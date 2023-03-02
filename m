Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD9E6A86BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCBQfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjCBQfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:35:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4406023870;
        Thu,  2 Mar 2023 08:34:57 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322G9XKs016267;
        Thu, 2 Mar 2023 16:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=KjiXNGsfSpZW+NwEpHDmlUXFZi+y+itjDwRpepZb5BQ=;
 b=YRy0y9RxiGA5kpUSYXGoTP52hRXmfETYf8ajBop8v83+czXNha2y7rRUGgGxHLdPKyvN
 083USuJKoLhQ6JlMttBEjg1EvttuaXzbwpsilsiGEqRpz5+li0+vu1LWlUH79Wdva/wk
 g+74NDme6HayYcPd3Bc17YfaWzw956BS9S1k5Kr7KbEXttoveHB2nFNzSmeAuizN4A7l
 pbNe/CvX6zpg2E4CDtoLPVW4CGgLEQRhsRpSQBXGIVJmLbj6IB0QcJDPhAjmm/NSyWMX
 Yrke8qZEm6CmYfB8Ry8xauwkD78zl14eEBJiFuqlQtjfNgxIF145kPOXqzrWZhlOOvJn Bg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p24uwc7cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 16:34:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 322GYrHt009934
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 16:34:53 GMT
Received: from vpolimer-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 2 Mar 2023 08:34:48 -0800
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>
CC:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <robdclark@gmail.com>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <quic_kalyant@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_khsieh@quicinc.com>, <quic_vproddut@quicinc.com>,
        <quic_bjorande@quicinc.com>, <quic_abhinavk@quicinc.com>,
        <quic_sbillaka@quicinc.com>
Subject: [PATCH v14 14/14] drm/msm/dp: set self refresh aware based on PSR support
Date:   Thu, 2 Mar 2023 22:03:17 +0530
Message-ID: <1677774797-31063-15-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xfAPcyisS-Us9HoPNtJkHGb4sKmKCug0
X-Proofpoint-ORIG-GUID: xfAPcyisS-Us9HoPNtJkHGb4sKmKCug0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_09,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 mlxlogscore=868 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303020143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the PSR to kick in, self_refresh_aware has to be set.
Initialize it based on the PSR support for the eDP interface.

Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_drm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 029e08c..785d766 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -117,6 +117,8 @@ static int edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
 	if (WARN_ON(!conn_state))
 		return -ENODEV;
 
+	conn_state->self_refresh_aware = dp->psr_supported;
+
 	if (!conn_state->crtc || !crtc_state)
 		return 0;
 
-- 
2.7.4

