Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96957074F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjEQWCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjEQWCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:02:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AAE40CE;
        Wed, 17 May 2023 15:02:21 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HLQC63006793;
        Wed, 17 May 2023 22:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=LLmrYE4K8iezj1vGwoCeKmLSyDshM8IWngowE+vD8sw=;
 b=PWY1uVs4I7tn7qgKTbYGVtLsiXwxiXbJYFGf2OeHGVRFLKS9bP4/FQVG2HTGDmaNfdmw
 rLJpneqv5d4wJ02HcuOIGjAHfVdH2ZvRz7ROuk2YyBGLoSfGafSLHwD6Rk0xpBvVPoiq
 t8Z8+Q2Wxou6ZUA3OlzlB7Z1unn24DHUrglpgyxZFivO1QyPiunqnKX2PfWQAUD2hEib
 3fZcoIJqnHp7VoBuL1AcXcCYq2bpmcwkaOAfJuo1270Kh8mBSoOeEvTVImHF5hEvPeDv
 65STUMsH9CZPJT1Ghe+64H8e8kdqUBRTOMokWwo1h5LfigN2R4up8MY6S/QO/gF4EfI3 fQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn3fsggvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 22:02:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HM2AWD009472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 22:02:10 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 15:02:10 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        <quic_khsieh@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/8] drm/msm/dpu: add dsc blocks to the catalog of MSM8998 and SC8180X
Date:   Wed, 17 May 2023 15:01:52 -0700
Message-ID: <1684360919-28458-2-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684360919-28458-1-git-send-email-quic_khsieh@quicinc.com>
References: <1684360919-28458-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 911mvtjLkQ7G2_2loBZtPDEGCxm6Tcmb
X-Proofpoint-GUID: 911mvtjLkQ7G2_2loBZtPDEGCxm6Tcmb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170181
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Some platforms have DSC blocks which have not been declared in the catalog.
Complete DSC 1.1 support for all platforms by adding the missing blocks to
MSM8998 and SC8180X.

Changes in v9:
-- add MSM8998 and SC8180x to commit titil

Changes in v10:
-- fix grammar at commit text

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h |  7 +++++++
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index c0dd477..521cfd5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -126,6 +126,11 @@ static const struct dpu_pingpong_cfg msm8998_pp[] = {
 			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
 };
 
+static const struct dpu_dsc_cfg msm8998_dsc[] = {
+	DSC_BLK("dsc_0", DSC_0, 0x80000, 0),
+	DSC_BLK("dsc_1", DSC_1, 0x80400, 0),
+};
+
 static const struct dpu_dspp_cfg msm8998_dspp[] = {
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_MSM8998_MASK,
 		 &msm8998_dspp_sblk),
@@ -199,6 +204,8 @@ const struct dpu_mdss_cfg dpu_msm8998_cfg = {
 	.dspp = msm8998_dspp,
 	.pingpong_count = ARRAY_SIZE(msm8998_pp),
 	.pingpong = msm8998_pp,
+	.dsc_count = ARRAY_SIZE(msm8998_dsc),
+	.dsc = msm8998_dsc,
 	.intf_count = ARRAY_SIZE(msm8998_intf),
 	.intf = msm8998_intf,
 	.vbif_count = ARRAY_SIZE(msm8998_vbif),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
index e8057a1..fec1665 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -142,6 +142,15 @@ static const struct dpu_merge_3d_cfg sc8180x_merge_3d[] = {
 	MERGE_3D_BLK("merge_3d_2", MERGE_3D_2, 0x83200),
 };
 
+static const struct dpu_dsc_cfg sc8180x_dsc[] = {
+	DSC_BLK("dsc_0", DSC_0, 0x80000, BIT(DPU_DSC_OUTPUT_CTRL)),
+	DSC_BLK("dsc_1", DSC_1, 0x80400, BIT(DPU_DSC_OUTPUT_CTRL)),
+	DSC_BLK("dsc_2", DSC_2, 0x80800, BIT(DPU_DSC_OUTPUT_CTRL)),
+	DSC_BLK("dsc_3", DSC_3, 0x80c00, BIT(DPU_DSC_OUTPUT_CTRL)),
+	DSC_BLK("dsc_4", DSC_4, 0x81000, BIT(DPU_DSC_OUTPUT_CTRL)),
+	DSC_BLK("dsc_5", DSC_5, 0x81400, BIT(DPU_DSC_OUTPUT_CTRL)),
+};
+
 static const struct dpu_intf_cfg sc8180x_intf[] = {
 	INTF_BLK("intf_0", INTF_0, 0x6a000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7180_MASK,
 			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
@@ -206,6 +215,8 @@ const struct dpu_mdss_cfg dpu_sc8180x_cfg = {
 	.mixer = sc8180x_lm,
 	.pingpong_count = ARRAY_SIZE(sc8180x_pp),
 	.pingpong = sc8180x_pp,
+	.dsc_count = ARRAY_SIZE(sc8180x_dsc),
+	.dsc = sc8180x_dsc,
 	.merge_3d_count = ARRAY_SIZE(sc8180x_merge_3d),
 	.merge_3d = sc8180x_merge_3d,
 	.intf_count = ARRAY_SIZE(sc8180x_intf),
-- 
2.7.4

