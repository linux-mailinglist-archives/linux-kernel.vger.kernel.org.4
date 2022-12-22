Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4C6543DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiLVPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbiLVPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:06:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD83B26483;
        Thu, 22 Dec 2022 07:06:17 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMDi3p3005474;
        Thu, 22 Dec 2022 15:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FtaVgq6aouDsq3SfMo4XhPeYviWzT0KQs8oWVHqyBdw=;
 b=dTeLm+fq8DqQoRiPY9S97zWqo9hGCT+feBbQeOlthxvYhNsOnihYYwhdHJOWrDEIXLCQ
 fQF1RO09zVDSI3rBuYCRJyp9JDxWxCxTkKkQxXyu2TB2ST17W/8wxAFo5uo4XV8+cNET
 qLZomovjMsPBFQUCxBZ5e2TN3MMu5Y9zhAny6chyquB8fRTkpWTxeUToGnOH/7u9Rm0K
 JimpD05tUhs3GlR1YaYPrJVuvG+qmN+Z2CTI9pYF2ngJJFAOZODc3GAbVJNiTlhuCncJ
 628s08b5JDNLnM2lJlU6LacnC0R67Nie7fKBQ9AxGfI5vp/21BsDTKNs7eG/lfxRI570 kQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mk90t63vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 15:06:15 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BMF5s35005730
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 15:05:54 GMT
Received: from vpolimer-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 07:05:49 -0800
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <robdclark@gmail.com>,
        <dianders@chromium.org>, <quic_vpolimer@quicinc.com>,
        <swboyd@chromium.org>, <quic_kalyant@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <quic_khsieh@quicinc.com>,
        <quic_vproddut@quicinc.com>, <quic_bjorande@quicinc.com>,
        <quic_abhinavk@quicinc.com>
Subject: [PATCH v10 06/15] drm/msm/dp: disable self_refresh_aware after entering psr
Date:   Thu, 22 Dec 2022 20:34:53 +0530
Message-ID: <1671721502-16587-7-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671721502-16587-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1671721502-16587-1-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yNhFpST1wehbGs7JVX7aphAM2UCTPSRd
X-Proofpoint-ORIG-GUID: yNhFpST1wehbGs7JVX7aphAM2UCTPSRd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_08,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212220131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sankeerth Billakanti <quic_sbillaka@quicinc.com>

Updated frames get queued if self_refresh_aware is set when the
sink is in psr. To support bridge enable and avoid queuing of update
frames, reset the self_refresh_aware state after entering psr.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_drm.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index d3e9010..0f262a6 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -131,6 +131,8 @@ static void edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	struct drm_crtc_state *old_crtc_state;
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->dp_display;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state = NULL;
 
 	/*
 	 * Check the old state of the crtc to determine if the panel
@@ -147,10 +149,22 @@ static void edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 
 	if (old_crtc_state && old_crtc_state->self_refresh_active) {
 		dp_display_set_psr(dp, false);
-		return;
+		goto psr_aware;
 	}
 
 	dp_bridge_atomic_enable(drm_bridge, old_bridge_state);
+
+psr_aware:
+	connector = drm_atomic_get_new_connector_for_encoder(atomic_state,
+							drm_bridge->encoder);
+	if (connector)
+		conn_state = drm_atomic_get_new_connector_state(atomic_state,
+								connector);
+
+	if (conn_state) {
+		conn_state->self_refresh_aware = dp->psr_supported;
+	}
+
 }
 
 static void edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
@@ -161,6 +175,14 @@ static void edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
 	struct drm_crtc_state *new_crtc_state = NULL, *old_crtc_state = NULL;
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->dp_display;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state = NULL;
+
+	connector = drm_atomic_get_old_connector_for_encoder(atomic_state,
+							drm_bridge->encoder);
+	if (connector)
+		conn_state = drm_atomic_get_new_connector_state(atomic_state,
+								connector);
 
 	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_state,
 						   drm_bridge->encoder);
@@ -187,6 +209,9 @@ static void edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
 	 * when display disable occurs while the sink is in psr state.
 	 */
 	if (new_crtc_state->self_refresh_active) {
+		if (conn_state)
+			conn_state->self_refresh_aware = false;
+
 		dp_display_set_psr(dp, true);
 		return;
 	} else if (old_crtc_state->self_refresh_active) {
-- 
2.7.4

