Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE115B4F54
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiIKOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiIKODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE633A2B;
        Sun, 11 Sep 2022 07:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DB38B80B51;
        Sun, 11 Sep 2022 14:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB8DC433D7;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=RTXkeeZEPPGrbwaO0YHvnaYqk5ERJAmf6ulr4Fnc6bA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmlT3cNY+Tpzh16FVIYbWWWVIrbmsYVzHcLiSlVTVCkB7wfNK5U5moNQlNUk8W0xx
         Sryxm/UfWUcTqLM7vNXATSKKaNThWjJmyoUWNAOLkBD9NIRVUKSw0+mD4Tc2tZ5nU4
         eXPxoTBDV4O1zT1cQ++FpYVdUI1kU1dhUBq0uIAsbAFnNZfuUkYeMjgLhY5DD5oZZ3
         PkMDqTYp/v32MgsoHWolQa4IMaaNmAuF49/Wb/G/Zn2oV76/2fETfKzpFbcFwj1K74
         veebpUpK/s5vpsMvGdlWvDe8CkPkqSM+d9UjEIFimVf/gWhAQjw4w5F8/JARutb6Lj
         ZS1pGxPbE5iPg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYL-0007wc-MT; Sun, 11 Sep 2022 16:03:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] USB: serial: ftdi_sio: rename chip types
Date:   Sun, 11 Sep 2022 16:02:07 +0200
Message-Id: <20220911140216.30481-4-johan@kernel.org>
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

Shorten the chip type enum and string representation for A, B and R chip
types so that they don't include the IC package type in the name.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 60 +++++++++++++++++------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 4b432707d75b..b4db6a4ea223 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -49,13 +49,13 @@
 
 enum ftdi_chip_type {
 	SIO,
-	FT8U232AM,
-	FT232BM,
+	FT232A,
+	FT232B,
 	FT2232C,
-	FT232RL,
+	FT232R,
+	FT232H,
 	FT2232H,
 	FT4232H,
-	FT232H,
 	FTX,
 };
 
@@ -1071,15 +1071,15 @@ static const struct usb_device_id id_table_combined[] = {
 MODULE_DEVICE_TABLE(usb, id_table_combined);
 
 static const char *ftdi_chip_name[] = {
-	[SIO] = "SIO",	/* the serial part of FT8U100AX */
-	[FT8U232AM] = "FT8U232AM",
-	[FT232BM] = "FT232BM",
-	[FT2232C] = "FT2232C",
-	[FT232RL] = "FT232RL",
-	[FT2232H] = "FT2232H",
-	[FT4232H] = "FT4232H",
-	[FT232H]  = "FT232H",
-	[FTX]     = "FT-X"
+	[SIO]		= "SIO",	/* the serial part of FT8U100AX */
+	[FT232A]	= "FT232A",
+	[FT232B]	= "FT232B",
+	[FT2232C]	= "FT2232C",
+	[FT232R]	= "FT232R",
+	[FT232H]	= "FT232H",
+	[FT2232H]	= "FT2232H",
+	[FT4232H]	= "FT4232H",
+	[FTX]		= "FT-X",
 };
 
 
@@ -1338,7 +1338,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			div_okay = 0;
 		}
 		break;
-	case FT8U232AM:
+	case FT232A:
 		if (baud <= 3000000) {
 			div_value = ftdi_232am_baud_to_divisor(baud);
 		} else {
@@ -1348,9 +1348,9 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			div_okay = 0;
 		}
 		break;
-	case FT232BM:
+	case FT232B:
 	case FT2232C:
-	case FT232RL:
+	case FT232R:
 	case FTX:
 		if (baud <= 3000000) {
 			u16 product_id = le16_to_cpu(
@@ -1432,7 +1432,7 @@ static int write_latency_timer(struct usb_serial_port *port)
 	int rv;
 	int l = priv->latency;
 
-	if (priv->chip_type == SIO || priv->chip_type == FT8U232AM)
+	if (priv->chip_type == SIO || priv->chip_type == FT232A)
 		return -EINVAL;
 
 	if (priv->flags & ASYNC_LOW_LATENCY)
@@ -1473,7 +1473,7 @@ static int read_latency_timer(struct usb_serial_port *port)
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	int rv;
 
-	if (priv->chip_type == SIO || priv->chip_type == FT8U232AM)
+	if (priv->chip_type == SIO || priv->chip_type == FT232A)
 		return -EINVAL;
 
 	rv = _read_latency_timer(port);
@@ -1604,7 +1604,7 @@ static void ftdi_determine_type(struct usb_serial_port *port)
 		priv->baud_base = 12000000 / 16;
 	} else if (version < 0x400) {
 		/* Assume it's an FT8U232AM (or FT8U245AM) */
-		priv->chip_type = FT8U232AM;
+		priv->chip_type = FT232A;
 		/*
 		 * It might be a BM type because of the iSerialNumber bug.
 		 * If iSerialNumber==0 and the latency timer is readable,
@@ -1615,14 +1615,14 @@ static void ftdi_determine_type(struct usb_serial_port *port)
 			dev_dbg(&port->dev,
 				"%s: has latency timer so not an AM type\n",
 				__func__);
-			priv->chip_type = FT232BM;
+			priv->chip_type = FT232B;
 		}
 	} else if (version < 0x600) {
 		/* Assume it's an FT232BM (or FT245BM) */
-		priv->chip_type = FT232BM;
+		priv->chip_type = FT232B;
 	} else if (version < 0x900) {
 		/* Assume it's an FT232RL */
-		priv->chip_type = FT232RL;
+		priv->chip_type = FT232R;
 	} else if (version < 0x1000) {
 		/* Assume it's an FT232H */
 		priv->chip_type = FT232H;
@@ -1752,9 +1752,9 @@ static int create_sysfs_attrs(struct usb_serial_port *port)
 		dev_dbg(&port->dev, "sysfs attributes for %s\n", ftdi_chip_name[priv->chip_type]);
 		retval = device_create_file(&port->dev, &dev_attr_event_char);
 		if ((!retval) &&
-		    (priv->chip_type == FT232BM ||
+		    (priv->chip_type == FT232B ||
 		     priv->chip_type == FT2232C ||
-		     priv->chip_type == FT232RL ||
+		     priv->chip_type == FT232R ||
 		     priv->chip_type == FT2232H ||
 		     priv->chip_type == FT4232H ||
 		     priv->chip_type == FT232H ||
@@ -1773,9 +1773,9 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
 	/* XXX see create_sysfs_attrs */
 	if (priv->chip_type != SIO) {
 		device_remove_file(&port->dev, &dev_attr_event_char);
-		if (priv->chip_type == FT232BM ||
+		if (priv->chip_type == FT232B ||
 		    priv->chip_type == FT2232C ||
-		    priv->chip_type == FT232RL ||
+		    priv->chip_type == FT232R ||
 		    priv->chip_type == FT2232H ||
 		    priv->chip_type == FT4232H ||
 		    priv->chip_type == FT232H ||
@@ -2153,7 +2153,7 @@ static int ftdi_gpio_init(struct usb_serial_port *port)
 	case FT232H:
 		result = ftdi_gpio_init_ft232h(port);
 		break;
-	case FT232RL:
+	case FT232R:
 		result = ftdi_gpio_init_ft232r(port);
 		break;
 	case FTX:
@@ -2838,10 +2838,10 @@ static int ftdi_get_modem_status(struct usb_serial_port *port,
 	case SIO:
 		len = 1;
 		break;
-	case FT8U232AM:
-	case FT232BM:
+	case FT232A:
+	case FT232B:
 	case FT2232C:
-	case FT232RL:
+	case FT232R:
 	case FT2232H:
 	case FT4232H:
 	case FT232H:
-- 
2.35.1

