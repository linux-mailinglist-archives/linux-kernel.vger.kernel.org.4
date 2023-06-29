Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43961742D93
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjF2TYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjF2TXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:23:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E183596;
        Thu, 29 Jun 2023 12:23:12 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TGSaec006930;
        Thu, 29 Jun 2023 19:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=+hWul2nekoDN8xRttv+Z7MLmGJ5cvGp4fmfxDkERFUQ=;
 b=hd24qcb4baRZIqSiwJmKJocuwnCWyxPTPxEzCq+1GwdvJPCjmVZkBXQf/0FwJD9dDPrX
 uQ2slzma0r/4segPjhtaKN5h2V0WZpR0wB/CgguHMnswYfUouuQ6bkCGwl5vHpgQKsLN
 N1W/kMwzWVUpKbrW7r+5mo4ftOHp8MesymTXrvSbdq99WZOCiLm547vvFb8eGfKhMS/b
 gutBvyh0fRw28humJeb0+Nf3WMp07bWNPQlxqkCdy/GcU1twJ79I8hHDH9rw8ZOZjdER
 3KLvYgIDggTKK6W4XqGuXynT1I6ULgCWmGAHAmz+9lx+HFnTWz8n2HAGeUtAMJLzpG2T dA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgy1tj0y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 19:22:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35TJMrj4004286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 19:22:53 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Thu, 29 Jun 2023 12:21:51 -0700
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <quic_jesszhan@quicinc.com>,
        <andersson@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] drm/msm/dpu: use dpu core's major version to enable data compress
Date:   Thu, 29 Jun 2023 12:21:17 -0700
Message-ID: <20230629192121.14008-2-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629192121.14008-1-quic_abhinavk@quicinc.com>
References: <20230629192121.14008-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iKfPWVluYW23th--bmnPM5a56Equxp36
X-Proofpoint-GUID: iKfPWVluYW23th--bmnPM5a56Equxp36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a feature bit to decide whether to enable data
compress or not for DSC use-cases, use dpu core's major version instead.
This will avoid defining feature bits for every bit level details of
registers.

Also, rename the intf's enable_compression() op to program_datapath()
and allow it to accept a struct intf_dpu_datapath_cfg to program
all the bits at once. This can be re-used by widebus later on as
well as it touches the same register.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  9 +++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c      |  9 +++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h      | 16 ++++++++++++++--
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index b856c6286c85..f4e15b4c4cc9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -50,6 +50,7 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
 			to_dpu_encoder_phys_cmd(phys_enc);
 	struct dpu_hw_ctl *ctl;
 	struct dpu_hw_intf_cfg intf_cfg = { 0 };
+	struct dpu_kms *dpu_kms = phys_enc->dpu_kms;
 
 	ctl = phys_enc->hw_ctl;
 	if (!ctl->ops.setup_intf_cfg)
@@ -68,8 +69,12 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
 				phys_enc->hw_intf,
 				phys_enc->hw_pp->idx);
 
-	if (intf_cfg.dsc != 0 && phys_enc->hw_intf->ops.enable_compression)
-		phys_enc->hw_intf->ops.enable_compression(phys_enc->hw_intf);
+	if (intf_cfg.dsc != 0 && dpu_kms->catalog->core_major_version >= 0x7) {
+		struct intf_dpu_datapath_cfg datapath_cfg = { 0 };
+
+		datapath_cfg.data_compress = true;
+		phys_enc->hw_intf->ops.program_datapath(phys_enc->hw_intf, &datapath_cfg);
+	}
 }
 
 static void dpu_encoder_phys_cmd_pp_tx_done_irq(void *arg, int irq_idx)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 5b0f6627e29b..85333df08fbc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -513,11 +513,13 @@ static void dpu_hw_intf_disable_autorefresh(struct dpu_hw_intf *intf,
 
 }
 
-static void dpu_hw_intf_enable_compression(struct dpu_hw_intf *ctx)
+static void dpu_hw_intf_program_datapath(struct dpu_hw_intf *ctx,
+					 struct intf_dpu_datapath_cfg *datapath_cfg)
 {
 	u32 intf_cfg2 = DPU_REG_READ(&ctx->hw, INTF_CONFIG2);
 
-	intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
+	if (datapath_cfg->data_compress)
+		intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
 
 	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
 }
@@ -543,8 +545,7 @@ static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
 		ops->disable_autorefresh = dpu_hw_intf_disable_autorefresh;
 	}
 
-	if (cap & BIT(DPU_INTF_DATA_COMPRESS))
-		ops->enable_compression = dpu_hw_intf_enable_compression;
+	ops->program_datapath = dpu_hw_intf_program_datapath;
 }
 
 struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
index 99e21c4137f9..f736dca38463 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -48,6 +48,11 @@ struct intf_status {
 	u32 line_count;		/* current line count including blanking */
 };
 
+struct intf_dpu_datapath_cfg {
+	u8 data_compress;	/* enable data compress between dpu and dsi */
+	/* can be expanded for other programmable bits */
+};
+
 /**
  * struct dpu_hw_intf_ops : Interface to the interface Hw driver functions
  *  Assumption is these functions will be called after clocks are enabled
@@ -70,7 +75,7 @@ struct intf_status {
  * @get_autorefresh:            Retrieve autorefresh config from hardware
  *                              Return: 0 on success, -ETIMEDOUT on timeout
  * @vsync_sel:                  Select vsync signal for tear-effect configuration
- * @enable_compression:         Enable data compression
+ * @program_datapath:           Program the DPU to interface datapath for relevant chipsets
  */
 struct dpu_hw_intf_ops {
 	void (*setup_timing_gen)(struct dpu_hw_intf *intf,
@@ -108,7 +113,14 @@ struct dpu_hw_intf_ops {
 	 */
 	void (*disable_autorefresh)(struct dpu_hw_intf *intf, uint32_t encoder_id, u16 vdisplay);
 
-	void (*enable_compression)(struct dpu_hw_intf *intf);
+	/**
+	 * Program the DPU to intf datapath by specifying
+	 * which of the settings need to be programmed for
+	 * use-cases which need DPU-intf handshake such as
+	 * widebus, compression etc.
+	 */
+	void (*program_datapath)(struct dpu_hw_intf *intf,
+				 struct intf_dpu_datapath_cfg *datapath_cfg);
 };
 
 struct dpu_hw_intf {
-- 
2.40.1

