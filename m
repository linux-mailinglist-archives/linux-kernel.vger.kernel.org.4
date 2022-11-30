Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA7563CC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiK3ANG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiK3AM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:12:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9688D2A958;
        Tue, 29 Nov 2022 16:12:57 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATNX0j3025189;
        Wed, 30 Nov 2022 00:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=AZ6vt2jKGUOv4azD48DvcGRskVyis4YObWpEOWE6LZg=;
 b=jOiX8wqYDL04+cW4ilEE43UNFYOo7PwkakWKZbH4OsL9PNXqCFcmEBbncR0WtbFmnxwV
 dcUzqh4ejBx2adSb89i5JZoYGlELNfmde7E7vf5HU62tE+fJ1Rxx6CuwFYgTmG8an5NY
 89g53IMj/jOipJ11cb64wvxiagzEQ0cPqaVFWOpj+9LZ6HTTY/ksecmYQ37QJ4mlS7+m
 /i4pydSll3XcYCbWPUyoVw1/DxZjilU3Vo8ueYZSGvfAS/qLwISJvBvqwBnfuDis291t
 llcoEW+HOV++WmiFshsirSh2LvrGe6TniHVy56pOoWS+CJ/dqcZ7pgkCMLSph46Sw0jn Sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m57p7kmry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 00:12:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AU0Co32015935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 00:12:50 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 29 Nov 2022 16:12:49 -0800
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
Subject: [PATCH v5 2/3] drm/msm/dp: parser data-lanes and link-frequencies from endpoint node
Date:   Tue, 29 Nov 2022 16:12:10 -0800
Message-ID: <1669767131-13854-3-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669767131-13854-1-git-send-email-quic_khsieh@quicinc.com>
References: <1669767131-13854-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3GTTyKFpIAYD2Oc6AbfTBR-xaUDu445m
X-Proofpoint-GUID: 3GTTyKFpIAYD2Oc6AbfTBR-xaUDu445m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both data-lanes and link-frequencies are property of endpoint. This
patch parser endpoint to retrieve max data lanes and max link rate
supported specified at dp_out endpoint. In the case where no endpoint
specified, then 4 data lanes with HBR2 link rate (5.4G) will be the
default link configuration.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_parser.c | 34 ++++++++++++++++++++++++++--------
 drivers/gpu/drm/msm/dp/dp_parser.h |  2 ++
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index dd73221..9367f8c 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -94,16 +94,34 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
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
+	struct device_node *endpoint;
+	int cnt;
+	u64 frequence[4];
+
+	endpoint = of_graph_get_endpoint_by_regs(of_node, 1, 0); /* port@1 */
+	if (endpoint) {
+		cnt = of_property_count_u32_elems(endpoint, "data-lanes");
+		if (cnt < 0)
+			parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
+		else
+			parser->max_dp_lanes = cnt;
+
+		cnt = of_property_count_u64_elems(endpoint, "link-frequencies");
+		if (cnt < 0) {
+			parser->max_dp_link_rate = DP_LINK_FREQUENCY_HBR2; /* 54000 khz */
+		} else {
+			if (cnt > 4)	/* 4 frequency at most */
+				cnt = 4;
+			of_property_read_u64_array(endpoint, "link-frequencies", frequence, cnt);
+			parser->max_dp_link_rate = (u32)frequence[cnt  -1];
+			parser->max_dp_link_rate /= 1000;	/* khz */
+		}
+	} else {
+		/* default */
+		parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
+		parser->max_dp_link_rate = DP_LINK_FREQUENCY_HBR2; /* 54000 khz */
 	}
 
-	parser->max_dp_lanes = len;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
index 866c1a8..76ddb751 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.h
+++ b/drivers/gpu/drm/msm/dp/dp_parser.h
@@ -15,6 +15,7 @@
 #define DP_LABEL "MDSS DP DISPLAY"
 #define DP_MAX_PIXEL_CLK_KHZ	675000
 #define DP_MAX_NUM_DP_LANES	4
+#define DP_LINK_FREQUENCY_HBR2	540000
 
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

