Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5249A5B4F51
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiIKODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIKODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C5326C0;
        Sun, 11 Sep 2022 07:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59BBE61048;
        Sun, 11 Sep 2022 14:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F047C4314B;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=8hzbbHrrGmUOdQqlSJTWWGTPUH/13Z+G4m3ZYEOgNvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enVnn68zg9k4o1V/OCt/4mezo8NKe/wT8/lv9XAirYMcn+T5zICCv0Q8rehhW3u4S
         XbDkZ/y0/Qzu/dDDQqOZMMHEkzI0DBWNrNqSfq3dkft3g+vTpX4nX7lfz87tkBfERz
         XtZNPEu5K4xjDfnJQs+Yv2pBkTa9UpsECnlBhA8SrY6iFtyn4nDTHi4XyRdfuKuUKh
         6nP1xAgq2GO2qqreas4J8dm2f/ILk9LWSIw8WOeAL2e3c/d6wfE11bjrKi4O9ofZ6v
         VFL8yvtd5nb8aw2YfhYUWIaQNA9E2gbFMx2N4P/KtgtLrpPwy6d0FilT8sC7vwcHO4
         oGsu1FlAj0Ojw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYM-0007wv-8b; Sun, 11 Sep 2022 16:03:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] USB: serial: ftdi_sio: clean up baudrate request
Date:   Sun, 11 Sep 2022 16:02:13 +0200
Message-Id: <20220911140216.30481-10-johan@kernel.org>
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

Multi-channel devices need to encode the channel selector in their
control requests and newer single-channel chip types use the same
request format.

Set the channel index also for these single-channel types so that the
index can be used to determine the baudrate request format instead of
listing types explicitly.

Note that FT232H and FTX accept either 0 or 1 as selector for their
single channel, presumably for backward compatibility reasons.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 835e12fc971a..e772aacae562 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1407,13 +1407,8 @@ static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
 	index_value = get_ftdi_divisor(tty, port);
 	value = (u16)index_value;
 	index = (u16)(index_value >> 16);
-	if (priv->chip_type == FT2232C || priv->chip_type == FT2232H ||
-			priv->chip_type == FT4232H || priv->chip_type == FT232H ||
-			priv->chip_type == FTX) {
-		/* Probably the BM type needs the MSB of the encoded fractional
-		 * divider also moved like for the chips above. Any infos? */
+	if (priv->channel)
 		index = (u16)((index << 8) | priv->channel);
-	}
 
 	rv = usb_control_msg(port->serial->dev,
 			    usb_sndctrlpipe(port->serial->dev, 0),
@@ -1596,10 +1591,12 @@ static int ftdi_determine_type(struct usb_serial_port *port)
 		break;
 	case 0x900:
 		priv->chip_type = FT232H;
+		priv->channel = CHANNEL_A + ifnum;
 		priv->baud_base = 120000000 / 2;
 		break;
 	case 0x1000:
 		priv->chip_type = FTX;
+		priv->channel = CHANNEL_A + ifnum;
 		break;
 	default:
 		if (version < 0x200) {
-- 
2.35.1

