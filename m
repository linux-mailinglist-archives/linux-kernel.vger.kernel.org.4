Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402AB6DA8F0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbjDGG00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbjDGG0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:26:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734B6AD1D;
        Thu,  6 Apr 2023 23:26:16 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3373S7dA008792;
        Fri, 7 Apr 2023 06:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=mLU8PddVay+xhpHjod+Iu7mG/cA/zsZCpaGPuS6s2BM=;
 b=lSG9g531RtIOBJNFWvWjItIox7sjxBUcrc3Av1GiRyz7VMVPaOT55Nl7MXGKXp7HkQtO
 utF0lXFTpEFtKex9OAvmLpuEnndT2vd406CdBOiJKUXCy7ipQtuo83/bvFlpWaITeuCW
 pfccarc1yNfunHDYzQuKhFbodBowXNyZorcs8gfV8AcUKgzmCysWae7Nw0kv/c6sbWT1
 9vWKULcyqvSTyqIMBFY04cQLvI+n4opi4buT1/lxo98towQ6SovXsavAsx1TWZCuRt7l
 W94gE4E1/fW6Yy70hlIGyI0gAe60ugaG+TcP/BDuGYCeEpMJcGpKDCC0J03w04DfVbpr xQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptb9wga7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 06:26:12 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3376Q9Xd014127;
        Fri, 7 Apr 2023 06:26:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3ppdpm5y99-1;
        Fri, 07 Apr 2023 06:26:09 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3376Q9t0014120;
        Fri, 7 Apr 2023 06:26:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3376Q8pb014119;
        Fri, 07 Apr 2023 06:26:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 3DDF01310; Fri,  7 Apr 2023 11:56:08 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH v2 2/3] venus: enable sufficient sequence change support for vp9
Date:   Fri,  7 Apr 2023 11:55:57 +0530
Message-Id: <1680848758-3947-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
References: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qaIUoHbTlDCTG8HLkxke85WWTKz8br72
X-Proofpoint-ORIG-GUID: qaIUoHbTlDCTG8HLkxke85WWTKz8br72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_03,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=911 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070059
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

