Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE7074C647
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjGIPnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjGIPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:43:02 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C764114;
        Sun,  9 Jul 2023 08:42:55 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qIWYg-0002yG-Ge; Sun, 09 Jul 2023 17:42:46 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, heiko@sntech.de,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, ebiggers@kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v6 1/3] RISC-V: expose Zbc as Kconfig option
Date:   Sun,  9 Jul 2023 17:42:41 +0200
Message-Id: <20230709154243.1582671-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709154243.1582671-1-heiko@sntech.de>
References: <20230709154243.1582671-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Similar to Zbb add a Zbc option to allow making further functionality
depend on it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/Kconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c86..cb5bd47c50c9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -531,6 +531,29 @@ config RISCV_ISA_ZBB
 
 	   If you don't know what to do here, say Y.
 
+config TOOLCHAIN_HAS_ZBC
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbc)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbc)
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZBC
+	bool "Zbc extension support for bit manipulation instructions"
+	depends on TOOLCHAIN_HAS_ZBC
+	depends on MMU
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	   Adds support to dynamically detect the presence of the ZBC
+	   extension (carry-less multiplication) and enable its usage.
+
+	   The Zbc extension provides instructions clmul, clmulh and clmulr
+	   to accelerate carry-less multiplications.
+
+	   If you don't know what to do here, say Y.
+
 config RISCV_ISA_ZICBOM
 	bool "Zicbom extension support for non-coherent DMA operation"
 	depends on MMU
-- 
2.39.2

