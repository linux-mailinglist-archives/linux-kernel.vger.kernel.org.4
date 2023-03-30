Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E0B6D1025
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjC3Umr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjC3Umo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:42:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F035E1AD;
        Thu, 30 Mar 2023 13:42:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso14124367wms.1;
        Thu, 30 Mar 2023 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680208961; x=1682800961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp5g+Zi0wKgOQ2vp6xwRZI4o1XJtRQeBG9LsYfC8lGA=;
        b=TSHAv3w8L++MepeQGzoXX4DmWU/dP6DTQMMZNp+ACwyJAU6LxBe4AGvkh5OVKrQFZK
         6E4SjbIfI9fQT8cdxQ6aaHuDwBNpP1rgqZX0iuU0RRJE+DmXRF2Ks3Ym+rlGx3UWwGnu
         Cqm822iqN/AJovh7gNG+iGTimq1rjxhU5FbMY+gdXLxYGBgqf0XlPo4yDSLPP5I76/sX
         K7Gvqj4LFV6LqDb617Hrdd8lr+HnuUAO7eHf6T0AOTpoz+NRdeRrF7B3oc4mWT6V/b/Q
         wu0+QBr+sEZ66EPraatiJzkG7HaTFOKYbQ6JQ8wpWiHnMwBWFNCvRF+XJkKIA7iq+19x
         uZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208961; x=1682800961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp5g+Zi0wKgOQ2vp6xwRZI4o1XJtRQeBG9LsYfC8lGA=;
        b=S6mCIxK5+QLbvk4GfKBEu2s0llGk5FMH5PG7F1sUJVCi2byDn+NPAzm4fOvmNNcxzw
         fLUyRQwDgBqs1eoZcF4pekpTy7tdYbVPHvjNdCPgg0hxWxQDMVd0iXQqXPJMrvsvZZf5
         Z6AaUDMbA93C4p7XfyeWxP/J8dFGbYaMB7Fv7kxg/3KlhON+ymPEtaxFYdo15SIrQQ3v
         5FEtlb3vBdlIkvoT8t0hVWddzzL/Ll/Nvqx+EthMobpCDxqRnAmYqyMTCYJo8q1DKC3A
         5LWfpdS28XW7IMobkzwigJbm2jj4lwxGCaqr47Je5hZosQWodWVD4Qserc5otRwAG3zZ
         QGbg==
X-Gm-Message-State: AO0yUKWh+kFXBFExuU267GcdzxsHZ4mpX105NtCYG7uSt7FAgw+9QKZW
        XYfFaiXHeeY56NohxkS2pp4=
X-Google-Smtp-Source: AK7set86PBgpBS+AU8+CgX/jFDzrvzrcf8p4oqZLRwtuBJFamJXZU0iWJiFMchCN+Ogb1aRCtXGEZQ==
X-Received: by 2002:a7b:ca59:0:b0:3eb:2da5:e19 with SMTP id m25-20020a7bca59000000b003eb2da50e19mr18837458wml.27.1680208960652;
        Thu, 30 Mar 2023 13:42:40 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:30f2:5b7:ab32:c3f])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4b0c000000b002cfed482e9asm297981wrq.61.2023.03.30.13.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:42:39 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function pointers for cache management
Date:   Thu, 30 Mar 2023 21:42:12 +0100
Message-Id: <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Currently, selecting which CMOs to use on a given platform is done using
and ALTERNATIVE_X() macro. This was manageable when there were just two
CMO implementations, but now that there are more and more platforms coming
needing custom CMOs, the use of the ALTERNATIVE_X() macro is unmanageable.

To avoid such issues this patch switches to use of function pointers
instead of ALTERNATIVE_X() macro for cache management (the only drawback
being performance over the previous approach).

void (*clean_range)(unsigned long addr, unsigned long size);
void (*inv_range)(unsigned long addr, unsigned long size);
void (*flush_range)(unsigned long addr, unsigned long size);

The above function pointers are provided to be overridden for platforms
needing CMO.

Convert ZICBOM and T-HEAD CMO to use function pointers.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v6->v7
* Updated commit description
* Fixed build issues when CONFIG_ERRATA_THEAD_CMO=n
* Used static const struct ptr to register CMO ops
* Dropped riscv_dma_noncoherent_cmo_ops
* Moved ZICBOM CMO setup to setup.c

v5->v6
* New patch
---
 arch/riscv/errata/thead/errata.c         | 76 ++++++++++++++++++++++++
 arch/riscv/include/asm/dma-noncoherent.h | 73 +++++++++++++++++++++++
 arch/riscv/include/asm/errata_list.h     | 53 -----------------
 arch/riscv/kernel/setup.c                | 49 ++++++++++++++-
 arch/riscv/mm/dma-noncoherent.c          | 25 ++++++--
 arch/riscv/mm/pmem.c                     |  6 +-
 6 files changed, 221 insertions(+), 61 deletions(-)
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 7e8d50ebb71a..4bb3f2baee03 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -11,10 +11,83 @@
 #include <linux/uaccess.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
+#include <asm/dma-noncoherent.h>
 #include <asm/errata_list.h>
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
 
+#ifdef CONFIG_ERRATA_THEAD_CMO
+/*
+ * dcache.ipa rs1 (invalidate, physical address)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01010      rs1       000      00000  0001011
+ * dache.iva rs1 (invalida, virtual address)
+ *   0000001    00110      rs1       000      00000  0001011
+ *
+ * dcache.cpa rs1 (clean, physical address)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01001      rs1       000      00000  0001011
+ * dcache.cva rs1 (clean, virtual address)
+ *   0000001    00100      rs1       000      00000  0001011
+ *
+ * dcache.cipa rs1 (clean then invalidate, physical address)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01011      rs1       000      00000  0001011
+ * dcache.civa rs1 (... virtual address)
+ *   0000001    00111      rs1       000      00000  0001011
+ *
+ * sync.s (make sure all cache operations finished)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000000    11001     00000      000      00000  0001011
+ */
+#define THEAD_inval_A0	".long 0x0265000b"
+#define THEAD_clean_A0	".long 0x0245000b"
+#define THEAD_flush_A0	".long 0x0275000b"
+#define THEAD_SYNC_S	".long 0x0190000b"
+
+#define THEAD_CMO_OP(_op, _start, _size, _cachesize)				\
+	asm volatile("mv a0, %1\n\t"						\
+		     "j 2f\n\t"							\
+		     "3:\n\t"							\
+		     THEAD_##_op##_A0 "\n\t"					\
+		     "add a0, a0, %0\n\t"					\
+		     "2:\n\t"							\
+		     "bltu a0, %2, 3b\n\t"					\
+		     THEAD_SYNC_S						\
+		     : : "r"(_cachesize),					\
+			 "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
+			 "r"((unsigned long)(_start) + (_size))			\
+		     : "a0")
+
+static void thead_cmo_clean_range(unsigned long addr, unsigned long size)
+{
+	THEAD_CMO_OP(clean, addr, size, riscv_cbom_block_size);
+}
+
+static void thead_cmo_flush_range(unsigned long addr, unsigned long size)
+{
+	THEAD_CMO_OP(flush, addr, size, riscv_cbom_block_size);
+}
+
+static void thead_cmo_inval_range(unsigned long addr, unsigned long size)
+{
+	THEAD_CMO_OP(inval, addr, size, riscv_cbom_block_size);
+}
+
+static const struct riscv_cache_ops thead_cmo_ops = {
+	.clean_range = &thead_cmo_clean_range,
+	.inv_range = &thead_cmo_inval_range,
+	.flush_range = &thead_cmo_flush_range,
+};
+
+static void thead_register_cmo_ops(void)
+{
+	riscv_noncoherent_register_cache_ops(&thead_cmo_ops);
+}
+#else
+static void thead_register_cmo_ops(void) {}
+#endif
+
 static bool errata_probe_pbmt(unsigned int stage,
 			      unsigned long arch_id, unsigned long impid)
 {
@@ -45,6 +118,9 @@ static bool errata_probe_cmo(unsigned int stage,
 
 	riscv_cbom_block_size = L1_CACHE_BYTES;
 	riscv_noncoherent_supported();
+
+	thead_register_cmo_ops();
+
 	return true;
 }
 
diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/include/asm/dma-noncoherent.h
new file mode 100644
index 000000000000..fc8d16c89f01
--- /dev/null
+++ b/arch/riscv/include/asm/dma-noncoherent.h
@@ -0,0 +1,73 @@
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
+#ifdef CONFIG_RISCV_DMA_NONCOHERENT
+
+/*
+ * struct riscv_cache_ops - Structure for CMO function pointers
+ *
+ * @clean_range: Function pointer for clean cache
+ * @inv_range: Function pointer for invalidate cache
+ * @flush_range: Function pointer for flushing the cache
+ */
+struct riscv_cache_ops {
+	void (*clean_range)(unsigned long addr, unsigned long size);
+	void (*inv_range)(unsigned long addr, unsigned long size);
+	void (*flush_range)(unsigned long addr, unsigned long size);
+};
+
+extern struct riscv_cache_ops noncoherent_cache_ops;
+
+void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops *ops);
+
+static inline void riscv_dma_noncoherent_clean(void *vaddr, size_t size)
+{
+	if (noncoherent_cache_ops.clean_range) {
+		unsigned long addr = (unsigned long)vaddr;
+
+		noncoherent_cache_ops.clean_range(addr, size);
+	}
+}
+
+static inline void riscv_dma_noncoherent_flush(void *vaddr, size_t size)
+{
+	if (noncoherent_cache_ops.flush_range) {
+		unsigned long addr = (unsigned long)vaddr;
+
+		noncoherent_cache_ops.flush_range(addr, size);
+	}
+}
+
+static inline void riscv_dma_noncoherent_inval(void *vaddr, size_t size)
+{
+	if (noncoherent_cache_ops.inv_range) {
+		unsigned long addr = (unsigned long)vaddr;
+
+		noncoherent_cache_ops.inv_range(addr, size);
+	}
+}
+
+static inline void riscv_dma_noncoherent_pmem_clean(void *vaddr, size_t size)
+{
+	riscv_dma_noncoherent_clean(vaddr, size);
+}
+
+static inline void riscv_dma_noncoherent_pmem_inval(void *vaddr, size_t size)
+{
+	riscv_dma_noncoherent_inval(vaddr, size);
+}
+#else
+
+static inline void riscv_dma_noncoherent_pmem_clean(void *vaddr, size_t size) {}
+static inline void riscv_dma_noncoherent_pmem_inval(void *vaddr, size_t size) {}
+
+#endif /* CONFIG_RISCV_DMA_NONCOHERENT */
+
+#endif	/* __ASM_DMA_NONCOHERENT_H */
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index fb1a810f3d8c..112429910ee6 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -89,59 +89,6 @@ asm volatile(ALTERNATIVE(						\
 #define ALT_THEAD_PMA(_val)
 #endif
 
-/*
- * dcache.ipa rs1 (invalidate, physical address)
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000001    01010      rs1       000      00000  0001011
- * dache.iva rs1 (invalida, virtual address)
- *   0000001    00110      rs1       000      00000  0001011
- *
- * dcache.cpa rs1 (clean, physical address)
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000001    01001      rs1       000      00000  0001011
- * dcache.cva rs1 (clean, virtual address)
- *   0000001    00100      rs1       000      00000  0001011
- *
- * dcache.cipa rs1 (clean then invalidate, physical address)
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000001    01011      rs1       000      00000  0001011
- * dcache.civa rs1 (... virtual address)
- *   0000001    00111      rs1       000      00000  0001011
- *
- * sync.s (make sure all cache operations finished)
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000000    11001     00000      000      00000  0001011
- */
-#define THEAD_inval_A0	".long 0x0265000b"
-#define THEAD_clean_A0	".long 0x0245000b"
-#define THEAD_flush_A0	".long 0x0275000b"
-#define THEAD_SYNC_S	".long 0x0190000b"
-
-#define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
-asm volatile(ALTERNATIVE_2(						\
-	__nops(6),							\
-	"mv a0, %1\n\t"							\
-	"j 2f\n\t"							\
-	"3:\n\t"							\
-	CBO_##_op(a0)							\
-	"add a0, a0, %0\n\t"						\
-	"2:\n\t"							\
-	"bltu a0, %2, 3b\n\t"						\
-	"nop", 0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,	\
-	"mv a0, %1\n\t"							\
-	"j 2f\n\t"							\
-	"3:\n\t"							\
-	THEAD_##_op##_A0 "\n\t"						\
-	"add a0, a0, %0\n\t"						\
-	"2:\n\t"							\
-	"bltu a0, %2, 3b\n\t"						\
-	THEAD_SYNC_S, THEAD_VENDOR_ID,					\
-			ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
-	: : "r"(_cachesize),						\
-	    "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
-	    "r"((unsigned long)(_start) + (_size))			\
-	: "a0")
-
 #define THEAD_C9XX_RV_IRQ_PMU			17
 #define THEAD_C9XX_CSR_SCOUNTEROF		0x5c5
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 5d3184cbf518..b2b69d1dec23 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -24,6 +24,7 @@
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
+#include <asm/dma-noncoherent.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable.h>
 #include <asm/setup.h>
@@ -262,6 +263,50 @@ static void __init parse_dtb(void)
 #endif
 }
 
+#ifdef CONFIG_RISCV_ISA_ZICBOM
+
+#define ZICBOM_CMO_OP(_op, _start, _size, _cachesize)				\
+	asm volatile("mv a0, %1\n\t"						\
+		     "j 2f\n\t"							\
+		     "3:\n\t"							\
+		     CBO_##_op(a0)						\
+		     "add a0, a0, %0\n\t"					\
+		     "2:\n\t"							\
+		     "bltu a0, %2, 3b\n\t"					\
+		     : : "r"(_cachesize),					\
+			 "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
+			 "r"((unsigned long)(_start) + (_size))			\
+		     : "a0")
+
+static void zicbom_cmo_clean_range(unsigned long addr, unsigned long size)
+{
+	ZICBOM_CMO_OP(clean, addr, size, riscv_cbom_block_size);
+}
+
+static void zicbom_cmo_flush_range(unsigned long addr, unsigned long size)
+{
+	ZICBOM_CMO_OP(flush, addr, size, riscv_cbom_block_size);
+}
+
+static void zicbom_cmo_inval_range(unsigned long addr, unsigned long size)
+{
+	ZICBOM_CMO_OP(inval, addr, size, riscv_cbom_block_size);
+}
+
+const struct riscv_cache_ops zicbom_cmo_ops = {
+	.clean_range = &zicbom_cmo_clean_range,
+	.inv_range = &zicbom_cmo_inval_range,
+	.flush_range = &zicbom_cmo_flush_range,
+};
+
+static void zicbom_register_cmo_ops(void)
+{
+	riscv_noncoherent_register_cache_ops(&zicbom_cmo_ops);
+}
+#else
+static void zicbom_register_cmo_ops(void) {}
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	parse_dtb();
@@ -301,8 +346,10 @@ void __init setup_arch(char **cmdline_p)
 	riscv_fill_hwcap();
 	apply_boot_alternatives();
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
-	    riscv_isa_extension_available(NULL, ZICBOM))
+	    riscv_isa_extension_available(NULL, ZICBOM)) {
 		riscv_noncoherent_supported();
+		zicbom_register_cmo_ops();
+	}
 }
 
 static int __init topology_init(void)
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index b9a9f57e02be..ab8f6dc67914 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -9,28 +9,36 @@
 #include <linux/dma-map-ops.h>
 #include <linux/mm.h>
 #include <asm/cacheflush.h>
+#include <asm/dma-noncoherent.h>
 
 static bool noncoherent_supported;
 
+struct riscv_cache_ops noncoherent_cache_ops = {
+	.clean_range = NULL,
+	.inv_range = NULL,
+	.flush_range = NULL,
+};
+EXPORT_SYMBOL_GPL(noncoherent_cache_ops);
+
 static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
-	ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+	riscv_dma_noncoherent_clean(vaddr, size);
 }
 
 static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
-	ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
+	riscv_dma_noncoherent_inval(vaddr, size);
 }
 
 static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
-	ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+	riscv_dma_noncoherent_flush(vaddr, size);
 }
 
 static inline bool arch_sync_dma_clean_before_fromdevice(void)
@@ -50,7 +58,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 {
 	void *flush_addr = page_address(page);
 
-	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
+	riscv_dma_noncoherent_flush(flush_addr, size);
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
@@ -75,3 +83,12 @@ void riscv_noncoherent_supported(void)
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
index 089df92ae876..aad7c2209eca 100644
--- a/arch/riscv/mm/pmem.c
+++ b/arch/riscv/mm/pmem.c
@@ -6,16 +6,16 @@
 #include <linux/export.h>
 #include <linux/libnvdimm.h>
 
-#include <asm/cacheflush.h>
+#include <asm/dma-noncoherent.h>
 
 void arch_wb_cache_pmem(void *addr, size_t size)
 {
-	ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
+	riscv_dma_noncoherent_pmem_clean(addr, size);
 }
 EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
 
 void arch_invalidate_pmem(void *addr, size_t size)
 {
-	ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
+	riscv_dma_noncoherent_pmem_inval(addr, size);
 }
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
-- 
2.25.1

