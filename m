Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F168F6ECA3D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjDXKWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjDXKVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:21:19 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAB2421D;
        Mon, 24 Apr 2023 03:20:51 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id D17C55EBE5;
        Mon, 24 Apr 2023 12:36:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-lLqFUc6B;
        Mon, 24 Apr 2023 12:36:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328965;
        bh=SSxwu9lthPZqqdCdgmUMEpmuMngqWwft96CtvBOzvls=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=IuJ/8EyOB6yEznRSkx495zMeYi3Zv5PWv9VH+KP2hzAdLbpnvPj54Wuy/8PEFl4DX
         W5suv33jnqg0C4wohVHpD0vAaziUKEpEoNSblbyTPCjjtw+LGKFizw80DJb4gpav9h
         R/WqKa+yioPnhnOU7RHbH0ZIWkja/2ofEOfxd/0g=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 33/43] gpio: ep93xx: add DT support for gpio-ep93xx
Date:   Mon, 24 Apr 2023 15:34:49 +0300
Message-Id: <20230424123522.18302-34-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add match table.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/gpio/gpio-ep93xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index ca508c7c4f2f..4e3d01fab012 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -363,9 +363,15 @@ static int ep93xx_gpio_probe(struct platform_device *pdev)
 	return devm_gpiochip_add_data(&pdev->dev, gc, egc);
 }
 
+static const struct of_device_id ep93xx_gpio_match[] = {
+	{ .compatible = "cirrus,ep9301-gpio" },
+	{ /* end of table */ },
+};
+
 static struct platform_driver ep93xx_gpio_driver = {
 	.driver		= {
 		.name	= "gpio-ep93xx",
+		.of_match_table = ep93xx_gpio_match,
 	},
 	.probe		= ep93xx_gpio_probe,
 };
-- 
2.39.2

