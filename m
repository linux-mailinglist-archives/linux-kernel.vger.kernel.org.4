Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E55BCBD7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiISMdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiISMda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:33:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39972DA92;
        Mon, 19 Sep 2022 05:33:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8120821ECF;
        Mon, 19 Sep 2022 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663590805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOGEQqqvGgBv9t9U3dwRcTFr510bvL3XRcIHTHYCDOQ=;
        b=FPa2jvC/zTpC1InKSRSdUPLahKGa4yUcao9elGgmgqqxR1BxbGAjEWbvSgtbyY22T24ZxM
        vPRc/pC7bK8TmoaVn9xbyvXR+YxcJ4vEEUomDK5blP8jTUP+wcgqyQ6FcxWLuPkpVPmDIP
        Lh67eq/VGtjabIhYhlwjL7OPOPJ/dkc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DF3513A96;
        Mon, 19 Sep 2022 12:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6EQDFpVhKGN4LAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Mon, 19 Sep 2022 12:33:25 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     mcgrof@kernel.org
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 2/2] module: Merge same-name module load requests
Date:   Mon, 19 Sep 2022 14:32:33 +0200
Message-Id: <20220919123233.8538-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220919123233.8538-1-petr.pavlu@suse.com>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a system boot, it can happen that the kernel receives a burst of
requests to insert the same module but loading it eventually fails
during its init call. For instance, udev can make a request to insert
a frequency module for each individual CPU when another frequency module
is already loaded which causes the init function of the new module to
return an error.

The module loader currently serializes all such requests, with the
barrier in add_unformed_module(). This creates a lot of unnecessary work
and delays the boot.

This patch improves the behavior as follows:
* A check whether a module load matches an already loaded module is
  moved right after a module name is determined. -EEXIST continues to be
  returned if the module exists and is live, -EBUSY is returned if
  a same-name module is going.
* A new reference-counted shared_load_info structure is introduced to
  keep track of duplicate load requests. Two loads are considered
  equivalent if their module name matches. In case a load duplicates
  another running insert, the code waits for its completion and then
  returns -EEXIST or -EBUSY depending on whether it succeeded.

Note that prior to 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
for modules that have finished loading"), the kernel already did merge
some of same load requests but it was more by accident and relied on
specific timing. The patch brings this behavior back in a more explicit
form.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/main.c | 214 ++++++++++++++++++++++++++++++-------------
 1 file changed, 150 insertions(+), 64 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 06cb41c3d2a1..fb97d7a0cae9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -61,14 +61,29 @@
 
 /*
  * Mutex protects:
- * 1) List of modules (also safely readable with preempt_disable),
+ * 1) list of modules (also safely readable with preempt_disable, delete and add
+ *    uses RCU list operations).
  * 2) module_use links,
- * 3) mod_tree.addr_min/mod_tree.addr_max.
- * (delete and add uses RCU list operations).
+ * 3) mod_tree.addr_min/mod_tree.addr_max,
+ * 4) list of unloaded_tainted_modules.
+ * 5) list of running_loads.
  */
 DEFINE_MUTEX(module_mutex);
 LIST_HEAD(modules);
 
+/* Shared information to track duplicate module loads. */
+struct shared_load_info {
+	char name[MODULE_NAME_LEN];
+	refcount_t refcnt;
+	struct list_head list;
+	struct completion done;
+	int err;
+};
+static LIST_HEAD(running_loads);
+
+/* Waiting for a module to finish loading? */
+static DECLARE_WAIT_QUEUE_HEAD(module_wq);
+
 /* Work queue for freeing init sections in success case */
 static void do_free_init(struct work_struct *w);
 static DECLARE_WORK(init_free_wq, do_free_init);
@@ -122,9 +137,6 @@ static void mod_update_bounds(struct module *mod)
 int modules_disabled;
 core_param(nomodule, modules_disabled, bint, 0);
 
-/* Waiting for a module to finish initializing? */
-static DECLARE_WAIT_QUEUE_HEAD(module_wq);
-
 static BLOCKING_NOTIFIER_HEAD(module_notify_list);
 
 int register_module_notifier(struct notifier_block *nb)
@@ -762,8 +774,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false), sizeof(last_unloaded_module.taints));
 
 	free_module(mod);
-	/* someone could wait for the module in add_unformed_module() */
-	wake_up_interruptible(&module_wq);
 	return 0;
 out:
 	mutex_unlock(&module_mutex);
@@ -2374,26 +2384,6 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	return module_finalize(info->hdr, info->sechdrs, mod);
 }
 
-/* Is this module of this name done loading?  No locks held. */
-static bool finished_loading(const char *name)
-{
-	struct module *mod;
-	bool ret;
-
-	/*
-	 * The module_mutex should not be a heavily contended lock;
-	 * if we get the occasional sleep here, we'll go an extra iteration
-	 * in the wait_event_interruptible(), which is harmless.
-	 */
-	sched_annotate_sleep();
-	mutex_lock(&module_mutex);
-	mod = find_module_all(name, strlen(name), true);
-	ret = !mod || mod->state == MODULE_STATE_LIVE;
-	mutex_unlock(&module_mutex);
-
-	return ret;
-}
-
 /* Call module constructors. */
 static void do_mod_ctors(struct module *mod)
 {
@@ -2524,7 +2514,6 @@ static noinline int do_init_module(struct module *mod)
 		schedule_work(&init_free_wq);
 
 	mutex_unlock(&module_mutex);
-	wake_up_interruptible(&module_wq);
 
 	return 0;
 
@@ -2540,7 +2529,6 @@ static noinline int do_init_module(struct module *mod)
 	klp_module_going(mod);
 	ftrace_release_mod(mod);
 	free_module(mod);
-	wake_up_interruptible(&module_wq);
 	return ret;
 }
 
@@ -2552,43 +2540,133 @@ static int may_init_module(void)
 	return 0;
 }
 
+static struct shared_load_info *
+shared_load_info_alloc(const struct load_info *info)
+{
+	struct shared_load_info *shared_info =
+		kzalloc(sizeof(*shared_info), GFP_KERNEL);
+	if (shared_info == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	strscpy(shared_info->name, info->name, sizeof(shared_info->name));
+	refcount_set(&shared_info->refcnt, 1);
+	INIT_LIST_HEAD(&shared_info->list);
+	init_completion(&shared_info->done);
+	return shared_info;
+}
+
+static void shared_load_info_get(struct shared_load_info *shared_info)
+{
+	refcount_inc(&shared_info->refcnt);
+}
+
+static void shared_load_info_put(struct shared_load_info *shared_info)
+{
+	if (refcount_dec_and_test(&shared_info->refcnt))
+		kfree(shared_info);
+}
+
 /*
- * We try to place it in the list now to make sure it's unique before
- * we dedicate too many resources.  In particular, temporary percpu
+ * Check that a module load is unique and make it visible to others. The code
+ * looks for parallel running inserts and already loaded modules. Two inserts
+ * are considered equivalent if their module name matches. In case this load
+ * duplicates another running insert, the code waits for its completion and
+ * then returns -EEXIST or -EBUSY depending on whether it succeeded.
+ *
+ * Detecting early that a load is unique avoids dedicating too many cycles and
+ * resources to bring up the module. In particular, it prevents temporary percpu
  * memory exhaustion.
+ *
+ * Merging same load requests then primarily helps during the boot process. It
+ * can happen that the kernel receives a burst of requests to load the same
+ * module (for example, a same module for each individual CPU) and loading it
+ * eventually fails during its init call. Merging the requests allows that only
+ * one full attempt to load the module is made.
+ *
+ * On a non-error return, it is guaranteed that this load is unique.
  */
-static int add_unformed_module(struct module *mod)
+static struct shared_load_info *add_running_load(const struct load_info *info)
 {
-	int err;
 	struct module *old;
+	struct shared_load_info *shared_info;
 
-	mod->state = MODULE_STATE_UNFORMED;
-
-again:
 	mutex_lock(&module_mutex);
-	old = find_module_all(mod->name, strlen(mod->name), true);
-	if (old != NULL) {
-		if (old->state != MODULE_STATE_LIVE) {
-			/* Wait in case it fails to load. */
+
+	/* Search if there is a running load of a module with the same name. */
+	list_for_each_entry(shared_info, &running_loads, list)
+		if (strcmp(shared_info->name, info->name) == 0) {
+			int err;
+
+			shared_load_info_get(shared_info);
 			mutex_unlock(&module_mutex);
-			err = wait_event_interruptible(module_wq,
-					       finished_loading(mod->name));
-			if (err)
-				goto out_unlocked;
-			goto again;
+
+			err = wait_for_completion_interruptible(
+				&shared_info->done);
+			if (!err)
+				err = shared_info->err ? -EBUSY : -EEXIST;
+			shared_load_info_put(shared_info);
+			shared_info = ERR_PTR(err);
+			goto out_unlocked;
 		}
-		err = -EEXIST;
+
+	/* Search if there is a live module with the given name already. */
+	old = find_module_all(info->name, strlen(info->name), true);
+	if (old != NULL) {
+		if (old->state == MODULE_STATE_LIVE) {
+			shared_info = ERR_PTR(-EEXIST);
+			goto out;
+		}
+
+		/*
+		 * Any active load always has its record in running_loads and so
+		 * would be found above. This applies independent whether such
+		 * a module is currently in MODULE_STATE_UNFORMED,
+		 * MODULE_STATE_COMING, or even in MODULE_STATE_GOING if its
+		 * initialization failed. It therefore means this must be an
+		 * older going module and the caller should try later once it is
+		 * gone.
+		 */
+		WARN_ON(old->state != MODULE_STATE_GOING);
+		shared_info = ERR_PTR(-EBUSY);
 		goto out;
 	}
-	mod_update_bounds(mod);
-	list_add_rcu(&mod->list, &modules);
-	mod_tree_insert(mod);
-	err = 0;
+
+	/* The load is unique, make it visible to others. */
+	shared_info = shared_load_info_alloc(info);
+	if (IS_ERR(shared_info))
+		goto out;
+	list_add(&shared_info->list, &running_loads);
 
 out:
 	mutex_unlock(&module_mutex);
 out_unlocked:
-	return err;
+	return shared_info;
+}
+
+static void finalize_running_load(struct shared_load_info *shared_info, int err)
+{
+	/* Inform other duplicate inserts that the load finished. */
+	mutex_lock(&module_mutex);
+	list_del(&shared_info->list);
+	shared_info->err = err;
+	mutex_unlock(&module_mutex);
+
+	complete_all(&shared_info->done);
+	shared_load_info_put(shared_info);
+
+	/* Tell other modules waiting on this one that it completed loading. */
+	wake_up_interruptible(&module_wq);
+}
+
+static void add_unformed_module(struct module *mod)
+{
+	mod->state = MODULE_STATE_UNFORMED;
+
+	mutex_lock(&module_mutex);
+	mod_update_bounds(mod);
+	list_add_rcu(&mod->list, &modules);
+	mod_tree_insert(mod);
+	mutex_unlock(&module_mutex);
 }
 
 static int complete_formation(struct module *mod, struct load_info *info)
@@ -2674,6 +2752,7 @@ static void cfi_init(struct module *mod);
 static int load_module(struct load_info *info, const char __user *uargs,
 		       int flags)
 {
+	struct shared_load_info *shared_info;
 	struct module *mod;
 	long err = 0;
 	char *after_dashes;
@@ -2711,38 +2790,43 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		goto free_copy;
 
 	/*
-	 * Now that we know we have the correct module name, check
-	 * if it's blacklisted.
+	 * Now that we know we have the correct module name, check if there is
+	 * another load of the same name in progress.
 	 */
+	shared_info = add_running_load(info);
+	if (IS_ERR(shared_info)) {
+		err = PTR_ERR(shared_info);
+		goto free_copy;
+	}
+
+	/* Check if the module is blacklisted. */
 	if (blacklisted(info->name)) {
 		err = -EPERM;
 		pr_err("Module %s is blacklisted\n", info->name);
-		goto free_copy;
+		goto free_shared;
 	}
 
 	err = rewrite_section_headers(info, flags);
 	if (err)
-		goto free_copy;
+		goto free_shared;
 
 	/* Check module struct version now, before we try to use module. */
 	if (!check_modstruct_version(info, info->mod)) {
 		err = -ENOEXEC;
-		goto free_copy;
+		goto free_shared;
 	}
 
 	/* Figure out module layout, and allocate all the memory. */
 	mod = layout_and_allocate(info, flags);
 	if (IS_ERR(mod)) {
 		err = PTR_ERR(mod);
-		goto free_copy;
+		goto free_shared;
 	}
 
 	audit_log_kern_module(mod->name);
 
 	/* Reserve our place in the list. */
-	err = add_unformed_module(mod);
-	if (err)
-		goto free_module;
+	add_unformed_module(mod);
 
 #ifdef CONFIG_MODULE_SIG
 	mod->sig_ok = info->sig_ok;
@@ -2852,7 +2936,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Done! */
 	trace_module_load(mod);
 
-	return do_init_module(mod);
+	err = do_init_module(mod);
+	finalize_running_load(shared_info, err);
+	return err;
 
  sysfs_cleanup:
 	mod_sysfs_teardown(mod);
@@ -2886,15 +2972,15 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Unlink carefully: kallsyms could be walking list. */
 	list_del_rcu(&mod->list);
 	mod_tree_remove(mod);
-	wake_up_interruptible(&module_wq);
 	/* Wait for RCU-sched synchronizing before releasing mod->list. */
 	synchronize_rcu();
 	mutex_unlock(&module_mutex);
- free_module:
 	/* Free lock-classes; relies on the preceding sync_rcu() */
 	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
 	module_deallocate(mod, info);
+ free_shared:
+	finalize_running_load(shared_info, err);
  free_copy:
 	free_copy(info, flags);
 	return err;
-- 
2.35.3

