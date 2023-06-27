Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD273F8E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjF0Jmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjF0Jm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:42:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801B3E54;
        Tue, 27 Jun 2023 02:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqKVtGnuyg/2fgvViUiTCW9JS2HjrCzHIVdyYfC8ORAHPSbF4fDAsPZgREEsl7JpHAPnEsQz1AWs5OUVyUDyYhFu3yfdFGL+JckKVOJDfAEW8G/hcuEdXorZtSEzXR0aHEBye0b0I5YMsEORvzLPANmU3rVRFJW7AN/gbDASfMt06hXHD7PZfMB6AKcr2nRbXe7nR/mQlH+TJZ5wkh/eeF2kwa5qBc0Z+MxPgXxanA12iM3KKWRWfCB4LhlpbCDX0QOBLboIqK81CIW1tkqBUS8CwOGoPvA0KmJcJPFBOqU0OO2+aVGiCwPM60F+CIUjiNIiFw89ze/r8hSoC1E9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UYcsHQ8GOaQvypkoK7QQ/YEx7HJ50SjmS8VhAeC/Po=;
 b=El3cKjGqHPE9cL24yc28RipCMGcdz9l4emus2yZmmOdvNznGrxKzW5LtTY+VJkxtf0W+KxpCi5TvTqNikCL3A8JFfjtD2wCTji0JIOfZz/+YprxWv+ZLEcTRptrmHNuFZ5awaRby6OFWqYdOqEY2B3UWCb4TbZxWh8kt3SbN+WQ4FVU4ZcfwjKYlQccqTLippQPYQnSwTelNyfvyC33iEIxYNIwHiQr8GEE86RX9Yv24U8XaCZgVUtZmrG/vL4jn6+RunvECTwa1WTr/VU41YSnLQ1iYQ+iKSijzs8EajIGFYqn20++OtMKpkv9P2U8xkX19nz6+nCWMWnpg2Ew6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UYcsHQ8GOaQvypkoK7QQ/YEx7HJ50SjmS8VhAeC/Po=;
 b=X8vic6M5ROg1b72cwaCgqCg+R/r5buWCWr8NU8B+kaMwzZc1ySHPbHSBNh7iPY7IXqpucYbPs8GTEMuRwlidc+rxGRjCW1peUFFHrAmB1FRFZKipOXTCM/PykHgVx1bMeGAhjAHMOuWpTQ2Pg84x2Ndm0Dk0aqptPF7cESlWcdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8649.eurprd04.prod.outlook.com (2603:10a6:20b:43c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:42:20 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:42:20 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 2/2] net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT
Date:   Tue, 27 Jun 2023 12:42:07 +0300
Message-Id: <20230627094207.3385231-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b4557a-9869-4515-2b4b-08db76f2cd53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dLggMjy85oUNTmMe+c2OaqBxH95BMW6JE1kN0JAJhOxJIvWQHAx15sw/TupSaQSwbqN1X4oiVcxxP6iWBH10XbxrDMemvk5p+nfAFzbbU5tAkuKTNjYge3PWN9hlT8NpiyEPgB2PeCxfFChlg7Mr4FjhBLTy+nhhzunWQfoqS2ZSdr51dh06lkuKDKs+oHZLOds88aCXZdSrw5HfSWQXtOfQTlo7IrtGueMANCDA0G7E1Yl5x5FP3FSQPPsythThxQk5q1/atq6bechOaNMljynX9elX2830O9OxCjdj6TzNFjNF0bO84MvqcwEraA/OF1OlVW56SBNUWqK+cGZNDjMXU2/8afbmgIOL8y4ZAvVT8wOC0I+X+OkcXikPJxgm2uqiaQiH9UMeHYcZ7T9WjhlDfYnxU28H8T7pubfQgf0Ae2gKVVouxmlDhAKiA/YrjksYwW+lPwF2W3DclJuQxPop2a+vqtaw9e3zsuiTLsA2WMFt+ps9evgs1n2ghJc4O7zcmsUIBzYtyWkSz/cdTl3UNsAUIAbdN8HWqy8ie2BVsH2glpuJwFs58OreQ6uXUAJKFS2D4nUoAFMbW+Kixg/dr31Et7RKr0bKQ3iQEczuF7ZyG+6Ucl8djaLWn5/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(1076003)(52116002)(6486002)(38100700002)(26005)(83380400001)(2616005)(6666004)(38350700002)(186003)(6506007)(6512007)(41300700001)(2906002)(86362001)(54906003)(478600001)(4326008)(316002)(66946007)(66476007)(6916009)(66556008)(44832011)(8936002)(36756003)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nvejej0crlS4aBgELuGsDZDVFhTn67Qp+YlaZkzzCzvxwjXcqVo5UKEgRfTL?=
 =?us-ascii?Q?Lo8CggboCGLKLtE2vOc0BSGjvWsNT9JstnemcsSy2sj/TBnmyETwRkBaYoRs?=
 =?us-ascii?Q?FxwtmtZlCrcQ4WbPo1xC4rBirvXTERDkzxhN4JeHGRoLyPJaq4wtjjJaQ7QK?=
 =?us-ascii?Q?zgQInowVtAY1/GFju8BeprlImO11yINRyGOpk74YqvSAyVIDCLQPJJrSILKU?=
 =?us-ascii?Q?cmpomkbASIJArKPlPLeiF/OpkTNpX8+jTdTN4IU2wylEe9nT2RMsWKyNINFj?=
 =?us-ascii?Q?A0RHPctTIOhNuWZk86bTEW6ahSTVLmA5tzPy3swE7cz1gX4CG9NUdDowIduy?=
 =?us-ascii?Q?vqfopcuokN2Sbp6B4afFbqvTmhNNoOrUr6W24prJdWX/K9/OlZK1Pr1H/In7?=
 =?us-ascii?Q?qJtp5Ur6ySqL9okkSqz1YBtEK80k/HgEUr2ttdauvA3z8/o58VGetLS94pz8?=
 =?us-ascii?Q?QFPEb0YgCtVQ0FFFQlecpQ5JTdZFnCFMAuKIO5Ht786LePGITKmt6TAMZ201?=
 =?us-ascii?Q?RZ8KXI2xpFpdSkBPdWV/IuiOOMomFkytXHTfRuxVJjTzRfprdGKunJwTpPGY?=
 =?us-ascii?Q?6VBtd8pusMImuvsQERKTsRfRD61oR/Tnc4Cet58ImjAzsY3xq3wxq5llw0dx?=
 =?us-ascii?Q?dYQR2voMXvLbA5nOaeCpgZf+Ode2f14UiaZH6d+nUT3z6z0bXYVkOVhMudUJ?=
 =?us-ascii?Q?5oG0BtgnTIpWq3JvLf2vxAMymVw8ahZR/simU9/FQRowW/4AF6JKrMSXwpZm?=
 =?us-ascii?Q?yuRqYqQhjao+0DpzGgAOlU3/kzoetmRVPXKTZr46v5fQsRkGEBjS4zZSHBxI?=
 =?us-ascii?Q?jDYsjsr5JpuAnEj0MT5kGZsY+4Q6jAVwrAVXa1qSzCGMKp4vC7KoB3psfuot?=
 =?us-ascii?Q?3IsRGmO1+TnVmvHXtGx7DCqMqO2B6iqbQ8fjc9BwBUBo258VIWe3saOKAK4o?=
 =?us-ascii?Q?fhJV6PIkHOLeSu0/TBjr8P5ZPxEOIhFFCeYp4EYXb4LtTx9HjlffDXsD7Zpu?=
 =?us-ascii?Q?wVIlzwalkW5OGtgQyYtnb+P1+yRMROKhaqqw4NPT55h3oU5Yob2tWVdSQr8k?=
 =?us-ascii?Q?n1/QAB3W9Z1VcYhdLToOhvBd9jrC+LvpMPrHI8YQPjKCp4D41h5purxcNn3h?=
 =?us-ascii?Q?bBHx29io3hZUXUZsx5iSA1U7e9iAEZ0QBScB6aWr4HxsgMk3tfMiqBdFIpvt?=
 =?us-ascii?Q?Qt3dSYhzf21YDRDJC9Fk+3gQvqEZOgQtXSPiR6kRXrEk9MB1e2C3yAss1FZl?=
 =?us-ascii?Q?lAwG2ub8xTO0d4IfjE9Be3ih5xv2QtZ6Ext6d/BpxFmaokyZS9OWI+7Nh9sX?=
 =?us-ascii?Q?MzB6J6OGZwHAh4ozg3m6BITo6GVPXgTIj0y04oJa1sA2BjpZjGFdVbVXwkqK?=
 =?us-ascii?Q?ogPXLPUOdvpelTpVGWqNKgVTUyb+8d6PNxf84l0u+VRC+h6hM9S9WW36bLOm?=
 =?us-ascii?Q?XVRjC1bjactrBvMu8oqt0GOmze5b7dspzzASDPu8iQ/VNEmc5hgmE0LWcR7B?=
 =?us-ascii?Q?ym3EgWy6N6Iz1zjno4mHvLYCLJOdYospGPHnd183ZXq3EgPYyHA1asS0MZI9?=
 =?us-ascii?Q?DhNo+NqnTfHJZJEy6dCBEgSHmKEKRun7VDon+X7uIiW6616bvAyyr65u0cU9?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b4557a-9869-4515-2b4b-08db76f2cd53
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:42:20.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHoWbLVUGt0mtowENERgeBmoV8HTUZo53o8PsZDGtp63tQgo+w4W5yDaQ2rTa0QNWlmY12zaon0vMKbi5U4xyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the sja1105 tagging protocol prefers using the source port
information from the VLAN header if that is available, falling back to
the INCL_SRCPT option if it isn't. The VLAN header is available for all
frames except for META frames initiated by the switch (containing RX
timestamps), and thus, the "if (is_link_local)" branch is practically
dead.

The tag_8021q source port identification has become more loose
("imprecise") and will report a plausible rather than exact bridge port,
when under a bridge (be it VLAN-aware or VLAN-unaware). But link-local
traffic always needs to know the precise source port. With incorrect
source port reporting, for example PTP traffic over 2 bridged ports will
all be seen on sockets opened on the first such port, which is incorrect.

Now that the tagging protocol has been changed to make link-local frames
always contain source port information, we can reverse the order of the
checks so that we always give precedence to that information (which is
always precise) in lieu of the tag_8021q VID which is only precise for a
standalone port.

Fixes: d7f9787a763f ("net: dsa: tag_8021q: add support for imprecise RX based on the VBID")
Fixes: 91495f21fcec ("net: dsa: tag_8021q: replace the SVL bridging with VLAN-unaware IVL bridging")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: protect against malformed input packets ("vid" variable may be
uninitialized)

 net/dsa/tag_sja1105.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index a5f3b73da417..92a626a05e82 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -545,10 +545,7 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 	is_link_local = sja1105_is_link_local(skb);
 	is_meta = sja1105_is_meta_frame(skb);
 
-	if (sja1105_skb_has_tag_8021q(skb)) {
-		/* Normal traffic path. */
-		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vbid, &vid);
-	} else if (is_link_local) {
+	if (is_link_local) {
 		/* Management traffic path. Switch embeds the switch ID and
 		 * port ID into bytes of the destination MAC, courtesy of
 		 * the incl_srcpt options.
@@ -562,16 +559,39 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		sja1105_meta_unpack(skb, &meta);
 		source_port = meta.source_port;
 		switch_id = meta.switch_id;
-	} else {
+	}
+
+	/* Normal data plane traffic and link-local frames are tagged with
+	 * a tag_8021q VLAN which we have to strip
+	 */
+	if (sja1105_skb_has_tag_8021q(skb)) {
+		int tmp_source_port = -1, tmp_switch_id = -1;
+
+		sja1105_vlan_rcv(skb, &tmp_source_port, &tmp_switch_id, &vbid,
+				 &vid);
+		/* Preserve the source information from the INCL_SRCPT option,
+		 * if available. This allows us to not overwrite a valid source
+		 * port and switch ID with zeroes when receiving link-local
+		 * frames from a VLAN-unaware bridged port (non-zero vbid) or a
+		 * VLAN-aware bridged port (non-zero vid).
+		 */
+		if (source_port == -1)
+			source_port = tmp_source_port;
+		if (switch_id == -1)
+			switch_id = tmp_switch_id;
+	} else if (source_port == -1 && switch_id == -1) {
+		/* Packets with no source information have no chance of
+		 * getting accepted, drop them straight away.
+		 */
 		return NULL;
 	}
 
-	if (vbid >= 1)
+	if (source_port != -1 && switch_id != -1)
+		skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
+	else if (vbid >= 1)
 		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else if (source_port == -1 || switch_id == -1)
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	else
-		skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.34.1

