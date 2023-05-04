Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B471C6F7038
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjEDQus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjEDQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:50:45 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE040E9;
        Thu,  4 May 2023 09:50:26 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 3242E20B6A;
        Thu,  4 May 2023 18:50:19 +0200 (CEST)
Date:   Thu, 4 May 2023 18:50:14 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        gregkh@linuxfoundation.org, jun.li@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        peter.chen@nxp.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        francesco.dolcini@toradex.com
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Message-ID: <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
References: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
 <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Luca,
I guess your mail to Philippe bounced, let me try to answer since I am aware
of the issue here.

On Thu, May 04, 2023 at 06:23:12PM +0200, Luca Ceresoli wrote:
> I found this thread after several hours spent in debugging why USB host is
> not detecting new devices on a custom board using the iMX6ULL Colibri
> SoM.
> 
> My best workaround at the moment is:
We have the same workaround in our BSP since quite some time, see
https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-kernel/linux/linux-toradex-mainline-git/0002-drivers-chipidea-disable-runtime-pm-for-imx6ul.patch

> I haven't found any follow-up patches from you, so I'm wondering whether
> you have made any progress on this issue.
You can find the latest discussion on that regard here
https://lore.kernel.org/all/Y1vLpaxpc5WBCuGD@francesco-nb.int.toradex.com/

> As I see it, a quirk in the driver would make sense.
I am not sure.

The reason this is not working is that the VBUS is not directly
connected to the SOC and the USB IP is powered in a different way (all
of that was reviewed/acked by NXP when the board was designed).

The issue is in drivers/usb/phy/phy-mxs-usb.c:mxs_phy_disconnect_line(),
however:
 1 - checking for the VBUS when in host mode is not correct.
 2 - checking for the VBUS when in OTG/dual-role mode should be done using
 extcon or equivalent. In this case on the colibri-imx6ull you would get
 the correct behavior.

The NXP downstream kernel has some improvements on that regard, for
instance 1 would work, 2 I am not 100% sure.

Here the related patches:

From 60422d8301fc354e69ec0184831468c3b65cc26a Mon Sep 17 00:00:00 2001
From: Li Jun <jun.li@nxp.com>
Date: Wed, 12 Apr 2017 05:31:17 +0800
Subject: [PATCH 1/3] MLK-14285-1 usb: phy: add usb mode for usb_phy

USB phy driver may need to know the current working mode of
the controller, and does some different settings according to
host mode or device mode.

Signed-off-by: Li Jun <jun.li@nxp.com>
(cherry picked from commit 2286cb30feedd6f4a5cb82a0f0af5aa3a04ab698)
Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
Signed-off-by: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
---
 include/linux/usb/phy.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index e4de6bc1f69b..93963a018a13 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -63,6 +63,13 @@ enum usb_otg_state {
 	OTG_STATE_A_VBUS_ERR,
 };
 
+/* The usb role of phy to be working with */
+enum usb_current_mode {
+	CUR_USB_MODE_NONE,
+	CUR_USB_MODE_HOST,
+	CUR_USB_MODE_DEVICE,
+};
+
 struct usb_phy;
 struct usb_otg;
 
@@ -155,6 +162,10 @@ struct usb_phy {
 	 * manually detect the charger type.
 	 */
 	enum usb_charger_type (*charger_detect)(struct usb_phy *x);
+
+	int	(*set_mode)(struct usb_phy *x,
+			enum usb_current_mode mode);
+
 };
 
 /* for board-specific init logic */
@@ -213,6 +224,15 @@ usb_phy_vbus_off(struct usb_phy *x)
 	return x->set_vbus(x, false);
 }
 
+static inline int
+usb_phy_set_mode(struct usb_phy *x, enum usb_current_mode mode)
+{
+	if (!x || !x->set_mode)
+		return 0;
+
+	return x->set_mode(x, mode);
+}
+
 /* for usb host and peripheral controller drivers */
 #if IS_ENABLED(CONFIG_USB_PHY)
 extern struct usb_phy *usb_get_phy(enum usb_phy_type type);


From cf3f741f4b7ab5d139938c4c0cd65d4547d386ff Mon Sep 17 00:00:00 2001
From: Li Jun <jun.li@nxp.com>
Date: Wed, 12 Apr 2017 05:41:21 +0800
Subject: [PATCH 2/3] MLK-14285-3 usb: phy: mxs: optimize disconnect line
 condition

We only have below cases to disconnect line when suspend:
1. Device mode without connection to any host/charger(no vbus).
2. Device mode connect to a charger(w/ vbus), usb suspend when
   system is entering suspend.
This patch can fix usb phy wrongly does disconnect line in case
some usb host enters suspend but vbus is off.

Signed-off-by: Li Jun <jun.li@nxp.com>
(cherry picked from commit 2af48913f77cec3658f5863b13f63619d8101279)
---
 drivers/usb/phy/phy-mxs-usb.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 8a262c5a0408..31f40dbb71c0 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2012-2014 Freescale Semiconductor, Inc.
+ * Copyright 2012-2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
  * Copyright (C) 2012 Marek Vasut <marex@denx.de>
  * on behalf of DENX Software Engineering GmbH
  */
@@ -204,6 +205,7 @@ struct mxs_phy {
 	int port_id;
 	u32 tx_reg_set;
 	u32 tx_reg_mask;
+	enum usb_current_mode mode;
 };
 
 static inline bool is_imx6q_phy(struct mxs_phy *mxs_phy)
@@ -386,18 +388,6 @@ static void __mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool disconnect)
 		usleep_range(500, 1000);
 }
 
-static bool mxs_phy_is_otg_host(struct mxs_phy *mxs_phy)
-{
-	void __iomem *base = mxs_phy->phy.io_priv;
-	u32 phyctrl = readl(base + HW_USBPHY_CTRL);
-
-	if (IS_ENABLED(CONFIG_USB_OTG) &&
-			!(phyctrl & BM_USBPHY_CTRL_OTG_ID_VALUE))
-		return true;
-
-	return false;
-}
-
 static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 {
 	bool vbus_is_on = false;
@@ -412,7 +402,7 @@ static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 
 	vbus_is_on = mxs_phy_get_vbus_status(mxs_phy);
 
-	if (on && !vbus_is_on && !mxs_phy_is_otg_host(mxs_phy))
+	if (on && ((!vbus_is_on && mxs_phy->mode != CUR_USB_MODE_HOST)))
 		__mxs_phy_disconnect_line(mxs_phy, true);
 	else
 		__mxs_phy_disconnect_line(mxs_phy, false);
@@ -708,6 +698,19 @@ static enum usb_charger_type mxs_phy_charger_detect(struct usb_phy *phy)
 	return chgr_type;
 }
 
+/*
+ * Set the usb current role for phy.
+ */
+static int mxs_phy_set_mode(struct usb_phy *phy,
+		enum usb_current_mode mode)
+{
+	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
+
+	mxs_phy->mode = mode;
+
+	return 0;
+}
+
 static int mxs_phy_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -793,6 +796,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 
 	mxs_phy->clk = clk;
 	mxs_phy->data = of_device_get_match_data(&pdev->dev);
+	mxs_phy->phy.set_mode		= mxs_phy_set_mode;
 
 	platform_set_drvdata(pdev, mxs_phy);
 

From d4c4385b997f32b081e859d491f25f5beb738ae9 Mon Sep 17 00:00:00 2001
From: Li Jun <jun.li@nxp.com>
Date: Wed, 12 Apr 2017 05:38:48 +0800
Subject: [PATCH 3/3] MLK-14285-2 usb: chipidea: set mode for usb phy driver

After enters one specific role, notify usb phy driver.

Signed-off-by: Li Jun <jun.li@nxp.com>
(cherry picked from commit d3aa2a13f4e47bc7fae7f2eee1e86291d7513312)
---
 drivers/usb/chipidea/ci.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 99440baa6458..9d7ba902246d 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -274,9 +274,21 @@ static inline int ci_role_start(struct ci_hdrc *ci, enum ci_role role)
 		return -ENXIO;
 
 	ret = ci->roles[role]->start(ci);
-	if (!ret)
-		ci->role = role;
-	return ret;
+	if (ret)
+		return ret;
+
+	ci->role = role;
+
+	if (ci->usb_phy) {
+		if (role == CI_ROLE_HOST)
+			usb_phy_set_mode(ci->usb_phy,
+					CUR_USB_MODE_HOST);
+		else
+			usb_phy_set_mode(ci->usb_phy,
+					CUR_USB_MODE_DEVICE);
+	}
+
+	return 0;
 }
 
 static inline void ci_role_stop(struct ci_hdrc *ci)
@@ -289,6 +301,9 @@ static inline void ci_role_stop(struct ci_hdrc *ci)
 	ci->role = CI_ROLE_END;
 
 	ci->roles[role]->stop(ci);
+
+	if (ci->usb_phy)
+		usb_phy_set_mode(ci->usb_phy, CUR_USB_MODE_NONE);
 }
 
 static inline enum usb_role ci_role_to_usb_role(struct ci_hdrc *ci)


Francesco

