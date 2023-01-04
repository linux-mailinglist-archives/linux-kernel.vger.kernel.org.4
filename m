Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6617F65D116
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbjADLBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjADLAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:00:31 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2073.outbound.protection.outlook.com [40.107.14.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18CB13E87;
        Wed,  4 Jan 2023 02:59:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuJzAbRxfgEx4d6hNI5Lx+45/pnJdFF4Uun5PoprIo2+D6VsJ9HFdR2VCuF5fFhyvh8a7uhMsLyrUZ9ROv9JVfhmRZm6OpVE3NLOb/1EIvpHvFaOmiLwq9it4SqpCb8UCb5/jG1akv907WV+SFfuBkt7f9GE9rio8xYHuo7FPGHvGt+F10IpkrpxMkpkMFi9G1WpAJGzIm3mSi8iUm0T2npY0x3iiZ9Hit0ZujEEMFY+X8KoGvabzaMS0bNAMdYbmGQ6x6u4ZdIpiCHsu4KI+GT/GQqS34NcSfSnqIHPhz+qGuqQu4FQLYQrC4Mms+BbHZJnhLiDW4dkriB/EnHGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkSAA7lXSuHGgi6j2zcyXSpuLor0RifYXuE2FgVgD5w=;
 b=Qs7q5XNpqH6+vwf0ysStpP4qWDVA0xzgsqBD2hZ/O/yEz022di0PXFEsnAhECEUJyPSj1JTdtJore331KmClfrLdXFxEvoEvpszmzWpBvT57x11p+wqkqwn2HC846cUChNv4QJfSXWnoTB4Nn9v1v2yyPgKgP4mtrvVnNNZYFEOc0b2RKKrI8N7bEz7F5vg6eC5j2aNaD1O3UDdZUT/guwio8UqprMGrwbuHBkiLgwWg2AIWScTmfZ3+k+8jbW3ULIJI6S7d/YCF6KNowQZD74g1gxXnDRcAD70MDK/DkIX3k56/vEJr2j6zep7cUAq7tNhy6M5XaJrPH95n4MFWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkSAA7lXSuHGgi6j2zcyXSpuLor0RifYXuE2FgVgD5w=;
 b=BYajTWNOBdQ7XLA7t5SFF5RmM2yPz+iVgWANns8TsgJPMAnGEaGnzubeeS+dWmx/tXG1v9U0aOvmXnJBTNQMAffkDRT02MSdVsJY/v4yP9inwLc4YaGg2AkL8HK2DWQMav+DeAzY/X0CFrE+BlJrHLpslwxzefNKbWpLLv18MSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8408.eurprd04.prod.outlook.com (2603:10a6:102:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 10:59:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 10:59:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] clk: imx: imx93: invoke imx_register_uart_clocks
Date:   Wed,  4 Jan 2023 19:00:32 +0800
Message-Id: <20230104110032.1220721-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
References: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e527bab-e61f-4273-b8cc-08daee42c086
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xka69p/EmEFKGCfwLP0OApRf+XlqXfgYUe7EQvtaDaFgcOQ9td7YocnZzQgS8zd3j9SasosME2kdJ7LZAfVFqK3IAkaVPvdCJ69BfibAchTWBvuqwRfKpHJFECwrlNDnX1uUqwL6nUICyjiEOlJCSHj9DsHCQzZOiKAWk2bMrzJC1SzPDi0hbucztq14hwMaRMNQuB9Y/24vbQd4vcXVRCV5rAwvk6lL9ZDw1M/eEb5rd2CfWI6E4zST3Hhk+brZn6x7rl0IeMO2/Cb7AyeCMm8BfbcyKnW5/avyfvwyBzuYqxewF85lVKn/nQSY/88gEDRcV99OEOjdY9BGiHHoRn33lETv4L3/RZVFFlZuJxXhS4I2o9OiIExLoHG41Gqvmu1MWs2gD3P8iisyE2YVyDVfBnaS895e06Alg33hFsQa/f/+ill7ZQ8a/oNpofcKvBiNf1BLEhScxA53YS5YgubE50SXzWp6+VuWvHERKsQA4retDV7Q2SKWwcH6J17hoIBefwYh2gTKueXOooR9Gs2fTGzYfMDuh2f/vZ8OMvLhSo0jcxfi7881sIIHXs44FBmqRujy0rp01us+6PEVO4uKr2l8xzi8ogk2G/86V+5QboHgLSjUcShthGgSYclbkSgCMWUqaw0lI97Fj98yT10L37/iRuS25rEcl3Y6AahPP4K4xy7wa1KekM5TIKqG+aeS/SVdbQzwXcyaJysq0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(2906002)(8936002)(38100700002)(38350700002)(5660300002)(41300700001)(7416002)(4744005)(86362001)(83380400001)(52116002)(66946007)(6486002)(66556008)(478600001)(6666004)(8676002)(4326008)(66476007)(316002)(1076003)(186003)(6506007)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZwCcfpRKJ5URUojhteCJ1XBCmu5qOIXePIo65zwEecPHjw2RBZVFIqbiLxc6?=
 =?us-ascii?Q?zVhOfDu/zKiGuhYFLMsjEdysEpTqxK0VfZtUW6qrwv21eBWbhWlfFOe3PgqW?=
 =?us-ascii?Q?h5mBQ9J4wxn2WwgoDi/0i5ccqocei+SsSIxxFzVyBHoplSDcfI5SgF4lRRYe?=
 =?us-ascii?Q?rGkC1kTPixao0/YhvyAX/NYLgs0/iQHTht4F06ZB7D3vIfgJBsa31+Ji4Pat?=
 =?us-ascii?Q?DEs97zGlvGFIFODhoErBFhls4w9IDSVG6MKhoQ+S+MYIaXhhstMeA/mYkA4k?=
 =?us-ascii?Q?ngivSU9tRXxS2BuAGOspcyVWhXgsMTdVjVd0Z4rvT63S3mtfiAMy5LvnR4fO?=
 =?us-ascii?Q?btBuUGF4wYY7DqERRqApwjUcSGPehRVpdkicQ6dJRRlUth6cgmB0DeTPYucG?=
 =?us-ascii?Q?qYp8rw51YQE/346gYrSh7DjTSXLZn1fzn0JtMYWEn2Tbz+JwUo1OhJwAX3sa?=
 =?us-ascii?Q?/N4ni6m3sPichYy6FCMMLZBnzQdNg0/cVhLMdo8ek4nscPi8Gowvj1qdSwAB?=
 =?us-ascii?Q?3jGTNi743OZh6XYbLXcxhXRKxFQA0wbB6NVWRdWTABhdNmFPtDJr7KiCAM2u?=
 =?us-ascii?Q?RLK+O18x1BcyqphaxiniB67IrLmH2afhqGMfTfuOi0klv2eGNs2BLMZvvvUf?=
 =?us-ascii?Q?+XfDaTEnKPFFFlRFqcyAFDNx82JYb4sUyj7cDTcL0Y55Y6qKbpyYDvDZOesK?=
 =?us-ascii?Q?rUyrUuoW4+YwymrFnKVvb4MCYYudHc84CuQEdYxwa+XOZq+R58nxzbukNMna?=
 =?us-ascii?Q?kfJO9U1vlXmR0aczXW7rD8eW02JiOBP5vt+akdGxFY2SwbfJJPgMvNnaBLiS?=
 =?us-ascii?Q?JJmXiTM0aGzOQxArn0CiBLdmyoCxz5zjJhI8ubVXmOdT0bcfP2ltvr2b7T6k?=
 =?us-ascii?Q?fpHp5TJq3/fwv1Mgffir1gWQMa01mUpEpArTXNRzMW2KjpGY05D26YxklcNl?=
 =?us-ascii?Q?isDw7Xrx6JyE2FIZ7BUYthhx4n/RHI/Ox0NZ6OnbPK8q68eLoXiHpOjGQcH+?=
 =?us-ascii?Q?Qs8zkxfgzPLFQ1klqinReoYAk6rP046Rlebff+TT9NiNB18ftwx3vKOChqQT?=
 =?us-ascii?Q?awG3o84gjWS0OImzbdrXJ0ntgancQwQTEj+WQqurQQdsDUKQUylheg/Dakec?=
 =?us-ascii?Q?E9Wn3hjTMM8xNJlO4Nh5RoMGziUISDV4QAZoKX0haUDZMxPWcQtWUVgLc/HG?=
 =?us-ascii?Q?012agzm0O0+ifE7IoDJsqwsT7pCR4MjNx1BZx8i8E+2YwhXPwMeZWwb/hLqh?=
 =?us-ascii?Q?rOIf1xb0B+NbYaM7WsACe98Wz1I3pql33MpAbVKfg/gHhiqYG36AUbSwOGuH?=
 =?us-ascii?Q?Bx3BmNm/p9dAKrWoJ06ADkruhUgKC4h4N0rPqYcuJoedewAlA/w6Wp1SO7UM?=
 =?us-ascii?Q?TaY7vDYzhMov5pbm1Q+I9fB9r+NGEvDPkuT1caQJjT4YTievamZ7qd0wp4Ys?=
 =?us-ascii?Q?gegO5JffppzxdA8miiD2wuMsWs745MVoZX/vphQkM53PFKMFr5KnP0dj0lEO?=
 =?us-ascii?Q?fNNfwVA0nDgEYA+zHrOJQt0n7yz20bh/ByxZ/TDVCYhyOmPJJxtnwAqN4lQm?=
 =?us-ascii?Q?totWaqOWYqikHCxAl9YAwNT3sktOyQkGSkLwihCF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e527bab-e61f-4273-b8cc-08daee42c086
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 10:59:29.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h62Avv6gxAscQlkejtFOchHj1j/uc6BN/OqblGRIjp+l4/c+K2czPC3p/oseUDtb+In+TWTdg609HAqsrPI1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8408
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Invoke imx_register_uart_clocks to keep uart clk on when earlycon
specified.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index e464d9e71fbc..8d0974db6bfd 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -326,6 +326,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 		goto unregister_hws;
 	}
 
+	imx_register_uart_clocks();
+
 	return 0;
 
 unregister_hws:
-- 
2.37.1

