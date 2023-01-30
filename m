Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC468146C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjA3PNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbjA3PNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:13:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DF2F746;
        Mon, 30 Jan 2023 07:13:01 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UBagGa023817;
        Mon, 30 Jan 2023 15:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=I8K2mZZHuzSPKy8nc2Hk0AtKpb6Cs7KdRnlCPd7JNf0=;
 b=p7DZ+HU1s8ZzWWaGkoDG2JG/w/OGSBqKgIK307NdItlI/YsYfsabSd6OHRwjDm2cjqK+
 T4629LVZxEBqsUBtZPmpZLoyRfMqwo6Yc2l0eDef/1HWiGbjnhn2bH5w/Di4ptpz2Qyx
 KrP1JfNd6QMhb+j2PXq3aXYiscvcngHwwHUVGuhniyaBEs7Zir7a3ilixcdnYZYqmCFP
 B9RcxDu6ZBLF9o/5hH5mR7qaktXfVoG81qRrNpwz9u+QlVty1TjbYRm/lnhH0e/hWRgi
 Z+zNZafwd3QExp3y9BU1DBh0/cR6RJ7YfV7Ot5F9RW03i+f/6yQ5kOTJI0kLcIkAJr7y gA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncua8v8wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:12:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UFCfSR002582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:12:41 GMT
Received: from vpolimer-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 07:12:36 -0800
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
Subject: [PATCH v12 09/14] drm/msm/dp: disable self_refresh_aware after entering psr
Date:   Mon, 30 Jan 2023 20:41:29 +0530
Message-ID: <1675091494-13988-10-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675091494-13988-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1675091494-13988-1-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xTh-un36Yth8-Z-N8IKNyi0JMPpqKzgt
X-Proofpoint-ORIG-GUID: xTh-un36Yth8-Z-N8IKNyi0JMPpqKzgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_13,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300147
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
 drivers/gpu/drm/msm/dp/dp_drm.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 029e08c..01ca148b 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -134,6 +134,8 @@ static void edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	struct drm_crtc_state *old_crtc_state;
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->dp_display;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state = NULL;
 
 	/*
 	 * Check the old state of the crtc to determine if the panel
@@ -150,10 +152,20 @@ static void edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 
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
+	if (conn_state)
+		conn_state->self_refresh_aware = dp->psr_supported;
 }
 
 static void edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
@@ -164,6 +176,14 @@ static void edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
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
@@ -190,6 +210,9 @@ static void edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
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

