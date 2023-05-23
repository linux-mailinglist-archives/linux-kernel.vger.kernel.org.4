Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C690170D430
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjEWGnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjEWGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:43:26 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AB3130
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=q/5GtK2jKYSsTw
        9UU1qmAu6KvhIyFjfDhl1+EC7gwzU=; b=EmcpTr1H+9yVuwGiTaYLAplUwiyGAA
        xAyvjt24R5noeLwW9G3GR3bHJYTgNp1s3rqDMxD6StyDrK08F6AZd9k7/HV86E98
        pcgzejYczVFBEC2AGCY+PMoE+HMVHfbyicz8w1/BsiTSrZ+Mc/LKifB+sJnj1QX/
        A9RPf2MFGLk9c=
Received: (qmail 2628284 invoked from network); 23 May 2023 08:43:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 May 2023 08:43:22 +0200
X-UD-Smtp-Session: l3s3148p1@J1sZtFb8DMkujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 4/5] gnss: ubx: add support for the reset gpio
Date:   Tue, 23 May 2023 08:43:09 +0200
Message-Id: <20230523064310.3005-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with a Renesas KingFisher board. The chip correctly disappears
from the I2C bus when the 'gnss0' device is not opened.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gnss/ubx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index d5281bfae9cb..be393b123d9a 100644
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
@@ -31,6 +33,8 @@ static int ubx_set_active(struct gnss_serial *gserial)
 			return ret;
 	}
 
+	gpiod_set_value_cansleep(data->reset_gpio, 0);
+
 	return 0;
 }
 
@@ -45,6 +49,8 @@ static int ubx_set_standby(struct gnss_serial *gserial)
 			return ret;
 	}
 
+	gpiod_set_value_cansleep(data->reset_gpio, 1);
+
 	return 0;
 }
 
@@ -116,6 +122,11 @@ static int ubx_probe(struct serdev_device *serdev)
 	if (ret < 0 && ret != -ENODEV)
 		goto err_free_gserial;
 
+	/* Start with reset asserted (GPIO must be active low!) */
+	data->reset_gpio = devm_gpiod_get_optional(&serdev->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio))
+		return PTR_ERR(data->reset_gpio);
+
 	ret = gnss_serial_register(gserial);
 	if (ret)
 		goto err_free_gserial;
-- 
2.35.1

