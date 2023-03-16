Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9936BC8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCPIRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCPIQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:16:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE00B4210;
        Thu, 16 Mar 2023 01:16:17 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G622iv019200;
        Thu, 16 Mar 2023 08:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=konrs8oy5Ris8v21QVEkfGVaheNILdZMjxbxTm0YeQ8=;
 b=lCdComlV5fHZwZOxx+H/5qd7GEF5BuSkoMvv7dAmY1+TcHxJJMKF2PSh/xJd0j3nyqxk
 B3unXS2zwftFAVeYriCOc0mUXLfo4Eb0H9xWTaFUYmryGIyTruwy1wKFzjbIG76znK2B
 YIHHUPk7GHA6Usdo13TcANv7SwjbnalZqAucTNcuAmZrM03UTyX0fPFJKYTL97lUPwkk
 9pr0RIO3jQUK3Off/2DMhoyc4i8xvNfGFcFVdLeoVoVoJ7Bmyt+0YIEEauhXdGqNHWmP
 1My9kZzV0gLF0EAnbpqoVbsP6fBtbDPOQz2ib9NHAOvXHXHaP3AAU3L91q/zyRszErq0 6w== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpy3h5h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 08:15:19 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32G8FDKR008640;
        Thu, 16 Mar 2023 08:15:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3p8jqks0j2-1;
        Thu, 16 Mar 2023 08:15:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32G8FGRb008653;
        Thu, 16 Mar 2023 08:15:16 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 32G8FFbD008651;
        Thu, 16 Mar 2023 08:15:16 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 22368900889; Thu, 16 Mar 2023 13:45:15 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@qti.qualcomm.com>
Subject: [PATCH] venus: Enable sufficient sequence change support for sc7180 and fix for Decoder STOP command issue.
Date:   Thu, 16 Mar 2023 13:45:09 +0530
Message-Id: <20230316081509.12201-2-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230316081509.12201-1-quic_vboma@quicinc.com>
References: <20230202064712.5804-2-quic_vboma@quicinc.com>
 <20230316081509.12201-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U8VqVNmPAi4u_z1dIOcfhQ6lkuVXq4p1
X-Proofpoint-ORIG-GUID: U8VqVNmPAi4u_z1dIOcfhQ6lkuVXq4p1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_05,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160069
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viswanath Boma <quic_vboma@quicinc.com>

For VP9 bitstreams, there could be a change in resolution at interframe,
for driver to get notified of such resolution change,
enable the property in video firmware.
Also, EOS handling is now made same in video firmware across all V6 SOCs,
hence above a certain firmware version, the driver handling is
made generic for all V6s

Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Tested-by: Nathan Hebert <nhebert@chromium.org>
---
 drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
 drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
 drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
 5 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 32551c2602a9..ee8b70a34656 100644
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
@@ -500,4 +505,17 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
 	return NULL;
 }
 
+static inline int
+is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
+{
+	return ((core)->venus_ver.major == vmajor && (core)->venus_ver.minor ==
+			vminor && (core)->venus_ver.rev >= vrev);
+}
+
+static inline int
+is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
+{
+	return ((core)->venus_ver.major == vmajor && (core)->venus_ver.minor ==
+			vminor && (core)->venus_ver.rev <= vrev);
+}
 #endif
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
index df96db3761a7..07ac0fcd2852 100644
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
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 4ceaba37e2e5..36c88858ea9d 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 
 		fdata.buffer_type = HFI_BUFFER_INPUT;
 		fdata.flags |= HFI_BUFFERFLAG_EOS;
-		if (IS_V6(inst->core))
+		if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
 			fdata.device_addr = 0;
 		else
 			fdata.device_addr = 0xdeadb000;
@@ -671,6 +671,16 @@ static int vdec_set_properties(struct venus_inst *inst)
 			return ret;
 	}
 
+	/* Enabling sufficient sequence change support for VP9 */
+	if (of_device_is_compatible(inst->core->dev->of_node, "qcom,sc7180-venus")) {
+		if (is_fw_rev_or_newer(inst->core, 5, 4, 51)) {
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

