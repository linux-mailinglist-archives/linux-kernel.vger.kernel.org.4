Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD60C6B7C64
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCMPuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjCMPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:50:41 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644166F603
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:50:27 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DEPFBo004637;
        Mon, 13 Mar 2023 10:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=uFBC8RrDMvweaYvhR9SIiEznOkshqG+7URIf1J9cblY=;
 b=SQWxBoUKgyOm4+Woig14zq6Pqiqn3rqB9hE3PZ4hrqmo6FUPt3VoqP+3m8tLnvcEuL9M
 lhnUcM566o8uaOjWNhUFUc2eDqDBCi89C5VDZOEC6raql2AZtgIjV+0HIYKSrklZslN2
 uQC3M8gH3TTXkDSHWhVzlC4cMxhS0FMu6Wvi+Uo1kFle2LNOa6meBgUgTnLGoywMEjWZ
 1BKYqqL4vq4+DDcBkmjVstjxM0tCKi0AxMaATK+vklfTnkboVM2VN8M6ZXCPgs+Bk9h2
 rXVMREdetd0zqyXj166VkA1Bat/kv62GYbSySrU7Lez/hqBGCOmXKFxd6Zhl6g6dQZo5 7g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3p8qx7b4rb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 10:50:08 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 13 Mar
 2023 10:50:06 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 13 Mar 2023 10:50:06 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 29C4111D4;
        Mon, 13 Mar 2023 15:50:06 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 5/8] ASoC: wm_adsp: Expose the DSP boot work actions as wm_adsp_power_up()
Date:   Mon, 13 Mar 2023 15:49:52 +0000
Message-ID: <20230313154955.4268-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230313154955.4268-1-rf@opensource.cirrus.com>
References: <20230313154955.4268-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -eQ75dyvAxc0ImGZY-ylhOGSWyzVnwuc
X-Proofpoint-GUID: -eQ75dyvAxc0ImGZY-ylhOGSWyzVnwuc
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

To support self-booting DSPs that are considered always running, the work
that is usually invoked as part of a DAPM sequence needs to be triggered
by a client of wm_adsp as part of it's startup sequence.

These actions load firmware files that might create ALSA controls and
apply configuration to the device.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 27 ++++++++++++++++++---------
 sound/soc/codecs/wm_adsp.h |  2 ++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 8176b6173de9..d4bffa2f7005 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -998,11 +998,8 @@ int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_preloader_put);
 
-static void wm_adsp_boot_work(struct work_struct *work)
+int wm_adsp_power_up(struct wm_adsp *dsp)
 {
-	struct wm_adsp *dsp = container_of(work,
-					   struct wm_adsp,
-					   boot_work);
 	int ret = 0;
 	char *wmfw_filename = NULL;
 	const struct firmware *wmfw_firmware = NULL;
@@ -1013,16 +1010,28 @@ static void wm_adsp_boot_work(struct work_struct *work)
 					     &wmfw_firmware, &wmfw_filename,
 					     &coeff_firmware, &coeff_filename);
 	if (ret)
-		return;
+		return ret;
 
-	cs_dsp_power_up(&dsp->cs_dsp,
-			wmfw_firmware, wmfw_filename,
-			coeff_firmware, coeff_filename,
-			wm_adsp_fw_text[dsp->fw]);
+	ret = cs_dsp_power_up(&dsp->cs_dsp,
+			      wmfw_firmware, wmfw_filename,
+			      coeff_firmware, coeff_filename,
+			      wm_adsp_fw_text[dsp->fw]);
 
 	wm_adsp_release_firmware_files(dsp,
 				       wmfw_firmware, wmfw_filename,
 				       coeff_firmware, coeff_filename);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wm_adsp_power_up);
+
+static void wm_adsp_boot_work(struct work_struct *work)
+{
+	struct wm_adsp *dsp = container_of(work,
+					   struct wm_adsp,
+					   boot_work);
+
+	wm_adsp_power_up(dsp);
 }
 
 int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 173dcae2c260..769904d34a87 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -91,6 +91,8 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event);
 
+int wm_adsp_power_up(struct wm_adsp *dsp);
+
 irqreturn_t wm_adsp2_bus_error(int irq, void *data);
 irqreturn_t wm_halo_bus_error(int irq, void *data);
 irqreturn_t wm_halo_wdt_expire(int irq, void *data);
-- 
2.30.2

