Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E9D6108F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiJ1Dm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiJ1DmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:42:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA088D0CEE;
        Thu, 27 Oct 2022 20:42:14 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S2o5fI026807;
        Fri, 28 Oct 2022 03:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=zQITVjOMu36nG2pgpk3PWbR8z3tJSa1zpAQs+GL2+DQ=;
 b=KCzQlkVmoDuFXf1OjiipwRf9QJ6q6y2hkxeB6HLdAs7uR6hbJs+2QSjzX81xb29OegBo
 GPGR4kKbjXK4dLDysK43P2peqnIfdPqcqCjnXq3UkK+k48V0BPUS7C2eLPBxHysHF5l/
 u2CCdAJ+4bbsqpsjDhf+V9ZpHAK/1oaqksVBEBm4RNkzz+i87Dfi09IV5RmsJMZxygwH
 bQncYZAKbxpX+pWMuRG7H3Z/HOrHniBGpZI3mXmzOFjjEvBttvDe4P7kIxaQGDxqYi35
 TfK+zVqCWqPnVjyDwR3sO7zuixOvYw66psdtjlw8rXV2mCTW/QNKUlFNes54/tZi6INH GQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kg59ag9bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 03:42:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29S3g2Ib001380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 03:42:02 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 27 Oct 2022 20:42:02 -0700
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
Subject: [PATCH 02/10] interconnect: qcom: osm-l3: Squash common descriptors
Date:   Thu, 27 Oct 2022 20:41:47 -0700
Message-ID: <20221028034155.5580-3-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028034155.5580-1-quic_bjorande@quicinc.com>
References: <20221028034155.5580-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fhD7k9tAvN8qFkCyoiKpXXB_CsRrvu2B
X-Proofpoint-ORIG-GUID: fhD7k9tAvN8qFkCyoiKpXXB_CsRrvu2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each platform defines their own OSM L3 descriptor, but in practice
there's only two: one for OSM and one for EPSS. Remove the duplicated
definitions.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/interconnect/qcom/osm-l3.c | 48 +++++-------------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index d23769844419..7d6844253241 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -104,7 +104,7 @@ static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
 	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
 };
 
-static const struct qcom_osm_l3_desc sdm845_icc_osm_l3 = {
+static const struct qcom_osm_l3_desc osm_l3 = {
 	.nodes = osm_l3_nodes,
 	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
 	.lut_row_size = OSM_LUT_ROW_SIZE,
@@ -112,39 +112,7 @@ static const struct qcom_osm_l3_desc sdm845_icc_osm_l3 = {
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
-static const struct qcom_osm_l3_desc sc7180_icc_osm_l3 = {
-	.nodes = osm_l3_nodes,
-	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
-	.lut_row_size = OSM_LUT_ROW_SIZE,
-	.reg_freq_lut = OSM_REG_FREQ_LUT,
-	.reg_perf_state = OSM_REG_PERF_STATE,
-};
-
-static const struct qcom_osm_l3_desc sc7280_icc_epss_l3 = {
-	.nodes = epss_l3_nodes,
-	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
-	.lut_row_size = EPSS_LUT_ROW_SIZE,
-	.reg_freq_lut = EPSS_REG_FREQ_LUT,
-	.reg_perf_state = EPSS_REG_PERF_STATE,
-};
-
-static const struct qcom_osm_l3_desc sc8180x_icc_osm_l3 = {
-	.nodes = osm_l3_nodes,
-	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
-	.lut_row_size = OSM_LUT_ROW_SIZE,
-	.reg_freq_lut = OSM_REG_FREQ_LUT,
-	.reg_perf_state = OSM_REG_PERF_STATE,
-};
-
-static const struct qcom_osm_l3_desc sm8150_icc_osm_l3 = {
-	.nodes = osm_l3_nodes,
-	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
-	.lut_row_size = OSM_LUT_ROW_SIZE,
-	.reg_freq_lut = OSM_REG_FREQ_LUT,
-	.reg_perf_state = OSM_REG_PERF_STATE,
-};
-
-static const struct qcom_osm_l3_desc sm8250_icc_epss_l3 = {
+static const struct qcom_osm_l3_desc epss_l3 = {
 	.nodes = epss_l3_nodes,
 	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
 	.lut_row_size = EPSS_LUT_ROW_SIZE,
@@ -317,12 +285,12 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id osm_l3_of_match[] = {
-	{ .compatible = "qcom,sc7180-osm-l3", .data = &sc7180_icc_osm_l3 },
-	{ .compatible = "qcom,sc7280-epss-l3", .data = &sc7280_icc_epss_l3 },
-	{ .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_icc_osm_l3 },
-	{ .compatible = "qcom,sm8150-osm-l3", .data = &sm8150_icc_osm_l3 },
-	{ .compatible = "qcom,sc8180x-osm-l3", .data = &sc8180x_icc_osm_l3 },
-	{ .compatible = "qcom,sm8250-epss-l3", .data = &sm8250_icc_epss_l3 },
+	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
+	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3 },
+	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
+	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
+	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
+	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, osm_l3_of_match);
-- 
2.37.3

