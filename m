Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D44654B65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiLWC4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbiLWC4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:56:02 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98B02870F;
        Thu, 22 Dec 2022 18:56:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5pWBaS+xt/4xm1Ei3YI8eYo2ldAFnDQcShFmzL21XMk7xV1SpelhbgZgJJOJ7nN8leuWcsCNwi/7uqifNecQLn/Vbijw/4XyKDZHRq94zt+W6r4Yb8gP5MA8ibk3G3MZxDF6L5wdMRu9eDbQI8CxXTpcHyacJaGxVEasEUNr1BeWIFBxl04jqmOMwRaZ6h+jEgcTGqUyII7o/8OV6n91BrZE7Pq8IxnUkNpEzeJ5tPu2t/Wzk3GQnmBNe4uEhF6c8RxE1Cqp4kZsJnPzmE2yQDEsrOBtQR+dqxT8Rr208X+19yL76qci4/YfZKPEpqxOO5vP7WV+ECwYQL17BH94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqfSmCI2z0OQjf6rBxm7pLj2wAftiWnZI2EWd+XCFRY=;
 b=i5M9IcheGyUR5MYHdWQFTmWqmiSckwnjSKZaZUIHtQeUdWOHZPbbAnBbTcPJlKC9+uNPB2L30bkRE+sz4CmDvGnvJiG2OCH8CTJTIn6zLfrueINkj4elKxNUn13hktfYBU9XsxplX19UZkEgnw45IbdNWq3iJBnk4gb5y1psTc695lY6/oia/8CK+wxPtTN+i2S3yM2PY2ak+cX5RTN0KtOjDX0dx0KIwJ/3UjaPUjgV3V9YxelNqsPxlLrpKBF2exM8rsD6A3b+1RJIX8GP14JmYnqXtx8Zj32fQhPwGxy6xnc7r3NicgFjVh2C/tiQKef0KaQiiJP52k2aNuAdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqfSmCI2z0OQjf6rBxm7pLj2wAftiWnZI2EWd+XCFRY=;
 b=G3Bd9W15T7yQGQD1aEikiY8QzrQ+O87YHhk1eN1aKjvHET7q9eV8kXRy5y06BCwXKCu8Tnz6fXrE/7cgvV0Adif/HYXtaZfRhKB7eCyczLn2VwflQ6dqbp5L6Eamwebm3X5siudJL95GepjJaDJW4hrM6PvSPOAwPFH8kgzz6tI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Fri, 23 Dec
 2022 02:55:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 02:55:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/5] arm64: dts: imx8mn: update iomuxc-gpr node name
Date:   Fri, 23 Dec 2022 10:57:02 +0800
Message-Id: <20221223025703.15784-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221223025703.15784-1-peng.fan@oss.nxp.com>
References: <20221223025703.15784-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d59f7b4-eac2-4971-0495-08dae491378a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qm4xnOJcwlEEu0THrglL1HNqKqUrypUy9cmAUBXnojCMRwDqpNVXV+eH8DzPDJuk/ciubPNfNKf1dsfsx7lrWreE9UL/hgpzPuTHYBP6yzGD25oYq+EHO8gUcpNzPx12gUkOcpNCW4heuFUTuWBG/OeWTcAcrNddS310weKcBAh2cVPLW37OqVU9OKV8ZXci2DBacDP2UJRfjgr1PiZWqocZCfUqfKy2stRMufz6DWYQ7HigDOOxy/K/g9IeoX0TD+5btgofqRB33p2/qQFIWQc+h+DLecH7ldcZRZWBujqM6FngwY4JwK6rLCMl+jk3i8j65Xg2O3TGNREG1+GIl2XE1w/aHzAXHJFZXfZXyVmQ1TKlaNROVqNvVSiZX3R36al0+Csn55Ix1uJQGOeNzDlGuUGbC7FOuWQ+s8AveNmwXhDe8KHEbDWZGpUcYDIxPhnKf8f8xwUyteoTs8y6RzDQ7VjAtAyTO1GeFeh98VA/v65sdXQHj2z9avni5bysu76r2PqGVr749HOaL9Y4YdwkfRJBoeuGN5yRwpwZrVREVxWtyFmKV1ghkp7TnPc5qiDB15L+GlvcbKOHxvZXNYXWvBWibtNNY/E3M3XR3Ecjc466V753QqC8uXEuQ7oYUKLGo9RcJ8Ibsxy+uYArSp6VTkS50LqGV+bK3hjP8DNIkbq+Rx4odR9DK2vVnsG8sVG0RCDgUXsmOnkRRatJtaNrt9KOPdIlUJKlf19OS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(6512007)(66556008)(8676002)(66946007)(4326008)(66476007)(6666004)(186003)(26005)(6506007)(2616005)(6486002)(1076003)(52116002)(478600001)(83380400001)(316002)(86362001)(41300700001)(4744005)(8936002)(5660300002)(38350700002)(2906002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cb7MozuG0p0zrh+Vk92/Vz1tkgTzabndp7BYHymgNN2ANiPNPsQECWdj9mO5?=
 =?us-ascii?Q?kBpGTm+ASlBSLmo2zhBZjXL5DKHyK/f24XvyDc42g40GhrlYLX4tVi49drbf?=
 =?us-ascii?Q?ubeit18wqrOlKm28Bl0yJzOF/rVBzIvoSY+eElSHwAdZXCUsxlpft4E6vKyA?=
 =?us-ascii?Q?S+DcayHPRx/BoAFiCdZsTjGuh8qVGB1ibeu+hTPtvpkgSQO78PZjT44bGjK8?=
 =?us-ascii?Q?ZPGoYiZUnGl8cZn3EdAK6J3AJ3leXIWPOLr1Qs+9W5ckpJxbrqeWDWadvNPy?=
 =?us-ascii?Q?eRvw/uN3PKBFeeH1ilFB6TfJF09aSv4NewlqHmFtFeZoxUlIdEmr37e+fxDv?=
 =?us-ascii?Q?Zj/bWyeqvH3pJWLHH858ZDOot05DShyQYobII6E9GQVKnSCmuHSmNwN1UJEw?=
 =?us-ascii?Q?u0ObQwWWlaR6JIGZjBkBDQN7sjD/JQxQWiOlzJbNwX4zP21CEWkmDycfemi1?=
 =?us-ascii?Q?evmXRHp3A+9lkh/rCsyXv52rFIqCc16tZzzLojxG6IDdK2fZwZfZhSu5KAnK?=
 =?us-ascii?Q?tTGM6DRWWI0o/DmyPPwpSxrGjYRpDNpV5hRFDzU+0G1JvSygS6bL0yI5Qc8X?=
 =?us-ascii?Q?l5GeGKrQFC8zZefYd+EAJI40geFbGPxMRwmrzwAcnMtciZACeNU3xFvp6Ca2?=
 =?us-ascii?Q?l0gHKk8bVwv4oYHrkbxKh5Msl3dPne16mtY7IIIjTeaUfuqvCwIUnE0qnmNQ?=
 =?us-ascii?Q?yp7uRB3EtMdlCZKk3mHReRq/YKG79VjkpK1lyKxStlSOyTPe0sAMF6E1YJJB?=
 =?us-ascii?Q?Yrr4+kTnporcR1Z0Twea84MA0Hdc5QCylt9HBFq0oGv4ss/b9+/EqyleuaE/?=
 =?us-ascii?Q?5GMl1me/HqYXsD5RfazuED5jzR85CAqsZmoSl0EA3P36JCiuw+kQ9aCTrrbV?=
 =?us-ascii?Q?EZnCaGbEXTeicCyW3UL5IrzV1PITRDmykqzdwy7B2shv2gOBVnLiqWV1c3l6?=
 =?us-ascii?Q?8Xu2qTzdvoGxLQCQo46SckR+yZ3QemBgXa7vWKBetPpdxq/AnepQhlxZUAKc?=
 =?us-ascii?Q?RHj+Xyzmg427CdQU3xo0ifXSAMDdqGk3r2PlQIdCCLaZwOoqDgMZbg8uZ8q+?=
 =?us-ascii?Q?QrmPSlghI2OYaJ2/YufSUVXZ/JRJ/8zTpwZKm/hpb+A0Rlmb081bsrAyEqso?=
 =?us-ascii?Q?/3cnjfncUzti/RG8bNKC1pXrgPNivx6DNvQ3M75YsT5zq7XH8P/HOkR2Qq5m?=
 =?us-ascii?Q?lxNtb6GRCMGt1IhCaIfiQdz64Yi1L7k4hQpFCtVmG5j3vaN+QmWmuslE7zn7?=
 =?us-ascii?Q?7icdAqxBwFPGajADNBw/iiiKbyvQznc0ujIKKXtglAI1a0zXwNoEvffDxJYA?=
 =?us-ascii?Q?no6HTC/pm0jixg9KS3zhgjTqxbvVrEne6ghcgdlHyGTck9wTpK3tVKbtubTI?=
 =?us-ascii?Q?58cVBhsa/GLyPd/fUDL6jCG7qwWYHsnHK381f6WRJfywjrBY6MINjs5PBNgd?=
 =?us-ascii?Q?p8zboyXo+aeSVvOHFWMEVg+iAAUEh4vbMf5HPbNRsDCOAWk9dF8eVWkSgHQd?=
 =?us-ascii?Q?cydFpLSdFzvzs34XZUyG7TGz4UM1sz9qQ6ryuaMXITABKsoGK4TaMRkaL7+5?=
 =?us-ascii?Q?wZj4/jCH4vd8MeZIalcWwRIC+6t+pbQgu3scK6VH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d59f7b4-eac2-4971-0495-08dae491378a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:55:58.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6uwUDACVfa6N8+XxBrsGA5PbCFYUbIgsoKXu5lcWcsSwDyvDFiyiOAxt02Wgkgx11FlZedmgsOuIRE+si5DOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9642
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It is better use syscon for IOMUXC GPR, since it contains various
bits for system control

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index b7d91df71cc2..08ca91bb1887 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -552,7 +552,7 @@ iomuxc: pinctrl@30330000 {
 				reg = <0x30330000 0x10000>;
 			};
 
-			gpr: iomuxc-gpr@30340000 {
+			gpr: syscon@30340000 {
 				compatible = "fsl,imx8mn-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
-- 
2.37.1

