Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E56DA8ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbjDGG0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbjDGG0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:26:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1085EA5FD;
        Thu,  6 Apr 2023 23:26:15 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33761FvX010936;
        Fri, 7 Apr 2023 06:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=dS5VeuYXriPxVH2Fth6dJvTRBBS6ORIkrXIfqrTCxKQ=;
 b=PQmsMnN8fnx1JFKTUCKvu4xVM6Nw3/kjvcKRqP3vsYxorh2x84OVUonQPOpxdQ2MLwZS
 13I8cO9C1eQVkHl/z9246DZlhzr2Yk3Y0RH5pIZlpwXN/nfu2HFWO8mdEFmpzYclXWWt
 ou2WTpIHb+LtYY0BlGLv2US/f40vmfPWDLDZIN4grsPAyP2/JPgQmVQM3LHYE4A/m5Qb
 qqbaUd/A4KJi12pqGElWLRItyuROng2puL3zssgcr5dHzp4JQBY2d4JnvTmi2Z2gyC9f
 a4q0tkaFO7NXInThYx+SbUtaFpCmfS17MWki5RDNhK+mtwnlTAKufRdU68Wgm9d/u2hp dg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptb9wga7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 06:26:10 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3376Q78i014103;
        Fri, 7 Apr 2023 06:26:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3ppdpm5y8u-1;
        Fri, 07 Apr 2023 06:26:07 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3376Q7Dg014096;
        Fri, 7 Apr 2023 06:26:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3376Q6gc014095;
        Fri, 07 Apr 2023 06:26:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 4C4EE1310; Fri,  7 Apr 2023 11:56:06 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH v2 1/3] venus: add firmware version based check
Date:   Fri,  7 Apr 2023 11:55:56 +0530
Message-Id: <1680848758-3947-2-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
References: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N7f_zeC8PBmW8kb0i6fJplF5ZugAtmIQ
X-Proofpoint-ORIG-GUID: N7f_zeC8PBmW8kb0i6fJplF5ZugAtmIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_03,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=840 clxscore=1015 classifier=spam adjust=0 reason=mlx
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

Add firmware version based checks to enable/disable
features for different SOCs.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Tested-by: Nathan Hebert <nhebert@chromium.org>
---
 drivers/media/platform/qcom/venus/core.h     | 20 ++++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_msgs.c | 11 +++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 32551c2..9d1e4b2 100644
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
 
+static inline int
+is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
+{
+	return ((core)->venus_ver.major == vmajor &&
+		(core)->venus_ver.minor == vminor &&
+		(core)->venus_ver.rev >= vrev);
+}
+
+static inline int
+is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
+{
+	return ((core)->venus_ver.major == vmajor &&
+		(core)->venus_ver.minor == vminor &&
+		(core)->venus_ver.rev <= vrev);
+}
 #endif
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index df96db3..07ac0fc 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
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
@@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
 		return;
 
 	img_ver = pkt->data;
+	if (IS_V4(core))
+		sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
+		       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
+	else if (IS_V6(core))
+		sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
+		       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
 
 	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
 
@@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct venus_core *core,
 
 	switch (pkt->property) {
 	case HFI_PROPERTY_SYS_IMAGE_VERSION:
-		sys_get_prop_image_version(dev, pkt);
+		sys_get_prop_image_version(core, pkt);
 		break;
 	default:
 		dev_dbg(dev, VDBGL "unknown property data\n");
-- 
2.7.4

