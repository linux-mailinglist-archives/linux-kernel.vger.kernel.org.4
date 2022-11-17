Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4962E8B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbiKQWuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbiKQWuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:50:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6201767A;
        Thu, 17 Nov 2022 14:50:05 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHMeuJG021687;
        Thu, 17 Nov 2022 22:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=z4+9HN9t7p07q3/lcD8TiyPjOdLbQCPx9C4p5M7FHpM=;
 b=IceUHpQZuvhAzo8Kb8ViyArQfBiR0vNomGAZIO3iU2Sk1cqLbJ1QLhH94RM8E8kXJuCK
 +wgpUk/pUzJyxven3sWE+YJKDZWAt2IiYgBd6+OMmTUpwnA4SU0XzJBINFbeJsn0i+VS
 PU1anrI+BTsq7Q5UWtQMqXQJaW9QAe0LjiuqUPZvl1BTqrhv2A4ClVDCr9/At2+Ga0Ge
 rCafNOOMO63VvtXuJ72XCFAhuujqPAgCioX1juLDGu4FQdpXo+bHbFkKcJPhbPruKol1
 UF9i0lK1BrJpKdkAs6phH86OxjeVc5EvBTts99Uq4INChdToM3RBXGeXZNqARRs478p1 TA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kwwy500gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:49:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AHMnvED026443
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:49:57 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 17 Nov 2022 14:49:56 -0800
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
Subject: [PATCH v3 2/2] drm/msm/dp: add support of max dp link rate
Date:   Thu, 17 Nov 2022 14:49:29 -0800
Message-ID: <1668725369-6331-3-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1668725369-6331-1-git-send-email-quic_khsieh@quicinc.com>
References: <1668725369-6331-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7Tgn-baWVqQ0NqkhQO8utUHpAxUJv4sd
X-Proofpoint-ORIG-GUID: 7Tgn-baWVqQ0NqkhQO8utUHpAxUJv4sd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dp_out endpoint contains both data-lanes and link-frequencies properties.
This patch parser dp_out endpoint properties and acquire dp_max_lanes and
dp_max_link_rate from respective property. Finally, comparing them against
both data lane and link rate read back from sink to ensure both data lane
and link rate are supported by platform.
In the case there is no data-lanes or link-frequencies property defined at
dp_out endpoint, the default value are 4 data lanes with 5.4 Ghz link rate.

Changes in v2:
-- add max link rate from dtsi

Changes in v3:
-- parser max_data_lanes and max_dp_link_rate from dp_out endpoint

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c  |  4 ++++
 drivers/gpu/drm/msm/dp/dp_panel.c    |  7 ++++---
 drivers/gpu/drm/msm/dp/dp_panel.h    |  1 +
 drivers/gpu/drm/msm/dp/dp_parser.c   | 30 ++++++++++++++++++++++--------
 drivers/gpu/drm/msm/dp/dp_parser.h   |  2 ++
 6 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 4afe53b..d456e76 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3897,6 +3897,7 @@
 						reg = <0>;
 						dp_in: endpoint {
 							remote-endpoint = <&dpu_intf0_out>;
+							data-lanes = <0 1 2 3>;
 						};
 					};
 				};
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 29c9845..4fe2092 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -390,6 +390,10 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
 	struct edid *edid;
 
 	dp->panel->max_dp_lanes = dp->parser->max_dp_lanes;
+	dp->panel->max_dp_link_rate = dp->parser->max_dp_link_rate;
+
+	drm_dbg_dp(dp->drm_dev, "max_lanes=%d max_link_rate=%d\n",
+		dp->panel->max_dp_lanes, dp->panel->max_dp_link_rate);
 
 	rc = dp_panel_read_sink_caps(dp->panel, dp->dp_display.connector);
 	if (rc)
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 5149ceb..933fa9c 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -75,12 +75,13 @@ static int dp_panel_read_dpcd(struct dp_panel *dp_panel)
 	link_info->rate = drm_dp_bw_code_to_link_rate(dpcd[DP_MAX_LINK_RATE]);
 	link_info->num_lanes = dpcd[DP_MAX_LANE_COUNT] & DP_MAX_LANE_COUNT_MASK;
 
+	/* Limit data lanes from data-lanes of endpoint properity of dtsi */
 	if (link_info->num_lanes > dp_panel->max_dp_lanes)
 		link_info->num_lanes = dp_panel->max_dp_lanes;
 
-	/* Limit support upto HBR2 until HBR3 support is added */
-	if (link_info->rate >= (drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4)))
-		link_info->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+	/* Limit link rate from link-frequencies of endpoint properity of dtsi */
+	if (link_info->rate > dp_panel->max_dp_link_rate)
+		link_info->rate = dp_panel->max_dp_link_rate;
 
 	drm_dbg_dp(panel->drm_dev, "version: %d.%d\n", major, minor);
 	drm_dbg_dp(panel->drm_dev, "link_rate=%d\n", link_info->rate);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index d861197a..f04d021 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -50,6 +50,7 @@ struct dp_panel {
 
 	u32 vic;
 	u32 max_dp_lanes;
+	u32 max_dp_link_rate;
 
 	u32 max_bw_code;
 };
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index dd73221..667981e 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -94,16 +94,30 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
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
+	u32 frequence = 0;
+
+	endpoint = of_graph_get_endpoint_by_regs(of_node, 1, 0);
+
+	if (endpoint) {
+		cnt = of_property_count_u32_elems(endpoint, "data-lanes");
+		if (cnt < 0)
+			parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
+		else
+			parser->max_dp_lanes = cnt;
+
+		cnt = of_property_count_u32_elems(endpoint, "link-frequencies");
+		if (cnt < 0) {
+			parser->max_dp_link_rate = DP_LINK_FREQUENCY_HBR2; /* 54000 khz */
+		} else {
+			of_property_read_u32_array(endpoint, "link-frequencies", &frequence, 1);
+			parser->max_dp_link_rate = frequence;
+		}
 	}
 
-	parser->max_dp_lanes = len;
+	pr_err("%s: kuogee, lane=%d frequency=%d\n", __func__, parser->max_dp_lanes, parser->max_dp_link_rate);
+
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

