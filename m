Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13B070B4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjEVGRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEVGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:17:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909EACF;
        Sun, 21 May 2023 23:17:40 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M5xejK030473;
        Mon, 22 May 2023 06:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=T1vsZa8+TKi0dF3pAfw1AYXdnB3fLpyQ3b7cAWLlRqE=;
 b=OTkncq1JuA5D2jn5NjcuJq2lBwzFSdnPgvUWAlpNU/6g7LP/6oY99xHgk+w9i4Xw8EQW
 9uiX4XRtaXsi9Y002MPeezzaay11N4ljjo7Xi2pJ5aFAv2Q+dkSH0Rp7NDQ7hcrmPhe+
 d11Gfc7/ij32VVBy57l8KUBjN5TbsADYW7mRdyUp63TMwG8IygmVLOUvIhqCs1MDoP68
 /3y9sBAdenQIk7fCqvf3yfQkUXiChJN41XPocZ3+age/2mkzo7MHuv16+yf2yDuHpa3/
 So47paOK9M6AWBCWpohtrLwoQvhe/3r70LGnRqM3OuNmkoUmdLJeIEvp1BdcAfCLI2wH pA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppa1augr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:17:33 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34M6HTq1013891;
        Mon, 22 May 2023 06:17:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qpq9kefm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 06:17:29 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M6HTF6013886;
        Mon, 22 May 2023 06:17:29 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34M6HTGW013885;
        Mon, 22 May 2023 06:17:29 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 7804333B6; Mon, 22 May 2023 11:47:28 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH] venus: replace arrary index with enum for supported formats
Date:   Mon, 22 May 2023 11:47:09 +0530
Message-Id: <1684736229-30567-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A8GG-yQ9vhgoBX4V5MC5sgxWsP6pXz4a
X-Proofpoint-ORIG-GUID: A8GG-yQ9vhgoBX4V5MC5sgxWsP6pXz4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=940 phishscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220052
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use enums to list supported formats for encoder and decoder
instead of array index which was a error prone design.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.h | 16 ++++++++
 drivers/media/platform/qcom/venus/vdec.c | 63 +++++++++++++++++++-------------
 drivers/media/platform/qcom/venus/venc.c | 31 +++++++++-------
 3 files changed, 72 insertions(+), 38 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 12a42fb..e988ed4 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -83,6 +83,22 @@ struct venus_resources {
 	const char *fwname;
 };
 
+enum venus_fmt {
+	VENUS_FMT_NV12			= 0,
+	VENUS_FMT_QC08C			= 1,
+	VENUS_FMT_QC10C			= 2,
+	VENUS_FMT_H264			= 3,
+	VENUS_FMT_VP8			= 4,
+	VENUS_FMT_VP9			= 5,
+	VENUS_FMT_HEVC			= 6,
+	VENUS_FMT_VC1_ANNEX_G		= 7,
+	VENUS_FMT_VC1_ANNEX_L		= 8,
+	VENUS_FMT_MPEG4			= 9,
+	VENUS_FMT_MPEG2			= 10,
+	VENUS_FMT_H263			= 11,
+	VENUS_FMT_XVID			= 12,
+};
+
 struct venus_format {
 	u32 pixfmt;
 	unsigned int num_planes;
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index c6f0fd08..bab985b 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -30,69 +30,82 @@
  * - future firmware versions could add support for >1 planes
  */
 static const struct venus_format vdec_formats[] = {
-	{
+	[VENUS_FMT_NV12] = {
 		.pixfmt = V4L2_PIX_FMT_NV12,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
-	}, {
+	},
+	[VENUS_FMT_QC08C] = {
 		.pixfmt = V4L2_PIX_FMT_QC08C,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
-	}, {
+	},
+	[VENUS_FMT_QC10C] = {
 		.pixfmt = V4L2_PIX_FMT_QC10C,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_MPEG4,
+	},
+	[VENUS_FMT_H264] = {
+		.pixfmt = V4L2_PIX_FMT_H264,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_MPEG2,
+	},
+	[VENUS_FMT_VP8] = {
+		.pixfmt = V4L2_PIX_FMT_VP8,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_H263,
+	},
+	[VENUS_FMT_VP9] = {
+		.pixfmt = V4L2_PIX_FMT_VP9,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_G,
+	},
+	[VENUS_FMT_HEVC] = {
+		.pixfmt = V4L2_PIX_FMT_HEVC,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_L,
+	},
+	[VENUS_FMT_VC1_ANNEX_G] = {
+		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_G,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_H264,
+	},
+	[VENUS_FMT_VC1_ANNEX_L] = {
+		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_L,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_VP8,
+	},
+	[VENUS_FMT_MPEG4] = {
+		.pixfmt = V4L2_PIX_FMT_MPEG4,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_VP9,
+	},
+	[VENUS_FMT_MPEG2] = {
+		.pixfmt = V4L2_PIX_FMT_MPEG2,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_XVID,
+	},
+	[VENUS_FMT_H263] = {
+		.pixfmt = V4L2_PIX_FMT_H263,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_HEVC,
+	},
+	[VENUS_FMT_XVID] = {
+		.pixfmt = V4L2_PIX_FMT_XVID,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
 	},
+
 };
 
 static const struct venus_format *
@@ -1575,8 +1588,8 @@ static const struct hfi_inst_ops vdec_hfi_ops = {
 static void vdec_inst_init(struct venus_inst *inst)
 {
 	inst->hfi_codec = HFI_VIDEO_CODEC_H264;
-	inst->fmt_out = &vdec_formats[8];
-	inst->fmt_cap = &vdec_formats[0];
+	inst->fmt_out = &vdec_formats[VENUS_FMT_H264];
+	inst->fmt_cap = &vdec_formats[VENUS_FMT_NV12];
 	inst->width = frame_width_min(inst);
 	inst->height = ALIGN(frame_height_min(inst), 32);
 	inst->crop.left = 0;
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 4666f42..b60772c 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -32,28 +32,33 @@
  * - future firmware versions could add support for >1 planes
  */
 static const struct venus_format venc_formats[] = {
-	{
+	[VENUS_FMT_NV12] = {
 		.pixfmt = V4L2_PIX_FMT_NV12,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_MPEG4,
+	},
+	[VENUS_FMT_H264] = {
+		.pixfmt = V4L2_PIX_FMT_H264,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_H263,
+	},
+	[VENUS_FMT_VP8] = {
+		.pixfmt = V4L2_PIX_FMT_VP8,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_H264,
+	},
+	[VENUS_FMT_HEVC] = {
+		.pixfmt = V4L2_PIX_FMT_HEVC,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_VP8,
+	},
+	[VENUS_FMT_MPEG4] = {
+		.pixfmt = V4L2_PIX_FMT_MPEG4,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
-	}, {
-		.pixfmt = V4L2_PIX_FMT_HEVC,
+	},
+	[VENUS_FMT_H263] = {
+		.pixfmt = V4L2_PIX_FMT_H263,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	},
@@ -1416,8 +1421,8 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 
 static void venc_inst_init(struct venus_inst *inst)
 {
-	inst->fmt_cap = &venc_formats[3];
-	inst->fmt_out = &venc_formats[0];
+	inst->fmt_cap = &venc_formats[VENUS_FMT_H264];
+	inst->fmt_out = &venc_formats[VENUS_FMT_NV12];
 	inst->width = 1280;
 	inst->height = ALIGN(720, 32);
 	inst->out_width = 1280;
-- 
2.7.4

