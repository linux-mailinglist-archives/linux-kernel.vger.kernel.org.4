Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8975473F86F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjF0JMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjF0JLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:11:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3DE2D4F;
        Tue, 27 Jun 2023 02:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/QtkBXAbM60dO5WqHzIkeIXdO6NTT+uomjFkd3+VygyUgjqPO9O064RBNJMV8KhzWWOxWxyXMY268XzPtmLX1EUrQSMubepub9Qvp/NzAGGUx+XG081Px1ClsxK/VZwNKevDpqzdJ1WICKgonODQjCf/PBBwmOxnfyhocfzkwEfqqVo0TcZFQuvhy3hmROGn6O0LiLLQ3oGtj11xs6ke02WXfI529CdxRqNcbkAtmHuXN4ZPaE2o3uzSyVZBQubdqfWtE+gpQffdsOIRdzSd+eiHAb7xSzScpjo5/CwCRgQCz67nB1z3gpL4mluk/PMkTDmu8O7g2LbBIudx2FLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voVqYPY0BKfPHCX+ZRboN12I+vP4ZaP2jImwH437K6o=;
 b=ikIHxuIyODw4CnbqcMDImxk7MrlrsVz85JVafcUguRXaPtiRvjY0/0wQriicKVTdfrTLSjeD9T4Gc3MEF48BYxtlqkLDymSXaQoqFnZ3yoSyKaJeYezYbU/O1l14cBCgJMyd6h2nfsgymbU4MP4qBh8+QQPPE7OvEINhuYIeQUY/cGrkBQQYC9CH1N8jQ0Wwycv3csZ2URo3DjMif1jmjwqgLA9rvfvdfuAlFLur8yN7aDqV1uZTqkaIXz0QN5QG5G7oens/bz0OVaVC5jeeZp3OpWSHrft9p6jiler/lZaH240YHGy5H7oCWxeWOSd37pHA2weFaAoQODsDxxV5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voVqYPY0BKfPHCX+ZRboN12I+vP4ZaP2jImwH437K6o=;
 b=R770rnpI6i3wqHVjSoiPdGOeYJ4wrh9UeGktuDpwzzaAk493CyofghCbfBvBl3sZQbA7iuQIWjnvsRbq4tbvj44ekthsKi4TBzOELDG34AcqXrc0mmoRifkTlJB5GhhOYN7XSL+BLyuP8CGN24IC0iFSwzMcOS2FN3lO5iV0c3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM7PR04MB6775.eurprd04.prod.outlook.com (2603:10a6:20b:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 09:11:21 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:11:21 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Harini Katakam <harini.katakam@amd.com>
Subject: [PATCH net] net: phy: mscc: fix packet loss due to RGMII delays
Date:   Tue, 27 Jun 2023 12:11:09 +0300
Message-Id: <20230627091109.3374701-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::20) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM7PR04MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 52416892-03b6-4ba0-8b1d-08db76ee790c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZxW9hAIbgu+aSCmxm5HftOQSt1IplUhf6wsTgEuju55T4QSEDHYfNPZSU6pcRdfTeVBdcG9OBNf/tZrCBUy+X+NKUVOSXZBYU5m16CQu4JgcO/IgLZL1oyhDm7Ew2b3VTMalkBLQhyXpsMOhsYGgAefMGj80vLu4eUHeKM7IB6FdNRlGZVChN3A4YEKWH5bw5iEvkh5OOWc+87lRrLtWFQpkPs0skfo+/E/Hc0IijpvnEQYVPsiK/OC0YNXOpqvRyvmIZ14lmAG9S/iGnfb6H3cbVBwCuLyWERlxDbqaJ2+mM9pjx1xjM/Jkp1nQuk699Ud7h4X9ybL/60z07LQKPA97gQJL3BGBcybjMMUtKzqeZwS28o0y+b8n26pmsn8iMTEdJCS0n1GeraGyUk4oe5azRV2hyGJGHLfDiKVCfHGhErbS3qPcVRbnebFtVTa0aVE5J6tf51W7ceOhhkuMdP81+2PyBk9PiL2C11Z/47sqj6yIYh41iZFrNaVR6qnOE9UwYSM6FGV6q9UXJOu9pALIcjnwi/ADSyw0AO50E3wBYe9REccsBKVzWbxIKv19D2KpLabLiatEpru0CuB2zDVfe9vfsC4dRtVpDNFRiqfqGHJ/+Q2G5n4xsgBs1Pf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(83380400001)(52116002)(6486002)(478600001)(54906003)(6666004)(1076003)(66556008)(66946007)(2906002)(6512007)(186003)(6506007)(26005)(66476007)(38350700002)(7416002)(44832011)(316002)(41300700001)(38100700002)(8676002)(5660300002)(8936002)(36756003)(4326008)(6916009)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RtMaxjJfok8/b36e4/SvdVI9G7J4WI3+dhz4wkEXThTqb2be6NhO0QuRTQA+?=
 =?us-ascii?Q?1elfeMgYGa+Ko+YLs/7db2iFPM+lLnuXXZ6LrVDSNTrVmKf6Jow2/215uSY4?=
 =?us-ascii?Q?531Qo4S7tAPZKtue1awrufZf5kQmej2FUkmU1Sjr6sBSdN7RLxppRQfChi7s?=
 =?us-ascii?Q?6wBdCjwqFI73kxilWAm4SXL6sP5gpwGAetxg1s0cdMTTwWs+2vTHhvTehYFj?=
 =?us-ascii?Q?BtpcP/EyfnNsY7lnGTkS7DDUEpP6QJWdr0EmS5CHsMGsRM7RIZF7yiCE3pfv?=
 =?us-ascii?Q?9HGmnc2ILILWgAAHgKuwBvPFwILqkHchp6IiyMRUEF1p3Re2q9zg8O/NYMX9?=
 =?us-ascii?Q?4Is988ANerKTdERH5fSq5fci++U8ddH6zIABlF+yEUijYZqfu1aJsG8k3rD6?=
 =?us-ascii?Q?2ZjHn5QouPlrrQxqNDu1yYBTSxGkMn/4AJmFZaUiKIWrgFFvSFNCgBFDClne?=
 =?us-ascii?Q?fkFjsPqemqZmSOgth3+N7KLFe9WPcASIcUlSJ8WHQr8HHH90E197XZG4zW9g?=
 =?us-ascii?Q?XFVMxXTgcd2LnN5Rt+OT5S+ittPeONy4fJjeO/e40cZnKrnWw8pDt/MovvjF?=
 =?us-ascii?Q?u1bfXc9OrOpPC4tcinBIX2obB0P2I7We4IvgzWVUEyQsyIeeYFJglOEk4ZcU?=
 =?us-ascii?Q?7C7WyCY7TP6oKZlkXb0V+E8jhwF4iV2H+FWCri2SVsmfZT0H6KptPKKf2mCt?=
 =?us-ascii?Q?BtNtWxo/FF6m2gPJgw6VMRKL3cbbGoJIstb8SqWrBnLaB4WMYLdIf1tGVbqP?=
 =?us-ascii?Q?jlhsTppywK51hlBo/UiesrJJPu6ILN9mU5GYmY68vYRlTN3W+Bc20dNmfoHC?=
 =?us-ascii?Q?+EtXRU9l5BkdQOyVbkOFhxZrtHm49xGjgi8GJXkoDcuKIj6ytoDf3jI0ZmIF?=
 =?us-ascii?Q?n52PBQhq2cYeRULwqKP4nz8gpI9t0b291LQQAJ5ptIlx9MQGRGHstkZSX9QV?=
 =?us-ascii?Q?Jwz81PHvV3ozkXf78Phv7WynFu5mitMjTMJZjQmAKqD3Pysop6VIifmVDPjq?=
 =?us-ascii?Q?yMWNHTtgUlyeXnZiCWGH57oJYAvzoO1qWznS9myH9OfHUn1tJk7CPAxjNjxU?=
 =?us-ascii?Q?sEtxSrbYiDW6jnwUnt2l93mpLfwzOQjk6v7rNIqjaHm8+GNvwLMYFz1fSGt8?=
 =?us-ascii?Q?aIJPmXo/2vWW7cX085x87O2G7x91lcPy+KAA/Am/Y5vKAUBiyAfod/la7Blh?=
 =?us-ascii?Q?n+oBPqDm2i29D0fhTeuJwVDT93UcIKQLwf+c8YQ4uN5untt0Fom95ssVQbOM?=
 =?us-ascii?Q?UteRFrPgBsEb6ZzcQeEwpYlruvLKGAw4qZ2BcBZozUQLCANqzx7ArnMjhEy4?=
 =?us-ascii?Q?+wfcQMRvkht69pWZ6u/F7Sdxlv1/SA+apN23NB4w+YA6wPXY9tI+3gVGcqdn?=
 =?us-ascii?Q?rJ4OsjM483TLHS9y+ef8+9hzu+MAh0fCu+MI0+8n4rZqqAqcwuxntWLQbjob?=
 =?us-ascii?Q?aW8v6rHtWoEUMJG3Cuy8DRs1MhPjQoDQ/z6b19SfyzWOelCfFCOLhMsPdW5F?=
 =?us-ascii?Q?Dg9HCzFkcXp1gbtGd4ZoyFti295qORuRP0ndasCFYvyhSCPe4bYAxkxZi9Rm?=
 =?us-ascii?Q?7OG22SbRwguEZhuiyKe01epE5df0FluVxXXAZ8lKLwRioU/TTjMulY60Ex0/?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52416892-03b6-4ba0-8b1d-08db76ee790c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:11:21.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAF7Rds7rPWodRQ3/4Oao2svKsFxaQiu/FeIstxXAYP0QXmCkEpqztRSlO9yVNM5O+oaN/WrEYMylGEZHwe/ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two deadly typos break RX and TX traffic on the VSC8502 PHY using RGMII
if phy-mode = "rgmii-id" or "rgmii-txid", and no "tx-internal-delay-ps"
override exists. The negative error code from phy_get_internal_delay()
does not get overridden with the delay deduced from the phy-mode, and
later gets committed to hardware. Also, the rx_delay gets overridden by
what should have been the tx_delay.

Fixes: dbb050d2bfc8 ("phy: mscc: Add support for RGMII delay configuration")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/mscc/mscc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 669a4a7a28ce..4171f01d34e5 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -563,9 +563,9 @@ static int vsc85xx_update_rgmii_cntl(struct phy_device *phydev, u32 rgmii_cntl,
 	if (tx_delay < 0) {
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID ||
 		    phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
-			rx_delay = RGMII_CLK_DELAY_2_0_NS;
+			tx_delay = RGMII_CLK_DELAY_2_0_NS;
 		else
-			rx_delay = RGMII_CLK_DELAY_0_2_NS;
+			tx_delay = RGMII_CLK_DELAY_0_2_NS;
 	}
 
 	reg_val |= rx_delay << rgmii_rx_delay_pos;
-- 
2.34.1

