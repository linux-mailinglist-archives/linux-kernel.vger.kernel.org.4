Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3D710F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbjEYPHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbjEYPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:07:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D008197
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:07:29 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PEE1Bs025343;
        Thu, 25 May 2023 10:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=zSkleEFb1sYYKGX1TRaMv5H+zoDafqbPYbhdjt5L+FM=;
 b=QwvgbQ1oFcDyeXIpe+06/55UFx3wQtEfdWP6ictmYTlKxq3UuTRF3dpNMytbmzKHakDk
 zuTNPqihuiVsPh2Qojj9rlyWPrxrk28ybX5apej5MX3IADvi/lTXOJRcX21HTfc6ZugP
 M4X84YPbRFPyBJWLUH8dxeHXZ8MK2Mep3c+LqKmYo+/XH2w+nGf+D2l1vdE2RZ72vN3W
 kJsC5MxRytECxkp/n9t85vpYsQ4N4kdrofLiL8psDkkm+DSyGX9aL9EgZI4RQHCuV3Le
 hzQRElKB2QfneLiKBKno0lY6xX9M7E4CGZgRvFRBnF4dBlBFX2Mm/RGCr/PLFzulf59d ng== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm70m4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 10:07:05 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 10:07:02 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 25 May 2023 10:07:02 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DB59A11D4;
        Thu, 25 May 2023 15:07:01 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 02/13] ASoC: cs35l56: Make cs35l56_system_reset() code more generic
Date:   Thu, 25 May 2023 16:06:48 +0100
Message-ID: <20230525150659.25409-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525150659.25409-1-rf@opensource.cirrus.com>
References: <20230525150659.25409-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CDhFn8BLYtuBr7JRV5k3m0-jXuw2os5f
X-Proofpoint-GUID: CDhFn8BLYtuBr7JRV5k3m0-jXuw2os5f
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

The function can be more easily reused in HDA if the tracking of whether
a soft reset is being performed and whether the device is connected to a
SoundWire bus is moved out of the function.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 4d41c4b040a4..76cc9110d4e0 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -805,10 +805,8 @@ static const struct reg_sequence cs35l56_system_reset_seq[] = {
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
 };
 
-static void cs35l56_system_reset(struct cs35l56_private *cs35l56)
+static void cs35l56_system_reset(struct cs35l56_private *cs35l56, bool is_soundwire)
 {
-	cs35l56->soft_resetting = true;
-
 	/*
 	 * Must enter cache-only first so there can't be any more register
 	 * accesses other than the controlled system reset sequence below.
@@ -819,7 +817,7 @@ static void cs35l56_system_reset(struct cs35l56_private *cs35l56)
 					ARRAY_SIZE(cs35l56_system_reset_seq));
 
 	/* On SoundWire the registers won't be accessible until it re-enumerates. */
-	if (cs35l56->sdw_peripheral)
+	if (is_soundwire)
 		return;
 
 	usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
@@ -886,7 +884,8 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56)
 
 	init_completion(&cs35l56->init_completion);
 
-	cs35l56_system_reset(cs35l56);
+	cs35l56->soft_resetting = true;
+	cs35l56_system_reset(cs35l56, !!cs35l56->sdw_peripheral);
 
 	if (cs35l56->sdw_peripheral) {
 		/*
@@ -1550,7 +1549,8 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 
 	if (!cs35l56->base.reset_gpio) {
 		dev_dbg(cs35l56->base.dev, "No reset gpio: using soft reset\n");
-		cs35l56_system_reset(cs35l56);
+		cs35l56->soft_resetting = true;
+		cs35l56_system_reset(cs35l56, !!cs35l56->sdw_peripheral);
 		if (cs35l56->sdw_peripheral) {
 			/* Keep alive while we wait for re-enumeration */
 			pm_runtime_get_noresume(cs35l56->base.dev);
-- 
2.30.2

