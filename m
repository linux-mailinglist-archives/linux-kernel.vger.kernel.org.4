Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D7C6D58AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjDDGSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjDDGSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:18:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F51B8;
        Mon,  3 Apr 2023 23:18:00 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3344EFXp006230;
        Tue, 4 Apr 2023 06:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=0S7+uGNt9THphK854doV1sLggrAP6r14jqBBaKfAZFo=;
 b=kDL9KHAFdHtJwJ8/7QmsS76ybQ4xrm6LEAb5j6suCspmg5mZvuHanfF4+5tS9PJN16YL
 YUNRz6uRmPy70+hvSn5LAghbgmmnWbgoqODEGV8v5B3SuuAFpU+8NvHrt23P++ItEXII
 HJl5rZ8uFGdZANbq4TAV1loA03Oe8HZyfz8p7tUlR8rC8GWmH5RhbjvGRZ1F65gk/4T4
 Cd+8OKV4ksD0xOnWA5ScseGklS2VH484l1mICBJcjTXdJFdti7vyLKjImHoq/Dc9Rzwx
 nIilFhVd/L9f7gZEkeggeodUHiFa9Lhvm349V3OaFNdbvrmzGHKV0MpkQHrYMBHFAjei rA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pr4jm9784-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 06:17:21 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3346HG7s025891;
        Tue, 4 Apr 2023 06:17:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3ppdpkhu42-1;
        Tue, 04 Apr 2023 06:17:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3346HH5E026449;
        Tue, 4 Apr 2023 06:17:17 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3346HHv1026329;
        Tue, 04 Apr 2023 06:17:17 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 0F83732EE; Tue,  4 Apr 2023 11:47:17 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH 2/3] venus: enable sufficient sequence change support for vp9
Date:   Tue,  4 Apr 2023 11:47:11 +0530
Message-Id: <1680589032-26046-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1680589032-26046-1-git-send-email-quic_dikshita@quicinc.com>
References: <1680589032-26046-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2641QbTpnIbuXegDLPPOEe8eXNuNLruf
X-Proofpoint-GUID: 2641QbTpnIbuXegDLPPOEe8eXNuNLruf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=912 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040057
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VP9 supports resolution change at interframe.
Currenlty, if sequence change is detected at interframe and
resources are sufficient, sequence change event is not raised
by firmware to driver until the next keyframe.
This change add the HFI to notify the sequence change in this
case to driver.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Tested-by: Nathan Hebert <nhebert@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c   | 1 +
 drivers/media/platform/qcom/venus/hfi_helper.h | 2 ++
 drivers/media/platform/qcom/venus/vdec.c       | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 930b743..e2539b5 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -521,6 +521,7 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
 		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*en);
 		break;
 	}
+	case HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT:
 	case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER: {
 		struct hfi_enable *in = pdata;
 		struct hfi_enable *en = prop_data;
diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index d2d6719..20516b4 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -469,6 +469,8 @@
 #define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH			0x1003007
 #define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT			0x1003009
 #define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE			0x100300a
+#define HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT \
+								0x0100300b
 
 /*
  * HFI_PROPERTY_CONFIG_VDEC_COMMON_START
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 4ceaba3..f0394b9 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -671,6 +671,14 @@ static int vdec_set_properties(struct venus_inst *inst)
 			return ret;
 	}
 
+	/* Enabling sufficient sequence change support for VP9 */
+	if (is_fw_rev_or_newer(inst->core, 5, 4, 51)) {
+		ptype = HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT;
+		ret = hfi_session_set_property(inst, ptype, &en);
+		if (ret)
+			return ret;
+	}
+
 	ptype = HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
 	conceal = ctr->conceal_color & 0xffff;
 	conceal |= ((ctr->conceal_color >> 16) & 0xffff) << 10;
-- 
2.7.4

