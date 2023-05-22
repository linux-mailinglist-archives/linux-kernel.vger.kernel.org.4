Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEC070B4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjEVGDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjEVGDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:03:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DD3FA;
        Sun, 21 May 2023 23:03:04 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M5vtfA001326;
        Mon, 22 May 2023 06:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Ue0zqBdgeGxFH6tOdBckhB9sz6k1v8PqTY0oyzZ7MCc=;
 b=g2uvyxGU6C5Y7q4+BY7As1IC/ZGvJIRcrHQpVIkde4UgDVlF3dQDWlwP+h7vQTs/Psim
 rYrDblCDnLOYBQ+z5ReJWDOFWxrUgdRhXWPZyNAn/yzqDvzibmKlHhZMzWR5Fol4YcL0
 cfGN438fsvxRWJF78q76c6UJljVdvMXI4+Iz6vRjFoytKKd8zkL6KrsI1XUsQCXWoQHG
 oOY8N8EkGUYS+a1EiKCTHfS32iVgxlzgrj7J7T7EnFtsoPgbh6YFZ2nByWUXEjHCafcM
 Ggr4jFETnDRmnry++/FVni9jI83ozss9t61ZUha1OKjiyQqzi8FRztxz5ikhgm8PnHnU eQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpkjujysp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:03:00 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34M62vgR032307;
        Mon, 22 May 2023 06:02:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qpq9keeqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 06:02:57 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M62uMI032298;
        Mon, 22 May 2023 06:02:56 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34M62uHg032295;
        Mon, 22 May 2023 06:02:56 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 1DFC63F5E; Mon, 22 May 2023 11:32:56 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH v4 1/3] venus: add firmware version based check
Date:   Mon, 22 May 2023 11:32:50 +0530
Message-Id: <1684735372-10075-2-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684735372-10075-1-git-send-email-quic_dikshita@quicinc.com>
References: <1684735372-10075-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qP4n7yLUELZ6jX9LaQlrNQa1carVtIMD
X-Proofpoint-ORIG-GUID: qP4n7yLUELZ6jX9LaQlrNQa1carVtIMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=805 priorityscore=1501 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220050
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add firmware version based checks to enable/disable
features for different SOCs.

Tested-by: Nathan Hebert <nhebert@chromium.org>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.h     | 20 +++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_msgs.c | 30 +++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 32551c2..2f2176f 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -202,6 +202,11 @@ struct venus_core {
 	unsigned int core0_usage_count;
 	unsigned int core1_usage_count;
 	struct dentry *root;
+	struct venus_img_version {
+		u32 major;
+		u32 minor;
+		u32 rev;
+	} venus_ver;
 };
 
 struct vdec_controls {
@@ -500,4 +505,19 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
 	return NULL;
 }
 
+static inline bool
+is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
+{
+	return ((core)->venus_ver.major == vmajor &&
+		(core)->venus_ver.minor == vminor &&
+		(core)->venus_ver.rev >= vrev);
+}
+
+static inline bool
+is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
+{
+	return ((core)->venus_ver.major == vmajor &&
+		(core)->venus_ver.minor == vminor &&
+		(core)->venus_ver.rev <= vrev);
+}
 #endif
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index df96db3..65c8fb3 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -248,13 +248,15 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
 }
 
 static void
-sys_get_prop_image_version(struct device *dev,
+sys_get_prop_image_version(struct venus_core *core,
 			   struct hfi_msg_sys_property_info_pkt *pkt)
 {
+	struct device *dev = core->dev;
 	u8 *smem_tbl_ptr;
 	u8 *img_ver;
 	int req_bytes;
 	size_t smem_blk_sz;
+	int ret;
 
 	req_bytes = pkt->hdr.size - sizeof(*pkt);
 
@@ -263,8 +265,30 @@ sys_get_prop_image_version(struct device *dev,
 		return;
 
 	img_ver = pkt->data;
+	if (!img_ver)
+		return;
+
+	ret = sscanf(img_ver, "14:video-firmware.%u.%u-%u",
+		     &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
+	if (ret)
+		goto done;
+
+	ret = sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u",
+		     &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
+	if (ret)
+		goto done;
+
+	ret = sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u",
+		     &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
+	if (ret)
+		goto done;
 
-	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
+	dev_err(dev, VDBGL "error reading F/W version\n");
+	return;
+
+done:
+	dev_dbg(dev, VDBGL "F/W version: %s, major %u, minor %u, revision %u\n",
+		img_ver, core->venus_ver.major, core->venus_ver.minor, core->venus_ver.rev);
 
 	smem_tbl_ptr = qcom_smem_get(QCOM_SMEM_HOST_ANY,
 		SMEM_IMG_VER_TBL, &smem_blk_sz);
@@ -286,7 +310,7 @@ static void hfi_sys_property_info(struct venus_core *core,
 
 	switch (pkt->property) {
 	case HFI_PROPERTY_SYS_IMAGE_VERSION:
-		sys_get_prop_image_version(dev, pkt);
+		sys_get_prop_image_version(core, pkt);
 		break;
 	default:
 		dev_dbg(dev, VDBGL "unknown property data\n");
-- 
2.7.4

