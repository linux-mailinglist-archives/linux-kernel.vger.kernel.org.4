Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B191460DC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiJZHjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJZHjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:39:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2D87086;
        Wed, 26 Oct 2022 00:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmAUK5lbmaj2akqQwooyHwHt2/F5JkbLzZ0Txy0XOlzp7ZzGXdrw/9SR3qf/HKiAXTYLq/tLql2MuEU25RJx793xNIJnFpGB7eRanm+DmEwNTggQ0jiR+jTVAia3YCZ3zYoyFb+K6HMBPmyxBCx4UzoFYCO4N3l+yzfL34ep7u21ZLoF2sEQsP0ZpXzCL/ztkupQZNw3N0kCHQL9GaX5pB28kukb3gTBNIEY3B7RSC9C3suWjfyoALWrjlhndicIjvuAUiiD3Cy+58YX4pgzfSLV7A5ywHLPq/TTrAE9+Ve46CqyzcOpQ3vipEYdt7+jLRAGNkzx+72Ixa9Rr2urqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Z1MZz6BiMxe/pWUF5OteeuNk97BurDfH1wh9uUIHpE=;
 b=i8E79cG5EvEfEwxQxNc9uv2aRk1SitZMTqQVwKdxmSRcFyHzOlIKrB1lxEBcGal+KsKCzhhfIRZkC5oeHcQIEOKJjlzO7KDK25or0Wxz0W0nkhkJHtpfmInUJz6W95O2eaygz5DIErOTaEj2129w/kGmWqVl9oKvLt01imwVfQRomWQ3YwVazTIQqzrqfZzJqlFQ4cW2GDTkAdCNTiXRh46C71rwbTbE+oAOCzT3dqpzXnPNnXyhlepsDV/sAiLX9J/3IbiJM67a+00XpYvDBuSpP1yjGbv4hChgQgXPFIoiK6VaHtAJdLtcO+1EkWdFnaN3mOji4Gz2Lp56Q6LT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z1MZz6BiMxe/pWUF5OteeuNk97BurDfH1wh9uUIHpE=;
 b=Mz0obt3MNlPT5ODNc77V8oL3UW1iabMHEoQMRuybj2x5p1/wjVrrvaDZG7FbLVaa2iu4jmi3EI/LMKTmRXvyQ3UgnJZ4k59N0Ov5kH4XkMBmJRcyacCaxgoMUuPWP087Yws7eTsY7bdrZK2iWfTMMRkv4Dmk5/dINuIlDXogS08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7815.eurprd04.prod.outlook.com (2603:10a6:20b:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 07:39:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 07:39:16 +0000
Date:   Wed, 26 Oct 2022 16:25:30 +0800
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
Subject: Re: [PATCH v3 1/5] arm64: dts: imx8dxl-ss-lsio: add gpio-ranges
 property
Message-ID: <20221026082530.GC18160@linux-1xn6>
References: <20221025183244.615318-1-shenwei.wang@nxp.com>
 <20221025183244.615318-2-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025183244.615318-2-shenwei.wang@nxp.com>
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3d195c-b25a-405c-4fe9-08dab7252f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Njq7hEHKz3mRnp9J9+udSNpAdrltMgcBdPluGuuoiKJ+Y5gnfac9en2OupYNSmoqFaRYPmokZBOhWy2NSXtdZep3PBIjSq9NsP9FTx3sQljhcciP29XeEwoZj0V5ErgLzP8m/ZdI2LkcuJj7EsU+qoFPnGpsrr1J2SXUIeDg5GsFjP52n5pxfbOBro6zimKS4EEN/cYok4K4/umCrfoM0oRcBfFAR4IJJo/PNIy0RMRfzlrTglou8s93JjhLSu1rswQmsvK016AUsz0YSshEjCJOfpS4O/egHnS221jQ+ErezhIYRCDwy1k2CVY7o+7K0F0ClqkDkcsCrRaa7UYyh46j3JUI3pni2GTKVmhvwQlPWhtBwJjDilI6kTCWWNvyQkMZq4NBRzDqXuvdQC63EewKHfDmvbgxV1ms0prGz/o8k7BqQVEzZ7l4wFuD6XpEaspnNHMrkYEkbElk1pOfjaz4HB6BSuSAvLINFb5gbAbk1yeJQncx88OyO+l3FZCUApkXe9TU9nJ1t+rYepZEb9PNJt+IDy1uKbr4GLaINnehAJidLM5yHVZA1FoC6XSNBJKxo999xiaKKiiG4B++FG1GUAXkvxYQHmJSiYvX0SITMNwWD1cUF7d1bJll2HR9DPV5uUS2jKkGeKGVIxy1+QdiTNCV7IdyUWShtL4iNWz11D3ZazHzI1mP3PSkwxcEXmG30VgXFaUj/ndtvrdWEyxURIWA7PZ5HHwTOl2Z8B4K4ZNtkOGyRmg+tT82yVwH7Vu3j4VkWdIKx2skDFXv4D3I+lTm2qOpe9yBokzjPfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(26005)(6506007)(52116002)(6666004)(9686003)(6512007)(478600001)(186003)(1076003)(44832011)(2906002)(316002)(66556008)(33716001)(8676002)(66476007)(6486002)(6636002)(54906003)(6862004)(8936002)(7416002)(4326008)(66946007)(5660300002)(41300700001)(33656002)(86362001)(38100700002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WJU5TAPtk7CeyM5R0ILdj9vMut+bjFXdj1qhaDloYUc2zyzMPWnWfx8CqsMS?=
 =?us-ascii?Q?XdXvFLQWraa/sYC37XxBdXumhwNTfTNsI4WMWCdr3/PxhkRAmqC898k375rZ?=
 =?us-ascii?Q?Pk7hKYwnrER3Lc1rI3LL0tC9ZvgcV5Dn1UP8UbGWp0yfoOLWUJt0qnzHoiEy?=
 =?us-ascii?Q?zt/7wKr3j8tolaloO7yWyA9sKw4ecB3HkFgBMfYlrFgWqBSrPWrviX2Tb9Jq?=
 =?us-ascii?Q?Hhhl/3kE4V9KAX2QbV8ivl6Y4iyBw8kJJO6kctPuSRikoc93Ngf6C+5nY4Bf?=
 =?us-ascii?Q?wEpJRvdmKtAj0InttdetYcMjEKz5j/rvIE5Sr+4fZeAx375CK7f3TWbeAw3m?=
 =?us-ascii?Q?w7y9As6jTNdeT+HulVzasYtRElk/xQw1LGYsVKqlsCff1zdLFNWxcXbC73/O?=
 =?us-ascii?Q?s6d7ecmsFE++iOtbSLUHk9Q27RoJS0/Jc6bmTxDa4DDcXRZFChkVryVCgMnQ?=
 =?us-ascii?Q?hLwPfAtapDOPc0ciJUvmjavHEaOMjkw+HM2osR9o0UMBdRO4rYeI80ZNk/Dq?=
 =?us-ascii?Q?rFoiRtNv0yc8qEyr3gHjfAOayrY8Xzxuk2ePPArTX1lSbJ5mxoEq3MX2KjWR?=
 =?us-ascii?Q?7t1o4Ws3D2Y0x3pixHX1NiPgkOy8Kzu+Lt58JWNIlTpnAPDZ9nzwmfuh1hwt?=
 =?us-ascii?Q?ozXy/oVW2DPjxxc7O0LfYFwyrl7lY4k1Fxz3at5igYd7/SdLma5CR0pQfQdz?=
 =?us-ascii?Q?fFygmNw/34IP80Zgi8vBOIRHC5o7Sd+8/Qkc1yt4C4QcKbS3gvcrCXnIeH17?=
 =?us-ascii?Q?a43BiCnwdJmSqd6I40z8khv537/0DMHQbZ9VqnYOngJVx5zwfXr07Lz1NSZ+?=
 =?us-ascii?Q?sk+fYXaVP7d3RDuyA9ouSruXrUwkoUN+PvaROq8Y4UoYZBCfl4dQeZKj3Aji?=
 =?us-ascii?Q?d26vQovSZv64t1CyW18toVtZXnYOKRk4qgkVE1hj57RjgmrP5p8ZZRXy9cbi?=
 =?us-ascii?Q?4WBJY5e0gd+evorm4DeF57YhdpijDzHAYfVjKXnLvCx3lM75O5xYKeHU6zbM?=
 =?us-ascii?Q?kH4+RrftnnPiJF7mTj3RkS+9glPaYuC2O0VSI0gGEDW/8KcyofqP1T1yngBN?=
 =?us-ascii?Q?ofv2Jeh/OFIUH73impzbcrSvjCMtQz0aPt/tFE+ZeKZ7i/ULqhY2dEgeR3r5?=
 =?us-ascii?Q?of4rL8EpHX92P9wKLSmMy30di3PnaalX0/Ah49x+FhVHHSUoB6TuQlyQSXNs?=
 =?us-ascii?Q?Hz+cbL1b6g6MRw+N+0xxUpOUaoeHUqTGNg9HoMFqbPQkg+KzImrMIH2O88UD?=
 =?us-ascii?Q?8kGEu37w0LcFCGDm2NFmMnUZffGtCLDCBaj8oCedC156/lXNW2PaI4vX6DTV?=
 =?us-ascii?Q?UF9RVx9F8gWm9NqdZfmiPyyHee7df98gLdguay1BPxWznaUUFImZVylXWCOI?=
 =?us-ascii?Q?FSNP8bK+93TjcYG1ys6MiXfKOvth6TZ/h8VrrvAcUzLi6KlSB+/Yckuqzsm/?=
 =?us-ascii?Q?E9j+N+4RUaoKoO2MPY0utmxKDJ3nTkkuPzMBPOSbNjeFK4JwlKByPyOOUgl5?=
 =?us-ascii?Q?PYHWE6BpcmP9yj3qjr/dvSPacyVJmet2ES3JGFnbALo7qU4FVLYMjOjJ/es4?=
 =?us-ascii?Q?+yXNYGn8DO4jkjcM39D2iRBhVPO/pYpyaxkD9ju9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3d195c-b25a-405c-4fe9-08dab7252f2c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 07:39:16.0702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: St/uRsWV5XHwCiOZhXZUjpobfbn2Ml9pvm+W+QCJnbGqvQhH0S4qToCrGBdgsTQHvSnCTnaDK5qkJbLE2nivwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 01:32:40PM -0500, Shenwei Wang wrote:
>add gpio-ranges property for imx8dxl soc.
>
>Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
>---
> .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   | 41 +++++++++++++++++++
> 1 file changed, 41 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
>index 815bd987b09b..5306d2b3fc3f 100644
>--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
>+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
>@@ -6,41 +6,82 @@
> &lsio_gpio0 {
> 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> 	interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
>+	gpio-ranges = <&iomuxc 0 47 13>,
>+		      <&iomuxc 13 61 4>,
>+		      <&iomuxc 19 67 4>,
>+		      <&iomuxc 24 72 1>;
> };
> 
> &lsio_gpio1 {
> 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> 	interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
>+	gpio-ranges = <&iomuxc 4 74 5>,
>+		      <&iomuxc 9 80 16>;
> };
> 
> &lsio_gpio2 {
> 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> 	interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>+	gpio-ranges = <&iomuxc 1 98 2>,
>+		      <&iomuxc 3 101 1>,
>+		      <&iomuxc 5 107 8>;
> };
> 
> &lsio_gpio3 {
> 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> 	interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
>+	gpio-ranges = <&iomuxc 0 115 4>,
>+		      <&iomuxc 9 121 1>,
>+		      <&iomuxc 10 120 1>,
>+		      <&iomuxc 11 123 1>,
>+		      <&iomuxc 12 122 1>,
>+		      <&iomuxc 13 125 1>,
>+		      <&iomuxc 14 124 1>,
>+		      <&iomuxc 16 126 1>,
>+		      <&iomuxc 17 128 1>,
>+		      <&iomuxc 18 131 1>,
>+		      <&iomuxc 19 130 1>,
>+		      <&iomuxc 20 133 1>,
>+		      <&iomuxc 21 132 1>,
>+		      <&iomuxc 22 129 1>,
>+		      <&iomuxc 23 134 1>;
> };
> 
> &lsio_gpio4 {
> 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> 	interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
>+	gpio-ranges = <&iomuxc 0 0 3>,
>+		      <&iomuxc 3 4 4>,
>+		      <&iomuxc 7 9 12>,
>+		      <&iomuxc 19 22 2>,
>+		      <&iomuxc 21 25 2>,
>+		      <&iomuxc 29 29 3>;
> };
> 
> &lsio_gpio5 {
> 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> 	interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>+	gpio-ranges = <&iomuxc 0 32 3>,
>+		      <&iomuxc 3 36 6>,
>+		      <&iomuxc 9 43 3>;
> };
> 
> &lsio_gpio6 {
> 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> 	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
>+	gpio-ranges = <&iomuxc 0 53 7>,
>+		      <&iomuxc 8 86 10>,
>+		      <&iomuxc 19 107 8>;
> };
> 
> &lsio_gpio7 {
> 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> 	interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>+	gpio-ranges = <&iomuxc 0 0 3>,
>+		      <&iomuxc 3 4 4>,
>+		      <&iomuxc 8 22 2>,
>+		      <&iomuxc 10 25 2>,
>+		      <&iomuxc 16 44 2>;
> };
> 
> &lsio_mu0 {

Reviewed-by: Peng Fan <peng.fan@nxp.com>

>-- 
>2.34.1
>

-- 
