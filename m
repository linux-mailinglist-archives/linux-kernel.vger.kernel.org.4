Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C5E6108D9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbiJ1DmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiJ1DmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:42:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE946D0CEC;
        Thu, 27 Oct 2022 20:42:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S1j6DU001501;
        Fri, 28 Oct 2022 03:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ljwIYDmtXdUHA7IxdT6F5j2COIUJnQYPZUcPwQawneE=;
 b=WjXVqGJX/AwG51ifoYc0dvpBArFuxTBoesa+n6DRdNysQ6t/UsQXXHX0RRarG2zAMEKW
 DNis5W8G9YrmtXybpl2+CGjMzcSWtG2lVocZfCV2UX5Szmqu8gBGoOuaMqJWGXH6JCXW
 X25JmPSQ02tjozl3QzGUgNogQflD/LoT4VDFNjEKbBaJWbK9is3rov9SP5vsg9eLA7o3
 LIvhfq9AdbsKPsAxFpQ3hpst9uf20mTC81W8ZGQ/8EXTDJ5g3iXzg+bKSb1scNcewXCN
 TYv1ChUWfODNFndcBQqQYbLV61ZrAPU8P4gNRUbfLuvvoR8uxrp700c4eP5wE49xP7Gi nw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfyf7h3fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 03:42:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29S3g35b001400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 03:42:03 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 27 Oct 2022 20:42:03 -0700
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
Subject: [PATCH 04/10] interconnect: qcom: osm-l3: Simplify osm_l3_set()
Date:   Thu, 27 Oct 2022 20:41:49 -0700
Message-ID: <20221028034155.5580-5-quic_bjorande@quicinc.com>
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
X-Proofpoint-ORIG-GUID: OQfNPHyCpKZOby8IWgexqsRN2f0KzCw0
X-Proofpoint-GUID: OQfNPHyCpKZOby8IWgexqsRN2f0KzCw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aggregation over votes for all nodes in the provider will always
only find the bandwidth votes for the destination side of the path.
Further more, the average kBps value will always be 0.

Simplify the logic by directly looking at the destination node's peak
bandwidth request.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/interconnect/qcom/osm-l3.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 469be732a00b..5fa171087425 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -134,22 +134,14 @@ static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
 	struct qcom_osm_l3_icc_provider *qp;
 	struct icc_provider *provider;
 	const struct qcom_osm_l3_node *qn;
-	struct icc_node *n;
 	unsigned int index;
-	u32 agg_peak = 0;
-	u32 agg_avg = 0;
 	u64 rate;
 
 	qn = src->data;
 	provider = src->provider;
 	qp = to_osm_l3_provider(provider);
 
-	list_for_each_entry(n, &provider->nodes, node_list)
-		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
-				    &agg_avg, &agg_peak);
-
-	rate = max(agg_avg, agg_peak);
-	rate = icc_units_to_bps(rate);
+	rate = icc_units_to_bps(dst->peak_bw);
 	do_div(rate, qn->buswidth);
 
 	for (index = 0; index < qp->max_state - 1; index++) {
-- 
2.37.3

