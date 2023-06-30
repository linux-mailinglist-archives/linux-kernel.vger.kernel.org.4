Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A8E7440A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjF3RAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjF3Q7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:59:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4341144A7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-314118623d5so2371248f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144336; x=1690736336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FgwEHIiufvN4/vrAM+EmRTKMvuGIUCUJpN7+/AjohE=;
        b=zJKm1O3gqfl+/l50NqDCQVslJww9J04yE89jZ5f/lU/O9RkBXTLjndN7cOTiCR52d+
         2rWtrBCNymviRY86hDdMyCddB6ShlNjbD6K2lo5+z+o6X1NUfJdkYXxeNPy7ld4+Lh+2
         sYysn1DdGwZGblXk6RYANZeFevQ97VVVYiUMJJnpLk0D3ssCK1znw7XESfsbUN7O7GeR
         DQhavB0xiTESX7UaUitfbY6F/PHswbOkNBRvzi651+5RWH5QtNkO4lu0WopUCi8jZroa
         WgCPdF9MdRJx9PfrdQM8jMACd94F5U0aUvHS7+r0CDEvdNETaEHZJC54c+0x55olTUwM
         ZOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144336; x=1690736336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FgwEHIiufvN4/vrAM+EmRTKMvuGIUCUJpN7+/AjohE=;
        b=Fqj11t3AjNd3yRFNma0wjQF7JWqsosC8jSvSYAE4plaZgwUUNRn+nsnt5chw2Pciwt
         joX2bMp8gfzTastarTFOPGHFHquz/MGfQ/cEbMXqe1XnsdXbUC9jsTxE1SI8E59dPHU4
         lKmSjzZS+CPC4Kf9oyu9sFL8mVgQxWTTBnvw5yK2tPwHog+IitqRZRkhJu9RgXfknNwz
         ybBVgw2QncZGqlPGmPbgErLfyNfBtGRFL/Dt//v2njzlvgP8LN0p8orSsIKIED4G4NF1
         X6HCSCepMhVZW8bzwwZ5YsGOwxCyfjUZBMgK1I92l97pkMCF+xwubXyx2fWncfsVeWCG
         bmhw==
X-Gm-Message-State: ABy/qLaI6Yom6hNuZfFuJiQdMqlimae/UubDS8E/FoJw/Dmwvxz2IlDz
        J/Gw/koZYcmx8vTcirWPNo4mTQ==
X-Google-Smtp-Source: APBJJlF+HR7IlwOv6BGJulPd3da1YOPyBnMGP5I0+G0uGCgFrxABHVR8qHNl0+04XrjGbTvktRYacg==
X-Received: by 2002:adf:ed0a:0:b0:314:13e2:2f6c with SMTP id a10-20020adfed0a000000b0031413e22f6cmr2444524wro.58.1688144336059;
        Fri, 30 Jun 2023 09:58:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm18913772wri.73.2023.06.30.09.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:58:55 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 30 Jun 2023 18:58:37 +0200
Subject: [PATCH v2 12/15] power: reset: oxnas-restart: remove obsolete
 restart driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-12-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-oxnas@groups.io,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11262;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=NNcUV2Vccp2R6feBFSgnzPy5EF8i0mzkDpw8Uj3QejE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm4ttQQcVXfjEc6zcYUSzILYTX7Rne5j6+Afkl3
 GWDpCd+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JuAAKCRB33NvayMhJ0cU8D/
 95wd5v6ygGkISEKlkwGW17FxM49F6T4SMlre7FJQHzam7WZxMKPHqmGoggmwhs+7qeLZ19TJspfC2n
 tFh2S5HN+040y+1vUwBeckjBbVeEJcnPszDnRxi3XumlnfKURTDPvQOI7MIhRLuSc9tChMbAMxnu4n
 QyPICeZm+qpMFgUdy8vKdFU7NKmP6Ge19SkD0k3SfqOB6MNijMGVBlMDJxmfoh9uPiE2KHIDo2Zs9A
 m1H5ddDX1dWobSPx1pnm/nlNOMAvCE6Af7f+bmGgCPoMOhtHnfYjvpbUlqd/aUSafeQUenqL8a8yY9
 7CScsFjys4iQH4or+SGbcwtJkCg5NMLyMREJ+QcJQANd6D/jgefq9lVk+vmnwRKD7BE75cKdWPfX88
 EBk3k6ENCFCcR9QOW25EMrbPm0ixsUH9avRngd6oDWeiwM7aoBbjUDk9H1WAT33iVkeG1x7Q+xJBFu
 rrSGUv+JJYS21nJjOy69NbOyEfAv7A+4KErcxKo9ZwpcG00RCfM59CtWiWEfIGkoPNI9Bx7f3mZlK2
 62PSiEzqVumcUqhpMJYajHYLDAV03hudTNXrlfj7JY+iDFERrOxpNmUt1XVQkrSnFoVtDBg34SYtas
 rVENXk/3r4FDd4mUoo+Sja5jCeaZ5Q92ZWtqP//XHkBl7KP6e7uAZl/m9lCQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove support
for OX810 and OX820 restart feature.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/power/reset/Kconfig         |   7 --
 drivers/power/reset/Makefile        |   1 -
 drivers/power/reset/oxnas-restart.c | 233 ------------------------------------
 3 files changed, 241 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fff07b2bd77b..59e1ebb7842e 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -148,13 +148,6 @@ config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
 	help
 	  This driver supports Power off for Odroid Go Ultra device.
 
-config POWER_RESET_OXNAS
-	bool "OXNAS SoC restart driver"
-	depends on ARCH_OXNAS
-	default MACH_OX820
-	help
-	  Restart support for OXNAS/PLXTECH OX820 SoC.
-
 config POWER_RESET_PIIX4_POWEROFF
 	tristate "Intel PIIX4 power-off driver"
 	depends on PCI
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index d763e6735ee3..a95d1bd275d1 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_LINKSTATION) += linkstation-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_MT6323) += mt6323-poweroff.o
-obj-$(CONFIG_POWER_RESET_OXNAS) += oxnas-restart.o
 obj-$(CONFIG_POWER_RESET_QCOM_PON) += qcom-pon.o
 obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
 obj-$(CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF) += odroid-go-ultra-poweroff.o
diff --git a/drivers/power/reset/oxnas-restart.c b/drivers/power/reset/oxnas-restart.c
deleted file mode 100644
index 13090bec058a..000000000000
--- a/drivers/power/reset/oxnas-restart.c
+++ /dev/null
@@ -1,233 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0)
-/*
- * oxnas SoC reset driver
- * based on:
- * Microsemi MIPS SoC reset driver
- * and ox820_assert_system_reset() written by Ma Hajun <mahaijuns@gmail.com>
- *
- * Copyright (c) 2013 Ma Hajun <mahaijuns@gmail.com>
- * Copyright (c) 2017 Microsemi Corporation
- * Copyright (c) 2020 Daniel Golle <daniel@makrotopia.org>
- */
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/notifier.h>
-#include <linux/mfd/syscon.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
-#include <linux/reboot.h>
-#include <linux/regmap.h>
-
-/* bit numbers of reset control register */
-#define OX820_SYS_CTRL_RST_SCU                0
-#define OX820_SYS_CTRL_RST_COPRO              1
-#define OX820_SYS_CTRL_RST_ARM0               2
-#define OX820_SYS_CTRL_RST_ARM1               3
-#define OX820_SYS_CTRL_RST_USBHS              4
-#define OX820_SYS_CTRL_RST_USBHSPHYA          5
-#define OX820_SYS_CTRL_RST_MACA               6
-#define OX820_SYS_CTRL_RST_MAC                OX820_SYS_CTRL_RST_MACA
-#define OX820_SYS_CTRL_RST_PCIEA              7
-#define OX820_SYS_CTRL_RST_SGDMA              8
-#define OX820_SYS_CTRL_RST_CIPHER             9
-#define OX820_SYS_CTRL_RST_DDR                10
-#define OX820_SYS_CTRL_RST_SATA               11
-#define OX820_SYS_CTRL_RST_SATA_LINK          12
-#define OX820_SYS_CTRL_RST_SATA_PHY           13
-#define OX820_SYS_CTRL_RST_PCIEPHY            14
-#define OX820_SYS_CTRL_RST_STATIC             15
-#define OX820_SYS_CTRL_RST_GPIO               16
-#define OX820_SYS_CTRL_RST_UART1              17
-#define OX820_SYS_CTRL_RST_UART2              18
-#define OX820_SYS_CTRL_RST_MISC               19
-#define OX820_SYS_CTRL_RST_I2S                20
-#define OX820_SYS_CTRL_RST_SD                 21
-#define OX820_SYS_CTRL_RST_MACB               22
-#define OX820_SYS_CTRL_RST_PCIEB              23
-#define OX820_SYS_CTRL_RST_VIDEO              24
-#define OX820_SYS_CTRL_RST_DDR_PHY            25
-#define OX820_SYS_CTRL_RST_USBHSPHYB          26
-#define OX820_SYS_CTRL_RST_USBDEV             27
-#define OX820_SYS_CTRL_RST_ARMDBG             29
-#define OX820_SYS_CTRL_RST_PLLA               30
-#define OX820_SYS_CTRL_RST_PLLB               31
-
-/* bit numbers of clock control register */
-#define OX820_SYS_CTRL_CLK_COPRO              0
-#define OX820_SYS_CTRL_CLK_DMA                1
-#define OX820_SYS_CTRL_CLK_CIPHER             2
-#define OX820_SYS_CTRL_CLK_SD                 3
-#define OX820_SYS_CTRL_CLK_SATA               4
-#define OX820_SYS_CTRL_CLK_I2S                5
-#define OX820_SYS_CTRL_CLK_USBHS              6
-#define OX820_SYS_CTRL_CLK_MACA               7
-#define OX820_SYS_CTRL_CLK_MAC                OX820_SYS_CTRL_CLK_MACA
-#define OX820_SYS_CTRL_CLK_PCIEA              8
-#define OX820_SYS_CTRL_CLK_STATIC             9
-#define OX820_SYS_CTRL_CLK_MACB               10
-#define OX820_SYS_CTRL_CLK_PCIEB              11
-#define OX820_SYS_CTRL_CLK_REF600             12
-#define OX820_SYS_CTRL_CLK_USBDEV             13
-#define OX820_SYS_CTRL_CLK_DDR                14
-#define OX820_SYS_CTRL_CLK_DDRPHY             15
-#define OX820_SYS_CTRL_CLK_DDRCK              16
-
-/* Regmap offsets */
-#define OX820_CLK_SET_REGOFFSET               0x2c
-#define OX820_CLK_CLR_REGOFFSET               0x30
-#define OX820_RST_SET_REGOFFSET               0x34
-#define OX820_RST_CLR_REGOFFSET               0x38
-#define OX820_SECONDARY_SEL_REGOFFSET         0x14
-#define OX820_TERTIARY_SEL_REGOFFSET          0x8c
-#define OX820_QUATERNARY_SEL_REGOFFSET        0x94
-#define OX820_DEBUG_SEL_REGOFFSET             0x9c
-#define OX820_ALTERNATIVE_SEL_REGOFFSET       0xa4
-#define OX820_PULLUP_SEL_REGOFFSET            0xac
-#define OX820_SEC_SECONDARY_SEL_REGOFFSET     0x100014
-#define OX820_SEC_TERTIARY_SEL_REGOFFSET      0x10008c
-#define OX820_SEC_QUATERNARY_SEL_REGOFFSET    0x100094
-#define OX820_SEC_DEBUG_SEL_REGOFFSET         0x10009c
-#define OX820_SEC_ALTERNATIVE_SEL_REGOFFSET   0x1000a4
-#define OX820_SEC_PULLUP_SEL_REGOFFSET        0x1000ac
-
-struct oxnas_restart_context {
-	struct regmap *sys_ctrl;
-	struct notifier_block restart_handler;
-};
-
-static int ox820_restart_handle(struct notifier_block *this,
-				 unsigned long mode, void *cmd)
-{
-	struct oxnas_restart_context *ctx = container_of(this, struct
-							oxnas_restart_context,
-							restart_handler);
-	u32 value;
-
-	/*
-	 * Assert reset to cores as per power on defaults
-	 * Don't touch the DDR interface as things will come to an impromptu
-	 * stop NB Possibly should be asserting reset for PLLB, but there are
-	 * timing concerns here according to the docs
-	 */
-	value = BIT(OX820_SYS_CTRL_RST_COPRO)		|
-		BIT(OX820_SYS_CTRL_RST_USBHS)		|
-		BIT(OX820_SYS_CTRL_RST_USBHSPHYA)	|
-		BIT(OX820_SYS_CTRL_RST_MACA)		|
-		BIT(OX820_SYS_CTRL_RST_PCIEA)		|
-		BIT(OX820_SYS_CTRL_RST_SGDMA)		|
-		BIT(OX820_SYS_CTRL_RST_CIPHER)		|
-		BIT(OX820_SYS_CTRL_RST_SATA)		|
-		BIT(OX820_SYS_CTRL_RST_SATA_LINK)	|
-		BIT(OX820_SYS_CTRL_RST_SATA_PHY)	|
-		BIT(OX820_SYS_CTRL_RST_PCIEPHY)		|
-		BIT(OX820_SYS_CTRL_RST_STATIC)		|
-		BIT(OX820_SYS_CTRL_RST_UART1)		|
-		BIT(OX820_SYS_CTRL_RST_UART2)		|
-		BIT(OX820_SYS_CTRL_RST_MISC)		|
-		BIT(OX820_SYS_CTRL_RST_I2S)		|
-		BIT(OX820_SYS_CTRL_RST_SD)		|
-		BIT(OX820_SYS_CTRL_RST_MACB)		|
-		BIT(OX820_SYS_CTRL_RST_PCIEB)		|
-		BIT(OX820_SYS_CTRL_RST_VIDEO)		|
-		BIT(OX820_SYS_CTRL_RST_USBHSPHYB)	|
-		BIT(OX820_SYS_CTRL_RST_USBDEV);
-
-	regmap_write(ctx->sys_ctrl, OX820_RST_SET_REGOFFSET, value);
-
-	/* Release reset to cores as per power on defaults */
-	regmap_write(ctx->sys_ctrl, OX820_RST_CLR_REGOFFSET,
-			BIT(OX820_SYS_CTRL_RST_GPIO));
-
-	/*
-	 * Disable clocks to cores as per power-on defaults - must leave DDR
-	 * related clocks enabled otherwise we'll stop rather abruptly.
-	 */
-	value = BIT(OX820_SYS_CTRL_CLK_COPRO)		|
-		BIT(OX820_SYS_CTRL_CLK_DMA)		|
-		BIT(OX820_SYS_CTRL_CLK_CIPHER)		|
-		BIT(OX820_SYS_CTRL_CLK_SD)		|
-		BIT(OX820_SYS_CTRL_CLK_SATA)		|
-		BIT(OX820_SYS_CTRL_CLK_I2S)		|
-		BIT(OX820_SYS_CTRL_CLK_USBHS)		|
-		BIT(OX820_SYS_CTRL_CLK_MAC)		|
-		BIT(OX820_SYS_CTRL_CLK_PCIEA)		|
-		BIT(OX820_SYS_CTRL_CLK_STATIC)		|
-		BIT(OX820_SYS_CTRL_CLK_MACB)		|
-		BIT(OX820_SYS_CTRL_CLK_PCIEB)		|
-		BIT(OX820_SYS_CTRL_CLK_REF600)		|
-		BIT(OX820_SYS_CTRL_CLK_USBDEV);
-
-	regmap_write(ctx->sys_ctrl, OX820_CLK_CLR_REGOFFSET, value);
-
-	/* Enable clocks to cores as per power-on defaults */
-
-	/* Set sys-control pin mux'ing as per power-on defaults */
-	regmap_write(ctx->sys_ctrl, OX820_SECONDARY_SEL_REGOFFSET, 0);
-	regmap_write(ctx->sys_ctrl, OX820_TERTIARY_SEL_REGOFFSET, 0);
-	regmap_write(ctx->sys_ctrl, OX820_QUATERNARY_SEL_REGOFFSET, 0);
-	regmap_write(ctx->sys_ctrl, OX820_DEBUG_SEL_REGOFFSET, 0);
-	regmap_write(ctx->sys_ctrl, OX820_ALTERNATIVE_SEL_REGOFFSET, 0);
-	regmap_write(ctx->sys_ctrl, OX820_PULLUP_SEL_REGOFFSET, 0);
-
-	regmap_write(ctx->sys_ctrl, OX820_SEC_SECONDARY_SEL_REGOFFSET, 0);
-	regmap_write(ctx->sys_ctrl, OX820_SEC_TERTIARY_SEL_REGOFFSET, 0);
-	regmap_write(ctx->sys_ctrl, OX820_SEC_QUATERNARY_SEL_REGOFFSET, 0);
-	regmap_write(ctx->sys_ctrl, OX820_SEC_DEBUG_SEL_REGOFFSET, 0);
-	regmap_write(ctx->sys_ctrl, OX820_SEC_ALTERNATIVE_SEL_REGOFFSET, 0);
-	regmap_write(ctx->sys_ctrl, OX820_SEC_PULLUP_SEL_REGOFFSET, 0);
-
-	/*
-	 * No need to save any state, as the ROM loader can determine whether
-	 * reset is due to power cycling or programatic action, just hit the
-	 * (self-clearing) CPU reset bit of the block reset register
-	 */
-	value =
-		BIT(OX820_SYS_CTRL_RST_SCU) |
-		BIT(OX820_SYS_CTRL_RST_ARM0) |
-		BIT(OX820_SYS_CTRL_RST_ARM1);
-
-	regmap_write(ctx->sys_ctrl, OX820_RST_SET_REGOFFSET, value);
-
-	pr_emerg("Unable to restart system\n");
-	return NOTIFY_DONE;
-}
-
-static int ox820_restart_probe(struct platform_device *pdev)
-{
-	struct oxnas_restart_context *ctx;
-	struct regmap *sys_ctrl;
-	struct device *dev = &pdev->dev;
-	int err = 0;
-
-	sys_ctrl = syscon_node_to_regmap(pdev->dev.of_node);
-	if (IS_ERR(sys_ctrl))
-		return PTR_ERR(sys_ctrl);
-
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-
-	ctx->sys_ctrl = sys_ctrl;
-	ctx->restart_handler.notifier_call = ox820_restart_handle;
-	ctx->restart_handler.priority = 192;
-	err = register_restart_handler(&ctx->restart_handler);
-	if (err)
-		dev_err(dev, "can't register restart notifier (err=%d)\n", err);
-
-	return err;
-}
-
-static const struct of_device_id ox820_restart_of_match[] = {
-	{ .compatible = "oxsemi,ox820-sys-ctrl" },
-	{}
-};
-
-static struct platform_driver ox820_restart_driver = {
-	.probe = ox820_restart_probe,
-	.driver = {
-		.name = "ox820-chip-reset",
-		.of_match_table = ox820_restart_of_match,
-	},
-};
-builtin_platform_driver(ox820_restart_driver);

-- 
2.34.1

