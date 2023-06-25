Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D73F73CFDB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjFYJzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjFYJy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:54:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5949310C4;
        Sun, 25 Jun 2023 02:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkwWDy3wXme5vEthZRzw2BzABoQPln/jh9WPJeIHW4yWuqMxroGYwEueGGAyDWGGoqiM7JVPGAlo7K2KyEmTAmHYUXkchWmSUg6p9qOpYluScl9ldb0qDAdtq3QDX21OwzI85xQLV80gVV87C7Qn2V2F0KveMXUcdXNLduO7PqKbvErvtyeqh5WYUd32SxeYYXrFxAatOlFysWuUml/We1X0isAT9tCzx6k2+hFRR0MShDhEn/sf8e19zZGLQ1ErPrk40C/UrKk0j4VfYMOhEzbG8G/3UYI3PYzHHEAfOxAaKhLL9hvAnz+iwgpCCg3Ln6KG8n8xAZuTshj4WdwaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbmIoFm8sONkYeYQKStBZ0/Jtz8C6dB8d2q+QwxKw60=;
 b=DPWChgc3Z+fU4zkasko1ZsOcWYm1BS3/Sfg8ZMtKsCb5Z51exExQvDlXohvckYqNqd7nDZ6lKNaiFrqgv+cRo/xgvJH+mUxKxDEN0ul1fEmvHA9Ir9ANt/WJLI1fzZFZ5EtBaadMqYRMN9b51UGZvHqX/qqa9AeOeSgYlbeRBDeE26bFxuTGTzB3oIU9KUSxGaL4TyNvEQMuSn6q/S8S//xZOwTwDyJ1zkW1KUmAsncesFg8miZHi22K5hA7SCeL+3E1/eFYHGGNzam6ZZkCuhvdk8e2LYOliUERvCxvAUih/S3YU+xfi3Slu9XczXjfwaygeaiUxVmQu14ZdTUgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbmIoFm8sONkYeYQKStBZ0/Jtz8C6dB8d2q+QwxKw60=;
 b=ATqxLvlHvso+DbJfr/pLPPxTZuobDm+HoM7ahLYQMomj6PAmVePRhYSdLfUimxoJkXYcV3Ls94+zkgFLOITCOGGnFQhF7V3lqKw+5xKGhhParte3tzObRnbS4zlGADqVpLK3tPWLnHsgYKRXs/h2M6pz2Dvb37Ccmz1WrYZ3P/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 09:54:50 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 09:54:50 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 2/4] arm64: dts: imx8ulp: remove "fsl,imx7ulp-lpuart" compatible for i.MX8ULP
Date:   Sun, 25 Jun 2023 17:48:55 +0800
Message-Id: <20230625094857.29644-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230625094857.29644-1-sherry.sun@nxp.com>
References: <20230625094857.29644-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 3401b1db-765e-458f-7801-08db756237cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1sM/W//tyHUt88vUAp1QdZongAmfjM0xWJwmmQd1rkDokS87gnXnZfSYZ+JKURKPOcBTKbAM8YpQqbd0tGAWgKDYqRiPPSPfwGvn8f8rB9f01yLr1WvyGZI0chvyuEdOOwLw2C7Kd7dGx+35ycgFo7V58b9ecXxIY8n+/rt9j8MIYU68AREznF3BnRfqOTqqrSvY6rmTiBmzC6jsLoM3EfoeS9FdsFpF4qkRyJNa9SXN6Qfmw2zfMv48jZoYxsJdUXtU5GYylSZdLKtPI3odqsvIVSXXiu99ctH1Q8rtWYRufTZPvMReX3kOVTmgmXD9cWX4ykqf0I7BkZJm/ApIvEU9nTpYOsW01oaBHYBswieEa2zgOQ3kLAg8W05LRz70YtpGZvozNCDbG2EmBmdvmvu5wP4Ff6IF0GkL8lRDt+BHPj/l51ee+tEoL9V50hPWXvOXUR9f9VYb0ABHG3dawD5IiM5Yt0yhbJvwWtwfsVrEX/GTN5gTvEC3POk3E8KBNMJWqxMcfwIydDWN2rmKI9eFBHMxHQ+mT79kfcDhXCXmXoiL27oPMYMrAW3g6K5u0oKJginFUJws0hBeUN8GCpdrAcinjb6PWeFgt1gHICugUOVf/U7vlmYH4pnonCOjum83n5erLBGWcVHdzaMzPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(26005)(36756003)(5660300002)(7416002)(44832011)(66476007)(8936002)(8676002)(41300700001)(86362001)(316002)(66556008)(4326008)(38350700002)(38100700002)(66946007)(6506007)(1076003)(6512007)(2906002)(6486002)(186003)(52116002)(83380400001)(478600001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sphm2HsO9PB+kFoN5v1GAx+sP0PSJJn2uLwosdLX1NlfIgplhQNhoFzZePqD?=
 =?us-ascii?Q?RvrgAWfwTlXFNooFOUhxXyeSsY4baUudCxbPsSAejR8XoCjHsPS4IyH7HBAi?=
 =?us-ascii?Q?Yn9f3uMHuMg0JrcGiCoBbpp3RxuTuzbYLMubmeOnBnjUOHcKxaSLUwoWhnlk?=
 =?us-ascii?Q?BuxQ0/naIb0HSYdlw2SmO7R+wu9jfo6tQqVhLbADnd3yyfNrMvvDjzmjHvwI?=
 =?us-ascii?Q?Al7dqSTDKWN/fRggWSDS+VTFewuxfkOYttTcGPd+zsDV+hvzGfCUL3uXKxe9?=
 =?us-ascii?Q?//iddfM31NN4tJi4rwEaofVO8NQgXBKYRrdrZhz+X6cUwOg6+BrFXuUFKa02?=
 =?us-ascii?Q?YbK6bhwrzyCdaOWkB8c5hsncC3jPZYzTkdccPXgGFtDwcElH8eBkfxrCM6QH?=
 =?us-ascii?Q?B/cUDjwRkZXM69I53HwCBdl1jxLBvtWW4w5c9Ioe1eFIAy0e//H9WsRwIevH?=
 =?us-ascii?Q?Qaww8fm7pF8v5Io/ftjgTKG76hiXMEUrxdly+WPoRb+07gWct8MBnahBtp8q?=
 =?us-ascii?Q?rDnrhYwQ7mmOqwjeNV4tkuewZ50mbkjd3XMJW+R4GNiNXVgJKodvuHCGBLa6?=
 =?us-ascii?Q?S5NvK/IALa4Ewlg/cGmSkczwujBhBbYj659HG1BOP/OaZGgggqDSwPX+oFiE?=
 =?us-ascii?Q?RcbIZhjUnmqReTutpLixBuszBvWQs6PQClEr7/pCbMXMmP+oaUg8zaF5a51+?=
 =?us-ascii?Q?KJW2hCd8DxbdvidbP4N8ZY5+qMXlESZA97jY+Jq+zOf1ANxldU+R6ZXMLIF6?=
 =?us-ascii?Q?8eteHVvCVHxp/abNH6Fk9LbmIuXcQde0ab3CKD5AuwDlZjcrXe+WIFGj211p?=
 =?us-ascii?Q?pKrB+rKPP0BIe/vLkR+tVaIr6u49BTK+gyI3uojn3lh01y4+3eDc27oE8hKK?=
 =?us-ascii?Q?vNF/4XZ1ZGhmUwstkKQK2cXAVBFRLDsaExXOZpllylXDiuU24ofHMwuzZZuH?=
 =?us-ascii?Q?c87ANvd5gl63ZHEtX9L9tyOB+CVhHZPPMUBp4aj8gXi/F7ySiuEcRizNSEpV?=
 =?us-ascii?Q?2tTUgvIdI28zpsiXtn8Ys/5Hv6CqHirldK+I4oH+TbVy5sUXxyneNuJTdS6i?=
 =?us-ascii?Q?jmd7tMeRC/rdH0G3vcB/09Y3CeAxL8QbtBwXwDDiF9hYsLqpaPnjR0GnQrjw?=
 =?us-ascii?Q?tLm06sO/ywMMXoOBv8t5KoO8BVtmjji3vCFOB66zZtEfMn95NBSqfJWxdmIi?=
 =?us-ascii?Q?BkG64TSZr/fiCMejHPJ6+YGKzjlq6g1Qy8Ekpn0O8yirtlvsgaFpSA0WaG7f?=
 =?us-ascii?Q?dzq770hEBbZB0Q1bmQi4JpGongwinVosro3ckOELz+xhpsUrjO75lV2WKwuK?=
 =?us-ascii?Q?mmWHgKN710IKtlDuWCGpxnT8pi+MGm8OQzv0RX/BwD8BF2BLLXBtfPqpZ/a5?=
 =?us-ascii?Q?zLXoGm253XmBf8UAoyw0Pm/2qwF42npJqPKyEk6NoAcT3F3/2IUa3kJmt4KL?=
 =?us-ascii?Q?ZYecHd8E4Z1MfmYFnsKUDlzgDh2fGeKEPGrv4idnEIr4bApJcMLTXlAShkQn?=
 =?us-ascii?Q?PLawKhObyMqqavlCdx+FAL5RJ/bWYmXzQRHP24RH9hHqYJsp/YUSTuQOeKAv?=
 =?us-ascii?Q?KaGlXdrFEu/Yr6IKV7hNHiMYjgY/yecP24jsm95+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3401b1db-765e-458f-7801-08db756237cc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 09:54:50.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLZJo22AS0GRqK1cGvqTUYpLiM1ljluX23n0kXNRt1crIqoFE3Adg2lt4CCZhxCepDWO6lCNU3fZDgTT+KnOgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8ULP has specific "fsl,imx8ulp-lpuart" compatible in lpuart driver,
"fsl,imx7ulp-lpuart" compatible is no longer needed, and i.MX8ULP is not
fully compatible with i.MX7ULP, for example, i.MX8ulp can support
EOP(end-of-packet) function while i.MX7ulp doesn't, so remove
"fsl,imx7ulp-lpuart" compatible.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 57627bdaa851..e900f5b25694 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -245,7 +245,7 @@
 			};
 
 			lpuart4: serial@29390000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx8ulp-lpuart";
 				reg = <0x29390000 0x1000>;
 				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&pcc3 IMX8ULP_CLK_LPUART4>;
@@ -254,7 +254,7 @@
 			};
 
 			lpuart5: serial@293a0000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx8ulp-lpuart";
 				reg = <0x293a0000 0x1000>;
 				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&pcc3 IMX8ULP_CLK_LPUART5>;
@@ -334,7 +334,7 @@
 			};
 
 			lpuart6: serial@29860000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx8ulp-lpuart";
 				reg = <0x29860000 0x1000>;
 				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&pcc4 IMX8ULP_CLK_LPUART6>;
@@ -343,7 +343,7 @@
 			};
 
 			lpuart7: serial@29870000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx8ulp-lpuart";
 				reg = <0x29870000 0x1000>;
 				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&pcc4 IMX8ULP_CLK_LPUART7>;
-- 
2.17.1

