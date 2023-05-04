Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3645F6F6D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjEDNrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjEDNrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:47:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31937D9D
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:47:39 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.felsch@pengutronix.de>)
        id 1puZIV-0004SX-2D; Thu, 04 May 2023 15:47:03 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
Date:   Thu, 04 May 2023 15:46:51 +0200
Subject: [PATCH v2 2/4] usb: typec: mux: gpio-sbu-mux: add support for ss
 data lane muxing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-2-3889b1b2050c@pengutronix.de>
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
In-Reply-To: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
To:     andreas@fatal.se, jun.li@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.12.1
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit adds the support to handle gpio based usb-c ss data lanes
muxes as well. The only difference is the data lanes enable handling.
The data lanes don't depend on the alt-mode settings instead they depend
on the usb-c cable orientation (connected, not connected).

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/usb/typec/mux/Kconfig        |  5 +++--
 drivers/usb/typec/mux/gpio-sbu-mux.c | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index c46fa4f9d3df..68438e7722d0 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -13,10 +13,11 @@ config TYPEC_MUX_FSA4480
 	  If compiled as a module, the module will be named fsa4480.
 
 config TYPEC_MUX_GPIO_SBU
-	tristate "Generic GPIO based SBU mux for USB Type-C applications"
+	tristate "Generic GPIO based SS/SBU mux for USB Type-C applications"
 	help
 	  Say Y or M if your system uses a GPIO based mux for managing the
-	  connected state and the swapping of the SBU lines in a Type-C port.
+	  connected state and the swapping of the SS or SBU lines in a Type-C
+	  port.
 
 config TYPEC_MUX_PI3USB30532
 	tristate "Pericom PI3USB30532 Type-C cross switch driver"
diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
index f62516dafe8f..a1a560a085b8 100644
--- a/drivers/usb/typec/mux/gpio-sbu-mux.c
+++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
@@ -14,12 +14,18 @@
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
 
+enum gpio_sbu_mux_type {
+	MUX_TYPE_SBU,
+	MUX_TYPE_SS,
+};
+
 struct gpio_sbu_mux {
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *select_gpio;
 
 	struct typec_switch_dev *sw;
 	struct typec_mux_dev *mux;
+	enum gpio_sbu_mux_type type;
 
 	struct mutex lock; /* protect enabled and swapped */
 	bool enabled;
@@ -38,6 +44,13 @@ static int gpio_sbu_switch_set(struct typec_switch_dev *sw,
 	enabled = sbu_mux->enabled;
 	swapped = sbu_mux->swapped;
 
+	/*
+	 * In case of muxing the SS data lanes the enable status depends only on
+	 * the orientation and not on the TYPEC_DP_STATE_*
+	 */
+	if (sbu_mux->type == MUX_TYPE_SS)
+		enabled = true;
+
 	switch (orientation) {
 	case TYPEC_ORIENTATION_NONE:
 		enabled = false;
@@ -103,6 +116,8 @@ static int gpio_sbu_mux_probe(struct platform_device *pdev)
 	if (!sbu_mux)
 		return -ENOMEM;
 
+	sbu_mux->type = (enum gpio_sbu_mux_type)device_get_match_data(&pdev->dev);
+
 	mutex_init(&sbu_mux->lock);
 
 	sbu_mux->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
@@ -153,7 +168,8 @@ static int gpio_sbu_mux_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id gpio_sbu_mux_match[] = {
-	{ .compatible = "gpio-sbu-mux", },
+	{ .compatible = "gpio-sbu-mux", .data = (void *)MUX_TYPE_SBU },
+	{ .compatible = "gpio-ss-mux", .data = (void *)MUX_TYPE_SS },
 	{}
 };
 MODULE_DEVICE_TABLE(of, gpio_sbu_mux_match);

-- 
2.39.2

