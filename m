Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E76A605BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJTKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJTJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:59:43 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1F71D2F64;
        Thu, 20 Oct 2022 02:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+aRLGTbE0nW61S+vElagKyxagTuBSLzd6+sPx0ObsVDOpqkSsgzi3A3jrrYPXbEP4hdqbH3OimXUzexKEfcmd/1KbSkbT/vdMGdxLQKHoRRgIZpVcxc6Mm1xobnYNasgefZk048j5CAoCO31FieNABe1bil8HTRcr4Ld3OpUSqmsIe0e8g0gGz2SXj3I6GpNYxg7BN54P3eWzZuf7UnOY0bgUfYealKNyQuiPedZp0Cx9gZYpiiaNY+0sOdcHFdxKU72vUezLP0mC1AUU9wNPT9PHvwRXgOesDhM/YxsvP7PD4Mt2mp3BjTYKjpvR4lk9g0J3i1Ez+6RVE77861Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvTpscjAhb9AQiEfZFdUGGIPMDQCQ2mqyIJfZV1Wwig=;
 b=BCOkWVeQTWKpAcC+m3by6UpravysB9x1xWww/8T77oSgwCg7lY4w7FFp/IKjy3Lm9OjkgcLLyZu9LvA1HNFzL7wDpREQGjxnhcyBCTlsmvtIcgkIooVZufs762/AeCFZP8HZ8K8L0RkZvEu9iZNLEwuGlG6RvSXhDkDjb5XrjNt+NybsrxqNzc5dN7IsKNraqpiBWfx2ocDWzvg+OfE1uSlwHlNVz5IV3c5dznziQyyhF/EDi0nYBv2MVtSkmrvXfjhiqisV42eKKh7d8heStRuNAd7YF27pFB/fVjjrkK2kLDnzq7npTK/aOMVgsTPowZMxrW2jzQpw9mBu5Mxucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvTpscjAhb9AQiEfZFdUGGIPMDQCQ2mqyIJfZV1Wwig=;
 b=CG0m7uMeLNDn2FOFnuKBseQHTZ+DXSkYWteVHweIqC5Bw4pOu5E6pXcdGNxbLaJQeYMiSxrI+5uuLrHEzkDKjSrPp9cHsMdnCCgzRZ01GwW+pEvGVg9xfaS6U2yRK7H7jbCdVDaytYHX39Sn5KGLPTURKtyEpTVopkp33l/iXrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 09/15] arm64: dts: imx8mn-evk: set off-on-delay-us in regulator
Date:   Thu, 20 Oct 2022 17:59:28 +0800
Message-Id: <20221020095934.1659449-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: e8965cfb-a3c2-4229-4e05-08dab281af57
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fD+UQ3igDzgT+pavMYR1rBtMnawlllmFIByGTZWYd69tlSq5LedpaFXg0bU8c9d9QYyIuFEOlLi4Z5Sg1OWQkkSrGZBDjTa8m4kSFJ9sBtta10By09bGQk7fbnkbXvzqX4liRoudkZBxN0a9JbKBdU39hiFRxZJukING5gVAkQjDPJFLcofw+eyFEVrK+D13jRaepghJteqJfSQBmimM1bOBfJP2W88bQJ7bvdH2UXgExK6i4lwx6VmYCAm+GbOWzcD7Z6SaIfoiCjizW5iC1ur8AlNbf8ZFJ61yn5xFfOZUGz/b8LDBGRIQmLpPk08BnfeFkM0NIOpZO4ft/ME0ume4ZRfnkCPp1xKrsEJu5JDukMjjL4fL7Ovc+km2tC2BR6pLsiWhY0PtN8JI5PSzZCkVHZoDR+jZ5pmpgA6WnL+tygeTL3xrovFL7ZeT5DX/eHxAv/dp84vuNpzXKw96Y2Gc1G2CHBemy0gcEijdJtDbbWFnEiGUom9hBtehRGQErtGwOR7H6qjZ8hh5eiyLx++SrdC8XNkCtbAWmQ5DNBDBsC3Tu29PBRaPsbXky9ti5RoT7jaQL9o3wz/0ZCD/mq2Hv8dNoF9tfSUUr9vkasGxmqZANj4ACnzcOVl1tX7yu6t0n1FFfLxkMGGFoiP8UidLSLuFb2JuK4Hd8pcTNLxB8FOT+Uhexq6s4WXS2exTZ1OZSK4Ftoi9EqQ/kF4f4tkOTYpAy2/iPYh1fHFYllqSoLb7wZB5nYcHlxjkEOU47SJNCLm+9ro+0YzvTk9hB8Gg3ay17UuJsTD2mIMyyiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(83380400001)(478600001)(86362001)(66946007)(66556008)(6666004)(26005)(41300700001)(6512007)(4326008)(8676002)(8936002)(66476007)(38100700002)(2616005)(2906002)(38350700002)(1076003)(186003)(5660300002)(6506007)(52116002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZIsn4VxXdP4z0QToOOIYQivR1i82GHlkq5Fi8D3l6xbTQ+d7O9riNdbRL7HF?=
 =?us-ascii?Q?k/bTiiFxQT4SX/EX+JN8rQfEnJBFKsa/psneq8gal/DpKJ/aNXdURKhhC4QZ?=
 =?us-ascii?Q?a7h2CPZzhV7p2+kayd2WjJKdpyKi8Fgt6fYmqViuPZoigJSSoD2Ep74CkFCd?=
 =?us-ascii?Q?DlJWLw1D9vd9E+ZBnLTRyO59qwVKhniiU+yx4t0c85XTDkzmBc917QvvlRbw?=
 =?us-ascii?Q?c0xsvRoqp8r1Y8SdeWnaJXPVUoqAXDr0NNGHb3Wa1Z44uF6raRVtnVO1EEmV?=
 =?us-ascii?Q?9h+Ue5cAnHymGow77xrAZPTs9XqAlX22Lm/XSIs3EAzaUh/vAM6jxraZI8uF?=
 =?us-ascii?Q?iN5lsAo7I4s/+S3iDa4fQ/GrYTLZnl39FsUX//3CsOuxMKwBWrN+xHSF/e5V?=
 =?us-ascii?Q?p7prCSzw2suhOdUlDGYpV0WfeZxBp+OLyeLRo9xDHsrNNh1sd7KSPaZeaSC/?=
 =?us-ascii?Q?nDH9YexT3uPHgs5rh4l912Y6Um74n8BRlyTr+o6mpWrv0MNzUI0Edkz8Aq/0?=
 =?us-ascii?Q?SumpJ2ZJFsrzGtKhD8l4HpvnxyeupWLz2kwtpYADJkcJagpT/9SaO+ebReci?=
 =?us-ascii?Q?hheV6kKjVsCK5wdrFOI5nq6qvS36ssDWYpRgVuhHaCTRCUaU6zeP10XLKm8B?=
 =?us-ascii?Q?FVPtsXdMtZVSVChrGiPspWOsxYAVD1CUMa72ttKs5L6PDF83Rd/9euw2QD6X?=
 =?us-ascii?Q?93+4lumHAgU+TS6ockQVQD+zSL4WmYAuNQTYFX0wv3WU8ZwAB8wNUewtxBvG?=
 =?us-ascii?Q?2tjRg+H/R6CAC4dFp5uOmIEsn5xZfvMjeuKH18KDHut+Y0jKmhM0so0/WKZn?=
 =?us-ascii?Q?bXDAmCsZ+RztkXQbdxW60mrXPhxj8yuOrhGXSnLsNlYCq/tbvDkhjqTi/OfM?=
 =?us-ascii?Q?lncqZXaJS7wGkEAQkUWLiqDDEurznGN8F9d+2tx/Nyw/y+98kKA0StLxBzLq?=
 =?us-ascii?Q?NjElcwG0jP3rG/KayFgw87KZhI39w7cYwk2eg+tVaSwzJN8k9bIrS/Es6Rgz?=
 =?us-ascii?Q?e8jIZWhM61mj48TAcOAFGnDHj0G+2WIwWpamae60vGZPupqv/J+SEdTHQfFX?=
 =?us-ascii?Q?z1+aE8mzpdaavWc8+HiFAUd1Vh8LXNIS9wy385ZMpljl9d7OfFfwaLN3XhDY?=
 =?us-ascii?Q?AboMZWbjKVlKaSoWkRihXbMWgVYb+eC9Yt+/gcF0BjZEKquaTrXSUI0/nunZ?=
 =?us-ascii?Q?yMotku1jNcg2IDOh19MkDmQK1wywZEiQI5q1Iwaj1wMvMbV7k2ghjO+7DL70?=
 =?us-ascii?Q?GBK7kIehRH5TQh4479b5pUIO9e/pKZxNyW1+ZNozO7wEgWJ4QFtHWawSF+FD?=
 =?us-ascii?Q?XOofGP4kD68zGU8fmoojfcnaUnRjjSKvNVNFZGBe3IzoJYk1iY6uDIqO426q?=
 =?us-ascii?Q?7Hkjpin8nyWNfeFB37prNnIZLRXkFxQ1P32/FLGCZ6B3aNOQpNsUjJ6LXPpk?=
 =?us-ascii?Q?U8uSFDpy37x1YS9oWinMd2wUuSbMIH1U+Ly+tW/hV2NxbdZrYDW+ah7560gP?=
 =?us-ascii?Q?+CumYrDtfV7HIG2jbh0nn36FT8KMyksQYZ++Ohv3yGpLy9neAMokqcvO+7nb?=
 =?us-ascii?Q?3NIB2h62J5poVO39hvyIyhU1VKNEtLKxmLSXBXsB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8965cfb-a3c2-4229-4e05-08dab281af57
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:49.0325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kf4SqxeD9OSZQBQeDRfqs80UlvRGcv853iun4WeU4JsB2FiAdTvzlgM9eZrBJwWEWtni+guDcSfIRK4cH1Ct4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

