Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988056B7E46
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCMQ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCMQ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:56:47 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF070402;
        Mon, 13 Mar 2023 09:56:28 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 23A2F21E2A;
        Mon, 13 Mar 2023 17:50:45 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-usb@vger.kernel.org
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/3] usb: misc: usb3503: refactor code to prepare for usb3803 addition
Date:   Mon, 13 Mar 2023 17:50:38 +0100
Message-Id: <20230313165039.255579-3-francesco@dolcini.it>
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

Refactor code to simplify adding support for USB3803 and bypass mode.

Remove static usb3503_reset() and move it to usb3503_switch_mode(),
with the addition of the bypass mode we need to drive the various
control signals to the expected configuration, not just to
assert/release the reset.

In addition to that the usb3503_connect() needs to be called only
for HUB mode.

No functional changes expected nor intended because of this change.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/usb/misc/usb3503.c | 44 ++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
index bd47c4437ca4..3044db9fd8aa 100644
--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -52,28 +52,11 @@ struct usb3503 {
 	bool	secondary_ref_clk;
 };
 
-static int usb3503_reset(struct usb3503 *hub, int state)
-{
-	if (!state && hub->connect)
-		gpiod_set_value_cansleep(hub->connect, 0);
-
-	if (hub->reset)
-		gpiod_set_value_cansleep(hub->reset, !state);
-
-	/* Wait T_HUBINIT == 4ms for hub logic to stabilize */
-	if (state)
-		usleep_range(4000, 10000);
-
-	return 0;
-}
-
 static int usb3503_connect(struct usb3503 *hub)
 {
 	struct device *dev = hub->dev;
 	int err;
 
-	usb3503_reset(hub, 1);
-
 	if (hub->regmap) {
 		/* SP_ILOCK: set connect_n, config_n for config */
 		err = regmap_write(hub->regmap, USB3503_SP_ILOCK,
@@ -126,25 +109,36 @@ static int usb3503_connect(struct usb3503 *hub)
 static int usb3503_switch_mode(struct usb3503 *hub, enum usb3503_mode mode)
 {
 	struct device *dev = hub->dev;
-	int err = 0;
+	int rst, conn;
 
 	switch (mode) {
 	case USB3503_MODE_HUB:
-		err = usb3503_connect(hub);
+		conn = 1;
+		rst = 0;
 		break;
-
 	case USB3503_MODE_STANDBY:
-		usb3503_reset(hub, 0);
+		conn = 0;
+		rst = 1;
 		dev_info(dev, "switched to STANDBY mode\n");
 		break;
-
 	default:
 		dev_err(dev, "unknown mode is requested\n");
-		err = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 
-	return err;
+	if (!conn && hub->connect)
+		gpiod_set_value_cansleep(hub->connect, 0);
+
+	if (hub->reset)
+		gpiod_set_value_cansleep(hub->reset, rst);
+
+	if (conn) {
+		/* Wait T_HUBINIT == 4ms for hub logic to stabilize */
+		usleep_range(4000, 10000);
+		return usb3503_connect(hub);
+	}
+
+	return 0;
 }
 
 static const struct regmap_config usb3503_regmap_config = {
-- 
2.25.1

