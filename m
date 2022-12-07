Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E3F645F69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLGQ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:58:33 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DCC62E9B;
        Wed,  7 Dec 2022 08:58:32 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GnGUE028363;
        Wed, 7 Dec 2022 16:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=D0G4TADsne4GknsV3/DiDjdVyQbWExXugyPC5lUp4U0=;
 b=ExsOxCJwnWGIbdw+fRl+BhEYV8OJad3on+pcgVhVNpCmNtyRMJ48D5FsQajYKN4WAlNR
 3i0oPikzYHwP2WHGmkYD2F7Q9oNPkXdu0/IW/PcuiHaGv7lYJdVv2MHYgIdJhCteJUiq
 4f0xCm71I1r0nWzzprGVedDfUzO+eKmRp6UbdmS/EXVa/9RYPg5T3qH4B14qhaPJnZTu
 i0O/HHQ+3y15HgCn7sFZph9PCTt3jEDbKwThBXwmfsu59d6ukaV4GJmichX/twjTgXlt
 CEwLu45eVJDWy2JnO0yTVx5SUZt89e9+FehzHZe0h3l+wiWbVt3ikjn7izO7pp9YwQ8/ 0A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3map4a175r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 16:58:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B7GwLrV001383
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Dec 2022 16:58:21 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 7 Dec 2022 08:58:20 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <airlied@gmail.com>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 3/5] drm/msm/dp: parser data-lanes as property of dp_out endpoint
Date:   Wed, 7 Dec 2022 08:57:56 -0800
Message-ID: <1670432278-30643-4-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1670432278-30643-1-git-send-email-quic_khsieh@quicinc.com>
References: <1670432278-30643-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zwLStHUbwvRq3c9HPaup9Zpr47n_yWy2
X-Proofpoint-GUID: zwLStHUbwvRq3c9HPaup9Zpr47n_yWy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add capability to parser data-lanes as property of dp_out endpoint.
Also retain the original capability to parser data-lanes as property
of mdss_dp node to handle legacy case.

Changes in v6:
-- first patch after split parser patch into two

Changes in v7:
-- check "data-lanes" from endpoint first

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_parser.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index dd73221..b5f7e70 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -94,16 +94,25 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
 static int dp_parser_misc(struct dp_parser *parser)
 {
 	struct device_node *of_node = parser->pdev->dev.of_node;
-	int len;
-
-	len = drm_of_get_data_lanes_count(of_node, 1, DP_MAX_NUM_DP_LANES);
-	if (len < 0) {
-		DRM_WARN("Invalid property \"data-lanes\", default max DP lanes = %d\n",
-			 DP_MAX_NUM_DP_LANES);
-		len = DP_MAX_NUM_DP_LANES;
+	int cnt;
+
+	/*
+	 * data-lanes is the property of dp_out endpoint
+	 */
+	cnt = drm_of_get_data_lanes_count_ep(of_node, 1, 0, 1, DP_MAX_NUM_DP_LANES);
+	if (cnt > 0)
+		parser->max_dp_lanes = cnt;
+	else {
+		/*
+		 * legacy code, data-lanes is the property of mdss_dp node
+		 */
+		cnt = drm_of_get_data_lanes_count(of_node, 1, DP_MAX_NUM_DP_LANES);
+		if (cnt > 0)
+			parser->max_dp_lanes = cnt;
+		else
+			parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
 	}
 
-	parser->max_dp_lanes = len;
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

