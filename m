Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7F722B07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjFEP3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbjFEP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:29:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F60BAD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:29:15 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3558sEEG030588;
        Mon, 5 Jun 2023 10:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=I3l9dEf9Pxrt0iwsB+1r4Bv1ieTEMmtO3O+2uHhuyLc=;
 b=jORWHZOJiDgCTNJcVf2nFbpIbPjYqM6jy1O0lo3R5+BiNWqYEjPLTevqY4+GDauwMSAy
 z+haucZREOk5Nj/lrj30j5o8LZHquq7oPs9nis/N9hukVeOkA0jAGiU98elfWwd7JztY
 bwijaIJ0kSMCag+1Oy39ZrKF5ybgAzjzi7Srrd0xhVaqK6o1uvfNuSf4bE/9FcwzI9ul
 H/8wA8S5JU9Z9vHPGuRVmuCs73yYfiuDsw5EHkDmJ4GOgXNgVFGEllE5A9H4EFx09Qq4
 KfW8ueuMYeE2m/t9jCmRW/g2oE76evISsNCy3+ZOqktC4kPQBE7N1qedi7dMgqcGQTJP Jg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3r01xna179-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 10:29:05 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 5 Jun
 2023 16:29:03 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 5 Jun 2023 16:29:03 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (NEWNC1SL3J3.ad.cirrus.com [198.90.238.20])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F3CD1B2F;
        Mon,  5 Jun 2023 15:29:02 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 1/3] ALSA: hda: cs35l41: Clean up Firmware Load Controls
Date:   Mon, 5 Jun 2023 16:28:53 +0100
Message-ID: <20230605152855.448115-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605152855.448115-1-sbinding@opensource.cirrus.com>
References: <20230605152855.448115-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cx2g64B3zanoghmQu9UO1mb7CAd7WSF9
X-Proofpoint-GUID: cx2g64B3zanoghmQu9UO1mb7CAd7WSF9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure Firmware Load control and Firmware Type control
returns 1 when the value changes.

Remove fw_mutex from firmware load control put, since it is
unnecessary, and prevents any possibility of mutex inversion.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index b5210abb5141f..d100189e15b83 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -835,34 +835,26 @@ static int cs35l41_fw_load_ctl_put(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
 	struct cs35l41_hda *cs35l41 = snd_kcontrol_chip(kcontrol);
-	unsigned int ret = 0;
-
-	mutex_lock(&cs35l41->fw_mutex);
 
 	if (cs35l41->request_fw_load == ucontrol->value.integer.value[0])
-		goto err;
+		return 0;
 
 	if (cs35l41->fw_request_ongoing) {
 		dev_dbg(cs35l41->dev, "Existing request not complete\n");
-		ret = -EBUSY;
-		goto err;
+		return -EBUSY;
 	}
 
 	/* Check if playback is ongoing when initial request is made */
 	if (cs35l41->playback_started) {
 		dev_err(cs35l41->dev, "Cannot Load/Unload firmware during Playback\n");
-		ret = -EBUSY;
-		goto err;
+		return -EBUSY;
 	}
 
 	cs35l41->fw_request_ongoing = true;
 	cs35l41->request_fw_load = ucontrol->value.integer.value[0];
 	schedule_work(&cs35l41->fw_load_work);
 
-err:
-	mutex_unlock(&cs35l41->fw_mutex);
-
-	return ret;
+	return 1;
 }
 
 static int cs35l41_fw_type_ctl_get(struct snd_kcontrol *kcontrol,
@@ -881,8 +873,12 @@ static int cs35l41_fw_type_ctl_put(struct snd_kcontrol *kcontrol,
 	struct cs35l41_hda *cs35l41 = snd_kcontrol_chip(kcontrol);
 
 	if (ucontrol->value.enumerated.item[0] < HDA_CS_DSP_NUM_FW) {
-		cs35l41->firmware_type = ucontrol->value.enumerated.item[0];
-		return 0;
+		if (cs35l41->firmware_type != ucontrol->value.enumerated.item[0]) {
+			cs35l41->firmware_type = ucontrol->value.enumerated.item[0];
+			return 1;
+		} else {
+			return 0;
+		}
 	}
 
 	return -EINVAL;
-- 
2.34.1

