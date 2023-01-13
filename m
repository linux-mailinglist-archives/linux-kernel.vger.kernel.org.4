Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31F766A5B5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjAMWIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAMWIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:08:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FABA11826;
        Fri, 13 Jan 2023 14:08:46 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DLmWjv025561;
        Fri, 13 Jan 2023 22:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=dsGJlaQuvGBZBxMWCJCDqU2zhJ/sq0AQpKWU/9sWrS0=;
 b=MLLeEgWPy5TKMLjHQGvC94+VRKtthKfRsPxBGZhya0ihGH6XOShMVYIsAc5QF6L+U7ZS
 /DlJf6liUcK+1IkLwa7/btIx4S7BpDKCRnLidszv+afmwvlArdop10prBItYJqzvK3SM
 AjZObMOP7oMCnw1zxRQ8+IQT9rbxq3a0KA4ewmOsa8VS+yEHT9rxLBOm9O61vwJuc3yB
 +uIIAnYdi67B+sz+fW1xWup+anninnVF0V788RCPXB+UD4v9OCDepm8TgM4wRGl36+k4
 k5Wq6eiWOO2W52UzJliHwOF7TWl+qWUke8KkK2vIE95nEADuTHzw8vxl9Y6nZI+7ReQk Tg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2k47kux1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 22:08:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DM8g3X014988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 22:08:42 GMT
Received: from hu-viveka-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 14:08:42 -0800
From:   Vivek Aknurwar <quic_viveka@quicinc.com>
To:     <djakov@kernel.org>
CC:     <quic_mdtipton@quicinc.com>, <quic_okukatla@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vivek Aknurwar <quic_viveka@quicinc.com>
Subject: [PATCH] interconnect: Skip call into provider if initial bw is zero
Date:   Fri, 13 Jan 2023 14:07:59 -0800
Message-ID: <1673647679-15216-1-git-send-email-quic_viveka@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Pqp_ndKn4AepxXxjB8BjiJ8F0S0XCira
X-Proofpoint-ORIG-GUID: Pqp_ndKn4AepxXxjB8BjiJ8F0S0XCira
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1011 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301130152
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently framework sets bw even when init bw requirements are zero during
provider registration, thus resulting bulk of set bw to hw.
Avoid this behaviour by skipping provider set bw calls if init bw is zero.

Signed-off-by: Vivek Aknurwar <quic_viveka@quicinc.com>
---
 drivers/interconnect/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 25debde..43ed595 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -977,14 +977,17 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = node->init_avg;
 	node->peak_bw = node->init_peak;
 
-	if (provider->pre_aggregate)
-		provider->pre_aggregate(node);
-
-	if (provider->aggregate)
-		provider->aggregate(node, 0, node->init_avg, node->init_peak,
-				    &node->avg_bw, &node->peak_bw);
+	if (node->avg_bw || node->peak_bw) {
+		if (provider->pre_aggregate)
+			provider->pre_aggregate(node);
+
+		if (provider->aggregate)
+			provider->aggregate(node, 0, node->init_avg, node->init_peak,
+					    &node->avg_bw, &node->peak_bw);
+		if (provider->set)
+			provider->set(node, node);
+	}
 
-	provider->set(node, node);
 	node->avg_bw = 0;
 	node->peak_bw = 0;
 
-- 
2.7.4

