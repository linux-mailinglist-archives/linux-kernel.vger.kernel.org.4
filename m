Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B07562D778
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbiKQJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239258AbiKQJwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:52:49 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204B66712D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:52:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGZCjLorwz1rm15yijIwldWN1uCEDWRaCMVO6yMmYS8bPXJc//sDchRBprBZAhvxDvdkqEj5lGDhtzBYgpKmFENwETSbefC6LYo4wQkNBDQbBYh2jqdeJcGLXiRKFUo95ttGzfBkaFUxao15US+Vf6qmsz/UzyPOwY/R1JcK2zXKr0AMG3l+iUBLL+pwMg5qZxC6B8DTIfupORbW5CWFBxoldmEzB65dQxTaDNOID5iD7MwkSlnw3/vzky4DF+Y8ab3AqliAyMsPEUPGcM0JY++DwVKeTMUdjYfJFhVIAw/udtwsN0NQBo/cEjn/1bleg9cfjB36iGzZtn0gS5rw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mD3y/1/E0ibJpbjGPCjYtWgvN8kRPlJ5U7hqTre8rJI=;
 b=NLHlDP9WgoUP9255Qf/Roj/9lxBeT56k7IbKvDnX54t8WKKff7X2sAvo3zoX24537hNBgvwvPHBRYyAwRWw2GlxpjcD1/vsb/PzYi5VpUDHp2wvM2dAHebiy62c34Y7gXNCkJ//Szp+x687OJXeDoDdDPjx5WMYukNO2oo9guH+n6xiMN/HpmK8FzcU/QwLiDHEbeK7KGU6DZdWMF6JnetErnxKVy1fATgX7rEYFQ6ByJlz7hWMvcoYda6zpaAe1ZRlGRG7fdLzIS47BX2TbTuTCss7dmylviz0/kjT41xS5QfYGCy7FEu0zd1YK0+aK18Ux6RcBbSkxxutV9FNqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD3y/1/E0ibJpbjGPCjYtWgvN8kRPlJ5U7hqTre8rJI=;
 b=KDrbUcNgoYFzkUXv7qaGaBKO6wVZWeINjzJWK848fcpMg6h1SYeQACZuazmQCuEwcfGW8M7d90kfLLMRHOWIp+ZmAWrSrOwICSIAaN8MRjVRweX4kO5RQA3FROOO4/fo4SeeUvIMweAwkc9Fogp7q8RZvoRqhgCcOB9mLuiauNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 09:52:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:52:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V6 02/12] arm64: dts: imx8mp-evk: correct pcie pad settings
Date:   Thu, 17 Nov 2022 17:53:53 +0800
Message-Id: <20221117095403.1876071-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d563c8-0612-4c5a-c50b-08dac8817963
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9Xt4kNjWswnhtK/0h1mXKSRE+kPxKykiXhNqBYlJjHF0ShQQMImoRbQ9Oj4zNVD0AWrA3Knu3gIIzBjwBWi6/aUqOcsULrB+c4cq+yy8pVZC+DOmNDY1ZfWRi+KKdERDB7e7IdzaLzfcGanZS7EvJpzxVRephzXL5TZqHWbBXVzKxAY8OGnl896zjWGIEH2JNwvshLCYGxGXvuVJhTBKuIVrPpZm6ihWStPb/UH277wP3wRe+XxbSPDLoCL/lWBoPyCjT/dtmQQ7ezKzCphbnHC3e1k6JN7u5JxkP3Pu5q/KOLLABZufDjOfafiHtUsUOiffQN/MYAhMafxCP2f/SjH7y/tHQkRrLvwS6DdSGQ1do85JlZNabr94le2KkboVME14zz0w62nMLmoIga/r7gCOUp3d+YKwoNzAJ6+d0Z5PmxXutS0sgfRCy/aE/NVsov9plvTSQ/wyP7YqxOB9JGZSSqkN3QBS25eYQkk7TclEjYpO6tAdw2Dt66bNy533VIxSR5JrDQRZEOkqxlPCwidq7nYAsOfYsIfHauza2UGehinEJ3CSQCCKqkk8B2O2jYAWKrKfSA0GPLCakRTqNO6o9b7CTxNP0flGB7B2e72DhnU0Xa18S71IXWkM4dixzQvnAAbM2K2T4Ax0koZMeJsp1wQOTr7MsNNYR5xdUbHNISF7BLQ6sDtsK4VEnQUaZyT2rTYwt1FX1eHp/ELbP+0k89TqNcPide/3AnwpEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(83380400001)(86362001)(38350700002)(38100700002)(8936002)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(52116002)(6666004)(6512007)(6506007)(26005)(2616005)(186003)(1076003)(316002)(54906003)(478600001)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OgT8fvyke4NljzTEaj9QcpDMdpWz/dkvxdXuR72IDNlhE/i0pAR8e4zJVsLq?=
 =?us-ascii?Q?UoZ19tgeLUKapyvLiy75FAceuojzxZCMkTa19cyq2wyoqK9osiL0ncHZFL77?=
 =?us-ascii?Q?dmoKCnmnyQ8ShLwBC5wCh9DxD2ZD1eVsJZA5H25RmeAGU05Kup31gjkmhO8X?=
 =?us-ascii?Q?s+5hE1OPL7lbpuwYV01fZlEwwbi2CNwZdokbV/dgl1bD5mA5qMOXD5123t8D?=
 =?us-ascii?Q?sRsqvaSWdKO+iY5CceZiJ5acNaJ/mm4hsTSn5/cw/104vNmH+Ll6Y23R10gX?=
 =?us-ascii?Q?K9w/5/ZzQW7p/aPc3giyu/+VGMCOg4ZF8CqAoB+mhHQ6vPQ6NqpQ24mFvIoC?=
 =?us-ascii?Q?f5N/K8UTK7J2lhr8/gNyeVhMmZKlDTjXxsnLsY8Q7Lwkitsaz+jPmqkRIFty?=
 =?us-ascii?Q?OY+FEdoX81tLff25TdJEK8TfmYjNEr+KIdVOKoEWpSJ/Z5orh7C2osG7mfiR?=
 =?us-ascii?Q?ieDYGXJY23Cl/9mre8bHSCVrQOsUo10hcPI4gvLiELtdb4RvK6bRLBWdUGHG?=
 =?us-ascii?Q?icCVMOxQ5vF+/kZTBcxbK2Dhh4b9/AE7kKMs04w3RLQxHtQ2qr/aQVG8/cHj?=
 =?us-ascii?Q?GtKjXoXZ+S6qU3q/D/oQVotykvGiQtzEjbPLt71ANEhcIaN2usKY196EtdkC?=
 =?us-ascii?Q?H24OI8J7SEedv4pJZnLkt3U+TIMu+BYsUWM8CTRZDZ+RZGc0cBOh8vj3wwzs?=
 =?us-ascii?Q?2x1ny8GEw1AkyULKR5qbI5CLW3GrBZHjSBNSSogkEN4vXbpTJ6hG5nBjy2CH?=
 =?us-ascii?Q?kWI15e9DCssl6wSyzJ9/K+0iau0cEoi8vZK8xXuhj/Mu4GNPibf1fXb2e0KD?=
 =?us-ascii?Q?OXk3Nv6phKG2Xm6CVShpeNZulycdMi35TFIa7VqmbtVNlzMkBlfG6kqihNA6?=
 =?us-ascii?Q?rN/B5e5reTPjILYFmWMc6RQrd9QAUOZSlMJ0ujEVBKafmKtbD24EOgz9tZRp?=
 =?us-ascii?Q?w1VVKfn7cT3tKSC62rJmviZOeLGsm12ZTTuV3u8rfpZqocq4PVEmMmvtX+4M?=
 =?us-ascii?Q?v7VbmC0CHfrIbo2eBWmzaL7ijlzuVZqQECI7gweWK51YsX0GeeIk5SnZCAd1?=
 =?us-ascii?Q?xR9jM9c/2u0uFEo6Ci91qjnyTR4WPCNylu9sQ/mKMiHksWAn4vySFpFbKVW8?=
 =?us-ascii?Q?ys7psmVRzCQgoifJmymIA+Mc5M0WIsUuxm2Iy/apdizgdaYPZCH/8nrIDXvY?=
 =?us-ascii?Q?yupCBI7PPYoNG80mvrOaDKHpTX9iQZkhLbglhe6RdJJDjH4jPrUNbLqefm+G?=
 =?us-ascii?Q?s9QdfJZtwuXxKablDXHS28ih94M6L37fQY+O/yJd16qIvyQh3+aUhA9OxkkA?=
 =?us-ascii?Q?GDh5dstsAMWeatuk3bDHl7/s0je6z7XBKO8Q+GW4z5ZTqMIMxkqd2VxvJfVA?=
 =?us-ascii?Q?5N3L6Y7+fe0O3m8nCbS6NUt30EMx5clYqViuIO1KqzsHQZAlq3tP82wKiC5/?=
 =?us-ascii?Q?TcARE36qyNffFDysgyhfq7BBBP1GbMYJWsOgsKfIYPR6+Mx2y17JjvpPbPs1?=
 =?us-ascii?Q?yitQoulIXe+jkCFfIrzYrjlG4afg20Pac4zyZuem5iQnKCbJQPibIkvnqxVy?=
 =?us-ascii?Q?gc/KpHaurdGWGWRmSGY6FK+o+yXwYqj1XUmz5ged?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d563c8-0612-4c5a-c50b-08dac8817963
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:52:44.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhxeJFZBJUeGSdsnT6Y7WiKGZHm7KSOiPQRD4gEihNECMwHbs3IXWtl6HcozcedaguSIs9I/NasP/yJJnEobGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7702
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM bit layout, BIT3 and BIT0 are reserved.
  8  7   6   5   4   3  2 1  0
  PE HYS PUE ODE FSEL X  DSE  X

Although function is not broken, we should not set reserved bit.

Fixes: d50650500064 ("arm64: dts: imx8mp-evk: Add PCIe support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 9f1469db554d..b4c1ef2559f2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -544,14 +544,14 @@ MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL         0x400001c2
 
 	pinctrl_pcie0: pcie0grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x61 /* open drain, pull up */
-			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x41
+			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x60 /* open drain, pull up */
+			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x40
 		>;
 	};
 
 	pinctrl_pcie0_reg: pcie0reggrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x41
+			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x40
 		>;
 	};
 
-- 
2.37.1

