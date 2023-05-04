Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DAD6F6874
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjEDJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjEDJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:39:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D304C12;
        Thu,  4 May 2023 02:39:35 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3448I8NA008958;
        Thu, 4 May 2023 09:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=LyQSYCNjRKReWAAcEI2z/ca56QcNkiq+9YhTD1jSC+w=;
 b=JeeUvYCeXFvc2chvtn7cyBRKc748cxXnQSZB8zpYF0YHQOriiUEGZfjxLfhZkAn+tMGp
 YvwBGbLtpmJ3a7EXCTtcXjTr0VdtCk94t1G4ALBJMYsPFvuyAru5hEJCwwnpAnXgWy3M
 mYkqgMSePY3M7N2dGf5iDImakPOCoEQBGbo5Rg2Rm9JgULpVLQUjIoNDoEkCHsDeu59i
 W3zd+aoYKIPq6x75TvMWPzZmRxAuElglZSUnSBIpk145i9N2ssi/aVpgLNg3jw/BLr0I
 DAYt4Uuv+yGmk5ARM0Fo02q+N/tRnvd99h7ZoZtq9UM/MUm2R0x8MWawsuIWlV2x4LfM +A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc5bn0k7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 09:39:31 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3449dS0E014336;
        Thu, 4 May 2023 09:39:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3q8vaksvrc-1;
        Thu, 04 May 2023 09:39:28 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3449dSOs014329;
        Thu, 4 May 2023 09:39:28 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3449dSDv014328;
        Thu, 04 May 2023 09:39:28 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 89C5B37B0; Thu,  4 May 2023 15:09:27 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH v3 2/3] venus: enable sufficient sequence change support for vp9
Date:   Thu,  4 May 2023 15:09:11 +0530
Message-Id: <1683193152-5808-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683193152-5808-1-git-send-email-quic_dikshita@quicinc.com>
References: <1683193152-5808-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a6hNVfWVfVlCaBLBM8MJ1wL2Hgu24zxR
X-Proofpoint-GUID: a6hNVfWVfVlCaBLBM8MJ1wL2Hgu24zxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=906 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040079
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
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
index d2d6719..2e03b6e 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -469,6 +469,8 @@
 #define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH			0x1003007
 #define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT			0x1003009
 #define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE			0x100300a
+#define HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT \
+								0x100300b
 
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

