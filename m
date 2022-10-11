Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29F5FB4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJKOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJKOg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:36:28 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1637149B4E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:36:27 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B5tp63002064;
        Tue, 11 Oct 2022 09:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=/bn+4fdIUIPJRUslDh7kAAlTL0j0sf0+OYvn4bA4pN8=;
 b=M3eEh+Jkd6BSFyJOpPlkXr844hA2T+VcGsyzJaVsUMp4p1J5CoxSCXity2aw6LKOUoab
 w41CoN9QTZC2UilAlk0jV2RFO/VoOL1cFQ1sd9l2FOY9PQ3zalgdVGH+t+OrAvmSBvAc
 6XFuvI9Wphs87N76WsEwe2rI/5bnJ/T5+qHGKWpvVVzvXXL4WMa3c1WKB+goJe58ULFB
 /H4g4iRU9jyPdswKq3NLHGx9zCQu1ul15GuyjaShfTonktDp+wCj2AzLUCUauV5vy/V9
 qNWTf+mVzNAn1L72IWvzbH60Gp+kthnGOtV2L6PR5WGP7vUD/YMC0eaEpF6uFoEAGuL3 8Q== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3k36m1uhph-2
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6E5F4468;
        Tue, 11 Oct 2022 14:36:13 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 4/5] ALSA: hda: cs35l41: Remove suspend/resume hda hooks
Date:   Tue, 11 Oct 2022 15:35:51 +0100
Message-ID: <20221011143552.621792-5-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011143552.621792-1-sbinding@opensource.cirrus.com>
References: <20221011143552.621792-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nS4tHdMcPQQ_ZbeWtoa-BoyRFDu8lZqY
X-Proofpoint-ORIG-GUID: nS4tHdMcPQQ_ZbeWtoa-BoyRFDu8lZqY
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code uses calls from the HDA Codec driver to
determine when to suspend/resume by calling hooks via the
hda_component binding.
However, this means the cs35l41 driver relies on the HDA
Codec driver to tell it when to suspend or resume,
creating an additional external dependency, and potentially
creating race conditions in the future. It is better for
the cs35l41 hda driver to decide for itself when the part
should be suspended or resumed.
This makes supporting system suspend easier.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c   | 31 ++++++++++++-------------------
 sound/pci/hda/hda_component.h |  2 --
 sound/pci/hda/patch_realtek.c | 19 +------------------
 3 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 102ac4a94a9d6..89f6b4a28d3d7 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -487,10 +487,10 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 	struct regmap *reg = cs35l41->regmap;
 	int ret = 0;
 
-	mutex_lock(&cs35l41->fw_mutex);
-
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
+		pm_runtime_get_sync(dev);
+		mutex_lock(&cs35l41->fw_mutex);
 		cs35l41->playback_started = true;
 		if (cs35l41->firmware_running) {
 			regmap_multi_reg_write(reg, cs35l41_hda_config_dsp,
@@ -508,15 +508,21 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 					 CS35L41_AMP_EN_MASK, 1 << CS35L41_AMP_EN_SHIFT);
 		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
 			regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00008001);
+		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
+		mutex_lock(&cs35l41->fw_mutex);
 		ret = cs35l41_global_enable(reg, cs35l41->hw_cfg.bst_type, 1);
+		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_CLEANUP:
+		mutex_lock(&cs35l41->fw_mutex);
 		regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
 		ret = cs35l41_global_enable(reg, cs35l41->hw_cfg.bst_type, 0);
+		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
+		mutex_lock(&cs35l41->fw_mutex);
 		ret = regmap_update_bits(reg, CS35L41_PWR_CTRL2,
 					 CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
 		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
@@ -530,14 +536,16 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 		}
 		cs35l41_irq_release(cs35l41);
 		cs35l41->playback_started = false;
+		mutex_unlock(&cs35l41->fw_mutex);
+
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
 		break;
 	default:
 		dev_warn(cs35l41->dev, "Playback action not supported: %d\n", action);
 		break;
 	}
 
-	mutex_unlock(&cs35l41->fw_mutex);
-
 	if (ret)
 		dev_err(cs35l41->dev, "Regmap access fail: %d\n", ret);
 }
@@ -618,19 +626,6 @@ static int cs35l41_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int cs35l41_hda_suspend_hook(struct device *dev)
-{
-	dev_dbg(dev, "Request Suspend\n");
-	pm_runtime_mark_last_busy(dev);
-	return pm_runtime_put_autosuspend(dev);
-}
-
-static int cs35l41_hda_resume_hook(struct device *dev)
-{
-	dev_dbg(dev, "Request Resume\n");
-	return pm_runtime_get_sync(dev);
-}
-
 static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 {
 	int halo_sts;
@@ -863,8 +858,6 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	ret = cs35l41_create_controls(cs35l41);
 
 	comps->playback_hook = cs35l41_hda_playback_hook;
-	comps->suspend_hook = cs35l41_hda_suspend_hook;
-	comps->resume_hook = cs35l41_hda_resume_hook;
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index 1223621bd62ca..534e845b9cd1d 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -16,6 +16,4 @@ struct hda_component {
 	char name[HDA_MAX_NAME_SIZE];
 	struct hda_codec *codec;
 	void (*playback_hook)(struct device *dev, int action);
-	int (*suspend_hook)(struct device *dev);
-	int (*resume_hook)(struct device *dev);
 };
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4b076912bbf4b..e6c4bb5fa041a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4022,22 +4022,16 @@ static void alc5505_dsp_init(struct hda_codec *codec)
 static int alc269_suspend(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	int i;
 
 	if (spec->has_alc5505_dsp)
 		alc5505_dsp_suspend(codec);
 
-	for (i = 0; i < HDA_MAX_COMPONENTS; i++)
-		if (spec->comps[i].suspend_hook)
-			spec->comps[i].suspend_hook(spec->comps[i].dev);
-
 	return alc_suspend(codec);
 }
 
 static int alc269_resume(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	int i;
 
 	if (spec->codec_variant == ALC269_TYPE_ALC269VB)
 		alc269vb_toggle_power_output(codec, 0);
@@ -4068,10 +4062,6 @@ static int alc269_resume(struct hda_codec *codec)
 	if (spec->has_alc5505_dsp)
 		alc5505_dsp_resume(codec);
 
-	for (i = 0; i < HDA_MAX_COMPONENTS; i++)
-		if (spec->comps[i].resume_hook)
-			spec->comps[i].resume_hook(spec->comps[i].dev);
-
 	return 0;
 }
 #endif /* CONFIG_PM */
@@ -6664,19 +6654,12 @@ static int comp_bind(struct device *dev)
 {
 	struct hda_codec *cdc = dev_to_hda_codec(dev);
 	struct alc_spec *spec = cdc->spec;
-	int ret, i;
+	int ret;
 
 	ret = component_bind_all(dev, spec->comps);
 	if (ret)
 		return ret;
 
-	if (snd_hdac_is_power_on(&cdc->core)) {
-		codec_dbg(cdc, "Resuming after bind.\n");
-		for (i = 0; i < HDA_MAX_COMPONENTS; i++)
-			if (spec->comps[i].resume_hook)
-				spec->comps[i].resume_hook(spec->comps[i].dev);
-	}
-
 	return 0;
 }
 
-- 
2.34.1

