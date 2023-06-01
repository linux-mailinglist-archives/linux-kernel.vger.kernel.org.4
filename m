Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FA7192A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjFAFrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjFAFq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:46:58 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B3A10DD;
        Wed, 31 May 2023 22:46:27 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id B2EE546CDA;
        Thu,  1 Jun 2023 08:46:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-zieECyhD;
        Thu, 01 Jun 2023 08:46:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598383;
        bh=A2FiCkys0aL7RsfnhMzn1bmYZGGoisuSld30oU2VX3Y=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=EGnOrp8PGQbb0MIsNhPKsLwLUhMbmVl3+0qqeLSb8CnN70PT7cedgH9vXG3cUAy5S
         ywUAmMZmEPQRyKd/YdocZXnzEhbhpxWbex5FH1v66MQRNg5Gt43OgJhnios1RHqtDU
         EgOEazSLyLprVQ4MLtjcEKXoR34rnUWr85ExNwTk=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 34/43] gpio: ep93xx: add DT support for gpio-ep93xx
Date:   Thu,  1 Jun 2023 08:45:39 +0300
Message-Id: <20230601054549.10843-16-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add match table.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    
    - dropped coma in id table

 drivers/gpio/gpio-ep93xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index ca508c7c4f2f..5e328e4411cc 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -363,9 +363,15 @@ static int ep93xx_gpio_probe(struct platform_device *pdev)
 	return devm_gpiochip_add_data(&pdev->dev, gc, egc);
 }
 
+static const struct of_device_id ep93xx_gpio_match[] = {
+	{ .compatible = "cirrus,ep9301-gpio" },
+	{ /* sentinel */ }
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
2.37.4

