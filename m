Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C736CD1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjC2Fc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjC2FcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:32:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DA13C39;
        Tue, 28 Mar 2023 22:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2bVkSUsIADWswZ5bVimfZdo+Dy3JEjup3DneXTttdjU=; b=XhxXDw48uuZL/uQqb/68ZIqJmD
        rmpQ5+Q9WG115GOyc2PP14uow1Fu9Fyl+xWkZjxKZPYGV93xilgKKaBYoUt+OfXEwj8QKkWJYdBAP
        IlOSqIb2pSUIbY05lI7yLe9mQz5sYUPfe2ZaCkc0mtkmJ5EgcE6Wl/9UhBxe1X1SjI0HtQj4Nsklu
        G0XJOAjov0Mty6kJx7mKk8qTyGDWjwDWIjOJYGmew3nmK1fFOcBMhqcc3k6rUwweq/cTtXlDD6n0v
        29oZ94XSTgSoPHrpY41wLms5xSkIGpjfT/z1uB11c2CAUA2biuHqIOL5jHz7+HStSb9kGiUkN6CoT
        qrdIB1TQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phOPW-00GgRu-2q;
        Wed, 29 Mar 2023 05:31:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, mcgrof@kernel.org
Subject: [PATCH 7/7] module: add debug stats to help identify memory pressure
Date:   Tue, 28 Mar 2023 22:31:49 -0700
Message-Id: <20230329053149.3976378-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329053149.3976378-1-mcgrof@kernel.org>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loading modules with finit_module() can end up using vmalloc(), vmap()
and vmalloc() again, for a total of up to 3 separate allocations in the
worse case for a single module. We always kernel_read*() the module,
that's a vmalloc(). Then vmap() is used for the module decompression,
and if so the last read buffer is freed as we use the now decompressed
module buffer to stuff data into our copy module. The last one is
specific to architectures but pretty much that's generally a series
of vmalloc() for different ELF sections...

Evaluation with new stress-ng module support [1] with just 100 ops
us proving that you can end up using GiBs of data easily even if
we are trying to be very careful not to load modules which are already
loaded. 100 ops seems to resemble the sort of pressure a system with
about 400 CPUs can create on modules. Although those issues for so
many concurrent loads per CPU is silly and are being fixed, we lack
proper tooling to help diagnose easily what happened, when it happened
and what likely are the culprits -- userspace or kernel module
autoloading.

Provide an initial set of stats for debugfs which let us easily scrape
post-boot information about failed loads. This sort of information can
be used on production worklaods to try to optimize *avoiding* redundant
memory pressure using finit_module().

Screen shot:

root@kmod ~ # cat /sys/kernel/debug/modules/stats
           Modules loaded       67
        Total module size       11464704
      Total mod text size       4194304
       Failed kread bytes       890064
        Failed kmod bytes       890064
      Invalid kread bytes       890064
 Invalid decompress bytes       0
        Invalid mod bytes       890064
         Average mod size       171115
    Average mod text size       62602
Failed modules:
                kvm_intel
                      kvm
                irqbypass
         crct10dif_pclmul
      ghash_clmulni_intel
             sha512_ssse3
           sha512_generic
              aesni_intel
              crypto_simd
                   cryptd
                    evdev
                serio_raw
               virtio_pci
                     nvme
                nvme_core
    virtio_pci_legacy_dev
                   t10_pi
           crc64_rocksoft
    virtio_pci_modern_dev
             crc32_pclmul
                   virtio
             crc32c_intel
              virtio_ring
                    crc64

[0] https://github.com/ColinIanKing/stress-ng.git
[1] echo 0 > /proc/sys/vm/oom_dump_tasks
    ./stress-ng --module 100 --module-name xfs

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/Kconfig    |  32 +++++++
 kernel/module/Makefile   |   4 +
 kernel/module/debug.c    |  16 ++++
 kernel/module/internal.h |  35 +++++++
 kernel/module/main.c     |  45 ++++++++-
 kernel/module/stats.c    | 200 +++++++++++++++++++++++++++++++++++++++
 kernel/module/tracking.c |   7 +-
 7 files changed, 331 insertions(+), 8 deletions(-)
 create mode 100644 kernel/module/debug.c
 create mode 100644 kernel/module/stats.c

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 424b3bc58f3f..fbf7b92cb3d0 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -22,6 +22,12 @@ menuconfig MODULES
 
 if MODULES
 
+config MODULE_DEBUG
+	bool "Module debugging"
+	default n
+	help
+	  Allows to help debug module functionality.
+
 config MODULE_FORCE_LOAD
 	bool "Forced module loading"
 	default n
@@ -48,6 +54,8 @@ config MODULE_FORCE_UNLOAD
 	  rmmod).  This is mainly for kernel developers and desperate users.
 	  If unsure, say N.
 
+if MODULE_DEBUG
+
 config MODULE_UNLOAD_TAINT_TRACKING
 	bool "Tainted module unload tracking"
 	depends on MODULE_UNLOAD
@@ -59,6 +67,30 @@ config MODULE_UNLOAD_TAINT_TRACKING
 	  page (see bad_page()), the aforementioned details are also
 	  shown. If unsure, say N.
 
+config MODULE_STATS
+	bool "Module statistics"
+	depends on DEBUG_FS
+	default n
+	help
+	  This option allows you to maintain a record of module statistics.
+	  For example each all modules size, average size, text size, and
+	  failed modules and the size for each of those. For failed
+	  modules we keep track of module which failed due to either the
+	  existing module taking too long to load or that module already
+	  was loaded.
+
+	  You should enable this if you are debugging production loads
+	  and want to see if userspace or the kernel is doing stupid things
+	  with loading modules when it shouldn't or if you want to help
+	  optimize userspace / kernel space module autoloading schemes.
+	  You might want to do this because failed modules tend to use
+	  use up significan amount of memory, and so you'd be doing everyone
+	  a favor in avoiding these failure proactively.
+
+	  If unsure, say N.
+
+endif # MODULE_DEBUG
+
 config MODVERSIONS
 	bool "Module versioning support"
 	help
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 5b1d26b53b8d..fe97047f3807 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -20,4 +20,8 @@ obj-$(CONFIG_PROC_FS) += procfs.o
 obj-$(CONFIG_SYSFS) += sysfs.o
 obj-$(CONFIG_KGDB_KDB) += kdb.o
 obj-$(CONFIG_MODVERSIONS) += version.o
+
+# Link order matters here, keep debug.o first.
+obj-$(CONFIG_MODULE_DEBUG) += debug.o
+obj-$(CONFIG_MODULE_STATS) += stats.o
 obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
diff --git a/kernel/module/debug.c b/kernel/module/debug.c
new file mode 100644
index 000000000000..ef580d70b751
--- /dev/null
+++ b/kernel/module/debug.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
+ */
+
+#include <linux/debugfs.h>
+#include "internal.h"
+
+struct dentry *mod_debugfs_root;
+
+static int module_debugfs_init(void)
+{
+	mod_debugfs_root = debugfs_create_dir("modules", NULL);
+	return 0;
+}
+module_init(module_debugfs_init);
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 6ae29bb8836f..a645cb3fafc7 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -143,6 +143,41 @@ static inline bool set_livepatch_module(struct module *mod)
 #endif
 }
 
+#ifdef CONFIG_MODULE_STATS
+
+#define mod_stat_add64(count, var) atomic64_add(count, var)
+#define mod_stat_inc(name) atomic_inc(name)
+
+extern atomic64_t total_mod_size;
+extern atomic64_t total_text_size;
+extern atomic64_t invalid_kread_bytes;
+extern atomic64_t invalid_decompress_bytes;
+extern atomic64_t invalid_mod_becoming_bytes;
+extern atomic64_t invalid_mod_bytes;
+
+extern atomic_t modcount;
+extern atomic_t failed_kreads;
+extern atomic_t failed_decompress;
+extern atomic_t failed_load_modules;
+struct mod_fail_load {
+	struct list_head list;
+	char name[MODULE_NAME_LEN];
+	atomic_t count;
+};
+
+int try_add_failed_module(const char *name);
+
+#else
+
+#define mod_stat_inc64(name)
+#define mod_stat_inc(name) atomic_inc(name)
+
+static inline int try_add_failed_module(const char *name)
+{
+	return 0;
+}
+#endif /* CONFIG_MODULE_STATS */
+
 #ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
 struct mod_unload_taint {
 	struct list_head list;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 145e15f19576..8b851042b7f9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2495,6 +2495,16 @@ static noinline int do_init_module(struct module *mod)
 {
 	int ret = 0;
 	struct mod_initfree *freeinit;
+	unsigned int text_size = 0, total_size = 0;
+
+	for_each_mod_mem_type(type) {
+		const struct module_memory *mod_mem = &mod->mem[type];
+		if (mod_mem->size) {
+			total_size += mod_mem->size;
+			if (type == MOD_TEXT || type == MOD_INIT_TEXT)
+				text_size += mod->mem[type].size;
+		}
+	}
 
 	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
 	if (!freeinit) {
@@ -2556,6 +2566,7 @@ static noinline int do_init_module(struct module *mod)
 		mod->mem[type].base = NULL;
 		mod->mem[type].size = 0;
 	}
+
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointer */
 	mod->btf_data = NULL;
@@ -2579,6 +2590,11 @@ static noinline int do_init_module(struct module *mod)
 	mutex_unlock(&module_mutex);
 	wake_up_all(&module_wq);
 
+	mod_stat_add64(text_size, &total_text_size);
+	mod_stat_add64(total_size, &total_mod_size);
+
+	mod_stat_inc(&modcount);
+
 	return 0;
 
 fail_free_freeinit:
@@ -2594,6 +2610,7 @@ static noinline int do_init_module(struct module *mod)
 	ftrace_release_mod(mod);
 	free_module(mod);
 	wake_up_all(&module_wq);
+
 	return ret;
 }
 
@@ -2650,6 +2667,9 @@ static int module_patient_check_exists(const char *name)
 		old = find_module_all(name, strlen(name), true);
 	}
 
+	if (try_add_failed_module(name))
+		pr_warn("Could not add fail-tracking for module: %s\n", name);
+
 	/*
 	 * We are here only when the same module was being loaded. Do
 	 * not try to load it again right now. It prevents long delays
@@ -2800,6 +2820,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		       int flags)
 {
 	struct module *mod;
+	bool module_allocated = false;
 	long err = 0;
 	char *after_dashes;
 
@@ -2839,6 +2860,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		goto free_copy;
 	}
 
+	module_allocated = true;
+
 	audit_log_kern_module(mod->name);
 
 	/* Reserve our place in the list. */
@@ -2983,6 +3006,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	synchronize_rcu();
 	mutex_unlock(&module_mutex);
  free_module:
+	mod_stat_add64(info->len, &invalid_mod_bytes);
 	/* Free lock-classes; relies on the preceding sync_rcu() */
 	for_class_mod_mem_type(type, core_data) {
 		lockdep_free_key_range(mod->mem[type].base,
@@ -2991,6 +3015,13 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	module_deallocate(mod, info);
  free_copy:
+	/*
+	 * The info->len is always set. We distinguish between
+	 * failures once the proper module was allocated and
+	 * before that.
+	 */
+	if (!module_allocated)
+		mod_stat_add64(info->len, &invalid_mod_becoming_bytes);
 	free_copy(info, flags);
 	return err;
 }
@@ -3009,8 +3040,10 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 	       umod, len, uargs);
 
 	err = copy_module_from_user(umod, len, &info);
-	if (err)
+	if (err) {
+		mod_stat_inc(&failed_kreads);
 		return err;
+	}
 
 	return load_module(&info, uargs, 0);
 }
@@ -3035,14 +3068,20 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 
 	len = kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
 				       READING_MODULE);
-	if (len < 0)
+	if (len < 0) {
+		mod_stat_inc(&failed_kreads);
+		mod_stat_add64(len, &invalid_kread_bytes);
 		return len;
+	}
 
 	if (flags & MODULE_INIT_COMPRESSED_FILE) {
 		err = module_decompress(&info, buf, len);
 		vfree(buf); /* compressed data is no longer needed */
-		if (err)
+		if (err) {
+			mod_stat_inc(&failed_decompress);
+			mod_stat_add64(len, &invalid_decompress_bytes);
 			return err;
+		}
 	} else {
 		info.hdr = buf;
 		info.len = len;
diff --git a/kernel/module/stats.c b/kernel/module/stats.c
new file mode 100644
index 000000000000..bbf0ddb8b589
--- /dev/null
+++ b/kernel/module/stats.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Let's keep keep tabs on a few important module stats, useful
+ * for debugging production loads and interactions between userspace
+ * and kernelspace for loading modules.
+ *
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/debugfs.h>
+#include <linux/rculist.h>
+
+#include "internal.h"
+
+extern struct dentry *mod_debugfs_root;
+
+/*
+ * Tracks modules which failed to be loaded as they were being processed.
+ * These require modulesed consumed vmalloc space for all finit_module()
+ * calls as kernel_read*() is used. Then if compression is used vmap()
+ * is used to allocate space for the decompressed version of what userspace
+ * has on the filesystem, we vfree() the compressed data which kerne_read*()
+ * fetched for us. Finally, a final module is allocated as well which we
+ * use to keep around, and that *can* use vmalloc() too.
+ *
+ * In the worst case, when module compression is used then we use the vmap
+ * space three times.
+ *
+ * We really should strive to get this list to be empty. This not being empty
+ * is a reflection of us needing to do more work to ensure either the kernel
+ * or usersapce does not do unnecessary calls to load modules which it should
+ * know are already loaded or on its way to be loaded.
+ */
+static LIST_HEAD(failed_modules);
+
+/* Total bytes used by all modules we've dealt with on this system */
+atomic64_t total_mod_size;
+
+/* Total .text section sizes we've dealt with on this system */
+atomic64_t total_text_size;
+
+/* Failures happen on the initial kernel_read_*() call. They use vmalloc() */
+atomic64_t invalid_kread_bytes;
+
+/* Failures happen on the module decompression path, these use use vmap(). */
+atomic64_t invalid_decompress_bytes;
+
+/*
+ * The invalid_mod_becoming_bytes only keeps tabs of failures in between kread
+ * success and right before we allocate the module to process it. These
+ * can be failures due to:
+ *
+ *  o module_sig_check() - module signature checks
+ *  o elf_validity_cache_copy() - ELF does not add up
+ *  o early_mod_check():
+ *  	- blacklist
+ *  	- failed to rewrite section headers
+ *  	- verion magic
+ *  	- live patch requirements didn't check out
+ *  	- the module was detected as being already present, this
+ *  	  first check avoids a new vmalloc for the full size of
+ *  	  the module.
+ */
+atomic64_t invalid_mod_becoming_bytes;
+
+/*
+ * These are failures after we did all the sanity checks of the
+ * module userspace passed to us. This can still fail if we detect
+ * the module is loaded, we do this check after we allocate space
+ * for the module.
+ */
+atomic64_t invalid_mod_bytes;
+
+/* How many modules we've loaded in our kernel life time */
+atomic_t modcount;
+
+/* How many modules failed due to failed kernel_read*() */
+atomic_t failed_kreads;
+
+/* How many failed decompression attempts we've had */
+atomic_t failed_decompress;
+
+/* How many modules failed once we've allocated space for our module */
+atomic_t failed_load_modules;
+
+int try_add_failed_module(const char *name)
+{
+	struct mod_fail_load *mod_fail;
+
+	list_for_each_entry_rcu(mod_fail, &failed_modules, list,
+				lockdep_is_held(&module_mutex)) {
+                if (!strcmp(mod_fail->name, name)) {
+                        atomic_inc(&mod_fail->count);
+                        goto out;
+                }
+        }
+
+	mod_fail = kmalloc(sizeof(*mod_fail), GFP_KERNEL);
+	if (!mod_fail)
+		return -ENOMEM;
+	strscpy(mod_fail->name, name, MODULE_NAME_LEN);
+        atomic_inc(&mod_fail->count);
+        list_add_rcu(&mod_fail->list, &failed_modules);
+out:
+	return 0;
+}
+
+static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct mod_fail_load *mod_fail;
+	unsigned int len;
+	const unsigned int size = 1024;
+	char *buf;
+	u32 live_mod_count, fkreads, floads;
+	u64 total_size, text_size, ikread_bytes, idecomp_bytes, imod_bytes;
+
+	live_mod_count = atomic_read(&modcount);
+	fkreads = atomic_read(&failed_kreads);
+	floads = atomic_read(&failed_load_modules);
+
+	total_size = atomic64_read(&total_mod_size);
+	text_size = atomic64_read(&total_text_size);
+	ikread_bytes = atomic64_read(&invalid_mod_bytes);
+	idecomp_bytes = atomic64_read(&invalid_decompress_bytes);
+	imod_bytes = atomic64_read(&invalid_mod_bytes);
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	len += scnprintf(buf + len, size - len, "%25s\t%u\n", "Modules loaded", live_mod_count);
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Total module size", total_size);
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Total mod text size", text_size);
+
+	/*
+	 * Failed kmod bytes do not contain any failed kreads bytes as those
+	 * failures would happen earlier on kread. Failed kread bytes are wasted
+	 * vmalloc() space allocations and are indicative of invalid modules.
+	 */
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Failed kread bytes", ikread_bytes);
+
+	/*
+	 * Failed kmod bytes are modules which for whatever reason fail to load
+	 * on the load_module() effort. They are good signs the kernel or userspace
+	 * is doing something stupid or that could be improved.
+	 */
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Failed kmod bytes", imod_bytes);
+
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Invalid kread bytes", ikread_bytes);
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Invalid decompress bytes", idecomp_bytes);
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Invalid mod bytes", imod_bytes);
+
+	if (live_mod_count && total_size) {
+		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Average mod size",
+				 DIV_ROUND_UP(total_size, live_mod_count));
+	}
+
+	if (live_mod_count && text_size) {
+		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Average mod text size",
+				 DIV_ROUND_UP(text_size, live_mod_count));
+	}
+
+	if (list_empty(&failed_modules))
+		goto out;
+
+	len += scnprintf(buf + len, size - len, "Failed modules:\n");
+	list_for_each_entry_rcu(mod_fail, &failed_modules, list)
+		len += scnprintf(buf + len, size - len, "%25s\n", mod_fail->name);
+out:
+        return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_mod_stats = {
+	.read = read_file_mod_stats,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static int __init module_stats_init(void)
+{
+	debugfs_create_atomic64_t("total_mod_size", 0400, mod_debugfs_root, &total_mod_size);
+	debugfs_create_atomic64_t("total_text_size", 0400, mod_debugfs_root, &total_text_size);
+	debugfs_create_atomic64_t("invalid_kread_bytes", 0400, mod_debugfs_root, &invalid_kread_bytes);
+	debugfs_create_atomic64_t("invalid_decompress_bytes", 0400, mod_debugfs_root, &invalid_decompress_bytes);
+	debugfs_create_atomic64_t("invalid_mod_bytes", 0400, mod_debugfs_root, &invalid_mod_bytes);
+	debugfs_create_atomic_t("modcount", 0400, mod_debugfs_root, &modcount);
+	debugfs_create_atomic_t("failed_kreads", 0400, mod_debugfs_root, &failed_kreads);
+	debugfs_create_atomic_t("failed_load_modules", 0400, mod_debugfs_root, &failed_load_modules);
+	debugfs_create_file("stats", 0400, mod_debugfs_root, mod_debugfs_root, &fops_mod_stats);
+
+	return 0;
+}
+module_init(module_stats_init);
diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 26d812e07615..cbeb9330db9b 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -15,6 +15,7 @@
 #include "internal.h"
 
 static LIST_HEAD(unloaded_tainted_modules);
+extern struct dentry *mod_debugfs_root
 
 int try_add_tainted_module(struct module *mod)
 {
@@ -120,12 +121,8 @@ static const struct file_operations unloaded_tainted_modules_fops = {
 
 static int __init unloaded_tainted_modules_init(void)
 {
-	struct dentry *dir;
-
-	dir = debugfs_create_dir("modules", NULL);
-	debugfs_create_file("unloaded_tainted", 0444, dir, NULL,
+	debugfs_create_file("unloaded_tainted", 0444, mod_debugfs_root, NULL,
 			    &unloaded_tainted_modules_fops);
-
 	return 0;
 }
 module_init(unloaded_tainted_modules_init);
-- 
2.39.2

