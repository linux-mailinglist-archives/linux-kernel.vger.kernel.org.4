Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5170B56E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjEVGxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjEVGwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:52:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183AD1728;
        Sun, 21 May 2023 23:49:59 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M6lXw1022118;
        Mon, 22 May 2023 06:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=B1CgYnt3+WZI2EobkSysrBV6Vrn+SDToOcc5pOrclZk=;
 b=ItuuCXiPAFP74S0uisBMsxJKB0pBanjyFrseKrtOGYCKvTaSJcUiQ/2gsw0PaIDpeCGY
 hO055QPRSeLm0UqFIZOWxvfmFrkRKX7WpqSM52kcj6Cr5Jy14p9EaKtuQdAfYfz1LLoc
 HMiQ9aZBO8vQ4BY4CCltSHOZJdBz9hLvUyN3inDiudJN6R7/xMjTNCCdH3oTJQBnuAyX
 7aeH8GiyeN6FsMAoIS3pi9S1TAULXXjIOodyiC3xw4tzL5j9mYyF+sKP29lhfhWQImsN
 Cou9Ij+Ar1+y+eT1Kv8nH2l/dDHThkxev26kiH3O+tzuY/6Lc2ib3cUn2ewpsHivta5+ 1g== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppypasca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:48:30 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34M6mKHZ009736;
        Mon, 22 May 2023 06:48:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qpq9kej06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 06:48:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M6mQlA009780;
        Mon, 22 May 2023 06:48:26 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34M6mQHr009778;
        Mon, 22 May 2023 06:48:26 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id AA0723F5C; Mon, 22 May 2023 12:18:25 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 2/4] venus: update calculation for dpb buffers
Date:   Mon, 22 May 2023 12:18:16 +0530
Message-Id: <1684738098-17372-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684738098-17372-1-git-send-email-quic_dikshita@quicinc.com>
References: <1684738098-17372-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LhJfuEQfzsL7fWGjh9AEdtHG7l9Asr8K
X-Proofpoint-GUID: LhJfuEQfzsL7fWGjh9AEdtHG7l9Asr8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=728 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220057
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dpb color format, width and height of output port
for calculating buffer size of dpb buffers.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/helpers.c          |  4 ++++
 drivers/media/platform/qcom/venus/hfi_plat_bufs.h    |  3 +++
 drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c | 11 ++++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 9a38b36..7dbaa38 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -641,12 +641,16 @@ static int platform_get_bufreq(struct venus_inst *inst, u32 buftype,
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
index a9be31e..e97ff8cf 100644
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
@@ -1230,12 +1231,16 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
 			calculate_dec_input_frame_size(width, height, codec,
 						       max_mbs_per_frame,
 						       buffer_size_limit);
-	} else if (buftype == HFI_BUFFER_OUTPUT ||
-		   buftype == HFI_BUFFER_OUTPUT2) {
+	} else if (buftype == HFI_BUFFER_OUTPUT || buftype == HFI_BUFFER_OUTPUT2) {
 		bufreq->count_min = out_min_count;
 		bufreq->size =
 			venus_helper_get_framesz_raw(params->hfi_color_fmt,
-						     width, height);
+						     out_width, out_height);
+		if (buftype == HFI_BUFFER_OUTPUT &&
+		    params->dec.is_secondary_output)
+			bufreq->size =
+				venus_helper_get_framesz_raw(params->hfi_dpb_color_fmt,
+							     out_width, out_height);
 	} else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH(version)) {
 		bufreq->size = dec_ops->scratch(width, height, is_interlaced);
 	} else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH_1(version)) {
-- 
2.7.4

