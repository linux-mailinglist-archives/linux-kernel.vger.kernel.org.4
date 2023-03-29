Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89C76CDB95
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjC2OJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjC2OIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:08:53 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CFC4C3E;
        Wed, 29 Mar 2023 07:07:46 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1phWSA-0004ZJ-Pd; Wed, 29 Mar 2023 16:07:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 2/4] RISC-V: add Zbkb extension detection
Date:   Wed, 29 Mar 2023 16:06:40 +0200
Message-Id: <20230329140642.2186644-3-heiko.stuebner@vrull.eu>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Add detection for Zbkb extension.

Zbkb is part of the set of scalar cryptography extensions and provides
bitmanip instructions for cryptography, with them being a "subset of the
Zbb extension particularly useful for cryptography".

Zbkb was ratified in january 2022.

Expect code using the extension to pre-encode zbkb instructions, so
don't introduce special toolchain requirements for now.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpu.c        | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index c3cdad6b6ec8..90b02d01ded4 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -45,6 +45,7 @@
 #define RISCV_ISA_EXT_SVNAPOT		33
 #define RISCV_ISA_EXT_ZICBOZ		34
 #define RISCV_ISA_EXT_ZBC		35
+#define RISCV_ISA_EXT_ZBKB		36
 
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 4cab0432d7ef..32470119f31c 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -190,6 +190,7 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
+	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ddc7cebd810..1c4392421fe9 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -233,6 +233,7 @@ printk("!!!! isa-string: %s\n\n\n", isa);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
 				SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
 				SET_ISA_EXT_MAP("zbc", RISCV_ISA_EXT_ZBC);
+				SET_ISA_EXT_MAP("zbkb", RISCV_ISA_EXT_ZBKB);
 				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
 				SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);
 				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
-- 
2.39.0

