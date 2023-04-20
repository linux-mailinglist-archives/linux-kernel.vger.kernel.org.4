Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860FD6E868A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjDTAa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjDTAaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:30:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C6693;
        Wed, 19 Apr 2023 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QNcP7Y8waGN8qINRX778MCg2Bb0i1HWpYFjQ+JXIBOg=; b=2/BnyOT7ySK6DBX4aw0Q+AQzLC
        gwfNX+0z27ZWCRrPIJRlUpCL/5qeomkL9Y4Hn0XHoa4gborBuGswHmMrTcHFlETDrB/f58+4IgCzW
        3eLDdsXzLYQnpFC9SxEvrnFX6NCK4bstuxELDdNaFXLquEDCT7sNv0Wi9xiM/wHsgMqwQ5PA77SEM
        s91r+xNO3qcRQ3ZXVJD2/RugnD1MnIEcBk5ZB5pJR0A2cqe206U9yJaNlWCyV+s2hcgmnnJvACyFT
        HzQn14ateCS0/nopjr9NKvc94gqYugy1aoeZ/dKvSMbI64WDa9J/MMrg7eF283kZxNTMjjU1i4w9C
        kM/wS9vQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppICF-006jL8-0l;
        Thu, 20 Apr 2023 00:30:47 +0000
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
Subject: [PATCH v2] module: add debugging auto-load duplicate module support
Date:   Wed, 19 Apr 2023 17:30:46 -0700
Message-Id: <20230420003046.1604251-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The finit_module() system call can in the worst case use up to more than
twice of a module's size in virtual memory. Duplicate finit_module()
system calls are non fatal, however they unnecessarily strain virtual
memory during bootup and in the worst case can cause a system to fail
to boot. This is only known to currently be an issue on systems with
larger number of CPUs.

To help debug this situation we need to consider the different sources for
finit_module(). Requests from the kernel that rely on module auto-loading,
ie, the kernel's *request_module() API, are one source of calls. Although
modprobe checks to see if a module is already loaded prior to calling
finit_module() there is a small race possible allowing userspace to
trigger multiple modprobe calls racing against modprobe and this not
seeing the module yet loaded.

This adds debugging support to the kernel module auto-loader (*request_module()
calls) to easily detect duplicate module requests. To aid with possible bootup
failure issues incurred by this, it will converge duplicates requests to a
single request. This avoids any possible strain on virtual memory during
bootup which could be incurred by duplicate module autoloading requests.

Folks debugging virtual memory abuse on bootup can and should enable
this to see what pr_warn()s come on, to see if module auto-loading is to
blame for their wores. If they see duplicates they can further debug this
by enabling the module.enable_dups_trace kernel parameter or by enabling
CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE.

Current evidence seems to point to only a few duplicates for module
auto-loading. And so the source for other duplicates creating heavy
virtual memory pressure due to larger number of CPUs should becoming
from another place (likely udev).

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Changes on this v2:

  o Tons of language adjustments based on feedback by Greg KH so
    that folks understand this is for debugging purposes. The "lost"
    language has been modified to clarify the issue with duplicates is
    straining of virtual memory on bootup.
  o The kconfig option was renamed to clarify the goal
  o A new module paramter is added so to avoid WARN_ON() by default and
    have the bots go crazy. A new kconfig option is also added so to
    not have folks have to set this module parameter. Documentation is
    added for this too.

 .../admin-guide/kernel-parameters.txt         |   6 +
 kernel/module/Kconfig                         |  59 +++++
 kernel/module/Makefile                        |   1 +
 kernel/module/dups.c                          | 246 ++++++++++++++++++
 kernel/module/internal.h                      |  15 ++
 kernel/module/kmod.c                          |  23 +-
 6 files changed, 346 insertions(+), 4 deletions(-)
 create mode 100644 kernel/module/dups.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..5915a23207da 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3332,6 +3332,12 @@
 			specified, <module>.async_probe takes precedence for
 			the specific module.
 
+	module.enable_dups_trace
+			[KNL] When CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS is set,
+			this means that duplicate request_module() calls will
+			trigger a WARN_ON() instead of a pr_warn(). Note that
+			if MODULE_DEBUG_AUTOLOAD_DUPS_TRACE is set, WARN_ON()s
+			will always be issued and this option does nothing.
 	module.sig_enforce
 			[KNL] When CONFIG_MODULE_SIG is set, this means that
 			modules without (valid) signatures will fail to load.
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index e6df183e2c80..33a2e991f608 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -59,6 +59,65 @@ config MODULE_STATS
 
 	  If unsure, say N.
 
+config MODULE_DEBUG_AUTOLOAD_DUPS
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
+	  duplicate module request ends up just unnecessarily straining virtual
+	  memory.
+
+	  This debugging facility will create pr_warn() splats for duplicate
+	  module requests to help identify if module auto-loading may be the
+	  culprit to your early boot virtual memory pressure. Since virtual
+	  memory abuse caused by duplicate module requests could render a
+	  system unusable this functionality will also converge races in
+	  requests for the same module to a single request. You can boot with
+	  the module.enable_dups_trace=1 kernel parameter to use WARN_ON()
+	  instead of the pr_warn().
+
+	  If the first module request used request_module_nowait() we cannot
+	  use that as the anchor to wait for duplicate module requests, since
+	  users of request_module() do want a proper return value. If a call
+	  for the same module happened earlier with request_module() though,
+	  then a duplicate request_module_nowait() would be detected. The
+	  non-wait request_module() call is synchronous and waits until modprobe
+	  completes. Subsequent auto-loading requests for the same module do
+	  not trigger a new finit_module() calls and do not strain virtual
+	  memory, and so as soon as modprobe successfully completes we remove
+	  tracking for duplicates for that module.
+
+	  Enable this functionality to try to debug virtual memory abuse during
+	  boot on systems which are failing to boot or if you suspect you may be
+	  straining virtual memory during boot, and you want to identify if the
+	  abuse was due to module auto-loading. These issues are currently only
+	  known to occur on systems with many CPUs (over 400) and is likely the
+	  result of udev issuing duplicate module requests for each CPU, and so
+	  module auto-loading is not the culprit. There may very well still be
+	  many duplicate module auto-loading requests which could be optimized
+	  for and this debugging facility can be used to help identify them.
+
+	  Only enable this for debugging system functionality, never have it
+	  enabled on real systems.
+
+config MODULE_DEBUG_AUTOLOAD_DUPS_TRACE
+	bool "Force full stack trace when duplicates are found"
+	depends on MODULE_DEBUG_AUTOLOAD_DUPS
+	help
+	  Enabling this will force a full stack trace for duplicate module
+	  auto-loading requests using WARN_ON() instead of pr_warn(). You
+	  should keep this disabled at all times unless you are a developer
+	  and are doing a manual inspection and want to debug exactly why
+	  these duplicates occur.
+
 endif # MODULE_DEBUG
 
 config MODULE_FORCE_LOAD
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 52340bce497e..a10b2b9a6fdf 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -10,6 +10,7 @@ KCOV_INSTRUMENT_module.o := n
 obj-y += main.o
 obj-y += strict_rwx.o
 obj-y += kmod.o
+obj-$(CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS) += dups.o
 obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
diff --git a/kernel/module/dups.c b/kernel/module/dups.c
new file mode 100644
index 000000000000..aa8e1361fdb5
--- /dev/null
+++ b/kernel/module/dups.c
@@ -0,0 +1,246 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * kmod dups - the kernel module autoloader duplicate suppressor
+ *
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
+ */
+
+#define pr_fmt(fmt)     "module: " fmt
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
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "module."
+static bool enable_dups_trace = IS_ENABLED(CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE);
+module_param(enable_dups_trace, bool_enable_only, 0644);
+
+/*
+ * Protects dup_kmod_reqs list, adds / removals with RCU.
+ */
+static DEFINE_MUTEX(kmod_dup_mutex);
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
+			pr_debug("New request_module_nowait() for %s -- cannot track duplicates for this request\n", module_name);
+			mutex_unlock(&kmod_dup_mutex);
+			return false;
+		}
+
+		/*
+		 * There was no duplicate, just add the request so we can
+		 * keep tab on duplicates later.
+		 */
+		pr_debug("New request_module() for %s\n", module_name);
+		list_add_rcu(&new_kmod_req->list, &dup_kmod_reqs);
+		mutex_unlock(&kmod_dup_mutex);
+		return false;
+	}
+	mutex_unlock(&kmod_dup_mutex);
+
+	/* We are dealing with a duplicate request now */
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
+	if (enable_dups_trace)
+		WARN(1, "module-autoload: duplicate request for module %s\n", module_name);
+	else
+		pr_warn("module-autoload: duplicate request for module %s\n", module_name);
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
index 1fd75dd346dc..d67682489d14 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
  */
 
 #include <linux/elf.h>
@@ -221,6 +222,20 @@ static inline void mod_stat_bump_becoming(struct load_info *info, int flags)
 
 #endif /* CONFIG_MODULE_STATS */
 
+#ifdef CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS
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

