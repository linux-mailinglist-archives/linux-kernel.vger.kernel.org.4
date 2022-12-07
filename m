Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FF0645F70
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLGQ6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLGQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:58:33 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8353462E9F;
        Wed,  7 Dec 2022 08:58:32 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GBUm1024545;
        Wed, 7 Dec 2022 16:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fq1jdjbOEaw3v9/eII+pLaG7auDSLgn1tDjsTV6sElo=;
 b=BWFpRD0b2kMTfkW+L2nBGqxEVwsaN2V4pBDrJu3dxQiseSMnNiDfWMkbpJ8oeQ+uR2ks
 AkdiXvsqeic4U8xuWkvoVhQQeNmlPoDp1w7k4vIC1EYDRoWnm9B1JWjDym6TUWkbfL6T
 dE/9P+9YAtmPqOS78b3aWVgj8K4xv3gka9sXeoJNRSeTcQrflAvH2EF0auxumxM7r+6u
 52Tq+y5nrRn+GgXEdcTPcYCqettwWKmaEYKF/sJZYL5ZaPpR4VXQAlcv9Ei1Igul5fFI
 QSi+vnh/lGo/mXfPoiqOx3v07sG9jAGb7i6evc0wNQB3TjHCc1xRXY8jmxvE4JqocjIc 0g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3map4a175s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 16:58:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B7GwMGf017541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Dec 2022 16:58:23 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 7 Dec 2022 08:58:22 -0800
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
Subject: [PATCH v10 4/5] drm/msm/dp: parser link-frequencies as property of dp_out endpoint
Date:   Wed, 7 Dec 2022 08:57:57 -0800
Message-ID: <1670432278-30643-5-git-send-email-quic_khsieh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: OyHBNx7LOxUuDmfqvOIt6pv7hL6s-L3w
X-Proofpoint-GUID: OyHBNx7LOxUuDmfqvOIt6pv7hL6s-L3w
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

Add capability to parser and retrieve max DP link supported rate from
link-frequencies property of dp_out endpoint.

Changes in v6:
-- second patch after split parser patch into two patches

Changes in v7:
-- without checking cnt against DP_MAX_NUM_DP_LANES to retrieve link rate

Changes in v9:
-- separate parser link-frequencies out of data-lanes

Changes in v10:
-- add dp_parser_link_frequencies()

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_parser.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_parser.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index b5f7e70..9398abe 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -91,6 +91,28 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
 	return 0;
 }
 
+static u32 dp_parser_link_frequencies(struct device_node *of_node)
+{
+	struct device_node *endpoint;
+	u64 frequency = 0;
+	int cnt = 0;
+
+	endpoint = of_graph_get_endpoint_by_regs(of_node, 1, 0); /* port@1 */
+	if (endpoint)
+		cnt = of_property_count_u64_elems(endpoint, "link-frequencies");
+
+	if (cnt > 0) {
+		of_property_read_u64_index(endpoint, "link-frequencies",
+						cnt - 1, &frequency);
+		frequency /= 10;	/* from symbol rate to link rate */
+		frequency /= 1000;	/* kbits */
+	}
+
+	of_node_put(endpoint);
+
+	return (u32)frequency;
+}
+
 static int dp_parser_misc(struct dp_parser *parser)
 {
 	struct device_node *of_node = parser->pdev->dev.of_node;
@@ -113,6 +135,11 @@ static int dp_parser_misc(struct dp_parser *parser)
 			parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
 	}
 
+	parser->max_dp_link_rate = dp_parser_link_frequencies(of_node);
+
+	if (!parser->max_dp_link_rate)
+                parser->max_dp_link_rate = DP_LINK_RATE_HBR2; /* 540000 khz */
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
index 866c1a8..6b10c3e 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.h
+++ b/drivers/gpu/drm/msm/dp/dp_parser.h
@@ -15,6 +15,7 @@
 #define DP_LABEL "MDSS DP DISPLAY"
 #define DP_MAX_PIXEL_CLK_KHZ	675000
 #define DP_MAX_NUM_DP_LANES	4
+#define DP_LINK_RATE_HBR2	540000 /* khz */
 
 enum dp_pm_type {
 	DP_CORE_PM,
@@ -119,6 +120,7 @@ struct dp_parser {
 	struct dp_io io;
 	struct dp_display_data disp_data;
 	u32 max_dp_lanes;
+	u32 max_dp_link_rate;
 	struct drm_bridge *next_bridge;
 
 	int (*parse)(struct dp_parser *parser);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

