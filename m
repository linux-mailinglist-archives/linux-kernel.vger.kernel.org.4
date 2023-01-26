Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73067CDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjAZOXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjAZOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC4C1715A;
        Thu, 26 Jan 2023 06:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11D9061842;
        Thu, 26 Jan 2023 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C67C43239;
        Thu, 26 Jan 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742978;
        bh=MyPlfqgwLCW9R8daVZNHfkNPmJZl3+mMcd7/6rQjSw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibCSm02bF9LGX8B5EOn5MyMdY7qbeRz/d2gIpICeFd+4sKa7S993D87f0q8PBT6tr
         0feICV4zR3zAxEICP7V3cjjSbKMQpihzI51Ri/AYIx/b7H4tCY1XlVp+H7Z+7dvI3A
         6UTX2RVCkyzRNmbVpV8tGNQX+GL7TDLEDDjTlbqKPGx75Wict0r880e3qbKva3vBa4
         A4andUNIBnh/QP2r2hpWM3t0GeWjzEXlHKyyoXWvKTZTDWtxDYcE+Up8GTU14CBHV+
         7xm4wWgXyVm7beCJZ/RqhhsGMMQB2Zpm/hjaZ1eES9+3ySgpur0w8r6KxzWJ+gdVSw
         pmgo15E8rYvcw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39d-0006iu-CA; Thu, 26 Jan 2023 15:23:05 +0100
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
Subject: [PATCH 16/24] rtc: pm8xxx: add support for nvmem offset
Date:   Thu, 26 Jan 2023 15:20:49 +0100
Message-Id: <20230126142057.25715-17-johan+linaro@kernel.org>
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

On many Qualcomm platforms the PMIC RTC control and time registers are
read-only so that the RTC time can not be updated. Instead an offset
needs be stored in some machine-specific non-volatile memory, which the
driver can take into account.

Add support for storing a 32-bit offset from the Epoch in an nvmem cell
so that the RTC time can be set on such platforms.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 134 +++++++++++++++++++++++++++++++++++----
 1 file changed, 123 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 922aef0f0241..09816b9f6282 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -3,6 +3,7 @@
  */
 #include <linux/of.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/init.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
@@ -49,6 +50,8 @@ struct pm8xxx_rtc_regs {
  * @alarm_irq:		alarm irq number
  * @regs:		register description
  * @dev:		device structure
+ * @nvmem_cell:		nvmem cell for offset
+ * @offset:		offset from epoch in seconds
  */
 struct pm8xxx_rtc {
 	struct rtc_device *rtc;
@@ -57,8 +60,60 @@ struct pm8xxx_rtc {
 	int alarm_irq;
 	const struct pm8xxx_rtc_regs *regs;
 	struct device *dev;
+	struct nvmem_cell *nvmem_cell;
+	u32 offset;
 };
 
+static int pm8xxx_rtc_read_nvmem_offset(struct pm8xxx_rtc *rtc_dd)
+{
+	size_t len;
+	void *buf;
+	int rc;
+
+	buf = nvmem_cell_read(rtc_dd->nvmem_cell, &len);
+	if (IS_ERR(buf)) {
+		rc = PTR_ERR(buf);
+		dev_err(rtc_dd->dev, "failed to read nvmem offset: %d\n", rc);
+		return rc;
+	}
+
+	if (len != sizeof(u32)) {
+		dev_err(rtc_dd->dev, "unexpected nvmem cell size %zu\n", len);
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	rtc_dd->offset = get_unaligned_le32(buf);
+
+	kfree(buf);
+
+	return 0;
+}
+
+static int pm8xxx_rtc_write_nvmem_offset(struct pm8xxx_rtc *rtc_dd, u32 offset)
+{
+	u8 buf[sizeof(u32)];
+	int rc;
+
+	put_unaligned_le32(offset, buf);
+
+	rc = nvmem_cell_write(rtc_dd->nvmem_cell, buf, sizeof(buf));
+	if (rc < 0) {
+		dev_err(rtc_dd->dev, "failed to write nvmem offset: %d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int pm8xxx_rtc_read_offset(struct pm8xxx_rtc *rtc_dd)
+{
+	if (!rtc_dd->nvmem_cell)
+		return 0;
+
+	return pm8xxx_rtc_read_nvmem_offset(rtc_dd);
+}
+
 static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
 {
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
@@ -90,6 +145,33 @@ static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
 	return 0;
 }
 
+static int pm8xxx_rtc_update_offset(struct pm8xxx_rtc *rtc_dd, u32 secs)
+{
+	u32 raw_secs;
+	u32 offset;
+	int rc;
+
+	if (!rtc_dd->nvmem_cell)
+		return -ENODEV;
+
+	rc = pm8xxx_rtc_read_raw(rtc_dd, &raw_secs);
+	if (rc)
+		return rc;
+
+	offset = secs - raw_secs;
+
+	if (offset == rtc_dd->offset)
+		return 0;
+
+	rc = pm8xxx_rtc_write_nvmem_offset(rtc_dd, offset);
+	if (rc)
+		return rc;
+
+	rtc_dd->offset = offset;
+
+	return 0;
+}
+
 /*
  * Steps to write the RTC registers.
  * 1. Disable alarm if enabled.
@@ -99,23 +181,15 @@ static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
  * 5. Enable rtc if disabled in step 2.
  * 6. Enable alarm if disabled in step 1.
  */
-static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
+static int __pm8xxx_rtc_set_time(struct pm8xxx_rtc *rtc_dd, u32 secs)
 {
-	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 	u8 value[NUM_8_BIT_RTC_REGS];
 	bool alarm_enabled;
-	u32 secs;
 	int rc;
 
-	if (!rtc_dd->allow_set_time)
-		return -ENODEV;
-
-	secs = rtc_tm_to_time64(tm);
 	put_unaligned_le32(secs, value);
 
-	dev_dbg(dev, "set time: %ptRd %ptRt (%u)\n", tm, tm, secs);
-
 	rc = regmap_update_bits_check(rtc_dd->regmap, regs->alarm_ctrl,
 				      regs->alarm_en, 0, &alarm_enabled);
 	if (rc)
@@ -158,6 +232,27 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
+	u32 secs;
+	int rc;
+
+	secs = rtc_tm_to_time64(tm);
+
+	if (rtc_dd->allow_set_time)
+		rc = __pm8xxx_rtc_set_time(rtc_dd, secs);
+	else
+		rc = pm8xxx_rtc_update_offset(rtc_dd, secs);
+
+	if (rc)
+		return rc;
+
+	dev_dbg(dev, "set time: %ptRd %ptRt (%u + %u)\n", tm, tm,
+			secs - rtc_dd->offset, rtc_dd->offset);
+	return 0;
+}
+
 static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
@@ -168,10 +263,11 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	if (rc)
 		return rc;
 
+	secs += rtc_dd->offset;
 	rtc_time64_to_tm(secs, tm);
 
-	dev_dbg(dev, "read time: %ptRd %ptRt (%u)\n", tm, tm, secs);
-
+	dev_dbg(dev, "read time: %ptRd %ptRt (%u + %u)\n", tm, tm,
+			secs - rtc_dd->offset, rtc_dd->offset);
 	return 0;
 }
 
@@ -184,6 +280,7 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	int rc;
 
 	secs = rtc_tm_to_time64(&alarm->time);
+	secs -= rtc_dd->offset;
 	put_unaligned_le32(secs, value);
 
 	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
@@ -223,6 +320,7 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		return rc;
 
 	secs = get_unaligned_le32(value);
+	secs += rtc_dd->offset;
 	rtc_time64_to_tm(secs, &alarm->time);
 
 	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
@@ -380,9 +478,23 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	rtc_dd->allow_set_time = of_property_read_bool(pdev->dev.of_node,
 						      "allow-set-time");
 
+	rtc_dd->nvmem_cell = devm_nvmem_cell_get(&pdev->dev, "offset");
+	if (IS_ERR(rtc_dd->nvmem_cell)) {
+		rc = PTR_ERR(rtc_dd->nvmem_cell);
+		if (rc != -ENOENT)
+			return rc;
+		rtc_dd->nvmem_cell = NULL;
+	}
+
 	rtc_dd->regs = match->data;
 	rtc_dd->dev = &pdev->dev;
 
+	if (!rtc_dd->allow_set_time) {
+		rc = pm8xxx_rtc_read_offset(rtc_dd);
+		if (rc)
+			return rc;
+	}
+
 	rc = pm8xxx_rtc_enable(rtc_dd);
 	if (rc)
 		return rc;
-- 
2.39.1

