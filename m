Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA4A70CFA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjEWAlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjEWAM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:12:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E952121;
        Mon, 22 May 2023 17:01:06 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N00epY023284;
        Tue, 23 May 2023 00:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UBo4AUigQs4sXmPtonF5Wh0yzSkrMUZgWWei9l/Mngg=;
 b=KAtR2uO1g+0iBCEIp39mkdWMWMnL461fYAIjemK94kgbEttYJvPFFVTLJZZ2pER8QPzk
 v7NcPMNqOFB3NBuugYI+HdxuGpSf8lB8wujtulirFA+CpiSGRgTcRQl0wKLqNMEa7r72
 1OOQnVDBlrDChDfYWT5HIGainQeXvJqL2wQLlLsAn/GAmnHnCsamhzlzysrELexfWoHb
 S3ZXFzoJ5+16Mh3Em8YpNxjbjo4qAtzwVTolcPX6wKHrR1Ko7AbtpnjAJwrBxPD9mByL
 /XAm3c7/JMWsjnk22J15lErlubSaygDz0sudvaIM3OsANj+Ocm7NmQw6L5PswvLElTNt dQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qracsh0kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 00:00:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N00vd7029943
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 00:00:57 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 22 May 2023 17:00:56 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 05/10] drm/msm/dpu: Introduce PINGPONG_NONE to disconnect DSC from PINGPONG
Date:   Mon, 22 May 2023 17:00:34 -0700
Message-ID: <1684800039-18231-6-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684800039-18231-1-git-send-email-quic_khsieh@quicinc.com>
References: <1684800039-18231-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tMmHpekqSaNuWEEgnKbxumpl0WRU0xpt
X-Proofpoint-ORIG-GUID: tMmHpekqSaNuWEEgnKbxumpl0WRU0xpt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_18,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220203
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling the crossbar mux between DSC and PINGPONG currently
requires a bogus enum dpu_pingpong value to be passed when calling
dsc_bind_pingpong_blk() with enable=false, even though the register
value written is independent of the current PINGPONG block.  Replace
that `bool enable` parameter with a new PINGPONG_NONE dpu_pingpong
flag that triggers the write of the "special" 0xF "crossbar
disabled" value to the register instead.

Changes in v4:
-- more details to commit text

Changes in v5:
-- rewording commit text suggested by Marijn
-- add DRM_DEBUG_KMS for DSC unbinding case

Changes in v8:
-- fix checkpatch warning

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c  | 14 +++++++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h  |  1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  3 ++-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index cf1de5d..ffa6f04 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1850,7 +1850,7 @@ static void dpu_encoder_dsc_pipe_cfg(struct dpu_hw_dsc *hw_dsc,
 		hw_pp->ops.setup_dsc(hw_pp);
 
 	if (hw_dsc->ops.dsc_bind_pingpong_blk)
-		hw_dsc->ops.dsc_bind_pingpong_blk(hw_dsc, true, hw_pp->idx);
+		hw_dsc->ops.dsc_bind_pingpong_blk(hw_dsc, hw_pp->idx);
 
 	if (hw_pp->ops.enable_dsc)
 		hw_pp->ops.enable_dsc(hw_pp);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
index 8deedeae..509dbaa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
@@ -157,7 +157,6 @@ static void dpu_hw_dsc_config_thresh(struct dpu_hw_dsc *hw_dsc,
 
 static void dpu_hw_dsc_bind_pingpong_blk(
 		struct dpu_hw_dsc *hw_dsc,
-		bool enable,
 		const enum dpu_pingpong pp)
 {
 	struct dpu_hw_blk_reg_map *c = &hw_dsc->hw;
@@ -166,14 +165,15 @@ static void dpu_hw_dsc_bind_pingpong_blk(
 
 	dsc_ctl_offset = DSC_CTL(hw_dsc->idx);
 
-	if (enable)
+	if (pp)
 		mux_cfg = (pp - PINGPONG_0) & 0x7;
 
-	DRM_DEBUG_KMS("%s dsc:%d %s pp:%d\n",
-			enable ? "Binding" : "Unbinding",
-			hw_dsc->idx - DSC_0,
-			enable ? "to" : "from",
-			pp - PINGPONG_0);
+	if (pp)
+		DRM_DEBUG_KMS("Binding dsc:%d to pp:%d\n",
+			      hw_dsc->idx - DSC_0, pp - PINGPONG_0);
+	else
+		DRM_DEBUG_KMS("Unbinding dsc:%d from any pp\n",
+			      hw_dsc->idx - DSC_0);
 
 	DPU_REG_WRITE(c, dsc_ctl_offset, mux_cfg);
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
index 287ec5f..138080a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
@@ -44,7 +44,6 @@ struct dpu_hw_dsc_ops {
 				  struct drm_dsc_config *dsc);
 
 	void (*dsc_bind_pingpong_blk)(struct dpu_hw_dsc *hw_dsc,
-				  bool enable,
 				  enum dpu_pingpong pp);
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 1913a19..02a0f48 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -191,7 +191,8 @@ enum dpu_dsc {
 };
 
 enum dpu_pingpong {
-	PINGPONG_0 = 1,
+	PINGPONG_NONE,
+	PINGPONG_0,
 	PINGPONG_1,
 	PINGPONG_2,
 	PINGPONG_3,
-- 
2.7.4

