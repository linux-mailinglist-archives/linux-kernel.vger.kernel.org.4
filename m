Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062E35FE119
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiJMSZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiJMSZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CE39F771
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665685152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=228Ak1koI4cRS8wN5hieMFYJjdxB30m/YzzVRJtmkcw=;
        b=QjqRgvLG4eO85/6xuPNmOT9Y49XA8d09eyxHJjM91AdN54Z+oOc57rUIgVa+R0ulsrcISJ
        DHXVrZDTJDtSf6PT7J+xxMM37XyZWANd9hEBalb7vjaHm/MVtr5NV07m7ei1NskGmY38bx
        82Ip5GJgPorQIQ+FjvUYshzo0tEbXUM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-vYNjGK6zNQ2_s5OW0XqIYw-1; Thu, 13 Oct 2022 14:05:23 -0400
X-MC-Unique: vYNjGK6zNQ2_s5OW0XqIYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E58E086C042;
        Thu, 13 Oct 2022 18:05:22 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A719208744E;
        Thu, 13 Oct 2022 18:05:19 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, David Hildenbrand <david@redhat.com>,
        Lin Liu <linl@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v1] kernel/module: allocate module vmap space after making sure the module is unique
Date:   Thu, 13 Oct 2022 20:05:18 +0200
Message-Id: <20221013180518.217405-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already make sure to allocate percpu data only after we verified that
the module we're loading hasn't already been loaded and isn't
concurrently getting loaded -- that it's unique.

On big systems (> 400 CPUs and many devices) with KASAN enabled, we're now
phasing a similar issue with the module vmap space.

When KASAN_INLINE is enabled (resulting in large module size), plenty
of devices that udev wants to probe and plenty (> 400) of CPUs that can
carry out that probing concurrently, we can actually run out of module
vmap space and trigger vmap allocation errors:

[  165.818200] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
[  165.836622] vmap allocation for size 315392 failed: use vmalloc=<size> to increase size
[  165.837461] vmap allocation for size 315392 failed: use vmalloc=<size> to increase size
[  165.840573] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
[  165.841059] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
[  165.841428] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
[  165.841819] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
[  165.842123] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
[  165.843359] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
[  165.844894] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
[  165.847028] CPU: 253 PID: 4995 Comm: systemd-udevd Not tainted 5.19.0 #2
[  165.935689] Hardware name: Lenovo ThinkSystem SR950 -[7X12ABC1WW]-/-[7X12ABC1WW]-, BIOS -[PSE130O-1.81]- 05/20/2020
[  165.947343] Call Trace:
[  165.950075]  <TASK>
[  165.952425]  dump_stack_lvl+0x57/0x81
[  165.956532]  warn_alloc.cold+0x95/0x18a
[  165.960836]  ? zone_watermark_ok_safe+0x240/0x240
[  165.966100]  ? slab_free_freelist_hook+0x11d/0x1d0
[  165.971461]  ? __get_vm_area_node+0x2af/0x360
[  165.976341]  ? __get_vm_area_node+0x2af/0x360
[  165.981219]  __vmalloc_node_range+0x291/0x560
[  165.986087]  ? __mutex_unlock_slowpath+0x161/0x5e0
[  165.991447]  ? move_module+0x4c/0x630
[  165.995547]  ? vfree_atomic+0xa0/0xa0
[  165.999647]  ? move_module+0x4c/0x630
[  166.003741]  module_alloc+0xe7/0x170
[  166.007747]  ? move_module+0x4c/0x630
[  166.011840]  move_module+0x4c/0x630
[  166.015751]  layout_and_allocate+0x32c/0x560
[  166.020519]  load_module+0x8e0/0x25c0
[  166.024623]  ? layout_and_allocate+0x560/0x560
[  166.029586]  ? kernel_read_file+0x286/0x6b0
[  166.034269]  ? __x64_sys_fspick+0x290/0x290
[  166.038946]  ? userfaultfd_unmap_prep+0x430/0x430
[  166.044203]  ? lock_downgrade+0x130/0x130
[  166.048698]  ? __do_sys_finit_module+0x11a/0x1c0
[  166.053854]  __do_sys_finit_module+0x11a/0x1c0
[  166.058818]  ? __ia32_sys_init_module+0xa0/0xa0
[  166.063882]  ? __seccomp_filter+0x92/0x930
[  166.068494]  do_syscall_64+0x59/0x90
[  166.072492]  ? do_syscall_64+0x69/0x90
[  166.076679]  ? do_syscall_64+0x69/0x90
[  166.080864]  ? do_syscall_64+0x69/0x90
[  166.085047]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[  166.090984]  ? lockdep_hardirqs_on+0x79/0x100
[  166.095855]  entry_SYSCALL_64_after_hwframe+0x63/0xcd[  165.818200] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size

Interestingly, when reducing the number of CPUs (nosmt), it works as
expected.

The underlying issue is that we first allocate memory (including module
vmap space) in layout_and_allocate(), and then verify whether the module
is unique in add_unformed_module(). So we end up allocating module vmap
space even though we might not need it -- which is a problem when modules
are big and we can have a lot of concurrent probing of the same set of
modules as on the big system at hand.

Unfortunately, we cannot simply add the module earlier, because
move_module() -- that allocates the module vmap space -- essentially
brings the module to life from a temporary one. Adding the temporary one
and replacing it is also sub-optimal (because replacing it would require
to synchronize against RCU) and feels kind of dangerous judging that we
end up copying it.

So instead, add a second list (pending_load_infos) that tracks the modules
(via their load_info) that are unique and are still getting loaded
("pending"), but haven't made it to the actual module list yet. This
shouldn't have a notable runtime overhead when concurrently loading
modules: the new list is expected to usually either be empty or contain
very few entries for a short time.

Thanks to Uladzislau for his help to verify that it's not actually a
vmap code issue.

Reported-by: Lin Liu <linl@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/module/internal.h |   2 +
 kernel/module/main.c     | 122 +++++++++++++++++++++++++++------------
 2 files changed, 88 insertions(+), 36 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 680d980a4fb2..9d5cc9b1d56a 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -76,6 +76,8 @@ struct load_info {
 	struct {
 		unsigned int sym, str, mod, vers, info, pcpu;
 	} index;
+
+	struct list_head next;
 };
 
 enum mod_license {
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a4e4d84b6f4e..b473228136eb 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -65,10 +65,20 @@
  * 2) module_use links,
  * 3) mod_tree.addr_min/mod_tree.addr_max.
  * (delete and add uses RCU list operations).
+ *
+ * 4) List of pending load infos
  */
 DEFINE_MUTEX(module_mutex);
 LIST_HEAD(modules);
 
+/*
+ * Modules (via load_info) that are currently being loaded but cannot be added
+ * to the module list yet are kept in a separate list. This list, combined with
+ * the module list makes sure that modules are unique: a module name has to be
+ * unique across both lists, protected by the module_mutex.
+ */
+LIST_HEAD(pending_load_infos);
+
 /* Work queue for freeing init sections in success case */
 static void do_free_init(struct work_struct *w);
 static DECLARE_WORK(init_free_wq, do_free_init);
@@ -762,7 +772,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false), sizeof(last_unloaded_module.taints));
 
 	free_module(mod);
-	/* someone could wait for the module in add_unformed_module() */
+	/* someone could wait for the module in add_pending_load_info() */
 	wake_up_all(&module_wq);
 	return 0;
 out:
@@ -2374,6 +2384,16 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	return module_finalize(info->hdr, info->sechdrs, mod);
 }
 
+static bool __is_pending_load_info_name(const char *name)
+{
+	struct load_info *info;
+
+	list_for_each_entry(info, &pending_load_infos, next)
+		if (!strcmp(info->name, name))
+			return true;
+	return false;
+}
+
 /* Is this module of this name done loading?  No locks held. */
 static bool finished_loading(const char *name)
 {
@@ -2388,7 +2408,11 @@ static bool finished_loading(const char *name)
 	sched_annotate_sleep();
 	mutex_lock(&module_mutex);
 	mod = find_module_all(name, strlen(name), true);
-	ret = !mod || mod->state == MODULE_STATE_LIVE;
+	if (!mod)
+		/* It might still be in the early process of loading. */
+		ret = !__is_pending_load_info_name(name);
+	else
+		ret = mod->state == MODULE_STATE_LIVE;
 	mutex_unlock(&module_mutex);
 
 	return ret;
@@ -2552,43 +2576,58 @@ static int may_init_module(void)
 	return 0;
 }
 
-/*
- * We try to place it in the list now to make sure it's unique before
- * we dedicate too many resources.  In particular, temporary percpu
- * memory exhaustion.
- */
-static int add_unformed_module(struct module *mod)
+static int add_pending_load_info(struct load_info *info)
 {
+	struct module *mod;
 	int err;
-	struct module *old;
-
-	mod->state = MODULE_STATE_UNFORMED;
 
-again:
-	mutex_lock(&module_mutex);
-	old = find_module_all(mod->name, strlen(mod->name), true);
-	if (old != NULL) {
-		if (old->state != MODULE_STATE_LIVE) {
-			/* Wait in case it fails to load. */
+	while (true) {
+		mutex_lock(&module_mutex);
+		mod = find_module_all(info->name, strlen(info->name), true);
+		if (!mod && !__is_pending_load_info_name(info->name))
+			break;
+		if (mod && mod->state == MODULE_STATE_LIVE) {
 			mutex_unlock(&module_mutex);
-			err = wait_event_interruptible(module_wq,
-					       finished_loading(mod->name));
-			if (err)
-				goto out_unlocked;
-			goto again;
+			return -EEXIST;
 		}
-		err = -EEXIST;
-		goto out;
+
+		/*
+		 * The module is in some phase of getting loaded/unloaded;
+		 * wait and retry.
+		 */
+		mutex_unlock(&module_mutex);
+		err = wait_event_interruptible(module_wq,
+					       finished_loading(info->name));
+		if (err)
+			return err;
 	}
+
+	INIT_LIST_HEAD(&info->next);
+	list_add(&info->next, &pending_load_infos);
+	mutex_unlock(&module_mutex);
+	return 0;
+}
+
+static void remove_pending_load_info(struct load_info *info)
+{
+	mutex_lock(&module_mutex);
+	list_del(&info->next);
+	/* someone could wait for the module name in finished_loading(). */
+	wake_up_all(&module_wq);
+	mutex_unlock(&module_mutex);
+}
+
+static void add_unformed_module(struct load_info *info, struct module *mod)
+{
+	mod->state = MODULE_STATE_UNFORMED;
+
+	mutex_lock(&module_mutex);
 	mod_update_bounds(mod);
 	list_add_rcu(&mod->list, &modules);
+	/* The module is on the module list now. */
+	list_del(&info->next);
 	mod_tree_insert(mod);
-	err = 0;
-
-out:
 	mutex_unlock(&module_mutex);
-out_unlocked:
-	return err;
 }
 
 static int complete_formation(struct module *mod, struct load_info *info)
@@ -2720,12 +2759,24 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		goto free_copy;
 	}
 
-	err = rewrite_section_headers(info, flags);
+	/*
+	 * We make sure the module name is unique before we dedicate too many
+	 * resources. In particular, avoid temporary percpu memory and module
+	 * vmap space exhaustion.
+	 */
+	err = add_pending_load_info(info);
 	if (err)
 		goto free_copy;
 
+	err = rewrite_section_headers(info, flags);
+	if (err) {
+		remove_pending_load_info(info);
+		goto free_copy;
+	}
+
 	/* Check module struct version now, before we try to use module. */
 	if (!check_modstruct_version(info, info->mod)) {
+		remove_pending_load_info(info);
 		err = -ENOEXEC;
 		goto free_copy;
 	}
@@ -2739,10 +2790,11 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	audit_log_kern_module(mod->name);
 
-	/* Reserve our place in the list. */
-	err = add_unformed_module(mod);
-	if (err)
-		goto free_module;
+	/*
+	 * Add the module to the module list as unformed. This will remove the
+	 * load_info from the pending load_info list.
+	 */
+	add_unformed_module(info, mod);
 
 #ifdef CONFIG_MODULE_SIG
 	mod->sig_ok = info->sig_ok;
@@ -2754,7 +2806,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	}
 #endif
 
-	/* To avoid stressing percpu allocator, do this once we're unique. */
 	err = percpu_modalloc(mod, info);
 	if (err)
 		goto unlink_mod;
@@ -2890,7 +2941,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Wait for RCU-sched synchronizing before releasing mod->list. */
 	synchronize_rcu();
 	mutex_unlock(&module_mutex);
- free_module:
 	/* Free lock-classes; relies on the preceding sync_rcu() */
 	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
-- 
2.37.3

