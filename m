Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5475D608058
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJUUxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJUUxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:53:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2433E27EAE5;
        Fri, 21 Oct 2022 13:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA1BF60D3F;
        Fri, 21 Oct 2022 20:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012A0C433C1;
        Fri, 21 Oct 2022 20:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385582;
        bh=OE69UEMWIZo9/0uQr+S1+Wh+gSXBQpFtZNr5MxjC0Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liWXDUMsEhwl21E+HP4sVoeVcnV1Zx5uf5GaN4iQaPxVGhfw0uAVV/5oVXF74savg
         K/Yk8Ozvq0s7P8jpHG84ubfgarX3Ms8PlOptwygLXEYg0QXODbgVqHIkQNtFLMtfVi
         oreNQliKHGKqQQ+urMEl1bYX8Zk/k5Yadp/syBDpcKNM4WtJjzfV5Eb7SGE6IQr/Rd
         gK6TwWKBeZwSyoHphOT3w0pzhrW3nKV1yxZ5agtPB3gKI9Z1qsdT4ZM1Ay9nafqHnw
         y6D08sgFAPC4HPIDq3GuKDXD/3uL2kAwUtnqiprBjaFpnmkvPVvVtJrxsDCKcHBr9/
         axtdzL2uFFIDg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 20/21] soc: s3c: remove pm-debug hack
Date:   Fri, 21 Oct 2022 22:27:53 +0200
Message-Id: <20221021203329.4143397-20-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_SAMSUNG_PM_DEBUG was only used on s3c24xx because of the
DEBUG_S3C24XX_UART dependency. Since s3c24xx is now gone, and nobody
ever noticed this option being missing from s3c64xx, it can be safely
removed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/samsung/Kconfig        | 22 +--------
 drivers/soc/samsung/Makefile       |  1 -
 drivers/soc/samsung/s3c-pm-debug.c | 79 ------------------------------
 3 files changed, 1 insertion(+), 101 deletions(-)
 delete mode 100644 drivers/soc/samsung/s3c-pm-debug.c

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index b4f538d7412f..7a8f291e7704 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -52,29 +52,9 @@ config EXYNOS_PM_DOMAINS
 	bool "Exynos PM domains" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && PM_GENERIC_DOMAINS) || COMPILE_TEST
 
-config SAMSUNG_PM_DEBUG
-	bool "Samsung PM Suspend debug"
-	depends on PM && DEBUG_KERNEL
-	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
-	depends on DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
-	depends on DEBUG_LL && MMU
-	help
-	  Say Y here if you want verbose debugging from the PM Suspend and
-	  Resume code. See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
-	  for more information.
-
-config S3C_PM_DEBUG_LED_SMDK
-       bool "SMDK LED suspend/resume debugging"
-       depends on PM && (MACH_SMDK6410)
-       help
-         Say Y here to enable the use of the SMDK LEDs on the baseboard
-	 for debugging of the state of the suspend and resume process.
-
-	 Note, this currently only works for S3C64XX based SMDK boards.
-
 config SAMSUNG_PM_CHECK
 	bool "S3C2410 PM Suspend Memory CRC"
-	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
+	depends on PM && (ARCH_S3C64XX || ARCH_S5PV210)
 	select CRC32
 	help
 	  Enable the PM code's memory area checksum over sleep. This option
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 9f59d1905ab0..d35270fc6b2b 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -14,4 +14,3 @@ obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
 obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
 
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= s3c-pm-check.o
-obj-$(CONFIG_SAMSUNG_PM_DEBUG)	+= s3c-pm-debug.o
diff --git a/drivers/soc/samsung/s3c-pm-debug.c b/drivers/soc/samsung/s3c-pm-debug.c
deleted file mode 100644
index b5ce0e9a41e5..000000000000
-- 
2.29.2

