Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCB5712B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbjEZRLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbjEZRL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA64E53
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C57CC651BE
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D085CC433EF;
        Fri, 26 May 2023 17:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685121078;
        bh=Bs4Qhmx5NZ+yKonQ7Rt09UyM8af1mOtvP1M80X6S4jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q9Y1UXMhi4qK29CeyQI19Humy4yTmrqCpAopNGt1S+1XcaeUKmnORESujrBqXEfd3
         qvyiSgkK20sTmXgyHEJccjGyXnZ17e5PF7iLp92CC0yT0Z/JZf7UIbIvqs2eUcTEaF
         e//NjVYc1BMFIG/OE0/ik7wg3p8J1EIBIQXxrTR967X4dGzAEc5H2hrn8Sj+3pChl5
         eF9S4qczAXnpMMxQYG0TdNBYrdEFdNDfMgLkRoSUisfE2yVc9fVNi6CfoPwMQD8SLi
         i3ZmM+sElibCVv5j5oilGTXSrslQ3Or1mpAVnl8L7S9vaNgFA513T/J2wz7eAGGBBe
         tcEgUMrGrAGiA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4/6] riscv: mm: pass noncoherent or not to riscv_noncoherent_supported()
Date:   Sat, 27 May 2023 00:59:56 +0800
Message-Id: <20230526165958.908-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230526165958.908-1-jszhang@kernel.org>
References: <20230526165958.908-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon take different actions by checking the HW is noncoherent
or not, I.E ZICBOM/ERRATA_THEAD_CMO or not.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/errata/thead/errata.c    | 19 +++++++++++--------
 arch/riscv/include/asm/cacheflush.h |  4 ++--
 arch/riscv/kernel/setup.c           |  6 +++++-
 arch/riscv/mm/dma-noncoherent.c     | 10 ++++++----
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index be84b14f0118..c192b80a5166 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -36,21 +36,24 @@ static bool errata_probe_pbmt(unsigned int stage,
 static bool errata_probe_cmo(unsigned int stage,
 			     unsigned long arch_id, unsigned long impid)
 {
-	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_CMO))
-		return false;
-
-	if (arch_id != 0 || impid != 0)
-		return false;
+	bool cmo;
 
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return false;
 
+	if (IS_ENABLED(CONFIG_ERRATA_THEAD_CMO) &&
+	    (arch_id == 0 && impid == 0))
+		cmo = true;
+	else
+		cmo = false;
+
 	if (stage == RISCV_ALTERNATIVES_BOOT) {
-		riscv_cbom_block_size = L1_CACHE_BYTES;
-		riscv_noncoherent_supported();
+		if (cmo)
+			riscv_cbom_block_size = L1_CACHE_BYTES;
+		riscv_noncoherent_supported(cmo);
 	}
 
-	return true;
+	return cmo;
 }
 
 static bool errata_probe_pmu(unsigned int stage,
diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 8091b8bf4883..9d056c9b625a 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -54,9 +54,9 @@ extern unsigned int riscv_cboz_block_size;
 void riscv_init_cbo_blocksizes(void);
 
 #ifdef CONFIG_RISCV_DMA_NONCOHERENT
-void riscv_noncoherent_supported(void);
+void riscv_noncoherent_supported(bool cmo);
 #else
-static inline void riscv_noncoherent_supported(void) {}
+static inline void riscv_noncoherent_supported(bool cmo) {}
 #endif
 
 /*
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 36b026057503..565f3e20169b 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -264,6 +264,7 @@ static void __init parse_dtb(void)
 
 void __init setup_arch(char **cmdline_p)
 {
+	bool cmo;
 	parse_dtb();
 	setup_initial_init_mm(_stext, _etext, _edata, _end);
 
@@ -298,7 +299,10 @@ void __init setup_arch(char **cmdline_p)
 	apply_boot_alternatives();
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
 	    riscv_isa_extension_available(NULL, ZICBOM))
-		riscv_noncoherent_supported();
+		cmo = true;
+	else
+		cmo = false;
+	riscv_noncoherent_supported(cmo);
 }
 
 static int __init topology_init(void)
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index d51a75864e53..0e172e2b4751 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -72,9 +72,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	dev->dma_coherent = coherent;
 }
 
-void riscv_noncoherent_supported(void)
+void riscv_noncoherent_supported(bool cmo)
 {
-	WARN(!riscv_cbom_block_size,
-	     "Non-coherent DMA support enabled without a block size\n");
-	noncoherent_supported = true;
+	if (cmo) {
+		WARN(!riscv_cbom_block_size,
+		     "Non-coherent DMA support enabled without a block size\n");
+		noncoherent_supported = true;
+	}
 }
-- 
2.40.1

