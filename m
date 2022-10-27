Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8660F899
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiJ0NK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbiJ0NKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:10:06 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D2357F0;
        Thu, 27 Oct 2022 06:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr2lqqXgWTIxM9HWMg8Vx+un9V9NagcJHOlyboQ5B1DxNIvLXDuNEvadC9baHJQC3BrVUUS1tek/ZzPuPDmzaNs8s7JxUqz0SG+XcGbWz5mkuLO79Hgu3Y+4nAyzoQzrbTtSkds/ofNBDSoCmaKPAJCVh7dSeCw0cv9VyopZQvJ6+3t2f3WpbyIqwbI1KsR+A/fEbeqBqwJTeh2lKcUroMXsYdOt8icxtit1F+9E8ecLODZ3kVwph3gOKC6PXmIWlLm8bPzV9hoGYph3sijEYMuYa7Tk0q9J5qB3PNkBVPsMJdJAo5AbSYtXmE4xdXx8ocRso5TQF5NqaJ34uLsG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pt6pEJ4tFgXysBoOilvGa8i9zK5mFNHm3eCr37GOGd0=;
 b=LZ5d/ZgcwelXCw+Ob+8/XE+G976AajpywzgI5KV3ORrP3Ww/1oEkG63ZfZ/Iqv9+ffO7VyEExtH824JBEFYpFjnDzRYHs/FKLTwonFgaSpXK3JxvnbdoFHtcw2So48o4waxkAhPrZZopHopJIFRcp2S1iBydaaMIH6SILdiBWBUPveuxE5e12vrIcWJ5PgDMttix2x7eXGrBgrR2WUFrhClb7ZIDSMSjnsC1X3schu4tRcElai7mJ+C0jbrdgDVvn06oVh4bfWbH500lPmqbU7oqTfc3/NBHPdFEBXXx9HeRUlq0uR3PJDtie45QZCYLLZYPv8vkzAP9iObEtr4Xhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt6pEJ4tFgXysBoOilvGa8i9zK5mFNHm3eCr37GOGd0=;
 b=jxt6nXc7C5rJYnXVl4WHKF+V9JPbmS3j00HBCH7XmNtdgh8yg9BxNibeGhgN6hQBo+8qYU/iR7HoyMxdItRPJsB3jvMSr1ZCBLvR9KTBM/9dWONczicw4ZNM+IlPN116R+z08GUIrgXNbI3+kni2CX3xeua3jXnsaeJzzM1TtpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 13:10:01 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8%3]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 13:10:01 +0000
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
Subject: [PATCH v4 3/5] arm64: dts: imx8qxp-ss-lsio: add gpio-ranges property
Date:   Thu, 27 Oct 2022 08:08:57 -0500
Message-Id: <20221027130859.1444412-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027130859.1444412-1-shenwei.wang@nxp.com>
References: <20221027130859.1444412-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0378.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::23) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM7PR04MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed0ab93-3cf1-4c5a-2094-08dab81c8dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSXbU8shxivf17/mSZYLYgZ34U6qAu1lUzqvT98YkUe/ZIkO8k9+AbGUoa6H3EN7BhW35aioRDj/d4xcjABS8BUekc3qq63aozahFIWsVULJCL7LJ//qfRYaXs0ZBE0G0YMco8SaBqTZHD3SLwRePchTzavLKSW5QT9rspY4K4pBAWVqo6qO18Lu2yfwupWC+fiDJDwFlqMaIB5lkT4l1p/tfdgiJZHPnKQTCITNxtIMsBCQNzwjJBpABugyT45pihsr6Q8Ymgf+SIzqEtJ1ahOnua16WMjCILsizj0Pu1SszpJV03k/x5h2GRDL50kPgSQDRoWLR5wj+munX+wTYdTa0hXhkTl01GXrDG0PxRulTaBFMFEoxlgqr19vzrUmAg4zMzQQ7pRB1lJBRfpNbDcw5wlTg9+gSXnCTEoYajdaGSOzu2V5P0jXTTqK3YHp6YLj+5x4xjFHnEOs8YTnPY0FBRqLzZAjbDS98oIkr2eQ7w+c+7CPaO1ILmYpaZZnfpKBppuCa/Tce1MKdWkASl4glCVHA/yw1rp17FUPBfw25mlVILtWZibTPNxI+PZl0GtVCHgpwSXYVQexztHgvwu93ASZALp/URo3mPS7yPQhwndLwBmPcEQQyHCm+Aopp17478YEMf9+bQQUuCQkDOVsjvQnyKmYkidKr1Z5Wj3du4wi+0qc1BMZtQ7z3U0QOq2HEox9JB8wI2Pf8ZFSD7Teo+bYAL1QK0b7Gkr5610RU5Yn4SOVK8jNKI6H4lbyIbYAVQ9b51cxcugqfOy1Fd468aqrQHy02XRFt2wEy9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(55236004)(1076003)(6512007)(26005)(52116002)(6666004)(6506007)(478600001)(186003)(2616005)(44832011)(2906002)(6636002)(5660300002)(54906003)(8676002)(110136005)(6486002)(316002)(41300700001)(66556008)(7416002)(66946007)(66476007)(4326008)(8936002)(36756003)(86362001)(38350700002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7AaPwlNuwXuXiEB2QvURprNs7A1qCbC65tdiKtly3QDcV/dhMte53fQhJjZ?=
 =?us-ascii?Q?PUzMASWq1xRc6/bl1VrH6zNGpyfBlOglW3orRt4Euj+MJLgEk3uP+V3c4GJM?=
 =?us-ascii?Q?JQzElR4/4TpDCX9ZQQ14qGq/Lu+B3dH9VtwaHAMVSLh5ksi/Xvni6KcJeAg2?=
 =?us-ascii?Q?FLwu+/q+NHNW7vTV9KYnUS1hxMZ2H50OmFw/I485CizA9FO9LaJytNHTUvd5?=
 =?us-ascii?Q?bxJ8i67tr0Z4fQv+NdKI/zIee1WmE8wgm8cyQmTj42aoYr2xT0w/0JQB6/KG?=
 =?us-ascii?Q?gkEHvwgGZ4lrx+4toYFjzaUnQLc3OvYXKBUYCmC5Qmp5JwUO3kBGl5V5iJp3?=
 =?us-ascii?Q?5g3/br6owfudf4I3bONll3Q/gJNtja8YvSOZSvmXE6SoYjKov3Ri7PK1VhYY?=
 =?us-ascii?Q?D1bRP4d89CqNj3gEOi/N0vORtFMq4KW4jDZChZ016AwrjmdXHtPZ9yTMOdbY?=
 =?us-ascii?Q?e333FuuLfgJv3LKtXY3j/yivW6Msy+/3IKpGjAP1DLzMwQ4E79CtWckIcS1V?=
 =?us-ascii?Q?BDzjvxU11sE+vOn5WfBRBS4W8+1JfYBADI/D4WUAazB/mHZn0NXkNS+YrN33?=
 =?us-ascii?Q?REQWtqw0lmlyU1Dh58V/BuuHiAKYpfoEj47O2IRuPHP4E8BpbjJAPDsCcpn9?=
 =?us-ascii?Q?uhH4qlXlwiyh6cKiZXWfBoQg0Oln39l6dvDwVhJkijnAd5KSt98ADGNJN7LG?=
 =?us-ascii?Q?CipeBB/bazbajtbdbyEKhXdB+7KK7aW68EmCfSRyr2JQATCMiVD2a407SHkD?=
 =?us-ascii?Q?tMQntJ4ZzJnwlbaPKHUuVhAac6nUEvTEn+JOhXh1GZdLNtiNf52w8IMFA1Vk?=
 =?us-ascii?Q?dHTlP/Cn2PkeXvLZQHIAaHztIC4mtGem+ufjzevQ0sQzrJI7hTxwUXx2KkdV?=
 =?us-ascii?Q?Oacrj2+GSG3TWqZieccOFF7WeQYo4c0qxUhURc0TLzXyAiDjFnstZ8hbLJPb?=
 =?us-ascii?Q?03c1ZonK66TDDSaGTSXxQ8XSckIxRaerQkzvxD4lXcHdXB5vV2ILYtmPbKzB?=
 =?us-ascii?Q?3QsCU7hmrc/ymFc+jUQdF+j/krkFQfCfvjIm3rZJfJkf3wyfO/uCNrieJ4GA?=
 =?us-ascii?Q?LZraVluiTgE10mTsP2c7pv7q5cRSInvDVn3QHk3sydkdiFCRmCOaCwnNN33Y?=
 =?us-ascii?Q?SqDYfCxpjUM+wOHAu/hXozehW6QukYh56CYF8syw5B3AlMIQ5lPpHjmLUSZx?=
 =?us-ascii?Q?6SecuJFmnvNtJEpgGB0T6GAlUjb4EFshX6Tw2h+TOkleuonXHYklr+um2Tjt?=
 =?us-ascii?Q?Ag/GxJsIkEKJuqyvqLtXowXxFnynkh9lTXjG+7DcEdnFaqlqAHOzFw9yPtza?=
 =?us-ascii?Q?Uh9lqPrC3EDkDU8ILS7JYDMn889QCpw7/T5u/ni0ZC6Q1OhvQAfpREzE7lPM?=
 =?us-ascii?Q?8tNJK1TG4a7YcZAWk8axWaA8m4y8K6TPs8sWkKNtPd3LC1Zyrqx8i7F6Ft6o?=
 =?us-ascii?Q?iCQ5xC2wb8W6eIXj5lAas+4JhV//+UkBJf/wId9SfjFAMWQtJaFV9hxQYZQm?=
 =?us-ascii?Q?VjdW9hd8vQj7CK+5puh0pkQ5os3Fsz/3rMkRnxIpeTMp+e3BPbI8nPmfKu3x?=
 =?us-ascii?Q?y1yqvlMKOmStnPM+mThsdWNvzgqSb3PAksa9dY7N/98sEsD1Q5fYMBotmYRf?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed0ab93-3cf1-4c5a-2094-08dab81c8dbb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:10:01.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXxQy/M58T826J3cClr66RjWD2r7kvC9JEjMX/8z4foy6QdBQE+I85KN9cqJ/qvArz4Uhp9GBoxgrHZef4Yh+g==
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

add gpio-ranges property for imx8qxp soc.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
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

