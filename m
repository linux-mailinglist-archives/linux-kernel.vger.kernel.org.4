Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF706D411E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjDCJsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjDCJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:48:12 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DC111E94;
        Mon,  3 Apr 2023 02:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlfF9M64lYAA96fSPjWAiHv5BZV+bFj1M8sQYX0SEtNzJ5+qqMDwGzQ+VMZPzACeeAIoH+aoAslOUQ6TxiVHPVmSn9H9Rso/z306mglm/wM553PoaR9VuArT6n+1Fl1gHQBd7EOjU0BrpZMsa0sR6kn5bs5zX9pqOURifc9CjWFbzu5lVpai4Mj2OTTj9HzirwbpKjeRSQCtK1L6swrlBgSYp85Iu44OAtEvf3iIM+vXkNPIsEo8UGceJDdH49/AEHn66wg519I7UHxtrxxj1C/eQOXwRij1ZTF4tAZPCBBxgKbDf5z2pAwPzU5jbzTJk/SBgBb1ZpFefnkIUuZLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg+3/Aq/jV2NT/K5QnH1Qj2pzfpfqwF37aCElOaefts=;
 b=ZDquxnQTQVv0tAWuhaUwxjNeLESrSQjr3PdWM0QuZToisWIX7Rfc1oAY0Cly2u36j4/eWDe40/yrG2X7P0ADJeMbEwKuhh0gkaWPyUAypTIkluoZ+WZLf3/kKNTuhZpC7lQlaAsGDiCfxzq5fCgjxwGkCNoHwmURipE7Z5nYNik5jBFYLn70Yk4vHWSIOg8IxKu8UXuyg/oRPz1I3z2KXmjf08WziHVuCiMA1MHg67yiaE2OVVDCyCD3iQDCyopFNKBMJLY8++cT6jnOXCxv19DO5+Gfh0b0ASHv08IGs+BEgxyYfSxZ4jHkDnFvk72ueLB96P86OdtdpfOc07L2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg+3/Aq/jV2NT/K5QnH1Qj2pzfpfqwF37aCElOaefts=;
 b=EhCqiX5hZTgvWaKAWbD/T6qOnUDc5ouThSWZASVMtwoPaAg3bBkZ98n5ZYCe9a3P+b8h5MOHUsvd4IfxEwWqza+LeXuohE9+pYkKQzF2Qr39eyGibfapiPxy23Q5BQKl7T90NC6zzHmTs2MDAOO0CB4VvU4UwFPGCkex+3oWol0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:48:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:48:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V3 1/7] clk: imx: fracn-gppll: fix the rate table
Date:   Mon,  3 Apr 2023 17:52:54 +0800
Message-Id: <20230403095300.3386988-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 196156e4-af61-43fe-3ac4-08db342882f4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rc/Nzyd+5f5ldS6pbSTuC69aW5o51fmPvmkC/qwvE9oa3Btvl8+Vpt+yQXIeEl3ifgs9Pm5QELk2edGzi6VDvW/v7/eE7r9TxNqhD4u5pm7REXL4Iu9mHFPHpIYRHFRphf0jc5EEihKXiQqG3n4NqIsgaYnMEOnFubBPRqZK3CWVg8te+J2+RwR0yYkK/i4rl0M/QVratu3FwY0P2znDfriCkOhaI/AnuU8E04xLMkuwnSaAW5NiiuknzZusVMr2yQzRGEKKw0hrpfUroQVatexfxVy7w+EIkizM6TifnRJTA0goAABYqRuk1yj3YaGUaSPeq4GuIZTD0eQ2EZiLwmG+FEpxUlocH4NRdvFvqM5ZUPr7wEDyZWByIcvS2dS8QGKE4SIcfaU3yTPbHwW30HXkKooRGFRpk7OEWnzGfljOT6VyOg3f0mOmS+H0FqF4Hu+MlODjxV3Wv+eU8XvLz6mDH/xDKJBMgrXXrCyHvfpcunISZ/6/CnEiIZGoPAZeZHM0RQ7WRQijFVU6ZilN33nSI92LmDQy9QpzGcrM6qVgqEmU7KvxAbNAjVfoJ1lZNes3kEC8kxlMSy4Txxv7A/5yqJCtRZYvOJmsWOk+01TlWYCpIrtxlLl2Pzhx14dk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(54906003)(316002)(478600001)(8936002)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ckbd6hxQZN9olIXxTgbPxIxP1m4GSoWcyRaMTN6mbyQ6ZhYQonbhB2q0v0EY?=
 =?us-ascii?Q?TKPF4NX6wNX/Z1hc2RBrkJAyMXtufTiEVnH/ndiykS11usEqTvQHAn7FoAWN?=
 =?us-ascii?Q?AitnWNLAmYbQojstpafStwOu7FVFXionikmW+hO8N6AWAtvdfZtvGjSzeotj?=
 =?us-ascii?Q?bXtNxgKgALjjVcix4UhiHOgsetwTVL/Pgm1eWbT0BCFYZ90vj39KvBkHhmLJ?=
 =?us-ascii?Q?kZboRCgsmIknyPW5OgB4upJVUk2RkZi7rxUDppfMiupCcrmlQyBMRfYirDqN?=
 =?us-ascii?Q?HKLcn0w3K9IUvhbEupV+mKi512vvXsEr3G98CMgBAxsxCCDm3Mw/cvVklCO1?=
 =?us-ascii?Q?mphiB1xOybSJfGJBST8oteIVlARNyvGaNKl54w1NtaHTjrQWDrUm8ml3sDhj?=
 =?us-ascii?Q?kzwnSSL8dz2eKbIbKyztdQeyfr5hJK431V/JiRGEKYr5mwubJ9v4jaholYhi?=
 =?us-ascii?Q?KLay71T/PaEw2dXaPcGF8cOSJY33rVOfIVwbNF1aW+pzV+VdDgF3rEhcjfDr?=
 =?us-ascii?Q?s6CEUrKpX+UvJEc/TJKALEerx0SyUChaHx63aFyumqzIeys1CIC2s/JZt7Qv?=
 =?us-ascii?Q?TloRl6NYYjqMFAAjUjC/ek7Z8rDF52fdJF7iRVPUO3DLk/R6sVeF9Wye1n31?=
 =?us-ascii?Q?5byDdrqCdC3SN2YgOW2uFFyvcoKl86aJre2o9iZ4Ks2+KOR/s8ZqOKbmSPQK?=
 =?us-ascii?Q?XxbrQTU2FbNLR0qzjMaoz8eQb5HxGeRmqLd6M5eroVBxc7MerFbxqLvOQPH2?=
 =?us-ascii?Q?xwE+BbTJYLuvM9fqVYtjRkyZusk+Rmrws6fFy9eVLvn6GcuU2oAq80ZsvEYm?=
 =?us-ascii?Q?GFiC1SPRXqL8HGUqpVadGNukoBh9aTEtUnDwehYQrue/c7WYqObCtnAyKUlA?=
 =?us-ascii?Q?ZfUvJ57xVy75wfOBu7OORwvBJJh4j0FP8Cgtx9QzbfKl5NDwhSmfLdSj3tVv?=
 =?us-ascii?Q?7VZzcaxCH35fhuaycbdevW9u1LAeSF7A/28nHAzNBHl4EVLJ3Q50WrWKS+cb?=
 =?us-ascii?Q?/4zgt+wX+M0hGTELrtkxZj/kBPMEvfLhiFTUPQxvWv5djQLvrn57GX/g4/h0?=
 =?us-ascii?Q?AsiPHqVbvTxT7d4bLvz/O5xEq+5hhc91fYv+yN3kYR1K9wH+3JhnaMBp6mFZ?=
 =?us-ascii?Q?z++zngpplQivEnVmLxZ43O63fvqIitkuTGl6S1a16r9Zd7EyS+0Gtq3o4g+G?=
 =?us-ascii?Q?8wJ+7IWwjc+L6sU7r+dA2aaUuB/KCyJpbl2OyoXk3SjrMoiAhXidu19s1xal?=
 =?us-ascii?Q?vO21REDaoIUVYqRbNwxIEAuik0mHGlSx5nujcXUn88mLNqWgmNVIKz3GwbFW?=
 =?us-ascii?Q?8uwi96DiiXfgkxa7vQlmShm1b0aiordGHGco4YV7cZ1acQIEVUiSqTnFwmtI?=
 =?us-ascii?Q?fuUkQr8mPRH702WRhyNkufkKsaJoPhdC1ANqeLG1IJUrmSsghXALLy2efzAm?=
 =?us-ascii?Q?VZt7Qze0koCD4DVZ8sfxdjHgfvxxuReRo7e5uJRKez9FnFR0sWRLxjxbIJ+r?=
 =?us-ascii?Q?wPMDqib0OzyTzdnh4NgohAy8JRD6U0xk7uSd3QHTtBcSwFXUdI0h+kfKoPA4?=
 =?us-ascii?Q?vfRFoK8UqUJjxifu5fDsYLB1lUUTgZaWiodDse+G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196156e4-af61-43fe-3ac4-08db342882f4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:48:00.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7i7MZIgULkuigjUXZwwOrVsGLhwG8pQI8SoCj4zAijYId57wWvFKFAuZ/kCwcKyejRlelb3mqlV9m9P1rpkwew==
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

The Fvco should be range 2.4GHz to 5GHz, the original table voilate the
spec, so update the table to fix it.

Fixes: c196175acdd3 ("clk: imx: clk-fracn-gppll: Add more freq config for video pll")
Fixes: 044034efbeea ("clk: imx: clk-fracn-gppll: fix mfd value")
Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index a2aaa14fc1ae..ec50c41e2a4c 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -60,18 +60,20 @@ struct clk_fracn_gppll {
 };
 
 /*
- * Fvco = Fref * (MFI + MFN / MFD)
- * Fout = Fvco / (rdiv * odiv)
+ * Fvco = (Fref / rdiv) * (MFI + MFN / MFD)
+ * Fout = Fvco / odiv
+ * The (Fref / rdiv) should be in range 20MHz to 40MHz
+ * The Fvco should be in range 2.5Ghz to 5Ghz
  */
 static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
-	PLL_FRACN_GP(650000000U, 81, 0, 1, 0, 3),
+	PLL_FRACN_GP(650000000U, 162, 50, 100, 0, 6),
 	PLL_FRACN_GP(594000000U, 198, 0, 1, 0, 8),
-	PLL_FRACN_GP(560000000U, 70, 0, 1, 0, 3),
-	PLL_FRACN_GP(498000000U, 83, 0, 1, 0, 4),
+	PLL_FRACN_GP(560000000U, 140, 0, 1, 0, 6),
+	PLL_FRACN_GP(498000000U, 166, 0, 1, 0, 8),
 	PLL_FRACN_GP(484000000U, 121, 0, 1, 0, 6),
 	PLL_FRACN_GP(445333333U, 167, 0, 1, 0, 9),
-	PLL_FRACN_GP(400000000U, 50, 0, 1, 0, 3),
-	PLL_FRACN_GP(393216000U, 81, 92, 100, 0, 5)
+	PLL_FRACN_GP(400000000U, 200, 0, 1, 0, 12),
+	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10)
 };
 
 struct imx_fracn_gppll_clk imx_fracn_gppll = {
-- 
2.37.1

