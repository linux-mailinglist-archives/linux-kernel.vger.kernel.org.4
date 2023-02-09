Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F5D6905CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBIK4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBIK4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:56:35 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004AF45F71;
        Thu,  9 Feb 2023 02:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1675940192; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=8Rj931UpR4sPfkYMBJNzZ2RhNPpS/Zxi0rg4US/2knY=;
        b=xAIctGGuOLVs3hAmUX9dtux/LaLJMwYJPqPWyx6PpPFfFLdf8c96TTOLzzpE5aAqiVuUK8
        Kh3JQESJfInyGEvWl+/Kp9XVFu5Zh8UtTDKFEqX7y/pctyDRMqeMEiWzkvlyzgEU2tVEdq
        c0SU+JxYBViTJNZmCVgu8NwCTUOneo8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH][6.2] Revert "usb: gadget: u_ether: Do not make UDC parent of the net device"
Date:   Thu,  9 Feb 2023 10:56:26 +0000
Message-Id: <20230209105626.10597-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 321b59870f850a10dbb211ecd2bd87b41497ea6f.

This commit broke USB networking on Ingenic SoCs and maybe elsewhere.
The actual reason is unknown; and while a proper fix would be better,
we're sitting at -rc7 now, so a revert is justified - and we can work on
re-introducing this change for 6.3.

Fixes: 321b59870f85 ("usb: gadget: u_ether: Do not make UDC parent of the net device")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/u_ether.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 8f12f3f8f6ee..e06022873df1 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -798,6 +798,7 @@ struct eth_dev *gether_setup_name(struct usb_gadget *g,
 	net->max_mtu = GETHER_MAX_MTU_SIZE;
 
 	dev->gadget = g;
+	SET_NETDEV_DEV(net, &g->dev);
 	SET_NETDEV_DEVTYPE(net, &gadget_type);
 
 	status = register_netdev(net);
@@ -872,6 +873,8 @@ int gether_register_netdev(struct net_device *net)
 	struct usb_gadget *g;
 	int status;
 
+	if (!net->dev.parent)
+		return -EINVAL;
 	dev = netdev_priv(net);
 	g = dev->gadget;
 
@@ -902,6 +905,7 @@ void gether_set_gadget(struct net_device *net, struct usb_gadget *g)
 
 	dev = netdev_priv(net);
 	dev->gadget = g;
+	SET_NETDEV_DEV(net, &g->dev);
 }
 EXPORT_SYMBOL_GPL(gether_set_gadget);
 
-- 
2.39.1

