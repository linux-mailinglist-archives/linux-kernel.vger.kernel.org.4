Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3FB7233D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjFEX6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjFEX6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:58:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3A0F2;
        Mon,  5 Jun 2023 16:58:38 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355NDL40000971;
        Mon, 5 Jun 2023 23:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=EmTZWvjU+MwHPnG0fraAqfkIBhPrmyWTxxAMokOM/V0=;
 b=SDOTy8fAY0+jh9wUMWFFmskPSHmxm6cgPFbIKLDF53f/MOV1wm/fDqjF17IVzzSbebMg
 7tZq7tqZZ4ihKkwCnkrBDjf3wnE07SAod5rI7135UxvrRwmRRfA/im3G65TSLRDYA2TV
 GQw/+PpbVzaLbB3v1T8bPxjjAjtNVW0KZ6dGA3NtHcICg9Deb1YpngX564qwD1XSHPlv
 QUioagJXb8IRSIPvQOcffM4dWyxSGeNWsUzf/ITNuxVJ6WJNc+8x3FCn3Y9aEpbMLZpz
 BoSCT0hj9/Lyi/9UzZTKr9KHZmTA8YCxu+GOesKRaE5Zb51d92vPPG6IS/ai2MboFMtw BQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyw46cx58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 23:58:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 355NwP59012923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 23:58:25 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 16:58:24 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <vkoul@kernel.org>, <daniel@ffwll.ch>,
        <airlied@gmail.com>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <andersson@kernel.org>,
        <marijn.suijten@somainline.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_khsieh@quicinc.com>,
        <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v15] drm/msm/dpu: add DSC blocks to the catalog of MSM8998 and SC8180X
Date:   Mon, 5 Jun 2023 16:58:14 -0700
Message-ID: <1686009494-25127-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sFwY9Kjx5GGkJe58of6QRZ8D283hX7U1
X-Proofpoint-GUID: sFwY9Kjx5GGkJe58of6QRZ8D283hX7U1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_34,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050207
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
-- add MSM8998 and SC8180x to commit title

Changes in v10:
-- fix grammar at commit text

Changes in v12:
-- fix "titil" with "title" at changes in v9

Changes in v14:
-- "dsc" tp "DSC" at commit title

Changes in v15:
-- fix merge conflicts at dpu_5_1_sc8180x.h

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h | 7 +++++++
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index 3c732a0..7d0d0e7 100644
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
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
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
index 8ed2b263..b5c575c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -230,6 +230,8 @@ const struct dpu_mdss_cfg dpu_sc8180x_cfg = {
 	.dsc = sc8180x_dsc,
 	.pingpong_count = ARRAY_SIZE(sc8180x_pp),
 	.pingpong = sc8180x_pp,
+	.dsc_count = ARRAY_SIZE(sc8180x_dsc),
+	.dsc = sc8180x_dsc,
 	.merge_3d_count = ARRAY_SIZE(sc8180x_merge_3d),
 	.merge_3d = sc8180x_merge_3d,
 	.intf_count = ARRAY_SIZE(sc8180x_intf),
-- 
2.7.4

