Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE5F629844
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbiKOMNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKOMMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:12:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E850643A;
        Tue, 15 Nov 2022 04:12:51 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFBVZIT002822;
        Tue, 15 Nov 2022 12:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=MbT9O1UeZc6tHHQz0nYJOEITPJqSdLQWb8rk0ye7n7M=;
 b=LlgBktfv0f06NhHM7Pvlre4/32NQDh3F5l2t2b9uBsGzS2d5mahY4D72TgPX8fA7DQpj
 xUceKi21IVsEHqpzI0GhX84M1bR6Ujyh5uv0jZYla29Zbogrjhi8M6Dq3bKglQ52YCOt
 rNELhPpozWDVv57NfWBgPaZi2B6pweDki1q+Vw7Z14JjDSI3HvG95XoHzWbdRoIwlLXA
 7f52LWqjN+UxoAODtn+9Jap4boNiZoz813147NHEuiarOtGDnnTLSw3Wg1+VeemMeIXZ
 hUTxefmrioUYNLSPAw9z7bWNGZ8qx4ZozSkVym9ZDkIGoXSEe466PTz/Rmk5ZGT5wQPR Bg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kv51phncq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 12:12:47 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFCA8u5024608;
        Tue, 15 Nov 2022 12:12:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3kt4jkds9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Nov 2022 12:12:43 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AFCChju025860;
        Tue, 15 Nov 2022 12:12:43 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2AFCCggl025859;
        Tue, 15 Nov 2022 12:12:43 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 52543900889; Tue, 15 Nov 2022 17:42:42 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>,
        Vikash Garodia <vgarodia@qti.qualcomm.com>
Subject: [PATCH 1/1] venus: Enable sufficient sequence change support for sc7180 and Fix for Decoder STOP command issue.
Date:   Tue, 15 Nov 2022 17:42:37 +0530
Message-Id: <20221115121237.28361-2-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115121237.28361-1-quic_vboma@quicinc.com>
References: <20221115121237.28361-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: btW4ncbAbIUJDjT9cj7o9gDnHwGww3rt
X-Proofpoint-ORIG-GUID: btW4ncbAbIUJDjT9cj7o9gDnHwGww3rt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_06,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150084
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viswanath Boma <quic_vboma@quicinc.com>

For VP9 bitstreams, there could be a change in resolution at interframe,
for driver to get notified of such resolution change, enable the property in video firmware.
Also, EOS handling is now made same in video firmware across all V6 SOCs,
hence above a certain firmware version, the driver handling is made generic for all V6s

Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.h       | 10 ++++++++++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
 drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
 drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 32551c2602a9..538d7cd41edd 100644
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
@@ -472,6 +477,11 @@ struct venus_inst {
 #define IS_V3(core)	((core)->res->hfi_version == HFI_VERSION_3XX)
 #define IS_V4(core)	((core)->res->hfi_version == HFI_VERSION_4XX)
 #define IS_V6(core)	((core)->res->hfi_version == HFI_VERSION_6XX)
+#define IS_FW_REV_OR_NEWER(core, vmajor, vminor, vrev)  ((core)->venus_ver.major == vmajor && \
+			(core)->venus_ver.minor == vminor && (core)->venus_ver.rev >= vrev)
+#define IS_FW_REV_OR_OLDER(core, vmajor, vminor, vrev)  ((core)->venus_ver.major == vmajor && \
+			(core)->venus_ver.minor == vminor && (core)->venus_ver.rev <= vrev)
+
 
 #define ctrl_to_inst(ctrl)	\
 	container_of((ctrl)->handler, struct venus_inst, ctrl_handler)
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 930b743f225e..e2539b58340f 100644
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
index d2d6719a2ba4..20516b4361d3 100644
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
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index df96db3761a7..4a398f77fe9c 100644
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
+			&core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
+	else if (IS_V6(core))
+		sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
+			&core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
 
 	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
 
@@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct venus_core *core,
 
 	switch (pkt->property) {
 	case HFI_PROPERTY_SYS_IMAGE_VERSION:
-		sys_get_prop_image_version(dev, pkt);
+		sys_get_prop_image_version(core, pkt);
 		break;
 	default:
 		dev_dbg(dev, VDBGL "unknown property data\n");
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 4ceaba37e2e5..cc19eb62b723 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 
 		fdata.buffer_type = HFI_BUFFER_INPUT;
 		fdata.flags |= HFI_BUFFERFLAG_EOS;
-		if (IS_V6(inst->core))
+		if (IS_V6(inst->core) && IS_FW_REV_OR_OLDER(inst->core, 1, 0, 87))
 			fdata.device_addr = 0;
 		else
 			fdata.device_addr = 0xdeadb000;
@@ -671,6 +671,16 @@ static int vdec_set_properties(struct venus_inst *inst)
 			return ret;
 	}
 
+	/* Enabling sufficient sequence change support for VP9 */
+	if (of_device_is_compatible(inst->core->dev->of_node, "qcom,sc7180-venus")) {
+		if (IS_FW_REV_OR_NEWER(inst->core, 5, 4, 51)) {
+			ptype = HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT;
+			ret = hfi_session_set_property(inst, ptype, &en);
+			if (ret)
+				return ret;
+		}
+	}
+
 	ptype = HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
 	conceal = ctr->conceal_color & 0xffff;
 	conceal |= ((ctr->conceal_color >> 16) & 0xffff) << 10;
-- 
2.17.1

