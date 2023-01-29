Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5667FEC3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 13:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjA2MFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 07:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjA2MFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 07:05:12 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DA2234FC;
        Sun, 29 Jan 2023 04:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1674993891; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LiDIJ3Rmd36AtqhKNh3sjPZ+wGugz3vIRIvjOepxpSg=;
        b=jJ1s281Ict/W29rTi8nGIVpF/Vj/+9pxvN7t1X0FnNXwtM2kM90LY9uueI6Lgv7io7c0lk
        6WSjSrbaPGLjll1qfUG0uJsP08gyjg5vu/tePGTgyLgW5f9CjhKGJ9IAAFygK4wCf8jen1
        aKgrccczdD7zIsYnkbiKXKn74yIrvpU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        list@opendingux.net, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 2/4] rtc: jz4740: Use readl_poll_timeout
Date:   Sun, 29 Jan 2023 12:04:40 +0000
Message-Id: <20230129120442.22858-3-paul@crapouillou.net>
In-Reply-To: <20230129120442.22858-1-paul@crapouillou.net>
References: <20230129120442.22858-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use readl_poll_timeout() from <iopoll.h> instead of using custom poll
loops.

The timeout settings are different, but that shouldn't be much of a
problem. Instead of polling 10000 times in a close loop, it polls for
one millisecond.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/rtc/rtc-jz4740.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index c383719292c7..4ee6e5ee09b1 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -7,6 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -69,19 +70,15 @@ static inline uint32_t jz4740_rtc_reg_read(struct jz4740_rtc *rtc, size_t reg)
 static int jz4740_rtc_wait_write_ready(struct jz4740_rtc *rtc)
 {
 	uint32_t ctrl;
-	int timeout = 10000;
 
-	do {
-		ctrl = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CTRL);
-	} while (!(ctrl & JZ_RTC_CTRL_WRDY) && --timeout);
-
-	return timeout ? 0 : -EIO;
+	return readl_poll_timeout(rtc->base + JZ_REG_RTC_CTRL, ctrl,
+				  ctrl & JZ_RTC_CTRL_WRDY, 0, 1000);
 }
 
 static inline int jz4780_rtc_enable_write(struct jz4740_rtc *rtc)
 {
 	uint32_t ctrl;
-	int ret, timeout = 10000;
+	int ret;
 
 	ret = jz4740_rtc_wait_write_ready(rtc);
 	if (ret != 0)
@@ -89,11 +86,8 @@ static inline int jz4780_rtc_enable_write(struct jz4740_rtc *rtc)
 
 	writel(JZ_RTC_WENR_MAGIC, rtc->base + JZ_REG_RTC_WENR);
 
-	do {
-		ctrl = readl(rtc->base + JZ_REG_RTC_WENR);
-	} while (!(ctrl & JZ_RTC_WENR_WEN) && --timeout);
-
-	return timeout ? 0 : -EIO;
+	return readl_poll_timeout(rtc->base + JZ_REG_RTC_WENR, ctrl,
+				  ctrl & JZ_RTC_WENR_WEN, 0, 1000);
 }
 
 static inline int jz4740_rtc_reg_write(struct jz4740_rtc *rtc, size_t reg,
-- 
2.39.0

