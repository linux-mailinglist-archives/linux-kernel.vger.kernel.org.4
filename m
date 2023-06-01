Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F663719092
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjFACiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjFACio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:38:44 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7723FE7;
        Wed, 31 May 2023 19:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH7/vtoDnc4K0wPaaFXm69EF0E1y70frKWOea5kxrsRXnjV+lUzGjBmTGj3vwZCtO9/51iO95JyRkldtbtC94vlWUrzunk76qqETpcqHl2uUNyCRra6QD/TiYal4A7pR7uamox0dHbP6gwDgp3oMW6HD9kxC1uS2NhgkPHhw6kqwdsHmFDfFrQCfQtqKVkJUcxbbOWF0BZ9c7O9KnLZFJ5MFCRDH/cQxQ0etBeCLbMqnRCWN4jZpVxDH8KM1jv9r8uiGNk/j6TOL3jxE+AAJHtJADibCviXJ1vce4Puh+BFnd6J63KNsVky9HVqrKJIw+t2rJW1XqL6TB0ok6TRvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bEuT3Akp62ZfYHy6luVNNKX9T0bttqvL2nGd1nvaRw=;
 b=EpX2jmpsAClGZOBq97RRTwBlGh3Zkd4P4noFXxygiY+XQ2SdRShnoxJkX2QShAndlqaIDCpi0ZfO9HsJX19b4woV5NaCH8LyNxmqFYp/TplYHoXXgRk+teHDeSRZpY02D+NqBOnWK4ik+YqqsetkeSbEHcqpqc5tcJkUd9r0OEVnxmW34/cFFZf4+hDUuO8s8aD8cFEekbCHtmu6haKEc+OwHec2sAdW+8zaiAn8XfN8mO/B9QqOqW0GGKjJJ3s3dIHZ/6h+K0AWjUTkSKbMjQxrq+D0wnWvVu5Euec2kupEyOAY/JgMZmetaYuEbnR88waz225lyugJg7Zk3BeC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bEuT3Akp62ZfYHy6luVNNKX9T0bttqvL2nGd1nvaRw=;
 b=TK4IbMcsLtqKu1puxCPhvcUaVW5Uqi1OKtB+zAooygTVornZ99JNsLKdFGafw/XT8RoFn0iyvR3MFPWvrN9Bi8G5np3BcqGmy15SFAvrnZFvUREh1I/hsbTzPr06OHtobVu96WX/Db84R/4p++P92TvIHT6xOqgyeP0AhBWLLuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7409.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 02:38:39 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::79f2:2888:dbd7:ad6f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::79f2:2888:dbd7:ad6f%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:38:39 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     shawnguo@kernel.org, mirela.rabulea@oss.nxp.com
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8-ss-img: Assign slot for imx jpeg encoder/decoder
Date:   Thu,  1 Jun 2023 10:38:01 +0800
Message-Id: <20230601023801.25229-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM8PR04MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a8fb68-e6f1-428e-abd2-08db62494e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8b4/N8AbNzPgJ90e67HDhWfn//Np4r34bIn91f+SzjTzktMOtWYrpVIb2xFB1k+6xwypIznBVHi9MPHxwZBBZhg8nDOENrXrQsfws6ZOHP1ix0XD5OKGZQbJnqYgq2UyPuUsxbPuBLhCqKwmF4CR7Q4HA95sTtsyDPACBClt91hl//5QqGzMLKGMwDhafJHYa0lzVY8UgmU6Bt+GEq3V1AFyYdgB9tpMvUpdB0y5FvEoRUJapssbf4zm5KlF/T5XmaArmMatSp9AJLfrHESMnNWXbrfmthvGYBlbqKzO3ZkyTtDxl9sL1HEmHY/6pDFfiUhJha5nU0F2fXJ/69EorjtL32gz2pzbVn4FNH2ITS0M6UI+sVIXdfLF7qrZwffaGxQnwE3c+A/rfl3988s2c8QcSX+6J+TJt3MRe/eQ1MHb1+V800b9zzqXDFMkQprDtS0E/75DeLaA5DRZqhpjyRFp6neTop0DIC/faKC+VdhkU2bK+g19nsDnTMw/jE84jiR4RR/CZeAePBu6ixQw6EpKZkJ5Nje+IoMJbyakqz0W5BsogrJxCkyJI6po+6k7lcIncFVTwJegkdc4ukeO25qQ08cLn6HA2Dm8GZgXsCL0tnn/o7g8tDDCkorvNMST
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(478600001)(6666004)(83380400001)(44832011)(66556008)(66946007)(4326008)(66476007)(316002)(2616005)(1076003)(26005)(6506007)(6512007)(8936002)(8676002)(5660300002)(2906002)(41300700001)(186003)(38350700002)(38100700002)(36756003)(86362001)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARVedSWJK7WTQlmJmaGR16m0qvyv6OlpnlOF0X53b0/BqKZxvpg1DzFaGDJr?=
 =?us-ascii?Q?lTGqsZ2DOaRMY2cVZ/9PQe5vuiOCXOWalPTwkmIMSRKPySIbSjYZvJwRW1kC?=
 =?us-ascii?Q?JeWTSBFleh3810f8lEgL5CWFkg8il1Kr8avnRW2JaMqesRpRwjuKM450iJXE?=
 =?us-ascii?Q?KCffAxtM0tmflsf29PHc9uWqFfMIoz8+mVaybT3sucXf1x82s6UMGvXtaD9h?=
 =?us-ascii?Q?i1yJH31pcq2IquT0l53QsePXZkxt0HzA22TG+9APxJeX8E0W86IBe7HTDAwO?=
 =?us-ascii?Q?9QhSl71tOzlfXEvb0vvVuIujTpYQoOxN6oIWt4GKpxKYFiq24SRKODMSYlj/?=
 =?us-ascii?Q?WskMDXCcdYivGZZif/U1xDjvTBGd95VxURDnsTwfTrQFggSIsbJ01Op/yLyY?=
 =?us-ascii?Q?hnAR1VhNSm2mjBQAPFJxgfvoEQ+s1s1h0YaUUBGFBMQOku3JRF7h7YE1aGLP?=
 =?us-ascii?Q?mFk1QzUMjARr/3c5iCtDGC8/xPsZ0gCpZiDMHQHsFNkCNGRw3hcl97xM6/A4?=
 =?us-ascii?Q?KfTuwudoAd8/3lrFLVW61+vKGDmypIYYFipKKRdDg+18NaJoEfKptzfuWcSt?=
 =?us-ascii?Q?TvQBKtMUrZoVtPbLqYBJhdzbwwP6kjiH2YGTRMrq9nQTPZn+Jx9ZOYk9NG04?=
 =?us-ascii?Q?umNKE1EJR4I2gZxljZYA/fX2rO+MmxtKf0R0jEhOpg5BMOkMOcXezROvxOcc?=
 =?us-ascii?Q?NL1FPo/5i25mP1s0MttluEf/tXITPMTLZPV7W8rqhxB8IL6YkePI+E1gXj95?=
 =?us-ascii?Q?KnVjcqKkMq+ymfBr8hdQ1x5D89GZydiHcK3sB7ZxmEJqNKaGzjp1uLZW3ZOf?=
 =?us-ascii?Q?kuTzWFsfUznexPC789wFJ0HKhlSXO1X7ELUHDnogK+EByxWbHz4EzIjb4Iyt?=
 =?us-ascii?Q?PDCVYTJ/LjzEdRC3+CA1jni3ptqoPNwrRH7mbNVzfDbhv5H0At8kJ/6YVa51?=
 =?us-ascii?Q?wYTICWyDOLub+sBX65Q7EvVBMFAKx7L6Ut69hW3Tba8P8GPIr4GugIBMKMGa?=
 =?us-ascii?Q?UsNJq0KqrGu4GkOeTgT3NMKzbDshneI00reON2/SThxyVCY3ogGyfV6zETL4?=
 =?us-ascii?Q?c0bul44BXbVH2dcFsHtYXxNefOIfrwJY3BwiIy5BbV5u5dAYhzuGV7jBLWfy?=
 =?us-ascii?Q?6GzxLAj1qw9fgZDpc4cJJazJ3F/RqR4sTkaOBH6eTZ8+7YBZT4Qn1mnfWMQt?=
 =?us-ascii?Q?KIllPepuk5V1en14jzL0gxGOmcbyS8Y4+IrZOiZi5r392+TWHBOqP2sscmyv?=
 =?us-ascii?Q?A2egFlvGErR/IF7kKcZups1hBctobGyKi7SY0vG30vw9AM1oEFlV73za25Lc?=
 =?us-ascii?Q?E+1go76QWw8zytTpU4HS/vi9eKXZjBI5Si7gsGoFUVcZP8ZPCOyRdYuXppSs?=
 =?us-ascii?Q?qATv9/RNMi5TYXwfEWKsIN3VmL8dR1lR+tyWE+m+IeF+CR4Vh2FNMTlR3t0Y?=
 =?us-ascii?Q?3r3ik8RUq7KZKEvdT4BkilFy69XsZxhPG/5BfVHEKhXDjovzW1D3D+7vFK4c?=
 =?us-ascii?Q?0jw1RNwASvTpWebXYWxi8KutBqXPj+b3gP6tTHwiFQ3UvsPrQF3WBKMojCwv?=
 =?us-ascii?Q?9d6A8abIJL1aCWTcV6zPsXOXXUQk+T4XFLqqxDxv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a8fb68-e6f1-428e-abd2-08db62494e81
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:38:39.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VgSVPYowqxllljrsR+6aBCmiGkqUy/w9bmIXU5RsW4K70Hp/wC98r2WTqcmV4xiKP9Qs7jC427f8Qm3vkvmdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

assign a single slot,
configure interrupt and power domain only for 1 slot,
not for the all 4 slots.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-img.dtsi | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
index a90654155a88..176dcce24b64 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
@@ -18,10 +18,7 @@ img_ipg_clk: clock-img-ipg {
 
 	jpegdec: jpegdec@58400000 {
 		reg = <0x58400000 0x00050000>;
-		interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&img_jpeg_dec_lpcg IMX_LPCG_CLK_0>,
 			 <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
@@ -29,18 +26,13 @@ jpegdec: jpegdec@58400000 {
 				  <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_DEC_MP>,
-				<&pd IMX_SC_R_MJPEG_DEC_S0>,
-				<&pd IMX_SC_R_MJPEG_DEC_S1>,
-				<&pd IMX_SC_R_MJPEG_DEC_S2>,
-				<&pd IMX_SC_R_MJPEG_DEC_S3>;
+				<&pd IMX_SC_R_MJPEG_DEC_S0>;
+		slot = <0>;
 	};
 
 	jpegenc: jpegenc@58450000 {
 		reg = <0x58450000 0x00050000>;
-		interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&img_jpeg_enc_lpcg IMX_LPCG_CLK_0>,
 			 <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
@@ -48,10 +40,8 @@ jpegenc: jpegenc@58450000 {
 				  <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_ENC_MP>,
-				<&pd IMX_SC_R_MJPEG_ENC_S0>,
-				<&pd IMX_SC_R_MJPEG_ENC_S1>,
-				<&pd IMX_SC_R_MJPEG_ENC_S2>,
-				<&pd IMX_SC_R_MJPEG_ENC_S3>;
+				<&pd IMX_SC_R_MJPEG_ENC_S0>;
+		slot = <0>;
 	};
 
 	img_jpeg_dec_lpcg: clock-controller@585d0000 {
-- 
2.38.1

