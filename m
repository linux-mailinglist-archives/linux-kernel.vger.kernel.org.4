Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7184960D39E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiJYSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiJYSde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:33:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E8CDD880;
        Tue, 25 Oct 2022 11:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyMqx8u6a6SGhD5ZwGS8cqt1+TE/da0c+1BSj9qKRW3ERy4Z4yQre4ChEibAvsMLiKKD07TTk3GF5GBJJrg1GPKNWzkguOu/0O+E2NiNTfYIXLrrfqeVt0whAa1FBrvm2mdqlYh11ry/zmKAZoZHoweH2Fw0nem9Yr3natN3MN89hvBmQEupuR1RS8qet1vzirLAr8TMjjT8rVEDKI6mIPWItrlQD64c9jc58D0B7lCUhVaqPA4ICVkF5NlUizel4/mEQCn6brwpZRnpXALdK7iEeugtr0xlsP1E2tr8ge9qEjZgkj42YUrM9IfA0qyEaaFg7cOu61yd15TA+YgAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvNRGO9FYjSRVBb27KW/tFvor3/VmOFsdI3W3Y3QopU=;
 b=VoeIDftnAjbTiIDj9xaG+6hJDyCUtqn7r0eEHpnZWXyDvd4VU38ysWCNBQJN3Yyk+XsSqyJ58NhJofFjA7M5iRwJ9B/cdxEFeon15C/hI5UytcSp9araYwq7fvkr21JhIuNulMMPZFfKEKrmMRBsTFKHtsQ6gcalWo9PQi//+ECHF/lHtGptB4U75ehDuX8PQrfiqfooPHA2KF9TKBhjrsbB9cDFhuKcOsW9utOhCTxyVYECSyiAfU/b6nESthW5XbDFYyXdnmM7VgCcT33AoPcsaxhxGcqjDWMT2s1ZFuczwRdvMEtWEy1ngs4UmRp2q4VLWdrK5Iy2OaN+p586LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvNRGO9FYjSRVBb27KW/tFvor3/VmOFsdI3W3Y3QopU=;
 b=Mp2C84+Ge0+2OElwaLz24shfEqlwjPeXFphWGSEP6ujcui25wbhO0QU83r4jbgS0hUDudUFfqDpGd0DGFp3OYzpC38gBrVWXZONlwiy6jB/1B2owlDfbBOdfqiXnOY/D8tcz3Cmn90SQtUubLHNoLolGpt5NNZRz2JkRIhe7elw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS1PR04MB9581.eurprd04.prod.outlook.com (2603:10a6:20b:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 25 Oct
 2022 18:33:22 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c%9]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 18:33:22 +0000
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
Subject: [PATCH v3 3/5] arm64: dts: imx8qxp-ss-lsio: add gpio-ranges property
Date:   Tue, 25 Oct 2022 13:32:42 -0500
Message-Id: <20221025183244.615318-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025183244.615318-1-shenwei.wang@nxp.com>
References: <20221025183244.615318-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::44) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AS1PR04MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: b15ca983-36b8-406e-29a6-08dab6b76587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EeFCt4o/f8/wKFq4cI6yv8KNdxhVAUE6L61nIQYXo5L+0KbGFoRmiiRBlI8mNutj+OmEHtW7CgGSWPggSnsK4QZYWxkwGahniREmAsHUJ2wh9rmNRx+eLLm6EbZCMSENu2DKPp8p5HLlVKq97bwRA5Hn9lkyW97NbNbg2J/jxfZK0j1rjT0LG6SPkUAJa7FbGTeFBGgSIrbZjNep2BGdR4xthSrMpa7hVZP8G/lPzzS78Cy8hC8o3yEgBXFOqWMoemu0xM53jNamBq2i+F3dBJrL5DC2iJaozkFwXnjxtHbfBh5OXydHsAbWidtFfWhVC1LVL2YW+3Vm7Ru9HuGVDFKI7+eOXUAYIe6LMKVkZWHd+KXm1VQ9GSqzon4uSksABUMtQXxaahytEhi1V7/9nKhGwqgsg5H4PMPW+zPUO2ib1xaj13spaOE+fqZUQUNYXbWbe3JHBDHFG8f67RJkh1OHKfgNMchXl7G1cxg4exuZkAab0g1gZBOEA3LJoVumzBNdk9bJtfHIHEVsDDEQ3yBWg9czcXrKexS/5rdTfKLen6YUMFZc0/rbIQUop6xG92+7OKvNkh6ghp3yLD2VXefbKXz24PaMJxTWydzVkfahaZOxWgR/PvqGzIMl4hR1Y5l+MWYIm2WtK/NgNmxN8TH9FuP8UOlrNJUual5Ijrwim7rqLPVU0OD972dDEBJ2e8MIY8OMN/K14eQOkEd1B4sdQDdYVBeMYUrmp9+0qrX6UVxZyTz6cmOsVHqKvXnHyCDSaKfmVjbu8iJfJqUqfX1P6SP0wCVExmJEaTXCxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(478600001)(38350700002)(38100700002)(7416002)(55236004)(6486002)(8676002)(86362001)(2906002)(52116002)(36756003)(44832011)(6636002)(66946007)(66476007)(110136005)(6506007)(8936002)(66556008)(4326008)(54906003)(26005)(41300700001)(5660300002)(6512007)(316002)(1076003)(186003)(2616005)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qNrYjEpTENPMkfX7To2qmuA2QbaNqAtm380R+qlag75aZEOdDc5QLPImkswA?=
 =?us-ascii?Q?JBOyu3JkXWmVyRmIENyeW45qATc6P0lymDl4uwNh0mt51I5EzIFxngVCfpRc?=
 =?us-ascii?Q?ZVVhTK3mFy9BOUolLcQWBkkDWDkgLpB37cPpJ659RZGXriz3DgmjgYaPc1rm?=
 =?us-ascii?Q?YyPCLxKamm8PdWGY6wcSXTAwOpcJIlDhQCuuzi84CIBpzivni1oRTgnXuQYn?=
 =?us-ascii?Q?3hKRggU5AoeYfdKzvVqgxjMSL3rl06R2MW329KN+HOlqUqIrRVUa1C9FHx5s?=
 =?us-ascii?Q?+eg7oJ0hUl31unzoM5mJtbqodBzZeUQl2kBopzJAg1oYB8VyK1lhLUbXPjRe?=
 =?us-ascii?Q?zVrC8oW7ciYSihbCdqrCJ2G1AXByccCc7pxwZwV1WVrYWsDkujd48gCGXC02?=
 =?us-ascii?Q?v2d3Avk2swWtHgAbxOL63IUX7PUdd7hXtlo2Ww3nx4j0cCvyUypr1hUv2JUu?=
 =?us-ascii?Q?kbLKKrwlOKz2s6rc5Mf4y0QCWWXLNFrwQMqJPxCyP2USLZI7+IrZwJYFRj1M?=
 =?us-ascii?Q?YTfE7mJkLmbaoZ6HFJsiBo30MiBQisBctppYlXEakIWsjCx8ctqeXLL66umQ?=
 =?us-ascii?Q?RlRGE80dvDy40qkmzTGh2t0DGGVYC/3a3oHpuFutxEyzTMSjaJVaSHrJmBg/?=
 =?us-ascii?Q?14fTonthh3HaASAx/O9NVxtXzSdjJMKcyTWlPtP3Ths0tv/IHr9rGC5QHtEB?=
 =?us-ascii?Q?+5iqjPdHAvPtVi8lFXMFnm6p3HMMzqxQ5YNv5y58w41pAQqGC3awrJsXc4vm?=
 =?us-ascii?Q?Oq+DIsIdL6Lan4/xKCz/bSICMeRHq0JYoH2o7bFBItM7cGNy2qqEqgESI4II?=
 =?us-ascii?Q?xzWlZA9A2z52diG0GAxSGkHXoznzaxYoxtR+JEy8I78xlIOzMBDoumejk6R2?=
 =?us-ascii?Q?zjO3gzgN7mwLAeeaJDYAlcUKzP/UAFpoSEHVEQr+wwkNnprX4c2/licFO/+o?=
 =?us-ascii?Q?bF9xq8W/Raz95fxTCSk/Wj9IoH5x0hOandz9t1tSGWA47Ggo7F/hp8ZS+s+d?=
 =?us-ascii?Q?TsGFuI4c77kNMmC1N4BnvL4ycuqbL3BT04eCDUu6ZeBhipQa7GHWzbdGkU4O?=
 =?us-ascii?Q?hrMV4UvVaTIFn1dDMO6GqVM4vAabzltAio4MrLmuZ9hGse3e97b+yf3U/2lE?=
 =?us-ascii?Q?29yGUn9Zebfup8N5lgM0jfTl5ec2ZKswfcxwXBrswfWb0zuZMvwNQMd93ioC?=
 =?us-ascii?Q?v3YBHt0XwrCE28LhKfhdJ8FqrUMM0TRURw872+e3FY+/R6ou2gbQEpn/JV/E?=
 =?us-ascii?Q?3zNzhrwehuApsi5597ndDFi/3CqJCZ0BMiNJcnPXL6ImFGLF0Sfb4VGmkbYC?=
 =?us-ascii?Q?Jm6Kza6tVyX7S2780acbNgojEcQJnnO3kVbhJEfHVnfGA0Eg2vqmk0rvvhR8?=
 =?us-ascii?Q?H19OSzfqfhioaFzZ9zLVw2LMW2vrssBlzhKJW1KwiwWNrD9YojWMId3ZIk4e?=
 =?us-ascii?Q?PT6y9+WXyHX2H/O9cuaRvkkzHzbSOFtPb3Z4ORR/2fLgXr1QtQVAjZRt9T1L?=
 =?us-ascii?Q?SL2piukStPrrJhKZDl72QkfYJq1iq8QL9rftO7NQVNhjhpnstN8Bi++d9WVA?=
 =?us-ascii?Q?SxUPB0B63+LN5rftVTLBtMj4n3NaAMdqUVG7TlXu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15ca983-36b8-406e-29a6-08dab6b76587
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:33:22.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQyg8aFCaN+e+pO0b29khFYJDulm2dl8ZdUQypYLwzGVaeEKU2SnwBUd/dyXlMqFj3jXilgJzWUpTJ5lWZgVpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add gpio-ranges property for imx8qxp soc.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 .../boot/dts/freescale/imx8qxp-ss-lsio.dtsi   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
index 8e2152c6eb88..8f722b1dd078 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
@@ -6,26 +6,51 @@
 
 &lsio_gpio0 {
 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 1 56 12>,
+		      <&iomuxc 13 69 4>,
+		      <&iomuxc 19 75 4>,
+		      <&iomuxc 24 80 1>,
+		      <&iomuxc 25 82 7>;
 };
 
 &lsio_gpio1 {
 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 89 9>,
+		      <&iomuxc 9 99 16>,
+		      <&iomuxc 25 116 7>;
 };
 
 &lsio_gpio2 {
 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 123 1>,
+		      <&iomuxc 1 126 2>,
+		      <&iomuxc 3 129 1>;
 };
 
 &lsio_gpio3 {
 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 146 4>,
+		      <&iomuxc 4 151 13>,
+		      <&iomuxc 17 165 8>;
 };
 
 &lsio_gpio4 {
 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 0 3>,
+		      <&iomuxc 3 4 4>,
+		      <&iomuxc 7 9 6>,
+		      <&iomuxc 13 16 6>,
+		      <&iomuxc 19 23 2>,
+		      <&iomuxc 21 26 2>,
+		      <&iomuxc 23 30 6>,
+		      <&iomuxc 29 37 3>;
 };
 
 &lsio_gpio5 {
 	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+	gpio-ranges = <&iomuxc 0 40 3>,
+		      <&iomuxc 3 44 6>,
+		      <&iomuxc 9 51 3>;
 };
 
 &lsio_gpio6 {
-- 
2.34.1

