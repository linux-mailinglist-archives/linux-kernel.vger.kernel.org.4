Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329395F56A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJEOom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJEOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:44:38 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6D2C301
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cjjRk
        IbFw7ZPJtS56W/SLnr0oycFTFI87OdoKaXglgc=; b=m4HRBFVjmX9Ijevx0WcCK
        l7UXTM2kgY4n5wp0tUtm4FSRxgHRk0w46j0zIwrsMQ3IEd7qxdJ/a5iRn+ew+fK4
        1oWG248XCouZSHQZVJ1D+6SjyX9u3/YOFycSUuutWjHYuKrc0umzaAp5lYXqBSx5
        AE0zV7I7c5fK18h0f9gqxY=
Received: from whoami-VirtualBox.. (unknown [223.72.43.15])
        by smtp9 (Coremail) with SMTP id DcCowADn7u4OmD1jjYE6Ag--.16997S2;
        Wed, 05 Oct 2022 22:43:27 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        anup@brainfault.org, atishp@rivosinc.com,
        conor.dooley@microchip.com, ajones@ventanamicro.com,
        guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, falcon@tinylab.org, tjytimi@163.com
Subject: [PATCH v1] riscv: bring up batched unmap tlb flush
Date:   Wed,  5 Oct 2022 22:43:24 +0800
Message-Id: <20221005144324.6157-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowADn7u4OmD1jjYE6Ag--.16997S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr1DZr17CF1UWrW5KFWkXrb_yoW3Jr13pF
        WDCrsYkFZ5GrnxGry2yrnrury3t39Y9a4ft343Zas0yrnFqryUCFs3Kw1kAr15JrZ5Ww13
        urZ0k34ru34UXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piNzV8UUUUU=
X-Originating-IP: [223.72.43.15]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbiZRCReF8ZUz16IQAAsv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For riscv, this feature can decrease the times of
flush_tlb_pages(), and decrease the times of boardcasting for SMP.
Add @start and @end in struct arch_tlbflush_unmap_barch in riscv
compared to x86, which can record the minimum and maximum addresses
in this flush batch to reduce the flush range.If there are a lot of 
pages to reclaim, or pages are shared with many tasks like server 
application,this feature is more beneficial.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---

This PATCH maybe conflict with patch v4 of arm64 batched unmap tlb flush
and patch v9 of IPI support for riscv.If this patch is ok,I will rebase
it on them.

I have test this patch in QEMU base on: 
https://lore.kernel.org/all/20220921084302.43631-3-yangyicong@huawei.com/

 #include <sys/types.h>
 #include <unistd.h>
 #include <sys/mman.h>
 #include <string.h>
 #include <time.h>
 #include <stdio.h>
 #include <stdlib.h>
 int main()
 {
 	 clock_t start,finish;
 	 double dur;
 #define SIZE (1 * 1024 * 1024 * 500)
         volatile unsigned char *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
                                          MAP_SHARED | MAP_ANONYMOUS, -1, 0);
	 for(int tt = 0; tt < 5; tt ++){
         	memset(p, 0x88, SIZE);
         	start = clock();
         	for (int k = 0; k < 10; k++) {
                	 /* swap in */
                 	for (int i = 0; i < SIZE; i += 4096) {
                        	 (void)p[i];
                 	}

                 	/* swap out */
                 	madvise(p, SIZE, MADV_PAGEOUT);
         	}
         	finish = clock();
         	dur = (double)(finish - start) / CLOCKS_PER_SEC;
         	printf("%f seconds this time\n",dur);
         }
    	 return 0;
         
 }
And in riscv QEMU, this patch decrease the average 27.1s to 26.7s of time cost
about this test app.Maybe the decrease will be more obvious for real CPU.

 arch/riscv/Kconfig                |  8 ++++++++
 arch/riscv/include/asm/tlbbatch.h | 18 ++++++++++++++++++
 arch/riscv/include/asm/tlbflush.h | 20 ++++++++++++++++++++
 arch/riscv/mm/tlbflush.c          | 18 ++++++++++++++++++
 arch/x86/include/asm/tlbflush.h   |  2 +-
 mm/rmap.c                         |  9 ++++-----
 6 files changed, 69 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/include/asm/tlbbatch.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59d18881f35b..03304d0e0c0a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -498,6 +498,14 @@ config ARCH_HAS_KEXEC_PURGATORY
 	depends on CRYPTO=y
 	depends on CRYPTO_SHA256=y
 
+config ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+	bool "Support batched unmap tlb flush"
+	help
+	  This will make tlb flush batched when unmap pages. If there are
+	  a lot of pages to reclaim, or pages are shared with many tasks
+	  like server device, this will decrease the times of flushing tlbs
+	  and broadcasting.
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/riscv/include/asm/tlbbatch.h b/arch/riscv/include/asm/tlbbatch.h
new file mode 100644
index 000000000000..357bb0f46cff
--- /dev/null
+++ b/arch/riscv/include/asm/tlbbatch.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ARCH_RISCV_TLBBATCH_H
+#define _ARCH_RISCV_TLBBATCH_H
+
+#include <linux/cpumask.h>
+
+struct arch_tlbflush_unmap_batch {
+	/*
+	 * Each bit set is a CPU that potentially has a TLB entry for one of
+	 * the PFNs being flushed. And the start and end will record the range
+	 * to be flush this batch.
+	 */
+	struct cpumask cpumask;
+	unsigned long start;
+	unsigned long end;
+};
+
+#endif /* _ARCH_RISCV_TLBBATCH_H */
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 801019381dea..e2d9dad08bd0 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -10,6 +10,8 @@
 #include <linux/mm_types.h>
 #include <asm/smp.h>
 #include <asm/errata_list.h>
+#include <asm/tlbbatch.h>
+#include <asm/page.h>
 
 #ifdef CONFIG_MMU
 static inline void local_flush_tlb_all(void)
@@ -59,4 +61,22 @@ static inline void flush_tlb_kernel_range(unsigned long start,
 	flush_tlb_all();
 }
 
+static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
+					unsigned long address, struct mm_struct *mm)
+{
+	/*
+	 * Each bit of cpumask is a CPU that potentially has a TLB entry for one of
+	 * the PFNs being flushed. And the start and end will record the range
+	 * to be flush this batch.
+	 */
+	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+
+	if (address < batch->start)
+		batch->start = address;
+	else if (address + PAGE_SIZE > batch->end)
+		batch->end = address + PAGE_SIZE;
+}
+
+extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+
 #endif /* _ASM_RISCV_TLBFLUSH_H */
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 37ed760d007c..6b117732200b 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -86,3 +86,21 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PMD_SIZE);
 }
 #endif
+void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
+{
+	unsigned int cpuid;
+	bool broadcast;
+
+	cpuid = get_cpu();
+
+	broadcast = cpumask_any_but(&batch->cpumask, cpuid) < nr_cpu_ids;
+	if (broadcast) {
+		sbi_remote_sfence_vma(&batch->cpumask, batch->start, batch->end - batch->start);
+	} else {
+		local_flush_tlb_all();
+	}
+
+	cpumask_clear(&batch->cpumask);
+
+	put_cpu();
+}
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index cda3118f3b27..9e7027ae256e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -252,7 +252,7 @@ static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 }
 
 static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
-					struct mm_struct *mm)
+					unsigned long address, struct mm_struct *mm)
 {
 	inc_mm_tlb_gen(mm);
 	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
diff --git a/mm/rmap.c b/mm/rmap.c
index 93d5a6f793d2..edae27aa20a9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -645,12 +645,12 @@ void try_to_unmap_flush_dirty(void)
 #define TLB_FLUSH_BATCH_PENDING_LARGE			\
 	(TLB_FLUSH_BATCH_PENDING_MASK / 2)
 
-static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
+static void set_tlb_ubc_flush_pending(struct mm_struct *mm, unsigned long address, bool writable)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 	int batch, nbatch;
 
-	arch_tlbbatch_add_mm(&tlb_ubc->arch, mm);
+	arch_tlbbatch_add_mm(&tlb_ubc->arch, address, mm);
 	tlb_ubc->flush_required = true;
 
 	/*
@@ -735,7 +735,7 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
 	}
 }
 #else
-static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
+static void set_tlb_ubc_flush_pending(struct mm_struct *mm, unsigned long address, bool writable)
 {
 }
 
@@ -1596,8 +1596,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * and traps if the PTE is unmapped.
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
-
-				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+				set_tlb_ubc_flush_pending(mm, address, pte_dirty(pteval));
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
-- 
2.34.1

