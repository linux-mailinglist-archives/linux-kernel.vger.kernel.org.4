Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2506C10BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCTLXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCTLXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:23:01 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CFC4217
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:22:58 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K6xMZg028388;
        Mon, 20 Mar 2023 06:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=uFBC8RrDMvweaYvhR9SIiEznOkshqG+7URIf1J9cblY=;
 b=XLTS8JvAP+BIX8IRRpkDl0+rWol7YNNAXwO+BQPP6kj3hjGbXwLufRwXJUAf8PgqyG4y
 FQ1dzj4yScSj3BMTx1X9bARkWHcZaTMldC4vYaUWpo2Epqc2IddDuVkbN/2MyUhCTUF3
 SKse6P7058YaWMUppll3JkZZH12CCk9qpyJ+HIqr3O8YcrFn7walbuXF0qRxkI4iP+Fi
 hg+vH9CeuYMCvZqAi2F8HiOAs6Hvbn6m8cQUfDG4Z2JrpU9nH+1hh3hnG7/RXhFk1+iM
 95j5ZNdk70cuDAbAZnqmiSTIlPGSHa1+t2CxMLVQGZsRRDZONoCzQdiLGOnS0FQaE31X ug== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pd9qptc80-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 06:22:48 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 20 Mar
 2023 06:22:45 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 20 Mar 2023 06:22:45 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D423CB38;
        Mon, 20 Mar 2023 11:22:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 5/8] ASoC: wm_adsp: Expose the DSP boot work actions as wm_adsp_power_up()
Date:   Mon, 20 Mar 2023 11:22:42 +0000
Message-ID: <20230320112245.115720-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230320112245.115720-1-rf@opensource.cirrus.com>
References: <20230320112245.115720-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KWXUtwz3Okw7vFPhKk3rn10sUtyXJQc3
X-Proofpoint-ORIG-GUID: KWXUtwz3Okw7vFPhKk3rn10sUtyXJQc3
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

