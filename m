Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3355C7494B0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjGFE2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGFE2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:28:02 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6846E1BD0;
        Wed,  5 Jul 2023 21:28:01 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365I3AWP030200;
        Wed, 5 Jul 2023 21:27:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=HP4LiQ6LuTG/JSI25L4E4+XjHbPHi/cDQHv1hFi3YAU=;
 b=WSBOo5hmIc6GgoSEodAS8UxtiSpWOb6+wEHCPs0eF1/myhBrdHWPnWIEAMAb8ALXWlcK
 Rw+nRIBrj7IWNQSS6ocPfDoeajN7nUshUBAzPJERPKsW18SzAuOpJiYgd9wRfzoknZX5
 tJUHC/5xghGx2oUQEtIbdsqhXQQcU96OUpa93HPCp384Y6/i8nT/YoNXLWT0vkfQeiT+
 hCTHVw5UKqftLeWA2JSKYpzH8gqJnJspC9SSlE+4kuM0KOKPjECd1iHfTNircmu/qwTn
 oLgIyiszzyMBSRVmSwpg5TFnjSFZ8L0k0fI7tqS1QCpnu1IzkSUms3T39wD/MZCzeaBX kg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rn3v93w7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 21:27:53 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 5 Jul
 2023 21:27:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 5 Jul 2023 21:27:51 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id D02B83F7066;
        Wed,  5 Jul 2023 21:27:47 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <michal.kubiak@intel.com>, <sgoutham@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sbhatta@marvell.com>, <gakula@marvell.com>,
        <schalla@marvell.com>, <hkelam@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net v1] octeontx2-af: Promisc enable/disable through mbox
Date:   Thu, 6 Jul 2023 09:57:05 +0530
Message-ID: <20230706042705.3235990-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wGFvuWNvoBlT3iqbu_ehh_3DD9p9PiNw
X-Proofpoint-ORIG-GUID: wGFvuWNvoBlT3iqbu_ehh_3DD9p9PiNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_02,2023-07-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In legacy silicon, promiscuous mode is only modified
through CGX mbox messages. In CN10KB silicon, it is modified
from CGX mbox and NIX. This breaks legacy application
behaviour. Fix this by removing call from NIX.

Fixes: d6c9784baf59 ("octeontx2-af: Invoke exact match functions if supported")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
ChangeLog

v0 -> v1: Fix 80 lines checkpatch warnings
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 11 ++-------
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 23 +++++++++++++++++--
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 0d745ae1cc9a..04b0e885f9d2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4069,21 +4069,14 @@ int rvu_mbox_handler_nix_set_rx_mode(struct rvu *rvu, struct nix_rx_mode *req,
 	}
 
 	/* install/uninstall promisc entry */
-	if (promisc) {
+	if (promisc)
 		rvu_npc_install_promisc_entry(rvu, pcifunc, nixlf,
 					      pfvf->rx_chan_base,
 					      pfvf->rx_chan_cnt);
-
-		if (rvu_npc_exact_has_match_table(rvu))
-			rvu_npc_exact_promisc_enable(rvu, pcifunc);
-	} else {
+	else
 		if (!nix_rx_multicast)
 			rvu_npc_enable_promisc_entry(rvu, pcifunc, nixlf, false);
 
-		if (rvu_npc_exact_has_match_table(rvu))
-			rvu_npc_exact_promisc_disable(rvu, pcifunc);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 9f11c1e40737..6fe67f3a7f6f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -1164,8 +1164,10 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 {
 	struct npc_exact_table *table;
 	u16 *cnt, old_cnt;
+	bool promisc;
 
 	table = rvu->hw->table;
+	promisc = table->promisc_mode[drop_mcam_idx];
 
 	cnt = &table->cnt_cmd_rules[drop_mcam_idx];
 	old_cnt = *cnt;
@@ -1177,13 +1179,18 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 
 	*enable_or_disable_cam = false;
 
-	/* If all rules are deleted, disable cam */
+	if (promisc)
+		goto done;
+
+	/* If all rules are deleted and not already in promisc mode;
+	 * disable cam
+	 */
 	if (!*cnt && val < 0) {
 		*enable_or_disable_cam = true;
 		goto done;
 	}
 
-	/* If rule got added, enable cam */
+	/* If rule got added and not already in promisc mode; enable cam */
 	if (!old_cnt && val > 0) {
 		*enable_or_disable_cam = true;
 		goto done;
@@ -1462,6 +1469,12 @@ int rvu_npc_exact_promisc_disable(struct rvu *rvu, u16 pcifunc)
 	*promisc = false;
 	mutex_unlock(&table->lock);
 
+	/* Enable drop rule */
+	rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX,
+					   true);
+
+	dev_dbg(rvu->dev, "%s: disabled  promisc mode (cgx=%d lmac=%d)\n",
+		__func__, cgx_id, lmac_id);
 	return 0;
 }
 
@@ -1503,6 +1516,12 @@ int rvu_npc_exact_promisc_enable(struct rvu *rvu, u16 pcifunc)
 	*promisc = true;
 	mutex_unlock(&table->lock);
 
+	/*  disable drop rule */
+	rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX,
+					   false);
+
+	dev_dbg(rvu->dev, "%s: Enabled promisc mode (cgx=%d lmac=%d)\n",
+		__func__, cgx_id, lmac_id);
 	return 0;
 }
 
-- 
2.25.1

