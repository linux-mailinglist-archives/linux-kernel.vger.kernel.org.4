Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C54D5B4F5A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiIKOEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIKODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6125333A3A;
        Sun, 11 Sep 2022 07:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13C83B80B52;
        Sun, 11 Sep 2022 14:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02B8C43150;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=SAqqcP5lBP9yri+H9v6GzRI9aDJ/79pe958bAhnOMkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vI+EiDCpbWLRRhLV5ZS31hyuSwJCqJLEM9sc0cJeJXnKvIQ+94kHhn4jVlcvE9j5d
         VYcvotOyucCGqVHzLw7fFVu+isOpTq/sOmk5DgO0CnivCAuGAEd04ziDnDtnUCh5B/
         gcX3CEVs0RxSgZKjHo3QNFaM1HZQx/iO1AadP7Zrx0s+0WItfXoGUuT4qo8QnLOb+X
         xnHQtSSgp7KSD9/hr4XTUpdqMcST1EylREk5+Mb8E9IGGn8H4+YT/UPpStkU9eYff6
         GyfO82AfaZk6jxhBvdDIkbJQmbx/yiEqr2RcpEO0/OUhGqK8hm+D19PUl0W+YuYC8T
         BwQjRn+DQxHqQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYM-0007wy-BC; Sun, 11 Sep 2022 16:03:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] USB: serial: ftdi_sio: assume hi-speed type
Date:   Sun, 11 Sep 2022 16:02:14 +0200
Message-Id: <20220911140216.30481-11-johan@kernel.org>
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

In preparation for adding further Hi-Speed types, assume a 120 MHz clock
and set the channel index by default and instead override these values
as needed for legacy types.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index e772aacae562..a43101000ee3 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1552,13 +1552,15 @@ static int ftdi_determine_type(struct usb_serial_port *port)
 	version = le16_to_cpu(udev->descriptor.bcdDevice);
 	ifnum = serial->interface->cur_altsetting->desc.bInterfaceNumber;
 
-	priv->baud_base = 48000000 / 2;
-	priv->channel = 0;
+	/* Assume Hi-Speed type */
+	priv->baud_base = 120000000 / 2;
+	priv->channel = CHANNEL_A + ifnum;
 
 	switch (version) {
 	case 0x200:
 		priv->chip_type = FT232A;
-
+		priv->baud_base = 48000000 / 2;
+		priv->channel = 0;
 		/*
 		 * FT232B devices have a bug where bcdDevice gets set to 0x200
 		 * when iSerialNumber is 0. Assume it is an FT232B in case the
@@ -1571,37 +1573,36 @@ static int ftdi_determine_type(struct usb_serial_port *port)
 		break;
 	case 0x400:
 		priv->chip_type = FT232B;
+		priv->baud_base = 48000000 / 2;
+		priv->channel = 0;
 		break;
 	case 0x500:
 		priv->chip_type = FT2232C;
-		priv->channel = CHANNEL_A + ifnum;
+		priv->baud_base = 48000000 / 2;
 		break;
 	case 0x600:
 		priv->chip_type = FT232R;
+		priv->baud_base = 48000000 / 2;
+		priv->channel = 0;
 		break;
 	case 0x700:
 		priv->chip_type = FT2232H;
-		priv->channel = CHANNEL_A + ifnum;
-		priv->baud_base = 120000000 / 2;
 		break;
 	case 0x800:
 		priv->chip_type = FT4232H;
-		priv->channel = CHANNEL_A + ifnum;
-		priv->baud_base = 120000000 / 2;
 		break;
 	case 0x900:
 		priv->chip_type = FT232H;
-		priv->channel = CHANNEL_A + ifnum;
-		priv->baud_base = 120000000 / 2;
 		break;
 	case 0x1000:
 		priv->chip_type = FTX;
-		priv->channel = CHANNEL_A + ifnum;
+		priv->baud_base = 48000000 / 2;
 		break;
 	default:
 		if (version < 0x200) {
 			priv->chip_type = SIO;
 			priv->baud_base = 12000000 / 16;
+			priv->channel = 0;
 		} else {
 			dev_err(&port->dev, "unknown device type: 0x%02x\n", version);
 			return -ENODEV;
-- 
2.35.1

