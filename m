Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533AF6E1B77
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDNFJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDNFIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:08:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330174C3C;
        Thu, 13 Apr 2023 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+eH6vPjQnVg0gd9Z+8M2Xml1tMtTa8mkMxVhyAh1QaU=; b=jr62aZ4ZhbxTHeGx+az03Y7Z2H
        mE0FKRh3Wq5AgJ9nNMRgW/t6nicvUARDONfuKcc6hLKYIA2IYnRFSXiT72Ugdzd0payickWrMihpU
        /PYjePjCAWim2gR9dsaLVBAHpDCDk7Mf5rtPISsNwPHs7BGMJQoqOGVW4cxZe1UsM8EzQq6zeBDXT
        cg/KD/t3u3UnsfYCnW5Q3IQF0HFFJQvDI+jaxOCpoUPsPhyJ0A2e8sMiBBu5edLVNE+nzETvlqX0l
        xawVPM6jKWkm+Xd2qbFCHrQlp9vnOH050+y8Ngyr3fa14vwbXZYPIery2MRk+ENqgrQcVxyFWCr1K
        leJuRxPA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnBfp-008KKN-2w;
        Fri, 14 Apr 2023 05:08:37 +0000
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
Subject: [PATCH v3 3/4] module: add debug stats to help identify memory pressure
Date:   Thu, 13 Apr 2023 22:08:35 -0700
Message-Id: <20230414050836.1984746-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414050836.1984746-1-mcgrof@kernel.org>
References: <20230414050836.1984746-1-mcgrof@kernel.org>
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

Loading modules with finit_module() can end up using vmalloc(), vmap()
and vmalloc() again, for a total of up to 3 separate allocations in the
worst case for a single module. We always kernel_read*() the module,
that's a vmalloc(). Then vmap() is used for the module decompression,
and if so the last read buffer is freed as we use the now decompressed
module buffer to stuff data into our copy module. The last allocation is
specific to each architectures but pretty much that's generally a series
of vmalloc() calls or a variation of vmalloc to handle ELF sections with
special permissions.

Evaluation with new stress-ng module support [1] with just 100 ops
is proving that you can end up using GiBs of data easily even with all
care we have in the kernel and userspace today in trying to not load modules
which are already loaded. 100 ops seems to resemble the sort of pressure a
system with about 400 CPUs can create on module loading. Although issues
relating to duplicate module requests due to each CPU inucurring a new
module reuest is silly and some of these are being fixed, we currently lack
proper tooling to help diagnose easily what happened, when it happened
and who likely is to blame -- userspace or kernel module autoloading.

Provide an initial set of stats which use debugfs to let us easily scrape
post-boot information about failed loads. This sort of information can
be used on production worklaods to try to optimize *avoiding* redundant
memory pressure using finit_module().

There's a few examples that can be provided:

A 255 vCPU system without the next patch in this series applied:

Startup finished in 19.143s (kernel) + 7.078s (userspace) = 26.221s
graphical.target reached after 6.988s in userspace

And 13.58 GiB of virtual memory space lost due to failed module loading:

root@big ~ # cat /sys/kernel/debug/modules/stats
         Mods ever loaded       67
     Mods failed on kread       0
Mods failed on decompress       0
  Mods failed on becoming       0
      Mods failed on load       1411
        Total module size       11464704
      Total mod text size       4194304
       Failed kread bytes       0
  Failed decompress bytes       0
    Failed becoming bytes       0
        Failed kmod bytes       14588526272
 Virtual mem wasted bytes       14588526272
         Average mod size       171115
    Average mod text size       62602
  Average fail load bytes       10339140
Duplicate failed modules:
              module-name        How-many-times                    Reason
                kvm_intel                   249                      Load
                      kvm                   249                      Load
                irqbypass                     8                      Load
         crct10dif_pclmul                   128                      Load
      ghash_clmulni_intel                    27                      Load
             sha512_ssse3                    50                      Load
           sha512_generic                   200                      Load
              aesni_intel                   249                      Load
              crypto_simd                    41                      Load
                   cryptd                   131                      Load
                    evdev                     2                      Load
                serio_raw                     1                      Load
               virtio_pci                     3                      Load
                     nvme                     3                      Load
                nvme_core                     3                      Load
    virtio_pci_legacy_dev                     3                      Load
    virtio_pci_modern_dev                     3                      Load
                   t10_pi                     3                      Load
                   virtio                     3                      Load
             crc32_pclmul                     6                      Load
           crc64_rocksoft                     3                      Load
             crc32c_intel                    40                      Load
              virtio_ring                     3                      Load
                    crc64                     3                      Load

The following screen shot, of a simple 8vcpu 8 GiB KVM guest with the
next patch in this series applied, shows 226.53 MiB are wasted in virtual
memory allocations which due to duplicate module requests during boot.
It also shows an average module memory size of 167.10 KiB and an an
average module .text + .init.text size of 61.13 KiB. The end shows all
modules which were detected as duplicate requests and whether or not
they failed early after just the first kernel_read*() call or late after
we've already allocated the private space for the module in
layout_and_allocate(). A system with module decompression would reveal
more wasted virtual memory space.

We should put effort now into identifying the source of these duplicate
module requests and trimming these down as much possible. Larger systems
will obviously show much more wasted virtual memory allocations.

root@kmod ~ # cat /sys/kernel/debug/modules/stats
         Mods ever loaded       67
     Mods failed on kread       0
Mods failed on decompress       0
  Mods failed on becoming       83
      Mods failed on load       16
        Total module size       11464704
      Total mod text size       4194304
       Failed kread bytes       0
  Failed decompress bytes       0
    Failed becoming bytes       228959096
        Failed kmod bytes       8578080
 Virtual mem wasted bytes       237537176
         Average mod size       171115
    Average mod text size       62602
  Avg fail becoming bytes       2758544
  Average fail load bytes       536130
Duplicate failed modules:
              module-name        How-many-times                    Reason
                kvm_intel                     7                  Becoming
                      kvm                     7                  Becoming
                irqbypass                     6           Becoming & Load
         crct10dif_pclmul                     7           Becoming & Load
      ghash_clmulni_intel                     7           Becoming & Load
             sha512_ssse3                     6           Becoming & Load
           sha512_generic                     7           Becoming & Load
              aesni_intel                     7                  Becoming
              crypto_simd                     7           Becoming & Load
                   cryptd                     3           Becoming & Load
                    evdev                     1                  Becoming
                serio_raw                     1                  Becoming
                     nvme                     3                  Becoming
                nvme_core                     3                  Becoming
                   t10_pi                     3                  Becoming
               virtio_pci                     3                  Becoming
             crc32_pclmul                     6           Becoming & Load
           crc64_rocksoft                     3                  Becoming
             crc32c_intel                     3                  Becoming
    virtio_pci_modern_dev                     2                  Becoming
    virtio_pci_legacy_dev                     1                  Becoming
                    crc64                     2                  Becoming
                   virtio                     2                  Becoming
              virtio_ring                     2                  Becoming

[0] https://github.com/ColinIanKing/stress-ng.git
[1] echo 0 > /proc/sys/vm/oom_dump_tasks
    ./stress-ng --module 100 --module-name xfs

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Documentation/core-api/kernel-api.rst |  22 +-
 kernel/module/Kconfig                 |  37 +++
 kernel/module/Makefile                |   1 +
 kernel/module/decompress.c            |   4 +
 kernel/module/internal.h              |  74 +++++
 kernel/module/main.c                  |  65 +++-
 kernel/module/stats.c                 | 432 ++++++++++++++++++++++++++
 kernel/module/tracking.c              |   7 +-
 8 files changed, 630 insertions(+), 12 deletions(-)
 create mode 100644 kernel/module/stats.c

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index e27728596008..9b3f3e5f5a95 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -220,12 +220,30 @@ relay interface
 Module Support
 ==============
 
-Module Loading
---------------
+Kernel module auto-loading
+--------------------------
 
 .. kernel-doc:: kernel/module/kmod.c
    :export:
 
+Module debugging
+----------------
+
+.. kernel-doc:: kernel/module/stats.c
+   :doc: module debugging statistics overview
+
+dup_failed_modules - tracks duplicate failed modules
+****************************************************
+
+.. kernel-doc:: kernel/module/stats.c
+   :doc: dup_failed_modules - tracks duplicate failed modules
+
+module statistics debugfs counters
+**********************************
+
+.. kernel-doc:: kernel/module/stats.c
+   :doc: module statistics debugfs counters
+
 Inter Module support
 --------------------
 
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 424b3bc58f3f..ca277b945a67 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -22,6 +22,43 @@ menuconfig MODULES
 
 if MODULES
 
+config MODULE_DEBUG
+	bool "Module debugging"
+	depends on DEBUG_FS
+	help
+	  Allows you to enable / disable features which can help you debug
+	  modules. You don't need these options in produciton systems. You can
+	  and probably should enable this prior to making your kernel
+	  produciton ready though.
+
+if MODULE_DEBUG
+
+config MODULE_STATS
+	bool "Module statistics"
+	depends on DEBUG_FS
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
+	  This functionality is also useful for those experimenting with
+	  module .text ELF section optimization.
+
+	  If unsure, say N.
+
+endif # MODULE_DEBUG
+
 config MODULE_FORCE_LOAD
 	bool "Forced module loading"
 	default n
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 5b1d26b53b8d..52340bce497e 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_SYSFS) += sysfs.o
 obj-$(CONFIG_KGDB_KDB) += kdb.o
 obj-$(CONFIG_MODVERSIONS) += version.o
 obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
+obj-$(CONFIG_MODULE_STATS) += stats.o
diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 7ddc87bee274..e97232b125eb 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -297,6 +297,10 @@ int module_decompress(struct load_info *info, const void *buf, size_t size)
 	ssize_t data_size;
 	int error;
 
+#if defined(CONFIG_MODULE_STATS)
+	info->compressed_len = size;
+#endif
+
 	/*
 	 * Start with number of pages twice as big as needed for
 	 * compressed data.
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 6ae29bb8836f..9d97a59a9127 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -59,6 +59,9 @@ struct load_info {
 	unsigned long mod_kallsyms_init_off;
 #endif
 #ifdef CONFIG_MODULE_DECOMPRESS
+#ifdef CONFIG_MODULE_STATS
+	unsigned long compressed_len;
+#endif
 	struct page **pages;
 	unsigned int max_pages;
 	unsigned int used_pages;
@@ -143,6 +146,77 @@ static inline bool set_livepatch_module(struct module *mod)
 #endif
 }
 
+/**
+ * enum fail_dup_mod_reason - state at which a duplicate module was detected
+ *
+ * @FAIL_DUP_MOD_BECOMING: the module is read properly, passes all checks but
+ * 	we've determined that another module with the same name is already loaded
+ * 	or being processed on our &modules list. This happens on early_mod_check()
+ * 	right before layout_and_allocate(). The kernel would have already
+ * 	vmalloc()'d space for the entire module through finit_module(). If
+ * 	decompression was used two vmap() spaces were used. These failures can
+ * 	happen when userspace has not seen the module present on the kernel and
+ * 	tries to load the module multiple times at same time.
+ * @FAIL_DUP_MOD_LOAD: the module has been read properly, passes all validation
+ *	checks and the kernel determines that the module was unique and because
+ *	of this allocated yet another private kernel copy of the module space in
+ *	layout_and_allocate() but after this determined in add_unformed_module()
+ *	that another module with the same name is already loaded or being processed.
+ *	These failures should be mitigated as much as possible and are indicative
+ *	of really fast races in loading modules. Without module decompression
+ *	they waste twice as much vmap space. With module decompression three
+ *	times the module's size vmap space is wasted.
+ */
+enum fail_dup_mod_reason {
+	FAIL_DUP_MOD_BECOMING = 0,
+	FAIL_DUP_MOD_LOAD,
+};
+
+#ifdef CONFIG_MODULE_STATS
+
+#define mod_stat_add_long(count, var) atomic_long_add(count, var)
+#define mod_stat_inc(name) atomic_inc(name)
+
+extern atomic_long_t total_mod_size;
+extern atomic_long_t total_text_size;
+extern atomic_long_t invalid_kread_bytes;
+extern atomic_long_t invalid_decompress_bytes;
+
+extern atomic_t modcount;
+extern atomic_t failed_kreads;
+extern atomic_t failed_decompress;
+struct mod_fail_load {
+	struct list_head list;
+	char name[MODULE_NAME_LEN];
+	atomic_long_t count;
+	unsigned long dup_fail_mask;
+};
+
+int try_add_failed_module(const char *name, size_t len, enum fail_dup_mod_reason reason);
+void mod_stat_bump_invalid(struct load_info *info, int flags);
+void mod_stat_bump_becoming(struct load_info *info, int flags);
+
+#else
+
+#define mod_stat_add_long(name, var)
+#define mod_stat_inc(name)
+
+static inline int try_add_failed_module(const char *name, size_t len,
+					enum fail_dup_mod_reason reason)
+{
+	return 0;
+}
+
+static inline void mod_stat_bump_invalid(struct load_info *info, int flags)
+{
+}
+
+static inline void mod_stat_bump_becoming(struct load_info *info, int flags)
+{
+}
+
+#endif /* CONFIG_MODULE_STATS */
+
 #ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
 struct mod_unload_taint {
 	struct list_head list;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 75b23257128d..5642d77657a0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -56,6 +56,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
 #include <linux/cfi.h>
+#include <linux/debugfs.h>
 #include <uapi/linux/module.h>
 #include "internal.h"
 
@@ -87,6 +88,8 @@ struct symsearch {
 	enum mod_license license;
 };
 
+struct dentry *mod_debugfs_root;
+
 /*
  * Bounds of module memory, for speeding up __module_address.
  * Protected by module_mutex.
@@ -2500,6 +2503,18 @@ static noinline int do_init_module(struct module *mod)
 {
 	int ret = 0;
 	struct mod_initfree *freeinit;
+#if defined(CONFIG_MODULE_STATS)
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
+#endif
 
 	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
 	if (!freeinit) {
@@ -2561,6 +2576,7 @@ static noinline int do_init_module(struct module *mod)
 		mod->mem[type].base = NULL;
 		mod->mem[type].size = 0;
 	}
+
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointer */
 	mod->btf_data = NULL;
@@ -2584,6 +2600,11 @@ static noinline int do_init_module(struct module *mod)
 	mutex_unlock(&module_mutex);
 	wake_up_all(&module_wq);
 
+	mod_stat_add_long(text_size, &total_text_size);
+	mod_stat_add_long(total_size, &total_mod_size);
+
+	mod_stat_inc(&modcount);
+
 	return 0;
 
 fail_free_freeinit:
@@ -2599,6 +2620,7 @@ static noinline int do_init_module(struct module *mod)
 	ftrace_release_mod(mod);
 	free_module(mod);
 	wake_up_all(&module_wq);
+
 	return ret;
 }
 
@@ -2632,7 +2654,8 @@ static bool finished_loading(const char *name)
 }
 
 /* Must be called with module_mutex held */
-static int module_patient_check_exists(const char *name)
+static int module_patient_check_exists(const char *name,
+				       enum fail_dup_mod_reason reason)
 {
 	struct module *old;
 	int err = 0;
@@ -2655,6 +2678,9 @@ static int module_patient_check_exists(const char *name)
 		old = find_module_all(name, strlen(name), true);
 	}
 
+	if (try_add_failed_module(name, strlen(name), reason))
+		pr_warn("Could not add fail-tracking for module: %s\n", name);
+
 	/*
 	 * We are here only when the same module was being loaded. Do
 	 * not try to load it again right now. It prevents long delays
@@ -2679,7 +2705,7 @@ static int add_unformed_module(struct module *mod)
 	mod->state = MODULE_STATE_UNFORMED;
 
 	mutex_lock(&module_mutex);
-	err = module_patient_check_exists(mod->name);
+	err = module_patient_check_exists(mod->name, FAIL_DUP_MOD_LOAD);
 	if (err)
 		goto out;
 
@@ -2800,6 +2826,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		       int flags)
 {
 	struct module *mod;
+	bool module_allocated = false;
 	long err = 0;
 	char *after_dashes;
 
@@ -2839,6 +2866,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		goto free_copy;
 	}
 
+	module_allocated = true;
+
 	audit_log_kern_module(mod->name);
 
 	/* Reserve our place in the list. */
@@ -2983,6 +3012,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	synchronize_rcu();
 	mutex_unlock(&module_mutex);
  free_module:
+	mod_stat_bump_invalid(info, flags);
 	/* Free lock-classes; relies on the preceding sync_rcu() */
 	for_class_mod_mem_type(type, core_data) {
 		lockdep_free_key_range(mod->mem[type].base,
@@ -2991,6 +3021,13 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	module_deallocate(mod, info);
  free_copy:
+	/*
+	 * The info->len is always set. We distinguish between
+	 * failures once the proper module was allocated and
+	 * before that.
+	 */
+	if (!module_allocated)
+		mod_stat_bump_becoming(info, flags);
 	free_copy(info, flags);
 	return err;
 }
@@ -3009,8 +3046,11 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 	       umod, len, uargs);
 
 	err = copy_module_from_user(umod, len, &info);
-	if (err)
+	if (err) {
+		mod_stat_inc(&failed_kreads);
+		mod_stat_add_long(len, &invalid_kread_bytes);
 		return err;
+	}
 
 	return load_module(&info, uargs, 0);
 }
@@ -3035,14 +3075,20 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 
 	len = kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
 				       READING_MODULE);
-	if (len < 0)
+	if (len < 0) {
+		mod_stat_inc(&failed_kreads);
+		mod_stat_add_long(len, &invalid_kread_bytes);
 		return len;
+	}
 
 	if (flags & MODULE_INIT_COMPRESSED_FILE) {
 		err = module_decompress(&info, buf, len);
 		vfree(buf); /* compressed data is no longer needed */
-		if (err)
+		if (err) {
+			mod_stat_inc(&failed_decompress);
+			mod_stat_add_long(len, &invalid_decompress_bytes);
 			return err;
+		}
 	} else {
 		info.hdr = buf;
 		info.len = len;
@@ -3216,3 +3262,12 @@ void print_modules(void)
 			last_unloaded_module.taints);
 	pr_cont("\n");
 }
+
+#ifdef CONFIG_MODULE_DEBUG
+static int module_debugfs_init(void)
+{
+	mod_debugfs_root = debugfs_create_dir("modules", NULL);
+	return 0;
+}
+module_init(module_debugfs_init);
+#endif
diff --git a/kernel/module/stats.c b/kernel/module/stats.c
new file mode 100644
index 000000000000..d4b5b2b9e6ad
--- /dev/null
+++ b/kernel/module/stats.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Debugging module statistics.
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
+#include <linux/math.h>
+
+#include "internal.h"
+
+/**
+ * DOC: module debugging statistics overview
+ *
+ * Enabling CONFIG_MODULE_STATS enables module debugging statistics which
+ * are useful to monitor and root cause memory pressure issues with module
+ * loading. These statistics are useful to allow us to improve production
+ * workloads.
+ *
+ * The current module debugging statistics supported help keep track of module
+ * loading failures to enable improvements either for kernel module
+ * auto-loading usage (request_module()) or interactions with userspace.
+ * Statistics are provided to track of all possible failures in the
+ * finit_module() path and memory wasted in this process space.  Each of the
+ * failure counters are associated to a type of module loading failure which
+ * is known to incur a certain amount of memory allocation loss. In the worst
+ * case loading a module will fail after a 3 step memory allocation process:
+ *
+ *   a) memory allocated with kernel_read_file_from_fd()
+ *   b) module decompression processes the file read from
+ *      kernel_read_file_from_fd(), and vmap() is used to map
+ *      the decompressed module to a new local buffer which represents
+ *      a copy of the decompressed module passed from userspace. The buffer
+ *      from kernel_read_file_from_fd() is freed right away.
+ *   c) layout_and_allocate() allocates space for the final resting
+ *      place where we would keep the module if it were to be processed
+ *      successfully.
+ *
+ * If a failure occurs after these three different allocations only one
+ * counters will be incremetned with the summation of the lost bytes incurred
+ * during this failure. Likewise, if a module loading failed only after step b)
+ * a separate counter is used and incremented for the bytes lost during both
+ * of those allocations.
+ *
+ * Virtual memory space can be limited, for example on x86 virtual memory size
+ * defaults to 128 MiB. We should strive to limit and avoid wasting virtual
+ * memory allocations when possible. These module dubugging statistics help
+ * to evaluate how much memory is being wasted on bootup due to module loading
+ * failures.
+ *
+ * All counters are designed to be incremental. Atomic counters are used so to
+ * remain simple and avoid delays and deadlocks.
+ */
+
+extern struct dentry *mod_debugfs_root;
+
+/**
+ * DOC: dup_failed_modules - tracks duplicate failed modules
+ *
+ * Linked list of modules which failed to be loaded because an already existing
+ * module with the same name was already being processed or already loaded.
+ * The finit_module() system call incurs heavy virtual memory allocations. In
+ * the worst case an finit_module() system call can end up allocating virtual
+ * memory 3 times:
+ *
+ *   1) kernel_read_file_from_fd() call uses vmalloc()
+ *   2) optional module decompression uses vmap()
+ *   3) layout_and allocate() can use vzalloc() or an arch specific variation of
+ *      vmalloc to deal with ELF sections requiring special permissions
+ *
+ * In practice on a typical boot today most finit_module() calls fail due to
+ * the module with the same name already being loaded or about to be processed.
+ * All virtual memory allocated to these failed modules will be lost with
+ * no functional use.
+ *
+ * To help with this the dup_failed_modules allows us to track modules which
+ * failed to load due to the fact that a module already was loaded or being
+ * processed already.  There are only two points at which we can fail such
+ * calls, we list them below along with the number of virtual memory allocation
+ * calls:
+ *
+ *   a) FAIL_DUP_MOD_BECOMING: at the end of early_mod_check() before
+ *	layout_and_allocate(). This does not yet happen.
+ *	- with module decompression: 2 virtual memory allocation calls
+ *	- without module decompression: 1 virtual memory allocation calls
+ *   b) FAIL_DUP_MOD_LOAD: after layout_and_allocate() on add_unformed_module()
+ *   	- with module decompression 3 virtual memory allocation calls
+ *   	- without module decompression 2 virtual memory allocation calls
+ *
+ * We should strive to get this list to be as small as possible. If this list
+ * is not empty it is a reflection of possible work or optimizations possible
+ * either in-kernel or in userspace.
+ */
+static LIST_HEAD(dup_failed_modules);
+
+/**
+ * DOC: module statistics debugfs counters
+ *
+ * The total amount of wasted virtual memory allocation space during module
+ * loading can be computed by adding the total from the summation:
+ *
+ *   * @invalid_kread_bytes +
+ *     @invalid_decompress_bytes +
+ *     @invalid_becoming_bytes +
+ *     @invalid_mod_bytes
+ *
+ * The following debugfs counters are available to inspect module loading
+ * failures:
+ *
+ *   * total_mod_size: total bytes ever used by all modules we've dealt with on
+ *     this system
+ *   * total_text_size: total bytes of the .text and .init.text ELF section
+ *     sizes we've dealt with on this system
+ *   * invalid_kread_bytes: bytes wasted in failures which happen due to
+ *     memory allocations with the initial kernel_read_file_from_fd().
+ *     kernel_read_file_from_fd() uses vmalloc() and so these are wasted
+ *     vmalloc() memory allocations. These should typically not happen unless
+ *     your system is under memory pressure.
+ *   * invalid_decompress_bytes: number of bytes wasted due to
+ *     memory allocations in the module decompression path that use vmap().
+ *     These typically should not happen unless your system is under memory
+ *     presssure.
+ *   * invalid_becoming_bytes: total number of bytes wasted due to
+ *     allocations used to read the kernel module userspace wants us to read
+ *     before we promote it to be processed to be added to our @modules linked
+ *     list. These failures could in theory happen in if we had a check in between
+ *     between a successful kernel_read_file_from_fd() call and right before
+ *     we allocate the our private memory for the module which would be kept if
+ *     the module is successfully loaded. The most common reason for this failure
+ *     is when userspace is racing to load a module which it does not yet see
+ *     loaded. The first module to succeed in add_unformed_module() will add a
+ *     module to our &modules list and subsequent loads of modules with the
+ *     same name will error out at the end of early_mod_check(). A check
+ *     for module_patient_check_exists() at the end of early_mod_check() could be
+ *     added to prevent duplicate allocations on layout_and_allocate() for
+ *     modules already being processed. These duplicate failed modules are
+ *     non-fatal, however they typically are indicative of userspace not seeing
+ *     a module in userspace loaded yet and unecessarily trying to load a
+ *     module before the kernel even has a chance to begin to process prior
+ *     requests. Although duplicate failures can be non-fatal, we should try to
+ *     reduce vmalloc() pressure proactively, so ideally after boot this will
+ *     be close to as 0 as possible.  If module decompression was used we also
+ *     add to this counter the cost of the initial kernel_read_file_from_fd()
+ *     of the compressed module. If module decompression was not used the
+ *     value represents the total wasted allocations in kernel_read_file_from_fd()
+ *     calls for these type of failures. These failures can occur because:
+ *
+ *    * module_sig_check() - module signature checks
+ *    * elf_validity_cache_copy() - some ELF validation issue
+ *    * early_mod_check():
+ *
+ *      * blacklisting
+ *      * failed to rewrite section headers
+ *      * version magic
+ *      * live patch requirements didn't check out
+ *      * the module was detected as being already present
+ *
+ *   * invalid_mod_bytes: these are the total number of bytes lost due to
+ *     failures after we did all the sanity checks of the module which userspace
+ *     passed to us and after our first check that the module is unique.  A
+ *     module can still fail to load if we detect the module is loaded after we
+ *     allocate space for it with layout_and_allocate(), we do this check right
+ *     before processing the module as live and run its initialiation routines.
+ *     Note that you have a failure of this type it also means the respective
+ *     kernel_read_file_from_fd() memory space was also wasted, and so we
+ *     increment this counter with twice the size of the module. Additionally
+ *     if you used module decompression the size of the compressed module is
+ *     also added to this counter.
+ *
+ *  * modcount: how many modules we've loaded in our kernel life time
+ *  * failed_kreads: how many modules failed due to failed kernel_read_file_from_fd()
+ *  * failed_decompress: how many failed module decompression attempts we've had.
+ *    These really should not happen unless your compression / decompression
+ *    might be broken.
+ *  * failed_becoming: how many modules failed after we kernel_read_file_from_fd()
+ *    it and before we allocate memory for it with layout_and_allocate(). This
+ *    counter is never incremented if you manage to validate the module and
+ *    call layout_and_allocate() for it.
+ *  * failed_load_modules: how many modules failed once we've allocated our
+ *    private space for our module using layout_and_allocate(). These failures
+ *    should hopefully mostly be dealt with already. Races in theory could
+ *    still exist here, but it would just mean the kernel had started processing
+ *    two threads concurrently up to early_mod_check() and then one just one
+ *    thread won. These failures are good signs the kernel or userspace is
+ *    doing something seriously stupid or that could be improved. We should
+ *    strive to fix these, but it is perhaps not easy to fix them.
+ *    A recent example are the modules requests incurred for frequency modules,
+ *    a separate module request was being issued for each CPU on a system.
+ */
+
+atomic_long_t total_mod_size;
+atomic_long_t total_text_size;
+atomic_long_t invalid_kread_bytes;
+atomic_long_t invalid_decompress_bytes;
+static atomic_long_t invalid_becoming_bytes;
+static atomic_long_t invalid_mod_bytes;
+atomic_t modcount;
+atomic_t failed_kreads;
+atomic_t failed_decompress;
+static atomic_t failed_becoming;
+static atomic_t failed_load_modules;
+
+static const char *mod_fail_to_str(struct mod_fail_load *mod_fail)
+{
+	if (test_bit(FAIL_DUP_MOD_BECOMING, &mod_fail->dup_fail_mask) &&
+	    test_bit(FAIL_DUP_MOD_LOAD, &mod_fail->dup_fail_mask))
+		return "Becoming & Load";
+	if (test_bit(FAIL_DUP_MOD_BECOMING, &mod_fail->dup_fail_mask))
+		return "Becoming";
+	if (test_bit(FAIL_DUP_MOD_LOAD, &mod_fail->dup_fail_mask))
+		return "Load";
+	return "Bug-on-stats";
+}
+
+void mod_stat_bump_invalid(struct load_info *info, int flags)
+{
+	atomic_long_add(info->len * 2, &invalid_mod_bytes);
+	atomic_inc(&failed_load_modules);
+#if defined(CONFIG_MODULE_DECOMPRESS)
+	if (flags & MODULE_INIT_COMPRESSED_FILE)
+		atomic_long_add(info->compressed_len, &invalid_mod_byte);
+#endif
+}
+
+void mod_stat_bump_becoming(struct load_info *info, int flags)
+{
+	atomic_inc(&failed_becoming);
+	atomic_long_add(info->len, &invalid_becoming_bytes);
+#if defined(CONFIG_MODULE_DECOMPRESS)
+	if (flags & MODULE_INIT_COMPRESSED_FILE)
+		atomic_long_add(info->compressed_len, &invalid_becoming_bytes);
+#endif
+}
+
+int try_add_failed_module(const char *name, size_t len, enum fail_dup_mod_reason reason)
+{
+	struct mod_fail_load *mod_fail;
+
+	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list,
+				lockdep_is_held(&module_mutex)) {
+		if (strlen(mod_fail->name) == len && !memcmp(mod_fail->name, name, len)) {
+                        atomic_long_inc(&mod_fail->count);
+			__set_bit(reason, &mod_fail->dup_fail_mask);
+                        goto out;
+                }
+        }
+
+	mod_fail = kzalloc(sizeof(*mod_fail), GFP_KERNEL);
+	if (!mod_fail)
+		return -ENOMEM;
+	memcpy(mod_fail->name, name, len);
+	__set_bit(reason, &mod_fail->dup_fail_mask);
+        atomic_long_inc(&mod_fail->count);
+        list_add_rcu(&mod_fail->list, &dup_failed_modules);
+out:
+	return 0;
+}
+
+/*
+ * At 64 bytes per module and assuming a 1024 bytes preamble we can fit the
+ * 112 module prints within 8k.
+ *
+ * 1024 + (64*112) = 8k
+ */
+#define MAX_PREAMBLE 1024
+#define MAX_FAILED_MOD_PRINT 112
+#define MAX_BYTES_PER_MOD 64
+static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct mod_fail_load *mod_fail;
+	unsigned int len, size, count_failed = 0;
+	char *buf;
+	u32 live_mod_count, fkreads, fdecompress, fbecoming, floads;
+	u64 total_size, text_size, ikread_bytes, ibecoming_bytes, idecompress_bytes, imod_bytes,
+	    total_virtual_lost;
+
+	live_mod_count = atomic_read(&modcount);
+	fkreads = atomic_read(&failed_kreads);
+	fdecompress = atomic_read(&failed_decompress);
+	fbecoming = atomic_read(&failed_becoming);
+	floads = atomic_read(&failed_load_modules);
+
+	total_size = atomic64_read(&total_mod_size);
+	text_size = atomic64_read(&total_text_size);
+	ikread_bytes = atomic64_read(&invalid_kread_bytes);
+	idecompress_bytes = atomic64_read(&invalid_decompress_bytes);
+	ibecoming_bytes = atomic64_read(&invalid_becoming_bytes);
+	imod_bytes = atomic64_read(&invalid_mod_bytes);
+
+	total_virtual_lost = ikread_bytes + idecompress_bytes + ibecoming_bytes + imod_bytes;
+
+	size = MAX_PREAMBLE + min((unsigned int)(floads + fbecoming) * MAX_BYTES_PER_MOD,
+			  (unsigned int) MAX_FAILED_MOD_PRINT * MAX_BYTES_PER_MOD);
+	buf = kzalloc(size, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	/* The beginning of our debug preamble */
+	len = scnprintf(buf + 0, size - len, "%25s\t%u\n", "Mods ever loaded", live_mod_count);
+
+	len += scnprintf(buf + len, size - len, "%25s\t%u\n", "Mods failed on kread", fkreads);
+
+	len += scnprintf(buf + len, size - len, "%25s\t%u\n", "Mods failed on decompress",
+			 fdecompress);
+	len += scnprintf(buf + len, size - len, "%25s\t%u\n", "Mods failed on becoming", fbecoming);
+
+	len += scnprintf(buf + len, size - len, "%25s\t%u\n", "Mods failed on load", floads);
+
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Total module size", total_size);
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Total mod text size", text_size);
+
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Failed kread bytes", ikread_bytes);
+
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Failed decompress bytes",
+			 idecompress_bytes);
+
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Failed becoming bytes", ibecoming_bytes);
+
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Failed kmod bytes", imod_bytes);
+
+	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Virtual mem wasted bytes", total_virtual_lost);
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
+	/*
+	 * We use WARN_ON_ONCE() for the counters to ensure we always have parity
+	 * for keeping tabs on a type of failure with one type of byte counter.
+	 * The counters for imod_bytes does not increase for fkreads failures
+	 * for example, and so on.
+	 */
+
+	WARN_ON_ONCE(ikread_bytes && !fkreads);
+	if (fkreads && ikread_bytes) {
+		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Avg fail kread bytes",
+				 DIV_ROUND_UP(ikread_bytes, fkreads));
+	}
+
+	WARN_ON_ONCE(ibecoming_bytes && !fbecoming);
+	if (fbecoming && ibecoming_bytes) {
+		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Avg fail becoming bytes",
+				 DIV_ROUND_UP(ibecoming_bytes, fbecoming));
+	}
+
+	WARN_ON_ONCE(idecompress_bytes && !fdecompress);
+	if (fdecompress && idecompress_bytes) {
+		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Avg fail decomp bytes",
+				 DIV_ROUND_UP(idecompress_bytes, fdecompress));
+	}
+
+	WARN_ON_ONCE(imod_bytes && !floads);
+	if (floads && imod_bytes) {
+		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Average fail load bytes",
+				 DIV_ROUND_UP(imod_bytes, floads));
+	}
+
+	/* End of our debug preamble header. */
+
+	/* Catch when we've gone beyond our expected preamble */
+	WARN_ON_ONCE(len >= MAX_PREAMBLE);
+
+	if (list_empty(&dup_failed_modules))
+		goto out;
+
+	len += scnprintf(buf + len, size - len, "Duplicate failed modules:\n");
+	len += scnprintf(buf + len, size - len, "%25s\t%15s\t%25s\n",
+			 "module-name", "How-many-times", "Reason");
+	mutex_lock(&module_mutex);
+
+
+	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list) {
+		if (WARN_ON_ONCE(++count_failed >= MAX_FAILED_MOD_PRINT))
+			goto out_unlock;
+		len += scnprintf(buf + len, size - len, "%25s\t%15llu\t%25s\n", mod_fail->name,
+				 atomic64_read(&mod_fail->count), mod_fail_to_str(mod_fail));
+	}
+out_unlock:
+	mutex_unlock(&module_mutex);
+out:
+	kfree(buf);
+        return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+#undef MAX_PREAMBLE
+#undef MAX_FAILED_MOD_PRINT
+#undef MAX_BYTES_PER_MOD
+
+static const struct file_operations fops_mod_stats = {
+	.read = read_file_mod_stats,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+#define mod_debug_add_ulong(name) debugfs_create_ulong(#name, 0400, mod_debugfs_root, (unsigned long *) &name.counter)
+#define mod_debug_add_atomic(name) debugfs_create_atomic_t(#name, 0400, mod_debugfs_root, &name)
+static int __init module_stats_init(void)
+{
+	mod_debug_add_ulong(total_mod_size);
+	mod_debug_add_ulong(total_text_size);
+	mod_debug_add_ulong(invalid_kread_bytes);
+	mod_debug_add_ulong(invalid_decompress_bytes);
+	mod_debug_add_ulong(invalid_becoming_bytes);
+	mod_debug_add_ulong(invalid_mod_bytes);
+
+	mod_debug_add_atomic(modcount);
+	mod_debug_add_atomic(failed_kreads);
+	mod_debug_add_atomic(failed_decompress);
+	mod_debug_add_atomic(failed_becoming);
+	mod_debug_add_atomic(failed_load_modules);
+
+	debugfs_create_file("stats", 0400, mod_debugfs_root, mod_debugfs_root, &fops_mod_stats);
+
+	return 0;
+}
+#undef mod_debug_add_ulong
+#undef mod_debug_add_atomic
+module_init(module_stats_init);
diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 26d812e07615..16742d1c630c 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -15,6 +15,7 @@
 #include "internal.h"
 
 static LIST_HEAD(unloaded_tainted_modules);
+extern struct dentry *mod_debugfs_root;
 
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

