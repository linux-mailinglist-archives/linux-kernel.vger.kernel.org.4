Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73C8611DC7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJ1W4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJ1Wzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:55:55 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2BA1EF06D;
        Fri, 28 Oct 2022 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666997728; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VRHSnhFqlAbB4ByXHkBp5FSSjtyBVVmk/Lv0SwF9ti8=;
        b=ok9Fs3gbFSdHNylRdcL+uco+GLwquJAiuljCCeoCxNdupA9Q+12Aj8bhmYqlOMAgHfFRAW
        xaBoP5hpECfimN0t+gXSLjp8ifJz5rqSdEQ/tASvC1Zf+1evUBlMdocy03o2CCEhESbKHj
        YRPqJANJ3ZQpMI1BvgxcNloqgQGOUk8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        od@opendingux.net, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/4] rtc: jz4740: Use readl_poll_timeout
Date:   Fri, 28 Oct 2022 23:55:17 +0100
Message-Id: <20221028225519.89210-3-paul@crapouillou.net>
In-Reply-To: <20221028225519.89210-1-paul@crapouillou.net>
References: <20221028225519.89210-1-paul@crapouillou.net>
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
2.35.1

