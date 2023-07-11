Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985FA74F3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjGKPjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjGKPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:39:04 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582F410EA;
        Tue, 11 Jul 2023 08:38:08 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJFQz-0000g0-33; Tue, 11 Jul 2023 17:37:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, heiko@sntech.de,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, ebiggers@kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 04/12] RISC-V: add vector crypto extension detection
Date:   Tue, 11 Jul 2023 17:37:35 +0200
Message-Id: <20230711153743.1970625-5-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711153743.1970625-1-heiko@sntech.de>
References: <20230711153743.1970625-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Add detection for some extensions of the vector-crypto specification:
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
 arch/riscv/include/asm/hwcap.h |  9 ++++++
 arch/riscv/kernel/cpu.c        |  8 ++++++
 arch/riscv/kernel/cpufeature.c | 50 ++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b80ca6e77088..0f5172fa87b0 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -64,6 +64,15 @@
 #define RISCV_ISA_EXT_ZKSED		51
 #define RISCV_ISA_EXT_ZKSH		52
 #define RISCV_ISA_EXT_ZKT		53
+#define RISCV_ISA_EXT_ZVBB		54
+#define RISCV_ISA_EXT_ZVBC		55
+#define RISCV_ISA_EXT_ZVKG		56
+#define RISCV_ISA_EXT_ZVKNED		57
+#define RISCV_ISA_EXT_ZVKNHA		58
+#define RISCV_ISA_EXT_ZVKNHB		59
+#define RISCV_ISA_EXT_ZVKSED		60
+#define RISCV_ISA_EXT_ZVKSH		61
+#define RISCV_ISA_EXT_ZVKT		62
 
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 10524322a4c0..925241e25db2 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -227,6 +227,14 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
 	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
 	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
+	__RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
+	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
+	__RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
+	__RISCV_ISA_EXT_DATA(zvkned, RISCV_ISA_EXT_ZVKNED),
+	__RISCV_ISA_EXT_DATA(zvknha, RISCV_ISA_EXT_ZVKNHA),
+	__RISCV_ISA_EXT_DATA(zvknhb, RISCV_ISA_EXT_ZVKNHB),
+	__RISCV_ISA_EXT_DATA(zvksed, RISCV_ISA_EXT_ZVKSED),
+	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 9a872a2007a5..13556fd16bf6 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -343,6 +343,56 @@ void __init riscv_fill_hwcap(void)
 				SET_ISA_EXT_MAP("zksh", RISCV_ISA_EXT_ZKSH);
 				SET_ISA_EXT_MAP("zkr", RISCV_ISA_EXT_ZKR);
 				SET_ISA_EXT_MAP("zkt", RISCV_ISA_EXT_ZKT);
+				SET_ISA_EXT_MAP("zvbb", RISCV_ISA_EXT_ZVBB);
+				SET_ISA_EXT_MAP("zvbc", RISCV_ISA_EXT_ZVBC);
+				SET_ISA_EXT_MAP("zvkg", RISCV_ISA_EXT_ZVKG);
+				SET_ISA_EXT_MAP("zvkned", RISCV_ISA_EXT_ZVKNED);
+				SET_ISA_EXT_MAP("zvknha", RISCV_ISA_EXT_ZVKNHA);
+				SET_ISA_EXT_MAP("zvknhb", RISCV_ISA_EXT_ZVKNHB);
+				SET_ISA_EXT_MAP("zvksed", RISCV_ISA_EXT_ZVKSED);
+				SET_ISA_EXT_MAP("zvksh", RISCV_ISA_EXT_ZVKSH);
+				SET_ISA_EXT_MAP("zvkt", RISCV_ISA_EXT_ZVKT);
+
+				/* NIST Algorithm Suite */
+				SET_ISA_EXT_MAP("zvkn", RISCV_ISA_EXT_ZVKNED);
+				SET_ISA_EXT_MAP("zvkn", RISCV_ISA_EXT_ZVKNHB);
+				SET_ISA_EXT_MAP("zvkn", RISCV_ISA_EXT_ZVBB);
+				SET_ISA_EXT_MAP("zvkn", RISCV_ISA_EXT_ZVKT);
+
+				/* NIST Algorithm Suite with carryless multiply */
+				SET_ISA_EXT_MAP("zvknc", RISCV_ISA_EXT_ZVKNED);
+				SET_ISA_EXT_MAP("zvknc", RISCV_ISA_EXT_ZVKNHB);
+				SET_ISA_EXT_MAP("zvknc", RISCV_ISA_EXT_ZVBB);
+				SET_ISA_EXT_MAP("zvknc", RISCV_ISA_EXT_ZVKT);
+				SET_ISA_EXT_MAP("zvknc", RISCV_ISA_EXT_ZVBC);
+
+				/* NIST Algorithm Suite with GCM */
+				SET_ISA_EXT_MAP("zvkng", RISCV_ISA_EXT_ZVKNED);
+				SET_ISA_EXT_MAP("zvkng", RISCV_ISA_EXT_ZVKNHB);
+				SET_ISA_EXT_MAP("zvkng", RISCV_ISA_EXT_ZVBB);
+				SET_ISA_EXT_MAP("zvkng", RISCV_ISA_EXT_ZVKT);
+				SET_ISA_EXT_MAP("zvkng", RISCV_ISA_EXT_ZVKG);
+
+				/*  ShangMi Algorithm Suite */
+				SET_ISA_EXT_MAP("zvks", RISCV_ISA_EXT_ZVKSED);
+				SET_ISA_EXT_MAP("zvks", RISCV_ISA_EXT_ZVKSH);
+				SET_ISA_EXT_MAP("zvks", RISCV_ISA_EXT_ZVBB);
+				SET_ISA_EXT_MAP("zvks", RISCV_ISA_EXT_ZVKT);
+
+				/* ShangMi Algorithm Suite with carryless multiply */
+				SET_ISA_EXT_MAP("zvksc", RISCV_ISA_EXT_ZVKSED);
+				SET_ISA_EXT_MAP("zvksc", RISCV_ISA_EXT_ZVKSH);
+				SET_ISA_EXT_MAP("zvksc", RISCV_ISA_EXT_ZVBB);
+				SET_ISA_EXT_MAP("zvksc", RISCV_ISA_EXT_ZVKT);
+				SET_ISA_EXT_MAP("zvksc", RISCV_ISA_EXT_ZVBC);
+
+				/* ShangMi Algorithm Suite with GCM */
+				SET_ISA_EXT_MAP("zvksg", RISCV_ISA_EXT_ZVKSED);
+				SET_ISA_EXT_MAP("zvksg", RISCV_ISA_EXT_ZVKSH);
+				SET_ISA_EXT_MAP("zvksg", RISCV_ISA_EXT_ZVBB);
+				SET_ISA_EXT_MAP("zvksg", RISCV_ISA_EXT_ZVKT);
+				SET_ISA_EXT_MAP("zvksg", RISCV_ISA_EXT_ZVKG);
+
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.39.2

