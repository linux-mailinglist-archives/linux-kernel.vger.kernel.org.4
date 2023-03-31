Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6ED6D179F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCaGlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaGlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:41:36 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9051F11144;
        Thu, 30 Mar 2023 23:41:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOCZlYzXzo1CWZI2aypZbt23OWFQMmHjRzbjpV0KODxMgpVgiAFiMfyV2cCLE+CVn9RZbCLI4B1CwucIG2AtJeXDAudigv3mxV4Zi9EBEH+bLwYrVxA8HtXYoBkfA8/IETauso2v0ICgR6G+huZr6CetHwsPFNYtJ2pg1Q+KHyDiHKiABx/ca4R/Y7G9o0STk2iUZDjrpYlURFOMFW+lDid/Wbu4y9VlyWgM/lnjnkNxUmFyuVlrT+7bwBDoJ1O6304tp6538KzUhRAKAZgmK7aNRSKf72a9ScRVj6ZhT7SPW9bFgg9AqadG3+fVJCTYntnAqEhJwIgYAN7wIJYEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg+3/Aq/jV2NT/K5QnH1Qj2pzfpfqwF37aCElOaefts=;
 b=Zj3uZsIYVZXvPxsGGW2/3b+o82gmmeQ3g2LL58KKCxFuAP7GMwJm8UCZaoeX+cIQI+cydxUsHyl/GTaI7EQoRlU2dL8OZwYaXtTU1p6t5QlmmheU2pFSesZKye19N5BbQMKkwUb1yQ72AT+rYLqFWFlGH8NgNKJu+wy7Dw/EOOR4ly7QG29FvA8L9dpJykgvhBv2Ba/P3QIasI9zOS13Af9uQQwTxWNG2Mj9Hvyu7CNVu4iKmsjC1DUN/ONzrezw+LtbRMcuwlK771omt9FctqeTqQgEqgB5BfVuRWDwZYqu6jaN4r/h6PGg1qoRNSHW+9w7rDGkQh/xt1MM+VIi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg+3/Aq/jV2NT/K5QnH1Qj2pzfpfqwF37aCElOaefts=;
 b=UG+hUF5ePHvMKqovo+OLxbAQEAZHgp0gFOFNCJuRT7dlrF8QuxNYzVSZHeF2GRn/gHhGbErmD3SoiSwqzLtfoJn1p3zqfqEqJV2dYrW9qgWTxMxksmmh4KISEErw1MpCTGsSYC3vcGO+6zYL4gpvpRTjV+XrLtDU0YMsF47Spns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9271.eurprd04.prod.outlook.com (2603:10a6:102:2a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 06:41:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:41:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 1/6] clk: imx: fracn-gppll: fix the rate table
Date:   Fri, 31 Mar 2023 14:46:24 +0800
Message-Id: <20230331064629.2475338-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86db32c4-28cb-45a9-4e60-08db31b2f633
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9feYwrsbfYWs7iwUfVwF9GCnMeo9cOCdNYM+zS+W0jKuF+5z+3g6tanx9q9HmHB3jSYI2vZud47I/pv56SEYpOYQDQilu+X7wP57tkCOKx7iStfLxU1rJdy9//aTMA0Q7RNz9rwxYfkLD5LUBqzdKT+QxnDowJG8YIRKqHU5h7753Be0VSplYMU87StdwJwNVaXibF8j9z7wg4hSoXH/bi7Ei20hK2K4JaK0ngywYsDq3ao2+YiR3Lk74vZZ1CqkHadqq6d05gTDALYGtdbuobLErYlMNdi/h9IT77FtlBDm47o+mabSuKBVW+9HmrDB3P5RaSzi82/LJlS7XQApfeKJcAHeJ3LGFCDQOWqGDRTjMpTpgMWwOHn9dpSOSg5jBlMPhD1ARLxEWUlPzdaNVOzh3GdhWU1vnYHFADbolGnNAQSPW8HmYV3F/CwByWWV/0Hc8nIV0GJmIoTp5QcSdLj0QU0PGRv/6+cDKtRbGGaKIigNgooTw7BgCPhwNltj+5+DtI1+FiMy9rHLiFPpzJd7tMLmr+Z91rSH0xOPl0VhWWO+ZuQMFbTx7oGh/smDbQeO2TsoSUWBVJHIUs79gVLrjdytQDxueMTdX1MFdiXtare9dYufpY4RQPSIVHNd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2616005)(2906002)(4326008)(38350700002)(38100700002)(41300700001)(83380400001)(86362001)(8936002)(66946007)(66556008)(6506007)(26005)(1076003)(186003)(6512007)(66476007)(8676002)(316002)(5660300002)(54906003)(6666004)(7416002)(52116002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZhPVgkaBF6KTb28bY0Yl4tRSyeBE1J3ElsbTYeH9bXONa7Ubg7070iBwLYoj?=
 =?us-ascii?Q?4iXg4zDY7DddCOu71Ute3ELjtvttiNROpl1cMMAu4Xle2g3ALsmPz5kg1mdQ?=
 =?us-ascii?Q?WeOQXB0R+KmXx85Fv4I/I6U52GWFJ3+tFzDnpZYj4KdQFraJPpN9wXtkrUKG?=
 =?us-ascii?Q?JPgUhUev6xSOKbWTce10jZXhAVgFIRZRkeTQ2iSDF3wi2Hh6kyQtxA1515Cg?=
 =?us-ascii?Q?4BBODdxENFA1ZKAGKOs4XAX503qT9/qG0lHATFmuR+dgwYr0Pu8OUOAOAwgM?=
 =?us-ascii?Q?2Hob0cqekHrTB3NoFyAPHaOseZ18CTz7MHewvkWwl/OhfwbN/SNx4XFlL6ML?=
 =?us-ascii?Q?Bmq7jK2k9tY+kF3lFdm2roZkJk2Z6DWTpZDK9y9/8AI31fnIbkPXVyOWYiRY?=
 =?us-ascii?Q?n/dypmVSHMAKP3HA9XOCoPmvaXlF1tg9K05g238j+SQz+ehI2nxJX6u/NuzJ?=
 =?us-ascii?Q?6P2vV097uvDSxtiyplLZyVjmvLo1Fbxu8nyGG+cmfGpjPQDHR9zhAW0FEBll?=
 =?us-ascii?Q?GRinK4u49UcsYVi0sO0WiSObaty8EIOsHQEHY0MaG1qHkF/oN0cFi+xxnseH?=
 =?us-ascii?Q?EnU9CxFqSoJ3fbWPtxfaD+QkH40jPYNmCgH5+KEPAnGoJtrj0i0qeZsNXGfo?=
 =?us-ascii?Q?qquxRiuV6gT4lTC3VOYsCUjKVHwqXc3KGN31bZd3/xscfwcq9wD5dm9Zr4k3?=
 =?us-ascii?Q?TqTlTXM5/6PdYUC6vaUbxl8rtOlCYwspdZ7nKHk3qkxBf3JnTgFJNgqjmcEg?=
 =?us-ascii?Q?2RzNeHDNaOQ/yOq+nO4a8bZWBf5YbQZWWcchSxA+BRCdJPIKsoIAAE0GD1wh?=
 =?us-ascii?Q?R8DETi+/9PLl8PMezb5C7WTv0g0GccwN6s6GVGcwts+iLM/8k5BSzHKOlkci?=
 =?us-ascii?Q?bplSgjJNj4ngGZ91RjH9wl8Qm6/fpW4emycHKzwfGRc4WWwCqIli/tJjVjX0?=
 =?us-ascii?Q?V3jRTHxzHDLaJzmPugBRhkfPOuSFaSW2OGXDtcwVaeXLfKzcqjHg4DhabHCE?=
 =?us-ascii?Q?dgNDKWRB3+JiWz52wbw6S7ikU5A/6uJl9tbpv3uq1bq52vD1RxG3JTTmtHQm?=
 =?us-ascii?Q?KxB15Xw52eTMRw4P4SP3L1ZpDOqO7qdVpMe6XP31XecHSr7H6o/EQ5fZ+hHY?=
 =?us-ascii?Q?zTzf2QbCFQvTL79W66xM//fXx/1GTxH028SuA8KcLJ+RRDX+L1kiRQPawbyc?=
 =?us-ascii?Q?fR2AOxLcvQ3JOA+W6mdx3FvU4c0EvwqPHgTR48l4lzgAe1nPwBf44ynGIEdJ?=
 =?us-ascii?Q?0f9csbUKtFtYkupa3Bm6abYxIGIM8DnonHyQU4sGr2s8/WRBopeS20gtNo95?=
 =?us-ascii?Q?YCkiIAoAcAmg90dUVir+qOFnsDWgnkHo+1LPJ68VcZQKPFCqzw2bD4/YtWhR?=
 =?us-ascii?Q?bN0BK7QlkcJ6YJNF9xYERsuIt4sX8ZoIP0wRAQAZjAPrnrI/urKLwi1j9WOp?=
 =?us-ascii?Q?ub3EPBqFTYNzCAlVuV6z+xhJ4uhj1dOwPC6srQI3riTf7bHrfS7Cddlrpgr9?=
 =?us-ascii?Q?dwr8+9/PwjChGKV3JjDll8etrItdY2zi0TsT9zfoCf7bBE6nZEDzjyPzv3QW?=
 =?us-ascii?Q?d7s56IXVORDcg9rfXcP3+60F9LUaa7DdHMUCV5qM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86db32c4-28cb-45a9-4e60-08db31b2f633
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:41:31.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZB28Sy/wUvcqItdmKASYSnpD+Gf8WTXckxcIZPYu0rETbDst+6hxUq7TPVDMu/dgCsYGkM+BvvBAqtxd+sklA==
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

