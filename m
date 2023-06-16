Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8A2733177
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbjFPMnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345356AbjFPMnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:43:11 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483693581;
        Fri, 16 Jun 2023 05:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHylA8aeS7SiQTuxi+Jf/TUGFQehVrsfLcpClDwJRZABM8zLmC6O8iYyw/BPdSYACTJvU9m4pOOpSfTLmSKgmP2EWNdetQqYjbHEua2LTkOdWFI8tZyIinplu3s9NqNd+I2VVruO8ZxNGaY6p3t2blU5edX4Wz8AqEj54a3Y8cwbAWWFAqf8CLCUZTf6AStvmY1g4+cjhRZ8crNG/2D+aTaa8N0AQ713Fix3wnOcpADpGWKm57n6h2MCMQvPMRCc1qyH7vncSa8C0DHuYIIvPR/rzXqLebyJ19wBwP8AzOsVtFT5OSsELy7lz0SJtUKKiZoylftUf5RsTNO3lQdgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnrCKd90iOlJl0Ik0f4N/oSjQZQQUwzhdJYr12QdY+4=;
 b=W/LxQ0I4WGIolD4s0+23AqRlqFfi2tUGP/a1UkbDGrp0myUDRqnUq82FggOd3NfUdn1WqCSOttGVq+Y75xG6XCzdgBUhoT6E3HMvSJZH+nIkmTVBIO1UcAcHadzLH2mGFGsfaA4LYrYbgSAnMVtDDzzbdQGOlGGni7pVfDwtcG7SN8SCP95QC06x8F0z2jAiyv33EY3xUGRFYSzg+/jNg17Vatr9dKHFkeoGyIwvZuTgJUEKk8FSNb8FXAOxLzwgHZ6sGU2BbDhx+V19vyZ4MWssAmhp0oseKjFgW+km8rvAajGBAIf8vbTVAXwM9tx81fdVlbHpBtfTV4g8gNoE+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnrCKd90iOlJl0Ik0f4N/oSjQZQQUwzhdJYr12QdY+4=;
 b=A3k8QpHzKCAM8bkRdhsbkatZilJ9CYO41AMs72B17u1ekSSQBRBmf2y17LOt92jw/pzz3zrDi0j7493qPf2L/HVCGvOLkafrXF/OOhlYxi17mGIKVT2eVGNv3XkqPEdoC/IyuAPDznEzHAlySHEfRurTnyf66fy+tNyfa3Y+slw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8320.eurprd04.prod.outlook.com (2603:10a6:102:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 12:43:03 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 12:43:03 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, linux-kernel@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH v3 3/7] arm64: dts: imx93-11x11-evk: reserved mem-ranges to constrain ele-mu dma-range
Date:   Fri, 16 Jun 2023 23:41:40 +0530
Message-Id: <20230616181144.646500-4-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616181144.646500-1-pankaj.gupta@nxp.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 876ff24a-afe9-4499-18d2-08db6e6739de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HP7gGG6qLqh8Kwuh//eYOSAC2YKl8QEfT58RkbRiEL3FbvdYwLulTzEJBch5vCi356JKCbhjjDuQjjF1xPWAnKX/mYTZGatwDSJgqbdqUBZDTX0zg75yCLczYDAj0CHeeCvUXCsHZSEeybVybiHZor9O4LxROkaVpQawOv6gdQ7DlmCVzVQRHDffAEYajfU/mI92z9yJvXtPygV+fcA9iKkkqEIicNOxSZ/H5F4CxKZsHjvVjyCOeqzcXGZYa48XGXSUTKcJwRyBpGOSNmwt+0Da/lhA98NhXY9VSYJO315E01Hjqy5FLjZgQldmE9BwTPkehXxO/1YeDiGNffKmkOZW3XjoqjXREjXyYrmFYkXZZJQbElmSBsGSNZTCch0YWcr78ORpNcx0u+BT6qfcmkkfjEvvLo6BSiregKouzvX/KOyF0g0Fk6RpbWh45GaTV97nNu5oG+YuDrV9Z8QnnLrGTrimIyaAJTx8TJAfM/ZQV9LOrLlQ2+wuX7uLhInrr6Cz9GFcEj4Duy+hE+KblkP05jfK+4kUIwo7rc8z5MzvjPDhD1y2I2mOkTHP69HdlAXlIZVBDexi8ZdHbvdYkCkzZXTEQyKpfqYCENVLDqfTOCunURNe+DTa0bm4UP11q17o6tlJ5o+ATyv5HYybrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(5660300002)(478600001)(54906003)(8936002)(41300700001)(8676002)(316002)(6486002)(52116002)(1076003)(6506007)(7416002)(44832011)(186003)(6666004)(4326008)(66476007)(66556008)(66946007)(26005)(6512007)(2616005)(2906002)(83380400001)(921005)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r5LLgxtjhM/3UekAMk4gLZh3DZWcbY1cQ/Tuidag0bFkShLCn89LDIry45NY?=
 =?us-ascii?Q?pzVOitSa4NitfM8rgK/cD5HYzF6d8ytj9ZC+VZv40nLsZJEOlH3XohWTJkeD?=
 =?us-ascii?Q?Vfifj+ucqfZX435c/2aBQHheHeuvBLjpk2Q88135nsgZTG8VlqBOVHh5OBnc?=
 =?us-ascii?Q?h8qdu3eGenCGnMQKkW9g1cWlhG5RW3oj6WEsUXE5YTmAymq7K1jZ7kVz2yxv?=
 =?us-ascii?Q?qcUbw7334Tg0f6jSRcP4uprVgxgW/C668kY2tYMaApVu9fNL1pfMubQ0Q8C6?=
 =?us-ascii?Q?eLBYrhT4w/emvMvSjMXZRmfGZV+XAjCGh7H8SvYJcve+RImz9t78NNirNuQe?=
 =?us-ascii?Q?a1ooiNil2F7iG0qT+npAzBVAnznpFSwfysnklMMn0gd5XIqVKu1dgoyBZD58?=
 =?us-ascii?Q?8KuHInRrYAGRFXMnaZQFyFEojW4Ezyl0JEuSl+1Gbw6d/dMc+cdt9p/5qp8M?=
 =?us-ascii?Q?PDejOJFrg8tc5y/UG2/GS4k/le4BWGTaGu2TWFNxRmn2bSsNFGJS+X64Srrk?=
 =?us-ascii?Q?LZ6H7W/6Fy0Wq3Z/WnLcEnxW/gaNm/suhamlDI8POimtfIbfZ62vlhNX94CK?=
 =?us-ascii?Q?/l25i5ZG1pBeQzH1b1AkuVfMQ/rdG1lPwQQC2RV4IqxevWkpb5robVZkFxma?=
 =?us-ascii?Q?yi8VzcuDvZ522vCm/oEqHJmnUqH+WrpI7QAr2CuRPP/GYcPfu1204709pccQ?=
 =?us-ascii?Q?uHZ2Qg1czaJHey0yJuCZg0/+rVWIlmSzX1lli1yk6ZhWyI6lC5JULDhQmt7w?=
 =?us-ascii?Q?5J1BLIv5l62gMb8LGzPgBQE3sb+JAJqEchxmLxOuwOgAvjBTTHu8rZK3rI6h?=
 =?us-ascii?Q?frb/AXSa5up7H1+PiaO1TXsSlloJlhro1GLbNGgE6n79MwXWRygFUaqpPDey?=
 =?us-ascii?Q?vKAPPSzABM5e3i2KVVHZ8QUGHXpb4pZ5qfxh4LsCar13iO9PNbZRVOs9t4re?=
 =?us-ascii?Q?zDaKF3iJ0vhCtxHLch0KajY8G/EX0p5Vnzdv4mx3wy4A0+nJL16OIIscg+MQ?=
 =?us-ascii?Q?G1GoT9+F6WcIH+YGxFTDyXKFKRzr4JBwv8kgA6ytbf2CzAvDmMKK69/vrts7?=
 =?us-ascii?Q?6Ekr1BONspWhbd3a5u3aU87zavuPPO0+3l70qb6o2VZ/KemqnUZm1LhIXBY1?=
 =?us-ascii?Q?vD/Zf5ri+iiPmpiY9je9hGNaZInvKdo1//P3WdHR2uvIfQHr66/zSrUUFm8J?=
 =?us-ascii?Q?UOdfI1iC5CTktSyFl/7feGxM8gyEwPZCcJ5wt1b7ldoFpADtSpsQv62YFnBU?=
 =?us-ascii?Q?MN8sfLvgIyLv8GNgFAHPoY9u9euMj/d90MIHWFfgqvhiBp6pVREZU9+Ymsh/?=
 =?us-ascii?Q?M19tcEEGMkLHachrGwJkt/QsyPBE0A1ve+rhQHsnlk62kelf9tRQHMEWk/uZ?=
 =?us-ascii?Q?iyCePBum/Q/pl9zp/SE3PDPGMdCQqqYzL9EUwi9/fT4lAFPRh+RuVVbK3/9A?=
 =?us-ascii?Q?qe+6c/S3sfe8exta0szjm8XkpEuIJCgLRGPUxpwQEM4SEmi/Bzcha0dOtKNq?=
 =?us-ascii?Q?cXCk8YmVR1F7Jq9BfG/XG+4eXNOrEClAmMGhgTbslbs4XfKlgK8LqkcYQdZG?=
 =?us-ascii?Q?6tK2GT2bvUlH1gVDIQzd1GQAxBoYoFPvso2egEge?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876ff24a-afe9-4499-18d2-08db6e6739de
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:43:03.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+ctXFnb+fgZQydLJM/2z2BLPLpllTYSZBjNf6rSQIkFidGk3k31i3m72dUTm4oHe+UUy9J2Vp6TnaxQ2ziJFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8320
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EdgeLock Enclave are has a hardware limitation of restricted access
to the DDR memory range:
- 0x80000000  0x9FFFFFFF

ELE-MU driver requireis 1MB of memory. In this patch the we are reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index fefb93487291..bb090300829e 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -7,6 +7,10 @@
 
 #include "imx93.dtsi"
 
+&ele_mu {
+	memory-region = <&ele_reserved>;
+};
+
 / {
 	model = "NXP i.MX93 11X11 EVK board";
 	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
@@ -22,6 +26,17 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		ele_reserved: ele-reserved@a4120000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4120000 0 0x100000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
2.34.1

