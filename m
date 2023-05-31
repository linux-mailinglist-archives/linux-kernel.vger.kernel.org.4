Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1DC71793D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjEaH5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjEaH5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:57:19 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D262E199D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:56:15 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxNvGT_XZkvuQCAA--.6409S3;
        Wed, 31 May 2023 15:56:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxMuWR_XZk4QuCAA--.13618S2;
        Wed, 31 May 2023 15:56:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3] LoongArch: Add support to clone a time namespace
Date:   Wed, 31 May 2023 15:56:01 +0800
Message-Id: <1685519761-20425-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxMuWR_XZk4QuCAA--.13618S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWfGFy8Cry8Zw18AryUKrWrGrg_yoWkuFWUpF
        Zakrs2qw4UKryfKryxJwn8uw15Jrn7uw4YgF4ag3ySyF1IvryUZF10yr95AFWYy3y8JryI
        grW8Zw4Yva1qqwUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When execute the following command to test clone3 on LoongArch:

  # cd tools/testing/selftests/clone3 && make && ./clone3

we can see the following error info:

  # [5719] Trying clone3() with flags 0x80 (size 0)
  # Invalid argument - Failed to create new process
  # [5719] clone3() with flags says: -22 expected 0
  not ok 18 [5719] Result (-22) is different than expected (0)

This is because if CONFIG_TIME_NS is not set, but the flag
CLONE_NEWTIME (0x80) is used to clone a time namespace, it
will return -EINVAL in copy_time_ns().

Here is the related code in include/linux/time_namespace.h:

  #ifdef CONFIG_TIME_NS
  ...
  struct time_namespace *copy_time_ns(unsigned long flags,
				      struct user_namespace *user_ns,
				      struct time_namespace *old_ns);
  ...
  #else
  ...
  static inline
  struct time_namespace *copy_time_ns(unsigned long flags,
				      struct user_namespace *user_ns,
				      struct time_namespace *old_ns)
  {
	  if (flags & CLONE_NEWTIME)
		  return ERR_PTR(-EINVAL);

	  return old_ns;
  }
  ...
  #endif

Here is the complete call stack:

  clone3()
    kernel_clone()
      copy_process()
        copy_namespaces()
          create_new_namespaces()
            copy_time_ns()
              clone_time_ns()

Because CONFIG_TIME_NS depends on GENERIC_VDSO_TIME_NS, select
GENERIC_VDSO_TIME_NS to enable CONFIG_TIME_NS to build the real
implementation of copy_time_ns() in kernel/time/namespace.c.

Additionally, it needs to define some arch dependent functions
such as __arch_get_timens_vdso_data(), arch_get_vdso_data() and
vdso_join_timens(), then the above failed test can be fixed.

At the same time, modify the layout of vvar to use a page size
for generic vdso data, expand a page size for timens vdso data
and assign LOONGARCH_VDSO_DATA_SIZE (maybe over a page size if
expand in the future) for loongarch vdso data, at last add the
callback function vvar_fault().

With this patch, the following failed test can be fixed too:

  # cd tools/testing/selftests/timens && make && ./timens

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

Special thanks Wang Rui and Youling for your suggestions offline.

 arch/loongarch/Kconfig                         |  1 +
 arch/loongarch/include/asm/page.h              |  1 +
 arch/loongarch/include/asm/vdso/gettimeofday.h | 10 ++-
 arch/loongarch/include/asm/vdso/vdso.h         | 30 ++++++--
 arch/loongarch/kernel/vdso.c                   | 98 +++++++++++++++++++++-----
 arch/loongarch/vdso/vgetcpu.c                  |  3 +-
 6 files changed, 120 insertions(+), 23 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d38b066..93b167f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -80,6 +80,7 @@ config LOONGARCH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_TIME_NS
 	select GPIOLIB
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index fb5338b..26e8dcc 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -81,6 +81,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+#define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
 #define virt_to_pfn(kaddr)	PFN_DOWN(PHYSADDR(kaddr))
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/include/asm/vdso/gettimeofday.h
index 7b2cd37..3c3043b 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -91,9 +91,17 @@ static inline bool loongarch_vdso_hres_capable(void)
 
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
-	return get_vdso_data();
+	return (const struct vdso_data *)get_vdso_data();
 }
 
+#ifdef CONFIG_TIME_NS
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
+{
+	return (const struct vdso_data *)(get_vdso_data() +
+		VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE);
+}
+#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
index 3b55d32..fa6049e 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -16,10 +16,31 @@ struct vdso_pcpu_data {
 
 struct loongarch_vdso_data {
 	struct vdso_pcpu_data pdata[NR_CPUS];
-	struct vdso_data data[CS_BASES]; /* Arch-independent data */
 };
 
-#define VDSO_DATA_SIZE PAGE_ALIGN(sizeof(struct loongarch_vdso_data))
+/*
+ * The layout of vvar:
+ *
+ *                      high
+ * +---------------------+--------------------------+
+ * | loongarch vdso data | LOONGARCH_VDSO_DATA_SIZE |
+ * +---------------------+--------------------------+
+ * | timens vdso data    | PAGE_SIZE                |
+ * +---------------------+--------------------------+
+ * | generic vdso data   | PAGE_SIZE                |
+ * +---------------------+--------------------------+
+ *                      low
+ */
+#define LOONGARCH_VDSO_DATA_SIZE PAGE_ALIGN(sizeof(struct loongarch_vdso_data))
+#define LOONGARCH_VDSO_DATA_PAGES (LOONGARCH_VDSO_DATA_SIZE >> PAGE_SHIFT)
+#define VVAR_SIZE (VVAR_LOONGARCH_PAGES_START * PAGE_SIZE + LOONGARCH_VDSO_DATA_SIZE)
+
+enum vvar_pages {
+	VVAR_GENERIC_PAGE_OFFSET,
+	VVAR_TIMENS_PAGE_OFFSET,
+	VVAR_LOONGARCH_PAGES_START,
+	VVAR_LOONGARCH_PAGES_END = VVAR_LOONGARCH_PAGES_START + LOONGARCH_VDSO_DATA_PAGES - 1,
+};
 
 static inline unsigned long get_vdso_base(void)
 {
@@ -34,10 +55,9 @@ static inline unsigned long get_vdso_base(void)
 	return addr;
 }
 
-static inline const struct vdso_data *get_vdso_data(void)
+static inline unsigned long get_vdso_data(void)
 {
-	return (const struct vdso_data *)(get_vdso_base()
-			- VDSO_DATA_SIZE + SMP_CACHE_BYTES * NR_CPUS);
+	return get_vdso_base() - VVAR_SIZE;
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index eaebd2e..cb75863 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -14,6 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/time_namespace.h>
 #include <linux/timekeeper_internal.h>
 
 #include <asm/page.h>
@@ -26,12 +27,17 @@ extern char vdso_start[], vdso_end[];
 
 /* Kernel-provided data used by the VDSO. */
 static union {
-	u8 page[VDSO_DATA_SIZE];
+	u8 page[PAGE_SIZE];
+	struct vdso_data data[CS_BASES];
+} generic_vdso_data __page_aligned_data;
+
+static union {
+	u8 page[LOONGARCH_VDSO_DATA_SIZE];
 	struct loongarch_vdso_data vdata;
 } loongarch_vdso_data __page_aligned_data;
 
 static struct page *vdso_pages[] = { NULL };
-struct vdso_data *vdso_data = loongarch_vdso_data.vdata.data;
+struct vdso_data *vdso_data = generic_vdso_data.data;
 struct vdso_pcpu_data *vdso_pdata = loongarch_vdso_data.vdata.pdata;
 
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
@@ -41,6 +47,43 @@ static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struc
 	return 0;
 }
 
+static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
+			     struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct page *timens_page = find_timens_vvar_page(vma);
+	unsigned long pfn;
+
+	switch (vmf->pgoff) {
+	case VVAR_GENERIC_PAGE_OFFSET:
+		if (timens_page)
+			pfn = page_to_pfn(timens_page);
+		else
+			pfn = sym_to_pfn(vdso_data);
+		break;
+#ifdef CONFIG_TIME_NS
+	case VVAR_TIMENS_PAGE_OFFSET:
+		/*
+		 * If a task belongs to a time namespace then a namespace specific
+		 * VVAR is mapped with the VVAR_GENERIC_PAGE_OFFSET and the real
+		 * VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET offset.
+		 * See also the comment near timens_setup_vdso_data().
+		 */
+		if (!timens_page)
+			return VM_FAULT_SIGBUS;
+		pfn = sym_to_pfn(vdso_data);
+		break;
+#endif /* CONFIG_TIME_NS */
+	case VVAR_LOONGARCH_PAGES_START ... VVAR_LOONGARCH_PAGES_END:
+		pfn = sym_to_pfn(&loongarch_vdso_data) +
+		      vmf->pgoff - VVAR_LOONGARCH_PAGES_START;
+		break;
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+
+	return vmf_insert_pfn(vma, vmf->address, pfn);
+}
+
 struct loongarch_vdso_info vdso_info = {
 	.vdso = vdso_start,
 	.size = PAGE_SIZE,
@@ -51,6 +94,7 @@ struct loongarch_vdso_info vdso_info = {
 	},
 	.data_mapping = {
 		.name = "[vvar]",
+		.fault = vvar_fault,
 	},
 	.offset_sigreturn = vdso_offset_sigreturn,
 };
@@ -73,6 +117,37 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_TIME_NS
+struct vdso_data *arch_get_vdso_data(void *vvar_page)
+{
+	return (struct vdso_data *)(vvar_page);
+}
+
+/*
+ * The vvar mapping contains data for a specific time namespace, so when a
+ * task changes namespace we must unmap its vvar data for the old namespace.
+ * Subsequent faults will map in data for the new namespace.
+ *
+ * For more details see timens_setup_vdso_data().
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+
+	VMA_ITERATOR(vmi, mm, 0);
+
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma_is_special_mapping(vma, &vdso_info.data_mapping))
+			zap_vma_pages(vma);
+	}
+	mmap_read_unlock(mm);
+
+	return 0;
+}
+#endif
+
 static unsigned long vdso_base(void)
 {
 	unsigned long base = STACK_TOP;
@@ -88,7 +163,7 @@ static unsigned long vdso_base(void)
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	int ret;
-	unsigned long vvar_size, size, data_addr, vdso_addr;
+	unsigned long size, data_addr, vdso_addr;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct loongarch_vdso_info *info = current->thread.vdso;
@@ -100,32 +175,23 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 * Determine total area size. This includes the VDSO data itself
 	 * and the data pages.
 	 */
-	vvar_size = VDSO_DATA_SIZE;
-	size = vvar_size + info->size;
+	size = VVAR_SIZE + info->size;
 
 	data_addr = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
 	if (IS_ERR_VALUE(data_addr)) {
 		ret = data_addr;
 		goto out;
 	}
-	vdso_addr = data_addr + VDSO_DATA_SIZE;
 
-	vma = _install_special_mapping(mm, data_addr, vvar_size,
-				       VM_READ | VM_MAYREAD,
+	vma = _install_special_mapping(mm, data_addr, VVAR_SIZE,
+				       VM_READ | VM_MAYREAD | VM_PFNMAP,
 				       &info->data_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out;
 	}
 
-	/* Map VDSO data page. */
-	ret = remap_pfn_range(vma, data_addr,
-			      virt_to_phys(&loongarch_vdso_data) >> PAGE_SHIFT,
-			      vvar_size, PAGE_READONLY);
-	if (ret)
-		goto out;
-
-	/* Map VDSO code page. */
+	vdso_addr = data_addr + VVAR_SIZE;
 	vma = _install_special_mapping(mm, vdso_addr, info->size,
 				       VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
 				       &info->code_mapping);
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index e02e775..e7884f88 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -21,7 +21,8 @@ static __always_inline int read_cpu_id(void)
 
 static __always_inline const struct vdso_pcpu_data *get_pcpu_data(void)
 {
-	return (struct vdso_pcpu_data *)(get_vdso_base() - VDSO_DATA_SIZE);
+	return (struct vdso_pcpu_data *)(get_vdso_data() +
+		VVAR_LOONGARCH_PAGES_START * PAGE_SIZE);
 }
 
 extern
-- 
2.1.0

