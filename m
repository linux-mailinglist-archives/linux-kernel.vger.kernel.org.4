Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F20460F498
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiJ0KLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiJ0KLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:11:19 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20061.outbound.protection.outlook.com [40.107.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8542937BD;
        Thu, 27 Oct 2022 03:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1cORnAA0s++3o9+YHjuIqEg6JVO6xLHbzqEZaihjHfl5pXjoqHZogR+d1PtqcMSvLLnI/jeiAMIyiq24xrtJK5xPJ7+48ygUA8TQ2F0Dm2YH79IP6jVm7t3V/6R2I2H6uYIp1IW20JGzfnegpztM43JtjbpLAlymeg6atk6oOve5yjdayMPsS9uY4OW7zogUgGvw7wSRdobPu+O1HrKY5JsYFOXf0tdcXmU/y1GVhbfSE9zjP1vF9oxd3hqQICBMOoBe22fBQVO+DnE9vLLSmo3SvcaPHM6N75N62ldMbblXrzD4CeCQAsi14aP/nmvaKyMFsDN07X4nkTIG4GWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QprAALKrF9MMpS/QguhLELOMx1LFNg+7UXFUMVyTFEo=;
 b=mY23PvjJRz+/gfL1cFxkPfp+hnEIIKcTANeBv8bIDc9eWg5TMcuAUIr4Gxykd11HTfyjfBDTSW9zraBIxsniVHW2p4rXhpZcTcBI9qEFH91TWEg3w/+thESCg3Kf1IVK+h+DqapwaAlEMTsC4LNGb+OBP93zscTPfTbgRMbnxIgEpNPVGFwQU/9xtVk2CLfv23mtrKBK5Qm1IeJFtl1MBLYaD2DWNdjFevsBCU4PVRZ/ncD8NsN4vvWZGdNr57XGkrU6brros+q57gH0FO1fgoFr1C1ngKpw2TRoQ/Q+pcM4bTWcP03bPERs+C0C7oshZuohlOLNDziHwIjt5qeMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QprAALKrF9MMpS/QguhLELOMx1LFNg+7UXFUMVyTFEo=;
 b=UoRXAfw54kXPKyr6zdbrdckjEtYdkJKSxmgJ6WK9bKwvN+WwRt0wYNMjZjgSFvQsgnGkL46YjlKz/T3oOwH7WplF8762M0R5/GTonf0v4DpEi6W979Jk3/QnsNFVsbU56wPj9FcdaPqVrdQgGYHId7gU+5k9ulBsYYdMmI2j1ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8454.eurprd04.prod.outlook.com (2603:10a6:20b:412::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 10:11:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 10:11:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/6] clk: imx93: keep sys ctr clock always on
Date:   Thu, 27 Oct 2022 18:11:59 +0800
Message-Id: <20221027101159.942843-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221027101159.942843-1-peng.fan@oss.nxp.com>
References: <20221027101159.942843-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dc0495-a04b-4698-1e2d-08dab8038e1a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWMpiLaO/0VR3n1wUYKX4St0ZffedZc/GNgJjj4As415Sk4zxT7co6cTYhupT8WOk+2BS5Vb6+yPY7KwXxt3DOJNl2/GnY/ssSy/b8faBl8fbM6x1ZRcxoIcAU/VzW+7q5JvctLO2lRmN2X58Ob+ukcpMJ/y4ztRkhBwVamj3X7eub4DtbChHjDvcEdsmhBS5yLGLtQ58+5zBPQUp9BvCmI5kRIUAWKBlL66diBJg+YGUvMhPebwrvn4wOKqVYq95OODlEXJZnIGoz+uBcGSJd86/envvSol+UbYaAZIS2ng5fMEKr/kz6AR/NvKP3J95BOF4trhR/I6QxISF5rgTNqUf79XxY+TecxDrZO2Uk7keIgbOiujWZI3UERoYPvSahOJBo1xapyGhDMMExIU3iwj2R9UjUIpHR4V8oZWKMNdY8bPF7BvsvM93M487AKsDR9BXoR4qz5cKT5M/ZeU/n5zjLbsem2Pn8Vr8YIjEBhoreeUVRi29JJGuFPCWz+jhHh/YdgzBYijMJCQQW9hN38xU+/a7j7tBUTvYkNQMuZXA8UibaTi33AZLTyJWlntIP/0jmMj3M3gdUzkJ23kuJEA06QgrO2pfiC7PycWjRAfDAqwNx2XMb/C6HXOh7vY01+rlod5MvJIfC4bIHuxJj05/DaZ8mM2UbU1wRZAuW32Lv7Lk77hTDGcgXDkuOHmOi+BqCArtDE7vFY06Tgl6IuApndLTMCEtlic/fUG+WTd9TGNTywtLMaLexUm+NELycAWRLhuUj/bjPv8wt6ybr0CxT5KEEHfgocVaBEFVqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(38100700002)(316002)(921005)(54906003)(6486002)(38350700002)(86362001)(6506007)(26005)(186003)(1076003)(6512007)(66946007)(52116002)(2616005)(6666004)(5660300002)(41300700001)(8936002)(2906002)(7416002)(83380400001)(478600001)(66556008)(8676002)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jKFSamy2xi2o6ZE0tjsCjjbIz0NuquzfgGgUXwcBGexpGcYTUn6rgQjghFUm?=
 =?us-ascii?Q?b8OfSwS+/NXvBE+sCfJkSOmxbKcugZf+eWrTBFKC13K8ORNx/N839w8//0ax?=
 =?us-ascii?Q?XoJtUpn49mb8SZctVzA4zZpsHKUNpDl+EVHCEQICWUOxfpSCiOXrbySgLevr?=
 =?us-ascii?Q?P7w0Mdn36aPjdwyjtF0tWpxU/VkRDlBxnwCJhr21UuXb9x882pGUF0pCdEaP?=
 =?us-ascii?Q?Pz43OlPXaBbd5a84zaX06mLFgPOuUXIBqU7qTa3nFZUNRU9wAQzWgIKy1j5M?=
 =?us-ascii?Q?1d/7MLkfV+FJLCAat0m1oPDQ/c/ypAiGE78YkkeD/48NtjEjK94CIbAItdbZ?=
 =?us-ascii?Q?wRa9Cfjz/zW/ezu0psTiDFjhtMORHCRGzos4jtAGfUNGiOPlLQMtSq3lFBez?=
 =?us-ascii?Q?1Jtu+5lTQjGfSimmKB84UVfCdCt6pfl1jMo1q9wyxpK499W2s+H2mDmY2+4/?=
 =?us-ascii?Q?eAB8KWJ41mK+ltQ7E9zCj8Bmx/IMJu+ZRCc4Ha4kHw0jK1/CBB6nlwNTekSG?=
 =?us-ascii?Q?LY65oZMXevOzCV7h8InSuhwguPJ2pdTlWnS6l4X+iT7lxGRn4NJeaWwooaLD?=
 =?us-ascii?Q?8gqXwvLvOeEE0jSDdc+i2EpEEFWPprYqWacwW+ZYV+6BqkNL3k7sMt7FJvdF?=
 =?us-ascii?Q?JIzD6f6XDmdixpoeWsx4osQvO3E0g6xjFON44tEGbP1xsEyCHPOGVad5rjli?=
 =?us-ascii?Q?yI3L/UNMILPuntcWWU+/HrSvygJnNBzDXZs8D9js5ZcATRPZuOVW27N1p/NL?=
 =?us-ascii?Q?XfubuoIzkmiJKgaouHpOuKb7dZKRgfdgzXYOA692yeILAUOJ5C+vL/5KwW1m?=
 =?us-ascii?Q?6WmX3QXCY8/77VVUOMigxdLx4yj6kNRnStyi5oQgNg9XglRZMFV2EjMSnSW+?=
 =?us-ascii?Q?URw2copV/IHWjTe2VM/VyBip5AWWVb2OOVxbii6t/VDb0O8dLOij9dw4cMyp?=
 =?us-ascii?Q?iNUwK/jNAfHgCDjFJC7x8h92dErrQrtOWUHAfcNue593Cu+zAsYmL/9j/HIr?=
 =?us-ascii?Q?xPk0NjhpWGJMcImuog7M4HL59kCoZwGkxD6Q5M0e7lMkFowZLuByGewPok4s?=
 =?us-ascii?Q?XxUmEE21vkFM5jC0Crgd+GWfw6GacrjwCTsfl5SQ9Fnb64PxfM69IYNFIJ+N?=
 =?us-ascii?Q?3gbd6DnlWcPgVJDQV8qJwpSSijG7JnNRokdiDS1pSt1POg5fGNMlfAHGqHdJ?=
 =?us-ascii?Q?F10fE3QBB1C08E/oKKGGJoPWAcb4vsrNrbLgEB2mWuGoum40Af6t2+Pmhho/?=
 =?us-ascii?Q?N9isDJm636QD5eQ+537JlMrEkTWJFtD7vR95e3YzeS3BAz7iMlLYAtCGRHzY?=
 =?us-ascii?Q?uGYQywsy/MOCcwJaSTsxBs4f0NWHpO9rW7hQYgBsWDCvUfYAE/HulgkG5ElZ?=
 =?us-ascii?Q?4la/ArpcNQdJJxnHPFb++O1WSFynykQ/jlMSyv6cj2Jp2O/b83Ts/awqA8XJ?=
 =?us-ascii?Q?EJzS2wkTYWoij0Z0Jf2qNy0kCnSyowyIYjlimsWg/KLFnfldywk5pFzrlpbj?=
 =?us-ascii?Q?l0U6BHF0qRnD6U26fVnmRIvZh+5Al3nEd7mf5F6CD9+U6hHxd9TqFbqoz++0?=
 =?us-ascii?Q?FOALpPWkuwmvSOi9O3qOLOPk6fDa1Crn79LSPR1N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dc0495-a04b-4698-1e2d-08dab8038e1a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 10:11:03.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTb8bkgTHr7E/9QNjBZFy1dCt0JuKPABySgaQ0VKvfroTMHbxyXQVrv840STsFREdRCCBRQhyATt5SO+16oi7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8454
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Keep sys ctr clock always on to make sure its register
can be accessed for cpuidle.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 74e8d810db7f..91db356564c1 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -238,7 +238,7 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
 	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, },
 	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
-	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, },
+	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, CLK_IS_CRITICAL},
 	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
 	{ IMX93_CLK_TSTMR2_GATE,	"tstmr2",	"bus_wakeup_root",	0x9f00, },
 	{ IMX93_CLK_TMC_GATE,		"tmc",		"osc_24m",		0x9f40, },
-- 
2.37.1

