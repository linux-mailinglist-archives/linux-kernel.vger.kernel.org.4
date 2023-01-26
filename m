Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F7D67CDF4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjAZOXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjAZOXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ADB34021;
        Thu, 26 Jan 2023 06:23:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AE43B81DF5;
        Thu, 26 Jan 2023 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EDDC43339;
        Thu, 26 Jan 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742978;
        bh=4z6TJNCwS8qAM3wHcv2tU/0WELTPhAMwIRU/5y7TjEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBQT9bNAxaKz3msJlHyveDXtH9yd1HKLE5fDUuw8OD2p7etlbFJPb2qRBztfKhuYF
         rUxQClpzfTQaRpRQa4CSoCp9T/Wl93TVXapwPn+FYBuONDOb74X6RIN37Fj8oD++SG
         z1AsFAaBUmD783R10QNTVWZR21BwgdyEKS2dZ+oJ9W4IdWROZ/zEDqU8rSj7BqzI7L
         qGMmjB/v+QqBKj+Up2tC8YiraDoyW0uzoh34MjZN9+L4RcytiIPb9vaft6pSNNhYFD
         MEbIBK4TO9YL3rH86ppK60lMlB3mW5w1p1Juu/hqcVjinkWL0oREeZXJ1JXegeCHok
         wi4F9K1A1yubA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39c-0006id-RQ; Thu, 26 Jan 2023 15:23:04 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 10/24] rtc: pm8xxx: rename alarm irq variable
Date:   Thu, 26 Jan 2023 15:20:43 +0100
Message-Id: <20230126142057.25715-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126142057.25715-1-johan+linaro@kernel.org>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the driver somewhat by renaming the driver-data alarm irq
variable by dropping the redundant "rtc" prefix.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 0fdbd233b10e..ea867b20573a 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -46,7 +46,7 @@ struct pm8xxx_rtc_regs {
  * @rtc:		rtc device for this driver.
  * @regmap:		regmap used to access RTC registers
  * @allow_set_time:	indicates whether writing to the RTC is allowed
- * @rtc_alarm_irq:	rtc alarm irq number.
+ * @alarm_irq:		alarm irq number
  * @regs:		rtc registers description.
  * @dev:		device structure
  */
@@ -54,7 +54,7 @@ struct pm8xxx_rtc {
 	struct rtc_device *rtc;
 	struct regmap *regmap;
 	bool allow_set_time;
-	int rtc_alarm_irq;
+	int alarm_irq;
 	const struct pm8xxx_rtc_regs *regs;
 	struct device *dev;
 };
@@ -364,8 +364,8 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	rtc_dd->rtc_alarm_irq = platform_get_irq(pdev, 0);
-	if (rtc_dd->rtc_alarm_irq < 0)
+	rtc_dd->alarm_irq = platform_get_irq(pdev, 0);
+	if (rtc_dd->alarm_irq < 0)
 		return -ENXIO;
 
 	rtc_dd->allow_set_time = of_property_read_bool(pdev->dev.of_node,
@@ -391,7 +391,7 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	rtc_dd->rtc->range_max = U32_MAX;
 
 	/* Request the alarm IRQ */
-	rc = devm_request_any_context_irq(&pdev->dev, rtc_dd->rtc_alarm_irq,
+	rc = devm_request_any_context_irq(&pdev->dev, rtc_dd->alarm_irq,
 					  pm8xxx_alarm_trigger,
 					  IRQF_TRIGGER_RISING,
 					  "pm8xxx_rtc_alarm", rtc_dd);
@@ -404,7 +404,7 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->rtc_alarm_irq);
+	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
 	if (rc)
 		return rc;
 
-- 
2.39.1

