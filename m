Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913456B7C63
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjCMPut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCMPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:50:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403F6F609
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:50:27 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DEPFBq004637;
        Mon, 13 Mar 2023 10:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Mj1tBC9kIBPSdh03nZLEaXsdWjbFpICDGatqwBjcDR4=;
 b=c1SVp4AbUp3oW+ggs9RuAtb0f8gyffrWZJfaNi/hacy7dOK27LwM3bu+0alzw4m2yvke
 5FbT/oRqGLTSFJT41w0DXTYDl+dzJ4PNLhFDHMFOAelJG4AbEqUEPH7gV+WWymXZVyEs
 Y52u6oeQjDq+2UWJpJlwMF8HqpCyms4M1O1bBWIj+Ls63oetvenVCS7/yIJQgnbHuHAa
 yNhOIAaYnHUOXfDt9HdXi4W0U4PlHhc9aH+oGXi8tvTQpZNnToxuw3pp3kDN+TLAh+yQ
 3kr/B1ZffpJdrgD4+Mvor3dDkE9u3L2X++tG3zzCHhW13Tkkp6uOGwn6Z9wTa4RSiFeZ BA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3p8qx7b4rb-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 10:50:09 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 13 Mar
 2023 10:50:07 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 13 Mar 2023 10:50:07 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0CC2911D4;
        Mon, 13 Mar 2023 15:50:07 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 7/8] ASoC: wm_adsp: Simplify the logging of requested firmware files
Date:   Mon, 13 Mar 2023 15:49:54 +0000
Message-ID: <20230313154955.4268-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230313154955.4268-1-rf@opensource.cirrus.com>
References: <20230313154955.4268-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jdJpG7vzcdpQp1SOId44tBGAz4moFljj
X-Proofpoint-GUID: jdJpG7vzcdpQp1SOId44tBGAz4moFljj
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

This change makes the logging of firmware files more consistent and
simplifies the code - a debug message is logged whether the requested
file was found or not and this applies to both wmfw and bin files.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index c23c306dc38d..216120b68b64 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -787,6 +787,8 @@ static int wm_adsp_request_firmware_file(struct wm_adsp *dsp,
 		adsp_dbg(dsp, "Failed to request '%s'\n", *filename);
 		kfree(*filename);
 		*filename = NULL;
+	} else {
+		adsp_dbg(dsp, "Found '%s'\n", *filename);
 	}
 
 	return ret;
@@ -807,7 +809,6 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 		if (!wm_adsp_request_firmware_file(dsp, wmfw_firmware, wmfw_filename,
 						   cirrus_dir, system_name,
 						   asoc_component_prefix, "wmfw")) {
-			adsp_dbg(dsp, "Found '%s'\n", *wmfw_filename);
 			wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
 						      cirrus_dir, system_name,
 						      asoc_component_prefix, "bin");
@@ -819,7 +820,6 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 		if (!wm_adsp_request_firmware_file(dsp, wmfw_firmware, wmfw_filename,
 						   cirrus_dir, system_name,
 						   NULL, "wmfw")) {
-			adsp_dbg(dsp, "Found '%s'\n", *wmfw_filename);
 			if (asoc_component_prefix)
 				wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
 							      cirrus_dir, system_name,
@@ -835,7 +835,6 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 
 	if (!wm_adsp_request_firmware_file(dsp, wmfw_firmware, wmfw_filename,
 					   "", NULL, NULL, "wmfw")) {
-		adsp_dbg(dsp, "Found '%s'\n", *wmfw_filename);
 		wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
 					      "", NULL, NULL, "bin");
 		return 0;
@@ -844,7 +843,6 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 	ret = wm_adsp_request_firmware_file(dsp, wmfw_firmware, wmfw_filename,
 					    cirrus_dir, NULL, NULL, "wmfw");
 	if (!ret) {
-		adsp_dbg(dsp, "Found '%s'\n", *wmfw_filename);
 		wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
 					      cirrus_dir, NULL, NULL, "bin");
 		return 0;
-- 
2.30.2

