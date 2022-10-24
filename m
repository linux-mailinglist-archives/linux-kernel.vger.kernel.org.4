Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D8F609897
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJXDPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJXDOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:14:24 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBB9792F3;
        Sun, 23 Oct 2022 20:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSbzyRFpqBjBNsJ70bIP5mQ5pFLbYXDZOKx55zhz5adv+sl9aF+bsaR5kUPGzz9587mZZpapnGAASArQCiB1llS81mrA0cYqmVFuR7ez4C3uRnw2hChm+8bmTBhiid8l+XrLDULaVoHhD0TSk2LS5/hx0oXXFtHbnVSMPWYR6TKUbvVJdwcPD/ffgYeepDI+vy/UCtr2hfnzUo/kjtzBACcilJk6etFUhOW6ZryLo/Js7fOKoMJ7nGd/3ULACxWB2P08iXEHNo3UmLoHVBum7z64MJsfFPfgOu4qcTDecgryQl3Xd1dV/SnnQhXYSuurfy0HRo5stjswh8QVWDnZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvUAb3mcK96FP9e73bKTht9uQvkXPfy6sAzCX5waNMc=;
 b=Tq0TTWafMO7aEmNWhZO91pP0kHAjw4MhtUvMz7fG2to/plZcq0FMoVyEb59KWsi0eYqLdnwzVhVR2N69PNoQgw742TlHHBmhR0xv/xtZCw8HlLmBCI1ZXx3vB0ela1s2RJJ9oBoSwX3uNipBFDGW0Q/9pz74vArH3qOuni3bb50mB13Mub3KQJkVjmTLssLdU81Os6iyBakthHGP17RkiZaCAr8ZJLkNbv4K0moMRWRPkfnMMeXSFprZTvCXK3L9yNZeAast0ddFiZbHL/3jgPwGZnxaLY3aMhXnH2brrMwhxMSigSh5QdbwTjiE40HxIxSdVjrXhhQJFwAIuZ5GpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvUAb3mcK96FP9e73bKTht9uQvkXPfy6sAzCX5waNMc=;
 b=X6OoeRhTTWd5ug32MzQOjqVfGlQ2fbh5WsUpjA4UotEIwJ4ysgoxzCFMtRc/Oft2kaQlIQ80Q4RkCqfyqwJgBYpmaTdZS34DmqM4+M5j/aTdQJ8yvzJ8yI31eNBh3D61UJ1/nJ5PERIqmucenzx67G3rwdx8occXnhDCXghkZFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8340.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 03:12:54 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:12:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 09/15] arm64: dts: imx8mn-evk: set off-on-delay-us in regulator
Date:   Mon, 24 Oct 2022 11:13:45 +0800
Message-Id: <20221024031351.4135651-10-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab0e5c44-9980-4300-5b33-08dab56da444
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cicLV1XBMbUgZWot7Cv1Fh8HMKYgNpxKb0uBbUT1ZCjiMsFWFd97fibeVUjbJWTiWEkyHg5pn62mHdVYZyXpBOiO03A1YhM2XY7+EfAR6TbVutDuyYURYlr/BokpjJSfN5B0FyDorn6i3hvlP2ys/EfmCQJ4GUIY+/C96AiFGHKD8iTf2AMNLaBZAtT7kJARtg2UzRy2JlvuJVDRUCPubzxCeERAbYvxnlvw81ICOd4B9o0Djso7ssxAbCOppkw4pCsKbwuWhIWYVOSReZFcENBAfJSlmawuPq4CS79eopjdpTGQZhlCPmDb6lxcc08Yxfl5hVweSrIJMrNGfzWTrkKDFHMv89eRP1qx/uGZYJ2FtVYeNuapWBAR63lyyKwJ2GnAa7uabQWb+cszqAsaNIiSmRi6m1HL+P+/t7wKePsVpF2FGXc43p/7bD42DAcryolwh5ysX30fmar3C+XMgimNN9MvISR3+a7XzlO7G2oXrh9KyeYGaIv95NA26MeMrMVxtrAiNOzvcvKBu3BLATtAxf9TlPrr0xUrS7CZ3AsIJRzt1hl73jM3VU9y2o9lbqetM2TWH2sh1blQ9LUKgishvzH8hC/N6+T5jyP7O3DpVDHz71EMBpNiFe/G+lzz28gVkenv4jJ1vWGVZnWMF4Tm+SOBfDrInnDjaTEEYzVNeSX/RjkQHHy1X6lVPfyV1gyzQZO5lmYo0MyJd7XGajKxurpP+Y67F6pHMSCmeLYiELzqh46ayP6wknWUPEg9+0+Gvzk9MARnnx3ZW2wPJTliVOun7k3X5Akbdo0PgqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(2906002)(41300700001)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(5660300002)(1076003)(186003)(2616005)(6512007)(26005)(6486002)(478600001)(6506007)(38100700002)(38350700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3hLgmaX4sWHsXgUZ1m+FjMKCyLIejATPWtlsvGh8ZSo0Df5tJcwIxDWEZr3Z?=
 =?us-ascii?Q?CCFWAH6P++Xd3doi0+FUi8II4lBud2rIzEeMv8+ePRUBhys7wY9IxQBU6RXK?=
 =?us-ascii?Q?eAe9QdywMdjgEudgWJ708HRXb48A7sLxGnIVXARv3ChjTeUBhexrRoSgnXHj?=
 =?us-ascii?Q?VyHWPQu3CXDbLBFs9rHc+04ef9P5YxxO0cTc9WvtBZ4wP7XtqkjAyUsf7r2a?=
 =?us-ascii?Q?PbFhbpY+b2AoJpkTPSN5/QP8d93axQ6xYrv3CcfsMw4mDp35qZvCl8TkCMJo?=
 =?us-ascii?Q?iqxqSp1B0+EvfmNy3PIrlqmnAClcXR5IjJUlOreIUtORtx1qKuw2JEuLH47c?=
 =?us-ascii?Q?mzNv0hCOV6IeIDxCmwPxdGMipOvdv1d5nTb0YANwVGFP16XXkSI4jcaJWVKe?=
 =?us-ascii?Q?w/2BRiOQJdEe5pYe2Puzc+IztM9WKoOwrz+vwnFIAq1VgcLizYdHlham2hmp?=
 =?us-ascii?Q?M0Wjm+HIYYDPIHkVhykKxmskCh58pjm/WPNauEltEqpNO9TF6Al/HaXVslEM?=
 =?us-ascii?Q?ueSu3OYBRiw88EeTtBls2zZlFJURDzS+aDqYmo6XgWRXzY9f/fGkK0+5ddvm?=
 =?us-ascii?Q?KKns0f946eoc0TsgA2QyXGjpK8pm4KZcf7nnnTGo4XNVW4qSoSH2Lw+v/Tkg?=
 =?us-ascii?Q?IaMLVdrKAavAUKidBvry1BxiP5K4WpXa/1sJBUQ0Tux7bt6y4Qct/fvg0M0h?=
 =?us-ascii?Q?9alYyHR5eSQcijBs97vHSPYdMBkepIb7Pwl1pnRuEV/cXvxl1xO+jVqSvBT+?=
 =?us-ascii?Q?I9HfCj+Nx38z5GygL2jsl9kkuOefyvMBV3gZDbI4QnPi1+jvCqYX5RcCeXQ1?=
 =?us-ascii?Q?bY+uptNhNl4y8ZVJjIllGNjSvXDvwoDA5oslSPmOduQxF2krGMvBaGsAQuud?=
 =?us-ascii?Q?2GPr66KLfQtCyht+JqJh4I68weZLvPTgbjvdAyaZvTd+NKleMzP2pJRytapY?=
 =?us-ascii?Q?AQKnEZ9OiAo/Mv0aM+xDy6ruAr8x/YDm07ANi9D1CvDV7CMqxtp1jwXEUvyR?=
 =?us-ascii?Q?4/ea983gHOBXAJm9GDmvhuZAICi5lMcIyi0aom/61SiXplJ1WSxN1y8IcRUS?=
 =?us-ascii?Q?KcCSGNaClD7l0eUrs66TAJzY0D2gPCwCHpvAt3Vk7dOrgpkVVRgoDJFE8+q7?=
 =?us-ascii?Q?bhgUCzniB92Pa1/O4bnbk2PLS7hiGB0mRPBOJapJv0Y2CpbaH/pFJ1tRMmdg?=
 =?us-ascii?Q?GtSuArFTgLopgDlWZTuLx3/plI3Ka9p2iBU2SknaB94feLXd442JTx7JAIWP?=
 =?us-ascii?Q?VfTeScmZ8OWpXU/jmggD1KWfEviBsXH//DsmH4ncEg2UwjAtfZcoYWwHMoOU?=
 =?us-ascii?Q?yRc0K5YQp/u9+VYaIChdGx391Z3yUDDdsIqj2m4BlPJX5iqufZgqlBugvF7j?=
 =?us-ascii?Q?qG6RLGP9FPJ6qFptsHZfgh5L76aORllZw6UAsNBrfqGhXsHprjOnLzbXLCJI?=
 =?us-ascii?Q?Uh3gz1ezxG+hQAoURFhsmQ4V+RR5/sVOChA09CwlC86WuQMAinZ4gyvYemOY?=
 =?us-ascii?Q?HyRDykXwpd+Yo9EbONiluC+Lolt6lLHeY1KCKDTTWAZNjDPk/tT5moYRzsBB?=
 =?us-ascii?Q?yrXxURT0IbrmnNwMOwdrjbFgfxpsGh3YM9nk8Mor?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0e5c44-9980-4300-5b33-08dab56da444
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:12:54.1476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chpvPV+f6Z3YIeUsavSSGKo4bcn8up/sbLxd8sIIfFnU9SBjeF4sQTgwJOblMc5vHAN+wW6ApI2C+VYf/uwWjw==
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
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 261c36540079..2b4395854283 100644
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

