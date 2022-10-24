Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225C609890
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJXDOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJXDNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:13:49 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4769B78BC7;
        Sun, 23 Oct 2022 20:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw5VPgIM9TNO3U+QU9z4QVEeKdwK2KE9m6e5rFnb6yD7lGPffMsYuluhGBRYA2M9PaHTlHA4HCo5FxXHUvhLUEYqQYMJCbjLnXnaM5rKooH6TYVreBRKp5iGFxsMDmg/55JqTnsCOVZFHFs+959noYFWwnuPsVNgD0HCY3hoRS1FGVt5Q/QH8Hx4TwkvgZ4Sr+c/NuTky/a/xWosxINdpswfUeBqec8DGVTtba/zpqoq60lIEDBeEHfPkfffU0q0Zi96ZVFs9fWmfU0UXOMS/xpSqgnIb40saUaKI/xKd1w5WA6D4vVgs3OeKekOgYopUlepM1IaxsS/QjHznPFJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7seoCcDHr1GrJVtmnKhkNbzTU04i+Pt/e27f19TPcAQ=;
 b=UdbBbk9Gh7E4CBY0iSE2iuFodwvuSEE30qlyQo2RyTsc0C0iy7h6UNyPU+pDmfpzSQ67gpAEtyyhLiPLbKhGTQc4oEqLEIpEt1cgTXZBJk6htfm2QVaGCGKtXYdKRuAPlIYR1KlqMAVfnKZjR2Axu9ijQ/yquq7nVhDIEJy9zaYqIXCmikxM0EwhYPPjdoS5/fUiGQhkPX3oNxnELF+e+4ArDyf9qbFMXPMxs+CctaSQLMomFGIzOBH09Bnp7NJ/ltN8CiEtA2g8l+fSl0XyYq/ohYDCplQ2DSJBb1/TDmeEEL8BNdFYGKBzd6ui5B/9H+BnTEXHl63MV9yfVdVyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7seoCcDHr1GrJVtmnKhkNbzTU04i+Pt/e27f19TPcAQ=;
 b=kfMNZECykvag3vrMBZsOFvg9fZ/GDQiaztEtf2vriPmk4yX8Hph/0I7B4go4N6i0878OfDSNBtioncE1Z9hwyBYbWh9Zwz1T1v3NhTe7+p0xow3KeHlHOauABBmUjgwUEHnx24BoZ6+dEXfjK+B2h954JeEezq/seWUTdAXCA+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8340.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 03:12:50 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:12:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 08/15] arm64: dts: imx8mn-evk: update vdd_soc dvs voltage
Date:   Mon, 24 Oct 2022 11:13:44 +0800
Message-Id: <20221024031351.4135651-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM9PR04MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e338994-142b-4c14-abaf-08dab56da235
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dn/DtDC8/GgdebF+oUyBsvsHkQLRjHquHCVnOBHYia9QdtspStaKsUUTXXOxnzSqPlrIBzkb3oc2abX4osj6rATMnS3s10aho4eHi8W25GYe2hecU7n6qvb6iiM7HmyAF7dp7krZtJJIm4L3B34bQrHnwCi8Br0zUUYspVo+v29TzEqPdySJqdF3SqcstVwe5RuYmlD+8ngsPUKgMJHDGotHhz6YOAYiBZd08uzsQrGECi7RfSfyJXbsCdbDMIjCbRppLqunU8X1lg6V6ocVFQe0IH21+IRJyVjGdtvO2ViagDn0if98EsjqBaA535k7DDSsailjaAp3BSFMhicEVtcERyzKc1shnmDtx6o/Drocc24pzXQKdaLnUJqiTZnn3DyPriXDUNp0AKNkDiQYwS3b5S0gKbz+m/1FQ1XhPus0rQWIxqqBbFIHwP803gY2WVUfeij/L06x1+u7MoAp3QoFJ8m9bt8ka+T6TviWJ3DT9iSp8+WFIOs4NcVjFb/7EWSS1qYX9qpo3dmjZXTS1yGomaQYo5noZh+GVL9w/B5OSe+jfW/Fxlqgc9XesnB8P5HyNFDbmUDlTHx29UCZpu9NAZdLre6dCGTNcjfrFnVh5C3jH4UsUHEXEgohFCSJFIRIx9EV2lk2kuhaggWq2mb5uTiN0VONHV9bHo9wI2/LWNkFtUHziZuMvanohLSKXT/28qs94mN9EVqec/pWJhacdQF/9sNH3bDVVrHVtXkao1RgdnxHfyndns3J6OxkqeKJxxUx3fLwRsLUyseW6PvLrXo4tjOgXXibS26Q3ZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(2906002)(41300700001)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(5660300002)(1076003)(186003)(2616005)(6512007)(26005)(6486002)(478600001)(6506007)(38100700002)(38350700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDnanvIikUfxxbrH5XMOs7CwfkvBzHNyNBNw7mwNaD5az+wv/GJmenDzwFpo?=
 =?us-ascii?Q?/fmlUq9d9Gv99g3od4Eac4XDZzP/5vQ7CPN2vQ2k6C3FxZmEjPYht0LosW10?=
 =?us-ascii?Q?FLBt07Jjv1DFn68Ms44SYlKgxDg0o8kBugvnN2IwNAYImM4tEWTqv0kP3KeL?=
 =?us-ascii?Q?AvE7vXRKhpLY/h0TvrM4tgTWuLxYSxiCJSWydawYX8iWVnKm0KfklUbkZ/75?=
 =?us-ascii?Q?DM0B5Y2oSI1pohS2GK6ivWtPyuHS/bwR6qGNrflFjKl+ZWzVCzI+oNHZcU21?=
 =?us-ascii?Q?nKYSU6Cy03KryhT28Za/xWE+Ur/ARjtopuFdmYxmrwRhHNIL5TB3GBI2T58p?=
 =?us-ascii?Q?ZgTt5zyaYAn6EBUMGalTsQXvL67nEcsxSUXlogTBQI+gh9+qObwbdSxVHMyR?=
 =?us-ascii?Q?wyDm27djTaS5xDqcewy+1juWghQb1hZSBxk8bgcsPhZrzODM8mus7wJYNX2P?=
 =?us-ascii?Q?rKJ/hMeJ8J2wQbM0Seq9t9ZmgLlIepYbN60Pwm4zGLcMBPjmBl/9Do44qkDz?=
 =?us-ascii?Q?qeSObV5pRXwSiX5i9oxujyYHemCptpvNDQi7//SZyozGso35lVWVPC2D/EVU?=
 =?us-ascii?Q?5ZkfgHr56/ZKqP8UIAZjVQ6vw3fegZydlXOvPjsDEli8EVcsFEGDzfGPxqI8?=
 =?us-ascii?Q?WCBAU2c/Y2Zoy2YiIyuDvRX54tG7lmrwb6TnMJ1qgewEwkFubRbUEdnk6ShZ?=
 =?us-ascii?Q?kegYlGvSSdonmwiQ/a43jgAYMh+Tzts9q6IXHyb55W7uz/cXhcS5UbBFyoa7?=
 =?us-ascii?Q?99AiAlMCObgfZGLnLSjccYqs1rsNOBfc+up5NVY2cymYUhpACdXlc7mi9juC?=
 =?us-ascii?Q?eRDW1oxItwqighd8UiLY/QyII8EisytiMi/APPsgW+iyxBsKIhos7aAQ/dCb?=
 =?us-ascii?Q?MXby7++LbHGAVlA0WwfjXmcrcZ/mZquTIvXY4uEcMac1B2COjYqjuIxJ2mT2?=
 =?us-ascii?Q?BZbtnpKp/BF0PCRZZwMuTHJsoLxYwFn+t9iOWV65FrYl875BB78hXpP6LM9r?=
 =?us-ascii?Q?LIWPY/dyP9icvEufAfFmxiZX29YNIoCa83/smC6GhOyS38ZQfjItGTvpy1PP?=
 =?us-ascii?Q?3xsbNp68lHtS2diUeQ0ECXR5BgeP5JCQmmlFqLkcbfZeLmb2YQChSF9dcX/P?=
 =?us-ascii?Q?K9yAguOZS3oZw2Q4XVl/jgXZu0CFr4/fWmkXfnjOWPT2mXxvHJHeXL+2xwfj?=
 =?us-ascii?Q?J97lx3GQx9XStjfC68wMTCcTV8Dcl7iKmbgjf0rLjTuP+hw08Bs3rY/SsWAJ?=
 =?us-ascii?Q?eMn9C61gHiil2M1XmVm2P1alL9l6KOrsyJRHlnmXsy0KvrWuapxVyswOFHPO?=
 =?us-ascii?Q?B77Xc9ZTjNS4S27x4amp6CnXfXRB1z68S1sI0bMdtugGfIIK2hknaQy/mNIy?=
 =?us-ascii?Q?aY5VEZ0tRZUXzatn/4ke1k+wSr4Lbt9Nml8JXbmTDR3LBGxnt+Oo1LAtM+T7?=
 =?us-ascii?Q?A6yC4mz7UvG/MHSY/nuXjacHrg1maNrOfobhMa5GBHmh/P38vWk3wATbRGVM?=
 =?us-ascii?Q?/jxaHluVGnPfV6RXVmgz8Zf2QUoCXUSD1UyCEX4ewbaP/33KnWw5tKGM7WRD?=
 =?us-ascii?Q?CPATHnU5KWkr13V9cpwhUSr37BTTwpa9PPLyqMFE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e338994-142b-4c14-abaf-08dab56da235
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:12:50.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cm423gVOKi+MzNhdwLaT59FookxXLe/G+6dH+xbynH15iN7IduQK30Wv8N9brGflJ5DD6T4LgNhKdGHZtxFgwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8340
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per schematic, BUCK1 is for VDD_SOC&DRAM&PU_0V9. The nxp,dvs-run-voltage
and nxp,dvs-standby-voltage need set for BUCK1, not BUCK2.
BUCK2 is for A53, which is handled by DVFS, so no need dvs property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index 4eb467df5ba7..a5a7d74ec1d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -47,6 +47,8 @@ buck1: BUCK1{
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <750000>;
 			};
 
 			buck2: BUCK2 {
@@ -56,8 +58,6 @@ buck2: BUCK2 {
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
 			};
 
 			buck4: BUCK4{
-- 
2.37.1

