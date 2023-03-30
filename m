Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4EA6CFE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjC3IUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjC3IUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:20:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E847A88
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:20:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t4so12937331wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680164414; x=1682756414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0XqBSHeGaRLN4xCxXbyLWOL7vWA6ZUNFt6cUQb67fI=;
        b=j+R5DCsD3lKi7RDWCWZLpN7cw71ovVStKaU8RWZiqnT6u5n+PoYn6UFpndbaX47Wjl
         V1P95W0gQYPO5UqTxp9RB7qTyoQWJE8CXDboVD6mu0WIkDhrNHhmQZ+uLNcY7ALX0cOL
         g7njKa8Zy22IVas5FPEbBAH9YiJMCXo2x6rbxpsE8951USamGmIbg9PeS6u/ZK0Qlzap
         AyobzE7Oqd4VN+sQR/Tt4OwNuXyvqa13ADH3hyssav1XP8Qw/QIiGavBNUe4A8Al4Xio
         iaxFMN3rWO7PDecwsVw7TGd0mr4VYhtw4e3sZbj9Nhoa6J73FfwPR2lp8RSXL5ET9GKm
         zSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680164414; x=1682756414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0XqBSHeGaRLN4xCxXbyLWOL7vWA6ZUNFt6cUQb67fI=;
        b=I0RFvjhxG5kJjNWBIYkzjFg8+WSqXOBKrhiPlgDUjpD3GWbKNMVi1iniRRlfDQgMpU
         KsjLyLA/ir7qwBgIFR8mnXkUfNNYruTLjfcaK4W7em17qyq1PRHUgZ+3/5LV7Exhg5cv
         7g8LqHhkfmsUGgUzqiqLZdX/1mgAHm6xE2+rOo3VJf4FAw6ED4S/bUV5Nfdiz6NH5rTe
         uHKsBxZvkDnr/IcY5xpsgp9pzfIradKSUSyASA++36ym9RURBWCRy/7X2AZ40ZVms9Tb
         yK/KKp2UAj+ggvkbMfoB0S6TD/WOlHPc+dd0wRviLVKoXaGb/YMXebk5u8ifrv92qWGE
         Ksbw==
X-Gm-Message-State: AAQBX9dt43kcwT5PhioS82d/eprCY45o1JQtu9Vwu7p8O8hDbbH5c2S4
        ibxc5dACgnoyTXn8QbczBKMOIA==
X-Google-Smtp-Source: AKy350ZiXOWI/5NacSA2pXDP93FN5gDkFRCPTCPxbkoDWHXFCMPcOKp4gJJM6XBUTczK3jxMlJ2Rsg==
X-Received: by 2002:adf:df12:0:b0:2d9:81b2:322a with SMTP id y18-20020adfdf12000000b002d981b2322amr17716930wrl.55.1680164414171;
        Thu, 30 Mar 2023 01:20:14 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d4e8d000000b002ceacff44c7sm32286588wru.83.2023.03.30.01.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:20:13 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     yi.l.liu@intel.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH v5 2/4] mfd: tps6594: Add driver for TI TPS6594 PMIC
Date:   Thu, 30 Mar 2023 10:20:04 +0200
Message-Id: <20230330082006.11216-3-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230330082006.11216-1-jpanis@baylibre.com>
References: <20230330082006.11216-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for TPS6594 PMIC MFD core. It provides
communication through the I2C and SPI interfaces, and supports
protocols with embedded CRC data fields for safety applications.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Acked-for-MFD-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/Kconfig         |   32 ++
 drivers/mfd/Makefile        |    3 +
 drivers/mfd/tps6594-core.c  |  462 ++++++++++++++++
 drivers/mfd/tps6594-i2c.c   |  244 +++++++++
 drivers/mfd/tps6594-spi.c   |  129 +++++
 include/linux/mfd/tps6594.h | 1020 +++++++++++++++++++++++++++++++++++
 6 files changed, 1890 insertions(+)
 create mode 100644 drivers/mfd/tps6594-core.c
 create mode 100644 drivers/mfd/tps6594-i2c.c
 create mode 100644 drivers/mfd/tps6594-spi.c
 create mode 100644 include/linux/mfd/tps6594.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index fcc141e067b9..328f160b88e2 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1662,6 +1662,38 @@ config MFD_TPS65912_SPI
 	  If you say yes here you get support for the TPS65912 series of
 	  PM chips with SPI interface.
 
+config MFD_TPS6594
+	tristate
+	select MFD_CORE
+	select REGMAP
+	select REGMAP_IRQ
+
+config MFD_TPS6594_I2C
+	tristate "TI TPS6594 Power Management chip with I2C"
+	select MFD_TPS6594
+	select REGMAP_I2C
+	select CRC8
+	depends on I2C
+	help
+	  If you say yes here you get support for the TPS6594 series of
+	  PM chips with I2C interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called tps6594-i2c.
+
+config MFD_TPS6594_SPI
+	tristate "TI TPS6594 Power Management chip with SPI"
+	select MFD_TPS6594
+	select REGMAP_SPI
+	select CRC8
+	depends on SPI_MASTER
+	help
+	  If you say yes here you get support for the TPS6594 series of
+	  PM chips with SPI interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called tps6594-spi.
+
 config TWL4030_CORE
 	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
 	depends on I2C=y
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2f6c89d1e277..27d0d5c9cff9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -96,6 +96,9 @@ obj-$(CONFIG_MFD_TPS65910)	+= tps65910.o
 obj-$(CONFIG_MFD_TPS65912)	+= tps65912-core.o
 obj-$(CONFIG_MFD_TPS65912_I2C)	+= tps65912-i2c.o
 obj-$(CONFIG_MFD_TPS65912_SPI)  += tps65912-spi.o
+obj-$(CONFIG_MFD_TPS6594)	+= tps6594-core.o
+obj-$(CONFIG_MFD_TPS6594_I2C)	+= tps6594-i2c.o
+obj-$(CONFIG_MFD_TPS6594_SPI)	+= tps6594-spi.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 
 obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
new file mode 100644
index 000000000000..15f314833207
--- /dev/null
+++ b/drivers/mfd/tps6594-core.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Core functions for TI TPS6594/TPS6593/LP8764 PMICs
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#include <linux/mfd/core.h>
+#include <linux/mfd/tps6594.h>
+
+#define TPS6594_CRC_SYNC_TIMEOUT_MS 150
+
+/* Completion to synchronize CRC feature enabling on all PMICs */
+static DECLARE_COMPLETION(tps6594_crc_comp);
+
+static const struct resource tps6594_regulator_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK1_OV, TPS6594_IRQ_NAME_BUCK1_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK1_UV, TPS6594_IRQ_NAME_BUCK1_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK1_SC, TPS6594_IRQ_NAME_BUCK1_SC),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK1_ILIM, TPS6594_IRQ_NAME_BUCK1_ILIM),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK2_OV, TPS6594_IRQ_NAME_BUCK2_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK2_UV, TPS6594_IRQ_NAME_BUCK2_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK2_SC, TPS6594_IRQ_NAME_BUCK2_SC),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK2_ILIM, TPS6594_IRQ_NAME_BUCK2_ILIM),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK3_OV, TPS6594_IRQ_NAME_BUCK3_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK3_UV, TPS6594_IRQ_NAME_BUCK3_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK3_SC, TPS6594_IRQ_NAME_BUCK3_SC),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK3_ILIM, TPS6594_IRQ_NAME_BUCK3_ILIM),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK4_OV, TPS6594_IRQ_NAME_BUCK4_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK4_UV, TPS6594_IRQ_NAME_BUCK4_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK4_SC, TPS6594_IRQ_NAME_BUCK4_SC),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK4_ILIM, TPS6594_IRQ_NAME_BUCK4_ILIM),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK5_OV, TPS6594_IRQ_NAME_BUCK5_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK5_UV, TPS6594_IRQ_NAME_BUCK5_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK5_SC, TPS6594_IRQ_NAME_BUCK5_SC),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BUCK5_ILIM, TPS6594_IRQ_NAME_BUCK5_ILIM),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO1_OV, TPS6594_IRQ_NAME_LDO1_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO1_UV, TPS6594_IRQ_NAME_LDO1_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO1_SC, TPS6594_IRQ_NAME_LDO1_SC),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO1_ILIM, TPS6594_IRQ_NAME_LDO1_ILIM),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO2_OV, TPS6594_IRQ_NAME_LDO2_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO2_UV, TPS6594_IRQ_NAME_LDO2_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO2_SC, TPS6594_IRQ_NAME_LDO2_SC),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO2_ILIM, TPS6594_IRQ_NAME_LDO2_ILIM),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO3_OV, TPS6594_IRQ_NAME_LDO3_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO3_UV, TPS6594_IRQ_NAME_LDO3_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO3_SC, TPS6594_IRQ_NAME_LDO3_SC),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO3_ILIM, TPS6594_IRQ_NAME_LDO3_ILIM),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO4_OV, TPS6594_IRQ_NAME_LDO4_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO4_UV, TPS6594_IRQ_NAME_LDO4_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO4_SC, TPS6594_IRQ_NAME_LDO4_SC),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_LDO4_ILIM, TPS6594_IRQ_NAME_LDO4_ILIM),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_VCCA_OV, TPS6594_IRQ_NAME_VCCA_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_VCCA_UV, TPS6594_IRQ_NAME_VCCA_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_VMON1_OV, TPS6594_IRQ_NAME_VMON1_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_VMON1_UV, TPS6594_IRQ_NAME_VMON1_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_VMON1_RV, TPS6594_IRQ_NAME_VMON1_RV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_VMON2_OV, TPS6594_IRQ_NAME_VMON2_OV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_VMON2_UV, TPS6594_IRQ_NAME_VMON2_UV),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_VMON2_RV, TPS6594_IRQ_NAME_VMON2_RV),
+};
+
+static const struct resource tps6594_pinctrl_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_GPIO9, TPS6594_IRQ_NAME_GPIO9),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_GPIO10, TPS6594_IRQ_NAME_GPIO10),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_GPIO11, TPS6594_IRQ_NAME_GPIO11),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_GPIO1, TPS6594_IRQ_NAME_GPIO1),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_GPIO2, TPS6594_IRQ_NAME_GPIO2),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_GPIO3, TPS6594_IRQ_NAME_GPIO3),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_GPIO4, TPS6594_IRQ_NAME_GPIO4),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_GPIO5, TPS6594_IRQ_NAME_GPIO5),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_GPIO6, TPS6594_IRQ_NAME_GPIO6),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_GPIO7, TPS6594_IRQ_NAME_GPIO7),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_GPIO8, TPS6594_IRQ_NAME_GPIO8),
+};
+
+static const struct resource tps6594_pfsm_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_NPWRON_START, TPS6594_IRQ_NAME_NPWRON_START),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_ENABLE, TPS6594_IRQ_NAME_ENABLE),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_FSD, TPS6594_IRQ_NAME_FSD),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_SOFT_REBOOT, TPS6594_IRQ_NAME_SOFT_REBOOT),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BIST_PASS, TPS6594_IRQ_NAME_BIST_PASS),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_EXT_CLK, TPS6594_IRQ_NAME_EXT_CLK),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_TWARN, TPS6594_IRQ_NAME_TWARN),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_TSD_ORD, TPS6594_IRQ_NAME_TSD_ORD),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_BIST_FAIL, TPS6594_IRQ_NAME_BIST_FAIL),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_REG_CRC_ERR, TPS6594_IRQ_NAME_REG_CRC_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_RECOV_CNT, TPS6594_IRQ_NAME_RECOV_CNT),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_SPMI_ERR, TPS6594_IRQ_NAME_SPMI_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_NPWRON_LONG, TPS6594_IRQ_NAME_NPWRON_LONG),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_NINT_READBACK, TPS6594_IRQ_NAME_NINT_READBACK),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_NRSTOUT_READBACK, TPS6594_IRQ_NAME_NRSTOUT_READBACK),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_TSD_IMM, TPS6594_IRQ_NAME_TSD_IMM),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_VCCA_OVP, TPS6594_IRQ_NAME_VCCA_OVP),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_PFSM_ERR, TPS6594_IRQ_NAME_PFSM_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_IMM_SHUTDOWN, TPS6594_IRQ_NAME_IMM_SHUTDOWN),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_ORD_SHUTDOWN, TPS6594_IRQ_NAME_ORD_SHUTDOWN),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_MCU_PWR_ERR, TPS6594_IRQ_NAME_MCU_PWR_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_SOC_PWR_ERR, TPS6594_IRQ_NAME_SOC_PWR_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_COMM_FRM_ERR, TPS6594_IRQ_NAME_COMM_FRM_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_COMM_CRC_ERR, TPS6594_IRQ_NAME_COMM_CRC_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_COMM_ADR_ERR, TPS6594_IRQ_NAME_COMM_ADR_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_EN_DRV_READBACK, TPS6594_IRQ_NAME_EN_DRV_READBACK),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_NRSTOUT_SOC_READBACK,
+			     TPS6594_IRQ_NAME_NRSTOUT_SOC_READBACK),
+};
+
+static const struct resource tps6594_esm_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_ESM_SOC_PIN, TPS6594_IRQ_NAME_ESM_SOC_PIN),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_ESM_SOC_FAIL, TPS6594_IRQ_NAME_ESM_SOC_FAIL),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_ESM_SOC_RST, TPS6594_IRQ_NAME_ESM_SOC_RST),
+};
+
+static const struct resource tps6594_rtc_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_TIMER, TPS6594_IRQ_NAME_TIMER),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_ALARM, TPS6594_IRQ_NAME_ALARM),
+	DEFINE_RES_IRQ_NAMED(TPS6594_IRQ_POWER_UP, TPS6594_IRQ_NAME_POWERUP),
+};
+
+static const struct mfd_cell tps6594_common_cells[] = {
+	MFD_CELL_RES("tps6594-regulator", tps6594_regulator_resources),
+	MFD_CELL_RES("tps6594-pinctrl", tps6594_pinctrl_resources),
+	MFD_CELL_RES("tps6594-pfsm", tps6594_pfsm_resources),
+	MFD_CELL_RES("tps6594-esm", tps6594_esm_resources),
+};
+
+static const struct mfd_cell tps6594_rtc_cells[] = {
+	MFD_CELL_RES("tps6594-rtc", tps6594_rtc_resources),
+};
+
+static const struct regmap_irq tps6594_irqs[] = {
+	/* INT_BUCK1_2 register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK1_OV, 0, TPS6594_BIT_BUCKX_OV_INT(0)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK1_UV, 0, TPS6594_BIT_BUCKX_UV_INT(0)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK1_SC, 0, TPS6594_BIT_BUCKX_SC_INT(0)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK1_ILIM, 0, TPS6594_BIT_BUCKX_ILIM_INT(0)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK2_OV, 0, TPS6594_BIT_BUCKX_OV_INT(1)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK2_UV, 0, TPS6594_BIT_BUCKX_UV_INT(1)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK2_SC, 0, TPS6594_BIT_BUCKX_SC_INT(1)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK2_ILIM, 0, TPS6594_BIT_BUCKX_ILIM_INT(1)),
+
+	/* INT_BUCK3_4 register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK3_OV, 1, TPS6594_BIT_BUCKX_OV_INT(2)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK3_UV, 1, TPS6594_BIT_BUCKX_UV_INT(2)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK3_SC, 1, TPS6594_BIT_BUCKX_SC_INT(2)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK3_ILIM, 1, TPS6594_BIT_BUCKX_ILIM_INT(2)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK4_OV, 1, TPS6594_BIT_BUCKX_OV_INT(3)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK4_UV, 1, TPS6594_BIT_BUCKX_UV_INT(3)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK4_SC, 1, TPS6594_BIT_BUCKX_SC_INT(3)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK4_ILIM, 1, TPS6594_BIT_BUCKX_ILIM_INT(3)),
+
+	/* INT_BUCK5 register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK5_OV, 2, TPS6594_BIT_BUCKX_OV_INT(4)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK5_UV, 2, TPS6594_BIT_BUCKX_UV_INT(4)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK5_SC, 2, TPS6594_BIT_BUCKX_SC_INT(4)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BUCK5_ILIM, 2, TPS6594_BIT_BUCKX_ILIM_INT(4)),
+
+	/* INT_LDO1_2 register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO1_OV, 3, TPS6594_BIT_LDOX_OV_INT(0)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO1_UV, 3, TPS6594_BIT_LDOX_UV_INT(0)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO1_SC, 3, TPS6594_BIT_LDOX_SC_INT(0)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO1_ILIM, 3, TPS6594_BIT_LDOX_ILIM_INT(0)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO2_OV, 3, TPS6594_BIT_LDOX_OV_INT(1)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO2_UV, 3, TPS6594_BIT_LDOX_UV_INT(1)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO2_SC, 3, TPS6594_BIT_LDOX_SC_INT(1)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO2_ILIM, 3, TPS6594_BIT_LDOX_ILIM_INT(1)),
+
+	/* INT_LDO3_4 register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO3_OV, 4, TPS6594_BIT_LDOX_OV_INT(2)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO3_UV, 4, TPS6594_BIT_LDOX_UV_INT(2)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO3_SC, 4, TPS6594_BIT_LDOX_SC_INT(2)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO3_ILIM, 4, TPS6594_BIT_LDOX_ILIM_INT(2)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO4_OV, 4, TPS6594_BIT_LDOX_OV_INT(3)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO4_UV, 4, TPS6594_BIT_LDOX_UV_INT(3)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO4_SC, 4, TPS6594_BIT_LDOX_SC_INT(3)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_LDO4_ILIM, 4, TPS6594_BIT_LDOX_ILIM_INT(3)),
+
+	/* INT_VMON register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_VCCA_OV, 5, TPS6594_BIT_VCCA_OV_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_VCCA_UV, 5, TPS6594_BIT_VCCA_UV_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_VMON1_OV, 5, TPS6594_BIT_VMON1_OV_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_VMON1_UV, 5, TPS6594_BIT_VMON1_UV_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_VMON1_RV, 5, TPS6594_BIT_VMON1_RV_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_VMON2_OV, 5, TPS6594_BIT_VMON2_OV_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_VMON2_UV, 5, TPS6594_BIT_VMON2_UV_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_VMON2_RV, 5, TPS6594_BIT_VMON2_RV_INT),
+
+	/* INT_GPIO register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_GPIO9, 6, TPS6594_BIT_GPIO9_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_GPIO10, 6, TPS6594_BIT_GPIO10_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_GPIO11, 6, TPS6594_BIT_GPIO11_INT),
+
+	/* INT_GPIO1_8 register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_GPIO1, 7, TPS6594_BIT_GPIOX_INT(0)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_GPIO2, 7, TPS6594_BIT_GPIOX_INT(1)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_GPIO3, 7, TPS6594_BIT_GPIOX_INT(2)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_GPIO4, 7, TPS6594_BIT_GPIOX_INT(3)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_GPIO5, 7, TPS6594_BIT_GPIOX_INT(4)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_GPIO6, 7, TPS6594_BIT_GPIOX_INT(5)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_GPIO7, 7, TPS6594_BIT_GPIOX_INT(6)),
+	REGMAP_IRQ_REG(TPS6594_IRQ_GPIO8, 7, TPS6594_BIT_GPIOX_INT(7)),
+
+	/* INT_STARTUP register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_NPWRON_START, 8, TPS6594_BIT_NPWRON_START_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_ENABLE, 8, TPS6594_BIT_ENABLE_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_FSD, 8, TPS6594_BIT_FSD_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_SOFT_REBOOT, 8, TPS6594_BIT_SOFT_REBOOT_INT),
+
+	/* INT_MISC register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_BIST_PASS, 9, TPS6594_BIT_BIST_PASS_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_EXT_CLK, 9, TPS6594_BIT_EXT_CLK_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_TWARN, 9, TPS6594_BIT_TWARN_INT),
+
+	/* INT_MODERATE_ERR register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_TSD_ORD, 10, TPS6594_BIT_TSD_ORD_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_BIST_FAIL, 10, TPS6594_BIT_BIST_FAIL_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_REG_CRC_ERR, 10, TPS6594_BIT_REG_CRC_ERR_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_RECOV_CNT, 10, TPS6594_BIT_RECOV_CNT_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_SPMI_ERR, 10, TPS6594_BIT_SPMI_ERR_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_NPWRON_LONG, 10, TPS6594_BIT_NPWRON_LONG_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_NINT_READBACK, 10, TPS6594_BIT_NINT_READBACK_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_NRSTOUT_READBACK, 10, TPS6594_BIT_NRSTOUT_READBACK_INT),
+
+	/* INT_SEVERE_ERR register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_TSD_IMM, 11, TPS6594_BIT_TSD_IMM_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_VCCA_OVP, 11, TPS6594_BIT_VCCA_OVP_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_PFSM_ERR, 11, TPS6594_BIT_PFSM_ERR_INT),
+
+	/* INT_FSM_ERR register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_IMM_SHUTDOWN, 12, TPS6594_BIT_IMM_SHUTDOWN_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_ORD_SHUTDOWN, 12, TPS6594_BIT_ORD_SHUTDOWN_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_MCU_PWR_ERR, 12, TPS6594_BIT_MCU_PWR_ERR_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_SOC_PWR_ERR, 12, TPS6594_BIT_SOC_PWR_ERR_INT),
+
+	/* INT_COMM_ERR register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_COMM_FRM_ERR, 13, TPS6594_BIT_COMM_FRM_ERR_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_COMM_CRC_ERR, 13, TPS6594_BIT_COMM_CRC_ERR_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_COMM_ADR_ERR, 13, TPS6594_BIT_COMM_ADR_ERR_INT),
+
+	/* INT_READBACK_ERR register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_EN_DRV_READBACK, 14, TPS6594_BIT_EN_DRV_READBACK_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_NRSTOUT_SOC_READBACK, 14, TPS6594_BIT_NRSTOUT_SOC_READBACK_INT),
+
+	/* INT_ESM register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_ESM_SOC_PIN, 15, TPS6594_BIT_ESM_SOC_PIN_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_ESM_SOC_FAIL, 15, TPS6594_BIT_ESM_SOC_FAIL_INT),
+	REGMAP_IRQ_REG(TPS6594_IRQ_ESM_SOC_RST, 15, TPS6594_BIT_ESM_SOC_RST_INT),
+
+	/* RTC_STATUS register */
+	REGMAP_IRQ_REG(TPS6594_IRQ_TIMER, 16, TPS6594_BIT_TIMER),
+	REGMAP_IRQ_REG(TPS6594_IRQ_ALARM, 16, TPS6594_BIT_ALARM),
+	REGMAP_IRQ_REG(TPS6594_IRQ_POWER_UP, 16, TPS6594_BIT_POWER_UP),
+};
+
+static const unsigned int tps6594_irq_reg[] = {
+	TPS6594_REG_INT_BUCK1_2,
+	TPS6594_REG_INT_BUCK3_4,
+	TPS6594_REG_INT_BUCK5,
+	TPS6594_REG_INT_LDO1_2,
+	TPS6594_REG_INT_LDO3_4,
+	TPS6594_REG_INT_VMON,
+	TPS6594_REG_INT_GPIO,
+	TPS6594_REG_INT_GPIO1_8,
+	TPS6594_REG_INT_STARTUP,
+	TPS6594_REG_INT_MISC,
+	TPS6594_REG_INT_MODERATE_ERR,
+	TPS6594_REG_INT_SEVERE_ERR,
+	TPS6594_REG_INT_FSM_ERR,
+	TPS6594_REG_INT_COMM_ERR,
+	TPS6594_REG_INT_READBACK_ERR,
+	TPS6594_REG_INT_ESM,
+	TPS6594_REG_RTC_STATUS,
+};
+
+static inline unsigned int tps6594_get_irq_reg(struct regmap_irq_chip_data *data,
+					       unsigned int base, int index)
+{
+	return tps6594_irq_reg[index];
+};
+
+static int tps6594_handle_post_irq(void *irq_drv_data)
+{
+	struct tps6594 *tps = irq_drv_data;
+	int ret = 0;
+
+	/*
+	 * When CRC is enabled, writing to a read-only bit triggers an error,
+	 * and COMM_ADR_ERR_INT bit is set. Besides, bits indicating interrupts
+	 * (that must be cleared) and read-only bits are sometimes grouped in
+	 * the same register.
+	 * Since regmap clears interrupts by doing a write per register, clearing
+	 * an interrupt bit in a register containing also a read-only bit makes
+	 * COMM_ADR_ERR_INT bit set. Clear immediately this bit to avoid raising
+	 * a new interrupt.
+	 */
+	if (tps->use_crc)
+		ret = regmap_write_bits(tps->regmap, TPS6594_REG_INT_COMM_ERR,
+					TPS6594_BIT_COMM_ADR_ERR_INT,
+					TPS6594_BIT_COMM_ADR_ERR_INT);
+
+	return ret;
+};
+
+static struct regmap_irq_chip tps6594_irq_chip = {
+	.ack_base = TPS6594_REG_INT_BUCK1_2,
+	.ack_invert = 1,
+	.clear_ack = 1,
+	.init_ack_masked = 1,
+	.num_regs = ARRAY_SIZE(tps6594_irq_reg),
+	.irqs = tps6594_irqs,
+	.num_irqs = ARRAY_SIZE(tps6594_irqs),
+	.get_irq_reg = tps6594_get_irq_reg,
+	.handle_post_irq = tps6594_handle_post_irq,
+};
+
+bool tps6594_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return (reg >= TPS6594_REG_INT_TOP && reg <= TPS6594_REG_STAT_READBACK_ERR) ||
+	       reg == TPS6594_REG_RTC_STATUS;
+}
+EXPORT_SYMBOL_GPL(tps6594_is_volatile_reg);
+
+static int tps6594_check_crc_mode(struct tps6594 *tps, bool primary_pmic)
+{
+	int ret;
+
+	/*
+	 * Check if CRC is enabled.
+	 * Once CRC is enabled, it can't be disabled until next power cycle.
+	 */
+	tps->use_crc = true;
+	ret = regmap_test_bits(tps->regmap, TPS6594_REG_SERIAL_IF_CONFIG,
+			       TPS6594_BIT_I2C1_SPI_CRC_EN);
+	if (ret == 0) {
+		ret = -EIO;
+	} else if (ret > 0) {
+		dev_info(tps->dev, "CRC feature enabled on %s PMIC",
+			 primary_pmic ? "primary" : "secondary");
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int tps6594_set_crc_feature(struct tps6594 *tps)
+{
+	int ret;
+
+	ret = tps6594_check_crc_mode(tps, true);
+	if (ret) {
+		/*
+		 * If CRC is not already enabled, force PFSM I2C_2 trigger to enable it
+		 * on primary PMIC.
+		 */
+		tps->use_crc = false;
+		ret = regmap_write_bits(tps->regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
+					TPS6594_BIT_TRIGGER_I2C(2), TPS6594_BIT_TRIGGER_I2C(2));
+		if (ret)
+			return ret;
+
+		/*
+		 * Wait for PFSM to process trigger.
+		 * The datasheet indicates 2 ms, and clock specification is +/-5%.
+		 * 4 ms should provide sufficient margin.
+		 */
+		usleep_range(4000, 5000);
+
+		ret = tps6594_check_crc_mode(tps, true);
+	}
+
+	return ret;
+}
+
+static int tps6594_enable_crc(struct tps6594 *tps)
+{
+	struct device *dev = tps->dev;
+	unsigned int is_primary;
+	unsigned long timeout = msecs_to_jiffies(TPS6594_CRC_SYNC_TIMEOUT_MS);
+	int ret;
+
+	/*
+	 * CRC mode can be used with I2C or SPI protocols.
+	 * If this mode is specified for primary PMIC, it will also be applied to secondary PMICs
+	 * through SPMI serial interface.
+	 * In this multi-PMIC synchronization scheme, the primary PMIC is the controller device
+	 * on the SPMI bus, and the secondary PMICs are the target devices on the SPMI bus.
+	 */
+	is_primary = of_property_read_bool(dev->of_node, "ti,primary-pmic");
+	if (is_primary) {
+		/* Enable CRC feature on primary PMIC */
+		ret = tps6594_set_crc_feature(tps);
+		if (ret)
+			return ret;
+
+		/* Notify secondary PMICs that CRC feature is enabled */
+		complete_all(&tps6594_crc_comp);
+	} else {
+		/* Wait for CRC feature enabling event from primary PMIC */
+		ret = wait_for_completion_interruptible_timeout(&tps6594_crc_comp, timeout);
+		if (ret == 0)
+			ret = -ETIMEDOUT;
+		else if (ret > 0)
+			ret = tps6594_check_crc_mode(tps, false);
+	}
+
+	return ret;
+}
+
+int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
+{
+	struct device *dev = tps->dev;
+	int ret;
+
+	if (enable_crc) {
+		ret = tps6594_enable_crc(tps);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to enable CRC\n");
+	}
+
+	/* Keep PMIC in ACTIVE state */
+	ret = regmap_set_bits(tps->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
+			      TPS6594_BIT_NSLEEP1B | TPS6594_BIT_NSLEEP2B);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set PMIC state\n");
+
+	tps6594_irq_chip.irq_drv_data = tps;
+	tps6594_irq_chip.name = devm_kasprintf(dev, GFP_KERNEL, "%s-%ld-0x%02x",
+					       dev->driver->name, tps->chip_id, tps->reg);
+
+	ret = devm_regmap_add_irq_chip(dev, tps->regmap, tps->irq, IRQF_SHARED | IRQF_ONESHOT,
+				       0, &tps6594_irq_chip, &tps->irq_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add regmap IRQ\n");
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, tps6594_common_cells,
+				   ARRAY_SIZE(tps6594_common_cells), NULL, 0,
+				   regmap_irq_get_domain(tps->irq_data));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add common child devices\n");
+
+	/* No RTC for LP8764 */
+	if (tps->chip_id != LP8764) {
+		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, tps6594_rtc_cells,
+					   ARRAY_SIZE(tps6594_rtc_cells), NULL, 0,
+					   regmap_irq_get_domain(tps->irq_data));
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to add RTC child device\n");
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tps6594_device_init);
+
+MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
new file mode 100644
index 000000000000..449d5c61bc9f
--- /dev/null
+++ b/drivers/mfd/tps6594-i2c.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I2C access driver for TI TPS6594/TPS6593/LP8764 PMICs
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#include <linux/crc8.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/tps6594.h>
+
+static bool enable_crc;
+module_param(enable_crc, bool, 0444);
+MODULE_PARM_DESC(enable_crc, "Enable CRC feature for I2C interface");
+
+DECLARE_CRC8_TABLE(tps6594_i2c_crc_table);
+
+static int tps6594_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	int ret = i2c_transfer(adap, msgs, num);
+
+	if (ret == num)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static int tps6594_i2c_reg_read_with_crc(struct i2c_client *client, u8 page, u8 reg, u8 *val)
+{
+	struct i2c_msg msgs[2];
+	u8 buf_rx[] = { 0, 0 };
+	/* I2C address = I2C base address + Page index */
+	const u8 addr = client->addr + page;
+	/*
+	 * CRC is calculated from every bit included in the protocol
+	 * except the ACK bits from the target. Byte stream is:
+	 * - B0: (I2C_addr_7bits << 1) | WR_bit, with WR_bit = 0
+	 * - B1: reg
+	 * - B2: (I2C_addr_7bits << 1) | RD_bit, with RD_bit = 1
+	 * - B3: val
+	 * - B4: CRC from B0-B1-B2-B3
+	 */
+	u8 crc_data[] = { addr << 1, reg, addr << 1 | 1, 0 };
+	int ret;
+
+	/* Write register */
+	msgs[0].addr = addr;
+	msgs[0].flags = 0;
+	msgs[0].len = 1;
+	msgs[0].buf = &reg;
+
+	/* Read data and CRC */
+	msgs[1].addr = msgs[0].addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = 2;
+	msgs[1].buf = buf_rx;
+
+	ret = tps6594_i2c_transfer(client->adapter, msgs, 2);
+	if (ret < 0)
+		return ret;
+
+	crc_data[sizeof(crc_data) - 1] = *val = buf_rx[0];
+	if (buf_rx[1] != crc8(tps6594_i2c_crc_table, crc_data, sizeof(crc_data), CRC8_INIT_VALUE))
+		return -EIO;
+
+	return ret;
+}
+
+static int tps6594_i2c_reg_write_with_crc(struct i2c_client *client, u8 page, u8 reg, u8 val)
+{
+	struct i2c_msg msg;
+	u8 buf[] = { reg, val, 0 };
+	/* I2C address = I2C base address + Page index */
+	const u8 addr = client->addr + page;
+	/*
+	 * CRC is calculated from every bit included in the protocol
+	 * except the ACK bits from the target. Byte stream is:
+	 * - B0: (I2C_addr_7bits << 1) | WR_bit, with WR_bit = 0
+	 * - B1: reg
+	 * - B2: val
+	 * - B3: CRC from B0-B1-B2
+	 */
+	const u8 crc_data[] = { addr << 1, reg, val };
+
+	/* Write register, data and CRC */
+	msg.addr = addr;
+	msg.flags = client->flags & I2C_M_TEN;
+	msg.len = sizeof(buf);
+	msg.buf = buf;
+
+	buf[msg.len - 1] = crc8(tps6594_i2c_crc_table, crc_data, sizeof(crc_data), CRC8_INIT_VALUE);
+
+	return tps6594_i2c_transfer(client->adapter, &msg, 1);
+}
+
+static int tps6594_i2c_read(void *context, const void *reg_buf, size_t reg_size,
+			    void *val_buf, size_t val_size)
+{
+	struct i2c_client *client = context;
+	struct tps6594 *tps = i2c_get_clientdata(client);
+	struct i2c_msg msgs[2];
+	const u8 *reg_bytes = reg_buf;
+	u8 *val_bytes = val_buf;
+	const u8 page = reg_bytes[1];
+	u8 reg = reg_bytes[0];
+	int ret = 0;
+	int i;
+
+	if (tps->use_crc) {
+		/*
+		 * Auto-increment feature does not support CRC protocol.
+		 * Converts the bulk read operation into a series of single read operations.
+		 */
+		for (i = 0 ; ret == 0 && i < val_size ; i++)
+			ret = tps6594_i2c_reg_read_with_crc(client, page, reg + i, val_bytes + i);
+
+		return ret;
+	}
+
+	/* Write register: I2C address = I2C base address + Page index */
+	msgs[0].addr = client->addr + page;
+	msgs[0].flags = 0;
+	msgs[0].len = 1;
+	msgs[0].buf = &reg;
+
+	/* Read data */
+	msgs[1].addr = msgs[0].addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = val_size;
+	msgs[1].buf = val_bytes;
+
+	return tps6594_i2c_transfer(client->adapter, msgs, 2);
+}
+
+static int tps6594_i2c_write(void *context, const void *data, size_t count)
+{
+	struct i2c_client *client = context;
+	struct tps6594 *tps = i2c_get_clientdata(client);
+	struct i2c_msg msg;
+	const u8 *bytes = data;
+	u8 *buf;
+	const u8 page = bytes[1];
+	const u8 reg = bytes[0];
+	int ret = 0;
+	int i;
+
+	if (tps->use_crc) {
+		/*
+		 * Auto-increment feature does not support CRC protocol.
+		 * Converts the bulk write operation into a series of single write operations.
+		 */
+		for (i = 0 ; ret == 0 && i < count - 2 ; i++)
+			ret = tps6594_i2c_reg_write_with_crc(client, page, reg + i, bytes[i + 2]);
+
+		return ret;
+	}
+
+	/* Setup buffer: page byte is not sent */
+	buf = kzalloc(--count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = reg;
+	for (i = 0 ; i < count - 1 ; i++)
+		buf[i + 1] = bytes[i + 2];
+
+	/* Write register and data: I2C address = I2C base address + Page index */
+	msg.addr = client->addr + page;
+	msg.flags = client->flags & I2C_M_TEN;
+	msg.len = count;
+	msg.buf = buf;
+
+	ret = tps6594_i2c_transfer(client->adapter, &msg, 1);
+
+	kfree(buf);
+	return ret;
+}
+
+static const struct regmap_config tps6594_i2c_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
+	.volatile_reg = tps6594_is_volatile_reg,
+	.read = tps6594_i2c_read,
+	.write = tps6594_i2c_write,
+};
+
+static const struct of_device_id tps6594_i2c_of_match_table[] = {
+	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
+	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
+	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
+	{}
+};
+MODULE_DEVICE_TABLE(of, tps6594_i2c_of_match_table);
+
+static int tps6594_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct tps6594 *tps;
+	const struct of_device_id *match;
+
+	tps = devm_kzalloc(dev, sizeof(*tps), GFP_KERNEL);
+	if (!tps)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, tps);
+
+	tps->dev = dev;
+	tps->reg = client->addr;
+	tps->irq = client->irq;
+
+	tps->regmap = devm_regmap_init(dev, NULL, client, &tps6594_i2c_regmap_config);
+	if (IS_ERR(tps->regmap))
+		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
+
+	match = of_match_device(tps6594_i2c_of_match_table, dev);
+	if (!match)
+		return dev_err_probe(dev, PTR_ERR(match), "Failed to find matching chip ID\n");
+	tps->chip_id = (unsigned long)match->data;
+
+	crc8_populate_msb(tps6594_i2c_crc_table, TPS6594_CRC8_POLYNOMIAL);
+
+	return tps6594_device_init(tps, enable_crc);
+}
+
+static struct i2c_driver tps6594_i2c_driver = {
+	.driver	= {
+		.name = "tps6594",
+		.of_match_table = tps6594_i2c_of_match_table,
+	},
+	.probe_new = tps6594_i2c_probe,
+};
+module_i2c_driver(tps6594_i2c_driver);
+
+MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 I2C Interface Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/tps6594-spi.c b/drivers/mfd/tps6594-spi.c
new file mode 100644
index 000000000000..a938a191744f
--- /dev/null
+++ b/drivers/mfd/tps6594-spi.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI access driver for TI TPS6594/TPS6593/LP8764 PMICs
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#include <linux/crc8.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include <linux/mfd/tps6594.h>
+
+#define TPS6594_SPI_PAGE_SHIFT	5
+#define TPS6594_SPI_READ_BIT	BIT(4)
+
+static bool enable_crc;
+module_param(enable_crc, bool, 0444);
+MODULE_PARM_DESC(enable_crc, "Enable CRC feature for SPI interface");
+
+DECLARE_CRC8_TABLE(tps6594_spi_crc_table);
+
+static int tps6594_spi_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct spi_device *spi = context;
+	struct tps6594 *tps = spi_get_drvdata(spi);
+	u8 buf[4] = { 0 };
+	size_t count_rx = 1;
+	int ret;
+
+	buf[0] = reg;
+	buf[1] = TPS6594_REG_TO_PAGE(reg) << TPS6594_SPI_PAGE_SHIFT | TPS6594_SPI_READ_BIT;
+
+	if (tps->use_crc)
+		count_rx++;
+
+	ret = spi_write_then_read(spi, buf, 2, buf + 2, count_rx);
+	if (ret < 0)
+		return ret;
+
+	if (tps->use_crc && buf[3] != crc8(tps6594_spi_crc_table, buf, 3, CRC8_INIT_VALUE))
+		return -EIO;
+
+	*val = buf[2];
+
+	return 0;
+}
+
+static int tps6594_spi_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct spi_device *spi = context;
+	struct tps6594 *tps = spi_get_drvdata(spi);
+	u8 buf[4] = { 0 };
+	size_t count = 3;
+
+	buf[0] = reg;
+	buf[1] = TPS6594_REG_TO_PAGE(reg) << TPS6594_SPI_PAGE_SHIFT;
+	buf[2] = val;
+
+	if (tps->use_crc)
+		buf[3] = crc8(tps6594_spi_crc_table, buf, count++, CRC8_INIT_VALUE);
+
+	return spi_write(spi, buf, count);
+}
+
+static const struct regmap_config tps6594_spi_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
+	.volatile_reg = tps6594_is_volatile_reg,
+	.reg_read = tps6594_spi_reg_read,
+	.reg_write = tps6594_spi_reg_write,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static const struct of_device_id tps6594_spi_of_match_table[] = {
+	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
+	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
+	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
+	{}
+};
+MODULE_DEVICE_TABLE(of, tps6594_spi_of_match_table);
+
+static int tps6594_spi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct tps6594 *tps;
+	const struct of_device_id *match;
+
+	tps = devm_kzalloc(dev, sizeof(*tps), GFP_KERNEL);
+	if (!tps)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, tps);
+
+	tps->dev = dev;
+	tps->reg = spi->chip_select;
+	tps->irq = spi->irq;
+
+	tps->regmap = devm_regmap_init(dev, NULL, spi, &tps6594_spi_regmap_config);
+	if (IS_ERR(tps->regmap))
+		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
+
+	match = of_match_device(tps6594_spi_of_match_table, dev);
+	if (!match)
+		return dev_err_probe(dev, PTR_ERR(match), "Failed to find matching chip ID\n");
+	tps->chip_id = (unsigned long)match->data;
+
+	crc8_populate_msb(tps6594_spi_crc_table, TPS6594_CRC8_POLYNOMIAL);
+
+	return tps6594_device_init(tps, enable_crc);
+}
+
+static struct spi_driver tps6594_spi_driver = {
+	.driver	= {
+		.name = "tps6594",
+		.of_match_table = tps6594_spi_of_match_table,
+	},
+	.probe = tps6594_spi_probe,
+};
+module_spi_driver(tps6594_spi_driver);
+
+MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 SPI Interface Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/tps6594.h b/include/linux/mfd/tps6594.h
new file mode 100644
index 000000000000..3f7c5e23cd4c
--- /dev/null
+++ b/include/linux/mfd/tps6594.h
@@ -0,0 +1,1020 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Functions to access TPS6594 Power Management IC
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#ifndef __LINUX_MFD_TPS6594_H
+#define __LINUX_MFD_TPS6594_H
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+struct regmap_irq_chip_data;
+
+/* Chip id list */
+enum pmic_id {
+	TPS6594,
+	TPS6593,
+	LP8764,
+};
+
+/* Macro to get page index from register address */
+#define TPS6594_REG_TO_PAGE(reg)	((reg) >> 8)
+
+/* Registers for page 0 of TPS6594 */
+#define TPS6594_REG_DEV_REV				0x01
+
+#define TPS6594_REG_NVM_CODE_1				0x02
+#define TPS6594_REG_NVM_CODE_2				0x03
+
+#define TPS6594_REG_BUCKX_CTRL(buck_inst)		(0x04 + ((buck_inst) << 1))
+#define TPS6594_REG_BUCKX_CONF(buck_inst)		(0x05 + ((buck_inst) << 1))
+#define TPS6594_REG_BUCKX_VOUT_1(buck_inst)		(0x0e + ((buck_inst) << 1))
+#define TPS6594_REG_BUCKX_VOUT_2(buck_inst)		(0x0f + ((buck_inst) << 1))
+#define TPS6594_REG_BUCKX_PG_WINDOW(buck_inst)		(0x18 + (buck_inst))
+
+#define TPS6594_REG_LDOX_CTRL(ldo_inst)			(0x1d + (ldo_inst))
+#define TPS6594_REG_LDORTC_CTRL				0x22
+#define TPS6594_REG_LDOX_VOUT(ldo_inst)			(0x23 + (ldo_inst))
+#define TPS6594_REG_LDOX_PG_WINDOW(ldo_inst)		(0x27 + (ldo_inst))
+
+#define TPS6594_REG_VCCA_VMON_CTRL			0x2b
+#define TPS6594_REG_VCCA_PG_WINDOW			0x2c
+#define TPS6594_REG_VMON1_PG_WINDOW			0x2d
+#define TPS6594_REG_VMON1_PG_LEVEL			0x2e
+#define TPS6594_REG_VMON2_PG_WINDOW			0x2f
+#define TPS6594_REG_VMON2_PG_LEVEL			0x30
+
+#define TPS6594_REG_GPIOX_CONF(gpio_inst)		(0x31 + (gpio_inst))
+#define TPS6594_REG_NPWRON_CONF				0x3c
+#define TPS6594_REG_GPIO_OUT_1				0x3d
+#define TPS6594_REG_GPIO_OUT_2				0x3e
+#define TPS6594_REG_GPIO_IN_1				0x3f
+#define TPS6594_REG_GPIO_IN_2				0x40
+#define TPS6594_REG_GPIOX_OUT(gpio_inst)		(TPS6594_REG_GPIO_OUT_1 + (gpio_inst) / 8)
+#define TPS6594_REG_GPIOX_IN(gpio_inst)			(TPS6594_REG_GPIO_IN_1 + (gpio_inst) / 8)
+
+#define TPS6594_REG_GPIO_IN_1				0x3f
+#define TPS6594_REG_GPIO_IN_2				0x40
+
+#define TPS6594_REG_RAIL_SEL_1				0x41
+#define TPS6594_REG_RAIL_SEL_2				0x42
+#define TPS6594_REG_RAIL_SEL_3				0x43
+
+#define TPS6594_REG_FSM_TRIG_SEL_1			0x44
+#define TPS6594_REG_FSM_TRIG_SEL_2			0x45
+#define TPS6594_REG_FSM_TRIG_MASK_1			0x46
+#define TPS6594_REG_FSM_TRIG_MASK_2			0x47
+#define TPS6594_REG_FSM_TRIG_MASK_3			0x48
+
+#define TPS6594_REG_MASK_BUCK1_2			0x49
+#define TPS6594_REG_MASK_BUCK3_4			0x4a
+#define TPS6594_REG_MASK_BUCK5				0x4b
+#define TPS6594_REG_MASK_LDO1_2				0x4c
+#define TPS6594_REG_MASK_LDO3_4				0x4d
+#define TPS6594_REG_MASK_VMON				0x4e
+#define TPS6594_REG_MASK_GPIO1_8_FALL			0x4f
+#define TPS6594_REG_MASK_GPIO1_8_RISE			0x50
+#define TPS6594_REG_MASK_GPIO9_11			0x51
+#define TPS6594_REG_MASK_STARTUP			0x52
+#define TPS6594_REG_MASK_MISC				0x53
+#define TPS6594_REG_MASK_MODERATE_ERR			0x54
+#define TPS6594_REG_MASK_FSM_ERR			0x56
+#define TPS6594_REG_MASK_COMM_ERR			0x57
+#define TPS6594_REG_MASK_READBACK_ERR			0x58
+#define TPS6594_REG_MASK_ESM				0x59
+
+#define TPS6594_REG_INT_TOP				0x5a
+#define TPS6594_REG_INT_BUCK				0x5b
+#define TPS6594_REG_INT_BUCK1_2				0x5c
+#define TPS6594_REG_INT_BUCK3_4				0x5d
+#define TPS6594_REG_INT_BUCK5				0x5e
+#define TPS6594_REG_INT_LDO_VMON			0x5f
+#define TPS6594_REG_INT_LDO1_2				0x60
+#define TPS6594_REG_INT_LDO3_4				0x61
+#define TPS6594_REG_INT_VMON				0x62
+#define TPS6594_REG_INT_GPIO				0x63
+#define TPS6594_REG_INT_GPIO1_8				0x64
+#define TPS6594_REG_INT_STARTUP				0x65
+#define TPS6594_REG_INT_MISC				0x66
+#define TPS6594_REG_INT_MODERATE_ERR			0x67
+#define TPS6594_REG_INT_SEVERE_ERR			0x68
+#define TPS6594_REG_INT_FSM_ERR				0x69
+#define TPS6594_REG_INT_COMM_ERR			0x6a
+#define TPS6594_REG_INT_READBACK_ERR			0x6b
+#define TPS6594_REG_INT_ESM				0x6c
+
+#define TPS6594_REG_STAT_BUCK1_2			0x6d
+#define TPS6594_REG_STAT_BUCK3_4			0x6e
+#define TPS6594_REG_STAT_BUCK5				0x6f
+#define TPS6594_REG_STAT_LDO1_2				0x70
+#define TPS6594_REG_STAT_LDO3_4				0x71
+#define TPS6594_REG_STAT_VMON				0x72
+#define TPS6594_REG_STAT_STARTUP			0x73
+#define TPS6594_REG_STAT_MISC				0x74
+#define TPS6594_REG_STAT_MODERATE_ERR			0x75
+#define TPS6594_REG_STAT_SEVERE_ERR			0x76
+#define TPS6594_REG_STAT_READBACK_ERR			0x77
+
+#define TPS6594_REG_PGOOD_SEL_1				0x78
+#define TPS6594_REG_PGOOD_SEL_2				0x79
+#define TPS6594_REG_PGOOD_SEL_3				0x7a
+#define TPS6594_REG_PGOOD_SEL_4				0x7b
+
+#define TPS6594_REG_PLL_CTRL				0x7c
+
+#define TPS6594_REG_CONFIG_1				0x7d
+#define TPS6594_REG_CONFIG_2				0x7e
+
+#define TPS6594_REG_ENABLE_DRV_REG			0x80
+
+#define TPS6594_REG_MISC_CTRL				0x81
+
+#define TPS6594_REG_ENABLE_DRV_STAT			0x82
+
+#define TPS6594_REG_RECOV_CNT_REG_1			0x83
+#define TPS6594_REG_RECOV_CNT_REG_2			0x84
+
+#define TPS6594_REG_FSM_I2C_TRIGGERS			0x85
+#define TPS6594_REG_FSM_NSLEEP_TRIGGERS			0x86
+
+#define TPS6594_REG_BUCK_RESET_REG			0x87
+
+#define TPS6594_REG_SPREAD_SPECTRUM_1			0x88
+
+#define TPS6594_REG_FREQ_SEL				0x8a
+
+#define TPS6594_REG_FSM_STEP_SIZE			0x8b
+
+#define TPS6594_REG_LDO_RV_TIMEOUT_REG_1		0x8c
+#define TPS6594_REG_LDO_RV_TIMEOUT_REG_2		0x8d
+
+#define TPS6594_REG_USER_SPARE_REGS			0x8e
+
+#define TPS6594_REG_ESM_MCU_START_REG			0x8f
+#define TPS6594_REG_ESM_MCU_DELAY1_REG			0x90
+#define TPS6594_REG_ESM_MCU_DELAY2_REG			0x91
+#define TPS6594_REG_ESM_MCU_MODE_CFG			0x92
+#define TPS6594_REG_ESM_MCU_HMAX_REG			0x93
+#define TPS6594_REG_ESM_MCU_HMIN_REG			0x94
+#define TPS6594_REG_ESM_MCU_LMAX_REG			0x95
+#define TPS6594_REG_ESM_MCU_LMIN_REG			0x96
+#define TPS6594_REG_ESM_MCU_ERR_CNT_REG			0x97
+#define TPS6594_REG_ESM_SOC_START_REG			0x98
+#define TPS6594_REG_ESM_SOC_DELAY1_REG			0x99
+#define TPS6594_REG_ESM_SOC_DELAY2_REG			0x9a
+#define TPS6594_REG_ESM_SOC_MODE_CFG			0x9b
+#define TPS6594_REG_ESM_SOC_HMAX_REG			0x9c
+#define TPS6594_REG_ESM_SOC_HMIN_REG			0x9d
+#define TPS6594_REG_ESM_SOC_LMAX_REG			0x9e
+#define TPS6594_REG_ESM_SOC_LMIN_REG			0x9f
+#define TPS6594_REG_ESM_SOC_ERR_CNT_REG			0xa0
+
+#define TPS6594_REG_REGISTER_LOCK			0xa1
+
+#define TPS6594_REG_MANUFACTURING_VER			0xa6
+
+#define TPS6594_REG_CUSTOMER_NVM_ID_REG			0xa7
+
+#define TPS6594_REG_VMON_CONF_REG			0xa8
+
+#define TPS6594_REG_SOFT_REBOOT_REG			0xab
+
+#define TPS6594_REG_RTC_SECONDS				0xb5
+#define TPS6594_REG_RTC_MINUTES				0xb6
+#define TPS6594_REG_RTC_HOURS				0xb7
+#define TPS6594_REG_RTC_DAYS				0xb8
+#define TPS6594_REG_RTC_MONTHS				0xb9
+#define TPS6594_REG_RTC_YEARS				0xba
+#define TPS6594_REG_RTC_WEEKS				0xbb
+
+#define TPS6594_REG_ALARM_SECONDS			0xbc
+#define TPS6594_REG_ALARM_MINUTES			0xbd
+#define TPS6594_REG_ALARM_HOURS				0xbe
+#define TPS6594_REG_ALARM_DAYS				0xbf
+#define TPS6594_REG_ALARM_MONTHS			0xc0
+#define TPS6594_REG_ALARM_YEARS				0xc1
+
+#define TPS6594_REG_RTC_CTRL_1				0xc2
+#define TPS6594_REG_RTC_CTRL_2				0xc3
+#define TPS6594_REG_RTC_STATUS				0xc4
+#define TPS6594_REG_RTC_INTERRUPTS			0xc5
+#define TPS6594_REG_RTC_COMP_LSB			0xc6
+#define TPS6594_REG_RTC_COMP_MSB			0xc7
+#define TPS6594_REG_RTC_RESET_STATUS			0xc8
+
+#define TPS6594_REG_SCRATCH_PAD_REG_1			0xc9
+#define TPS6594_REG_SCRATCH_PAD_REG_2			0xca
+#define TPS6594_REG_SCRATCH_PAD_REG_3			0xcb
+#define TPS6594_REG_SCRATCH_PAD_REG_4			0xcc
+
+#define TPS6594_REG_PFSM_DELAY_REG_1			0xcd
+#define TPS6594_REG_PFSM_DELAY_REG_2			0xce
+#define TPS6594_REG_PFSM_DELAY_REG_3			0xcf
+#define TPS6594_REG_PFSM_DELAY_REG_4			0xd0
+
+/* Registers for page 1 of TPS6594 */
+#define TPS6594_REG_SERIAL_IF_CONFIG			0x11a
+#define TPS6594_REG_I2C1_ID				0x122
+#define TPS6594_REG_I2C2_ID				0x123
+
+/* Registers for page 4 of TPS6594 */
+#define TPS6594_REG_WD_ANSWER_REG			0x401
+#define TPS6594_REG_WD_QUESTION_ANSW_CNT		0x402
+#define TPS6594_REG_WD_WIN1_CFG				0x403
+#define TPS6594_REG_WD_WIN2_CFG				0x404
+#define TPS6594_REG_WD_LONGWIN_CFG			0x405
+#define TPS6594_REG_WD_MODE_REG				0x406
+#define TPS6594_REG_WD_QA_CFG				0x407
+#define TPS6594_REG_WD_ERR_STATUS			0x408
+#define TPS6594_REG_WD_THR_CFG				0x409
+#define TPS6594_REG_DWD_FAIL_CNT_REG			0x40a
+
+/* BUCKX_CTRL register field definition */
+#define TPS6594_BIT_BUCK_EN				BIT(0)
+#define TPS6594_BIT_BUCK_FPWM				BIT(1)
+#define TPS6594_BIT_BUCK_FPWM_MP			BIT(2)
+#define TPS6594_BIT_BUCK_VSEL				BIT(3)
+#define TPS6594_BIT_BUCK_VMON_EN			BIT(4)
+#define TPS6594_BIT_BUCK_PLDN				BIT(5)
+#define TPS6594_BIT_BUCK_RV_SEL				BIT(7)
+
+/* BUCKX_CONF register field definition */
+#define TPS6594_MASK_BUCK_SLEW_RATE			GENMASK(2, 0)
+#define TPS6594_MASK_BUCK_ILIM				GENMASK(5, 3)
+
+/* BUCKX_PG_WINDOW register field definition */
+#define TPS6594_MASK_BUCK_OV_THR			GENMASK(2, 0)
+#define TPS6594_MASK_BUCK_UV_THR			GENMASK(5, 3)
+
+/* BUCKX VSET */
+#define TPS6594_MASK_BUCKS_VSET GENMASK(7, 0)
+
+/* LDOX_CTRL register field definition */
+#define TPS6594_BIT_LDO_EN				BIT(0)
+#define TPS6594_BIT_LDO_SLOW_RAMP			BIT(1)
+#define TPS6594_BIT_LDO_VMON_EN				BIT(4)
+#define TPS6594_MASK_LDO_PLDN				GENMASK(6, 5)
+#define TPS6594_BIT_LDO_RV_SEL				BIT(7)
+
+/* LDORTC_CTRL register field definition */
+#define TPS6594_BIT_LDORTC_DIS				BIT(0)
+
+/* LDOX_VOUT register field definition */
+#define TPS6594_MASK_LDO123_VSET			GENMASK(6, 1)
+#define TPS6594_MASK_LDO4_VSET				GENMASK(6, 0)
+#define TPS6594_BIT_LDO_BYPASS				BIT(7)
+
+/* LDOX_PG_WINDOW register field definition */
+#define TPS6594_MASK_LDO_OV_THR				GENMASK(2, 0)
+#define TPS6594_MASK_LDO_UV_THR				GENMASK(5, 3)
+
+/* VCCA_VMON_CTRL register field definition */
+#define TPS6594_BIT_VMON_EN				BIT(0)
+#define TPS6594_BIT_VMON1_EN				BIT(1)
+#define TPS6594_BIT_VMON1_RV_SEL			BIT(2)
+#define TPS6594_BIT_VMON2_EN				BIT(3)
+#define TPS6594_BIT_VMON2_RV_SEL			BIT(4)
+#define TPS6594_BIT_VMON_DEGLITCH_SEL			BIT(5)
+
+/* VCCA_PG_WINDOW register field definition */
+#define TPS6594_MASK_VCCA_OV_THR			GENMASK(2, 0)
+#define TPS6594_MASK_VCCA_UV_THR			GENMASK(5, 3)
+#define TPS6594_BIT_VCCA_PG_SET				BIT(6)
+
+/* VMONX_PG_WINDOW register field definition */
+#define TPS6594_MASK_VMONX_OV_THR			GENMASK(2, 0)
+#define TPS6594_MASK_VMONX_UV_THR			GENMASK(5, 3)
+#define TPS6594_BIT_VMONX_RANGE				BIT(6)
+
+/* GPIOX_CONF register field definition */
+#define TPS6594_BIT_GPIO_DIR				BIT(0)
+#define TPS6594_BIT_GPIO_OD				BIT(1)
+#define TPS6594_BIT_GPIO_PU_SEL				BIT(2)
+#define TPS6594_BIT_GPIO_PU_PD_EN			BIT(3)
+#define TPS6594_BIT_GPIO_DEGLITCH_EN			BIT(4)
+#define TPS6594_MASK_GPIO_SEL				GENMASK(7, 5)
+
+/* NPWRON_CONF register field definition */
+#define TPS6594_BIT_NRSTOUT_OD				BIT(0)
+#define TPS6594_BIT_ENABLE_PU_SEL			BIT(2)
+#define TPS6594_BIT_ENABLE_PU_PD_EN			BIT(3)
+#define TPS6594_BIT_ENABLE_DEGLITCH_EN			BIT(4)
+#define TPS6594_BIT_ENABLE_POL				BIT(5)
+#define TPS6594_MASK_NPWRON_SEL				GENMASK(7, 6)
+
+/* GPIO_OUT_X register field definition */
+#define TPS6594_BIT_GPIOX_OUT(gpio_inst)		BIT((gpio_inst) % 8)
+
+/* GPIO_IN_X register field definition */
+#define TPS6594_BIT_GPIOX_IN(gpio_inst)			BIT((gpio_inst) % 8)
+#define TPS6594_BIT_NPWRON_IN				BIT(3)
+
+/* RAIL_SEL_1 register field definition */
+#define TPS6594_MASK_BUCK1_GRP_SEL			GENMASK(1, 0)
+#define TPS6594_MASK_BUCK2_GRP_SEL			GENMASK(3, 2)
+#define TPS6594_MASK_BUCK3_GRP_SEL			GENMASK(5, 4)
+#define TPS6594_MASK_BUCK4_GRP_SEL			GENMASK(7, 6)
+
+/* RAIL_SEL_2 register field definition */
+#define TPS6594_MASK_BUCK5_GRP_SEL			GENMASK(1, 0)
+#define TPS6594_MASK_LDO1_GRP_SEL			GENMASK(3, 2)
+#define TPS6594_MASK_LDO2_GRP_SEL			GENMASK(5, 4)
+#define TPS6594_MASK_LDO3_GRP_SEL			GENMASK(7, 6)
+
+/* RAIL_SEL_3 register field definition */
+#define TPS6594_MASK_LDO4_GRP_SEL			GENMASK(1, 0)
+#define TPS6594_MASK_VCCA_GRP_SEL			GENMASK(3, 2)
+#define TPS6594_MASK_VMON1_GRP_SEL			GENMASK(5, 4)
+#define TPS6594_MASK_VMON2_GRP_SEL			GENMASK(7, 6)
+
+/* FSM_TRIG_SEL_1 register field definition */
+#define TPS6594_MASK_MCU_RAIL_TRIG			GENMASK(1, 0)
+#define TPS6594_MASK_SOC_RAIL_TRIG			GENMASK(3, 2)
+#define TPS6594_MASK_OTHER_RAIL_TRIG			GENMASK(5, 4)
+#define TPS6594_MASK_SEVERE_ERR_TRIG			GENMASK(7, 6)
+
+/* FSM_TRIG_SEL_2 register field definition */
+#define TPS6594_MASK_MODERATE_ERR_TRIG			GENMASK(1, 0)
+
+/* FSM_TRIG_MASK_X register field definition */
+#define TPS6594_BIT_GPIOX_FSM_MASK(gpio_inst)		BIT(((gpio_inst) << 1) % 8)
+#define TPS6594_BIT_GPIOX_FSM_MASK_POL(gpio_inst)	BIT(((gpio_inst) << 1) % 8 + 1)
+
+/* MASK_BUCKX register field definition */
+#define TPS6594_BIT_BUCKX_OV_MASK(buck_inst)		BIT(((buck_inst) << 2) % 8)
+#define TPS6594_BIT_BUCKX_UV_MASK(buck_inst)		BIT(((buck_inst) << 2) % 8 + 1)
+#define TPS6594_BIT_BUCKX_ILIM_MASK(buck_inst)		BIT(((buck_inst) << 2) % 8 + 3)
+
+/* MASK_LDOX register field definition */
+#define TPS6594_BIT_LDOX_OV_MASK(ldo_inst)		BIT(((ldo_inst) << 2) % 8)
+#define TPS6594_BIT_LDOX_UV_MASK(ldo_inst)		BIT(((ldo_inst) << 2) % 8 + 1)
+#define TPS6594_BIT_LDOX_ILIM_MASK(ldo_inst)		BIT(((ldo_inst) << 2) % 8 + 3)
+
+/* MASK_VMON register field definition */
+#define TPS6594_BIT_VCCA_OV_MASK			BIT(0)
+#define TPS6594_BIT_VCCA_UV_MASK			BIT(1)
+#define TPS6594_BIT_VMON1_OV_MASK			BIT(2)
+#define TPS6594_BIT_VMON1_UV_MASK			BIT(3)
+#define TPS6594_BIT_VMON2_OV_MASK			BIT(5)
+#define TPS6594_BIT_VMON2_UV_MASK			BIT(6)
+
+/* MASK_GPIOX register field definition */
+#define TPS6594_BIT_GPIOX_FALL_MASK(gpio_inst)		BIT((gpio_inst) < 8 ? \
+							    (gpio_inst) : (gpio_inst) % 8)
+#define TPS6594_BIT_GPIOX_RISE_MASK(gpio_inst)		BIT((gpio_inst) < 8 ? \
+							    (gpio_inst) : (gpio_inst) % 8 + 3)
+
+/* MASK_STARTUP register field definition */
+#define TPS6594_BIT_NPWRON_START_MASK			BIT(0)
+#define TPS6594_BIT_ENABLE_MASK				BIT(1)
+#define TPS6594_BIT_FSD_MASK				BIT(4)
+#define TPS6594_BIT_SOFT_REBOOT_MASK			BIT(5)
+
+/* MASK_MISC register field definition */
+#define TPS6594_BIT_BIST_PASS_MASK			BIT(0)
+#define TPS6594_BIT_EXT_CLK_MASK			BIT(1)
+#define TPS6594_BIT_TWARN_MASK				BIT(3)
+
+/* MASK_MODERATE_ERR register field definition */
+#define TPS6594_BIT_BIST_FAIL_MASK			BIT(1)
+#define TPS6594_BIT_REG_CRC_ERR_MASK			BIT(2)
+#define TPS6594_BIT_SPMI_ERR_MASK			BIT(4)
+#define TPS6594_BIT_NPWRON_LONG_MASK			BIT(5)
+#define TPS6594_BIT_NINT_READBACK_MASK			BIT(6)
+#define TPS6594_BIT_NRSTOUT_READBACK_MASK		BIT(7)
+
+/* MASK_FSM_ERR register field definition */
+#define TPS6594_BIT_IMM_SHUTDOWN_MASK			BIT(0)
+#define TPS6594_BIT_ORD_SHUTDOWN_MASK			BIT(1)
+#define TPS6594_BIT_MCU_PWR_ERR_MASK			BIT(2)
+#define TPS6594_BIT_SOC_PWR_ERR_MASK			BIT(3)
+
+/* MASK_COMM_ERR register field definition */
+#define TPS6594_BIT_COMM_FRM_ERR_MASK			BIT(0)
+#define TPS6594_BIT_COMM_CRC_ERR_MASK			BIT(1)
+#define TPS6594_BIT_COMM_ADR_ERR_MASK			BIT(3)
+#define TPS6594_BIT_I2C2_CRC_ERR_MASK			BIT(5)
+#define TPS6594_BIT_I2C2_ADR_ERR_MASK			BIT(7)
+
+/* MASK_READBACK_ERR register field definition */
+#define TPS6594_BIT_EN_DRV_READBACK_MASK		BIT(0)
+#define TPS6594_BIT_NRSTOUT_SOC_READBACK_MASK		BIT(3)
+
+/* MASK_ESM register field definition */
+#define TPS6594_BIT_ESM_SOC_PIN_MASK			BIT(0)
+#define TPS6594_BIT_ESM_SOC_FAIL_MASK			BIT(1)
+#define TPS6594_BIT_ESM_SOC_RST_MASK			BIT(2)
+#define TPS6594_BIT_ESM_MCU_PIN_MASK			BIT(3)
+#define TPS6594_BIT_ESM_MCU_FAIL_MASK			BIT(4)
+#define TPS6594_BIT_ESM_MCU_RST_MASK			BIT(5)
+
+/* INT_TOP register field definition */
+#define TPS6594_BIT_BUCK_INT				BIT(0)
+#define TPS6594_BIT_LDO_VMON_INT			BIT(1)
+#define TPS6594_BIT_GPIO_INT				BIT(2)
+#define TPS6594_BIT_STARTUP_INT				BIT(3)
+#define TPS6594_BIT_MISC_INT				BIT(4)
+#define TPS6594_BIT_MODERATE_ERR_INT			BIT(5)
+#define TPS6594_BIT_SEVERE_ERR_INT			BIT(6)
+#define TPS6594_BIT_FSM_ERR_INT				BIT(7)
+
+/* INT_BUCK register field definition */
+#define TPS6594_BIT_BUCK1_2_INT				BIT(0)
+#define TPS6594_BIT_BUCK3_4_INT				BIT(1)
+#define TPS6594_BIT_BUCK5_INT				BIT(2)
+
+/* INT_BUCKX register field definition */
+#define TPS6594_BIT_BUCKX_OV_INT(buck_inst)		BIT(((buck_inst) << 2) % 8)
+#define TPS6594_BIT_BUCKX_UV_INT(buck_inst)		BIT(((buck_inst) << 2) % 8 + 1)
+#define TPS6594_BIT_BUCKX_SC_INT(buck_inst)		BIT(((buck_inst) << 2) % 8 + 2)
+#define TPS6594_BIT_BUCKX_ILIM_INT(buck_inst)		BIT(((buck_inst) << 2) % 8 + 3)
+
+/* INT_LDO_VMON register field definition */
+#define TPS6594_BIT_LDO1_2_INT				BIT(0)
+#define TPS6594_BIT_LDO3_4_INT				BIT(1)
+#define TPS6594_BIT_VCCA_INT				BIT(4)
+
+/* INT_LDOX register field definition */
+#define TPS6594_BIT_LDOX_OV_INT(ldo_inst)		BIT(((ldo_inst) << 2) % 8)
+#define TPS6594_BIT_LDOX_UV_INT(ldo_inst)		BIT(((ldo_inst) << 2) % 8 + 1)
+#define TPS6594_BIT_LDOX_SC_INT(ldo_inst)		BIT(((ldo_inst) << 2) % 8 + 2)
+#define TPS6594_BIT_LDOX_ILIM_INT(ldo_inst)		BIT(((ldo_inst) << 2) % 8 + 3)
+
+/* INT_VMON register field definition */
+#define TPS6594_BIT_VCCA_OV_INT				BIT(0)
+#define TPS6594_BIT_VCCA_UV_INT				BIT(1)
+#define TPS6594_BIT_VMON1_OV_INT			BIT(2)
+#define TPS6594_BIT_VMON1_UV_INT			BIT(3)
+#define TPS6594_BIT_VMON1_RV_INT			BIT(4)
+#define TPS6594_BIT_VMON2_OV_INT			BIT(5)
+#define TPS6594_BIT_VMON2_UV_INT			BIT(6)
+#define TPS6594_BIT_VMON2_RV_INT			BIT(7)
+
+/* INT_GPIO register field definition */
+#define TPS6594_BIT_GPIO9_INT				BIT(0)
+#define TPS6594_BIT_GPIO10_INT				BIT(1)
+#define TPS6594_BIT_GPIO11_INT				BIT(2)
+#define TPS6594_BIT_GPIO1_8_INT				BIT(3)
+
+/* INT_GPIOX register field definition */
+#define TPS6594_BIT_GPIOX_INT(gpio_inst)		BIT(gpio_inst)
+
+/* INT_STARTUP register field definition */
+#define TPS6594_BIT_NPWRON_START_INT			BIT(0)
+#define TPS6594_BIT_ENABLE_INT				BIT(1)
+#define TPS6594_BIT_RTC_INT				BIT(2)
+#define TPS6594_BIT_FSD_INT				BIT(4)
+#define TPS6594_BIT_SOFT_REBOOT_INT			BIT(5)
+
+/* INT_MISC register field definition */
+#define TPS6594_BIT_BIST_PASS_INT			BIT(0)
+#define TPS6594_BIT_EXT_CLK_INT				BIT(1)
+#define TPS6594_BIT_TWARN_INT				BIT(3)
+
+/* INT_MODERATE_ERR register field definition */
+#define TPS6594_BIT_TSD_ORD_INT				BIT(0)
+#define TPS6594_BIT_BIST_FAIL_INT			BIT(1)
+#define TPS6594_BIT_REG_CRC_ERR_INT			BIT(2)
+#define TPS6594_BIT_RECOV_CNT_INT			BIT(3)
+#define TPS6594_BIT_SPMI_ERR_INT			BIT(4)
+#define TPS6594_BIT_NPWRON_LONG_INT			BIT(5)
+#define TPS6594_BIT_NINT_READBACK_INT			BIT(6)
+#define TPS6594_BIT_NRSTOUT_READBACK_INT		BIT(7)
+
+/* INT_SEVERE_ERR register field definition */
+#define TPS6594_BIT_TSD_IMM_INT				BIT(0)
+#define TPS6594_BIT_VCCA_OVP_INT			BIT(1)
+#define TPS6594_BIT_PFSM_ERR_INT			BIT(2)
+
+/* INT_FSM_ERR register field definition */
+#define TPS6594_BIT_IMM_SHUTDOWN_INT			BIT(0)
+#define TPS6594_BIT_ORD_SHUTDOWN_INT			BIT(1)
+#define TPS6594_BIT_MCU_PWR_ERR_INT			BIT(2)
+#define TPS6594_BIT_SOC_PWR_ERR_INT			BIT(3)
+#define TPS6594_BIT_COMM_ERR_INT			BIT(4)
+#define TPS6594_BIT_READBACK_ERR_INT			BIT(5)
+#define TPS6594_BIT_ESM_INT				BIT(6)
+#define TPS6594_BIT_WD_INT				BIT(7)
+
+/* INT_COMM_ERR register field definition */
+#define TPS6594_BIT_COMM_FRM_ERR_INT			BIT(0)
+#define TPS6594_BIT_COMM_CRC_ERR_INT			BIT(1)
+#define TPS6594_BIT_COMM_ADR_ERR_INT			BIT(3)
+#define TPS6594_BIT_I2C2_CRC_ERR_INT			BIT(5)
+#define TPS6594_BIT_I2C2_ADR_ERR_INT			BIT(7)
+
+/* INT_READBACK_ERR register field definition */
+#define TPS6594_BIT_EN_DRV_READBACK_INT			BIT(0)
+#define TPS6594_BIT_NRSTOUT_SOC_READBACK_INT		BIT(3)
+
+/* INT_ESM register field definition */
+#define TPS6594_BIT_ESM_SOC_PIN_INT			BIT(0)
+#define TPS6594_BIT_ESM_SOC_FAIL_INT			BIT(1)
+#define TPS6594_BIT_ESM_SOC_RST_INT			BIT(2)
+#define TPS6594_BIT_ESM_MCU_PIN_INT			BIT(3)
+#define TPS6594_BIT_ESM_MCU_FAIL_INT			BIT(4)
+#define TPS6594_BIT_ESM_MCU_RST_INT			BIT(5)
+
+/* STAT_BUCKX register field definition */
+#define TPS6594_BIT_BUCKX_OV_STAT(buck_inst)		BIT(((buck_inst) << 2) % 8)
+#define TPS6594_BIT_BUCKX_UV_STAT(buck_inst)		BIT(((buck_inst) << 2) % 8 + 1)
+#define TPS6594_BIT_BUCKX_ILIM_STAT(buck_inst)		BIT(((buck_inst) << 2) % 8 + 3)
+
+/* STAT_LDOX register field definition */
+#define TPS6594_BIT_LDOX_OV_STAT(ldo_inst)		BIT(((ldo_inst) << 2) % 8)
+#define TPS6594_BIT_LDOX_UV_STAT(ldo_inst)		BIT(((ldo_inst) << 2) % 8 + 1)
+#define TPS6594_BIT_LDOX_ILIM_STAT(ldo_inst)		BIT(((ldo_inst) << 2) % 8 + 3)
+
+/* STAT_VMON register field definition */
+#define TPS6594_BIT_VCCA_OV_STAT			BIT(0)
+#define TPS6594_BIT_VCCA_UV_STAT			BIT(1)
+#define TPS6594_BIT_VMON1_OV_STAT			BIT(2)
+#define TPS6594_BIT_VMON1_UV_STAT			BIT(3)
+#define TPS6594_BIT_VMON2_OV_STAT			BIT(5)
+#define TPS6594_BIT_VMON2_UV_STAT			BIT(6)
+
+/* STAT_STARTUP register field definition */
+#define TPS6594_BIT_ENABLE_STAT				BIT(1)
+
+/* STAT_MISC register field definition */
+#define TPS6594_BIT_EXT_CLK_STAT			BIT(1)
+#define TPS6594_BIT_TWARN_STAT				BIT(3)
+
+/* STAT_MODERATE_ERR register field definition */
+#define TPS6594_BIT_TSD_ORD_STAT			BIT(0)
+
+/* STAT_SEVERE_ERR register field definition */
+#define TPS6594_BIT_TSD_IMM_STAT			BIT(0)
+#define TPS6594_BIT_VCCA_OVP_STAT			BIT(1)
+
+/* STAT_READBACK_ERR register field definition */
+#define TPS6594_BIT_EN_DRV_READBACK_STAT		BIT(0)
+#define TPS6594_BIT_NINT_READBACK_STAT			BIT(1)
+#define TPS6594_BIT_NRSTOUT_READBACK_STAT		BIT(2)
+#define TPS6594_BIT_NRSTOUT_SOC_READBACK_STAT		BIT(3)
+
+/* PGOOD_SEL_1 register field definition */
+#define TPS6594_MASK_PGOOD_SEL_BUCK1			GENMASK(1, 0)
+#define TPS6594_MASK_PGOOD_SEL_BUCK2			GENMASK(3, 2)
+#define TPS6594_MASK_PGOOD_SEL_BUCK3			GENMASK(5, 4)
+#define TPS6594_MASK_PGOOD_SEL_BUCK4			GENMASK(7, 6)
+
+/* PGOOD_SEL_2 register field definition */
+#define TPS6594_MASK_PGOOD_SEL_BUCK5			GENMASK(1, 0)
+
+/* PGOOD_SEL_3 register field definition */
+#define TPS6594_MASK_PGOOD_SEL_LDO1			GENMASK(1, 0)
+#define TPS6594_MASK_PGOOD_SEL_LDO2			GENMASK(3, 2)
+#define TPS6594_MASK_PGOOD_SEL_LDO3			GENMASK(5, 4)
+#define TPS6594_MASK_PGOOD_SEL_LDO4			GENMASK(7, 6)
+
+/* PGOOD_SEL_4 register field definition */
+#define TPS6594_BIT_PGOOD_SEL_VCCA			BIT(0)
+#define TPS6594_BIT_PGOOD_SEL_VMON1			BIT(1)
+#define TPS6594_BIT_PGOOD_SEL_VMON2			BIT(2)
+#define TPS6594_BIT_PGOOD_SEL_TDIE_WARN			BIT(3)
+#define TPS6594_BIT_PGOOD_SEL_NRSTOUT			BIT(4)
+#define TPS6594_BIT_PGOOD_SEL_NRSTOUT_SOC		BIT(5)
+#define TPS6594_BIT_PGOOD_POL				BIT(6)
+#define TPS6594_BIT_PGOOD_WINDOW			BIT(7)
+
+/* PLL_CTRL register field definition */
+#define TPS6594_MASK_EXT_CLK_FREQ			GENMASK(1, 0)
+
+/* CONFIG_1 register field definition */
+#define TPS6594_BIT_TWARN_LEVEL				BIT(0)
+#define TPS6594_BIT_TSD_ORD_LEVEL			BIT(1)
+#define TPS6594_BIT_I2C1_HS				BIT(3)
+#define TPS6594_BIT_I2C2_HS				BIT(4)
+#define TPS6594_BIT_EN_ILIM_FSM_CTRL			BIT(5)
+#define TPS6594_BIT_NSLEEP1_MASK			BIT(6)
+#define TPS6594_BIT_NSLEEP2_MASK			BIT(7)
+
+/* CONFIG_2 register field definition */
+#define TPS6594_BIT_BB_CHARGER_EN			BIT(0)
+#define TPS6594_BIT_BB_ICHR				BIT(1)
+#define TPS6594_MASK_BB_VEOC				GENMASK(3, 2)
+#define TPS6594_BB_EOC_RDY				BIT(7)
+
+/* ENABLE_DRV_REG register field definition */
+#define TPS6594_BIT_ENABLE_DRV				BIT(0)
+
+/* MISC_CTRL register field definition */
+#define TPS6594_BIT_NRSTOUT				BIT(0)
+#define TPS6594_BIT_NRSTOUT_SOC				BIT(1)
+#define TPS6594_BIT_LPM_EN				BIT(2)
+#define TPS6594_BIT_CLKMON_EN				BIT(3)
+#define TPS6594_BIT_AMUXOUT_EN				BIT(4)
+#define TPS6594_BIT_SEL_EXT_CLK				BIT(5)
+#define TPS6594_MASK_SYNCCLKOUT_FREQ_SEL		GENMASK(7, 6)
+
+/* ENABLE_DRV_STAT register field definition */
+#define TPS6594_BIT_EN_DRV_IN				BIT(0)
+#define TPS6594_BIT_NRSTOUT_IN				BIT(1)
+#define TPS6594_BIT_NRSTOUT_SOC_IN			BIT(2)
+#define TPS6594_BIT_FORCE_EN_DRV_LOW			BIT(3)
+#define TPS6594_BIT_SPMI_LPM_EN				BIT(4)
+
+/* RECOV_CNT_REG_1 register field definition */
+#define TPS6594_MASK_RECOV_CNT				GENMASK(3, 0)
+
+/* RECOV_CNT_REG_2 register field definition */
+#define TPS6594_MASK_RECOV_CNT_THR			GENMASK(3, 0)
+#define TPS6594_BIT_RECOV_CNT_CLR			BIT(4)
+
+/* FSM_I2C_TRIGGERS register field definition */
+#define TPS6594_BIT_TRIGGER_I2C(bit)			BIT(bit)
+
+/* FSM_NSLEEP_TRIGGERS register field definition */
+#define TPS6594_BIT_NSLEEP1B				BIT(0)
+#define TPS6594_BIT_NSLEEP2B				BIT(1)
+
+/* BUCK_RESET_REG register field definition */
+#define TPS6594_BIT_BUCKX_RESET(buck_inst)		BIT(buck_inst)
+
+/* SPREAD_SPECTRUM_1 register field definition */
+#define TPS6594_MASK_SS_DEPTH				GENMASK(1, 0)
+#define TPS6594_BIT_SS_EN				BIT(2)
+
+/* FREQ_SEL register field definition */
+#define TPS6594_BIT_BUCKX_FREQ_SEL(buck_inst)		BIT(buck_inst)
+
+/* FSM_STEP_SIZE register field definition */
+#define TPS6594_MASK_PFSM_DELAY_STEP			GENMASK(4, 0)
+
+/* LDO_RV_TIMEOUT_REG_1 register field definition */
+#define TPS6594_MASK_LDO1_RV_TIMEOUT			GENMASK(3, 0)
+#define TPS6594_MASK_LDO2_RV_TIMEOUT			GENMASK(7, 4)
+
+/* LDO_RV_TIMEOUT_REG_2 register field definition */
+#define TPS6594_MASK_LDO3_RV_TIMEOUT			GENMASK(3, 0)
+#define TPS6594_MASK_LDO4_RV_TIMEOUT			GENMASK(7, 4)
+
+/* USER_SPARE_REGS register field definition */
+#define TPS6594_BIT_USER_SPARE(bit)			BIT(bit)
+
+/* ESM_MCU_START_REG register field definition */
+#define TPS6594_BIT_ESM_MCU_START			BIT(0)
+
+/* ESM_MCU_MODE_CFG register field definition */
+#define TPS6594_MASK_ESM_MCU_ERR_CNT_TH			GENMASK(3, 0)
+#define TPS6594_BIT_ESM_MCU_ENDRV			BIT(5)
+#define TPS6594_BIT_ESM_MCU_EN				BIT(6)
+#define TPS6594_BIT_ESM_MCU_MODE			BIT(7)
+
+/* ESM_MCU_ERR_CNT_REG register field definition */
+#define TPS6594_MASK_ESM_MCU_ERR_CNT			GENMASK(4, 0)
+
+/* ESM_SOC_START_REG register field definition */
+#define TPS6594_BIT_ESM_SOC_START			BIT(0)
+
+/* ESM_SOC_MODE_CFG register field definition */
+#define TPS6594_MASK_ESM_SOC_ERR_CNT_TH			GENMASK(3, 0)
+#define TPS6594_BIT_ESM_SOC_ENDRV			BIT(5)
+#define TPS6594_BIT_ESM_SOC_EN				BIT(6)
+#define TPS6594_BIT_ESM_SOC_MODE			BIT(7)
+
+/* ESM_SOC_ERR_CNT_REG register field definition */
+#define TPS6594_MASK_ESM_SOC_ERR_CNT			GENMASK(4, 0)
+
+/* REGISTER_LOCK register field definition */
+#define TPS6594_BIT_REGISTER_LOCK_STATUS		BIT(0)
+
+/* VMON_CONF register field definition */
+#define TPS6594_MASK_VMON1_SLEW_RATE			GENMASK(2, 0)
+#define TPS6594_MASK_VMON2_SLEW_RATE			GENMASK(5, 3)
+
+/* SOFT_REBOOT_REG register field definition */
+#define TPS6594_BIT_SOFT_REBOOT				BIT(0)
+
+/* RTC_SECONDS & ALARM_SECONDS register field definition */
+#define TPS6594_MASK_SECOND_0				GENMASK(3, 0)
+#define TPS6594_MASK_SECOND_1				GENMASK(6, 4)
+
+/* RTC_MINUTES & ALARM_MINUTES register field definition */
+#define TPS6594_MASK_MINUTE_0				GENMASK(3, 0)
+#define TPS6594_MASK_MINUTE_1				GENMASK(6, 4)
+
+/* RTC_HOURS & ALARM_HOURS register field definition */
+#define TPS6594_MASK_HOUR_0				GENMASK(3, 0)
+#define TPS6594_MASK_HOUR_1				GENMASK(5, 4)
+#define TPS6594_BIT_PM_NAM				BIT(7)
+
+/* RTC_DAYS & ALARM_DAYS register field definition */
+#define TPS6594_MASK_DAY_0				GENMASK(3, 0)
+#define TPS6594_MASK_DAY_1				GENMASK(5, 4)
+
+/* RTC_MONTHS & ALARM_MONTHS register field definition */
+#define TPS6594_MASK_MONTH_0				GENMASK(3, 0)
+#define TPS6594_BIT_MONTH_1				BIT(4)
+
+/* RTC_YEARS & ALARM_YEARS register field definition */
+#define TPS6594_MASK_YEAR_0				GENMASK(3, 0)
+#define TPS6594_MASK_YEAR_1				GENMASK(7, 4)
+
+/* RTC_WEEKS register field definition */
+#define TPS6594_MASK_WEEK				GENMASK(2, 0)
+
+/* RTC_CTRL_1 register field definition */
+#define TPS6594_BIT_STOP_RTC				BIT(0)
+#define TPS6594_BIT_ROUND_30S				BIT(1)
+#define TPS6594_BIT_AUTO_COMP				BIT(2)
+#define TPS6594_BIT_MODE_12_24				BIT(3)
+#define TPS6594_BIT_SET_32_COUNTER			BIT(5)
+#define TPS6594_BIT_GET_TIME				BIT(6)
+#define TPS6594_BIT_RTC_V_OPT				BIT(7)
+
+/* RTC_CTRL_2 register field definition */
+#define TPS6594_BIT_XTAL_EN				BIT(0)
+#define TPS6594_MASK_XTAL_SEL				GENMASK(2, 1)
+#define TPS6594_BIT_LP_STANDBY_SEL			BIT(3)
+#define TPS6594_BIT_FAST_BIST				BIT(4)
+#define TPS6594_MASK_STARTUP_DEST			GENMASK(6, 5)
+#define TPS6594_BIT_FIRST_STARTUP_DONE			BIT(7)
+
+/* RTC_STATUS register field definition */
+#define TPS6594_BIT_RUN					BIT(1)
+#define TPS6594_BIT_TIMER				BIT(5)
+#define TPS6594_BIT_ALARM				BIT(6)
+#define TPS6594_BIT_POWER_UP				BIT(7)
+
+/* RTC_INTERRUPTS register field definition */
+#define TPS6594_MASK_EVERY				GENMASK(1, 0)
+#define TPS6594_BIT_IT_TIMER				BIT(2)
+#define TPS6594_BIT_IT_ALARM				BIT(3)
+
+/* RTC_RESET_STATUS register field definition */
+#define TPS6594_BIT_RESET_STATUS_RTC			BIT(0)
+
+/* SERIAL_IF_CONFIG register field definition */
+#define TPS6594_BIT_I2C_SPI_SEL				BIT(0)
+#define TPS6594_BIT_I2C1_SPI_CRC_EN			BIT(1)
+#define TPS6594_BIT_I2C2_CRC_EN				BIT(2)
+#define TPS6594_MASK_T_CRC				GENMASK(7, 3)
+
+/* WD_QUESTION_ANSW_CNT register field definition */
+#define TPS6594_MASK_WD_QUESTION			GENMASK(3, 0)
+#define TPS6594_MASK_WD_ANSW_CNT			GENMASK(5, 4)
+
+/* WD_MODE_REG register field definition */
+#define TPS6594_BIT_WD_RETURN_LONGWIN			BIT(0)
+#define TPS6594_BIT_WD_MODE_SELECT			BIT(1)
+#define TPS6594_BIT_WD_PWRHOLD				BIT(2)
+
+/* WD_QA_CFG register field definition */
+#define TPS6594_MASK_WD_QUESTION_SEED			GENMASK(3, 0)
+#define TPS6594_MASK_WD_QA_LFSR				GENMASK(5, 4)
+#define TPS6594_MASK_WD_QA_FDBK				GENMASK(7, 6)
+
+/* WD_ERR_STATUS register field definition */
+#define TPS6594_BIT_WD_LONGWIN_TIMEOUT_INT		BIT(0)
+#define TPS6594_BIT_WD_TIMEOUT				BIT(1)
+#define TPS6594_BIT_WD_TRIG_EARLY			BIT(2)
+#define TPS6594_BIT_WD_ANSW_EARLY			BIT(3)
+#define TPS6594_BIT_WD_SEQ_ERR				BIT(4)
+#define TPS6594_BIT_WD_ANSW_ERR				BIT(5)
+#define TPS6594_BIT_WD_FAIL_INT				BIT(6)
+#define TPS6594_BIT_WD_RST_INT				BIT(7)
+
+/* WD_THR_CFG register field definition */
+#define TPS6594_MASK_WD_RST_TH				GENMASK(2, 0)
+#define TPS6594_MASK_WD_FAIL_TH				GENMASK(5, 3)
+#define TPS6594_BIT_WD_EN				BIT(6)
+#define TPS6594_BIT_WD_RST_EN				BIT(7)
+
+/* WD_FAIL_CNT_REG register field definition */
+#define TPS6594_MASK_WD_FAIL_CNT			GENMASK(3, 0)
+#define TPS6594_BIT_WD_FIRST_OK				BIT(5)
+#define TPS6594_BIT_WD_BAD_EVENT			BIT(6)
+
+/* CRC8 polynomial for I2C & SPI protocols */
+#define TPS6594_CRC8_POLYNOMIAL	0x07
+
+/* IRQs */
+enum tps6594_irqs {
+	/* INT_BUCK1_2 register */
+	TPS6594_IRQ_BUCK1_OV,
+	TPS6594_IRQ_BUCK1_UV,
+	TPS6594_IRQ_BUCK1_SC,
+	TPS6594_IRQ_BUCK1_ILIM,
+	TPS6594_IRQ_BUCK2_OV,
+	TPS6594_IRQ_BUCK2_UV,
+	TPS6594_IRQ_BUCK2_SC,
+	TPS6594_IRQ_BUCK2_ILIM,
+	/* INT_BUCK3_4 register */
+	TPS6594_IRQ_BUCK3_OV,
+	TPS6594_IRQ_BUCK3_UV,
+	TPS6594_IRQ_BUCK3_SC,
+	TPS6594_IRQ_BUCK3_ILIM,
+	TPS6594_IRQ_BUCK4_OV,
+	TPS6594_IRQ_BUCK4_UV,
+	TPS6594_IRQ_BUCK4_SC,
+	TPS6594_IRQ_BUCK4_ILIM,
+	/* INT_BUCK5 register */
+	TPS6594_IRQ_BUCK5_OV,
+	TPS6594_IRQ_BUCK5_UV,
+	TPS6594_IRQ_BUCK5_SC,
+	TPS6594_IRQ_BUCK5_ILIM,
+	/* INT_LDO1_2 register */
+	TPS6594_IRQ_LDO1_OV,
+	TPS6594_IRQ_LDO1_UV,
+	TPS6594_IRQ_LDO1_SC,
+	TPS6594_IRQ_LDO1_ILIM,
+	TPS6594_IRQ_LDO2_OV,
+	TPS6594_IRQ_LDO2_UV,
+	TPS6594_IRQ_LDO2_SC,
+	TPS6594_IRQ_LDO2_ILIM,
+	/* INT_LDO3_4 register */
+	TPS6594_IRQ_LDO3_OV,
+	TPS6594_IRQ_LDO3_UV,
+	TPS6594_IRQ_LDO3_SC,
+	TPS6594_IRQ_LDO3_ILIM,
+	TPS6594_IRQ_LDO4_OV,
+	TPS6594_IRQ_LDO4_UV,
+	TPS6594_IRQ_LDO4_SC,
+	TPS6594_IRQ_LDO4_ILIM,
+	/* INT_VMON register */
+	TPS6594_IRQ_VCCA_OV,
+	TPS6594_IRQ_VCCA_UV,
+	TPS6594_IRQ_VMON1_OV,
+	TPS6594_IRQ_VMON1_UV,
+	TPS6594_IRQ_VMON1_RV,
+	TPS6594_IRQ_VMON2_OV,
+	TPS6594_IRQ_VMON2_UV,
+	TPS6594_IRQ_VMON2_RV,
+	/* INT_GPIO register */
+	TPS6594_IRQ_GPIO9,
+	TPS6594_IRQ_GPIO10,
+	TPS6594_IRQ_GPIO11,
+	/* INT_GPIO1_8 register */
+	TPS6594_IRQ_GPIO1,
+	TPS6594_IRQ_GPIO2,
+	TPS6594_IRQ_GPIO3,
+	TPS6594_IRQ_GPIO4,
+	TPS6594_IRQ_GPIO5,
+	TPS6594_IRQ_GPIO6,
+	TPS6594_IRQ_GPIO7,
+	TPS6594_IRQ_GPIO8,
+	/* INT_STARTUP register */
+	TPS6594_IRQ_NPWRON_START,
+	TPS6594_IRQ_ENABLE,
+	TPS6594_IRQ_FSD,
+	TPS6594_IRQ_SOFT_REBOOT,
+	/* INT_MISC register */
+	TPS6594_IRQ_BIST_PASS,
+	TPS6594_IRQ_EXT_CLK,
+	TPS6594_IRQ_TWARN,
+	/* INT_MODERATE_ERR register */
+	TPS6594_IRQ_TSD_ORD,
+	TPS6594_IRQ_BIST_FAIL,
+	TPS6594_IRQ_REG_CRC_ERR,
+	TPS6594_IRQ_RECOV_CNT,
+	TPS6594_IRQ_SPMI_ERR,
+	TPS6594_IRQ_NPWRON_LONG,
+	TPS6594_IRQ_NINT_READBACK,
+	TPS6594_IRQ_NRSTOUT_READBACK,
+	/* INT_SEVERE_ERR register */
+	TPS6594_IRQ_TSD_IMM,
+	TPS6594_IRQ_VCCA_OVP,
+	TPS6594_IRQ_PFSM_ERR,
+	/* INT_FSM_ERR register */
+	TPS6594_IRQ_IMM_SHUTDOWN,
+	TPS6594_IRQ_ORD_SHUTDOWN,
+	TPS6594_IRQ_MCU_PWR_ERR,
+	TPS6594_IRQ_SOC_PWR_ERR,
+	/* INT_COMM_ERR register */
+	TPS6594_IRQ_COMM_FRM_ERR,
+	TPS6594_IRQ_COMM_CRC_ERR,
+	TPS6594_IRQ_COMM_ADR_ERR,
+	TPS6594_IRQ_I2C2_CRC_ERR,
+	TPS6594_IRQ_I2C2_ADR_ERR,
+	/* INT_READBACK_ERR register */
+	TPS6594_IRQ_EN_DRV_READBACK,
+	TPS6594_IRQ_NRSTOUT_SOC_READBACK,
+	/* INT_ESM register */
+	TPS6594_IRQ_ESM_SOC_PIN,
+	TPS6594_IRQ_ESM_SOC_FAIL,
+	TPS6594_IRQ_ESM_SOC_RST,
+	/* RTC_STATUS register */
+	TPS6594_IRQ_TIMER,
+	TPS6594_IRQ_ALARM,
+	TPS6594_IRQ_POWER_UP,
+};
+
+#define TPS6594_IRQ_NAME_BUCK1_OV		"buck1_ov"
+#define TPS6594_IRQ_NAME_BUCK1_UV		"buck1_uv"
+#define TPS6594_IRQ_NAME_BUCK1_SC		"buck1_sc"
+#define TPS6594_IRQ_NAME_BUCK1_ILIM		"buck1_ilim"
+#define TPS6594_IRQ_NAME_BUCK2_OV		"buck2_ov"
+#define TPS6594_IRQ_NAME_BUCK2_UV		"buck2_uv"
+#define TPS6594_IRQ_NAME_BUCK2_SC		"buck2_sc"
+#define TPS6594_IRQ_NAME_BUCK2_ILIM		"buck2_ilim"
+#define TPS6594_IRQ_NAME_BUCK3_OV		"buck3_ov"
+#define TPS6594_IRQ_NAME_BUCK3_UV		"buck3_uv"
+#define TPS6594_IRQ_NAME_BUCK3_SC		"buck3_sc"
+#define TPS6594_IRQ_NAME_BUCK3_ILIM		"buck3_ilim"
+#define TPS6594_IRQ_NAME_BUCK4_OV		"buck4_ov"
+#define TPS6594_IRQ_NAME_BUCK4_UV		"buck4_uv"
+#define TPS6594_IRQ_NAME_BUCK4_SC		"buck4_sc"
+#define TPS6594_IRQ_NAME_BUCK4_ILIM		"buck4_ilim"
+#define TPS6594_IRQ_NAME_BUCK5_OV		"buck5_ov"
+#define TPS6594_IRQ_NAME_BUCK5_UV		"buck5_uv"
+#define TPS6594_IRQ_NAME_BUCK5_SC		"buck5_sc"
+#define TPS6594_IRQ_NAME_BUCK5_ILIM		"buck5_ilim"
+#define TPS6594_IRQ_NAME_LDO1_OV		"ldo1_ov"
+#define TPS6594_IRQ_NAME_LDO1_UV		"ldo1_uv"
+#define TPS6594_IRQ_NAME_LDO1_SC		"ldo1_sc"
+#define TPS6594_IRQ_NAME_LDO1_ILIM		"ldo1_ilim"
+#define TPS6594_IRQ_NAME_LDO2_OV		"ldo2_ov"
+#define TPS6594_IRQ_NAME_LDO2_UV		"ldo2_uv"
+#define TPS6594_IRQ_NAME_LDO2_SC		"ldo2_sc"
+#define TPS6594_IRQ_NAME_LDO2_ILIM		"ldo2_ilim"
+#define TPS6594_IRQ_NAME_LDO3_OV		"ldo3_ov"
+#define TPS6594_IRQ_NAME_LDO3_UV		"ldo3_uv"
+#define TPS6594_IRQ_NAME_LDO3_SC		"ldo3_sc"
+#define TPS6594_IRQ_NAME_LDO3_ILIM		"ldo3_ilim"
+#define TPS6594_IRQ_NAME_LDO4_OV		"ldo4_ov"
+#define TPS6594_IRQ_NAME_LDO4_UV		"ldo4_uv"
+#define TPS6594_IRQ_NAME_LDO4_SC		"ldo4_sc"
+#define TPS6594_IRQ_NAME_LDO4_ILIM		"ldo4_ilim"
+#define TPS6594_IRQ_NAME_VCCA_OV		"vcca_ov"
+#define TPS6594_IRQ_NAME_VCCA_UV		"vcca_uv"
+#define TPS6594_IRQ_NAME_VMON1_OV		"vmon1_ov"
+#define TPS6594_IRQ_NAME_VMON1_UV		"vmon1_uv"
+#define TPS6594_IRQ_NAME_VMON1_RV		"vmon1_rv"
+#define TPS6594_IRQ_NAME_VMON2_OV		"vmon2_ov"
+#define TPS6594_IRQ_NAME_VMON2_UV		"vmon2_uv"
+#define TPS6594_IRQ_NAME_VMON2_RV		"vmon2_rv"
+#define TPS6594_IRQ_NAME_GPIO9			"gpio9"
+#define TPS6594_IRQ_NAME_GPIO10			"gpio10"
+#define TPS6594_IRQ_NAME_GPIO11			"gpio11"
+#define TPS6594_IRQ_NAME_GPIO1			"gpio1"
+#define TPS6594_IRQ_NAME_GPIO2			"gpio2"
+#define TPS6594_IRQ_NAME_GPIO3			"gpio3"
+#define TPS6594_IRQ_NAME_GPIO4			"gpio4"
+#define TPS6594_IRQ_NAME_GPIO5			"gpio5"
+#define TPS6594_IRQ_NAME_GPIO6			"gpio6"
+#define TPS6594_IRQ_NAME_GPIO7			"gpio7"
+#define TPS6594_IRQ_NAME_GPIO8			"gpio8"
+#define TPS6594_IRQ_NAME_NPWRON_START		"npwron_start"
+#define TPS6594_IRQ_NAME_ENABLE			"enable"
+#define TPS6594_IRQ_NAME_FSD			"fsd"
+#define TPS6594_IRQ_NAME_SOFT_REBOOT		"soft_reboot"
+#define TPS6594_IRQ_NAME_BIST_PASS		"bist_pass"
+#define TPS6594_IRQ_NAME_EXT_CLK		"ext_clk"
+#define TPS6594_IRQ_NAME_TWARN			"twarn"
+#define TPS6594_IRQ_NAME_TSD_ORD		"tsd_ord"
+#define TPS6594_IRQ_NAME_BIST_FAIL		"bist_fail"
+#define TPS6594_IRQ_NAME_REG_CRC_ERR		"reg_crc_err"
+#define TPS6594_IRQ_NAME_RECOV_CNT		"recov_cnt"
+#define TPS6594_IRQ_NAME_SPMI_ERR		"spmi_err"
+#define TPS6594_IRQ_NAME_NPWRON_LONG		"npwron_long"
+#define TPS6594_IRQ_NAME_NINT_READBACK		"nint_readback"
+#define TPS6594_IRQ_NAME_NRSTOUT_READBACK	"nrstout_readback"
+#define TPS6594_IRQ_NAME_TSD_IMM		"tsd_imm"
+#define TPS6594_IRQ_NAME_VCCA_OVP		"vcca_ovp"
+#define TPS6594_IRQ_NAME_PFSM_ERR		"pfsm_err"
+#define TPS6594_IRQ_NAME_IMM_SHUTDOWN		"imm_shutdown"
+#define TPS6594_IRQ_NAME_ORD_SHUTDOWN		"ord_shutdown"
+#define TPS6594_IRQ_NAME_MCU_PWR_ERR		"mcu_pwr_err"
+#define TPS6594_IRQ_NAME_SOC_PWR_ERR		"soc_pwr_err"
+#define TPS6594_IRQ_NAME_COMM_FRM_ERR		"comm_frm_err"
+#define TPS6594_IRQ_NAME_COMM_CRC_ERR		"comm_crc_err"
+#define TPS6594_IRQ_NAME_COMM_ADR_ERR		"comm_adr_err"
+#define TPS6594_IRQ_NAME_EN_DRV_READBACK	"en_drv_readback"
+#define TPS6594_IRQ_NAME_NRSTOUT_SOC_READBACK	"nrstout_soc_readback"
+#define TPS6594_IRQ_NAME_ESM_SOC_PIN		"esm_soc_pin"
+#define TPS6594_IRQ_NAME_ESM_SOC_FAIL		"esm_soc_fail"
+#define TPS6594_IRQ_NAME_ESM_SOC_RST		"esm_soc_rst"
+#define TPS6594_IRQ_NAME_TIMER			"timer"
+#define TPS6594_IRQ_NAME_ALARM			"alarm"
+#define TPS6594_IRQ_NAME_POWERUP		"powerup"
+
+/**
+ * struct tps6594 - device private data structure
+ *
+ * @dev:      MFD parent device
+ * @chip_id:  chip ID
+ * @reg:      I2C slave address or SPI chip select number
+ * @use_crc:  if true, use CRC for I2C and SPI interface protocols
+ * @regmap:   regmap for accessing the device registers
+ * @irq:      irq generated by the device
+ * @irq_data: regmap irq data used for the irq chip
+ */
+struct tps6594 {
+	struct device *dev;
+	unsigned long chip_id;
+	unsigned short reg;
+	bool use_crc;
+	struct regmap *regmap;
+	int irq;
+	struct regmap_irq_chip_data *irq_data;
+};
+
+bool tps6594_is_volatile_reg(struct device *dev, unsigned int reg);
+int tps6594_device_init(struct tps6594 *tps, bool enable_crc);
+
+#endif /*  __LINUX_MFD_TPS6594_H */
-- 
2.37.3

