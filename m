Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCAA67CDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjAZOXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjAZOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2A01D91F;
        Thu, 26 Jan 2023 06:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C5A4B81DF0;
        Thu, 26 Jan 2023 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E2BC43324;
        Thu, 26 Jan 2023 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742977;
        bh=7/HQf6/GGIuDaxy+2slvzMSyzdgxzdXhyFV520wU3YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uAOGAGpNA3ePLe//qEtVZpQq7P/FHcAbDUvjWAtzzuqXNaCArPvXkWSXv4AloYJJ0
         YzzqlF1q8GUUQITiqe8Z/C9qm/BANog3AMA33CIBYVs27E94yId7Uk940ZdvOS7TCR
         4FKq61ydVoO39kvuepnXVxJjtc6zasLIr/1N8P18jfCUH5vfzJYfHr7h8y6AHgZbtN
         9BMXsHFD39o3Hie9tOBN7G+Y6WcZ/8I1n6PuE4c3S3kj4jpSwkUx9EUOvQGaHwrsJ9
         XNkt9vwwIFraChOyUCXCozyp/z7KHBAAPSo2p4Fe/0y2W2xco+qIsGW92b2CiENBL6
         /rzdMAa4SpaIQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39c-0006iZ-OG; Thu, 26 Jan 2023 15:23:04 +0100
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
Subject: [PATCH 09/24] rtc: pm8xxx: rename struct device pointer
Date:   Thu, 26 Jan 2023 15:20:42 +0100
Message-Id: <20230126142057.25715-10-johan+linaro@kernel.org>
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

