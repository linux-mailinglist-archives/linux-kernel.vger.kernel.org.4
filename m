Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACDB6C62EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCWJLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjCWJLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:11:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139AE193F0;
        Thu, 23 Mar 2023 02:11:09 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4awRr012202;
        Thu, 23 Mar 2023 09:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Ls1+cbacZrVEKng9VlW2DlZLGTZ4GSURvUdjpUKmHqI=;
 b=lwFr/Xq/pfeWmE+2oWQBLhgKtaRqCTdsdvqw0bxoaSVlCY4cwVrjhyVAXh/wFEK5n9Gc
 9WdjikoClCGADrBGm5NtE6N0NtIXWkhvsQjFHWy2edTbMw8SPupGdjE18Of6+XXV4soG
 GVBXOPvoo5vqjUDGpDRSjKMKxOnPDgezlMHJt3N5XVd+/iCwL020pi0StIsJfas5iTSZ
 8BTwvPrzjOwlBegxU7LOVzKaivX1H+2p19YZ2hSiAPTtTvwNv7kItcqVEcIrWtUJWA4m
 47bDdlWjs48UMPAggitumvX+wkuMDjCSvgr8438c/MOAfz5pFtV9JG5Vcj/y0q0MlI7U sg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg9naha0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 09:11:04 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9B0s1021245;
        Thu, 23 Mar 2023 09:11:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3pd6ckjf1y-1;
        Thu, 23 Mar 2023 09:11:00 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32N9B0mN021239;
        Thu, 23 Mar 2023 09:11:00 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 32N9B0MY021238;
        Thu, 23 Mar 2023 09:11:00 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 3BE9C900889; Thu, 23 Mar 2023 14:40:59 +0530 (IST)
From:   Viswanath Boma <quic_vboma@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH v2] venus: Add support for min/max qp range.
Date:   Thu, 23 Mar 2023 14:40:52 +0530
Message-Id: <20230323091052.23318-1-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pOkdxqbIZAept7sLX7-CSn3ygB9QWjJ8
X-Proofpoint-ORIG-GUID: pOkdxqbIZAept7sLX7-CSn3ygB9QWjJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230068
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently QP range set from client is not communicated to video firmware.
Add support for the QP range HFI to set the same to firmware.

Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---

since v1: addressed the review comments.

 drivers/media/platform/qcom/venus/hfi_cmds.c  | 23 +++++++++++
 .../media/platform/qcom/venus/hfi_helper.h    | 18 ++++++++
 drivers/media/platform/qcom/venus/venc.c      | 41 +++++++++++++++----
 3 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 930b743f225e..bc3f8ff05840 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -1257,7 +1257,30 @@ pkt_session_set_property_4xx(struct hfi_session_set_property_pkt *pkt,
 		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*tm);
 		break;
 	}
+	case HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE_V2: {
+		struct hfi_quantization_range_v2 *in = pdata, *range = prop_data;
+		u32 min_qp, max_qp;
+
+		min_qp = in->min_qp.qp_packed;
+		max_qp = in->max_qp.qp_packed;
 
+		/* We'll be packing in the qp, so make sure we
+		 * won't be losing data when masking
+		 */
+		if (min_qp > 0xff || max_qp > 0xff)
+			return -ERANGE;
+
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

