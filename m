Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D046DF2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjDLLOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDLLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:09:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F186E6E9A;
        Wed, 12 Apr 2023 04:09:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g5so13867310wrb.5;
        Wed, 12 Apr 2023 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681297771; x=1683889771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB3sPVEcrgu6W+ilG7iG45RRlHi0fVznqs8qRjeeZzA=;
        b=nG67AZDgYKdJnkqDzdBqL7IETA6Nq75bT/jKzTrBr0Rp8gJDxALJsSSAbhwkH/+mr9
         C/UfJ9aEvNz4Bic4fi+Xz/nZH+6/rajKZuQEo+934ySYt/Hp/pM01sfrd/ejBeb2Zaej
         efWKvkx2OjdciaTTIaH+ZZ3bXbg1tZXeFUHsjjzxl+xkbVLf50bDYx6BVlj+qQTuFoeW
         lnG20h5N1VxrmIWlhuMB3EWvjzlhsEd4SrQp9fqEW5Dx4JIShONrkjvt+HsnXu3zMRZJ
         KoLA912TXPOJL/D5SB/8G6IZcLcRC8q4KH+W9Jl845Hwba5FVro/vgPciPrNMkXfCfYb
         6B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681297771; x=1683889771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nB3sPVEcrgu6W+ilG7iG45RRlHi0fVznqs8qRjeeZzA=;
        b=wjWkDhcFoxfoveALMLII2cE3LRA9idgzhVgOITYlgnrzfLyIjjmFkVgzBbckFCD9YC
         1kY45tltYO6esaW6DoczlojrQIJ5yszCuGe+MWceV1AWYFc1IOPVAMg3n/10mgLN9w8j
         B1ifHDHDv3mjzaOgc9iQ/CQvsffO3wO7YH07eZShNSZ60DL9cY6sjDIzVqCMKVK44nmS
         aQ+ozXmPISo/PjHCqAIWNEQ/cyjQwfmMjkgnMS1nK04HsyCtl1EpMjMfZl+RajN1RQYW
         yC5tYoTNPL/H0RjoGTpBkn75YQkpotti638WeLKuMDbRMSsTFNYAYcBBsQy+WVx769Jb
         DiXg==
X-Gm-Message-State: AAQBX9cjS+EFac4ypli7rt4r5jM9b9kGIothMQMBOz6f8WAr2YvOVVDb
        9ClEzc/8flOvcRcvVyK77ds=
X-Google-Smtp-Source: AKy350baFT53FrVZDDIYkVxi/WMtlVuaA05Nl+WNWc4qmRoasQeQvrWT71zHJavpnqvcSwx3li5Y1w==
X-Received: by 2002:a5d:6189:0:b0:2ce:9d06:58c6 with SMTP id j9-20020a5d6189000000b002ce9d0658c6mr1637641wru.53.1681297771385;
        Wed, 12 Apr 2023 04:09:31 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:783d:9280:20c4:db22])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d668d000000b002e61e002943sm16863582wru.116.2023.04.12.04.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 04:09:30 -0700 (PDT)
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
Subject: [PATCH v8 6/7] riscv: errata: Hookup the Andes AX45MP non-coherent handling
Date:   Wed, 12 Apr 2023 12:08:59 +0100
Message-Id: <20230412110900.69738-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hookup the Andes AX45MP non-coherent handling by updating the
ALT_CMO_OP() macro which will be used by dma-noncoherent.c for
non-coherent platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v7->v8
* New patch
---
 arch/riscv/include/asm/cacheflush.h  |  9 ++++++++
 arch/riscv/include/asm/errata_list.h | 33 ++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 8091b8bf4883..a8503cc04fdb 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -59,6 +59,15 @@ void riscv_noncoherent_supported(void);
 static inline void riscv_noncoherent_supported(void) {}
 #endif
 
+#ifdef CONFIG_AX45MP_L2_CACHE
+extern asmlinkage void ax45mp_dma_cache_wback_inv(void *vaddr, unsigned long size);
+extern asmlinkage void ax45mp_dma_cache_wback(void *vaddr, unsigned long size);
+extern asmlinkage void ax45mp_dma_cache_inv(void *vaddr, unsigned long size);
+#else
+static inline void ax45mp_dma_cache_wback_inv(void *vaddr, unsigned long size) {}
+static inline void ax45mp_dma_cache_wback(void *vaddr, unsigned long size) {}
+static inline void ax45mp_dma_cache_inv(void *vaddr, unsigned long size) {}
+#endif
 /*
  * Bits in sys_riscv_flush_icache()'s flags argument.
  */
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index e2ecd01bfac7..8e9811c14ba3 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -122,9 +122,13 @@ asm volatile(ALTERNATIVE(						\
 #define THEAD_flush_A0	".long 0x0275000b"
 #define THEAD_SYNC_S	".long 0x0190000b"
 
+#define ANDESTECH_AX45MP_clean	"call ax45mp_dma_cache_wback"
+#define ANDESTECH_AX45MP_inval	"call ax45mp_dma_cache_inv"
+#define ANDESTECH_AX45MP_flush	"call ax45mp_dma_cache_wback_inv"
+
 #define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
-asm volatile(ALTERNATIVE_2(						\
-	__nops(6),							\
+asm volatile(ALTERNATIVE_3(						\
+	__nops(11),							\
 	"mv a0, %1\n\t"							\
 	"j 2f\n\t"							\
 	"3:\n\t"							\
@@ -132,7 +136,7 @@ asm volatile(ALTERNATIVE_2(						\
 	"add a0, a0, %0\n\t"						\
 	"2:\n\t"							\
 	"bltu a0, %2, 3b\n\t"						\
-	"nop", 0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,	\
+	__nops(6), 0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,	\
 	"mv a0, %1\n\t"							\
 	"j 2f\n\t"							\
 	"3:\n\t"							\
@@ -140,12 +144,27 @@ asm volatile(ALTERNATIVE_2(						\
 	"add a0, a0, %0\n\t"						\
 	"2:\n\t"							\
 	"bltu a0, %2, 3b\n\t"						\
-	THEAD_SYNC_S, THEAD_VENDOR_ID,					\
-			ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
+	THEAD_SYNC_S "\n\t"						\
+	__nops(5), THEAD_VENDOR_ID,					\
+			ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO,	\
+	"addi sp,sp,-16\n\t"						\
+	"sd s0,0(sp)\n\t"						\
+	"sd ra,8(sp)\n\t"						\
+	"addi s0,sp,16\n\t"						\
+	"mv a1,%4\n\t"							\
+	"mv a0,%3\n\t"							\
+	ANDESTECH_AX45MP_##_op "\n\t"					\
+	"ld ra,8(sp)\n\t"						\
+	"ld s0,0(sp)\n\t"						\
+	"addi sp,sp,16\n\t",						\
+	ANDESTECH_VENDOR_ID, ERRATA_ANDESTECH_NO_IOCP,			\
+		CONFIG_ERRATA_ANDES)					\
 	: : "r"(_cachesize),						\
 	    "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
-	    "r"((unsigned long)(_start) + (_size))			\
-	: "a0")
+	    "r"((unsigned long)(_start) + (_size)),			\
+	    "r"((void *)(_start)),					\
+	    "r"((unsigned long)(_size))					\
+	: "a0", "a1")
 
 #define THEAD_C9XX_RV_IRQ_PMU			17
 #define THEAD_C9XX_CSR_SCOUNTEROF		0x5c5
-- 
2.25.1

