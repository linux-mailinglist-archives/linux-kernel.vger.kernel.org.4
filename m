Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38265FB4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJKOhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJKOg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:36:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9DC4F189
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:36:56 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B5tp62002064;
        Tue, 11 Oct 2022 09:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=NQ/a9OMWp4UgIfiyTruCdgQ6jJ8h1zM9Y2bxV++LG1U=;
 b=P2biYnYvuarL//HN/G2wGHBr+9n6aq9qxWbq9wP9qinVFpPJ3b7aB69thFdQ2f1ypARP
 bTI2BBm4dHkrzs3Hfiuk19+TvibkF4gCUwsGH31I3yNXr6VBSflMIJna3BKs2/mHCu9L
 oAgcvyxxYJef0aDbyka1QdNFTNEfXs8Ts4yUmIqzEJO0m9HqFPSlueyC5NuL3+woXW+0
 zX6HJuJ/urBIza9ZBGy0XvTSF2lhM7H034Y8RFJQXGrYKnPmGsvBy7YJmZnFvcTy1007
 MemAODPfMf2Yrz7sf8lTQw/FuBLiWNOu1K4WWpw+xTuNzvuYK1g3jkL6yyh2ia3OWyuU lw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3k36m1uhph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 09:36:15 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Tue, 11 Oct
 2022 09:36:13 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Tue, 11 Oct 2022 09:36:13 -0500
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4A210356C;
        Tue, 11 Oct 2022 14:36:13 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 3/5] ALSA: hda/cs_dsp_ctl: Fix mutex inversion when creating controls
Date:   Tue, 11 Oct 2022 15:35:50 +0100
Message-ID: <20221011143552.621792-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011143552.621792-1-sbinding@opensource.cirrus.com>
References: <20221011143552.621792-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wMZZaay4mygZ5jOgKcCefWtPfsmXzEhW
X-Proofpoint-ORIG-GUID: wMZZaay4mygZ5jOgKcCefWtPfsmXzEhW
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

Redesign the creation of ALSA controls so that the cs_dsp
pwr_lock is not held when calling snd_ctl_add(). Instead of
creating the ALSA control from the cs_dsp control_add callback,
do it after cs_dsp_power_up() has completed. The existing
functions are changed to return void instead of passing errors
back - this duplicates the original behaviour, as cs_dsp does
not abort firmware load if creation of a control fails.

It is safe to walk the control list without taking any mutex
provided that the caller is not trying to load a new firmware
or remove the driver in parallel. There is no other situation
that the list can change. So the caller can trigger creation
of ALSA controls after cs_dsp_power_up() has returned. A cs_dsp
control will have a non-NULL priv pointer if we have created
an ALSA control.

With the previous code the ALSA controls were created from
the cs_dsp control_add callback. But this is called with
pwr_lock held (as it is part of the DSP power-up sequence).
The kernel lock checking will show a mutex inversion between
this and the control creation path:

control_add
  pwr_lock held, takes controls_rwsem (in snd_ctl_add)

get/put
  controls_rwsem held, takes pwr_lock to call cs_dsp.

This is not completely theoretical. Although the time window
is very small, it is possible for these to run in parallel
and deadlock the old implementation.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c    |  8 ++---
 sound/pci/hda/hda_cs_dsp_ctl.c | 59 ++++++++++++++++++++--------------
 sound/pci/hda/hda_cs_dsp_ctl.h |  2 +-
 3 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 3952f28537034..102ac4a94a9d6 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -91,20 +91,18 @@ static const struct reg_sequence cs35l41_hda_mute[] = {
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_VOL_PCM Mute
 };
 
-static int cs35l41_control_add(struct cs_dsp_coeff_ctl *cs_ctl)
+static void cs35l41_add_controls(struct cs35l41_hda *cs35l41)
 {
-	struct cs35l41_hda *cs35l41 = container_of(cs_ctl->dsp, struct cs35l41_hda, cs_dsp);
 	struct hda_cs_dsp_ctl_info info;
 
 	info.device_name = cs35l41->amp_name;
 	info.fw_type = cs35l41->firmware_type;
 	info.card = cs35l41->codec->card;
 
-	return hda_cs_dsp_control_add(cs_ctl, &info);
+	hda_cs_dsp_add_controls(&cs35l41->cs_dsp, &info);
 }
 
 static const struct cs_dsp_client_ops client_ops = {
-	.control_add = cs35l41_control_add,
 	.control_remove = hda_cs_dsp_control_remove,
 };
 
@@ -435,6 +433,8 @@ static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
 	if (ret)
 		goto err_release;
 
+	cs35l41_add_controls(cs35l41);
+
 	ret = cs35l41_save_calibration(cs35l41);
 
 err_release:
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 75fb691858172..1622a22f96f6a 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -97,7 +97,7 @@ static unsigned int wmfw_convert_flags(unsigned int in)
 	return out;
 }
 
-static int hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char *name)
+static void hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char *name)
 {
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
 	struct snd_kcontrol_new kcontrol = {0};
@@ -107,7 +107,7 @@ static int hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char
 	if (cs_ctl->len > ADSP_MAX_STD_CTRL_SIZE) {
 		dev_err(cs_ctl->dsp->dev, "KControl %s: length %zu exceeds maximum %d\n", name,
 			cs_ctl->len, ADSP_MAX_STD_CTRL_SIZE);
-		return -EINVAL;
+		return;
 	}
 
 	kcontrol.name = name;
@@ -120,24 +120,21 @@ static int hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char
 	/* Save ctl inside private_data, ctl is owned by cs_dsp,
 	 * and will be freed when cs_dsp removes the control */
 	kctl = snd_ctl_new1(&kcontrol, (void *)ctl);
-	if (!kctl) {
-		ret = -ENOMEM;
-		return ret;
-	}
+	if (!kctl)
+		return;
 
 	ret = snd_ctl_add(ctl->card, kctl);
 	if (ret) {
 		dev_err(cs_ctl->dsp->dev, "Failed to add KControl %s = %d\n", kcontrol.name, ret);
-		return ret;
+		return;
 	}
 
 	dev_dbg(cs_ctl->dsp->dev, "Added KControl: %s\n", kcontrol.name);
 	ctl->kctl = kctl;
-
-	return 0;
 }
 
-int hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl, struct hda_cs_dsp_ctl_info *info)
+static void hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl,
+				   const struct hda_cs_dsp_ctl_info *info)
 {
 	struct cs_dsp *cs_dsp = cs_ctl->dsp;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
@@ -145,13 +142,10 @@ int hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl, struct hda_cs_dsp_ct
 	const char *region_name;
 	int ret;
 
-	if (cs_ctl->flags & WMFW_CTL_FLAG_SYS)
-		return 0;
-
 	region_name = cs_dsp_mem_region_name(cs_ctl->alg_region.type);
 	if (!region_name) {
-		dev_err(cs_dsp->dev, "Unknown region type: %d\n", cs_ctl->alg_region.type);
-		return -EINVAL;
+		dev_warn(cs_dsp->dev, "Unknown region type: %d\n", cs_ctl->alg_region.type);
+		return;
 	}
 
 	ret = scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s %s %.12s %x", info->device_name,
@@ -171,22 +165,39 @@ int hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl, struct hda_cs_dsp_ct
 
 	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
 	if (!ctl)
-		return -ENOMEM;
+		return;
 
 	ctl->cs_ctl = cs_ctl;
 	ctl->card = info->card;
 	cs_ctl->priv = ctl;
 
-	ret = hda_cs_dsp_add_kcontrol(ctl, name);
-	if (ret) {
-		dev_err(cs_dsp->dev, "Error (%d) adding control %s\n", ret, name);
-		kfree(ctl);
-		return ret;
-	}
+	hda_cs_dsp_add_kcontrol(ctl, name);
+}
 
-	return 0;
+void hda_cs_dsp_add_controls(struct cs_dsp *dsp, const struct hda_cs_dsp_ctl_info *info)
+{
+	struct cs_dsp_coeff_ctl *cs_ctl;
+
+	/*
+	 * pwr_lock would cause mutex inversion with ALSA control lock compared
+	 * to the get/put functions.
+	 * It is safe to walk the list without holding a mutex because entries
+	 * are persistent and only cs_dsp_power_up() or cs_dsp_remove() can
+	 * change the list.
+	 */
+	lockdep_assert_not_held(&dsp->pwr_lock);
+
+	list_for_each_entry(cs_ctl, &dsp->ctl_list, list) {
+		if (cs_ctl->flags & WMFW_CTL_FLAG_SYS)
+			continue;
+
+		if (cs_ctl->priv)
+			continue;
+
+		hda_cs_dsp_control_add(cs_ctl, info);
+	}
 }
-EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_add, SND_HDA_CS_DSP_CONTROLS);
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_add_controls, SND_HDA_CS_DSP_CONTROLS);
 
 void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
 {
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.h b/sound/pci/hda/hda_cs_dsp_ctl.h
index 4babc69cf2f0c..2cf93359c4f23 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.h
+++ b/sound/pci/hda/hda_cs_dsp_ctl.h
@@ -29,7 +29,7 @@ struct hda_cs_dsp_ctl_info {
 
 extern const char * const hda_cs_dsp_fw_ids[HDA_CS_DSP_NUM_FW];
 
-int hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl, struct hda_cs_dsp_ctl_info *info);
+void hda_cs_dsp_add_controls(struct cs_dsp *dsp, const struct hda_cs_dsp_ctl_info *info);
 void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl);
 int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
 			 unsigned int alg, const void *buf, size_t len);
-- 
2.34.1

