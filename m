Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8076251A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiKKDZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiKKDZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:25:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816DC5B59F;
        Thu, 10 Nov 2022 19:25:35 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB2upqA018074;
        Fri, 11 Nov 2022 03:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=KVy2F4GdMfJKDsvGf/PKbRUwQn0Evm524WuZkRAFovw=;
 b=cfwFuhV+cyn8YpsLaAEhtcXKQVvnLY+kn5eiimVWAwi4/ar1KKFJQbL2guNARQ9/zcWo
 cJDQe7LSKjsl8Z7fmfhRSJbjk6C5I/KgGKEUhRa3lGP8kWuNbzJhnTkpJbHt4PoJ6zRH
 U/mP8BBs1FT6todPLg9LO1UbUlNSUDPVT0dGBHaxUWCXPgrmuurOBZgfZH577CtMBN3h
 y6UCm3DSf7n5lwXlD6A0sNxXnQ6tBaMZlqORqG4eAlxzG0ZOxsg2ocT2vpe4cT9oIxas
 4NvqggiCwqavfAaJceU0JvX84I2fGJo+XcHHZTU09yIwLIvFaVV3HY7ntF0pr/VtU/GQ hQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksah80f3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AB3PLlI027150
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:21 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 10 Nov 2022 19:25:21 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        "Johan Hovold" <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/10] interconnect: qcom: osm-l3: Use platform-independent node ids
Date:   Thu, 10 Nov 2022 19:25:06 -0800
Message-ID: <20221111032515.3460-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111032515.3460-1-quic_bjorande@quicinc.com>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pi0_ewH2bYueWuYVSMXj7z7V6ypCc39z
X-Proofpoint-GUID: pi0_ewH2bYueWuYVSMXj7z7V6ypCc39z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The identifiers used for nodes needs to be unique in the running system,
but defining them per platform results in a lot of duplicated
definitions and prevents us from using generic compatibles.

As these identifiers are not exposed outside the kernel, change to use
driver-local numbers, picked completely at random.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Tested-by: Steev Klimaszewski <steev@kali.org>
---

Changes since v1:
- None

 drivers/interconnect/qcom/osm-l3.c | 87 +++++++++++-------------------
 1 file changed, 30 insertions(+), 57 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index ddbdf0943f94..d23769844419 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -74,6 +74,11 @@ struct qcom_osm_l3_desc {
 	unsigned int reg_perf_state;
 };
 
+enum {
+	OSM_L3_MASTER_NODE = 10000,
+	OSM_L3_SLAVE_NODE,
+};
+
 #define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
 	static const struct qcom_osm_l3_node _name = {			\
 		.name = #_name,						\
@@ -83,97 +88,65 @@ struct qcom_osm_l3_desc {
 		.links = { __VA_ARGS__ },				\
 	}
 
-DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, SDM845_SLAVE_OSM_L3);
-DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16);
+DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
+DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
+
+static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
+	[MASTER_OSM_L3_APPS] = &osm_l3_master,
+	[SLAVE_OSM_L3] = &osm_l3_slave,
+};
+
+DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
+DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
 
-static const struct qcom_osm_l3_node * const sdm845_osm_l3_nodes[] = {
-	[MASTER_OSM_L3_APPS] = &sdm845_osm_apps_l3,
-	[SLAVE_OSM_L3] = &sdm845_osm_l3,
+static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
+	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
+	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
 };
 
 static const struct qcom_osm_l3_desc sdm845_icc_osm_l3 = {
-	.nodes = sdm845_osm_l3_nodes,
-	.num_nodes = ARRAY_SIZE(sdm845_osm_l3_nodes),
+	.nodes = osm_l3_nodes,
+	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
 	.lut_row_size = OSM_LUT_ROW_SIZE,
 	.reg_freq_lut = OSM_REG_FREQ_LUT,
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
-DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, SC7180_SLAVE_OSM_L3);
-DEFINE_QNODE(sc7180_osm_l3, SC7180_SLAVE_OSM_L3, 16);
-
-static const struct qcom_osm_l3_node * const sc7180_osm_l3_nodes[] = {
-	[MASTER_OSM_L3_APPS] = &sc7180_osm_apps_l3,
-	[SLAVE_OSM_L3] = &sc7180_osm_l3,
-};
-
 static const struct qcom_osm_l3_desc sc7180_icc_osm_l3 = {
-	.nodes = sc7180_osm_l3_nodes,
-	.num_nodes = ARRAY_SIZE(sc7180_osm_l3_nodes),
+	.nodes = osm_l3_nodes,
+	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
 	.lut_row_size = OSM_LUT_ROW_SIZE,
 	.reg_freq_lut = OSM_REG_FREQ_LUT,
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
-DEFINE_QNODE(sc7280_epss_apps_l3, SC7280_MASTER_EPSS_L3_APPS, 32, SC7280_SLAVE_EPSS_L3);
-DEFINE_QNODE(sc7280_epss_l3, SC7280_SLAVE_EPSS_L3, 32);
-
-static const struct qcom_osm_l3_node * const sc7280_epss_l3_nodes[] = {
-	[MASTER_EPSS_L3_APPS] = &sc7280_epss_apps_l3,
-	[SLAVE_EPSS_L3_SHARED] = &sc7280_epss_l3,
-};
-
 static const struct qcom_osm_l3_desc sc7280_icc_epss_l3 = {
-	.nodes = sc7280_epss_l3_nodes,
-	.num_nodes = ARRAY_SIZE(sc7280_epss_l3_nodes),
+	.nodes = epss_l3_nodes,
+	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
 	.lut_row_size = EPSS_LUT_ROW_SIZE,
 	.reg_freq_lut = EPSS_REG_FREQ_LUT,
 	.reg_perf_state = EPSS_REG_PERF_STATE,
 };
 
-DEFINE_QNODE(sc8180x_osm_apps_l3, SC8180X_MASTER_OSM_L3_APPS, 32, SC8180X_SLAVE_OSM_L3);
-DEFINE_QNODE(sc8180x_osm_l3, SC8180X_SLAVE_OSM_L3, 32);
-
-static const struct qcom_osm_l3_node * const sc8180x_osm_l3_nodes[] = {
-	[MASTER_OSM_L3_APPS] = &sc8180x_osm_apps_l3,
-	[SLAVE_OSM_L3] = &sc8180x_osm_l3,
-};
-
 static const struct qcom_osm_l3_desc sc8180x_icc_osm_l3 = {
-	.nodes = sc8180x_osm_l3_nodes,
-	.num_nodes = ARRAY_SIZE(sc8180x_osm_l3_nodes),
+	.nodes = osm_l3_nodes,
+	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
 	.lut_row_size = OSM_LUT_ROW_SIZE,
 	.reg_freq_lut = OSM_REG_FREQ_LUT,
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
-DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, SM8150_SLAVE_OSM_L3);
-DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32);
-
-static const struct qcom_osm_l3_node * const sm8150_osm_l3_nodes[] = {
-	[MASTER_OSM_L3_APPS] = &sm8150_osm_apps_l3,
-	[SLAVE_OSM_L3] = &sm8150_osm_l3,
-};
-
 static const struct qcom_osm_l3_desc sm8150_icc_osm_l3 = {
-	.nodes = sm8150_osm_l3_nodes,
-	.num_nodes = ARRAY_SIZE(sm8150_osm_l3_nodes),
+	.nodes = osm_l3_nodes,
+	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
 	.lut_row_size = OSM_LUT_ROW_SIZE,
 	.reg_freq_lut = OSM_REG_FREQ_LUT,
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
-DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, SM8250_SLAVE_EPSS_L3);
-DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32);
-
-static const struct qcom_osm_l3_node * const sm8250_epss_l3_nodes[] = {
-	[MASTER_EPSS_L3_APPS] = &sm8250_epss_apps_l3,
-	[SLAVE_EPSS_L3_SHARED] = &sm8250_epss_l3,
-};
-
 static const struct qcom_osm_l3_desc sm8250_icc_epss_l3 = {
-	.nodes = sm8250_epss_l3_nodes,
-	.num_nodes = ARRAY_SIZE(sm8250_epss_l3_nodes),
+	.nodes = epss_l3_nodes,
+	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
 	.lut_row_size = EPSS_LUT_ROW_SIZE,
 	.reg_freq_lut = EPSS_REG_FREQ_LUT,
 	.reg_perf_state = EPSS_REG_PERF_STATE,
-- 
2.17.1

