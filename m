Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36005B4F45
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIKODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiIKODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E0326C0;
        Sun, 11 Sep 2022 07:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00E9561012;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56045C43470;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=nhRqD/sx9Bg9OQB7wlx22Zh4neB2ClHMeK+G19F5nZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHl+UYFDyc9hgxyCCqbEbyuAycVDgCkpId92WnzHynB8lZHCpMwv7dh4tN+Bgyz9k
         9ldSpyf3QSX0ySTmJFxO+cisPeLzzrW0lOj9i25m70wMrVm+l30tEBEt0U0t7jql7M
         184ypNApHU8+6NQ8u2Arek4WxdBGRJLmlRWlw7B75SaReZs5UfbpqXmCxU0/XQaSyZ
         oFn3xLn4hOlF6ZZxbO/FUd6NbcWMypTQ0lNyMfW+1FvjKQOdoxuqsZojxEu/aFDFbT
         RrcqoK43aEf6Jy53yxbbe+NC/mvkA+aA9DFHkRC/AoHelNxOW2devG9ESuipiJVrPN
         pNEY9KpifMlgA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYL-0007wm-Vr; Sun, 11 Sep 2022 16:03:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] USB: serial: ftdi_sio: tighten device-type detection
Date:   Sun, 11 Sep 2022 16:02:10 +0200
Message-Id: <20220911140216.30481-7-johan@kernel.org>
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

Clean up and tighten the device-type detection, which is based on
bcdDevice.

Don't make assumptions about unknown (future) types (currently assumed
to be either FT2232C or FT-X depending on bNumInterfaces) and instead
log an error and refuse to bind so that we can add proper support when
needed.

Note that the bcdDevice values have been provided by FTDI.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 118 ++++++++++++++++------------------
 1 file changed, 55 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 707dc3d67a19..f372f55a1bdf 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1547,89 +1547,73 @@ static int get_lsr_info(struct usb_serial_port *port,
 	return 0;
 }
 
-
-/* Determine type of FTDI chip based on USB config and descriptor. */
-static void ftdi_determine_type(struct usb_serial_port *port)
+static int ftdi_determine_type(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct usb_serial *serial = port->serial;
 	struct usb_device *udev = serial->dev;
-	unsigned version;
-	unsigned interfaces;
+	unsigned int version, ifnum;
+
+	version = le16_to_cpu(udev->descriptor.bcdDevice);
+	ifnum = serial->interface->cur_altsetting->desc.bInterfaceNumber;
 
-	/* Assume it is not the original SIO device for now. */
 	priv->baud_base = 48000000 / 2;
+	priv->channel = 0;
 
-	version = le16_to_cpu(udev->descriptor.bcdDevice);
-	interfaces = udev->actconfig->desc.bNumInterfaces;
-	dev_dbg(&port->dev, "%s: bcdDevice = 0x%x, bNumInterfaces = %u\n", __func__,
-		version, interfaces);
-	if (interfaces > 1) {
-		struct usb_interface *intf = serial->interface;
-		int ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
-
-		/* Multiple interfaces.*/
-		if (version == 0x0800) {
-			priv->chip_type = FT4232H;
-			/* Hi-speed - baud clock runs at 120MHz */
-			priv->baud_base = 120000000 / 2;
-		} else if (version == 0x0700) {
-			priv->chip_type = FT2232H;
-			/* Hi-speed - baud clock runs at 120MHz */
-			priv->baud_base = 120000000 / 2;
-		} else
-			priv->chip_type = FT2232C;
-
-		if (ifnum == 0)
-			priv->channel = CHANNEL_A;
-		else if (ifnum == 1)
-			priv->channel = CHANNEL_B;
-		else if (ifnum == 2)
-			priv->channel = CHANNEL_C;
-		else if (ifnum == 3)
-			priv->channel = CHANNEL_D;
-
-		/* BM-type devices have a bug where bcdDevice gets set
-		 * to 0x200 when iSerialNumber is 0.  */
-		if (version < 0x500) {
-			dev_dbg(&port->dev,
-				"%s: something fishy - bcdDevice too low for multi-interface device\n",
-				__func__);
-		}
-	} else if (version < 0x200) {
-		/* Old device.  Assume it's the original SIO. */
-		priv->chip_type = SIO;
-		priv->baud_base = 12000000 / 16;
-	} else if (version < 0x400) {
-		/* Assume it's an FT8U232AM (or FT8U245AM) */
+	switch (version) {
+	case 0x200:
 		priv->chip_type = FT232A;
+
 		/*
-		 * It might be a BM type because of the iSerialNumber bug.
-		 * If iSerialNumber==0 and the latency timer is readable,
-		 * assume it is BM type.
+		 * FT232B devices have a bug where bcdDevice gets set to 0x200
+		 * when iSerialNumber is 0. Assume it is an FT232B in case the
+		 * latency timer is readable.
 		 */
 		if (udev->descriptor.iSerialNumber == 0 &&
 				_read_latency_timer(port) >= 0) {
-			dev_dbg(&port->dev,
-				"%s: has latency timer so not an AM type\n",
-				__func__);
 			priv->chip_type = FT232B;
 		}
-	} else if (version < 0x600) {
-		/* Assume it's an FT232BM (or FT245BM) */
+		break;
+	case 0x400:
 		priv->chip_type = FT232B;
-	} else if (version < 0x900) {
-		/* Assume it's an FT232RL */
+		break;
+	case 0x500:
+		priv->chip_type = FT2232C;
+		priv->channel = CHANNEL_A + ifnum;
+		break;
+	case 0x600:
 		priv->chip_type = FT232R;
-	} else if (version < 0x1000) {
-		/* Assume it's an FT232H */
+		break;
+	case 0x700:
+		priv->chip_type = FT2232H;
+		priv->channel = CHANNEL_A + ifnum;
+		priv->baud_base = 120000000 / 2;
+		break;
+	case 0x800:
+		priv->chip_type = FT4232H;
+		priv->channel = CHANNEL_A + ifnum;
+		priv->baud_base = 120000000 / 2;
+		break;
+	case 0x900:
 		priv->chip_type = FT232H;
-	} else {
-		/* Assume it's an FT-X series device */
+		priv->baud_base = 120000000 / 2;
+		break;
+	case 0x1000:
 		priv->chip_type = FTX;
+		break;
+	default:
+		if (version < 0x200) {
+			priv->chip_type = SIO;
+			priv->baud_base = 12000000 / 16;
+		} else {
+			dev_err(&port->dev, "unknown device type: 0x%02x\n", version);
+			return -ENODEV;
+		}
 	}
 
 	dev_info(&udev->dev, "Detected %s\n", ftdi_chip_name[priv->chip_type]);
+
+	return 0;
 }
 
 
@@ -2256,7 +2240,10 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 
 	usb_set_serial_port_data(port, priv);
 
-	ftdi_determine_type(port);
+	result = ftdi_determine_type(port);
+	if (result)
+		goto err_free;
+
 	ftdi_set_max_packet_size(port);
 	if (read_latency_timer(port) < 0)
 		priv->latency = 16;
@@ -2271,6 +2258,11 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 	}
 
 	return 0;
+
+err_free:
+	kfree(priv);
+
+	return result;
 }
 
 /* Setup for the USB-UIRT device, which requires hardwired
-- 
2.35.1

