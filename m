Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46DB605C07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiJTKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiJTKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:15:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B70191D7B;
        Thu, 20 Oct 2022 03:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6bjquUNRegqV5oYpcbOU6MJC7i3fqjW7CDksdHCMge3kUye25eUuo9PAAz04PXCeGaP61qJdv/3XKGumPLj7fUMHmKV8A7L4WgvR5uE1IIXwnZLpNhc5jjOn0peBhqtcM1rPkUG+VdHeHGecX8W24Cm0lZMWs6Fr11Poy2nd1p+mySMXdMORZ5mQ1bCHTfqur+OkTfh6ONc1gUZ7yBlaTD4TSvRiSSFFr4NAGesmr/zpglj7+Q9u+DbHR+8CBJfcDEMK9v1CIZA0Y9nigJZ1CcDwB1IH+6vwKgNgGCNek0qIucFLy2KcWGGo+bNqWLtV8ojf9cwrmhSohp47FV9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iSOyLDIgqgO4IfiYy/fBA4Rhqxi1OPj/b59ZviL7Gk=;
 b=adz2fQDZi0799a+Rdbs+39tnjTM+Nc2kGql4QD77oDfrw1kCVl8dv/qwd8GSoBMLV2Un6rpa1qu39YpbnEcBmmX624doKuFeLVrMzdVAKjJQcfDqSVsdBnJW3Z/PlJ6FHp+zJCiw7uCRMq10VrkaCgqpeRvwez4wICayxuImgKFDy5UC4jY+0RZy/XVhY4MtCvrSIRc40YLAFTwVoZAaUJhzGjXpuVRZefSonc0AAPVFJadr/Vvdrjqn2nLa/E3iEMUST4KBISIZrCH3VJn8SLi+tut9sK30lJPzO6K5k4oUprLm9HQFBqCDE9gpM5h9vbfdNQJm5b6wJSLlDDZ5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iSOyLDIgqgO4IfiYy/fBA4Rhqxi1OPj/b59ZviL7Gk=;
 b=B/jyJNlR5kNxXk//ZfTlQY9+c2IdFgA1bw+XH2aRXzugGgnjwN1ZSG9+QmY9eooaq/uRU8flCrNIM+Gn9LX7kmlYSEKYsXQqIyDQQh7aD2uGN/u5vqAVN1UqsurqumpfNBZDo+rJSNk0HiJuimK6h5SK9t3M7L1zoDB0PsEH2UM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8177.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 10:15:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 10:15:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 2/7] arm64: dts: imx93: correct gpio-ranges
Date:   Thu, 20 Oct 2022 18:16:57 +0800
Message-Id: <20221020101702.1867188-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
References: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 79477bf9-4880-4377-80f6-08dab2840f11
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRrUb9cwTwfWi2oe2MI8bk4uE7XDszXUzA4rlIGaUkqfclBmeL4Bsm0zb9R0kKazMsQz7P6ud/BVLo+UdOasTdKoN1H8p286uymgXXTBL91BSJUuvgO/YA1YMHWSOCuv282dZWdXLRZAyGpqRUdHTQsXxbOp1pD9b6Exe7/qH+z7v9Z7aN6BtIsk+dpbEAsVfhJQiOlUS9M6FmGBg63YtXQRcbi5K/7+bGytyGyqg3gUrvZBts2HZv5ZcM+n4T9gPj+nZjBlOPGSKh2croVITHNdFngoW+GDXBnAmye+pJN0JvOtAiEWut5PjOGqqzsdIT7fIbwgsqEnouexIm8amdq4JRBAtv+dHa9TcPRlNgYRUrS5GFSE7fcnoiBguXE2PiDfCl9ZYRtY4ppzDr2jfTzY5O2Au44MMIoQOst2kA8CmJ39nW+/I9lUqwCPj6hNTdpM6/Xw7d9osC+ztD3GwE4D50+Rzm/7Q6ShOTyYvEj5sKEEL0l01qz99YsdmCwyMmoJXUiqPygV8l9AhUVZ6fnpXcX7jDaGFp+f28SUWhWEo9joIrC+yjEu1GIlGYTjFiX6NwhE0Opob4NOjcpte2lELXaaCnBqI4Qco5FGG4zNgiS19K5HEi5CmvSPCFxc90jA0YbiUJGuuGYPOB2xt5bfwxLGCsf04J1hM5SljL0uo71aGWxU9bEV3HadL1EXZMc7KS6Vs6+7GQFwIdbOGEzaUGaJPSbH16iv0UCmnbbhCojjVd+XlIt/OzjzOyxZjrwanQZiFy1eySKlckqtEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(86362001)(478600001)(4326008)(66946007)(8676002)(66556008)(8936002)(6486002)(41300700001)(316002)(54906003)(6512007)(66476007)(38100700002)(38350700002)(186003)(1076003)(52116002)(2616005)(26005)(6666004)(83380400001)(6506007)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?44UGFT8Rs0SPHhPl383vr1UqbsZ8of9fIRkF1naQKKLaoVl5dH7DyI0jt/wc?=
 =?us-ascii?Q?jzRlq/PM+wHtywNkhR5RhJ+bQC0yn1Bh21X5uyvMUFB/n+BTIL86bFJKO3UU?=
 =?us-ascii?Q?ngagTRHYACaZi9YyMn4dui2ege0F0f1HYDRkAnN3PtNppyGHGVfFzcOar/LX?=
 =?us-ascii?Q?1foestQ098mIAOCT8utXrpbLZQUn59Rm7++ahW/vl/p26JHx5h14n0BmYSy4?=
 =?us-ascii?Q?s6SF4dUKk2OuUeXres7jmOarEaLY3tZKpLZiu1RNTussxIJtymS1oiozNP3n?=
 =?us-ascii?Q?Nnn8iHQE6ZYBA8Kfwnrs8pKuBL1M9G2bD3EvQO9pWsjD9o6fcvkG1movxDW2?=
 =?us-ascii?Q?Zp1t6FpeSjhQjWSG4q74WK/CME/PlCuqTQAvr/sIb05Z1W/5W4ZpSn72qutf?=
 =?us-ascii?Q?BG0Cm7ej2OtdnNWp3cY+YpSGBdMZCuXa6CfvhPVJtg6liZZojykYRX2EgKUm?=
 =?us-ascii?Q?mwanCsPfXf/zLwGaflUegkBA7mHGAS7t2rJgb1gdc1PHJCf4jIfu1a4ZlsPs?=
 =?us-ascii?Q?nxlO+Tx34ceyH3ClnPUZ7uKJhuYXDgjbHF2ob+yaK/bljZcLOcedUnslJHTK?=
 =?us-ascii?Q?6VXnud5RxeziEmgJMn4/MtezrgWSphV2SOUAfLqLTeXYNjqv9qq/+PWTC92g?=
 =?us-ascii?Q?PbUKcffveOGNnBAv8RSYMHGEUJz0YcdXiytxnj5rgIWMXnmRK0eHs2c6NxD3?=
 =?us-ascii?Q?Ibm2GWSfK1GlrRU41uH+as6v4Ryx3ulJyhRUYiebANjXBJ16ARXvjfh80+3L?=
 =?us-ascii?Q?x6qdHq/pLp4hVtE3/lAhdlkTYTKe40ez+Fojh8uh4J+/nHiUJORW0GCkJ39I?=
 =?us-ascii?Q?1L4v9AGZyBUt6esqgz7F8bEXbsTcn9Xa5/kg9Gl5DzAG9t3o/7NdW643Ji9O?=
 =?us-ascii?Q?44kAndOhKVqJHcgNE/kjiA6ZqnMAAvIKD+icbPf8yn1NhCGgPqd7WLoa3MsP?=
 =?us-ascii?Q?JcckzHgz1FlOH9ewZxMMwHnA8Mfv1yt2DZ1QplGsojPEn5R65qiW4/bEgslM?=
 =?us-ascii?Q?+5R8UiJniXpxh5ZTg3W6ILELlTtV8Kd9PKT7QXgcjOukHLLwYlvaw3ek3wZO?=
 =?us-ascii?Q?c7IR6wLXxqibSlb7lqvx1F39iTPkB7cgAt8OMJgZQkiU6pcZjKqJ99hybaOr?=
 =?us-ascii?Q?d/H3+mr0wZcqLD4l4VAZO8dQ3fxlTKp3XuWPjPsBhnwdSUq9rxfU+9h3U1Xx?=
 =?us-ascii?Q?HmihTNUuq3ZCo9Dx2sJsLaFKhX/6uOhdBoKPqN6H92RCrwEumXgbuap1/qrD?=
 =?us-ascii?Q?hrtIwgViuGzXmd/agfhGiD5CAmQhFbiJHc/obKxn6p3+q2YwpYO6lKWAxPI7?=
 =?us-ascii?Q?DSpKnCsJvjW0nXKL0j+eD7pTDqRIwpbUXzF6aSpmRyeddDa2HY/i57U/ldH5?=
 =?us-ascii?Q?0kYxcUD8R4yOQvAsXAdUrh4TD4OJ3vQlpumAk3Ceb9igRJwX5WH+yUCXGmXP?=
 =?us-ascii?Q?ldJHRC0Y0c2+C+awnK6ciN5ViW83suJRNExe+xOWeafvZby3trWlSOl1w8vL?=
 =?us-ascii?Q?CmBKui0UHYzZdfRcXb7ePSDpqg5jLBYM9lebK3ZyiRmaIh30BNk+JFcxu9f4?=
 =?us-ascii?Q?OIEbvDjUkD/p/0auAXwxEcwx9j+G2UhKrYGpyMa1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79477bf9-4880-4377-80f6-08dab2840f11
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:15:48.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PEUb74+FgPdqUvFNqBhSRp2uO2aYW8w2M92HzLuP/uX9V6zbuq4SurV8Z4xqU0gn50QqHx9NB8xrc3AfjvpJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8177
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per imx93-pinfunc.h and pinctrl-imx93.c, correct gpio-ranges.

Fixes: ec8b5b5058ea ("arm64: dts: freescale: Add i.MX93 dtsi support")
Reported-by: David Wolfe <david.wolfe@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 55a70ee6f91a..0247866fc86b 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -451,7 +451,7 @@ gpio2: gpio@43810080 {
 			clocks = <&clk IMX93_CLK_GPIO2_GATE>,
 				 <&clk IMX93_CLK_GPIO2_GATE>;
 			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 32 32>;
+			gpio-ranges = <&iomuxc 0 4 30>;
 		};
 
 		gpio3: gpio@43820080 {
@@ -465,7 +465,8 @@ gpio3: gpio@43820080 {
 			clocks = <&clk IMX93_CLK_GPIO3_GATE>,
 				 <&clk IMX93_CLK_GPIO3_GATE>;
 			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 64 32>;
+			gpio-ranges = <&iomuxc 0 84 8>, <&iomuxc 8 66 18>,
+				      <&iomuxc 26 34 2>, <&iomuxc 28 0 4>;
 		};
 
 		gpio4: gpio@43830080 {
@@ -479,7 +480,7 @@ gpio4: gpio@43830080 {
 			clocks = <&clk IMX93_CLK_GPIO4_GATE>,
 				 <&clk IMX93_CLK_GPIO4_GATE>;
 			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 96 32>;
+			gpio-ranges = <&iomuxc 0 38 28>, <&iomuxc 28 36 2>;
 		};
 
 		gpio1: gpio@47400080 {
@@ -493,7 +494,7 @@ gpio1: gpio@47400080 {
 			clocks = <&clk IMX93_CLK_GPIO1_GATE>,
 				 <&clk IMX93_CLK_GPIO1_GATE>;
 			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 0 32>;
+			gpio-ranges = <&iomuxc 0 92 16>;
 		};
 
 		s4muap: mailbox@47520000 {
-- 
2.37.1

