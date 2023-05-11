Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFAD6FFB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbjEKVFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbjEKVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:05:13 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A3F7EE9;
        Thu, 11 May 2023 14:05:11 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 2567B5FD62;
        Fri, 12 May 2023 00:05:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683839110;
        bh=izMKXdTFH1h2UBa+MY3F3v9dqaNkzDFsQICpQYJio5U=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=lAqWEQ3PMUY37Xoo9RjMkqSYFW71Ex4lEIV5r5bPkbSm3VvjG6VN21slRxo3EtFPn
         NdCJ9UsMt+lb5YdHQLxs9aERJ/MIwokQFNHbCr+pQ5AKLS5NXKbUREgi0py/ifPm5n
         nV0vIAh783Roh1WO6WU4OjiXjxPCHLNhSNQbeFcdmJCs7H/AehdA0l3dgLy6PWjVm+
         U3TIRhTuxct1FCuElre23kqogWOUp+7mUkZ4gi9CiBF3KNeho4wJv/TsKP8CYJlm5F
         aHCBdCx9cBFt5nMbdIlLeAyGEIE0cvEMHQ4npapWjZIomKzH1uRD0vNgVJaz0T23t2
         0pBkT95bf2kLw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 12 May 2023 00:05:10 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <mturquette@baylibre.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <hminas@synopsys.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <yue.wang@amlogic.com>, <hanjie.lin@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-phy@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v4 3/3] usb: dwc3-meson-g12a: support OTG switch for all IP versions
Date:   Fri, 12 May 2023 00:04:55 +0300
Message-ID: <20230511210455.6634-4-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230511210455.6634-1-ddrokosov@sberdevices.ru>
References: <20230511210455.6634-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/11 10:21:00 #21259776
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From now, the Amlogic A1 USB controller is capable of switching between
host and gadget modes based on the status of the OTG_ID signal or via
manual USB role change.
Previously, only the Amlogic A1 IP version did not use OTG support for
host only mode, but this is no longer applicable.
Therefore, the 'otg_switch_supported' option can now be removed as
it is no longer required.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index b282ad0e69c6..a13afdb219e8 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -140,7 +140,6 @@ static const char * const meson_a1_phy_names[] = {
 struct dwc3_meson_g12a;
 
 struct dwc3_meson_g12a_drvdata {
-	bool otg_switch_supported;
 	bool otg_phy_host_port_disable;
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -189,7 +188,6 @@ static int dwc3_meson_gxl_usb_post_init(struct dwc3_meson_g12a *priv);
  */
 
 static const struct dwc3_meson_g12a_drvdata gxl_drvdata = {
-	.otg_switch_supported = true,
 	.otg_phy_host_port_disable = true,
 	.clks = meson_gxl_clocks,
 	.num_clks = ARRAY_SIZE(meson_g12a_clocks),
@@ -203,7 +201,6 @@ static const struct dwc3_meson_g12a_drvdata gxl_drvdata = {
 };
 
 static const struct dwc3_meson_g12a_drvdata gxm_drvdata = {
-	.otg_switch_supported = true,
 	.otg_phy_host_port_disable = true,
 	.clks = meson_gxl_clocks,
 	.num_clks = ARRAY_SIZE(meson_g12a_clocks),
@@ -217,7 +214,6 @@ static const struct dwc3_meson_g12a_drvdata gxm_drvdata = {
 };
 
 static const struct dwc3_meson_g12a_drvdata axg_drvdata = {
-	.otg_switch_supported = true,
 	.clks = meson_gxl_clocks,
 	.num_clks = ARRAY_SIZE(meson_gxl_clocks),
 	.phy_names = meson_a1_phy_names,
@@ -230,7 +226,6 @@ static const struct dwc3_meson_g12a_drvdata axg_drvdata = {
 };
 
 static const struct dwc3_meson_g12a_drvdata g12a_drvdata = {
-	.otg_switch_supported = true,
 	.clks = meson_g12a_clocks,
 	.num_clks = ARRAY_SIZE(meson_g12a_clocks),
 	.phy_names = meson_g12a_phy_names,
@@ -242,7 +237,6 @@ static const struct dwc3_meson_g12a_drvdata g12a_drvdata = {
 };
 
 static const struct dwc3_meson_g12a_drvdata a1_drvdata = {
-	.otg_switch_supported = false,
 	.clks = meson_a1_clocks,
 	.num_clks = ARRAY_SIZE(meson_a1_clocks),
 	.phy_names = meson_a1_phy_names,
@@ -307,7 +301,7 @@ static int dwc3_meson_g12a_usb2_init_phy(struct dwc3_meson_g12a *priv, int i,
 			U2P_R0_POWER_ON_RESET,
 			U2P_R0_POWER_ON_RESET);
 
-	if (priv->drvdata->otg_switch_supported && i == USB2_OTG_PHY) {
+	if (i == USB2_OTG_PHY) {
 		regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
 				   U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS,
 				   U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS);
@@ -490,7 +484,7 @@ static int dwc3_meson_g12a_otg_mode_set(struct dwc3_meson_g12a *priv,
 {
 	int ret;
 
-	if (!priv->drvdata->otg_switch_supported || !priv->phys[USB2_OTG_PHY])
+	if (!priv->phys[USB2_OTG_PHY])
 		return -EINVAL;
 
 	if (mode == PHY_MODE_USB_HOST)
@@ -589,9 +583,6 @@ static int dwc3_meson_g12a_otg_init(struct platform_device *pdev,
 	int ret, irq;
 	struct device *dev = &pdev->dev;
 
-	if (!priv->drvdata->otg_switch_supported)
-		return 0;
-
 	if (priv->otg_mode == USB_DR_MODE_OTG) {
 		/* Ack irq before registering */
 		regmap_update_bits(priv->usb_glue_regmap, USB_R5,
@@ -841,8 +832,7 @@ static int dwc3_meson_g12a_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i;
 
-	if (priv->drvdata->otg_switch_supported)
-		usb_role_switch_unregister(priv->role_switch);
+	usb_role_switch_unregister(priv->role_switch);
 
 	of_platform_depopulate(dev);
 
-- 
2.36.0

