Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9CE6FE525
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjEJUcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEJUb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:31:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D593F59CA;
        Wed, 10 May 2023 13:31:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AKJAFb004475;
        Wed, 10 May 2023 20:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=300Q7CuSs1GWedhq/GUgOnDR36NkRfwfJs/hvUybQo4=;
 b=ee7N8ZprgWNlrxz0F1EywISpLH4aUeZRipdlmtIQDyxSGQn6VFdfjZzgefL+hAQyqnZk
 7RIKc1wGoP336+DPcYmrdvUbteVCNDc69y7SFKWFr5FKPFPpDF10sWAQsihAuJRmDNKa
 v8zSlDTjAP5F48APkWuV83T2x3Sc2yoJbpuD3H4pxOHOlBGdVzUjO924yTx4nrRlqKYo
 59/Y4p4+6KrVWELNBI9zLE8mnhFB0Ft1LxnS+QKpLMLfRI2DFpcDNGdqS7HtWyIir3bP
 rhTKkMsvPnmdnpyr751m38MAtex012LftGKVfIxpyGkbVpvdGXSXcnqolaiC1ztO+DJ8 Mg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg79csg06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 20:31:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AKVKZt010761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 20:31:20 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 13:31:19 -0700
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
Subject: [PATCH v1 1/2] drm/msm/dp: enable HDP plugin/unplugged interrupts to hpd_enable/disable
Date:   Wed, 10 May 2023 13:31:04 -0700
Message-ID: <1683750665-8764-2-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683750665-8764-1-git-send-email-quic_khsieh@quicinc.com>
References: <1683750665-8764-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kLyaznvEkZGHBGIhzoVxzw4cyvqwvBdv
X-Proofpoint-ORIG-GUID: kLyaznvEkZGHBGIhzoVxzw4cyvqwvBdv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=963 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal_hpd flag was introduced to handle external DP HPD derived from GPIO
pinmuxed into DP controller. HPD plug/unplug interrupts cannot be enabled until
internal_hpd flag is set to true.
At both bootup and resume time, the DP driver will enable external DP
plugin interrupts and handle plugin interrupt accordingly. Unfortunately
dp_bridge_hpd_enable() bridge ops function was called to set internal_hpd
flag to true later than where DP driver expected during bootup time.

This causes external DP plugin event to not get detected and display stays blank.
Move enabling HDP plugin/unplugged interrupts to dp_bridge_hpd_enable()/disable() to
set internal_hpd to true along with enabling HPD plugin/unplugged interrupts
simultaneously to avoid timing issue during bootup and resume.

Fixes: cd198caddea7 ("drm/msm/dp: Rely on hpd_enable/disable callbacks")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 3e13acdf..71aa944 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1088,13 +1088,6 @@ static void dp_display_config_hpd(struct dp_display_private *dp)
 	dp_display_host_init(dp);
 	dp_catalog_ctrl_hpd_config(dp->catalog);
 
-	/* Enable plug and unplug interrupts only if requested */
-	if (dp->dp_display.internal_hpd)
-		dp_catalog_hpd_config_intr(dp->catalog,
-				DP_DP_HPD_PLUG_INT_MASK |
-				DP_DP_HPD_UNPLUG_INT_MASK,
-				true);
-
 	/* Enable interrupt first time
 	 * we are leaving dp clocks on during disconnect
 	 * and never disable interrupt
@@ -1396,12 +1389,6 @@ static int dp_pm_resume(struct device *dev)
 
 	dp_catalog_ctrl_hpd_config(dp->catalog);
 
-	if (dp->dp_display.internal_hpd)
-		dp_catalog_hpd_config_intr(dp->catalog,
-				DP_DP_HPD_PLUG_INT_MASK |
-				DP_DP_HPD_UNPLUG_INT_MASK,
-				true);
-
 	if (dp_catalog_link_is_connected(dp->catalog)) {
 		/*
 		 * set sink to normal operation mode -- D0
@@ -1801,15 +1788,29 @@ void dp_bridge_hpd_enable(struct drm_bridge *bridge)
 {
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
 	struct msm_dp *dp_display = dp_bridge->dp_display;
+	struct dp_display_private *dp;
+
+	dp = container_of(dp_display, struct dp_display_private, dp_display);
 
 	dp_display->internal_hpd = true;
+	dp_catalog_hpd_config_intr(dp->catalog,
+				DP_DP_HPD_PLUG_INT_MASK |
+				DP_DP_HPD_UNPLUG_INT_MASK,
+				true);
 }
 
 void dp_bridge_hpd_disable(struct drm_bridge *bridge)
 {
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
 	struct msm_dp *dp_display = dp_bridge->dp_display;
+	struct dp_display_private *dp;
+
+	dp = container_of(dp_display, struct dp_display_private, dp_display);
 
+	dp_catalog_hpd_config_intr(dp->catalog,
+				DP_DP_HPD_PLUG_INT_MASK |
+				DP_DP_HPD_UNPLUG_INT_MASK,
+				false);
 	dp_display->internal_hpd = false;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

