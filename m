Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661B56C4217
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCVFWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjCVFV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:21:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2129442ED;
        Tue, 21 Mar 2023 22:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJy2vOlW0xy6eyzYdI3oDOP2W+Jdb9PHJCvA0zMt3RNJXXl7ZOKQqIWglrktWwzOPWQFLXglbzsBp7LtS39NHDT39NATtRlrNalxq3QIVx/4RNZNehuUlu+IGF3ptluXFNFc2NZ/TCIHgi/Nsunw4qM9+HRsKRM4q9oVuvjUEXZqsY3I3yhcREnwngaDUwWbaFSegpG8PT6EwmL0hsWmkkdCrlPKhtcL5cmQdpgc3PLsDWeCBDTW5OMkzjOwSymFUIl4iT5TO0/XBYbeohojNe4vET1iLU16Aw9ODOjEkCa1gyq8QqdFsa3Y+nXIq0dnTkqfsNnCenOPEkMwa0gUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff4ng602SoshLDvQgPEcxyiSzsCtkn3MaccwzpQapdA=;
 b=nJWP9NRHyucZwRo+Dk7RBxqhFt5RpsYp0Im8mQlsSKvcMav82bXSkUpZQggtF000v83BlRfsrvkENeUoA5K8M9EpERgvLQQGv3eGz89ocgl4TFaK2r0OQ3hA2lQVkVNAoumivf0HvPLlnOJPDTEAHZlfvInCNH3eyoyi4MAJCmbO32nyKn+/bF0dnyFziYZrAsyzDKgZzEBTUM+APbGrltpuOk1xDPBMDUzWUfm80549YQE+1iY/K0MT8z+hZNTvCzpKJkZ5cc1FLUKXvZs6iyVZ540W9UhljgI0K0JHGkQDlovMdagebzuVqczrqUPxhiWsTa0mdJDwBS2F4ZxOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff4ng602SoshLDvQgPEcxyiSzsCtkn3MaccwzpQapdA=;
 b=XRfQpDAqd7ufcJQIiWf2LDelJFuCwv4nrRFqzZhbyZM9WV+1/oY+XBvRMLE4Rk+eXLnyBcaxPiYX+jo+U2oLXd4vegUJmq3vfXGSTQgnX2kEAe6f9UNfRi3DFDAsUs/beXH6ooF6UY9yLoW3eRyYvH1w8YraNBIzMN2H2Fy4Ikw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6819.eurprd04.prod.outlook.com (2603:10a6:208:17f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:20:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:20:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 07/10] arm64: dts: imx8dxl: update usb compatible
Date:   Wed, 22 Mar 2023 13:25:01 +0800
Message-Id: <20230322052504.2629429-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 22444ce2-ad8e-460f-b6e7-08db2a952920
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stmJCErMZgKJmUEqF42ExxJo2UxQu95v2FsAO9ha0ziE3L0K7NaQZu2UCnqnOsaEDHnl1hkrgUDiqtFnYMCoaf76rB7/yyo5tIKaKde41v2q63Cv0N4sT17jusx62AzbTQiNXpEAJNzHaq4CH33GOxeH5fQuO1CdVcOXJHzj2Ual2D9TsR7nA59KeNnrFXwI8ji+Wi6npTuCsIWUtT0GqP/d37AimPt1gTu20kHpwduA/zJj7miTYOpIqHClVm3w27tAQ624r60isNBf2vPfPRhidhqSsHDErjGomeujOXuy4nH3fBwHYFYh2HKCoU2ummybMi8oUtBwaYgDJEtbtt9q0YmFQmEtQAx3gp/nZ+JDufGMcEWFLam7u79OwUT2fGXeASkn0uJy6hOrEC/lUI17/NV9KwRvi3lbmr/FQ8aHJ0k1TSGysuVpDTSLQWZsSKws/m5ojSDvwKZwW79zxootRNY+MhNE504gD1frkncFnJIjBCqaDgnwXdBtPI0ajZxZqnnjLbRWtnhLtr/NWrj2R09nShBn+bwmtiPVXYZ1ZugPPG42HOoBLtcks83WpT2iovduBmGRuYs5OHfZ4zXs/HJ+FXtq+ManOPINzPkblli3e21xPcAG+7Y+Kd8Xpg0cp0zLdy1in8hGiGlKhfyHsXaAKEggyZrTbUMjoJbJWnazkXgauw3E/yhKsJIEXnC09stB8Ex821/voIE30pfy10GAfyG4/oHXoT8dV8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199018)(52116002)(2616005)(186003)(6486002)(4326008)(83380400001)(478600001)(6666004)(15650500001)(1076003)(66476007)(316002)(66946007)(8676002)(66556008)(6506007)(6512007)(26005)(41300700001)(8936002)(5660300002)(7416002)(38350700002)(2906002)(38100700002)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DLmP4TBm0wjE9HucEvrwUswFqv1kVz2jRyEmR/JonnVShMIGWuTdNyCIgrc2?=
 =?us-ascii?Q?7xAkdGFw5YLF15B9sdAknK++jmX9nNO3Lz7Kcz6y4WvdH/GiEMJK3RxkFB88?=
 =?us-ascii?Q?UzinSecONT49EBrWldGt+wYJdeHqlJMccE5cQhl1AMgszh4CUneLHONfslXo?=
 =?us-ascii?Q?ewL2r8TOfueYdKy+JfjuJsI7Lv6ju0zZpn7qmxvTvooouOAI2J10Y/m72Pf6?=
 =?us-ascii?Q?eBXNhGewj+54AiUgaqb/OIqC+TNFKr7h/f2t/3T3bAkJwE6ecqRJ5YjyE1qn?=
 =?us-ascii?Q?HH6/r2tRPjUtvDEqSW2KAYBYUX8rGmTjDggqv8X1T2S9xFn0P0SjaIAAsTL8?=
 =?us-ascii?Q?HdtqAU8Z/XMq9QNdKbT1xxQCdp9g3lVlY+fj7lXbRU4HspC4HW36EROyjJK/?=
 =?us-ascii?Q?z8+S6ltVgCpbtW++Pn8uDnoN/T/pX/dexqisJ3njAZw5cYsaNcifsdKHvpHH?=
 =?us-ascii?Q?NV4TmnHQSUZwJwhJVtMQR2Icvbq/tW4mAREnx9XBWI+SYruhtKOHQnInUOSv?=
 =?us-ascii?Q?ls0ImMvMVT5p2sT9egdojJHkldlPZE2ePTYWh1ZAnoMr2Rkfr4w/qgMVGgkn?=
 =?us-ascii?Q?AQQyuYCDZzWQ7kixTX74bCtCtUPleJzy/zw1PzibvJtY4qBjxMtIctpDIcPC?=
 =?us-ascii?Q?2P4X/0TEDr/p2RbNYCgCgQOwI2MOGDNdTnuGAERRfyYzmyMryy9PF4mbx+8z?=
 =?us-ascii?Q?h0EE1r85t2rFXATSE6wDD9zLUuq24hi0zNiqaTzU0gvO+S2tFq7Z+rWLtc3m?=
 =?us-ascii?Q?QHbd2G7RLERLpHjE0IXC5ZWgENBAk3y0HJ1gNsWLspIDrCyCMAoY6QHVN+g7?=
 =?us-ascii?Q?NPAS4snTZdEoMdzhG13tMckfqQW8QiAyBXLUDEl3Bkt/9TFju1B8i6C966Sw?=
 =?us-ascii?Q?Qtj29wpFQYSbgdRlwsG6Y+5GV1z6cVPOPPe19xNJ9MyaZtPwOeK/ip3trOl8?=
 =?us-ascii?Q?JNr5IM0XR/TaLafGzn2msSJZRYpmy2sS/AiE+oBJqA/fDfYe7nzxT82/Ddza?=
 =?us-ascii?Q?sUdCInr6WB2bsiYmzc92oVEO5DpR738125Mq7eZ0EGUFOspW1JMGRuNEuLUt?=
 =?us-ascii?Q?AXJjkCY2nDgQEwDZqiKRaJ7VO+laIrSVkHLXzk4rFKgW/1lmM2TPCnPCx9zs?=
 =?us-ascii?Q?Dtdo7VBtqk3M78MCbKxtTxZXBgfEHUu7v2phQRz8BohZQoa0E0bwdoY3SWvb?=
 =?us-ascii?Q?hcFXK25qEr6NZ8mdA8quiQnVcvURmh1wRltLEzoctMP1mkqGa/koZuz3Jhcb?=
 =?us-ascii?Q?0/lU0AFjWs6wIXzQkrPZ/W3uM0axa5s+LaiGcR48XrJKDpcBBe+eQYaGzYVx?=
 =?us-ascii?Q?aGc1EkpUzFaXG0FiGimehU3gwS901KQje+z/iJlCmA0jGXyG3qQZZ82DtjVZ?=
 =?us-ascii?Q?j/b5zO4rzUSQkMWoJVLa0eolVRtkZsZmLoMumlSHEVu6L2snmzkou+YEj0IQ?=
 =?us-ascii?Q?I3jq4zajAqhE2yPnT3TRgQIrtTpSXPnaCYy7ub5TcyieIjfPtMiD/DgJYPrQ?=
 =?us-ascii?Q?v+qwO2QbxfjnnuYukOG5YOM8a2uXCiGXQyKXT36JRgck8whkAfNnL1G729Fx?=
 =?us-ascii?Q?LWMhZXoIjUWjr9cbIJBNsM787J0Wr7bkDEY9Gd2L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22444ce2-ad8e-460f-b6e7-08db2a952920
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:20:33.4685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpKODfCLudnDItD/cd3kfwClD34UmpzY8sAkg8Wff1kdXwojj6Cn+Z/1RZBeJ9YEqF/Z7mAD3D9ObQTed4Uzbg==
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

