Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A473E3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjFZPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjFZPoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:44:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BA8125;
        Mon, 26 Jun 2023 08:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu3Nfdh0hRqu0pEIN4iiet7f0dRXCpLEhxy/ul9zPKXOnNI8C6pMXZ2njXHE88mXz/kMAwhZU4p/3XlPYpQx+vFO/KnT59Dr0Y3GPETyLUUa6GCY3mzAqW5I4Ln93cE/mxb4noQFT0K8oiedAE67Ig52DtwiaSJlhb5DMv746IDhPphMGzW1LKHdZM5h9KVuAcyxtIGjCtJczk7G2nzjVz5xDQMBwalotOc9ZJoOzfmTXGXFVuQnb4RwpTpoQwyB1c0BYMXwuTWYokhneAGp06146NU1FY1TZwT//CLX31+N0eQGeNqfs5Gl3OxpIC06iBTk+rLSOnh1gz5trxPwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwG7SSGnSxDC28lBFIVrPrhHrcY5mAeIaBsyq7nmcRY=;
 b=X11kL3/t3pTOUsOjrKnkqTun+44loAOPB/SYoY62oVoynkd+lhpqoYL1IBgZYntRmYTqENpXPjezniDrcBNdAkGN3oP8owAycZvT0Uwu9G8VOG8nNEAIZRYpYs22D7VZ8SQOO2s9oTLZELWPgFavOkZGfC0EBWsOTbeUDGZIqG2jtosTwC75Hempje+j1qJHKRsnQ+kHa5fxbQkb+dSFpnQbxMxG+/zou7D03S3qbFDvNwtA444Yf/k/VGif6HT4Yk5YfPicUabne2kO/9NmUMsEVw8cAuVeOr1HK2ObcJzqHaET0/g2TK/yRE1W/yCUuzhby1BtWbFWzGCIiBvcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwG7SSGnSxDC28lBFIVrPrhHrcY5mAeIaBsyq7nmcRY=;
 b=ltXyqZKTDJNadswwjnyrORNAlZuzExdeUnUq7mx5Irh4JBJ4ZSTwgPg5vO56NyHUUctD0hIEuTgaVAUJ8WPASRWRVmCvrR6EdWxsM0oWxumJ1CMRZwTINuOfwBegztQSxuAqbNBYeYcdV8hXPcECdD7mvaFJedIvMKqH9RNAowQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 15:44:17 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 15:44:17 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: avoid suspicious RCU usage for synced VLAN-aware MAC addresses
Date:   Mon, 26 Jun 2023 18:44:02 +0300
Message-Id: <20230626154402.3154454-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: 915ff03b-1366-47a6-d686-08db765c3300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQK1CD5xju+6eL9qmd0uNggRbqXsqNaCTJgjhrwY2MF8ftXiObMTEHyerCNjkrsHMcDGn/KsIIspEdxtsEggV2Prm9Et9Y2CbxKvqLLtQjbQqphPQyI+0Dr/w2Cv6j+iFpn6Y4Xo/PCVhnI0ad+qbJO/vPRCJCWpNdHYzYgPk8onnF0UaZJaWKRFt2/UvWpAH6rQLvE00CYNOAdxYTETdo7p6i8zWuxGweJ1Jy39GaTPJaxUEyGQhOxbzPqRgyOslSaz6V8VZ7SnmS+U39x5pVDM6EDaS5VHdVse+7RxLik2aIiQ8E3COCwg86ojCqwdGQDW32WXHmNq4aqgXMF3/oKcGplL469GshOUS7bnD5AyGcrNSndfJFj8qAO2j7TzCI/R++oM7hjN4w3klYi/ZroJOX6VDf0H2L+cKNelnuBq9vTp4exPoRNzixTUV4bCe152gXzKvc+vhHoey6abgywHx54B4qFqMwuY54N2MRNRzEJLwruOXsCuUhYz4UdWIknp5rdcSEyf4EJPegGLLNPEKmatvesEUD763JJo8rOGlFsHWpwODdia7sDKuqoODOQtOPq+7zk1mfA/J2NkoePz4IAIKNR6kbeDPcgUHXQu4y70uiPy/O4Ecs2jxJU0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(38350700002)(38100700002)(83380400001)(36756003)(86362001)(478600001)(2616005)(54906003)(6486002)(52116002)(6666004)(41300700001)(66476007)(66946007)(8936002)(316002)(66556008)(8676002)(4326008)(6916009)(1076003)(6506007)(6512007)(26005)(186003)(2906002)(44832011)(5660300002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MCsy8K2UfJ1gtvb90yapv22gNIXeqT/Fx/uFyWbrcgDbhK3FaDziTQbqQmfX?=
 =?us-ascii?Q?maZ/jvEhtQW8bombNEk9GCiaP4a7fYxbn9fhtSVKXQzvrSrP6hi6zBSf6dRJ?=
 =?us-ascii?Q?cR7yExmzP7IvJzDh8aOlkpAl02aqrKNM1X4JxYDA7WTqDeZ3cQyPUc+7prm5?=
 =?us-ascii?Q?T6lfqzVWfdgwobqaCEBf9wfAHGxTPc/1fEjoJw2oUaZBRsyKU0aU00rMIndP?=
 =?us-ascii?Q?5T8uT3Xu6FeL1f533IV+EbCLHS2XYPgWqJygbzrmEq4BwbFOHIDSFL/3C4G2?=
 =?us-ascii?Q?HRI3wsCNsZAF+7dr39a+vUtl9n34ZqTbqqwNxaQmxpbErbxQFt90aK4CAch9?=
 =?us-ascii?Q?z08zp1GYyQ0oCatvHeSUwkMXiKgK9Gq3KPv+AMX6xVdbN2fT6OovJ459QuSW?=
 =?us-ascii?Q?sooVDZUyDIJbddC1rnDAGX/ouellxVcz6noTugUX/QbdURCvoV78eUP0n9lf?=
 =?us-ascii?Q?TnfqYkPhgKos0spBQxC1zXpzERebkl+bYgBHvo4OFbxak24ik2hSgoKwddVH?=
 =?us-ascii?Q?YMPE7dCm9GnaI536ee7rVzFG1J+MurThrf2XZuRPz9dVgVD4udIBTAXJ2PiJ?=
 =?us-ascii?Q?g4KQum2lfJDHNrIv4pdrpJoO/Ln14PXifI6QOT2FC0lwTgNPgwP6n1oYL0Nr?=
 =?us-ascii?Q?IFhCqKozupbM/gd6leNcgrr99GXrcUYbSok+o0F2eWTWPko94WOu0t/qA7K/?=
 =?us-ascii?Q?lcZZQapxdXRBw2sw4sVNCx3+bgBnlzeVygw8jiHhSiNCQOJuhDUqhGTfPVW6?=
 =?us-ascii?Q?bZDZ0imLS8Xv5Yf/4W3ozUD/A7UcyRoFl90UwtjSWZ8mUJm157acLBPmz0NM?=
 =?us-ascii?Q?5o+VWHUQomuYXalnAztXY3490YjiLtWb3srgsdHNP70QN0MQUz5tZ9TCcwKA?=
 =?us-ascii?Q?GRxx+T+GX9ghFUX2iQ+iGrTx5ZkJexRqSbVk/Px7gFhETBpnr3ZOz+uAbOjs?=
 =?us-ascii?Q?9OfNO5R0WDcPRM3KZvxdDtyelztF/J7j0HROqMzWNy6BLZa7cSvRe1gmGKgi?=
 =?us-ascii?Q?BI/FXHx+UZGhETyunH9jNdL0BtpoR4QUomH9AB7SwbTLbl9sKDacBDxXPttS?=
 =?us-ascii?Q?Bxjz3CBMepxQ7lX7NIWv4QDXgPAqj4tqkx64N1auDCz1RwBZtTXc8SHoGJ7n?=
 =?us-ascii?Q?ZtmEiDFfaAA64DOfQZT0Qz5+hs2KsagJqhT/pZ15QOFUypjV14U59e7wrme2?=
 =?us-ascii?Q?eBtkB2gP5i5fey7RHQ2qBm8nZeZSD1+xDOAErAbJtabB97agZzMiE16z7hYQ?=
 =?us-ascii?Q?RzSDOIWzq5r3bZom64K76x4TwILT2Ciw+Dj5FYJp54BkL5FibtS6ROR0tXUz?=
 =?us-ascii?Q?SCLH1gbsyWYPrsP9dsQA4vG9O//IvK+WGeWaPEjAGEar+LrYLxFyr1lMNq47?=
 =?us-ascii?Q?3zSR/0u22PivrWH0oQ2F+XhF8hF1nUHr55CRWPqiQuxytrBDA8fPviEkgcBv?=
 =?us-ascii?Q?fCmBP/WBEehGP4Io5DV2/fdmiXGXtOjQpS2rVuL0v25a40NzPbaxQ1flLT4Y?=
 =?us-ascii?Q?eOKRvfOGvvdiDI/xI6cQ28RuQjEsakWvdguxYwRHw+r8Nq9e48w93e8062iP?=
 =?us-ascii?Q?zL8Igur5sJPMco23uIh+ZmPZZ8shDRmFE1y+UcpZP1OROacghI0qJl3fqvKO?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915ff03b-1366-47a6-d686-08db765c3300
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:44:16.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbGcusM0h5QVjDG1aTDGYvJXRnCxKwvzaaVLjIeWDg5KLOe3uBtoYoNBgrEV3ci5EW7KMYFg61FM0jBknwePzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the felix driver (the only one which supports UC filtering
and MC filtering) as a DSA master for a random other DSA switch, one can
see the following stack trace when the downstream switch ports join a
VLAN-aware bridge:

=============================
WARNING: suspicious RCU usage
-----------------------------
net/8021q/vlan_core.c:238 suspicious rcu_dereference_protected() usage!

stack backtrace:
Workqueue: dsa_ordered dsa_slave_switchdev_event_work
Call trace:
 lockdep_rcu_suspicious+0x170/0x210
 vlan_for_each+0x8c/0x188
 dsa_slave_sync_uc+0x128/0x178
 __hw_addr_sync_dev+0x138/0x158
 dsa_slave_set_rx_mode+0x58/0x70
 __dev_set_rx_mode+0x88/0xa8
 dev_uc_add+0x74/0xa0
 dsa_port_bridge_host_fdb_add+0xec/0x180
 dsa_slave_switchdev_event_work+0x7c/0x1c8
 process_one_work+0x290/0x568

What it's saying is that vlan_for_each() expects rtnl_lock() context and
it's not getting it, when it's called from the DSA master's ndo_set_rx_mode().

The caller of that - dsa_slave_set_rx_mode() - is the slave DSA
interface's dsa_port_bridge_host_fdb_add() which comes from the deferred
dsa_slave_switchdev_event_work().

We went to great lengths to avoid the rtnl_lock() context in that call
path in commit 0faf890fc519 ("net: dsa: drop rtnl_lock from
dsa_slave_switchdev_event_work"), and calling rtnl_lock() is simply not
an option due to the possibility of deadlocking when calling
dsa_flush_workqueue() from the call paths that do hold rtnl_lock() -
basically all of them.

So, when the DSA master calls vlan_for_each() from its ndo_set_rx_mode(),
the state of the 8021q driver on this device is really not protected
from concurrent access by anything.

Looking at net/8021q/, I don't think that vlan_info->vid_list was
particularly designed with RCU traversal in mind, so introducing an RCU
read-side form of vlan_for_each() - vlan_for_each_rcu() - won't be so
easy, and it also wouldn't be exactly what we need anyway.

In general I believe that the solution isn't in net/8021q/ anyway;
vlan_for_each() is not cut out for this task. DSA doesn't need rtnl_lock()
to be held per se - since it's not a netdev state change that we're
blocking, but rather, just concurrent additions/removals to a VLAN list.
We don't even need sleepable context - the callback of vlan_for_each()
just schedules deferred work.

The proposed escape is to remove the dependency on vlan_for_each() and
to open-code a non-sleepable, rtnl-free alternative to that, based on
copies of the VLAN list modified from .ndo_vlan_rx_add_vid() and
.ndo_vlan_rx_kill_vid().

Fixes: 64fdc5f341db ("net: dsa: sync unicast and multicast addresses for VLAN filters too")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/dsa.h | 12 +++++--
 net/dsa/dsa.c     |  2 +-
 net/dsa/slave.c   | 84 ++++++++++++++++++++++++++++++++---------------
 net/dsa/switch.c  |  4 +--
 net/dsa/switch.h  |  3 ++
 5 files changed, 74 insertions(+), 31 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 90bba1ce5899..d309ee7ed04b 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -314,9 +314,17 @@ struct dsa_port {
 	struct list_head	fdbs;
 	struct list_head	mdbs;
 
-	/* List of VLANs that CPU and DSA ports are members of. */
 	struct mutex		vlans_lock;
-	struct list_head	vlans;
+	union {
+		/* List of VLANs that CPU and DSA ports are members of.
+		 * Access to this is serialized by the sleepable @vlans_lock.
+		 */
+		struct list_head	vlans;
+		/* List of VLANs that user ports are members of.
+		 * Access to this is serialized by netif_addr_lock_bh().
+		 */
+		struct list_head	user_vlans;
+	};
 };
 
 /* TODO: ideally DSA ports would have a single dp->link_dp member,
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 1afed89e03c0..ccbdb98109f8 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1106,7 +1106,7 @@ static struct dsa_port *dsa_port_touch(struct dsa_switch *ds, int index)
 	mutex_init(&dp->vlans_lock);
 	INIT_LIST_HEAD(&dp->fdbs);
 	INIT_LIST_HEAD(&dp->mdbs);
-	INIT_LIST_HEAD(&dp->vlans);
+	INIT_LIST_HEAD(&dp->vlans); /* also initializes &dp->user_vlans */
 	INIT_LIST_HEAD(&dp->list);
 	list_add_tail(&dp->list, &dst->ports);
 
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 165bb2cb8431..527b1d576460 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -27,6 +27,7 @@
 #include "master.h"
 #include "netlink.h"
 #include "slave.h"
+#include "switch.h"
 #include "tag.h"
 
 struct dsa_switchdev_event_work {
@@ -161,8 +162,7 @@ static int dsa_slave_schedule_standalone_work(struct net_device *dev,
 	return 0;
 }
 
-static int dsa_slave_host_vlan_rx_filtering(struct net_device *vdev, int vid,
-					    void *arg)
+static int dsa_slave_host_vlan_rx_filtering(void *arg, int vid)
 {
 	struct dsa_host_vlan_rx_filtering_ctx *ctx = arg;
 
@@ -170,6 +170,28 @@ static int dsa_slave_host_vlan_rx_filtering(struct net_device *vdev, int vid,
 						  ctx->addr, vid);
 }
 
+static int dsa_slave_vlan_for_each(struct net_device *dev,
+				   int (*cb)(void *arg, int vid), void *arg)
+{
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_vlan *v;
+	int err;
+
+	lockdep_assert_held(&dev->addr_list_lock);
+
+	err = cb(arg, 0);
+	if (err)
+		return err;
+
+	list_for_each_entry(v, &dp->user_vlans, list) {
+		err = cb(arg, v->vid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int dsa_slave_sync_uc(struct net_device *dev,
 			     const unsigned char *addr)
 {
@@ -180,18 +202,14 @@ static int dsa_slave_sync_uc(struct net_device *dev,
 		.addr = addr,
 		.event = DSA_UC_ADD,
 	};
-	int err;
 
 	dev_uc_add(master, addr);
 
 	if (!dsa_switch_supports_uc_filtering(dp->ds))
 		return 0;
 
-	err = dsa_slave_schedule_standalone_work(dev, DSA_UC_ADD, addr, 0);
-	if (err)
-		return err;
-
-	return vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering, &ctx);
+	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+				       &ctx);
 }
 
 static int dsa_slave_unsync_uc(struct net_device *dev,
@@ -204,18 +222,14 @@ static int dsa_slave_unsync_uc(struct net_device *dev,
 		.addr = addr,
 		.event = DSA_UC_DEL,
 	};
-	int err;
 
 	dev_uc_del(master, addr);
 
 	if (!dsa_switch_supports_uc_filtering(dp->ds))
 		return 0;
 
-	err = dsa_slave_schedule_standalone_work(dev, DSA_UC_DEL, addr, 0);
-	if (err)
-		return err;
-
-	return vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering, &ctx);
+	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+				       &ctx);
 }
 
 static int dsa_slave_sync_mc(struct net_device *dev,
@@ -228,18 +242,14 @@ static int dsa_slave_sync_mc(struct net_device *dev,
 		.addr = addr,
 		.event = DSA_MC_ADD,
 	};
-	int err;
 
 	dev_mc_add(master, addr);
 
 	if (!dsa_switch_supports_mc_filtering(dp->ds))
 		return 0;
 
-	err = dsa_slave_schedule_standalone_work(dev, DSA_MC_ADD, addr, 0);
-	if (err)
-		return err;
-
-	return vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering, &ctx);
+	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+				       &ctx);
 }
 
 static int dsa_slave_unsync_mc(struct net_device *dev,
@@ -252,18 +262,14 @@ static int dsa_slave_unsync_mc(struct net_device *dev,
 		.addr = addr,
 		.event = DSA_MC_DEL,
 	};
-	int err;
 
 	dev_mc_del(master, addr);
 
 	if (!dsa_switch_supports_mc_filtering(dp->ds))
 		return 0;
 
-	err = dsa_slave_schedule_standalone_work(dev, DSA_MC_DEL, addr, 0);
-	if (err)
-		return err;
-
-	return vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering, &ctx);
+	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+				       &ctx);
 }
 
 void dsa_slave_sync_ha(struct net_device *dev)
@@ -1759,6 +1765,7 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 	struct netlink_ext_ack extack = {0};
 	struct dsa_switch *ds = dp->ds;
 	struct netdev_hw_addr *ha;
+	struct dsa_vlan *v;
 	int ret;
 
 	/* User port... */
@@ -1782,8 +1789,17 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 	    !dsa_switch_supports_mc_filtering(ds))
 		return 0;
 
+	v = kzalloc(sizeof(*v), GFP_KERNEL);
+	if (!v) {
+		ret = -ENOMEM;
+		goto rollback;
+	}
+
 	netif_addr_lock_bh(dev);
 
+	v->vid = vid;
+	list_add_tail(&v->list, &dp->user_vlans);
+
 	if (dsa_switch_supports_mc_filtering(ds)) {
 		netdev_for_each_synced_mc_addr(ha, dev) {
 			dsa_slave_schedule_standalone_work(dev, DSA_MC_ADD,
@@ -1803,6 +1819,12 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 	dsa_flush_workqueue();
 
 	return 0;
+
+rollback:
+	dsa_port_host_vlan_del(dp, &vlan);
+	dsa_port_vlan_del(dp, &vlan);
+
+	return ret;
 }
 
 static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
@@ -1816,6 +1838,7 @@ static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 	};
 	struct dsa_switch *ds = dp->ds;
 	struct netdev_hw_addr *ha;
+	struct dsa_vlan *v;
 	int err;
 
 	err = dsa_port_vlan_del(dp, &vlan);
@@ -1832,6 +1855,15 @@ static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 
 	netif_addr_lock_bh(dev);
 
+	v = dsa_vlan_find(&dp->user_vlans, &vlan);
+	if (!v) {
+		netif_addr_unlock_bh(dev);
+		return -ENOENT;
+	}
+
+	list_del(&v->list);
+	kfree(v);
+
 	if (dsa_switch_supports_mc_filtering(ds)) {
 		netdev_for_each_synced_mc_addr(ha, dev) {
 			dsa_slave_schedule_standalone_work(dev, DSA_MC_DEL,
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 8c9a9f94b756..1a42f9317334 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -673,8 +673,8 @@ static bool dsa_port_host_vlan_match(struct dsa_port *dp,
 	return false;
 }
 
-static struct dsa_vlan *dsa_vlan_find(struct list_head *vlan_list,
-				      const struct switchdev_obj_port_vlan *vlan)
+struct dsa_vlan *dsa_vlan_find(struct list_head *vlan_list,
+			       const struct switchdev_obj_port_vlan *vlan)
 {
 	struct dsa_vlan *v;
 
diff --git a/net/dsa/switch.h b/net/dsa/switch.h
index 15e67b95eb6e..ea034677da15 100644
--- a/net/dsa/switch.h
+++ b/net/dsa/switch.h
@@ -111,6 +111,9 @@ struct dsa_notifier_master_state_info {
 	bool operational;
 };
 
+struct dsa_vlan *dsa_vlan_find(struct list_head *vlan_list,
+			       const struct switchdev_obj_port_vlan *vlan);
+
 int dsa_tree_notify(struct dsa_switch_tree *dst, unsigned long e, void *v);
 int dsa_broadcast(unsigned long e, void *v);
 
-- 
2.34.1

