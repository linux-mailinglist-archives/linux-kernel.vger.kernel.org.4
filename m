Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63DB62D787
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbiKQJyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbiKQJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:53:23 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60079.outbound.protection.outlook.com [40.107.6.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B50D7617B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiMzBZ+M2R4nCVg+uypFbVzzIeaziRn7T8idgBCGtT+pzOwG+n+FPTdLm5/W/qgTIQKUe/hXfEqnZ4ZUubFJleY3U84Lg0eRTWuKdts8SnKItuY4z1USws2xxyJrDqwHdO+Yo5dOW/t7tXGq7ajPQMV2wVgXnmtyHYn3ypXEdgs63NL/A2+28GBAnfJV/3prq98QlhEVNMswdE6VZi0zoIKJu2Ctm9xR7Oxh6bZWPv5N8uhpjtdKuVLuBjosLoysWZeNVWaJ/GwD/rCAn3BiOo2yIwd+Y6qI4ekAclu7xa7HRAdBNcWscAKN4Th7U1IQyYjM1saj7p/Ro2ttS2LuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNa9aMDSp/BXLWQWMde9pU+d/D9S7E2mtyCAZ3YRlw4=;
 b=MTYQNisKuGI1CyHMINYMiI7G/llpIyFMvKYgiJFFfAGCW2KehkATMev4q+HJ0jVy01Q/TsHADaxki3jf6EPnMIkBBjJN928wBzdYJzIOkCuqFecgAcQfD0jblZMW9wxUob0250Pa3jrKAP+L5S0wFg1P7zeOBfzAWv/McxmjhWl+HQuBL5uWbVGHBuCog9R6Yv0qJzkG6eJhqw7EVhnuZmZhZQfrwqOGqMT56Tug1M51UsW4M8vMdS4dAjufQxme9G0OsCjsAMir91XBJx8FuqUy4fg8MFPnrQXARxSAUQlPBjegJCWUdtkmV/y0eBg8fFNiyFdds0IswEVA92l2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNa9aMDSp/BXLWQWMde9pU+d/D9S7E2mtyCAZ3YRlw4=;
 b=Hzst8+QU344/ye0GcfBg8a1dsSaWHzrEShaKIrk94lPQGdTqtHjFFc1XvjFG46/j8U+GEDMj8gTVuWzpaEeCzWxAPCAyXttDkiQj9fy2OQhZ55wQLsEwGbUi3RZyuSOitYLx7+ztSnPxuv86Ac9eggZTm7ldoyN4NznrRpslhCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Thu, 17 Nov
 2022 09:53:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:53:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrian Alonso <adrian.alonso@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V6 12/12] arm64: dts: imx8mm-evk: add vcc supply for pca6416
Date:   Thu, 17 Nov 2022 17:54:03 +0800
Message-Id: <20221117095403.1876071-13-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: a468b292-2de5-4ed2-c975-08dac8818d42
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkZ3aLW8myAgd5Cu2K1zj6scwwUczsb8ixiRmtH9Sg/W/S16yYbLrxMIeapZ/kDO+uX1+FDymRoqn/fSghC63y+q9NAzIvcLL7HEoFsavkX9706MZRfcDxd1pQUjJu0J5LbKYUMkSLQ/fHicU0Vl10YnOGzT/hD12GrfdEDZdEFu1v3IvsJcIUugREdhEcXKrXzYiZ+fAhKWGo8mFIaLy98xfIIbXETt7KnhOS4v5MH+TBe1lcm89k7tZ6GqZJXZBUV9JUKLkntk8Clgs2x4ocgCCZw+HnDr3u4DBH2oqORAbO/3IIgg0fe60+Qac6myr43VtQxJsFsteW1qR7hM5s8htnuNlArzwr7lZNqKCNyXgYLpmLjCnR2462IMNxrqhyr26gkduwWfWkk2JkktD9SOQQKBtbYULP0JZ4F533YNsY+njV053a1c5EZhjxBrVrBbDsZt+oLpFgLjkH1LSWXimUp31sQr0+163wsWDcvVACHTksOQ+5+zr4ZjVBownTUkd7hsYUw3qVuyztg0A8IUW9b+QQ/9x8WvgbqgB9HiIyx02V9l/QvUBHFWLl1gxdqCDGh+chC+ep/9eXKJMk7smKyvxEHRV3xPGej06zZawQRkK7GVKp1cAKs1kWnA7WUEINActhB8LGkCE350IExa+6fxX0eaXlXmYZIq/yoQYFrxvQ32+2L4Pyy4sbLNETAhL4JKe663zE45Kckyq9aH5d7Yjc5Umwes4+zSbwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(86362001)(38350700002)(38100700002)(8936002)(4744005)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(52116002)(6666004)(6512007)(6506007)(26005)(2616005)(186003)(1076003)(316002)(54906003)(478600001)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OtvvnwZFShWglF3/31G47ig/45y9TdVTnncqgNA9kkKQNc9IpOIQT7DX2EO4?=
 =?us-ascii?Q?DgMN/kM8GHa9/qg556oO9vm3rcQu2q4wvLZJpmegHIV56kmlATyukAt0IpuN?=
 =?us-ascii?Q?eY5GMGHK3NZfQv73IwjBkBmqoIdGLylW/2/LNhqHmyPJfvvGgDMZQZMO3Q1r?=
 =?us-ascii?Q?xoL7jY66AYM7roVnGmK9qZMLe/oSAiZdlUrLEQ8E7DIanoK+0W87v9MvHjMT?=
 =?us-ascii?Q?ADid2zetjytSnoV+DTlyK51GOg72FS1hhCpS12iFsvfp+bA1UghZ1wGarp99?=
 =?us-ascii?Q?JTVzzFk7+kxG1M/1bqKXPOJO5j2pm2+slMuMDGyN75f/Csmf9nlESbGQJRKd?=
 =?us-ascii?Q?akWAz/ikJlUEAPEsaf0ZuireL1Eupyellusc9HAf0S0mvFRf7TnJN7siYzoq?=
 =?us-ascii?Q?B96MKVh11q7z7PVCDkARDkWbuCprpDfiiQNtcnEKlVLVYZxWWIEk6C67Xnmo?=
 =?us-ascii?Q?F4ygKR1/Yb/0Rf1tmoPCE07U+su0CwumEkh1okgCfAcMqOf4OoNovxYu7jUV?=
 =?us-ascii?Q?rZqump5MYD7jC4l3ZYNLs+xUKHIwxmsXw6JS50B83Bo8dASTToLPVXEvW98c?=
 =?us-ascii?Q?BqerDgYyLJufbHxMpIBmU6fRNQMjwMLboq59MbpymUQ2qjI2nFx7qPusRNaJ?=
 =?us-ascii?Q?QSqNz9AhUiBFJE7ae2ETC9ESD4QKKcB65rg69vjqga49apx5EkU/XTUtjUMI?=
 =?us-ascii?Q?HzEfuM3xyCV1v6CM6R4F5f80+SqRIvFs4gV99YSmOZWfWMw9x2qXBnLkRZUe?=
 =?us-ascii?Q?WfcgqvHzi70WFYiWmAMJe6SUWRBOgAZRlu40pnvKRWs8M49cKhg0iY7MXczM?=
 =?us-ascii?Q?unomc5qgeEgEx6FZiUko7M6ZDRcqP1StfmxDvUNuS/BY7ki5DMdtEDH1nL8k?=
 =?us-ascii?Q?oABwIE65/vISMf2Hea9y3AM/CTyUI1h9HOcEjG4Bcp9MemXJK6oylYSgDxTU?=
 =?us-ascii?Q?/+DoHfQGbZAEsmOJ+8eLcFwz+d6G1nb3tB1F8DsNtWC998g1hr7hk0JjKreZ?=
 =?us-ascii?Q?E5x2ezZD66g1HyOERV+bVz5OuTvqEMN5uWPeo7QIHj3TohOF0Fp4Fvx/Wz7Q?=
 =?us-ascii?Q?vllZcTXhpal3M38dH3r1tj8cp5GJA/C0W1mhy2u0GJ8+NMCfhvIDsX+ikyBe?=
 =?us-ascii?Q?wuz0XE3pikCTnm22pbhGclrspj9nTd5LfaBNdb2UC3FStIntXCsYpqCml9fx?=
 =?us-ascii?Q?0fHogOJLeF+a5Yij+TKzaRCj8x469H8XOXSqRd8umc8rkuaqwpmOB+3OFLUq?=
 =?us-ascii?Q?Gk4eXKThaOAafrwjQD+FSZNshilFWSD00p23+4DsHvBcWQKIxwCSaziHGNPj?=
 =?us-ascii?Q?HUT2E8ML7U5r4N1H+2u3YQvVqYvdBJmAxot72k/7d8iHNyQXEjma5tGi6MEg?=
 =?us-ascii?Q?cZi/+qU17JuOGMLgrcmdoFB9w5PPYGs2QM+fBeGyBJKb/iSKFSKXC5gYMadt?=
 =?us-ascii?Q?S+ixLfhvBYvmwZErCupImjjPir6lEWozoHhsBCIYk9JFKMuQ9ABVCJlUvp+x?=
 =?us-ascii?Q?hUBQmDfnyuned1DYrSBjGStkDRcxpZ0Wbfq5wP3wymLlQtxgl7OWurayPQ7O?=
 =?us-ascii?Q?NVVSU+rq9CYSUU/NuY/cqiCGujEcwCD3OR0ZRaqJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a468b292-2de5-4ed2-c975-08dac8818d42
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:53:17.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtebZeLDOsCDxL4czXKykkRZ6hGB2qSpTymeCu1C+QcbK6vYsrgCf2kdfSKkwz7EwOf1BRVuKKt/vWPPbPL22A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8223
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Alonso <adrian.alonso@nxp.com>

pca6146 requires vcc-supply to work on i.MX8MM-EVK board.

Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Adrian Alonso <adrian.alonso@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 3f2b0ad51e18..e0b604ac0da4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -344,6 +344,7 @@ pca6416: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		vcc-supply = <&buck4_reg>;
 	};
 };
 
-- 
2.37.1

