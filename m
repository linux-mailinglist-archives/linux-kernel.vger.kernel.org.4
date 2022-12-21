Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0134652FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiLUKs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiLUKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:48:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF31D674
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:48:14 -0800 (PST)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p7wdu-00065f-I0; Wed, 21 Dec 2022 11:48:10 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 2/2] net: rfkill: gpio: add DT support
Date:   Wed, 21 Dec 2022 11:48:03 +0100
Message-Id: <20221221104803.1693874-2-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221221104803.1693874-1-p.zabel@pengutronix.de>
References: <20221221104803.1693874-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow probing rfkill-gpio via device tree. This just hooks up the
already existing support that was started in commit 262c91ee5e52 ("net:
rfkill: gpio: prepare for DT and ACPI support") via the "rfkill-gpio"
compatible.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 net/rfkill/rfkill-gpio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index f5afc9bcdee6..9f763654cd27 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -157,12 +157,21 @@ static const struct acpi_device_id rfkill_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rfkill_acpi_match);
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id rfkill_of_match[] = {
+	{ .compatible = "rfkill-gpio", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rfkill_of_match);
+#endif
+
 static struct platform_driver rfkill_gpio_driver = {
 	.probe = rfkill_gpio_probe,
 	.remove = rfkill_gpio_remove,
 	.driver = {
 		.name = "rfkill_gpio",
 		.acpi_match_table = ACPI_PTR(rfkill_acpi_match),
+		.of_match_table = of_match_ptr(rfkill_of_match),
 	},
 };
 
-- 
2.30.2

