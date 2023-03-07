Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFDA6AEAD1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjCGRhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjCGRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:37:06 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBAA3CE2C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:33:11 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i10so14905746plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1678210391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhoxkcYGcQslA0UXxBRCIsDkoFsS09fOQ+XclLq53kM=;
        b=mO39Qo6ECScoQF+IDHRN1zjrEj8GF0iEketodESa4sMOO0NRvK8FPOdWkZ5/ZTd/SI
         HdAzpeIY5BrW7XUg3idWI6RrqTOeo00liqlZaOg/uNVjuyeLgWwebM7n9GW4xWG68dx+
         SXrVveli12m5pjVjKQ6qnc1v3XNlc1WT6AVDuPcDjK3/cV90H4x5b44Urll9WKHR1w13
         rku2ctQJjRYweu/6+fy5OQ+Kdwqgit7t0Fs3vx45orGTkvgerSaylqRD4JlhPXH0/sAt
         eO58HowFq49cstUJQOU/muo2osnG/IFqsPQ6mofwOnY63uPFyfzgWorVFiyXnrQMaG4P
         XRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhoxkcYGcQslA0UXxBRCIsDkoFsS09fOQ+XclLq53kM=;
        b=RH1FWuqEHA34kSSPorILDaCTj17fDps4ORSNLV4y+hljpb2Y8YiSVail0N6ay7f/hp
         UnjMVSO0Qj1zLjttEqOVVBPcMeaEBJITH1gg6Fi/DMN/SSFfatmJ2T2atlyP3rDf4FU1
         j4Sd0JXB86gVGoYmZnADsFAt+8h7FVs9oekFsYFaddcZ/EpMhkqVLsMZmmWBhEZ8U8Qe
         MOOKAltG5HPkUe9JfRMwhxOC2Dx5oebyDbB/6b45S2lgyFVZRAiL7R4x1ZARmkTuAdZS
         cetwBG++sIJzMB/YymKhCX/OD2Ie7ICDULs7wVsgDnwmbgAFZ3H7L8Yw2WDm1AgKL2PR
         ewug==
X-Gm-Message-State: AO0yUKWA+t/7ki39ec1m7Hv52CNJtpayzoE+qRtu0oQMWz5qTasdlGor
        HxfIqwokGFb/nuXFjy4CWLm1Uw==
X-Google-Smtp-Source: AK7set9rOJtXJscQ0vI9n+jnJLJIokrmeDZhJPAbMuRjssm/if74yj3G18y2Qge0STp7hZ1msOAxdw==
X-Received: by 2002:a05:6a20:1a9d:b0:be:a3b2:cc7d with SMTP id ci29-20020a056a201a9d00b000bea3b2cc7dmr13196243pzb.6.1678210391327;
        Tue, 07 Mar 2023 09:33:11 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id 1-20020a630301000000b004fb11a7f2d4sm7996185pgd.57.2023.03.07.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:33:10 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v17 5/7] RISC-V: Use IPIs for remote TLB flush when possible
Date:   Tue,  7 Mar 2023 23:02:29 +0530
Message-Id: <20230307173231.2189275-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307173231.2189275-1-apatel@ventanamicro.com>
References: <20230307173231.2189275-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have specialized interrupt controller (such as AIA IMSIC) which
allows supervisor mode to directly inject IPIs without any assistance
from M-mode or HS-mode then using such specialized interrupt controller,
we can do remote TLB flushes directly from supervisor mode instead of
using the SBI RFENCE calls.

This patch extends remote TLB flush functions to use supervisor mode
IPIs whenever direct supervisor mode IPIs.are supported by interrupt
controller.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/tlbflush.c | 93 +++++++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index ce7dfc81bb3f..91078377344d 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -7,14 +7,62 @@
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
+static inline void local_flush_tlb_range(unsigned long start,
+		unsigned long size, unsigned long stride)
+{
+	if (size <= stride)
+		local_flush_tlb_page(start);
+	else
+		local_flush_tlb_all();
+}
+
+static inline void local_flush_tlb_range_asid(unsigned long start,
+		unsigned long size, unsigned long stride, unsigned long asid)
+{
+	if (size <= stride)
+		local_flush_tlb_page_asid(start, asid);
+	else
+		local_flush_tlb_all_asid(asid);
+}
+
+static void __ipi_flush_tlb_all(void *info)
+{
+	local_flush_tlb_all();
+}
+
 void flush_tlb_all(void)
 {
-	sbi_remote_sfence_vma(NULL, 0, -1);
+	if (riscv_use_ipi_for_rfence())
+		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
+	else
+		sbi_remote_sfence_vma(NULL, 0, -1);
+}
+
+struct flush_tlb_range_data {
+	unsigned long asid;
+	unsigned long start;
+	unsigned long size;
+	unsigned long stride;
+};
+
+static void __ipi_flush_tlb_range_asid(void *info)
+{
+	struct flush_tlb_range_data *d = info;
+
+	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
+}
+
+static void __ipi_flush_tlb_range(void *info)
+{
+	struct flush_tlb_range_data *d = info;
+
+	local_flush_tlb_range(d->start, d->size, d->stride);
 }
 
-static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
-				  unsigned long size, unsigned long stride)
+static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
+			      unsigned long size, unsigned long stride)
 {
+	struct flush_tlb_range_data ftd;
 	struct cpumask *pmask = &mm->context.tlb_stale_mask;
 	struct cpumask *cmask = mm_cpumask(mm);
 	unsigned int cpuid;
@@ -39,19 +87,34 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
 		cpumask_andnot(pmask, pmask, cmask);
 
 		if (broadcast) {
-			sbi_remote_sfence_vma_asid(cmask, start, size, asid);
-		} else if (size <= stride) {
-			local_flush_tlb_page_asid(start, asid);
+			if (riscv_use_ipi_for_rfence()) {
+				ftd.asid = asid;
+				ftd.start = start;
+				ftd.size = size;
+				ftd.stride = stride;
+				on_each_cpu_mask(cmask,
+						 __ipi_flush_tlb_range_asid,
+						 &ftd, 1);
+			} else
+				sbi_remote_sfence_vma_asid(cmask,
+							   start, size, asid);
 		} else {
-			local_flush_tlb_all_asid(asid);
+			local_flush_tlb_range_asid(start, size, stride, asid);
 		}
 	} else {
 		if (broadcast) {
-			sbi_remote_sfence_vma(cmask, start, size);
-		} else if (size <= stride) {
-			local_flush_tlb_page(start);
+			if (riscv_use_ipi_for_rfence()) {
+				ftd.asid = 0;
+				ftd.start = start;
+				ftd.size = size;
+				ftd.stride = stride;
+				on_each_cpu_mask(cmask,
+						 __ipi_flush_tlb_range,
+						 &ftd, 1);
+			} else
+				sbi_remote_sfence_vma(cmask, start, size);
 		} else {
-			local_flush_tlb_all();
+			local_flush_tlb_range(start, size, stride);
 		}
 	}
 
@@ -60,23 +123,23 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__sbi_tlb_flush_range(mm, 0, -1, PAGE_SIZE);
+	__flush_tlb_range(mm, 0, -1, PAGE_SIZE);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
+	__flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PAGE_SIZE);
+	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
 }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PMD_SIZE);
+	__flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
 }
 #endif
-- 
2.34.1

