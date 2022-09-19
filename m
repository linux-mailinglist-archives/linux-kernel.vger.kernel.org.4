Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6545BCCFE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiISNWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiISNWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:22:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289AF26551;
        Mon, 19 Sep 2022 06:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPzAwAhWbr4o7MAYpUAvok60OrZOHG+XWGiav01AoSh9PlAKFuLmqTNznQHeQrxv26sNl3qE8DU76n5rcW8tCzYpjvOyXcsUwq+7ITHGln0Ei+MxaFROMedBGPWP6PsPY5LsqBaOZFTZLQZPWSsoiRYSk9BqDRmGu++kIoRoRFFTl5SmXqJHEKI6TtGW+AarjvLCZ2N7i3g12LwgfcqcuC6I54FEC0CgOPrLiQjxdaRV/9ttMJ4Xpd4ZjVcQFJPplT+QPmu/s2pIDRbFxq1TdFCnHuW/jcbuGFscux8/c51yuv+1pud73MOHO0pxZWddxIiBUMW3mfGe3nTqNQn15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhuelpZBPETnJWMDwRlTP3/aoQE+3KfImM4DiDoz0pg=;
 b=AcVpFMqQAMEi8LVUbznXI3zUs10hvNUy33HwX6XpiEY+8wyaA3B+ldzhlcQiPIAp1KPS785hzvVRQTzCb60jJ5lS2H/D8u+aGS2iTv+pQ3kOJR4ZSCGmml39tPxMlOfVqB9ipWXZpcP43BzssZ7a4s006omFmtZ/QAk2YOpI8mxPyYxmNqx0jrYMC5c7MiCQj5lxNZRMqfmo6xNH0Cuy2aXq253ctmh/xOeJpoTdsrgJlByZGiZQbJgZzDrn8u1S6Q+iA6T66MywV8Wr5u8pJmz59/LH7YtT67g00cXn5g6h++5JXWMq6FM6IjWV8L5AEpWlzV70MldFxrcJx12xnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhuelpZBPETnJWMDwRlTP3/aoQE+3KfImM4DiDoz0pg=;
 b=e3OfWpD58dDnyTMwoqjVp0gFt2XTcoV5QtCO1n0o9xegOH4PSTur6wox/8Gmu7GbJZaXu6JW3P45ZrAAMeA3vAvyBuKnaWP8XRCxjMtChOfNFA047211i88XpfxweXcI5DWvcDxNfGexLfs0ZMzljlWr/+9GX4yiOMvxT4jQ3p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DBAPR04MB7240.eurprd04.prod.outlook.com (2603:10a6:10:1af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 13:22:45 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef%5]) with mapi id 15.20.5632.018; Mon, 19 Sep 2022
 13:22:45 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
Date:   Mon, 19 Sep 2022 16:22:36 +0300
Message-Id: <20220919132236.264382-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0159.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::13) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DBAPR04MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 8049e2cf-992c-48ea-a2da-08da9a4209b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10Md9s+XfvjU0PwZ02oY9AGNklH++1b/IaKmGIIcpIkiqqIbsPwyJ8vWgZxp+YAFwFkJXhtqiGA/MJfx0RK9KOiASq77ZvpWGSz22okyi8/2AwytieYeGOm5yAmzAGXRiHybE00UiyqvE04T/kuJ09jhCDtb9kirzhBDduRBVUpFAi8q3LP1jhFJwPS2tvXeKV8eZT2rn09kI2/n1UTcWqOgSvJ0wuKpWZc3AHnjSVsnPHIRInVYorB2k/yRm1+P2YiBrj7ssA5hTspVFQikMnJc6rf3bQYAVa9F3bueTsxRAIu5R6QhcGNQbgy9CEGEnsrwkxxmWq0QEHIxSLsOIkjvcJ2NwWmr/trqbg0bqbzBIKOLnNPJJb8Ig0p7o4n7sB/banezNnEUGYEfwL8EaLNjuH93WLQ1Yuf2qyy9xoo5rktgwgOttP1ATYYusN4hcyaOdP/QAk/hu3GggNEaCnbKMERWjgEGhyVJ7BSi5uS78bMQcvm2no9Ao7KbINcbZ4R7nbb3ao3iDBDM1kIDQfqq34VD0aiDDvt/HFUUI9kYgxKPdl8AaA7JLSrLm372nFaqZWYU0LNN2F9iCHsjLseb7b51orf2x+l3qyH/Kpbr9NpOtxWEqK8W78fx6AtDlTkR/LD15iCWzkmsfrIm7TRxEglbShQJucr+YgnUSSiqhSwvowTzOAEm3Hjmd3HKAwAMFUmPtiGgXVg7rrGMhiNoYgonc1mSynqY9mnqHVeLVXQOxiIUInWcpAsMY3Ma23s2pr/uf/uCeFJbaG3vvFmyHcBa4cWuOTGfKiNdeNhNBv4qWtwua8jlthu67M0TvyoqmS25nx/T+dTmIsGZQYppkVUpb7pCJFee7Bmcokc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(86362001)(921005)(110136005)(6486002)(966005)(316002)(38350700002)(8676002)(38100700002)(6666004)(6506007)(478600001)(6512007)(52116002)(26005)(1076003)(66556008)(66476007)(66946007)(41300700001)(2616005)(8936002)(2906002)(83380400001)(186003)(5660300002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KYHNFHp9XFToPQe15RaIsUMMGMmC4+KyG/DFoQLnY9sL1t1DdUscW03/5S4U?=
 =?us-ascii?Q?Ao9rayfFcLRt4hC/tqNWXSrt+wZqpIpb8qLUMdb7F3m7cCXwclnlgB5fAa6l?=
 =?us-ascii?Q?Ab671b8QLGW5TeDyKEt557sYTaubtFei9bwp2f4Janm/ePJUE56ZciPdwler?=
 =?us-ascii?Q?h3IEmvHk7js0/byo6L6dDKBu5PYp+HHNz6wJ7O7Xq1D9g4ua1/f3Tr2iuWcx?=
 =?us-ascii?Q?Kdz+mcJcInYbCaqPhS/IgdrktUD1md+rDmAQXmfch6T22+bYuwQnD6EHbljC?=
 =?us-ascii?Q?IflzsO5LkKofTP4G+Xko5O78oexMtAqK4qHBa4sVyt3xXWQMxRN0j75PfQSF?=
 =?us-ascii?Q?KF9pJMLvN4BjHCAtyhpgpVdFtI+im7EDZhAETnWJ/I/mdiUOANrmcsGH30h+?=
 =?us-ascii?Q?V/bUjrp5uE43w6ZyG09Fs0gsY7IrO377JeR0wcpCoPvCGU1q6T1KFRmfxQjr?=
 =?us-ascii?Q?/jpFlrY4Xd/99qpN6h7zDwfHqn8/LI6xycS1L5JiaJX8PqZqq81cnvtRNwcw?=
 =?us-ascii?Q?N371jOc5DAzUkFJislJz5i8Th6BKfIO2THItdhMsuTpxPcWSJiJC+olNS/hp?=
 =?us-ascii?Q?u6YhPc+78VBg1lfFJ/LslZcWYd+WKpWNOOs2wbhgXE2L/H+vP36bWB7oAqXT?=
 =?us-ascii?Q?/9iCyL49tzeirbN/8/IQ35Kbb7ODMEoqG4V6Nc/aI6YWTxOHVM4rCrqIqNR8?=
 =?us-ascii?Q?VV245qHw0U5BGAUou+8Lh0qN8lMpGBSdKN2Td8ey8WbfUltaS1THZNdCLbcq?=
 =?us-ascii?Q?aPn+CtuENSgPa34m1t1RUaX1kw1npy4PDa1H1sdx/Irqd/YF7QTIeNKKzCMI?=
 =?us-ascii?Q?JosB990nQ0okWU6yyOpQmYzfppjmO+Bd7ZfZKDdC+3HQzxYwlpNn4Q6B89x5?=
 =?us-ascii?Q?GrEjMYGeH/mtSqoUCYsv9lXZ0tsS5wRQBx+bSnhJxaRlcSYg/gMslmFAODPH?=
 =?us-ascii?Q?OUHY289OgZE3P6bBODdMkYFNsKyMiDHR7nprfeOFhNnZ6GQNPGpl6f1VtWoy?=
 =?us-ascii?Q?QgYYG5HgSn8OzR3XdJcEcW4FxVrjOAtX5rHim+jPq6Yq0KZ757IZ+8JqX06T?=
 =?us-ascii?Q?e1ylp1DNdS+eiPcps5hZdAPTaW/ANr/6L2WtFBERWMsWjVr9m8Jeh1LsBacn?=
 =?us-ascii?Q?SYEXftwc+gbfE0faNptE16tmAuxaQ1hsz8GujlgdmjJ2gybem4+FDD5q0rU1?=
 =?us-ascii?Q?Kaiqo18memlziD2Rrt4uZqah6bDBm+jM4JZj9SFINCPmT8N/y+fsR3NzSncW?=
 =?us-ascii?Q?qLNALyqCUtsXVy6+Lj4SXJDzYj/GVy16zciHW+XmeJm/N69bkOmGTR6cLaEZ?=
 =?us-ascii?Q?hC7GuxBIAaDu255oCXloWOxrCCoEq8eQeVQ7k8jNg/VWd3pxpVWaH6pRH/DF?=
 =?us-ascii?Q?055U5JfkWAujQDltpNjnqAMrvrAUQ30yBFysMNEFabjK+DA5RCFlRPRZ7kZQ?=
 =?us-ascii?Q?v7/4gsD/zOiIuKIcMhuQCs5tVOJ5xZrjNDRtMNW6jRye4gPnNs3OVX/WlVAc?=
 =?us-ascii?Q?A0+goyr2xL9OYQjLaRru18Fpw5VyvXAawX+9qBR0OsMTAGpyN4LsPhSv7VS6?=
 =?us-ascii?Q?deDhy3q3O7/yIlZUw7qIufwueqSWyKqQTL73AzDQLxSzwArEBMmkWV2Ni/jL?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8049e2cf-992c-48ea-a2da-08da9a4209b6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 13:22:45.0329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bh7x+RFu9O7J7pCTZbJhnbMwT8NDcuBOeqoAkcxdRZywIWgc0LvGtmK+cHLaDr+v4mU7U+a0kcz+EIUWOiJfjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7240
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
 include/dt-bindings/firmware/imx/rsrc.h | 294 ++++++++++++++++--------
 1 file changed, 198 insertions(+), 96 deletions(-)

Changes since v1: https://lore.kernel.org/all/20220915181805.424670-1-viorel.suman@oss.nxp.com/
	Two patches squashed into one in order to keep changes bissectable
	and compilable as suggested by Alexander Stein.

Changes since v2: https://lore.kernel.org/all/20220919113715.243910-1-viorel.suman@oss.nxp.com/
	Added two more defines in backward compatibility section in order to
	to avoid breaking ABI, so there is no need to change the driver
	anymore.

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 1675de05ad33..ed33869f184e 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -13,30 +13,30 @@
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
 #define IMX_SC_R_USB_1_PHY		24
 #define IMX_SC_R_DC_0_WARP		25
 #define IMX_SC_R_V2X_MU_0		26
@@ -56,11 +56,14 @@
 #define IMX_SC_R_V2X_MU_3		40
 #define IMX_SC_R_V2X_MU_4		41
 #define IMX_SC_R_DC_1_WARP		42
+#define IMX_SC_R_STM			43
 #define IMX_SC_R_SECVIO			44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
+#define IMX_SC_R_V2X			48
 #define IMX_SC_R_DC_1			49
+#define IMX_SC_R_UNUSED14		50
 #define IMX_SC_R_DC_1_PLL_0		51
 #define IMX_SC_R_DC_1_PLL_1		52
 #define IMX_SC_R_SPI_0			53
@@ -151,10 +154,10 @@
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
@@ -183,7 +186,7 @@
 #define IMX_SC_R_PCIE_B			169
 #define IMX_SC_R_SATA_0			170
 #define IMX_SC_R_SERDES_1		171
-#define IMX_SC_R_HSIO_GPIO		172
+#define IMX_SC_R_HSIO_GPIO_0		172
 #define IMX_SC_R_MATCH_15		173
 #define IMX_SC_R_MATCH_16		174
 #define IMX_SC_R_MATCH_17		175
@@ -250,15 +253,15 @@
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
@@ -289,46 +292,50 @@
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
@@ -373,33 +380,33 @@
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
@@ -514,11 +521,11 @@
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
@@ -539,8 +546,8 @@
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
@@ -572,6 +579,97 @@
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
+#define IMX_SC_R_VPU_UART		IMX_SC_R_ENET_0_A2
+#define IMX_SC_R_VPUCORE		IMX_SC_R_ENET_1_A0
+
 /*
  * Defines for SC CONTROL
  */
@@ -637,6 +735,10 @@
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

