Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AB474D42D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjGJLEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjGJLE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:04:28 -0400
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3D54E1;
        Mon, 10 Jul 2023 04:03:45 -0700 (PDT)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 36AANPeX019774;
        Mon, 10 Jul 2023 05:23:25 -0500
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 36AANOgJ019772;
        Mon, 10 Jul 2023 05:23:24 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 07/13] Implement TSEM control plane.
Date:   Mon, 10 Jul 2023 05:23:13 -0500
Message-Id: <20230710102319.19716-8-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230710102319.19716-1-greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fs.c file contains the implementation of the TSEM control
plane that is rooted in the following directory in the securityfs
filesystem:

/sys/kernel/security/tsem

The following file documents the interface provided by the
control plane:

Documentation/ABI/testing/tsem

The pseudo-files act on the modeling context of the process that
is reading or writing to the control plane files.  For example,
reading the 'id' pseudo-file, returns the security modeling
namespace identifier that the process is running in.

The 'control' pseudo-file is the only writable file in the plane
and is used to control the TSEM implementation.  The most
important and primary roles are to create namespaces and set the
trust status of a process modeled by an external TMA.

The ExternalTMA directory is used to segregate the pseudo-files
that are created in order to surface security event descriptions
to an external trust orchestrator.  The files in this directory
appear as the numeric value of the modeling domain they were
created for.

The following directory:

/sys/kernel/security/tsem/InternalTMA

Holds directories that are used to surface the characteristics of
internal Trusted Modeling agents.  There is currently only a
single internal TMA implemented and its characteristics are in
the following directory:

/sys/kernel/security/tsem/InternalTMA/model0

This model is used to allow new TMA's to be implemented and to
maintain ABI compatibility if changes are needed in a TMA.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 security/tsem/fs.c | 1336 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1336 insertions(+)
 create mode 100644 security/tsem/fs.c

diff --git a/security/tsem/fs.c b/security/tsem/fs.c
new file mode 100644
index 000000000000..9752aca13afa
--- /dev/null
+++ b/security/tsem/fs.c
@@ -0,0 +1,1336 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2023 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * Implements the securityfs based control plane.
+ */
+
+#include <linux/seq_file.h>
+#include <linux/poll.h>
+
+#include "tsem.h"
+
+static struct dentry *tsem_dir;
+static struct dentry *control;
+static struct dentry *id;
+static struct dentry *aggregate;
+static struct dentry *internal_tma;
+static struct dentry *model;
+static struct dentry *forensics;
+static struct dentry *forensics_counts;
+static struct dentry *forensics_coeff;
+static struct dentry *trajectory;
+static struct dentry *trajectory_counts;
+static struct dentry *trajectory_coeff;
+static struct dentry *measurement;
+static struct dentry *state;
+static struct dentry *external_tma;
+
+struct control_commands {
+	char *cmd;
+	enum tsem_control_type type;
+};
+
+static const char * const control_commands[] = {
+	"internal",
+	"external",
+	"enforce",
+	"seal",
+	"trusted",
+	"untrusted",
+	"state",
+	"pseudonym",
+	"base"
+};
+
+enum namespace_argument_type {
+	NS_REF = 0,
+	NS_DIGEST,
+	NS_KEY,
+	NS_CACHE
+};
+
+static const char * const namespace_arguments[] = {
+	"nsref",
+	"digest",
+	"key",
+	"cache"
+};
+
+enum control_argument_type {
+	CONTROL_KEY = 0,
+	CONTROL_PID
+};
+
+static const char * const control_arguments[] = {
+	"key",
+	"pid"
+};
+
+static bool can_access_fs(void)
+{
+	struct tsem_context *ctx = tsem_context(current);
+
+	if (ctx->external)
+		return false;
+	if (capable(TSEM_CONTROL_CAPABILITY))
+		return true;
+	if (ctx->sealed)
+		return false;
+	return true;
+}
+
+static int control_COE(unsigned long cmd, pid_t pid, char *keystr)
+{
+	bool wakeup = false;
+	int retn = -ESRCH;
+	u8 event_key[HASH_MAX_DIGESTSIZE];
+	struct task_struct *COE;
+	struct tsem_task *task;
+	struct tsem_task *tma = tsem_task(current);
+
+	rcu_read_lock();
+	COE = find_task_by_vpid(pid);
+	if (COE != NULL) {
+		task = tsem_task(COE);
+		if (tsem_context(COE)->id != tma->tma_for_ns) {
+			retn = -EINVAL;
+			goto done;
+		}
+
+		retn = tsem_ns_event_key(task->task_key, keystr, event_key);
+		if (retn)
+			goto done;
+
+		if (memcmp(tma->task_key, event_key, tsem_digestsize())) {
+			retn = -EINVAL;
+			goto done;
+		}
+
+		if (cmd == TSEM_CONTROL_UNTRUSTED)
+			task->trust_status = TSEM_TASK_UNTRUSTED;
+		if (cmd == TSEM_CONTROL_TRUSTED) {
+			task->trust_status &= ~TSEM_TASK_TRUST_PENDING;
+			if (tsem_task_trusted(COE))
+				task->trust_status = TSEM_TASK_TRUSTED;
+		}
+		retn = 0;
+		wakeup = true;
+	}
+
+ done:
+	rcu_read_unlock();
+
+	if (retn == -EINVAL)
+		pr_warn("tsem: Invalid process release request.\n");
+
+	if (wakeup)
+		wake_up_process(COE);
+
+	return retn;
+}
+
+static int config_COE(unsigned long cmd, char *arg)
+{
+	char **argv, *argp, *key = NULL;
+	int argc, retn = -EINVAL;
+	unsigned int lp;
+	long pid = 0;
+	enum control_argument_type control_arg;
+
+	if (!*arg)
+		return retn;
+
+	argv = argv_split(GFP_KERNEL, arg, &argc);
+	if (!argv)
+		return -ENOMEM;
+
+	for (lp = 0; lp < argc; ++lp) {
+		argp = strchr(argv[lp], '=');
+		if (!argp)
+			goto done;
+		*argp++ = '\0';
+
+		control_arg = match_string(control_arguments,
+					   ARRAY_SIZE(control_arguments),
+					   argv[lp]);
+		if (control_arg < 0)
+			goto done;
+
+		switch (control_arg) {
+		case CONTROL_KEY:
+			key = argp;
+			if (strlen(key) != tsem_digestsize()*2)
+				goto done;
+			break;
+		case CONTROL_PID:
+			if (kstrtol(argp, 0, &pid))
+				goto done;
+			break;
+		}
+	}
+
+	if (!key || !pid)
+		goto done;
+	retn = control_COE(cmd, pid, key);
+
+ done:
+	argv_free(argv);
+	return retn;
+}
+
+static int config_context(unsigned long cmd, char *bufr)
+{
+	int retn = -EINVAL;
+	unsigned int lp;
+	struct tsem_context *ctx = tsem_context(current);
+
+	if (ctx->sealed)
+		return -EPERM;
+
+	if (cmd == TSEM_CONTROL_SEAL) {
+		ctx->sealed = true;
+		retn = 0;
+	}
+
+	if (cmd == TSEM_CONTROL_ENFORCE) {
+		for (lp = 0; lp < ARRAY_SIZE(tsem_root_actions); ++lp)
+			ctx->actions[lp] = TSEM_ACTION_EPERM;
+		retn = 0;
+	}
+
+	return retn;
+}
+
+static int config_point(enum tsem_control_type type, char *arg)
+{
+	char *argp;
+	int retn = -EINVAL;
+	u8 mapping[HASH_MAX_DIGESTSIZE];
+
+	if (!arg)
+		goto done;
+
+	argp = strchr(arg, '=');
+	if (!argp)
+		goto done;
+	*argp++ = '\0';
+
+	if (strcmp(arg, "value"))
+		goto done;
+
+	if (strlen(argp) != tsem_digestsize()*2)
+		goto done;
+	if (hex2bin(mapping, argp, tsem_digestsize()))
+		goto done;
+
+	if (type == TSEM_CONTROL_MAP_STATE)
+		retn = tsem_model_load_point(mapping);
+	else if (type == TSEM_CONTROL_MAP_PSEUDONYM)
+		retn = tsem_model_load_pseudonym(mapping);
+	else {
+		tsem_model_load_base(mapping);
+		retn = 0;
+	}
+
+ done:
+	return retn;
+}
+
+static int config_namespace(enum tsem_control_type type, const char *arg)
+{
+	char **argv, *argp, *digest = "sha256", *key = NULL;
+	int argc, retn = -EINVAL;
+	unsigned int lp, cache_size = TSEM_MAGAZINE_SIZE_INTERNAL;
+	enum namespace_argument_type ns_arg;
+	enum tsem_ns_reference ns_ref = TSEM_NS_INITIAL;
+
+	if (type == TSEM_CONTROL_EXTERNAL)
+		cache_size = TSEM_MAGAZINE_SIZE_EXTERNAL;
+
+	if (!arg) {
+		if (type == TSEM_CONTROL_EXTERNAL)
+			return retn;
+		return tsem_ns_create(type, digest, ns_ref, key, cache_size);
+	}
+
+	argv = argv_split(GFP_KERNEL, arg, &argc);
+	if (!argv)
+		return -ENOMEM;
+
+	for (lp = 0; lp < argc; ++lp) {
+		argp = strchr(argv[lp], '=');
+		if (!argp)
+			goto done;
+		*argp++ = '\0';
+
+		ns_arg = match_string(namespace_arguments,
+				    ARRAY_SIZE(namespace_arguments), argv[lp]);
+		if (ns_arg < 0)
+			goto done;
+
+		switch (ns_arg) {
+		case NS_REF:
+			if (!strcmp(argp, "current"))
+				ns_ref = TSEM_NS_CURRENT;
+			else if (!strcmp(argp, "initial"))
+				ns_ref = TSEM_NS_INITIAL;
+			else
+				goto done;
+			break;
+		case NS_DIGEST:
+			digest = argp;
+			if (!crypto_has_shash(digest, 0, 0))
+				goto done;
+			break;
+		case NS_KEY:
+			key = argp;
+			if (strlen(key) % 2)
+				goto done;
+			break;
+		case NS_CACHE:
+			if (kstrtouint(argp, 0, &cache_size))
+				goto done;
+			if (!cache_size)
+				goto done;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (type == TSEM_CONTROL_EXTERNAL && !key)
+		goto done;
+
+	retn = tsem_ns_create(type, digest, ns_ref, key, cache_size);
+
+ done:
+	argv_free(argv);
+	return retn;
+}
+
+static void show_event(struct seq_file *c, struct tsem_event *ep)
+{
+	tsem_fs_show_field(c, "event");
+	if (ep->pid)
+		tsem_fs_show_key(c, ",", "pid", "%u", ep->pid);
+	tsem_fs_show_key(c, ",", "process", "%s", ep->comm);
+	tsem_fs_show_key(c, ",", "type", "%s", tsem_names[ep->event]);
+	tsem_fs_show_key(c, "}, ", "task_id", "%*phN", tsem_digestsize(),
+			 ep->task_id);
+
+	tsem_fs_show_field(c, "COE");
+	tsem_fs_show_key(c, ",", "uid", "%u", ep->COE.uid);
+	tsem_fs_show_key(c, ",", "euid", "%u", ep->COE.euid);
+	tsem_fs_show_key(c, ",", "suid", "%u", ep->COE.suid);
+	tsem_fs_show_key(c, ",", "gid", "%u", ep->COE.gid);
+	tsem_fs_show_key(c, ",", "egid", "%u", ep->COE.egid);
+	tsem_fs_show_key(c, ",", "sgid", "%u", ep->COE.sgid);
+	tsem_fs_show_key(c, ",", "fsuid", "%u", ep->COE.fsuid);
+	tsem_fs_show_key(c, ",", "fsgid", "%u", ep->COE.fsgid);
+	tsem_fs_show_key(c, "}, ", "capeff", "0x%llx", ep->COE.capeff.value);
+}
+
+static void show_file(struct seq_file *c, struct tsem_event *ep)
+{
+	if (ep->event == TSEM_FILE_OPEN)
+		tsem_fs_show_field(c, "file_open");
+	else
+		tsem_fs_show_field(c, "file");
+
+	tsem_fs_show_key(c, ",", "flags", "%u", ep->file.flags);
+	tsem_fs_show_key(c, ",", "uid", "%u", ep->file.uid);
+	tsem_fs_show_key(c, ",", "gid", "%u", ep->file.gid);
+	tsem_fs_show_key(c, ",", "mode", "0%o", ep->file.mode);
+	tsem_fs_show_key(c, ",", "path", "%s", ep->pathname);
+	tsem_fs_show_key(c, ",", "s_magic", "0x%0x", ep->file.s_magic);
+	tsem_fs_show_key(c, ",", "s_id", "%s", ep->file.s_id);
+	tsem_fs_show_key(c, ",", "s_uuid", "%*phN", sizeof(ep->file.s_uuid),
+		 ep->file.s_uuid);
+	tsem_fs_show_key(c, "}", "digest", "%*phN", tsem_digestsize(),
+			 ep->file.digest);
+}
+
+static void show_mmap(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_mmap_file_args *args = &ep->CELL.mmap_file;
+
+	show_event(c, ep);
+
+	tsem_fs_show_field(c, tsem_names[ep->event]);
+	tsem_fs_show_key(c, ",", "type", "%u", args->file == NULL);
+	tsem_fs_show_key(c, ",", "reqprot", "%u", args->reqprot);
+	tsem_fs_show_key(c, ",", "prot", "%u", args->prot);
+
+	if (args->file) {
+		tsem_fs_show_key(c, ",", "flags", "%u", args->flags);
+		show_file(c, ep);
+		seq_putc(c, '}');
+	} else
+		tsem_fs_show_key(c, "}", "flags", "%u", args->flags);
+}
+
+static void show_socket_create(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_socket_create_args *args = &ep->CELL.socket_create;
+
+	show_event(c, ep);
+
+	tsem_fs_show_field(c, tsem_names[ep->event]);
+	tsem_fs_show_key(c, ",", "family", "%u", args->family);
+	tsem_fs_show_key(c, ",", "type", "%u", args->type);
+	tsem_fs_show_key(c, ",", "protocol", "%u", args->protocol);
+	tsem_fs_show_key(c, "}", "kern", "%u", args->kern);
+}
+
+static void show_socket(struct seq_file *c, struct tsem_event *ep)
+{
+	struct sockaddr_in *ipv4;
+	struct sockaddr_in6 *ipv6;
+	struct tsem_socket_connect_args *scp = &ep->CELL.socket_connect;
+
+	show_event(c, ep);
+
+	tsem_fs_show_field(c, tsem_names[ep->event]);
+	tsem_fs_show_key(c, ",", "family", "%u", scp->family);
+
+	switch (scp->family) {
+	case AF_INET:
+		ipv4 = (struct sockaddr_in *) &scp->u.ipv4;
+		tsem_fs_show_key(c, ",", "port", "%u", ipv4->sin_port);
+		tsem_fs_show_key(c, "}", "addr", "%u", ipv4->sin_addr.s_addr);
+		break;
+	case AF_INET6:
+		ipv6 = (struct sockaddr_in6 *) &scp->u.ipv6;
+		tsem_fs_show_key(c, ",", "port", "%u", ipv6->sin6_port);
+		tsem_fs_show_key(c, ",", "flow", "%u", ipv6->sin6_flowinfo);
+		tsem_fs_show_key(c, ",", "scope", "%u", ipv6->sin6_scope_id);
+		tsem_fs_show_key(c, "}", "addr", "%*phN",
+			 (int) sizeof(ipv6->sin6_addr.in6_u.u6_addr8),
+			 ipv6->sin6_addr.in6_u.u6_addr8);
+		break;
+	case AF_UNIX:
+		tsem_fs_show_key(c, "}", "addr", "%s", scp->u.path);
+		break;
+	default:
+		tsem_fs_show_key(c, "}", "addr", "%*phN", tsem_digestsize(),
+				 scp->u.mapping);
+		break;
+	}
+}
+
+static void show_socket_accept(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_socket_accept_args *sap = &ep->CELL.socket_accept;
+
+	show_event(c, ep);
+
+	tsem_fs_show_field(c, tsem_names[ep->event]);
+	tsem_fs_show_key(c, ",", "family", "%u", sap->family);
+	tsem_fs_show_key(c, ",", "type", "%u", sap->type);
+	tsem_fs_show_key(c, ",", "port", "%u", sap->port);
+
+	switch (sap->family) {
+	case AF_INET:
+		tsem_fs_show_key(c, "}", "addr", "%u", sap->u.ipv4);
+		break;
+	case AF_INET6:
+		tsem_fs_show_key(c, "}", "addr", "%*phN",
+			 (int) sizeof(sap->u.ipv6.in6_u.u6_addr8),
+			 sap->u.ipv6.in6_u.u6_addr8);
+		break;
+	case AF_UNIX:
+		tsem_fs_show_key(c, "}", "addr", "%s", sap->u.path);
+		break;
+	default:
+		tsem_fs_show_key(c, "}", "addr", "%*phN", tsem_digestsize(),
+				 sap->u.mapping);
+		break;
+	}
+}
+
+static void show_task_kill(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	show_event(c, ep);
+
+	tsem_fs_show_field(c, tsem_names[ep->event]);
+	tsem_fs_show_key(c, ",", "cross", "%u", args->cross_model);
+	tsem_fs_show_key(c, ",", "signal", "%u", args->signal);
+	tsem_fs_show_key(c, "}", "target", "%*phN", tsem_digestsize(),
+			 args->target);
+}
+
+static void show_event_generic(struct seq_file *c, struct tsem_event *ep)
+{
+	show_event(c, ep);
+
+	tsem_fs_show_field(c, tsem_names[ep->event]);
+	tsem_fs_show_key(c, "}", "type", "%s",
+			 tsem_names[ep->CELL.event_type]);
+}
+
+static void *trajectory_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->trajectory_lock);
+	end = model->trajectory_list.prev;
+	spin_unlock(&model->trajectory_lock);
+
+	mutex_lock(&model->trajectory_end_mutex);
+	model->trajectory_end = end;
+
+	return seq_list_start(&model->trajectory_list, *pos);
+}
+
+static void *trajectory_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->trajectory_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->trajectory_end)
+		model->trajectory_end = NULL;
+
+	return seq_list_next(p, &model->trajectory_list, pos);
+}
+
+static void trajectory_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->trajectory_end_mutex);
+}
+
+static int trajectory_show(struct seq_file *c, void *trajectory)
+{
+	struct tsem_event *ep;
+
+	ep = list_entry(trajectory, struct tsem_event, list);
+
+	seq_putc(c, '{');
+	tsem_fs_show_trajectory(c, ep);
+	seq_puts(c, "}\n");
+
+	return 0;
+}
+
+static const struct seq_operations trajectory_seqops = {
+	.start = trajectory_start,
+	.next = trajectory_next,
+	.stop = trajectory_stop,
+	.show = trajectory_show
+};
+
+static int trajectory_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &trajectory_seqops);
+}
+
+static const struct file_operations trajectory_ops = {
+	.open = trajectory_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static void *trajectory_count_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->point_lock);
+	end = model->point_list.prev;
+	spin_unlock(&model->point_lock);
+
+	mutex_lock(&model->point_end_mutex);
+	model->point_end = end;
+
+	return seq_list_start(&model->point_list, *pos);
+}
+
+static void *trajectory_count_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->point_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->point_end)
+		model->point_end = NULL;
+
+	return seq_list_next(p, &model->point_list, pos);
+}
+
+static void trajectory_count_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->point_end_mutex);
+}
+
+static int trajectory_count_show(struct seq_file *c, void *point)
+{
+	struct tsem_event_point *pt;
+
+	pt = list_entry(point, struct tsem_event_point, list);
+	if (!pt->valid)
+		return 0;
+
+	seq_printf(c, "%llu\n", pt->count);
+	return 0;
+}
+
+static const struct seq_operations trajectory_count_seqops = {
+	.start = trajectory_count_start,
+	.next = trajectory_count_next,
+	.stop = trajectory_count_stop,
+	.show = trajectory_count_show
+};
+
+static int trajectory_count_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &trajectory_count_seqops);
+}
+
+static const struct file_operations trajectory_count_ops = {
+	.open = trajectory_count_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static void *trajectory_point_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->point_lock);
+	end = model->point_list.prev;
+	spin_unlock(&model->point_lock);
+
+	mutex_lock(&model->point_end_mutex);
+	model->point_end = end;
+
+	return seq_list_start(&model->point_list, *pos);
+}
+
+static void *trajectory_point_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->point_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->point_end)
+		model->point_end = NULL;
+
+	return seq_list_next(p, &model->point_list, pos);
+}
+
+static void trajectory_point_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->point_end_mutex);
+}
+
+static int trajectory_point_show(struct seq_file *c, void *point)
+{
+	struct tsem_event_point *pt;
+
+	pt = list_entry(point, struct tsem_event_point, list);
+	if (!pt->valid)
+		return 0;
+
+	seq_printf(c, "%*phN\n", tsem_digestsize(), pt->point);
+	return 0;
+}
+
+static const struct seq_operations trajectory_point_seqops = {
+	.start = trajectory_point_start,
+	.next = trajectory_point_next,
+	.stop = trajectory_point_stop,
+	.show = trajectory_point_show
+};
+
+static int trajectory_point_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &trajectory_point_seqops);
+}
+
+static const struct file_operations trajectory_point_ops = {
+	.open = trajectory_point_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int open_control(struct inode *inode, struct file *filp)
+{
+	if (!capable(TSEM_CONTROL_CAPABILITY))
+		return -EACCES;
+	if (!(filp->f_flags & O_WRONLY))
+		return -EACCES;
+	return 0;
+}
+
+static ssize_t write_control(struct file *file, const char __user *buf,
+			     size_t datalen, loff_t *ppos)
+{
+	char *p, *arg, cmdbufr[128];
+	ssize_t retn = -EINVAL;
+	enum tsem_control_type type;
+
+	if (*ppos != 0)
+		goto done;
+	if (datalen > sizeof(cmdbufr)-1)
+		goto done;
+
+	memset(cmdbufr, '\0', sizeof(cmdbufr));
+	if (copy_from_user(cmdbufr, buf, datalen)) {
+		retn = -EFAULT;
+		goto done;
+	}
+
+	p = strchr(cmdbufr, '\n');
+	if (!p)
+		goto done;
+	*p = '\0';
+
+	arg = strchr(cmdbufr, ' ');
+	if (arg != NULL) {
+		*arg = '\0';
+		++arg;
+	}
+
+	type = match_string(control_commands, ARRAY_SIZE(control_commands),
+			    cmdbufr);
+	if (type < 0)
+		goto done;
+
+	switch (type) {
+	case TSEM_CONTROL_EXTERNAL:
+	case TSEM_CONTROL_INTERNAL:
+		retn = config_namespace(type, arg);
+		break;
+	case TSEM_CONTROL_ENFORCE:
+	case TSEM_CONTROL_SEAL:
+		retn = config_context(type, cmdbufr);
+		break;
+	case TSEM_CONTROL_TRUSTED:
+	case TSEM_CONTROL_UNTRUSTED:
+		retn = config_COE(type, arg);
+		break;
+	case TSEM_CONTROL_MAP_STATE:
+	case TSEM_CONTROL_MAP_PSEUDONYM:
+	case TSEM_CONTROL_MAP_BASE:
+		retn = config_point(type, arg);
+		break;
+	}
+
+done:
+	if (!retn)
+		retn = datalen;
+	return retn;
+}
+
+static int release_control(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static const struct file_operations control_ops = {
+	.open = open_control,
+	.write = write_control,
+	.release = release_control,
+	.llseek = generic_file_llseek,
+};
+
+static void *forensics_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->forensics_lock);
+	end = model->forensics_list.prev;
+	spin_unlock(&model->forensics_lock);
+
+	mutex_lock(&model->forensics_end_mutex);
+	model->forensics_end = end;
+
+	return seq_list_start(&model->forensics_list, *pos);
+}
+
+static void *forensics_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->forensics_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->forensics_end)
+		model->forensics_end = NULL;
+
+	return seq_list_next(p, &model->forensics_list, pos);
+}
+
+static void forensics_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->forensics_end_mutex);
+}
+
+static int forensics_show(struct seq_file *c, void *event)
+{
+	struct tsem_event *ep;
+
+	ep = list_entry(event, struct tsem_event, list);
+
+	seq_putc(c, '{');
+	tsem_fs_show_trajectory(c, ep);
+	seq_puts(c, "}\n");
+
+	return 0;
+}
+
+static const struct seq_operations forensics_seqops = {
+	.start = forensics_start,
+	.next = forensics_next,
+	.stop = forensics_stop,
+	.show = forensics_show
+};
+
+static int forensics_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &forensics_seqops);
+}
+
+static const struct file_operations forensics_ops = {
+	.open = forensics_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static void *forensics_point_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->point_lock);
+	end = model->point_list.prev;
+	spin_unlock(&model->point_lock);
+
+	mutex_lock(&model->point_end_mutex);
+	model->point_end = end;
+
+	return seq_list_start(&model->point_list, *pos);
+}
+
+static void *forensics_point_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->point_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->point_end)
+		model->point_end = NULL;
+
+	return seq_list_next(p, &model->point_list, pos);
+}
+
+static void forensics_point_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->point_end_mutex);
+}
+
+static int forensics_point_show(struct seq_file *c, void *point)
+{
+	struct tsem_event_point *pt;
+
+	pt = list_entry(point, struct tsem_event_point, list);
+	if (pt->valid)
+		return 0;
+
+	seq_printf(c, "%*phN\n", tsem_digestsize(), pt->point);
+	return 0;
+}
+
+static const struct seq_operations forensics_point_seqops = {
+	.start = forensics_point_start,
+	.next = forensics_point_next,
+	.stop = forensics_point_stop,
+	.show = forensics_point_show
+};
+
+static int forensics_point_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &forensics_point_seqops);
+}
+
+static const struct file_operations forensics_point_ops = {
+	.open = forensics_point_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static void *forensics_count_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->point_lock);
+	end = model->point_list.prev;
+	spin_unlock(&model->point_lock);
+
+	mutex_lock(&model->point_end_mutex);
+	model->point_end = end;
+
+	return seq_list_start(&model->point_list, *pos);
+}
+
+static void *forensics_count_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->point_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->point_end)
+		model->point_end = NULL;
+
+	return seq_list_next(p, &model->point_list, pos);
+}
+
+static void forensics_count_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->point_end_mutex);
+}
+
+static int forensics_count_show(struct seq_file *c, void *point)
+{
+	struct tsem_event_point *pt;
+
+	pt = list_entry(point, struct tsem_event_point, list);
+	if (pt->valid)
+		return 0;
+
+	seq_printf(c, "%llu\n", pt->count);
+	return 0;
+}
+
+static const struct seq_operations forensics_count_seqops = {
+	.start = forensics_count_start,
+	.next = forensics_count_next,
+	.stop = forensics_count_stop,
+	.show = forensics_count_show
+};
+
+static int forensics_count_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &forensics_count_seqops);
+}
+
+static const struct file_operations forensics_count_ops = {
+	.open = forensics_count_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int measurement_show(struct seq_file *c, void *event)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	seq_printf(c, "%*phN\n", tsem_digestsize(), model->measurement);
+	return 0;
+}
+
+static int measurement_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return single_open(file, &measurement_show, NULL);
+}
+
+static const struct file_operations measurement_ops = {
+	.open = measurement_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int id_show(struct seq_file *c, void *event)
+{
+	seq_printf(c, "%llu\n", tsem_context(current)->id);
+	return 0;
+}
+
+static int id_open(struct inode *inode, struct file *file)
+{
+	struct tsem_context *ctx = tsem_context(current);
+
+	if (ctx->sealed)
+		return -EACCES;
+	return single_open(file, &id_show, NULL);
+}
+
+static const struct file_operations id_ops = {
+	.open = id_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int state_show(struct seq_file *m, void *v)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	tsem_model_compute_state();
+	seq_printf(m, "%*phN\n", tsem_digestsize(), model->state);
+	return 0;
+}
+
+static int state_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return single_open(file, &state_show, NULL);
+}
+
+static const struct file_operations state_ops = {
+	.open = state_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int aggregate_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%*phN\n", tsem_digestsize(), tsem_trust_aggregate());
+	return 0;
+}
+
+static int aggregate_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return single_open(file, &aggregate_show, NULL);
+}
+
+static const struct file_operations aggregate_ops = {
+	.open = aggregate_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static __poll_t export_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct tsem_context *ctx = tsem_context(current);
+
+	if (!ctx->external)
+		return -ENOENT;
+
+	poll_wait(file, &ctx->external->wq, wait);
+
+	if (ctx->external->have_event) {
+		ctx->external->have_event = false;
+		return EPOLLIN | EPOLLRDNORM;
+	}
+	return 0;
+}
+
+static int export_open(struct inode *inode, struct file *file)
+{
+	if (!capable(TSEM_CONTROL_CAPABILITY))
+		return -EACCES;
+	return single_open(file, &tsem_export_show, NULL);
+}
+
+static const struct file_operations export_ops = {
+	.open = export_open,
+	.poll = export_poll,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+/**
+ * tsem_fs_create_external() - Create an external TMA update file.
+ * @id: A pointer to the ASCII representation of the modeling domain
+ *      that the export file is being created for.
+ *
+ * This function is used to create a pseudo-file that will output security
+ * event descriptions for a namespace.  This routine will create the
+ * following file:
+ *
+ * /sys/kernel/security/tsem/ExternalTMA/N
+ *
+ * Where N is replaced with the security model context identifier.
+ *
+ * Return: If creation of the update file is successful a pointer to the
+ *	   dentry of the file is returned.  If an error was encountered
+ *	   the pointer with an encoded code will be returned.
+ */
+struct dentry *tsem_fs_create_external(const char *name)
+{
+
+	return securityfs_create_file(name, 0400, external_tma, NULL,
+				      &export_ops);
+}
+
+/**
+ * tsem_fs_show_trajectory() - Generate the output of a security event.
+ * @sf: A pointer to the seq_file structure to which output will
+ *      be set.
+ * @ep: A pointer to the event description that is to be output.
+ *
+ * This function is used to generate a record that will be output to
+ * the pseudo-file that outputs the security events for the
+ * domain being modeled.
+ */
+void tsem_fs_show_trajectory(struct seq_file *c, struct tsem_event *ep)
+{
+	switch (ep->event) {
+	case TSEM_FILE_OPEN:
+		show_event(c, ep);
+		show_file(c, ep);
+		break;
+	case TSEM_MMAP_FILE:
+		show_mmap(c, ep);
+		break;
+	case TSEM_SOCKET_CREATE:
+		show_socket_create(c, ep);
+		break;
+	case TSEM_SOCKET_CONNECT:
+	case TSEM_SOCKET_BIND:
+		show_socket(c, ep);
+		break;
+	case TSEM_SOCKET_ACCEPT:
+		show_socket_accept(c, ep);
+		break;
+	case TSEM_TASK_KILL:
+		show_task_kill(c, ep);
+		break;
+	case TSEM_GENERIC_EVENT:
+		show_event_generic(c, ep);
+		break;
+	default:
+		break;
+	}
+}
+
+/**
+ * tesm_fs_show_field() - Output a JSON field description
+ * @sf: A pointer to the seq_file structure that the field description
+ *	is to be written to.
+ * @f:  A pointer to null terminated character buffer containing the
+ *      name of the field to encode
+ *
+ * This function is used to generate a JSON field description that
+ * is used to name a sequence of key/value pairs describing the
+ * characteristcis of the field.
+ */
+void tsem_fs_show_field(struct seq_file *c, const char *field)
+{
+	seq_printf(c, "\"%s\": {", field);
+}
+
+/**
+ * tesm_fs_tsem_fs_show_key() - Output a JSON key/value pair
+ * @sf: A pointer to the seq_file structure that the field description
+ *	is to be written to.
+ * @term: A pointer to a null-terminated character buffer containing
+ *	  the string that is to be used for terminating the key/value
+ *	  pair.
+ * @key: A pointer to the null-terminated character buffer containing
+ *	 the key description.
+ * @fmt: The printf format that is to be used for formatting the
+ *	 value of the key.
+ *
+ * This function is a variadic function that is used to encode a
+ * JSON key/value pair that provides one of characteristics of an
+ * event description field.
+ */
+void tsem_fs_show_key(struct seq_file *c, char *term, char *key,
+		      char *fmt, ...)
+{
+	va_list args;
+
+	seq_printf(c, "\"%s\": \"", key);
+
+	va_start(args, fmt);
+	seq_vprintf(c, fmt, args);
+	va_end(args);
+
+	if (term[0] == ',')
+		seq_printf(c, "\"%s ", term);
+	else
+		seq_printf(c, "\"%s", term);
+}
+
+/**
+ * tesm_fs_init() - Initialize the TSEM control filesystem heirarchy
+ *
+ * This function is called as part of the TSEM LSM initialization
+ * process.  The purpose of this function is to create the TSEM
+ * control plane, based on the securityfs filesystem, by creating the
+ * /sys/kernel/security/tsem directory and populating that directory
+ * with the control plane files and internal TMA model information
+ * files.  The /sys/kernel/security/tsem/ExternalTMA directory is
+ * also created.  This directory will be used to hold the modeling
+ * domain specific files that will emit the security event descriptions
+ * for the domain.
+ *
+ * Return: If filesystem initialization is successful a return code of 0
+ *	   is returned.  A negative return value is returned if an error
+ *	   is encountered.
+ */
+int __init tsem_fs_init(void)
+{
+	int retn = -1;
+
+	tsem_dir = securityfs_create_dir("tsem", NULL);
+	if (tsem_dir == NULL)
+		goto done;
+
+	control = securityfs_create_file("control", 0200, tsem_dir, NULL,
+					 &control_ops);
+	if (IS_ERR(control))
+		goto err;
+
+	id = securityfs_create_file("id", 0400, tsem_dir, NULL, &id_ops);
+	if (IS_ERR(control))
+		goto err;
+
+	aggregate = securityfs_create_file("aggregate", 0400, tsem_dir, NULL,
+					   &aggregate_ops);
+	if (IS_ERR(aggregate))
+		goto err;
+
+	internal_tma = securityfs_create_dir("InternalTMA", tsem_dir);
+	if (IS_ERR(internal_tma))
+		goto err;
+
+	model = securityfs_create_dir("model0", internal_tma);
+	if (IS_ERR(model))
+		goto err;
+
+	forensics = securityfs_create_file("forensics", 0400, model, NULL,
+					   &forensics_ops);
+	if (IS_ERR(forensics))
+		goto err;
+
+	forensics_counts = securityfs_create_file("forensics_counts", 0400,
+						 model, NULL,
+						 &forensics_count_ops);
+	if (IS_ERR(forensics_counts))
+		goto err;
+
+	forensics_coeff = securityfs_create_file("forensics_coefficients",
+						 0400, model, NULL,
+						 &forensics_point_ops);
+	if (IS_ERR(forensics_coeff))
+		goto err;
+
+	trajectory = securityfs_create_file("trajectory", 0400, model, NULL,
+					     &trajectory_ops);
+	if (IS_ERR(trajectory))
+		goto err;
+
+	trajectory_counts = securityfs_create_file("trajectory_counts", 0400,
+						   model, NULL,
+						   &trajectory_count_ops);
+	if (IS_ERR(trajectory_counts))
+		goto err;
+
+	trajectory_coeff = securityfs_create_file("trajectory_coefficients",
+						  0400, model, NULL,
+						  &trajectory_point_ops);
+	if (IS_ERR(trajectory_coeff))
+		goto err;
+
+	measurement = securityfs_create_file("measurement", 0400,
+						  model, NULL,
+						  &measurement_ops);
+	if (IS_ERR(measurement))
+		goto err;
+
+	state = securityfs_create_file("state", 0400, model, NULL,
+					&state_ops);
+	if (IS_ERR(state))
+		goto err;
+
+	external_tma = securityfs_create_dir("ExternalTMA", tsem_dir);
+	if (IS_ERR(external_tma))
+		goto err;
+
+	retn = 0;
+
+ done:
+	return retn;
+
+ err:
+	securityfs_remove(tsem_dir);
+	securityfs_remove(control);
+	securityfs_remove(id);
+	securityfs_remove(aggregate);
+	securityfs_remove(internal_tma);
+	securityfs_remove(model);
+	securityfs_remove(forensics);
+	securityfs_remove(forensics_counts);
+	securityfs_remove(forensics_coeff);
+	securityfs_remove(trajectory);
+	securityfs_remove(trajectory_counts);
+	securityfs_remove(trajectory_coeff);
+	securityfs_remove(measurement);
+	securityfs_remove(state);
+	securityfs_remove(external_tma);
+
+	return retn;
+}
-- 
2.39.1

