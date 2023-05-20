Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D35F70A730
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjETKfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETKfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:35:09 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 137ABE49
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 03:35:06 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxKupZomhkLmgKAA--.17997S3;
        Sat, 20 May 2023 18:35:05 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxMuVXomhkPJxrAA--.49896S3;
        Sat, 20 May 2023 18:35:04 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Add support to clone a time namespace
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1684292580-2455-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H6wtsFX+EUqzgseNmEW7FJk4b7b_PmcxKBiYu0qdHGwJQ@mail.gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <23ed6b8b-be53-bde0-717a-9eded1ad3780@loongson.cn>
Date:   Sat, 20 May 2023 18:35:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6wtsFX+EUqzgseNmEW7FJk4b7b_PmcxKBiYu0qdHGwJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxMuVXomhkPJxrAA--.49896S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKrWkZFy3WrWUJryUJrW7CFg_yoW7Ar4fpF
        WfAFn2vw42qrySgr18Jw1Duw1YywnrGw4FgF15KF4SyF4IvFy2vF10yrZ5JFWFy3y8Gr17
        uayIqwsYvan0qw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8fsqJUUUUU==
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/18/2023 10:25 AM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> The layout of vdso data (loongarch_vdso_data):
>
>        struct vdso_pcpu_data pdata[NR_CPUS];
>        struct vdso_data data[CS_BASES];
>
> VDSO_DATA_SIZE is the page aligned size of loongarch_vdso_data, and in
> memory, vdso code is above vdso data.
>
> Then, get_vdso_base() returns the start of vdso code, and
> get_vdso_data() returns the start of vdso data.
>
> In your patch, __arch_get_timens_vdso_data() returns get_vdso_data() +
> PAGE_SIZE, but you don't increase the size of loongarch_vdso_data. The
> result is it returns an address in vdso code.
>
> Now, do you know what the problem is? Or still insist that "I have tested"?

Please review the following changes based on the current patch,
modify the layout of vvar to expand a page size for timens_data,
and also map it to zero pfn before creating time namespace, then
the last thing is to add the callback function vvar_fault().

$ git diff
diff --git a/arch/loongarch/include/asm/page.h 
b/arch/loongarch/include/asm/page.h
index fb5338b..26e8dcc 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -81,6 +81,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  #define __va(x)                ((void *)((unsigned long)(x) + 
PAGE_OFFSET - PHYS_OFFSET))

  #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
+#define sym_to_pfn(x)          __phys_to_pfn(__pa_symbol(x))

  #define virt_to_pfn(kaddr)     PFN_DOWN(PHYSADDR(kaddr))
  #define virt_to_page(kaddr)    pfn_to_page(virt_to_pfn(kaddr))
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index cf62103..3e89aca 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -23,7 +23,27 @@
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
+enum vvar_pages {
+       VVAR_DATA_PAGE_OFFSET,
+       VVAR_TIMENS_PAGE_OFFSET,
+};
+
  extern char vdso_start[], vdso_end[];
+extern unsigned long zero_pfn;

  /* Kernel-provided data used by the VDSO. */
  static union {
@@ -42,6 +62,40 @@ static int vdso_mremap(const struct 
vm_special_mapping *sm, struct vm_area_struc
         return 0;
  }

+static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
+                            struct vm_area_struct *vma, struct vm_fault 
*vmf)
+{
+       struct page *timens_page = find_timens_vvar_page(vma);
+       unsigned long pfn;
+
+       switch (vmf->pgoff) {
+       case VVAR_DATA_PAGE_OFFSET:
+               if (timens_page)
+                       pfn = page_to_pfn(timens_page);
+               else
+                       pfn = sym_to_pfn(vdso_data);
+               break;
+#ifdef CONFIG_TIME_NS
+       case VVAR_TIMENS_PAGE_OFFSET:
+               /*
+                * If a task belongs to a time namespace then a namespace
+                * specific VVAR is mapped with the 
VVAR_DATA_PAGE_OFFSET and
+                * the real VVAR page is mapped with the 
VVAR_TIMENS_PAGE_OFFSET
+                * offset.
+                * See also the comment near timens_setup_vdso_data().
+                */
+               if (!timens_page)
+                       return VM_FAULT_SIGBUS;
+               pfn = sym_to_pfn(vdso_data);
+               break;
+#endif /* CONFIG_TIME_NS */
+       default:
+               return VM_FAULT_SIGBUS;
+       }
+
+       return vmf_insert_pfn(vma, vmf->address, pfn);
+}
+
  struct loongarch_vdso_info vdso_info = {
         .vdso = vdso_start,
         .size = PAGE_SIZE,
@@ -52,6 +106,7 @@ struct loongarch_vdso_info vdso_info = {
         },
         .data_mapping = {
                 .name = "[vvar]",
+               .fault = vvar_fault,
         },
         .offset_sigreturn = vdso_offset_sigreturn,
  };
@@ -120,7 +175,7 @@ static unsigned long vdso_base(void)
  int arch_setup_additional_pages(struct linux_binprm *bprm, int 
uses_interp)
  {
         int ret;
-       unsigned long vvar_size, size, data_addr, vdso_addr;
+       unsigned long size, data_addr, vdso_addr;
         struct mm_struct *mm = current->mm;
         struct vm_area_struct *vma;
         struct loongarch_vdso_info *info = current->thread.vdso;
@@ -132,17 +187,16 @@ int arch_setup_additional_pages(struct 
linux_binprm *bprm, int uses_interp)
          * Determine total area size. This includes the VDSO data itself
          * and the data pages.
          */
-       vvar_size = VDSO_DATA_SIZE;
-       size = vvar_size + info->size;
+       size = VVAR_SIZE + info->size;

         data_addr = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
         if (IS_ERR_VALUE(data_addr)) {
                 ret = data_addr;
                 goto out;
         }
-       vdso_addr = data_addr + VDSO_DATA_SIZE;
+       vdso_addr = data_addr + VVAR_SIZE;

-       vma = _install_special_mapping(mm, data_addr, vvar_size,
+       vma = _install_special_mapping(mm, data_addr, VVAR_SIZE,
                                        VM_READ | VM_MAYREAD,
                                        &info->data_mapping);
         if (IS_ERR(vma)) {
@@ -153,7 +207,12 @@ int arch_setup_additional_pages(struct linux_binprm 
*bprm, int uses_interp)
         /* Map VDSO data page. */
         ret = remap_pfn_range(vma, data_addr,
                               virt_to_phys(&loongarch_vdso_data) >> 
PAGE_SHIFT,
-                             vvar_size, PAGE_READONLY);
+                             VDSO_DATA_SIZE, PAGE_READONLY);
+       if (ret)
+               goto out;
+
+       ret = remap_pfn_range(vma, data_addr + VDSO_DATA_SIZE, zero_pfn,
+                             PAGE_SIZE, PAGE_READONLY);
         if (ret)
                 goto out;

If you have any more comments, please let me know, thank you.
I will send v2 after waiting for some more feedbacks.

Thanks,
Tiezhu

