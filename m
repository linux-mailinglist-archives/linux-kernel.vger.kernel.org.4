Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A95A69489C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjBMOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjBMOub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:50:31 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5331BADE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:50:27 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D5v5Z4009266;
        Mon, 13 Feb 2023 08:50:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=oivy1ExM1xF7alvWxcWK8c/YVtlPEJ4ySSrAjKcVL8k=;
 b=ZEnwis+PgHe1dt6LH9bRrs3KBRtKktsmN7jrVFpQYr/iQx7tVXWBruN5wi3XtDgSaLge
 mCMGGMeHqh1Af4cN/RK9sLEMiIHcsnZMA05v8Kden6kfsewVCBE5iV3PyhUGxfKIpyGk
 tUD0AoLZKucswQ8MlIBBSbFIItD+FlRkfHdyD0pQJGtJ92kakWZCDJeRCFtbSh9Siq1P
 z7Q6w7NMUFy84yhBoZpL3xo283yd2UOyVUxvkvBLYXVCZgNsFKMkfUPgt5FN46rIfRZq
 KWd+vY5fuWR9YOXPojWbZP+6ODdIz3j2OMRrMmGqoCblwFFNCjna+WP6udg3Kb1FctGM tA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3np9a72amk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 08:50:13 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 13 Feb
 2023 08:50:11 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Mon, 13 Feb 2023 08:50:11 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2D40411AC;
        Mon, 13 Feb 2023 14:50:11 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 3/3] ALSA: hda: cs35l41: Enable Amp High Pass Filter
Date:   Mon, 13 Feb 2023 14:50:08 +0000
Message-ID: <20230213145008.1215849-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213145008.1215849-1-sbinding@opensource.cirrus.com>
References: <20230213145008.1215849-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: URn604kHDUYiA19I5c0cEokfVJduXbxP
X-Proofpoint-ORIG-GUID: URn604kHDUYiA19I5c0cEokfVJduXbxP
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps smooth out pops and clicks in the amps.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 1aad2604b9db..75020edd39e7 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -58,7 +58,7 @@ static const struct reg_sequence cs35l41_hda_config[] = {
 	{ CS35L41_DSP1_RX3_SRC,         0x00000018 }, // DSP1RX3 SRC = VMON
 	{ CS35L41_DSP1_RX4_SRC,         0x00000019 }, // DSP1RX4 SRC = IMON
 	{ CS35L41_DSP1_RX5_SRC,         0x00000020 }, // DSP1RX5 SRC = ERRVOL
-	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00000000 }, // AMP_VOL_PCM  0.0 dB
+	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00008000 }, // AMP_HPF_PCM_EN = 1, AMP_VOL_PCM  0.0 dB
 	{ CS35L41_AMP_GAIN_CTRL,	0x00000084 }, // AMP_GAIN_PCM 4.5 dB
 };
 
@@ -82,13 +82,13 @@ static const struct reg_sequence cs35l41_hda_config_dsp[] = {
 	{ CS35L41_DSP1_RX3_SRC,         0x00000018 }, // DSP1RX3 SRC = VMON
 	{ CS35L41_DSP1_RX4_SRC,         0x00000019 }, // DSP1RX4 SRC = IMON
 	{ CS35L41_DSP1_RX5_SRC,         0x00000029 }, // DSP1RX5 SRC = VBSTMON
-	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00000000 }, // AMP_VOL_PCM  0.0 dB
+	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00008000 }, // AMP_HPF_PCM_EN = 1, AMP_VOL_PCM  0.0 dB
 	{ CS35L41_AMP_GAIN_CTRL,	0x00000233 }, // AMP_GAIN_PCM = 17.5dB AMP_GAIN_PDM = 19.5dB
 };
 
 static const struct reg_sequence cs35l41_hda_mute[] = {
 	{ CS35L41_AMP_GAIN_CTRL,	0x00000000 }, // AMP_GAIN_PCM 0.5 dB
-	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_VOL_PCM Mute
+	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_HPF_PCM_EN = 1, AMP_VOL_PCM Mute
 };
 
 static void cs35l41_add_controls(struct cs35l41_hda *cs35l41)
-- 
2.34.1

