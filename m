Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342F8688378
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjBBP4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjBBPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:55:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E82577D7;
        Thu,  2 Feb 2023 07:54:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D38D661C15;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A76CC43339;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353284;
        bh=4z6TJNCwS8qAM3wHcv2tU/0WELTPhAMwIRU/5y7TjEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qh5dBu/slxBr09UrqMCCaO8sXzUh9R9uvCf6cItFLgLlh6Jj0BXsq0A6G387FbrSG
         Nr+tx+5tIvoX3oPkaZDyo0Pif+uc8Bof5d4W0a59l+6Ov1ZJ0XWbb/aypd1P+ThrCk
         2/36sQr+yFuAfCVltzo64BdF6KxyCqiDgnPTGqvKifu0pV/YB+N61OBSZmBqb5M1d1
         b7sM5ouobpNKrHSUMjxb7Nf7IrXMqXRKKa6J32M33NQPe8x0m7q53l5AN/ljUQhb9q
         Z7GKzzC2RVEXwyppSm1XGw5DQppoZ8xNos8Jv5bBT4IG6LO5PY66gPGL5R4jeEsN3E
         NdlZ9soUZq/Cg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbvZ-0001m8-Cz; Thu, 02 Feb 2023 16:55:09 +0100
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
Subject: [PATCH v2 10/22] rtc: pm8xxx: rename alarm irq variable
Date:   Thu,  2 Feb 2023 16:54:36 +0100
Message-Id: <20230202155448.6715-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202155448.6715-1-johan+linaro@kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
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

