Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED5C6D4133
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjDCJuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjDCJtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:49:42 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D8171A;
        Mon,  3 Apr 2023 02:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LY0MPHETIXy0Wqlh0eY329zKYouu//OPxzw5c/3aQ/oCWcLbChisXtlhafTdwEl/wJp6QKqOULghKU0bZBX4vJAFUMK+eoy2uxg+PMzoQE1TdqgzcAV64rdsIpQAVRrbjxMg1iuW2y8vRC+AM9Z4yE7CodWcw3Ims2WCv2WQSXA3G78H7J08dAO6cT8vViyF1Yno14LWpwPtBqRCvgDScBvsHStuhVz0+/dqS08taHQliogc2JFTMj8QPCeM40dsJiIrJKkk6dFa4mlzOH1SKV9DWsAU56kzi40qenAJVLnP0OzpHXlkukoxjEoEUiGCR94leBcOk3//8UC3aSwTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETuJofe8ZfN7VX4BGmq/281L79ouoSuTQv57kBHlu/s=;
 b=JHDZSl+pH+gVpXrnJ9j2KdSkR+MMNyG4S44FvIHBbyLqzK6h8iB95U7Y0p5DZdASwT0wGhuE2++krYzQV2C3G6cxWjcNjMAUMCYPhSYkw5ICeWf9SY140f+ZjrOpSz0/wGywHLtHuevvhScrfWfYx4q++dyR4d7c508KP0GKVNcwTNVudmaZfYOUKtT0bKJWNWJZvcDEwrwY8OPjert5BKLdW3Km1Dpn1sZoIHAO0xSdWUdoaGxrzeiYR0Gsn1w58nlwigQFSV7kuUboqcMdOE6lP2O/smJjWWcYAC+7sLZrIO+f9Fkb6DdSXm0zJkz8k08AL/tk9OFWW7+EX/Z+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETuJofe8ZfN7VX4BGmq/281L79ouoSuTQv57kBHlu/s=;
 b=VACzjIxFQpTVC//u3OA+84SDioGSpwwycQ2eOR9+MxdgPhSGYhchqsfEzFfEGgbLUh7qb+5YkO0eummQgByLxgd53NDJACiSSvLHjfyVvUe2DGSuczpf4wbHB++ZnMzLI0JC+V0VZ1FMG8utXGoDVcvthjZSBIjqcNzwSIFDmb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:48:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:48:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Ye Li <ye.li@nxp.com>
Subject: [PATCH V3 5/7] clk: imx: imx93: add mcore_booted module paratemter
Date:   Mon,  3 Apr 2023 17:52:58 +0800
Message-Id: <20230403095300.3386988-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
References: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 29330b61-2df6-4a7e-a2ba-08db34288f61
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56yjp0ESW+5EUfmczs5d8gU6pmtC4+dL5gR5yOM/DjnGxMJvH9rgMuyMqNLd+gLa3OF4EANkRjP0p4vHHymlJSCJqgOfiHg8hNwwNwomaZyjXOfU8gfEPBfNgQ1g8wItY/XYHapu4mJ5GQ0OkjKxlxNAwlW1g0unph/YZCtfOQoX1l54rXJUtMiu+SrQsNRljxslaEMMrtmuU4E5ld2/BAKYkhwY7mvWVNR9HMFV4pqAixDFzoVC6xUrUOO6HyV8ymlTtbsArQqJoinj/jRjg/G1juLbX3ev6ZHybF1A2jRgE54xNtpd7qrD0XJkUUavpFmPg0AXSjqNJtXcTemhKBzlUhUPqMKw+Ye7+hXCrqBkQ5rSreqsQL7fCU3m6cF3QhFIF0HyhnP+BCM8Dbgi0fEhEm61ioSgvUwMXd2i6o9HR7RZtZDI5iEQlmxKaVuTsGdI37tqAAyZWIyZ7KCFJiL7E3xSEXEVccxmeZvrfkiuF1f3uoXqzDCl63rtWYgl3hbRi61VN0Y0qTS00sP9MmcExdSdJ3Xn2lqXAWLGe+yxMJZV7p5Gbf/LbLpJ4scjAY/YBVh0Gw1QNtp6X3AhrVjuzINFlXRf8Lv+oY3mgckERzCuQluHTQl62/T0ez+/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(54906003)(316002)(478600001)(8936002)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KI2Kf2sIDw25CKovQ1V25JX/dyjg5Qj/3kWRYiy1yvmXLUP60G1fMRYa8Yxk?=
 =?us-ascii?Q?ohMXk/WKmG0vwLFLfcWyA7dPfHiL1VOJgByzjJ1zHEu727oZMedrXKYWUrWn?=
 =?us-ascii?Q?8/G85P6UGcpdV4IsZ8zyfgxH7oz5jLgaVW3s2mAgrnRD90VGPkKso5zkFjf2?=
 =?us-ascii?Q?75E7Nsbq2UwXJP99umc5A9XZ35R4+hm66oLnudR16rZDLRBhNZ2yxMilmrAJ?=
 =?us-ascii?Q?yvgrnmNbgCag+VIY2O7P2YiD9Gf1A1QPizFhu1sGhhSH3oKcl1FVq6/P0T9z?=
 =?us-ascii?Q?At2gkYmRpcH3R+SCLGFKSs8o19gbQi5/8LAXH5OkMIgY9wlYjWnBIL3MMRkw?=
 =?us-ascii?Q?Cqbr1NtNeROCDG+U7WwAFrTgVsNOlG00Kl1V4iV3b+owLalUzZJku1gcE7X2?=
 =?us-ascii?Q?duhOTzUCQqYnAFb/IAefOUp3S/tcENV7TA4cqkEDzxG8OfhA4SYRbVrgaYAK?=
 =?us-ascii?Q?TD5VmcJqtZpgnbUVuWpc8ELIde4xddMXk9w7os5MEm+uiFUXGF/+umpTdwxA?=
 =?us-ascii?Q?KOawyF5sD9LVEVUTcn6+mCGCJBynA0CWgD05lo5BT5Ip5OpV2owBZtzkVixW?=
 =?us-ascii?Q?kqeCNRTHYNO5nRDoQrR75iVeTStI23pbztvCCv6pbxxjkXwnpBfOw8cXjSQD?=
 =?us-ascii?Q?C2CeLvnDMkmA5OllaOlRXm9umnWyFT06Xwt7JlR/+/MKZsItfdntrg7aLO3x?=
 =?us-ascii?Q?/ljvTdBVRXDOKQ5rLurK2uX0p+LK/7CyamVSTiGNx76UFiW2PKR4vqxxbjhn?=
 =?us-ascii?Q?NmI0w6MbRSYtrkavbMZb34hIawQFxkZrr+J+25Sta1TiJTasAO7qHp/VKpJQ?=
 =?us-ascii?Q?6zxMRgIoxTl++NQheXhVPRliqR2+6qdZHCcKRnpmJgJsUEI+A4aZZNoMmUXP?=
 =?us-ascii?Q?Zsp1Tju05EEYF+ve6qZqofhyaEr8J88Obn6ARE8wZ3PO0EusuZMdVp41B5oR?=
 =?us-ascii?Q?eHhn9K6a43tSLyV210GjgOgwXuVzGwvyD50BNFKplfikj9YNlQgtuv3CfUTX?=
 =?us-ascii?Q?Gq+b+c1MKReZqhNGV/nBcfFhg6Yj3IYoaf+7OIFH+GJXZUaOqeqspXGOfoDR?=
 =?us-ascii?Q?nqEeNVmtXrX0dld619yW+z4OBvmfkS30J227Cb0zvMv6rDLULUVCkMuQ5Gva?=
 =?us-ascii?Q?Y1HCrYiPJjNVz9ogHLkdM6FFMxUQxr/z3beOeC7jHb0UTSDA0uBNrYfLqwFl?=
 =?us-ascii?Q?kF87oSwWmpCVTP1LV5S2DX8MFdp4fMoNBmGbrVzt+NVJJwvX3EuwW/N/974G?=
 =?us-ascii?Q?OMCwUgQ3+FpKlZkkW0maMTMlE1JbLvPxUN8y+/EOLXC64ZceYJ555tlWPJia?=
 =?us-ascii?Q?Yq1vNR9Kh1xtqb6HoxVsLpEhHaRU9M/phO2/jiFCgZWHmSsXi7fUXRWg+sS6?=
 =?us-ascii?Q?A4eYTHHGdqvbGxVcijee10tz7raAPd+CWEqtGklCQKHw8JrxKhSeAB9M6wfp?=
 =?us-ascii?Q?DzR+5GyycNgF5NsZCMlYC56OlmXL7l0VBy0lwuBrjlIE5fRUuyYbiq/UYjh/?=
 =?us-ascii?Q?OvGv8PdylwSoDBEkPlLxcBjGQ7CZMkTBUpBRqCUollNn8xdrn8DNQRgSXd0y?=
 =?us-ascii?Q?kmQ7QfOxA2PyRlVWErIeZxZ+VW1F+tKbXJEtLoqW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29330b61-2df6-4a7e-a2ba-08db34288f61
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:48:22.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uKUwxWTmkIPdjPpT2IXxEQ90fVv0nUf0tbCa17KHjlMo5VUKrcK5y8nQJDp2VUcIWk2PRyHKwklB4pDXXaO9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
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
index 8d0974db6bfd..de1ed1d8ba54 100644
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

