Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40CB7169A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjE3QdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjE3QdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:33:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA3DE8;
        Tue, 30 May 2023 09:32:42 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U6q4JT016736;
        Tue, 30 May 2023 16:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/qk5Arae9koJJXy7bIAt35842+Qzx3zoMV+zQQQw4kI=;
 b=biqO9jFu3IfHcK/a0qeymb82oqcTsACrYzBnkkxdwodgEUh7oF2b4LxVpbwye6NniZ+O
 BEeZbUv+4EDx0TogbKx8WTuuMC+ftoFgXtMHr45lMB0K+ELiBzAILLTFfAWoLNwPvj1E
 OsN7VT3tIW31/HuheWCYnyfjZSg5h+12Ew9rWYEQs6TNO4SpIcX/qSwzE6nCdXsygaX8
 L4DWx2iY2/vUMvx5gKADyAWuWtPmEYop4BlieZRoCOOhv+oNLRs1AmOx0nsNIRttHtF3
 HSn7bTYsnd3IdIaJRfafnGAFuDHppOejgCT1aaNTqiqkc7NVoLKmPU9m8v1jNdYhDgdX HQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qvws8jfb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 16:32:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34UGWCN4014040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 16:32:12 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 09:32:12 -0700
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
Subject: [PATCH v1 1/3] drm/msm/dsi: add msm_dsi_bridge_get_dsc_config()
Date:   Tue, 30 May 2023 09:31:56 -0700
Message-ID: <1685464318-25031-2-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685464318-25031-1-git-send-email-quic_khsieh@quicinc.com>
References: <1685464318-25031-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 03NlmzQi_F5c-MFnH4rhhFonno-nYrip
X-Proofpoint-GUID: 03NlmzQi_F5c-MFnH4rhhFonno-nYrip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_12,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305300131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI is implemented as a DRM bridge. It is more logically to access
DSI from outside world through DRM bridge structure. Add DSI bridge
function msm_dsi_bridge_get_dsc_config() to retrieve DSC information.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dsi/dsi.c         | 8 ++++++++
 drivers/gpu/drm/msm/dsi/dsi.h         | 2 ++
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 4 ++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index baab79a..fa7fcb5 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -17,6 +17,14 @@ struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
 	return msm_dsi_host_get_dsc_config(msm_dsi->host);
 }
 
+struct drm_dsc_config *msm_dsi_bridge_get_dsc_config(struct drm_bridge *bridge)
+{
+        int id = dsi_mgr_bridge_get_id(bridge);
+        struct msm_dsi *msm_dsi = dsi_mgr_get_dsi(id);
+
+	return msm_dsi_host_get_dsc_config(msm_dsi->host);
+}
+
 static int dsi_get_phy(struct msm_dsi *msm_dsi)
 {
 	struct platform_device *pdev = msm_dsi->pdev;
diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index bd3763a..394f605 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -64,6 +64,8 @@ bool msm_dsi_manager_cmd_xfer_trigger(int id, u32 dma_base, u32 len);
 int msm_dsi_manager_register(struct msm_dsi *msm_dsi);
 void msm_dsi_manager_unregister(struct msm_dsi *msm_dsi);
 void msm_dsi_manager_tpg_enable(void);
+int dsi_mgr_bridge_get_id(struct drm_bridge *bridge);
+struct msm_dsi *dsi_mgr_get_dsi(int id);
 
 /* msm dsi */
 static inline bool msm_dsi_device_connected(struct msm_dsi *msm_dsi)
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 1bbac72..5a7ac338 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -60,7 +60,7 @@ static inline bool dsi_mgr_power_on_early(struct drm_bridge *bridge)
 }
 #endif
 
-static inline struct msm_dsi *dsi_mgr_get_dsi(int id)
+struct msm_dsi *dsi_mgr_get_dsi(int id)
 {
 	return msm_dsim_glb.dsi[id];
 }
@@ -218,7 +218,7 @@ struct dsi_bridge {
 
 #define to_dsi_bridge(x) container_of(x, struct dsi_bridge, base)
 
-static int dsi_mgr_bridge_get_id(struct drm_bridge *bridge)
+int dsi_mgr_bridge_get_id(struct drm_bridge *bridge)
 {
 	struct dsi_bridge *dsi_bridge = to_dsi_bridge(bridge);
 	return dsi_bridge->id;
-- 
2.7.4

