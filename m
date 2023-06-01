Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E272D71925D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjFAFia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjFAFhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:37:48 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492C5134;
        Wed, 31 May 2023 22:37:10 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id CAC3C600D4;
        Thu,  1 Jun 2023 08:37:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OaGNfZvWv8c0-6hcLzyhA;
        Thu, 01 Jun 2023 08:37:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685597828;
        bh=R+Pz7YByYt2SATeGDLe/ccdxjieXmmvUqEMemvxyK3o=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=GE4qmciVDxM7OEXSzFXGcIiE537k0frwF7ZjWFt55Hd1bYs/DGl/p7zSrwRQoqtWT
         MlRuagrWKA6v6096m9Rwnx1B2UCEMyAVAQeCVhtuWL1ddPtb3rBLww2tWW34yZ/t/K
         lMwcGIeqid4xvnxfCKa3NxUbmxKYBzfp1Frhn6O4=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/43] rtc: ep93xx: add DT support for Cirrus EP93xx
Date:   Thu,  1 Jun 2023 08:34:02 +0300
Message-Id: <20230601053546.9574-12-nikita.shubin@maquefel.me>
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

Notes:
    v0 -> v1:
    
    - fixed headers

 drivers/rtc/rtc-ep93xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index acae7f16808f..1fdd20d01560 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -148,9 +149,16 @@ static int ep93xx_rtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(ep93xx_rtc->rtc);
 }
 
+static const struct of_device_id ep93xx_rtc_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-rtc" },
+	{ /* sentinel */ }
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
2.37.4

