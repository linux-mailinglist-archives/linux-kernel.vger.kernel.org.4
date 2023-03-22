Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CD16C4210
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCVFUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCVFUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:20:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A836346B2;
        Tue, 21 Mar 2023 22:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3QQbxHO9u32mEKfpvvnJVl7eXUCyK3nQGk9gVhEQdNSntOIWoZnj6tdis+Gt/UaHskSg8MIuMU2gnMxotZc1q1J7wko+p5oJOIoCSdH6JcXmEm78LOB866HxgPrIwR6WC6c84g59dOQb4+WOqFdQmape0tLzH2/17Z9A7KaD8aRyS/J5LPIVgz1BaHpEz4vgASkC1dCLAFhdrv5+IgTUiPzEPQDWVc57sovz2m1RsVBt9W5h15BzMnllcyHOysP9H4Ay42DQxvl0Zc3MczGkeNj1RrXxv+SAq9tLtHuyG8RSWS1bnBzFrCADA8zBSI5DmrriIcs5x4FjeipVOY5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hlEhotFhkg72FyYq068bth7cR3cLx6PJeLSFh4yT3g=;
 b=BVnVRFLRBnOXSyq2cB2xaJ2pF2BrxzI1XZqcuaToslq9A6VVCSU+0WbJNJaiNVZkir0uPNW0kJx+xlVlesUEJFQKia0pSsJ//RjKALEN5HDFxgV7r4LU2p2YGGXOY5zNzNfMq9lHT2k/KXyeReUlx6Fit5q5NfRsl6BM2DtT+VnPILGs0IlADFE+eP9mEbF0wLRsakndPQWbCOSnwIuUX2p2x6DoQt1+NbQuWkIHoLbwxuH5uO/Zb5CHbOlUxVuZrjQc52ngCM9Gsk3QQyXIWKQzVAPlWiypLzvkdyTCShXzZiE67q+SV4NelR9+6Zf7ILjDfZpIoVgqiT9ID6D8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hlEhotFhkg72FyYq068bth7cR3cLx6PJeLSFh4yT3g=;
 b=PRvvA06+gwUQFg36m3s6N7huY/3BuvFtvZ33wuInFLGCw9jRU5lthNRXKyQrVA4aPWg0ma3E5U4lkkTZGz2Bulz4VULd8+guvwbWVpUaKWgRFghLalOdGht/IaYx9QSy7NxZLocHB1yMHb43f35nUAyN/iLbJZTToy5qInzHqr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6819.eurprd04.prod.outlook.com (2603:10a6:208:17f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:20:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:20:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 04/10] arm64: dts: imx8mn: update usb compatible
Date:   Wed, 22 Mar 2023 13:24:58 +0800
Message-Id: <20230322052504.2629429-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6cb78e00-c64a-44fd-d5b0-08db2a9520c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNs20SCJi7Y/5dL0hViIt5Mc8CQLIRCN0Z2L8ewMIDubvnQrq8on8Lm5F2U2uthzQhySFpNZ3U2YXDDqiaDa22il670aMwswHibBdaCLuWWfbGS0mbeP14bcs3wx5SJEe9Rx1pgfJ7fu1wYofBDonYlHBf8K9I3VTU24g3ITwFXpdP9qPbNHXaDDZI7b4xfhdpjYjJjTAbOYXV+qsuIQ+zF4/nCGN8Mj+AbzeCP6YVd8LVmaLDI+vtkwlt10rVTtlDuVI7Fyizuwl6G753qxbPh1zb4I6iG8Sh4OoQxZRsEbD3TCeHtw7yieq2yGuxC4i5utHRAqCfDKZnfqpSi9Lq4oIaBT+UZbPFUmNFUONF9Tu48b5FvFi0fiq0wYACtRGjLMCvq3HUf5fsunMR9lN7mRMXGkIjxJ9Xe0S8GB/jBoanHBs1zOucwJyJnujSNY88uFUdH7OBk3DNZxW9CEJCXoAqeq/dYTbF7k0K1cx/OFRIZTMyaEfDq7ViFIFs/u3ogvQpTtzUWszlaGGKlophtreqVeogD4NarRKbUfGkWahytiQXMimZBPJIzYSlU3jvWliumBS366WTvoHgQUjCTw/z54rSkEGlpIVYX6K0ft+D96jIuaFgovLjSYNEQbNT7gx90GBLAwi2i8FC2hRxROALnXvsKEWRzZgYS0HPOQ+fITah2ADRgPj6/qIuU5YPairb0Wdu0Gqf5YbawW9qtv6plwlU6imZFXSwf0zNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199018)(52116002)(2616005)(186003)(6486002)(4326008)(83380400001)(478600001)(6666004)(15650500001)(1076003)(66476007)(316002)(66946007)(8676002)(66556008)(6506007)(6512007)(26005)(41300700001)(8936002)(5660300002)(7416002)(38350700002)(2906002)(38100700002)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKXeA15A2CCGwQ19GkR6w0xud5KGovVwoD66I6tyyEB3T/cJ5kVYoTMWdgem?=
 =?us-ascii?Q?JrMD2GYOOwU7c8xwy4gFUhwWBWlrnlMVp40rK0zPwAXYRp0/8Nzxjsiy/iH8?=
 =?us-ascii?Q?kg1CHilKNzGN6KbphcdtlsCSwqe4FuqAng0dY4f5y4WR8DfvVC8Nvir+HUtq?=
 =?us-ascii?Q?OyzOAbLnxdQJ0b41YGS9vfB7MpbEVdwDxnjHJPAHPGDl/t71EtefLkulLRa2?=
 =?us-ascii?Q?5VafK7NmpOtuq5MYhaEp/wvONpBiQIt0LgX7TBjnYPkG/pRsOAgTlENFifgr?=
 =?us-ascii?Q?9XCsMJcyu8GVMuSxGWAGzoCjY7YgZliRBQAGOOOPhLLdjVaFtkJYzu5/iu4c?=
 =?us-ascii?Q?lTsen98DNc1Umo82aZh+EyV6is6wVnB5n3SzOeQWfoevdX06eGlWXtsBjINS?=
 =?us-ascii?Q?Bei8sIv1xJk0Nxt7z7CGlBscam9rm+UYaSJmBZJsPd9U7DvxZri+qodG/6Gu?=
 =?us-ascii?Q?Q7N3zwoCUdt1EwN1ueLJ8Xsb5aYE7FaVnIZzqlg69j/kd5KLLZxTfAvSamtN?=
 =?us-ascii?Q?ldCVYiOZkmg80ZD4XtVg0NstuKhIKC39JrbmEScd/PuCd6vHlZccfL416L/4?=
 =?us-ascii?Q?oSx84Go5R9NoUwgRZyIvMbjSByiH6S/fGeTv5W7Xf2XujN5WP3V4DOJf6VY+?=
 =?us-ascii?Q?oaTQe4w/i2lsuhHlnK0PLY4sTL1Uj4ppdD+FTEReF2Rj+5HH/palTKcJaLpb?=
 =?us-ascii?Q?09D0wwZXKw3mpCNBd6QXqILYLH8gf4NIwTmffeKVhmQtD4HF55gfobq1Tg4D?=
 =?us-ascii?Q?yGx6EZS693Tsx/tUcjBcj/om7Oz+iNcYzc89Dhpuqe8VsglyjlYDrNF64xDE?=
 =?us-ascii?Q?goCfZZUliRjwhVu9aFJqjrP0NUBrHa/x7PrEs73GbKTjGivI40yeGjGrnyqV?=
 =?us-ascii?Q?M2pGk84vL7KNxsrYHURWacfI4vZAwXjApccbyyALlNNpH4FY6iBcVzhOX47A?=
 =?us-ascii?Q?7ZyHEb5X0+cZok8PNpmcBNWwEGEHkV7408LGY6yu5Vhb4OwcaGSpMLz4i9Kx?=
 =?us-ascii?Q?/oRECBzR6/sTqykwGlovk5bxyA/lPpJuYgBbTUfjpb7Vdx4IlSZT5rWsic4b?=
 =?us-ascii?Q?vhOtsBg+IG4aqghOWWn/hSDy49d2R2OwksFvR5N7IyWYRkqQNaSIIdsl96u4?=
 =?us-ascii?Q?LkNmP/6IlMNVm3BgK2CsKZbi9WWatXWDHHattREsFozp5QYHDncL4gNpjS5S?=
 =?us-ascii?Q?+4/sv07C/dQelfhk2C5Dw4oQDVlx1gUd8VxGOp8qGl1p9HYzAFVsZGvzioaF?=
 =?us-ascii?Q?sWRggnhTxOKZUHYd8L+zpZ+XdhSj4Bcy6kQ0xoTZs7F3CfTHLYStCJVqpXzY?=
 =?us-ascii?Q?+IEwSo1SMgE6rxfai4cG85cj6tNT5j3H6gAdJBEM9rPqtPRI8/douLoDBr+8?=
 =?us-ascii?Q?TeAekrOyrnyjic9UwqFcvy9IAvtfupZSSgfDn5X3DXVh63Uvs/D1oVcpNXwH?=
 =?us-ascii?Q?w3dUf3n9Vv3v7Nvno2j6d78LuBUzTzZwcWspaOT0xsVFFyiO4fXl5jajTnYV?=
 =?us-ascii?Q?O0EC9gvPufKWzqjUvTw6FvUTDc1F7KBAIqLu+SI5Dk6B9+fsIiioN1aTSpFN?=
 =?us-ascii?Q?zrHobFbhOg8kdfF/VVXr60zG0Zi54kkiWXiRxZJE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb78e00-c64a-44fd-d5b0-08db2a9520c5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:20:19.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+rnbApKnvXm6BF+vkc9zgGpwJ6+xLdfLPdb3yu1gAGuBOYTCpPqHUCkB+Wp5FsArN2Xuy8VmdkwxOcY+gzK1Q==
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
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 9e0ddd6b7a32..7b58660d9ef4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1091,7 +1091,7 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
 			};
 
 			usbotg1: usb@32e40000 {
-				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
@@ -1105,7 +1105,8 @@ usbotg1: usb@32e40000 {
 			};
 
 			usbmisc1: usbmisc@32e40200 {
-				compatible = "fsl,imx8mn-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mn-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e40200 0x200>;
 			};
-- 
2.37.1

