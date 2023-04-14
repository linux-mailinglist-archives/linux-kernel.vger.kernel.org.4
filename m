Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB26E1BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDNF30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDNF3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:29:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93296A42;
        Thu, 13 Apr 2023 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rAVcglQKGoDiPrgNmbJqJmJCewpnoiefCuDpW4aDLqc=; b=DtR7UPhBEXFLNFyZrfEWesrGrw
        qOlciBpSWARmOVo91oa1EpHxsan0AJXosO5SkWUMD5RS2oXhxOkQ+abuI3cYelF6/DKyIuorH+1j4
        J82IxuBZqCoPCLtEhdZFzwoThgC5BwTC5ILRi0YENsWoxc+WzBTF3y92WnbDe8jTiEj6uptHh0nE0
        1ldW55XC5IelLaIW8Ye1otlx4imPC+lXRovp2AwxdqOUXKNjpVRhUt9smrqXykJVdjSS5WmtJQ1Ki
        ApEsqySu3l4lFgY93NnS4H255n3EdiolsyEQbyw3jBFknQh+voEQDYdIEBrM6vqG/KiSikV360fWz
        9e5W7dVQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnBzK-008Msg-0k;
        Fri, 14 Apr 2023 05:28:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org
Subject: [RFC 1/2] module: add debugging auto-load duplicate module support
Date:   Thu, 13 Apr 2023 22:28:39 -0700
Message-Id: <20230414052840.1994456-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414052840.1994456-1-mcgrof@kernel.org>
References: <20230414052840.1994456-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds debugging support to the kernel module auto-loader to
easily detect and deal with duplicate module requests. To aid
with possible bootup failure issues it will supress the waste
in virtual memory when races happen before userspace loads a
module and the kernel is still issuing requests for the same
module.

Folks debugging virtual memory abuse on bootup can and should
enable this to see what WARN()s come on, to see if module
auto-loading is to blame for their woes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/Kconfig    |  40 +++++++
 kernel/module/Makefile   |   1 +
 kernel/module/dups.c     | 234 +++++++++++++++++++++++++++++++++++++++
 kernel/module/internal.h |  15 +++
 kernel/module/kmod.c     |  23 +++-
 5 files changed, 309 insertions(+), 4 deletions(-)
 create mode 100644 kernel/module/dups.c

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index ca277b945a67..ac7d23679799 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -57,6 +57,46 @@ config MODULE_STATS
 
 	  If unsure, say N.
 
+config MODULE_AUTOLOAD_SUPRESS_DUPS
+	bool "Debug duplicate modules with auto-loading"
+	help
+	  Module autoloading allows in-kernel code to request modules through
+	  the *request_module*() API calls. This in turn just calls userspace
+	  modprobe. Although modprobe checks to see if a module is already
+	  loaded before trying to load a module there is a small time window in
+	  which multiple duplicate requests can end up in userspace and multiple
+	  modprobe calls race calling finit_module() around the same time for
+	  duplicate modules. The finit_module() system call can consume in the
+	  worst case more than twice the respective module size in virtual
+	  memory for each duplicate module requests. Although duplicate module
+	  requests are non-fatal virtual memory is a limited resource and each
+	  duplicate module request ends up just wasting virtual memory.
+
+	  This debugging facility will create WARN() splats for duplicate module
+	  requests to help identify if module auto-loading is the culprit to your
+	  woes. Since virtual memory abuse caused by duplicate module requests
+	  could render a system unusable this functionality will also suppresses
+	  the waste in virtual memory caused by duplicate requests by sharing
+	  races in requests for the same module to a single unified request.
+	  Once a non-wait request_module() call completes a module should be
+	  loaded and modprobe should simply not allow new finit_module() calls.
+
+	  Enable this functionality to try to debug virtual memory abuse during
+	  boot on systems and identify if the abuse was due to module
+	  auto-loading.
+
+	  If the first module request used request_module_nowait() we cannot
+	  use that as the anchor to wait for duplicate module requests, since
+	  users of request_module() do want a proper return value. If a call
+	  for the same module happened earlier with request_module() though,
+	  then a duplicate request_module_nowait() would be detected.
+
+	  You want to enable this if you want to debug and see if duplicate
+	  module auto-loading might be causing virtual memory abuse during
+	  bootup. A kernel trace will be provided for each duplicate request.
+
+	  Disable this if you are on production.
+
 endif # MODULE_DEBUG
 
 config MODULE_FORCE_LOAD
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 52340bce497e..e8b121ac39cf 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -10,6 +10,7 @@ KCOV_INSTRUMENT_module.o := n
 obj-y += main.o
 obj-y += strict_rwx.o
 obj-y += kmod.o
+obj-$(CONFIG_MODULE_AUTOLOAD_SUPRESS_DUPS) += dups.o
 obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
diff --git a/kernel/module/dups.c b/kernel/module/dups.c
new file mode 100644
index 000000000000..903ab7c7e8f4
--- /dev/null
+++ b/kernel/module/dups.c
@@ -0,0 +1,234 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * kmod dups - the kernel module autoloader duplicate suppressor
+ *
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/sched/task.h>
+#include <linux/binfmts.h>
+#include <linux/syscalls.h>
+#include <linux/unistd.h>
+#include <linux/kmod.h>
+#include <linux/slab.h>
+#include <linux/completion.h>
+#include <linux/cred.h>
+#include <linux/file.h>
+#include <linux/fdtable.h>
+#include <linux/workqueue.h>
+#include <linux/security.h>
+#include <linux/mount.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/resource.h>
+#include <linux/notifier.h>
+#include <linux/suspend.h>
+#include <linux/rwsem.h>
+#include <linux/ptrace.h>
+#include <linux/async.h>
+#include <linux/uaccess.h>
+
+DEFINE_MUTEX(kmod_dup_mutex);
+static LIST_HEAD(dup_kmod_reqs);
+
+struct kmod_dup_req {
+	struct list_head list;
+	char name[MODULE_NAME_LEN];
+	struct completion first_req_done;
+	struct work_struct complete_work;
+	struct delayed_work delete_work;
+	int dup_ret;
+};
+
+static struct kmod_dup_req *kmod_dup_request_lookup(char *module_name)
+{
+	struct kmod_dup_req *kmod_req;
+
+	list_for_each_entry_rcu(kmod_req, &dup_kmod_reqs, list,
+				lockdep_is_held(&kmod_dup_mutex)) {
+		if (strlen(kmod_req->name) == strlen(module_name) &&
+		    !memcmp(kmod_req->name, module_name, strlen(module_name))) {
+			return kmod_req;
+                }
+        }
+
+	return NULL;
+}
+
+static void kmod_dup_request_delete(struct work_struct *work)
+{
+	struct kmod_dup_req *kmod_req;
+	kmod_req = container_of(to_delayed_work(work), struct kmod_dup_req, delete_work);
+
+	/*
+	 * The typical situation is a module successully loaded. In that
+	 * situation the module will be present already in userspace. If
+	 * new requests come in after that, userspace will already know the
+	 * module is loaded so will just return 0 right away. There is still
+	 * a small chance right after we delete this entry new request_module()
+	 * calls may happen after that, they can happen. These heuristics
+	 * are to protect finit_module() abuse for auto-loading, if modules
+	 * are still tryign to auto-load even if a module is already loaded,
+	 * that's on them, and those inneficiencies should not be fixed by
+	 * kmod. The inneficies there are a call to modprobe and modprobe
+	 * just returning 0.
+	 */
+	mutex_lock(&kmod_dup_mutex);
+	list_del_rcu(&kmod_req->list);
+	synchronize_rcu();
+	mutex_unlock(&kmod_dup_mutex);
+	kfree(kmod_req);
+}
+
+static void kmod_dup_request_complete(struct work_struct *work)
+{
+	struct kmod_dup_req *kmod_req;
+
+	kmod_req = container_of(work, struct kmod_dup_req, complete_work);
+
+	/*
+	 * This will ensure that the kernel will let all the waiters get
+	 * informed its time to check the return value. It's time to
+	 * go home.
+	 */
+	complete_all(&kmod_req->first_req_done);
+
+	/*
+	 * Now that we have allowed prior request_module() calls to go on
+	 * with life, let's schedule deleting this entry. We don't have
+	 * to do it right away, but we *eventually* want to do it so to not
+	 * let this linger forever as this is just a boot optimization for
+	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
+	 */
+	queue_delayed_work(system_wq, &kmod_req->delete_work, 60 * HZ);
+}
+
+bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
+{
+	struct kmod_dup_req *kmod_req, *new_kmod_req;
+	int ret;
+
+	/*
+	 * Pre-allocate the entry in case we have to use it later
+	 * to avoid contention with the mutex.
+	 */
+	new_kmod_req = kzalloc(sizeof(*new_kmod_req), GFP_KERNEL);
+	if (!new_kmod_req)
+		return false;
+
+	memcpy(new_kmod_req->name, module_name, strlen(module_name));
+	INIT_WORK(&new_kmod_req->complete_work, kmod_dup_request_complete);
+	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
+	init_completion(&new_kmod_req->first_req_done);
+
+	mutex_lock(&kmod_dup_mutex);
+
+	kmod_req = kmod_dup_request_lookup(module_name);
+	if (!kmod_req) {
+		/*
+		 * If the first request that came through for a module
+		 * was with request_module_nowait() we cannot wait for it
+		 * and share its return value with other users which may
+		 * have used request_module() and need a proper return value
+		 * so just skip using them as an anchor.
+		 *
+		 * If a prior request to this one came through with
+		 * request_module() though, then a request_module_nowait()
+		 * would benefit from duplicate detection.
+		 */
+		if (!wait) {
+			kfree(new_kmod_req);
+			pr_warn("New request_module_nowait() for %s -- cannot track duplicates for this request\n", module_name);
+			mutex_unlock(&kmod_dup_mutex);
+			return false;
+		}
+
+		/*
+		 * There was no duplicate, just add the request so we can
+		 * keep tab on duplicates later.
+		 */
+		pr_info("New request_module() for %s\n", module_name);
+		list_add_rcu(&new_kmod_req->list, &dup_kmod_reqs);
+		mutex_unlock(&kmod_dup_mutex);
+		return false;
+	}
+	mutex_unlock(&kmod_dup_mutex);
+
+	/* We are dealing with a duplicate request now */
+
+	kfree(new_kmod_req);
+
+	/*
+	 * To fix these try to use try_then_request_module() instead as that
+	 * will check if the component you are looking for is present or not.
+	 * You could also just queue a single request to load the module once,
+	 * instead of having each and everything you need try to request for
+	 * the module.
+	 *
+	 * Duplicate request_module() calls  can cause quite a bit of wasted
+	 * vmalloc() space when racing with userspace.
+	 */
+	WARN(1, "module-autoload: duplicate request for module %s\n", module_name);
+
+	if (!wait) {
+		/*
+		 * If request_module_nowait() was used then the user just
+		 * wanted to issue the request and if another module request
+		 * was already its way with the same name we don't care for
+		 * the return value either. Let duplicate request_module_nowait()
+		 * calls bail out right away.
+		 */
+		*dup_ret = 0;
+		return true;
+	}
+
+	/*
+	 * If a duplicate request_module() was used they *may* care for
+	 * the return value, so we have no other option but to wait for
+	 * the first caller to complete. If the first caller used
+	 * the request_module_nowait() call, subsquent callers will
+	 * deal with the comprmise of getting a successful call with this
+	 * optimization enabled ...
+	 */
+	ret = wait_for_completion_state(&kmod_req->first_req_done,
+					TASK_UNINTERRUPTIBLE | TASK_KILLABLE);
+	if (ret) {
+		*dup_ret = ret;
+		return true;
+	}
+
+	/* Now the duplicate request has the same exact return value as the first request */
+	*dup_ret = kmod_req->dup_ret;
+
+	return true;
+}
+
+void kmod_dup_request_announce(char *module_name, int ret)
+{
+	struct kmod_dup_req *kmod_req;
+
+	mutex_lock(&kmod_dup_mutex);
+
+	kmod_req = kmod_dup_request_lookup(module_name);
+	if (!kmod_req)
+		goto out;
+
+	kmod_req->dup_ret = ret;
+
+	/*
+	 * If we complete() here we may allow duplicate threads
+	 * to continue before the first one that submitted the
+	 * request. We're in no rush also, given that each and
+	 * every bounce back to userspace is slow we avoid that
+	 * with a slight delay here. So queueue up the completion
+	 * and let duplicates suffer, just wait a tad bit longer.
+	 * There is no rush. But we also don't want to hold the
+	 * caller up forever or introduce any boot delays.
+	 */
+	queue_work(system_wq, &kmod_req->complete_work);
+
+out:
+	mutex_unlock(&kmod_dup_mutex);
+}
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 9d97a59a9127..67d750549a44 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
  */
 
 #include <linux/elf.h>
@@ -217,6 +218,20 @@ static inline void mod_stat_bump_becoming(struct load_info *info, int flags)
 
 #endif /* CONFIG_MODULE_STATS */
 
+#ifdef CONFIG_MODULE_AUTOLOAD_SUPRESS_DUPS
+bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret);
+void kmod_dup_request_announce(char *module_name, int ret);
+#else
+static inline bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
+{
+	return false;
+}
+
+static inline void kmod_dup_request_announce(char *module_name, int ret)
+{
+}
+#endif
+
 #ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
 struct mod_unload_taint {
 	struct list_head list;
diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
index 5899083436a3..0800d9891692 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -1,6 +1,9 @@
 /*
  * kmod - the kernel module loader
+ *
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
  */
+
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -27,6 +30,7 @@
 #include <linux/uaccess.h>
 
 #include <trace/events/module.h>
+#include "internal.h"
 
 /*
  * Assuming:
@@ -65,7 +69,7 @@ static void free_modprobe_argv(struct subprocess_info *info)
 	kfree(info->argv);
 }
 
-static int call_modprobe(char *module_name, int wait)
+static int call_modprobe(char *orig_module_name, int wait)
 {
 	struct subprocess_info *info;
 	static char *envp[] = {
@@ -74,12 +78,14 @@ static int call_modprobe(char *module_name, int wait)
 		"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
 		NULL
 	};
+	char *module_name;
+	int ret;
 
 	char **argv = kmalloc(sizeof(char *[5]), GFP_KERNEL);
 	if (!argv)
 		goto out;
 
-	module_name = kstrdup(module_name, GFP_KERNEL);
+	module_name = kstrdup(orig_module_name, GFP_KERNEL);
 	if (!module_name)
 		goto free_argv;
 
@@ -94,13 +100,16 @@ static int call_modprobe(char *module_name, int wait)
 	if (!info)
 		goto free_module_name;
 
-	return call_usermodehelper_exec(info, wait | UMH_KILLABLE);
+	ret = call_usermodehelper_exec(info, wait | UMH_KILLABLE);
+	kmod_dup_request_announce(orig_module_name, ret);
+	return ret;
 
 free_module_name:
 	kfree(module_name);
 free_argv:
 	kfree(argv);
 out:
+	kmod_dup_request_announce(orig_module_name, -ENOMEM);
 	return -ENOMEM;
 }
 
@@ -124,7 +133,7 @@ int __request_module(bool wait, const char *fmt, ...)
 {
 	va_list args;
 	char module_name[MODULE_NAME_LEN];
-	int ret;
+	int ret, dup_ret;
 
 	/*
 	 * We don't allow synchronous module loading from async.  Module
@@ -156,8 +165,14 @@ int __request_module(bool wait, const char *fmt, ...)
 
 	trace_module_request(module_name, wait, _RET_IP_);
 
+	if (kmod_dup_request_exists_wait(module_name, wait, &dup_ret)) {
+		ret = dup_ret;
+		goto out;
+	}
+
 	ret = call_modprobe(module_name, wait ? UMH_WAIT_PROC : UMH_WAIT_EXEC);
 
+out:
 	up(&kmod_concurrent_max);
 
 	return ret;
-- 
2.39.2

