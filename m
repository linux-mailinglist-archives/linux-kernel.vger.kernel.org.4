Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBAD625EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiKKPs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiKKPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:48:41 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089C17BE44;
        Fri, 11 Nov 2022 07:48:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmGmsHX1nt5+0pNPUPsxE51ofKiHYVfsSIBFiNSVZrVaEIcRjfIx4T7kjdGbpSDR8zHd/mLBJe5/wjvmNSoRuKfFah2lQNLdp/r2MjbOa0neRcBGvTOG3iEHy9dtZEsRRQw28tka5iRD0sJlIV3IxImISEMpd8mKGmLpryN8cRtNQKjqpCGQe8aK+x6iV3dZt4Hx7Doc38lPc0JdRDXPttWzPHz5eKoGgawSGni+AI3+ittqAkdG4ucawi+7JrJi6/siBj5HCW9cp1nkO0Oy6WguX6TmVTvThg8f8cTM4JnnNJfMX5r4t3KpUuDD1RSyCroabs/JZVoKNDc1V1QYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKMRYg8fbkNQ6/Y9ezmKPCwX/EbHm/PVsVXpPD2+IpE=;
 b=VIosFUpNWpGnTwHJimuzk8MDvc0bayGoEy5AXs1DpBds40gtwsrrXJSfNhrd8DEKqlPnydMau/zWSfUVYuAQt3ovk9lfDl7uJwF/2pWU74yzfqkJZFQYhvpv0lG3/S+GvUpvf6KY4u6FU+PWIiVXaZ+lGZKmemh0fo9IHjJchJmu2s3XBd07mQ/v6AYDAOeEEOZ98PeLrJ24/TkQI+NS2BtHm0VzYKahFTHae+voKZr++qV4J3rLHoZEzlff9hGs6JZTzDl6jdrRKmwfhXmqlFMDQjAMUr3BiTWzRaMySYAN9EO4xyc65N+mm7KiL49LH5vUWuFwSHP5nmB6qJ2Erw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKMRYg8fbkNQ6/Y9ezmKPCwX/EbHm/PVsVXpPD2+IpE=;
 b=EewZwXro/M80UTpAz6XCCoUINGwUOhhOHep16AJoiEOQECVHXaRHq0HvgS42nzp7ZtufeRYbDiGqKN73XB9DeDrABk8XpFmI9sQFrpihBzhC6G5xyXE/iOO8vWqF5vKrGEgq3Hnie2lxYw3sKWApurwlRz//yycMG0YhmmtN1a0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8982.eurprd04.prod.outlook.com (2603:10a6:10:2e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 15:48:33 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5813.013; Fri, 11 Nov
 2022 15:48:33 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org
Cc:     Frank.Li@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, han.xu@nxp.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shenwei.wang@nxp.com
Subject: [PATCH v2 6/6] arm64: dts: imx8dxl_evk: add lpspi0 support
Date:   Fri, 11 Nov 2022 10:47:42 -0500
Message-Id: <20221111154742.2753318-7-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ecb4c9b-0c0b-4224-b130-08dac3fc3009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RiqcAC/s9O/frLirOOF0cZPNrM1qEeleYeZIHp3qxrNxG8XPsmzh0sdJNrgS7wNEi6QqYtGl6wEZMZ8A59UsfrSDv4/KUw1najBwwaSHL2RK6SZGUX0EBruUW3H9YYi/M+FA2cS2bo8h3Ko+hFx8gTcb7/hELMbyHMyN9UC4uttxoXJdaXtIOxre/kPPftArWTsd7EEuXVTxCRrndMmZlaBWDOFsJwEkIm1rCgyGFweq85pM7jJejoN0NWVw/SaBTy5ZGRJ/ivyGi6m9V/CanKHroVkLs+to03STapHDCuzkFzC2tBausrlYsswREMjbi1rH+hFbPTOAKnKwEYjmy016xzGxTPRNaRSKfH1HcNOen96FXeiX9y/JDdYNOZA3CDvIUvDmeejfZm5bv9t89gKipvAOgxLVHospWqBbvkbsDA92CMd2p/QVbsp7QHPMKb3tGXerW8ZP41Vv3m2OUyBkkH1m0qCg/NhjRiEUFnuBRbgUxbqbR3+psXAqQT7AJTcm3bkKDZx2J2s9WtwpWUIDeAR5/m2FZ6p/12w/ytIHTuwtv+CJ2gpH2/xXKu3qDPpYNSBpo42O6EQDC4PHsChUCvbC0+Al5GDaHDWPMtPbqzhaEOa3NaaJBd7FTxbvjj9ktLs6fLgaPM1nnk0SlTwOqbdfVisdhNUwVnU6/P8TcwwehFVte2X1rzEy0CDSqxKXNj3syOUaPxAQstIx5pe1Y5BudRGO1WAvAHxSS3+G4dSgbCDYndCp1Q+uEv3Lfqmh/b4DtXnHfdvyTfjBNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(8936002)(86362001)(7416002)(4744005)(5660300002)(36756003)(316002)(66556008)(66476007)(41300700001)(38350700002)(66946007)(38100700002)(4326008)(8676002)(1076003)(186003)(6916009)(6486002)(478600001)(26005)(2616005)(6506007)(6666004)(6512007)(52116002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aMNTxZyFsbVW5+iudtoqYFZPfqKtLxsL37aOG6GjyB6l8XriXUjgyaRAAPN5?=
 =?us-ascii?Q?yHMV8Ohr2cEgPpWj9Zcw5lFpKHYlLpyWb3PE6Rr5vxCMA9Fc1AoVKV/I8LPo?=
 =?us-ascii?Q?wocTewwcjxtf9ejNK46vJbNzeUAMPIXKLB4aU0chSIs9Bzj446zTWrOwdyiG?=
 =?us-ascii?Q?yB+RLylCn4PpEE77VKFIVVda6XufTVN1k7CvHQO4qZMBBv/5v+8cT/hFLhke?=
 =?us-ascii?Q?nyBcgENUbfKABZTge5g/171KO7pd32b7U31NboStfSi2sAlShFUAnuyaRBT5?=
 =?us-ascii?Q?jLcY1aRPDdJiytlncjghhDV8+7v4wflNNAWeKOUm9O2SD4d/aSUAdjECS9D7?=
 =?us-ascii?Q?R9AGM7eRVR/8FgFSmwl/hMXIxPgL5Ji8uU5s+NvS55ZNL3w9KN1VLqAiy+ys?=
 =?us-ascii?Q?p3NEkuHP6GE79YJUIKJXDipWwoD0gah95pY+BlF1QxWk9QDa6ErzM2NFHJPM?=
 =?us-ascii?Q?/VCRH3bwYazXwRGLXvoJpVKUgoYRpZ5uejDPR69T7gcb7BuRt6k9Sj2vD47R?=
 =?us-ascii?Q?P2y6IEhGuZw+r+/uajTydxFF0hf3FCRhv0UBZcZlzTdZP0pu9C520fe8Snvn?=
 =?us-ascii?Q?6aF6wyV21hIWnZJQaUexIRCvF4e+fTdnPJk8TSYNZSCupF8Vm7TWcPV6z0RU?=
 =?us-ascii?Q?xbOIPWBy0gdhCrVmVgcGzcxXPBePBCMJT+5P3lLSpmKDA5FGCcVvL1Uxg66R?=
 =?us-ascii?Q?hwAglOGVaPVj4J5lPEL6fuJIAPeWsgUgM2yQ50glXjWIAFz601N+j7u1lF5p?=
 =?us-ascii?Q?VWKhNj3sKluKtT74cNt7usvVnUktzNQoYKSq+HY6tn2157aWsNa6ssWE2L3J?=
 =?us-ascii?Q?0+f4rcW5loNMee9xDKmK5Hukpp3VUvb/tqYNlTy43Szyc7hNUC9CgcC7joqk?=
 =?us-ascii?Q?9VhtS9xoM1IeDosIR+53mAAlhKuaK6jveb1tZz6BOCK9fvet8W+twxWUskK+?=
 =?us-ascii?Q?1P6ThTNja5K17NqOx2+LxvEXSk7jOA2x4R7p8W4W2A/8JCZQkKlKjyq6TKyM?=
 =?us-ascii?Q?nmcVQpB12/6gspecngdK5WbTBg+varm/rxIpWBcbTNFfDVbjq/emz2JI2VnY?=
 =?us-ascii?Q?6AWd9bi1QqAICIDRJbxjmunAQwhmfPV3POuaDs17z/c21+CjrxfQJ9lYjTKx?=
 =?us-ascii?Q?jcpBZLoCwBgSCt4kHxSfysL66JyTp//EjRsiFuct8Kbo7JD0M40PCKfi4RsJ?=
 =?us-ascii?Q?vX2yrFQGeIAyy6pEZ618eRzpUyxjKKkMluP9i39iPA1RpPCMu8/LfYsTKvoA?=
 =?us-ascii?Q?m7JnFMsmFKqguF5txVQIqN6Gyf2DXCog2CoCz53O0bIEcG1VgefVMEprc4RE?=
 =?us-ascii?Q?k8ZvHuud0o0U4Umapp5Al/3AWCS6LYXsqd49S21yZqCyhVJs0U8rGnNny+lq?=
 =?us-ascii?Q?P+nBkHjRgf4KS7R14/1wyHPaWbuKTNdG9xCOfqhGh2ogQVY48fFEtL+OD1La?=
 =?us-ascii?Q?AVfYhQYum2QrEoCT2JuciHS8Uz53UE16P0xaus95WPOLSvdEvaZuM2ttEWyz?=
 =?us-ascii?Q?bQG9eAMChWCD3QkqaB8PfxGJoIr/VPxeAz5/LWG7x44sVQcRXqUmbCW4PJRE?=
 =?us-ascii?Q?nibGEAQDN91XQrd7uA8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecb4c9b-0c0b-4224-b130-08dac3fc3009
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 15:48:33.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJFCn4qCvtLercXm/D53fPNKxr+q/+Ob0ilgVemaoZEcDPadtkWZg1ozjvfC84fm2ipThNFyUjV9acr4CaC+/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable lpspi0 at imx8dxl_evk boards dts.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index f8d416f7fd92..280a9c9d8bd9 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -359,6 +359,21 @@ &usdhc2 {
 	status = "okay";
 };
 
+&lpspi3 {
+	fsl,spi-num-chipselects = <1>;
+	fsl,spi-only-use-cs1-sel;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi3>;
+	pinctrl-assert-gpios = <&pca6416_1 7 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	spidev0: spi@0 {
+		reg = <0>;
+		compatible = "rohm,dh2228fv";
+		spi-max-frequency = <30000000>;
+	};
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
2.34.1

