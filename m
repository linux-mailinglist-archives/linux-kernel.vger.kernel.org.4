Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D716DDF94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjDKPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjDKPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:25:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48548469E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:25:37 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B5nsH8029336;
        Tue, 11 Apr 2023 10:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=6ygy8yOQrMF4h+ESCpufA5eR+krnF14NouI1a2OY12M=;
 b=P0QbHwbRUFD8LR+OlFv+s1w80PsskSQY3RgbuvU0vVMTO4lGNfYZ3hg5fHJAFjm0WSDb
 zMsQNypXaO/+KlxLB6wKf8Ye7hebByj0ZKVfEc1daBTLM1xPT7+Gh0tDx2Sz+XhvdPX9
 XfhDBgTE/sfw3Ty9altzzDUOlWtoCsJCvMeZy61gHJK86GdReV+j1Dd5fc9bjnW0968b
 tomp8HlphuilxGCuvxafGZdPzEA3naVY5EWl+ZE/uxYq+3K/d3hQTJnTaDGtZXck0nNW
 0HzHYQjSR+a27BWnR2nPfesqJtCem9deBMiWt16h2jg06AmulAXfmP9pe+NgZPp2/t+8 lg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pu4pq54a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:25:30 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 11 Apr
 2023 10:25:28 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 11 Apr 2023 10:25:28 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9A1753560;
        Tue, 11 Apr 2023 15:25:28 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 6/6] ASoC: cs35l56: Re-patch firmware after system suspend
Date:   Tue, 11 Apr 2023 16:25:28 +0100
Message-ID: <20230411152528.329803-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230411152528.329803-1-rf@opensource.cirrus.com>
References: <20230411152528.329803-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ktI1ak-rDsYuVepHDzrnjs6fl1D85HFD
X-Proofpoint-ORIG-GUID: ktI1ak-rDsYuVepHDzrnjs6fl1D85HFD
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check during cs35l56_system_resume() whether the firmware patch must
be applied again.

The FIRMWARE_MISSING flag in the PROTECTION_STATUS register indicates
whether the firmware has been patched.

In non-secure mode the FIRMWARE_MISSING flag is cleared at the end of
dsp_work(). If it is set after system-resume we know that dsp_work()
must be run again.

In secure mode the pre-OS loader will have done the secure patching
and cleared the FIRMWARE_MISSING flag. So this flag does not tell us
whether firmware memory was lost. But the driver could only be
downloading non-secure tunings, which is always safe to do.

If the driver has control of RESET we will have asserted it during
suspend so the firmware patch will have been lost. The driver would only
have control of RESET in non-secure mode.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h        |  4 ++
 sound/soc/codecs/cs35l56-sdw.c | 12 +++++-
 sound/soc/codecs/cs35l56.c     | 67 +++++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 5f8ea2dfaa21..b3300bce74f4 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -95,6 +95,7 @@
 #define CS35L56_MAIN_RENDER_USER_MUTE			0x3400024
 #define CS35L56_MAIN_RENDER_USER_VOLUME			0x340002C
 #define CS35L56_MAIN_POSTURE_NUMBER			0x3400094
+#define CS35L56_PROTECTION_STATUS			0x34000D8
 #define CS35L56_TRANSDUCER_ACTUAL_PS			0x3400150
 #define CS35L56_DSP1_YMEM_UNPACKED24_6141		0x3405FF4
 #define CS35L56_DSP1_PMEM_0				0x3800000
@@ -216,6 +217,9 @@
 #define CS35L56_MAIN_POSTURE_MAX			255
 #define CS35L56_MAIN_POSTURE_MASK			CS35L56_MAIN_POSTURE_MAX
 
+/* CS35L56_PROTECTION_STATUS */
+#define CS35L56_FIRMWARE_MISSING			BIT(0)
+
 /* Software Values */
 #define CS35L56_HALO_STATE_SHUTDOWN			1
 #define CS35L56_HALO_STATE_BOOT_DONE			2
diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index 947d4e5f4dc9..e759347423cf 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -473,6 +473,16 @@ static int __maybe_unused cs35l56_sdw_system_suspend(struct device *dev)
 	return cs35l56_system_suspend(dev);
 }
 
+static int __maybe_unused cs35l56_sdw_system_resume(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+
+	cs35l56->sdw_irq_no_unmask = false;
+	/* runtime_resume re-enables the interrupt */
+
+	return cs35l56_system_resume(dev);
+}
+
 static int cs35l56_sdw_probe(struct sdw_slave *peripheral, const struct sdw_device_id *id)
 {
 	struct device *dev = &peripheral->dev;
@@ -522,7 +532,7 @@ static int cs35l56_sdw_remove(struct sdw_slave *peripheral)
 
 static const struct dev_pm_ops cs35l56_sdw_pm = {
 	SET_RUNTIME_PM_OPS(cs35l56_sdw_runtime_suspend, cs35l56_sdw_runtime_resume, NULL)
-	SYSTEM_SLEEP_PM_OPS(cs35l56_sdw_system_suspend, cs35l56_system_resume)
+	SYSTEM_SLEEP_PM_OPS(cs35l56_sdw_system_suspend, cs35l56_sdw_system_resume)
 	LATE_SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend_late, cs35l56_system_resume_early)
 	/* NOIRQ stage not needed, SoundWire doesn't use a hard IRQ */
 };
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index eb85c27ab087..18e341744839 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -946,6 +946,7 @@ static void cs35l56_dsp_work(struct work_struct *work)
 		goto err_unlock;
 	}
 
+	regmap_clear_bits(cs35l56->regmap, CS35L56_PROTECTION_STATUS, CS35L56_FIRMWARE_MISSING);
 	cs35l56->fw_patched = true;
 
 err_unlock:
@@ -1026,6 +1027,8 @@ static const struct snd_soc_component_driver soc_component_dev_cs35l56 = {
 	.num_controls = ARRAY_SIZE(cs35l56_controls),
 
 	.set_bias_level = cs35l56_set_bias_level,
+
+	.suspend_bias_off = 1, /* see cs35l56_system_resume() */
 };
 
 static const struct reg_sequence cs35l56_hibernate_seq[] = {
@@ -1156,6 +1159,47 @@ int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_CORE);
 
+static int cs35l56_is_fw_reload_needed(struct cs35l56_private *cs35l56)
+{
+	unsigned int val;
+	int ret;
+
+	/* Nothing to re-patch if we haven't done any patching yet. */
+	if (!cs35l56->fw_patched)
+		return false;
+
+	/*
+	 * If we have control of RESET we will have asserted it so the firmware
+	 * will need re-patching.
+	 */
+	if (cs35l56->reset_gpio)
+		return true;
+
+	/*
+	 * In secure mode FIRMWARE_MISSING is cleared by the BIOS loader so
+	 * can't be used here to test for memory retention.
+	 * Assume that tuning must be re-loaded.
+	 */
+	if (cs35l56->secured)
+		return true;
+
+	ret = pm_runtime_resume_and_get(cs35l56->dev);
+	if (ret) {
+		dev_err(cs35l56->dev, "Failed to runtime_get: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(cs35l56->regmap, CS35L56_PROTECTION_STATUS, &val);
+	if (ret)
+		dev_err(cs35l56->dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
+	else
+		ret = !!(val & CS35L56_FIRMWARE_MISSING);
+
+	pm_runtime_put_autosuspend(cs35l56->dev);
+
+	return ret;
+}
+
 int cs35l56_system_suspend(struct device *dev)
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
@@ -1273,7 +1317,28 @@ int cs35l56_system_resume(struct device *dev)
 	if (cs35l56->irq)
 		enable_irq(cs35l56->irq);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	/* Firmware won't have been loaded if the component hasn't probed */
+	if (!cs35l56->component)
+		return 0;
+
+	ret = cs35l56_is_fw_reload_needed(cs35l56);
+	dev_dbg(cs35l56->dev, "fw_reload_needed: %d\n", ret);
+	if (ret < 1)
+		return ret;
+
+	cs35l56->fw_patched = false;
+	init_completion(&cs35l56->dsp_ready_completion);
+	queue_work(cs35l56->dsp_wq, &cs35l56->dsp_work);
+
+	/*
+	 * suspend_bias_off ensures we are now in BIAS_OFF so there will be
+	 * a BIAS_OFF->BIAS_STANDBY transition to complete dsp patching.
+	 */
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(cs35l56_system_resume);
 
-- 
2.30.2

