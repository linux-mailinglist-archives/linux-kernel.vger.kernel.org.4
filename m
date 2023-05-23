Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E05B70D255
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjEWDXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjEWDXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:23:11 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F72618E
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:23:07 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Ax3eqaMWxknCcLAA--.19119S3;
        Tue, 23 May 2023 11:23:06 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxFLGZMWxk3ttvAA--.56063S2;
        Tue, 23 May 2023 11:23:05 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2] LoongArch: Add support to clone a time namespace
Date:   Tue, 23 May 2023 11:23:04 +0800
Message-Id: <1684812184-5849-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8BxFLGZMWxk3ttvAA--.56063S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxuw4DJrW7KF1kurW7JF48tFb_yoWxWF4fpF
        WSkrnrtw4Utry8KryUJ3sruwn8Krn7Gw42gF1jgayfAF1I9ryDZr1vyr95AFWYy3ykGryx
        WaySqr45ZF4DXw7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
        YxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=
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
vdso_join_timens(), then the failed test can be fixed.

At the same time, modify the layout of vvar to expand a page size
for timens_data, and also map it to zero pfn before creating time
namespace.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig                         |  1 +
 arch/loongarch/include/asm/vdso/gettimeofday.h |  7 +++
 arch/loongarch/kernel/vdso.c                   | 63 +++++++++++++++++++++++---
 3 files changed, 65 insertions(+), 6 deletions(-)

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
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/include/asm/vdso/gettimeofday.h
index 7b2cd37..1af88ac 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -94,6 +94,13 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 	return get_vdso_data();
 }
 
+#ifdef CONFIG_TIME_NS
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
+{
+	return get_vdso_data() + PAGE_SIZE;
+}
+#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index eaebd2e..5bb2b4f 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -14,6 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/time_namespace.h>
 #include <linux/timekeeper_internal.h>
 
 #include <asm/page.h>
@@ -22,7 +23,22 @@
 #include <vdso/vsyscall.h>
 #include <generated/vdso-offsets.h>
 
+/*
+ * The layout of vvar:
+ *
+ *                 high
+ * +----------------+----------------+
+ * | timens_data    | PAGE_SIZE      |
+ * +----------------+----------------+
+ * | vdso_data      |                |
+ * | vdso_pcpu_data | VDSO_DATA_SIZE |
+ * +----------------+----------------+
+ *                 low
+ */
+#define VVAR_SIZE (VDSO_DATA_SIZE + PAGE_SIZE)
+
 extern char vdso_start[], vdso_end[];
+extern unsigned long zero_pfn;
 
 /* Kernel-provided data used by the VDSO. */
 static union {
@@ -73,6 +89,37 @@ static int __init init_vdso(void)
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
@@ -88,7 +135,7 @@ static unsigned long vdso_base(void)
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	int ret;
-	unsigned long vvar_size, size, data_addr, vdso_addr;
+	unsigned long size, data_addr, vdso_addr;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct loongarch_vdso_info *info = current->thread.vdso;
@@ -100,17 +147,16 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
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
+	vdso_addr = data_addr + VVAR_SIZE;
 
-	vma = _install_special_mapping(mm, data_addr, vvar_size,
+	vma = _install_special_mapping(mm, data_addr, VVAR_SIZE,
 				       VM_READ | VM_MAYREAD,
 				       &info->data_mapping);
 	if (IS_ERR(vma)) {
@@ -121,7 +167,12 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	/* Map VDSO data page. */
 	ret = remap_pfn_range(vma, data_addr,
 			      virt_to_phys(&loongarch_vdso_data) >> PAGE_SHIFT,
-			      vvar_size, PAGE_READONLY);
+			      VDSO_DATA_SIZE, PAGE_READONLY);
+	if (ret)
+		goto out;
+
+	ret = remap_pfn_range(vma, data_addr + VDSO_DATA_SIZE, zero_pfn,
+			      PAGE_SIZE, PAGE_READONLY);
 	if (ret)
 		goto out;
 
-- 
2.1.0

