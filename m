Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B736BC913
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCPI1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCPI1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:27:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD7F1A661;
        Thu, 16 Mar 2023 01:26:48 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G8Pj3e008598;
        Thu, 16 Mar 2023 08:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=PSONzhpNIm0qzXM+ka30l3IfEm0WtSQR6bbs+PyRZSY=;
 b=n3OSh+0eMZXbCZR4HM3Js/dOyTbNREqDL0U0868N7Ddi5ism7+uCp1t52s3bgbtO/iHY
 CU6hURYpVDuxe1z0RMQ2vYar4eX2PU4divskwfZu5ns8HVKbXk00v4HAQH5PYqxSAvCo
 HMet7sZjXIPKOQQ3Mzzcv+enhbxuyzT2KJywgxHIUjEckQSDpXZIiqSfXPUNoBmrrRIu
 Hi7r5WR+Ax/yE45YwD4tm3TPb5po3BdUTEbc52Oo803CYgYRyDfwDiE3H8R1juYzxr83
 LTHGy3dnW+rkJtkvceEebTNhEbxkI0lsdq4ZL7hx33PKffbVmk699vOzCGXRXOZp7ude PQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpy8h735-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 08:26:36 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32G8QXoQ032749;
        Thu, 16 Mar 2023 08:26:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqm760m-1;
        Thu, 16 Mar 2023 08:26:33 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32G8QXJn032743;
        Thu, 16 Mar 2023 08:26:33 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32G8QXwO032741;
        Thu, 16 Mar 2023 08:26:33 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 9CA0C900889; Thu, 16 Mar 2023 13:56:32 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH] venus: Add support for min/max qp range.
Date:   Thu, 16 Mar 2023 13:56:27 +0530
Message-Id: <20230316082627.19279-2-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230316082627.19279-1-quic_vboma@quicinc.com>
References: <20230316082627.19279-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: amsZvekHb8yudt9N3yHhlJ9rCJB6Nc5Q
X-Proofpoint-ORIG-GUID: amsZvekHb8yudt9N3yHhlJ9rCJB6Nc5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_05,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160071
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viswanath Boma <quic_vboma@quicinc.com>

This change enables the support on firmware. Client's qp range
values will be set at session level by the driver.

Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c  | 27 +++++++++++-
 .../media/platform/qcom/venus/hfi_helper.h    | 18 ++++++++
 drivers/media/platform/qcom/venus/venc.c      | 41 +++++++++++++++----
 3 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 930b743f225e..98ad4f4fba0a 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -1189,6 +1189,7 @@ pkt_session_set_property_4xx(struct hfi_session_set_property_pkt *pkt,
 			     void *cookie, u32 ptype, void *pdata)
 {
 	void *prop_data;
+	int ret = 0;
 
 	if (!pkt || !cookie || !pdata)
 		return -EINVAL;
@@ -1257,7 +1258,31 @@ pkt_session_set_property_4xx(struct hfi_session_set_property_pkt *pkt,
 		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*tm);
 		break;
 	}
+	case HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE_V2: {
+		struct hfi_quantization_range_v2 *in = pdata, *range = prop_data;
+		u32 min_qp, max_qp;
 
+		min_qp = in->min_qp.qp_packed;
+		max_qp = in->max_qp.qp_packed;
+
+		/* We'll be packing in the qp, so make sure we
+		 * won't be losing data when masking
+		 */
+		if (min_qp > 0xff || max_qp > 0xff) {
+			ret = -ERANGE;
+			break;
+		}
+		range->min_qp.layer_id = 0xFF;
+		range->max_qp.layer_id = 0xFF;
+		range->min_qp.qp_packed = (min_qp & 0xFF) | ((min_qp & 0xFF) << 8) |
+			((min_qp & 0xFF) << 16);
+		range->max_qp.qp_packed = (max_qp & 0xFF) | ((max_qp & 0xFF) << 8) |
+			((max_qp & 0xFF) << 16);
+		range->min_qp.enable = 7;
+		range->max_qp.enable = 7;
+		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*range);
+		break;
+	}
 	case HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE:
 	case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER:
 	case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE:
@@ -1269,7 +1294,7 @@ pkt_session_set_property_4xx(struct hfi_session_set_property_pkt *pkt,
 		return pkt_session_set_property_3xx(pkt, cookie, ptype, pdata);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int
diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index d2d6719a2ba4..105792a68060 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -487,6 +487,11 @@
 #define HFI_PROPERTY_PARAM_VENC_SESSION_QP			0x2005006
 #define HFI_PROPERTY_PARAM_VENC_MPEG4_AC_PREDICTION		0x2005007
 #define HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE		0x2005008
+/*
+ * Note: HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE_V2 is
+ * specific to HFI_VERSION_6XX and HFI_VERSION_4XX only
+ */
+#define HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE_V2		0x2005009
 #define HFI_PROPERTY_PARAM_VENC_MPEG4_TIME_RESOLUTION		0x2005009
 #define HFI_PROPERTY_PARAM_VENC_MPEG4_SHORT_HEADER		0x200500a
 #define HFI_PROPERTY_PARAM_VENC_MPEG4_HEADER_EXTENSION		0x200500b
@@ -827,6 +832,19 @@ struct hfi_quantization_range {
 	u32 layer_id;
 };
 
+struct hfi_quantization_v2 {
+	u32 qp_packed;
+	u32 layer_id;
+	u32 enable;
+	u32 reserved[3];
+};
+
+struct hfi_quantization_range_v2 {
+	struct hfi_quantization_v2 min_qp;
+	struct hfi_quantization_v2 max_qp;
+	u32 reserved[4];
+};
+
 #define HFI_LTR_MODE_DISABLE	0x0
 #define HFI_LTR_MODE_MANUAL	0x1
 #define HFI_LTR_MODE_PERIODIC	0x2
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index cdb12546c4fa..b01da4c1d47a 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -617,6 +617,7 @@ static int venc_set_properties(struct venus_inst *inst)
 	struct hfi_idr_period idrp;
 	struct hfi_quantization quant;
 	struct hfi_quantization_range quant_range;
+	struct hfi_quantization_range_v2 quant_range_v2;
 	struct hfi_enable en;
 	struct hfi_ltr_mode ltr_mode;
 	struct hfi_intra_refresh intra_refresh = {};
@@ -825,16 +826,40 @@ static int venc_set_properties(struct venus_inst *inst)
 	if (ret)
 		return ret;
 
-	ptype = HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE;
-	if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_HEVC) {
-		quant_range.min_qp = ctr->hevc_min_qp;
-		quant_range.max_qp = ctr->hevc_max_qp;
+	if (inst->core->res->hfi_version == HFI_VERSION_4XX ||
+	    inst->core->res->hfi_version == HFI_VERSION_6XX) {
+		ptype = HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE_V2;
+
+		if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_HEVC) {
+			quant_range_v2.min_qp.qp_packed = ctr->hevc_min_qp;
+			quant_range_v2.max_qp.qp_packed = ctr->hevc_max_qp;
+		} else if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_VP8) {
+			quant_range_v2.min_qp.qp_packed = ctr->vp8_min_qp;
+			quant_range_v2.max_qp.qp_packed = ctr->vp8_max_qp;
+		} else {
+			quant_range_v2.min_qp.qp_packed = ctr->h264_min_qp;
+			quant_range_v2.max_qp.qp_packed = ctr->h264_max_qp;
+		}
+
+		ret = hfi_session_set_property(inst, ptype, &quant_range_v2);
 	} else {
-		quant_range.min_qp = ctr->h264_min_qp;
-		quant_range.max_qp = ctr->h264_max_qp;
+		ptype = HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE;
+
+		if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_HEVC) {
+			quant_range.min_qp = ctr->hevc_min_qp;
+			quant_range.max_qp = ctr->hevc_max_qp;
+		} else if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_VP8) {
+			quant_range.min_qp = ctr->vp8_min_qp;
+			quant_range.max_qp = ctr->vp8_max_qp;
+		} else {
+			quant_range.min_qp = ctr->h264_min_qp;
+			quant_range.max_qp = ctr->h264_max_qp;
+		}
+
+		quant_range.layer_id = 0;
+		ret = hfi_session_set_property(inst, ptype, &quant_range);
 	}
-	quant_range.layer_id = 0;
-	ret = hfi_session_set_property(inst, ptype, &quant_range);
+
 	if (ret)
 		return ret;
 
-- 
2.17.1

