Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0636B7E44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCMQ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjCMQ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:56:47 -0400
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 09:56:30 PDT
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BB47043D;
        Mon, 13 Mar 2023 09:56:28 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 6FDAB21E2B;
        Mon, 13 Mar 2023 17:50:45 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-usb@vger.kernel.org
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 3/3] usb: misc: usb3503: support usb3803 and bypass mode
Date:   Mon, 13 Mar 2023 17:50:39 +0100
Message-Id: <20230313165039.255579-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230313165039.255579-1-francesco@dolcini.it>
References: <20230313165039.255579-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_DNS_FOR_FROM,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add support for USB3803 and bypass mode, with this change
is also possible to move the component out of bypass mode.

In bypass mode the downstream port 3 is connected to the
upstream port with low switch resistance R_on.

Controlling mode of operations:

| RESET_N | BYPASS_N | Mode    |
--------------------------------
|    0    |    0     | standby |
|    1    |    0     | bypass  |
|    1    |    1     | hub     |

Datasheet: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/00001691D.pdf
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/usb/misc/usb3503.c            | 22 +++++++++++++++++++++-
 include/linux/platform_data/usb3503.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
index 3044db9fd8aa..c6cfd1edaf76 100644
--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -46,6 +46,7 @@ struct usb3503 {
 	struct device		*dev;
 	struct clk		*clk;
 	u8	port_off_mask;
+	struct gpio_desc	*bypass;
 	struct gpio_desc	*intn;
 	struct gpio_desc 	*reset;
 	struct gpio_desc 	*connect;
@@ -109,18 +110,25 @@ static int usb3503_connect(struct usb3503 *hub)
 static int usb3503_switch_mode(struct usb3503 *hub, enum usb3503_mode mode)
 {
 	struct device *dev = hub->dev;
-	int rst, conn;
+	int rst, bypass, conn;
 
 	switch (mode) {
 	case USB3503_MODE_HUB:
 		conn = 1;
 		rst = 0;
+		bypass = 0;
 		break;
 	case USB3503_MODE_STANDBY:
 		conn = 0;
 		rst = 1;
+		bypass = 1;
 		dev_info(dev, "switched to STANDBY mode\n");
 		break;
+	case USB3503_MODE_BYPASS:
+		conn = 0;
+		rst = 0;
+		bypass = 1;
+		break;
 	default:
 		dev_err(dev, "unknown mode is requested\n");
 		return -EINVAL;
@@ -132,6 +140,9 @@ static int usb3503_switch_mode(struct usb3503 *hub, enum usb3503_mode mode)
 	if (hub->reset)
 		gpiod_set_value_cansleep(hub->reset, rst);
 
+	if (hub->bypass)
+		gpiod_set_value_cansleep(hub->bypass, bypass);
+
 	if (conn) {
 		/* Wait T_HUBINIT == 4ms for hub logic to stabilize */
 		usleep_range(4000, 10000);
@@ -247,6 +258,14 @@ static int usb3503_probe(struct usb3503 *hub)
 	if (hub->connect)
 		gpiod_set_consumer_name(hub->connect, "usb3503 connect");
 
+	hub->bypass = devm_gpiod_get_optional(dev, "bypass", GPIOD_OUT_HIGH);
+	if (IS_ERR(hub->bypass)) {
+		err = PTR_ERR(hub->bypass);
+		goto err_clk;
+	}
+	if (hub->bypass)
+		gpiod_set_consumer_name(hub->bypass, "usb3503 bypass");
+
 	hub->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(hub->reset)) {
 		err = PTR_ERR(hub->reset);
@@ -382,6 +401,7 @@ MODULE_DEVICE_TABLE(i2c, usb3503_id);
 static const struct of_device_id usb3503_of_match[] = {
 	{ .compatible = "smsc,usb3503", },
 	{ .compatible = "smsc,usb3503a", },
+	{ .compatible = "smsc,usb3803", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, usb3503_of_match);
diff --git a/include/linux/platform_data/usb3503.h b/include/linux/platform_data/usb3503.h
index d01ef97ddf36..f3c942f396f8 100644
--- a/include/linux/platform_data/usb3503.h
+++ b/include/linux/platform_data/usb3503.h
@@ -12,6 +12,7 @@ enum usb3503_mode {
 	USB3503_MODE_UNKNOWN,
 	USB3503_MODE_HUB,
 	USB3503_MODE_STANDBY,
+	USB3503_MODE_BYPASS,
 };
 
 struct usb3503_platform_data {
-- 
2.25.1

