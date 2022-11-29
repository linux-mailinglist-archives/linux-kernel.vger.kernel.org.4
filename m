Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AEB63C24C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiK2OTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbiK2OTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:19:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B3064A14;
        Tue, 29 Nov 2022 06:16:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87DF36175D;
        Tue, 29 Nov 2022 14:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6D1C433C1;
        Tue, 29 Nov 2022 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669731377;
        bh=wJYMqQkpPj53vh5G04dC9dsU41D7ACPHJwuQY6nmZ/4=;
        h=From:To:Cc:Subject:Date:From;
        b=dhm8KHFCw3QIMflr1nxPDMhvWwb8g2gbM3uVz+oJL4RUgqfTeX7UCL26l+OkNzXpu
         5gpemrr98/AVbqThALGRPomnWDNbFOfAXnvDdHHVvBhdLhNfOTtjZiX0hNh3efhGWX
         o9C/Zq81LdbUDL9h4JRhO8uayFGk/c6QcmcYoE/FavR6CXiAnIGYbtU3rDQ6lncnuv
         3tQbvbokq+/jBKsnktihuj24VVeOFdbLZQXsey+tuVPjZhug4NPEkcLu7/0eLGUe0v
         ObRecdnwqXYwMNcFxusqK1yaTIo44TkQrNnNILupHCsl6wX7Kvkg9M0ePckOWuh/Qv
         B10DmJzx0N8AA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p01PF-0003xI-FN; Tue, 29 Nov 2022 15:16:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Alex Henrie <alexh@vpitech.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: cp210x: add support for B0 hangup
Date:   Tue, 29 Nov 2022 15:15:39 +0100
Message-Id: <20221129141539.15176-1-johan@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A request to set the line speed to B0 is used to hang up a modem
connection by deasserting the modem control lines.

Note that there is no need reconfigure the line speed in hardware when
B0 is requested (even if some drivers do set it to an arbitrary value
for implementation or protocol reasons).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index f6fb23620e87..67372acc2352 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1049,11 +1049,12 @@ static void cp210x_change_speed(struct tty_struct *tty,
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	u32 baud;
 
+	if (tty->termios.c_ospeed == 0)
+		return;
+
 	/*
 	 * This maps the requested rate to the actual rate, a valid rate on
 	 * cp2102 or cp2103, or to an arbitrary rate in [1M, max_speed].
-	 *
-	 * NOTE: B0 is not implemented.
 	 */
 	baud = clamp(tty->termios.c_ospeed, priv->min_speed, priv->max_speed);
 
@@ -1146,7 +1147,8 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 		tty->termios.c_iflag &= ~(IXON | IXOFF);
 	}
 
-	if (old_termios &&
+	if (tty->termios.c_ospeed != 0 &&
+			old_termios && old_termios->c_ospeed != 0 &&
 			C_CRTSCTS(tty) == (old_termios->c_cflag & CRTSCTS) &&
 			I_IXON(tty) == (old_termios->c_iflag & IXON) &&
 			I_IXOFF(tty) == (old_termios->c_iflag & IXOFF) &&
@@ -1171,6 +1173,14 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 
 	mutex_lock(&port_priv->mutex);
 
+	if (tty->termios.c_ospeed == 0) {
+		port_priv->dtr = false;
+		port_priv->rts = false;
+	} else if (old_termios && old_termios->c_ospeed == 0) {
+		port_priv->dtr = true;
+		port_priv->rts = true;
+	}
+
 	ret = cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
 			sizeof(flow_ctl));
 	if (ret)
@@ -1243,7 +1253,8 @@ static void cp210x_set_termios(struct tty_struct *tty,
 	u16 bits;
 	int ret;
 
-	if (old_termios && !cp210x_termios_change(&tty->termios, old_termios))
+	if (old_termios && !cp210x_termios_change(&tty->termios, old_termios) &&
+			tty->termios.c_ospeed != 0)
 		return;
 
 	if (!old_termios || tty->termios.c_ospeed != old_termios->c_ospeed)
-- 
2.37.4

