Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D7A619E4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiKDRQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiKDRQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:16:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D52B32BA7;
        Fri,  4 Nov 2022 10:16:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z26so5082329pff.1;
        Fri, 04 Nov 2022 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz0y0NUNkUf+PsJYRPU+aqv8faUzWDQk/DO9G90XRKo=;
        b=Z3ID3+fUilwpptQbakP1Bw3RkXXb6Z6uBwK9oPN9nqBEAh1/6XDg03a6BlcSasoJh9
         gYa4XkYDTSIm4NCKqnkv41e7VwaffKXipVy4PsCcn+xtKt4XM8yg0TSG8/JkUaio/0ND
         ldix8oj7sZQDc3y7Z8qdwu92XziPcWSMdfJWwmadqK3F0ngSiAAOgXGoaPhh41RW8W8y
         xyete8ujLnU9jve0QgEtnHjRoEfDnLBv3BBDB0dAyBOwDkNWs+q27BbHYc1rb2HJ8Epd
         3+8yHxzdRRwsLZjt6DJWoL0BVuTj7zSU0P6Z/8GkXSjUVTxfbmgDuouyKPpHVtMw5vqg
         lrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xz0y0NUNkUf+PsJYRPU+aqv8faUzWDQk/DO9G90XRKo=;
        b=uP1bi2Eptrr7q0NS8zMrrQDJeAuyAEsbqeN7w/Az0XNFQFNvQP/g+qYFgFaZIACYyF
         w1l0+F9S6sXaiP6x/ch658gLtLUwKqS1tkYOdny/Y8rRxXT4F3KcCkaziegb0/SnQyOq
         /yko1escrKAP1rV/rSWGikpQAZU+Zfo/cXJy5sG650DO4ekXLzDMqg25pXyn79w8lP9v
         URz1dEpfWDLHZK9VYuRr6Oo8PCnKjR0oZBQQYTOepKeGJO6W39hnkX9uiUloCCknJef5
         mWjn2kGVsBcSrcTVzqGuCO9FIimBdRiTCFngkGKA71nRQpWQ4IXTa4OToMbSyj+X78/h
         sWHg==
X-Gm-Message-State: ACrzQf3N4eWcq158xXthjP4rgW52/Ukeos3TC6n5TVFXhVRXpZHqt+70
        bZwWbpbNJ6zWDTVAgaHKKuTXrSm1Ijw=
X-Google-Smtp-Source: AMsMyM5d/ovbRY9EV1vKTdycQP8C9Q3zhLDFha9/KS6ksS9Lysb3v+4Os2GQdL22ju5cT9yitMbRdA==
X-Received: by 2002:a63:e348:0:b0:46f:25cc:d554 with SMTP id o8-20020a63e348000000b0046f25ccd554mr32095610pgj.598.1667582201901;
        Fri, 04 Nov 2022 10:16:41 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090a450f00b00212c27abcaesm1917655pjg.17.2022.11.04.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:16:41 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 2/3] can: etas_es58x: use usb_cache_string() to retrieve the product info string
Date:   Sat,  5 Nov 2022 02:16:03 +0900
Message-Id: <20221104171604.24052-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of allocating memory ourselves and doing all the error
handling, rely on usb_cache_string(). This results in simpler code.

Make es58x_get_product_info() return void. The reason is double:

  1/ by using usb_cache_string() we do not know anymore the root cause
     (is it an allocation issue or input/output issue?)

  2/ Failling to get the product info is not critical. So it is OK to
     continue.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 33 +++------------------
 drivers/net/can/usb/etas_es58x/es58x_core.h |  3 ++
 2 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 51294b717040..1a17aadfc1dc 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -2124,41 +2124,18 @@ static void es58x_free_netdevs(struct es58x_device *es58x_dev)
  * @es58x_dev: ES58X device.
  *
  * Do a synchronous call to get the product information.
- *
- * Return: zero on success, errno when any error occurs.
  */
-static int es58x_get_product_info(struct es58x_device *es58x_dev)
+static void es58x_get_product_info(struct es58x_device *es58x_dev)
 {
-	struct usb_device *udev = es58x_dev->udev;
-	const int es58x_prod_info_idx = 6;
-	/* Empirical tests show a prod_info length of maximum 83,
-	 * below should be more than enough.
-	 */
-	const size_t prod_info_len = 127;
 	char *prod_info;
-	int ret;
 
-	prod_info = kmalloc(prod_info_len, GFP_KERNEL);
+	prod_info = usb_cache_string(es58x_dev->udev, ES58X_PROD_INFO_IDX);
 	if (!prod_info)
-		return -ENOMEM;
+		return;
 
-	ret = usb_string(udev, es58x_prod_info_idx, prod_info, prod_info_len);
-	if (ret < 0) {
-		dev_err(es58x_dev->dev,
-			"%s: Could not read the product info: %pe\n",
-			__func__, ERR_PTR(ret));
-		goto out_free;
-	}
-	if (ret >= prod_info_len - 1) {
-		dev_warn(es58x_dev->dev,
-			 "%s: Buffer is too small, result might be truncated\n",
-			 __func__);
-	}
 	dev_info(es58x_dev->dev, "Product info: %s\n", prod_info);
 
- out_free:
 	kfree(prod_info);
-	return ret < 0 ? ret : 0;
 }
 
 /**
@@ -2243,9 +2220,7 @@ static int es58x_probe(struct usb_interface *intf,
 	if (IS_ERR(es58x_dev))
 		return PTR_ERR(es58x_dev);
 
-	ret = es58x_get_product_info(es58x_dev);
-	if (ret)
-		return ret;
+	es58x_get_product_info(es58x_dev);
 
 	for (ch_idx = 0; ch_idx < es58x_dev->num_can_ch; ch_idx++) {
 		ret = es58x_init_netdev(es58x_dev, ch_idx);
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index 640fe0a1df63..9a5a616df783 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
@@ -49,6 +49,9 @@
 /* A magic number sent by the ES581.4 to inform it is alive. */
 #define ES58X_HEARTBEAT 0x11
 
+/* USB descriptor index containing the product information string. */
+#define ES58X_PROD_INFO_IDX 6
+
 /**
  * enum es58x_driver_info - Quirks of the device.
  * @ES58X_DUAL_CHANNEL: Device has two CAN channels. If this flag is
-- 
2.37.4

