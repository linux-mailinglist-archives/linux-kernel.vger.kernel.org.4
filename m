Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601A772164B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 13:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjFDLLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 07:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFDLL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 07:11:28 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084F483
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 04:11:26 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 5ldsqSy1Rxbtx5ldsqUd84; Sun, 04 Jun 2023 13:11:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685877085;
        bh=UutA+4HoQTrFvBUHKvF3cps73mebreJXZd7+xMeN1VI=;
        h=From:To:Cc:Subject:Date;
        b=UsygrdGW7TEBua2m9lk+P1GEARd5eoHSENJLiRV7uHBr/96ImlKJnfFampPX9oA8i
         9BqlrZmF/G6WbxRg6mVW6ys29WSBPsvOHYj+xDOJNoeboRk97thIDWLKbFUcSiytfU
         mKDdOe4/AiH/H1HIr0vD4pez4GUJ49X4boTQDQm9IgBTkKGuvER/Mc1SXlc/ykUs14
         YVTmxnD0mB4pR6hntAKl09H5XBdYGKH0NOMORkUDG0wNovDJft+8h2NCVEJHucy1WM
         KcoeBu/uBhJokHg0eAUb5nMmjt1q2y1R+/Sn1xqbXK/4yZu3yqxEajXyZnk7K4d1Kz
         XWkTCFBz+8Whg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 04 Jun 2023 13:11:25 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Richard Leitner <richard.leitner@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: usb251xb: Use of_property_read_u16()
Date:   Sun,  4 Jun 2023 13:11:18 +0200
Message-Id: <97478908a814d4fa694e0ca44212c3776cf3e6e9.1685877052.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_property_read_u16() instead of of_property_read_u16_array() when
only 1 element is read.
This slightly simplifies the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/misc/usb251xb.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 1f3329ef5c7a..e4edb486b69e 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -416,14 +416,13 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 		return dev_err_probe(dev, PTR_ERR(hub->gpio_reset),
 				     "unable to request GPIO reset pin\n");
 
-	if (of_property_read_u16_array(np, "vendor-id", &hub->vendor_id, 1))
+	if (of_property_read_u16(np, "vendor-id", &hub->vendor_id))
 		hub->vendor_id = USB251XB_DEF_VENDOR_ID;
 
-	if (of_property_read_u16_array(np, "product-id",
-				       &hub->product_id, 1))
+	if (of_property_read_u16(np, "product-id", &hub->product_id))
 		hub->product_id = data->product_id;
 
-	if (of_property_read_u16_array(np, "device-id", &hub->device_id, 1))
+	if (of_property_read_u16(np, "device-id", &hub->device_id))
 		hub->device_id = USB251XB_DEF_DEVICE_ID;
 
 	hub->conf_data1 = USB251XB_DEF_CONFIG_DATA_1;
@@ -532,7 +531,7 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 	if (!of_property_read_u32(np, "power-on-time-ms", &property_u32))
 		hub->power_on_time = min_t(u8, property_u32 / 2, 255);
 
-	if (of_property_read_u16_array(np, "language-id", &hub->lang_id, 1))
+	if (of_property_read_u16(np, "language-id", &hub->lang_id))
 		hub->lang_id = USB251XB_DEF_LANGUAGE_ID;
 
 	if (of_property_read_u8(np, "boost-up", &hub->boost_up))
-- 
2.34.1

