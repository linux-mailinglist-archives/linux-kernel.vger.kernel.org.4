Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE674A97F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 05:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjGGDxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 23:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGGDxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 23:53:42 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BA11FC9;
        Thu,  6 Jul 2023 20:53:41 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366GpMW8030462;
        Thu, 6 Jul 2023 20:53:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=IPtGxkbPmFGDLM3aZoleuH6KTP7fOT7Q4al0VCaPr1Y=;
 b=j0V0pNHURZavUJzej5Ty4OHZUmqdTbAMUBxEftSyP6WoOJ8UIpSTnMzr7pDGlWatMEzW
 ZsXxKKos7lxJMZ/WW8/0RkIve4zhAPMUmYVTL5Oxw+bmDL9nkN3cIyBHyRE0f4Fnns4o
 BCUpuLNFnnyaclJ2nMAnuDodwH3hzzfPIVjmPowjPGU6Pl0/r03/19BLX3FXhfBaX3iv
 CuFcpthw1kqS3yKNeZtpWPA4AMRUkMXbm2IMvKm1VEVg0cjnQpcRRaa8vipidpLfTYIx
 QfsOR8dNxXnFCb/v4XzZCL8AIopv18xN+of3/jPoycsSikgQf6zbuR0I3tsqdEXXXJIo Gg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rn3v98cyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 20:53:29 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 6 Jul
 2023 20:53:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 6 Jul 2023 20:53:27 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 406193F7075;
        Thu,  6 Jul 2023 20:53:24 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V4] octeontx2-pf: Add additional check for MCAM rules
Date:   Fri, 7 Jul 2023 09:23:21 +0530
Message-ID: <20230707035321.2227742-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: myUSop_FmLnLVxA8c_tsIDxrzwAaKoh4
X-Proofpoint-ORIG-GUID: myUSop_FmLnLVxA8c_tsIDxrzwAaKoh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_01,2023-07-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to hardware limitation, MCAM drop rule with
ether_type == 802.1Q and vlan_id == 0 is not supported. Hence rejecting
such rules.

Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
Changes since v3:
- moved assignment of vlan_etype before the if check
  
 .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c |  8 ++++++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c    | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 10e11262d48a..2d7713a1a153 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -872,6 +872,14 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
 				return -EINVAL;
 
 			vlan_etype = be16_to_cpu(fsp->h_ext.vlan_etype);
+
+			/* Drop rule with vlan_etype == 802.1Q
+			 * and vlan_id == 0 is not supported
+			 */
+			if (vlan_etype == ETH_P_8021Q && !fsp->m_ext.vlan_tci &&
+			    fsp->ring_cookie == RX_CLS_FLOW_DISC)
+				return -EINVAL;
+
 			/* Only ETH_P_8021Q and ETH_P_802AD types supported */
 			if (vlan_etype != ETH_P_8021Q &&
 			    vlan_etype != ETH_P_8021AD)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 044cc211424e..6c0fdc2bad73 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -604,6 +604,19 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 			return -EOPNOTSUPP;
 		}
 
+		if (!match.mask->vlan_id) {
+			struct flow_action_entry *act;
+			int i;
+
+			flow_action_for_each(i, act, &rule->action) {
+				if (act->id == FLOW_ACTION_DROP) {
+					netdev_err(nic->netdev, "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
+						   ntohs(match.key->vlan_tpid), match.key->vlan_id);
+					return -EOPNOTSUPP;
+				}
+			}
+		}
+
 		if (match.mask->vlan_id ||
 		    match.mask->vlan_dei ||
 		    match.mask->vlan_priority) {
-- 
2.25.1

