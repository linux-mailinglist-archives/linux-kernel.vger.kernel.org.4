Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30660DC42
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiJZHkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiJZHkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:40:04 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A01742B;
        Wed, 26 Oct 2022 00:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ju+d67KFUIAQaGvzlEMJZ9LGk3hCk7y25TaxkhLAAwmENRTLdXDhGJgukvctFSqt/quWipaZrZCIzkM1g5cXdRmpZd0OuzJYbVIRNS13L5tuGzeHIS/uc4rhfXBEXAOJtz4LA/+7/GPRNf00CiBskqHwPitDezNnrpoZH3uBByYut+a4W1lcT/S/ZgsL0wPCaLwPR+RitN+hapG5wfTFbQ5S4PqA4sJRWDeL4OPrGo28N9Jkz88z1+0jUOHPekfyJwScDyFVR2LxKrHT4fOGJb5qFGLo4MQ6F/+LIYXK56maaKXCRUybRF9KWZl/crUoe9jSK/L3uxDbKraENrbadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2rO2F6YrHuAAyc52/u32+YTxD5r54pFuOCpA9emG/U=;
 b=bq4oyQ5RvdoxKK6MPMylEyEHp3ofpxkvZKkxJY7KGk15Lj8xA9I2LRtrIEWaqwKiSv6RZT/S9xMqpgGTKbBorhxHLmwRGuN0MaFAmQG+b3k2eSL8rMyWxUc8afewwZo/BI+Q1Vg9I1Jtg5h0bDpxc24bPXRXUx+w9Rsm7zaTTNdT0MZC6XWc6lXdtsFPNCYVs21V0vvtXq3HaHG4sHuV3dg34YF/jcD5wSsdmjTHUHH1iVjUzAhYWqBOk0lu7jy2Qp84TWBa9jeUZnVP+uGu75bgVF8UnytU9pEjg+P2NysFjVFjo8I5rO25SZLYjDk3RYolLYV63OSGkGH3dba/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2rO2F6YrHuAAyc52/u32+YTxD5r54pFuOCpA9emG/U=;
 b=RkNWTFWDFDNoeaY8Cc2knh2UC3CjE23YAB+SeClgLeWU7vyVST2xLdGj3TuY1SMbkhfRW5KtB9QgHx3qHC7Dmlb0lHFhtGLfD5cegpZJJ78NOINaPDNEvkwlRgFbWPC3AP3ShFda537d06XwPO/gArq32J7K4waoiX7zLw/1X18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 07:40:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 07:39:59 +0000
Date:   Wed, 26 Oct 2022 16:26:08 +0800
From:   Peng Fan <peng.fan@nxp.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 2/5] arm64: dts: imx8qm-ss-lsio: add gpio-ranges
 property
Message-ID: <20221026082608.GD18160@linux-1xn6>
References: <20221025183244.615318-1-shenwei.wang@nxp.com>
 <20221025183244.615318-3-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025183244.615318-3-shenwei.wang@nxp.com>
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c97c01a-d680-4dad-acd6-08dab7254932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xOVCVL+BnkMgvQBrjdjTVpyDZVY7GsvQsYuvvDysPe9/VVmbJo8+lIPUFr11JbG1pdUOPMUn23T3Z14kuyuJIfcWpokAWFpv7wzi51DQPbalI/zuvB1chHN+jUZ9kqctkH/Em0H3of1gI98rTd5/AmBEpEYylaMzTRsLza+gNE+q7MxI7Ggtco8KeYi5tsYd9cHVvPZZ5Tl2U4OAAzMUwh9PUEfoHux0esSHuFPDla3ejbEDwhyv0zKBXcSCzFOvK6Pi4b1W991IVa1d2C4yBH89Ws7txmEfl+21SS0q+4QuOwWO7bFeHefecUkbm5ZlSaNXWqiB353Y0TJJE2LvFyA/eMMyCzW5ckBb3gmiySC4875J3QSOQ0aiRW5Jb49hQXzg8t+eMmbMI2UIeNk4GasqFpyzNLQQMBNrFJdiEGiuD64WYdQb8gmnHEuG7KeS3hpXd5HoV2AKRdivo0Foy8Cq3RvhLW7Q4RtRCQIOYF6C6/eSlnq2w+z83t1qhxUV/5JIZGSA7ZGbpo/V/HgRCFuWzlF62ZzE/JIwsVUC0iRe4wvMRpK1mE/gUA6VlvBp4VR3WiXlpgFWmMcJ8ewwH7voKrm2d8PAN/XshYM6UcXsdPvmz3fXLFzrR3UExNaP01YsKYIDt4yfM9I3hL9PW41C/fO4zbOX3rDXqL2bEt1YXn4ONyI8sPH8GAzDpEM0vAGwLr5KHB6QFzyvjNAb0+utVjtTbhUVy6tb55mm0jgKKI9jhqtze+QxhmovpxDrG0XU2zVfH447FZ0DWAejpy9LJJJB98xgiOW1kdEvtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(478600001)(86362001)(6486002)(9686003)(26005)(41300700001)(8936002)(6636002)(54906003)(6862004)(7416002)(66476007)(52116002)(6506007)(6666004)(4326008)(8676002)(66556008)(66946007)(44832011)(1076003)(186003)(2906002)(33656002)(5660300002)(316002)(38100700002)(6512007)(33716001)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fdvaI+EGpEha6CNc5xSNi0NSp/uiPD8hCrtjhdsSZrP4Ft+Is1S1e73ZBSHf?=
 =?us-ascii?Q?iZ7VYrszbBybgQJxAgOK9bU2tFFXQbqfiB9TgFa4+9tb3JhKXF5e40GWAG+y?=
 =?us-ascii?Q?VS98BJ6lKAhVnaTjJFeS4Db+EfbrT9cvc9bM1D9N8TE1BtNYPMJXrThy16XY?=
 =?us-ascii?Q?+zb5KZ/msq/2HlMYzZKu8fwnM7LjXrmLsXSExhUvh+xCtsAwlJ1mgXo9fPfb?=
 =?us-ascii?Q?SNontXZFg8m6WjJS9idENqOZWNGpgDQ9zyVumFuLDOcqF2WTTnnUAbsnCYCl?=
 =?us-ascii?Q?oXCQ+ZLAUYhPAL2GnwbNQXTXVxy7F2cA15TEwePJjtFcEH6lVhWeRx6T727M?=
 =?us-ascii?Q?b07VJGaFlsLr4u4GzqPL4U6XBPrmMDeEHGSi8DiKhibKcMm7ukOnEqx/GhKe?=
 =?us-ascii?Q?Ze7kGPMxLhSiCpc7ycfzpB0SIaGBpTouS/cLEZ1u/fC9vK1ndrks3Mei0SBW?=
 =?us-ascii?Q?gArFxeA0mmGurqjbfd8RmENW9CSGfm/fdPD0jaWecrcaEb/evo7mComzqFeH?=
 =?us-ascii?Q?4q4oM0ndj4qwm1BrBexXmKpjZstBQYRKWTVCcITeadjngA3PA6zricDXM/JA?=
 =?us-ascii?Q?j4uE9d25UgJuDFBlrheYvAx3SfxQzkAp7MZbjbiVC/TBygE4bwxBZ0VNNDyB?=
 =?us-ascii?Q?UQEY5iU5m1mh2BTOzsWem/L2AoZraUB6akmw34FLjSJ/Lnnjpv1VEBHX91/6?=
 =?us-ascii?Q?3zCPGwfwiCIQ2FosRXkC1gqk5xz6tjCkjn/9lzC4BQJrDTiVyBh1jXq0kXTx?=
 =?us-ascii?Q?GB7kompM/aVY6wzK+ldE1owkHGoulB1FVXcXQvrgWivKdoaSU+C/t1i4Kg7v?=
 =?us-ascii?Q?RqQVHf8ogf90yWzJ8hZ6rULmZsV0KSZuzeymOfQ0JF2PcbaIorI+L5zh1UKD?=
 =?us-ascii?Q?g39B3whn7aJfgxiHR89dzPwoJ2cNKcNmR0TCVHV09UU2iO40e2I5WIdR2Df/?=
 =?us-ascii?Q?AzrviftUku3Lb6Zc3OvFoTXHlL3kjmdkNG0i6tQRy0HGC6DTj4zwhOxZRv1z?=
 =?us-ascii?Q?D+EZeBc1580q/BlGZzNDSDUhIKu9+F40cHjmhwHeWTxN6jekkouKgfQC9MKo?=
 =?us-ascii?Q?zjQwsKSmp2nwaewxbVoBbISSmXuu+9iCRkbma31vMIV+FBfTftDekrWOzD96?=
 =?us-ascii?Q?onfvQQRzQlzxz/PP2w7d5ndu9TjK/6k3vq/YXfQjij/as5kZl2fuh3eZJftG?=
 =?us-ascii?Q?U44gIBnRwzOCf0K13Qqa8n8/nigWdKiym2ImxMO8P2/kqW7aeqwgPdItETmD?=
 =?us-ascii?Q?loMUQ4iPqA8gGZH3jPkd3n003XnRDoJxpAR7og5YJRxGidCcc+mHjk3w0IU/?=
 =?us-ascii?Q?cmoRoIHt9Q7TlFcKa42els0/VABKNOyTUiJ5+aabT9dYbssFRxypX42wmy0b?=
 =?us-ascii?Q?l55nSi/6aiugjsJW3r5AcZbjsmzxKak8x4q1kGr4lf3glgIm4cqazofeVqQk?=
 =?us-ascii?Q?XcqZZIgVfLwIHBqaq+16eaApYhGZv+oA+fOXUmoU1faB64p8yPJnCpOI7aJ+?=
 =?us-ascii?Q?Jlt4F7k/as/im1ESJYHIEHfwPxdJ1DL2fHYhGyiSDCPkmcSPOV5HoifoVcYm?=
 =?us-ascii?Q?MVSMrH77aWr8h+Mv+a1zzhxMPSuWig1tSqiTCFzF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c97c01a-d680-4dad-acd6-08dab7254932
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 07:39:59.7256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orMsx+W4jfL9AbNlS7eUikV8hN+Azmxo+4QVTeyGQtfhEu4khHPv8BMhxg4Mrm5o/LCpuwXGrgVMSoyMEaw9IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 01:32:41PM -0500, Shenwei Wang wrote:
>add gpio-ranges property for imx8qm soc.
>
>Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
>---
> .../boot/dts/freescale/imx8qm-ss-lsio.dtsi    | 38 +++++++++++++++++++
> 1 file changed, 38 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
>index 669aa14ce9f7..b483134f84d1 100644
>--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
>+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
>@@ -6,30 +6,68 @@
> 
> &lsio_gpio0 {
> 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 0 6>,
>+		      <&iomuxc 6 7 22>,
>+		      <&iomuxc 28 36 4>;
> };
> 
> &lsio_gpio1 {
> 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 40 4>,
>+		      <&iomuxc 4 50 12>,
>+		      <&iomuxc 16 63 8>,
>+		      <&iomuxc 24 72 8>;
> };
> 
> &lsio_gpio2 {
> 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 80 4>,
>+		      <&iomuxc 4 85 18>,
>+		      <&iomuxc 22 104 10>;
> };
> 
> &lsio_gpio3 {
> 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 114 2>,
>+		      <&iomuxc 2 117 16>,
>+		      <&iomuxc 18 141 1>,
>+		      <&iomuxc 19 140 1>,
>+		      <&iomuxc 20 139 1>,
>+		      <&iomuxc 21 138 1>,
>+		      <&iomuxc 22 137 1>,
>+		      <&iomuxc 23 136 1>,
>+		      <&iomuxc 24 135 1>,
>+		      <&iomuxc 25 134 1>,
>+		      <&iomuxc 26 142 3>,
>+		      <&iomuxc 29 146 3>;
> };
> 
> &lsio_gpio4 {
> 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 149 3>,
>+		      <&iomuxc 3 153 4>,
>+		      <&iomuxc 7 158 6>,
>+		      <&iomuxc 13 165 6>,
>+		      <&iomuxc 19 172 8>,
>+		      <&iomuxc 27 198 5>;
> };
> 
> &lsio_gpio5 {
> 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 203 1>,
>+		      <&iomuxc 1 205 2>,
>+		      <&iomuxc 3 210 11>,
>+		      <&iomuxc 14 223 3>,
>+		      <&iomuxc 17 227 2>,
>+		      <&iomuxc 19 230 5>,
>+		      <&iomuxc 24 236 6>,
>+		      <&iomuxc 30 243 2>;
> };
> 
> &lsio_gpio6 {
> 	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 245 10>,
>+		      <&iomuxc 10 256 12>;
> };
> 
> &lsio_gpio7 {

Reviewed-by: Peng Fan <peng.fan@nxp.com>

>-- 
>2.34.1
>

-- 
