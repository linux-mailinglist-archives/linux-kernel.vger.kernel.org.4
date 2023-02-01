Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3824D681929
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbjA3S3Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Jan 2023 13:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbjA3S3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:29:10 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A525545F54
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:27:22 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30UHa50n005005
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:21:29 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3nd03cbngy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:21:28 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 30 Jan 2023 10:21:28 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 371F914CA6A4D; Mon, 30 Jan 2023 10:21:21 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hch@lst.de>, <kernel-team@meta.com>, Song Liu <song@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4] module: replace module_layout with module_memory
Date:   Mon, 30 Jan 2023 10:21:09 -0800
Message-ID: <20230130182109.3571524-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DwW4fbXd3Gh0vD50yXbcFIp5tQhbG1E5
X-Proofpoint-GUID: DwW4fbXd3Gh0vD50yXbcFIp5tQhbG1E5
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_layout manages different types of memory (text, data, rodata, etc.)
in one allocation, which is problematic for some reasons:

1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
2. It is hard to use huge pages in modules (and not break strict rwx).
3. Many archs uses module_layout for arch-specific data, but it is not
   obvious how these data are used (are they RO, RX, or RW?)

Improve the scenario by replacing 2 (or 3) module_layout per module with
up to 7 module_memory per module:

        MOD_MEM_TYPE_TEXT,
        MOD_MEM_TYPE_DATA,
        MOD_MEM_TYPE_RODATA,
        MOD_MEM_TYPE_RO_AFTER_INIT,
        MOD_MEM_TYPE_INIT_TEXT,
        MOD_MEM_TYPE_INIT_DATA,
        MOD_MEM_TYPE_INIT_RODATA,

and allocating them separately. This adds slightly more entries to
mod_tree (from up to 3 entries per module, to up to 7 entries per
module). However, this at most adds a small constant overhead to
__module_address(), which is expected to be fast.

Various archs use module_layout for different data. These data are put
into different module_memory based on their location in module_layout.
IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TEXT;
data that used to go with data is allocated with MOD_MEM_TYPE_DATA, etc.

module_memory simplifies quite some of the module code. For example,
ARCH_WANTS_MODULES_DATA_IN_VMALLOC is a lot cleaner, as it just uses a
different allocator for the data. kernel/module/strict_rwx.c is also
much cleaner with module_memory.

Signed-off-by: Song Liu <song@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>

---

This is the preparation work for the type aware module_alloc() discussed
in [1]. While this work is not covered much in the discussion, it is a
critical step of the effort.

As this part grows pretty big (~1000 lines, + and -), I would like get
some feedback on it, so that I know it is on the right track.

Please share your comments. Thanks!

Test coverage: Tested on x86_64.
Build tested by kernel test bot in [2]. The only regression in [2] was a
typo in parisc, which is also fixed.

[1] https://lore.kernel.org/linux-mm/20221107223921.3451913-1-song@kernel.org/T/#u
[2] https://lore.kernel.org/linux-raid/63b8827e.clJQX2wg+I+tiX7m%25lkp@intel.com/T/#u

Changes v1 => v2:
1. Add data_addr_[min|max] for CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
   case.

Changes v2 => v3:
1. Fix and remove the last use of INIT_OFFSET_MASK.
2. Add more information in the commit log. (Luis Chamberlain)
3. Rebase and fix issues in x86/calltrunks.
4. Minor cleanup.

Changes v3 => v4:
1. Shorten enum/variable names, so that the code are easier to read.
   (Christophe Leroy)
2. Remove an used variable. (Guenter Roeck, Christophe Leroy)
---
 arch/alpha/kernel/module.c      |   2 +-
 arch/arc/kernel/unwind.c        |   9 +-
 arch/arm/kernel/module-plts.c   |   5 +-
 arch/arm64/kernel/module-plts.c |   5 +-
 arch/ia64/kernel/module.c       |  30 ++-
 arch/mips/kernel/vpe.c          |  11 +-
 arch/parisc/kernel/module.c     |  51 +++--
 arch/powerpc/kernel/module_32.c |  10 +-
 arch/s390/kernel/module.c       |  30 +--
 arch/x86/kernel/callthunks.c    |   4 +-
 arch/x86/kernel/module.c        |   4 +-
 include/linux/module.h          |  63 +++---
 kernel/module/internal.h        |  47 ++--
 kernel/module/kallsyms.c        |  60 +++---
 kernel/module/kdb.c             |  17 +-
 kernel/module/main.c            | 372 ++++++++++++++++++--------------
 kernel/module/procfs.c          |  17 +-
 kernel/module/strict_rwx.c      | 113 +++-------
 kernel/module/tree_lookup.c     |  43 ++--
 19 files changed, 484 insertions(+), 409 deletions(-)

diff --git a/arch/alpha/kernel/module.c b/arch/alpha/kernel/module.c
index 5b60c248de9e..9109213abc09 100644
--- a/arch/alpha/kernel/module.c
+++ b/arch/alpha/kernel/module.c
@@ -148,7 +148,7 @@ apply_relocate_add(Elf64_Shdr *sechdrs, const char *strtab,
 
 	/* The small sections were sorted to the end of the segment.
 	   The following should definitely cover them.  */
-	gp = (u64)me->core_layout.base + me->core_layout.size - 0x8000;
+	gp = (u64)me->mem[MOD_DATA].base + me->mem[MOD_DATA].size - 0x8000;
 	got = sechdrs[me->arch.gotsecindex].sh_addr;
 
 	for (i = 0; i < n; i++) {
diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 200270a94558..933451f4494f 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -369,6 +369,8 @@ void *unwind_add_table(struct module *module, const void *table_start,
 		       unsigned long table_size)
 {
 	struct unwind_table *table;
+	struct module_memory *mod_mem_core_text;
+	struct module_memory *mod_mem_init_text;
 
 	if (table_size <= 0)
 		return NULL;
@@ -377,9 +379,12 @@ void *unwind_add_table(struct module *module, const void *table_start,
 	if (!table)
 		return NULL;
 
+	mod_mem_core_text = &module->mem[MOD_TEXT];
+	mod_mem_init_text = &module->mem[MOD_INIT_TEXT];
+
 	init_unwind_table(table, module->name,
-			  module->core_layout.base, module->core_layout.size,
-			  module->init_layout.base, module->init_layout.size,
+			  mod_mem_core_text->base, mod_mem_core_text->size,
+			  mod_mem_init_text->base, mod_mem_init_text->size,
 			  table_start, table_size,
 			  NULL, 0);
 
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index af7c322ebed6..17fd0978aee8 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -30,7 +30,10 @@ static const u32 fixed_plts[] = {
 
 static bool in_init(const struct module *mod, unsigned long loc)
 {
-	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
+	const struct module_memory *mod_mem;
+
+	mod_mem = &mod->mem[MOD_INIT_TEXT];
+	return loc - (u32)mod_mem->base < mod_mem->size;
 }
 
 static void prealloc_fixed(struct mod_plt_sec *pltsec, struct plt_entries *plt)
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 5a0a8f552a61..2f9f672a7cbb 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -67,7 +67,10 @@ static bool plt_entries_equal(const struct plt_entry *a,
 
 static bool in_init(const struct module *mod, void *loc)
 {
-	return (u64)loc - (u64)mod->init_layout.base < mod->init_layout.size;
+	const struct module_memory *mod_mem;
+
+	mod_mem = &mod->mem[MOD_INIT_TEXT];
+	return (u64)loc - (u64)mod_mem->base < mod_mem->size;
 }
 
 u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
index 8f62cf97f691..4268ddb54a33 100644
--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -485,19 +485,25 @@ module_frob_arch_sections (Elf_Ehdr *ehdr, Elf_Shdr *sechdrs, char *secstrings,
 	return 0;
 }
 
-static inline int
+static inline bool
 in_init (const struct module *mod, uint64_t addr)
 {
-	return addr - (uint64_t) mod->init_layout.base < mod->init_layout.size;
+	const struct module_memory *mod_mem;
+
+	mod_mem = &mod->mem[MOD_INIT_TEXT];
+	return addr - (uint64_t)mod_mem->base < mod_mem->size;
 }
 
-static inline int
+static inline bool
 in_core (const struct module *mod, uint64_t addr)
 {
-	return addr - (uint64_t) mod->core_layout.base < mod->core_layout.size;
+	const struct module_memory *mod_mem;
+
+	mod_mem = &mod->mem[MOD_TEXT];
+	return addr - (uint64_t)mod_mem->base < mod_mem->size;
 }
 
-static inline int
+static inline bool
 is_internal (const struct module *mod, uint64_t value)
 {
 	return in_init(mod, value) || in_core(mod, value);
@@ -677,7 +683,8 @@ do_reloc (struct module *mod, uint8_t r_type, Elf64_Sym *sym, uint64_t addend,
 		break;
 
 	      case RV_BDREL:
-		val -= (uint64_t) (in_init(mod, val) ? mod->init_layout.base : mod->core_layout.base);
+		val -= (uint64_t) (in_init(mod, val) ? mod->mem[MOD_INIT_TEXT].base :
+				   mod->mem[MOD_TEXT].base);
 		break;
 
 	      case RV_LTV:
@@ -812,15 +819,18 @@ apply_relocate_add (Elf64_Shdr *sechdrs, const char *strtab, unsigned int symind
 		 *     addresses have been selected...
 		 */
 		uint64_t gp;
-		if (mod->core_layout.size > MAX_LTOFF)
+		struct module_memory *mod_mem;
+
+		mod_mem = &mod->mem[MOD_DATA];
+		if (mod_mem->size > MAX_LTOFF)
 			/*
 			 * This takes advantage of fact that SHF_ARCH_SMALL gets allocated
 			 * at the end of the module.
 			 */
-			gp = mod->core_layout.size - MAX_LTOFF / 2;
+			gp = mod_mem->size - MAX_LTOFF / 2;
 		else
-			gp = mod->core_layout.size / 2;
-		gp = (uint64_t) mod->core_layout.base + ((gp + 7) & -8);
+			gp = mod_mem->size / 2;
+		gp = (uint64_t) mod_mem->base + ((gp + 7) & -8);
 		mod->arch.gp = gp;
 		DEBUGP("%s: placing gp at 0x%lx\n", __func__, gp);
 	}
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 13294972707b..ab114c686f9d 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -199,18 +199,17 @@ static void layout_sections(struct module *mod, const Elf_Ehdr *hdr,
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
 		for (i = 0; i < hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &sechdrs[i];
+			struct module_memory *mod_mem;
+
+			mod_mem = &mod->mem[MOD_TEXT];
 
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL)
 				continue;
 			s->sh_entsize =
-				get_offset((unsigned long *)&mod->core_layout.size, s);
+				get_offset((unsigned long *)&mod_mem->size, s);
 		}
-
-		if (m == 0)
-			mod->core_layout.text_size = mod->core_layout.size;
-
 	}
 }
 
@@ -641,7 +640,7 @@ static int vpe_elfload(struct vpe *v)
 		layout_sections(&mod, hdr, sechdrs, secstrings);
 	}
 
-	v->load_addr = alloc_progmem(mod.core_layout.size);
+	v->load_addr = alloc_progmem(mod.mod_mem[MOD_TEXT].size);
 	if (!v->load_addr)
 		return -ENOMEM;
 
diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index 7df140545b22..e052a5fdd51b 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -27,9 +27,9 @@
  *      We are not doing SEGREL32 handling correctly. According to the ABI, we
  *      should do a value offset, like this:
  *			if (in_init(me, (void *)val))
- *				val -= (uint32_t)me->init_layout.base;
+ *				val -= (uint32_t)me->mem[MOD_INIT_TEXT].base;
  *			else
- *				val -= (uint32_t)me->core_layout.base;
+ *				val -= (uint32_t)me->mem[MOD_TEXT].base;
  *	However, SEGREL32 is used only for PARISC unwind entries, and we want
  *	those entries to have an absolute address, and not just an offset.
  *
@@ -76,23 +76,18 @@
  * allows us to allocate up to 4095 GOT entries. */
 #define MAX_GOTS	4095
 
-/* three functions to determine where in the module core
- * or init pieces the location is */
-static inline int in_init(struct module *me, void *loc)
+static inline bool in_local(struct module *me, void *loc)
 {
-	return (loc >= me->init_layout.base &&
-		loc <= (me->init_layout.base + me->init_layout.size));
-}
+	enum mod_mem_type type;
 
-static inline int in_core(struct module *me, void *loc)
-{
-	return (loc >= me->core_layout.base &&
-		loc <= (me->core_layout.base + me->core_layout.size));
-}
+	for (type = MOD_TEXT; type < MOD_MEM_NUM_TYPES; type++) {
+		struct module_memory *mod_mem = &me->mem[type];
 
-static inline int in_local(struct module *me, void *loc)
-{
-	return in_init(me, loc) || in_core(me, loc);
+		if (loc >= mod_mem->base &&
+		    loc <= (mod_mem->base + mod_mem->size))
+			return true;
+	}
+	return false;
 }
 
 #ifndef CONFIG_64BIT
@@ -302,6 +297,7 @@ int module_frob_arch_sections(CONST Elf_Ehdr *hdr,
 {
 	unsigned long gots = 0, fdescs = 0, len;
 	unsigned int i;
+	struct module_memory *mod_mem;
 
 	len = hdr->e_shnum * sizeof(me->arch.section[0]);
 	me->arch.section = kzalloc(len, GFP_KERNEL);
@@ -346,14 +342,15 @@ int module_frob_arch_sections(CONST Elf_Ehdr *hdr,
 		me->arch.section[s].stub_entries += count;
 	}
 
+	mod_mem = &me->mem[MOD_TEXT];
 	/* align things a bit */
-	me->core_layout.size = ALIGN(me->core_layout.size, 16);
-	me->arch.got_offset = me->core_layout.size;
-	me->core_layout.size += gots * sizeof(struct got_entry);
+	mod_mem->size = ALIGN(mod_mem->size, 16);
+	me->arch.got_offset = mod_mem->size;
+	mod_mem->size += gots * sizeof(struct got_entry);
 
-	me->core_layout.size = ALIGN(me->core_layout.size, 16);
-	me->arch.fdesc_offset = me->core_layout.size;
-	me->core_layout.size += fdescs * sizeof(Elf_Fdesc);
+	mod_mem->size = ALIGN(mod_mem->size, 16);
+	me->arch.fdesc_offset = mod_mem->size;
+	mod_mem->size += fdescs * sizeof(Elf_Fdesc);
 
 	me->arch.got_max = gots;
 	me->arch.fdesc_max = fdescs;
@@ -371,7 +368,7 @@ static Elf64_Word get_got(struct module *me, unsigned long value, long addend)
 
 	BUG_ON(value == 0);
 
-	got = me->core_layout.base + me->arch.got_offset;
+	got = me->mem[MOD_TEXT].base + me->arch.got_offset;
 	for (i = 0; got[i].addr; i++)
 		if (got[i].addr == value)
 			goto out;
@@ -389,7 +386,7 @@ static Elf64_Word get_got(struct module *me, unsigned long value, long addend)
 #ifdef CONFIG_64BIT
 static Elf_Addr get_fdesc(struct module *me, unsigned long value)
 {
-	Elf_Fdesc *fdesc = me->core_layout.base + me->arch.fdesc_offset;
+	Elf_Fdesc *fdesc = me->mem[MOD_TEXT].base + me->arch.fdesc_offset;
 
 	if (!value) {
 		printk(KERN_ERR "%s: zero OPD requested!\n", me->name);
@@ -407,7 +404,7 @@ static Elf_Addr get_fdesc(struct module *me, unsigned long value)
 
 	/* Create new one */
 	fdesc->addr = value;
-	fdesc->gp = (Elf_Addr)me->core_layout.base + me->arch.got_offset;
+	fdesc->gp = (Elf_Addr)me->mem[MOD_TEXT].base + me->arch.got_offset;
 	return (Elf_Addr)fdesc;
 }
 #endif /* CONFIG_64BIT */
@@ -839,7 +836,7 @@ register_unwind_table(struct module *me,
 
 	table = (unsigned char *)sechdrs[me->arch.unwind_section].sh_addr;
 	end = table + sechdrs[me->arch.unwind_section].sh_size;
-	gp = (Elf_Addr)me->core_layout.base + me->arch.got_offset;
+	gp = (Elf_Addr)me->mem[MOD_TEXT].base + me->arch.got_offset;
 
 	pr_debug("register_unwind_table(), sect = %d at 0x%p - 0x%p (gp=0x%lx)\n",
 	       me->arch.unwind_section, table, end, gp);
@@ -977,7 +974,7 @@ void module_arch_cleanup(struct module *mod)
 #ifdef CONFIG_64BIT
 void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 {
-	unsigned long start_opd = (Elf64_Addr)mod->core_layout.base +
+	unsigned long start_opd = (Elf64_Addr)mod->mem[MOD_TEXT].base +
 				   mod->arch.fdesc_offset;
 	unsigned long end_opd = start_opd +
 				mod->arch.fdesc_count * sizeof(Elf64_Fdesc);
diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index ea6536171778..c3a5a0a8fe9b 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -160,11 +160,13 @@ static uint32_t do_plt_call(void *location,
 			    struct module *mod)
 {
 	struct ppc_plt_entry *entry;
+	struct module_memory *mod_mem;
 
 	pr_debug("Doing plt for call to 0x%x at 0x%x\n", val, (unsigned int)location);
+
+	mod_mem = &mod->mem[MOD_TEXT];
 	/* Init, or core PLT? */
-	if (location >= mod->core_layout.base
-	    && location < mod->core_layout.base + mod->core_layout.size)
+	if (location >= mod_mem->base && location < mod_mem->base + mod_mem->size)
 		entry = (void *)sechdrs[mod->arch.core_plt_section].sh_addr;
 	else
 		entry = (void *)sechdrs[mod->arch.init_plt_section].sh_addr;
@@ -322,14 +324,14 @@ notrace int module_trampoline_target(struct module *mod, unsigned long addr,
 
 int module_finalize_ftrace(struct module *module, const Elf_Shdr *sechdrs)
 {
-	module->arch.tramp = do_plt_call(module->core_layout.base,
+	module->arch.tramp = do_plt_call(module->mem[MOD_TEXT].base,
 					 (unsigned long)ftrace_caller,
 					 sechdrs, module);
 	if (!module->arch.tramp)
 		return -ENOENT;
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	module->arch.tramp_regs = do_plt_call(module->core_layout.base,
+	module->arch.tramp_regs = do_plt_call(module->mem[MOD_TEXT].base,
 					      (unsigned long)ftrace_regs_caller,
 					      sechdrs, module);
 	if (!module->arch.tramp_regs)
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 2d159b32885b..3ed455b785ad 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -108,7 +108,7 @@ static void check_rela(Elf_Rela *rela, struct module *me)
 	case R_390_GLOB_DAT:
 	case R_390_JMP_SLOT:
 	case R_390_RELATIVE:
-		/* Only needed if we want to support loading of 
+		/* Only needed if we want to support loading of
 		   modules linked with -shared. */
 		break;
 	}
@@ -126,6 +126,7 @@ int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 	Elf_Rela *rela;
 	char *strings;
 	int nrela, i, j;
+	struct module_memory *mod_mem;
 
 	/* Find symbol table and string table. */
 	symtab = NULL;
@@ -173,14 +174,15 @@ int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 
 	/* Increase core size by size of got & plt and set start
 	   offsets for got and plt. */
-	me->core_layout.size = ALIGN(me->core_layout.size, 4);
-	me->arch.got_offset = me->core_layout.size;
-	me->core_layout.size += me->arch.got_size;
-	me->arch.plt_offset = me->core_layout.size;
+	mod_mem = &me->mem[MOD_TEXT];
+	mod_mem->size = ALIGN(mod_mem->size, 4);
+	me->arch.got_offset = mod_mem->size;
+	mod_mem->size += me->arch.got_size;
+	me->arch.plt_offset = mod_mem->size;
 	if (me->arch.plt_size) {
 		if (IS_ENABLED(CONFIG_EXPOLINE) && !nospec_disable)
 			me->arch.plt_size += PLT_ENTRY_SIZE;
-		me->core_layout.size += me->arch.plt_size;
+		mod_mem->size += me->arch.plt_size;
 	}
 	return 0;
 }
@@ -304,7 +306,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 	case R_390_GOTPLT64:	/* 64 bit offset to jump slot.	*/
 	case R_390_GOTPLTENT:	/* 32 bit rel. offset to jump slot >> 1. */
 		if (info->got_initialized == 0) {
-			Elf_Addr *gotent = me->core_layout.base +
+			Elf_Addr *gotent = me->mem[MOD_TEXT].base +
 					   me->arch.got_offset +
 					   info->got_offset;
 
@@ -329,7 +331,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 			rc = apply_rela_bits(loc, val, 0, 64, 0, write);
 		else if (r_type == R_390_GOTENT ||
 			 r_type == R_390_GOTPLTENT) {
-			val += (Elf_Addr) me->core_layout.base - loc;
+			val += (Elf_Addr) me->mem[MOD_TEXT].base - loc;
 			rc = apply_rela_bits(loc, val, 1, 32, 1, write);
 		}
 		break;
@@ -345,7 +347,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 			char *plt_base;
 			char *ip;
 
-			plt_base = me->core_layout.base + me->arch.plt_offset;
+			plt_base = me->mem[MOD_TEXT].base + me->arch.plt_offset;
 			ip = plt_base + info->plt_offset;
 			*(int *)insn = 0x0d10e310;	/* basr 1,0  */
 			*(int *)&insn[4] = 0x100c0004;	/* lg	1,12(1) */
@@ -375,7 +377,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 			       val - loc + 0xffffUL < 0x1ffffeUL) ||
 			      (r_type == R_390_PLT32DBL &&
 			       val - loc + 0xffffffffULL < 0x1fffffffeULL)))
-				val = (Elf_Addr) me->core_layout.base +
+				val = (Elf_Addr) me->mem[MOD_TEXT].base +
 					me->arch.plt_offset +
 					info->plt_offset;
 			val += rela->r_addend - loc;
@@ -397,7 +399,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 	case R_390_GOTOFF32:	/* 32 bit offset to GOT.  */
 	case R_390_GOTOFF64:	/* 64 bit offset to GOT. */
 		val = val + rela->r_addend -
-			((Elf_Addr) me->core_layout.base + me->arch.got_offset);
+			((Elf_Addr) me->mem[MOD_TEXT].base + me->arch.got_offset);
 		if (r_type == R_390_GOTOFF16)
 			rc = apply_rela_bits(loc, val, 0, 16, 0, write);
 		else if (r_type == R_390_GOTOFF32)
@@ -407,7 +409,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 		break;
 	case R_390_GOTPC:	/* 32 bit PC relative offset to GOT. */
 	case R_390_GOTPCDBL:	/* 32 bit PC rel. off. to GOT shifted by 1. */
-		val = (Elf_Addr) me->core_layout.base + me->arch.got_offset +
+		val = (Elf_Addr) me->mem[MOD_TEXT].base + me->arch.got_offset +
 			rela->r_addend - loc;
 		if (r_type == R_390_GOTPC)
 			rc = apply_rela_bits(loc, val, 1, 32, 0, write);
@@ -418,7 +420,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
 	case R_390_GLOB_DAT:	/* Create GOT entry.  */
 	case R_390_JMP_SLOT:	/* Create PLT entry.  */
 	case R_390_RELATIVE:	/* Adjust by program base.  */
-		/* Only needed if we want to support loading of 
+		/* Only needed if we want to support loading of
 		   modules linked with -shared. */
 		return -ENOEXEC;
 	default:
@@ -515,7 +517,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	    !nospec_disable && me->arch.plt_size) {
 		unsigned int *ij;
 
-		ij = me->core_layout.base + me->arch.plt_offset +
+		ij = me->mem[MOD_TEXT].base + me->arch.plt_offset +
 			me->arch.plt_size - PLT_ENTRY_SIZE;
 		ij[0] = 0xc6000000;	/* exrl	%r0,.+10	*/
 		ij[1] = 0x0005a7f4;	/* j	.		*/
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index ffea98f9064b..22ab13966427 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -330,8 +330,8 @@ void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
 					    struct module *mod)
 {
 	struct core_text ct = {
-		.base = (unsigned long)mod->core_layout.base,
-		.end  = (unsigned long)mod->core_layout.base + mod->core_layout.size,
+		.base = (unsigned long)mod->mem[MOD_TEXT].base,
+		.end  = (unsigned long)mod->mem[MOD_TEXT].base + mod->mem[MOD_TEXT].size,
 		.name = mod->name,
 	};
 
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 705fb2a41d7d..dbc8e226c464 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -339,8 +339,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 	}
 	if (locks) {
 		void *lseg = (void *)locks->sh_addr;
-		void *text = me->core_layout.base;
-		void *text_end = text + me->core_layout.text_size;
+		void *text = me->mem[MOD_TEXT].base;
+		void *text_end = text + me->mem[MOD_TEXT].size;
 		alternatives_smp_module_add(me, me->name,
 					    lseg, lseg + locks->sh_size,
 					    text, text_end);
diff --git a/include/linux/module.h b/include/linux/module.h
index 8c5909c0076c..61b7cff632f9 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -320,17 +320,22 @@ struct mod_tree_node {
 	struct latch_tree_node node;
 };
 
-struct module_layout {
-	/* The actual code + data. */
+enum mod_mem_type {
+	MOD_TEXT,
+	MOD_DATA,
+	MOD_RODATA,
+	MOD_RO_AFTER_INIT,
+	MOD_INIT_TEXT,
+	MOD_INIT_DATA,
+	MOD_INIT_RODATA,
+
+	MOD_MEM_NUM_TYPES,
+	MOD_INVALID = -1,
+};
+
+struct module_memory {
 	void *base;
-	/* Total size. */
 	unsigned int size;
-	/* The size of the executable code.  */
-	unsigned int text_size;
-	/* Size of RO section of the module (text+rodata) */
-	unsigned int ro_size;
-	/* Size of RO after init section */
-	unsigned int ro_after_init_size;
 
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 	struct mod_tree_node mtn;
@@ -339,9 +344,9 @@ struct module_layout {
 
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 /* Only touch one cacheline for common rbtree-for-core-layout case. */
-#define __module_layout_align ____cacheline_aligned
+#define __module_memory_align ____cacheline_aligned
 #else
-#define __module_layout_align
+#define __module_memory_align
 #endif
 
 struct mod_kallsyms {
@@ -418,12 +423,8 @@ struct module {
 	/* Startup function. */
 	int (*init)(void);
 
-	/* Core layout: rbtree is accessed frequently, so keep together. */
-	struct module_layout core_layout __module_layout_align;
-	struct module_layout init_layout;
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-	struct module_layout data_layout;
-#endif
+	/* rbtree is accessed frequently, so keep together. */
+	struct module_memory mem[MOD_MEM_NUM_TYPES] __module_memory_align;
 
 	/* Arch-specific module values */
 	struct mod_arch_specific arch;
@@ -573,23 +574,33 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
 
+static inline bool within_module_mem_type(unsigned long addr,
+					  const struct module *mod,
+					  enum mod_mem_type type)
+{
+	unsigned long base, size;
+
+	base = (unsigned long)mod->mem[type].base;
+	size = mod->mem[type].size;
+
+	return base <= addr && addr < base + size;
+}
+
 static inline bool within_module_core(unsigned long addr,
 				      const struct module *mod)
 {
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-	if ((unsigned long)mod->data_layout.base <= addr &&
-	    addr < (unsigned long)mod->data_layout.base + mod->data_layout.size)
-		return true;
-#endif
-	return (unsigned long)mod->core_layout.base <= addr &&
-	       addr < (unsigned long)mod->core_layout.base + mod->core_layout.size;
+	return within_module_mem_type(addr, mod, MOD_TEXT) ||
+		within_module_mem_type(addr, mod, MOD_DATA) ||
+		within_module_mem_type(addr, mod, MOD_RODATA) ||
+		within_module_mem_type(addr, mod, MOD_RO_AFTER_INIT);
 }
 
 static inline bool within_module_init(unsigned long addr,
 				      const struct module *mod)
 {
-	return (unsigned long)mod->init_layout.base <= addr &&
-	       addr < (unsigned long)mod->init_layout.base + mod->init_layout.size;
+	return within_module_mem_type(addr, mod, MOD_INIT_TEXT) ||
+		within_module_mem_type(addr, mod, MOD_INIT_DATA) ||
+		within_module_mem_type(addr, mod, MOD_INIT_RODATA);
 }
 
 static inline bool within_module(unsigned long addr, const struct module *mod)
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 2e2bf236f558..b079bd19ea9a 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -17,27 +17,31 @@
 #define ARCH_SHF_SMALL 0
 #endif
 
-/* If this is set, the section belongs in the init part of the module */
-#define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG - 1))
+/*
+ * Use highest 4 bits of sh_entsize to store the mod_mem_type of this
+ * section. This leaves 28 bits for offset on 32-bit systems, which is
+ * about 256 MiB (WARN_ON_ONCE if we exceed that).
+ */
+
+#define SH_ENTSIZE_TYPE_BITS	4
+#define SH_ENTSIZE_TYPE_SHIFT	(BITS_PER_LONG - SH_ENTSIZE_TYPE_BITS)
+#define SH_ENTSIZE_TYPE_MASK	((1UL << SH_ENTSIZE_TYPE_BITS) - 1)
+#define SH_ENTSIZE_OFFSET_MASK	((1UL << (BITS_PER_LONG - SH_ENTSIZE_TYPE_BITS)) - 1)
+
 /* Maximum number of characters written by module_flags() */
 #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
 
-#ifndef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-#define	data_layout core_layout
-#endif
+#define for_each_mod_mem_type(type)	\
+	for ((type) = MOD_TEXT;	\
+	     (type) < MOD_MEM_NUM_TYPES; (type)++)
 
-/*
- * Modules' sections will be aligned on page boundaries
- * to ensure complete separation of code and data, but
- * only when CONFIG_STRICT_MODULE_RWX=y
- */
-static inline unsigned int strict_align(unsigned int size)
-{
-	if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-		return PAGE_ALIGN(size);
-	else
-		return size;
-}
+#define for_core_mod_mem_type(type)		\
+	for ((type) = MOD_TEXT;		\
+	     (type) < MOD_INIT_TEXT; (type)++)
+
+#define for_init_mod_mem_type(type)		\
+	for ((type) = MOD_INIT_TEXT;		\
+	     (type) < MOD_MEM_NUM_TYPES; (type)++)
 
 extern struct mutex module_mutex;
 extern struct list_head modules;
@@ -101,8 +105,8 @@ int try_to_force_load(struct module *mod, const char *reason);
 bool find_symbol(struct find_symbol_arg *fsa);
 struct module *find_module_all(const char *name, size_t len, bool even_unformed);
 int cmp_name(const void *name, const void *sym);
-long module_get_offset(struct module *mod, unsigned int *size, Elf_Shdr *sechdr,
-		       unsigned int section);
+long module_get_offset_and_type(struct module *mod, enum mod_mem_type type,
+				Elf_Shdr *sechdr, unsigned int section);
 char *module_flags(struct module *mod, char *buf, bool show_state);
 size_t module_flags_taint(unsigned long taints, char *buf);
 
@@ -190,10 +194,13 @@ struct mod_tree_root {
 #endif
 	unsigned long addr_min;
 	unsigned long addr_max;
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	unsigned long data_addr_min;
+	unsigned long data_addr_max;
+#endif
 };
 
 extern struct mod_tree_root mod_tree;
-extern struct mod_tree_root mod_data_tree;
 
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 void mod_tree_insert(struct module *mod);
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 4523f99b0358..c445639dfbd9 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -78,6 +78,7 @@ static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
 			   unsigned int shnum, unsigned int pcpundx)
 {
 	const Elf_Shdr *sec;
+	enum mod_mem_type type;
 
 	if (src->st_shndx == SHN_UNDEF ||
 	    src->st_shndx >= shnum ||
@@ -90,11 +91,14 @@ static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
 #endif
 
 	sec = sechdrs + src->st_shndx;
+	type = sec->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
 	if (!(sec->sh_flags & SHF_ALLOC)
 #ifndef CONFIG_KALLSYMS_ALL
 	    || !(sec->sh_flags & SHF_EXECINSTR)
 #endif
-	    || (sec->sh_entsize & INIT_OFFSET_MASK))
+	    || (type == MOD_INIT_TEXT)
+	    || (type == MOD_INIT_DATA)
+	    || (type == MOD_INIT_RODATA))
 		return false;
 
 	return true;
@@ -113,11 +117,13 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	Elf_Shdr *strsect = info->sechdrs + info->index.str;
 	const Elf_Sym *src;
 	unsigned int i, nsrc, ndst, strtab_size = 0;
+	struct module_memory *mod_mem_data = &mod->mem[MOD_DATA];
+	struct module_memory *mod_mem_init_data = &mod->mem[MOD_INIT_DATA];
 
 	/* Put symbol section at end of init part of module. */
 	symsect->sh_flags |= SHF_ALLOC;
-	symsect->sh_entsize = module_get_offset(mod, &mod->init_layout.size, symsect,
-						info->index.sym) | INIT_OFFSET_MASK;
+	symsect->sh_entsize = module_get_offset_and_type(mod, MOD_INIT_DATA,
+							 symsect, info->index.sym);
 	pr_debug("\t%s\n", info->secstrings + symsect->sh_name);
 
 	src = (void *)info->hdr + symsect->sh_offset;
@@ -134,28 +140,27 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	}
 
 	/* Append room for core symbols at end of core part. */
-	info->symoffs = ALIGN(mod->data_layout.size, symsect->sh_addralign ?: 1);
-	info->stroffs = mod->data_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
-	mod->data_layout.size += strtab_size;
+	info->symoffs = ALIGN(mod_mem_data->size, symsect->sh_addralign ?: 1);
+	info->stroffs = mod_mem_data->size = info->symoffs + ndst * sizeof(Elf_Sym);
+	mod_mem_data->size += strtab_size;
 	/* Note add_kallsyms() computes strtab_size as core_typeoffs - stroffs */
-	info->core_typeoffs = mod->data_layout.size;
-	mod->data_layout.size += ndst * sizeof(char);
-	mod->data_layout.size = strict_align(mod->data_layout.size);
+	info->core_typeoffs = mod_mem_data->size;
+	mod_mem_data->size += ndst * sizeof(char);
 
 	/* Put string table section at end of init part of module. */
 	strsect->sh_flags |= SHF_ALLOC;
-	strsect->sh_entsize = module_get_offset(mod, &mod->init_layout.size, strsect,
-						info->index.str) | INIT_OFFSET_MASK;
+	strsect->sh_entsize = module_get_offset_and_type(mod, MOD_INIT_DATA,
+							 strsect, info->index.str);
 	pr_debug("\t%s\n", info->secstrings + strsect->sh_name);
 
 	/* We'll tack temporary mod_kallsyms on the end. */
-	mod->init_layout.size = ALIGN(mod->init_layout.size,
-				      __alignof__(struct mod_kallsyms));
-	info->mod_kallsyms_init_off = mod->init_layout.size;
-	mod->init_layout.size += sizeof(struct mod_kallsyms);
-	info->init_typeoffs = mod->init_layout.size;
-	mod->init_layout.size += nsrc * sizeof(char);
-	mod->init_layout.size = strict_align(mod->init_layout.size);
+	mod_mem_init_data->size = ALIGN(mod_mem_init_data->size,
+					__alignof__(struct mod_kallsyms));
+	info->mod_kallsyms_init_off = mod_mem_init_data->size;
+
+	mod_mem_init_data->size += sizeof(struct mod_kallsyms);
+	info->init_typeoffs = mod_mem_init_data->size;
+	mod_mem_init_data->size += nsrc * sizeof(char);
 }
 
 /*
@@ -171,9 +176,11 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	char *s;
 	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
 	unsigned long strtab_size;
+	void *data_base = mod->mem[MOD_DATA].base;
+	void *init_data_base = mod->mem[MOD_INIT_DATA].base;
 
 	/* Set up to point into init section. */
-	mod->kallsyms = (void __rcu *)mod->init_layout.base +
+	mod->kallsyms = (void __rcu *)init_data_base +
 		info->mod_kallsyms_init_off;
 
 	rcu_read_lock();
@@ -183,15 +190,15 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	/* Make sure we get permanent strtab: don't use info->strtab. */
 	rcu_dereference(mod->kallsyms)->strtab =
 		(void *)info->sechdrs[info->index.str].sh_addr;
-	rcu_dereference(mod->kallsyms)->typetab = mod->init_layout.base + info->init_typeoffs;
+	rcu_dereference(mod->kallsyms)->typetab = init_data_base + info->init_typeoffs;
 
 	/*
 	 * Now populate the cut down core kallsyms for after init
 	 * and set types up while we still have access to sections.
 	 */
-	mod->core_kallsyms.symtab = dst = mod->data_layout.base + info->symoffs;
-	mod->core_kallsyms.strtab = s = mod->data_layout.base + info->stroffs;
-	mod->core_kallsyms.typetab = mod->data_layout.base + info->core_typeoffs;
+	mod->core_kallsyms.symtab = dst = data_base + info->symoffs;
+	mod->core_kallsyms.strtab = s = data_base + info->stroffs;
+	mod->core_kallsyms.typetab = data_base + info->core_typeoffs;
 	strtab_size = info->core_typeoffs - info->stroffs;
 	src = rcu_dereference(mod->kallsyms)->symtab;
 	for (ndst = i = 0; i < rcu_dereference(mod->kallsyms)->num_symtab; i++) {
@@ -267,12 +274,15 @@ static const char *find_kallsyms_symbol(struct module *mod,
 	unsigned int i, best = 0;
 	unsigned long nextval, bestval;
 	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
+	struct module_memory *mod_mem;
 
 	/* At worse, next value is at end of module */
 	if (within_module_init(addr, mod))
-		nextval = (unsigned long)mod->init_layout.base + mod->init_layout.text_size;
+		mod_mem = &mod->mem[MOD_INIT_TEXT];
 	else
-		nextval = (unsigned long)mod->core_layout.base + mod->core_layout.text_size;
+		mod_mem = &mod->mem[MOD_TEXT];
+
+	nextval = (unsigned long)mod_mem->base + mod_mem->size;
 
 	bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
 
diff --git a/kernel/module/kdb.c b/kernel/module/kdb.c
index f4317f92e189..995c32d3698f 100644
--- a/kernel/module/kdb.c
+++ b/kernel/module/kdb.c
@@ -26,10 +26,11 @@ int kdb_lsmod(int argc, const char **argv)
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
 
-		kdb_printf("%-20s%8u", mod->name, mod->core_layout.size);
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-		kdb_printf("/%8u", mod->data_layout.size);
-#endif
+		kdb_printf("%-20s%8u", mod->name, mod->mem[MOD_TEXT].size);
+		kdb_printf("/%8u", mod->mem[MOD_RODATA].size);
+		kdb_printf("/%8u", mod->mem[MOD_RO_AFTER_INIT].size);
+		kdb_printf("/%8u", mod->mem[MOD_DATA].size);
+
 		kdb_printf("  0x%px ", (void *)mod);
 #ifdef CONFIG_MODULE_UNLOAD
 		kdb_printf("%4d ", module_refcount(mod));
@@ -40,10 +41,10 @@ int kdb_lsmod(int argc, const char **argv)
 			kdb_printf(" (Loading)");
 		else
 			kdb_printf(" (Live)");
-		kdb_printf(" 0x%px", mod->core_layout.base);
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-		kdb_printf("/0x%px", mod->data_layout.base);
-#endif
+		kdb_printf(" 0x%px", mod->mem[MOD_TEXT].base);
+		kdb_printf("/0x%px", mod->mem[MOD_RODATA].base);
+		kdb_printf("/0x%px", mod->mem[MOD_RO_AFTER_INIT].base);
+		kdb_printf("/0x%px", mod->mem[MOD_DATA].base);
 
 #ifdef CONFIG_MODULE_UNLOAD
 		{
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d3be89de706d..6edac95526d4 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -80,12 +80,6 @@ struct mod_tree_root mod_tree __cacheline_aligned = {
 	.addr_min = -1UL,
 };
 
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-struct mod_tree_root mod_data_tree __cacheline_aligned = {
-	.addr_min = -1UL,
-};
-#endif
-
 struct symsearch {
 	const struct kernel_symbol *start, *stop;
 	const s32 *crcs;
@@ -93,14 +87,25 @@ struct symsearch {
 };
 
 /*
- * Bounds of module text, for speeding up __module_address.
+ * Bounds of module memory, for speeding up __module_address.
  * Protected by module_mutex.
  */
-static void __mod_update_bounds(void *base, unsigned int size, struct mod_tree_root *tree)
+static void __mod_update_bounds(enum mod_mem_type type __maybe_unused, void *base,
+				unsigned int size, struct mod_tree_root *tree)
 {
 	unsigned long min = (unsigned long)base;
 	unsigned long max = min + size;
 
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	if (type == MOD_DATA || type == MOD_RODATA ||
+	    type == MOD_RO_AFTER_INIT) {
+		if (min < tree->data_addr_min)
+			tree->data_addr_min = min;
+		if (max > tree->data_addr_max)
+			tree->data_addr_max = max;
+		return;
+	}
+#endif
 	if (min < tree->addr_min)
 		tree->addr_min = min;
 	if (max > tree->addr_max)
@@ -109,12 +114,14 @@ static void __mod_update_bounds(void *base, unsigned int size, struct mod_tree_r
 
 static void mod_update_bounds(struct module *mod)
 {
-	__mod_update_bounds(mod->core_layout.base, mod->core_layout.size, &mod_tree);
-	if (mod->init_layout.size)
-		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size, &mod_tree);
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-	__mod_update_bounds(mod->data_layout.base, mod->data_layout.size, &mod_data_tree);
-#endif
+	enum mod_mem_type type;
+
+	for_each_mod_mem_type(type) {
+		struct module_memory *mod_mem = &mod->mem[type];
+
+		if (mod_mem->size)
+			__mod_update_bounds(type, mod_mem->base, mod_mem->size, &mod_tree);
+	}
 }
 
 /* Block module loading/unloading? */
@@ -923,11 +930,27 @@ static ssize_t store_uevent(struct module_attribute *mattr,
 struct module_attribute module_uevent =
 	__ATTR(uevent, 0200, NULL, store_uevent);
 
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+
+static ssize_t show_coresize(struct module_attribute *mattr,
+			     struct module_kobject *mk, char *buffer)
+{
+	return sprintf(buffer, "%u\n", mk->mod->mem[MOD_TEXT].size);
+}
+
+#else
+
 static ssize_t show_coresize(struct module_attribute *mattr,
 			     struct module_kobject *mk, char *buffer)
 {
-	return sprintf(buffer, "%u\n", mk->mod->core_layout.size);
+	enum mod_mem_type type;
+	unsigned int size = 0;
+
+	for_core_mod_mem_type(type)
+		size += mk->mod->mem[type].size;
+	return sprintf(buffer, "%u\n", size);
 }
+#endif
 
 static struct module_attribute modinfo_coresize =
 	__ATTR(coresize, 0444, show_coresize, NULL);
@@ -936,7 +959,15 @@ static struct module_attribute modinfo_coresize =
 static ssize_t show_datasize(struct module_attribute *mattr,
 			     struct module_kobject *mk, char *buffer)
 {
-	return sprintf(buffer, "%u\n", mk->mod->data_layout.size);
+	enum mod_mem_type type;
+	unsigned int size = 0;
+
+	for_core_mod_mem_type(type) {
+		if (type == MOD_TEXT)
+			continue;
+		size += mk->mod->mem[type].size;
+	}
+	return sprintf(buffer, "%u\n", size);
 }
 
 static struct module_attribute modinfo_datasize =
@@ -946,7 +977,12 @@ static struct module_attribute modinfo_datasize =
 static ssize_t show_initsize(struct module_attribute *mattr,
 			     struct module_kobject *mk, char *buffer)
 {
-	return sprintf(buffer, "%u\n", mk->mod->init_layout.size);
+	enum mod_mem_type type;
+	unsigned int size = 0;
+
+	for_init_mod_mem_type(type)
+		size += mk->mod->mem[type].size;
+	return sprintf(buffer, "%u\n", size);
 }
 
 static struct module_attribute modinfo_initsize =
@@ -1143,6 +1179,63 @@ void __weak module_arch_freeing_init(struct module *mod)
 {
 }
 
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+static bool mod_mem_use_vmalloc(enum mod_mem_type type)
+{
+	return type == MOD_DATA || type == MOD_RODATA || type == MOD_RO_AFTER_INIT;
+}
+#else
+static bool mod_mem_use_vmalloc(enum mod_mem_type type)
+{
+	return false;
+}
+#endif
+
+static void *module_memory_alloc(unsigned int size, enum mod_mem_type type)
+{
+	if (mod_mem_use_vmalloc(type))
+		return vzalloc(size);
+	return module_alloc(size);
+}
+
+static void module_memory_free(void *ptr, enum mod_mem_type type)
+{
+	if (mod_mem_use_vmalloc(type))
+		vfree(ptr);
+	else
+		module_memfree(ptr);
+}
+
+static void free_mod_mem(struct module *mod)
+{
+	/* free the memory in the right order to avoid use-after-free */
+	static enum mod_mem_type mod_mem_free_order[MOD_MEM_NUM_TYPES] = {
+		/* first free init sections */
+		MOD_INIT_TEXT,
+		MOD_INIT_DATA,
+		MOD_INIT_RODATA,
+
+		/* then core sections, except rw data */
+		MOD_TEXT,
+		MOD_RODATA,
+		MOD_RO_AFTER_INIT,
+
+		/* last, rw data */
+		MOD_DATA,
+	};
+	int i;
+
+	for (i = 0; i < MOD_MEM_NUM_TYPES; i++) {
+		enum mod_mem_type type = mod_mem_free_order[i];
+		struct module_memory *mod_mem = &mod->mem[type];
+
+		/* Free lock-classes; relies on the preceding sync_rcu(). */
+		lockdep_free_key_range(mod_mem->base, mod_mem->size);
+		if (mod_mem->size)
+			module_memory_free(mod_mem->base, type);
+	}
+}
+
 /* Free a module, remove from lists, etc. */
 static void free_module(struct module *mod)
 {
@@ -1189,18 +1282,10 @@ static void free_module(struct module *mod)
 
 	/* This may be empty, but that's OK */
 	module_arch_freeing_init(mod);
-	module_memfree(mod->init_layout.base);
 	kfree(mod->args);
 	percpu_modfree(mod);
 
-	/* Free lock-classes; relies on the preceding sync_rcu(). */
-	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
-
-	/* Finally, free the core (containing the module structure) */
-	module_memfree(mod->core_layout.base);
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-	vfree(mod->data_layout.base);
-#endif
+	free_mod_mem(mod);
 }
 
 void *__symbol_get(const char *symbol)
@@ -1387,16 +1472,18 @@ unsigned int __weak arch_mod_section_prepend(struct module *mod,
 	return 0;
 }
 
-/* Update size with this section: return offset. */
-long module_get_offset(struct module *mod, unsigned int *size,
-		       Elf_Shdr *sechdr, unsigned int section)
+long module_get_offset_and_type(struct module *mod, enum mod_mem_type type,
+				Elf_Shdr *sechdr, unsigned int section)
 {
-	long ret;
+	long offset;
+	long mask = ((unsigned long)(type) & SH_ENTSIZE_TYPE_MASK) << SH_ENTSIZE_TYPE_SHIFT;
 
-	*size += arch_mod_section_prepend(mod, section);
-	ret = ALIGN(*size, sechdr->sh_addralign ?: 1);
-	*size = ret + sechdr->sh_size;
-	return ret;
+	mod->mem[type].size += arch_mod_section_prepend(mod, section);
+	offset = ALIGN(mod->mem[type].size, sechdr->sh_addralign ?: 1);
+	mod->mem[type].size = offset + sechdr->sh_size;
+
+	WARN_ON_ONCE(offset & mask);
+	return offset | mask;
 }
 
 static bool module_init_layout_section(const char *sname)
@@ -1428,6 +1515,20 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		{ SHF_WRITE | SHF_ALLOC, ARCH_SHF_SMALL },
 		{ ARCH_SHF_SMALL | SHF_ALLOC, 0 }
 	};
+	static int core_m_to_mem_type[] = {
+		MOD_TEXT,
+		MOD_RODATA,
+		MOD_RO_AFTER_INIT,
+		MOD_DATA,
+		MOD_INVALID,
+	};
+	static int init_m_to_mem_type[] = {
+		MOD_INIT_TEXT,
+		MOD_INIT_RODATA,
+		MOD_INVALID,
+		MOD_INIT_DATA,
+		MOD_INVALID,
+	};
 	unsigned int m, i;
 
 	for (i = 0; i < info->hdr->e_shnum; i++)
@@ -1435,41 +1536,30 @@ static void layout_sections(struct module *mod, struct load_info *info)
 
 	pr_debug("Core section allocation order:\n");
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
+		enum mod_mem_type type = core_m_to_mem_type[m];
+
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
 			const char *sname = info->secstrings + s->sh_name;
-			unsigned int *sizep;
 
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
 			    || module_init_layout_section(sname))
 				continue;
-			sizep = m ? &mod->data_layout.size : &mod->core_layout.size;
-			s->sh_entsize = module_get_offset(mod, sizep, s, i);
+
+			if (WARN_ON_ONCE(type == MOD_INVALID))
+				continue;
+
+			s->sh_entsize = module_get_offset_and_type(mod, type, s, i);
 			pr_debug("\t%s\n", sname);
 		}
-		switch (m) {
-		case 0: /* executable */
-			mod->core_layout.size = strict_align(mod->core_layout.size);
-			mod->core_layout.text_size = mod->core_layout.size;
-			break;
-		case 1: /* RO: text and ro-data */
-			mod->data_layout.size = strict_align(mod->data_layout.size);
-			mod->data_layout.ro_size = mod->data_layout.size;
-			break;
-		case 2: /* RO after init */
-			mod->data_layout.size = strict_align(mod->data_layout.size);
-			mod->data_layout.ro_after_init_size = mod->data_layout.size;
-			break;
-		case 4: /* whole core */
-			mod->data_layout.size = strict_align(mod->data_layout.size);
-			break;
-		}
 	}
 
 	pr_debug("Init section allocation order:\n");
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
+		enum mod_mem_type type = init_m_to_mem_type[m];
+
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
 			const char *sname = info->secstrings + s->sh_name;
@@ -1479,30 +1569,13 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			    || s->sh_entsize != ~0UL
 			    || !module_init_layout_section(sname))
 				continue;
-			s->sh_entsize = (module_get_offset(mod, &mod->init_layout.size, s, i)
-					 | INIT_OFFSET_MASK);
+
+			if (WARN_ON_ONCE(type == MOD_INVALID))
+				continue;
+
+			s->sh_entsize = module_get_offset_and_type(mod, type, s, i);
 			pr_debug("\t%s\n", sname);
 		}
-		switch (m) {
-		case 0: /* executable */
-			mod->init_layout.size = strict_align(mod->init_layout.size);
-			mod->init_layout.text_size = mod->init_layout.size;
-			break;
-		case 1: /* RO: text and ro-data */
-			mod->init_layout.size = strict_align(mod->init_layout.size);
-			mod->init_layout.ro_size = mod->init_layout.size;
-			break;
-		case 2:
-			/*
-			 * RO after init doesn't apply to init_layout (only
-			 * core_layout), so it just takes the value of ro_size.
-			 */
-			mod->init_layout.ro_after_init_size = mod->init_layout.ro_size;
-			break;
-		case 4: /* whole init */
-			mod->init_layout.size = strict_align(mod->init_layout.size);
-			break;
-		}
 	}
 }
 
@@ -2120,74 +2193,42 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 
 static int move_module(struct module *mod, struct load_info *info)
 {
+	enum mod_mem_type type;
 	int i;
 	void *ptr;
 
-	/* Do the allocs. */
-	ptr = module_alloc(mod->core_layout.size);
-	/*
-	 * The pointer to this block is stored in the module structure
-	 * which is inside the block. Just mark it as not being a
-	 * leak.
-	 */
-	kmemleak_not_leak(ptr);
-	if (!ptr)
-		return -ENOMEM;
-
-	memset(ptr, 0, mod->core_layout.size);
-	mod->core_layout.base = ptr;
+	for_each_mod_mem_type(type) {
+		if (!mod->mem[type].size) {
+			mod->mem[type].base = NULL;
+			continue;
+		}
+		mod->mem[type].size = PAGE_ALIGN(mod->mem[type].size);
+		ptr = module_memory_alloc(mod->mem[type].size, type);
 
-	if (mod->init_layout.size) {
-		ptr = module_alloc(mod->init_layout.size);
 		/*
 		 * The pointer to this block is stored in the module structure
-		 * which is inside the block. This block doesn't need to be
-		 * scanned as it contains data and code that will be freed
-		 * after the module is initialized.
+		 * which is inside the block. Just mark it as not being a
+		 * leak.
 		 */
 		kmemleak_ignore(ptr);
-		if (!ptr) {
-			module_memfree(mod->core_layout.base);
-			return -ENOMEM;
-		}
-		memset(ptr, 0, mod->init_layout.size);
-		mod->init_layout.base = ptr;
-	} else
-		mod->init_layout.base = NULL;
-
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-	/* Do the allocs. */
-	ptr = vzalloc(mod->data_layout.size);
-	/*
-	 * The pointer to this block is stored in the module structure
-	 * which is inside the block. Just mark it as not being a
-	 * leak.
-	 */
-	kmemleak_not_leak(ptr);
-	if (!ptr) {
-		module_memfree(mod->core_layout.base);
-		module_memfree(mod->init_layout.base);
-		return -ENOMEM;
+		if (!ptr)
+			goto out_enomem;
+		memset(ptr, 0, mod->mem[type].size);
+		mod->mem[type].base = ptr;
 	}
 
-	mod->data_layout.base = ptr;
-#endif
 	/* Transfer each section which specifies SHF_ALLOC */
 	pr_debug("final section addresses:\n");
 	for (i = 0; i < info->hdr->e_shnum; i++) {
 		void *dest;
 		Elf_Shdr *shdr = &info->sechdrs[i];
+		enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
 
 		if (!(shdr->sh_flags & SHF_ALLOC))
 			continue;
 
-		if (shdr->sh_entsize & INIT_OFFSET_MASK)
-			dest = mod->init_layout.base
-				+ (shdr->sh_entsize & ~INIT_OFFSET_MASK);
-		else if (!(shdr->sh_flags & SHF_EXECINSTR))
-			dest = mod->data_layout.base + shdr->sh_entsize;
-		else
-			dest = mod->core_layout.base + shdr->sh_entsize;
+		dest = mod->mem[type].base +
+			(shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
 
 		if (shdr->sh_type != SHT_NOBITS)
 			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
@@ -2198,6 +2239,10 @@ static int move_module(struct module *mod, struct load_info *info)
 	}
 
 	return 0;
+out_enomem:
+	for (type--; type >= 0; type--)
+		module_memory_free(mod->mem[type].base, type);
+	return -ENOMEM;
 }
 
 static int check_module_license_and_versions(struct module *mod)
@@ -2237,17 +2282,20 @@ static int check_module_license_and_versions(struct module *mod)
 
 static void flush_module_icache(const struct module *mod)
 {
+	enum mod_mem_type type;
+
 	/*
 	 * Flush the instruction cache, since we've played with text.
 	 * Do it before processing of module parameters, so the module
 	 * can provide parameter accessor functions of its own.
 	 */
-	if (mod->init_layout.base)
-		flush_icache_range((unsigned long)mod->init_layout.base,
-				   (unsigned long)mod->init_layout.base
-				   + mod->init_layout.size);
-	flush_icache_range((unsigned long)mod->core_layout.base,
-			   (unsigned long)mod->core_layout.base + mod->core_layout.size);
+	for_each_mod_mem_type(type) {
+		const struct module_memory *mod_mem = &mod->mem[type];
+
+		if (mod_mem->size)
+			flush_icache_range((unsigned long)mod_mem->base,
+					   (unsigned long)mod_mem->base + mod_mem->size);
+	}
 }
 
 bool __weak module_elf_check_arch(Elf_Ehdr *hdr)
@@ -2350,11 +2398,8 @@ static void module_deallocate(struct module *mod, struct load_info *info)
 {
 	percpu_modfree(mod);
 	module_arch_freeing_init(mod);
-	module_memfree(mod->init_layout.base);
-	module_memfree(mod->core_layout.base);
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-	vfree(mod->data_layout.base);
-#endif
+
+	free_mod_mem(mod);
 }
 
 int __weak module_finalize(const Elf_Ehdr *hdr,
@@ -2415,7 +2460,9 @@ static void do_mod_ctors(struct module *mod)
 /* For freeing module_init on success, in case kallsyms traversing */
 struct mod_initfree {
 	struct llist_node node;
-	void *module_init;
+	void *init_text;
+	void *init_data;
+	void *init_rodata;
 };
 
 static void do_free_init(struct work_struct *w)
@@ -2429,7 +2476,9 @@ static void do_free_init(struct work_struct *w)
 
 	llist_for_each_safe(pos, n, list) {
 		initfree = container_of(pos, struct mod_initfree, node);
-		module_memfree(initfree->module_init);
+		module_memfree(initfree->init_text);
+		module_memfree(initfree->init_data);
+		module_memfree(initfree->init_rodata);
 		kfree(initfree);
 	}
 }
@@ -2450,13 +2499,16 @@ static noinline int do_init_module(struct module *mod)
 {
 	int ret = 0;
 	struct mod_initfree *freeinit;
+	enum mod_mem_type type;
 
 	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
 	if (!freeinit) {
 		ret = -ENOMEM;
 		goto fail;
 	}
-	freeinit->module_init = mod->init_layout.base;
+	freeinit->init_text = mod->mem[MOD_INIT_TEXT].base;
+	freeinit->init_data = mod->mem[MOD_INIT_DATA].base;
+	freeinit->init_rodata = mod->mem[MOD_INIT_RODATA].base;
 
 	do_mod_ctors(mod);
 	/* Start the module */
@@ -2492,8 +2544,8 @@ static noinline int do_init_module(struct module *mod)
 	if (!mod->async_probe_requested)
 		async_synchronize_full();
 
-	ftrace_free_mem(mod, mod->init_layout.base, mod->init_layout.base +
-			mod->init_layout.size);
+	ftrace_free_mem(mod, mod->mem[MOD_INIT_TEXT].base,
+			mod->mem[MOD_INIT_TEXT].base + mod->mem[MOD_INIT_TEXT].size);
 	mutex_lock(&module_mutex);
 	/* Drop initial reference. */
 	module_put(mod);
@@ -2505,11 +2557,10 @@ static noinline int do_init_module(struct module *mod)
 	module_enable_ro(mod, true);
 	mod_tree_remove_init(mod);
 	module_arch_freeing_init(mod);
-	mod->init_layout.base = NULL;
-	mod->init_layout.size = 0;
-	mod->init_layout.ro_size = 0;
-	mod->init_layout.ro_after_init_size = 0;
-	mod->init_layout.text_size = 0;
+	for_init_mod_mem_type(type) {
+		mod->mem[type].base = NULL;
+		mod->mem[type].size = 0;
+	}
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointer */
 	mod->btf_data = NULL;
@@ -2698,6 +2749,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	struct module *mod;
 	long err = 0;
 	char *after_dashes;
+	enum mod_mem_type type;
 
 	/*
 	 * Do the signature check (if any) first. All that
@@ -2909,7 +2961,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mutex_unlock(&module_mutex);
  free_module:
 	/* Free lock-classes; relies on the preceding sync_rcu() */
-	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
+	for_core_mod_mem_type(type) {
+		lockdep_free_key_range(mod->mem[type].base,
+				       mod->mem[type].size);
+	}
 
 	module_deallocate(mod, info);
  free_copy:
@@ -3060,20 +3115,21 @@ bool is_module_address(unsigned long addr)
 struct module *__module_address(unsigned long addr)
 {
 	struct module *mod;
-	struct mod_tree_root *tree;
 
 	if (addr >= mod_tree.addr_min && addr <= mod_tree.addr_max)
-		tree = &mod_tree;
+		goto lookup;
+
 #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-	else if (addr >= mod_data_tree.addr_min && addr <= mod_data_tree.addr_max)
-		tree = &mod_data_tree;
+	if (addr >= mod_tree.data_addr_min && addr <= mod_tree.data_addr_max)
+		goto lookup;
 #endif
-	else
-		return NULL;
 
+	return NULL;
+
+lookup:
 	module_assert_mutex_or_preempt();
 
-	mod = mod_find(addr, tree);
+	mod = mod_find(addr, &mod_tree);
 	if (mod) {
 		BUG_ON(!within_module(addr, mod));
 		if (mod->state == MODULE_STATE_UNFORMED)
@@ -3112,9 +3168,13 @@ struct module *__module_text_address(unsigned long addr)
 {
 	struct module *mod = __module_address(addr);
 	if (mod) {
+		struct module_memory *text_mem, *init_text_mem;
+
+		text_mem = &mod->mem[MOD_TEXT];
+		init_text_mem = &mod->mem[MOD_INIT_TEXT];
 		/* Make sure it's within the text section. */
-		if (!within(addr, mod->init_layout.base, mod->init_layout.text_size)
-		    && !within(addr, mod->core_layout.base, mod->core_layout.text_size))
+		if (!within(addr, text_mem->base, text_mem->size)
+		    && !within(addr, init_text_mem->base, init_text_mem->size))
 			mod = NULL;
 	}
 	return mod;
diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index cf5b9f1e6ec4..d22c21400342 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -62,6 +62,16 @@ static void m_stop(struct seq_file *m, void *p)
 	mutex_unlock(&module_mutex);
 }
 
+static unsigned int module_total_size(struct module *mod)
+{
+	int size = 0;
+	enum mod_mem_type type;
+
+	for_each_mod_mem_type(type)
+		size += mod->mem[type].size;
+	return size;
+}
+
 static int m_show(struct seq_file *m, void *p)
 {
 	struct module *mod = list_entry(p, struct module, list);
@@ -73,10 +83,7 @@ static int m_show(struct seq_file *m, void *p)
 	if (mod->state == MODULE_STATE_UNFORMED)
 		return 0;
 
-	size = mod->init_layout.size + mod->core_layout.size;
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-	size += mod->data_layout.size;
-#endif
+	size = module_total_size(mod);
 	seq_printf(m, "%s %u", mod->name, size);
 	print_unload_info(m, mod);
 
@@ -86,7 +93,7 @@ static int m_show(struct seq_file *m, void *p)
 		   mod->state == MODULE_STATE_COMING ? "Loading" :
 		   "Live");
 	/* Used by oprofile and other similar tools. */
-	value = m->private ? NULL : mod->core_layout.base;
+	value = m->private ? NULL : mod->mem[MOD_TEXT].base;
 	seq_printf(m, " 0x%px", value);
 
 	/* Taints info */
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 14fbea66f12f..2518e135fda5 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -11,82 +11,40 @@
 #include <linux/set_memory.h>
 #include "internal.h"
 
-/*
- * LKM RO/NX protection: protect module's text/ro-data
- * from modification and any data from execution.
- *
- * General layout of module is:
- *          [text] [read-only-data] [ro-after-init] [writable data]
- * text_size -----^                ^               ^               ^
- * ro_size ------------------------|               |               |
- * ro_after_init_size -----------------------------|               |
- * size -----------------------------------------------------------|
- *
- * These values are always page-aligned (as is base) when
- * CONFIG_STRICT_MODULE_RWX is set.
- */
-
-/*
- * Since some arches are moving towards PAGE_KERNEL module allocations instead
- * of PAGE_KERNEL_EXEC, keep frob_text() and module_enable_x() independent of
- * CONFIG_STRICT_MODULE_RWX because they are needed regardless of whether we
- * are strict.
- */
-static void frob_text(const struct module_layout *layout,
-		      int (*set_memory)(unsigned long start, int num_pages))
-{
-	set_memory((unsigned long)layout->base,
-		   PAGE_ALIGN(layout->text_size) >> PAGE_SHIFT);
-}
-
-static void frob_rodata(const struct module_layout *layout,
-		 int (*set_memory)(unsigned long start, int num_pages))
-{
-	set_memory((unsigned long)layout->base + layout->text_size,
-		   (layout->ro_size - layout->text_size) >> PAGE_SHIFT);
-}
-
-static void frob_ro_after_init(const struct module_layout *layout,
-			int (*set_memory)(unsigned long start, int num_pages))
+bool module_check_misalignment(const struct module *mod)
 {
-	set_memory((unsigned long)layout->base + layout->ro_size,
-		   (layout->ro_after_init_size - layout->ro_size) >> PAGE_SHIFT);
-}
+	enum mod_mem_type type;
 
-static void frob_writable_data(const struct module_layout *layout,
-			int (*set_memory)(unsigned long start, int num_pages))
-{
-	set_memory((unsigned long)layout->base + layout->ro_after_init_size,
-		   (layout->size - layout->ro_after_init_size) >> PAGE_SHIFT);
-}
+	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		return false;
 
-static bool layout_check_misalignment(const struct module_layout *layout)
-{
-	return WARN_ON(!PAGE_ALIGNED(layout->base)) ||
-	       WARN_ON(!PAGE_ALIGNED(layout->text_size)) ||
-	       WARN_ON(!PAGE_ALIGNED(layout->ro_size)) ||
-	       WARN_ON(!PAGE_ALIGNED(layout->ro_after_init_size)) ||
-	       WARN_ON(!PAGE_ALIGNED(layout->size));
+	for_each_mod_mem_type(type) {
+		if (WARN_ON(!PAGE_ALIGNED(mod->mem[type].base)))
+			return true;
+	}
+	return false;
 }
 
-bool module_check_misalignment(const struct module *mod)
+static void module_set_memory(
+	const struct module *mod, enum mod_mem_type type,
+	int (*set_memory)(unsigned long start, int num_pages))
 {
-	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-		return false;
+	const struct module_memory *mod_mem = &mod->mem[type];
 
-	return layout_check_misalignment(&mod->core_layout) ||
-	       layout_check_misalignment(&mod->data_layout) ||
-	       layout_check_misalignment(&mod->init_layout);
+	set_vm_flush_reset_perms(mod_mem->base);
+	set_memory((unsigned long)mod_mem->base, mod_mem->size >> PAGE_SHIFT);
 }
 
+/*
+ * Since some arches are moving towards PAGE_KERNEL module allocations instead
+ * of PAGE_KERNEL_EXEC, keep module_enable_x() independent of
+ * CONFIG_STRICT_MODULE_RWX because they are needed regardless of whether we
+ * are strict.
+ */
 void module_enable_x(const struct module *mod)
 {
-	if (!PAGE_ALIGNED(mod->core_layout.base) ||
-	    !PAGE_ALIGNED(mod->init_layout.base))
-		return;
-
-	frob_text(&mod->core_layout, set_memory_x);
-	frob_text(&mod->init_layout, set_memory_x);
+	module_set_memory(mod, MOD_TEXT, set_memory_x);
+	module_set_memory(mod, MOD_INIT_TEXT, set_memory_x);
 }
 
 void module_enable_ro(const struct module *mod, bool after_init)
@@ -98,28 +56,27 @@ void module_enable_ro(const struct module *mod, bool after_init)
 		return;
 #endif
 
-	set_vm_flush_reset_perms(mod->core_layout.base);
-	set_vm_flush_reset_perms(mod->init_layout.base);
-	frob_text(&mod->core_layout, set_memory_ro);
-
-	frob_rodata(&mod->data_layout, set_memory_ro);
-	frob_text(&mod->init_layout, set_memory_ro);
-	frob_rodata(&mod->init_layout, set_memory_ro);
+	module_set_memory(mod, MOD_TEXT, set_memory_ro);
+	module_set_memory(mod, MOD_INIT_TEXT, set_memory_ro);
+	module_set_memory(mod, MOD_RODATA, set_memory_ro);
+	module_set_memory(mod, MOD_INIT_RODATA, set_memory_ro);
 
 	if (after_init)
-		frob_ro_after_init(&mod->data_layout, set_memory_ro);
+		module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
 }
 
 void module_enable_nx(const struct module *mod)
 {
+	enum mod_mem_type type;
+
 	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
 		return;
 
-	frob_rodata(&mod->data_layout, set_memory_nx);
-	frob_ro_after_init(&mod->data_layout, set_memory_nx);
-	frob_writable_data(&mod->data_layout, set_memory_nx);
-	frob_rodata(&mod->init_layout, set_memory_nx);
-	frob_writable_data(&mod->init_layout, set_memory_nx);
+	for_each_mod_mem_type(type) {
+		if (type == MOD_TEXT || type == MOD_INIT_TEXT)
+			continue;
+		module_set_memory(mod, type, set_memory_nx);
+	}
 }
 
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
diff --git a/kernel/module/tree_lookup.c b/kernel/module/tree_lookup.c
index 8ec5cfd60496..21c8cf1906d6 100644
--- a/kernel/module/tree_lookup.c
+++ b/kernel/module/tree_lookup.c
@@ -21,16 +21,16 @@
 
 static __always_inline unsigned long __mod_tree_val(struct latch_tree_node *n)
 {
-	struct module_layout *layout = container_of(n, struct module_layout, mtn.node);
+	struct module_memory *mod_mem = container_of(n, struct module_memory, mtn.node);
 
-	return (unsigned long)layout->base;
+	return (unsigned long)mod_mem->base;
 }
 
 static __always_inline unsigned long __mod_tree_size(struct latch_tree_node *n)
 {
-	struct module_layout *layout = container_of(n, struct module_layout, mtn.node);
+	struct module_memory *mod_mem = container_of(n, struct module_memory, mtn.node);
 
-	return (unsigned long)layout->size;
+	return (unsigned long)mod_mem->size;
 }
 
 static __always_inline bool
@@ -77,32 +77,33 @@ static void __mod_tree_remove(struct mod_tree_node *node, struct mod_tree_root *
  */
 void mod_tree_insert(struct module *mod)
 {
-	mod->core_layout.mtn.mod = mod;
-	mod->init_layout.mtn.mod = mod;
+	enum mod_mem_type type;
 
-	__mod_tree_insert(&mod->core_layout.mtn, &mod_tree);
-	if (mod->init_layout.size)
-		__mod_tree_insert(&mod->init_layout.mtn, &mod_tree);
-
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-	mod->data_layout.mtn.mod = mod;
-	__mod_tree_insert(&mod->data_layout.mtn, &mod_data_tree);
-#endif
+	for_each_mod_mem_type(type) {
+		mod->mem[type].mtn.mod = mod;
+		if (mod->mem[type].size)
+			__mod_tree_insert(&mod->mem[type].mtn, &mod_tree);
+	}
 }
 
 void mod_tree_remove_init(struct module *mod)
 {
-	if (mod->init_layout.size)
-		__mod_tree_remove(&mod->init_layout.mtn, &mod_tree);
+	enum mod_mem_type type;
+
+	for_init_mod_mem_type(type) {
+		if (mod->mem[type].size)
+			__mod_tree_remove(&mod->mem[type].mtn, &mod_tree);
+	}
 }
 
 void mod_tree_remove(struct module *mod)
 {
-	__mod_tree_remove(&mod->core_layout.mtn, &mod_tree);
-	mod_tree_remove_init(mod);
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-	__mod_tree_remove(&mod->data_layout.mtn, &mod_data_tree);
-#endif
+	enum mod_mem_type type;
+
+	for_each_mod_mem_type(type) {
+		if (mod->mem[type].size)
+			__mod_tree_remove(&mod->mem[type].mtn, &mod_tree);
+	}
 }
 
 struct module *mod_find(unsigned long addr, struct mod_tree_root *tree)
-- 
2.30.2

