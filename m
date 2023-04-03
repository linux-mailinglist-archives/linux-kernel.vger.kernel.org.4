Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3F6D3EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjDCIQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDCIQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:16:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FB76B7;
        Mon,  3 Apr 2023 01:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5WVBrgi6wCLaxc3zJioZGQSMy82+mE0IjxXewnpGJrBM6RrBLMn1tbWYYG/4wmt3miIqoRkWyA32O28vqFWd2vbIKC/0GHf+dw1iNv/c7ma0gGKi0Dhv6gqnP+eUwi1P1V+RHTggWYCxgMYBy9eG+1tcZ2qj1unmL40yHXegjTFeudaAIs/InRyMLOLVGGG1+ZvbZSJU7aYG7djfzKQNsZbhSjtV/jhthhaSJ/yKHRSR0uWlvUa35eez8jxDnrot8RhveN0DdxP5OY/GX8gdJkc190Fk9/QWsIM00SsL/8VNDCTcEDF6hWTTp6IDhARuv6bxV+ivWp2l1Z34a/WhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KciKSwftmbsOf26wG1Zc6yOal9BRgEfsKcqPjjJw68=;
 b=KmZ3l/1F8Fk7m3z3w30pn1UFdbDJk7K2DpIGYZYZhwFyCp2gbfO3Fy++JLoAKaNDfzvvBWLOX6SkUO/1BMXJdGpFIAjN3+2xZM9TN/UmZIowF58aQkeO2uX6UazPYVpstjvBUnc5yhcZtWV6O0n8aHVSBXCi6dfLlMAkpRCBCAp5ATr1JRi+WHc5FkbNlHKajYJeALBbaN9/G2aweZCl0cPtKrxrC8nZ4w2eYSsZXcPQjo6fZlp7LiRWsXP4BsaGhS49N5gJYjvoloT4AGtiE6dQfMSn/V+0l0ZUZd/scwf1QL2kBeVye2EV+IuQcYWTBcAeUP2QB/JH3s/N+aUZ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KciKSwftmbsOf26wG1Zc6yOal9BRgEfsKcqPjjJw68=;
 b=NkGGvEJ/h9pNPQkPQOn8VvNK1rc/QiVDAZFSv09lXN3MWOFl+dv8+z82qTkjMo3qbNaV5N/FGnS2by5018V05D3xQkEIDc1OluOg/kTGG4pc2ZDGfxTFVBhBw/Ol/JXTi0Iqm1hgJBKPoRN5HqC+bm/RkFAT9waN96+caVJgdOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9381.eurprd04.prod.outlook.com (2603:10a6:20b:4db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Mon, 3 Apr
 2023 08:16:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:16:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] clk: imx: imx6sx: spdif clock rate is too high for asrc
Date:   Mon,  3 Apr 2023 16:21:38 +0800
Message-Id: <20230403082138.3195452-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9381:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b9379a-ddcd-472a-cf78-08db341bbcde
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0bzg5AZ4mkK2YynX+UsHjl1TKuN36WYO9Mk6oCnMT6JPs4EhtEBRKSRiESKfsx/JY7S7nncECDe56pc6JoP7VKTTuGhxrtmgLJyAwTMfKhPvPcqz/PB/eBVp4QYaG5rFVwI62VrgcoZDP76pn55ugHqmLmAQ0megxNWUIPg5lC308hzJC8pC6nxyMCOZDyd+X9k18aMLw1erwSCZcJjviw/G0AAp12tHwjrmkhnNu/pUL5OYRVAWg8docf8f3DNEi2oVZqW+8D+nKGYfNwKTZIikDPZn2X6TXBklmd9pMsmZUg+q7Gxj+nT08N3RYc92qpTco0ixFlyEFSgtUr2d3UiSBVkmdPkULTA8WYvds9eHB8Eca0+Tmh5gUKH/OhXYXWDC96nudUzT93hNoYrLsYWK2rjlGdku6/DjFghIePrgQz31G11PnxiGVI1D6NP+89we/bLcLjMCwUfHY9tWmIBL9TG3QRl85l0cTgDqUkj23yI89F6Hh9Jkm7g1crMJOT19jGmQlqwJgvMFyOqJA/QXIuNn63yMNW8lhrNKiIBEgMEncnIg97DusiyInSfOLPz9fD4WpX9wict7DkIQcrSHBTr5JwX6GfC2ynsfh+ky0bisgot+278lO5mUuHj0cEQtMitEgTgdSXslZJHRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(86362001)(2906002)(66899021)(52116002)(2616005)(83380400001)(186003)(26005)(1076003)(6486002)(6512007)(6506007)(8676002)(4326008)(478600001)(66946007)(66476007)(41300700001)(66556008)(5660300002)(7416002)(38100700002)(38350700002)(54906003)(316002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aJxdLfuMTXLxy65JGGeaD/gC0PQ4/V65ZVOlTulUNWGdYW1IwL4SX409vju3?=
 =?us-ascii?Q?cIUGXJ3GLW8v/Q77ehfrHk/lH61nsdORDU3jQT0WZdBjRX1e24UgjsgVsNdK?=
 =?us-ascii?Q?/SH68VicYj+SlzrC0nQYqn3+dNhsmKVe7WQeLe4+cohzlPYw3Y0yDudHRQy/?=
 =?us-ascii?Q?WVvi3nOdMi5QuNhn+I+epx4RJOkjkR9zoOaNtG6dL4w6fr0xlOaaEoE40UOm?=
 =?us-ascii?Q?HOCbg6fMLQXIRq1J9E4JPGgT4PyI2Tpq5ALKPWj0GJDKqx5AH+h7rAzLg/hb?=
 =?us-ascii?Q?LaswmB5gSVZgS+Vm4YSFLKJ0UL3+jUpRxyH6fE7Yxa6vw8K8lImF2lzYuVdy?=
 =?us-ascii?Q?rlhMbRaUCw9ix7KOvzkBTdHbRTf2PKTLiL3DVULv0T7PS2BQ1RdR+T+MW3eZ?=
 =?us-ascii?Q?urmhK2M7n10Q3S7Z0JKMescjnZrJDfHHC1xaQm+W9YCMjT8o8QowiBCZe0g7?=
 =?us-ascii?Q?UedofoaR63sByoLDJidbtDVPQsElo0j09xFkBSlxKMviNjRtz+lHfqBA3AiE?=
 =?us-ascii?Q?TkdiqyCByWeSyxopx7KoYxluyuSYzX7hNepGOf9BXYvRzxEx5qJs2WM3Hvp8?=
 =?us-ascii?Q?+AxTNPz6HhlCh1xC77zKijZXQmi24WSP6hNuSuqjYRb50YE0r997PUYpczAn?=
 =?us-ascii?Q?K4BkoIwZwz6pmp5v1TqKatoMGBqOyJX7Yv6ARneLVoek+J4H7nRFIVw48p+X?=
 =?us-ascii?Q?XSpZ9TfDiBm2TIO5BLV609onhF90GLbjAgYU8cmQRl5LGKb2FqgcpNQbvaPN?=
 =?us-ascii?Q?mgkdAtMn6lnUBSKo7SlsvM83CNp7Yvu1T+aA+R56VgxIXPKEAYD6tNrK/fUf?=
 =?us-ascii?Q?b4K8oaxo0PCnM8NH/8S8c3FknCYLid93knSC7Nhi/yappq3NSPKCJ3/e2wEh?=
 =?us-ascii?Q?RfR5Tcopa2SRb+JOnuRCcu8Hd+H6bQfCWOP8SjVnsIF1gPrUo916+Gh5uqvh?=
 =?us-ascii?Q?PCqYUvSxzCbQgNSvM3pdAAXSXwck2cfb7yAmMQW0xFYRcuWgMG1AzdGNkCd5?=
 =?us-ascii?Q?NvEUtaTO7A/VMiMTfmuewllQB9D+xaj1uPcDwpASg9mHFxWoWth0fraCTI+o?=
 =?us-ascii?Q?IFZkQuY0Y4uX1rH7NbTpg4Ct5LJ4zBaFpdAxcqggovPdqUEeCHRhKamw0l3Z?=
 =?us-ascii?Q?jXV9oPuboxwbc8Ik/zKa5UjkPVPv7q/kWAadGJ9+H39NkpSXWHhKTLRtUs7l?=
 =?us-ascii?Q?+ojZJupNb7uyje+v3hVpf9W97PDzeakXr7D2z85nS2tnLjH6mmjhCRJRnkA4?=
 =?us-ascii?Q?mw+BQclYQlG7yY7KLEmNoKPk/x1L6IahseuUgzztSOmf91GxfAv+aFuVff1w?=
 =?us-ascii?Q?wBoqqtcXtWyo7Yq5Izot9Pqz88HY2BUyGKmY5K3AfGNub20QUBSlo0LsvIhx?=
 =?us-ascii?Q?kje/8G4rzMNcx5xnJc2KYYyk7uoYSKteyaloCjj97Z5Hh5eWxJ49OF4NBWEf?=
 =?us-ascii?Q?Xy3u8M4tH8PaFqvRzmN0SGbR5Zby0i0/jG2x1FzSdosqVexNuZc3kXY83uVq?=
 =?us-ascii?Q?ILV3ctUrLfhSkjGtdtviFNOrgoYGnjgAHwpATOZU6BIQh8i021Y4yhvkTSwq?=
 =?us-ascii?Q?nQurW/h/DmVUo8fG4JAu2HiFJ3b2RU+q5xzOkrqs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b9379a-ddcd-472a-cf78-08db341bbcde
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:16:34.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOqBhVXX25HWBTZlT7zw/jlDCR4P14+JZ908s5BJvV2E20f9P3CYgHBoNrBhdCHrem5cFkC1eUBMBjIDoOAtiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9381
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

Fixes: f1541e15e38e ("clk: imx6sx: Switch to clk_hw based API")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

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

