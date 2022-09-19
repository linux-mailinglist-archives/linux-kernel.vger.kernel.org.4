Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7249B5BCD13
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiISNZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiISNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:25:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4072ECE3E;
        Mon, 19 Sep 2022 06:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D473B81BE2;
        Mon, 19 Sep 2022 13:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6F8C433B5;
        Mon, 19 Sep 2022 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663593926;
        bh=Tff0msRmVXjswmkJrDQx5mdytkeF8V7Bwkf1RbtpykA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9Z1IH4/jlUoM1g1n73j9vu07Jo2fx2KBmmmwxjwVv9D2BXeackQe+Ay+pr6uAEKN
         ph3jJwj7eXyjwpMNz4ZuSpH1cGpV0Fjeo5XRE5yL5oz56NfE01OwdR1xJuNS7GwPCf
         28GI7ySSfulNUV3dQ2t7yVAJS1wV/oCsBozyelbT2AlrIg7jTtBnzixBjX02FjNKXI
         +9KWXqGvz8VzaSZCJypY5S3IgMC0c+vUKMrZ3ZVnT0CdUi5MDx92VrbPSetd7xRIXd
         q21cKV4yhHjmH0SoYNeRCrL8OU2idzVyEI9CHRuT3g4Ip2idFPUNasL7pWXx71SvU1
         rdHaHv/1uSzLA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaGmB-0005R5-27; Mon, 19 Sep 2022 15:25:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] USB: serial: ftdi_sio: clean up attribute visibility logic
Date:   Mon, 19 Sep 2022 15:24:54 +0200
Message-Id: <20220919132456.20851-2-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919132456.20851-1-johan@kernel.org>
References: <20220919132456.20851-1-johan@kernel.org>
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

Clean up the attribute visibility logic by defaulting to attributes
being visible and explicitly listing the exceptions.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 147b5e80595a..a5fc199cde0b 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1775,19 +1775,18 @@ static umode_t ftdi_is_visible(struct kobject *kobj, struct attribute *attr, int
 	struct usb_serial_port *port = to_usb_serial_port(dev);
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	enum ftdi_chip_type type = priv->chip_type;
-	umode_t mode = attr->mode;
 
-	if (type != SIO) {
-		if (attr == &dev_attr_event_char.attr)
-			return mode;
+	if (attr == &dev_attr_event_char.attr) {
+		if (type == SIO)
+			return 0;
 	}
 
-	if (type != SIO && type != FT232A) {
-		if (attr == &dev_attr_latency_timer.attr)
-			return mode;
+	if (attr == &dev_attr_latency_timer.attr) {
+		if (type == SIO || type == FT232A)
+			return 0;
 	}
 
-	return 0;
+	return attr->mode;
 }
 
 static const struct attribute_group ftdi_group = {
-- 
2.35.1

