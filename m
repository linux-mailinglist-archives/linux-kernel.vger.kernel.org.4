Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F66B6B8182
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjCMTNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCMTNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:13:13 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9939CC3B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:13:08 -0700 (PDT)
Received: from ip4d1634a9.dynamic.kabel-deutschland.de ([77.22.52.169] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pbnbV-00028k-Qn; Mon, 13 Mar 2023 20:13:05 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     greentime.hu@sifive.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu, heiko@sntech.de
Subject: [PATCH RFC v3 08/16] RISC-V: add vector crypto extension detection
Date:   Mon, 13 Mar 2023 20:12:54 +0100
Message-Id: <20230313191302.580787-9-heiko.stuebner@vrull.eu>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230313191302.580787-1-heiko.stuebner@vrull.eu>
References: <20230313191302.580787-1-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Add detection for some extensions of the vector-crypto specification, namely
- Zvkb: Vector Bit-manipulation used in Cryptography
- Zvkg: Vector GCM/GMAC
- Zvknha and Zvknhb: NIST Algorithm Suite
- Zvkns: AES-128, AES-256 Single Round Suite
- Zvksed: ShangMi Algorithm Suite
- Zvksh: ShangMi Algorithm Suite

As their use is very specific and will likely be limited to special places
we expect current code to just pre-encode those instructions, so right now
we don't introduce toolchain requirements.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/include/asm/hwcap.h | 7 +++++++
 arch/riscv/kernel/cpu.c        | 7 +++++++
 arch/riscv/kernel/cpufeature.c | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b28548fb10f3..914559e0e136 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -45,6 +45,13 @@
 #define RISCV_ISA_EXT_ZIHINTPAUSE	32
 #define RISCV_ISA_EXT_ZBC		33
 #define RISCV_ISA_EXT_ZBKB		34
+#define RISCV_ISA_EXT_ZVKB		35
+#define RISCV_ISA_EXT_ZVKG		36
+#define RISCV_ISA_EXT_ZVKNED		37
+#define RISCV_ISA_EXT_ZVKNHA		38
+#define RISCV_ISA_EXT_ZVKNHB		39
+#define RISCV_ISA_EXT_ZVKSED		40
+#define RISCV_ISA_EXT_ZVKSH		41
 
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 6f65aac68018..c01e6673a947 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -190,6 +190,13 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
 	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
+	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
+	__RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
+	__RISCV_ISA_EXT_DATA(zvkned, RISCV_ISA_EXT_ZVKNED),
+	__RISCV_ISA_EXT_DATA(zvknha, RISCV_ISA_EXT_ZVKNHA),
+	__RISCV_ISA_EXT_DATA(zvknhb, RISCV_ISA_EXT_ZVKNHB),
+	__RISCV_ISA_EXT_DATA(zvksed, RISCV_ISA_EXT_ZVKSED),
+	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index eb7be8e7f24e..ad866321ae37 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -232,6 +232,13 @@ void __init riscv_fill_hwcap(void)
 				SET_ISA_EXT_MAP("zbkb", RISCV_ISA_EXT_ZBKB);
 				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
 				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
+				SET_ISA_EXT_MAP("zvkb", RISCV_ISA_EXT_ZVKB);
+				SET_ISA_EXT_MAP("zvkg", RISCV_ISA_EXT_ZVKG);
+				SET_ISA_EXT_MAP("zvkned", RISCV_ISA_EXT_ZVKNED);
+				SET_ISA_EXT_MAP("zvknha", RISCV_ISA_EXT_ZVKNHA);
+				SET_ISA_EXT_MAP("zvknhb", RISCV_ISA_EXT_ZVKNHB);
+				SET_ISA_EXT_MAP("zvksed", RISCV_ISA_EXT_ZVKSED);
+				SET_ISA_EXT_MAP("zvksh", RISCV_ISA_EXT_ZVKSH);
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.39.0

