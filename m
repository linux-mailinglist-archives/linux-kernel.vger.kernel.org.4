Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4706870CC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjBAWBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBAWBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:01:39 -0500
X-Greylist: delayed 9668 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 14:01:37 PST
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67658721E3;
        Wed,  1 Feb 2023 14:01:37 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 60EF61B001A3;
        Thu,  2 Feb 2023 00:01:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1675288894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=7qMACyI50QCL/1H8CQztKwAHxqU95HicQ+T+75853As=;
        b=C3hyYo+q5gsvGCex9DMuC+hDsie43vE0s5nr2I3VM4TioBL0hPTAxVWiDqiO8W4SsJZr/M
        0AgWWNOpdoVnBOGINMOnvPctd89w+nBYsv2SRjMekBsBsTFYZaMf3mfGRhcfTd14cDChZI
        0ruteU74W95yrV3uo5Dgx5wsa9Fcq5gUYwkBfe7WE/WfCRF+bZVrsPSs4OxzZvq3RzAAFx
        uOAeQcIQCNix8Vdl4nb9gYiJSgV9d9hw18L8HZ5OPqzR3XxS+v5AkDugKYTkWWOhcs9U8U
        yshxfE174KYH6KYFIVvh69EufdhRzyFUD6PvRkcncqWUHRUWSx3Z/m73IAt6eg==
Received: from darkstar.musicnaut.iki.fi (85-76-35-32-nat.elisa-mobile.fi [85.76.35.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id A663A20071;
        Thu,  2 Feb 2023 00:01:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1675288888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=7qMACyI50QCL/1H8CQztKwAHxqU95HicQ+T+75853As=;
        b=Cr2/+l3633BNoAOWWyjwPWw9AwLNxM0CEgndIYguIliAzbpuf+Co5m0yvAT9PPuAttPuCr
        cbQGI9oKrLyG0JVMiequANl/tvuRVATAfXcrWNZQdS6H9I9Y25w1TkhPNVJHZw/Br6MTfD
        xyyBoM90fxI8kkJAOIlsaG2ascyQFvo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1675288888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=7qMACyI50QCL/1H8CQztKwAHxqU95HicQ+T+75853As=;
        b=QJWKXv6TymNVDw5KlNYoyq8TFhR27v5UHHBs19G6BYp8TgEVhyyDE1eQ8a/QPtFMNGM1kN
        vlmvUVL2bpgPJjG90PMlGepSOuF36HtL+ycSQUjpEAwivQNZQSQmEXYiCQMPNgZlllVxrt
        GVmKi4xTfQZ6am1bOvlixMGyF7tOk9Q=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1675288888; a=rsa-sha256; cv=none;
        b=et3oMo+X+eGZzbGfLHm3Gelzlbsw07EbR5xiwnV61dEUXjCmDNjxvn5kJbQatWbCjDoX1w
        JnAsbzXY7qQaz1pEHFpGZa9fjrpOzA9Ytzv39hn6zGbOgCluKRpIte1TbbEuSjFNiG+UEQ
        bMqAVaWsAulsXrAnGq+PdWqujyUT9Gs=
Date:   Thu, 2 Feb 2023 00:01:25 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: udc: do not clear gadget driver.bus
Message-ID: <20230201220125.GD2415@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the commit fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
gadget driver.bus was unused. For whatever reason, many UDC drivers set
this field explicitly to NULL in udc_start(). With the newly added gadget
bus, doing this will crash the driver during the attach.

The problem was first reported, fixed and tested with OMAP UDC and g_ether.
Other drivers are changed based on code analysis only.

Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/fotg210/fotg210-udc.c      | 1 -
 drivers/usb/gadget/udc/bcm63xx_udc.c   | 1 -
 drivers/usb/gadget/udc/fsl_qe_udc.c    | 1 -
 drivers/usb/gadget/udc/fsl_udc_core.c  | 1 -
 drivers/usb/gadget/udc/fusb300_udc.c   | 1 -
 drivers/usb/gadget/udc/goku_udc.c      | 1 -
 drivers/usb/gadget/udc/gr_udc.c        | 1 -
 drivers/usb/gadget/udc/m66592-udc.c    | 1 -
 drivers/usb/gadget/udc/max3420_udc.c   | 1 -
 drivers/usb/gadget/udc/mv_u3d_core.c   | 1 -
 drivers/usb/gadget/udc/mv_udc_core.c   | 1 -
 drivers/usb/gadget/udc/net2272.c       | 1 -
 drivers/usb/gadget/udc/net2280.c       | 1 -
 drivers/usb/gadget/udc/omap_udc.c      | 1 -
 drivers/usb/gadget/udc/pch_udc.c       | 1 -
 drivers/usb/gadget/udc/snps_udc_core.c | 1 -
 16 files changed, 16 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
index 87cca81bf4ac..eb076746f032 100644
--- a/drivers/usb/fotg210/fotg210-udc.c
+++ b/drivers/usb/fotg210/fotg210-udc.c
@@ -1014,7 +1014,6 @@ static int fotg210_udc_start(struct usb_gadget *g,
 	int ret;
 
 	/* hook up the driver */
-	driver->driver.bus = NULL;
 	fotg210->driver = driver;
 
 	if (!IS_ERR_OR_NULL(fotg210->phy)) {
diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index 2cdb07905bde..d04d72f5816e 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -1830,7 +1830,6 @@ static int bcm63xx_udc_start(struct usb_gadget *gadget,
 	bcm63xx_select_phy_mode(udc, true);
 
 	udc->driver = driver;
-	driver->driver.bus = NULL;
 	udc->gadget.dev.of_node = udc->dev->of_node;
 
 	spin_unlock_irqrestore(&udc->lock, flags);
diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index bf745358e28e..3b1cc8fa30c8 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -2285,7 +2285,6 @@ static int fsl_qe_start(struct usb_gadget *gadget,
 	/* lock is needed but whether should use this lock or another */
 	spin_lock_irqsave(&udc->lock, flags);
 
-	driver->driver.bus = NULL;
 	/* hook up the driver */
 	udc->driver = driver;
 	udc->gadget.speed = driver->max_speed;
diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 50435e804118..a67873a074b7 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1943,7 +1943,6 @@ static int fsl_udc_start(struct usb_gadget *g,
 	/* lock is needed but whether should use this lock or another */
 	spin_lock_irqsave(&udc_controller->lock, flags);
 
-	driver->driver.bus = NULL;
 	/* hook up the driver */
 	udc_controller->driver = driver;
 	spin_unlock_irqrestore(&udc_controller->lock, flags);
diff --git a/drivers/usb/gadget/udc/fusb300_udc.c b/drivers/usb/gadget/udc/fusb300_udc.c
index 9af8b415f303..5954800d652c 100644
--- a/drivers/usb/gadget/udc/fusb300_udc.c
+++ b/drivers/usb/gadget/udc/fusb300_udc.c
@@ -1311,7 +1311,6 @@ static int fusb300_udc_start(struct usb_gadget *g,
 	struct fusb300 *fusb300 = to_fusb300(g);
 
 	/* hook up the driver */
-	driver->driver.bus = NULL;
 	fusb300->driver = driver;
 
 	return 0;
diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index bdc56b24b5c9..5ffb3d5c635b 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -1375,7 +1375,6 @@ static int goku_udc_start(struct usb_gadget *g,
 	struct goku_udc	*dev = to_goku_udc(g);
 
 	/* hook up the driver */
-	driver->driver.bus = NULL;
 	dev->driver = driver;
 
 	/*
diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 22096f8505de..85cdc0af3bf9 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -1906,7 +1906,6 @@ static int gr_udc_start(struct usb_gadget *gadget,
 	spin_lock(&dev->lock);
 
 	/* Hook up the driver */
-	driver->driver.bus = NULL;
 	dev->driver = driver;
 
 	/* Get ready for host detection */
diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
index c7e421b449f3..06e21cee431b 100644
--- a/drivers/usb/gadget/udc/m66592-udc.c
+++ b/drivers/usb/gadget/udc/m66592-udc.c
@@ -1454,7 +1454,6 @@ static int m66592_udc_start(struct usb_gadget *g,
 	struct m66592 *m66592 = to_m66592(g);
 
 	/* hook up the driver */
-	driver->driver.bus = NULL;
 	m66592->driver = driver;
 
 	m66592_bset(m66592, M66592_VBSE | M66592_URST, M66592_INTENB0);
diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 3074da00c3df..ddf0ed3eb4f2 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -1108,7 +1108,6 @@ static int max3420_udc_start(struct usb_gadget *gadget,
 
 	spin_lock_irqsave(&udc->lock, flags);
 	/* hook up the driver */
-	driver->driver.bus = NULL;
 	udc->driver = driver;
 	udc->gadget.speed = USB_SPEED_FULL;
 
diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index 598654a3cb41..411b6179782c 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -1243,7 +1243,6 @@ static int mv_u3d_start(struct usb_gadget *g,
 	}
 
 	/* hook up the driver ... */
-	driver->driver.bus = NULL;
 	u3d->driver = driver;
 
 	u3d->ep0_dir = USB_DIR_OUT;
diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index fdb17d86cd65..b397f3a848cf 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -1359,7 +1359,6 @@ static int mv_udc_start(struct usb_gadget *gadget,
 	spin_lock_irqsave(&udc->lock, flags);
 
 	/* hook up the driver ... */
-	driver->driver.bus = NULL;
 	udc->driver = driver;
 
 	udc->usb_state = USB_STATE_ATTACHED;
diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 84605a4d0715..538c1b9a2883 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -1451,7 +1451,6 @@ static int net2272_start(struct usb_gadget *_gadget,
 		dev->ep[i].irqs = 0;
 	/* hook up the driver ... */
 	dev->softconnect = 1;
-	driver->driver.bus = NULL;
 	dev->driver = driver;
 
 	/* ... then enable host detection and ep0; and we're ready
diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index d6a68631354a..1b929c519cd7 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -2423,7 +2423,6 @@ static int net2280_start(struct usb_gadget *_gadget,
 		dev->ep[i].irqs = 0;
 
 	/* hook up the driver ... */
-	driver->driver.bus = NULL;
 	dev->driver = driver;
 
 	retval = device_create_file(&dev->pdev->dev, &dev_attr_function);
diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index bea346e362b2..f660ebfa1379 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2066,7 +2066,6 @@ static int omap_udc_start(struct usb_gadget *g,
 	udc->softconnect = 1;
 
 	/* hook up the driver */
-	driver->driver.bus = NULL;
 	udc->driver = driver;
 	spin_unlock_irqrestore(&udc->lock, flags);
 
diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 9bb7a9d7a2fb..4f8617210d85 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -2908,7 +2908,6 @@ static int pch_udc_start(struct usb_gadget *g,
 {
 	struct pch_udc_dev	*dev = to_pch_udc(g);
 
-	driver->driver.bus = NULL;
 	dev->driver = driver;
 
 	/* get ready for ep0 traffic */
diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
index 52ea4dcf6a92..2fc5d4d277bc 100644
--- a/drivers/usb/gadget/udc/snps_udc_core.c
+++ b/drivers/usb/gadget/udc/snps_udc_core.c
@@ -1933,7 +1933,6 @@ static int amd5536_udc_start(struct usb_gadget *g,
 	struct udc *dev = to_amd5536_udc(g);
 	u32 tmp;
 
-	driver->driver.bus = NULL;
 	dev->driver = driver;
 
 	/* Some gadget drivers use both ep0 directions.
-- 
2.17.0

