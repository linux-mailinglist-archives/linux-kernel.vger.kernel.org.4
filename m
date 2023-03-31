Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E7F6D184C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjCaHQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCaHP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:15:59 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2081.outbound.protection.outlook.com [40.107.249.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C561A47F;
        Fri, 31 Mar 2023 00:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLImIy3o8cDxIWjiCzqYLH+xziTX7sAny/q9EobXoTzclvOhfqvpuOegUCDLBHkbQ//BahtZfJSE6FjZXMOaPyWO83+qEFFmFXzw4kZS8RHYdHfS0aR7/M9XALnrLG2Bedr0g05wo+pJZPMagjrjAS0/2PPWhjI4SXukHxwE8OUexy/Wf/dKlaQFPLrjmfauRXhS73wyI9XFM5l2atCsx16QsgSg/ZXqa0+fu9VUoocXVciqID9Yqb2K+xnB33vqyvjBed2Wc/rngQ/tEVRJyo6yi+TdY3VQspqqM2QFfDXgprHI+rn2h5y5I9bRjk6dhvpAO08kPnkbTIOgrRYi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmCZvQV26FmdrI6zifDlOXchdQTeus2mYVJqcU7WEnk=;
 b=Hjp+DZAYPWyOJ7PsrxqlPDOHZlxBbELem9QlnVIRSqTOygcL1B0kHW0RCRmBhfJoG7/lQyKB0/oLNdrJAT4pc0DfQDzIPy70n79A1OsjqpmZElSLcBQDLuL/orDK9G8PLsdgMd68F2uWdAeopKpnmMyb/M9Y0U+dyHT6EczFKumqipRqwZFsL3FSRng1AtbGpqb/gsVd1S3i0EioXTP6B5rUcW5rxTE01D2XINzz/HYpmPNy6jIdBX6SvE2IdDua8Fj0AJqGFZtVo0h6o0RICjN1VlDbSJiRcyJ3vyt4LQEUqK2hYHGG6KW2FK+S6QUnGj4jugCi7t/Luz+R7OFVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmCZvQV26FmdrI6zifDlOXchdQTeus2mYVJqcU7WEnk=;
 b=i3AIFfvrqS/VdKqpfV1FbSKlfFPfNKbcnmJDn9x0MHecdIlKqITSrO/MZa8N01TJ/wgybqJg/JqowfRTHqjLsSGU5P0V+W95AIkkCOzZZilbTVe04lBY9OIu4Vz+f/RNUwO0xl3VsBFAFglN+A8dPupgXdm1lYzus5HsDo/h9aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7892.eurprd04.prod.outlook.com (2603:10a6:20b:235::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Fri, 31 Mar
 2023 07:15:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 07:15:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: imx6sx: spdif clock rate is too high for asrc
Date:   Fri, 31 Mar 2023 15:20:58 +0800
Message-Id: <20230331072058.2483975-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: a6882e19-a1ac-418c-bb65-08db31b7c3c6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkYdcSiCjXUkPKKfyq0cuxaTW4ZntSs5U2Bu8/gEMQSIDZqR6N11PrkteKo1RB+1K8DueldRh0/i95m7EcpQPKkfRPhLCYcjJyQTPwCS4SKfzib8wCs8A263x6l2bcf/M0DCeGYzKq/WPVYlgbxNXZwin/Kq3z5HOkcRin6uqJp3sI/oAFEcD8jfmzCIb0JDS1Dggm3Eg7IUBtF+uk7hyEw6130/IdV+cDwIzBxmYiZQXnXJ6p/WWbmWFR3tZNuDC+JHNQevZm+eVMrqRNj1I0lFfX9WYyrGuV1lzanP+ETx5h2tzQX25KJYdMvN1u37RoVkHAR46NiR5v6ykKYlKA+QNpNWQxxdPaVamsswCqXShXHtFZw4hGZYd3sFu4hnINcY+45v3vyfOYuibaxYzOs8TkL60kKeWT1LjzV++NpvUHfGhsRMCmAuJV1pVhkUie/MSWpbSnil07wZs1gBEBC36J2gAXK04deZ/kun32vPQD89q+M93TVSWNE8ABhrQ8eIC+gHS+c3uAy1a92/q2SWA0QKB6445yFryirRyn0wyH6mP+BbNBoqpRPp2qS8agYLuiJxq9wg1XRX4UJM7UqqHibd2ckwqARhHzceInmohrMm640qaTwfGLBEIOl6REsjPdteSYls42GMmz76LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(6512007)(2906002)(2616005)(83380400001)(54906003)(4326008)(66476007)(7416002)(66556008)(8676002)(66946007)(478600001)(1076003)(316002)(6506007)(26005)(186003)(52116002)(86362001)(38350700002)(38100700002)(6486002)(5660300002)(41300700001)(66899021)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aFmTyR5i/CQvX5Qv1sjCRrv7tODNNvqKoMZJy0qOqMMgBGSawnSrTzeRynAg?=
 =?us-ascii?Q?ejxwmib7hplPQQAoX86X51DAtPluoPjt48B6AVM/8vPRXFanFC+0BYOaAqAe?=
 =?us-ascii?Q?2zeJ/H9yLClbNxtGZzDP2OU5Hd/FMK3Q1SRrr+DSLE6ZHOQk9XaGamriR45u?=
 =?us-ascii?Q?M2Vjv20kAww1q5rNVeVUJ9CAHp6kkNua2SWenKp9JQO+jlcGiYvK94Lab+Or?=
 =?us-ascii?Q?7hTBJyAsv4Qlc2queSQFtHvdG4RgOqM/lhcDxglO6+78PBxe3izKAVnzf0f9?=
 =?us-ascii?Q?92mUD0zuAGtHzkKYH7ET6KGXym17os1T8SQ8gqQxrap4DAqbeOWtCJDtqGz/?=
 =?us-ascii?Q?v0b9TmSEO1BCmhDrWV2qqCbArAlAJFnWhhwYP8VC55MzWrMklpu4+7CnZuZ9?=
 =?us-ascii?Q?hhUuz7tlZnj/itzwz53oiC+qAMKLt70wwR5uQeylY/g5fSrmIXfqseZkG8QB?=
 =?us-ascii?Q?i0Ww5IYkhUk77K8kL6ylCIlAOgUxLFM3z/7GCuiFdOb/7Haef8iWQp8JygKc?=
 =?us-ascii?Q?d8+j20qMfGXA9mjzddYU5yG64sBrut0v/RaLAiXeMP8JA5ugoDrhYuGaQ0Uc?=
 =?us-ascii?Q?9JJ+ec+Khe1H8M7qpCAUPsdWWuKSmboMYS9x8N7B431AeZ/UDycq/7vg/4AD?=
 =?us-ascii?Q?iYfVO/+ukYnWMExG32rrpNqlWQaN1ScewP+vEJA4ijyP+FFgkYhehoDqUb6H?=
 =?us-ascii?Q?wlq4Sp6rnQzcfvGLhvBFKua2yQT2V+EjM557XNJM9YwwgY7lL0Sh5+3JkI9e?=
 =?us-ascii?Q?IuoC/FwwrHjEmW8SG9p1TsWiYGLiMb94a2l2ZaPlJe+SBk3QANYekUcTrx3w?=
 =?us-ascii?Q?nEFHwJeO+B8bonWYRNYc384CXuT1pmHwjPuo3AwZm8aJrwgcPM5BTlYkVnjw?=
 =?us-ascii?Q?jkUkHqh2DUbfgV2LeKo9TT9HLtMCd7xO3Hj44JgbkxBbI0+KMzk/IZKmJ0HI?=
 =?us-ascii?Q?Wxa6Tb8hYINWmYGi+i3AV0X705yICRtoIBPqn7bvhEmknzGbIYF+2KUVsE36?=
 =?us-ascii?Q?tsuBDqzYFWN4RI2Y7tgELTGPjx70uJ50SsscQm92xFhZ8Ch2b6jMvgWNyV3r?=
 =?us-ascii?Q?E/pdYFVZbgWXTvI6CFF6tyJ9qLHEPztx8/2jim9wmi7ptWBExU+xbzrCcZiS?=
 =?us-ascii?Q?tC7W3Cz0Bl3ye4ZBrJkQrBA6PVYbYPgtGMnrxJe7OMPAuL8cLl1BcLQOP9fr?=
 =?us-ascii?Q?P8qwUH/qvwiU4ZO8mT9wCdQ3ws/uSIdn/gnZP8lC3mPYsHre0tCwPsxOE+cW?=
 =?us-ascii?Q?hU30spCYg1SAkEEsZydj8XbwWORWvcqT1K+w9otY2dddNyqywlN5/hBgpBeR?=
 =?us-ascii?Q?RxKqcYC7qvQdIQ0MFE52qQ9D3x/EUYgzIDetVA3Wqiu1lWeKm+64YEwG1G2i?=
 =?us-ascii?Q?sCunzFiWjsgEfhfiO2sQYu6lgyQl9c3i1Pltfp/R6cqICG5zUQAyALFWEZQZ?=
 =?us-ascii?Q?D83cpgPYj4MVdXD1NzOEvEJfKrdWrZRjTy197fNmQs8R26ztidwe/nPY7Jog?=
 =?us-ascii?Q?1Pi4vHBJgQ+eQvevqOlyuU+PpTFix9odEs5UVD53S0wEL7hWwemTAN84yHVg?=
 =?us-ascii?Q?RwyWx7Ao1yafWm49de11UYrlATJRReBSgWwybaVI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6882e19-a1ac-418c-bb65-08db31b7c3c6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:15:53.8592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6EXaUw316sF13vsAC8OHu8SmnZSTQ7hHuJb7InL8LG8lXdGsYuluuJQIuSWzLh30PWQSGZEpbweS5DKZmObLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7892
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

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
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

