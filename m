Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B576C6C011F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCSLx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCSLxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:53:25 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C29B20D33;
        Sun, 19 Mar 2023 04:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6zKYgTkUbAIHYeZ8g1DA5Q+SVnaf/Gr0ZaySa8OPFIhSdHjBKaWZvhLyHCLoYn/W5HfiuFqZINKU7enJUHaPx5znAd9StGF1CsZzJ1k8giUvWEREt4woYhh6j9ulULUDlgu87AIkfBVa2bnLWYK/EmT8ZO7XCUxlupolA8SysBKmjt/8aSlxyjO8jk/4xvdTG8dHYc/YpsmVq5PBGplvM8pRhsvEnb4wMsaeFrdWtmlZRtOT4Cvn3Js+RJuUNeDdBcXh3/ZqFQq6G5XcOx4bFDclIUn+kO4U4EvMEPqpMmpoSJ/Vo/li5FsrhCl228yl/IrqK46n/wz+xAOWNG6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oIMJoaa1fZ7Qe9o//yuFaWYDpQrA/J7Hg5mCW8lIEE=;
 b=AB0nPZ7OX5RXf3lHHBgZWFOa4xmM4M2KKeNl+RCIpuSItEBmxZ4wf1teE8NevW87qJXvRXstr1zmYGJijueVI46NjUZDft9E1CrTSOszims3iG0PTLEWIit5pXEy9XLnbF+/PEhcv9vWMKv4+UBLzZNbaVOwwrFXJt4aBpnDkgLJme8ZOHt2YA/dn2H4+/fY8Vh02OReS/0zRlCZ+qdY/6qfHiiBgjnmQbaCKI4H3xtod1N/k04k1ixT7TxcnjKXqlRigLP/n6z3rd+4Eq8NZ2o9KU4bjuD17zkl3uxOEC6TcJZNNA94ksZOttPgiYPQMYTXmqJh+tdh/fLdiHnp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oIMJoaa1fZ7Qe9o//yuFaWYDpQrA/J7Hg5mCW8lIEE=;
 b=aLeDCsd5eVc5EfBzeoNcstO9yXDfIiejxm15et2ceKUyT/Jo1ZBmT7rdzBv7vbG/utsXlow4lwbeh6EUetqlhwMGiOTGnuVMcEM2jhJSY2SBnVi3Pc8uPghrw5D9PncgM5MyF7pPS/xtrVnc4e1Onz+UHMjmwj/TY2xbZfXY6uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7685.eurprd04.prod.outlook.com (2603:10a6:20b:29c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 11:50:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 11:50:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 9/9] ARM64: dts: imx7ulp: update usb compatible
Date:   Sun, 19 Mar 2023 19:54:56 +0800
Message-Id: <20230319115456.716969-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230319115456.716969-1-peng.fan@oss.nxp.com>
References: <20230319115456.716969-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bbf040-5b0e-4231-4a5d-08db2870240b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHbwdTr5gk8soRR3XipjQ14gE+z+J1X3qSYe78OaIJOJl056eFn0E39kCrx15ByVWh/AMkRTSJ2tiDkN6f8jZNJ+IfAbZUBe8qQUpiXIk6EPmaqdv7R4cPmXJnY+6ZZSWhqlFlCrmw1u1+yyVf9bXs0KUHFBQzloiV+bObOSVkOaecoW7+ZaCfKo8SHSsjk28ig88+FaWCRA/NgkHVChx6B46gRB0gDqwsnNXoo9pIOIPKrmr6a0JuLvT/Gp5WQ8wqQhfJ92KOmugeZvCwqQBfazKHyJz68HTwCjFs1EqCm628vy+PVK/1T0KzhPNwshp+UjVsGIIgk5fsTnrZixRpvSCQWLiaLhmZU+wXd70tcOG916XrXT6h93f0c5LFk+17u9/R7Ivs//FAIbpT79bHPXbC32aJmYTQzkbrv2CZXeiqMnCqNH/598mHBsdk4D2YMi7+3kTluyXntJF2jzt5E6QMQXdr2IGNHPo8IWq9ZRpk+FQNYE/xOfM0Q9kxitveJkkbPSdhR75GcIYV/KWurvKMq31H288K0eIBtwUgmoJX+5W7Gt/7m2f8HBKtxW5t5VHHsIhQ+i7QNusB4YhF7ZwttZxNPhjTEeEv+3bX1sQO8YbTFsSwcjsJpxL8a4Gqd7VXN2P9BlCGGXrUGZtrPtK1neD0bc485MOsNV7NnG7YyQv+R5px7biNbhP6fjA8keHYpA1qBAr9s2S2an2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(8936002)(5660300002)(7416002)(4744005)(41300700001)(86362001)(38100700002)(38350700002)(15650500001)(2906002)(4326008)(6486002)(83380400001)(478600001)(52116002)(2616005)(186003)(6666004)(6506007)(1076003)(26005)(6512007)(316002)(66476007)(8676002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2JoreK5XrBED8a30Dq0G2sdiRowuCS23gifj0f3V91DKAlr7mfY5wY2pXg05?=
 =?us-ascii?Q?xgqImKsWu3FihUfexueySpkQ6CiaRBdDK59XhKF55/dhjGjs6ZlqCB6K9KcX?=
 =?us-ascii?Q?WaOzzUhiacL4QEoUXu222518te3ux7++w34/fLU4Ar/2GCwNSjHV6dI+yRIK?=
 =?us-ascii?Q?ndzITUs3Vh93TQgDEjtx4NXP6svrBeleo5A2seNteGzJwxKuxDngkz3pJlsS?=
 =?us-ascii?Q?enyr7qmpJR3GZW78P+WjZWtv7afHlgzKG0XNqIepVsK5Ikcg6VGN7efGQ50r?=
 =?us-ascii?Q?IyLj3Gt9uZt91LQntwby4/bAywOuFa2fuAG7dztXut1EptOjmxbPQvm/zz3B?=
 =?us-ascii?Q?Lhfz8fgeRl/6S76IVtNK0L9LY9kHP+Mwi7496ZxVmMqyA6oGB869KxG1cv/z?=
 =?us-ascii?Q?NI893+hpSS9FLe3kzbcF/gOl7Ti89fuh1/l1cIAnDTXtdhtU8V97BX6oxB/z?=
 =?us-ascii?Q?e4jTI+UY9UlPofoY31q3Nl6AnfyjFG5rrJLoVeyKC2L2GhKTen6ukSsPh4rg?=
 =?us-ascii?Q?zjI4vMOeBlEOHo6UZomRucZlIwWIeRHrNRruGSnaJiggRbYkcGw3xJyxxzo2?=
 =?us-ascii?Q?egiMIOMBT5G4cp8RVY01YBpTqFVvA5wuMP8bGCTNeRc9hhyNpvUupAcchd61?=
 =?us-ascii?Q?EuJwvX1fhpn0KysmpiGLzB/vP7tiKlT7zhysY0rJZQo4Wf4uyL+vQ0kCp0zM?=
 =?us-ascii?Q?n4T83kocPjyqLqnCdQLueC2r4emj2McqZmXX1X3JBfJwaWddF+UFQhYhhoNl?=
 =?us-ascii?Q?m1gCikw5Fxpfif0aveU6YMZPD8TG9nnvErV76OKtZ/eYji4yhrJSusf+lbDz?=
 =?us-ascii?Q?rBH3QUvj5vgJTnQ+yr5jDiSCWVtNdSwWoMPTuOTKaWyOYP+DdMZ0ozSttwHw?=
 =?us-ascii?Q?LTe4zXJvFA0Kw+Y7ouOvq2mZ8ak+PdTia9lD8qaUGp/T0ymRZ/gG3vCRpxr9?=
 =?us-ascii?Q?4ynOn6eHzN51w6RACexPmTlYzh/mugI9tFsdA55wx7vA3UKXXjotD+2++BWT?=
 =?us-ascii?Q?2tEZLv9zJU+ISzZYn3Wc9CQkWU0ois9S1xQD20Ls1L5MzNEigXxmNGgT0L8J?=
 =?us-ascii?Q?ZwllfjkACuof8AUeC7xxH0hqeEDS5iBxX8XTEDqjXmcoFAqmEcLH6iYBu6pS?=
 =?us-ascii?Q?t7oBkwGx1Vg1z6KOL5ElrQKGRvTlC/c0Y9O02bA+MxtNG3Oa8xbnpHq4DMwS?=
 =?us-ascii?Q?zbu7U2lBHw/w2Ex6JTYE3n47AoJ2KayIgsAm2m7MAz0nqcRASaQRYcz+YojD?=
 =?us-ascii?Q?aElXDB3AkvCNpHQIXdmcW9jpl+UqBST4rfVtjZsIgWInsJJ35erc0YwvP78X?=
 =?us-ascii?Q?NJQjprklm689PxUyyylMeKg0ntY/eG5+9PpYZ0aMqipkPc4MCN2dFjY2VHFv?=
 =?us-ascii?Q?wyfxgiWu24WC/ZFxCEgUFIbbBSDV8TK8mLqgqwTik9CDUJX5WKZ5Zi+Lb7Wk?=
 =?us-ascii?Q?tl1EB1I5kPYuWxnd/a2tccOK35kRfuWIq3Xun1sIxJo5itGNOM8+mz2/xV0g?=
 =?us-ascii?Q?3dDmoJgk1QfPpig27cGT5fqw6Xew01OB9d03XS0wFsqOjFHObZ7EI7veu9vp?=
 =?us-ascii?Q?s28DYYbE/2A91KT4SzmY28Abt+BK+nGfNAJZkei0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bbf040-5b0e-4231-4a5d-08db2870240b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 11:50:31.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqvujV+BLZut0GtoHB7pfZNm0ercDGoqSA7ACi27Kmkc7IW4snX28E/tDM9rggSi3M6wS4uyKafeXMxVTlc6Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per binding doc, update the compatible

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index 7f7d2d5122fb..f91bf719d4e2 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -189,7 +189,7 @@ tpm5: tpm@40260000 {
 		};
 
 		usbotg1: usb@40330000 {
-			compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
+			compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb", "fsl,imx27-usb";
 			reg = <0x40330000 0x200>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pcc2 IMX7ULP_CLK_USB0>;
@@ -202,7 +202,8 @@ usbotg1: usb@40330000 {
 		};
 
 		usbmisc1: usbmisc@40330200 {
-			compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc";
+			compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc",
+				     "fsl,imx6q-usbmisc";
 			#index-cells = <1>;
 			reg = <0x40330200 0x200>;
 		};
-- 
2.37.1

