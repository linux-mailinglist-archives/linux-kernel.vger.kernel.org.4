Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2206F7FF1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjEEJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjEEJ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:27:04 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A619419
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZWeCkoU+oVfj3nB6vcE6xcaWkQdfuTtdfO0em0OY071OBPPPW44LXRSpe9GsXRYjrEdM1ZOjKcfxNCYCpniDWewJHPUe63Prq36FhOXxjcco7nCwgKp8E2yeYxsS/Wmlc6hAKStUyDjSCNSDFv4ZZV0f/C/4UPg6+h9SUoUUJ6Lg8WNqFa14NY8uZepXwYPip6yUPl7vDP4hcxul/tFaHguzzrTFSsJv/KYFrX7h+CJv6gxp+1IpnipIZ+GpCeD3g4v28VXain+b3Bc87IKAq5i2pfyyA0AR6J6bcM9oYdnzFHSQcJIq7jnvi3wBPLbskPCtSIqED1aeCrCh0JFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSSZ47YXKop6DjIHxf82s+xRkzv408K2behSWcI9WA4=;
 b=gwf3I1+7LyxLkjsqKvO0UXiA6lBpjRfH/dgLTTfRsdJINkmfW539n9VYVVphzXoMoim88ai/faKrjHxPsuFyWi62RkQn64h4CWsFN1aJvs0zqv6lG3nSWMMShmqLg7OFeSDCx9S2yI1B4mS/9paV4KJObrvhrNDh8/43vsnklX2aZ3M/RiuBdJd6us0CJZRXm7RNpTp13YWGS3En8gbKbu0wrA6fOMFOssrrCQbDJ4ZzGBzxRKvCEF45En9301vSnjZ2ZQCF7ZWfzCPsa3H27l15UpwY3nGd4cg6wOYV6rr+AUNYsI4LyZAEissYu49wAsL80JBTa5+XNzzGkXuW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSSZ47YXKop6DjIHxf82s+xRkzv408K2behSWcI9WA4=;
 b=WcVmIpIKTX65B+mKd+2VFK7QpSq5oq/GdQF8Ha/+/LDWGsaASgGlDZ626jfsRMUIoFA51Lcl8fotM3pjdK6EFY23yc7PmsxEPU8FfAi3IdfxYYxnuELrrSHiq3OmSARseh/yAQHzCZ/tfpPvQm3vk/OFKY8E+TBGTJ9rHDWwNKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9674.eurprd04.prod.outlook.com (2603:10a6:10:306::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 09:26:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 09:26:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx93: add wdog3 node
Date:   Fri,  5 May 2023 17:31:30 +0800
Message-Id: <20230505093130.1834861-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9674:EE_
X-MS-Office365-Filtering-Correlation-Id: f50abe6b-4337-45ff-5111-08db4d4ad223
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwxaIW9B2fxvbF8RUUZuqN1KoFYljeYwa1V4entsNOt0vlXOALm/9wZbOoFnxZbPEG/GgP/1sKzAJkG2PiyVd/0hEszscX35wD5pd4rTICto27u0qe4FtOQdGdrjQHDcd9YanlMiACNOCcjFdxFEOnWME103GzgySR8ychUGaMKvXr+mCEEwB1ZOp1o5dIzCddw79KzcKt0WRSg8TenUiYgWSfw+806VffHT9LxcOBN751kmD1OnoPZo3QU0t/Elhk3K/2Y4cisW6laYHZddkPFzRN49jQ4V1rxD9Q78zo3uQkvQBX8n/wnqIhFJ3Jssob682LxmYPjAegkXTYh9BhXaTvWUHcqugrCeAFeQtg6QsI2CFdXEMU5PG4nDlYjrXEYDi1Jc895FHaoJuBvw0+osTlWQ9rwt/km1t3PICszjvc2QC3rkLvjKWObfmbIUZNT+A4WuckHMEUu8mucFXTlQdGCl+Lnyeg37NhnS599kx4tLQ9M7oD09Uo4KUd3IYSMO6PSkWb/cjyKbJDS/4I/o4s2cIWnwq6X8/K5hcYcqvWib2mqFu9sEFgcCZ6v0SGB0gTlrkrAGorZIn9nUCau+1CFZE+Y1TrixOvfuQxgvQ3SXpbMGB3rDfaMUeBX/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(478600001)(66476007)(66556008)(4326008)(6666004)(52116002)(66946007)(6486002)(316002)(86362001)(83380400001)(6506007)(6512007)(26005)(1076003)(2616005)(8936002)(8676002)(5660300002)(4744005)(2906002)(41300700001)(38350700002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Du4Zkcaxbtq5RSyuHRWkmBff1Dm7MDHJyVJxvCQpIIg1ykiJ6G+2Heq4w8pI?=
 =?us-ascii?Q?V++5G6IyUR3NuUx+TKViDx2u31vI2XNsenQtCdpnSvJwJKSSBJrfQnW6v9Oo?=
 =?us-ascii?Q?fwUQevQHjtsJZhLtJlFwpRrvjvTumOosO7j8JSE1Nq5/AuTkZEEnmG7glk7W?=
 =?us-ascii?Q?BzLOSqwhMOocgaTNq2MivQPj0UT0KNOU6My08jZ+CjtHZx1h7wJEkHSHOTj+?=
 =?us-ascii?Q?ETk5bVkhN/9C2c5TKCM3KjqESUHBnoPVi33zoW0fBmP1J5YrUmXNdNbJUgWf?=
 =?us-ascii?Q?6WFu2CfDzIlWNh01X2sAWiQMCynjz6hX257xxH45BiLHKgu14emCV37TL8tu?=
 =?us-ascii?Q?TpS9EZM7t+B6RJJ9Mn3VSlBY1OQxBKkJJ91SC66kN6YCz8ri8G0W82AAjDBw?=
 =?us-ascii?Q?BRX6fAdfJ4c+xlJ1z62jwYY6W/19Y5GHXSzEshTT26vAbE1R2gXYEoNrYK1f?=
 =?us-ascii?Q?MW086UJFcyvwNvEdQHzzt8jgeHupj2Dj93FTyAht8FfRJE2pXN031Djo+UoU?=
 =?us-ascii?Q?jy80b6gf42JkHYu5fexvUbNaWG2XQ1ge/P+M4KNpL1FBmUaoToX6nmhBUs/e?=
 =?us-ascii?Q?F1zsIXYn4UxQJVgJkqzFqvdmW0TAKNj+T50gcaPpNxL8ugJVNT3S1n4dKt3c?=
 =?us-ascii?Q?55yIj5SGKE9YjjUO+4vtL8EpuUWRNyHCMdvezK/2gErVe0F3SFZM37CLr+XE?=
 =?us-ascii?Q?RvU5IpsWibu5krbzy9BnKtMgYg8tWWEmes7dtIvgrmz7O2ud8O9OKRnkY91h?=
 =?us-ascii?Q?vARyxWrZKrDTraSVPLpVaP2GRnjpndu5WvERpOFSxKIp3OmtxCfsl6Dxbcls?=
 =?us-ascii?Q?izOm85H3QcfoaUMsMpJcMRKkaWIKu7LI8yaMTyMd0bo4/J0DhFjU6mswZ08J?=
 =?us-ascii?Q?kxUJNeDUwg0NaLG8yrx8rwKHUj7sSvDAV7d0SwJwpD96GRaMSywSsNGFESeH?=
 =?us-ascii?Q?QKxxIPJhbTb+uRfA5kSR+nt6z317VpyEyvtB0SfZJLirTYFnhSgG1GvdTwjW?=
 =?us-ascii?Q?YNN6KvORM2B5QJacAnIYzjpMsTJVmAJSZVWtwrKIV0X6Kr1TCreeKiFoT5wZ?=
 =?us-ascii?Q?yhJdFIt0APiJKVuKXkOCvfYR7ZNIrYDo8mU7tF+fLZSowVdHDhL+TW8mQgYw?=
 =?us-ascii?Q?YMVZvjP/20/IzNlDyjXhR6MzbFsqPtOYBOpri+1Wq9NOi8YxPxih4+8WwehS?=
 =?us-ascii?Q?UFLCJnUNw7ZUmZnw60xexWksctMzLmgdWxb3R6IeL5mf0iTZa08PeFp3VHnk?=
 =?us-ascii?Q?cGOnYfw+7cydT8UFJ70Zp0k3x5F4qWuaUDCrcjGV1N3P6viJ1z2fMCn3HUt4?=
 =?us-ascii?Q?KbAJzN2xoW5RQTbck5aG8O75jdZIgIrVK3ef+INK4RRskZ/DzMdsVgLBZjTw?=
 =?us-ascii?Q?LpZY50KFrv+45etbdgfj4oym8oZL5soR6KY5mJL+69jONFUCMmZZbP5rPoxa?=
 =?us-ascii?Q?ziOLYv/vHUflRMDQUSVxQ5dH4YfdJ3gcpTYTWZDE3eeamJmLvl3gEqIzWaTW?=
 =?us-ascii?Q?BVp4/Ti3V8I+ssTJubmXxcry6Xx3iA8ElfmNsoH8G8E+Qcf3jKJhw0656yKA?=
 =?us-ascii?Q?oxYWjDZbIMlBpR/0IDiVl+oSgrkhwvyIHYENctB8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50abe6b-4337-45ff-5111-08db4d4ad223
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 09:26:35.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OJBA22lFZQEz/gAjU0y2goh41P0PDKFU6NE3GoOuFRWc8fVspWiEOjgyeKPk+QRFdejLMOFgEbxnEXVTe6pZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9674
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add wdog3 node, then watchdog could be used.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index e8d49660ac85..73ecd953ec8d 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -344,6 +344,14 @@ mu2: mailbox@42440000 {
 				status = "disabled";
 			};
 
+			wdog3: wdog@42490000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x42490000 0x10000>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_WDOG3_GATE>;
+				timeout-sec = <40>;
+			};
+
 			tpm3: pwm@424e0000 {
 				compatible = "fsl,imx7ulp-pwm";
 				reg = <0x424e0000 0x1000>;
-- 
2.37.1

