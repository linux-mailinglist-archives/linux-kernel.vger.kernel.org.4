Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6803F6C10B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjCTLXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCTLW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:22:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5CE135
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:22:56 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K6vbPq027039;
        Mon, 20 Mar 2023 06:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Mj1tBC9kIBPSdh03nZLEaXsdWjbFpICDGatqwBjcDR4=;
 b=bcg3wtlxKi7beXgPkpq+Jp8aAKTT7N0h7WIqOj/7Hie05W/ApiBLLfSr07S56DMq8sGT
 ZZNiv3d0HvjZqzgzbw7mKD5kJjMOiW6u6YA5jmHm8mUOOLpztfLTD3MngirSYGLlN3l7
 Jk6yVeazzNcZdOVNVNwllqLgZzMf6wjUuIUPoRGUyZDl6SJN5YWqg887kh9ZsuxxSIkS
 Q29ncvG4Gp2ReRidiXHqiJNRP9zQ0F3f61tLnDR3lPoaaFJvCieqAkTwIOJs1fWGio2n
 nrum755EgaJ0be4OWvXbYD5qNs0FO0LkhM+a11ReIeigotNnteu2185KMGXL6LsEZ6WM PQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pd9qptc81-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 06:22:49 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 20 Mar
 2023 06:22:46 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 20 Mar 2023 06:22:46 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EB71E11DA;
        Mon, 20 Mar 2023 11:22:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 7/8] ASoC: wm_adsp: Simplify the logging of requested firmware files
Date:   Mon, 20 Mar 2023 11:22:44 +0000
Message-ID: <20230320112245.115720-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230320112245.115720-1-rf@opensource.cirrus.com>
References: <20230320112245.115720-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4-vDMj8DQxnFLj-v3NqArXN1mWnr6q06
X-Proofpoint-ORIG-GUID: 4-vDMj8DQxnFLj-v3NqArXN1mWnr6q06
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

