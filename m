Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68E570A170
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjESVRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjESVRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:17:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB2FB;
        Fri, 19 May 2023 14:17:45 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JL3mlJ025256;
        Fri, 19 May 2023 21:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=/aqVzZY0IFwIx51HTpdTgFu062ANanD2Cfw0BgY/do0=;
 b=P9WwHfh1uRCgwKBD4SfjgAlmtPSSMhRw+s/xxliZhwj6fvaZWKFoMyYVgzg4jSqeqfo+
 5/gHcxi9qJdyGa422MjpgmX1qygNIZBxnMoX/JnXB43D3rj6yyzxhz19RJG6osqH+fdI
 5xuf/2e0GqsbRxVnRr+CPu86uXUxlo+yqtUxIyJGBUcENlAOTKzaQ3eB16M29M2TCFzV
 Qdpr1NBZqfUEtBRE1bQ/4CSks4r2ykMG0iD/P63vlbSJreuBGY5NlpAAL2VI1ZpGLRbp
 bvMpsFtgS8Zd1hBpegOdCPSR7spn431JiFBmxVjo412inROGkdPi3VVoj6+Nu3rqZph4 Ew== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpad1h6x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 21:17:38 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JLHbMk021563
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 21:17:37 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 14:17:37 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Fri, 19 May 2023 14:17:29 -0700
Subject: [PATCH v3 4/5] drm/msm/dpu: Set DATA_COMPRESS for command mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230405-add-dsc-support-v3-4-6e1d35a206b3@quicinc.com>
References: <20230405-add-dsc-support-v3-0-6e1d35a206b3@quicinc.com>
In-Reply-To: <20230405-add-dsc-support-v3-0-6e1d35a206b3@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684531055; l=3530;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=v5BaRvxjpsFqDUR6zArMEGwcN5kOCsmIV/ZOG6SDhVs=;
 b=P6vK8cxIh6zjJw5GmhT1MV/1Zhy6wSiMdzqiDyd69Odt61ZERx/kjVl3HW1/W9nj6gBep50gB
 BlatAQhaCe9AgGtGhnz6rFF6X6LKXjbEJ9wPIV80jsRlvDZmGTAnZya
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ng1wFdRc8zZkts934l67sEEFdUNQwkm_
X-Proofpoint-ORIG-GUID: ng1wFdRc8zZkts934l67sEEFdUNQwkm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DPU INTF op to set DATA_COMPRESS register if the
DPU_INTF_DATA_COMPRESS feature is enabled. This bit needs to be set in
order for DSC v1.2 to work.

Note: For now, this op is called for command mode encoders only. Changes to
set DATA_COMPRESS for video mode encoders will be posted along with DSC
v1.2 support for DP.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  3 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 13 +++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index d8ed85a238af..1a4c20f02312 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -68,6 +68,9 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
 				phys_enc->hw_intf,
 				true,
 				phys_enc->hw_pp->idx);
+
+	if (phys_enc->hw_intf->ops.enable_compression)
+		phys_enc->hw_intf->ops.enable_compression(phys_enc->hw_intf);
 }
 
 static void dpu_encoder_phys_cmd_pp_tx_done_irq(void *arg, int irq_idx)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 6485500eedb8..a462c6780e6e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -91,6 +91,7 @@
 
 #define INTF_CFG2_DATABUS_WIDEN	BIT(0)
 #define INTF_CFG2_DATA_HCTL_EN	BIT(4)
+#define INTF_CFG2_DCE_DATA_COMPRESS     BIT(12)
 
 static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
 		const struct intf_timing_params *p,
@@ -522,6 +523,15 @@ static void dpu_hw_intf_disable_autorefresh(struct dpu_hw_intf *intf,
 
 }
 
+static void dpu_hw_intf_enable_compression(struct dpu_hw_intf *ctx)
+{
+	u32 intf_cfg2 = DPU_REG_READ(&ctx->hw, INTF_CONFIG2);
+
+	intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
+
+	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
+}
+
 static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
 		unsigned long cap)
 {
@@ -542,6 +552,9 @@ static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
 		ops->vsync_sel = dpu_hw_intf_vsync_sel;
 		ops->disable_autorefresh = dpu_hw_intf_disable_autorefresh;
 	}
+
+	if (cap & BIT(DPU_INTF_DATA_COMPRESS))
+		ops->enable_compression = dpu_hw_intf_enable_compression;
 }
 
 struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
index 73b0885918f8..72fe907729f1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -70,6 +70,7 @@ struct intf_status {
  * @get_autorefresh:            Retrieve autorefresh config from hardware
  *                              Return: 0 on success, -ETIMEDOUT on timeout
  * @vsync_sel:                  Select vsync signal for tear-effect configuration
+ * @enable_compression:         Enable data compression
  */
 struct dpu_hw_intf_ops {
 	void (*setup_timing_gen)(struct dpu_hw_intf *intf,
@@ -107,6 +108,7 @@ struct dpu_hw_intf_ops {
 	 * Disable autorefresh if enabled
 	 */
 	void (*disable_autorefresh)(struct dpu_hw_intf *intf, uint32_t encoder_id, u16 vdisplay);
+	void (*enable_compression)(struct dpu_hw_intf *intf);
 };
 
 struct dpu_hw_intf {

-- 
2.40.1

