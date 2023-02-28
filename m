Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B486A4FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjB1AGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjB1AF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:05:56 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A89224CBF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:05:54 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pWnV9-000552-Qd; Tue, 28 Feb 2023 01:05:51 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     greentime.hu@sifive.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH RFC v2 08/16] RISC-V: add vector crypto extension detection
Date:   Tue, 28 Feb 2023 01:05:36 +0100
Message-Id: <20230228000544.2234136-9-heiko@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230228000544.2234136-1-heiko@sntech.de>
References: <20230228000544.2234136-1-heiko@sntech.de>
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
index 23427b9ed1e6..3701032a4df5 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -64,6 +64,13 @@ enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_ZBKB,
 	RISCV_ISA_EXT_ZICBOM,
 	RISCV_ISA_EXT_ZIHINTPAUSE,
+	RISCV_ISA_EXT_ZVKB,
+	RISCV_ISA_EXT_ZVKG,
+	RISCV_ISA_EXT_ZVKNED,
+	RISCV_ISA_EXT_ZVKNHA,
+	RISCV_ISA_EXT_ZVKNHB,
+	RISCV_ISA_EXT_ZVKSED,
+	RISCV_ISA_EXT_ZVKSH,
 	RISCV_ISA_EXT_ID_MAX
 };
 static_assert(RISCV_ISA_EXT_ID_MAX <= RISCV_ISA_EXT_MAX);
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
index 8f5434993128..4971008fa1fa 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -238,6 +238,13 @@ void __init riscv_fill_hwcap(void)
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

