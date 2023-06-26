Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7F673E3F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjFZPwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjFZPwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:52:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BFD186;
        Mon, 26 Jun 2023 08:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie8eyV9NNzpxQM0GEibbnzfZI8GwX10vMj8wSyJlDjW6FE89i+1loh6jvmvI3tae2O1fmvmBxugRu3+sGY0DtFf3CjirMuZgqypxhLwwoW8iio5Q8xh4BH8LXCKxr/iTme7nS+4PgMU0oOXdQHZ6Li5ZVi+yh4WijZFieT3KUZ4XDDiA1ejuu3ueejNG3giuN0soo38E65adj24N3+16o37Vda30BD/yiVSlruIFWj6NFW4c4/iSBYIHaaGZ/eNrkfJjlDe0susilOPVeAm6L6Y13M/zAc+LEaUVvfUmGq+I32zchEZgysUoVV0b+O9ip/DHVIpIoy1IWtgNnpfhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0KaiIPfpfV1xAF/VGQzXR9ExTOsU7bKLyM7oUho40w=;
 b=MICj82q/T+oSFfS79eZNdiKbGX3tdqrX2i605WGLUvTYOGH1iALgeKJh9VeNkc2Q+2fGt1W4rY3XArZIAm3QHrRtjtZU8EdhphpucgHaEqGsfF661R5Yrqn0oS4M9gflVK/vco/sl2akEjP3vokqXmYrSxEFYf8tsVmUh3PFjc8fmubFaVAkEAeoBzS90kaxDaO/1+yQC0xXJ1cmbuA4v+51eUCbunPsggq4HCsartn9fmJwD76Zgb2k+RZMRDEwFaSoyFlJGrlziBCYBooOLMFkSgFW5RqgxcD9P1oqA/cPkVAZ/KP2eirZ1nDKh/zz9s9LN9SsRpEUR9fYWS93bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0KaiIPfpfV1xAF/VGQzXR9ExTOsU7bKLyM7oUho40w=;
 b=m/A/lRdluPFvd6Rq4lGg1eeB4yAKMiVUASV0UjGy2Coxoprt2EBmsNayfFcOhChW7HDQBxo7g+fipyeN4Yk+tdVGCgeYBvBn6HSlpEBxT5e5ONC3LpjFZXlu/8Dvc4C0ftqZqzRV15VkAFF8kyiwr/AO2AyPSdvNCK8jJ0qNUCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB9522.eurprd04.prod.outlook.com (2603:10a6:10:2f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 15:52:19 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 15:52:19 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT
Date:   Mon, 26 Jun 2023 18:51:12 +0300
Message-Id: <20230626155112.3155993-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626155112.3155993-1-vladimir.oltean@nxp.com>
References: <20230626155112.3155993-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0003.eurprd03.prod.outlook.com
 (2603:10a6:205:2::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f56860-cb38-4738-9d8c-08db765d5254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHiHw/ppspfsGmcqma9iCwgGyxhu1o4T5tHCzoy9CyHJqwWnx1yAsM2vrTG7Uot5PjVrs7zfbh0kF5TiongWPYhCvv/3+gHHPvFEGtoD+itFvYzfwEOEsgNH3RVAoh8BW48K27wwWCer9VZTmj3SIVgfYbUk5snX1/PR9nzq9q/8xra4APbLW2gpmjxkNz+WYjT4IdVXb4EO2WN5tP4OMrQ8UhCbewF2wjHPcboqIzCAKSsDr/0pna0R8juR2TEAMToQcaFhQtnwilftQ1LVi7mMgnJI//K4xVcK6sZHrS4pPe7d/BdWmkCoQjqlaYQA4hyk62++ZWRf/sWpXECoV39UdfHE4Wo4uSEg3K4MEl73MMfQ6Tu4++0Ul/nmcYc16Z+C2UX094KmDecO7UoUxuZmsPWWaDAIp9l9LTm+SD1a3Mk1BlWWY7t4vGCoLWOEH0fkEu5VWM0cn6xUUC8o/ZdXedYRFYInVzoUnFZrPFad/Xt5mE+ardg76PPu9CcK1IHfSPJhPZDycaV8BctGCas2+WA3eLXA33Ls9ZnQLn+IZUXGmQ8sRjUH0Ng/KP01C8NSKBG74mBVbmHdXUJF8lnLH/HAQvZ3+7VA2zlspNlZvuTDaG86ehSgMifTcgaV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(6512007)(1076003)(44832011)(66556008)(6916009)(66946007)(66476007)(4326008)(316002)(478600001)(8936002)(36756003)(8676002)(5660300002)(2906002)(86362001)(54906003)(41300700001)(6486002)(52116002)(6666004)(186003)(6506007)(26005)(38350700002)(38100700002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?saSwCaqu6a2bGZJcCdItKJAlR4i8FZoh45JWY11LMykZZ1tGJNUvq8t1Jw3x?=
 =?us-ascii?Q?Z4kt+HN20wnDKhe6G9cxzigvjMb6L7enubBsyBaWmK46XX2z29p80bakStOg?=
 =?us-ascii?Q?Ahzt3isyRdorh7uVVzze2p7ndO5scaAmBASAVAGZfoNNbgL0SHA0qmJ0Br1r?=
 =?us-ascii?Q?sT10zJ2zviugsb1HAurom94MlfgLoYdGEa6WPCSbXk5GKBIKmF1/oCRUa6yB?=
 =?us-ascii?Q?9o3DAStC3FLM0tYZq8jiwMW44KGCwPAhuG/1GAJxD9l9cyNKg7STBQkxQ0Io?=
 =?us-ascii?Q?JwEH63taRd9YyyDVIuiQ1Ku3Nas42v8zWJQekDpNG5haDyWC4aV0oARm3+CX?=
 =?us-ascii?Q?Qa2YTauAl3v61Y8IVKopgq8pxaYf+zpVBxIMJapbsfpfaa0rSYhUAklPieLH?=
 =?us-ascii?Q?0sahPqTJWDsI8DLPePQt40rlruMX3dE0tDQafp93RbWkzcf+VTyrLvtI0J2X?=
 =?us-ascii?Q?NML4B4q+tNon7RjGcFHOZpQJt67zK4Q/wKW+4NiQf50dFvSaoVYKE8SNbfAx?=
 =?us-ascii?Q?T01v6xKFnGAsbKBZNAEIrfFnlTMLNoaJH5AznlDzpVu+4LkPnT7dQaPClMEz?=
 =?us-ascii?Q?l8uFPPCLrCcJ/w4yTzAemuSEwrDRcRtL+SM9zxYzvBqbTWcsOuhHE6N25X20?=
 =?us-ascii?Q?fCWA526+6fRybeiG+dRIXFzFfAQWhUsz57L7MG7LRrCLNOD1yXLGYXf4DjsQ?=
 =?us-ascii?Q?aZXfygIcURopsggJmSvuGxIEc+i9ixVHprQ6rvqroeYI/WXlMKYIfc/83FKY?=
 =?us-ascii?Q?LACCkVff4CAYJmRoii0PDmhdlWqqd9yNsX31RUgWoNkBwBBMPm79+K1pEpd0?=
 =?us-ascii?Q?gKNDZ1yrmOqEZGe9iwI9XR0ttpa1qQjW5i4Hwteak8X6tW707oVd9Da6k7Z+?=
 =?us-ascii?Q?5+Keld1DIMtJ6bZcPH9edgQDDzUxN1hnhNmXLmBZOoY/QY9FDub1MerBZEiG?=
 =?us-ascii?Q?ir/9yTpbfb4qg12NGAFZXyIGpncVa5FkRrNmMlNT0D0wuCaijxKPa29XyRD4?=
 =?us-ascii?Q?brMFVRBlp0I4mnrFevpju3lDlYEUx3b2WBLOe/aKQii/O2hRmOHE5l0K8CMj?=
 =?us-ascii?Q?yDE4wSZNnBSl4ZGpB/edogTpYO7g2fOms6LVRA0gBfq43a5jQOxfXMXauWB7?=
 =?us-ascii?Q?M925/+xIJBtzxrNmr8hf7UvZXpCVuUBQ81vQWp75TrzPwsHsAzKqoJnJhhen?=
 =?us-ascii?Q?eLzl1zxPWa0W2aX1k4IPDF8IItStPSXu8nHxj2aHCs+f4gb5Hhn5UNuSKhG4?=
 =?us-ascii?Q?r4wd68HdwmwOd0k/oHXOUrPzBAQHhi5oWPPBLod5UZ+oZ1JebJNo3CExh+Cz?=
 =?us-ascii?Q?bIPMs4Yc6ZUQhdNkym43lfEVrtYvUESYLDthKBi2BvbMlAbl8SRuiy56lgtM?=
 =?us-ascii?Q?BIGJbKNFvgqxifnPgqfHnK2A+A+2zfQoAu1waKiqxa5hDMDRCqIg/hJ6wpvu?=
 =?us-ascii?Q?3O1gY6/xxb42QCeO7UwAh9eozcmmkA+CftVCuba7PHuim6rNLqQq+gWm3V12?=
 =?us-ascii?Q?czK5tI0X8kfEoLbltWU5DS+p3uX2KdqK8Cf1Av5vI1svDsM8j0trzr5WbhEw?=
 =?us-ascii?Q?cRdMpu82tVVX4iBIeL2Vw7OgVQJEGTLaslL5rlxf/b11SHEmeoyDtT/Ea8Ss?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f56860-cb38-4738-9d8c-08db765d5254
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:52:19.5593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQgKCwcyAIDReFYOzhsGh72XGPht5VyexFWrV/LPbqiEYeylliz3V6lvGpNNAvLJHX503HFNi21Ecmc4NiKWUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 net/dsa/tag_sja1105.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index a5f3b73da417..0e62eab8f251 100644
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
@@ -562,16 +559,34 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		sja1105_meta_unpack(skb, &meta);
 		source_port = meta.source_port;
 		switch_id = meta.switch_id;
-	} else {
-		return NULL;
 	}
 
-	if (vbid >= 1)
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
+	}
+
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

