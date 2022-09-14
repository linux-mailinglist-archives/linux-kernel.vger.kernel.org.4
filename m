Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE985B8F93
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiINULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiINULR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:11:17 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34FE1D8;
        Wed, 14 Sep 2022 13:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzxCwoSzEIiEi+lH3fSzGyezKLZfahq9U+jcWz7aqHgu0z2ZIkpKuBOm4HHNtajeG4QMKon/sbGhp47efedQEShxF8uMEvkS+gFA1nGZlbhbsgBwBK2/GuL50mwKy1GP5ORwZKC1egmivJ5tmQthwhSe7cyCF1RMx3fAcbYEqQltuGIenzuZdcaeJyI27rAd0qulUI0y/fG5Vtnbo5fNYcVzI04j769bhy5/C23QYw0Yj9lsls/q8NRZYVe2branv4vLmwIeWCQAoyV+s03o44qHPG1Koz71/Wbu1sTqEzQc45rgNQwctJ4aefuui1VWH7/hFEnWRCALutryIf7B7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqkn8LG44Q/V72ZhEEpJeraRU5UcMcGuN2RyMk5ONNc=;
 b=cOv9qbdC+laxMf/cZP93SlW5KFVwrUjjONK8jMnSvHcsKHcHaA5IbY+H0xhVBVIIfk4Q/JBjpnmXqaegMFsMUsfKflncA+gLrVnJcXrW7Q92wygZiU4nza4ne3nncA2nKLrC01wO6R/X/6yNwE4kSiXCMWpGJpWxHHF5x2rp5XACkcBo5juxh3bEQf37+HHy9fuAc9bMzD04WnjCoQ4Jof/A6D9VrXyUo/l6CBxCqfUwcqRMyAag36ftkY32xiRTBbb7m1KlYaY78UUKDTFBnxGPfLxBWmWzISqysTmdjaMLEqXsxScO8KbMW7MoOHbhw5BETD/uv8T2lIS72G2V0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bqkn8LG44Q/V72ZhEEpJeraRU5UcMcGuN2RyMk5ONNc=;
 b=I200NKCSaNLmMsH9EWKqA09DnnDLcijmNbmusfyq2U50BpAcQtqGk44qD301Op5w1wehQipqt/dOOEluBaK7R/ILHGZ4LLJFYOhPA2Us+Q7FZQ8Qp7ogAvF7ejQOuhXmlQo623HGTOYD4HfAyTlqirQmfB+mxix2zTtk70MAXLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8781.eurprd04.prod.outlook.com (2603:10a6:102:20c::22)
 by DB9PR04MB8249.eurprd04.prod.outlook.com (2603:10a6:10:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 20:11:13 +0000
Received: from PAXPR04MB8781.eurprd04.prod.outlook.com
 ([fe80::49c6:8096:8082:35ce]) by PAXPR04MB8781.eurprd04.prod.outlook.com
 ([fe80::49c6:8096:8082:35ce%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 20:11:13 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org (open list:NXP i.MX CLOCK DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        han.xu@nxp.com
Subject: [PATCH] clk: imx: imx6sx: remove the SET_RATE_PARENT flag for QSPI clocks
Date:   Wed, 14 Sep 2022 15:10:48 -0500
Message-Id: <20220914201049.3508104-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To PAXPR04MB8781.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8781:EE_|DB9PR04MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a2cea4-6678-44c0-f957-08da968d45e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KY2O3nsmz0KDt27/T+BQD3dacjdYmSzQrILeyqrFI1pGjpGhkEabIX3aqSp7AFWjHSLcewTTtoeeZQXXskoy9soYOFcaoeG4Ccf8vRUMA6Eptiypn9eGV9tJ0ywkpF9qewiVzMC6SlCJrWhpmfIuRdBs9j0lEJCDLGlWIiU9Th9ZDyaTzsJMtDkzXvD6KQCVux/gh/0Lq6gPTRT3UVWe/KN7xMHis3WZ/9xOc6nit+5d/s0Hg3WBmsYEwySS8I0F1XU5l1yztcQDLLzJ2MKe9nB0Fd46xSam7YGRJgKnxvz23d8jyZTr/WRzEmdVgFh22w86Q7qFXA0VsawAdMelnoN0kSH+KQ48XzWwcI6qnanZua1w7zQ301RAf3D8eEkIm9vv/jkbK1PeFnf66zIzjnLQCC4hx2pJYi1+p8I+IaMUBCchNojSvC+r+KSX93CZBIqj9Y/srTwqo9TqBHJ9jQ2AHiRKJwY/AcbAAU1tzhG8NZNyU2gePbirfas6PQz/S//TWUFq7CiktZEkPs0nkwlMAeqqWM+DL5Jw9Tew8upYn7UnK8iYYWCS1MurEPl4qqfQwOWz0EPjIgfjaJCqc9z55QCR+YtbHnF2J0AeoxzXXG57gD9WkPObGREffv4sdBEezmx4e94r4Aqkoa220GqgckmHSw5qcrHX6x3YdPyc/5dGRRJ5b0X5q5nO7kvXID/b6K1L1AXFQo8z8BLNg16Eqwh41bnx4SuwVPBkATGfZ6FiFqfJvOGwLIhEW0xgQtQmF+GakP7CfRyf4JfcTZJ0eLv6dbcr/YcKLXbnyFRdhZiMmQtnu7mMWtMHECTJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8781.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199015)(66946007)(921005)(52116002)(6506007)(110136005)(66476007)(86362001)(4326008)(6666004)(44832011)(5660300002)(66556008)(36756003)(41300700001)(2906002)(26005)(6512007)(7416002)(38100700002)(478600001)(316002)(8936002)(38350700002)(83380400001)(6486002)(8676002)(2616005)(186003)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n5OITiVF4TEi4Nn9vXFuhRYFUWbF6kCbfn9Su+6ues+KyoQgBth6d4nrrcms?=
 =?us-ascii?Q?SQePAktxmbelXtTNt9uun/WQzbrV9IM36CCIiLzhftNmrf8e+2zbT27cn5gh?=
 =?us-ascii?Q?5YrpaTNmTjwWnv9NaMgQsPqHC4JoULqULgxwZ8cRo73uq4Yqzdtphu8rCXU9?=
 =?us-ascii?Q?vkpI3pAJmrU+DZd0H1JnK6PPlGfMuefS6XOl/mGdGY+BlsdWhJbnuIWDRfs9?=
 =?us-ascii?Q?NO4nAbX/9/GLgW7xzVpiUG4EJq947i+lvrkVfXNv2W+VY1nEbOIi7rh+OiNA?=
 =?us-ascii?Q?Hh0GKDTqpiLiSF4TasiD6ySKncgSCpz4WKZs+B0PqrI1Uto8liB3xGRFM2/O?=
 =?us-ascii?Q?dG21m+ZGOYP17h9jgZ2hsGIuAoFJedSh36CZXHZTrT6cQf879OWgjvXfU0tn?=
 =?us-ascii?Q?byTHDj1Psg4wvT7UQpamFA5hD2Y4lG636+nUCcDWfU+pdHVUIQ7nAQdRzRsg?=
 =?us-ascii?Q?xnlJtnKwv3x4Y7qd3vwo22f4eaIQeiOJscjIjucAfE/OALHCdWT27uHOlFfb?=
 =?us-ascii?Q?4MbQcCc0Sn7g8twjLbSM1BEi/bhB9lmB8emQV496fR0w4T3EJO9U9jz8TgXN?=
 =?us-ascii?Q?56Mq3+NEWz+Akdn2D7f6g6Eu8bbZkPbMJIIdImS/S5FMs+7EtLBfI48zX2y+?=
 =?us-ascii?Q?ORERSOjMRbyHtu8oA7UoQiq4wbeK/yCO1GsV33u9q3ZFncU90IaEkPUCJzvT?=
 =?us-ascii?Q?380QaY+5OSAJ3OO/0O5g42n/QjUhk368XzIgny8wxvAjlVtxBElHiiRfhNae?=
 =?us-ascii?Q?HhEk/4JBRGUw0A7+/XaakObFe6phIY+of6zvvbNaMYUtRoGtzzpZ2Yusgl5G?=
 =?us-ascii?Q?je07qn0mKJoY719ptMOGnc2IuMkh0cuM8DEWhOxAeiJsD4mcOcI173tPvV4b?=
 =?us-ascii?Q?2O62sr5gpsmLY8u70pongQOiQIDqbtAXojSZL2ixkQ1vMgGsIuEjGuMufYS6?=
 =?us-ascii?Q?XQsQ/FqxV+KlbBRzhX8PQxwxb5PpzzZjpo23yLixjZHEdEzR+WOFmefx0fnq?=
 =?us-ascii?Q?+INAKF543hTHjIiR5Khzds2cYI8VqAnv+yKaQlHOgnYb0naI27QZ/qFurdB5?=
 =?us-ascii?Q?CDH1/+24xOQkh7IVWlMqCKUkvVMeh1tKrA7O+iwa06xtVvzEVNf0iVGMxoJj?=
 =?us-ascii?Q?Eu273kFJPvNehB2rE3bISUBQFzy8J5RiSCKDpVse4bP7Bws3pcGCVoNNnrK9?=
 =?us-ascii?Q?cQSqJupcLhesF1UudAKjF9pEDK9gBM05Esc3nSY6xkO0RQ5zcrvXk1fnRbQ7?=
 =?us-ascii?Q?9wxqeJpDILQqpXLPCwwQ2zwCzZHq5oDb0oD4gB185Ut/yTr25hxg711E7FJR?=
 =?us-ascii?Q?sg7jKUkNFumVkiybiCxtgDPENFYzZlLVT7m2AhPJBR+aRnWgnkMS9yqETOxY?=
 =?us-ascii?Q?kV9/kJGvDk0DcH3TUc18P2w6e/w6vo+wguT5OoD04yK/4HjsSd31GjcDV+Ga?=
 =?us-ascii?Q?Fp2fwM+PhlE1nL3lzQ9/9XQPhvDBJ8XQ9DzMN7z3ZPJFLho8VlYa7GNlHNYv?=
 =?us-ascii?Q?/ck61RqYCY3R2NFJkKZYaJF3D8SwQ8J5+39If7FogqYl7kXPhOGDgRyPQfyL?=
 =?us-ascii?Q?lF01JxWaWDOccHodcIE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a2cea4-6678-44c0-f957-08da968d45e9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8781.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 20:11:13.5581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvEXsYWqZ+m9kEwwDNgTktQrtJDUEtL4aDkQBwPV26yGkWYCSdMxnOu1J8IfYOjU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no dedicate parent clock for QSPI so SET_RATE_PARENT flag
should not be used. For instance, the default parent clock for QSPI is
pll2_bus, which is also the parent clock for quite a few modules, such
as MMDC, once GPMI NAND set clock rate for EDO5 mode can cause system
hang due to pll2_bus rate changed.

Fixes: f1541e15e38e ("clk: imx6sx: Switch to clk_hw based API")
Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 2301d8fb8c76..1e53e366cde7 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -324,13 +324,13 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	hws[IMX6SX_CLK_SSI3_SEL]           = imx_clk_hw_mux("ssi3_sel",         base + 0x1c,  14,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
 	hws[IMX6SX_CLK_SSI2_SEL]           = imx_clk_hw_mux("ssi2_sel",         base + 0x1c,  12,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
 	hws[IMX6SX_CLK_SSI1_SEL]           = imx_clk_hw_mux("ssi1_sel",         base + 0x1c,  10,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
-	hws[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_hw_mux_flags("qspi1_sel", base + 0x1c,  7, 3, qspi1_sels, ARRAY_SIZE(qspi1_sels), CLK_SET_RATE_PARENT);
+	hws[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_hw_mux("qspi1_sel",        base + 0x1c,  7,      3,      qspi1_sels,        ARRAY_SIZE(qspi1_sels);
 	hws[IMX6SX_CLK_PERCLK_SEL]         = imx_clk_hw_mux("perclk_sel",       base + 0x1c,  6,      1,      perclk_sels,       ARRAY_SIZE(perclk_sels));
 	hws[IMX6SX_CLK_VID_SEL]            = imx_clk_hw_mux("vid_sel",          base + 0x20,  21,     3,      vid_sels,          ARRAY_SIZE(vid_sels));
 	hws[IMX6SX_CLK_ESAI_SEL]           = imx_clk_hw_mux("esai_sel",         base + 0x20,  19,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
 	hws[IMX6SX_CLK_CAN_SEL]            = imx_clk_hw_mux("can_sel",          base + 0x20,  8,      2,      can_sels,          ARRAY_SIZE(can_sels));
 	hws[IMX6SX_CLK_UART_SEL]           = imx_clk_hw_mux("uart_sel",         base + 0x24,  6,      1,      uart_sels,         ARRAY_SIZE(uart_sels));
-	hws[IMX6SX_CLK_QSPI2_SEL]          = imx_clk_hw_mux_flags("qspi2_sel", base + 0x2c, 15, 3, qspi2_sels, ARRAY_SIZE(qspi2_sels), CLK_SET_RATE_PARENT);
+	hws[IMX6SX_CLK_QSPI2_SEL]          = imx_clk_hw_mux("qspi2_sel",        base + 0x2c,  15,     3,      qspi2_sels,        ARRAY_SIZE(qspi2_sels);
 	hws[IMX6SX_CLK_SPDIF_SEL]          = imx_clk_hw_mux("spdif_sel",        base + 0x30,  20,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
 	hws[IMX6SX_CLK_AUDIO_SEL]          = imx_clk_hw_mux("audio_sel",        base + 0x30,  7,      2,      audio_sels,        ARRAY_SIZE(audio_sels));
 	hws[IMX6SX_CLK_ENET_PRE_SEL]       = imx_clk_hw_mux("enet_pre_sel",     base + 0x34,  15,     3,      enet_pre_sels,     ARRAY_SIZE(enet_pre_sels));
-- 
2.25.1

