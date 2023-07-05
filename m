Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25AE748F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGEVAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:00:21 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CEF19A0;
        Wed,  5 Jul 2023 14:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neRL94PpJDPHt+XT8hw0KtHcG197PfP4j2J4UlMb/DJGDZCrFrWXtwQxmLZm9yM5gdtCFC8jKQVP5OvX3Ko6QfxBVVB1vwiLOcUrW6owU3U+ELpE6i0kRp96QIcWbTplh3+SIMfcG3FxX2cuC8iD/ODldi/U3gbKHu+uy4Lwo6fPRdDLUgc8er8dqSNxQDMAY7dpY7YaHr/F2tX8iF7o49ycGPytQgaKmhCa3BS/9SirU/juTt5mSwutFYuLa0E5EL/fMaUXqxrWBFUFFLv2L8mKte7YoBtFR1yuNrmVI35rky0oIAwugI8bOpQgljW7A8qF+UKqApjROHTQ57uBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmMnOOK8zn5S5vlxwTygfb9iNS5lJg91+f2/hio6QJU=;
 b=FBl2pS6q01Xy8yd70MHrv/hZ1lCUunbeDWD9+bc4b28IJHjRmXKCKwfovXhLNpsMyzyJiEK2h+LRFIzh6RUWCOdibaqEnJ9Fye85CN7sHtvJC3TtrQjfM0ZFGrBR3o8AkHpvZxbXvv20eXyfJG+ONAUhwGlpBzeeqZPRFHaXmnzxUH1j8A1iA6t1Y/5MSx3u+Iou8swYBvtupGWuouXawcZKqEfNE/zoYi+lp1bMeVZ7L6m0F7/dEz0atVY3EQIbpMUYj/04GCmYbckdmFi8WLk6JzPzYxZULJQH74MKUtR9abtaiB+PD7nuPo5kK79RCD2qcJmmcAgUWRFs6r532w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmMnOOK8zn5S5vlxwTygfb9iNS5lJg91+f2/hio6QJU=;
 b=YpymCV/V9YcoK/83l4UmoQD/xVTnZ6EWcn+8XQDW4nR5/xp3VzQibC8LXYo9bNcVxcdBwZn/EVAPVkZyDKVx79jjzGtnPbTb2fTHkmULTQ7EWgxkr6xMy1JlGlAxqcawtnnLWuuAuXsFFO4N34Zcx3sj/zeV2SNJMMXG/ixJ98c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VE1PR04MB7389.eurprd04.prod.outlook.com (2603:10a6:800:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 21:00:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 21:00:17 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] arm64: dts: imx8mp: remove arm,primecell-periphid at etm nodes
Date:   Wed,  5 Jul 2023 16:59:53 -0400
Message-Id: <20230705205954.4159781-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VE1PR04MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: 4515e9ab-3eb4-49b8-c5a7-08db7d9ad5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbxtAPAxDYVBL3trdOYNUp3AgNOMQs5bjvsu5X0CV3EGT7Sp3B9W+/uw/7V/1yy7qAY2qrrUjWMOa+4rJ2DkWxz9MVgFV1UFMK3+Nu5eYmWkrWaOwoCQeXx5IN7VryZM8+QK48Mx5ANmcVZ276H6/0sHzRDbRlTd6hHAtBiOintdeXUJhXnvVZsCRXSuKBl+EA795+Nx+9CJgHowW2dp+OStDcs+wZOicsEtz6pZx0SGyl3jYRAaoq9X7RJn/wDITncCsq+A6m0aTgaO2saNt8uSAbz1qaEV8IKBx/dllHa6VozXDmtADh4WBcRo/Yne7Nb/QJOoIOfHyfdimKzNVy6J/OxmV3Ke9lGDlWf1bMVhnDIe6YsBbJsjJ7YC4uWcxlm1qgOmSWCqh7rVkVTg3dyFGVicPCXofZWTtLJTqKM5zh2/yPaRCpiHtZiB3a+/Q/zwO01qOekUeH+3fh9u4t+zDV2vteqeNtI/tTQNjmTeXjyknulTk6MW355zMiJord9oH7dbp/WOhAmigj493YqwBhzbBJ3sq+eKwD9CMEIjCKNeA8s3wzVqA2nqWsFtfs1IS2Wyn/RxZuCRdYX6ATYwdswWXINMOZkWuCYxX0sw+XD8cy+FQ7uBHU4OfJsHHc8B5/gpKU81wU6yKmFDaSHfCP8LPq/0oh8LlCO4fo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(110136005)(6512007)(26005)(186003)(8936002)(52116002)(36756003)(86362001)(8676002)(6666004)(7416002)(5660300002)(2906002)(6486002)(41300700001)(478600001)(38100700002)(38350700002)(921005)(1076003)(6506007)(66476007)(66946007)(66556008)(2616005)(83380400001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JN5EUKHX0RkHSqMux++DHXuplQtjWbui8x0IoofMT6i5LO2mys5XXRiqFX6f?=
 =?us-ascii?Q?bjFPTGlTU5xaMHnc1xhuf5ezP3K/v5YMh7fJ14MqLlM+TkN9c8Drx75hiDgN?=
 =?us-ascii?Q?hwyMN67FNbjGfA4h1Ryz6Pijqo0NiYHvDTKwlbgBXly8Aa5KQiCpixg9IgxE?=
 =?us-ascii?Q?PRdyWU1hyk7FwK/h1zMzvZG6tjwcm44/dSwDnFzsdh3QWhKIY8MZQGcv0NK6?=
 =?us-ascii?Q?y57ey37iATb1ZmU2KjlK+BP46u/OGvumK0eXtbhbqPJNOwz2m8uiPVCbiu7O?=
 =?us-ascii?Q?ouqKOnhJcN64fb22NXeWbNjwGjY6/Y3RUQFBx3HOFczLA17BS3Ek+2t0nj2B?=
 =?us-ascii?Q?Xy0yPijqwZy5UIjvb40kLDcBTrg71PFr3pHeZ8bKdVSOTBuzINufq3rNg960?=
 =?us-ascii?Q?r717rJyvJABNbVvlSPK6b6/qkIVs1swrv3vQ0fWTMPOm6irADhux58IXDgvD?=
 =?us-ascii?Q?WcEmce6dUFOCoR8H/SJkKn++/f9pXQRSjx17kDxFpJfPf5tZwns7yT+64t38?=
 =?us-ascii?Q?qObcW12+8z18nTmKGe/wgY8dAmBZuE4d+hTFkIV2dwWoGP3OnM6QZVBewHGa?=
 =?us-ascii?Q?GWxjMrws6RcrmNSQ/NvfSRPQgEQA0M02xXk8YOkqSQ0YfKv07LsITKInhOId?=
 =?us-ascii?Q?KuFYQxy0z8tgcjD8B0TTDItitwg07OhIYJDsPauspcKLWmA+NaliaG1VcOcE?=
 =?us-ascii?Q?X33tShG94SgKfZRgloOZQzrTZ2/jTixsBVmTroOC6BHzj0eTvsKL8JoIO5QV?=
 =?us-ascii?Q?rJN8194XvTACizkj/gpy4j1hSbKfyMHls8BDm3tJRhEROxJo/m4kp+NwZePH?=
 =?us-ascii?Q?tVEoaqlWYMyMXIiR70eKzGc7iSo6lkK8myAGxttzjVhwslGLLCCOzzv1WygX?=
 =?us-ascii?Q?hf0/oI71nMUMB+8nXMhziddvUSlQqnVRNP7L9t0Ohls8dm7D/evthJzqg1EL?=
 =?us-ascii?Q?Fb5dw88XDMLbGE27b0IoKNIfmaiTIcfhekv8iZErZSRWh+kHGVbtwOhFwCZe?=
 =?us-ascii?Q?i8OVB2DZmp8Zk8lA6X4MSFcqLGcnmbwWzJsmkfytW6OaEOcxLxr82vpaDAvX?=
 =?us-ascii?Q?CE4lBLB46pjohneeQiWD5rye5fs8u0r+lwLyhdFsMnq9CItCk4lDkaaRtqNE?=
 =?us-ascii?Q?vjRyB3vxJVOGn7py+bC5pk68SkxQN0KlfyJq+X+yUuZVqaQyuKk6RD+xNyDB?=
 =?us-ascii?Q?AlItqDBLH4K/q7IUg7zGrIJ06MQWrxArNrDvgQxnMbncucbvvIG07m6wrPaF?=
 =?us-ascii?Q?gyP4nYVbMgtID5AbSdE1jmUskVxWuwZbF7xXwHM7Mna+Ey7/4/32ooNPXamt?=
 =?us-ascii?Q?6aRlqKCIC3T6A5OkOmvC/xif1N4NRMsLuEEuJv1yW9q2hqmNzS0QezCM/bOU?=
 =?us-ascii?Q?VHtRtKC3RNdijjlmIisRGmwby7W1K3l42+7y71fqw95de9lqpZxQa4io/cNq?=
 =?us-ascii?Q?oXu2ujwRiuXnf5xMvXKR03o7u68nrAgVadZOt5X3jYnU/nxH5U2tq4/n3X/x?=
 =?us-ascii?Q?RTO0kJG2OarPyAYDb6MmMWTTU8PmralXzgJm09j7CyOmXWD8DhHtnUE9PP6d?=
 =?us-ascii?Q?h+/PyepTdzNCwTReBlyjdWjhkImj0cvVat7wNtiQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4515e9ab-3eb4-49b8-c5a7-08db7d9ad5dc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 21:00:17.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USCwHWhtQCUy4wHqOf7y84ga6PNlMvQ1VF0BTXC/I/240xfwtUJDsepCMzmqd7X34912C9P+SoxuRT+mp+k0lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7389
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reg size of etm nodes is incorrectly set to 64k instead of 4k. This
leads to a crash when calling amba_read_periphid().  After corrected reg
size, amba_read_periphid() retrieve the correct periphid.
arm,primecell-periphid were removed from the etm nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index cc406bb338fe..e0ca82ff6f15 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -306,8 +306,7 @@ soc: soc@0 {
 
 		etm0: etm@28440000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x28440000 0x10000>;
-			arm,primecell-periphid = <0xbb95d>;
+			reg = <0x28440000 0x1000>;
 			cpu = <&A53_0>;
 			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
 			clock-names = "apb_pclk";
@@ -323,8 +322,7 @@ etm0_out_port: endpoint {
 
 		etm1: etm@28540000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x28540000 0x10000>;
-			arm,primecell-periphid = <0xbb95d>;
+			reg = <0x28540000 0x1000>;
 			cpu = <&A53_1>;
 			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
 			clock-names = "apb_pclk";
@@ -340,8 +338,7 @@ etm1_out_port: endpoint {
 
 		etm2: etm@28640000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x28640000 0x10000>;
-			arm,primecell-periphid = <0xbb95d>;
+			reg = <0x28640000 0x1000>;
 			cpu = <&A53_2>;
 			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
 			clock-names = "apb_pclk";
@@ -357,8 +354,7 @@ etm2_out_port: endpoint {
 
 		etm3: etm@28740000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x28740000 0x10000>;
-			arm,primecell-periphid = <0xbb95d>;
+			reg = <0x28740000 0x1000>;
 			cpu = <&A53_3>;
 			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
 			clock-names = "apb_pclk";
-- 
2.34.1

