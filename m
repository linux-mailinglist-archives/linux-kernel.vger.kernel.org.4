Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0832A625EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiKKPsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiKKPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:48:17 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F1256EEF;
        Fri, 11 Nov 2022 07:48:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+9dXhlCA63F3mRjyANvQZPSmegmPKRL4mxXSkr6ZK440sF9qvztbTbEj9XdW6sYYdgHdJSD1Boi/vwM07tQ5yg007D2a8bwHxNac/8P7KyKFKkUGQih5pbAzZ/aXE1R0/SWIbjsaSEvzFfK7WCS0Q/yybyg1ApqNpKI7t0snWn900CB97hCoSCXwzau9Na054PDDE4+y0ieGG4GjOStdSky9PuYgTca71dk5UtpalshoVC+vZJ9AgU9lUAlxNegDSIZQGAXNstYBYRXJRj43B7F5ifNgraIF1lhfcaM3xegAFN9PgKwRxLIkv41uyjDUPRduU1jWYa3anCHrbWjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNERjs0wXE4pViRLRJId2KWBGuGqdPFKI3z65I6wMzo=;
 b=buv43DtHS2HoXWU1lx7bMYp1TG6QtYzKuwmdi/Lgt3ZhDdv+xaSRG3+zpp6zrHQuC5gS/dWh+VbVGR+wXKBzNmUGNZJdALdaH5A/cUSMGSdz3TaVkJBFu23IAzsQRXMvKmrM0FoVxf8/WK4LZbxpYtqaUB5jpCiGZsLGSt8VTvO8ga+L1waG38v1za3avDNqb+niHiFg4l93NA09l5dwxiII1gYDwRJcmElUS9vnZ5FPYoNSouuXKle+NXJJkfJrsk3OGMm0WphxlEj1mqTS1bEyOvo7y7QFxNxmzJoTkCt+VzPgg9nuNQLSyK4210vvXEku9AmfCDdONw4DXPb57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNERjs0wXE4pViRLRJId2KWBGuGqdPFKI3z65I6wMzo=;
 b=cXIziP2FeFAp6pV76jPUIH2yGBeGpsFGEpdFm6P+opK+7k4CtCtA0wHSte3wlsZhcZGGyetQaLLJ7XUgBf8V/bK0UX02EbMtA8Cdkf4m3ig23sLTE3MvBt4KgQkCnhFb2i+gJ7vXbphfE6U906ug03OwWmDiTHxmiADl+P4bhrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB8PR04MB6969.eurprd04.prod.outlook.com (2603:10a6:10:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 11 Nov
 2022 15:48:15 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5813.013; Fri, 11 Nov
 2022 15:48:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org
Cc:     Frank.Li@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, han.xu@nxp.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shenwei.wang@nxp.com
Subject: [PATCH v2 2/6] arm64: dts: imx8dxl_evk: add adc0 support
Date:   Fri, 11 Nov 2022 10:47:38 -0500
Message-Id: <20221111154742.2753318-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111154742.2753318-1-Frank.Li@nxp.com>
References: <20221111154742.2753318-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DB8PR04MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 4573ccf4-d93f-47d0-6a2d-08dac3fc2505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIK/R2ZlQoWN1KhmWYI3R2L44UJ7djJdL79v1A7vzgaDdTtEmYyVgGFGDJwJGsqf4vUGELZDYU4XMEnfYqtSy0mSN3wzIj1dCpbHkVRCJ4lzMmiZX2TqMiU5pFMmNLp8jxSanCWW/w7UQNz0WFr70QYcFPgTB+uOmw14kwt32GLu2HP/xeLRPZrurNUdPNirMsRWvYo4feGqHd0FLlpzuthjL8H3SBQbTwQmTSRFx1DbAek00sLuiFa4XnHn52dr0CO9YW3LGyV6tm0lns+BV77HHP4RyWLzcKtwXikND/D3ZFpCOGo8g9io5TX7HCeukmA/N0GX+N82773lgylRpNevBPgCJZkxNj2pzRUCtEH1kSPy+mnnSVYmqkCoK9izuk8sE3sTEoRfOb2PRmYevmPxK4E1Q8l2FoO15QFoC/zcLEgO9FtH9qCpK3/S+OJ3kLIYs3W5K3cYMA/3Cr98XWA0bHcFWgObMq5Ytrja49zu7i0Gse0dcWeSC105+fHCBPACH5Bu44kwoej9LODcMF2NFmNuiXNVKH/dBJDdjXADF2jR6dj6IA9HtrtpeTxiLXGzmsSEGKvJO2ubRrxTk5jTrL1o7OwRbqeUd+TYwVn4FdVhfItkjvues/GbYZGhEtyLdaYC4/puhGctaR07mLHYfJlHTI65anyNLp/D9dfFwL7PL5eCXD8q9DoZlTztV/ce2uHlqAy8o349jlLV9Fhw1zJqoZlr+oECbyiqxyIfTijR1tJATEAsAcY9yh+doPVeVrwCtiKLIDYQUM5X5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(86362001)(66476007)(38350700002)(38100700002)(478600001)(6506007)(8936002)(41300700001)(6486002)(8676002)(7416002)(4326008)(66946007)(66556008)(186003)(2616005)(316002)(26005)(1076003)(6512007)(2906002)(4744005)(6666004)(6916009)(5660300002)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PvrVAIsHf9pSGhiRyMGKCK51iS6imt1KBlrVSoX7j0X4TfT4SiDVQy49wqId?=
 =?us-ascii?Q?PrDX/XJ/K9NdykXCdxXCQHljGTLToaITnpbFQ/qDEmmJDyAE2sRWcvjA2+I0?=
 =?us-ascii?Q?Mu5zYjInkUVnkQKFOTZSyQd4z3BLSu2oY/JCMOPph88E2LirAmh0yEwknBbz?=
 =?us-ascii?Q?jdoC9gTO7wINWIBYNTFeZSrRFl4dlqw+djpKMkMwyXyc5ySWwQHtr7Mey2Or?=
 =?us-ascii?Q?CzyAlNGXSABLRUzyR1jIMEHl+tGBcImC18+2NTahYkqC9V/17Z9ufrxqa1p+?=
 =?us-ascii?Q?k9wl/jTYsGZEeJ21mDL1Ajnshlr0qya0zFmBlrAO++F5pu7WbekPdP5/CjQf?=
 =?us-ascii?Q?Ux7hGtHJ0UfFazLl/64OR5Le8mzBHSyWmtrRqg2X4R2i3r3ZnIbF3slIJ3+D?=
 =?us-ascii?Q?gRQ1HPBIDUS1oJ/0joUFgg+RJTXZpa2/4ULf6YHapfOt7XlUZyPx5lSNmzAc?=
 =?us-ascii?Q?4Jd/SQCp6pLA3d3I8KnWRx3WOpvxDddfRNn3G4S1Q1XHv+vfYHAWs+byOpkr?=
 =?us-ascii?Q?g6Z6MnsZbyYhr+R8Y++webofVfWcegBp2uaXQx33VgCPjCF6IJBoBuca0jXk?=
 =?us-ascii?Q?N6gJxFWMQnPMrNJeKs+0lpguXPm03bkfzxN0o/81/YI8thNzmztPALuyD3F3?=
 =?us-ascii?Q?34ANWQwwDA+7fKC5rsQBBMYLg/eV4hZj+OyFxMTl3bWxYVdramR1vtfk3ldX?=
 =?us-ascii?Q?xjCvhpZbVEPWcQoY/PSze62Q4AcNZhARWtxSD6bm/WwihyObLELwBDkSZRUW?=
 =?us-ascii?Q?8lXEosSYp+VbBUprR6Jlw06cjjER596yEgX5ypydnHqD2Zl0Fva09p1LcmtO?=
 =?us-ascii?Q?FBsq8N676ZxHTVRKByuBfKCImvAVioostJ/byj5d6h2bKnI6Bl35G0gDYeNK?=
 =?us-ascii?Q?O9HopMdDwPN2eeM1OO67cuV6R7FgpgvSCS1+cDsQK05C6ZvK9UEO30h1uIy/?=
 =?us-ascii?Q?uXXq1rqArDFSb3VQfqzLIB5UhoJfBdsdYg8tMikFo8C84XnWgYzMZroiS3Jg?=
 =?us-ascii?Q?l5cys3e2EmukKZrF4iD92Gl5x28pPTgBvv2FoCc9dfzpTVwMazAUROUmQ6AW?=
 =?us-ascii?Q?Bk1COD3f5BKrJuk4vrD+5vCfwR3dHQS1jiU33kagFFF9XN0jQR+m3YVUfg24?=
 =?us-ascii?Q?lwgNwyXKL21Dt1QoRVAbem1AEna6qudUgOrBtm6tKJYxpHxWvOJR9Zo3b9ND?=
 =?us-ascii?Q?ZXhsRdsdfveIPjEMMK1YO+mk+A8zMBAlS3tGqMCu45ixFKCMygXwEz7Xt0D5?=
 =?us-ascii?Q?+r9pEBesKETgYQ5yVgt7FglTlcmwdqxXn/dfnea+aU17lnDB1YcLJLpmKV9k?=
 =?us-ascii?Q?FYjfGdQP5RAGyvtKkRAkmenay+MzPHdP0ErJC4I81l6DLLom7hc3556hG2KW?=
 =?us-ascii?Q?b/BH+4FzXNdVqQ4ltezKKOyBCbAXd84tOSgLGxj6tdMpgeDXTAuRkcKwUZ6G?=
 =?us-ascii?Q?I7FBVSDhkybrVm8ZxDZlAdf0hhaJf21hc05foVM95s8YcJRgM5kNz9+QBYsL?=
 =?us-ascii?Q?nheykWX/x0AYEySpP6GRkKaIFke+aDsKELyLqzsmyAD7ygyQDf3TS5wMij3v?=
 =?us-ascii?Q?S2Cd7Z6dyJQhxUwoj7E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4573ccf4-d93f-47d0-6a2d-08dac3fc2505
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 15:48:15.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ii9LxqHbcc3lapXnSZjLlCMsHw+Lp0ibV/RrIIF/0eHvY29HxfZyyZvyFmlbasSRqq1Zzq/WOipxrbGu0tYnjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6969
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable adc0 at imx8dxl_evk boards dts.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index fc9647ea50e9..11b1ff90c06d 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -91,6 +91,13 @@ reg_usdhc2_vmmc: regulator-3 {
 		off-on-delay-us = <3480>;
 	};
 
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	mii_select: regulator-4 {
 		compatible = "regulator-fixed";
 		regulator-name = "mii-select";
@@ -102,6 +109,11 @@ mii_select: regulator-4 {
 	};
 };
 
+&adc0 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
-- 
2.34.1

