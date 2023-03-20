Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766E16C10B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjCTLXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCTLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:23:00 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFD4270F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:22:57 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K6xMZi028388;
        Mon, 20 Mar 2023 06:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=EKnDAwCfy9GRT/qvjYxeHgVu90MN/3twhG33D7PV3Pw=;
 b=jwMpr+85uOHvZl8nVQtcC2eWXwoJvGgrjBKStZteg6HYDZE40ZpIMKjtF5QusrJ8WUci
 jfDRCar1j+IvDqaq/J4LfuvkgQAsgdPB+tGU/iv+rLa8xcSgg5bdvmrcY3DGwN8AC1br
 +dP3UhDzV1QJF8VTefRPQwOKlGs2objLhXfoQtCTfN8AGMDzmq5CRwX9ViLWJeJoOh9A
 TTILbxBKNvjLR/aiIdFngER61UwSLredPxxK7WSmJPZOuwzNAiCy3m9gw1lY9pLVquzy
 1lKqtnF+z2jW1rc9i+en7YsqqEY7Iux3BLa6s0eSUvSwklG/8KkM7WQ+LfOHyi8x7rOw 5A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pd9qptc80-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 06:22:48 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 20 Mar
 2023 06:22:45 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 20 Mar 2023 06:22:45 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E4A9511D4;
        Mon, 20 Mar 2023 11:22:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 6/8] ASoC: wm_adsp: Add support for loading bin files without wmfw
Date:   Mon, 20 Mar 2023 11:22:43 +0000
Message-ID: <20230320112245.115720-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230320112245.115720-1-rf@opensource.cirrus.com>
References: <20230320112245.115720-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HexwZbFcq_TtVm_dyJI1QkMk_t5MLavq
X-Proofpoint-ORIG-GUID: HexwZbFcq_TtVm_dyJI1QkMk_t5MLavq
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

A self-booted DSP may have a file of coefficients to apply to the device
even when there is no firmware to download.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d4bffa2f7005..c23c306dc38d 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -850,8 +850,29 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 		return 0;
 	}
 
-	if (dsp->wmfw_optional)
+	if (dsp->wmfw_optional) {
+		if (system_name) {
+			if (asoc_component_prefix)
+				wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
+							      cirrus_dir, system_name,
+							      asoc_component_prefix, "bin");
+
+			if (!*coeff_firmware)
+				wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
+							      cirrus_dir, system_name,
+							      NULL, "bin");
+		}
+
+		if (!*coeff_firmware)
+			wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
+						      "", NULL, NULL, "bin");
+
+		if (!*coeff_firmware)
+			wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
+						      cirrus_dir, NULL, NULL, "bin");
+
 		return 0;
+	}
 
 	adsp_err(dsp, "Failed to request firmware <%s>%s-%s-%s<-%s<%s>>.wmfw\n",
 		 cirrus_dir, dsp->part, dsp->fwf_name, wm_adsp_fw[dsp->fw].file,
-- 
2.30.2

