Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512546EC995
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjDXJz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjDXJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:55:47 -0400
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 02:55:24 PDT
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320340EE;
        Mon, 24 Apr 2023 02:55:23 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id 161E15EC77;
        Mon, 24 Apr 2023 12:35:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-ZrhHlrZZ;
        Mon, 24 Apr 2023 12:35:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328947;
        bh=70tk1h+wgeQTaLaqiB2qLFxkPdeNb1mwGKko+ahe0Pk=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=KmrSjPINTOPndFgRIQ/9jPYIMPspzIV+4nqN8RLXqz1aylvrv9zoL74k3w4hDfY5S
         n15pcFYLcyijQH2T21QEheg3x+KlT69ReXXDWuwe52eRgCR6M+wV7A4W0DKAu8WCSJ
         EdOGa09/CODJabDPTbjDwGAj6+FDq7gunwru1BmE=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 13/43] power: reset: Add a driver for the ep93xx reset
Date:   Mon, 24 Apr 2023 15:34:29 +0300
Message-Id: <20230424123522.18302-14-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the reset behaviour of the various EP93xx SoCS in drivers/power/reset.

It used to be located in arch/arm/mach-ep93xx.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/power/reset/Kconfig          | 10 +++++
 drivers/power/reset/Makefile         |  1 +
 drivers/power/reset/ep93xx-restart.c | 65 ++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 drivers/power/reset/ep93xx-restart.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 8c87eeda0fec..2a61afbb047b 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -75,6 +75,16 @@ config POWER_RESET_BRCMSTB
 	  Say Y here if you have a Broadcom STB board and you wish
 	  to have restart support.
 
+config POWER_RESET_EP93XX
+	bool "Cirrus EP93XX reset driver" if COMPILE_TEST
+	depends on MFD_SYSCON
+	default ARCH_EP93XX
+	help
+	  This driver provides restart support for Cirrus EP93XX SoC.
+
+	  Say Y here if you have a Cirrus EP93XX SoC and you wish
+	  to have restart support.
+
 config POWER_RESET_GEMINI_POWEROFF
 	bool "Cortina Gemini power-off driver"
 	depends on ARCH_GEMINI || COMPILE_TEST
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index d763e6735ee3..61f4e11619b2 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_POWER_RESET_ATC260X) += atc260x-poweroff.o
 obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMKONA) += brcm-kona-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
+obj-$(CONFIG_POWER_RESET_EP93XX) += ep93xx-restart.o
 obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) += gemini-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
diff --git a/drivers/power/reset/ep93xx-restart.c b/drivers/power/reset/ep93xx-restart.c
new file mode 100644
index 000000000000..0dab09d4fd3c
--- /dev/null
+++ b/drivers/power/reset/ep93xx-restart.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Cirrus EP93xx SoC reset driver
+ *
+ * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
+ */
+
+#include <linux/delay.h>
+#include <linux/notifier.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+
+#include <linux/soc/cirrus/ep93xx.h>
+
+#define EP93XX_SYSCON_DEVCFG_SWRST	BIT(31)
+
+static int ep93xx_restart_handle(struct notifier_block *this,
+				 unsigned long mode, void *cmd)
+{
+	/* Issue the reboot */
+	ep93xx_devcfg_set_clear(EP93XX_SYSCON_DEVCFG_SWRST, 0x00);
+	ep93xx_devcfg_set_clear(0x00, EP93XX_SYSCON_DEVCFG_SWRST);
+
+	mdelay(1000);
+
+	pr_emerg("Unable to restart system\n");
+	return NOTIFY_DONE;
+}
+
+static int ep93xx_reboot_probe(struct platform_device *pdev)
+{
+	struct notifier_block *res_han;
+	struct device *dev = &pdev->dev;
+	int err;
+
+	res_han = devm_kzalloc(&pdev->dev, sizeof(*res_han), GFP_KERNEL);
+	if (!res_han)
+		return -ENOMEM;
+
+	res_han->notifier_call = ep93xx_restart_handle;
+	res_han->priority = 128;
+
+	err = register_restart_handler(res_han);
+	if (err)
+		dev_err(dev, "can't register restart notifier (err=%d)\n", err);
+
+	return err;
+}
+
+static const struct of_device_id ep93xx_reboot_of_match[] = {
+	{
+		.compatible = "cirrus,ep9301-reboot",
+	},
+	{}
+};
+
+static struct platform_driver ep93xx_reboot_driver = {
+	.probe = ep93xx_reboot_probe,
+	.driver = {
+		.name = "ep9301-reboot",
+		.of_match_table = ep93xx_reboot_of_match,
+	},
+};
+builtin_platform_driver(ep93xx_reboot_driver);
-- 
2.39.2

