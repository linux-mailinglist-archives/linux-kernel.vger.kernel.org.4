Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF3D72F251
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbjFNB6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbjFNB6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:58:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764421BE5;
        Tue, 13 Jun 2023 18:57:54 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E1PYTA018925;
        Wed, 14 Jun 2023 01:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uENpEzQeGAi7ASAmPlPiDYIIezjwRITJgB49JsVsiiE=;
 b=js0p5ZxpnAyJsYMESAlgrHVIhToka0v77xxECm3Q0gRimGvJl5rLOiiztW4HmWrhzjYD
 1a98Xt5Ey1iHC2A6ZZcnN/Y09lU/coZtEj5bmNFGOhg2ly6XOBI2Zk2+VwEQQHazepBp
 M3PVQXIY1ltHX3g2ttdbHEhaqjZkVdaa0ytKPs8yb35BZB0povI5JkqKyk7KsRlw1jTz
 TQp0TSBbejzwadTDzIEXOKpGnm1cpOz2zPWvbv1Kijhl0v2749lXMxtHlXnreruM5sXz
 xhxY4OnEeLM5nlAUjjKGhpfWlu3N1k7Ni8y+YUOaKoiLkpQMQpq/DBs9BYIJmr7mRKzD Kw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6vx80sh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 01:57:47 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35E1vkQq017288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 01:57:46 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 18:57:45 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] drm/msm/dpu: Set DATABUS_WIDEN on command mode encoders
Date:   Tue, 13 Jun 2023 18:57:12 -0700
Message-ID: <20230525-add-widebus-support-v1-2-c7069f2efca1@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686707625; l=3106; i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id; bh=7V8oU6jQipSRbjK7qPsDDdnlXMmvR+0HO+A20+jo4lE=; b=b83JdlWTrhdNq97AOcw9xPOEB7O9hjl62g6peEMzW50i7R6mex83IXSSSxOhrIrmgMM/A6aXw FMjKC1cwDMnCa1xZDqCKYNNt8jl65Eq6bNoXNgG0lpEMtTR9IXNIsEv
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519; pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NAh9NCxuna0oSZyrCSTuvU1QcSf-qURw
X-Proofpoint-GUID: NAh9NCxuna0oSZyrCSTuvU1QcSf-qURw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_24,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140012
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DPU INTF op to set the DATABUS_WIDEN register to enable the
databus-widen mode datapath.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  3 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 12 ++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index b856c6286c85..124ba96bebda 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -70,6 +70,9 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
 
 	if (intf_cfg.dsc != 0 && phys_enc->hw_intf->ops.enable_compression)
 		phys_enc->hw_intf->ops.enable_compression(phys_enc->hw_intf);
+
+	if (phys_enc->hw_intf->ops.enable_widebus)
+		phys_enc->hw_intf->ops.enable_widebus(phys_enc->hw_intf);
 }
 
 static void dpu_encoder_phys_cmd_pp_tx_done_irq(void *arg, int irq_idx)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 5b0f6627e29b..03ba3a1c7a46 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -513,6 +513,15 @@ static void dpu_hw_intf_disable_autorefresh(struct dpu_hw_intf *intf,
 
 }
 
+static void dpu_hw_intf_enable_widebus(struct dpu_hw_intf *ctx)
+{
+	u32 intf_cfg2 = DPU_REG_READ(&ctx->hw, INTF_CONFIG2);
+
+	intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
+
+	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
+}
+
 static void dpu_hw_intf_enable_compression(struct dpu_hw_intf *ctx)
 {
 	u32 intf_cfg2 = DPU_REG_READ(&ctx->hw, INTF_CONFIG2);
@@ -545,6 +554,9 @@ static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
 
 	if (cap & BIT(DPU_INTF_DATA_COMPRESS))
 		ops->enable_compression = dpu_hw_intf_enable_compression;
+
+	if (cap & BIT(DPU_INTF_DATABUS_WIDEN))
+		ops->enable_widebus = dpu_hw_intf_enable_widebus;
 }
 
 struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
index 99e21c4137f9..64a17b99d3d1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -71,6 +71,7 @@ struct intf_status {
  *                              Return: 0 on success, -ETIMEDOUT on timeout
  * @vsync_sel:                  Select vsync signal for tear-effect configuration
  * @enable_compression:         Enable data compression
+ * @enable_widebus:             Enable widebus
  */
 struct dpu_hw_intf_ops {
 	void (*setup_timing_gen)(struct dpu_hw_intf *intf,
@@ -109,6 +110,8 @@ struct dpu_hw_intf_ops {
 	void (*disable_autorefresh)(struct dpu_hw_intf *intf, uint32_t encoder_id, u16 vdisplay);
 
 	void (*enable_compression)(struct dpu_hw_intf *intf);
+
+	void (*enable_widebus)(struct dpu_hw_intf *intf);
 };
 
 struct dpu_hw_intf {

-- 
2.40.1

