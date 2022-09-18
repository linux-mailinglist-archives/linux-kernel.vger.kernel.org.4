Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314F85BBDEC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 15:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIRNIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIRNIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 09:08:22 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F4B1FCC8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 06:08:20 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Zu1yoxokbiBgAZu1yoePn2; Sun, 18 Sep 2022 15:08:18 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Sep 2022 15:08:18 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: applespi - avoid wasting some memory
Date:   Sun, 18 Sep 2022 15:08:17 +0200
Message-Id: <0db94f84920663f3bd45a73e2ae73950627a377f.1663506472.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the 'struct applespi_data' structure is allocated at the beginning of
applespi_probe(), 2504 bytes are allocated.

Because of the way memory is allocated, it ends to a 4096 bytes allocation.
So, about 1500 bytes are wasted.

Later in this function, when 'tx_buffer', 'tx_status', 'rx_buffer' and
'msg_buf' are allocated, 256, 4, 256 and 512 bytes are requested (~1 ko).
A devm_ memory allocation has a small overhead of 40 bytes. So, for the
same reason as above, it ends to allocate 512, 64, 512 and 1024 (~2 ko).

All that said, defining these 4 arrays as part of 'struct applespi_data'
saves 2 ko of runtime memory.

3504 bytes are now requested, and 4096 really allocated. All these 4
arrays fit in the 'wasted' memory of the first allocation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/input/keyboard/applespi.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index fab5473ae5da..bee4ccfa2b05 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -373,11 +373,11 @@ struct applespi_data {
 	struct input_dev		*keyboard_input_dev;
 	struct input_dev		*touchpad_input_dev;
 
-	u8				*tx_buffer;
-	u8				*tx_status;
-	u8				*rx_buffer;
+	u8				tx_buffer[APPLESPI_PACKET_SIZE];
+	u8				tx_status[APPLESPI_STATUS_SIZE];
+	u8				rx_buffer[APPLESPI_PACKET_SIZE];
 
-	u8				*msg_buf;
+	u8				msg_buf[MAX_PKTS_PER_MSG * APPLESPI_PACKET_SIZE];
 	unsigned int			saved_msg_len;
 
 	struct applespi_tp_info		tp_info;
@@ -1659,21 +1659,6 @@ static int applespi_probe(struct spi_device *spi)
 	/* store the driver data */
 	spi_set_drvdata(spi, applespi);
 
-	/* create our buffers */
-	applespi->tx_buffer = devm_kmalloc(&spi->dev, APPLESPI_PACKET_SIZE,
-					   GFP_KERNEL);
-	applespi->tx_status = devm_kmalloc(&spi->dev, APPLESPI_STATUS_SIZE,
-					   GFP_KERNEL);
-	applespi->rx_buffer = devm_kmalloc(&spi->dev, APPLESPI_PACKET_SIZE,
-					   GFP_KERNEL);
-	applespi->msg_buf = devm_kmalloc_array(&spi->dev, MAX_PKTS_PER_MSG,
-					       APPLESPI_PACKET_SIZE,
-					       GFP_KERNEL);
-
-	if (!applespi->tx_buffer || !applespi->tx_status ||
-	    !applespi->rx_buffer || !applespi->msg_buf)
-		return -ENOMEM;
-
 	/* set up our spi messages */
 	applespi_setup_read_txfrs(applespi);
 	applespi_setup_write_txfrs(applespi);
-- 
2.34.1

