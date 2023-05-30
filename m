Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D33716CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjE3TAM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 15:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjE3TAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:00:08 -0400
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 12:00:02 PDT
Received: from mail-b.sr.ht (mail-b.sr.ht [173.195.146.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DB1F9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:00:02 -0700 (PDT)
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
        by mail-b.sr.ht (Postfix) with ESMTPSA id 6224B11F05E;
        Tue, 30 May 2023 18:50:50 +0000 (UTC)
From:   ~akihirosuda <akihirosuda@git.sr.ht>
Date:   Tue, 30 May 2023 23:42:52 +0900
Subject: [PATCH linux 1/3] net/ipv4: split group_range logic to kernel/group_range.c
Message-ID: <168547265011.24337.4306067683997517082-1@git.sr.ht>
X-Mailer: git.sr.ht
Reply-to: ~akihirosuda <suda.kyoto@gmail.com>
In-Reply-To: <168547265011.24337.4306067683997517082-0@git.sr.ht>
To:     linux-kernel@vger.kernel.org, containers@lists.linux.dev,
        serge@hallyn.com, brauner@kernel.org, paul@paul-moore.com,
        ebiederm@xmission.com
Cc:     suda.kyoto@gmail.com, akihiro.suda.cz@hco.ntt.co.jp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FREEMAIL_FORGED_REPLYTO,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>

The logic can be reused for other sysctls in future.

Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
---
 include/linux/group_range.h | 24 ++++++++++
 include/net/netns/ipv4.h    |  9 +---
 include/net/ping.h          |  6 ---
 kernel/Makefile             |  2 +-
 kernel/group_range.c        | 91 +++++++++++++++++++++++++++++++++++++
 net/ipv4/ping.c             | 39 ++--------------
 net/ipv4/sysctl_net_ipv4.c  | 56 ++---------------------
 7 files changed, 125 insertions(+), 102 deletions(-)
 create mode 100644 include/linux/group_range.h
 create mode 100644 kernel/group_range.c

diff --git a/include/linux/group_range.h b/include/linux/group_range.h
new file mode 100644
index 000000000000..5bd837eced95
--- /dev/null
+++ b/include/linux/group_range.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_GROUP_RANGE_H
+#define _LINUX_GROUP_RANGE_H
+
+#include <linux/seqlock.h>
+#include <linux/uidgid.h>
+
+/*
+ * gid_t is either uint or ushort.  We want to pass it to
+ * proc_dointvec_minmax(), so it must not be larger than MAX_INT
+ */
+#define GROUP_RANGE_MAX (((gid_t)~0U) >> 1)
+
+struct group_range {
+	seqlock_t       lock;
+	kgid_t          range[2];
+};
+
+typedef struct group_range* (*sysctl_group_range_func_t)(struct ctl_table *);
+int sysctl_group_range(sysctl_group_range_func_t fn, struct ctl_table *table,
+				 int write, void *buffer, size_t *lenp, loff_t *ppos);
+
+bool check_current_group_range(struct group_range *gr);
+#endif /* _LINUX_GROUP_RANGE_H */
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index db762e35aca9..75d745a7c6e1 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -6,11 +6,11 @@
 #ifndef __NETNS_IPV4_H__
 #define __NETNS_IPV4_H__
 
-#include <linux/uidgid.h>
 #include <net/inet_frag.h>
 #include <linux/rcupdate.h>
 #include <linux/seqlock.h>
 #include <linux/siphash.h>
+#include <linux/group_range.h>
 
 struct ctl_table_header;
 struct ipv4_devconf;
@@ -24,11 +24,6 @@ struct local_ports {
 	bool		warned;
 };
 
-struct ping_group_range {
-	seqlock_t	lock;
-	kgid_t		range[2];
-};
-
 struct inet_hashinfo;
 
 struct inet_timewait_death_row {
@@ -204,7 +199,7 @@ struct netns_ipv4 {
 	int sysctl_igmp_max_msf;
 	int sysctl_igmp_qrv;
 
-	struct ping_group_range ping_group_range;
+	struct group_range ping_group_range;
 
 	atomic_t dev_addr_genid;
 
diff --git a/include/net/ping.h b/include/net/ping.h
index 9233ad3de0ad..37b1d7baeb7b 100644
--- a/include/net/ping.h
+++ b/include/net/ping.h
@@ -16,12 +16,6 @@
 #define PING_HTABLE_SIZE 	64
 #define PING_HTABLE_MASK 	(PING_HTABLE_SIZE-1)
 
-/*
- * gid_t is either uint or ushort.  We want to pass it to
- * proc_dointvec_minmax(), so it must not be larger than MAX_INT
- */
-#define GID_T_MAX (((gid_t)~0U) >> 1)
-
 /* Compatibility glue so we can support IPv6 when it's compiled as a module */
 struct pingv6_ops {
 	int (*ipv6_recv_error)(struct sock *sk, struct msghdr *msg, int len,
diff --git a/kernel/Makefile b/kernel/Makefile
index b69c95315480..fb3a812cf92e 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    extable.o params.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
-	    async.o range.o smpboot.o ucount.o regset.o
+	    async.o range.o smpboot.o ucount.o regset.o group_range.o
 
 obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
 obj-$(CONFIG_MULTIUSER) += groups.o
diff --git a/kernel/group_range.c b/kernel/group_range.c
new file mode 100644
index 000000000000..b5c7d35d680b
--- /dev/null
+++ b/kernel/group_range.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/cred.h>
+#include <linux/group_range.h>
+#include <linux/uidgid.h>
+#include <linux/seqlock.h>
+#include <linux/sysctl.h>
+
+static void get_group_range(struct group_range *gr, kgid_t *low, kgid_t *high)
+{
+	unsigned int seq;
+
+	do {
+		seq = read_seqbegin(&gr->lock);
+
+		*low = gr->range[0];
+		*high = gr->range[1];
+	} while (read_seqretry(&gr->lock, seq));
+}
+
+static void set_group_range(struct group_range *gr, kgid_t low, kgid_t high)
+{
+	write_seqlock(&gr->lock);
+	gr->range[0] = low;
+	gr->range[1] = high;
+	write_sequnlock(&gr->lock);
+}
+
+static int group_range_min[] = { 0, 0 };
+static int group_range_max[] = { GROUP_RANGE_MAX, GROUP_RANGE_MAX };
+
+int sysctl_group_range(sysctl_group_range_func_t fn, struct ctl_table *table,
+				 int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct group_range *gr = fn(table);
+	struct user_namespace *user_ns = current_user_ns();
+	int ret;
+	gid_t urange[2];
+	kgid_t low, high;
+	struct ctl_table tmp = {
+		.data = &urange,
+		.maxlen = sizeof(urange),
+		.mode = table->mode,
+		.extra1 = &group_range_min,
+		.extra2 = &group_range_max,
+	};
+
+	get_group_range(gr, &low, &high);
+	urange[0] = from_kgid_munged(user_ns, low);
+	urange[1] = from_kgid_munged(user_ns, high);
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+
+	if (write && ret == 0) {
+		low = make_kgid(user_ns, urange[0]);
+		high = make_kgid(user_ns, urange[1]);
+		if (!gid_valid(low) || !gid_valid(high))
+			return -EINVAL;
+		if (urange[1] < urange[0] || gid_lt(high, low)) {
+			low = make_kgid(&init_user_ns, 1);
+			high = make_kgid(&init_user_ns, 0);
+		}
+		set_group_range(gr, low, high);
+	}
+
+	return ret;
+}
+
+bool check_current_group_range(struct group_range *gr)
+{
+	kgid_t group = current_egid();
+	struct group_info *group_info;
+	int i;
+	kgid_t low, high;
+	bool ret = true;
+
+	get_group_range(gr, &low, &high);
+	if (gid_lte(low, group) && gid_lte(group, high))
+		return true;
+
+	group_info = get_current_groups();
+	for (i = 0; i < group_info->ngroups; i++) {
+		kgid_t gid = group_info->gid[i];
+
+		if (gid_lte(low, gid) && gid_lte(gid, high))
+			goto out_release_group;
+	}
+	ret = false;
+out_release_group:
+	put_group_info(group_info);
+	return ret;
+}
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 5178a3f3cb53..6e23771c5234 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -244,50 +244,17 @@ exit:
 	return sk;
 }
 
-static void inet_get_ping_group_range_net(struct net *net, kgid_t *low,
-					  kgid_t *high)
-{
-	kgid_t *data = net->ipv4.ping_group_range.range;
-	unsigned int seq;
-
-	do {
-		seq = read_seqbegin(&net->ipv4.ping_group_range.lock);
-
-		*low = data[0];
-		*high = data[1];
-	} while (read_seqretry(&net->ipv4.ping_group_range.lock, seq));
-}
-
-
 int ping_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
-	kgid_t group = current_egid();
-	struct group_info *group_info;
-	int i;
-	kgid_t low, high;
-	int ret = 0;
 
 	if (sk->sk_family == AF_INET6)
 		sk->sk_ipv6only = 1;
 
-	inet_get_ping_group_range_net(net, &low, &high);
-	if (gid_lte(low, group) && gid_lte(group, high))
-		return 0;
-
-	group_info = get_current_groups();
-	for (i = 0; i < group_info->ngroups; i++) {
-		kgid_t gid = group_info->gid[i];
+	if (!check_current_group_range(&net->ipv4.ping_group_range))
+		return -EACCES;
 
-		if (gid_lte(low, gid) && gid_lte(gid, high))
-			goto out_release_group;
-	}
-
-	ret = -EACCES;
-
-out_release_group:
-	put_group_info(group_info);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ping_init_sock);
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 40fe70fc2015..ad355ab265db 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -34,8 +34,6 @@ static int ip_ttl_min = 1;
 static int ip_ttl_max = 255;
 static int tcp_syn_retries_min = 1;
 static int tcp_syn_retries_max = MAX_TCP_SYNCNT;
-static int ip_ping_group_range_min[] = { 0, 0 };
-static int ip_ping_group_range_max[] = { GID_T_MAX, GID_T_MAX };
 static u32 u32_max_div_HZ = UINT_MAX / HZ;
 static int one_day_secs = 24 * 3600;
 static u32 fib_multipath_hash_fields_all_mask __maybe_unused =
@@ -133,66 +131,20 @@ static int ipv4_privileged_ports(struct ctl_table *table, int write,
 	return ret;
 }
 
-static void inet_get_ping_group_range_table(struct ctl_table *table, kgid_t *low, kgid_t *high)
+static struct group_range *ipv4_ping_group_range_func(struct ctl_table *table)
 {
-	kgid_t *data = table->data;
 	struct net *net =
 		container_of(table->data, struct net, ipv4.ping_group_range.range);
-	unsigned int seq;
-	do {
-		seq = read_seqbegin(&net->ipv4.ping_group_range.lock);
 
-		*low = data[0];
-		*high = data[1];
-	} while (read_seqretry(&net->ipv4.ping_group_range.lock, seq));
-}
-
-/* Update system visible IP port range */
-static void set_ping_group_range(struct ctl_table *table, kgid_t low, kgid_t high)
-{
-	kgid_t *data = table->data;
-	struct net *net =
-		container_of(table->data, struct net, ipv4.ping_group_range.range);
-	write_seqlock(&net->ipv4.ping_group_range.lock);
-	data[0] = low;
-	data[1] = high;
-	write_sequnlock(&net->ipv4.ping_group_range.lock);
+	return &net->ipv4.ping_group_range;
 }
 
 /* Validate changes from /proc interface. */
 static int ipv4_ping_group_range(struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct user_namespace *user_ns = current_user_ns();
-	int ret;
-	gid_t urange[2];
-	kgid_t low, high;
-	struct ctl_table tmp = {
-		.data = &urange,
-		.maxlen = sizeof(urange),
-		.mode = table->mode,
-		.extra1 = &ip_ping_group_range_min,
-		.extra2 = &ip_ping_group_range_max,
-	};
-
-	inet_get_ping_group_range_table(table, &low, &high);
-	urange[0] = from_kgid_munged(user_ns, low);
-	urange[1] = from_kgid_munged(user_ns, high);
-	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
-
-	if (write && ret == 0) {
-		low = make_kgid(user_ns, urange[0]);
-		high = make_kgid(user_ns, urange[1]);
-		if (!gid_valid(low) || !gid_valid(high))
-			return -EINVAL;
-		if (urange[1] < urange[0] || gid_lt(high, low)) {
-			low = make_kgid(&init_user_ns, 1);
-			high = make_kgid(&init_user_ns, 0);
-		}
-		set_ping_group_range(table, low, high);
-	}
-
-	return ret;
+	return sysctl_group_range(ipv4_ping_group_range_func, table,
+		write, buffer, lenp, ppos);
 }
 
 static int ipv4_fwd_update_priority(struct ctl_table *table, int write,
-- 
2.38.4

