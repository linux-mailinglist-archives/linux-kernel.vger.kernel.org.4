Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638B25B4F56
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiIKOEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiIKODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713C33A3B;
        Sun, 11 Sep 2022 07:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8DA0B80B3B;
        Sun, 11 Sep 2022 14:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F68EC43149;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=37cnzMM3fHj4HuHjrrjP7jTiSZuXJ1j1atdznt3e8Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pepUIK7+4MCU4bGUVs4WRJUA0mEgHALyh3xx8GjxAj7Rb86mJnGkxBX0GgjHKBAGP
         0jemwS3p6nE6gC4g+3kKUgo8hY1jQjPdYDRwaWODTGnb2P8s1ma3Fw7xnnKag1tW70
         Gr8Y/6v4ReELfhaBfzGaYpkhMgggyWP6PA31yLZui1iWlQIQrVbKVnsJvEuA7xNaFh
         41xwZebw6XtD1Ay0FxsHIRLnAIPXELfzTQG9dCh98TKc3/u8wuoCoRJpz5PGyFPuza
         5IYOI0slfL6D6nO5QLp/jscmhiE3X+JBrv7CK4ly+k/PUvKrfPrH60e5GdNkYpcian
         hwlH40e72dGuA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYM-0007wp-2p; Sun, 11 Sep 2022 16:03:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] USB: serial: ftdi_sio: clean up modem-status handling
Date:   Sun, 11 Sep 2022 16:02:11 +0200
Message-Id: <20220911140216.30481-8-johan@kernel.org>
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

All chip types but the original SIO (FT8U100AX) return a two-byte modem
status and there's no need to explicitly list every other type in the
handler.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index f372f55a1bdf..58e0acb211df 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2821,27 +2821,13 @@ static int ftdi_get_modem_status(struct usb_serial_port *port,
 	if (!buf)
 		return -ENOMEM;
 	/*
-	 * The 8U232AM returns a two byte value (the SIO a 1 byte value) in
-	 * the same format as the data returned from the in point.
+	 * The device returns a two byte value (the SIO a 1 byte value) in the
+	 * same format as the data returned from the IN endpoint.
 	 */
-	switch (priv->chip_type) {
-	case SIO:
+	if (priv->chip_type == SIO)
 		len = 1;
-		break;
-	case FT232A:
-	case FT232B:
-	case FT2232C:
-	case FT232R:
-	case FT2232H:
-	case FT4232H:
-	case FT232H:
-	case FTX:
+	else
 		len = 2;
-		break;
-	default:
-		ret = -EFAULT;
-		goto out;
-	}
 
 	ret = usb_control_msg(port->serial->dev,
 			usb_rcvctrlpipe(port->serial->dev, 0),
-- 
2.35.1

