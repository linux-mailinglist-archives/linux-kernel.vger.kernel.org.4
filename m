Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BDD711F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 07:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbjEZFQV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 May 2023 01:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbjEZFQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 01:16:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159B613A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:10 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PKnuf5003992
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:09 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qt9b0nga9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:09 -0700
Received: from twshared18891.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 22:16:07 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id BA3F71E38AFE9; Thu, 25 May 2023 22:15:54 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <mcgrof@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <x86@kernel.org>, <rppt@kernel.org>,
        <kent.overstreet@linux.dev>, Song Liu <song@kernel.org>
Subject: [PATCH 1/3] module: Introduce module_alloc_type
Date:   Thu, 25 May 2023 22:15:27 -0700
Message-ID: <20230526051529.3387103-2-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526051529.3387103-1-song@kernel.org>
References: <20230526051529.3387103-1-song@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Xauevc-EQTB4uXVaGAgjB-d8L7uMEkAj
X-Proofpoint-GUID: Xauevc-EQTB4uXVaGAgjB-d8L7uMEkAj
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce memory type aware module_alloc_type, which provides a unified
allocator for all different archs. This work was discussed in [1].

Each arch can configure the allocator to do the following:

   1. Specify module_vaddr and module_end
   2. Random module start address for KASLR
   3. kasan_alloc_module_shadow()
   4. kasan_reset_tag()
   5. Preferred and secondary module address ranges

enum mod_alloc_params_flags are used to control the behavior of
module_alloc_type. Specifically: MOD_ALLOC_FALLBACK let module_alloc_type
fallback to existing module_alloc. MOD_ALLOC_SET_MEMORY let
module_alloc_type to protect the memory before returning to the user.

module_allocator_init() call is added to start_kernel() to initialize
module_alloc_type.

Signed-off-by: Song Liu <song@kernel.org>

[1] https://lore.kernel.org/linux-mm/20221107223921.3451913-1-song@kernel.org/
---
 include/linux/module.h       |   6 +
 include/linux/moduleloader.h |  75 ++++++++++++
 init/main.c                  |   1 +
 kernel/bpf/bpf_struct_ops.c  |  10 +-
 kernel/bpf/core.c            |  20 ++--
 kernel/bpf/trampoline.c      |   6 +-
 kernel/kprobes.c             |   6 +-
 kernel/module/internal.h     |   3 +
 kernel/module/main.c         | 217 +++++++++++++++++++++++++++++++++--
 kernel/module/strict_rwx.c   |   4 +
 10 files changed, 319 insertions(+), 29 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 9e56763dff81..948b8132a742 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -752,6 +752,8 @@ static inline bool is_livepatch_module(struct module *mod)
 
 void set_module_sig_enforced(void);
 
+void __init module_allocator_init(void);
+
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -855,6 +857,10 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 	return ptr;
 }
 
+static inline void __init module_allocator_init(void)
+{
+}
+
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 03be088fb439..59c7114a7b65 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -32,6 +32,81 @@ void *module_alloc(unsigned long size);
 /* Free memory returned from module_alloc. */
 void module_memfree(void *module_region);
 
+#ifdef CONFIG_MODULES
+
+/* For mod_alloc_params.flags */
+enum mod_alloc_params_flags {
+	MOD_ALLOC_FALLBACK		= (1 << 0),	/* Fallback to module_alloc() */
+	MOD_ALLOC_KASAN_MODULE_SHADOW	= (1 << 1),	/* Calls kasan_alloc_module_shadow() */
+	MOD_ALLOC_KASAN_RESET_TAG	= (1 << 2),	/* Calls kasan_reset_tag() */
+	MOD_ALLOC_SET_MEMORY		= (1 << 3),	/* The allocator calls set_memory_ on
+							 * memory before returning it to the
+							 * caller, so that the caller do not need
+							 * to call set_memory_* again. This does
+							 * not work for MOD_RO_AFTER_INIT.
+							 */
+};
+
+#define MOD_MAX_ADDR_SPACES 2
+
+/**
+ * struct vmalloc_params - Parameters to call __vmalloc_node_range()
+ * @start:          Address space range start
+ * @end:            Address space range end
+ * @gfp_mask:       The gfp_t mask used for this range
+ * @pgprot:         The page protection for this range
+ * @vm_flags        The vm_flag used for this range
+ */
+struct vmalloc_params {
+	unsigned long	start;
+	unsigned long	end;
+	gfp_t		gfp_mask;
+	pgprot_t	pgprot;
+	unsigned long	vm_flags;
+};
+
+/**
+ * struct mod_alloc_params - Parameters for module allocation type
+ * @flags:          Properties in mod_alloc_params_flags
+ * @granularity:    The allocation granularity (PAGE/PMD) in bytes
+ * @alignment:      The allocation alignment requirement
+ * @vmp:            Parameters used to call vmalloc
+ * @fill:           Function to fill allocated space. If NULL, use memcpy()
+ * @invalidate:     Function to invalidate memory space.
+ *
+ * If @granularity > @alignment the allocation can reuse free space in
+ * previously allocated pages. If they are the same, then fresh pages
+ * have to be allocated.
+ */
+struct mod_alloc_params {
+	unsigned int		flags;
+	unsigned int		granularity;
+	unsigned int		alignment;
+	struct vmalloc_params	vmp[MOD_MAX_ADDR_SPACES];
+	void *			(*fill)(void *dst, const void *src, size_t len);
+	void *			(*invalidate)(void *ptr, size_t len);
+};
+
+struct mod_type_allocator {
+	struct mod_alloc_params	params;
+};
+
+struct mod_allocators {
+	struct mod_type_allocator *types[MOD_MEM_NUM_TYPES];
+};
+
+void *module_alloc_type(size_t size, enum mod_mem_type type);
+void module_memfree_type(void *ptr, enum mod_mem_type type);
+void module_memory_fill_type(void *dst, void *src, size_t len, enum mod_mem_type type);
+void module_memory_invalidate_type(void *ptr, size_t len, enum mod_mem_type type);
+void module_memory_protect(void *ptr, size_t len, enum mod_mem_type type);
+void module_memory_unprotect(void *ptr, size_t len, enum mod_mem_type type);
+void module_memory_force_protect(void *ptr, size_t len, enum mod_mem_type type);
+void module_memory_force_unprotect(void *ptr, size_t len, enum mod_mem_type type);
+void module_alloc_type_init(struct mod_allocators *allocators);
+
+#endif /* CONFIG_MODULES */
+
 /* Determines if the section name is an init section (that is only used during
  * module loading).
  */
diff --git a/init/main.c b/init/main.c
index af50044deed5..e05228cabde8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -936,6 +936,7 @@ asmlinkage __visible void __init __no_sanitize_address __noreturn start_kernel(v
 	sort_main_extable();
 	trap_init();
 	mm_core_init();
+	module_allocator_init();
 	poking_init();
 	ftrace_init();
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d3f0a4825fa6..e4ec4be866cc 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/btf_ids.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/moduleloader.h>
 
 enum bpf_struct_ops_state {
 	BPF_STRUCT_OPS_STATE_INIT,
@@ -512,7 +513,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		err = st_ops->validate(kdata);
 		if (err)
 			goto reset_unlock;
-		set_memory_rox((long)st_map->image, 1);
+		module_memory_protect(st_map->image, PAGE_SIZE, MOD_TEXT);
+
 		/* Let bpf_link handle registration & unregistration.
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
@@ -521,7 +523,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		goto unlock;
 	}
 
-	set_memory_rox((long)st_map->image, 1);
+	module_memory_protect(st_map->image, PAGE_SIZE, MOD_TEXT);
 	err = st_ops->reg(kdata);
 	if (likely(!err)) {
 		/* This refcnt increment on the map here after
@@ -544,8 +546,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	 * there was a race in registering the struct_ops (under the same name) to
 	 * a sub-system through different struct_ops's maps.
 	 */
-	set_memory_nx((long)st_map->image, 1);
-	set_memory_rw((long)st_map->image, 1);
+	module_memory_unprotect(st_map->image, PAGE_SIZE, MOD_TEXT);
 
 reset_unlock:
 	bpf_struct_ops_map_put_progs(st_map);
@@ -907,4 +908,3 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	kfree(link);
 	return err;
 }
-
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7421487422d4..4c989a8fe8b8 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -860,7 +860,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 		       GFP_KERNEL);
 	if (!pack)
 		return NULL;
-	pack->ptr = module_alloc(BPF_PROG_PACK_SIZE);
+	pack->ptr = module_alloc_type(BPF_PROG_PACK_SIZE, MOD_TEXT);
 	if (!pack->ptr) {
 		kfree(pack);
 		return NULL;
@@ -869,8 +869,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 	list_add_tail(&pack->list, &pack_list);
 
-	set_vm_flush_reset_perms(pack->ptr);
-	set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	module_memory_protect(pack->ptr, BPF_PROG_PACK_SIZE, MOD_TEXT);
 	return pack;
 }
 
@@ -884,11 +883,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	mutex_lock(&pack_mutex);
 	if (size > BPF_PROG_PACK_SIZE) {
 		size = round_up(size, PAGE_SIZE);
-		ptr = module_alloc(size);
+		ptr = module_alloc_type(size, MOD_TEXT);
 		if (ptr) {
 			bpf_fill_ill_insns(ptr, size);
-			set_vm_flush_reset_perms(ptr);
-			set_memory_rox((unsigned long)ptr, size / PAGE_SIZE);
+			module_memory_protect(ptr, size, MOD_TEXT);
 		}
 		goto out;
 	}
@@ -922,7 +920,8 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 
 	mutex_lock(&pack_mutex);
 	if (hdr->size > BPF_PROG_PACK_SIZE) {
-		module_memfree(hdr);
+		module_memfree_type(hdr, MOD_TEXT);
+
 		goto out;
 	}
 
@@ -946,7 +945,8 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
 				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
 		list_del(&pack->list);
-		module_memfree(pack->ptr);
+		module_memfree_type(pack->ptr, MOD_TEXT);
+
 		kfree(pack);
 	}
 out:
@@ -997,12 +997,12 @@ void bpf_jit_uncharge_modmem(u32 size)
 
 void *__weak bpf_jit_alloc_exec(unsigned long size)
 {
-	return module_alloc(size);
+	return module_alloc_type(size, MOD_TEXT);
 }
 
 void __weak bpf_jit_free_exec(void *addr)
 {
-	module_memfree(addr);
+	module_memfree_type(addr, MOD_TEXT);
 }
 
 struct bpf_binary_header *
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ac021bc43a66..fd2d46c9a295 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/bpf_lsm.h>
 #include <linux/delay.h>
+#include <linux/moduleloader.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -440,7 +441,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err < 0)
 		goto out;
 
-	set_memory_rox((long)im->image, 1);
+	module_memory_protect(im->image, PAGE_SIZE, MOD_TEXT);
 
 	WARN_ON(tr->cur_image && tr->selector == 0);
 	WARN_ON(!tr->cur_image && tr->selector);
@@ -462,8 +463,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		tr->fops->trampoline = 0;
 
 		/* reset im->image memory attr for arch_prepare_bpf_trampoline */
-		set_memory_nx((long)im->image, 1);
-		set_memory_rw((long)im->image, 1);
+		module_memory_unprotect(im->image, PAGE_SIZE, MOD_TEXT);
 		goto again;
 	}
 #endif
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 00e177de91cc..daf47da3c96e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -113,17 +113,17 @@ enum kprobe_slot_state {
 void __weak *alloc_insn_page(void)
 {
 	/*
-	 * Use module_alloc() so this page is within +/- 2GB of where the
+	 * Use module_alloc_type() so this page is within +/- 2GB of where the
 	 * kernel image and loaded module images reside. This is required
 	 * for most of the architectures.
 	 * (e.g. x86-64 needs this to handle the %rip-relative fixups.)
 	 */
-	return module_alloc(PAGE_SIZE);
+	return module_alloc_type(PAGE_SIZE, MOD_TEXT);
 }
 
 static void free_insn_page(void *page)
 {
-	module_memfree(page);
+	module_memfree_type(page, MOD_TEXT);
 }
 
 struct kprobe_insn_cache kprobe_insn_slots = {
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index dc7b0160c480..b2e136326c4c 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/moduleloader.h>
 #include <linux/mm.h>
 
 #ifndef ARCH_SHF_SMALL
@@ -392,3 +393,5 @@ static inline int same_magic(const char *amagic, const char *bmagic, bool has_cr
 	return strcmp(amagic, bmagic) == 0;
 }
 #endif /* CONFIG_MODVERSIONS */
+
+extern struct mod_allocators module_allocators;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index ea7d0c7f3e60..0f9183f1ca9f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1203,11 +1203,11 @@ static bool mod_mem_use_vmalloc(enum mod_mem_type type)
 		mod_mem_type_is_core_data(type);
 }
 
-static void *module_memory_alloc(unsigned int size, enum mod_mem_type type)
+static void *module_memory_alloc(size_t size, enum mod_mem_type type)
 {
 	if (mod_mem_use_vmalloc(type))
 		return vzalloc(size);
-	return module_alloc(size);
+	return module_alloc_type(size, type);
 }
 
 static void module_memory_free(void *ptr, enum mod_mem_type type)
@@ -1215,7 +1215,7 @@ static void module_memory_free(void *ptr, enum mod_mem_type type)
 	if (mod_mem_use_vmalloc(type))
 		vfree(ptr);
 	else
-		module_memfree(ptr);
+		module_memfree_type(ptr, type);
 }
 
 static void free_mod_mem(struct module *mod)
@@ -1609,6 +1609,201 @@ void * __weak module_alloc(unsigned long size)
 			NUMA_NO_NODE, __builtin_return_address(0));
 }
 
+struct mod_allocators module_allocators;
+
+static struct mod_type_allocator default_mod_type_allocator = {
+	.params = {
+		.flags = MOD_ALLOC_FALLBACK,
+	},
+};
+
+void __init __weak module_alloc_type_init(struct mod_allocators *allocators)
+{
+	for_each_mod_mem_type(type)
+		allocators->types[type] = &default_mod_type_allocator;
+}
+
+static void module_memory_enable_protection(void *ptr, size_t len, enum mod_mem_type type)
+{
+	int npages = DIV_ROUND_UP(len, PAGE_SIZE);
+
+	switch (type) {
+	case MOD_TEXT:
+	case MOD_INIT_TEXT:
+		set_memory_rox((unsigned long)ptr, npages);
+		break;
+	case MOD_DATA:
+	case MOD_INIT_DATA:
+		set_memory_nx((unsigned long)ptr, npages);
+		break;
+	case MOD_RODATA:
+		set_memory_nx((unsigned long)ptr, npages);
+		set_memory_ro((unsigned long)ptr, npages);
+		break;
+	case MOD_RO_AFTER_INIT:
+		set_memory_ro((unsigned long)ptr, npages);
+		break;
+	default:
+		WARN_ONCE(true, "Unknown mod_mem_type: %d\n", type);
+		break;
+	}
+}
+
+static void module_memory_disable_protection(void *ptr, size_t len, enum mod_mem_type type)
+{
+	int npages = DIV_ROUND_UP(len, PAGE_SIZE);
+
+	switch (type) {
+	case MOD_TEXT:
+	case MOD_INIT_TEXT:
+		set_memory_nx((unsigned long)ptr, npages);
+		set_memory_rw((unsigned long)ptr, npages);
+		break;
+	case MOD_RODATA:
+	case MOD_RO_AFTER_INIT:
+		set_memory_rw((unsigned long)ptr, npages);
+		break;
+	case MOD_DATA:
+	case MOD_INIT_DATA:
+		break;
+	default:
+		WARN_ONCE(true, "Unknown mod_mem_type: %d\n", type);
+		break;
+	}
+}
+
+void *module_alloc_type(size_t size, enum mod_mem_type type)
+{
+	struct mod_type_allocator *allocator;
+	struct mod_alloc_params *params;
+	void *ptr = NULL;
+	int i;
+
+	if (WARN_ON_ONCE(type >= MOD_MEM_NUM_TYPES))
+		return NULL;
+
+	allocator = module_allocators.types[type];
+	params = &allocator->params;
+
+	if (params->flags & MOD_ALLOC_FALLBACK)
+		return module_alloc(size);
+
+	for (i = 0; i < MOD_MAX_ADDR_SPACES; i++) {
+		struct vmalloc_params *vmp = &params->vmp[i];
+
+		if (vmp->start == vmp->end)
+			continue;
+
+		ptr = __vmalloc_node_range(size, params->alignment, vmp->start, vmp->end,
+					   vmp->gfp_mask, vmp->pgprot, vmp->vm_flags,
+					   NUMA_NO_NODE, __builtin_return_address(0));
+		if (!ptr)
+			continue;
+
+		if (params->flags & MOD_ALLOC_KASAN_MODULE_SHADOW) {
+			if (ptr && kasan_alloc_module_shadow(ptr, size, vmp->gfp_mask)) {
+				vfree(ptr);
+				return NULL;
+			}
+		}
+
+		/*
+		 * VM_FLUSH_RESET_PERMS is still needed here. This is
+		 * because "size" is not available in module_memfree_type
+		 * at the moment, so we cannot undo set_memory_rox in
+		 * module_memfree_type. Once a better allocator is used,
+		 * we can manually undo set_memory_rox, and thus remove
+		 * VM_FLUSH_RESET_PERMS.
+		 */
+		set_vm_flush_reset_perms(ptr);
+
+		if (params->flags & MOD_ALLOC_SET_MEMORY)
+			module_memory_enable_protection(ptr, size, type);
+
+		if (params->flags & MOD_ALLOC_KASAN_RESET_TAG)
+			return kasan_reset_tag(ptr);
+		return ptr;
+	}
+	return NULL;
+}
+
+void module_memfree_type(void *ptr, enum mod_mem_type type)
+{
+	module_memfree(ptr);
+}
+
+void module_memory_fill_type(void *dst, void *src, size_t len, enum mod_mem_type type)
+{
+	struct mod_type_allocator *allocator;
+	struct mod_alloc_params *params;
+
+	allocator = module_allocators.types[type];
+	params = &allocator->params;
+
+	if (params->fill)
+		params->fill(dst, src, len);
+	else
+		memcpy(dst, src, len);
+}
+
+void module_memory_invalidate_type(void *dst, size_t len, enum mod_mem_type type)
+{
+	struct mod_type_allocator *allocator;
+	struct mod_alloc_params *params;
+
+	allocator = module_allocators.types[type];
+	params = &allocator->params;
+
+	if (params->invalidate)
+		params->invalidate(dst, len);
+	else
+		memset(dst, 0, len);
+}
+
+/*
+ * Protect memory allocated by module_alloc_type(). Called by users of
+ * module_alloc_type. This is a no-op with MOD_ALLOC_SET_MEMORY.
+ */
+void module_memory_protect(void *ptr, size_t len, enum mod_mem_type type)
+{
+	struct mod_alloc_params *params = &module_allocators.types[type]->params;
+
+	if (params->flags & MOD_ALLOC_SET_MEMORY)
+		return;
+	module_memory_enable_protection(ptr, len, type);
+}
+
+/*
+ * Unprotect memory allocated by module_alloc_type(). Called by users of
+ * module_alloc_type. This is a no-op with MOD_ALLOC_SET_MEMORY.
+ */
+void module_memory_unprotect(void *ptr, size_t len, enum mod_mem_type type)
+{
+	struct mod_alloc_params *params = &module_allocators.types[type]->params;
+
+	if (params->flags & MOD_ALLOC_SET_MEMORY)
+		return;
+	module_memory_disable_protection(ptr, len, type);
+}
+
+/*
+ * Should only be used by arch code in cases where text_poke like
+ * solution is not ready yet
+ */
+void module_memory_force_protect(void *ptr, size_t len, enum mod_mem_type type)
+{
+	module_memory_enable_protection(ptr, len, type);
+}
+
+/*
+ * Should only be used by arch code in cases where text_poke like
+ * solution is not ready yet
+ */
+void module_memory_force_unprotect(void *ptr, size_t len, enum mod_mem_type type)
+{
+	module_memory_disable_protection(ptr, len, type);
+}
+
 bool __weak module_init_section(const char *name)
 {
 	return strstarts(name, ".init");
@@ -2241,7 +2436,7 @@ static int move_module(struct module *mod, struct load_info *info)
 			t = type;
 			goto out_enomem;
 		}
-		memset(ptr, 0, mod->mem[type].size);
+		module_memory_invalidate_type(ptr, mod->mem[type].size, type);
 		mod->mem[type].base = ptr;
 	}
 
@@ -2269,7 +2464,8 @@ static int move_module(struct module *mod, struct load_info *info)
 				ret = -ENOEXEC;
 				goto out_enomem;
 			}
-			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
+
+			module_memory_fill_type(dest, (void *)shdr->sh_addr, shdr->sh_size, type);
 		}
 		/*
 		 * Update the userspace copy's ELF section address to point to
@@ -2471,9 +2667,9 @@ static void do_free_init(struct work_struct *w)
 
 	llist_for_each_safe(pos, n, list) {
 		initfree = container_of(pos, struct mod_initfree, node);
-		module_memfree(initfree->init_text);
-		module_memfree(initfree->init_data);
-		module_memfree(initfree->init_rodata);
+		module_memfree_type(initfree->init_text, MOD_INIT_TEXT);
+		module_memfree_type(initfree->init_data, MOD_INIT_DATA);
+		module_memfree_type(initfree->init_rodata, MOD_INIT_RODATA);
 		kfree(initfree);
 	}
 }
@@ -3268,3 +3464,8 @@ static int module_debugfs_init(void)
 }
 module_init(module_debugfs_init);
 #endif
+
+void __init module_allocator_init(void)
+{
+	module_alloc_type_init(&module_allocators);
+}
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index a2b656b4e3d2..65ff1b09dc84 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -16,6 +16,10 @@ static void module_set_memory(const struct module *mod, enum mod_mem_type type,
 {
 	const struct module_memory *mod_mem = &mod->mem[type];
 
+	/* The allocator already called set_memory_*, skip here. */
+	if (module_allocators.types[type]->params.flags & MOD_ALLOC_SET_MEMORY)
+		return;
+
 	set_vm_flush_reset_perms(mod_mem->base);
 	set_memory((unsigned long)mod_mem->base, mod_mem->size >> PAGE_SHIFT);
 }
-- 
2.34.1

