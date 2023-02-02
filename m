Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396F6688363
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjBBPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjBBPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:55:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215E35CD0B;
        Thu,  2 Feb 2023 07:54:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA6861C27;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09F4C432C6;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353284;
        bh=g8tBszJ6bi4ZqUD9po9Mp1LVkFHLLnMzDqeejdkoUk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P55b/Nb7HMpX1HIFOXjNsKr9ri1eGohcOuaCvwmn6fFj2xDCAhe9J4Lr4JsRuiINH
         jaDkhylrXVKdZrOAWn5HOmupo37BON/+YT4jCMonLSvLVjiGwO7tIGei8teShgzxWB
         w5/1qqOwewzHXhjwr+LBe4RgRHvkoYnpuT20kfBaMg97Fk8CUeOySuSgo5zP9MuF5W
         AqgM9ldbZw028+t2+bV8ACFxTQTCVP3ORVpABKPfaaoaKw6N6+cNRcKIkN1VtnUuFc
         eJXqxiHYUETZTnM4o1CV0Jw2WkQjAtNf1+qHMbvAkWXanlyrWscuKxvQPQvbkOsyrB
         +7/ETvwswxC4w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbvZ-0001mO-RS; Thu, 02 Feb 2023 16:55:09 +0100
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
Subject: [PATCH v2 15/22] rtc: pm8xxx: drop error messages
Date:   Thu,  2 Feb 2023 16:54:41 +0100
Message-Id: <20230202155448.6715-16-johan+linaro@kernel.org>
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

For consistency with the rest of the driver, drop the last two error
messages for conditions that should only occur during development, if
ever.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 922aef0f0241..eff2782beeed 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -368,10 +368,8 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	rtc_dd->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!rtc_dd->regmap) {
-		dev_err(&pdev->dev, "Parent regmap unavailable.\n");
+	if (!rtc_dd->regmap)
 		return -ENXIO;
-	}
 
 	rtc_dd->alarm_irq = platform_get_irq(pdev, 0);
 	if (rtc_dd->alarm_irq < 0)
@@ -402,10 +400,8 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 					  pm8xxx_alarm_trigger,
 					  IRQF_TRIGGER_RISING,
 					  "pm8xxx_rtc_alarm", rtc_dd);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "Request IRQ failed (%d)\n", rc);
+	if (rc < 0)
 		return rc;
-	}
 
 	rc = devm_rtc_register_device(rtc_dd->rtc);
 	if (rc)
-- 
2.39.1

