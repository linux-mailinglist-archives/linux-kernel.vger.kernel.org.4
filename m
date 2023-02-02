Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B097168835A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjBBPzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjBBPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:55:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E495577F6;
        Thu,  2 Feb 2023 07:54:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7008661BFB;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6287EC43338;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353284;
        bh=7/HQf6/GGIuDaxy+2slvzMSyzdgxzdXhyFV520wU3YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJzTdqIZXIlvmVR/OG0Ij6Nzr8P8yBUVfz7LIT8FB6GHZJhA40nisoNQy6d3mGjFb
         HAUWZq+bBnqSBEotjQYUA++ZulXl9YMfYhM4lkpa+Ssy7UhnFZgsB6HzZTPru/h6no
         8PRL5UTiGmA8axJW/n3TYKelMf0jjGw+j9hU4omWmxf++90d553j/QbfvMfnuoxMbF
         8DrDv6wpUTYm42TUVTbwpydStIdfoFh9rr/8D6LKJnP1cpwMsD/vvrB90je1ncSkSt
         VmzIbWQV3NnLs7AAvnPHdSoT4Gklx0fwsISC9YWjaVKObvWALafXTvChdxWifQQ2c+
         WBofxa1x1uQXg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbvZ-0001m5-A5; Thu, 02 Feb 2023 16:55:09 +0100
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
Subject: [PATCH v2 09/22] rtc: pm8xxx: rename struct device pointer
Date:   Thu,  2 Feb 2023 16:54:35 +0100
Message-Id: <20230202155448.6715-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202155448.6715-1-johan+linaro@kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the driver-data struct device pointer by dropping the "rtc"
prefix which is both redundant and misleading (as this is a pointer to
the platform device and not the rtc class device).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 8c364e5d3b57..0fdbd233b10e 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -48,7 +48,7 @@ struct pm8xxx_rtc_regs {
  * @allow_set_time:	indicates whether writing to the RTC is allowed
  * @rtc_alarm_irq:	rtc alarm irq number.
  * @regs:		rtc registers description.
- * @rtc_dev:		device structure.
+ * @dev:		device structure
  */
 struct pm8xxx_rtc {
 	struct rtc_device *rtc;
@@ -56,7 +56,7 @@ struct pm8xxx_rtc {
 	bool allow_set_time;
 	int rtc_alarm_irq;
 	const struct pm8xxx_rtc_regs *regs;
-	struct device *rtc_dev;
+	struct device *dev;
 };
 
 /*
@@ -372,7 +372,7 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 						      "allow-set-time");
 
 	rtc_dd->regs = match->data;
-	rtc_dd->rtc_dev = &pdev->dev;
+	rtc_dd->dev = &pdev->dev;
 
 	rc = pm8xxx_rtc_enable(rtc_dd);
 	if (rc)
-- 
2.39.1

