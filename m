Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22C73ACF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjFVXNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjFVXNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:13:34 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14891992
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:13:30 -0700 (PDT)
Received: from i53875bdf.versanet.de ([83.135.91.223] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qCTUP-0002nK-9C; Fri, 23 Jun 2023 01:13:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu, heiko@sntech.de,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v2 2/3] RISC-V: move vector-available status into a dedicated variable
Date:   Fri, 23 Jun 2023 01:13:04 +0200
Message-Id: <20230622231305.631331-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622231305.631331-1-heiko@sntech.de>
References: <20230622231305.631331-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

There is at least one core implementing the wrong vector specification,
which cannot claim to implement the v extension but still is able to
do vectors similar to v.

To not hack around this by claiming to do v, move the has_vector() return
to act similar to riscv_noncoherent_supported() and move to a separate
variable that can be set for example from errata code.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/include/asm/vector.h | 5 ++++-
 arch/riscv/kernel/setup.c       | 6 ++++++
 arch/riscv/kernel/vector.c      | 8 ++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 04c0b07bf6cd..315c96d2b4d0 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -19,13 +19,16 @@
 #include <asm/csr.h>
 #include <asm/asm.h>
 
+extern bool riscv_v_supported;
+void riscv_vector_supported(void);
+
 extern unsigned long riscv_v_vsize;
 int riscv_v_setup_vsize(void);
 bool riscv_v_first_use_handler(struct pt_regs *regs);
 
 static __always_inline bool has_vector(void)
 {
-	return riscv_has_extension_unlikely(RISCV_ISA_EXT_v);
+	return riscv_v_supported;
 }
 
 static inline void __riscv_v_vstate_clean(struct pt_regs *regs)
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 971fe776e2f8..952dfb90525e 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -36,6 +36,7 @@
 #include <asm/thread_info.h>
 #include <asm/kasan.h>
 #include <asm/efi.h>
+#include <asm/vector.h>
 
 #include "head.h"
 
@@ -308,6 +309,11 @@ void __init setup_arch(char **cmdline_p)
 	riscv_fill_hwcap();
 	init_rt_signal_env();
 	apply_boot_alternatives();
+
+	if (IS_ENABLED(CONFIG_RISCV_ISA_V) &&
+	    riscv_isa_extension_available(NULL, v))
+		riscv_vector_supported();
+
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
 	    riscv_isa_extension_available(NULL, ZICBOM))
 		riscv_noncoherent_supported();
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index f9c8e19ab301..74178fb71805 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -22,6 +22,9 @@
 
 static bool riscv_v_implicit_uacc = IS_ENABLED(CONFIG_RISCV_ISA_V_DEFAULT_ENABLE);
 
+bool riscv_v_supported;
+EXPORT_SYMBOL_GPL(riscv_v_supported);
+
 unsigned long riscv_v_vsize __read_mostly;
 EXPORT_SYMBOL_GPL(riscv_v_vsize);
 
@@ -274,3 +277,8 @@ static int riscv_v_init(void)
 	return riscv_v_sysctl_init();
 }
 core_initcall(riscv_v_init);
+
+void riscv_vector_supported(void)
+{
+	riscv_v_supported = true;
+}
-- 
2.39.2

