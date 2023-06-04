Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73597216FB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjFDMfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB33CA;
        Sun,  4 Jun 2023 05:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E748A6114F;
        Sun,  4 Jun 2023 12:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E67C4339B;
        Sun,  4 Jun 2023 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685882095;
        bh=Ja8wGgMtSQRHBWHquX+EUjKNR8wzL800/eoXUfWWbuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8QLQLSvhcGrG/yRiuDSqn1dXsGIyujNuXwEVeHQZ0GxE6Bujxlr3Un+cL3UQjW9y
         j1UY9Mz60/pz/zWXFg7qj+J20Gow1n0tni+T/jFO4JMdSaJLny6wh9Lmu72tu6F9Tr
         FNQqNUpH2/ZqqmPd4GNy9KnqzjtX0KKq4X9gnQgc7V/Vl57i6EeUlIN1OYrqnuBhqG
         dd/dVlG4A3t8WyDFMZ/Fqjn08W57XTKGWqHPSycFmX6brCDocnN6zsB3mQ94C1gsIA
         aPPMahmaG9vBkpOSk7FD0LT71BzhsiRekBCXvm22egsEsK51jGgk9R4biXiFDRQsWK
         lbRTE77iE/NAQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q5mww-0001DW-MU; Sun, 04 Jun 2023 14:35:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 2/3] USB: serial: cp210x: disable break signalling on CP2105 SCI
Date:   Sun,  4 Jun 2023 14:35:04 +0200
Message-Id: <20230604123505.4661-3-johan@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230604123505.4661-1-johan@kernel.org>
References: <20230604123505.4661-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the first UART interface (ECI) on CP2105 supports break signalling.

Return an error on requests for break state changes for the second
interface (SCI) to avoid transmitting a garbage character and waiting
when break is not supported.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 81e49ed9d147..1e61fe043171 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1437,8 +1437,14 @@ static int cp210x_tiocmget(struct tty_struct *tty)
 static int cp210x_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct cp210x_serial_private *priv = usb_get_serial_data(port->serial);
 	u16 state;
 
+	if (priv->partnum == CP210X_PARTNUM_CP2105) {
+		if (cp210x_interface_num(port->serial) == 1)
+			return -ENOTTY;
+	}
+
 	if (break_state == 0)
 		state = BREAK_OFF;
 	else
-- 
2.39.3

