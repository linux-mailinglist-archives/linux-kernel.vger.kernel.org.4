Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3020B6ECA32
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjDXKVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjDXKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:47 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA1A3A90
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:20:45 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 8404E5EE57;
        Mon, 24 Apr 2023 12:35:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-z9Flm1CE;
        Mon, 24 Apr 2023 12:35:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328942;
        bh=K1BrJFARres8quvGFHRVDGGD0XFqhKg6JqfWlOl6IWw=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ZgzB4YwjgAjrXUb5wN89rYvQobvH0KISWKTeScRVSVTn29bGMW+oBR8/DNYxTVYCY
         DNnGeToeHxUtNeLITjsni9W4ljpNVZ65qJQZybU/QY/v0tdnGXVJcIJvysB6xWV/Z8
         yf9K1JDB4dwhtTJPEoT8ecqwsKjMjIZNZ0z6Wzh4=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/43] rtc: ep93xx: add DT support for Cirrus EP93xx
Date:   Mon, 24 Apr 2023 15:34:24 +0300
Message-Id: <20230424123522.18302-9-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Find register range from the device tree.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    Arnd Bergmann:
    - wildcards ep93xx to something meaningful, i.e. ep9301
    - drop wrappers

 drivers/rtc/rtc-ep93xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index acae7f16808f..8bda20a4940a 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/rtc.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gfp.h>
@@ -148,9 +149,16 @@ static int ep93xx_rtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(ep93xx_rtc->rtc);
 }
 
+static const struct of_device_id ep93xx_rtc_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-rtc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ep93xx_rtc_of_ids);
+
 static struct platform_driver ep93xx_rtc_driver = {
 	.driver		= {
 		.name	= "ep93xx-rtc",
+		.of_match_table = ep93xx_rtc_of_ids,
 	},
 	.probe		= ep93xx_rtc_probe,
 };
-- 
2.39.2

