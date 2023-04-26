Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BA6EEEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbjDZHBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbjDZHAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:00:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA335AC;
        Wed, 26 Apr 2023 00:00:36 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33Q34wA3004689;
        Wed, 26 Apr 2023 07:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=qo4WKRh1ielD2GmzBgFz0jRL03eeC4YF6ehlpz+iMMA=;
 b=mzI/GNL2XzvYHO573Le5qoCYsN05DdWu3ePSQodirzkKNiP3qRPty0UDY8r6pfHrbmIS
 fQMXkb9foCVBoIawrFEK7yk0jUEdjh0eCU1Ggx8eueNyOuNXKIqYiUqrPKpkEURcYqoz
 Oc/Vpb9wZeuT7CECK7R6X8QgfVWIwuy934swnpr7s1flxTA7NTeyXTYQVhFwjgE8T4SF
 wRTSQ3hwGKBu9THBQ5rxbPdCWr0TokOBmbDb8raRD9RzK0ktLoyjxqqRXBasvMi4TrZ5
 VFZpHERaOFW/aOgXEgavKzj1AheZLACIJbjS4jYC3yEKi3iImDo6/cJUQiUXgLxcaTwU PQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q6fs2t5du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 07:00:31 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33Q70RDZ001770;
        Wed, 26 Apr 2023 07:00:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3q48nkq4k8-1;
        Wed, 26 Apr 2023 07:00:27 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33Q70RuI001765;
        Wed, 26 Apr 2023 07:00:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 33Q70RXc001764;
        Wed, 26 Apr 2023 07:00:27 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 7037E339D; Wed, 26 Apr 2023 12:30:26 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH] venus: add support for 10 bit decoding.
Date:   Wed, 26 Apr 2023 12:30:17 +0530
Message-Id: <1682492417-20496-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hDHBH8d4tcJNp5o3ccrkcV3GgBF74FIP
X-Proofpoint-ORIG-GUID: hDHBH8d4tcJNp5o3ccrkcV3GgBF74FIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_02,2023-04-26_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=955 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260063
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add support for V4L2_PIX_FMT_P010 color format.
- Add handling of bit depth change from firmware.
- Return P010 as preferred format for 10 bit decode.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/helpers.c        | 25 ++++++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_plat_bufs.h  |  3 +++
 .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |  9 +++++++-
 drivers/media/platform/qcom/venus/vdec.c           | 18 +++++++++++++---
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index ab6a29f..193215c 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -612,6 +612,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
 		return HFI_COLOR_FORMAT_NV12_UBWC;
 	case V4L2_PIX_FMT_QC10C:
 		return HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
+	case V4L2_PIX_FMT_P010:
+		return HFI_COLOR_FORMAT_P010;
 	default:
 		break;
 	}
@@ -639,12 +641,16 @@ static int platform_get_bufreq(struct venus_inst *inst, u32 buftype,
 	if (is_dec) {
 		params.width = inst->width;
 		params.height = inst->height;
+		params.out_width = inst->out_width;
+		params.out_height = inst->out_height;
 		params.codec = inst->fmt_out->pixfmt;
 		params.hfi_color_fmt = to_hfi_raw_fmt(inst->fmt_cap->pixfmt);
 		params.dec.max_mbs_per_frame = mbs_per_frame_max(inst);
 		params.dec.buffer_size_limit = 0;
 		params.dec.is_secondary_output =
 			inst->opb_buftype == HFI_BUFFER_OUTPUT2;
+		if (params.dec.is_secondary_output)
+			params.hfi_dpb_color_fmt = inst->dpb_fmt;
 		params.dec.is_interlaced =
 			inst->pic_struct != HFI_INTERLACE_FRAME_PROGRESSIVE;
 	} else {
@@ -1764,6 +1770,25 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
 	if (!caps)
 		return -EINVAL;
 
+	if (inst->bit_depth == VIDC_BITDEPTH_10 &&
+	    inst->session_type == VIDC_SESSION_TYPE_DEC) {
+		found_ubwc =
+			find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
+					   HFI_COLOR_FORMAT_YUV420_TP10_UBWC);
+		found = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT2,
+					   fmt);
+		if (found_ubwc && found) {
+			/*
+			 * Hard-code DPB buffers to be 10bit UBWC
+			 * until V4L2 is able to expose compressed/tiled
+			 * formats to applications.
+			 */
+			*out_fmt = HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
+			*out2_fmt = fmt;
+			return 0;
+		}
+	}
+
 	if (ubwc) {
 		ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
 		found_ubwc = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
index 52a51a3..25e6074 100644
--- a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
+++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
@@ -12,8 +12,11 @@
 struct hfi_plat_buffers_params {
 	u32 width;
 	u32 height;
+	u32 out_width;
+	u32 out_height;
 	u32 codec;
 	u32 hfi_color_fmt;
+	u32 hfi_dpb_color_fmt;
 	enum hfi_version version;
 	u32 num_vpp_pipes;
 	union {
diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
index ea25c45..08caab1 100644
--- a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
+++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
@@ -1185,6 +1185,7 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
 	enum hfi_version version = params->version;
 	u32 codec = params->codec;
 	u32 width = params->width, height = params->height, out_min_count;
+	u32 out_width = params->out_width, out_height = params->out_height;
 	struct dec_bufsize_ops *dec_ops;
 	bool is_secondary_output = params->dec.is_secondary_output;
 	bool is_interlaced = params->dec.is_interlaced;
@@ -1235,7 +1236,13 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
 		bufreq->count_min = out_min_count;
 		bufreq->size =
 			venus_helper_get_framesz_raw(params->hfi_color_fmt,
-						     width, height);
+						     out_width, out_height);
+
+		if (buftype == HFI_BUFFER_OUTPUT &&
+		    params->dec.is_secondary_output)
+			bufreq->size =
+				venus_helper_get_framesz_raw(params->hfi_dpb_color_fmt,
+							     out_width, out_height);
 	} else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH(version)) {
 		bufreq->size = dec_ops->scratch(width, height, is_interlaced);
 	} else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH_1(version)) {
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 4ceaba3..99d0e96 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -43,6 +43,10 @@ static const struct venus_format vdec_formats[] = {
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	}, {
+		.pixfmt = V4L2_PIX_FMT_P010,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	}, {
 		.pixfmt = V4L2_PIX_FMT_MPEG4,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
@@ -697,6 +701,9 @@ static int vdec_set_work_route(struct venus_inst *inst)
 }
 
 #define is_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_UBWC_BASE))
+#define is_10bit_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_10_BIT_BASE & \
+				    HFI_COLOR_FORMAT_UBWC_BASE))
+
 
 static int vdec_output_conf(struct venus_inst *inst)
 {
@@ -744,7 +751,7 @@ static int vdec_output_conf(struct venus_inst *inst)
 		inst->opb_fmt = out2_fmt;
 		inst->dpb_buftype = HFI_BUFFER_OUTPUT;
 		inst->dpb_fmt = out_fmt;
-	} else if (is_ubwc_fmt(out2_fmt)) {
+	} else if (is_ubwc_fmt(out2_fmt) || is_10bit_ubwc_fmt(out_fmt)) {
 		inst->opb_buftype = HFI_BUFFER_OUTPUT;
 		inst->opb_fmt = out_fmt;
 		inst->dpb_buftype = HFI_BUFFER_OUTPUT2;
@@ -1420,7 +1427,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
 static void vdec_event_change(struct venus_inst *inst,
 			      struct hfi_event_data *ev_data, bool sufficient)
 {
-	static const struct v4l2_event ev = {
+	struct v4l2_event ev = {
 		.type = V4L2_EVENT_SOURCE_CHANGE,
 		.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION };
 	struct device *dev = inst->core->dev_dec;
@@ -1461,8 +1468,13 @@ static void vdec_event_change(struct venus_inst *inst,
 	inst->out_width = ev_data->width;
 	inst->out_height = ev_data->height;
 
-	if (inst->bit_depth != ev_data->bit_depth)
+	if (inst->bit_depth != ev_data->bit_depth) {
 		inst->bit_depth = ev_data->bit_depth;
+		if (inst->bit_depth == VIDC_BITDEPTH_10)
+			inst->fmt_cap = &vdec_formats[3];
+		else
+			inst->fmt_cap = &vdec_formats[0];
+	}
 
 	if (inst->pic_struct != ev_data->pic_struct)
 		inst->pic_struct = ev_data->pic_struct;
-- 
2.7.4

