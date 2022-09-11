Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011B85B4F50
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIKODU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiIKODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3681E33419;
        Sun, 11 Sep 2022 07:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C06CC60F5B;
        Sun, 11 Sep 2022 14:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AF2C43146;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=AEuQN1qN6g4lPNcGSyMgkuEVA8PP453BV0ADwWgFgQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usPjSiPoWKN/+cbGghdmZOsmNK8WmSkn2z0waF9Doxij9MQM9jGqUSQcCAgQBP4QP
         MSQX7lFNP3knTEpkm96ktvS7fqMqQpZ+CAevgb5iLlEpEBdZfe/1cJTpczQRnTm7OG
         p6qad5mI9g8yUDdl1QOpkGnYi72nNkeyxgTQwFW7CjvSwYb01VsIMydjhHk2MWjdku
         UoLVBREBCsjTwNWpnTTOhfAgHUZqqce+Bp8XkR1U5PXddR9/RFYT6FPsRLfIXgvH4S
         BK9yM6yV7yIC2i2AyblhFEhTi0p9NogBs9iQTlpg4mrM9WO73m0M8RcjOiG2CYPP+X
         357X7OT9pwulA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYM-0007ws-5j; Sun, 11 Sep 2022 16:03:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] USB: serial: ftdi_sio: clean up attribute handling
Date:   Sun, 11 Sep 2022 16:02:12 +0200
Message-Id: <20220911140216.30481-9-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220911140216.30481-1-johan@kernel.org>
References: <20220911140216.30481-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver exposes two attributes for all chip types but FT232A, which
doesn't have a configurable latency timer, and SIO, which (probably)
doesn't support the event-char mechanism either.

Explicitly test for the exceptions rather than list each and every
supported device type in the attribute helpers.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 47 ++++++++++++-----------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 58e0acb211df..835e12fc971a 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1726,46 +1726,31 @@ static DEVICE_ATTR_WO(event_char);
 static int create_sysfs_attrs(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	int retval = 0;
-
-	/* XXX I've no idea if the original SIO supports the event_char
-	 * sysfs parameter, so I'm playing it safe.  */
-	if (priv->chip_type != SIO) {
-		dev_dbg(&port->dev, "sysfs attributes for %s\n", ftdi_chip_name[priv->chip_type]);
-		retval = device_create_file(&port->dev, &dev_attr_event_char);
-		if ((!retval) &&
-		    (priv->chip_type == FT232B ||
-		     priv->chip_type == FT2232C ||
-		     priv->chip_type == FT232R ||
-		     priv->chip_type == FT2232H ||
-		     priv->chip_type == FT4232H ||
-		     priv->chip_type == FT232H ||
-		     priv->chip_type == FTX)) {
-			retval = device_create_file(&port->dev,
-						    &dev_attr_latency_timer);
-		}
+	enum ftdi_chip_type type = priv->chip_type;
+	int ret = 0;
+
+	if (type != SIO) {
+		ret = device_create_file(&port->dev, &dev_attr_event_char);
+		if (ret)
+			return ret;
 	}
-	return retval;
+
+	if (type != SIO && type != FT232A)
+		ret = device_create_file(&port->dev, &dev_attr_latency_timer);
+
+	return ret;
 }
 
 static void remove_sysfs_attrs(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	enum ftdi_chip_type type = priv->chip_type;
 
-	/* XXX see create_sysfs_attrs */
-	if (priv->chip_type != SIO) {
+	if (type != SIO)
 		device_remove_file(&port->dev, &dev_attr_event_char);
-		if (priv->chip_type == FT232B ||
-		    priv->chip_type == FT2232C ||
-		    priv->chip_type == FT232R ||
-		    priv->chip_type == FT2232H ||
-		    priv->chip_type == FT4232H ||
-		    priv->chip_type == FT232H ||
-		    priv->chip_type == FTX) {
-			device_remove_file(&port->dev, &dev_attr_latency_timer);
-		}
-	}
 
+	if (type != SIO && type != FT232A)
+		device_remove_file(&port->dev, &dev_attr_latency_timer);
 }
 
 #ifdef CONFIG_GPIOLIB
-- 
2.35.1

