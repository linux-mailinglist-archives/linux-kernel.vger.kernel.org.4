Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E85560E733
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiJZS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiJZS1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:27:34 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F5D73C6;
        Wed, 26 Oct 2022 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666808826; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rNhtiBQjZSrcPF4lImERz7BnM97JR5XN0W5IqAfLC9I=;
        b=Zr4P5esocfv3oEjk6u9XIgjqwdmgDroTOtqHAGA1j5k8HoBispNTKaS9OSmkrD2HDCao+j
        ihcjn/OFbPQoSwQ0H/90paahtGd9o5fkOxmhQlAD990J4okVz0PRXOmppyTko6Bb20bx3U
        qgfLi71SLnw6k5a8VGJ7pYqjlKXLymY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, od@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/7] usb: musb: Allow running without CONFIG_USB_PHY
Date:   Wed, 26 Oct 2022 19:26:53 +0100
Message-Id: <20221026182657.146630-4-paul@crapouillou.net>
In-Reply-To: <20221026182657.146630-1-paul@crapouillou.net>
References: <20221026182657.146630-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the core so that musb->xceiv is never deferenced without being
checked first.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/musb_core.c    |  2 +-
 drivers/usb/musb/musb_core.h    | 12 ++++++++++--
 drivers/usb/musb/musb_gadget.c  | 21 +++++++++++++--------
 drivers/usb/musb/musb_host.c    |  8 ++++++--
 drivers/usb/musb/musb_virthub.c | 11 +++++------
 5 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 9bf0ebaa3b7c..648bb6021c5e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2448,7 +2448,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	else
 		musb->io.set_toggle = musb_default_set_toggle;
 
-	if (!musb->xceiv->io_ops) {
+	if (IS_ENABLED(CONFIG_USB_PHY) && musb->xceiv && !musb->xceiv->io_ops) {
 		musb->xceiv->io_dev = musb->controller;
 		musb->xceiv->io_priv = musb->mregs;
 		musb->xceiv->io_ops = &musb_ulpi_access;
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index a497c44ab0da..b7588d11cfc5 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -339,6 +339,8 @@ struct musb {
 	struct usb_phy		*xceiv;
 	struct phy		*phy;
 
+	enum usb_otg_state	otg_state;
+
 	int nIrq;
 	unsigned		irq_wake:1;
 
@@ -595,12 +597,18 @@ static inline void musb_platform_clear_ep_rxintr(struct musb *musb, int epnum)
 static inline void musb_set_state(struct musb *musb,
 				  enum usb_otg_state otg_state)
 {
-	musb->xceiv->otg->state = otg_state;
+	if (musb->xceiv)
+		musb->xceiv->otg->state = otg_state;
+	else
+		musb->otg_state = otg_state;
 }
 
 static inline enum usb_otg_state musb_get_state(struct musb *musb)
 {
-	return musb->xceiv->otg->state;
+	if (musb->xceiv)
+		return musb->xceiv->otg->state;
+
+	return musb->otg_state;
 }
 
 static inline const char *musb_otg_state_string(struct musb *musb)
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 9f5c531de387..66c8b32b16bb 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1552,9 +1552,11 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 				break;
 		}
 
-		spin_unlock_irqrestore(&musb->lock, flags);
-		otg_start_srp(musb->xceiv->otg);
-		spin_lock_irqsave(&musb->lock, flags);
+		if (musb->xceiv) {
+			spin_unlock_irqrestore(&musb->lock, flags);
+			otg_start_srp(musb->xceiv->otg);
+			spin_lock_irqsave(&musb->lock, flags);
+		}
 
 		/* Block idling for at least 1s */
 		musb_platform_try_idle(musb,
@@ -1628,7 +1630,7 @@ static int musb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
 	struct musb	*musb = gadget_to_musb(gadget);
 
-	if (!musb->xceiv->set_power)
+	if (!musb->xceiv || !musb->xceiv->set_power)
 		return -EOPNOTSUPP;
 	return usb_phy_set_power(musb->xceiv, mA);
 }
@@ -1834,7 +1836,6 @@ static int musb_gadget_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
 	struct musb		*musb = gadget_to_musb(g);
-	struct usb_otg		*otg = musb->xceiv->otg;
 	unsigned long		flags;
 	int			retval = 0;
 
@@ -1851,7 +1852,9 @@ static int musb_gadget_start(struct usb_gadget *g,
 	spin_lock_irqsave(&musb->lock, flags);
 	musb->is_active = 1;
 
-	otg_set_peripheral(otg, &musb->g);
+	if (musb->xceiv)
+		otg_set_peripheral(musb->xceiv->otg, &musb->g);
+
 	musb_set_state(musb, OTG_STATE_B_IDLE);
 	spin_unlock_irqrestore(&musb->lock, flags);
 
@@ -1861,7 +1864,7 @@ static int musb_gadget_start(struct usb_gadget *g,
 	 * handles power budgeting ... this way also
 	 * ensures HdrcStart is indirectly called.
 	 */
-	if (musb->xceiv->last_event == USB_EVENT_ID)
+	if (musb->xceiv && musb->xceiv->last_event == USB_EVENT_ID)
 		musb_platform_set_vbus(musb, 1);
 
 	pm_runtime_mark_last_busy(musb->controller);
@@ -1899,7 +1902,9 @@ static int musb_gadget_stop(struct usb_gadget *g)
 
 	musb_set_state(musb, OTG_STATE_UNDEFINED);
 	musb_stop(musb);
-	otg_set_peripheral(musb->xceiv->otg, NULL);
+
+	if (musb->xceiv)
+		otg_set_peripheral(musb->xceiv->otg, NULL);
 
 	musb->is_active = 0;
 	musb->gadget_driver = NULL;
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index b7553da7f4bc..8ad39ecd3b6f 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2722,10 +2722,14 @@ int musb_host_setup(struct musb *musb, int power_budget)
 		MUSB_HST_MODE(musb);
 		musb_set_state(musb, OTG_STATE_A_IDLE);
 	}
-	otg_set_host(musb->xceiv->otg, &hcd->self);
+
+	if (musb->xceiv) {
+		otg_set_host(musb->xceiv->otg, &hcd->self);
+		musb->xceiv->otg->host = &hcd->self;
+	}
+
 	/* don't support otg protocols */
 	hcd->self.otg_port = 0;
-	musb->xceiv->otg->host = &hcd->self;
 	hcd->power_budget = 2 * (power_budget ? : 250);
 	hcd->skip_phy_initialization = 1;
 
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index 7eb929d75280..2b2164e028b3 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -50,7 +50,6 @@ void musb_host_finish_resume(struct work_struct *work)
 
 int musb_port_suspend(struct musb *musb, bool do_suspend)
 {
-	struct usb_otg	*otg = musb->xceiv->otg;
 	u8		power;
 	void __iomem	*mbase = musb->mregs;
 
@@ -88,7 +87,8 @@ int musb_port_suspend(struct musb *musb, bool do_suspend)
 		switch (musb_get_state(musb)) {
 		case OTG_STATE_A_HOST:
 			musb_set_state(musb, OTG_STATE_A_SUSPEND);
-			musb->is_active = otg->host->b_hnp_enable;
+			musb->is_active = musb->xceiv &&
+				musb->xceiv->otg->host->b_hnp_enable;
 			if (musb->is_active)
 				mod_timer(&musb->otg_timer, jiffies
 					+ msecs_to_jiffies(
@@ -97,7 +97,8 @@ int musb_port_suspend(struct musb *musb, bool do_suspend)
 			break;
 		case OTG_STATE_B_HOST:
 			musb_set_state(musb, OTG_STATE_B_WAIT_ACON);
-			musb->is_active = otg->host->b_hnp_enable;
+			musb->is_active = musb->xceiv &&
+				musb->xceiv->otg->host->b_hnp_enable;
 			musb_platform_try_idle(musb, 0);
 			break;
 		default:
@@ -196,8 +197,6 @@ void musb_port_reset(struct musb *musb, bool do_reset)
 
 void musb_root_disconnect(struct musb *musb)
 {
-	struct usb_otg	*otg = musb->xceiv->otg;
-
 	musb->port1_status = USB_PORT_STAT_POWER
 			| (USB_PORT_STAT_C_CONNECTION << 16);
 
@@ -206,7 +205,7 @@ void musb_root_disconnect(struct musb *musb)
 
 	switch (musb_get_state(musb)) {
 	case OTG_STATE_A_SUSPEND:
-		if (otg->host->b_hnp_enable) {
+		if (musb->xceiv && musb->xceiv->otg->host->b_hnp_enable) {
 			musb_set_state(musb, OTG_STATE_A_PERIPHERAL);
 			musb->g.is_a_peripheral = 1;
 			break;
-- 
2.35.1

