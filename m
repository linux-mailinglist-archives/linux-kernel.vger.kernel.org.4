Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85B9708490
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjERPEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjERPEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:04:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D8E53
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:03:54 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IBl9Gn018534;
        Thu, 18 May 2023 10:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=if4MXmKxN3SfnqhLmxf1Quq7P4ZDofQ6rP+3VpvG0WQ=;
 b=fMuF/p+iARjNTSTcJNbumJrZX4/Bo/+ubBbiypjCMgeGgxZ+rFGbbG94Jzbb03IjUDBe
 h8EXrmKyfb54gTQl9le+5vihXtCUhACMUNuQAwVLpMCdL1xS08Bzb/QVisj+SQPxjtdI
 QRuwhhD7icwuRG+YjDtcZXKIBo4YIs+XEoy9xW8rK4s/VRIQ//FOvkbMoMWgILRH5Tqb
 eQelmCR1urApm/eGpmO7fqN9yYuZZNQmZw6pfzMjqjA4XG3zj/2KFRQ3bhTe9Qho5yhp
 uJiCTTVyOeUXNKbbLcKOxJoXVE5dTrp0AID9GfPO13uK7UnQiOVCqoPMJc5HNVDKLtKL qQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qngq1ghum-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:02:53 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 18 May
 2023 10:02:50 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 May 2023 10:02:50 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 460DD15B7;
        Thu, 18 May 2023 15:02:50 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/3] ASoC: cs35l56: In secure mode skip SHUTDOWN and RESET around fw download
Date:   Thu, 18 May 2023 16:02:50 +0100
Message-ID: <20230518150250.1121006-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230518150250.1121006-1-rf@opensource.cirrus.com>
References: <20230518150250.1121006-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jvAwPQdb-Y1Fr8jO6yD6teUP0pedceX6
X-Proofpoint-ORIG-GUID: jvAwPQdb-Y1Fr8jO6yD6teUP0pedceX6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

If the device is in secure mode it's unnecessary to send a SHUTDOWN and
SYSTEM_RESET around the firmware download. It could only be patching
insecure tunings. A tuning patch doesn't need a SHUTDOWN and only needs
a REINIT afterwards. This will reduce the overhead of exiting system
suspend in secure mode.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h    |  1 +
 sound/soc/codecs/cs35l56.c | 47 ++++++++++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 002042b1c73c..1f9713d7ca76 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -223,6 +223,7 @@
 
 #define CS35L56_MBOX_CMD_AUDIO_PLAY			0x0B000001
 #define CS35L56_MBOX_CMD_AUDIO_PAUSE			0x0B000002
+#define CS35L56_MBOX_CMD_AUDIO_REINIT			0x0B000003
 #define CS35L56_MBOX_CMD_HIBERNATE_NOW			0x02000001
 #define CS35L56_MBOX_CMD_WAKEUP				0x02000002
 #define CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE		0x02000003
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 255c442308f2..3c07bd1e959e 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -825,19 +825,23 @@ static void cs35l56_system_reset(struct cs35l56_private *cs35l56)
 	regcache_cache_only(cs35l56->regmap, false);
 }
 
-static void cs35l56_dsp_work(struct work_struct *work)
+static void cs35l56_secure_patch(struct cs35l56_private *cs35l56)
+{
+	int ret;
+
+	/* Use wm_adsp to load and apply the firmware patch and coefficient files */
+	ret = wm_adsp_power_up(&cs35l56->dsp);
+	if (ret)
+		dev_dbg(cs35l56->dev, "%s: wm_adsp_power_up ret %d\n", __func__, ret);
+	else
+		cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_AUDIO_REINIT);
+}
+
+static void cs35l56_patch(struct cs35l56_private *cs35l56)
 {
-	struct cs35l56_private *cs35l56 = container_of(work,
-						       struct cs35l56_private,
-						       dsp_work);
 	unsigned int reg;
 	unsigned int val;
-	int ret = 0;
-
-	if (!cs35l56->init_done)
-		return;
-
-	pm_runtime_get_sync(cs35l56->dev);
+	int ret;
 
 	/*
 	 * Disable SoundWire interrupts to prevent race with IRQ work.
@@ -910,6 +914,29 @@ static void cs35l56_dsp_work(struct work_struct *work)
 		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1,
 				CS35L56_SDW_INT_MASK_CODEC_IRQ);
 	}
+}
+
+static void cs35l56_dsp_work(struct work_struct *work)
+{
+	struct cs35l56_private *cs35l56 = container_of(work,
+						       struct cs35l56_private,
+						       dsp_work);
+
+	if (!cs35l56->init_done)
+		return;
+
+	pm_runtime_get_sync(cs35l56->dev);
+
+	/*
+	 * When the device is running in secure mode the firmware files can
+	 * only contain insecure tunings and therefore we do not need to
+	 * shutdown the firmware to apply them and can use the lower cost
+	 * reinit sequence instead.
+	 */
+	if (cs35l56->secured)
+		cs35l56_secure_patch(cs35l56);
+	else
+		cs35l56_patch(cs35l56);
 
 	pm_runtime_mark_last_busy(cs35l56->dev);
 	pm_runtime_put_autosuspend(cs35l56->dev);
-- 
2.30.2

