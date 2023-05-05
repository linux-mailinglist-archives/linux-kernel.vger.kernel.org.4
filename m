Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CE26F88BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjEESjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjEESjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:39:43 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769331A4AD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:39:41 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id v0L9pk2E0Gtqgv0L9pZwJH; Fri, 05 May 2023 20:39:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683311979;
        bh=mnw6geelSaRq346Pzls6ofHvmuoLhwJOFudxBY6bbI8=;
        h=From:To:Cc:Subject:Date;
        b=HNyqmFrTormmtYO1mKS6qptrkzhC39BrHqC9jF3blBVbhK2TbhTTgNuCo94rx0J9K
         6hBRWsiD/e+zisqWN/uxReWAtn5HDIS/M7SWxq85LhDBdwnDX6vVahdn179f9WAD9M
         j7pUd4x1S+Q4sxpvtlY/ubPb4OTkig2uv+jzXREk1pJJ+cgEFAiVJkb5e1zX4h3+iC
         ydc2TMMhmSvhdSFwgDsfuD+Htn1OwaE4iIPK0B8U2Al6bio7FHcn9V/6Cwu3ejoyRr
         e51zKNApddwBEw95Net0SVx8JMDxA/7IpZkUpM/lnnoPBAnk2yj6wsCET6lSrvcOQ+
         Kngrr0jYJCexg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 May 2023 20:39:39 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Tobias Waldekranz <tobias@waldekranz.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH net] net: mdio: mvusb: Fix an error handling path in mvusb_mdio_probe()
Date:   Fri,  5 May 2023 20:39:33 +0200
Message-Id: <bd2244d44b914dec1aeccee4eba2e7e8135b585b.1683311885.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should of_mdiobus_register() fail, a previous usb_get_dev() call should be
undone as in the .disconnect function.

Fixes: 04e37d92fbed ("net: phy: add marvell usb to mdio controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/mdio/mdio-mvusb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-mvusb.c b/drivers/net/mdio/mdio-mvusb.c
index 68fc55906e78..554837c21e73 100644
--- a/drivers/net/mdio/mdio-mvusb.c
+++ b/drivers/net/mdio/mdio-mvusb.c
@@ -67,6 +67,7 @@ static int mvusb_mdio_probe(struct usb_interface *interface,
 	struct device *dev = &interface->dev;
 	struct mvusb_mdio *mvusb;
 	struct mii_bus *mdio;
+	int ret;
 
 	mdio = devm_mdiobus_alloc_size(dev, sizeof(*mvusb));
 	if (!mdio)
@@ -87,7 +88,15 @@ static int mvusb_mdio_probe(struct usb_interface *interface,
 	mdio->write = mvusb_mdio_write;
 
 	usb_set_intfdata(interface, mvusb);
-	return of_mdiobus_register(mdio, dev->of_node);
+	ret = of_mdiobus_register(mdio, dev->of_node);
+	if (ret)
+		goto put_dev;
+
+	return 0;
+
+put_dev:
+	usb_put_dev(mvusb->udev);
+	return ret;
 }
 
 static void mvusb_mdio_disconnect(struct usb_interface *interface)
-- 
2.34.1

