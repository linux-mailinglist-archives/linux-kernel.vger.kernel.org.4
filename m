Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A25368835B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjBBPzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjBBPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:55:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBF75B5A0;
        Thu,  2 Feb 2023 07:54:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F09261C1E;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C482EC432C7;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353284;
        bh=yUxC+lcXB5W9v1WZ5zrNhza/r9HK2s/OODdAQcbHFZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKObcNEIEPhKQIDK+uz2luC8aS2ZWIRbEr5hN9/iaaime389ecby/61WVGLPQ5ixm
         gfnu1bCjykYRQxEQKRjGet84WK74OEK+nDYyyjeTihSrRGrPhOmOPulfenY5oPsI9s
         hEFuuY0FuhWHziQi6hKfjYAJF3Rr6rC3za1Oz6u7xcPcEp+3BeDLCZ6R1f6jmXtHDP
         8Vzgtrw06kfAcFMOp7uHJ96MSenZQBRij4NOVkOX3Zm9WV/GO/2N2/jUHcBnOiFFjw
         IL7sOrmD1rvDTcr4pbqm4gBjzD4b5ofBAfLYDxpfTULAQ3kRDddKlhZdvppEDGIZRf
         Bfo/gLVoEHRTg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbvZ-0001mH-MO; Thu, 02 Feb 2023 16:55:09 +0100
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
Subject: [PATCH v2 13/22] rtc: pm8xxx: refactor read_time()
Date:   Thu,  2 Feb 2023 16:54:39 +0100
Message-Id: <20230202155448.6715-14-johan+linaro@kernel.org>
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

In preparation for adding support for setting the time by means of an
externally stored offset, refactor read_time() by adding a new helper
that can be used to retrieve the raw time as stored in the RTC.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 54 ++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index b1ce246c501a..2f96a178595c 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -59,6 +59,37 @@ struct pm8xxx_rtc {
 	struct device *dev;
 };
 
+static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
+{
+	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
+	u8 value[NUM_8_BIT_RTC_REGS];
+	unsigned int reg;
+	int rc;
+
+	rc = regmap_bulk_read(rtc_dd->regmap, regs->read, value, sizeof(value));
+	if (rc)
+		return rc;
+
+	/*
+	 * Read the LSB again and check if there has been a carry over.
+	 * If there has, redo the read operation.
+	 */
+	rc = regmap_read(rtc_dd->regmap, regs->read, &reg);
+	if (rc < 0)
+		return rc;
+
+	if (reg < value[0]) {
+		rc = regmap_bulk_read(rtc_dd->regmap, regs->read, value,
+				      sizeof(value));
+		if (rc)
+			return rc;
+	}
+
+	*secs = get_unaligned_le32(value);
+
+	return 0;
+}
+
 /*
  * Steps to write the RTC registers.
  * 1. Disable alarm if enabled.
@@ -129,33 +160,14 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	int rc;
-	u8 value[NUM_8_BIT_RTC_REGS];
-	unsigned int reg;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
-	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 	u32 secs;
+	int rc;
 
-	rc = regmap_bulk_read(rtc_dd->regmap, regs->read, value, sizeof(value));
+	rc = pm8xxx_rtc_read_raw(rtc_dd, &secs);
 	if (rc)
 		return rc;
 
-	/*
-	 * Read the LSB again and check if there has been a carry over.
-	 * If there is, redo the read operation.
-	 */
-	rc = regmap_read(rtc_dd->regmap, regs->read, &reg);
-	if (rc < 0)
-		return rc;
-
-	if (unlikely(reg < value[0])) {
-		rc = regmap_bulk_read(rtc_dd->regmap, regs->read,
-				      value, sizeof(value));
-		if (rc)
-			return rc;
-	}
-
-	secs = get_unaligned_le32(value);
 	rtc_time64_to_tm(secs, tm);
 
 	dev_dbg(dev, "read time: %ptRd %ptRt (%u)\n", tm, tm, secs);
-- 
2.39.1

