Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C421E7018D3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbjEMR6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjEMR5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E04A2133;
        Sat, 13 May 2023 10:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89DE861CAE;
        Sat, 13 May 2023 17:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B0BC433B0;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=2fRqwV2foJ6Q8LqJQ6YyRlrbT2AHforZWBmSS4FXU48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjAAUFrJkuIB3s8CX6Mj989yLIQjYixjIi9Q7wFneImPFc7hF8g7ZpmWVaMORVdYn
         HB9gJ6jNzvpFkWDOV7jQsj4wPEpR9+tYZus1tf6PTH7US9pScv9h0tsbKKKdGTWgBI
         FKB4AZEh7RmY1qXFRtW8WSe7u3nin7rFxh6xEX2EK23JkzAjESxjau6tWKLSQ7kXtQ
         Eg9/dlGZhNDGpYdbNjZSOv2gTZ6z6uzCBxHrkRfM8rv2rcTfHxJIZCpdGw99sGc07E
         /wFDmDU5UQppGCSHXtsLiW9/8abFHLZVpXx56LP3MDtaC/zUYQ2wHSBMUSZjjHhBab
         camKcsOee+rpw==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001tyT-21;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 22/24] media: dw2102: return -EIO instead of -1 for mac address read errors
Date:   Sat, 13 May 2023 18:57:39 +0100
Message-Id: <af920cd5eb144a10f7bf3baf9dc7dd8558707ff9.1684000646.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dvb-usb core function only checks if the returned value is
zero, so it doesn't actually matter the error code. Still, returning
-1 as an error condition is something that we don't do upstream. So,
change the logic to return -EIO in case of I2C transfer failures.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/usb/dvb-usb/dw2102.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 2a048499468b..970b84c3f0b5 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -830,7 +830,7 @@ static int dw210x_read_mac_address(struct dvb_usb_device *d, u8 mac[6])
 	for (i = 0; i < 256; i++) {
 		if (dw210x_op_rw(d->udev, 0xb6, 0xa0 , i, ibuf, 2, DW210X_READ_MSG) < 0) {
 			err("read eeprom failed.");
-			return -1;
+			return -EIO;
 		} else {
 			eepromline[i%16] = ibuf[0];
 			eeprom[i] = ibuf[0];
@@ -869,7 +869,7 @@ static int s6x0_read_mac_address(struct dvb_usb_device *d, u8 mac[6])
 		ret = s6x0_i2c_transfer(&d->i2c_adap, msg, 2);
 		if (ret != 2) {
 			err("read eeprom failed.");
-			return -1;
+			return -EIO;
 		} else {
 			eepromline[i % 16] = ibuf[0];
 			eeprom[i] = ibuf[0];
@@ -946,7 +946,7 @@ static int su3000_read_mac_address(struct dvb_usb_device *d, u8 mac[6])
 	for (i = 0; i < 6; i++) {
 		obuf[1] = 0xf0 + i;
 		if (i2c_transfer(&d->i2c_adap, msg, 2) != 2)
-			return -1;
+			return -EIO;
 		else
 			mac[i] = ibuf[0];
 	}
-- 
2.40.1

