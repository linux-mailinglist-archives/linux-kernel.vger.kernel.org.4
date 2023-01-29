Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1001967FEC7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 13:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjA2MFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 07:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjA2MFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 07:05:34 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F71B2387A;
        Sun, 29 Jan 2023 04:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1674993892; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1IJEsvKeYpQS+dvslB9I/8U3h0z6+5xQ1oLdzzjDbQ=;
        b=W0tsFp8DSSdHO+HZYZOczWMTpPIP7pMkBmkmO4HCPDaKx6UGLn1X2MyK5lj3Sd4F6bS32f
        tMnQJShDR9Ed6rW7t83VL6LKJn9aYfwiOmjO8OfSnCOlbVqERIo+TwNnqZNMw4JpFEiUSc
        wHJMmggog9HXeXAvGzo/AxsUYBGvwC8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        list@opendingux.net, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 3/4] rtc: jz4740: Use dev_err_probe()
Date:   Sun, 29 Jan 2023 12:04:41 +0000
Message-Id: <20230129120442.22858-4-paul@crapouillou.net>
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

Use dev_err_probe() where it makes sense to simplify a bit the code.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/rtc/rtc-jz4740.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 4ee6e5ee09b1..9ffa764aa71e 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -329,17 +329,13 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	device_init_wakeup(dev, 1);
 
 	ret = dev_pm_set_wake_irq(dev, irq);
-	if (ret) {
-		dev_err(dev, "Failed to set wake irq: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set wake irq\n");
 
 	rtc->rtc = devm_rtc_allocate_device(dev);
-	if (IS_ERR(rtc->rtc)) {
-		ret = PTR_ERR(rtc->rtc);
-		dev_err(dev, "Failed to allocate rtc device: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(rtc->rtc))
+		return dev_err_probe(dev, PTR_ERR(rtc->rtc),
+				     "Failed to allocate rtc device\n");
 
 	rtc->rtc->ops = &jz4740_rtc_ops;
 	rtc->rtc->range_max = U32_MAX;
@@ -356,10 +352,8 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq, jz4740_rtc_irq, 0,
 			       pdev->name, rtc);
-	if (ret) {
-		dev_err(dev, "Failed to request rtc irq: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request rtc irq\n");
 
 	if (of_device_is_system_power_controller(np)) {
 		dev_for_power_off = dev;
-- 
2.39.0

