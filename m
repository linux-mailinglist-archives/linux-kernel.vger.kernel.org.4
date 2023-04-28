Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0396F6F1718
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345943AbjD1MC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjD1MC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:02:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC31FF0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:02:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f315712406so57950445e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682683345; x=1685275345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+IhJdlbzPopAgcnIQcMyy0yuzqBnz1h8mDocxofWCY=;
        b=aLYgN7VlR46N9WcDi53goFnZv+vG6n3pLEhhSP9AnlnYDiiuuH7hkDMkrbFyl/q8IU
         QqyxBo3ttSlxPV99BPEA855FtbCjlLBq+2yUTvTQrQdE3zs6TkyppYM8+4iJm0cSlyTZ
         4kJvdtC6YfTYisDIciOvBeSXMzj6JftKhpHLkM7+dbEncXDxKStkW/Yeosa1Ci8x2Xew
         TRKfi2Xbgzs5uPExZM9N2S626aiDKkYDfPfeLt0iG40V81YMQo2BzohjA180oQd3gl9r
         zn5JUkkEJIGXv7OzhafPO6q+n3QKY7b0LRP/qIzGwu7mBU9lh01fnfzJTPUA2ueO4c+s
         Tysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682683345; x=1685275345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+IhJdlbzPopAgcnIQcMyy0yuzqBnz1h8mDocxofWCY=;
        b=QPTQa7Y3uRum3RBslLyZAfmN6vJUlwqBweXe0RjYLd/oAAcdD1l34uCI3S7AXtmgCC
         fNLfok5rVlBL6R5Cl99sp7Bdnwb/q6dSLJBpk7lM7vmDrTnDrOZSDgALVHqmnIXjIgaI
         b4jQafgvPSCCc3O0+ibS6aE8h6byqqgICJT1ntQVCWJQomUZkrY1iu9bOr4p/FzTwkmJ
         4SnSe/xT9YpaL7IRKXADpF07ZubbIQGvKT7i2ljdZ8bGWs8XaEjzI7+y0YLsh4HtdsOY
         iBYXcG1M+2mfKnsh+NeyW6pV/O4onHpJLmRev1/WwubQaRGUZEalSRWeSU0YF5dGpNSS
         iiHQ==
X-Gm-Message-State: AC+VfDyRaVSlZDhevSXzipsmW/E4hW2AIaL1rGylZOE6NnIn0ugvvo8V
        p0ce5waOhQdc3SScj7wdZZNx5g==
X-Google-Smtp-Source: ACHHUZ5VIm/9FvBnliMEeY0Op5aLkD+MKAJ4pG2os4QAW4erFcKj2zX2YCBI9BaqYR1JhwIUBX2zdw==
X-Received: by 2002:a5d:68cb:0:b0:2f0:2c3c:b858 with SMTP id p11-20020a5d68cb000000b002f02c3cb858mr6046924wrw.31.1682683344886;
        Fri, 28 Apr 2023 05:02:24 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id x8-20020a05600c21c800b003f2390bdd0csm15487607wmj.32.2023.04.28.05.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 05:02:24 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 2/2] riscv: Implement missing huge_ptep_get
Date:   Fri, 28 Apr 2023 14:01:20 +0200
Message-Id: <20230428120120.21620-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230428120120.21620-1-alexghiti@rivosinc.com>
References: <20230428120120.21620-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

huge_ptep_get must be reimplemented in order to go through all the PTEs
of a NAPOT region: this is needed because the HW can update the A/D bits
of any of the PTE that constitutes the NAPOT region.

Fixes: f2aeb0118ddd ("riscv: mm: support Svnapot in hugetlb page")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/hugetlb.h |  3 +++
 arch/riscv/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index fe6f23006641..ce1ebda1a49a 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -36,6 +36,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       unsigned long addr, pte_t *ptep,
 			       pte_t pte, int dirty);
 
+#define __HAVE_ARCH_HUGE_PTEP_GET
+pte_t huge_ptep_get(pte_t *ptep);
+
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
 
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 238d00bdac14..e0ef56dc57b9 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -3,6 +3,30 @@
 #include <linux/err.h>
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
+pte_t huge_ptep_get(pte_t *ptep)
+{
+	unsigned long pte_num;
+	int i;
+	pte_t orig_pte = ptep_get(ptep);
+
+	if (!pte_present(orig_pte) || !pte_napot(orig_pte))
+		return orig_pte;
+
+	pte_num = napot_pte_num(napot_cont_order(orig_pte));
+
+	for (i = 0; i < pte_num; i++, ptep++) {
+		pte_t pte = ptep_get(ptep);
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+
+	return orig_pte;
+}
+
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 		      struct vm_area_struct *vma,
 		      unsigned long addr,
-- 
2.37.2

