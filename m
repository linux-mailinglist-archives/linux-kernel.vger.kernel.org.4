Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C67649E40
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiLLLzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiLLLzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:55:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220EAF596;
        Mon, 12 Dec 2022 03:55:36 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso4898883wme.5;
        Mon, 12 Dec 2022 03:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/owj4dKvul9yQPdKIbLIisU85z4JvHjwmNbR5T/KcKc=;
        b=m828u87ePEdiN6J0F0mBLEBYWQ0Duzd4VUVie1oA/kVzMdFM5unYTFiCddppiMFcDn
         dSgkjg/l30yaUj6ts2pAfz2D7RTl4oq2svJ05PYyCYnssrAzspJOkkJ4DidtjPgeuhcS
         2SBE080Y51l9DSmX+0WhfqXNvZrXtYJL/TkHDfaZgDVIFtiwG5MxyroYSkvhKMLUMxv0
         NclaF1MrZZWqZGM3/28eiwwyPcjWMIAY9MrtQwXNBy6axByFDkFcDXuCwa/qH2NC1xs6
         UpNSOwShbRfSCvcCPCFubU5k0Ra4YWD1evBMgOeYHatCk0tqwl1oV11KVXu8mcP284Y5
         8mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/owj4dKvul9yQPdKIbLIisU85z4JvHjwmNbR5T/KcKc=;
        b=j2Ou7Mu3afvgPL61JByNPZxfF7Zk02lQbOZ6QX0EwzF9ASXLHF4z+DeYv+/g7oubod
         5FoEd88xhipNr6t/2cwnsHszzEBmHbgmGJhe+JHqY4dQQpVh9v+VWGdk2vtwNUTHotD4
         LQJhwXu20SNC2ouuwNkJQQpJ3ILgp4s0lY+sXmmXk1BK5WwI2D2b4y35MMkvRBpTS96w
         Yz2dUWiZ7WiCPyKGFAk/f0TIdaQ/P1Xy31FEuxjr4Cubp6on/LQvCK7CO7/hkaUMrkkM
         iqnqRWffxVlw4NNChMYwYHP8BW4rFfmhI2d+QorRg81pLfRcIDVTAcGokqbxoX3K6knk
         ifbQ==
X-Gm-Message-State: ANoB5pkp+A/5ny9IX3pdnCYIms283V6BkRn+GdOVx7H6cAI9tdPaO/UQ
        bAmo07IG7ZiUc4YGcVAsYzY=
X-Google-Smtp-Source: AA0mqf58jNIo9idrf0Z9GJcddQ8a7UCnMqj4fEx86F9b1wIZEemPVkIctQIAaPOTSDSqVqSSPFlaeg==
X-Received: by 2002:a05:600c:3501:b0:3cf:8e6f:e02e with SMTP id h1-20020a05600c350100b003cf8e6fe02emr12477935wmq.3.1670846134509;
        Mon, 12 Dec 2022 03:55:34 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1484:ef11:b25c:4612])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b003b4cba4ef71sm9793820wmq.41.2022.12.12.03.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:55:33 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 4/6] riscv: mm: dma-noncoherent: Pass direction and operation to ALT_CMO_OP()
Date:   Mon, 12 Dec 2022 11:55:03 +0000
Message-Id: <20221212115505.36770-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Pass direction and operation to ALT_CMO_OP() macro.

Vendors might want to perform different operations based on the direction
and callbacks (arch_sync_dma_for_device/arch_sync_dma_for_cpu/
arch_dma_prep_coherent) so to handle such cases pass the direction and
operation to ALT_CMO_OP() macro. This is in preparation for adding errata
for the Andes CPU core.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4 -> v5
* Updated commit message.

RFC v3 -> v4
* New patch
---
 arch/riscv/include/asm/cacheflush.h  |  4 ++++
 arch/riscv/include/asm/errata_list.h |  8 ++++++--
 arch/riscv/mm/dma-noncoherent.c      | 15 ++++++++++-----
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 03e3b95ae6da..e22019668b9e 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -8,6 +8,10 @@
 
 #include <linux/mm.h>
 
+#define NON_COHERENT_SYNC_DMA_FOR_DEVICE	0
+#define NON_COHERENT_SYNC_DMA_FOR_CPU		1
+#define NON_COHERENT_DMA_PREP			2
+
 static inline void local_flush_icache_all(void)
 {
 	asm volatile ("fence.i" ::: "memory");
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 2ba7e6e74540..48e899a8e7a9 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -124,7 +124,7 @@ asm volatile(ALTERNATIVE(						\
 #define THEAD_flush_A0	".long 0x0275000b"
 #define THEAD_SYNC_S	".long 0x0190000b"
 
-#define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
+#define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)		\
 asm volatile(ALTERNATIVE_2(						\
 	__nops(6),							\
 	"mv a0, %1\n\t"							\
@@ -146,7 +146,11 @@ asm volatile(ALTERNATIVE_2(						\
 			ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
 	: : "r"(_cachesize),						\
 	    "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
-	    "r"((unsigned long)(_start) + (_size))			\
+	    "r"((unsigned long)(_start) + (_size)),			\
+	    "r"((unsigned long)(_start)),				\
+	    "r"((unsigned long)(_size)),				\
+	    "r"((unsigned long)(_dir)),					\
+	    "r"((unsigned long)(_ops))					\
 	: "a0")
 
 #define THEAD_C9XX_RV_IRQ_PMU			17
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index d919efab6eba..e2b82034f504 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -19,13 +19,16 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 
 	switch (dir) {
 	case DMA_TO_DEVICE:
-		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size,
+			   dir, NON_COHERENT_SYNC_DMA_FOR_DEVICE);
 		break;
 	case DMA_FROM_DEVICE:
-		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size,
+			   dir, NON_COHERENT_SYNC_DMA_FOR_DEVICE);
 		break;
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size,
+			   dir, NON_COHERENT_SYNC_DMA_FOR_DEVICE);
 		break;
 	default:
 		break;
@@ -42,7 +45,8 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size,
+			   dir, NON_COHERENT_SYNC_DMA_FOR_CPU);
 		break;
 	default:
 		break;
@@ -53,7 +57,8 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 {
 	void *flush_addr = page_address(page);
 
-	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
+	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size,
+		   0, NON_COHERENT_DMA_PREP);
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-- 
2.25.1

