Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E065F60DC55
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiJZHla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiJZHlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:41:20 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1A097D60;
        Wed, 26 Oct 2022 00:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh1Eb6Dbf9RLmQZjiUrptiAiL8DFR6N3J40PveA62KcIHmFwcs7GmoPZ3J6/ANJiHawGQSrD231dT2/xAGHaMzr1fT+3IEaKm3y3Ki4mvOo0sBAyeRnVmpgfBn4n/wC/FkOjvzXUqD5Ve/TXQQSRuUQcMUrC0rY45/jShqX+Xs34kZxu/tCKtRn9xWIT9bYLTP+KDNJMrxh5hMld6HHZXBeKvfs79eOTDUgpZgWNqLPOaki3sVdPYQ49EXCzBsVMrKCn+wiY02EnqdehFI6SeBiA9+5bnNGda4vMMbEudt88QE57dOYU2x6qV5SU1sC8zNjII51eqdhRbOskdng1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcYfojsRLAE5VIGuIxxUW/0B3GmdfHgQC+m0mUosr3Q=;
 b=n+7UDoRPWba2qxWezKZbPiEAzioh/VA8j3kYrcJslRk8qmYC7+WxqouBHvA5vrOnUiq5PcIRlxalzAQSDsZcbX3UYg1hls91UAoBJm64/IUcg+OrV+jRodOGR7bRturCT2GXDV4/zEko+dtnQ/r73ZJULDYKijMFHUoaSMTzqGhAY9MvYxBauY1ixVZ248FWyK1x83sE1ZOrOt0W1MPJV6AA5q40yiMMR+7KYAE7dkvIeQec0iz6mj5f7kuktSKsXIH5Zi7MUrhgB2gSq05ydu5LnavlRY1bVhM3deZVT9DgnvtJ0efbYQxEVr1eFQzpp6oIskE6GcCun1mN/6KItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcYfojsRLAE5VIGuIxxUW/0B3GmdfHgQC+m0mUosr3Q=;
 b=L9wGQOF2dpyCqBi4GlLKgaLJwrDGlW9psJV6P/xf25OEbgM7bxuN/X9wz1++LAtJ8kv2E6eR6B/UVy7VU8oQgELlBKx+w5oQBQgN3G87GYmORBa8937AiF46mfrGkTvpd2GgsGdLQCWPDgFUmde5oloe6+yciqIGTKs+5lSA3Ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 07:41:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 07:41:15 +0000
Date:   Wed, 26 Oct 2022 16:27:31 +0800
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
Subject: Re: [PATCH v3 3/5] arm64: dts: imx8qxp-ss-lsio: add gpio-ranges
 property
Message-ID: <20221026082731.GE18160@linux-1xn6>
References: <20221025183244.615318-1-shenwei.wang@nxp.com>
 <20221025183244.615318-4-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025183244.615318-4-shenwei.wang@nxp.com>
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9b270b-9dbf-4a24-1950-08dab7257648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLKUCzUZuqsjq53P6nJXZCQy3jGfhUwgW/NGxgn11+LxyOvGa8a6BGfb8UVQ05uPv/6wvLdsUsV42U3l8ceHM+qsREJxzm4u6YVPMlciUXZzTpfk8H4zfnG5TlEvIPBk0IQUth52e8yI5TbpnlbaWzyllwgU2kBROUvSMHG0RY4TFty5TPb/pYwXognjBXnVtm0yNAhpm4791OHThNSNPMzTjTm5EoUzzZcklZ3mVcw6OMFpYwx3N2Vd1RfHAk5KLySIdLiG7dyQ3TRwu8YYhezUYV7IdkGpwUjUQgrusoBrArh/yyzHg72zp5Mj7qaY59EdmlP4f9Q79ucUEjQGFoRAUS+qiWOrWADP/IZo9PuQgf9edDuHepropBb8l1pUDpOpZqiJEu/DeTefiEh0UkGFW2Ojid7dMXfBv6Jk94yPjFJPTCIy/juNSqCtjh1sQUEAG2KvZKekHer8WEBNrtz2lgyu3B6tpiPNEt/9FwgkJ9OhuHOzD8dR2GR3ynXVvJTOAVJUsTHkRtrzcYfJdmMl85L4uKBzMRP58bP6v1oOyJ7I+tX9GBrQCaId06b/gGloIL6dCucuBCByJ848Gc+pw9dNuBEklqyHK4gv7jyKxzC0ERLxEqsS54k5huU72IjxT01G0L4lNbHWlSQNpSlSq0IYVFQVeY3X27jpgrrenSpt91sAn/4iLGYTPCyv6W3kkDh+kKD4Tq9Jq7/HI8ehbH41sTigOYhjSh0ThSdevevQ2bLPQ0YbqlxQX86LJuZnDr/mY3n8QmT2xTsGIg/M0pp6pYeD6/t0lH3P4lM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(478600001)(86362001)(6486002)(9686003)(26005)(41300700001)(8936002)(6636002)(54906003)(6862004)(7416002)(66476007)(52116002)(6506007)(6666004)(4326008)(8676002)(66556008)(66946007)(44832011)(1076003)(186003)(2906002)(33656002)(5660300002)(316002)(38100700002)(6512007)(33716001)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x4C1xdcUzA81/mEUM3UfjLJdRahuWo8uvCR0BnHLtKL40iwhpH2uY4o8/mn2?=
 =?us-ascii?Q?0Wa6Nl/GJu7Vunp/S8554BtTyQ6ul9eCckRzq+l8by11k2kA4MGs8WqPWC0g?=
 =?us-ascii?Q?9RfUXX/YnzZoiE2zL4Cex2jbf489CEj9ozdG+OEGiQpnJAEjuwx5NSJD/0v8?=
 =?us-ascii?Q?jBrXU0moao6zOkxWFim+phwIyanAhZb3tqnDqYiXDTctqfMkoG2tXyb5W7ge?=
 =?us-ascii?Q?wGlnR7HsXSafiiEtZqxuk75c5fL+gaOumxk0zVVqTlfcc8xsYxLR4kyOM98x?=
 =?us-ascii?Q?fzftgWT6taQrTR6VHbYwVjojaaZR/tazUPo7GvzpvibR/DWkKZ0gZ6Fzlelk?=
 =?us-ascii?Q?tXTdjQWATtQZmccHZERDVyeMtJwPhrfi4lfHD+TAV2RaYXtgxaOXlUFsXRF8?=
 =?us-ascii?Q?Pe6LOR5YgKO4xDk/Th5fr3twU6nF6WP568AbtK38xJ8xdRu79tcM03245f9t?=
 =?us-ascii?Q?YyPsofgC31tHcJ4UeiPHNXUZBnTQmzYsfEyE3+StZNoy/a8oyJuolksq2Z7N?=
 =?us-ascii?Q?DyLOxgJRenCD4Bx49NeGitRXKpSCs0Chjn8b0EayYs7dTJSLP4fFgtYeR5Nc?=
 =?us-ascii?Q?2wY7u7+/LiDeOnKRD6WYngYDLPZxDV6YWCbD0V4WYOvSSUp59l/zNOwDGHSJ?=
 =?us-ascii?Q?wLcptdBI01d83Bxz+fk6euhHVAq04RozvMhSX1POJKj/h4jVubYvBHZf7SOQ?=
 =?us-ascii?Q?8JttSC73E/XsmHbv7J2arlcPCJqTQn43vsi9M+uxec2S8XHnmuhjLlb+ppqM?=
 =?us-ascii?Q?dmLDIvzQJaUH7s6iSxxLnE/navjFifRYjU2FFSdxL39CT6AGklKH6lIGw2ny?=
 =?us-ascii?Q?BSPEP4HpyUTK3cqyRHb296+FYRxaEDHEGOr7AOBDhZkvY79fyzmtZ5ZL8FqP?=
 =?us-ascii?Q?2DYKQVJuw+gUIY0NXl6CU6ygf6uPkS5fn3k1EtGwPQwVIcJ5q/EBQbOl4b3f?=
 =?us-ascii?Q?mrxtvchl4ZzuMKoYiPLNn7Tb3rCHNAozp/vgtIb8ENzvPh06jrMIMqI6NH6C?=
 =?us-ascii?Q?rbFDTgIjWngfW0iTc4TbZ0nYIH+8JB3nsec4C4fIirMLTyEMKIs1GxqOWGfP?=
 =?us-ascii?Q?njAxS+ruzN81rde1ISYrg4Z1vY8L1FKHXtIoYaaH2IwXVzTyYCrc9lijD8Js?=
 =?us-ascii?Q?lHRS7Xv7iHA4FuRRrCfF+QIJZNTt6DO9OjeAOxEs/WUgynYiQd/zQAbcPmrp?=
 =?us-ascii?Q?ljxz/KrKunI+sZ5lNlPRVFZ6m9urfL4pTSyhIfbqTpVMvtF81Bh1QOkRHL14?=
 =?us-ascii?Q?lhTsh7Hq/MypYQ8NDCbP+IVToRvmRPlHxD1cCi5GksmbkOfNOyxk1Ul6vB6e?=
 =?us-ascii?Q?PMDnVgTIqxA380jS4rOhAyfN5OaSC6DM4LTBshpW31X8h0RbiezuWW0qKVIR?=
 =?us-ascii?Q?qRHxh1B6SNuTH52Wa4hC4uqtATmYebBvf9cjMlpiDDsHhcVc9Aud87UaP6wO?=
 =?us-ascii?Q?HVYvyXdekTPzENIngxhKS2ou8xWBgPi75AINGKcLZrfG03R2MhdyMRhmMVr3?=
 =?us-ascii?Q?y70nr7EBr7LTVrpjJgMSLXxIBIkswkEmPF7APvwCDBTTl+4McThhJljXwo0i?=
 =?us-ascii?Q?OquU1xZcBSTG57Ngcoccbh2bvO3prMP2m/mtk/yz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9b270b-9dbf-4a24-1950-08dab7257648
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 07:41:15.4167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JyZiYjUZE55svQ6S0XPbhwR41h4AM95CAhOO5hu0wcUvNQdcc8ZHtENsGcgFZ5mjbH/p5NoHL15oxdFMaimJg==
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

On Tue, Oct 25, 2022 at 01:32:42PM -0500, Shenwei Wang wrote:
>add gpio-ranges property for imx8qxp soc.
>
>Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
>---
> .../boot/dts/freescale/imx8qxp-ss-lsio.dtsi   | 25 +++++++++++++++++++
> 1 file changed, 25 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
>index 8e2152c6eb88..8f722b1dd078 100644
>--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
>+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
>@@ -6,26 +6,51 @@
> 
> &lsio_gpio0 {
> 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 1 56 12>,
>+		      <&iomuxc 13 69 4>,
>+		      <&iomuxc 19 75 4>,
>+		      <&iomuxc 24 80 1>,
>+		      <&iomuxc 25 82 7>;
> };
> 
> &lsio_gpio1 {
> 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 89 9>,
>+		      <&iomuxc 9 99 16>,
>+		      <&iomuxc 25 116 7>;
> };
> 
> &lsio_gpio2 {
> 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 123 1>,
>+		      <&iomuxc 1 126 2>,
>+		      <&iomuxc 3 129 1>;
> };
> 
> &lsio_gpio3 {
> 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 146 4>,
>+		      <&iomuxc 4 151 13>,
>+		      <&iomuxc 17 165 8>;
> };
> 
> &lsio_gpio4 {
> 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 0 3>,
>+		      <&iomuxc 3 4 4>,
>+		      <&iomuxc 7 9 6>,
>+		      <&iomuxc 13 16 6>,
>+		      <&iomuxc 19 23 2>,
>+		      <&iomuxc 21 26 2>,
>+		      <&iomuxc 23 30 6>,
>+		      <&iomuxc 29 37 3>;
> };
> 
> &lsio_gpio5 {
> 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
>+	gpio-ranges = <&iomuxc 0 40 3>,
>+		      <&iomuxc 3 44 6>,
>+		      <&iomuxc 9 51 3>;
> };
> 
> &lsio_gpio6 {

Reviewed-by: Peng Fan <peng.fan@nxp.com>

>-- 
>2.34.1
>

-- 
