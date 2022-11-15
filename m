Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACBE62941F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbiKOJRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiKOJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:17:03 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB0B2316E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:16:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aafeeaqgk3Z3ZlTTAcsSGNpaYi+B1ujRmVPYWyGVuO+HqhP2/dZiqzpa2CKT7c04LW5XKpwNTZC+V3lN0DS9AJ+180o2RNbeuM+QAAtKmCr31hfsftEgoQCCV609mdTmJ22cO6O1WNTjhweeYe4m3oFSg1Eds5c8iaRoN5tJHEcH3qsJSmo8jBm8wCpp9ElYOgYixpmCD7SnPpyz8EKqQ2shh/c9gwuJOwuE+5R7fgcAqoY3Mwe5tFkg8lmAk06Qb+ZxsrLO9qg5j10fmIeD7qKiL0oc0iR6S7tefyYeLa6uIWmwFNSn+Qrl6VH4mwtyNS89ruJWsVJzNCnncDTOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4GtD6rCQpSTNRugMldF/AhuI43m5h3lfCx/IbidyAQ=;
 b=Y/ZIjbpcKRNlVGcEsOJsRmmvB5qeggxaBZXxYEYp7/n7OYxZ32/YF7Iq/SExE3gFaS/1YQrd1aQfQbRo+TqtghvAmvyBpvA7VlvaDnOJ1QY3ZR4Eo55jbmigD4t+E8aRYGCxqk5dA0rM7MKdGgRkT/gqQeqZfn15DHV9j83X5jMLWELiwQDwzvh4OYg/lbhxVv8C+gjVUbxz53+57ffWdmS0nMc5Hhb7SHRRFeDmHnegOSZar3ocP7m8vaYw26/NXyuW3B1GCIh+ZiZG29IMW+f4f+wtDXtrxI34f053kZ2Fss5wgCxySLlJYqMVljk/0qTeQFMI49nX48LmWlA8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4GtD6rCQpSTNRugMldF/AhuI43m5h3lfCx/IbidyAQ=;
 b=NvwX1bfhSjsFq4qORzpEahedtv+A83wkNOJQXxb+e2QBTdHSuvTs1VmZVK8Iha/c1Ih2M1Q30yoSvjsW6KtHWN/XVYizZOGKqR8n9RT5rKSv9THWJxc1Ea5QTLbJiisTc5hcuiQr227SbhlLamhYzU2aByS8jbzi9lk2ZPwWB5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Tue, 15 Nov
 2022 09:16:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:16:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Haibo Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 11/12] arm64: dts: imx8m[m,q]-evk: change to use off-on-delay-us in regulator
Date:   Tue, 15 Nov 2022 17:17:08 +0800
Message-Id: <20221115091709.2865997-12-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e720470-f26d-4f96-49c9-08dac6ea107d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rKEwOqUKMLIsRP3cS/I0uheM5G5UxtIdyuI4HFh0+uKQjBmBU+m2hYYGFAPpEiFEQuft/4fwWZ3eqKm8Qd6MXnRxhphdwPDOHJHnZrkghGiIoclaibaw5ggBzZgxTY/FV9pVUtn4Pi5+ODJHzdfDAXnmJS/svP2y9gjh2rZIIM04dXVNmcHDYAT/zfItU/Lb4mMNQ1E2AWb/l/X8iPih4GrAwVbV1NBiSigyxiLtK9w5dC/od5mB5VrVyLh9jlHuUGUWOzDW/dfME78WeIYodUuvsRNnTW3JGRXAebCx5Tu5ijhX3z6AAW2K0M4oCdPM+kjysgHlLDtRhNe2gnj7kAWzbo34Gpmn0mouEJkuapVSFrR7e9B8Tqh4hEffncPc7zWtFuh8cWnXAcugTG2OGoPXKbxRfobQ1OaollytWXvFGkmG9mXVmg60rTGaE4coXFKzH2Fj3nkrt8PeUhgIBU0djtUBU0sXTKraIGe8OC17bucccfNfWaz1qlm094bK+pPbbgktOyVQt37mcz/xM3k3bc42mR4kbfMXOfUa+e0OZg1i68MJeWsjyRq1vVrmXlRScy5Y0KYyrwFqUPV0y8vCtVg7VEmTa3iruPTBvF0C4wiNeRkIYCzZr3nLHznNxDX3Y83syeOA+r/PgZd2fYEG4F5Z+ZUpW0+yLPxnS1sYR+E0HOzfHSbj8tzHuD/A3xmXouh/xzPsbHIWVY3N9eiSvkj+zEnpLA1JbWpTWigk6W45T0/79ceHneNJcGScoNmMnDpt48/7p7hDJ+8GIxQKRRCF6MNJu8c3r6Rb08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(1076003)(52116002)(6506007)(6666004)(186003)(478600001)(26005)(2616005)(6512007)(41300700001)(8936002)(5660300002)(66946007)(4326008)(66556008)(66476007)(2906002)(86362001)(6486002)(316002)(54906003)(8676002)(38350700002)(83380400001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Y0j8DIWrEUTCSjd2oUv4qt3eUJPwMGtKrapxcqn7+YKBLJqCByCSsgNQg7i?=
 =?us-ascii?Q?oJLHfoql51I7UA3zk7+WjT+W89MHIXMAtUtFd6SM6OZeTjyxiuxDKMwozn69?=
 =?us-ascii?Q?aZ3HQTceDyGsbn85aAcjdTwRhWAjYrzlKVD3rBympoS9GZWB3G+i9R+nX4Hi?=
 =?us-ascii?Q?wY0AzfIhfS8w0OcBa/6u9YwPsSUDijuRoYS4sWEpU9yr7IgHt9y7ch4o2vXL?=
 =?us-ascii?Q?Ck+xiu/Xj0KHGuop+zbE+vCBaW5rUV8KW/GCDWhIH27Dv27zpFKYhJM8w/6P?=
 =?us-ascii?Q?Z7fLzBXsG2RkWe+ejc8tX9M3AvF0FREFbcBND2IHi6XEwDROnGQUahLFfzPh?=
 =?us-ascii?Q?qQCXeHFwOpQ/GNXVBkXibwJzxlT5Qzy0WdsR4aFbETlkjVyyrG86c0JCtMQo?=
 =?us-ascii?Q?FhmnfH+ctTcx6tMxzRdv5saQEwoDWekZ5IXu3uKTfQ/ZIQY5aPE+xQvLF+eu?=
 =?us-ascii?Q?S0ypbtJZgCVZJbIkujeCFEgPTi6xSGpX4lNR00K2GUVhriu1mV7sf+bn8Amm?=
 =?us-ascii?Q?R4SqPd8rGloMD073lcpqC9b4jY3VQ2yqknS7EqWtjytShDDUA787jKQAS+fI?=
 =?us-ascii?Q?Re8LToqAElvz+TVm3kBPDVUCDCTQPfTnt48YuAY0tndkzQw/lTP4jyS38C+x?=
 =?us-ascii?Q?QgTewYm1WMpi4UVumY4iS/k3PGz4K36rALJFg6VToDowgEJBtyDngUfydbmt?=
 =?us-ascii?Q?1+OK+la5FEg2TFXJwc4BJdLBo+Qss781p9e+DXdc1YXm1oUhIKtfYrsOrh1+?=
 =?us-ascii?Q?7dGKR2Vh5iSgxv5rdrTjxjk9gT6iSqELF6j0cYJKAXMErgjO9GW/4l/AJyht?=
 =?us-ascii?Q?XgV2FYlrXBX3f18Yg8i1z4ChFY6oNMmgjn7DHkfWocGYJwoxJTeogWLQSwF/?=
 =?us-ascii?Q?TEtLoVvusfpotanYwFByUY+7d/InU2PhiB0rQKdP1dPsUAOrUrL/3fddtAiI?=
 =?us-ascii?Q?wIULkU0GQlPoK/LprwGqjhDllEy5SoGcNNI+RtMsR0asv4APugBfgB0WeSIl?=
 =?us-ascii?Q?rsc4Bvo5v90i8GCncijju0HvlKemJGDXqJGk/w2+59W3RLfSuGnmLG4P7ach?=
 =?us-ascii?Q?9b7xUQBRkCrd/LWI6bzs0dEhaKy9fACSApvv0e4w4SzDI4g0SgB9L0vpjCgi?=
 =?us-ascii?Q?8JhMygeaQ6tL7LZkoDM2ViCcMA//b1kYV18rUTPpTS2lb6EqJHV0YpK4WB5z?=
 =?us-ascii?Q?7y9dUElzR/2WuMEz1cZhRB0uJkQ5EfLirIt1Bxg7cTmjV8LJWqSiEERi6GbQ?=
 =?us-ascii?Q?hwfY4cpbPnjgEshAvC3Nd1tOao3V0fyl+Z+okF8RpD73FpjNA9JC9/pI8YLE?=
 =?us-ascii?Q?NNPLmMKM3yoNKS2SvTMFeGDelmVchODJJAHB2GPd4l9g6fARA1h6GPDQYaMv?=
 =?us-ascii?Q?HLZ//tktXhDDo0Z50v0mLlkmsVCMg4ETKTpwAq+Sgi0w93bsbV8Spj5zxucx?=
 =?us-ascii?Q?J5Rf8J0depZAPocmyUrtuYOdbBqZXVIxTWey4Se4BdkAyzFbMBi/ypiqaCp/?=
 =?us-ascii?Q?NAUXIhXDwSzs9dBgjy59ueXXue/nudrUL6MpZ5ZeI3LAuufASQSL/ma8yGCa?=
 =?us-ascii?Q?QVmJ/m05U+jCu9FLKWT+TCzlHUB89BIph9eIPJA6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e720470-f26d-4f96-49c9-08dac6ea107d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:16:23.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeTy32SsA0mOWq99rI4suA6kNZ8YJT/9KnST1yylbw5YyyMstzVIjuClcu/YPsqiTz1twYSW61QMAs61+Ejpmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

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

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 7d6317d95b13..f881494996a1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -56,6 +56,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <20000>;
 		enable-active-high;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 82387b9cb800..07d9fb2aacf8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -46,6 +46,7 @@ reg_usdhc2_vmmc: regulator-vsd-3v3 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <20000>;
 		enable-active-high;
 	};
 
-- 
2.37.1

