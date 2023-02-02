Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C491688347
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjBBPzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjBBPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:54:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E16627A4;
        Thu,  2 Feb 2023 07:54:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 261F6B826EB;
        Thu,  2 Feb 2023 15:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4295DC4332E;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353284;
        bh=BIFSHNu7yn057HMpG1CPNyOgFjAwXeeB7J7A6POE7cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzxX3nfGwZ7p8tXidN01RVDtuTSz5/MgLrTq3B2l6z6GzPp7WbwQP6wKrRaEhUuER
         jftOOww2eRpQEVVJizT6CXXIZRO6gppN2LwuIfUK6g84kKNpLysN4HZyxTBSMCkpsX
         swOwUoArFEms4oDczCKvH/C3I+/FKCCb6RvwYXDB33gCCRSYWWuApV3osoiRfDw0jH
         jcPktUK/9VLji799waJO9dOgTyiFRMcaM34JcvmfXhM8xY2GYKPNJkda0mHmxGuRe3
         sLd5+11eu2MgIiuv6bqeNte5+lrnwI0k0KXZq1knh2oFiDTqKPCW49PHbY9BoMB35C
         l+Tb9OkCmmxNQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbvZ-0001m2-6s; Thu, 02 Feb 2023 16:55:09 +0100
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
Subject: [PATCH v2 08/22] rtc: pm8xxx: clean up time and alarm debugging
Date:   Thu,  2 Feb 2023 16:54:34 +0100
Message-Id: <20230202155448.6715-9-johan+linaro@kernel.org>
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

Clean up the time and alarm callback debugging by using a consistent and
succinct human-readable (i.e. non-raw) format.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 5ff6898bcace..8c364e5d3b57 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -83,7 +83,7 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	secs = rtc_tm_to_time64(tm);
 	put_unaligned_le32(secs, value);
 
-	dev_dbg(dev, "Seconds value to be written to RTC = %lu\n", secs);
+	dev_dbg(dev, "set time: %ptRd %ptRt (%lu)\n", tm, tm, secs);
 
 	rc = regmap_update_bits_check(rtc_dd->regmap, regs->alarm_ctrl,
 				      regs->alarm_en, 0, &alarm_enabled);
@@ -158,7 +158,7 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	secs = get_unaligned_le32(value);
 	rtc_time64_to_tm(secs, tm);
 
-	dev_dbg(dev, "secs = %lu, h:m:s == %ptRt, y-m-d = %ptRdr\n", secs, tm, tm);
+	dev_dbg(dev, "read time: %ptRd %ptRt (%lu)\n", tm, tm, secs);
 
 	return 0;
 }
@@ -191,8 +191,7 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 			return rc;
 	}
 
-	dev_dbg(dev, "Alarm Set for h:m:s=%ptRt, y-m-d=%ptRdr\n",
-		&alarm->time, &alarm->time);
+	dev_dbg(dev, "set alarm: %ptRd %ptRt\n", &alarm->time, &alarm->time);
 
 	return 0;
 }
@@ -220,8 +219,7 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	alarm->enabled = !!(ctrl_reg & PM8xxx_RTC_ALARM_ENABLE);
 
-	dev_dbg(dev, "Alarm set for - h:m:s=%ptRt, y-m-d=%ptRdr\n",
-		&alarm->time, &alarm->time);
+	dev_dbg(dev, "read alarm: %ptRd %ptRt\n", &alarm->time, &alarm->time);
 
 	return 0;
 }
-- 
2.39.1

