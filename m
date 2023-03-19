Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57586C010D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCSLvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCSLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:51:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C09621956;
        Sun, 19 Mar 2023 04:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRMNrTiQ/ePUOP3kQmcHA1If0TPraHtQHz+thl5bM63nKzFFl1dAMSBaWMGEm1a2aIsydLZtEdO1wBdlcVx/CKSBvgf6hEJxnL7f2NrgkqPWpTtMYaKQZL1okfrZRFxKU2kF6eMv44pKaXV6urY9cxZberwPuPJrLTxeX1F5+XXFsRl1VpTj4MWFnT+pYMPwRI/BjYJGBg1UeMoeQKitomZwAZeh1Ab+V4JnJJjO77wwgz/8N8OOKXZXmitH9tjZG02c8ZyZQneddrO/9DpXMnC1XuL54Ed3MlzfUX92Yt/5B5Mn2x/RP31GGhk+9VwhZv5AzOsdRKpEI0o/1U6wCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff4ng602SoshLDvQgPEcxyiSzsCtkn3MaccwzpQapdA=;
 b=lBr1X9HPGVf+IiE4zhGDWafXd+7RcombEC/jiKcqg+v5VTFBAJSbVhGXM21TUZYFKSzaZKiG0xEblFDw6O5b7d3iC7jbcvjoGDeblTryYWIXlYoUiYJ70QwmPPk47662SyW0s6juWSvhASeyRVt4JcVX7NDYF4TT5Cze/qu2Jf5hHM4MbmLcA0tmGUC2lyC8ZAk+wF/zdEi3U6bZQmPyZc9qpQZzs4xyf5LmIataNbDdoUEuH9vt0J4OJ4Q1kDPulMhdvf/B4k8G6cJz8aw9aEk2IuE8DkQ3iH2hxzvNeb4Zl0dtAJrt543+KwAfqjaVIcmoEpvCohUk8+J1aO9GxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff4ng602SoshLDvQgPEcxyiSzsCtkn3MaccwzpQapdA=;
 b=MR1mh1Sv7Dj6hr/8HCuq/2pngEZHK/ryD0VvxRTCExAnBVk5wdysOnyhqFY2+8f5wP2UdKfHM9a3cQGqNgdenRS239IWi4N2loMeyJzBbiJxSwdKtNHc3IjfBdvxXyy3CbgJSBN3glob84wevNqHsL2YtCODlglgvEztrqTthWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7685.eurprd04.prod.outlook.com (2603:10a6:20b:29c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 11:50:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 11:50:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 6/9] arm64: dts: imx8dxl: update usb compatible
Date:   Sun, 19 Mar 2023 19:54:53 +0800
Message-Id: <20230319115456.716969-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230319115456.716969-1-peng.fan@oss.nxp.com>
References: <20230319115456.716969-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b021ee-1d0f-4700-e988-08db28701bf0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37yuIURWsOHlBJbUnyq1ShXyTdH16IO4f8zXVTiOL1CZRz8WAjolPRwZGkwzRqNoQK60O0sqvYCDObsIYh3Aa5yPheUDbTmxgTiyJfpjnM1p8FD1+kt1KRsNdYmicgtO0jVzRPSA6FYMm9RJ4KF5CV4m+NaNJOIV5YRxBu+HGQ13hMyf782tNVtSk7ucAYCX550L0+iOixivrkHmEdEPWx2WogHhmuoxmK0vbEpFgX/p2GzS2gejWzUmWDXBR9C+4Uc3SitWYrDftuF3xRYU1aJx5FxD2PSRD9ookoAm+L9f6+o37BMYcTYjUyap7CfwlNIh6bAbQYKpVwxUYy6AOLhqRbHAA/HpFwShdg7UAOOJ8L+FGlCDkJ/KHr0aueLVdoYGIUraCa3wTj1TcmsIsVPYsudMZ15aFibYGkYF6iFsA4ACUUGper/0aHmbukeVooy/z1FZLC7CiOGDs7i5KAm/1f3QhfF8LOYBij1tNSz00rRxDtm3drEoc/9sKjtMPSEIZEKa1HSGuzLHLl/XX0wMxOcnOBc3lRjY32OaiMTDX7yzD6CaCuGD3YCmPgXZclyXQahFhUyF/ZU7YRw2SzwQhsZ00PkTfpfnwzzRhWvYNP8htotHa3PgSDSD0xopc8TyBflZfGg9cHsGpiyobYeRtgYeu5m4PiRcVjFef9+gPS8GF4wvlHXX3jmE+XeQztz26INwqz7SdnzmL50humlMKKjYt75uVS9NZVDt9ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(8936002)(5660300002)(7416002)(41300700001)(86362001)(38100700002)(38350700002)(15650500001)(2906002)(4326008)(6486002)(83380400001)(478600001)(52116002)(2616005)(186003)(6666004)(6506007)(1076003)(26005)(6512007)(316002)(66476007)(8676002)(66946007)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OPILzfXEpumvpFcjW/92d21NZNXUV3N2KR4Ek/hbd71d/rW+i8o2wBkEuLt3?=
 =?us-ascii?Q?tmToOttmi3Gz7xSeLwWBjZ6/C4jFrfQDSooZD22FBd7n8sD/cQT2iIH3pkIg?=
 =?us-ascii?Q?fNqCPVM0V8QzrrS/sGmqqG/P0Dh+ls+1MmHJMtiMOK8UdVExdViEZtlKHCjH?=
 =?us-ascii?Q?DdN8W9zYO1CbejeWYIOmXVSugZH8dVM2FVb/RWyXimIvVpPScG3KfwXc/YXG?=
 =?us-ascii?Q?XurNfkKuvDV6o2nCfgFTgzAc71UeoHGymzecTGLaCuHmY5trLarudrKGToMx?=
 =?us-ascii?Q?Brk/v6DGK5voSBc1q72cw6GWyZc/5uj9b2MVIZTMKgKz4FlLqnLGdIMk16pr?=
 =?us-ascii?Q?d7R4Fak8Actu3Y/3uQBRE32kVN62T7lgrNjFTVw4izZauIpqUbznZ4YQsQOM?=
 =?us-ascii?Q?F2bCp2TOQdFFy8/+6gZl3Pgbidmx6fbaP51gz5aErL6shtWd9MKLiFy9FoU1?=
 =?us-ascii?Q?KWbYshioYb2e+gAajmMuvs0Fff7VKB+rmaBOK/B3XdUsfyHby/Q77tZeuagO?=
 =?us-ascii?Q?8scgp7Hoij7A79KT+7vAxFF2HV/8k3ZEWZ5Kx0o4J/tS+GEehT0YCQZq/LWm?=
 =?us-ascii?Q?vKqiUoaMDVlLyENHq2H0/Vm9e2/ynKp5bi5W/nh/003ttmToP8uRQjMbl2pl?=
 =?us-ascii?Q?wjW9dRmQk7v4Ic/n1glwIE1xpTtJe1ox7BjQaerdp4cd0fMUxZxPwEc3ovQO?=
 =?us-ascii?Q?gSPSZd65QBR3gomHttixh/TksKovj/sEgL59+2+Ell+9rM49ylTBsKp1UZTC?=
 =?us-ascii?Q?HHSHkck/O4hOxGjetAbLEV/gAD47pfAVNRNRcpRhOOIAj78P4t3yVT1Mo+RR?=
 =?us-ascii?Q?W81iDqZ/ir9FYOOmPDQ8Tq2TMBm5nf6RnQ9wT/rXEOaGdBHwDbloi5JoFfzY?=
 =?us-ascii?Q?wTBezFxLrD5orIXGgACX1YQDM0tR/4FHSByhyG8A5/eXyluaiNmGEixI+55o?=
 =?us-ascii?Q?W5WRcXteytT+Lmutdy8QfZVHzfyOdPxFKOS2bWd3QyLwMNdH0lKLUh0uJcKs?=
 =?us-ascii?Q?wnSETU5y/HBh4M2YNP4zhGHZerbaBmK8MakOlyL9T0vhLukt5xfq6+yOEnkN?=
 =?us-ascii?Q?KoklX86TP7rTks/6NdHdJswQK2rXaj1U4R1VmAftusYO8s4mTRKhHrJri7JC?=
 =?us-ascii?Q?BSgJ92665J5YxingZUMPxQfuB4w+LigxCBibb1j08zG6atQdM+3Ncjl1+jDE?=
 =?us-ascii?Q?vKGFDHtdPxnXPJT7e5mP1Uzv1CUKrSzVFiJ5VcBcTswrhUnAyJ8YoF59RZBm?=
 =?us-ascii?Q?NV8v4NsRrR+iGXwhh7fNbqaORUyWZTP2Rim4wDtR3R8LIl1P7b8c6diwXL71?=
 =?us-ascii?Q?Cn4FPjrMIdTA2pwsjsb870njzTJA8nv6Vfit3QeLk+bp/WDs//dRjayl4gEd?=
 =?us-ascii?Q?LWkAZqMqLt5apr4PeIP1jbH5mzmXNPTIkTjsjtrG+BLWWDnynbLJPEzdKas9?=
 =?us-ascii?Q?Hq/PMLakMnmuHNKH/Fk5yUtY3PSh6dRn0RZ2xG8wYB1Jb8Z7lqGtt0q2+F1a?=
 =?us-ascii?Q?U29RY66Bm2RADCWDGhon1HPw9TbIOwqiwaehcTjygcdxSnuCTBz7DOZItx7V?=
 =?us-ascii?Q?sZa6gFJW279RC2H7ni92PXMZ5ycrNjUOjW/QOeBk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b021ee-1d0f-4700-e988-08db28701bf0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 11:50:17.6090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RXeAFiS2HbcEbpddDrHV1oNKEIp0XMC6oOdYEMH36Ig+wkGU24jDVVyfTjiv1fdlYbHzjd+7fY2JCeo26mOUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index ca195e6d8f37..88913869ae9c 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -34,7 +34,7 @@ eqos: ethernet@5b050000 {
 	};
 
 	usbotg2: usb@5b0e0000 {
-		compatible = "fsl,imx8dxl-usb", "fsl,imx7ulp-usb";
+		compatible = "fsl,imx8dxl-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
 		reg = <0x5b0e0000 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
@@ -63,7 +63,7 @@ clk_dummy: clock-dummy {
 
 	usbmisc2: usbmisc@5b0e0200 {
 		#index-cells = <1>;
-		compatible = "fsl,imx7ulp-usbmisc";
+		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
 		reg = <0x5b0e0200 0x200>;
 	};
 
-- 
2.37.1

