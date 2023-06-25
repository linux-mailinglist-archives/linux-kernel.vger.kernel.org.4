Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE90673D0FB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjFYMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFYMh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:37:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E56F5;
        Sun, 25 Jun 2023 05:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PN3hw4yq7xytjMOcz1qAGnfsIFGaT9OdYG5mcSmwKddWXYMMGg7xJYkwbeo2MJHaT274QzhqzB/vxYpa8rybNBu6auSv3cy2aCH2GQexShrzhof+U4s+bKY4aiTZ2LDbxjrIjrqc8ObI0SfDJ2GPOYIiWUSALxvdteQrzuf5RBpXuY0Qkqc4Hc0k48uIMp/n8z105X/wATqaVYenhhgzjasyZ/OnZaqrOGGBb0VYFY0pj8EvjMrjmm9YSo2HzsfxCtrV/2l8gpvPh5dekoRGwsdD+9gHxU1GrrIIO7OXtZ0gGGtGY+6crIkH87yi8X8SmfwMc3BhxvKNJKt+AoHu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp40HZhMaV3BAbqklg6lJOSUHuiQWmRVJ8ZEz4xetzE=;
 b=BLiOOQK3RHu0uzNBxn2NYuvgQss4WgUIwbFibCjd+LVGuUzPhyfrP44jqV8CKYqyYXj3tnb5YL2WqVOrxxySaGX7RP6dZrNygCHVY6jA8ENPzeynk8IcR8Jm8SnHqIqfua5zesk1/37kiuU0dXQFD03pAdmK8gW5VHs667zg76DFE/ixvzhbcUrfXHaIR66Y78PxIugjrT40+3XVrCEI6kEumfmDv6xF5gh6C9a2ggzmn5lGM9r+L6WwmZnZi9mRJ0uOHa/MUE7ppz4iD/QQpTHsk7OGU2yBocstIN7a0JTu6dMLFMugLNaQYOfwXcsO9t3i1EMscprJyoT3tQGkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp40HZhMaV3BAbqklg6lJOSUHuiQWmRVJ8ZEz4xetzE=;
 b=KH4IXVKfOCD/wdE6mGZGnyLwWCKzVhM5uzg4mZ/W3CSdLCJXJ7UhFYNAgQ/iYgD2VE3BmT/JlxXS8jffHBJoCIi6GjtTxPJHhwIy/wAxzukdjO9hhMyN/fjnbj6V7tUua7GsXHH+ENWk64DdmJUeZo4mqZz5EUlGD+Ka0bR/7rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:37:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:37:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 02/10] arm64: dts: imx8ulp: set default clock for SDHC
Date:   Sun, 25 Jun 2023 20:42:30 +0800
Message-Id: <20230625124238.4071717-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 439656e8-fe65-4b52-a672-08db7579003a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwNuac30RIgx9UxAvvFjW1MqDAVK9Lgn2hRwJe/JdqPClCXR1fdL3+RcfyvmBKWDHSHlnAnb7libr1RMsZ5KnFygL52oMVWxFKl8PUEQRq6ZCfdhS+EuQe9Gi7tUJ/mHFa0Z2CTTmWzBrJ71F0JfHFe4BR9MwYltNaLT662jJ9u4TtukkNWu06wk2l1V4/Lo/Aa7Iu7hpY4GHzgGB8F4eYV2suIWhud8BE9l7LErnQA86Z02g2NJjAUURIZ3pao/0FhnEVtZVnpTC2D8D4k9v4MkDzfVsPZ6B3l6lX9sAJNnTzhBzbtmfkQ2YW7MOUmUvK6S4DvO6PvJujIJKHwR3aBrU83PV/FS0t3FSQGImBF2iYX/DqFQJc3PiIS0Y/1HucRzDjr8O8dI6CakLfkoAa/mU60Jd3W9ZQMDMennFLAR3r277KJ3Piye7jZjDv7MMjJgL2ZKU0CWs7cbtdXjVae9up284OCuiatf/nvV2uUUBLz1bavym0HfMe9MqRCCt3eFavN3wcYcQ128USbcO7At1NmLtTk6tglcsEQ5tkqocRClNeRaMgXrMO4gqAthEgmW1MMo9WQTL+VucyxKAvI+YHU01LiHZQpkq04aq4nwKSGWoFmhhL47Nl0fmA6SepmvYhk5nlNLbLqsqHjkCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(8676002)(8936002)(2906002)(54906003)(86362001)(41300700001)(6486002)(52116002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(38350700002)(6666004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pe5yzRWGkocRkvLS+4wA1YcxF+FnYIY0SxrFKc/nDtwY7OqdM6Sg0D7XD7+n?=
 =?us-ascii?Q?aPvh+dVmFeLs5tcrSBs7h1Dq4+Uc6pAua3HlFvt2MfYa4Z1AliRa3k3YOlYK?=
 =?us-ascii?Q?M7285TSdX6HOdnh7E/Ay2JXoZHKAvdIMp3o9wlF/l2Z6EOgGj3aZzPoumv3n?=
 =?us-ascii?Q?KdQ70bD6qg/OGXXzvRwMO3ASBhQn04EBgj2xUj9ogaOcjJ6YuXmCjJ+vZ3hv?=
 =?us-ascii?Q?H2GTm/kfV/GNvs+AueSweqL+Ow2r0Z9zOUY62LyIleKDdMDUjsE6ACxnRBOC?=
 =?us-ascii?Q?NefuzSy3Oim8U8s+ZRa/QWgZWxIle2Km0VuFny05q/i0TqIOEJrfHQulWgc4?=
 =?us-ascii?Q?upia5qdurTAjqH/s25ZNzuPjsc8TofEuDWjENt6RnEyfgEP/c+kaGL5VFwML?=
 =?us-ascii?Q?TlZ+VfBd2os3N4Jn49murW22l9r7/l51KBJBCWnLfLH/3t83xA3yJfIQwb18?=
 =?us-ascii?Q?Kxp7ND0VLB3un5EtcOAwD9uG64KDtnUdtwqqqkpq/vNaEK0cuFeVI6mn1zsw?=
 =?us-ascii?Q?dVKGXJh8WWP7tQsOZkcLtpHhnbeBWotxYUl2DEgQDL+tIfGvMMeLZ/rtaQ14?=
 =?us-ascii?Q?W1ko/wngnA5/qz29e57uZGHuZmIgbqE3rqF+Qt6RNqCBfTPcPs4qSOIVkUQj?=
 =?us-ascii?Q?SAPhJZ2YKi3LqrTxc6i/Nn83uaLNczB0uobFBAyFqCyyzQ4mOszJaJMfMKmf?=
 =?us-ascii?Q?KYdA0b6DkvpHKrBqJ7UgYUq9vS2Xo336jaCMYSMZrs2md5P8q0E4I3DmP5Km?=
 =?us-ascii?Q?/0RP2cIya29kuSXtkk8wIGSGidWq2IsvU/AtyUMxMpf2vyuhQ5tgxD8oDPG2?=
 =?us-ascii?Q?jdEEJkA3UIKoZeRJMfxtHdZEAKDTigSf//hirpu7adaPqYn7/xlb5Bco4wOS?=
 =?us-ascii?Q?3zVbgRefzPfsMcdCNKK6q9pfgPdgdIHAjM8W24dtDrIM5H+L1y13jnrbD0oQ?=
 =?us-ascii?Q?ATkVIdwEs6jwyf+VQfFfO1Uf6gd/IkDvkSc/nQHR8YmKfSe/miNNLhl7NmM7?=
 =?us-ascii?Q?SUtD/QG1Avcpz3bT2PKuMTwEVpOc+hYrUqUZ7XbZZZa9Ty6S+5neIrbV/gUT?=
 =?us-ascii?Q?osbjwXrhokHKxfIALQvh6UWhoIyoOMLAhYAlUMXsRMUCXi26u9P3CTqjXyCq?=
 =?us-ascii?Q?dSyds18C6uvO1lqV4979VTPGTzQEQ8+JthgqsBmzO+LeYe1sQH+XYyqdNZNk?=
 =?us-ascii?Q?N+XqrAZqFimPf+7uljnOxWpeBkEEUzUFlQ22wZ1e1DUoUKOIfNMMLryXGPD4?=
 =?us-ascii?Q?pX6DiG08oVXRNIOUxxyO/F7pjxwv5DNAmL5q9TzdNPPkcX82/DQlPZIWNwO+?=
 =?us-ascii?Q?ReFwAo28iqyB2qefk9/aeUK9fQMJnhQyMpf7sb1Bj5dq9t632LEsY7sXH5rA?=
 =?us-ascii?Q?YXTVZ5YP8pe1W4SpBBdM9bv9m8Hduh2+31EZe6KckkdDsW9fXvM6EQU2nXSd?=
 =?us-ascii?Q?v8+NydoKlhrQyeJhs+vrX+Qg7VgscRB2+Ya+UPJzNXWEIDaIbRG7qeJzjhs3?=
 =?us-ascii?Q?vSUKgXxSxR/Uzw3WKFjQ/gSR0y+ngHNqnT6quvUJ+NkPYJl5swdose6UWt0T?=
 =?us-ascii?Q?RlJ2uGakT7RFAX/Jek7oaAfQ7YmAeQL0lLgSs1wI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439656e8-fe65-4b52-a672-08db7579003a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:37:56.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuQsyoV18TD+EVIoeyq8vC0T42rWJJTPwv8Apig4ppZq5/hd+MOvPEJ+fKfCGGt13UrJ/joNs8DjZYysd7GD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Set default clock rate and parents for SDHC[0,1,2].

The PLL3 PFD2 maximum frequency is 332Mhz, we can't set it to 389Mhz
as USDHC clock parent. Because PLL3 PFD0 is used for NIC, PFD1 is used
for audio, the only choice is PFD3 which can reach to 400Mhz.

USDHC1 and USDHC2 maximum PCC clock rate is 200Mhz in Over Drive mode,
and 100Mhz in Nominal/Low Drive mode, when PTE or PTF is used.

The patch adjusts clock parent to PLL3 PFD3 DIV1 for USDHC0, PLL3
PFD3 DIV2 for USDHC1 and USDHC2. And set the max rate to meet
restrictions.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 8116d6eeb738..ba0edb9a009b 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -370,6 +370,10 @@ usdhc0: mmc@298d0000 {
 					 <&pcc4 IMX8ULP_CLK_USDHC0>;
 				clock-names = "ipg", "ahb", "per";
 				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC0>;
+				assigned-clocks = <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV1>,
+						  <&pcc4 IMX8ULP_CLK_USDHC0>;
+				assigned-clock-parents = <0>, <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV1>;
+				assigned-clock-rates = <389283840>, <389283840>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step = <2>;
 				bus-width = <4>;
@@ -385,6 +389,10 @@ usdhc1: mmc@298e0000 {
 					 <&pcc4 IMX8ULP_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
 				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC1>;
+				assigned-clocks = <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV2>,
+						  <&pcc4 IMX8ULP_CLK_USDHC1>;
+				assigned-clock-parents = <0>, <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV2>;
+				assigned-clock-rates = <194641920>, <194641920>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step = <2>;
 				bus-width = <4>;
@@ -400,6 +408,10 @@ usdhc2: mmc@298f0000 {
 					 <&pcc4 IMX8ULP_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
 				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
+				assigned-clocks = <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV2>,
+						  <&pcc4 IMX8ULP_CLK_USDHC2>;
+				assigned-clock-parents = <0>, <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV2>;
+				assigned-clock-rates = <194641920>, <194641920>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step = <2>;
 				bus-width = <4>;
-- 
2.37.1

