Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763246C7C37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCXKGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCXKGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:06:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA08B1ABEB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679652398; x=1711188398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bexdfvthgmxm24yne5iPZQH4IuiGSYCds0iNgWbzBLw=;
  b=W/Xogp3z7vKexdDOLXplHZaHbV3Gf0K3GDCSGTxLRGbEl7fZll8J6zZy
   +8ngBHgrI2JrZ/1gAWBpotJoess5fAnxhk9qTEzLrNnZHzE614LJVA66H
   oACB/fQxYDsbO/F87pf9DyDA4fj/C3VHWHX15x5DwP5iuykRJxbjdJwaX
   ReUP6kNzV4xzMgnosCA7XFA43sBL20X+yKQRZ9fdwvs30MdkieuVgCxtt
   jYB5nMSkIGe+WQCGVFEd4yM0yAEQc12IN5TBWdWH3JeymzHAUkAjvBEem
   2EfxLbnIu9uUqFsWH4b4hzwZdF6dfi4svg+sIxAV5klN9A4bMsaStNl0v
   w==;
X-IronPort-AV: E=Sophos;i="5.98,287,1673938800"; 
   d="scan'208";a="206553567"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2023 03:06:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 03:06:35 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 24 Mar 2023 03:06:33 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] RISC-V: always select RISCV_ALTERNATIVE for non-xip kernels
Date:   Fri, 24 Mar 2023 10:05:39 +0000
Message-ID: <20230324100538.3514663-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324100538.3514663-1-conor.dooley@microchip.com>
References: <20230324100538.3514663-1-conor.dooley@microchip.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3921; i=conor.dooley@microchip.com; h=from:subject; bh=Bexdfvthgmxm24yne5iPZQH4IuiGSYCds0iNgWbzBLw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmypS/iNOXXBArcsThyz3Zxon3V/LmPYr5tiWxWLFBfp3cj 7N3NjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzk6BuGv9I9bwPFNSy7XGNb5z5rPL EmVvxn3fSU9Uevzv8+93OEhw3DfzdB5T+T92V8Mr2ga9ituLvixiTpLZ+0dOTcj3yaW/PrIxsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When moving switch_to's has_fpu() over to using
riscv_has_extension_likely() rather than static branches, the FPU code
gained a dependency on the alternatives framework.
That dependency has now been removed, as riscv_has_extension_ikely() now
contains a fallback path, using __riscv_isa_extension_available(), but
if CONFIG_RISCV_ALTERNATIVE isn't selected when CONFIG_FPU is, has_fpu()
checks will not benefit from the "fast path" that the alternatives
framework provides.

We want to ensure that alternatives are available whenever
riscv_has_extension_[un]likely() is used, rather than silently falling
back to the slow path, but rather than rely on selecting
RISCV_ALTERNATIVE in the myriad of locations that may use
riscv_has_extension_[un]likely(), select it (almost) always instead by
adding it to the main RISCV config entry.
xip kernels cannot make use of the alternatives framework, so it is not
enabled for those configurations, although this is the status quo.

All current sites that select RISCV_ALTERNATIVE are converted to
dependencies on the option instead. The explicit dependencies on
!XIP_KERNEL can be dropped, as RISCV_ALTERNATIVE is not user selectable.

Fixes: 702e64550b12 ("riscv: fpu: switch has_fpu() to riscv_has_extension_likely()")
Link: https://lore.kernel.org/all/ZBruFRwt3rUVngPu@zx2c4.com/
Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig         | 12 ++++++------
 arch/riscv/Kconfig.erratas |  6 ++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5e42cc37604..2f6976418d0a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -126,6 +126,7 @@ config RISCV
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
+	select RISCV_ALTERNATIVE if !XIP_KERNEL
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC
@@ -401,9 +402,8 @@ config RISCV_ISA_C
 config RISCV_ISA_SVPBMT
 	bool "SVPBMT extension support"
 	depends on 64BIT && MMU
-	depends on !XIP_KERNEL
+	depends on RISCV_ALTERNATIVE
 	default y
-	select RISCV_ALTERNATIVE
 	help
 	   Adds support to dynamically detect the presence of the SVPBMT
 	   ISA-extension (Supervisor-mode: page-based memory types) and
@@ -428,8 +428,8 @@ config TOOLCHAIN_HAS_ZBB
 config RISCV_ISA_ZBB
 	bool "Zbb extension support for bit manipulation instructions"
 	depends on TOOLCHAIN_HAS_ZBB
-	depends on !XIP_KERNEL && MMU
-	select RISCV_ALTERNATIVE
+	depends on MMU
+	depends on RISCV_ALTERNATIVE
 	default y
 	help
 	   Adds support to dynamically detect the presence of the ZBB
@@ -443,9 +443,9 @@ config RISCV_ISA_ZBB
 
 config RISCV_ISA_ZICBOM
 	bool "Zicbom extension support for non-coherent DMA operation"
-	depends on !XIP_KERNEL && MMU
+	depends on MMU
+	depends on RISCV_ALTERNATIVE
 	default y
-	select RISCV_ALTERNATIVE
 	select RISCV_DMA_NONCOHERENT
 	help
 	   Adds support to dynamically detect the presence of the ZICBOM
diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
index 69621ae6d647..0c8f4652cd82 100644
--- a/arch/riscv/Kconfig.erratas
+++ b/arch/riscv/Kconfig.erratas
@@ -2,8 +2,7 @@ menu "CPU errata selection"
 
 config ERRATA_SIFIVE
 	bool "SiFive errata"
-	depends on !XIP_KERNEL
-	select RISCV_ALTERNATIVE
+	depends on RISCV_ALTERNATIVE
 	help
 	  All SiFive errata Kconfig depend on this Kconfig. Disabling
 	  this Kconfig will disable all SiFive errata. Please say "Y"
@@ -35,8 +34,7 @@ config ERRATA_SIFIVE_CIP_1200
 
 config ERRATA_THEAD
 	bool "T-HEAD errata"
-	depends on !XIP_KERNEL
-	select RISCV_ALTERNATIVE
+	depends on RISCV_ALTERNATIVE
 	help
 	  All T-HEAD errata Kconfig depend on this Kconfig. Disabling
 	  this Kconfig will disable all T-HEAD errata. Please say "Y"
-- 
2.39.2

