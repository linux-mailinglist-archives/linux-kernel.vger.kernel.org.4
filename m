Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC815668A99
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjAMELk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjAMELH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:11:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9792460CC0;
        Thu, 12 Jan 2023 20:11:03 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D3vPQ3015178;
        Fri, 13 Jan 2023 04:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=llTBvKrkffCkE5ctA3nXEYyG86V6MQzfrt4z9YeU7BI=;
 b=k+IEV1mNsV/Pcc2wQuVwi+ZZGar/H5BrI2yd0q8cbMkoNBQwk10FqdpMUDdGR+fq4FTY
 Bz1kDALoCRDQcm/fzdLNzwSTbzIgXuH2yKBm5ja3xYr3i/SfrQqu3TkX92/9y120x5+S
 5F4amsOSxKse6OZSfXl2y2cMVVMHDUQo1eOWVRfSv4k3Zq9XVas+3WZjCJR3u8pXpt0+
 tKE/pG8bw56aThNUtEtEBWd/Cvm/qkZ31mmyvPJOQVAjNtjz9HgnuGxJWTBpMg+Kj8Wo
 2aWusQOGQbB59YD/jOQeTH2yTXPQcMTdR3uRWPmvNF4kODNJBpA8qnO7mqhwQU/OscdM zA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1kxhnppm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 04:10:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30D4AvIK010924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 04:10:57 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 20:10:57 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan@kernel.org>
CC:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/msm: Initialize mode_config earlier
Date:   Thu, 12 Jan 2023 20:10:51 -0800
Message-ID: <20230113041051.4189063-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9V2gm2JOQ72qocD_tXuAHipnj6Vx1ydq
X-Proofpoint-ORIG-GUID: 9V2gm2JOQ72qocD_tXuAHipnj6Vx1ydq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_14,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoking drm_bridge_hpd_notify() on a drm_bridge with a HPD-enabled
bridge_connector ends up in drm_bridge_connector_hpd_cb() calling
drm_kms_helper_hotplug_event(), which assumes that the associated
drm_device's mode_config.funcs is a valid pointer.

But in the MSM DisplayPort driver the HPD enablement happens at bind
time and mode_config.funcs is initialized late in msm_drm_init(). This
means that there's a window for hot plug events to dereference a NULL
mode_config.funcs.

Move the assignment of mode_config.funcs before the bind, to avoid this
scenario.

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ee2f60b6f09b..7ac670f3e6ab 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -438,6 +438,9 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 	drm_mode_config_init(ddev);
 
+	ddev->mode_config.funcs = &mode_config_funcs;
+	ddev->mode_config.helper_private = &mode_config_helper_funcs;
+
 	ret = msm_init_vram(ddev);
 	if (ret)
 		return ret;
@@ -479,9 +482,6 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 	drm_helper_move_panel_connectors_to_head(ddev);
 
-	ddev->mode_config.funcs = &mode_config_funcs;
-	ddev->mode_config.helper_private = &mode_config_helper_funcs;
-
 	for (i = 0; i < priv->num_crtcs; i++) {
 		/* initialize event thread */
 		priv->event_thread[i].crtc_id = priv->crtcs[i]->base.id;
-- 
2.37.3

