Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD470E5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbjEWTkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbjEWTkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:40:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562EE196;
        Tue, 23 May 2023 12:39:53 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NFT4au026279;
        Tue, 23 May 2023 19:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=AhGAu/aDgBwdaSSjHCNw06BegN4W2KQlbT15Y/fm/zw=;
 b=I3uAQfy8SIHcpaJol2/H/8axZWbzRn9091/BNf0tQ16nGx55ZN5Z6ppPxRReGXUkjEj/
 wsnNGsKUaN3Od11fxW8ZM/hOx/GFWZxhIE9MM47MXGzlG3Ret4rLbeiJFJonM1HcKraO
 T28+QQoqamc0EZ0PG8D8/Kh0XL6y3lUW4cQExZL2geI+S6hu4DIaGV2yVafZyTBoquwD
 r7rM8XCWoOnUIm7lZDZ/ZrnHNwfRWDypeIc+lSGx99xugq8KS3s6VhuPcNSUiZv1SBMr
 JtMReC08flsGCfTq5+yg5MXiDkn0+8MHbUNd2qnO7Np6yOigJYsSkjslZJ26BYvD66Jk zA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs05s8ne8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 19:39:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34NJdUWk014786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 19:39:30 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 23 May 2023 12:39:29 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <leonard@lausen.nl>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/2] drm/msm/dp: no need to disable irq after devm_request_irq()
Date:   Tue, 23 May 2023 12:39:13 -0700
Message-ID: <1684870754-24906-2-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684870754-24906-1-git-send-email-quic_khsieh@quicinc.com>
References: <1684870754-24906-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fh_W6X-a70SHiIbGVhlhRY6Jw0A9stsw
X-Proofpoint-ORIG-GUID: fh_W6X-a70SHiIbGVhlhRY6Jw0A9stsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_12,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_request_irq() will allocate irq and return with irq enabled.
At current implementation irq are specified disabled after return from
devm_request_irq() and re enabled later. It is redundant.

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 3e13acdf..1af49b6 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1094,12 +1094,6 @@ static void dp_display_config_hpd(struct dp_display_private *dp)
 				DP_DP_HPD_PLUG_INT_MASK |
 				DP_DP_HPD_UNPLUG_INT_MASK,
 				true);
-
-	/* Enable interrupt first time
-	 * we are leaving dp clocks on during disconnect
-	 * and never disable interrupt
-	 */
-	enable_irq(dp->irq);
 }
 
 void dp_display_set_psr(struct msm_dp *dp_display, bool enter)
@@ -1282,7 +1276,6 @@ int dp_display_request_irq(struct msm_dp *dp_display)
 				dp->irq, rc);
 		return rc;
 	}
-	disable_irq(dp->irq);
 
 	return 0;
 }
@@ -1570,7 +1563,6 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
 		dp_display_host_init(dp_priv);
 		dp_catalog_ctrl_hpd_config(dp_priv->catalog);
 		dp_display_host_phy_init(dp_priv);
-		enable_irq(dp_priv->irq);
 
 		/*
 		 * The code below assumes that the panel will finish probing
@@ -1612,7 +1604,6 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
 
 error:
 	if (dp->is_edp) {
-		disable_irq(dp_priv->irq);
 		dp_display_host_phy_exit(dp_priv);
 		dp_display_host_deinit(dp_priv);
 	}
-- 
2.7.4

