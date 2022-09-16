Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C575BAD57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiIPMWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiIPMV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD7B14F4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d2so201097wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=h5pjjtpvuIBmXpwkOM+KyNe1mesHrCkdZB5vEBZPnfc=;
        b=Qfolmw2zjYhSKK7DBk+XSztHeKQFLTZ4/K7LkB5pJ9Jgtklf7UEBbwJ+xbVt3tvblo
         +05C5qdIenx66Mfsv4o1WUYEg5yIypu2NReVJmLGHSph4tVJdCPzjTiZnuR6hUlP2XeT
         e8XXlZOCjF0P+WQkfPnoGOzdcd14WKI9Y7AIaODgibFj/eP0L5Wryx5p6w7UCwpmxOPR
         g4qf0WT/dGJuXrXVP4EFXHZ+FhSawl/QYoxOnBhociex3yKwcZYti0Wmu//Zf0L0lJil
         2yyqv8WGcUtDvg5FQGpc7Gque1ZW8My5zdZzytlcYtXtjlNqlxptCX2VzghkEu3QBG4R
         kgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=h5pjjtpvuIBmXpwkOM+KyNe1mesHrCkdZB5vEBZPnfc=;
        b=nmrgo8IiCUp72rf7rmd2YP20Eg3HCkSuIxE+k/mZ4d+eBY4oMl7/9Q17xfV5b/zeLL
         5y7yXJuNywEiiNH7FVxN+2Sr1c/JHdVpjoLIepzWmjsHEs6Osgen7WGHfXg6bqtgdbWX
         Zd1aI+15k/D+6j71ztTZ8GTHI67O8rR/TQT5XbWgnieJQFy3xJ6AgDGZSR3it+BJbR0o
         VSYfKmpw/+O41ZBvN0+Z7s2tJVx9Sh4j1EIgFJNdPYJVE8Wr8qaa9JqCgVTxqs67tGCK
         ZVwy8JbuZ9Z+VvdT1o2zGkfkQ5L6Ft6vQ0Ts/6oMMxqhVVPzHlI2BO5NUgvkTITNPcli
         UfWg==
X-Gm-Message-State: ACrzQf3sgzWWpBahNKovboEOj2xXMmyoStT2vWB3w3wo1eNOdpWM4YVp
        +j/7ojNJnvDAlEGKK4bRrn/Fww==
X-Google-Smtp-Source: AMsMyM4/rSE1ktxoe4RBjklMEhVyFkCvyFkwHpJ+nLxp5wVdQ5dG4DPrCU6zfs5spsVR7goNt+KKhw==
X-Received: by 2002:a5d:52d0:0:b0:21e:4923:fa09 with SMTP id r16-20020a5d52d0000000b0021e4923fa09mr2800095wrv.244.1663330880338;
        Fri, 16 Sep 2022 05:21:20 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/13] nvmem: lan9662-otp: add support
Date:   Fri, 16 Sep 2022 13:20:59 +0100
Message-Id: <20220916122100.170016-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>

Add support for OTP controller available on LAN9662. The OTPC controls
the access to a non-volatile memory. The size of the memory is 8KB.
The OTPC can access the memory based on an offset.
Implement both the read and the write functionality.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig        |   8 ++
 drivers/nvmem/Makefile       |   2 +
 drivers/nvmem/lan9662-otpc.c | 222 +++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 drivers/nvmem/lan9662-otpc.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 7f2557934834..ec8a49c04003 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -98,6 +98,14 @@ config NVMEM_JZ4780_EFUSE
 	  To compile this driver as a module, choose M here: the module
 	  will be called nvmem_jz4780_efuse.
 
+config NVMEM_LAN9662_OTPC
+	tristate "Microchip LAN9662 OTP controller support"
+	depends on SOC_LAN966 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver enables the OTP controller available on Microchip LAN9662
+	  SoCs. It controls the access to the OTP memory connected to it.
+
 config NVMEM_LAYERSCAPE_SFP
 	tristate "Layerscape SFP (Security Fuse Processor) support"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index bac799b2fa8d..fa80fe17e567 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -21,6 +21,8 @@ obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
 nvmem-imx-ocotp-scu-y			:= imx-ocotp-scu.o
 obj-$(CONFIG_NVMEM_JZ4780_EFUSE)	+= nvmem_jz4780_efuse.o
 nvmem_jz4780_efuse-y			:= jz4780-efuse.o
+obj-$(CONFIG_NVMEM_LAN9662_OTPC)	+= nvmem-lan9662-otpc.o
+nvmem-lan9662-otpc-y		:= lan9662-otpc.o
 obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
 nvmem-layerscape-sfp-y			:= layerscape-sfp.o
 obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
new file mode 100644
index 000000000000..f6732fd216d8
--- /dev/null
+++ b/drivers/nvmem/lan9662-otpc.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#define OTP_OTP_PWR_DN(t)			(t + 0x00)
+#define OTP_OTP_PWR_DN_OTP_PWRDN_N		BIT(0)
+#define OTP_OTP_ADDR_HI(t)			(t + 0x04)
+#define OTP_OTP_ADDR_LO(t)			(t + 0x08)
+#define OTP_OTP_PRGM_DATA(t)			(t + 0x10)
+#define OTP_OTP_PRGM_MODE(t)			(t + 0x14)
+#define OTP_OTP_PRGM_MODE_OTP_PGM_MODE_BYTE	BIT(0)
+#define OTP_OTP_RD_DATA(t)			(t + 0x18)
+#define OTP_OTP_FUNC_CMD(t)			(t + 0x20)
+#define OTP_OTP_FUNC_CMD_OTP_PROGRAM		BIT(1)
+#define OTP_OTP_FUNC_CMD_OTP_READ		BIT(0)
+#define OTP_OTP_CMD_GO(t)			(t + 0x28)
+#define OTP_OTP_CMD_GO_OTP_GO			BIT(0)
+#define OTP_OTP_PASS_FAIL(t)			(t + 0x2c)
+#define OTP_OTP_PASS_FAIL_OTP_READ_PROHIBITED	BIT(3)
+#define OTP_OTP_PASS_FAIL_OTP_WRITE_PROHIBITED	BIT(2)
+#define OTP_OTP_PASS_FAIL_OTP_FAIL		BIT(0)
+#define OTP_OTP_STATUS(t)			(t + 0x30)
+#define OTP_OTP_STATUS_OTP_CPUMPEN		BIT(1)
+#define OTP_OTP_STATUS_OTP_BUSY			BIT(0)
+
+#define OTP_MEM_SIZE 8192
+#define OTP_SLEEP_US 10
+#define OTP_TIMEOUT_US 500000
+
+struct lan9662_otp {
+	struct device *dev;
+	void __iomem *base;
+};
+
+static bool lan9662_otp_wait_flag_clear(void __iomem *reg, u32 flag)
+{
+	u32 val;
+
+	return readl_poll_timeout(reg, val, !(val & flag),
+				  OTP_SLEEP_US, OTP_TIMEOUT_US);
+}
+
+static int lan9662_otp_power(struct lan9662_otp *otp, bool up)
+{
+	void __iomem *pwrdn = OTP_OTP_PWR_DN(otp->base);
+
+	if (up) {
+		writel(readl(pwrdn) & ~OTP_OTP_PWR_DN_OTP_PWRDN_N, pwrdn);
+		if (lan9662_otp_wait_flag_clear(OTP_OTP_STATUS(otp->base),
+						OTP_OTP_STATUS_OTP_CPUMPEN))
+			return -ETIMEDOUT;
+	} else {
+		writel(readl(pwrdn) | OTP_OTP_PWR_DN_OTP_PWRDN_N, pwrdn);
+	}
+
+	return 0;
+}
+
+static int lan9662_otp_execute(struct lan9662_otp *otp)
+{
+	if (lan9662_otp_wait_flag_clear(OTP_OTP_CMD_GO(otp->base),
+					OTP_OTP_CMD_GO_OTP_GO))
+		return -ETIMEDOUT;
+
+	if (lan9662_otp_wait_flag_clear(OTP_OTP_STATUS(otp->base),
+					OTP_OTP_STATUS_OTP_BUSY))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void lan9662_otp_set_address(struct lan9662_otp *otp, u32 offset)
+{
+	writel(0xff & (offset >> 8), OTP_OTP_ADDR_HI(otp->base));
+	writel(0xff & offset, OTP_OTP_ADDR_LO(otp->base));
+}
+
+static int lan9662_otp_read_byte(struct lan9662_otp *otp, u32 offset, u8 *dst)
+{
+	u32 pass;
+	int rc;
+
+	lan9662_otp_set_address(otp, offset);
+	writel(OTP_OTP_FUNC_CMD_OTP_READ, OTP_OTP_FUNC_CMD(otp->base));
+	writel(OTP_OTP_CMD_GO_OTP_GO, OTP_OTP_CMD_GO(otp->base));
+	rc = lan9662_otp_execute(otp);
+	if (!rc) {
+		pass = readl(OTP_OTP_PASS_FAIL(otp->base));
+		if (pass & OTP_OTP_PASS_FAIL_OTP_READ_PROHIBITED)
+			return -EACCES;
+		*dst = (u8) readl(OTP_OTP_RD_DATA(otp->base));
+	}
+	return rc;
+}
+
+static int lan9662_otp_write_byte(struct lan9662_otp *otp, u32 offset, u8 data)
+{
+	u32 pass;
+	int rc;
+
+	lan9662_otp_set_address(otp, offset);
+	writel(OTP_OTP_PRGM_MODE_OTP_PGM_MODE_BYTE, OTP_OTP_PRGM_MODE(otp->base));
+	writel(data, OTP_OTP_PRGM_DATA(otp->base));
+	writel(OTP_OTP_FUNC_CMD_OTP_PROGRAM, OTP_OTP_FUNC_CMD(otp->base));
+	writel(OTP_OTP_CMD_GO_OTP_GO, OTP_OTP_CMD_GO(otp->base));
+
+	rc = lan9662_otp_execute(otp);
+	if (!rc) {
+		pass = readl(OTP_OTP_PASS_FAIL(otp->base));
+		if (pass & OTP_OTP_PASS_FAIL_OTP_WRITE_PROHIBITED)
+			return -EACCES;
+		if (pass & OTP_OTP_PASS_FAIL_OTP_FAIL)
+			return -EIO;
+	}
+	return rc;
+}
+
+static int lan9662_otp_read(void *context, unsigned int offset,
+			    void *_val, size_t bytes)
+{
+	struct lan9662_otp *otp = context;
+	u8 *val = _val;
+	uint8_t data;
+	int i, rc = 0;
+
+	lan9662_otp_power(otp, true);
+	for (i = 0; i < bytes; i++) {
+		rc = lan9662_otp_read_byte(otp, offset + i, &data);
+		if (rc < 0)
+			break;
+		*val++ = data;
+	}
+	lan9662_otp_power(otp, false);
+
+	return rc;
+}
+
+static int lan9662_otp_write(void *context, unsigned int offset,
+			     void *_val, size_t bytes)
+{
+	struct lan9662_otp *otp = context;
+	u8 *val = _val;
+	u8 data, newdata;
+	int i, rc = 0;
+
+	lan9662_otp_power(otp, true);
+	for (i = 0; i < bytes; i++) {
+		/* Skip zero bytes */
+		if (val[i]) {
+			rc = lan9662_otp_read_byte(otp, offset + i, &data);
+			if (rc < 0)
+				break;
+
+			newdata = data | val[i];
+			if (newdata == data)
+				continue;
+
+			rc = lan9662_otp_write_byte(otp, offset + i,
+						      newdata);
+			if (rc < 0)
+				break;
+		}
+	}
+	lan9662_otp_power(otp, false);
+
+	return rc;
+}
+
+static struct nvmem_config otp_config = {
+	.name = "lan9662-otp",
+	.stride = 1,
+	.word_size = 1,
+	.reg_read = lan9662_otp_read,
+	.reg_write = lan9662_otp_write,
+	.size = OTP_MEM_SIZE,
+};
+
+static int lan9662_otp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct lan9662_otp *otp;
+
+	otp = devm_kzalloc(&pdev->dev, sizeof(*otp), GFP_KERNEL);
+	if (!otp)
+		return -ENOMEM;
+
+	otp->dev = dev;
+	otp->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(otp->base))
+		return PTR_ERR(otp->base);
+
+	otp_config.priv = otp;
+	otp_config.dev = dev;
+
+	nvmem = devm_nvmem_register(dev, &otp_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id lan9662_otp_match[] = {
+	{ .compatible = "microchip,lan9662-otp", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lan9662_otp_match);
+
+static struct platform_driver lan9662_otp_driver = {
+	.probe = lan9662_otp_probe,
+	.driver = {
+		.name = "lan9662-otp",
+		.of_match_table = lan9662_otp_match,
+	},
+};
+module_platform_driver(lan9662_otp_driver);
+
+MODULE_AUTHOR("Horatiu Vultur <horatiu.vultur@microchip.com>");
+MODULE_DESCRIPTION("lan9662 OTP driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

