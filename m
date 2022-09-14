Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02495B8F95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiINULl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiINULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:11:21 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E803183F37;
        Wed, 14 Sep 2022 13:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfRXP+Y55/Mkj/oDDrqYfScbIxFxilIXI3tN4TctdmZc3rcDmN2/IPndrbun1kasSoZJ6wSEZe5E7vBlb3R3Q0sJao6p5U9o6iyiqBv7enfkccWqTBy/GKFlYoioTPmhYqrlUI+JxKe9nZEVC76bI8Aqd+M5eea9EX8Omw5sXr41bjFBG4s6zDmNCsBpPXN359RJ/TgAQcj+jg9D8HBPw/NjFH/BydHq2nhBwd0DdkIr2LZRiDvkt4TAxkXag+XQYxu4kVXJixEUz1LaIRe7+aCuV3WOVjoNCPbCcgb5NN32U724xmA6YYgNWe1+nAn8T1feKzT7fozbZDYezGdOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqkn8LG44Q/V72ZhEEpJeraRU5UcMcGuN2RyMk5ONNc=;
 b=L9Akn89aJgNdaSYqp3sM7UPuhENggwVCtEO2QSQst6bnhN3e+g0Vdmkcv0vlPTQoNoMymSR0eHV6R5abFeJqrlIVfBJoiKRkrYx3GHzHqCGndbdYWIEpWkqQ/WKzW88VmWSlkI7oJLe/4q3pOejkT5R21+FY6gbgZEKuv3LKNX3H+c6PQjlsN4MRU0hNbWmVVqBsS5AUiFqBYEoXoYq+RIGxl938s/h98V6xfjaa5QTHxrjQ4pODemaaFAzeLGAkxnnF9KPSjIObrl02XJTxYNbKs3JPrvSt5vzhZN/yVK1pZUWAMm/nFNkdXKL/7OUVmxJPPKv7x+d3CdAKYPyoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bqkn8LG44Q/V72ZhEEpJeraRU5UcMcGuN2RyMk5ONNc=;
 b=qdbEiyzR1d357gc10vmSZ5LGUoNVRd2Nni3BeFDJD4cctCW2p9L5PksdnnCmN23mnViXxktmAOYQHNpzSLr5F/31V/kkyzmh+JTQvaA5uj/+LUn4Pa15CJ06UrkokijHOeS+VwrfsDxDvKtGRiSedEU/cD9mRutfRXaKcciI6lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8781.eurprd04.prod.outlook.com (2603:10a6:102:20c::22)
 by DB9PR04MB8249.eurprd04.prod.outlook.com (2603:10a6:10:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 20:11:17 +0000
Received: from PAXPR04MB8781.eurprd04.prod.outlook.com
 ([fe80::49c6:8096:8082:35ce]) by PAXPR04MB8781.eurprd04.prod.outlook.com
 ([fe80::49c6:8096:8082:35ce%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 20:11:17 +0000
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
Date:   Wed, 14 Sep 2022 15:10:49 -0500
Message-Id: <20220914201049.3508104-2-han.xu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914201049.3508104-1-han.xu@nxp.com>
References: <20220914201049.3508104-1-han.xu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To PAXPR04MB8781.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8781:EE_|DB9PR04MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c1cf87-ac9c-43ef-53a3-08da968d485d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvltA3qc3QlumM1uU7s9NAIrWGfRx9OpVp5fGj7OsZ54T7UvAd8yjRe2XoYmxBTwCPQC3mitBlXvN8Myb6gBmH4gLlw57d1b+34opQP0/YANU6NUtQApMB6X7joILH90aLXtlldyICECFbOU4HgzfjnL0gOAGelEw3FhsyZsoxdcs4MMX218yMqD+tlN34Pu9/wqdztvg6h9Vc4gYAuI0M3uST5+26NbPDdQpJP2Fa2Yp/870CnwA1XsSEpX+rpihcRCmy/rrSHQN+Hmc/oIsAafbAgTTo0vt8P4UOFQfiT1E+GREgLG70iSLirkzMemW8rt8cJnkWcLjdOoxmg38diTTPTPoL2/8hZ+ZUMmLuidCYNL4lXjZn+iMNNKANXMHOtxzAuTnMeZTmgJTp4PGhwaMtWJvhX/d/6DuRFDQlWEHo74LSY2rOshUj0i/xkWyCM6mfh5V/WuUIu6TsOwkJfBvVkJSXeSmzgBv+hW9FSJvVlDBudwHIDL8D78gqFIL/RT8/n2KT432FUvR2R8Kov2XemZLMMWliQG3YZdasWaQ2bbHWcXnl0vbSQHv3QYsUXJem3bh7LlioRItBehTiv6qB29FqeQREiZOnJdKtjM58Q2xxlauTYK+Uh0y13nSOxAnvhI2NGCIpJ7WS5tcp2tJrAcJZ4lPSXvOP0GMWTTacpgMToLDOoLQxX+TTit5WByvX8cFsuFg1lDJHx5CnbZ7IrLnzJcQeZYOALX4s/Egra+8Ljli+NIlBu4HVF9cJQJKKqijsyJznQJIGR6CzK2Gb2BSxod6t1oWaUaFDkQrl1B7eVc2ZddFwzxyhVn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8781.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199015)(66946007)(921005)(52116002)(6506007)(110136005)(66476007)(86362001)(4326008)(6666004)(44832011)(5660300002)(66556008)(36756003)(41300700001)(2906002)(26005)(6512007)(7416002)(38100700002)(478600001)(316002)(8936002)(38350700002)(83380400001)(6486002)(8676002)(2616005)(186003)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Wz9L3j3Bx/ZisUPNmQBRxA4+HlKSc6wBx8cnzEdSANvbiNOYA7NKzWgGjdo?=
 =?us-ascii?Q?uLk6cmyCtTwFqT4E8sQDjS2og62apg5xwPcEVdDtIG2j/eWKupsiWayGwKit?=
 =?us-ascii?Q?9x+DcehuIKBNuoJ6fYB5Gpw8ubaIucuVZkCIJ3oV57NKgT+0IAlozHrAmRNV?=
 =?us-ascii?Q?B9oHaRMGA30GX0XtAzjRbRbnI8t1wF0KLTwdYyq/dnrqqoCXv41HM7dKVJpP?=
 =?us-ascii?Q?ePlzCQWEgxYO6R4Kb+kQ3BbWRrhoAJrYvOOq6ShppGVNSCWtvpE4AL3BjwN+?=
 =?us-ascii?Q?WUaTD6+YjuJZWv3GcfXDErBw3MjfY91295eFctIoGwC2HUOhZDWMF54tuFxZ?=
 =?us-ascii?Q?CRhsNRyFqIWdCL7GxuepyS8+Ga1gq5vjie3X1Npw+7erkVE/7ju99RPjJalr?=
 =?us-ascii?Q?MJSlLEDL0BDbt3EDu+J3d8cgzG9wvgB8uIef0EZ8KgzoqYsg/BvGum9Yvnyk?=
 =?us-ascii?Q?l2HjoXHJQagHBgnM+6aNmZdpjn0DiYNemajDuloOjaMY6DleXlU2RXSeCgFq?=
 =?us-ascii?Q?lJnDBkOpbbCkqoiazT4O3L41sB9H3e34qj6J2550hIn99aXIHMPBXvXpV5LE?=
 =?us-ascii?Q?SrmCw8d66qvbjMjnGuSVcdjuKsWIBK7HaCGoI+07w/HNebel5cer+r6LrngV?=
 =?us-ascii?Q?EgocmuIsBX/MO9O2PZkql+Z612LCHQH7EiShjXluH0/CJqmYmZZPia52Gi/f?=
 =?us-ascii?Q?XGGpKFXZhWEcGQbxhrbQscLFJBzmEZoA+p1uCh/EazMaZXMfhlKbwePOdngl?=
 =?us-ascii?Q?Zw6Bi7UzKvtnurhhWjHTnAmdelfjOBbe+rxxcH6IEA5QK8PcfQ+B4XYcBbT4?=
 =?us-ascii?Q?pVnZe0Qc029rzyLm0yZQul3SUaQRfdyYVN45Cnx8VnMIJYIuN8AxeMr9423H?=
 =?us-ascii?Q?xyec4dAg8g8lKr+xSh5BvsLHK7Dy31/RtFC8r3OKC4ycE/hAwLYrppZclz79?=
 =?us-ascii?Q?BW6zNv7xBpxdnP7GyDWvRAfeAESI89PiKSBimdB9t+9MOIxeefP6pOp3QR3s?=
 =?us-ascii?Q?Rl34dxs2MnI/V9GLy57Iy7fCoQJmEOScLIU2h4dDQ7zD3uPdlJDAeWN+QaCg?=
 =?us-ascii?Q?QlHnSgKZ4e5pn70SfNBPxdXFg4mUlj4Rg7Qpw3TkYwwySXjlGSX65PdlJGo7?=
 =?us-ascii?Q?oVsivtgfOViPtlVseaAd3XazAtDyEm93rBlWtqM+ECvn6e3z9jzCPH5uerS2?=
 =?us-ascii?Q?1BDkesMC0j06RXPnm5fFnYX+xUdJ7poIm14lz1/Ul8Qa8Exi6Uj4Z9hA8aFx?=
 =?us-ascii?Q?WSr4uSBzD91DN5RdTYJzEyBeVdQxbf+CnK25qWUJ7ObViM5DQPly95UnHqWm?=
 =?us-ascii?Q?CD4WAsuzQilllze4Kh1t3461eNHdMkmyxGEsi+yT5sHdBddGEThnca4uwwWc?=
 =?us-ascii?Q?GGAmuAluPhsUlJpwXdTyhIWR+3Jilz05qMKBYU6GMW9p9ghYTpqDgSUVZEdg?=
 =?us-ascii?Q?bZIb6XWO6JgWmuRXxm4rHoO/6wQdR1bz9X7DYN6Mp+U0b/C+cAMA++0qg0B0?=
 =?us-ascii?Q?ZOQvgB+j791d5N784OgtcmBQxPpfsHkCACzOsUmR6C1IDGtknSDXTC3SSIj9?=
 =?us-ascii?Q?g8XfsFvRdl3gpWa2KQg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c1cf87-ac9c-43ef-53a3-08da968d485d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8781.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 20:11:17.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfstvbWBJUqKHop0L34jgGD1nFkvW12bOBhXh0Y6IPz898LqE4jDXaIYpqOecu18
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

