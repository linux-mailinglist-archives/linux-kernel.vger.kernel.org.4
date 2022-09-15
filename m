Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9215BA0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiIOSUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiIOSTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:19:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E1F9F742;
        Thu, 15 Sep 2022 11:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNRh1IVFVazCMfV7bXAzuMleDMVL+/GLD+j2gFji7yn79rhXrBLwx87SPHsNfkvXIG3Vt7eV8FqNWqeJtf4o4dPkGv9HdebEI9ZOJLONBdnQr40C58ZzGaNWoXs4bzqmrTzSHH7OGrIDboelYUkbZvXumLZ3dPB5F311R0/OB9j99xN5hP+o0lgbJ/Vr8KyOlA0STjOiMc692TeoO4w8KomIMYKT8P7elcML/eolnURoRwNzWNjjFWnwjN2FATEDH1UV44bHsG2BjHW4gynq0bbM+Hubug0qzPJGxG5RsoHqEpFtvdFsPgiRLEz8uusA38d5oRillm2t7f0ZWv0TZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaZXJpEyELm8pLg34lLj5UzkkaZIlOLxwPtdaQbqTYI=;
 b=YkC60E46qSfsS0yLqSf+qj6iSrKmOb/Mh23k1j56uyDCe87hJVNqIOuvfJBHIyNcnMmhDItNFFNAsMX56Zloti0byfV+ieIgWc/D7tLbLnw+2Ekh5R205o1KoSPRn1cB0SWrLXzJ4DgtyizrEDXbhuEsPxoHnplOggMHV8usqUAo+e3t4RuSvh9qd6KNh+c/GOtJOpt368801LYr3BirW/pDfBIej01GZ4rW1R7aPlX6IkC1BVJkz9xKTENDgyHj5quJeMUoDmI8FrYmLLogFdc3vuQ84x/pGyipmCtWBP6JJg86RW3zmGBa52JjIN0eu9N9pZM1YVf2DO75iIf6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaZXJpEyELm8pLg34lLj5UzkkaZIlOLxwPtdaQbqTYI=;
 b=CDRIGnEdWs0SuxHFhttjuwEmw0cLnpHooJc2/qVqMZSlnz+3OAXEE2IG8jsl0JOYFgnAtwcJJTHKWhS+pSax/ArwyRNnHu4jRtu88cUUZ/HOy/yrbZsDpAoDPJCRYcj3V0ioB8v+yauX/m1zw5wlTC+LglKJp0PhQYf40QWtMkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PA4PR04MB7998.eurprd04.prod.outlook.com (2603:10a6:102:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 18:19:00 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 18:19:00 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viorel Suman <viorel.suman@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
Date:   Thu, 15 Sep 2022 21:18:04 +0300
Message-Id: <20220915181805.424670-2-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915181805.424670-1-viorel.suman@oss.nxp.com>
References: <20220915181805.424670-1-viorel.suman@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|PA4PR04MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 170d96f5-e86e-423b-f4e3-08da9746c2c4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDjVisOeH9nIswKuOOHTezm2a4EA4HmsQSgeNTujsRDpHPZFSjEhofnPbwpIFhLrNvg9wc2D4o/H8hHcMVaG2KsYBYmB7OPTyqbhGHtxU7q/9QwZxsfhuN88dnSCfwXu1YiWmjTg+Ns5rUmQ19eCFaQWJ8BaAY+h4MFhvtJPdNACxQ2aM3CY7SMbC2lpoiSot1blkuGIKPffIkSzaSEhDkB/k+9QEVpHlW4ANJxZBt+E5JnODKeSH8Y0zXQRWKcS6pcNfU7jdbfiiOlF8Heiic6e4GoR/ASFvMbOd6XPXrKR62rtYHV2J4BjYZ8AFwZ3OaLh1nqZTHGd04EsirroArqzNPiBxwTTsdDuUQx8ecLVTcPGctCeYfnr/YflSK/i3E6bImzTTmbBeTDWFu4xZoX9+HI7JRIl7k22zbOnCR4U7Rr1+zD1ry7jBE+fLGirzmr0F7Pc7xFeFzqXVDIwbN2Eh1zUQ6c6JERVbO9RsFKpzgea5sIZ+f606vlvOvdZgJj1pZjLo1WGmtBOan9hEAib/VUpYYW1uPyQ46mM2EPfAeQKBWKboKudEENgi3mtXYftCiXYcCXTM18xuPPCMX2yrqngjU1PGe7AJ7dXNIBzt2eLgMKpFCB3lUPTSAPjSHiJybAmMuZQQ8z+7fBxep3oLCJxw8ibVW6u2NTOxEGZEGgp6+ovI6FhGLABa/rmkKhllvou2vPdPO7JAkG9k9TbbI2bhcDYH4a4/MRfi65AD2Mu4pW/9C9NW6TYZtnRoq31Tm1lESt/1aUmohc4AncSue4vtmo1H8BQWuKSL44NtsHXTy1iJ68X1vdKKgHB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199015)(30864003)(5660300002)(8936002)(2616005)(8676002)(966005)(2906002)(921005)(316002)(66946007)(110136005)(41300700001)(6512007)(86362001)(66556008)(38350700002)(6486002)(66476007)(1076003)(6506007)(38100700002)(83380400001)(52116002)(186003)(26005)(478600001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3bPqNsxqxeIY19QFS1rMgP+xXnbMdKvAmqJK20A8y9mj+cFppD7accjG4T8v?=
 =?us-ascii?Q?R5vOQypQaeF4HsYg83CzNkEco5JYVQ/vZcMnV9dsnF39LB+Vzv5pIsoZ0nwQ?=
 =?us-ascii?Q?VbfNdy0BcyBUQN2OZHYXAk8dp3o/6OJCR3PnQZ8gcdP13ZTfRmEJVH/bpQR9?=
 =?us-ascii?Q?/3FxoOZ/+3f08iew/oqwX9vxJbz+nuGAqUkWSFgjtpvOsU0/ITJZaweWlpfL?=
 =?us-ascii?Q?v9zK4ZyKx/0lP68Q38VjuyGQqANELkwk+BsvFWiu7kJsud36xS8FowjwHDUz?=
 =?us-ascii?Q?/CuzKrBNqbK/2GAOu1G+ewt/jwY9PTVsom8MTvs+4jD25yIg12QO4r4UyWeJ?=
 =?us-ascii?Q?VxiLq3o1msKVj1QhRdtKQ+aAMTxo4bQlUi1m5Vb0bObM3KLh2pEl0a5SBRJP?=
 =?us-ascii?Q?DyzPqVnevA+PTP53k00THW1bi75rl8iwG6WPxGK8UCniaBCfkBgkgcI2i/iJ?=
 =?us-ascii?Q?0EeGpk/J4uI/ucoPyGVd5IdnWWmihJ6OsIE61rKXeaUSLrhQ1mhSPCf47zi8?=
 =?us-ascii?Q?fqJ25GUIR8KBjwXogYMaeH8yVd4+/YPP5VeyZXPjiXk1AOUFVrBBzh4xb4sS?=
 =?us-ascii?Q?js4y4xA/iCq9Ao7xtKfViPOqXrRzrjEysAq51xLD7e41QRaolp6wZdiEzne6?=
 =?us-ascii?Q?abxy6U0DIthC1SGQ8vcDJE3gbvl7Xs00lbIj0+Nez1ucmx+AyeEYX6B7+ijV?=
 =?us-ascii?Q?5ZD7N/4yEHWexQfgI9hfYHwJpNAq7Xwhee6AjF/V4Y1w9UZKI3Vby0OgFDoE?=
 =?us-ascii?Q?XhA2ORCeGkL/CxwTZ80aS3pbjaBv/VcZynjFLdda+Sfv8F1N8XmlYs8/Qh3G?=
 =?us-ascii?Q?FIXZQZs3f3kGUWX+g3HCnGYoNMrs3B1Oev2Ge5VYywkuz8atLGUuCuDqYX2i?=
 =?us-ascii?Q?i8ze+/cWxlESWvvmHYA/D+HtA6XMmGJiLL/Omnk9Ad5QhtwDKYyGirYOlmqV?=
 =?us-ascii?Q?LOyTg3NtBDoHal5Wlgi7odYujMpP93Nt/YJjdGbepwxsB6P3vUcWLZGL/Iv9?=
 =?us-ascii?Q?HGtpTidPVcwQI5GijgfSSCDBVZL4lIv7T/bAXB8HbEt+7wu1kggKISctQg4k?=
 =?us-ascii?Q?a95lS2+OM8YaBcn2sEYVq75D+eK1WmL5RCpMQ5J+/6j4MMEaKjquz95zIh/5?=
 =?us-ascii?Q?Tnti6xsUTPybxlxevkMcXYengI/m7TLEiCPGLMOZt4KEEmgVuo8Yd2zWVhP3?=
 =?us-ascii?Q?G51kOWrPmuDXhj/lTG5sSwAvCOrPFnpM9xo/21UUMu0e+nZArQfikuDdq6Fe?=
 =?us-ascii?Q?7dPuPogaHXcPwGwo+fmwZ90K8TMNSRgeVRuXm6oI2Ilc/Fwrxl4o/56eYWl6?=
 =?us-ascii?Q?WvYqbElyWQdrofFxgDrcpmBhjSni8ae1Gmmloensdrpf4HcvDej/RlHmcTfQ?=
 =?us-ascii?Q?EMOl4NRQoGMMf1AdBqSZMZ3HQPGsUX1zH3dam342nD6hpnbVhXejSlx3lOwZ?=
 =?us-ascii?Q?qxxgoUkUHtig4L9U6JQvUVeW8XApxNZlVwB36EDVhWbBBt/ZwP3li2lsN7ic?=
 =?us-ascii?Q?4YS8TIAElfTTWetf1/w8giDKEz7ajSwpsjLTbiF91J7pThjtYjiW+5WUru8g?=
 =?us-ascii?Q?7rwE3Ynz2EWAZeI2XQ9HcwYCN+jIeDq8CWNgvtHt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170d96f5-e86e-423b-f4e3-08da9746c2c4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 18:18:59.9882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69Pt7M8ph7UgH1TVAQOxlR1FXOrhxOMUbZLAg4EL18Vz/jFUWHDYJN/+EcJ4nW7vSpgUeAjgTqzvsAnnLXXb/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7998
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Sync defines with the latest available SCFW kit version 1.13.0,
may be found at the address below:

https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 include/dt-bindings/firmware/imx/rsrc.h | 299 ++++++++++++++++--------
 1 file changed, 203 insertions(+), 96 deletions(-)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 43885056557c..a4c68f394986 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -13,34 +13,38 @@
  * never be changed or removed (only added to at the end of the list).
  */
 
-#define IMX_SC_R_A53			0
-#define IMX_SC_R_A53_0			1
-#define IMX_SC_R_A53_1			2
-#define IMX_SC_R_A53_2			3
-#define IMX_SC_R_A53_3			4
-#define IMX_SC_R_A72			5
-#define IMX_SC_R_A72_0			6
-#define IMX_SC_R_A72_1			7
-#define IMX_SC_R_A72_2			8
-#define IMX_SC_R_A72_3			9
+#define IMX_SC_R_AP_0			0
+#define IMX_SC_R_AP_0_0			1
+#define IMX_SC_R_AP_0_1			2
+#define IMX_SC_R_AP_0_2			3
+#define IMX_SC_R_AP_0_3			4
+#define IMX_SC_R_AP_1			5
+#define IMX_SC_R_AP_1_0			6
+#define IMX_SC_R_AP_1_1			7
+#define IMX_SC_R_AP_1_2			8
+#define IMX_SC_R_AP_1_3			9
 #define IMX_SC_R_CCI			10
 #define IMX_SC_R_DB			11
 #define IMX_SC_R_DRC_0			12
 #define IMX_SC_R_DRC_1			13
 #define IMX_SC_R_GIC_SMMU		14
-#define IMX_SC_R_IRQSTR_M4_0		15
-#define IMX_SC_R_IRQSTR_M4_1		16
-#define IMX_SC_R_SMMU			17
-#define IMX_SC_R_GIC			18
+#define IMX_SC_R_IRQSTR_MCU_0		15
+#define IMX_SC_R_IRQSTR_MCU_1		16
+#define IMX_SC_R_SMMU_0			17
+#define IMX_SC_R_GIC_0			18
 #define IMX_SC_R_DC_0_BLIT0		19
 #define IMX_SC_R_DC_0_BLIT1		20
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
-#define IMX_SC_R_PERF			23
+#define IMX_SC_R_PERF_0			23
+#define IMX_SC_R_USB_1_PHY		24
 #define IMX_SC_R_DC_0_WARP		25
+#define IMX_SC_R_V2X_MU_0		26
+#define IMX_SC_R_V2X_MU_1		27
 #define IMX_SC_R_DC_0_VIDEO0		28
 #define IMX_SC_R_DC_0_VIDEO1		29
 #define IMX_SC_R_DC_0_FRAC0		30
+#define IMX_SC_R_V2X_MU_2		31
 #define IMX_SC_R_DC_0			32
 #define IMX_SC_R_GPU_2_PID0		33
 #define IMX_SC_R_DC_0_PLL_0		34
@@ -49,11 +53,17 @@
 #define IMX_SC_R_DC_1_BLIT1		37
 #define IMX_SC_R_DC_1_BLIT2		38
 #define IMX_SC_R_DC_1_BLIT_OUT		39
+#define IMX_SC_R_V2X_MU_3		40
+#define IMX_SC_R_V2X_MU_4		41
 #define IMX_SC_R_DC_1_WARP		42
+#define IMX_SC_R_STM			43
+#define IMX_SC_R_SECVIO			44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
+#define IMX_SC_R_V2X			48
 #define IMX_SC_R_DC_1			49
+#define IMX_SC_R_UNUSED14		50
 #define IMX_SC_R_DC_1_PLL_0		51
 #define IMX_SC_R_DC_1_PLL_1		52
 #define IMX_SC_R_SPI_0			53
@@ -144,10 +154,10 @@
 #define IMX_SC_R_DMA_1_CH29		137
 #define IMX_SC_R_DMA_1_CH30		138
 #define IMX_SC_R_DMA_1_CH31		139
-#define IMX_SC_R_UNUSED1		140
-#define IMX_SC_R_UNUSED2		141
-#define IMX_SC_R_UNUSED3		142
-#define IMX_SC_R_UNUSED4		143
+#define IMX_SC_R_V2X_PID0		140
+#define IMX_SC_R_V2X_PID1		141
+#define IMX_SC_R_V2X_PID2		142
+#define IMX_SC_R_V2X_PID3		143
 #define IMX_SC_R_GPU_0_PID0		144
 #define IMX_SC_R_GPU_0_PID1		145
 #define IMX_SC_R_GPU_0_PID2		146
@@ -176,7 +186,7 @@
 #define IMX_SC_R_PCIE_B			169
 #define IMX_SC_R_SATA_0			170
 #define IMX_SC_R_SERDES_1		171
-#define IMX_SC_R_HSIO_GPIO		172
+#define IMX_SC_R_HSIO_GPIO_0		172
 #define IMX_SC_R_MATCH_15		173
 #define IMX_SC_R_MATCH_16		174
 #define IMX_SC_R_MATCH_17		175
@@ -243,15 +253,15 @@
 #define IMX_SC_R_ROM_0			236
 #define IMX_SC_R_FSPI_0			237
 #define IMX_SC_R_FSPI_1			238
-#define IMX_SC_R_IEE			239
-#define IMX_SC_R_IEE_R0			240
-#define IMX_SC_R_IEE_R1			241
-#define IMX_SC_R_IEE_R2			242
-#define IMX_SC_R_IEE_R3			243
-#define IMX_SC_R_IEE_R4			244
-#define IMX_SC_R_IEE_R5			245
-#define IMX_SC_R_IEE_R6			246
-#define IMX_SC_R_IEE_R7			247
+#define IMX_SC_R_IEE_0			239
+#define IMX_SC_R_IEE_0_R0		240
+#define IMX_SC_R_IEE_0_R1		241
+#define IMX_SC_R_IEE_0_R2		242
+#define IMX_SC_R_IEE_0_R3		243
+#define IMX_SC_R_IEE_0_R4		244
+#define IMX_SC_R_IEE_0_R5		245
+#define IMX_SC_R_IEE_0_R6		246
+#define IMX_SC_R_IEE_0_R7		247
 #define IMX_SC_R_SDHC_0			248
 #define IMX_SC_R_SDHC_1			249
 #define IMX_SC_R_SDHC_2			250
@@ -282,46 +292,50 @@
 #define IMX_SC_R_LVDS_2_PWM_0		275
 #define IMX_SC_R_LVDS_2_I2C_0		276
 #define IMX_SC_R_LVDS_2_I2C_1		277
-#define IMX_SC_R_M4_0_PID0		278
-#define IMX_SC_R_M4_0_PID1		279
-#define IMX_SC_R_M4_0_PID2		280
-#define IMX_SC_R_M4_0_PID3		281
-#define IMX_SC_R_M4_0_PID4		282
-#define IMX_SC_R_M4_0_RGPIO		283
-#define IMX_SC_R_M4_0_SEMA42		284
-#define IMX_SC_R_M4_0_TPM		285
-#define IMX_SC_R_M4_0_PIT		286
-#define IMX_SC_R_M4_0_UART		287
-#define IMX_SC_R_M4_0_I2C		288
-#define IMX_SC_R_M4_0_INTMUX		289
-#define IMX_SC_R_M4_0_MU_0B		292
-#define IMX_SC_R_M4_0_MU_0A0		293
-#define IMX_SC_R_M4_0_MU_0A1		294
-#define IMX_SC_R_M4_0_MU_0A2		295
-#define IMX_SC_R_M4_0_MU_0A3		296
-#define IMX_SC_R_M4_0_MU_1A		297
-#define IMX_SC_R_M4_1_PID0		298
-#define IMX_SC_R_M4_1_PID1		299
-#define IMX_SC_R_M4_1_PID2		300
-#define IMX_SC_R_M4_1_PID3		301
-#define IMX_SC_R_M4_1_PID4		302
-#define IMX_SC_R_M4_1_RGPIO		303
-#define IMX_SC_R_M4_1_SEMA42		304
-#define IMX_SC_R_M4_1_TPM		305
-#define IMX_SC_R_M4_1_PIT		306
-#define IMX_SC_R_M4_1_UART		307
-#define IMX_SC_R_M4_1_I2C		308
-#define IMX_SC_R_M4_1_INTMUX		309
-#define IMX_SC_R_M4_1_MU_0B		312
-#define IMX_SC_R_M4_1_MU_0A0		313
-#define IMX_SC_R_M4_1_MU_0A1		314
-#define IMX_SC_R_M4_1_MU_0A2		315
-#define IMX_SC_R_M4_1_MU_0A3		316
-#define IMX_SC_R_M4_1_MU_1A		317
+#define IMX_SC_R_MCU_0_PID0		278
+#define IMX_SC_R_MCU_0_PID1		279
+#define IMX_SC_R_MCU_0_PID2		280
+#define IMX_SC_R_MCU_0_PID3		281
+#define IMX_SC_R_MCU_0_PID4		282
+#define IMX_SC_R_MCU_0_RGPIO		283
+#define IMX_SC_R_MCU_0_SEMA42		284
+#define IMX_SC_R_MCU_0_TPM		285
+#define IMX_SC_R_MCU_0_PIT		286
+#define IMX_SC_R_MCU_0_UART		287
+#define IMX_SC_R_MCU_0_I2C		288
+#define IMX_SC_R_MCU_0_INTMUX		289
+#define IMX_SC_R_ENET_0_A0		290
+#define IMX_SC_R_ENET_0_A1		291
+#define IMX_SC_R_MCU_0_MU_0B		292
+#define IMX_SC_R_MCU_0_MU_0A0		293
+#define IMX_SC_R_MCU_0_MU_0A1		294
+#define IMX_SC_R_MCU_0_MU_0A2		295
+#define IMX_SC_R_MCU_0_MU_0A3		296
+#define IMX_SC_R_MCU_0_MU_1A		297
+#define IMX_SC_R_MCU_1_PID0		298
+#define IMX_SC_R_MCU_1_PID1		299
+#define IMX_SC_R_MCU_1_PID2		300
+#define IMX_SC_R_MCU_1_PID3		301
+#define IMX_SC_R_MCU_1_PID4		302
+#define IMX_SC_R_MCU_1_RGPIO		303
+#define IMX_SC_R_MCU_1_SEMA42		304
+#define IMX_SC_R_MCU_1_TPM		305
+#define IMX_SC_R_MCU_1_PIT		306
+#define IMX_SC_R_MCU_1_UART		307
+#define IMX_SC_R_MCU_1_I2C		308
+#define IMX_SC_R_MCU_1_INTMUX		309
+#define IMX_SC_R_UNUSED17		310
+#define IMX_SC_R_UNUSED18		311
+#define IMX_SC_R_MCU_1_MU_0B		312
+#define IMX_SC_R_MCU_1_MU_0A0		313
+#define IMX_SC_R_MCU_1_MU_0A1		314
+#define IMX_SC_R_MCU_1_MU_0A2		315
+#define IMX_SC_R_MCU_1_MU_0A3		316
+#define IMX_SC_R_MCU_1_MU_1A		317
 #define IMX_SC_R_SAI_0			318
 #define IMX_SC_R_SAI_1			319
 #define IMX_SC_R_SAI_2			320
-#define IMX_SC_R_IRQSTR_SCU2		321
+#define IMX_SC_R_IRQSTR_AP_0		321
 #define IMX_SC_R_IRQSTR_DSP		322
 #define IMX_SC_R_ELCDIF_PLL		323
 #define IMX_SC_R_OCRAM			324
@@ -366,33 +380,33 @@
 #define IMX_SC_R_VPU_PID5		363
 #define IMX_SC_R_VPU_PID6		364
 #define IMX_SC_R_VPU_PID7		365
-#define IMX_SC_R_VPU_UART		366
-#define IMX_SC_R_VPUCORE		367
-#define IMX_SC_R_VPUCORE_0		368
-#define IMX_SC_R_VPUCORE_1		369
-#define IMX_SC_R_VPUCORE_2		370
-#define IMX_SC_R_VPUCORE_3		371
+#define IMX_SC_R_ENET_0_A2		366
+#define IMX_SC_R_ENET_1_A0		367
+#define IMX_SC_R_ENET_1_A1		368
+#define IMX_SC_R_ENET_1_A2		369
+#define IMX_SC_R_ENET_1_A3		370
+#define IMX_SC_R_ENET_1_A4		371
 #define IMX_SC_R_DMA_4_CH0		372
 #define IMX_SC_R_DMA_4_CH1		373
 #define IMX_SC_R_DMA_4_CH2		374
 #define IMX_SC_R_DMA_4_CH3		375
 #define IMX_SC_R_DMA_4_CH4		376
-#define IMX_SC_R_ISI_CH0		377
-#define IMX_SC_R_ISI_CH1		378
-#define IMX_SC_R_ISI_CH2		379
-#define IMX_SC_R_ISI_CH3		380
-#define IMX_SC_R_ISI_CH4		381
-#define IMX_SC_R_ISI_CH5		382
-#define IMX_SC_R_ISI_CH6		383
-#define IMX_SC_R_ISI_CH7		384
-#define IMX_SC_R_MJPEG_DEC_S0		385
-#define IMX_SC_R_MJPEG_DEC_S1		386
-#define IMX_SC_R_MJPEG_DEC_S2		387
-#define IMX_SC_R_MJPEG_DEC_S3		388
-#define IMX_SC_R_MJPEG_ENC_S0		389
-#define IMX_SC_R_MJPEG_ENC_S1		390
-#define IMX_SC_R_MJPEG_ENC_S2		391
-#define IMX_SC_R_MJPEG_ENC_S3		392
+#define IMX_SC_R_ISI_0_CH0		377
+#define IMX_SC_R_ISI_0_CH1		378
+#define IMX_SC_R_ISI_0_CH2		379
+#define IMX_SC_R_ISI_0_CH3		380
+#define IMX_SC_R_ISI_0_CH4		381
+#define IMX_SC_R_ISI_0_CH5		382
+#define IMX_SC_R_ISI_0_CH6		383
+#define IMX_SC_R_ISI_0_CH7		384
+#define IMX_SC_R_MJPEG_0_DEC_S0		385
+#define IMX_SC_R_MJPEG_0_DEC_S1		386
+#define IMX_SC_R_MJPEG_0_DEC_S2		387
+#define IMX_SC_R_MJPEG_0_DEC_S3		388
+#define IMX_SC_R_MJPEG_0_ENC_S0		389
+#define IMX_SC_R_MJPEG_0_ENC_S1		390
+#define IMX_SC_R_MJPEG_0_ENC_S2		391
+#define IMX_SC_R_MJPEG_0_ENC_S3		392
 #define IMX_SC_R_MIPI_0			393
 #define IMX_SC_R_MIPI_0_PWM_0		394
 #define IMX_SC_R_MIPI_0_I2C_0		395
@@ -507,11 +521,11 @@
 #define IMX_SC_R_SECO_MU_3		504
 #define IMX_SC_R_SECO_MU_4		505
 #define IMX_SC_R_HDMI_RX_PWM_0		506
-#define IMX_SC_R_A35			507
-#define IMX_SC_R_A35_0			508
-#define IMX_SC_R_A35_1			509
-#define IMX_SC_R_A35_2			510
-#define IMX_SC_R_A35_3			511
+#define IMX_SC_R_AP_2			507
+#define IMX_SC_R_AP_2_0			508
+#define IMX_SC_R_AP_2_1			509
+#define IMX_SC_R_AP_2_2			510
+#define IMX_SC_R_AP_2_3			511
 #define IMX_SC_R_DSP			512
 #define IMX_SC_R_DSP_RAM		513
 #define IMX_SC_R_CAAM_JR1_OUT		514
@@ -532,8 +546,8 @@
 #define IMX_SC_R_BOARD_R5		529
 #define IMX_SC_R_BOARD_R6		530
 #define IMX_SC_R_BOARD_R7		531
-#define IMX_SC_R_MJPEG_DEC_MP		532
-#define IMX_SC_R_MJPEG_ENC_MP		533
+#define IMX_SC_R_MJPEG_0_DEC_MP		532
+#define IMX_SC_R_MJPEG_0_ENC_MP		533
 #define IMX_SC_R_VPU_TS_0		534
 #define IMX_SC_R_VPU_MU_0		535
 #define IMX_SC_R_VPU_MU_1		536
@@ -565,6 +579,95 @@
 #define IMX_SC_PM_CLK_PLL		4	/* PLL */
 #define IMX_SC_PM_CLK_BYPASS		4	/* Bypass clock */
 
+/*
+ * Compatibility defines for sc_rsrc_t
+ */
+#define IMX_SC_R_A35			IMX_SC_R_AP_2
+#define IMX_SC_R_A35_0			IMX_SC_R_AP_2_0
+#define IMX_SC_R_A35_1			IMX_SC_R_AP_2_1
+#define IMX_SC_R_A35_2			IMX_SC_R_AP_2_2
+#define IMX_SC_R_A35_3			IMX_SC_R_AP_2_3
+#define IMX_SC_R_A53			IMX_SC_R_AP_0
+#define IMX_SC_R_A53_0			IMX_SC_R_AP_0_0
+#define IMX_SC_R_A53_1			IMX_SC_R_AP_0_1
+#define IMX_SC_R_A53_2			IMX_SC_R_AP_0_2
+#define IMX_SC_R_A53_3			IMX_SC_R_AP_0_3
+#define IMX_SC_R_A72			IMX_SC_R_AP_1
+#define IMX_SC_R_A72_0			IMX_SC_R_AP_1_0
+#define IMX_SC_R_A72_1			IMX_SC_R_AP_1_1
+#define IMX_SC_R_A72_2			IMX_SC_R_AP_1_2
+#define IMX_SC_R_A72_3			IMX_SC_R_AP_1_3
+#define IMX_SC_R_GIC			IMX_SC_R_GIC_0
+#define IMX_SC_R_HSIO_GPIO		IMX_SC_R_HSIO_GPIO_0
+#define IMX_SC_R_IEE			IMX_SC_R_IEE_0
+#define IMX_SC_R_IEE_R0			IMX_SC_R_IEE_0_R0
+#define IMX_SC_R_IEE_R1			IMX_SC_R_IEE_0_R1
+#define IMX_SC_R_IEE_R2			IMX_SC_R_IEE_0_R2
+#define IMX_SC_R_IEE_R3			IMX_SC_R_IEE_0_R3
+#define IMX_SC_R_IEE_R4			IMX_SC_R_IEE_0_R4
+#define IMX_SC_R_IEE_R5			IMX_SC_R_IEE_0_R5
+#define IMX_SC_R_IEE_R6			IMX_SC_R_IEE_0_R6
+#define IMX_SC_R_IEE_R7			IMX_SC_R_IEE_0_R7
+#define IMX_SC_R_IRQSTR_M4_0		IMX_SC_R_IRQSTR_MCU_0
+#define IMX_SC_R_IRQSTR_M4_1		IMX_SC_R_IRQSTR_MCU_1
+#define IMX_SC_R_IRQSTR_SCU2		IMX_SC_R_IRQSTR_AP_0
+#define IMX_SC_R_ISI_CH0		IMX_SC_R_ISI_0_CH0
+#define IMX_SC_R_ISI_CH1		IMX_SC_R_ISI_0_CH1
+#define IMX_SC_R_ISI_CH2		IMX_SC_R_ISI_0_CH2
+#define IMX_SC_R_ISI_CH3		IMX_SC_R_ISI_0_CH3
+#define IMX_SC_R_ISI_CH4		IMX_SC_R_ISI_0_CH4
+#define IMX_SC_R_ISI_CH5		IMX_SC_R_ISI_0_CH5
+#define IMX_SC_R_ISI_CH6		IMX_SC_R_ISI_0_CH6
+#define IMX_SC_R_ISI_CH7		IMX_SC_R_ISI_0_CH7
+#define IMX_SC_R_M4_0_I2C		IMX_SC_R_MCU_0_I2C
+#define IMX_SC_R_M4_0_INTMUX		IMX_SC_R_MCU_0_INTMUX
+#define IMX_SC_R_M4_0_MU_0A0		IMX_SC_R_MCU_0_MU_0A0
+#define IMX_SC_R_M4_0_MU_0A1		IMX_SC_R_MCU_0_MU_0A1
+#define IMX_SC_R_M4_0_MU_0A2		IMX_SC_R_MCU_0_MU_0A2
+#define IMX_SC_R_M4_0_MU_0A3		IMX_SC_R_MCU_0_MU_0A3
+#define IMX_SC_R_M4_0_MU_0B		IMX_SC_R_MCU_0_MU_0B
+#define IMX_SC_R_M4_0_MU_1A		IMX_SC_R_MCU_0_MU_1A
+#define IMX_SC_R_M4_0_PID0		IMX_SC_R_MCU_0_PID0
+#define IMX_SC_R_M4_0_PID1		IMX_SC_R_MCU_0_PID1
+#define IMX_SC_R_M4_0_PID2		IMX_SC_R_MCU_0_PID2
+#define IMX_SC_R_M4_0_PID3		IMX_SC_R_MCU_0_PID3
+#define IMX_SC_R_M4_0_PID4		IMX_SC_R_MCU_0_PID4
+#define IMX_SC_R_M4_0_PIT		IMX_SC_R_MCU_0_PIT
+#define IMX_SC_R_M4_0_RGPIO		IMX_SC_R_MCU_0_RGPIO
+#define IMX_SC_R_M4_0_SEMA42		IMX_SC_R_MCU_0_SEMA42
+#define IMX_SC_R_M4_0_TPM		IMX_SC_R_MCU_0_TPM
+#define IMX_SC_R_M4_0_UART		IMX_SC_R_MCU_0_UART
+#define IMX_SC_R_M4_1_I2C		IMX_SC_R_MCU_1_I2C
+#define IMX_SC_R_M4_1_INTMUX		IMX_SC_R_MCU_1_INTMUX
+#define IMX_SC_R_M4_1_MU_0A0		IMX_SC_R_MCU_1_MU_0A0
+#define IMX_SC_R_M4_1_MU_0A1		IMX_SC_R_MCU_1_MU_0A1
+#define IMX_SC_R_M4_1_MU_0A2		IMX_SC_R_MCU_1_MU_0A2
+#define IMX_SC_R_M4_1_MU_0A3		IMX_SC_R_MCU_1_MU_0A3
+#define IMX_SC_R_M4_1_MU_0B		IMX_SC_R_MCU_1_MU_0B
+#define IMX_SC_R_M4_1_MU_1A		IMX_SC_R_MCU_1_MU_1A
+#define IMX_SC_R_M4_1_PID0		IMX_SC_R_MCU_1_PID0
+#define IMX_SC_R_M4_1_PID1		IMX_SC_R_MCU_1_PID1
+#define IMX_SC_R_M4_1_PID2		IMX_SC_R_MCU_1_PID2
+#define IMX_SC_R_M4_1_PID3		IMX_SC_R_MCU_1_PID3
+#define IMX_SC_R_M4_1_PID4		IMX_SC_R_MCU_1_PID4
+#define IMX_SC_R_M4_1_PIT		IMX_SC_R_MCU_1_PIT
+#define IMX_SC_R_M4_1_RGPIO		IMX_SC_R_MCU_1_RGPIO
+#define IMX_SC_R_M4_1_SEMA42		IMX_SC_R_MCU_1_SEMA42
+#define IMX_SC_R_M4_1_TPM		IMX_SC_R_MCU_1_TPM
+#define IMX_SC_R_M4_1_UART		IMX_SC_R_MCU_1_UART
+#define IMX_SC_R_MJPEG_DEC_MP		IMX_SC_R_MJPEG_0_DEC_MP
+#define IMX_SC_R_MJPEG_DEC_S0		IMX_SC_R_MJPEG_0_DEC_S0
+#define IMX_SC_R_MJPEG_DEC_S1		IMX_SC_R_MJPEG_0_DEC_S1
+#define IMX_SC_R_MJPEG_DEC_S2		IMX_SC_R_MJPEG_0_DEC_S2
+#define IMX_SC_R_MJPEG_DEC_S3		IMX_SC_R_MJPEG_0_DEC_S3
+#define IMX_SC_R_MJPEG_ENC_MP		IMX_SC_R_MJPEG_0_ENC_MP
+#define IMX_SC_R_MJPEG_ENC_S0		IMX_SC_R_MJPEG_0_ENC_S0
+#define IMX_SC_R_MJPEG_ENC_S1		IMX_SC_R_MJPEG_0_ENC_S1
+#define IMX_SC_R_MJPEG_ENC_S2		IMX_SC_R_MJPEG_0_ENC_S2
+#define IMX_SC_R_MJPEG_ENC_S3		IMX_SC_R_MJPEG_0_ENC_S3
+#define IMX_SC_R_PERF			IMX_SC_R_PERF_0
+#define IMX_SC_R_SMMU			IMX_SC_R_SMMU_0
+
 /*
  * Defines for SC CONTROL
  */
@@ -630,6 +733,10 @@
 #define IMX_SC_C_INTF_SEL			59
 #define IMX_SC_C_RXC_DLY			60
 #define IMX_SC_C_TIMER_SEL			61
-#define IMX_SC_C_LAST				62
+#define IMX_SC_C_MISC0				62
+#define IMX_SC_C_MISC1				63
+#define IMX_SC_C_MISC2				64
+#define IMX_SC_C_MISC3				65
+#define IMX_SC_C_LAST				66
 
 #endif /* __DT_BINDINGS_RSCRC_IMX_H */
-- 
2.37.2

