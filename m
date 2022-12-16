Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B6364F36B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiLPVqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiLPVpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:45:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B66C716;
        Fri, 16 Dec 2022 13:45:31 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGKd0Vo030801;
        Fri, 16 Dec 2022 21:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2oEu5kV5NSvp+e6NqVD0jrxmHSZkM/q7dHGy8yztSLw=;
 b=Yxj2CBUBXUJYFIrxjnrE2eTIIGfY22TpOBPYln6Wgc4xF9KEZ7dn/qalPdkeU8O7Ajr7
 e64rnvUSja1XePaBwz2wSPX7OpETsU4OF1olxIkGc8gOfx7OBoGfxhw0Lci9EfNZt62t
 F3CQkG9q24O/5ixuCLMvEZ9+fN2y7MXS3+U/sKfWSQ1eVQvbbaxR9hTCPnmdisWHdUNv
 2JH2PZ/qtG2rKo0yaGETE8PQeUGMa/ZXGk3Uo8WDrC7FlEIdO9TOuJtqfHVmjwLkDSF4
 QsG/4hZSTkIH6fwlGlyjLDCp3oinA4TvvGMXueNyAYxbnW23m4hHqoM1JLbPnZ0ujQRa 5g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg2vwda2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 21:45:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BGLjJ0w020944
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 21:45:19 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 13:45:18 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <airlied@gmail.com>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v15 4/5] Add capability to parser and retrieve max DP link supported rate from link-frequencies property of dp_out endpoint.
Date:   Fri, 16 Dec 2022 13:45:01 -0800
Message-ID: <1671227102-21717-5-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671227102-21717-1-git-send-email-quic_khsieh@quicinc.com>
References: <1671227102-21717-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p_E4kVjj7oDhMzRPToBkBflXN9Q7wLJ0
X-Proofpoint-ORIG-GUID: p_E4kVjj7oDhMzRPToBkBflXN9Q7wLJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160194
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v6:
-- second patch after split parser patch into two patches

Changes in v7:
-- without checking cnt against DP_MAX_NUM_DP_LANES to retrieve link rate

Changes in v9:
-- separate parser link-frequencies out of data-lanes

Changes in v10:
-- add dp_parser_link_frequencies()

Changes in v11:
-- return 0 if(!endpoint)

Changes in v12:
-- replace khz with kbytes at dp_parser.h

Changes in v14:
-- replace "parser" with "parse" at commit subject
-- use do_div() for 64 bits division

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_parser.c | 28 ++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_parser.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index e3ba322..42c0793 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -91,6 +91,30 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
 	return 0;
 }
 
+static u32 dp_parser_link_frequencies(struct device_node *of_node)
+{
+	struct device_node *endpoint;
+	u64 frequency = 0;
+	int cnt;
+
+	endpoint = of_graph_get_endpoint_by_regs(of_node, 1, 0); /* port@1 */
+	if (!endpoint)
+		return 0;
+
+	cnt = of_property_count_u64_elems(endpoint, "link-frequencies");
+
+	if (cnt > 0)
+		of_property_read_u64_index(endpoint, "link-frequencies",
+						cnt - 1, &frequency);
+	of_node_put(endpoint);
+
+	do_div(frequency,
+		10 * /* from symbol rate to link rate */
+		1000); /* kbytes */
+
+	return frequency;
+}
+
 static int dp_parser_misc(struct dp_parser *parser)
 {
 	struct device_node *of_node = parser->pdev->dev.of_node;
@@ -110,6 +134,10 @@ static int dp_parser_misc(struct dp_parser *parser)
 	else
 		parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
 
+	parser->max_dp_link_rate = dp_parser_link_frequencies(of_node);
+	if (!parser->max_dp_link_rate)
+		parser->max_dp_link_rate = DP_LINK_RATE_HBR2;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
index 866c1a8..526131ee 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.h
+++ b/drivers/gpu/drm/msm/dp/dp_parser.h
@@ -15,6 +15,7 @@
 #define DP_LABEL "MDSS DP DISPLAY"
 #define DP_MAX_PIXEL_CLK_KHZ	675000
 #define DP_MAX_NUM_DP_LANES	4
+#define DP_LINK_RATE_HBR2	540000 /* kbytes */
 
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

