Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8862D782
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbiKQJyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbiKQJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:53:16 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E4D74AAB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:53:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/xBFjjOlUi8xdU1UOYXURpuwAGyk3RHC376UAAe47WKKW9sqUzG2thjEhZrYTz+DHjqlgZr8T+9DfJ2gETVNZbJW94B17i4Gp1ELH8uOSZUc9dSUz54zOZtBcyKnlKYpCBzbL0Y00d7f4pxijcTMAH9QUvgakt8X8ld44sAwu8C/qmm5W8lvSUiG9nVWvysD8ny1ltVaOUf5iKLoUUV50SSR7J735a0NRd5cXcDW7B/PtPVN1ZU4CRzYlZVqdLyuMvi4L/rZg9hWC41VaWFkSNeXYqXUgzRoKIfO4v8rD3Z/nWdBrj440v4AzUF1M6oc/UiZovDuMZW62b1AQjz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FAmzwaCWT+XnB9FRuY7V9dh1frfjMW9F5SAk26BPwQ=;
 b=IVbnbdHaebNR9Iy0rzVfZhi9iZGyK1sQiaVM75pmDp/Y1BVOZPZXrcZtv65ZDOySij2XVjZTbZQAIUG16/Y3+y/8kHd0c5X62RNWNhAq+aL+d+BhIUXpTeamO+ZGQ+sIImnzDNI1+pCGpYoId0BvR+ykb05RJnYaXCSb0gH+x2qyTXR9p98uR9MeSAriHabktMQV3lrUnApxK31XFTDFes9jorckEJAgVpqF+VJJyOvsnC/prMaF449iY/FnnFnSZhFQzeW/I65YNa6NcVX+kxp+UOktW6onv+pbL8fOzAmSOjzFKPD5W90q5ZjZisF/NjCo5IVQDttUj2JTUczE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FAmzwaCWT+XnB9FRuY7V9dh1frfjMW9F5SAk26BPwQ=;
 b=IkTRISV8DNUn12VOu9wRlaLiaEWelGoinRn1/acVsdJ3KsKSe3buVEiW2T6L+96AvFh8DhJqFDigEAh38mB+ZozVmDunmpjJGZEVhJBYqEbD6tN4VrnVUh2Ydk4/Qp0QMO+d1VfebpMev/2fxZShOK2hRLQwkk8Jq1RdkpXjbDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8469.eurprd04.prod.outlook.com (2603:10a6:20b:414::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 09:53:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:53:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V6 08/12] arm64: dts: imx8mn-evk: set off-on-delay-us in regulator
Date:   Thu, 17 Nov 2022 17:53:59 +0800
Message-Id: <20221117095403.1876071-9-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f2ff80-1f12-452f-452d-08dac881852e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P109mXELzmuvzWETwO2ZUNkZoiJTevIcCBNoh0sQ5mqeU0qHV2PkAkLDFyTS+5oJkQpK+/0MqtplT2+uAavYo0vabDjHDvBDWwQY+T4jcBVho4b1FuUYefuRzmenXzbHDmkCqNwDStctOtMwtp5l4oWAot6JqTOJPjQxwPUXhMbHpdPGcn65WvnpDt/fZAokVOwba6vMDLez3GgPPE4iydz4qjLWVDuwyfYPF7eeXcXJ2ZjfrrabpZEFvb2m/A1wd/nw/LLTPfc4RMNHVpRfYDwWa1r3XEJJ08HpMcTfl71hTCn+Ol2v3uDfB47HpKJCeQ6ob5BWgYDfKKi1vgPZoiAZHUwEZ4Cvw+UsTnFUcJbHbuKKQnJVUSEErzjnhzaKbNvJI6qdj+SPL+VtLgWEqdQOcS6ZIC9h7XlPW6mClng+o+Sv1iyFc0tDujuY/OAoawGTPjWabmrLsDTMGDbWQrl3hgHIDiFkasFEhq5sWda99n28Z1Kb8750X/Fr1XYLUyb7vSrHrJeQKjVhmhJpypLnFUQT4A16xMLWh2HqchD0hyRwjx9voro22ZHfW88Z51dOFjmd8jPvvkMj18OCeiezMdsmIs7bDnEZVlJ0T+kDlQeyoZ5u/4g9AnCHA/Sbpy9LM+kJ+qdrg7kBjfW5lrsZvXKP4El7OPHf43z9Ak3R2K1bMun/Ja0/gYO47WbzNM3/9bxScWjk6x5L5LoFy7XnQ+QBgCeP6xg1c+PjbkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(66556008)(4326008)(66946007)(8676002)(316002)(66476007)(8936002)(86362001)(41300700001)(5660300002)(478600001)(2616005)(186003)(1076003)(6666004)(6512007)(52116002)(26005)(6506007)(54906003)(38100700002)(38350700002)(6486002)(83380400001)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1dNcGCXusozdK4vnoaixbFEGtlpVE2rWHmj31NwXU8hKagOZSMWlQhT/N25g?=
 =?us-ascii?Q?Z058ovNdp6KOvj/bIsIOUBBkorlaFFmvRwG/F7K4rP42jRQa8mH28Jt0VLHF?=
 =?us-ascii?Q?+j6wo+jImdinX2x2j4ZbxbcFgw5mxeM/UJFOWhOWqqwZiENprWk4zmMGykiN?=
 =?us-ascii?Q?FTjF410F093REkMVc5R3yTnm71zy1ID2Aqcc02KtMfSBzYSrN63PRA7+Z0MF?=
 =?us-ascii?Q?N1znbthO3nFG1dG6Ve4ckxwL03TaP0ykJ5bCTTno+CPej1UmSaZWvG0MsuEq?=
 =?us-ascii?Q?2Pc/9lh+ac9gOU0MxTPduNgbOIoywy7qwqDdsFLIZtWZEWeKEmRoTMEedvaB?=
 =?us-ascii?Q?zJkTqLY8eHsX6ErZXQrwk/nF9eHTSXbhVzky0sU0uADNWhdfuE/+OQdWf4zc?=
 =?us-ascii?Q?NLUH2AyAy8Ts/1kBCS408ecQ2p6Fr2NeMlBTuWXuXwfs1ZmykzRYuiW6cEhq?=
 =?us-ascii?Q?uFI+QhMYVZJ3XVRXE5Di9PUaapl6i/pxp3Y6ubqZV14DXKV5lI1E5FTpu1w5?=
 =?us-ascii?Q?T0VizdlRh3eWB/9D+VJ96i9inFHrxzJnXqk3WrSPqmEQAutWCstt7j8YxXLH?=
 =?us-ascii?Q?4GDWkfR/hzHqD2pKQ7bVlkO4kdRa1dhsx32OrNiJRG9JTgAYDDAhz20HaoVp?=
 =?us-ascii?Q?F00tPmYioquelZM3b+xwtaYbNgehh+pNfn6t4Wd4rW6drhzLTayX9CJoIDOA?=
 =?us-ascii?Q?1zwkd3ro+is0h1wuZRCu17kPwGtKNw20h2eIXIQ23cdeFFrNW11wzP/6zSty?=
 =?us-ascii?Q?J7cXjDDDxMgH6UZuXEKaCk/xU7lbF5Sa/a42uC9vd0wshTCPt0GZggXbo4Ua?=
 =?us-ascii?Q?+q1Vcr5JsKz+NS3A93InPaF+nc6J1DmmLcJs7JEoXk7PjdEz+AJFQmUojYme?=
 =?us-ascii?Q?YUNBCfg50yL+n2Me2WFpdtEx3Osh1oLaBt395fwI3id67qBqIPso9SXkwGhz?=
 =?us-ascii?Q?HOL3LSaDIrwTBSzjaxGzLA7GbQQGDRRKizKnoBRe3coWMk7VEdrk4toJfTzf?=
 =?us-ascii?Q?P3Wr3PnIldYsMtaN6Pp/p++nXnMV9zLDu9GLXQw1j/40gMT/2WJKmL1cK92H?=
 =?us-ascii?Q?XCL9f8gy6QcRTil88aU6LmYaqD61CPsaQXbSYo3NQsQrzNd5yv/yFoIK25JG?=
 =?us-ascii?Q?ZFfy+zxbYJKCBeN+keNG8Mmez1hXtYOuBoe/Xgp/Iv3is6Y6W20kxZ93kyo1?=
 =?us-ascii?Q?t/4ApyLvnzbm5BLb6mzTR7pt6FiiCUn30l1yPFYHMZp52B+xL4s4w3XIqTKY?=
 =?us-ascii?Q?22mVtzoIMWxeOdeu/VjciUlNrsn3Msa3fBn9x9UZyRy4CCnZdLh8HciwJd5Y?=
 =?us-ascii?Q?Jrq6lb4WSHj7zB1Xupogy4hfbzdetAfH91inmjLCinqtXw6Dfy3tBht3gCMj?=
 =?us-ascii?Q?08/UZA+QFvXlTg1PAqYkafSRqqS41w3ZiCK7v85DOHz9LxUbvHYuGimadX6t?=
 =?us-ascii?Q?r0UlmaC4GVDUB8u0a41K8yiRY80refUy38VRWMzi2Lu9DPUlEktz4jdvhlRr?=
 =?us-ascii?Q?XDNV1oz1t40a0Kl4LS5rqbiod/2q+KTXTo5Fb0Xi2jrLasC0WWizgntobr6w?=
 =?us-ascii?Q?bqitAdXboPphYCU5xK+HcNUvswPSKI6rCUMgWSE4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f2ff80-1f12-452f-452d-08dac881852e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:53:03.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FZERm4peF7bLNfMtPE5Jra5PniaTCx+8cL8KYbAPXkfIJ7G1S8xRblBBulyhP8SZrzDwBompNkCHyMfi0S7mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8469
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Some SD Card controller and power circuitry has increased capacitance,
so the usual toggling of regulator to power the card off and on
is insufficient.

According to SD spec, for sd card power reset operation, the sd card
supply voltage needs to be lower than 0.5v and keep over 1ms, otherwise,
next time power back the sd card supply voltage to 3.3v, sd card can't
support SD3.0 mode again.

This patch add the off-on-delay-us, make sure the sd power reset behavior
is align with the specification. Without this patch, when do quick system
suspend/resume test, some sd card can't work at SD3.0 mode after system
resume back.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 8cb87c7a0f03..e066fa9af834 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -36,6 +36,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <12000>;
 		enable-active-high;
 	};
 
-- 
2.37.1

