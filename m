Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950FB740140
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjF0Qcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjF0Qbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:31:53 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C513AB7;
        Tue, 27 Jun 2023 09:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJTno22RrgP1c4aEqqKmZ+axVuFTmf4KNiGAzpYzZky0SbEcRF7NsvtwaT7amiN+IsjXDjRq/L4bwIh6qTP2R/qH+FmpEZ0bAbpyPl08ZfiR05uQ2MTwCrJxJECiMAXM0dUrsTmn3CHkJLCb1SL0syJI1dRnXKNOUzYJqs+1j78WMfoC2mRE99FMfpj6YwFLC2MxM22Y3DWD6XoEZp2Rpn4SL9MvW8Ecnh3ylv8WaRlrhpJHSge+u0eagxsYQNLYqQbW9dv0qKHXRkA7wUaS7UR0IqmbO1Oovtyh6W1QhMOsdd50Fr9m7UxZWp9Accy+Ft04HeQKlhsoOtyF36041g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzsh9DezhFnr46zoqNwvG2xkkkAQf05VNJB7IfbkEmc=;
 b=F9gYKWY19R5Kj20Df2B+4YWmKUiwOb8pNv5V8m/oQuvRBWQC5eE7ldEdcH6qLAHdiIiI4UfmCEM+JQlnRcmVUmUNGWhRJRjnml6Z6T4ZcsKSpH+dinWBRG7EISfImOB7p+ueMWa2aWp7M1Ku9qt+7OEaHoIELB7qCe2uDwnJ4gfj/AbXL+Tb2FAC4JHSEc4JdmS3vSPICf4YjUTTJZHUl8uofT4Wh2oF9QrHMzT+S2UeVtssjWlB+awx0IghCkgSwNT3IfzL+Gog6SrvgAkuNC7ECRaqWGfy1kFWmapZRt4XoIbu42lYLERFLgFYds3DiQAsE0B7u+5qPLY6Zpq2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzsh9DezhFnr46zoqNwvG2xkkkAQf05VNJB7IfbkEmc=;
 b=QQfqcmXWJaTea9FiaS4G64o+Jc/ulPZkas+kiuXPg45T5LyByCp6OUJHqOYODuRKn59pul3ge4dkf7yT5z18C/Z0g88RoOxYt3hluJT+cTfrnoKFEfxM+Rgykx2c8f7B40vhvwbiyByIBvsu8aX6Ce7l66QLIo50d+yFrWANLuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB7314.eurprd04.prod.outlook.com (2603:10a6:20b:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 16:31:32 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 16:31:32 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 3/3] net: dsa: felix: don't drop PTP frames with tag_8021q when RX timestamping is disabled
Date:   Tue, 27 Jun 2023 19:31:14 +0300
Message-Id: <20230627163114.3561597-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627163114.3561597-1-vladimir.oltean@nxp.com>
References: <20230627163114.3561597-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM8PR04MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcf2c18-e482-417d-708b-08db772bf737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nntW6F0ly0KKK/QcYj8koJj52iXgsAZt0WU5I1MVbmldXSfEVYCjVvh/gnMBiLJGny6003CmtCagGHdPH7MhtGzGy5yVK4FrOFRzzRcUFhIXLVPLG2GtsmwkcqGj5zgdNXTVkm82KNZu5zLmCc1rtQ4EzqkAgM7HEPaVHLvaP7W7C3G3xDYAR2p6TdYyA4pn2rBCSUKGByb5mEP9Hm9W/BlC9UpGnhodTPRlRZtUpWd3evFMSXGUipQVLfrnetsJ8Zfq0aKxveDKjUhaGeWB6wNf65I3BAEy0xKKa/HNiM1joqY6Dp2AJY4esegMB2VWi3Ck4Vmnvj8/GfarYc6yfcCeiaHQvdkYI2kpzAXzFKmEvcHodHThLFJ15pzJdkQAw1od2fH54BbScenBJ6pbk+8DDUYN0zmGbZiI3CUuDJlGUdu2SqXlcJFWnDVQiuseqK48xHp51+pT9GxC9vclBfbFiHMrmRGrCmU+eboX2B2G8TVFqUCArPXaqkYTGlsjxTEUvx10uy3ScstdptumJzTuh+gadv+CHaqKXDwOQp2Vbh0pDfGxSy4Wllv+JwWep0s0MLafTVccSMqHnauj9SNMnVMb5yT8/BhgvlqClWMg6WG+dUC5BGWXwq9FT2KJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6512007)(1076003)(44832011)(7416002)(66556008)(4326008)(6916009)(66946007)(478600001)(316002)(36756003)(8936002)(66476007)(5660300002)(8676002)(2906002)(86362001)(54906003)(41300700001)(26005)(52116002)(6486002)(186003)(6506007)(38100700002)(6666004)(38350700002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KkLbsVZXS1PZHAvS4lM4uUpcnTxJJmEFE8FilFhtkmNKvCdHImYJdIAW0u+I?=
 =?us-ascii?Q?8McGkwl1VGNpUtDngMYxDYMnx6G9gYuxkxA2/5dlWjPOhlASQUY20OTXeHR9?=
 =?us-ascii?Q?JgdLImgygPdJtRaRVUZa55H9WnyddxJtGRqN8fHvVI32jJLIA/OUpNcgFuq/?=
 =?us-ascii?Q?s6KQwAez6Uht+21MY4AmOqiUhrc8Ue0YXNZ5c/ITJCno0UfktEdIGuLGTXnU?=
 =?us-ascii?Q?K6gNqV+SgJdlRsp724SCqe7UFDBLI15dXud3hrvbrq4BYJDRwYeWVpngGUvK?=
 =?us-ascii?Q?SvychTOB/HBitGGOUpaPTxbB72/JRVdFdFN9Pt0IpS5nVVlKQm63i/57bFJI?=
 =?us-ascii?Q?5G3or8Qubo3aOUh49/WfPCL2bxLOqrLptearftr7P2+FTIPjP3rbxzSs4pKX?=
 =?us-ascii?Q?ympN15xHj/A79le2vTIMyBht+r+sgVg85D9JwBjss7/5LBMEn3+xzxLxkg+j?=
 =?us-ascii?Q?xkXI4+oG0PZdzRXuQ7gNJNKcijH5rep3PU2G7D84iP78OyRCn9VzPaCG88Dg?=
 =?us-ascii?Q?juIJAsQ1h1IWXvwWR/5VMyaUD4pJBzluWS4i7gviD+V+J2q1Fmfi6+vcZIZX?=
 =?us-ascii?Q?43n5/3ga9A1v/69p+Ehutx/fFCNxHwfJgH7btIYX1PoxRe4K0fUNINT5p/oC?=
 =?us-ascii?Q?s/GPH40DPMcDBvv/NxRt/hj6SlP/rXVPpBUv7ARzJDKXEBdIJlyyxwR8GGh/?=
 =?us-ascii?Q?MW9lJNz30tKZVl9Uhka/Z6GmMQRo1Rz13O9IMGGWMEwjsGXiGt7g9vd79EGu?=
 =?us-ascii?Q?mzbNJdfweh6ZEhySYzNqkjH0a4d2FKmD83vP9HI7hu+9c9F3O05arZL+2ZoO?=
 =?us-ascii?Q?TOW4RHYcL6t2FUQuwoiUWHtX2W16Ubp+7Dire7Bpn6GeujCXQi6RUXaqx5CN?=
 =?us-ascii?Q?mC9LiVRaUXgfUiMiLVfuST3J4Gw15hNYjctCnlSg3oXUp8WIcWIpsRHWcB3Y?=
 =?us-ascii?Q?CilE5/2HfuooZjuNTlGXhfOU7e4qUa8RLtPGm6NxU4GL1kyEgvTZ8vWmRR27?=
 =?us-ascii?Q?uxJfShzoXabBqgcFcTJ44/F5+eDi44f/oeDwozDo86uWZfi75u78HZ8vz7df?=
 =?us-ascii?Q?BgLfK1qpXrteZ1AJTpC/6rb85/NZYhPrSQ85jZDSM5b8v4SsO4cfrj7ib1EY?=
 =?us-ascii?Q?l6sfAnIHaApKRGFyxOsBhT59Pi2exXlOABgTGO80BkpNh8hA1aPVHlk4d9DZ?=
 =?us-ascii?Q?cns2CtiphrNU6aKGtfiLS6mcYlNJO18eQDgGOumgKBsrmipMH/YYYuzY813R?=
 =?us-ascii?Q?y1UKGYHUItg82X6wFshIMaQX8iAR2HZuKhhU478jsDfYaB1EP31Sg5PfhE+a?=
 =?us-ascii?Q?yx6orK5n4KZE/YqlrfQS4HUtu48mrFSx++ygVuQiQCvTxROULTSeSVgryuSu?=
 =?us-ascii?Q?JmbebdmuNefkAdHk4qNdoi2ir/c7GG6+D7QDzPa0WGJWRox4w7sF9lsY8e8w?=
 =?us-ascii?Q?LuXCToT6O7rpflVx1Rke54989Rw3tqjhODmsHbSoIgWBYzeD98GGK/CfkkGn?=
 =?us-ascii?Q?p2BJTMMhBDX2EcumyE+Rrtm4KULavNPoRsN87qhdV5vzYpgTNLazNFgyvxwZ?=
 =?us-ascii?Q?M/6onERWq6VVW7D56P66JLBDbZorrFn7A+6mNJN2Vq5lrE9B5GlamUcz8/zd?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcf2c18-e482-417d-708b-08db772bf737
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 16:31:31.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVPY/0B2djrLaqR2iROpazcwEuX3a+E7Is3ACY2Bo25TVn/L7LWIZuKn075AsFYwmunLiCeMye1amc8sJ/rk7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver implements a workaround for the fact that it doesn't have an
IRQ source to tell it whether PTP frames are available through the
extraction registers, for those frames to be processed and passed
towards the network stack. That workaround is to configure the switch,
through felix_hwtstamp_set() -> felix_update_trapping_destinations(),
to create two copies of PTP packets: one sent over Ethernet to the DSA
master, and one to be consumed through the aforementioned CPU extraction
queue registers.

The reason why we want PTP packets to be consumed through the CPU
extraction registers in the first place is because we want to see their
hardware RX timestamp. With tag_8021q, that is only visible that way,
and it isn't visible with the copy of the packet that's transmitted over
Ethernet.

The problem with the workaround implementation is that it drops the
packet received over Ethernet, in expectation of its copy being present
in the CPU extraction registers. However, if felix_hwtstamp_set() hasn't
run (aka PTP RX timestamping is disabled), the driver will drop the
original PTP frame and there will be no copy of it in the CPU extraction
registers. So, the network stack will simply not see any PTP frame.

Look at the port's trapping configuration to see whether the driver has
previously enabled the CPU extraction registers. If it hasn't, just
don't RX timestamp the frame and let it be passed up the stack by DSA,
which is perfectly fine.

Fixes: 0a6f17c6ae21 ("net: dsa: tag_ocelot_8021q: add support for PTP timestamping")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: distinguish between L2 and L4 PTP packets

 drivers/net/dsa/ocelot/felix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 80861ac090ae..70c0e2b1936b 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1725,6 +1725,18 @@ static bool felix_rxtstamp(struct dsa_switch *ds, int port,
 	u32 tstamp_hi;
 	u64 tstamp;
 
+	switch (type & PTP_CLASS_PMASK) {
+	case PTP_CLASS_L2:
+		if (!(ocelot->ports[port]->trap_proto & OCELOT_PROTO_PTP_L2))
+			return false;
+		break;
+	case PTP_CLASS_IPV4:
+	case PTP_CLASS_IPV6:
+		if (!(ocelot->ports[port]->trap_proto & OCELOT_PROTO_PTP_L4))
+			return false;
+		break;
+	}
+
 	/* If the "no XTR IRQ" workaround is in use, tell DSA to defer this skb
 	 * for RX timestamping. Then free it, and poll for its copy through
 	 * MMIO in the CPU port module, and inject that into the stack from
-- 
2.34.1

