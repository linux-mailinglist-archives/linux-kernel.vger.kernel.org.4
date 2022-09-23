Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954315E7528
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiIWHsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiIWHs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:48:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5E57AC16;
        Fri, 23 Sep 2022 00:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QudFsF+3zVUvka56fY9x/14vCcpCy5lGUiG6sZ+yrP828R7rhGqALPCZUwjra/jCWwUxo5W9+ChmkLhphn6r3GdSqn6nWtOBO4w4lps64/+qPiLSBfuQdhla8EvLGKuXE/7trJ4eal/6+tdXDLeQpaIZfkXTsKoYKHwwm/MLOmFA/1h3ZV6jU6Epq0pCUYqG3TCOqbe2ZgzdjGDIkBeawUIvFCkNpDdDpVmm24M3/OCJu5hx4aBD92xBnyRRXOulZdxoVRurnClivaUrD62WE+OC946LDKD3FXMRAEzyIDaUqQXmA+hSC7054lpd116TNRDswSdMSMA1vjXABxkpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC8lYczCIQvtBHuoHaRaUemP2LBt/Uoy7UXaTRUXQ5Q=;
 b=KwkletfGxQgr6JevyCNr9+XIwTTJ3N/7yqtbCOjBzk7+KvhGljor0jsaNzoiq/wSysuWDaOwp+AwvaPO619P7Eh8NOBLqPU78TWKoDQZxMUte204YQXlQ8djD/T6QdhPCFZWDKE0tOQCKcV1ZS2+7+/eA36gMyFIfphO1gYgsy9vaT5zEucgUUBMvy7BQeTNJ/w0zo8pMldjGk/+XP5FxhNAgbyQOTgp7xSBjvjG1Uz1ITbmpfpq/rpkMoSDfSv2HeyreyNa/ifvjFLc5zy1TS8saEHEGp7kdJYMi9/Yq0FLT48NVve4oHSCSQPvS615UQLSto2wPJU2Ng+8QVbK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC8lYczCIQvtBHuoHaRaUemP2LBt/Uoy7UXaTRUXQ5Q=;
 b=GeQS0T2r2bIe7T/HN1pVdDToZ2ugd0GkeSHv5SvSxO+q813xwCjTFlfra4E6LkBz0TbAGvTEJeWaQz8G+FKg1vaJM5+BRVT31CLsRYyj5rvJQZaxfkcRUhJHIcdz7vfaElXnyF/Ka6TXl5I2HUziT2VpWZZ+e1DwchubvjDoaVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 07:48:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.018; Fri, 23 Sep 2022
 07:48:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, sboyd@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 2/2] arm64: dts: imx8m: align anatop with bindings
Date:   Fri, 23 Sep 2022 15:49:43 +0800
Message-Id: <20220923074943.981127-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220923074943.981127-1-peng.fan@oss.nxp.com>
References: <20220923074943.981127-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdf7ad6-aaf9-42d2-4700-08da9d37fd7e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJsbrP0eBs/RdNHAIDDHt8mcdQiSham+dFMEqH/mDbzvayJ6//GqzZjHvQ50fPvNnW2gD8CzT5+gKMxrWU/oYVRhF9ref4dmguQNKdcbP7hfUyyW5WXLjuadyecxFxiUWIZgg/Gg2GWEY6AW/nKF6l1eHVtZUkqG4Ch9R9kZ4QEUdDJ6I3D/ZclG/GZWLkon+T+uYnkARV4yIs+lWPWumVlR722trAcz/ZseK0npiLIhmdl0CYYl6rTsyxsWdCUf4WqpxUpMuZ7No1dE7gOeIdmxIMQjG1roxjiepUDvUg/VEuF1Gyjew6XmoMOG5f32VpIRqbCOFO+MQZIsnYCjBt5Z3OYeXHqWdCtq6zwxoyEUhe+pe7AG857d3taI7BG3tnrDKWkH0c+bmN39DkJaiN9YZXDKvnJ7t5CFvZyEgwPYP5FPUc2eK5Nj0GVuR0JvC8ZodpiSrDa9aNho1QpqKocaxKV+TPNupFrvOfgc39yOCxd88dSiGwvB5+HY4WkXDczqPlmJzik5YL0Pjjv0Pz5ItbGeotJlonuUIoSRwPXNfyMbDZorgIk61CVy9zajNI3PcpoLrub8gLMgNzIdl9YDYh0EV6LD8D3nFqTbOCT9bj508JbJ2ncaPF8poMRT6Z3J2N9NJzrTJMiqoGvLlkQ9iu0dWSiWrKnpT4dJ3jx86QAEn9v+qJFPQjUJxjg2y5BpOV3SZqtSQJJYJACePQf8S2gkrV46G3oJ+eHAXogmMzghMqWT69hoy/xf+r67S5ety6r7GjELO4kzwhk8BjXnUU7GXWlom3IllESIP3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(2616005)(186003)(1076003)(41300700001)(6512007)(26005)(2906002)(52116002)(6506007)(5660300002)(7416002)(8936002)(6666004)(38350700002)(38100700002)(86362001)(83380400001)(6486002)(478600001)(316002)(4326008)(8676002)(66946007)(66556008)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L6dX4s5rdyeqnaJUggbURlf1Nk799WyfiY6dmHLdyjFDnV1+sLxKosj1UIHr?=
 =?us-ascii?Q?BgJzcLx/rgskVNB933NXz+a+r7Y+bN34+PHY+BSDNDlHGAucFPMjoYvESU2L?=
 =?us-ascii?Q?TqUApX26OY8q3jqUJcdEo+teltt7vlCw2nqasdo380uXmfqOZbAlIQaO6gFQ?=
 =?us-ascii?Q?TT50mWLX9ShUu8imntvsOjzyIj+h+jmz/sBZ14xDa2N4oG0EJhSn8hYXW7OH?=
 =?us-ascii?Q?naPnctdnlCv3Hi+ruwGB/nLgQ85LHVctnktgjvk4rccXdSQmaN5+FjO716lE?=
 =?us-ascii?Q?2uC2etvQtgAT113ZS349nGzR1QQAk2pAurXmIofnqzfaEimzs7Q49QlJOUGB?=
 =?us-ascii?Q?W5JTUwQ0gxE/SNUekW0+Kf/JQmA/UIIB+k/7RXNBEoAlPAuYELUGar8TWqjo?=
 =?us-ascii?Q?lNqZ05Law/9pglONGrTzM8TFAixbUFGOF+90hSAKAJ3ZSWjOcBEO+9492JHW?=
 =?us-ascii?Q?zOi3Eb12IyB5PRXGnbkRTemulvoamzUugk7ritwegrezAfZVA9yoqELLTDAI?=
 =?us-ascii?Q?Yuz0jURxeOvW7HpsfmT8wCncmcY0yL+mLd+v45LmxyYLahXSpWnbwsqTXaYf?=
 =?us-ascii?Q?o8yfP/lPFieOFPUFEz0xAhOUSDYyDIEEfvYllSHIBeuIHdMqlN6FNti51JZZ?=
 =?us-ascii?Q?+Poa32KprqViKfU5OgrAHY1LTDhxDJRLNjk+ZcAsekLSxDV+L5Gy6PC8K/I1?=
 =?us-ascii?Q?1dOMMdB85uc8NYdMea3Xg8Mf5o56coBbYwAYWTzvJPoLd9Kn418TXdh1JLOJ?=
 =?us-ascii?Q?r+PookclLI7R3luzL9p/mZuj6GeCZmAgetWZM/Frg+6yXwlhBQF2xcVkDkKP?=
 =?us-ascii?Q?WPmllA6rPf/eu16RvyeGXTIizjp+Yv4lvg/wang59MLtg6phTsH5wr9kQLGT?=
 =?us-ascii?Q?LOWbQ/SguKHuEW6V9WT9MJc1zqpkWBS6yeDbWuj8bk6O0mH+boxPRSunldzp?=
 =?us-ascii?Q?zGqqMitXdir0RrL/OG0hCAAzZxG86pBHYDtC6y3EyvfZF2JYOqn/NrX+VNXa?=
 =?us-ascii?Q?6AAZoHyNF8j/7wkihxxuHt/rQEd3yHnSAwmyIiXLSDUCXz7nQ08iSJEKweOg?=
 =?us-ascii?Q?fXhjyYQhZwsXJa9Pfji2Oe7jVZVpJtEctW3SmxIwXVS4SWptcf5ZTF66YeqU?=
 =?us-ascii?Q?iCcRmu1qRT0XbUNKcd/xD5my3F1xUTdcwFSDSe1VtsWLd4uuSFGBRXkjEwM0?=
 =?us-ascii?Q?vYYu+zQ5XLp5n2Hr12NunzPkXOSYT1e/9ZrDlTcn6usE2H5deP/3TaxY+l4u?=
 =?us-ascii?Q?4Xbrr8NUHZhJ+jLcpR0/ZqbDAofbt7+2ciMR1m7ZyF0IWxImZCr8/czqtHM7?=
 =?us-ascii?Q?zwiEIXHbY/+Yg6kHNbsxtHkx4vby8kGW0tq+4oasC5DIONsCj2Q4iJkg9NNZ?=
 =?us-ascii?Q?sEdsfSwjp6pA8VawYUwHdc85GL1phJH/9bQZlDbxTB32g5Ld429hWPj26L8D?=
 =?us-ascii?Q?IAYV9rJvuB5GzcURPyXlEkiQXgZ2ZntX6CbHd7fU5bfoLXJYan2rjpZAYA1e?=
 =?us-ascii?Q?IUUrjCLU/5kWSC49FYyG+16JMX/2QKdOjsmy+I2iwPmSKPUl5KkCXwqcjE/p?=
 =?us-ascii?Q?inLnSImkXAFQUAMHne8wBc0zwk043lOin9czTnUI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdf7ad6-aaf9-42d2-4700-08da9d37fd7e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:48:23.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiveFpfgDE0T7U9nOSoi6Crdas+GZPOAUjpy066WZUP4PrL1P43rgomh0Oic71EPQnEHXspmIrRqpf2CmagJXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The CCM ANALOG module is used for generate PLLs, align the node
with DT bindings

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 5 +++--
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 5 +++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index afb90f59c83c..ea5feb04a0b7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -573,9 +573,10 @@ fec_mac_address: mac-address@90 {
 				};
 			};
 
-			anatop: anatop@30360000 {
-				compatible = "fsl,imx8mm-anatop", "syscon";
+			anatop: clock-controller@30360000 {
+				compatible = "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
+				#clock-cells = <1>;
 			};
 
 			snvs: snvs@30370000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index cb2836bfbd95..fc86e7337313 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -576,10 +576,10 @@ fec_mac_address: mac-address@90 {
 				};
 			};
 
-			anatop: anatop@30360000 {
-				compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop",
-					     "syscon";
+			anatop: clock-controller@30360000 {
+				compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
+				#clock-cells = <1>;
 			};
 
 			snvs: snvs@30370000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 53493dc7d976..130dec9b23fc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -441,10 +441,10 @@ eth_mac2: mac-address@96 {
 				};
 			};
 
-			anatop: anatop@30360000 {
-				compatible = "fsl,imx8mp-anatop", "fsl,imx8mm-anatop",
-					     "syscon";
+			anatop: clock-controller@30360000 {
+				compatible = "fsl,imx8mp-anatop", "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
+				#clock-cells = <1>;
 			};
 
 			snvs: snvs@30370000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 19eaa523564d..b14dbf2ffb9a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -605,10 +605,11 @@ fec_mac_address: mac-address@90 {
 				};
 			};
 
-			anatop: syscon@30360000 {
-				compatible = "fsl,imx8mq-anatop", "syscon";
+			anatop: clock-controller@30360000 {
+				compatible = "fsl,imx8mq-anatop";
 				reg = <0x30360000 0x10000>;
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				#clock-cells = <1>;
 			};
 
 			snvs: snvs@30370000 {
-- 
2.37.1

