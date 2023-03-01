Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DBE6A68E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCAI10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCAI1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:27:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D0838EAC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:27:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h14so12330746wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 00:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677659237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/vQkURrK2ciTBU+Pt35U7ABlbP4247yVAlnFnqItRY=;
        b=3wXq47ftSOAUsi4xd1gwHP/t2Qx2KSSDziZTN3nPLxzatHbZBgdoCKE6SAPoS7W1lu
         1kuOgyEs4Tjc+RkZd93D/tViTECmkVthQO5CeRnm6i21/GbHLDryAaco6DrEB+OakKn+
         0nm0nkzgPiEJWD7GeblE24M92kfnQKUPRy7q6cGr6YX61df1jswOf9aBCWEmNb5TNmnA
         6eE31v0qusiKaLJwSliWrxA/5MBcJYNkovnh+YXSKczWctIzFxeTmcgoJqDfCdNVVqgs
         W+7plCVvMuDDogVPvBOFfeTBth2+l5dy/CkjPMJXZ08frdc3+flmoNRZ4Ys8R/GaXzTv
         12bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677659237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/vQkURrK2ciTBU+Pt35U7ABlbP4247yVAlnFnqItRY=;
        b=Kd0O/n8qSevfipgPEzJbL0ECE+y8SnL7zDFWAmhx1AWh4hxZYzUpMTme/bl+VjZ4SJ
         TpV3nejcrwFhC0vV1FUT8nfMaqE2Iex0JwI1S3eeqhYawa1gOaVKBe1S+Wvyk1BNRDmu
         b62a0VTS9lWd/yGa72L6NuRjgINTzYzBnBMcAPwmtpv+g98fucT2eMuNJ/5+fWDDXGHe
         D+mUAb30sO+0x4IRKCsqIqQGL6Cp875JwoayfnkJO0nvXEbig8oBcc4zMSvyp/tJG6qZ
         A1hZQWcDYmnlXuuVfjJr8BsjIEGI2+/C6dkO0krZ5El78zXVOgw7H2nobhlgk4JforZ5
         sUAA==
X-Gm-Message-State: AO0yUKVxwZowfec29D9AYxUhm+mEcF3yTv92mXKmGYcWVhfeowrZSixX
        mXLEZQromyHXah5dQ8LNP+dlYA==
X-Google-Smtp-Source: AK7set9kiW+CiLCN+hsyoYIr1BHQff84nc5C3ZNm3+08O9K8LMZJnYtk8c6lYQ13uO/PhTaNmAd0uQ==
X-Received: by 2002:a5d:6507:0:b0:2c5:a6d4:1398 with SMTP id x7-20020a5d6507000000b002c5a6d41398mr3821917wru.70.1677659237035;
        Wed, 01 Mar 2023 00:27:17 -0800 (PST)
Received: from alex-rivos.home (lfbn-gre-1-235-32.w90-112.abo.wanadoo.fr. [90.112.194.32])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b002c6e8cb612fsm11733252wrs.92.2023.03.01.00.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 00:27:16 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 1/2] riscv: Get rid of riscv_pfn_base variable
Date:   Wed,  1 Mar 2023 09:25:51 +0100
Message-Id: <20230301082552.274331-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230301082552.274331-1-alexghiti@rivosinc.com>
References: <20230301082552.274331-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use directly phys_ram_base instead, riscv_pfn_base is just the pfn of
the address contained in phys_ram_base.

Even if there is no functional change intended in this patch, actually
setting phys_ram_base that early changes the behaviour of
kernel_mapping_pa_to_va during the early boot: phys_ram_base used to be
zero before this patch and now it is set to the physical start address of
the kernel. But it does not break the conversion of a kernel physical
address into a virtual address since kernel_mapping_pa_to_va should only
be used on kernel physical addresses, i.e. addresses greater than the
physical start address of the kernel.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/page.h | 3 +--
 arch/riscv/mm/init.c          | 6 +-----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 9f432c1b5289..926af5a3d02e 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -91,8 +91,7 @@ typedef struct page *pgtable_t;
 #endif
 
 #ifdef CONFIG_MMU
-extern unsigned long riscv_pfn_base;
-#define ARCH_PFN_OFFSET		(riscv_pfn_base)
+#define ARCH_PFN_OFFSET		(PFN_DOWN((unsigned long)phys_ram_base))
 #else
 #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
 #endif /* CONFIG_MMU */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 04d20e41894e..bef639fa330b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -271,9 +271,6 @@ static void __init setup_bootmem(void)
 #ifdef CONFIG_MMU
 struct pt_alloc_ops pt_ops __initdata;
 
-unsigned long riscv_pfn_base __ro_after_init;
-EXPORT_SYMBOL(riscv_pfn_base);
-
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
@@ -285,7 +282,6 @@ static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAG
 
 #ifdef CONFIG_XIP_KERNEL
 #define pt_ops			(*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
-#define riscv_pfn_base         (*(unsigned long  *)XIP_FIXUP(&riscv_pfn_base))
 #define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
 #define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
 #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
@@ -1009,7 +1005,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
 	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 
-	riscv_pfn_base = PFN_DOWN(kernel_map.phys_addr);
+	phys_ram_base = kernel_map.phys_addr;
 
 	/*
 	 * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
-- 
2.37.2

