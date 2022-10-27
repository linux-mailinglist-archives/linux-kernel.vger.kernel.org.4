Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4200460F897
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiJ0NKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiJ0NJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:09:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6423217588;
        Thu, 27 Oct 2022 06:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOom5DxucTjGnE+Ybo6ILNMsYmKIo3EpSVVRQwThaHe+UFJkUX02safJNC7Otr8Z6DnhoU3gftSpRMBc3eRhu8tbKCjb4VLyd2/LmLea6EUXAIPU+Ie11E+wEj6+h7JlWexzo4ZQK+Mx4hVIGabAr+lMy7ql6218nLfIHiQGLfhkWq+mOln/gvgWPoVW53949r2cX0fFQC5SAbms4W809xi3Fbq7bEFcBFjoLp21cDUUDOv2UUac2YeKbYhWO5eKQV5MIYjNp8anp7kk6qJBzTBQR2Sqj3LNWP1K1TM2S4h47fWzukeftf8g2N6WG1ch8KfNlTshcjPnwsV7YefHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ccpkmu4RpDemxBVUE3oS9vV8awijWMsffBawrv3GSqA=;
 b=LsEL1sUVP778hyda1vuX/vOUfS6fuBOUPOjgs5E2W2E6XX1x0NsOACEO1CNLpFhdeOmzH92+Lm3TFlvAQGu1lW0qr+SuxS4x4Nzu0ReKG6L6NmerBslBZeEin9srJkkSDnYBPXAC/rv5aAVmbYM9Oevr9yMoWXgAVritcX5mL7RwgkiTlbl0AZJ0WO739trenOGdw5Hw//LU6A4tOPjHs7gTTIFWhGezixYxyWQtJGPyugaKyLh9elAN/Eg8c9ejHMZ/yfnfrFo69HdlEwhfVIKOqg14/yubduyA3/uJ+I9IrsrR4CJLnv1zFMQsPVEKZC32kdl0xg8azi2RhZIndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ccpkmu4RpDemxBVUE3oS9vV8awijWMsffBawrv3GSqA=;
 b=ZykI1cWM8JfvCiXv89F0z4G4Xk5RkgS+YAGJxym814lROYadvHIFn/YBtn4Q3axXlDNcHOdSdmpuF0XYuaVC6O3K9xGcsBrczUwddo7gu2BOwguv6E8sSxo3KV5mkGeQVH7ucAmN8vQ8AFWLyoDi8fLapa+GaUwL31+ROm38p0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 13:09:53 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8%3]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 13:09:53 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH v4 2/5] arm64: dts: imx8qm-ss-lsio: add gpio-ranges property
Date:   Thu, 27 Oct 2022 08:08:56 -0500
Message-Id: <20221027130859.1444412-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027130859.1444412-1-shenwei.wang@nxp.com>
References: <20221027130859.1444412-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM7PR04MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: eec32179-2d6a-420c-7fb6-08dab81c89ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBqlKgzkpXQLV489b2p2WwDvzOMs1XmNrcpmr1IuSK9yY0tTLU6zebH6UNPT8GOVWXZ4ov2xFfefVrshxSGeeQZj/BS2sWFwul+P4xEGiXrOjpuPSIWoSuH4Aqc1nPmcatw5lZXI/3CeA6i+cFUQ74xXIavFVtbrk6J6FpciJGP4x4F5wUpftjzlbuReFKPn7L2hFImaFodkf5EHUU2P57SOgfCTIFOMhr60/2hj871y83wo0EgW0EADNHz2LmiUApYAEpq/n/dZU1/nHXDtsvqarhigH0BPs3UxVemGq9lR8qQI82pwXDstkP/tcK2RYLmIj1Go/hfqRaMkAx9aiaqJaK6XCKD8lWjBm7zmUazc+Kg5FvGxnHGG+q+z+E50nkUQXZ8DquDtaxlTsmLg5JdXJADH7dRz5DCHN5wxkDl4mwIq9DDSHpyo6ImdujrFT0G+wN8GNpe8uzExerjOoFlt2Rn8NOGMM2imyBgh9EM3zkU7wPo8g2LQcUrkqfsJEQsQzdsS+aQT/EIO58WbWHhnBkSPoUSdwvxytHFTziiySlyOACD3aJXtkfhYrmNMrcHMBXcWt6sBpknlONVzyiij2Hq+2XuhaVWt864hwH1COOPVFDPrWbMWdIySvYkOyYcsxwEu7c0iZC3BoOZB4rb/rUpeMe9vimVxuR/wO/GPyUCYSb2/TTV3taoCJ2Ps7BBKe8OZTMZeSgxIGtHzcsMmu5Vz5I1O+HNU0WaZ5AMDcE9W9e45WlxMK+XJwFbceBSKfgxsLH5VEPyrSuLOzsr2e/TWiZZTe6X2xABt1B4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(55236004)(1076003)(6512007)(26005)(52116002)(6506007)(478600001)(186003)(2616005)(44832011)(2906002)(6636002)(5660300002)(54906003)(8676002)(110136005)(6486002)(316002)(41300700001)(66556008)(7416002)(66946007)(66476007)(4326008)(8936002)(36756003)(86362001)(38350700002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x77nBL0TJML+eKW23+E/F9xQ7pbHLaa2axe5k/6qbi/v7DE4iBAm2LB/6oY8?=
 =?us-ascii?Q?qCyJOQPKpkos4qzWSNXl34IcuJftkw8qGWs8k46AsK798bCkLSO5QLtU8Hzc?=
 =?us-ascii?Q?Y9+hXKugRB/qeechpWNayb6VA9FGrosLfmP20fBZXFbyq8tt9zZw4m2wsyRD?=
 =?us-ascii?Q?hhX/ptRClm7RFd5B43CyIoSKbPyFyeddZsldC/N4UVt56i1mxAF6ULHCPHa2?=
 =?us-ascii?Q?YAfdj1G+ffXacQoKmhJB/VRJ7kWugnyR+Iqdkxf7jCGdVBsrkKgYXuyqeFbM?=
 =?us-ascii?Q?UYEHC+JBMQjF74/bxn+Cx5c+9p0ijJMmvEENnTAitPBaM8i2DzDTNTUJCvfA?=
 =?us-ascii?Q?x8sXbsydrMkm4baUzKXOnDjvAzg4c8eQcdr8EoYWaDWE1V90aBCWEG8O23fu?=
 =?us-ascii?Q?l+ahIHPK+45ItyRAF7mzMQP0B/US8Zp53qsCDfyXiNqZtAk3ERo9lp9QEKdp?=
 =?us-ascii?Q?g9A8y6VPEKYoH4WgnOqj8rO/TuyMX+asgJbR+22lf87ZpyYE5Jgh9RUJZuUt?=
 =?us-ascii?Q?dZjf5CbRBfaqLdt2oZxt9eOz0gNWKlzk1wNJqv4zWJloTBwuLacoDBEKKxB1?=
 =?us-ascii?Q?QFFMYqss8TiM8C9Yu0ThLplwF4nNbuoVMnrlZCTf+tD0u4ctZC+pYfj3R/BE?=
 =?us-ascii?Q?O3MDhSyujCxPIGaoM7Zp+7kqGjGpNFGm4EvDtRcZ+LKjQICb6IOIhkLIQw+Q?=
 =?us-ascii?Q?YDpcDBQn51+oaHYiz0poQnKBHUiLEbsbOtDicwDpxWv33psiKcSeMsxtTroT?=
 =?us-ascii?Q?QQef5hACAiItm8TinLdq51rRmfjFwCvk3U/06tSo8y2VZLN8vUZNgvzS0Oqu?=
 =?us-ascii?Q?SuUpPb9aPHHlhjgV3AbMRWQplnoWGFId9CUnrzKEIjassuti0o8BYn4+cgKy?=
 =?us-ascii?Q?Koat9BpSMFvtBYkwRjJ69AtIe6vb0uyuAb0nuEEdBi8Zfs78l78xQxLuSQTp?=
 =?us-ascii?Q?J7UMU11kNErl4J3YF9R8V3SyS+scnkBqDHqo4A+EYd3maZxrW1TdchDreEp1?=
 =?us-ascii?Q?y+Fb8/HMtJlNrPO0ZJCKGp4OIZxLrvZJK3oY6BoikbB+K3EDda9M93cI3YBh?=
 =?us-ascii?Q?H1mBXF6MF0OMwmN7RRzGgEyYvdBqTbHc7m1yIhMmGA9rFdgcNwYTxKv1IrEU?=
 =?us-ascii?Q?xw0+B1sXYLx+RyyPPBN+REr27ZkQciq51UGNvWIT9NRK4tMkAjNOGkDL2Icq?=
 =?us-ascii?Q?xPV2KkuOYt9tjjbR5OOly9/6lWf5oa8lNBAQnmgfRb1sT9/vml/EPs/YiqXR?=
 =?us-ascii?Q?nawoo+5WNpHnatzYDvkDzN4svM/pSzqi+rVVad8metVAJKaiu7m4bDKhyWRt?=
 =?us-ascii?Q?bSguMTfYSBQm86mm9s8Zc/TaOWu7XC3rdmg+ctL5AuoAh0z3C9KwNJW6m689?=
 =?us-ascii?Q?ov2BJKZh5cE/05m1eT22stS23SrnpmoVo2SUa+7u59rOOrDC0t34etdpIOWh?=
 =?us-ascii?Q?4UnWYb/Y0T6kYkMyaeVqKq/a04u2QliVHumhMQ0hpehkerGnOQ1eRPmcVF53?=
 =?us-ascii?Q?OGuEdg/59VhpNd58bRWcXfB8Xxxyf+TjCvBUcG0XAvopB1H2mHJ7CHjgPtUM?=
 =?us-ascii?Q?4G2cmh/5dIZOouOffrW/O8AmqhNInGdGdPd6Eu1PJ5/CDN/+sYwyu4D/zNIh?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec32179-2d6a-420c-7fb6-08dab81c89ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:09:53.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XE5gMPe8gAE/YYkDVbIZ7TR2OrqN1K31HypTGEBx+ZFXuISO7rl76n+B6KmQWekU930ceXhqDjb5XI1piOIxVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6807
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add gpio-ranges property for imx8qm soc.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 .../boot/dts/freescale/imx8qm-ss-lsio.dtsi    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
index 669aa14ce9f7..b483134f84d1 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
@@ -6,30 +6,68 @@
 
 &lsio_gpio0 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 0 6>,
+		      <&iomuxc 6 7 22>,
+		      <&iomuxc 28 36 4>;
 };
 
 &lsio_gpio1 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 40 4>,
+		      <&iomuxc 4 50 12>,
+		      <&iomuxc 16 63 8>,
+		      <&iomuxc 24 72 8>;
 };
 
 &lsio_gpio2 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 80 4>,
+		      <&iomuxc 4 85 18>,
+		      <&iomuxc 22 104 10>;
 };
 
 &lsio_gpio3 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 114 2>,
+		      <&iomuxc 2 117 16>,
+		      <&iomuxc 18 141 1>,
+		      <&iomuxc 19 140 1>,
+		      <&iomuxc 20 139 1>,
+		      <&iomuxc 21 138 1>,
+		      <&iomuxc 22 137 1>,
+		      <&iomuxc 23 136 1>,
+		      <&iomuxc 24 135 1>,
+		      <&iomuxc 25 134 1>,
+		      <&iomuxc 26 142 3>,
+		      <&iomuxc 29 146 3>;
 };
 
 &lsio_gpio4 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 149 3>,
+		      <&iomuxc 3 153 4>,
+		      <&iomuxc 7 158 6>,
+		      <&iomuxc 13 165 6>,
+		      <&iomuxc 19 172 8>,
+		      <&iomuxc 27 198 5>;
 };
 
 &lsio_gpio5 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 203 1>,
+		      <&iomuxc 1 205 2>,
+		      <&iomuxc 3 210 11>,
+		      <&iomuxc 14 223 3>,
+		      <&iomuxc 17 227 2>,
+		      <&iomuxc 19 230 5>,
+		      <&iomuxc 24 236 6>,
+		      <&iomuxc 30 243 2>;
 };
 
 &lsio_gpio6 {
 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 245 10>,
+		      <&iomuxc 10 256 12>;
 };
 
 &lsio_gpio7 {
-- 
2.34.1

