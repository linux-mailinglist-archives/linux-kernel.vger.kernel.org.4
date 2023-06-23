Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C751A73B1E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjFWHm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFWHmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:42:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B25F26B7;
        Fri, 23 Jun 2023 00:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVXemwO1Sht3p5ZB9TAYjy2I4/NhICrs7EqLbZWvJHuadxup7vG0blCuUfp2H8D0QOKDKZLyLkgA3wF2PAHK9drxpYRDisYdeI0eMOo+8zGVEUs2Gz3dOJUlTbA1OcQJQkCJ83m8BpfJkRiw0FlFQNPlCGLg746rNV28TpF4iIBxSCisYJr5sxHjyNzNB5N5EUTFbp4nuUBXjxDujLAsB3cfnS2ccIDfnqJY6eJ4uAhk53fx51phaoO66SAyIUhfEKbmzJrno8JKqyXXTHvuuPAaJuylt4AOLpAMAauVhTXzpxkXtlF+aeZXegY2p1+qXNeRTV2Wrkeg2OzDHQDiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqGb7Os0cK3DP25aGYikW/TRg6PcoqTgi10qkKDZ2Lo=;
 b=Zyyy5SB+X5TUiZPGcsdIaBeGSyjPpmNPyNJwNpbZ0VUXKWpBk95pw7TSV7Vh6cLpTvUGOQRPbFweT57K01UgfkhlG3Tl1k8fLj4E8NJbezClMFH3ErxJCcuV4Eu5gxHuKT52yokitGXyE7AEbHUlLiXMkEp9R5pT2OJWPcAGuofP7wms8cIacWFYiW2mx4StpxkciHttxdcu/GXJc++MJY3ErwgtCM5DYrVY1TZVqy88BJ9L7Aqk8mDjtppgbZgwG7AqApEc5He2mN7baPo9OQUZnG0YOf2f9WHiqzZe9X6qSTGWxpF/z+e1PTbWizgFeDIg8tHUauTJ2U8id1I2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqGb7Os0cK3DP25aGYikW/TRg6PcoqTgi10qkKDZ2Lo=;
 b=Ayu5vDxV7gTP5bGCwVs2GCW1V4I8ou2z6D/rBmOfyGW6Wy4MgN+9rG4Y7I4upVc5MJ+9cE5HJAScPv3C//w1mCILGJdSaJtndOPvWBk5vTXdqJ5iljs7uz03fm1LEMoNACphxxhIRTWEVqf9YI46pkvvBVenyXYGdA5rwCeohBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:41:43 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:43 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 06/13] net: phy: nxp-c45-tja11xx: use get_features
Date:   Fri, 23 Jun 2023 10:41:16 +0300
Message-Id: <20230623074123.152931-7-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VI1PR04MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3c63a2-d8b6-4119-1795-08db73bd4a55
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: encOKfdWBRRIg9Esp1V1PdG/H6fs9scB6ATYJ+DrbOaoQPWnxnHAFIKQZcP+VCGVM9KvBVNWwnEr26LXTJQUhkWR90pQ1HIhln89sGQQ3h61z8KQQewYfh7g3O2ghFL72iTEPZav8h5saRlDbi+1ojiE4vn2mE4TJaWaDfsBTsJEFNdkjKeYix6MU4VoLDO7x+FDm5L3d/HHcgQW0T3vIWbhTEZNC27McQvlqKrWI7TjnLB8ImGMmpYIeM+AWb9eTA5FOxDjBZxAonLwIGEgzELNiM0uVWV48RHEBWPXyEBPQwo673c8XPE+ewxok43jZH9Sx+pTRhjqi6yT3xKp6iT8HIg76MLULntGi3yQ6lvuouYjwuYz52p4jGc5j4/WVpcoRoj/mVlNs1787gFkYmG5gXUET72kpcChDTMt4wYs5dxZogt3omrJG/d0Pegre0oZ71K5Gl2JDsthn+Mhvm64XE0D1qh1hnGhBs/E9J2hwZnN4AMKRNNkXbzXeCQIapmayFfrefn+oabdrHX4epMLan/DwJDHrs9ZSlB6bfUn1qNtAdGOoX5rIrppbAc3YtVajf9FwM//5Dh7V+QOJ3tOVnw/Y/d56fveSZhcMWoqbdREPo1mdwWD9gAC7bZl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(8936002)(8676002)(5660300002)(7416002)(38350700002)(38100700002)(2906002)(478600001)(6486002)(186003)(6666004)(2616005)(86362001)(52116002)(66476007)(6512007)(1076003)(66556008)(66946007)(83380400001)(26005)(6506007)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E6jCuUWboiddJbB6XLzQefxJmlUGV8T/Cp8hUptk2XvALpu/3I6/r8cKTn7+?=
 =?us-ascii?Q?DsRMA+ZfIUzrQWV9snCFQ+jLpupF/QT1I8VBC2GxoKClIybeLfO3MAUzypUw?=
 =?us-ascii?Q?HMZGtiobfiKECXBtB/jjyBRJrRWApt4PVX8xaELX/sQaq+gbY3NeZ85wKKx3?=
 =?us-ascii?Q?URjsQq3e/OTJGMFZNhyQsWkkX9ivRbYjXpV1vTdolqjTKFdNix3zm7VPajyf?=
 =?us-ascii?Q?Bq5ofp5w4cAG4iayi/bBW+Ki4v7Ce5DC9Aq8QCHGu5wJZi+RlVyWLXZ8SvZL?=
 =?us-ascii?Q?ueN13FcIBV/BI7AGzobKU8y99fQ93suBPZNZ0GDdmj5EKRHYsb29pdvNx/xE?=
 =?us-ascii?Q?pF58mgxgxLgui/6hSoZQFXWW/WFVKXXvH0ZcCH8yHpGdBT1ojrvCI6fcSmSK?=
 =?us-ascii?Q?FwHaAdg7IzeqhpI9NGUyFvbjVFSAMdUbdx4/TE4+PmCQ3OphOUbsGUTnpM4H?=
 =?us-ascii?Q?hlgukqHeb4CLrZcgKUN4T+q880g9q4B+DX4ydJg4vKy8jWAhMnoBOYJjHilj?=
 =?us-ascii?Q?wrF/9hrYR8iuy9JnHwMpUghySwiBFIfYkF3QBFSmLzNHYjkMUEn5wBA81TQ+?=
 =?us-ascii?Q?PMM3KoQsYW7f08cWEroMInatuJotNhim+STFkSc5O1EhsHh6tgSH+NaRlzcL?=
 =?us-ascii?Q?8RIbusN4IY+9XFZ3hBW8uXd+WtM+beDDx5jCNROcF7A6qlEZ4+/Srto4Iico?=
 =?us-ascii?Q?haFgy2PMRU3u2GO3Eqqo6XIt7vOS6GpFIssbeTuppjh1I8784LuUe2s+j7fU?=
 =?us-ascii?Q?jSK1MrqH2txw7bb2STPBRs5Pj9ctp7axiStev9f7/1t4g7PJYDndGDHPm9ry?=
 =?us-ascii?Q?y+1vnqJjRJ2/IqTNoCmNfgHN09QcfbtgRB03SRAP35v3Jj6Gx/1I2P+kLFD7?=
 =?us-ascii?Q?6JD6fcR/O3Oup3B7YMFsFQRbzhVLDBfvlSfXNgCOizgCU+CI+M55AfxR6gBP?=
 =?us-ascii?Q?eweCynfTXfd68yLPRYjtGVFBegIwZPnTxRUom2rsGbs40jD47zihtzmBSguE?=
 =?us-ascii?Q?DDdZjRgv/OD0wXb3AIHPSZfAga7dzHMh2wFcT72Lv6TKNAmIuMCvpE3oXePY?=
 =?us-ascii?Q?zcVnszUndqefU8wcXi5GRylLAfsKVAGRQfWBrXURsX89+5bMyCs2USr/vJau?=
 =?us-ascii?Q?IJkKrO5/0Zl7g4L58/p8x//ygyutq3pvNBqwNnDIXSJ7FTPFCNvM+K9voDve?=
 =?us-ascii?Q?ScNidWjF5wnaB/tLr72Z/frv+zk4o6XRoI99YfCP21WQmJFRXs0AfMPdMLah?=
 =?us-ascii?Q?aqEnkTvJHqcDMBFArTzpp1xRZM9+/G8HiUxVvi1D1EJrs6Xg6BJGm9kNuPoW?=
 =?us-ascii?Q?smgRSvT44mh1jjEeSct3uK/H6OL1vLAXd61rnGf/tRMeD0QAFWd9DoOsdSHT?=
 =?us-ascii?Q?uBR/XGC3gwnRXuoeI9kNv6LMoYyqsupEQTPtdvP7mzv0ikwuyJ0mpoqSmDAI?=
 =?us-ascii?Q?84KgJ3s4XQLHn9Hm6LNYGTp0Zfx6JYnfB7ztn7ENmnfJyVj9HcXAhntyv/p4?=
 =?us-ascii?Q?jlg4pZE3k/jZG4PJoxIy3zIW8AT/ApkL1iWcF+vOL9FkuIUljSEbqzAnstf9?=
 =?us-ascii?Q?hR2hQBxsUCx5U9kXe3fQsa2kM27OIW9SvJuRA5+l2bnSbpLlAbUA2/NwM285?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3c63a2-d8b6-4119-1795-08db73bd4a55
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:43.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAs1eNsgnKbBR7A9Jl2sXVwxxbQgCzBa+SD7wkBVUwB4vHedPASVAZOe5OZ24zhA0QCKL+cRSvosctjBVWFEUG9b1xgQak02C6ylJsQSohw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY_BASIC_T1_FEATURES are not the right features supported by TJA1103
anymore.
For example ethtool reports:
	[root@alarm ~]# ethtool end0
	Settings for end0:
	        Supported ports: [ TP ]
	        Supported link modes:   100baseT1/Full
	                                10baseT1L/Full

10baseT1L/Full is not supported by TJA1103 and supported ports list is
not completed. The PHY also have a MII port.

genphy_c45_pma_read_abilities implementation can detect the PHY features
and they look like this.
[root@alarm ~]# ethtool end0
Settings for end0:
        Supported ports: [ TP    MII ]
        Supported link modes:   100baseT1/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  100baseT1/Full
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Auto-negotiation: off
        master-slave cfg: forced master
        master-slave status: master
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: external
        MDI-X: Unknown
        Supports Wake-on: g
        Wake-on: d
        Link detected: yes
        SQI: 7/7

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 162886cce08b..11fb5a4f47fb 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1353,6 +1353,14 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	return nxp_c45_start_op(phydev);
 }
 
+static int nxp_c45_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT, phydev->supported);
+
+	return genphy_c45_pma_read_abilities(phydev);
+}
+
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
@@ -1507,7 +1515,7 @@ static struct phy_driver nxp_c45_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
-		.features		= PHY_BASIC_T1_FEATURES,
+		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
 		.probe			= nxp_c45_probe,
 		.soft_reset		= nxp_c45_soft_reset,
-- 
2.34.1

