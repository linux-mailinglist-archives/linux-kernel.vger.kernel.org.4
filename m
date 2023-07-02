Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664D4745259
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjGBUfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjGBUez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:34:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F931BB;
        Sun,  2 Jul 2023 13:34:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-313f3a6db22so4359502f8f.3;
        Sun, 02 Jul 2023 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688330092; x=1690922092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcexdVQPBw2rdGBbBDTUXB1gr2v058VsgGzEZRfGeYk=;
        b=W8dcPNYnPZAWz3dYwbstWsoxXj+8ieIe2ZACK45R6iQD9OdL3Gy2TO0CWBtp1kxaDa
         vTRHRwAEprccmKG8vy38zpgvzWFypTDDA8GovnGn/eeSyIJ4Ckc+ithLylcmW+GVBODd
         R2eUS1peu6eFmEuYpa+3QuCcjNXdGV15ufgf3vgpd07a87ptdodxyMMCMwGD1l+6F6d3
         oYKsBWv3LS2nVapLuMJvMFP9ieN95Mol4ZMQhxvAoGSGGLN7gTyb1sUDJ7MRkyPT6Ci+
         N8kalFqhyDwpEFX0S3S4hXcituOGzj+Gra5Hmu0HOCbH1EM2YwcR1Lw6pGLjptCx8+pw
         FUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688330092; x=1690922092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcexdVQPBw2rdGBbBDTUXB1gr2v058VsgGzEZRfGeYk=;
        b=hxG8BoHmp8DNJOHocvOXtgrhLSMqjti1cT5dbyvaMYOgodut+TQX18gHswweZ1MbRH
         CM89aF+hrrhrtRgm3OYPPhS3ymryBUF7OTE4uDGzpZcJ2tG87x26BQBjd3KANZvShO5V
         htl+JewDhVecY7T75r+Z6GKxFsTojc+0vKINIlQDzTV50zuiiMxl8rF6C5eL+YYH0cgf
         yWfgmUMiXw2/yWJ9GZazWM3DCaO7MdocIXz5JCX2/QrD9GlJuqbAkxgkyli5hRycctTl
         8eo1mJ18OF35//7PdLABHIkPROJQ/Z7aqLkLyJ0qwg6ccy50qsXazm4eQt+0XfrVWkWK
         b07w==
X-Gm-Message-State: ABy/qLZ+w7S3SQmajzBdxef+iH338WhWN833r6VPmmtVLx4pZcpTw0x8
        uF9GJ6KuV7J+yRUUWHMJm9U=
X-Google-Smtp-Source: APBJJlG42eS96skXsOTDvhF78VPlj2Mt2tn2mqA2+pz+TVnhqMqFgowZn5j4VbBKwM4H2pSg0/GMxA==
X-Received: by 2002:adf:e9c2:0:b0:313:fff0:ff44 with SMTP id l2-20020adfe9c2000000b00313fff0ff44mr8062417wrn.38.1688330091931;
        Sun, 02 Jul 2023 13:34:51 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:b4ae:ae48:2e1b:1dcd])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b0030647449730sm24000478wrv.74.2023.07.02.13.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:34:51 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v10 3/6] riscv: mm: dma-noncoherent: nonstandard cache operations support
Date:   Sun,  2 Jul 2023 21:34:26 +0100
Message-Id: <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Introduce support for nonstandard noncoherent systems in the RISC-V
architecture. It enables function pointer support to handle cache
management in such systems.

This patch adds a new configuration option called
"RISCV_NONSTANDARD_CACHE_OPS." This option is a boolean flag that
depends on "RISCV_DMA_NONCOHERENT" and enables the function pointer
support for cache management in nonstandard noncoherent systems.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
---
v9 -> v10
* Added __ro_after_init compiler attribute for noncoherent_cache_ops
* Renamed clean -> wback
* Renamed inval -> inv
* Renamed flush -> wback_inv

v8 -> v9
* New patch
---
 arch/riscv/Kconfig                       |  7 ++++
 arch/riscv/include/asm/dma-noncoherent.h | 28 +++++++++++++++
 arch/riscv/mm/dma-noncoherent.c          | 43 ++++++++++++++++++++++++
 arch/riscv/mm/pmem.c                     | 13 +++++++
 4 files changed, 91 insertions(+)
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d9e451ac862a..42c86b13c5e1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -265,6 +265,13 @@ config RISCV_DMA_NONCOHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select DMA_DIRECT_REMAP
 
+config RISCV_NONSTANDARD_CACHE_OPS
+	bool
+	depends on RISCV_DMA_NONCOHERENT
+	help
+	  This enables function pointer support for non-standard noncoherent
+	  systems to handle cache management.
+
 config AS_HAS_INSN
 	def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(comma) t0$(comma) zero)
 
diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/include/asm/dma-noncoherent.h
new file mode 100644
index 000000000000..969cf1f1363a
--- /dev/null
+++ b/arch/riscv/include/asm/dma-noncoherent.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#ifndef __ASM_DMA_NONCOHERENT_H
+#define __ASM_DMA_NONCOHERENT_H
+
+#include <linux/dma-direct.h>
+
+/*
+ * struct riscv_cache_ops - Structure for CMO function pointers
+ *
+ * @wback: Function pointer for cache writeback
+ * @inv: Function pointer for invalidating cache
+ * @wback_inv: Function pointer for flushing the cache (writeback + invalidating)
+ */
+struct riscv_cache_ops {
+	void (*wback)(phys_addr_t paddr, unsigned long size);
+	void (*inv)(phys_addr_t paddr, unsigned long size);
+	void (*wback_inv)(phys_addr_t paddr, unsigned long size);
+};
+
+extern struct riscv_cache_ops noncoherent_cache_ops;
+
+void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops *ops);
+
+#endif	/* __ASM_DMA_NONCOHERENT_H */
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index b9a9f57e02be..4c2e3f1cdfe6 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -9,13 +9,26 @@
 #include <linux/dma-map-ops.h>
 #include <linux/mm.h>
 #include <asm/cacheflush.h>
+#include <asm/dma-noncoherent.h>
 
 static bool noncoherent_supported;
 
+struct riscv_cache_ops noncoherent_cache_ops __ro_after_init = {
+	.wback = NULL,
+	.inv = NULL,
+	.wback_inv = NULL,
+};
+
 static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.wback)) {
+		noncoherent_cache_ops.wback(paddr, size);
+		return;
+	}
+#endif
 	ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
 }
 
@@ -23,6 +36,13 @@ static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.inv)) {
+		noncoherent_cache_ops.inv(paddr, size);
+		return;
+	}
+#endif
+
 	ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
 }
 
@@ -30,6 +50,13 @@ static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.wback_inv)) {
+		noncoherent_cache_ops.wback_inv(paddr, size);
+		return;
+	}
+#endif
+
 	ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
 }
 
@@ -50,6 +77,13 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 {
 	void *flush_addr = page_address(page);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.wback_inv)) {
+		noncoherent_cache_ops.wback_inv(page_to_phys(page), size);
+		return;
+	}
+#endif
+
 	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
 }
 
@@ -75,3 +109,12 @@ void riscv_noncoherent_supported(void)
 	     "Non-coherent DMA support enabled without a block size\n");
 	noncoherent_supported = true;
 }
+
+void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops *ops)
+{
+	if (!ops)
+		return;
+
+	noncoherent_cache_ops = *ops;
+}
+EXPORT_SYMBOL_GPL(riscv_noncoherent_register_cache_ops);
diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
index 089df92ae876..c5fc5ec96f6d 100644
--- a/arch/riscv/mm/pmem.c
+++ b/arch/riscv/mm/pmem.c
@@ -7,15 +7,28 @@
 #include <linux/libnvdimm.h>
 
 #include <asm/cacheflush.h>
+#include <asm/dma-noncoherent.h>
 
 void arch_wb_cache_pmem(void *addr, size_t size)
 {
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.wback)) {
+		noncoherent_cache_ops.wback(virt_to_phys(addr), size);
+		return;
+	}
+#endif
 	ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
 }
 EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
 
 void arch_invalidate_pmem(void *addr, size_t size)
 {
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.inv)) {
+		noncoherent_cache_ops.inv(virt_to_phys(addr), size);
+		return;
+	}
+#endif
 	ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
 }
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
-- 
2.34.1

