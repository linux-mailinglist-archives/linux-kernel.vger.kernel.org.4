Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CBE6DDF97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjDKP0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjDKPZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:25:41 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5022E1A2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:25:39 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B5cuXK012801;
        Tue, 11 Apr 2023 10:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=zshJ2gQKlJ/ynFJsVBq5tsN+HV4UHIDxxL3uWopj5Zg=;
 b=DM5VoCTCloezNlSFakb+9+g4SujZAMi0FjC3NoM+LwJfZwvwHlUyo1vH5fea+mETs+wF
 n/nPUZKx3P1Lmic/e4+3njTWYgBzIga0GIZa/dxCwYpLw4IQupftU7JhzLu6dYSbBYuk
 VzqYcebPvgmi4fwsoKEABbIb3tZ5Jm+56s5sTa4D7MFdqhJDsgAqgFadesjcgp6AM1u6
 /TuWlXj/ANm82f9WfiN7Oa9U1WosZd/88Tq9tBp8xDCuAdlxjmqgutH7/9us6kVgE6Xc
 9UwpQBRrRG6f0xDfaC6UL5K1aQ9MMz2HWnqmgaCSwp6KNRbK/1xIf/rAIw2/XHsM77sP hw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pu4pq54a3-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:25:33 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 11 Apr
 2023 10:25:28 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Apr 2023 10:25:28 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8AB8645;
        Tue, 11 Apr 2023 15:25:28 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 5/6] ASoC: cs35l56: Add basic system suspend handling
Date:   Tue, 11 Apr 2023 16:25:27 +0100
Message-ID: <20230411152528.329803-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230411152528.329803-1-rf@opensource.cirrus.com>
References: <20230411152528.329803-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tx4FykHLpFPC7J6eRbmlP1PzJDlsjyuv
X-Proofpoint-ORIG-GUID: tx4FykHLpFPC7J6eRbmlP1PzJDlsjyuv
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the main handling for system suspend but does not handle
re-patching the firmware after system resume.

This is a multi-stage suspend and resume because if there is a
RESET line it is almost certain that it will be shared by all the
amps. So every amp must have done its suspend before we can
assert RESET. Likewise we must de-assert RESET before the amps
can resume.

It's preferable to assert RESET before we turning off regulators, and
while they power up.

The actual suspend and resume is done by using the pair
pm_runtime_force_suspend() and pm_runtime_force_resume() to
re-use our runtime suspend/resume sequences.

pm_runtime_force_suspend() will disable our pm_runtime. If we were
runtime-resumed it calls our runtime_suspend().

pm_runtime_force_resume() re-enables pm_runtime and if we were
originally runtime-resumed before the pm_runtime_force_suspend()
it calls our runtime_resume(). Otherwise it leaves us
runtime-suspended.

The general process is therefore:

 suspend() -> finish dsp_work and then run our runtime_suspend
 suspend_late() -> assert RESET and turn off supplies
 resume_early() -> enable supplies and de-assert RESET
 resume() -> pm_runtime_force_resume()

In addition, to prevent the IRQ handler running in the period
between pm_runtime_force_suspend() and pm_runtime_force_resume()
the parent IRQ is temporarily disabled:
 - from suspend until suspend_noirq
 - from resume_noirq until resume

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-sdw.c |  26 +++++++
 sound/soc/codecs/cs35l56.c     | 126 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.h     |   6 ++
 3 files changed, 158 insertions(+)

diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index 448ef3609f4c..947d4e5f4dc9 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -450,6 +450,29 @@ static int __maybe_unused cs35l56_sdw_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused cs35l56_sdw_system_suspend(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+
+	if (!cs35l56->init_done)
+		return 0;
+
+	/*
+	 * Disable SoundWire interrupts.
+	 * Flush - don't cancel because that could leave an unbalanced pm_runtime_get.
+	 */
+	cs35l56->sdw_irq_no_unmask = true;
+	flush_work(&cs35l56->sdw_irq_work);
+
+	/* Mask interrupts and flush in case sdw_irq_work was queued again */
+	sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1, 0);
+	sdw_read_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_STAT_1);
+	sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
+	flush_work(&cs35l56->sdw_irq_work);
+
+	return cs35l56_system_suspend(dev);
+}
+
 static int cs35l56_sdw_probe(struct sdw_slave *peripheral, const struct sdw_device_id *id)
 {
 	struct device *dev = &peripheral->dev;
@@ -499,6 +522,9 @@ static int cs35l56_sdw_remove(struct sdw_slave *peripheral)
 
 static const struct dev_pm_ops cs35l56_sdw_pm = {
 	SET_RUNTIME_PM_OPS(cs35l56_sdw_runtime_suspend, cs35l56_sdw_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(cs35l56_sdw_system_suspend, cs35l56_system_resume)
+	LATE_SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend_late, cs35l56_system_resume_early)
+	/* NOIRQ stage not needed, SoundWire doesn't use a hard IRQ */
 };
 
 static const struct sdw_device_id cs35l56_sdw_id[] = {
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 74abcf1c604a..eb85c27ab087 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -11,8 +11,10 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 #include <linux/math.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -1154,6 +1156,127 @@ int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_CORE);
 
+int cs35l56_system_suspend(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "system_suspend\n");
+
+	if (cs35l56->component)
+		flush_work(&cs35l56->dsp_work);
+
+	/*
+	 * The interrupt line is normally shared, but after we start suspending
+	 * we can't check if our device is the source of an interrupt, and can't
+	 * clear it. Prevent this race by temporarily disabling the parent irq
+	 * until we reach _no_irq.
+	 */
+	if (cs35l56->irq)
+		disable_irq(cs35l56->irq);
+
+	return pm_runtime_force_suspend(dev);
+}
+EXPORT_SYMBOL_GPL(cs35l56_system_suspend);
+
+int cs35l56_system_suspend_late(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "system_suspend_late\n");
+
+	/*
+	 * Assert RESET before removing supplies.
+	 * RESET is usually shared by all amps so it must not be asserted until
+	 * all driver instances have done their suspend() stage.
+	 */
+	if (cs35l56->reset_gpio) {
+		gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
+		usleep_range(CS35L56_RESET_PULSE_MIN_US, CS35L56_RESET_PULSE_MIN_US + 400);
+	}
+
+	regulator_bulk_disable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs35l56_system_suspend_late);
+
+int cs35l56_system_suspend_no_irq(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "system_suspend_no_irq\n");
+
+	/* Handlers are now disabled so the parent IRQ can safely be re-enabled. */
+	if (cs35l56->irq)
+		enable_irq(cs35l56->irq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs35l56_system_suspend_no_irq);
+
+int cs35l56_system_resume_no_irq(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "system_resume_no_irq\n");
+
+	/*
+	 * WAKE interrupts unmask if the CS35L56 hibernates, which can cause
+	 * spurious interrupts, and the interrupt line is normally shared.
+	 * We can't check if our device is the source of an interrupt, and can't
+	 * clear it, until it has fully resumed. Prevent this race by temporarily
+	 * disabling the parent irq until we complete resume().
+	 */
+	if (cs35l56->irq)
+		disable_irq(cs35l56->irq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs35l56_system_resume_no_irq);
+
+int cs35l56_system_resume_early(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "system_resume_early\n");
+
+	/* Ensure a spec-compliant RESET pulse. */
+	if (cs35l56->reset_gpio) {
+		gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
+		usleep_range(CS35L56_RESET_PULSE_MIN_US, CS35L56_RESET_PULSE_MIN_US + 400);
+	}
+
+	/* Enable supplies before releasing RESET. */
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
+	if (ret) {
+		dev_err(dev, "system_resume_early failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	/* Release shared RESET before drivers start resume(). */
+	gpiod_set_value_cansleep(cs35l56->reset_gpio, 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs35l56_system_resume_early);
+
+int cs35l56_system_resume(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "system_resume\n");
+
+	/* Undo pm_runtime_force_suspend() before re-enabling the irq */
+	ret = pm_runtime_force_resume(dev);
+	if (cs35l56->irq)
+		enable_irq(cs35l56->irq);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs35l56_system_resume);
+
 static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 {
 	struct wm_adsp *dsp;
@@ -1451,6 +1574,9 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_remove, SND_SOC_CS35L56_CORE);
 
 const struct dev_pm_ops cs35l56_pm_ops_i2c_spi = {
 	SET_RUNTIME_PM_OPS(cs35l56_runtime_suspend, cs35l56_runtime_resume_i2c_spi, NULL)
+	SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend, cs35l56_system_resume)
+	LATE_SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend_late, cs35l56_system_resume_early)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend_no_irq, cs35l56_system_resume_no_irq)
 };
 EXPORT_SYMBOL_NS_GPL(cs35l56_pm_ops_i2c_spi, SND_SOC_CS35L56_CORE);
 
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index dc91cd7d877f..50278dafc9ca 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -67,6 +67,12 @@ extern const struct dev_pm_ops cs35l56_pm_ops_i2c_spi;
 
 int cs35l56_runtime_suspend(struct device *dev);
 int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56);
+int cs35l56_system_suspend(struct device *dev);
+int cs35l56_system_suspend_late(struct device *dev);
+int cs35l56_system_suspend_no_irq(struct device *dev);
+int cs35l56_system_resume_no_irq(struct device *dev);
+int cs35l56_system_resume_early(struct device *dev);
+int cs35l56_system_resume(struct device *dev);
 irqreturn_t cs35l56_irq(int irq, void *data);
 int cs35l56_irq_request(struct cs35l56_private *cs35l56);
 int cs35l56_common_probe(struct cs35l56_private *cs35l56);
-- 
2.30.2

