Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86F473D870
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjFZHYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjFZHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:24:36 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC9E1AD;
        Mon, 26 Jun 2023 00:24:34 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q4kM7o025846;
        Mon, 26 Jun 2023 00:24:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=MLBI5yNtEj5QiGpTZ+ouXSBcoGGKWhR8JqCVNLfJEjc=;
 b=CKBNhoouvEUjYcUP3Wroi5um9J8nuXjuI6RdLruwg8r6YDre+3+xdjRcZwlQ2NeADNLE
 tX/IN5yyxD+pNuCjiOu338hRVBpn65CUOwa31TCosGuo2p7DNgx91h2ZMW3lwlKkVJCB
 6a5xsUxBj11EKfv2pSlLU5EALvOoDLpRmfeD/iULiXgCpoLrZm0rJpmvBQoZWlR99HQc
 Dw2HPUavR4K7gu3CsvvAI3fIK1a7VyJJVKtR5xcw/8uwjCnMCJxuSgj7bda2OBIPdQrH
 nLDfyvnTGsXODyBp5D0333k22g6B7yGTjFiB78O7EJQbc0e15hq32t2qTImouF/nFNx6 Bg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3re00juufb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 00:24:22 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 26 Jun
 2023 00:24:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 26 Jun 2023 00:24:20 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id D5ADC3F7085;
        Mon, 26 Jun 2023 00:24:14 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>,
        <willemdebruijn.kernel@gmail.com>, <andrew@lunn.ch>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <naveenm@marvell.com>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <maxtram95@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: [net-next Patchv2 1/3] octeontx2-pf: implement transmit schedular allocation algorithm
Date:   Mon, 26 Jun 2023 12:54:05 +0530
Message-ID: <20230626072407.32158-2-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626072407.32158-1-hkelam@marvell.com>
References: <20230626072407.32158-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 91DUem_wgic8olXxgYtBNBaC2aXEzBoK
X-Proofpoint-ORIG-GUID: 91DUem_wgic8olXxgYtBNBaC2aXEzBoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_04,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Mamindlapalli <naveenm@marvell.com>

unlike strict priority, where number of classes are limited to max
8, there is no restriction on the number of dwrr child nodes unless
the count increases the max number of child nodes supported.

Hardware expects strict priority transmit schedular indexes mapped
to their priority. This patch adds defines transmit schedular allocation
algorithm such that the above requirement is honored.

Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/qos.c  | 129 +++++++++++++++++-
 .../net/ethernet/marvell/octeontx2/nic/qos.h  |   6 +
 2 files changed, 129 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index d3a76c5ccda8..51e9be55d5f5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -19,6 +19,7 @@
 #define OTX2_QOS_CLASS_NONE		0
 #define OTX2_QOS_DEFAULT_PRIO		0xF
 #define OTX2_QOS_INVALID_SQ		0xFFFF
+#define OTX2_QOS_INVALID_TXSCHQ_IDX	0xFFFF
 
 static void otx2_qos_update_tx_netdev_queues(struct otx2_nic *pfvf)
 {
@@ -315,9 +316,12 @@ static void otx2_qos_fill_cfg_tl(struct otx2_qos_node *parent,
 
 	list_for_each_entry(node, &parent->child_list, list) {
 		otx2_qos_fill_cfg_tl(node, cfg);
-		cfg->schq_contig[node->level]++;
 		otx2_qos_fill_cfg_schq(node, cfg);
 	}
+
+	/* Assign the required number of transmit schedular queues under the given class */
+	cfg->schq_contig[parent->level - 1] += parent->child_dwrr_cnt +
+					       parent->max_static_prio + 1;
 }
 
 static void otx2_qos_prepare_txschq_cfg(struct otx2_nic *pfvf,
@@ -401,9 +405,13 @@ static int otx2_qos_add_child_node(struct otx2_qos_node *parent,
 	struct otx2_qos_node *tmp_node;
 	struct list_head *tmp;
 
+	if (node->prio > parent->max_static_prio)
+		parent->max_static_prio = node->prio;
+
 	for (tmp = head->next; tmp != head; tmp = tmp->next) {
 		tmp_node = list_entry(tmp, struct otx2_qos_node, list);
-		if (tmp_node->prio == node->prio)
+		if (tmp_node->prio == node->prio &&
+		    tmp_node->is_static)
 			return -EEXIST;
 		if (tmp_node->prio > node->prio) {
 			list_add_tail(&node->list, tmp);
@@ -476,6 +484,7 @@ otx2_qos_sw_create_leaf_node(struct otx2_nic *pfvf,
 	node->rate = otx2_convert_rate(rate);
 	node->ceil = otx2_convert_rate(ceil);
 	node->prio = prio;
+	node->is_static = true;
 
 	__set_bit(qid, pfvf->qos.qos_sq_bmap);
 
@@ -628,6 +637,20 @@ static int otx2_qos_txschq_alloc(struct otx2_nic *pfvf,
 	return rc;
 }
 
+static void otx2_qos_free_unused_txschq(struct otx2_nic *pfvf, struct otx2_qos_cfg *cfg)
+{
+	int lvl, idx, schq;
+
+	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
+		for (idx = 0; idx < cfg->schq_contig[lvl]; idx++) {
+			if (!cfg->schq_index_used[lvl][idx]) {
+				schq = cfg->schq_contig_list[lvl][idx];
+				otx2_txschq_free_one(pfvf, lvl, schq);
+			}
+		}
+	}
+}
+
 static void otx2_qos_txschq_fill_cfg_schq(struct otx2_nic *pfvf,
 					  struct otx2_qos_node *node,
 					  struct otx2_qos_cfg *cfg)
@@ -652,9 +675,10 @@ static void otx2_qos_txschq_fill_cfg_tl(struct otx2_nic *pfvf,
 	list_for_each_entry(tmp, &node->child_list, list) {
 		otx2_qos_txschq_fill_cfg_tl(pfvf, tmp, cfg);
 		cnt = cfg->static_node_pos[tmp->level];
-		tmp->schq = cfg->schq_contig_list[tmp->level][cnt];
+		tmp->schq = cfg->schq_contig_list[tmp->level][tmp->txschq_idx];
+		cfg->schq_index_used[tmp->level][tmp->txschq_idx] = true;
 		if (cnt == 0)
-			node->prio_anchor = tmp->schq;
+			node->prio_anchor = cfg->schq_contig_list[tmp->level][0];
 		cfg->static_node_pos[tmp->level]++;
 		otx2_qos_txschq_fill_cfg_schq(pfvf, tmp, cfg);
 	}
@@ -667,9 +691,84 @@ static void otx2_qos_txschq_fill_cfg(struct otx2_nic *pfvf,
 	mutex_lock(&pfvf->qos.qos_lock);
 	otx2_qos_txschq_fill_cfg_tl(pfvf, node, cfg);
 	otx2_qos_txschq_fill_cfg_schq(pfvf, node, cfg);
+	otx2_qos_free_unused_txschq(pfvf, cfg);
 	mutex_unlock(&pfvf->qos.qos_lock);
 }
 
+static void __otx2_qos_assign_base_idx_tl(struct otx2_nic *pfvf,
+					  struct otx2_qos_node *tmp,
+					  unsigned long *child_idx_bmap,
+					  int child_cnt)
+{
+	int idx;
+
+	if (tmp->txschq_idx != OTX2_QOS_INVALID_TXSCHQ_IDX)
+		return;
+
+	/* assign static nodes 1:1 prio mapping first, then remaining nodes */
+	for (idx = 0; idx < child_cnt; idx++) {
+		if (tmp->is_static && tmp->prio == idx &&
+		    !test_bit(idx, child_idx_bmap)) {
+			tmp->txschq_idx = idx;
+			set_bit(idx, child_idx_bmap);
+			return;
+		} else if (!tmp->is_static && idx >= tmp->prio &&
+			   !test_bit(idx, child_idx_bmap)) {
+			tmp->txschq_idx = idx;
+			set_bit(idx, child_idx_bmap);
+			return;
+		}
+	}
+}
+
+static int otx2_qos_assign_base_idx_tl(struct otx2_nic *pfvf,
+				       struct otx2_qos_node *node)
+{
+	unsigned long *child_idx_bmap;
+	struct otx2_qos_node *tmp;
+	int child_cnt;
+
+	list_for_each_entry(tmp, &node->child_list, list)
+		tmp->txschq_idx = OTX2_QOS_INVALID_TXSCHQ_IDX;
+
+	/* allocate child index array */
+	child_cnt = node->child_dwrr_cnt + node->max_static_prio + 1;
+	child_idx_bmap = kcalloc(BITS_TO_LONGS(child_cnt), sizeof(unsigned long),
+				 GFP_KERNEL);
+	if (!child_idx_bmap)
+		return -ENOMEM;
+
+	list_for_each_entry(tmp, &node->child_list, list)
+		otx2_qos_assign_base_idx_tl(pfvf, tmp);
+
+	/* assign base index of static priority children first */
+	list_for_each_entry(tmp, &node->child_list, list) {
+		if (!tmp->is_static)
+			continue;
+		__otx2_qos_assign_base_idx_tl(pfvf, tmp, child_idx_bmap, child_cnt);
+	}
+
+	/* assign base index of dwrr priority children */
+	list_for_each_entry(tmp, &node->child_list, list)
+		__otx2_qos_assign_base_idx_tl(pfvf, tmp, child_idx_bmap, child_cnt);
+
+	kfree(child_idx_bmap);
+
+	return 0;
+}
+
+static int otx2_qos_assign_base_idx(struct otx2_nic *pfvf,
+				    struct otx2_qos_node *node)
+{
+	int ret = 0;
+
+	mutex_lock(&pfvf->qos.qos_lock);
+	ret = otx2_qos_assign_base_idx_tl(pfvf, node);
+	mutex_unlock(&pfvf->qos.qos_lock);
+
+	return ret;
+}
+
 static int otx2_qos_txschq_push_cfg_schq(struct otx2_nic *pfvf,
 					 struct otx2_qos_node *node,
 					 struct otx2_qos_cfg *cfg)
@@ -761,8 +860,10 @@ static void otx2_qos_free_cfg(struct otx2_nic *pfvf, struct otx2_qos_cfg *cfg)
 
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
 		for (idx = 0; idx < cfg->schq_contig[lvl]; idx++) {
-			schq = cfg->schq_contig_list[lvl][idx];
-			otx2_txschq_free_one(pfvf, lvl, schq);
+			if (cfg->schq_index_used[lvl][idx]) {
+				schq = cfg->schq_contig_list[lvl][idx];
+				otx2_txschq_free_one(pfvf, lvl, schq);
+			}
 		}
 	}
 }
@@ -838,6 +939,10 @@ static int otx2_qos_push_txschq_cfg(struct otx2_nic *pfvf,
 	if (ret)
 		return -ENOSPC;
 
+	ret = otx2_qos_assign_base_idx(pfvf, node);
+	if (ret)
+		return -ENOMEM;
+
 	if (!(pfvf->netdev->flags & IFF_UP)) {
 		otx2_qos_txschq_fill_cfg(pfvf, node, cfg);
 		return 0;
@@ -995,6 +1100,7 @@ static int otx2_qos_leaf_alloc_queue(struct otx2_nic *pfvf, u16 classid,
 	if (ret)
 		goto out;
 
+	parent->child_static_cnt++;
 	set_bit(prio, parent->prio_bmap);
 
 	/* read current txschq configuration */
@@ -1067,6 +1173,7 @@ static int otx2_qos_leaf_alloc_queue(struct otx2_nic *pfvf, u16 classid,
 free_old_cfg:
 	kfree(old_cfg);
 reset_prio:
+	parent->child_static_cnt--;
 	clear_bit(prio, parent->prio_bmap);
 out:
 	return ret;
@@ -1105,6 +1212,7 @@ static int otx2_qos_leaf_to_inner(struct otx2_nic *pfvf, u16 classid,
 		goto out;
 	}
 
+	node->child_static_cnt++;
 	set_bit(prio, node->prio_bmap);
 
 	/* store the qid to assign to leaf node */
@@ -1178,6 +1286,7 @@ static int otx2_qos_leaf_to_inner(struct otx2_nic *pfvf, u16 classid,
 free_old_cfg:
 	kfree(old_cfg);
 reset_prio:
+	node->child_static_cnt--;
 	clear_bit(prio, node->prio_bmap);
 out:
 	return ret;
@@ -1207,6 +1316,10 @@ static int otx2_qos_leaf_del(struct otx2_nic *pfvf, u16 *classid,
 	otx2_qos_destroy_node(pfvf, node);
 	pfvf->qos.qid_to_sqmap[qid] = OTX2_QOS_INVALID_SQ;
 
+	parent->child_static_cnt--;
+	if (!parent->child_static_cnt)
+		parent->max_static_prio = 0;
+
 	clear_bit(prio, parent->prio_bmap);
 
 	return 0;
@@ -1245,6 +1358,10 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
 	otx2_qos_destroy_node(pfvf, node);
 	pfvf->qos.qid_to_sqmap[qid] = OTX2_QOS_INVALID_SQ;
 
+	parent->child_static_cnt--;
+	if (!parent->child_static_cnt)
+		parent->max_static_prio = 0;
+
 	clear_bit(prio, parent->prio_bmap);
 
 	/* create downstream txschq entries to parent */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h b/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
index 19773284be27..faa7c24675d1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
@@ -35,6 +35,7 @@ struct otx2_qos_cfg {
 	int dwrr_node_pos[NIX_TXSCH_LVL_CNT];
 	u16 schq_contig_list[NIX_TXSCH_LVL_CNT][MAX_TXSCHQ_PER_FUNC];
 	u16 schq_list[NIX_TXSCH_LVL_CNT][MAX_TXSCHQ_PER_FUNC];
+	bool schq_index_used[NIX_TXSCH_LVL_CNT][MAX_TXSCHQ_PER_FUNC];
 };
 
 struct otx2_qos {
@@ -62,7 +63,12 @@ struct otx2_qos_node {
 	u16 schq; /* hw txschq */
 	u16 qid;
 	u16 prio_anchor;
+	u16 max_static_prio;
+	u16 child_dwrr_cnt;
+	u16 child_static_cnt;
+	u16 txschq_idx;			/* txschq allocation index */
 	u8 level;
+	bool is_static;
 };
 
 
-- 
2.17.1

