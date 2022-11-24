Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF560637E46
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiKXRXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKXRWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:22:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC3861770;
        Thu, 24 Nov 2022 09:22:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v1so3336356wrt.11;
        Thu, 24 Nov 2022 09:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvgWfL4HI/QgKyNL1kR3QOr26Xuun8VUqB/AbzIo99c=;
        b=A+faFO7PyjtwbJVGQsiRq8Iod0sOFBjJO5hAzsbz8lwsfBMsPCTZOkzuj3p1JBEpnh
         D0Oa+O1YwjUDIhm1AFvCZ02AvD+aOrLequEPSQTaBqZDS7tTDzHjg6RZ5B2IlOeKnxYF
         7nt06jE9icHEZ/fRXeq/dNTOtCgP9YFagD852Nebh8Gi/ZXYmYopUrq9iBKFRH1a49aD
         NKYAg51LVzMO2HcgErVoSXJ4D8x/qesbyJKY+WHbMxGL90qtUsonC8sw3ke04aqNQkmE
         FqG6nHTQlNBoOnautNel3wWvcAlGF1etoIWs7rZHqaBOOLzMn3JDGcctzeApwm3AbvPy
         mOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvgWfL4HI/QgKyNL1kR3QOr26Xuun8VUqB/AbzIo99c=;
        b=oyoyzzlu1OlxpINPwKdF0G9vyhEnpf2NueZvG2rU+eGQo46PNJ8RlqMBALtZ2+OmRy
         PlatrLUe6lBIZxmBKT3K+Tc62MLM5uxnNWmA9C0y7N20Hnp5YEVbzdZ5fwGDtcOwgxhR
         0Ugt1y194SLCwPYzMO+oaT5F1dOVAjMn2oH703mAzqHv5Rl6r7nW1V4Wsg6fjxAAE0eB
         jgr+QXcfAwMkxL3Lyus9vJZN9mAdrs7Wyb4oNOv+jl2SdwV0L4y5zzXYd/2pmz6oacaR
         Ec2cxl0mm6QeAF4dM0DiBAb/7oxkicVhm/N2WaXIDxPYA2AXry/TlTkBdCNZnnGdDIER
         2xug==
X-Gm-Message-State: ANoB5pkmFBeDZNz5TYlMPt0sBWOth3dPQRyWdN6y208RAv9tMJwYDm3f
        tDfl+eRoOvtF43Cb/lAGupo=
X-Google-Smtp-Source: AA0mqf7G2aWca5qucK+oikgDePhg68/fqggGGElJZNwed81giUpGn+yWkND+InHRlX0jtNqHe4zr4g==
X-Received: by 2002:a5d:5e87:0:b0:241:e7a6:db08 with SMTP id ck7-20020a5d5e87000000b00241e7a6db08mr7017188wrb.349.1669310565021;
        Thu, 24 Nov 2022 09:22:45 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:89ee:3f5d:1c99:35d8])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003c64c186206sm2698086wmn.16.2022.11.24.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:22:44 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 5/7] riscv: mm: dma-noncoherent: Pass direction and operation to ALT_CMO_OP()
Date:   Thu, 24 Nov 2022 17:22:05 +0000
Message-Id: <20221124172207.153718-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This is in preparation for adding errata for the Andes CPU core.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC v3 -> v4
* New patch
---
 arch/riscv/include/asm/cacheflush.h  |  4 ++++
 arch/riscv/include/asm/errata_list.h |  8 ++++++--
 arch/riscv/mm/dma-noncoherent.c      | 15 ++++++++++-----
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index f6fbe7042f1c..4a04d1be7c67 100644
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

