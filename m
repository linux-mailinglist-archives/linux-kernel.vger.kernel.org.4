Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEF65FB4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJKOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJKOhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:37:00 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EF04F1AA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:36:58 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B5tp64002064;
        Tue, 11 Oct 2022 09:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=T50Al95xo16TE632hM1pPOnnhfkBsFzckULNsLl5Dg0=;
 b=M34IC+jCMj3DEhiz5bNE+bbPbhR8XDhL32+jaqpB1G2vVphaxM/8nm/wO5PiYmxDDNH7
 gQUFsig7VsXxUu9cpPsyhfv444H/WmW0UGhLQfwOmLjBg8Usia1an6fMbtoEADMcdHg3
 xRt1rhfjnF2fdIz/kYCQxZrNgy+v9XecBr79zDlYw6HyyA1urjeqfuwNkJyhfSoHaABP
 Vo0l+pT11013gAKrznZQZV2dFDJD71V4F9S+KR6x9wLqmSDDkb4dZTHZuIjwOHPTEwTi
 2VwfdzLGbqyMu41L4hLAAtKQfN6nYzbaQ1iKMqD8vd53tgbI/2a5+sF+9ooEq4/dlkMD 5A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3k36m1uhph-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 09:36:16 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Tue, 11 Oct
 2022 09:36:13 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Tue, 11 Oct 2022 09:36:13 -0500
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8D7AD11DC;
        Tue, 11 Oct 2022 14:36:13 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 5/5] ALSA: hda: cs35l41: Support System Suspend
Date:   Tue, 11 Oct 2022 15:35:52 +0100
Message-ID: <20221011143552.621792-6-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011143552.621792-1-sbinding@opensource.cirrus.com>
References: <20221011143552.621792-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QRUy-4emuWVfetDBlGVdFjtxyuPQq2jk
X-Proofpoint-ORIG-GUID: QRUy-4emuWVfetDBlGVdFjtxyuPQq2jk
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for system suspend into the CS35L41 HDA Driver.
Since S4 suspend may power off the system, it is required
that the driver ensure the part is safe to be shutdown before
system suspend, as well as ensuring that the firmware is
unloaded before shutdown. The part must then be restored
on system resume, including re-downloading the firmware.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 160 ++++++++++++++++++++++++++++++------
 1 file changed, 136 insertions(+), 24 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 89f6b4a28d3d7..e5f0549bf06d0 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -461,9 +461,12 @@ static void cs35l41_remove_dsp(struct cs35l41_hda *cs35l41)
 	struct cs_dsp *dsp = &cs35l41->cs_dsp;
 
 	cancel_work_sync(&cs35l41->fw_load_work);
+
+	mutex_lock(&cs35l41->fw_mutex);
 	cs35l41_shutdown_dsp(cs35l41);
 	cs_dsp_remove(dsp);
 	cs35l41->halo_initialized = false;
+	mutex_unlock(&cs35l41->fw_mutex);
 }
 
 /* Protection release cycle to get the speaker out of Safe-Mode */
@@ -570,45 +573,148 @@ static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsi
 				    rx_slot);
 }
 
+static void cs35l41_ready_for_reset(struct cs35l41_hda *cs35l41)
+{
+	mutex_lock(&cs35l41->fw_mutex);
+	if (cs35l41->firmware_running) {
+
+		regcache_cache_only(cs35l41->regmap, false);
+
+		cs35l41_exit_hibernate(cs35l41->dev, cs35l41->regmap);
+		cs35l41_shutdown_dsp(cs35l41);
+		cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
+
+		regcache_cache_only(cs35l41->regmap, true);
+		regcache_mark_dirty(cs35l41->regmap);
+	}
+	mutex_unlock(&cs35l41->fw_mutex);
+}
+
+static int cs35l41_system_suspend(struct device *dev)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(cs35l41->dev, "System Suspend\n");
+
+	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST_NO_VSPK_SWITCH) {
+		dev_err(cs35l41->dev, "System Suspend not supported\n");
+		return -EINVAL;
+	}
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	/* Shutdown DSP before system suspend */
+	cs35l41_ready_for_reset(cs35l41);
+
+	/*
+	 * Reset GPIO may be shared, so cannot reset here.
+	 * However beyond this point, amps may be powered down.
+	 */
+	return 0;
+}
+
+static int cs35l41_system_resume(struct device *dev)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(cs35l41->dev, "System Resume\n");
+
+	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST_NO_VSPK_SWITCH) {
+		dev_err(cs35l41->dev, "System Resume not supported\n");
+		return -EINVAL;
+	}
+
+	if (cs35l41->reset_gpio) {
+		usleep_range(2000, 2100);
+		gpiod_set_value_cansleep(cs35l41->reset_gpio, 1);
+	}
+
+	usleep_range(2000, 2100);
+
+	ret = pm_runtime_force_resume(dev);
+
+	mutex_lock(&cs35l41->fw_mutex);
+	if (!ret && cs35l41->request_fw_load && !cs35l41->fw_request_ongoing) {
+		cs35l41->fw_request_ongoing = true;
+		schedule_work(&cs35l41->fw_load_work);
+	}
+	mutex_unlock(&cs35l41->fw_mutex);
+
+	return ret;
+}
+
 static int cs35l41_runtime_suspend(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	int ret = 0;
 
-	dev_dbg(cs35l41->dev, "Suspend\n");
+	dev_dbg(cs35l41->dev, "Runtime Suspend\n");
 
-	if (!cs35l41->firmware_running)
+	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST_NO_VSPK_SWITCH) {
+		dev_dbg(cs35l41->dev, "Runtime Suspend not supported\n");
 		return 0;
+	}
 
-	if (cs35l41_enter_hibernate(cs35l41->dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type) < 0)
-		return 0;
+	mutex_lock(&cs35l41->fw_mutex);
+
+	if (cs35l41->playback_started) {
+		regmap_multi_reg_write(cs35l41->regmap, cs35l41_hda_mute,
+				       ARRAY_SIZE(cs35l41_hda_mute));
+		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 0);
+		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
+				   CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
+		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
+			regmap_write(cs35l41->regmap, CS35L41_GPIO1_CTRL1, 0x00000001);
+		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
+				   CS35L41_VMON_EN_MASK | CS35L41_IMON_EN_MASK,
+				   0 << CS35L41_VMON_EN_SHIFT | 0 << CS35L41_IMON_EN_SHIFT);
+		cs35l41->playback_started = false;
+	}
+
+	if (cs35l41->firmware_running) {
+		ret = cs35l41_enter_hibernate(cs35l41->dev, cs35l41->regmap,
+					      cs35l41->hw_cfg.bst_type);
+		if (ret)
+			goto err;
+	} else {
+		cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
+	}
 
 	regcache_cache_only(cs35l41->regmap, true);
 	regcache_mark_dirty(cs35l41->regmap);
 
-	return 0;
+err:
+	mutex_unlock(&cs35l41->fw_mutex);
+
+	return ret;
 }
 
 static int cs35l41_runtime_resume(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;
 
-	dev_dbg(cs35l41->dev, "Resume.\n");
+	dev_dbg(cs35l41->dev, "Runtime Resume\n");
 
 	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST_NO_VSPK_SWITCH) {
-		dev_dbg(cs35l41->dev, "System does not support Resume\n");
+		dev_dbg(cs35l41->dev, "Runtime Resume not supported\n");
 		return 0;
 	}
 
-	if (!cs35l41->firmware_running)
-		return 0;
+	mutex_lock(&cs35l41->fw_mutex);
 
 	regcache_cache_only(cs35l41->regmap, false);
 
-	ret = cs35l41_exit_hibernate(cs35l41->dev, cs35l41->regmap);
-	if (ret) {
-		regcache_cache_only(cs35l41->regmap, true);
-		return ret;
+	if (cs35l41->firmware_running)	{
+		ret = cs35l41_exit_hibernate(cs35l41->dev, cs35l41->regmap);
+		if (ret) {
+			dev_warn(cs35l41->dev, "Unable to exit Hibernate.");
+			goto err;
+		}
 	}
 
 	/* Test key needs to be unlocked to allow the OTP settings to re-apply */
@@ -617,13 +723,16 @@ static int cs35l41_runtime_resume(struct device *dev)
 	cs35l41_test_key_lock(cs35l41->dev, cs35l41->regmap);
 	if (ret) {
 		dev_err(cs35l41->dev, "Failed to restore register cache: %d\n", ret);
-		return ret;
+		goto err;
 	}
 
 	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
 		cs35l41_init_boost(cs35l41->dev, cs35l41->regmap, &cs35l41->hw_cfg);
 
-	return 0;
+err:
+	mutex_unlock(&cs35l41->fw_mutex);
+
+	return ret;
 }
 
 static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
@@ -673,8 +782,6 @@ static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 
 static void cs35l41_load_firmware(struct cs35l41_hda *cs35l41, bool load)
 {
-	pm_runtime_get_sync(cs35l41->dev);
-
 	if (cs35l41->firmware_running && !load) {
 		dev_dbg(cs35l41->dev, "Unloading Firmware\n");
 		cs35l41_shutdown_dsp(cs35l41);
@@ -684,9 +791,6 @@ static void cs35l41_load_firmware(struct cs35l41_hda *cs35l41, bool load)
 	} else {
 		dev_dbg(cs35l41->dev, "Unable to Load firmware.\n");
 	}
-
-	pm_runtime_mark_last_busy(cs35l41->dev);
-	pm_runtime_put_autosuspend(cs35l41->dev);
 }
 
 static int cs35l41_fw_load_ctl_get(struct snd_kcontrol *kcontrol,
@@ -702,16 +806,21 @@ static void cs35l41_fw_load_work(struct work_struct *work)
 {
 	struct cs35l41_hda *cs35l41 = container_of(work, struct cs35l41_hda, fw_load_work);
 
+	pm_runtime_get_sync(cs35l41->dev);
+
 	mutex_lock(&cs35l41->fw_mutex);
 
 	/* Recheck if playback is ongoing, mutex will block playback during firmware loading */
 	if (cs35l41->playback_started)
-		dev_err(cs35l41->dev, "Cannot Load/Unload firmware during Playback\n");
+		dev_err(cs35l41->dev, "Cannot Load/Unload firmware during Playback. Retrying...\n");
 	else
 		cs35l41_load_firmware(cs35l41, cs35l41->request_fw_load);
 
 	cs35l41->fw_request_ongoing = false;
 	mutex_unlock(&cs35l41->fw_mutex);
+
+	pm_runtime_mark_last_busy(cs35l41->dev);
+	pm_runtime_put_autosuspend(cs35l41->dev);
 }
 
 static int cs35l41_fw_load_ctl_put(struct snd_kcontrol *kcontrol,
@@ -835,6 +944,8 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 
 	pm_runtime_get_sync(dev);
 
+	mutex_lock(&cs35l41->fw_mutex);
+
 	comps->dev = dev;
 	if (!cs35l41->acpi_subsystem_id)
 		cs35l41->acpi_subsystem_id = kasprintf(GFP_KERNEL, "%.8x",
@@ -847,10 +958,8 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	if (firmware_autostart) {
 		dev_dbg(cs35l41->dev, "Firmware Autostart.\n");
 		cs35l41->request_fw_load = true;
-		mutex_lock(&cs35l41->fw_mutex);
 		if (cs35l41_smart_amp(cs35l41) < 0)
 			dev_warn(cs35l41->dev, "Cannot Run Firmware, reverting to dsp bypass...\n");
-		mutex_unlock(&cs35l41->fw_mutex);
 	} else {
 		dev_dbg(cs35l41->dev, "Firmware Autostart is disabled.\n");
 	}
@@ -859,6 +968,8 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 
 	comps->playback_hook = cs35l41_hda_playback_hook;
 
+	mutex_unlock(&cs35l41->fw_mutex);
+
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
@@ -1426,6 +1537,7 @@ EXPORT_SYMBOL_NS_GPL(cs35l41_hda_remove, SND_HDA_SCODEC_CS35L41);
 
 const struct dev_pm_ops cs35l41_hda_pm_ops = {
 	RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(cs35l41_system_suspend, cs35l41_system_resume)
 };
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_pm_ops, SND_HDA_SCODEC_CS35L41);
 
-- 
2.34.1

