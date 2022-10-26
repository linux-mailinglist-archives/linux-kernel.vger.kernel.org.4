Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80D760E736
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiJZS1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiJZS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:27:44 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF382D34;
        Wed, 26 Oct 2022 11:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666808827; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOVVrSW/npzEAOc9hlI/DwXmmJ9MpDgUUfZkFKj4+dA=;
        b=lpkky17SVhLZCcTnEHZTdCGuwaziUESpWLf5k7/4e2CoVvZ0aCBSad4ivJ3hUATEKKJNyW
        By4+DsKFVvl9iZb9AH+gB0l6QRTIALtYy5Lrb4yg71TUnJzQL6B6tpKw/9No910txXXmoH
        ibtFJO2d3KQjljyzIu7S0Y/nXUmUQtk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, od@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/7] usb: musb: Support setting OTG mode using generic PHY
Date:   Wed, 26 Oct 2022 19:26:54 +0100
Message-Id: <20221026182657.146630-5-paul@crapouillou.net>
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

When musb->xceiv is not provided but musb->phy is, support setting the
OTG mode (host, peripheral) using the generic PHY framework.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/musb_gadget.c | 4 ++++
 drivers/usb/musb/musb_host.c   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 66c8b32b16bb..6cb9514ef340 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1854,6 +1854,8 @@ static int musb_gadget_start(struct usb_gadget *g,
 
 	if (musb->xceiv)
 		otg_set_peripheral(musb->xceiv->otg, &musb->g);
+	else
+		phy_set_mode(musb->phy, PHY_MODE_USB_DEVICE);
 
 	musb_set_state(musb, OTG_STATE_B_IDLE);
 	spin_unlock_irqrestore(&musb->lock, flags);
@@ -1905,6 +1907,8 @@ static int musb_gadget_stop(struct usb_gadget *g)
 
 	if (musb->xceiv)
 		otg_set_peripheral(musb->xceiv->otg, NULL);
+	else
+		phy_set_mode(musb->phy, PHY_MODE_INVALID);
 
 	musb->is_active = 0;
 	musb->gadget_driver = NULL;
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 8ad39ecd3b6f..a02c29216955 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2726,6 +2726,8 @@ int musb_host_setup(struct musb *musb, int power_budget)
 	if (musb->xceiv) {
 		otg_set_host(musb->xceiv->otg, &hcd->self);
 		musb->xceiv->otg->host = &hcd->self;
+	} else {
+		phy_set_mode(musb->phy, PHY_MODE_USB_HOST);
 	}
 
 	/* don't support otg protocols */
-- 
2.35.1

