Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1691160987F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJXDMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJXDM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:12:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC37631F4;
        Sun, 23 Oct 2022 20:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccIbZhXaeadGR74OZxevO380Y8oHeM3XCy24Gz5yLm0tEqfZmQLbofurGNQjAj/WaMe+rONM+Lro+09A8U0LBqQcAQrT567/MDSji8iq0MJGEnS5Gpah2TGOhO0URasNNjDAjzqGQvfsr0s/+Kj7q9xr5GGM+2GLgd49YyCzKCf+gdsGbHjJOUfpilR+3Q9/NL/UK7MyNVXncytCt60sTloWUltE+JBls5tYSjMegsGSHIM3ga6yXXc7FNgi1MmpnqvfekEyYphSdfOcPlZhhG6HM1tMFcMq37K60o0yYAFn5brcjq++Vx/qj16sSGcBnfyQC9eiA0ZXz8Mh2UGfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaKk9v9NHxiGNHXzfunETX2khyjIAOtRmRfe5+2fd8c=;
 b=jd+yG54e9dG5kaL3LL5iQfPvx4yEAbhsJd8/XWXjthxN0PcNx5dcYtgoMe6z3EqRFRvEplgM6xCXVOQSlMIS/miu2dpBdE2rNOeJ3jWgOrSyhttEZeZe9x3uOn3XJGwtlryo9sOPOP3Sem33Hr5ym4ziBBdEnPqKQSvk5oKZf0N+rA1rbEutGoCVccpZRutmu/bfShSq6MH8pdPvkTPCZZJM48YW9lAdAhFokx00E12gb40+JmGFRwg+FtseC8CsC/AkxiA6tK8M7LL0Ryr5HM4Lu2wl1dapWWW/QngTPfx02jbhx/TytcxQOTcJSPmCI9gOd9YoNJXlalb1uQepCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaKk9v9NHxiGNHXzfunETX2khyjIAOtRmRfe5+2fd8c=;
 b=Bhq1Ik3HsMHsr4Ox4Hv77PXmgO/2vWH1pgeM2nQkhFFrsNmxKE3nByZEMgzQNevuffydb4uKSk5oFCIeUSqcbWmZO82Hv4A2nmKrtUPdyqWkKPXA9rl9gS2/1dV6SVELjSli8ntmUFB2hTFW2tw9mjRz8rQA7eqz1pg0utHND5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8340.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 03:12:25 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:12:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 01/15] arm64: dts: imx8mp: add mlmix power domain
Date:   Mon, 24 Oct 2022 11:13:37 +0800
Message-Id: <20221024031351.4135651-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b67a529a-abdb-4185-ddf4-08dab56d930e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgY+TLcfw7QrvpNb47D6XPAknwoiaBL2Yp5Mq5fvNE7w4AaxmS7DMi7sgMc11+fubINebRNhiraKrjAAp8HOB5PNAFXkdSplva7i2zb8+owrFXXG8LycpSo68U//6RySazut4lzoszgs7roofHk7yU4nIxlHjWPi73wEFVGRyLDVUEs9lc1S50D3lVeAbE65NfQM0d0vBayiEk/izO34dQzr8fCw9BCDYYZBZcVKajgl57htj3X5PIJpIBZiSQHq+OZD9C237iznshqudSNIyi+s0MZyUfbpmmvQvqapLwRcMEFUjKid0gPiUP6Zr1DLgdoDcExRaqbHo77gaqJ24y09O9B3MGCdYCRFiEdHyHpUucsdlMFu9MaQrdOSt7z3EQV+l+idxBv6/gf+2aRTc0VHpkN513LQu/kNR/c/tVG5gXtrX/FnDs/r7AaEtrfvuipIzoDWEUy7LyibzokcWOAjCoZTQ+Dp79XXxgw7hzFEDMQOaqlYa2JrR+9afucPdgwhEjTvM4dXwt9O/4NUJ9VX8zL34eSp/ejcDgrkQHqY6LPj3gAwBUd1DGWJLCBPgeDZ01K4vmWnR53H3/WQL4M7ZGg9TKNNUtIy2WI87748k6aLCwR4/IwShQlHJRkyDSffIBE1q4R6CRE8UT4k/VnVVUSUlEzQVFylP0uilGT4WQAU4N5nBd5iyk8m3cC3Ahai/hISIGInU5pzouasLrDCwRIoH7xNEU0bEyWftFAN37QYeeS2qxVB4GGLMK9Bl4a5j777yvjLow4iSzN33y5uYkLUFrlBYSmrZz/pXlo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(2906002)(4744005)(41300700001)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(5660300002)(1076003)(186003)(2616005)(6512007)(26005)(6486002)(478600001)(6506007)(38100700002)(38350700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skGBGE7Rjnu7on/L8Hhkiwt7nkRQdSgjnj/Kie66Jh6klVKYRUJr+1WXPG2d?=
 =?us-ascii?Q?3lZkzZg8TItXQZ6WYe5e4SUKdkPUePP87sABMkufeRjf6BodNCUPBWG85hPM?=
 =?us-ascii?Q?oHzvmKZmQj8fp5vVBILBAkuXm0w6eyiwakM5umPZbq2F9ZZIV1Y62QmtZ5wU?=
 =?us-ascii?Q?T/5JdwyE8d/MfiXvX7L0VfZVFVt9CWSF7tyGHX372pmFdMoc0K5HIRlt3CuO?=
 =?us-ascii?Q?F9ZrRrZkPBo0QgDHNOYA5faVfC10NnUP9nwsS42bgfYdEib2DJLsGSGzGjFW?=
 =?us-ascii?Q?amzW4OFsBDLAzkEXGChES5PFfRlqAD4uu0a0yhEgTp4YSM9C+P8WvlZVDotn?=
 =?us-ascii?Q?4K+q8sxI5PzO4VNRN3DEZmH/E8hNcF4enYveSEd3GJ0zduJ1G5nhBxoh+XW1?=
 =?us-ascii?Q?+cxGZiquY3YDIbHn3v211QpTpr3r3w1Rht+KZczd3VSsaaeK7TqD7ea8Vsjc?=
 =?us-ascii?Q?kcEL7+U9xeb7kJsv+ZOCRwqPtWSbwHXQp1ifQDj7l7nytBkF/3rap4BO+chm?=
 =?us-ascii?Q?iEsAXRRcfVJt8GsxbkIOMdihrKokGnuZLDpJaH2yqKj+0zaXSDCwnaxxas2p?=
 =?us-ascii?Q?jfOOySGsZoejutx3dXFq3Fmw7+4rvz3bmpRoGY18JdOUlmF5p9EZ0DXuIAzx?=
 =?us-ascii?Q?c132kGwEjDaeQ0d9dK4V36/e46PiCjAplKHQ3C2HHVVSHouS4C9XJ9yB47tJ?=
 =?us-ascii?Q?y6slABU8/y+0Iuqpg0uGpYkUU70WeXgV2UtQamRKJ0PuYPhrKdlTETHlb2n5?=
 =?us-ascii?Q?udyuXxIjTu4+6VczMeAtgRLiVKWkfiTP8x+9jVEg4Fk9nX3GC3oUCgJmNw5V?=
 =?us-ascii?Q?vPfqbXJhpKYvs9LTN571vDQU42bQy5chNlOQbHm/feaBf4OS1LyBwUebYAdi?=
 =?us-ascii?Q?nfTbGGPh65352l1daw5OcNfsW/cYjFB1ce8aVy5s6B+1mwUWRH3ZsrYDR+y7?=
 =?us-ascii?Q?0wjQw+Q94H1uIIC/RvS5ds97gnirgOUhWDJ5cCq7wdhVyeKoH+fV6d/8XO+1?=
 =?us-ascii?Q?LzJkmnZjvxo3wZwRhOWzIKF18Uj88ftKF556MkOwFh016HOB6AKVhqC+RZvf?=
 =?us-ascii?Q?J3Xee20kZagV+Dq2C2oyHsEw7rttQOgs00cP4wLihsuZexsQ2O19mkunzhVf?=
 =?us-ascii?Q?XFYxeVpJVNo1XNSMjrpD3qgFL92k+xdvYAhN0fG9NmMdLnSQBV+FpDxoIfjG?=
 =?us-ascii?Q?TtNn+9uLSmyDEclfQWLHFpIBMIgexsDXQMXowOIDMkLQLhThUmLjd3KgMicJ?=
 =?us-ascii?Q?3V5qoKPCNNEcxsPwDQ+B6Omt1VgOkulAIIPbkPsLL5BV2BbgIplitSWvU2Bg?=
 =?us-ascii?Q?EYBdYJKJf3Q9I1KQ4GBz4zTztfhmkW95ybO6buBrH1agQgDnxOl7IUSXEx4o?=
 =?us-ascii?Q?YDVWN0DSERKDth4NE9EmoLyaBmM/xPN+AVPq+8Cg1hdfNLIzxK3/EEBy9iV0?=
 =?us-ascii?Q?MYA3N18yDFn7lhOgOhIc2au2evRE8ApN/VKVxt5jwOLIDGNV9yZZIlCcg3xy?=
 =?us-ascii?Q?ZdJD5oJcBn65Tg3ouTcxRhh06eXshhxBQIVHwFdqaxs2YunK8ub3bhDH9iq/?=
 =?us-ascii?Q?2ufo9iXlcO3WeKqcKfdrOK1X0DvEruLKfh+o7/7W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67a529a-abdb-4185-ddf4-08dab56d930e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:12:25.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOoFPmewhUiBEIKse8QOXLIJI18zS5TJhUSya2C+yC85kDHL/iPbu5xOk1nunFn5A20A8EiqMxZwGLX5OwrNDw==
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

Add mlmix power domain

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index bb916a0948a8..732a87179edd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -631,6 +631,14 @@ pgc_vpu_vc8000e: power-domain@22 {
 						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
 						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
 					};
+
+					pgc_mlmix: power-domain@24 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_MLMIX>;
+						clocks = <&clk IMX8MP_CLK_ML_AXI>,
+							 <&clk IMX8MP_CLK_ML_AHB>,
+							 <&clk IMX8MP_CLK_NPU_ROOT>;
+					};
 				};
 			};
 		};
-- 
2.37.1

