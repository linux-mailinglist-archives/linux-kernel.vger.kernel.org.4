Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAFF70B573
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjEVGxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjEVGwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:52:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E1D2690;
        Sun, 21 May 2023 23:50:13 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M6hYHO024392;
        Mon, 22 May 2023 06:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=laguvSuvD4TNDIsQCj7PU68pDJD0i4k1RzP7nL7SgP4=;
 b=dneuuB6P8B8l3ayyo71yTGRr/lB3hNtVLq/pnc5W2g9CgLOAcrd53jwkfyLZnLuWTHJo
 3RLQu0FCl/H5r113/U1QGXtiu7NdN9escmPCru0xYwcGSUfxx/b9Mhi0fyDcU5riOD9N
 mf+FURxt4F7rhc4pEuA/6olbPthm33ZLCTGQswh2CxHgokxJxvjwUTUb+vQPsc60Z4ox
 ti5/fSRZjG/rvtGugU8BWyeQiGo/LfvWqNlrw90PraeGYDFmvmbfcSmepZt2Wydk7HZ6
 h5uz4NZHEFzOYue2mZNUsmcOn+LCjpzAINBe5dWNM0gZhejFPaEUQXudSj9p6tAvuqSy ng== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpnt62vss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:48:30 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34M6mRaD009797;
        Mon, 22 May 2023 06:48:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qpq9kej0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 06:48:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M6mR83009791;
        Mon, 22 May 2023 06:48:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34M6mRQp009786;
        Mon, 22 May 2023 06:48:27 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 702473F7E; Mon, 22 May 2023 12:18:26 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 3/4] venus: add handling of bit depth change from firmwar
Date:   Mon, 22 May 2023 12:18:17 +0530
Message-Id: <1684738098-17372-4-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684738098-17372-1-git-send-email-quic_dikshita@quicinc.com>
References: <1684738098-17372-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EXevUrK1-Dyspudgh59ot-LvkJGeWQKB
X-Proofpoint-GUID: EXevUrK1-Dyspudgh59ot-LvkJGeWQKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=744 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220057
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set opb format to TP10_UWC and dpb to client set format
when bit depth change to 10 bit is detecting by firmware.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/helpers.c | 16 ++++++++++++++++
 drivers/media/platform/qcom/venus/vdec.c    |  5 ++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 7dbaa38..b543b65 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -1770,6 +1770,22 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
 	if (!caps)
 		return -EINVAL;
 
+	if (inst->bit_depth == VIDC_BITDEPTH_10 && inst->session_type == VIDC_SESSION_TYPE_DEC) {
+		found_ubwc = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
+						HFI_COLOR_FORMAT_YUV420_TP10_UBWC);
+		found = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT2, fmt);
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
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 7aeaf77..96eceda 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -736,6 +736,9 @@ static int vdec_set_work_route(struct venus_inst *inst)
 }
 
 #define is_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_UBWC_BASE))
+#define is_10bit_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_10_BIT_BASE & \
+				 HFI_COLOR_FORMAT_UBWC_BASE))
+
 
 static int vdec_output_conf(struct venus_inst *inst)
 {
@@ -783,7 +786,7 @@ static int vdec_output_conf(struct venus_inst *inst)
 		inst->opb_fmt = out2_fmt;
 		inst->dpb_buftype = HFI_BUFFER_OUTPUT;
 		inst->dpb_fmt = out_fmt;
-	} else if (is_ubwc_fmt(out2_fmt)) {
+	} else if (is_ubwc_fmt(out2_fmt) || is_10bit_ubwc_fmt(out_fmt)) {
 		inst->opb_buftype = HFI_BUFFER_OUTPUT;
 		inst->opb_fmt = out_fmt;
 		inst->dpb_buftype = HFI_BUFFER_OUTPUT2;
-- 
2.7.4

