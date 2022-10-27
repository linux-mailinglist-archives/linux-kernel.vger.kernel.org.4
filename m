Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F260F893
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiJ0NKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbiJ0NJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:09:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1832BE1F;
        Thu, 27 Oct 2022 06:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR5Twdteequs5EPeGJhQnwPfqnY6ySNoQ8Wg4rHf44Wq5x/QaUcZM6ZQiPbpBk9eYomErfWVQeZ9L2rF3FsE3XiY+q9p7AV5ZcFeQi5Dyy+GE0sHwiF/OBWLs8tuR0QPorPAKFNdur77L5Q+2d/S/aFJ+lFKhO5+dG99OvdalFEkrb0lcP27a6UaiveoS50MWAduz+HbVnrx+twIviI/TfNg2ubllU04CLSMjkGddhrQudFJ0CAyFLCNViQISCvI5QiNXJbKUpmX3NIhi0Aw1kWk6EhRrvOtirDBhbGoD/rAuzPcrJPKwBVV3NBHX80Wz88IdsEIQYnZx+cskD5/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHh0nFTm4zTj5yYtQa/eucC6o1aa9lk6NCATzrwyE7I=;
 b=UyaErNSSZr75ikbPgwQynL8pUSZUizdsmPOC5idY37WuH/e9OW/4DWR8DNiHcEdhE/yxlSVr2xzxIKD3tAuzYACV8rnGH60r2SCSNIivuyzml1Wq+aOGJL0HCHajiBVveVcF79grrz5mHDyThYrk2sQGUB0pXNtVgnf3tZRlPSggs+t9akbJCcgk8HJzrQwNkcnIDwhZ2tR+0MnAm1uii/OSlitT9/qcshGubBH+OWnYtRqIPEuX89MNVyPWTE1bkxFpB3nQ+v1L4AiHOXzPjXmwUmAlHVHtjn2/0x4lCikoSYlm2B4y0Ycc4mifUGWEkejh9d0BVRBU8DipW4mlMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHh0nFTm4zTj5yYtQa/eucC6o1aa9lk6NCATzrwyE7I=;
 b=IKn8bWdn7MOh9CfNqdvyli7hb9DUxJRePxSy+5sgJvm7eSR+JijRJwwhqhqZYeEMZBcSSzRNu5Yn5PJ3K8Mc0VyxcBDpqBSgqS8Z9MKonYlG6gfJuTuAZhqm/lxmMIQt5BM3TpIPUqCLrJaWfKYbK581kjpXG+97DeZBtd2dtEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 13:09:46 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8%3]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 13:09:46 +0000
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
Subject: [PATCH v4 1/5] arm64: dts: imx8dxl-ss-lsio: add gpio-ranges property
Date:   Thu, 27 Oct 2022 08:08:55 -0500
Message-Id: <20221027130859.1444412-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027130859.1444412-1-shenwei.wang@nxp.com>
References: <20221027130859.1444412-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM7PR04MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c70e68e-3b58-41a7-7b1e-08dab81c853b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWsfqVe3VjAxTYgQs/+KrA9KmCMhhmyJIPZ+08RbpPv+iLzyNsrDXMpuNvS4DaSH9w/9yJqHSxI2w/UdJQX/jy2zQiEkTcTXxSDyPUCBmQFy4y372GZSSr+IG3SbzlH3KFTzmVPCYBZuPdIdr+WYijCJo7medYqUuB3cRo/sqFzb0AflPdltYKQPvbLFKbCuGNX4nkvXJuzsmrQXMfzPKhWpMh6+L82bvZHMJntC1E7zWORhVnvTg5v6/t1e6cfYJxiuFP+sng9yPYaeL3YxPmnIexxtxeSSTQmdtmPykgOLP/JuOFpGa8HJxF2aEzsGV0UWdwHJCN05CKdhmIB7gPsbxePzlsxK7jQ+BrmbHIeBpl6Rx8tMRbXFUHJgyIDrN/ES9SGW4RKvUn4ZtMaYsmGwQZ6wx7LSf9asGWmM7FgB43y2S+FxebuDw6gB3ZoX72dO+dAO/O1jzX9Mq9oRXmYgSAzVJoVoRgH25dz3cvXvqwOBCHcH2S7NTY4rIyskA8l9VVvYNQ7lFbM5+NnuDjz1y+i6sEu8zUYkCQFWc6/fCzpo7tccakR7NCOh/eBiXKnkg0KBrxW7bQfhcQsQ/huWMAvUIWoF2F5vftvsjuerX/k+Rud8E3BItN3WLxxeVK0s4XSei198OdQHKoS9GxdKi7k/cOhfBeXBjSUfFUCgQzGB1pVNfIfO1y80koZ+ZqW9dWgfd5Eo2xhvgT03OoTIUWjbCV/Y0cDTf7xotQtOUPuTH+glNWjaZp4s7dKsDLBS6ibhbQuMsgrEtCbvHKxrOVnZ6+7Y5FmZRcptmg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(55236004)(1076003)(6512007)(26005)(52116002)(6666004)(6506007)(478600001)(186003)(2616005)(44832011)(2906002)(6636002)(5660300002)(54906003)(8676002)(110136005)(6486002)(316002)(41300700001)(66556008)(7416002)(66946007)(66476007)(4326008)(8936002)(36756003)(86362001)(38350700002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wepp2Z7/UlknxeGWRfMiHA5YPWnLztYRgZthwfCLlPdd1W6IX9+XgGO0fKWR?=
 =?us-ascii?Q?b+fAMJnYIiZsHiRRJEx788H912Suo9eARQFtOiaObbuf8yvZ94ufPpCExFqz?=
 =?us-ascii?Q?2ZbsRDPvKosCtmWW2ymZxIAsD3TaLwwM5SA8ZhxviVl60GkDfyAsLudj4/Bu?=
 =?us-ascii?Q?QsDDw1Ce6Jh2229VY6YpPrOejfKwkU6b7xHAdRl5HU35ULnvRu43juY7ouyY?=
 =?us-ascii?Q?9YsP+A1KLHnaAJJma9JxqiIZGGqTvFTRj7gRTdr0lRS2fgzzbfFGSAqfmLSB?=
 =?us-ascii?Q?EkvKCbGWeX9T0LPK2OzCYqxNpSCGdodF+cnTKMSj7mKkAzOrYllExMjUKQYy?=
 =?us-ascii?Q?oW0QAoB1b+jQ2msAqgi6X3ipac//YwfbbX6zzM6XiVg7NQS4IEHnYCdIceQp?=
 =?us-ascii?Q?mscuKHjtshgUTBmQNh5HLlz5SeHLugZQcyeYNgpuLdis9dUyNOE486b5XKE5?=
 =?us-ascii?Q?Ou4AEPn8TsYq7Raw3XFSujO6iqOnw5L/uZCXjEIyB4FC7mvsCF5IlMQMRicp?=
 =?us-ascii?Q?pwYL6R9g2Bf7N7bFyz2HrMQgjH/9UteSOuzR/yjHoz+2xT4LodnxOvbPORIt?=
 =?us-ascii?Q?uV2milbQDCVIfVHZdVfrFD6SJy2CH2bZ8+1KQ6QF0niZQFOTc8bbMgcpdj3T?=
 =?us-ascii?Q?OcAd6xQaoe4o2tuFcuI0Hd1wrxPgIeQbF/Pq+ZGjVypckDyjx7EG5ArjKo2X?=
 =?us-ascii?Q?hql003X4KSm4/SHsi5ArBoxZIODYKfI/ut+M2nvxkZjEhTPjVGboGFi4ipmz?=
 =?us-ascii?Q?uO1MvLcED/blaN9c/imApI99hIGRJIhcoWUAZjHvqX45NPnVhAlVaAIYfmI4?=
 =?us-ascii?Q?xr2/So5aBGljHdxZnfUVAIAjnybiaIs9U/TXkmtrJCQNzAT2DMq62KOkw/oq?=
 =?us-ascii?Q?AbK0oG1cFC9BNHFKIGNlAtDL3yLjGdr7a3idrMoB9tRuW2uEuFCFi5kiFweA?=
 =?us-ascii?Q?XJ8JwH+Ko68xzLqjL92QxvFyXFliodyUgAmhTQ3EmLrmmxdu2BiCzRoF8PdO?=
 =?us-ascii?Q?BUAdTHjDwCIy9lsfVznx/Uj4ZINQJxFCXguadwzOd7+Gh98w0r3ZmWzdjzMx?=
 =?us-ascii?Q?cBAY0g7QAYgECrO8R9CeR+YGzTusuN2nB7xPdTbOzGxq0ohZCywAjI+qfIYb?=
 =?us-ascii?Q?Mp69O3Ip5hmVQ4hqrh0U75sjTxfsdf7Rr4OauDhAe4jd+JEwyXUyf32ZaV3w?=
 =?us-ascii?Q?VLmI5ajKzIpMcLwOMWNuRY3xm+YlvXyDonLnTS4WWUt8iyd67CANQmZ3Oczr?=
 =?us-ascii?Q?DKyLbLrIEnFvJEO0Xr0SwGXZWSr9O0NGdX8iUVvjgEehiy+VXEvh+/pbJBXC?=
 =?us-ascii?Q?4HnsjSJ1BecPc87ENiIQKsAalPKVjBYR9O9QKoHu5gHTtQQq4rupzgTIwWdv?=
 =?us-ascii?Q?hNa3QgfKruytyxpoP5WSi+bmxbizGPYGI64X3B9VXAF0xti0E7vU1I4JvFOH?=
 =?us-ascii?Q?ixhqfXKtDkr3ycA6ui6949FXSR2rq/g0V+cmbaI0GeDmlUK50mbrExh/qM+n?=
 =?us-ascii?Q?kXoqD6DfG3V7YA0Q9EQLPKeilznzinyMtigryaUnoicxOkfn/lOoQ9pYQ3Ej?=
 =?us-ascii?Q?qN/7mcZsdJz80DfNKwHxfmw4dtL/zHF1P3Qryc+Oc+T5S53lB8V0+2mr2/ba?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c70e68e-3b58-41a7-7b1e-08dab81c853b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:09:46.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0WbvoXnlA77R6n9TuQ7Zt+AuxINXY5zEm1xcwaS4kJTd/PGxiud1X3ZCgxpgI4ca5law+Pm0q4KGQWhS6YCCw==
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

add gpio-ranges property for imx8dxl soc.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
index 815bd987b09b..5306d2b3fc3f 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
@@ -6,41 +6,82 @@
 &lsio_gpio0 {
 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
 	interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+	gpio-ranges = <&iomuxc 0 47 13>,
+		      <&iomuxc 13 61 4>,
+		      <&iomuxc 19 67 4>,
+		      <&iomuxc 24 72 1>;
 };
 
 &lsio_gpio1 {
 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
 	interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+	gpio-ranges = <&iomuxc 4 74 5>,
+		      <&iomuxc 9 80 16>;
 };
 
 &lsio_gpio2 {
 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
 	interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+	gpio-ranges = <&iomuxc 1 98 2>,
+		      <&iomuxc 3 101 1>,
+		      <&iomuxc 5 107 8>;
 };
 
 &lsio_gpio3 {
 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
 	interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+	gpio-ranges = <&iomuxc 0 115 4>,
+		      <&iomuxc 9 121 1>,
+		      <&iomuxc 10 120 1>,
+		      <&iomuxc 11 123 1>,
+		      <&iomuxc 12 122 1>,
+		      <&iomuxc 13 125 1>,
+		      <&iomuxc 14 124 1>,
+		      <&iomuxc 16 126 1>,
+		      <&iomuxc 17 128 1>,
+		      <&iomuxc 18 131 1>,
+		      <&iomuxc 19 130 1>,
+		      <&iomuxc 20 133 1>,
+		      <&iomuxc 21 132 1>,
+		      <&iomuxc 22 129 1>,
+		      <&iomuxc 23 134 1>;
 };
 
 &lsio_gpio4 {
 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
 	interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+	gpio-ranges = <&iomuxc 0 0 3>,
+		      <&iomuxc 3 4 4>,
+		      <&iomuxc 7 9 12>,
+		      <&iomuxc 19 22 2>,
+		      <&iomuxc 21 25 2>,
+		      <&iomuxc 29 29 3>;
 };
 
 &lsio_gpio5 {
 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
 	interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+	gpio-ranges = <&iomuxc 0 32 3>,
+		      <&iomuxc 3 36 6>,
+		      <&iomuxc 9 43 3>;
 };
 
 &lsio_gpio6 {
 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
 	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+	gpio-ranges = <&iomuxc 0 53 7>,
+		      <&iomuxc 8 86 10>,
+		      <&iomuxc 19 107 8>;
 };
 
 &lsio_gpio7 {
 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
 	interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+	gpio-ranges = <&iomuxc 0 0 3>,
+		      <&iomuxc 3 4 4>,
+		      <&iomuxc 8 22 2>,
+		      <&iomuxc 10 25 2>,
+		      <&iomuxc 16 44 2>;
 };
 
 &lsio_mu0 {
-- 
2.34.1

