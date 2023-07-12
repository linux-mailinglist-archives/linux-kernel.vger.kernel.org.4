Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD20750646
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGLLif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGLLia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:38:30 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163F1FF9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=Lc4sa5FGc2Zv9bQCMcvCzN5cn0oZy93aSUCyZIixchQ=; b=deDZfe
        L+hfRpQ10A/KrZQcnU9x20j9gg9dZhwrbPZIAvEM7abQq38875+JoRulHgVP6dd7
        kxJchhDFJFIzHNRm2AlTkJ0RCBAkAjmDUOokXWR2F5kFeHLAdBr3CZA62XyL526u
        dWRQ+Jz3D4UTDIvv5N68Ww2stMmEV0+OTa8LnFBwADBQ7dZ9RaPbbgGYhvY4XLU3
        d2Kadb1gr5dJkUumElSHhlUPdSyM1Voia3jMYJkaqBBhhToKmUqwabzFZw8SEezo
        HfckxB7OSX1Y93HIlZL8P87p7VN1Rz5kLCJjk0/4G4Q1EurPMjQ6qc8yotZTTYYs
        EhPSTB9nY307YYpw==
Received: (qmail 1596861 invoked from network); 12 Jul 2023 13:37:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2023 13:37:45 +0200
X-UD-Smtp-Session: l3s3148p1@Ubf3pEgAXqUujnvL
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] gnss: ubx: add support for the reset gpio
Date:   Wed, 12 Jul 2023 13:37:31 +0200
Message-Id: <20230712113731.3306-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230712113731.3306-1-wsa+renesas@sang-engineering.com>
References: <20230712113731.3306-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with a Renesas KingFisher board. Because my GNSS device is hooked
up via UART and I2C simultaneously, I could verify functionality by
opening/closing the GNSS device using UART and see if the corresponding
I2C device was visible on the bus.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gnss/ubx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index 9b76b101ba5e..cb0612100644 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -7,6 +7,7 @@
 
 #include <linux/errno.h>
 #include <linux/gnss.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -18,6 +19,7 @@
 
 struct ubx_data {
 	struct regulator *vcc;
+	struct gpio_desc *reset_gpio;
 };
 
 static int ubx_set_active(struct gnss_serial *gserial)
@@ -29,6 +31,8 @@ static int ubx_set_active(struct gnss_serial *gserial)
 	if (ret)
 		return ret;
 
+	gpiod_set_value_cansleep(data->reset_gpio, 0);
+
 	return 0;
 }
 
@@ -41,6 +45,8 @@ static int ubx_set_standby(struct gnss_serial *gserial)
 	if (ret)
 		return ret;
 
+	gpiod_set_value_cansleep(data->reset_gpio, 1);
+
 	return 0;
 }
 
@@ -90,6 +96,13 @@ static int ubx_probe(struct serdev_device *serdev)
 	if (ret < 0 && ret != -ENODEV)
 		goto err_free_gserial;
 
+	/* Start with reset asserted (GPIO must be active low!) */
+	data->reset_gpio = devm_gpiod_get_optional(&serdev->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio)) {
+		ret = PTR_ERR(data->reset_gpio);
+		goto err_free_gserial;
+	}
+
 	ret = gnss_serial_register(gserial);
 	if (ret)
 		goto err_free_gserial;
-- 
2.30.2

