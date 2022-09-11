Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB05B4F5B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiIKOEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiIKODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C733A38;
        Sun, 11 Sep 2022 07:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06FB0B80B4B;
        Sun, 11 Sep 2022 14:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20EBC43153;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904990;
        bh=IKrZDRYxuBggOVlSeyt3KrXHgAe9Y/gZ2LAGYJArBlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UO8Qs6nYuHLExz8QkzQXGuoMXIEqTPb4+p4Mc8IxaTDEVW+nPC8VCTNI+LJl2epUk
         znWs2BExVS5rrIck3KlMiw8LHeNTDch/cU6JA8rcuGSl6BTFhMm47XvR/vH5/k+GjQ
         +lBdNhTUwEDfoo0KyhAIDvgbtNk47j4i40P6mfgUs6itfLqzCOyogd+Q9m7Ok9iRFn
         XzcMkfweHU9HTze42XQcAlJaDHA/b2mTh/N67/fg+HmqjrEwy6fCCGdcGMSJCtGQ85
         5WlZxSzFX14tJGY7dSW7O87si7+YiGobnJQTIecDs4i9lnMyxreHH0VWNNPUzd7Qwc
         iZacRyw6W66TA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYM-0007x4-Gd; Sun, 11 Sep 2022 16:03:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] USB: serial: ftdi_sio: add support for HP and HA devices
Date:   Sun, 11 Sep 2022 16:02:16 +0200
Message-Id: <20220911140216.30481-13-johan@kernel.org>
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

From: Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>

Add the product IDs for the USB-to-Serial devices FT2233HP, FT2232HP,
FT4233HP, FT4232HP, FT233HP, FT232HP, and FT4232HA.
Also include BCD values so that the chip type can be determined.

Signed-off-by: Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>
Link: https://lore.kernel.org/r/ac28f2c5eba23a645b3b9299c224f2755a233eef.1658385786.git.mallikarjuna.reddy@ftdichip.com
[ johan: rebase on type-handling rework, drop "Q" from automotive type
         name ]
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c     | 42 +++++++++++++++++++++++++++++++
 drivers/usb/serial/ftdi_sio_ids.h |  7 ++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index e9f508e31876..c1e707555fe0 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -56,6 +56,13 @@ enum ftdi_chip_type {
 	FT232H,
 	FT2232H,
 	FT4232H,
+	FT4232HA,
+	FT232HP,
+	FT233HP,
+	FT2232HP,
+	FT2233HP,
+	FT4232HP,
+	FT4233HP,
 	FTX,
 };
 
@@ -189,6 +196,13 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_4232H_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_232H_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_FTX_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT2233HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT4233HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT2232HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT4232HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT233HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT232HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT4232HA_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_MICRO_CHAMELEON_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_RELAIS_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_OPENDCC_PID) },
@@ -1078,6 +1092,13 @@ static const char *ftdi_chip_name[] = {
 	[FT232H]	= "FT232H",
 	[FT2232H]	= "FT2232H",
 	[FT4232H]	= "FT4232H",
+	[FT4232HA]	= "FT4232HA",
+	[FT232HP]	= "FT232HP",
+	[FT233HP]	= "FT233HP",
+	[FT2232HP]	= "FT2232HP",
+	[FT2233HP]	= "FT2233HP",
+	[FT4232HP]	= "FT4232HP",
+	[FT4233HP]	= "FT4233HP",
 	[FTX]		= "FT-X",
 };
 
@@ -1596,6 +1617,27 @@ static int ftdi_determine_type(struct usb_serial_port *port)
 		priv->chip_type = FTX;
 		priv->baud_base = 48000000 / 2;
 		break;
+	case 0x2800:
+		priv->chip_type = FT2233HP;
+		break;
+	case 0x2900:
+		priv->chip_type = FT4233HP;
+		break;
+	case 0x3000:
+		priv->chip_type = FT2232HP;
+		break;
+	case 0x3100:
+		priv->chip_type = FT4232HP;
+		break;
+	case 0x3200:
+		priv->chip_type = FT233HP;
+		break;
+	case 0x3300:
+		priv->chip_type = FT232HP;
+		break;
+	case 0x3600:
+		priv->chip_type = FT4232HA;
+		break;
 	default:
 		if (version < 0x200) {
 			priv->chip_type = SIO;
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 31c8ccabbbb7..e2099445db70 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -25,6 +25,13 @@
 #define FTDI_4232H_PID 0x6011 /* Quad channel hi-speed device */
 #define FTDI_232H_PID  0x6014 /* Single channel hi-speed device */
 #define FTDI_FTX_PID   0x6015 /* FT-X series (FT201X, FT230X, FT231X, etc) */
+#define FTDI_FT2233HP_PID	0x6040 /* Dual channel hi-speed device with PD */
+#define FTDI_FT4233HP_PID	0x6041 /* Quad channel hi-speed device with PD */
+#define FTDI_FT2232HP_PID	0x6042 /* Dual channel hi-speed device with PD */
+#define FTDI_FT4232HP_PID	0x6043 /* Quad channel hi-speed device with PD */
+#define FTDI_FT233HP_PID	0x6044 /* Dual channel hi-speed device with PD */
+#define FTDI_FT232HP_PID	0x6045 /* Dual channel hi-speed device with PD */
+#define FTDI_FT4232HA_PID	0x6048 /* Quad channel automotive grade hi-speed device */
 #define FTDI_SIO_PID	0x8372	/* Product Id SIO application of 8U100AX */
 #define FTDI_232RL_PID  0xFBFA  /* Product ID for FT232RL */
 
-- 
2.35.1

