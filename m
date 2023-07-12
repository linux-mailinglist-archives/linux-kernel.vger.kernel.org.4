Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE586750604
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjGLL1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjGLL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:27:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B08F;
        Wed, 12 Jul 2023 04:27:34 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CB5Vx8008296;
        Wed, 12 Jul 2023 11:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=dtyb8RrTEDjACnbVRF/5ewLfoMkIxFOfcdWAKcWgTm8=;
 b=pYSAvd2iab5IbWWkE14krwaHZxtbclZ4DnwJAUTXRNzKb9/Vft33wq/XHI1EM0vRtN+f
 9ytqn1VwsGGFUytz1a2gy/SL3ATB0X49IEPEAbBqHsB54OfQ+o2TqigmNOg/4ta8bajU
 nBYxwM2YWiuB8jIALZhJYgQTxq3bUlKEt9pgZKcDf9buFqIV7D76FwcP1aQ4/YjitBKZ
 NRXOAtiVYm5a4Gozoc6OnPXhYSO485tm9TYHjdUyFc04cJa7dXXcUDtUPOdmC/WpQOMU
 fbCZJs9oXDBJZlSitlL2a5TPGC5ZFG/M7MmmRlC1yzV2arL8GEibyVH4bF04EW6zBJWJ fA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgar9532-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:27:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CBRQNn005639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:27:26 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 04:26:59 -0700
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
To:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_clew@quicinc.com>,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
Subject: [PATCH net-next 1/3] net: qrtr: ns: Change servers radix tree to xarray
Date:   Wed, 12 Jul 2023 16:56:29 +0530
Message-ID: <20230712112631.3461793-2-quic_viswanat@quicinc.com>
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
X-Proofpoint-GUID: GIJBNhFWSBLwORGMDm6no3MArMxnTeYN
X-Proofpoint-ORIG-GUID: GIJBNhFWSBLwORGMDm6no3MArMxnTeYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0 lowpriorityscore=0
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

There is a use after free scenario while iterating through the servers
radix tree despite the ns being a single threaded process. This can
happen when the radix tree APIs are not synchronized with the
rcu_read_lock() APIs.

Convert the radix tree for servers to xarray to take advantage of the
built in rcu lock usage provided by xarray.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
---
 net/qrtr/ns.c | 133 +++++++++-----------------------------------------
 1 file changed, 24 insertions(+), 109 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 0f7a729f1a1f..039313c3e044 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -66,7 +66,7 @@ struct qrtr_server {
 
 struct qrtr_node {
 	unsigned int id;
-	struct radix_tree_root servers;
+	struct xarray servers;
 };
 
 static struct qrtr_node *node_get(unsigned int node_id)
@@ -83,6 +83,7 @@ static struct qrtr_node *node_get(unsigned int node_id)
 		return NULL;
 
 	node->id = node_id;
+	xa_init(&node->servers);
 
 	if (radix_tree_insert(&nodes, node_id, node)) {
 		kfree(node);
@@ -193,40 +194,23 @@ static void lookup_notify(struct sockaddr_qrtr *to, struct qrtr_server *srv,
 
 static int announce_servers(struct sockaddr_qrtr *sq)
 {
-	struct radix_tree_iter iter;
 	struct qrtr_server *srv;
 	struct qrtr_node *node;
-	void __rcu **slot;
+	unsigned long index;
 	int ret;
 
 	node = node_get(qrtr_ns.local_node);
 	if (!node)
 		return 0;
 
-	rcu_read_lock();
 	/* Announce the list of servers registered in this node */
-	radix_tree_for_each_slot(slot, &node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
-
+	xa_for_each(&node->servers, index, srv) {
 		ret = service_announce_new(sq, srv);
 		if (ret < 0) {
 			pr_err("failed to announce new service\n");
 			return ret;
 		}
-
-		rcu_read_lock();
 	}
-
-	rcu_read_unlock();
-
 	return 0;
 }
 
@@ -256,14 +240,17 @@ static struct qrtr_server *server_add(unsigned int service,
 		goto err;
 
 	/* Delete the old server on the same port */
-	old = radix_tree_lookup(&node->servers, port);
+	old = xa_store(&node->servers, port, srv, GFP_KERNEL);
 	if (old) {
-		radix_tree_delete(&node->servers, port);
-		kfree(old);
+		if (xa_is_err(old)) {
+			pr_err("failed to add server [0x%x:0x%x] ret:%d\n",
+				srv->service, srv->instance, xa_err(old));
+			goto err;
+		} else {
+			kfree(old);
+		}
 	}
 
-	radix_tree_insert(&node->servers, port, srv);
-
 	trace_qrtr_ns_server_add(srv->service, srv->instance,
 				 srv->node, srv->port);
 
@@ -280,11 +267,11 @@ static int server_del(struct qrtr_node *node, unsigned int port, bool bcast)
 	struct qrtr_server *srv;
 	struct list_head *li;
 
-	srv = radix_tree_lookup(&node->servers, port);
+	srv = xa_load(&node->servers, port);
 	if (!srv)
 		return -ENOENT;
 
-	radix_tree_delete(&node->servers, port);
+	xa_erase(&node->servers, port);
 
 	/* Broadcast the removal of local servers */
 	if (srv->node == qrtr_ns.local_node && bcast)
@@ -344,13 +331,12 @@ static int ctrl_cmd_hello(struct sockaddr_qrtr *sq)
 static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 {
 	struct qrtr_node *local_node;
-	struct radix_tree_iter iter;
 	struct qrtr_ctrl_pkt pkt;
 	struct qrtr_server *srv;
 	struct sockaddr_qrtr sq;
 	struct msghdr msg = { };
 	struct qrtr_node *node;
-	void __rcu **slot;
+	unsigned long index;
 	struct kvec iv;
 	int ret;
 
@@ -361,22 +347,9 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 	if (!node)
 		return 0;
 
-	rcu_read_lock();
 	/* Advertise removal of this client to all servers of remote node */
-	radix_tree_for_each_slot(slot, &node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
+	xa_for_each(&node->servers, index, srv)
 		server_del(node, srv->port, true);
-		rcu_read_lock();
-	}
-	rcu_read_unlock();
 
 	/* Advertise the removal of this client to all local servers */
 	local_node = node_get(qrtr_ns.local_node);
@@ -387,18 +360,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 	pkt.cmd = cpu_to_le32(QRTR_TYPE_BYE);
 	pkt.client.node = cpu_to_le32(from->sq_node);
 
-	rcu_read_lock();
-	radix_tree_for_each_slot(slot, &local_node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
-
+	xa_for_each(&local_node->servers, index, srv) {
 		sq.sq_family = AF_QIPCRTR;
 		sq.sq_node = srv->node;
 		sq.sq_port = srv->port;
@@ -411,11 +373,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 			pr_err("failed to send bye cmd\n");
 			return ret;
 		}
-		rcu_read_lock();
 	}
-
-	rcu_read_unlock();
-
 	return 0;
 }
 
@@ -423,7 +381,6 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 			       unsigned int node_id, unsigned int port)
 {
 	struct qrtr_node *local_node;
-	struct radix_tree_iter iter;
 	struct qrtr_lookup *lookup;
 	struct qrtr_ctrl_pkt pkt;
 	struct msghdr msg = { };
@@ -432,7 +389,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 	struct qrtr_node *node;
 	struct list_head *tmp;
 	struct list_head *li;
-	void __rcu **slot;
+	unsigned long index;
 	struct kvec iv;
 	int ret;
 
@@ -477,18 +434,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 	pkt.client.node = cpu_to_le32(node_id);
 	pkt.client.port = cpu_to_le32(port);
 
-	rcu_read_lock();
-	radix_tree_for_each_slot(slot, &local_node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
-
+	xa_for_each(&local_node->servers, index, srv) {
 		sq.sq_family = AF_QIPCRTR;
 		sq.sq_node = srv->node;
 		sq.sq_port = srv->port;
@@ -501,11 +447,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 			pr_err("failed to send del client cmd\n");
 			return ret;
 		}
-		rcu_read_lock();
 	}
-
-	rcu_read_unlock();
-
 	return 0;
 }
 
@@ -576,13 +518,12 @@ static int ctrl_cmd_del_server(struct sockaddr_qrtr *from,
 static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 			       unsigned int service, unsigned int instance)
 {
-	struct radix_tree_iter node_iter;
 	struct qrtr_server_filter filter;
-	struct radix_tree_iter srv_iter;
 	struct qrtr_lookup *lookup;
 	struct qrtr_node *node;
-	void __rcu **node_slot;
-	void __rcu **srv_slot;
+	struct qrtr_server *srv;
+	unsigned long node_idx;
+	unsigned long srv_idx;
 
 	/* Accept only local observers */
 	if (from->sq_node != qrtr_ns.local_node)
@@ -601,40 +542,14 @@ static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 	filter.service = service;
 	filter.instance = instance;
 
-	rcu_read_lock();
-	radix_tree_for_each_slot(node_slot, &nodes, &node_iter, 0) {
-		node = radix_tree_deref_slot(node_slot);
-		if (!node)
-			continue;
-		if (radix_tree_deref_retry(node)) {
-			node_slot = radix_tree_iter_retry(&node_iter);
-			continue;
-		}
-		node_slot = radix_tree_iter_resume(node_slot, &node_iter);
-
-		radix_tree_for_each_slot(srv_slot, &node->servers,
-					 &srv_iter, 0) {
-			struct qrtr_server *srv;
-
-			srv = radix_tree_deref_slot(srv_slot);
-			if (!srv)
-				continue;
-			if (radix_tree_deref_retry(srv)) {
-				srv_slot = radix_tree_iter_retry(&srv_iter);
-				continue;
-			}
-
+	xa_for_each(&nodes, node_idx, node) {
+		xa_for_each(&node->servers, srv_idx, srv) {
 			if (!server_match(srv, &filter))
 				continue;
 
-			srv_slot = radix_tree_iter_resume(srv_slot, &srv_iter);
-
-			rcu_read_unlock();
 			lookup_notify(from, srv, true);
-			rcu_read_lock();
 		}
 	}
-	rcu_read_unlock();
 
 	/* Empty notification, to indicate end of listing */
 	lookup_notify(from, NULL, true);
-- 
2.41.0

