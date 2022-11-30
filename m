Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA77163E5C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiK3Xwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiK3XwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:52:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D91769F2;
        Wed, 30 Nov 2022 15:52:21 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUKhpVY028276;
        Wed, 30 Nov 2022 23:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=WKZlIpUbr2zcGBTF+G5u3muSttTCTeTFzQs5tP5InKI=;
 b=Uku1pv9VXFBgrtskOtEzJzv4q6VXqRSMHb8heezEVMK1jL1eizENJxnqJI1jM0pEoh+R
 UHu02yGwn6h361DnLhOzFzC/b8zKTbdv1JhwJWC9NSONmMHPxTnoGbfy2bwpL5E0SDaz
 RyNZ+NU0rPjem/VQ5m7tQv9wKsTWge0/E6EQXkBJG4EXeE0PFVoiN3SAdJVr61a9lLku
 8i5QqPul/fGvaVSCAMD9pC8Yw+3gnS8R7gb331M7csHRvRho6rFigWad3CJjaIEEP2aQ
 PIjQt4bY94Dw24UA/qHUTIdKIKV8pQPFZsdXkhTyTcjPnN448NtZ3xfUzL4vMrgDicwn xg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6eferkrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 23:52:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AUNqEFx024698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 23:52:14 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 15:52:14 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/4] drm/msm/dp: parser link-frequencies as property of dp_out endpoint
Date:   Wed, 30 Nov 2022 15:51:49 -0800
Message-ID: <1669852310-22360-4-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669852310-22360-1-git-send-email-quic_khsieh@quicinc.com>
References: <1669852310-22360-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s_bNoYjRejWLbgvonfsVEtdKQJnaPJwJ
X-Proofpoint-ORIG-GUID: s_bNoYjRejWLbgvonfsVEtdKQJnaPJwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add capability to parser and retrieve max DP link supported rate from
link-frequencies property of dp_out endpoint.

Changes in v6:
-- second patch after split parser patch into two patches

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_parser.c | 16 ++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_parser.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index b06ff60..2006341 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -95,6 +95,7 @@ static int dp_parser_misc(struct dp_parser *parser)
 {
 	struct device_node *of_node = parser->pdev->dev.of_node;
 	struct device_node *endpoint;
+	u64 frequency;
 	int cnt;
 
 	/*
@@ -103,6 +104,7 @@ static int dp_parser_misc(struct dp_parser *parser)
 	cnt = drm_of_get_data_lanes_count(of_node, 1, DP_MAX_NUM_DP_LANES);
 	if (cnt > 0) {
 		parser->max_dp_lanes = cnt;
+		parser->max_dp_link_rate = DP_LINK_RATE_HBR2; /* 540000 khz */
 		return 0;
 	}
 
@@ -116,8 +118,22 @@ static int dp_parser_misc(struct dp_parser *parser)
 			parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
 		else
 			parser->max_dp_lanes = cnt;
+
+		cnt = of_property_count_u64_elems(endpoint, "link-frequencies");
+		if (cnt < 0) {
+			parser->max_dp_link_rate = DP_LINK_RATE_HBR2; /* 540000 khz */
+		} else {
+			if (cnt > DP_MAX_NUM_DP_LANES)
+				cnt = DP_MAX_NUM_DP_LANES;
+
+			of_property_read_u64_index(endpoint, "link-frequencies",
+							cnt - 1, &frequency);
+
+			parser->max_dp_link_rate = (frequency / 1000); /* kbits */
+		}
 	} else {
 		parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
+		parser->max_dp_link_rate = DP_LINK_RATE_HBR2; /* 540000 khz */
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
index 866c1a8..3ddf639 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.h
+++ b/drivers/gpu/drm/msm/dp/dp_parser.h
@@ -15,6 +15,7 @@
 #define DP_LABEL "MDSS DP DISPLAY"
 #define DP_MAX_PIXEL_CLK_KHZ	675000
 #define DP_MAX_NUM_DP_LANES	4
+#define DP_LINK_RATE_HBR2       540000
 
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

