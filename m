Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB672625EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiKKPsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbiKKPs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:48:27 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB59DE8C;
        Fri, 11 Nov 2022 07:48:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxnKXVy+t2Y6lk20GKnwm0PCjBPIZPmAUamRREV+5M5XfNioV38v/SX7IyKvzs92FPas0h0V8sBGAd30YWBhN83ckvOR65ipLOxMy5Z59/rHKTAvvPCd2WbjryvhjqY2gooGhpYgxzXr2vryDvQ7T0/3yJsinFQIM0TkrakV+dsBkl7niLDbqtwgk+Xf02aokOD4yyglfslMLJYZWrxK1rFs52TujNvinXIScKgUiJT1E391TFGTnWoRKyB+pGKSo+LnVdDPSXUX7DrLYHekbb7AJM+SSWw1vVumVnhmUWaLm0v7OdbyqL+OhVoY4s6LVwXjAB5qWhzxodhErsjWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+JRTSNAxpt2dn1ePugp2AoS2W6CPgXA4pvbE3m1huw=;
 b=CsomQkfxQwTaE1t8myynPYlDNqdV/i8gBO8yU0U40F0MhyAQF3LriSmrkJPM47MF7l7QK3Bqfk2IoAGjb+PlaS+PFZy+MJQOk3etnTCZW+7gnlIXyebd695hK12xXGXr9ZtP/GX0TnMcCocLu9kSNyWZ7h/uxsLeOGtuy/YoHpPxZqcN+M5L2jMI2BW9j4hv1kGP20iMkCIUtNfYW/sY49F1lI2Y8A4tc9DayyqIYeNeatzeS70PmJT3EXm0Q99rKGO5DSFvTPhn6DXnPrGX2vI8cjFBFuTs2oRhoGsbO1LvCE/BaN6oOv941cdf/IXMP3wPEuLuPfvNtS/OEsTfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+JRTSNAxpt2dn1ePugp2AoS2W6CPgXA4pvbE3m1huw=;
 b=Bh/a1dEZb75/RCLOa0+dZmeWZpjM/znAdxngCGBvdIc78gp73AVLXvAWfPZFx/wn3t4+tvbBYlaSxGjtDvAbN4ZlxBi7Smb+pV5e1tIju36zbic1MdZ0fvM8Ctv3HKVY0oZmNifxgMYZhphEu957eWX9aIFqZtN6EUEQWFbhUbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8982.eurprd04.prod.outlook.com (2603:10a6:10:2e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 15:48:24 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5813.013; Fri, 11 Nov
 2022 15:48:24 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org
Cc:     Frank.Li@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, han.xu@nxp.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shenwei.wang@nxp.com
Subject: [PATCH v2 4/6] arm64: dts: imx8dxl_evk: add flexspi0 support
Date:   Fri, 11 Nov 2022 10:47:40 -0500
Message-Id: <20221111154742.2753318-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d34f83c-ef89-42ed-0ca9-08dac3fc2a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEmhm4iUr4xiBizetNQ4dVwUpAqLrZueyGqDAUhp/p9MfyEdDjIJxrrAWSKDG4V92XzlhpAGclDBonjn9tfNTOfVRphDyL5XqCXujGLR0eNybKWy4GiQepyLQnnIKuvTIigYVCPXM0mIXfilMnsq8JfuYZiJZ9EmvFAMb8Ql3s+0nF6qAudYMMgNGTGIexZx3AeHzdsL3evyFAqyqfrsGpcC2AJhb6AoA59L56CwnFAjXYvDvYiplodQiaWkm0Mi/wegIMv4NVKjXeZf4u+dwRfEqwYS+fJ+F6w8k5ev6Jahmm54FnVKG0UhfJQ+Ww9CLff6cxppbSh9Q7HZV507g7q0L/BRZO0EW5Mj+n4vExe61pzrRl9eRx6bJ/3JKggkVyrZV92RNBY+cjhwGDxDAiIG10ekA8vSukYvkvoYG2UP7Rn7b5YNk8PzWfG+dgPYdHctFYz+xgir/5iJRW3zHJmFJXOizvbkol4eo/6hwEr2f5ukrggxlxJXNbGQwesv+XVtlJD6vHfUl0iFB6CcSGrcHj6KKz7ZhROCu9eptKgkfKnskE8w9W5RDXcCQPIDNKzMgjRYSf2g12OtXnWSP1rZ39/I6nXYCTMvEdXJ52FxfaR4gXruixQJzi+p1ml5Xn1a4HBSnKndWzwdUwDgEQBeqV6ahw3vjDnXtFnchDGnGw2orqlmDuS0S+4lgN7ffD4Q4JrmVrcv2owGhZenI/myz/qHxblW3SmgkLdDCR9QR8pByOSifo7usgC4bj9ELS2Um8D5y5eE3bGOgXxUxFWmn32O6POpSZtEWROsbXc/4QdcSV97O/Sm5NBHMPlC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(8936002)(86362001)(7416002)(5660300002)(36756003)(316002)(66556008)(66476007)(41300700001)(38350700002)(66946007)(38100700002)(4326008)(8676002)(1076003)(186003)(6916009)(6486002)(478600001)(26005)(2616005)(6506007)(6666004)(6512007)(52116002)(2906002)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UE1R8g6y71xJofi3dYjum2601dr93vIoszak0K7yKIz/I1PuVO0AKJcWWdrw?=
 =?us-ascii?Q?7I62dU0OYK+16nXgSEb4Itet9RQMmaPrHaU1RXIFc6aD9roISjfoScwVdHd0?=
 =?us-ascii?Q?tG9fjATawuaJAuXt+y9B1FT3v9nbCLp1m3fFZvYTMA8d+60cLvAjbuwNhOEF?=
 =?us-ascii?Q?8WSMD8D6067Zz8rKtz3SH3zNhXWKhjdQ9gXGVymAJv5NP5oAbffRiMzul9Eb?=
 =?us-ascii?Q?P4tT1jxKrXkcD18SnsFnLXeZGNjDbcjqm7KLvYKB3RViJZsaTfQCyrZkzruS?=
 =?us-ascii?Q?0KxIh/rfon+bVpzF6/2iB/96aTaPb5kbH/FnZ5g7ckk489M9ynyDeaZhDO6O?=
 =?us-ascii?Q?4PZ6ZDx0pQvTc93QMxexKS6IBzCOV37eTV7DI3kvcyMGQSl+q77aABOwO7P6?=
 =?us-ascii?Q?Dx2wiynKuxixgVQBX3AMX9V1/7ZQKKl5eInytDApWAvycN2/ht0W3IKC2WL3?=
 =?us-ascii?Q?bVeUmfdL9A6gwrmZoAyCVfyWDNtrLEWUOBvu7Ts++Oi1sV0egX11Ewww2ctK?=
 =?us-ascii?Q?XFO+/YaXL2RKAWK50Sn5QhHdYPOhK3LfCfWv0NmKq5oRTP6CyQuuVM1dv5Qc?=
 =?us-ascii?Q?W65b5jrzLs+ByGg8CbaJfUwofkCLxoBCC5Xxwqa3QRE9rYZ05UowueKdazO5?=
 =?us-ascii?Q?vYUEkgI+TUC0wjZxRmg6ictTEYQF0GqFY9Y0NfHU/U8tqMKyvNsWsOp2+Xc+?=
 =?us-ascii?Q?Yl2r4DEGfveQvx40kq7QrPJt04kpjK12kJnsghmFFf5gQtnjUb6gUyPJbV0W?=
 =?us-ascii?Q?+MLDGf3fquqQWCy6aavjEGIxUqMAO7o8UoY0EYXWNriYBiQKfvtfi2LhAMIt?=
 =?us-ascii?Q?9emVHZ7ABUeHAWdysrrFon2O6pAhReBI7GqkX/qLcHmf+jbNTXHd2YSWLzfF?=
 =?us-ascii?Q?D4mN4hYG94Jxvk+7gFwA+4OFhTC81eaC2A1Ue9pCuEuCDmZV/JVG/TpXbPW1?=
 =?us-ascii?Q?G32Hjn9lwIyIWYUm1SKAROxFxL/Si1QOgUFRUz43sWUmF4PhYK2VdOuA4QL2?=
 =?us-ascii?Q?Bx/hjAV1Hxjt3DhNS4FpLROXvrCEDRYSqmGKVa5N77IHNt3by7n1F8BDuzao?=
 =?us-ascii?Q?e6hdZOXN9usSR/spp0LqyH4XTWHbgxJH4Mll8m0df62FATXyQuXt38wtguhg?=
 =?us-ascii?Q?4dQnCFlLdLs2tWi1g8x56edbVLnCNZVC8Qx9xs8KNhy83QJ2Endp9WhoZmYt?=
 =?us-ascii?Q?pwP/A507oT/AhJsemAug/cp2fhxnWemBh3IUcUHNU5QUt0dVw8cIvuZb2RG8?=
 =?us-ascii?Q?q+uzBm5Wk8MNcjL0a9aG46edqsESzoa+pZMC8ww3M1whsMOMwhfGmgdWvG09?=
 =?us-ascii?Q?j/yJPT9/gLKM00lba5cLD2bVXUqdKYpt0MTe17GjZQrw1/iv3fZrpdX7EZFN?=
 =?us-ascii?Q?X6evjDTY/9kx6kCzxLeLh+Y7KXSf1sjmfNwHkOCxHbhfu4G0ezf/MAv2KUqu?=
 =?us-ascii?Q?2I+d0kWwr1QVjWDSNUp3XtL/X8jpEHQaxDCkJ+XlGa2G0cB+ruJZTulisEwY?=
 =?us-ascii?Q?GH4vPTxjvvCGbqpgzZImqVpddce9DaONQHJkau+m5LxkAJJ4++3kUeRXEbhl?=
 =?us-ascii?Q?RZY6K5STkPH+sdQMDqI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d34f83c-ef89-42ed-0ca9-08dac3fc2a97
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 15:48:24.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rB2zU1AU9MpkAfAUrDBfyfjrQZ5I0gVH/5F8qyc6DtJhCcgMcz3YghDKMrW9n3hKfTpqdVjy1mslPwbcmXiQJQ==
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

Enable flexspi0 at imx8dxl_evk boards dts.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 11b1ff90c06d..f8d416f7fd92 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -181,6 +181,23 @@ vddio1: vddio-regulator {
 	};
 };
 
+&flexspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	nxp,fspi-dll-slvdly = <4>;
+	status = "okay";
+
+	mt35xu512aba0: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &i2c2 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -386,6 +403,25 @@ IMX8DXL_ENET1_RGMII_TX_CTL_CONN_EQOS_RGMII_TX_CTL	0x06000020
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			IMX8DXL_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021
+			IMX8DXL_QSPI0A_DATA1_LSIO_QSPI0A_DATA1     0x06000021
+			IMX8DXL_QSPI0A_DATA2_LSIO_QSPI0A_DATA2     0x06000021
+			IMX8DXL_QSPI0A_DATA3_LSIO_QSPI0A_DATA3     0x06000021
+			IMX8DXL_QSPI0A_DQS_LSIO_QSPI0A_DQS         0x06000021
+			IMX8DXL_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B     0x06000021
+			IMX8DXL_QSPI0A_SCLK_LSIO_QSPI0A_SCLK       0x06000021
+			IMX8DXL_QSPI0B_SCLK_LSIO_QSPI0B_SCLK       0x06000021
+			IMX8DXL_QSPI0B_DATA0_LSIO_QSPI0B_DATA0     0x06000021
+			IMX8DXL_QSPI0B_DATA1_LSIO_QSPI0B_DATA1     0x06000021
+			IMX8DXL_QSPI0B_DATA2_LSIO_QSPI0B_DATA2     0x06000021
+			IMX8DXL_QSPI0B_DATA3_LSIO_QSPI0B_DATA3     0x06000021
+			IMX8DXL_QSPI0B_DQS_LSIO_QSPI0B_DQS         0x06000021
+			IMX8DXL_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B     0x06000021
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB0_PAD		0x000014a0
-- 
2.34.1

