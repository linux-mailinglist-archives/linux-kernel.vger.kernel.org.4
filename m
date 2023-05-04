Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717CB6F692D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjEDKhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjEDKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:37:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0122349E3;
        Thu,  4 May 2023 03:36:50 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344AMrWp004012;
        Thu, 4 May 2023 10:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=n8Nqq5knuYs0m9wUvtQ0ByXIx5S1MpqjK4cnS+3hfwY=;
 b=DxW05hqVBA9dHcOhxOSPJlQl/cJdylBk+iYHcOmmBnq8I41MbNQ+caDt2EJtRPu2Y0AA
 WQdBaIwX04YYD7+PO4MequMThZswUK+yPf1NyNjoXJ7i8Pm0wNRvtRg7M6kwpMcHQ8q1
 S0+SY1x2fHMvmLwHjKNY+Pbz/mV6RsJDaepvuKyVTcCSZn4zbLJX75mNzpVwA4mUJl+J
 UVST8svdO4cn0FOwDW7JsYqjMox40NbE1JlZMrLZ40tAQW+zofONoidy1Y/M8mQ5/Qbp
 aiM25cQFTb9N5AZOZBfkOecmw3MkWgr4UWGeCNSp40BU6tbxtlmaREb+jidyx+VZa7yZ Cw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qca1j857w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 10:36:46 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 344AahtL002473;
        Thu, 4 May 2023 10:36:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3q8vakt1qh-1;
        Thu, 04 May 2023 10:36:43 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 344Aahcb002456;
        Thu, 4 May 2023 10:36:43 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 344Aagn6002451;
        Thu, 04 May 2023 10:36:43 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 3AA09BE0; Thu,  4 May 2023 16:06:42 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH 2/4] venus: update calculation for dpb buffers
Date:   Thu,  4 May 2023 16:06:37 +0530
Message-Id: <1683196599-3730-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
References: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qLvi9VwSO-0SDgYs5mrwGj--lkBtXrFx
X-Proofpoint-GUID: qLvi9VwSO-0SDgYs5mrwGj--lkBtXrFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxlogscore=619 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040086
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dpb color format, width and height of output port
for calculating buffer size of dpb buffers.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/helpers.c          | 4 ++++
 drivers/media/platform/qcom/venus/hfi_plat_bufs.h    | 3 +++
 drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c | 8 +++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 5946def..4ad6232 100644
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
index ea25c45..3855b04 100644
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
@@ -1235,7 +1236,12 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
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

