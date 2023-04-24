Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D406ECA20
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDXKU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjDXKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:41 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF2D1FE2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:20:39 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 0235D5EEC3;
        Mon, 24 Apr 2023 12:36:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-5B6DOfTV;
        Mon, 24 Apr 2023 12:36:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328962;
        bh=dvHbRWEIIPXMemHUevxLrNBPqJlxXPnkd3R644ugivQ=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=n+rtBGxIG41mLHbLhfdtmpsbVLo8Dt1ufiEtSoVEm32SWm/R6+Sd9IL/K4N67bx0V
         dvUpDQ6NoqfDN2d59qaYRn6l15lHXV2Fo3xlrVerlzr29Tn0VwMrWLmHxjroxV4bDM
         t2EKGFiaApUgtJTXLyvlFAlyypH/9zBn7ZbeA15Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/43] rtc: m48t86: add DT support for m48t86
Date:   Mon, 24 Apr 2023 15:34:45 +0300
Message-Id: <20230424123522.18302-30-nikita.shubin@maquefel.me>
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

- get regs from device tree

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/rtc/rtc-m48t86.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 481c9525b1dd..d65727ac283a 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/bcd.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #define M48T86_SEC		0x00
 #define M48T86_SECALRM		0x01
@@ -269,9 +270,18 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id m48t86_rtc_of_ids[] = {
+	{ .compatible = "dallas,rtc-m48t86" },
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, m48t86_rtc_of_ids);
+#endif
+
 static struct platform_driver m48t86_rtc_platform_driver = {
 	.driver		= {
 		.name	= "rtc-m48t86",
+		.of_match_table = of_match_ptr(m48t86_rtc_of_ids),
 	},
 	.probe		= m48t86_rtc_probe,
 };
-- 
2.39.2

