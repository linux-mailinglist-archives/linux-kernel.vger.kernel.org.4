Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A87270B56B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjEVGw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjEVGwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:52:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E62172A;
        Sun, 21 May 2023 23:49:55 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M4fM94008241;
        Mon, 22 May 2023 06:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=SNn8f4hLF+a1WlR8DDfHSRY2Av+F8To99R9bfShkG5U=;
 b=HHNhYEB5AZtKD7+KxGhpINiT6PdwhRGVi/LB1AtL8+iTCUSMDk5BbK4yBa3H31SipDVl
 WN3msi9jqkE1ksB/h4kAQw08OgGe3uKsy7xjPZMDowlbj8haNJr2L+IrGJc/uvZBOzO/
 lkTiCSmXQl5Fo9gOWaELYW1jiu9QgzqokuRYEDd0qfElSLV+i+ETGWW55Svug2M8GXk6
 icCM3btprQW16LWCxZacLI2jxb/R3+7McNjakfCJt03Pt7BdoXJ5tQuPieLX4cuuyI4p
 EPaZRKCXu3zlxj8SpSKyR0c0aG5JPzNRoOO/3hxX0lJa3N7xqagd6pGG0l1wsn0Bw8nE WA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppypasc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:48:29 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34M6mPM8009773;
        Mon, 22 May 2023 06:48:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qpq9kej00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 06:48:25 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M6mPUV009767;
        Mon, 22 May 2023 06:48:25 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34M6mPSV009766;
        Mon, 22 May 2023 06:48:25 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 8E3973F5C; Mon, 22 May 2023 12:18:24 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 1/4] venus: add support for V4L2_PIX_FMT_P010 color format
Date:   Mon, 22 May 2023 12:18:15 +0530
Message-Id: <1684738098-17372-2-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684738098-17372-1-git-send-email-quic_dikshita@quicinc.com>
References: <1684738098-17372-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pi1ai2hbdUSTPvmvZkkJOOUrLSXLRLOf
X-Proofpoint-GUID: pi1ai2hbdUSTPvmvZkkJOOUrLSXLRLOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=993 phishscore=0 impostorscore=0
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

add V4L2_PIX_FMT_P010 as supported color format for decoder.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.h    | 21 +++++++++++----------
 drivers/media/platform/qcom/venus/helpers.c |  2 ++
 drivers/media/platform/qcom/venus/vdec.c    |  5 +++++
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index e988ed4..250342d 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -87,16 +87,17 @@ enum venus_fmt {
 	VENUS_FMT_NV12			= 0,
 	VENUS_FMT_QC08C			= 1,
 	VENUS_FMT_QC10C			= 2,
-	VENUS_FMT_H264			= 3,
-	VENUS_FMT_VP8			= 4,
-	VENUS_FMT_VP9			= 5,
-	VENUS_FMT_HEVC			= 6,
-	VENUS_FMT_VC1_ANNEX_G		= 7,
-	VENUS_FMT_VC1_ANNEX_L		= 8,
-	VENUS_FMT_MPEG4			= 9,
-	VENUS_FMT_MPEG2			= 10,
-	VENUS_FMT_H263			= 11,
-	VENUS_FMT_XVID			= 12,
+	VENUS_FMT_P010			= 3,
+	VENUS_FMT_H264			= 4,
+	VENUS_FMT_VP8			= 5,
+	VENUS_FMT_VP9			= 6,
+	VENUS_FMT_HEVC			= 7,
+	VENUS_FMT_VC1_ANNEX_G		= 8,
+	VENUS_FMT_VC1_ANNEX_L		= 9,
+	VENUS_FMT_MPEG4			= 10,
+	VENUS_FMT_MPEG2			= 11,
+	VENUS_FMT_H263			= 12,
+	VENUS_FMT_XVID			= 13,
 };
 
 struct venus_format {
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index a2ceab7..9a38b36 100644
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
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index bab985b..7aeaf77 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -45,6 +45,11 @@ static const struct venus_format vdec_formats[] = {
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	},
+	[VENUS_FMT_P010] = {
+		.pixfmt = V4L2_PIX_FMT_P010,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	},
 	[VENUS_FMT_H264] = {
 		.pixfmt = V4L2_PIX_FMT_H264,
 		.num_planes = 1,
-- 
2.7.4

