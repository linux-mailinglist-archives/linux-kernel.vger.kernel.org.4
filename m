Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0516D17A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCaGmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCaGlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:41:53 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A926F1CBBC;
        Thu, 30 Mar 2023 23:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5mKJEz/oRLjrI+I4yaX5oU+0FYq32Hfmv5dm07oVHld7u+sMrPJz+PEJjXdwW8eU3lCy/Ozazt6ZnvQatDsdIdPQ+SqRo6AcI/ng+4SqQD0y3qPISk9r863n0O7YgkzRgmS5Z70SvoNv7eHdTp1LxoUfrmwoBhBahfH+iUU6wgc4NbnaSwCc+whuXtnamz44BMoif2JcQwOxddoUVfGEo7hihEy6POeBdyg9oMdBHL3M3oUEd167dINcQgAR0knnhbqD34i2YJB4ePcpmklS8bupNOb8nvRm7VCJPY5luSfnF+vL7mB3kR38rB+pfhQau5EInhjjgLbi29DNCduLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNvKSM0cMjKyVgYD4C1TuVD+pATokKsELecBHdNvvdE=;
 b=Ho+nUZ9aeqBtl8K21BukF6YthRJ5MQVUtbbf6lgP2/4lYG6fP0LZYdI/w6Q6N0R+zFWHmDqXXQA3UX/p62XqGQB0gUajc6MN0eT1Kk0jkoy0BDfKCmvHPpFBzHPV+6Jt7tG6IoigMzBGFw5uHqBt0dcmwr0kjJ5+vCf9Anf6fPBgmhJd3B8dGldFatoBmTwsO2UsNn2yXiV61b6cX/uRgU0ezfJjU2P6czO36sBeP7H6IBlEV9J4U+8MjxJczyv7KJWg9h8lnmLDqlDUoYGPkK9BSAg3PKSRbnprMyBVPBgYTC0QJeHAYf3OlsMBB4Q82TVpW2B9al5DFo6lIbPEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNvKSM0cMjKyVgYD4C1TuVD+pATokKsELecBHdNvvdE=;
 b=Iou7iM1B07/orEv/N9vbqxE7UZGqRIDnh0WcB5gLAiTNjUfaQknDLO3Dkp9EWy1cU3W5uc+KZYMFlY4rKfIqt0zlNbVORlo3/1tNsWRu3dfBmnrioQOMezbbqsI90B8f6CJVNQAz/lzYMARQoPULt8D59IuBngPNtQQS22E5f64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9271.eurprd04.prod.outlook.com (2603:10a6:102:2a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 06:41:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:41:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 3/6] clk: imx: imx93: add mcore_booted module paratemter
Date:   Fri, 31 Mar 2023 14:46:26 +0800
Message-Id: <20230331064629.2475338-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230331064629.2475338-1-peng.fan@oss.nxp.com>
References: <20230331064629.2475338-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc325da-5e9e-4e8e-d60b-08db31b2fbdb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w33RbaRJuQV7peD4I3+V99zFbzro9o6LlyVsnjPZLGC5elVNVYYJPX5HJMoVnkFUAfBGZpifdfznenWGMyz7tUdzCrRwnzIUzZ82wnQKSWd9nGbF4lPbQmdIGsn6KtO74uCOttbi2KpGjthtSI6uy4ZYHFBLSy0xcXlfnFbzPWT0gJOBVpIVVwwtQpxPpRFx2mEdSyjW+x2p0RGEI0qg9rFBnL1uAq90x8eIO6xZTe0GbmY2CCfpa5gIJ5fgra0ajK/oD/f9r0ISMktdpr3NvMC9N4mOZGQlF1yfeE5lwIU4EW02cWY9TvqgFhC3dfvTtmqUxhxM+XKp8IE3aZNB2GL+tf2GMSBtxemUReZA2zAGCazWy1H7WdRMLWEfU8tX0+RwMZb3O9AyD3HdIaA1twy63bz+vDLGVxyA7m/uYP5xwCaI/SLzacrWqj4qvroH/Pg0L5doynugZOEAEjn8v9wDzyzaJKIg7GhMKdN4damU9V5obuYQdKVo24q8S0QDjRx+3y2FiZb+QfxEYCEY7KP9qEtlwSZmM20wafMX3D8aLZ+FhKqfbLi8t76K7jaRdWUFVeAltvUUo/8dPsLIOM5NMi4S/mLRsfzSS3vKt3pPA98xFgH8fQuVOSw5G/P/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2616005)(2906002)(4326008)(38350700002)(38100700002)(41300700001)(83380400001)(86362001)(8936002)(66946007)(66556008)(6506007)(26005)(1076003)(186003)(6512007)(66476007)(8676002)(316002)(5660300002)(54906003)(6666004)(7416002)(52116002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/XEp/JM5DFIgx5I87qUYw7HDcLVbvw61pClxvMGfTle+oTPRZ1SP5XFcfp96?=
 =?us-ascii?Q?pgSI9E5f0GqFPzfv2Zcnk5CfvtY0tS5P86SU/jsk2sGTGfdYwlpMj6+zQG1o?=
 =?us-ascii?Q?ZPw8QPmVr/CcemG+GdnlDSbz8BielPy3g4oi/Db78CKD4RyUhDzXSB08R99a?=
 =?us-ascii?Q?edTavSlt5VCZJ9HvT1xt5UBYWwuuxx2j8Xj/yfIpkb2XLtW+XJYD5BA7+pWI?=
 =?us-ascii?Q?Q/ILc9ewJXl8P2cAMQbUjbKTDvwcUxVCnXPi1/bGecCq8aWjPG16vUGWn+mb?=
 =?us-ascii?Q?w64SJ+TZeqOTpVbBc1U2ijCeslbZ/qqNflPUrhlErj0raZJY2JO9+HCcV6R9?=
 =?us-ascii?Q?8ybIAwwvcEY8IdnF8jQ1zd3MTFFqQQ1vHl2Y9GzSe3Q5SHeHjS48UYBjLc+x?=
 =?us-ascii?Q?VwHVEk/vRlYKC0uu15w0H/5KkmzLJ2Z1NZdUNJSuT1a24+4dIWHwkXDPXwBu?=
 =?us-ascii?Q?2xnNkXcA1ivcYalloYJ3dxFJKDm4iOVuYTVXKDmqnWRnLnKsGnVuVRhp/9Pf?=
 =?us-ascii?Q?7DO2S6PoJDg9IYTuZxoFKGtl/dCqTIzJdJo6Xv/JPxBBiqTQEWXIcaosO7NG?=
 =?us-ascii?Q?OforU3vKThOq686z7M24FBcsRSorqx3mg0M2sk/gPADEDBlaXF7818TuZGEg?=
 =?us-ascii?Q?B7lsEbFRsk5OuZE6555lw7hoqIRnvprg/7gQQ3u9b+1uPlOkBEeXyXj2N14X?=
 =?us-ascii?Q?xuPjAelBPHZTrXKWPPBaK/FVtq2RrPuX0dj/DcyJ6ekHlFxFmUv5dH7RN3Ko?=
 =?us-ascii?Q?4FuWmnhpYSlYf+FmPiWFEs8NgVD7QfzeltPysr9aeklvOasJjj+1sKb4Zn2X?=
 =?us-ascii?Q?1Bd3Y5BRbQ2jyUEv5/N45H/sFlIYNNcxaQFdhFC2d+YyoTp72tHLzxKFhmPa?=
 =?us-ascii?Q?NPnnfBzq2HnIHbYAazOcGiENQbdpHdwCVCHIMIgFU81tPxeK4xu0YiYjpAWa?=
 =?us-ascii?Q?rhkI0c+SYhOCo4a0WgnzMqCnSWLqICZPjXt+0zs1Sdu1m1KkBW1m1c06p1qt?=
 =?us-ascii?Q?YuoBFKDEuTp1/7qUGB7ONWENJ3v3urNlNpc8YyuBkuBjgH8/LbilhD6OI3u5?=
 =?us-ascii?Q?X2l6R9KOk6RqJG04uyE+gaU1tBPF4FVqmIXSQTMcVDZUyQ2IjJNl13s+SbGd?=
 =?us-ascii?Q?5PbZbkrFGOTKQHWvoztR6tNuxeh+NNrOtZ1NX24B8ha/mvgeWpvEN5yvnsMF?=
 =?us-ascii?Q?kosg0uWyjV++3g/wuvV92hdWcEYEjeFcLX0svvTjC/1KCsJ/L1VO2G+GauvB?=
 =?us-ascii?Q?h4HncAC4AKwMUmmu1UB0ld/1OZnHO486PCwwq4hWEHGkwzMNpjVdgtnB+6Za?=
 =?us-ascii?Q?hOSyX/mVMdgzb742AZEJ2kA0girQCwnxUvzgnmRww7RF5jFcweSH95FzYWgG?=
 =?us-ascii?Q?pK7t9McrNQgwrkabmshtZLBANk5uAQCxqlz+YYsmErD+GAmfKwy+FAYveEqM?=
 =?us-ascii?Q?hWi7SwhiGi9YlpGen15EBgO9UYAMK3zS2rZZKTERR1lp3/XFjez1uyi1cnWy?=
 =?us-ascii?Q?GcQKs9LJ1IW6VJ4+z/4/EpZZWqpb42zUiWE1SRwoPKeZBt+HR0rB3P6aFPtd?=
 =?us-ascii?Q?0fKfFcfNRru+P1GPvEaWeha15buXBelQAFpPgcVM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc325da-5e9e-4e8e-d60b-08db31b2fbdb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:41:40.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsrtbQsbXNo+T0yuM61jUzpYxvHP4aKLbkP47Y5K8/dOtrsZpRO/b73PohsLKYWvqm4t727lcT3XRF39KczivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9271
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mcore_booted boot parameter which could simplify AMP clock
management. To i.MX93, there is CCM(clock control Module) to generate
clock root clock, anatop(analog PLL module) to generate PLL, and LPCG
(clock gating) to gate clocks to peripherals. As below:
anatop->ccm->lpcg->peripheral

Linux handles the clock management and the auxiliary core is under
control of Linux. Although there is per hardware domain control for LPCG
and CCM, auxiliary core normally only use LPCG hardware domain control
to avoid linux gate off the clk to peripherals and leave CCM ana anatop
to Linux.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-93.c | 8 +++++++-
 drivers/clk/imx/clk-imx93.c        | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
index 74a66b0203e4..81164bdcd6cc 100644
--- a/drivers/clk/imx/clk-composite-93.c
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -222,7 +222,7 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 					       mux_hw, &clk_mux_ro_ops, div_hw,
 					       &clk_divider_ro_ops, NULL, NULL, flags);
-	} else {
+	} else if (!mcore_booted) {
 		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 		if (!gate)
 			goto fail;
@@ -238,6 +238,12 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 					       &imx93_clk_composite_divider_ops, gate_hw,
 					       &imx93_clk_composite_gate_ops,
 					       flags | CLK_SET_RATE_NO_REPARENT);
+	} else {
+		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+					       mux_hw, &imx93_clk_composite_mux_ops, div_hw,
+					       &imx93_clk_composite_divider_ops, NULL,
+					       &imx93_clk_composite_gate_ops,
+					       flags | CLK_SET_RATE_NO_REPARENT);
 	}
 
 	if (IS_ERR(hw))
diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 8d0974db6bfd..bf2908be26a1 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -352,6 +352,8 @@ static struct platform_driver imx93_clk_driver = {
 	},
 };
 module_platform_driver(imx93_clk_driver);
+module_param(mcore_booted, bool, 0444);
+MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
 
 MODULE_DESCRIPTION("NXP i.MX93 clock driver");
 MODULE_LICENSE("GPL v2");
-- 
2.37.1

