Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77226C421A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCVFWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCVFWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:22:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86857474D4;
        Tue, 21 Mar 2023 22:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqEvJv0OdjL3t4wsOP7HJXb+cVWiQ8KSzLsHcuYQkYt+B3z5Z5O/DMOfYeECXgof+l1Unx5OaS9aD66I0KpBOWV/Td+ah9LE39Ffs7DQBCoA6j3eq/4SH73qga3eNSHjgmaoQJHXs4hesOdbHbI8/bNGfl5RnPYjL0O7w5sBfTmCmtRjtV/CL7b9XOYtN4iBXrX1XS48CCsbQVASbz4pmdGFwcfo9UaQBjAqfdB78WdA2wTAzgnAXRBfuKz3+kHD0+u7gLhl21Bf0XaE1FffEE34Fw92EliCeNyHMRXLgcvnsLyFa6gDgvuh4mYXRK1/934zCS/TZRL5gKHGsgzseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nPkEt9QyfswdMet/S8eQ4hsytlZBf0Um1MloIm3Uq4=;
 b=ie07ezsZPxGuanxT5OmojUPTHrSGhdjytHGy6xMjB4/9dlRilKPibMWgCN/wqQ4zK/Tz9M1cUzF55lC7NT7H7x5OJMH2At0R5IHRF8hD8Q3gbhYfp0s0nxXjIkSgFyJbenHK80a+xVdckFmPuHJ1+ouC7hE+neA3zVdvsxtQhSeWye4CUgqH+qdPjG15j8l+IMrcaJ6Fr89wnwklXrdXZdMbs3Odl6XHx0orAhl65gGlwCK5KkhQb8Fa/AtSqVyhluI2VTpojB62JztO5eiTKM5bPrAZlAd+fEUUqfmloK3qCCcMk/dj20VKjEC8JE/31oZwfX3sRVf/4qlkte9qKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nPkEt9QyfswdMet/S8eQ4hsytlZBf0Um1MloIm3Uq4=;
 b=PcTqV2Sxh/so7aSjgrnHzpV0h+wZ1Y2WJk/ZIBXZFXLh0P7fefTqnC6/lZ513s8P9gl+50sc5dnKpyz3AYN6bPYTtksbvl9P4yM1T3DsNemD5IV36wF+LA5Mhy45+bLCfIEqwVXNBX+it1i7J0VtjZhyDfvLqT8gHs78BwXjERo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6819.eurprd04.prod.outlook.com (2603:10a6:208:17f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:20:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:20:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 06/10] arm64: dts: imx8: update usb compatible
Date:   Wed, 22 Mar 2023 13:25:00 +0800
Message-Id: <20230322052504.2629429-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 09065ef8-0c74-452e-a945-08db2a95262b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85D/+ihyoM1AbLwmDvECclP5j7kXC/L2YqTQ4r8WEF3QFR1FdMRUqQ6CekIje3sN+BjvMDq5fxcwXFQbl8HyHIfdoLeAezM1q6u6l0UUyMxSt4ykrfh900fOBAJsxvhRfrmiLO9VnxXWJQbEDGlJmS6w/8loaFkABD9ofsGcHeiLROj3sqkiobldaY+/0d3AV3xHpLIJnKmm28ABo1ReKZ7ZAZSSHadvisAj1YoxyiNhdCBLZS2cOJrdWxRUKZhtx+dTRUJMaL/p93e9GFX0W86dt00Z67Pa1GqbjcloQZbLIOGOGih9wT9EMVjasvfI1GzsICQQGqkt5rqMILHRQtkqmb+vChsTTH5tFnCDnhq4uzSn6z8P8q2+Xbo3v6R9DGDlt39lhaOaYUpUQ/Zismd7zH52d95K4zTo+o9miW93uXbr9tt2Hb0pWXyFDuG8uCeeU4G9nY5C0mzxc1kgErLaKtjs47snp8Jg7nitiEaTUMqH/fyjKLVD5z4Up0c0zsZvwqF7o5C72npkJ2QmFSKKox5owKGFkw2pNDISpqhCNuS+eZ21f+eO/23PhmqLEZ5aolhIaO2H+o5aR5dQyF41cYLm+VkLKr/qQ31Tcy04QXXTw3An6BiyHXoxfhRC2jAgGC0/IjW1o0sK/97phiGkqTmYQd463W2r5eBIG22Yb+Tf/ZjjLmPXB7sYJrfhgdxwBj9I9wJ3HuYAB8T+cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199018)(52116002)(2616005)(186003)(6486002)(4326008)(83380400001)(478600001)(6666004)(15650500001)(1076003)(66476007)(316002)(66946007)(8676002)(66556008)(6506007)(6512007)(26005)(41300700001)(8936002)(5660300002)(7416002)(38350700002)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UTOsimr8W02s/6lMXLEKvmQ1IS8U3jfJJQWb2s5UGVCWUONC+4LAPPzS8U8s?=
 =?us-ascii?Q?Zai/bfV9Oq8+NMx7/ltRtyWVJgVln8i7ZhZQy8XlHq6Vx3d5+f9tTA2N5XOo?=
 =?us-ascii?Q?6GfB1HYMjsmhenoNAU0c0xokz0wOVvcG+q3yISh3loz2dVySN8z06fWOnF++?=
 =?us-ascii?Q?GvAuBn2bL4iN/3+D2a7efzRcIojNXvWignqVs0vpU2pQvzetdJpJVdJZeOFU?=
 =?us-ascii?Q?0HCW4hGTnhtlkSZmxHNaa60VogagFwYGGtblysPz1X6ORoZmqrn7nE8pODdM?=
 =?us-ascii?Q?Uru64dRGej6ZnWVTnvzS1POLjhs6dTgk3qu17mkgH48bMyKmXILtgmhg4xUE?=
 =?us-ascii?Q?ge0JNswg4A1zyB8BXCp2uvkIgv6fCKqsZIiMdV1LtlhpnafWZkjmYZTOkdVQ?=
 =?us-ascii?Q?SDfcopvWrEROUOxmpgA9xiUh62dMYyInEM6tgLdIhbY58kP7zdMfz5PjcbD4?=
 =?us-ascii?Q?7SLfKGHryLO8xKsVHQ80fPGgm/FcXvw295KXGNm380GClhiQidoFydxYSs6b?=
 =?us-ascii?Q?5Ovob0AMF2TNnG3YuPJ+8FrZYewR58cIqdW2dyO22TyaU27QRKtrwnfvRIqt?=
 =?us-ascii?Q?oIuAthoKTib5qGBeiflp+ltdZW0asxy1YJ6dzqXQGgzDJkgbfB9s0raDI056?=
 =?us-ascii?Q?55IO8Puxo7IchxfDN/ZiGSyoqOerMbx+63jaFFd2gYb8MeGc3tAIULB0vThb?=
 =?us-ascii?Q?EoH4iwVfkzrCtxSK8p8fuxBJcZo0svSGh1YMxPWA2sKA0t6B4JPsV26RS/7/?=
 =?us-ascii?Q?9NWs61w+eJosQ8rWRKfjiVKp5Dhn8s7Y6G3/qxVAi0JnITHuEfAZ0t298YwO?=
 =?us-ascii?Q?I9f5atfUIvwRFEzoiuAlQi2pLnh2fMR8haDHMx0gnTaWf/OqF54wzHpcC8fG?=
 =?us-ascii?Q?qbBj51f6UndZT0WdfeLggajCBnLnYxuRr9GarN4uJsuRpONC2wqafeWQUcu2?=
 =?us-ascii?Q?CDs0rLghMKkXR9ab7+aDJQfX1a5Lc/uqAPqHCUM0pxoLmCbhdpyM4da1CKjL?=
 =?us-ascii?Q?MpRz5K1HAoakqxYnUxSLgD8g2OlJg7IyhpDhTueCOyGkOPD3FhnROhDwbJ4C?=
 =?us-ascii?Q?L0lHbpYzNmOSBAAR1MklskB5f1fUDgnuB0kz2YHMsTPeftku9bVfZYb8fQLN?=
 =?us-ascii?Q?ZOtM5+twmCSIAyxJ0mmJ9gx0/lx4/2mc9RpvGSfWxQCTkoYc+JRtM9/UilA5?=
 =?us-ascii?Q?sAU1wM6cx54ehXuazYxYGb96Jw6zZQhII+a0tnIsxH6ScG7Lyfiz14ReOUkj?=
 =?us-ascii?Q?3JB4Lxr8hAbUqgMiT5yGulEgdK690WnBpwtAj4nhqZCI4Gy12+Wwqh7Cfy8j?=
 =?us-ascii?Q?gpPL5ONsaiD2RHzBqmIY0WveKRIyeJ7wR2NmkqjQz35QJNt/4RXV1NmvtLmg?=
 =?us-ascii?Q?RGgfsDEmWFIEstu4l9epjSp0mdzCl5aMBt00KhOs3N8nq1X1w4lf97ySPLg+?=
 =?us-ascii?Q?lT/oXle2BINULktzE9HJtB1qE4Mr+xS/vpaYdURVdqOx/5lV+pDbSCX6XTZc?=
 =?us-ascii?Q?NGUSMSCDjKRhBIJOpZwWJ4zGpmUo0uN5DM8tz6c6nYkM/H6gpaN/4MZ4Kj0x?=
 =?us-ascii?Q?9bs2NA8L369NhwH9+47bd40DbPrn0kN2YJpJaiIH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09065ef8-0c74-452e-a945-08db2a95262b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:20:28.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRsL3XmfN1nzfrHcS/GkV2wv0Ez3GKJmeh7W0/+t1hXvsJfUdfJgG3cLrY/Cj5Hcy71uLI9/2hz4/arnTmSsbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6819
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 4852760adeee..6ed084862345 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -35,7 +35,7 @@ conn_ipg_clk: clock-conn-ipg {
 	};
 
 	usbotg1: usb@5b0d0000 {
-		compatible = "fsl,imx7ulp-usb";
+		compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb", "fsl,imx27-usb";
 		reg = <0x5b0d0000 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
@@ -51,7 +51,7 @@ usbotg1: usb@5b0d0000 {
 
 	usbmisc1: usbmisc@5b0d0200 {
 		#index-cells = <1>;
-		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx6q-usbmisc";
+		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
 		reg = <0x5b0d0200 0x200>;
 	};
 
-- 
2.37.1

