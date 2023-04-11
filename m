Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C906DCFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDKDD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjDKDDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:03:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F972D54;
        Mon, 10 Apr 2023 20:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMlCfJaS35IKwfSOpT0rVYPBX/rpI1IxOhDb5zqoJvvaCS48OB/ri93lBw1rhHWSfQZv/H2XAE+zvMizNNzUEvRCC747FGpR8AqHVLi8hWZAZD9BsM/qwEQnswcV6O1+3TWj2xh8IO2G2nUTr95bl5IsE58hXbWfCt8nqZDiBfcdEcnjRDfgq+KcYdSeKaYVoj9ZTgsYN4K271RvBn1C7X42No4UOjIqerY07a+ULE5zcQxiOfo+BUgnr8jPVkRszTAPqvzR4WlsBblx0ZV7GMrAn+QDulxA8QS6tOEreWK3hcW7tE8zxD0PWfHQoelbRlquylRiQmblYentD2yknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE72B9UHoMBjPBX8mbA63s8mwwWuc25N21KsFWPNBLU=;
 b=RWL1WmP6wunG5uJ1MfTxpVuWr37oEq9tou4LulNzPfbnEL6S4k9HZaQMQgqMEUHbwwB3a6E8EgEBqqM5na3eZj/GCpAj4SIdPyQxYLYEl9vqnwyMNeLngnFVjnFv3ONScwcElvDyHE/q947Q9LMljlaC77w8Ml8n4yeaaI2MXAJGMpqafD8C0WSKaPjagSWrudTYBTf2rfVX47AvxZ78bro4XWIbp/mITd8d0WK2japZyBrVjKS00/jv0kzoMUSAd+UNUdr1MNLY9C7rJ1Tf76in3RZTiH1y1smgBlzdbLmHbnAo9sG+LJwxl2lpEjdonsChl3qZq7Obd7jlQbiUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE72B9UHoMBjPBX8mbA63s8mwwWuc25N21KsFWPNBLU=;
 b=XjwSmLxjEKWv1Pg9N4CD0pyhUIt63Yk9a6kLWewrLuq8XUwxNx5rf0atX1QpaemM2Ms2ioeG4hCp2YdD4Ul2aTsvnEENnsRboFGnKAzGKYJfsyb4gAZ5iuXLPwH2uViTliCiKVkpOwgz+ieADpg7sMofphhHd/O79CuZt9OCscU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9278.eurprd04.prod.outlook.com (2603:10a6:102:2b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 03:03:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 03:03:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] clk: imx: imx6sx: spdif clock rate is too high for asrc
Date:   Tue, 11 Apr 2023 11:08:01 +0800
Message-Id: <20230411030801.2964482-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: 39fb5c0f-c415-40e8-158c-08db3a3941fe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cx3GHFdXCiSztwneoBPoWctTinIeb1Rk/pqv5FFlN0MjFROBUr7ChbOiwMfWcdxZ3ZU/LZRpWAQPQCJuHnfplf2GY1mp0W45CCkbfkiGoMgi/fg/pVYCHM8jXYCxa2ngeW5lG9k+JGYmMQ3Fzy0JLwW9J43pMbVbynb6rhqI7jKgV8Eqkj1oTP1KWIG6Fl/h8uwgi0kgtUzuJ4amRETkPNGEU7CjXzr0dH251/8dS6LYYe8VpOciYR0BJ/Fw/Tv9ILWyiPebf6hPdXiPGHBZqoWGoS/e8Gk919rG0y8uNnNXnjqQw/Q3+6mDUVUJw9yIibXt4xjXSCCjmQGXRcG9x3D17CcOPpevv41Hif4zLTBFGqaVkEbckYADOindjq1yKhazZrnHRpc0DnCMNh1rH/vTyzMT5y2V+bq+z6rrSolAxHAsiay4oVgLT0xqHw/432jbpUI+irjCUHsaePg2pCjca891cT7/VYsYPrGIPbqvbhvDatpe9v6G6RVtgMay02u71KDn2WQF3HsZjVpeL63EKXaBPfNBfpZd0qkmpE9oe4Z7eqi76v9bWV9xaP3DHdsnykwUNLj8D1bTg+GfmdKXqpwKvWh2ThP+WvtoE7pBgVK+GxEzNO9DiqJMTc02lEx7hLZgSbuxXCoW30yUgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(52116002)(8936002)(66899021)(7416002)(6486002)(5660300002)(86362001)(4326008)(8676002)(66556008)(66476007)(66946007)(478600001)(38350700002)(38100700002)(316002)(54906003)(83380400001)(2906002)(1076003)(6506007)(6512007)(186003)(2616005)(41300700001)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SlImfBVrrtxGQaFL2NDpmcjdDS1AW0rX80kUzBHHBm81PTvSNoHckRh2Eot/?=
 =?us-ascii?Q?FlaPyZnl+BLEyv6jFoNkDKy2o2DQMYg3bfNMHvuEVsK33J6ddli4nsFIEsyW?=
 =?us-ascii?Q?UKLB69HElaAjNDaCEulmsljsxNrvotb+3WDU5Mqj/fEDkE5feUgEpjZaLvID?=
 =?us-ascii?Q?BJS/YZJf/KKwip+vnuAbdqbwd0Zpobim7ToVv4noDJt/GB1DU7zpBWe8fVtZ?=
 =?us-ascii?Q?rS1Oy4OxclyyDW7oKb9RqsONQs7jODTc0SmUJ+W5zxuT8E4EYSodHtnC10km?=
 =?us-ascii?Q?pFUnOEiEeJAux8CuiyPD26DTbXgKhiOi1UKNOWJ8Ykun5xMWIc/aLpkFY5Sh?=
 =?us-ascii?Q?S5+7pvyTB/5luN/Y/afhidhF2eqtPes+4X6HLZun6W5sKArovkrlctMmnz50?=
 =?us-ascii?Q?05XBe5VL1naASHO09P0nPv4d08DLbfMCzo299DGFcGuP6lfaUhVAOdsSOLbP?=
 =?us-ascii?Q?lI3hWCAtMJwRVv8Kj83GNU3HEEijinZnsrtdykImT9Dx/VgkCYwPb1+xGinG?=
 =?us-ascii?Q?v1xmxQpGHn3F7vTR38FisUzVCesF8XZQEFslDbpMvryLR5Ehk4hCGQVHUPs5?=
 =?us-ascii?Q?/a5HbYm8Zr/81cFd39yUtEmjKR+rpCQ14Z0JpKRtScuowvNRmjx792ycSbWi?=
 =?us-ascii?Q?nN1i9EwCEYJvQ3QMsDzQCN+ztVH2Aj4yRmv3C2IkyQQEiWbFeKkSlxAlZjxW?=
 =?us-ascii?Q?4Por7+tMRVzl29gjU4XShDHK9MQ8Q76mgarNE1AuQHKksrJghFtkvkZKDTeC?=
 =?us-ascii?Q?YbQn24vnN109p89PjqEoCxNm3FQheGW0j1IBikC7i8u9VVrcesFQ69DreVTL?=
 =?us-ascii?Q?09VifZG8Xr9wGXuVZsyPIH8riCmZXAARiJEmPYKYm7GYIssmu35gBq734ZhL?=
 =?us-ascii?Q?SU5zuVZk+X5XjzKNo+pWnAXfcMQlTvcOpE6eG66oFg+KfPS+dtx1MGGsjWIr?=
 =?us-ascii?Q?5LYVsRdNXglXoEPcCa3cSNL222Ro+McUOyDu/NbehGjgQYRNsKhb5/GEEvm/?=
 =?us-ascii?Q?jp0HpIzKOl13f9qPe+QD+Lo07JiWV2njCUbftvqvIm3yR1kBO6E/kVQUOcrs?=
 =?us-ascii?Q?+yQnSdhTi7mwmNGW8HD3n34mw67DpCZfY3ssxrJRud1QbH5uDHr1dIQQduYe?=
 =?us-ascii?Q?P1bGWnzdgvegP+TVDxVXReefQrt0mghv7T0H3NQCp0P5DPHTYkjg4mDlzT3n?=
 =?us-ascii?Q?eHmXfYFwStEiytBHmQyB6jgmJvec09fjkYREDVF0pEopwfQimXkZDY9oXsMU?=
 =?us-ascii?Q?YH982ckuItCCni5HWLCcZBV1n1sdsnwqK4mdsLhmqdRZ4oiAdpJ/REo99+FW?=
 =?us-ascii?Q?QgtYSTPlrQGs2wuOD+Tr86s/2yQVGJ8HH7GLi4LHeRiOFTw8ylMJVYZQYqbQ?=
 =?us-ascii?Q?Nm5qtpfkLQaaD1dQ9PEhMYi8tPGdCZ8HgQePoHcYva8HktYjBK/OzqLITXBx?=
 =?us-ascii?Q?W+UriHZm+y/j/U4GW3k1gj1ow71x2S6q/wG8e07Cca3sCKE9CRhQglXv17na?=
 =?us-ascii?Q?J3rJsyA6MWFzA703+pm7ruok5637nm7PmrU2/KJyj+hY9vOU+HGgeQjMDGd4?=
 =?us-ascii?Q?B4W9sx4T39usK6BbPEZfijpzjmrI9b826ph60P3b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fb5c0f-c415-40e8-158c-08db3a3941fe
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 03:03:00.0424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gnhqb3pXjMhIXT8AMxR+1erPqGAtkyNloIgtbyRl3qVFJMmQTk525Fp2oUxZxC0XELdChy/N+3wEejj8z4IEeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9278
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

spdif clock is one of the asrc clock source, which is used
for ideal ratio mode. when set to 98.304MHz, it cause the
divider of asrc input clock and output clock exceed the
maximum value, and asrc driver saturate the value to maximum
value, which will cause the ASRC's performance very bad.
So we need to set spdif clock to a proper rate. which make asrc
divider not exceed maximum value, at least one of divider not
exceed maximum value.
The target is spdif clock rate / output(or input) sample rate
less than 1024(which is maximum divider).

Fixes: d55135689019 ("ARM: imx: add clock driver for imx6sx")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Update Fixes tag
V2:
 Add Fixes tag

 drivers/clk/imx/clk-imx6sx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 7cf86707bc39..3face052527d 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -520,7 +520,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clk_set_rate(hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk, 393216000);
 
 	clk_set_parent(hws[IMX6SX_CLK_SPDIF_SEL]->clk, hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk);
-	clk_set_rate(hws[IMX6SX_CLK_SPDIF_PODF]->clk, 98304000);
+	clk_set_rate(hws[IMX6SX_CLK_SPDIF_PODF]->clk, 24576000);
 
 	clk_set_parent(hws[IMX6SX_CLK_AUDIO_SEL]->clk, hws[IMX6SX_CLK_PLL3_USB_OTG]->clk);
 	clk_set_rate(hws[IMX6SX_CLK_AUDIO_PODF]->clk, 24000000);
-- 
2.37.1

