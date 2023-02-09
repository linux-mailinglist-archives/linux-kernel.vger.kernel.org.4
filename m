Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A66690DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjBIQFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjBIQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:05:26 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97067663FA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:04:38 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319EawII008427;
        Thu, 9 Feb 2023 10:04:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=JeV9DULu/bW1gH3V+k/WF22Dywo9MUNw7IWa7cNIS5U=;
 b=TJQWjlQ/jaZmRV2ARvMnZekQz1N2B79jE+fpKQJIn9mZshynHj99/TeOBzNlN25nLAns
 KKUOJ6iPsjhdzyt3b5hvmHu2xw6uK13ssG/E+XbY0oiifSVK0niGNH5teIxBVOO9Qs6T
 c+QWg7zMPWjanLmHdklHn2eYd7rJLIGp8cuhjwXr9DgjudI6/EsMAfN6eatUWti5hpMk
 4ExOA78uxBJlE1j5awdgnQ8SB2P7Zx6uFrr1re4heFeZXIMwH9nbV/sTFzNPoexAUaxH
 bX3nPo+y7zgWnlz1STN6NGLthAS1Mei8oKpBxjgk2ZN0pvzthmbj1zSUj0hSMuWPoO3B /g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3nhnn807j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 10:04:15 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 9 Feb
 2023 10:04:13 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Thu, 9 Feb 2023 10:04:13 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 068972A1;
        Thu,  9 Feb 2023 16:04:13 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v1 1/3] ALSA: hda/cs35l41: Fix error condition check
Date:   Thu, 9 Feb 2023 16:04:01 +0000
Message-ID: <20230209160403.838326-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209160403.838326-1-sbinding@opensource.cirrus.com>
References: <20230209160403.838326-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RBpoePbzX5-qwAAPv-y7lqG0HAd22aEs
X-Proofpoint-ORIG-GUID: RBpoePbzX5-qwAAPv-y7lqG0HAd22aEs
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Function hda_cs_dsp_write_ctl() returns 3 possible values:
0 - no change, 1 - value has changed and -1 - error, so value 1
is not an error.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index f7815ee24f83..4dc57454201e 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -316,27 +316,27 @@ static int cs35l41_apply_calibration(struct cs35l41_hda *cs35l41, unsigned int a
 
 	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_AMBIENT_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
 				   CAL_DSP_CTL_ALG, &ambient, 4);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_AMBIENT_DSP_CTL_NAME,
 			ret);
 		return ret;
 	}
 	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_R_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
 				   CAL_DSP_CTL_ALG, &r0, 4);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_R_DSP_CTL_NAME, ret);
 		return ret;
 	}
 	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_STATUS_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
 				   CAL_DSP_CTL_ALG, &status, 4);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_STATUS_DSP_CTL_NAME,
 			ret);
 		return ret;
 	}
 	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_CHECKSUM_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
 				   CAL_DSP_CTL_ALG, &checksum, 4);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_CHECKSUM_DSP_CTL_NAME,
 			ret);
 		return ret;
-- 
2.34.1

