Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7126F6876
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjEDJjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjEDJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:39:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2209149DC;
        Thu,  4 May 2023 02:39:35 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3448F4ZU023960;
        Thu, 4 May 2023 09:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=gyE76KAVVxtC2ZYI2xWbVFQqw8nDbeeuFh1hMTGYRhc=;
 b=bkcYHKunRA8kcFag57KxrDu8z900oHzDegTck12+dVgUE7znJ1LhW9F+qm7VjWY5riEP
 ryd7Es1yZuQUkxL++CJkeYutaikNAGfwUFqFM26vShXM9wElotvdtfQAX5haveCQkUwU
 z2eAl0oAus1TBALnr8ZPEQww5ps0jvKL4slGLzuu7Y5CNpwcSa2XZZW2o6yTb9juq+t1
 tVNELBb2wcXyWwTXTj+lvhEZZgRijlhVeVzzZZMLqtebgritSQl/u6PAVVJGebAeGdgK
 IBqvfIymoKPoKvDMpTq5smqTqEN6qqoE9hBRXvm6DVH/gUFPnX14aZgM/uqwpEGip1cs qQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbn0aak4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 09:39:31 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3449dRPn014323;
        Thu, 4 May 2023 09:39:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3q8vaksvr7-1;
        Thu, 04 May 2023 09:39:27 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3449dRsT014317;
        Thu, 4 May 2023 09:39:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3449dRiP014316;
        Thu, 04 May 2023 09:39:27 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id B926236CA; Thu,  4 May 2023 15:09:26 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH v3 1/3] venus: add firmware version based check
Date:   Thu,  4 May 2023 15:09:10 +0530
Message-Id: <1683193152-5808-2-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683193152-5808-1-git-send-email-quic_dikshita@quicinc.com>
References: <1683193152-5808-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l5MvXY7wtNgdVypWyT--NgfkyO4S0v8O
X-Proofpoint-ORIG-GUID: l5MvXY7wtNgdVypWyT--NgfkyO4S0v8O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=732 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add firmware version based checks to enable/disable
features for different SOCs.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Tested-by: Nathan Hebert <nhebert@chromium.org>
---
 drivers/media/platform/qcom/venus/core.h     | 20 ++++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_msgs.c | 27 +++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 32551c2..2f2176f 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -202,6 +202,11 @@ struct venus_core {
 	unsigned int core0_usage_count;
 	unsigned int core1_usage_count;
 	struct dentry *root;
+	struct venus_img_version {
+		u32 major;
+		u32 minor;
+		u32 rev;
+	} venus_ver;
 };
 
 struct vdec_controls {
@@ -500,4 +505,19 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
 	return NULL;
 }
 
+static inline bool
+is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
+{
+	return ((core)->venus_ver.major == vmajor &&
+		(core)->venus_ver.minor == vminor &&
+		(core)->venus_ver.rev >= vrev);
+}
+
+static inline bool
+is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
+{
+	return ((core)->venus_ver.major == vmajor &&
+		(core)->venus_ver.minor == vminor &&
+		(core)->venus_ver.rev <= vrev);
+}
 #endif
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index df96db3..4854863 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -248,13 +248,16 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
 }
 
 static void
-sys_get_prop_image_version(struct device *dev,
+sys_get_prop_image_version(struct venus_core *core,
 			   struct hfi_msg_sys_property_info_pkt *pkt)
 {
+	struct device *dev = core->dev;
 	u8 *smem_tbl_ptr;
 	u8 *img_ver;
 	int req_bytes;
 	size_t smem_blk_sz;
+	int ret;
+	u8 *ver_str;
 
 	req_bytes = pkt->hdr.size - sizeof(*pkt);
 
@@ -263,6 +266,26 @@ sys_get_prop_image_version(struct device *dev,
 		return;
 
 	img_ver = pkt->data;
+	if (IS_V6(core) && core->res->num_vpp_pipes == 1) {
+		ret = sscanf(img_ver, "14:video-firmware.%u.%u-%u",
+			     &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
+		if (ret != 2) {
+			dev_dbg(dev, VDBGL "error reading F/W version\n");
+			return;
+		}
+	} else {
+		if (IS_V6(core))
+			ver_str = "14:VIDEO.VPU.%u.%u-%u";
+		else
+			ver_str = "14:VIDEO.VE.%u.%u-%u";
+
+		ret = sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u",
+			     &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
+		if (ret != 3) {
+			dev_dbg(dev, VDBGL "error reading F/W version\n");
+			return;
+		}
+	}
 
 	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
 
@@ -286,7 +309,7 @@ static void hfi_sys_property_info(struct venus_core *core,
 
 	switch (pkt->property) {
 	case HFI_PROPERTY_SYS_IMAGE_VERSION:
-		sys_get_prop_image_version(dev, pkt);
+		sys_get_prop_image_version(core, pkt);
 		break;
 	default:
 		dev_dbg(dev, VDBGL "unknown property data\n");
-- 
2.7.4

