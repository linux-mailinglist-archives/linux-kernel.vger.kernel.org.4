Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C45750602
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjGLL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjGLL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:27:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39773173A;
        Wed, 12 Jul 2023 04:27:33 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8cmuk026157;
        Wed, 12 Jul 2023 11:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Gs56pmtfCp16afU4tLMf5PgqdJecLIO6WoHfuRQb6Uo=;
 b=YxPaY4CWl8YFeyWzOX+Frhas2ixuCMHNK6bqrObOt8W6Y0b9xXFY2ajQsILLpV1ohsBL
 QlcDr9K2Q4/RLqkqJXzpPkiuDCjPH0daYrt8/29wcAee4uBR4U5QLZjQ00B/NurDgYe+
 T8IOLahUYr9IEeHdl4r93szNHQOIJhNiL8QjA4A7RhxOVa1PnWuXK+Y2izb7JEf43Jvw
 N1uCPzQ3tDWdjRNS87rOKXGaRsBa2L8tOJDke/BX1tLfQo1mE9/Fk8i/ztSJbwqwVZTA
 91+WXx8toxCCaFKcsxznXNyeMFrwU3bpmCY1gVoBxR7QuZ1Sfp0MQg6rqI9txTXDnBin 4Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsf4s9a6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:27:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CBRQNo005639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:27:26 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 04:27:04 -0700
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
To:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_clew@quicinc.com>,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
Subject: [PATCH net-next 2/3] net: qrtr: ns: Change nodes radix tree to xarray
Date:   Wed, 12 Jul 2023 16:56:30 +0530
Message-ID: <20230712112631.3461793-3-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712112631.3461793-1-quic_viswanat@quicinc.com>
References: <20230712112631.3461793-1-quic_viswanat@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L24iVOAFuh7LFLT1Zfvw4aZCLWNZ38KE
X-Proofpoint-ORIG-GUID: L24iVOAFuh7LFLT1Zfvw4aZCLWNZ38KE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=724 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a use after free scenario while iterating through the nodes
radix tree despite the ns being a single threaded process. This can
happen when the radix tree APIs are not synchronized with the
rcu_read_lock() APIs.

Convert the radix tree for nodes to xarray to take advantage of the
built in rcu lock usage provided by xarray.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
---
 net/qrtr/ns.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 039313c3e044..12de671d7992 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -16,7 +16,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/qrtr.h>
 
-static RADIX_TREE(nodes, GFP_KERNEL);
+static DEFINE_XARRAY(nodes);
 
 static struct {
 	struct socket *sock;
@@ -73,7 +73,7 @@ static struct qrtr_node *node_get(unsigned int node_id)
 {
 	struct qrtr_node *node;
 
-	node = radix_tree_lookup(&nodes, node_id);
+	node = xa_load(&nodes, node_id);
 	if (node)
 		return node;
 
@@ -85,7 +85,7 @@ static struct qrtr_node *node_get(unsigned int node_id)
 	node->id = node_id;
 	xa_init(&node->servers);
 
-	if (radix_tree_insert(&nodes, node_id, node)) {
+	if (xa_store(&nodes, node_id, node, GFP_KERNEL)) {
 		kfree(node);
 		return NULL;
 	}
-- 
2.41.0

