Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A228B6F1716
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbjD1MB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjD1MB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:01:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851A51BEC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:01:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so84535355e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682683284; x=1685275284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPte/pKtqTO+AZafGTxmXrOl5pSZO0/CWxo2rC3YnZs=;
        b=D9Ug2iDIaCBa455YEXB0pLqOEYTMOM1r/7fk8K9lGH1dNTS8fVFclpVBPxfNrGJLOw
         KaQBHohnzVJrWOaRs8uJgZ9g9w/jVBvgyEEVfLlPH5frFMgPgjCB/dUCd5TpesPNHPp7
         VrNuAtBR+oi1LVL8zOJEyZKH935LdKrl4d8GQ78+nxplASPonmGwAb8TeyBvZDvg4wdP
         DO14ek8TP3GH/KvuVxbY0GT3jdZg6pNDls+UXYFUL6++7KkNbAFKS9V5ET2WxDvAJm6M
         VPjNt1HQ8u+x7ZzEhAuhPDeinB+Hg/eyLHkOg8dW4EeLwzj0vv4xERJpi2a8H06ZcgoZ
         giQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682683284; x=1685275284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPte/pKtqTO+AZafGTxmXrOl5pSZO0/CWxo2rC3YnZs=;
        b=PbtiIC30b5HjxvbzixxowhMGUJR4c97nacRm9MvM+PmuPdqOzIoz5VHOsU8kFp3SCU
         +VrQCWUhz+F39Uu709A1MSc9kMvATG1oO0lJvboj6wyqI7U5P4qdC4b0+UCDEbkVbeR+
         sk2Ddcu5gteMIuPxde3ktipfeIwoNHGf3u9DnxuxbJU9OgDEm9vamemC9T9QauL19amu
         p55OMVLcJ4h0+CadluWUIGcsWSBS1CB43hueNlFBGZ9fp1fwiVXaIrQi1n7F+fPorJIu
         1vL0/0+ZdYzaCPKWdMcCuGN+Q9XjIAyVPTvt9SHcxTwlOk3x4v38Jxszv97LbDU0A7U2
         iYaA==
X-Gm-Message-State: AC+VfDylC65m5rjqhap+Re+a5phMQ6l3UHx50eEGuhi6+cKRaGIPGVe6
        NjtpsgN4XeKSQcc+dfFk1Vulbw==
X-Google-Smtp-Source: ACHHUZ56NW1lU+tU1Ept9DHFEa6yhwXbLGLBDRLT8LZpAyx3okj6Vj4I+4BWrBpdsk1NON7Fn9nJ0A==
X-Received: by 2002:a05:600c:2183:b0:3f1:76d7:ae2b with SMTP id e3-20020a05600c218300b003f176d7ae2bmr4023406wme.13.1682683283971;
        Fri, 28 Apr 2023 05:01:23 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bcb92000000b003f24f245f57sm15383740wmi.42.2023.04.28.05.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 05:01:23 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 1/2] riscv: Fix huge_ptep_set_wrprotect when PTE is a NAPOT
Date:   Fri, 28 Apr 2023 14:01:19 +0200
Message-Id: <20230428120120.21620-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
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

We need to avoid inconsistencies across the PTEs that form a NAPOT
region, so when we write protect such a region, we should clear and flush
all the PTEs to make sure that any of those PTEs is not cached which would
result in such inconsistencies (arm64 does the same).

Fixes: f2aeb0118ddd ("riscv: mm: support Svnapot in hugetlb page")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/hugetlbpage.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index a163a3e0f0d4..238d00bdac14 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -218,6 +218,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 {
 	pte_t pte = ptep_get(ptep);
 	unsigned long order;
+	pte_t orig_pte;
 	int i, pte_num;
 
 	if (!pte_napot(pte)) {
@@ -228,9 +229,12 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	order = napot_cont_order(pte);
 	pte_num = napot_pte_num(order);
 	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
+	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
+
+	orig_pte = pte_wrprotect(orig_pte);
 
 	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
-		ptep_set_wrprotect(mm, addr, ptep);
+		set_pte_at(mm, addr, ptep, orig_pte);
 }
 
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-- 
2.37.2

