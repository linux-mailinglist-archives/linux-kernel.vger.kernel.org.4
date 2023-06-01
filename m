Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B6B719261
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjFAFii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjFAFiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:38:14 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F211A7;
        Wed, 31 May 2023 22:37:18 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id B0F66600D1;
        Thu,  1 Jun 2023 08:37:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OaGNfZvWv8c0-ru09HF4J;
        Thu, 01 Jun 2023 08:37:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685597831;
        bh=nCmh1471Kw/0ZT+tYC9QuJaR7Yngw3kQYxKNh7LKQTQ=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Pr2sG/5cTKRaLxieVR5g5bdTsoLk6KGlrNpkQSWrHeqPvphrFzBHAH7LTeYb5nSKo
         rJvEIz/8x7rNVMCDuJ8qW4/QWsYVF/OFHEpLTt3wpLv17cRuP2dWIHfxBRoDbQVZnL
         Xgpul3zViS+czi+omJA7yt27bfrMiHZXW+GLecTM=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/43] watchdog: ep93xx: add DT support for Cirrus EP93xx
Date:   Thu,  1 Jun 2023 08:34:04 +0300
Message-Id: <20230601053546.9574-14-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Find register range from the device tree.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/watchdog/ep93xx_wdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 38e26f160b9a..088b88aad94f 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -21,6 +21,7 @@
  * daemon dies.
  */
 
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/watchdog.h>
@@ -130,9 +131,16 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_wdt_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-wdt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_wdt_of_ids);
+
 static struct platform_driver ep93xx_wdt_driver = {
 	.driver		= {
 		.name	= "ep93xx-wdt",
+		.of_match_table = ep93xx_wdt_of_ids,
 	},
 	.probe		= ep93xx_wdt_probe,
 };
-- 
2.37.4

