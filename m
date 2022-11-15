Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E410D629418
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbiKOJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237954AbiKOJQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:16:16 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A16B22507
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:16:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTHf/pn3ieVBoreBb87p7QZcOit1o4WXhvQUJ/RfXZKJWUgNlfQ6pexQlj74TIWlf1h6pkgaq8Cx0aRs0kdfb4pTObO/aB/TX4/vKSzlbg6obzUcKkUlMwfh3xI9HidMo752irJurtBdZe1iHxzYDYbq3dekzmqRToAMFUem4+UCfOOryPlborTa82S6c54sgNO0U8QdQZR/ehTxTsDh6yHXDL2Fh5CE535Tnw6n9rdmf5OElFgVF4VYJweDDkns5YD4TFCLR1pc0F++lWv4KpR6mKgh0nMuzOvJISqSq3w6xpoczDNDYBcRmmRS77IvdopTFE6jgE3Qt9oxlFY73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqQhrYUqrPGsX58WHIHx+VjV6/HB8iZfsuonkjP5t9I=;
 b=a+b5j1krjhmWdreFUfhqWiRStyxaeiiyt6/yBkJ+y7ltRmDbLx9y5yR22glB6RKTGm2lHfIds3izqe+ck/p9fNPKxXxYCiJ364+udFXqIC+a1xbyj6CIPBVj6Jur9qnG/4CBzCjL1PCTSXgKVQDyYqh4pyI+P3oU9rTHUOArgyTS30GhavLpdyvviNlWP9PSsIG6VxdX3t8R4kmaYlovb2irz9stdXSnn4DPZtiOziILxKwO9dk3XFxmcIoDknVHrFgRqtl+gYMEUs/QxIrFlGNDOIfsvqbX6f0phCGkKNXmeOYegtV1uht/Q152NDrMKolTUxL2EWUxRq8iXACnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqQhrYUqrPGsX58WHIHx+VjV6/HB8iZfsuonkjP5t9I=;
 b=hsDJfW2HSOrUsM9gleqpOlR48MpQEbecjV34liC+pWfrlb18PiTrqvwl0iLVw3ed0v7UHQeYAxdYGX8aEc6IGm+K+/2WjD5/A3IO5quGsphk5JvJHRiinYwwxEwkDL5ds32VGq5Zeq0v5sLXZU/SlVcwnbknzbNUOqwDQct8FZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 09:16:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:16:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Han Xu <han.xu@nxp.com>, Frank Li <frank.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V5 05/12] arm64: dts: imx8mp-evk: enable fspi nor on imx8mp evk
Date:   Tue, 15 Nov 2022 17:17:02 +0800
Message-Id: <20221115091709.2865997-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: a0175144-89da-4a80-961d-08dac6ea02ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpFVoh8fdAH/YNJ6Caihzlu0tH0sXjh7zcTAKa2tSbdHK9cfJYGKNguSaE+G42uXh7TqPkiwcsuLUHoHjbEwQkxEZe+AE6u0hNC72h4EyNDHvKyryQo9EtxuXZb+m5wQKSfWSEHGDxoKf/OnG/I+tNRauudtJ5pbpZ8FeY83FhCvfCslA+5vxvFoFckGAwWDxQHaIKtEZ7+YblDRLHr5P5k7kFwwQIOlOBweoPUH7C4b+SSLRnxFXTzkD8wpnG13jaozg7OY0phDA25XDl+9H++joFSQIoE2tQogpvmXfI65A36WiNUPif3ZtO2b1qEQkOfHGMUD2KA5wRZb1UBhTGNEAll0k/b2xVWF38Dakr4JQsHCdItyn0L/WyeLhumO+K3A4JCVw/ufWkTtRd4+VwuIvOp02K5oLyPrBTV0EDJXTSUXbcQaH//XMS/sIo5q26oZR1XyG/yXDHblabN+8Cj04TcQwZxStd3DHxuh+wOCEMHXDSDPVBoGKuUHXtBieoh193ZKv2HEGzLPDmwbJut6jyZJHdAhk+KByHr9wTpEzccumvg/Cv7WTrpnOZHWgc4lJ3Rc3f4/F+PERg75H9R/4frFnGIJwmLASzujfZpdKEuHY67AL7DhnpSVHe5WtfauG7wOOKg0tABrePWkhUib4bekxHLEVNRyrEiiw0hrNkZdb9HOhztVRqCKYsi1eP8808D5M92Deyy/h/RSbEWhoQpDLiwYZb5QSwr/feCYdagSg0A48KhTKu3r/Vc6qUwjjSi/IgCmiAwhpE2W4we8M5Stt6qyhh9J1cJb0Wc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6512007)(52116002)(86362001)(38350700002)(38100700002)(1076003)(186003)(2616005)(2906002)(26005)(6506007)(8936002)(5660300002)(478600001)(6486002)(66476007)(54906003)(66946007)(316002)(66556008)(8676002)(41300700001)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uXwEDmZMXL3e0kkUZ8P+hYKDapa6+ANhqNLPA+//WESTb680lNodntsvZlod?=
 =?us-ascii?Q?fH1eCfMZiuL4MH9wi0fPWXL16/Ji5IwiCMd1rz54ZusTmZ3U8hkVyBWiZGUl?=
 =?us-ascii?Q?xci0Xewwr+DkbM3ugp74f/HQX2yf8DCTlpY7ZMz3u5HRntnhA+bStX4QZ2w1?=
 =?us-ascii?Q?p6Ki/uS5ATysamOsgAhbFU0NfFht1I4Qt+9UuJyYTXpCDoudcxOnwnmq+aST?=
 =?us-ascii?Q?140q58jv0OleOsgRjp74Y929wG9aIUve/EUK0D92L52uN97e9Hy4hrtFqNL2?=
 =?us-ascii?Q?milQjmwm4bttdk+RcJ1A7T0y5M2VfspWEVTiuLtlmZfVEgRcGivsyQrmaJJT?=
 =?us-ascii?Q?6yI2hNv36zYVHuUtUcjhdBkspudFu/LtZC9ibfkJFOjwfAql3oHvrSfkyfju?=
 =?us-ascii?Q?yl9bPPVJPqSi+bO2YlrI4ORWi5jonTC1Z1s9SIhzqMXyRQYNtiGX8I4rc1p7?=
 =?us-ascii?Q?RIa+HFU8rYYjKtxpP6tViU3G/HNtaHqDhsDnpTvPJfBAzuSQMLZLHe5JLeTx?=
 =?us-ascii?Q?OsurFjO8p8XUIRDAnsHo2Bi3Hfb3q2hKjgfe55RL89FSfTfL9kmuB47UNhTq?=
 =?us-ascii?Q?e2dVylrIYkaue1FYf1RyFg8GJp6QElmkabBNV5I9tQRsuurTL/APxVmu8ao6?=
 =?us-ascii?Q?TdI6haa9D93e0Df8AhsMk5hkCXfStWhqK6VLyAZ2Tw7wED9w2NgW9wFtSjnn?=
 =?us-ascii?Q?4xHLxZR8znLAu8UNdzk9Hw7uSrYv5ZyxuJowwwLGyWOIk6iJKqdsrrfCeEVD?=
 =?us-ascii?Q?o1aCf+bRpQZybnVNdwbcG52S54ywvpB6dM7fGzsoWUuAXLi0q3Fv1ZeKvzcF?=
 =?us-ascii?Q?e+wD3F0H8ghdQbfvtl1IKvKTPJY6GT93NGxoNWvMHa6AxfKHhtgwnaYgRCxg?=
 =?us-ascii?Q?7VMwGzOzD1TptPHWWtUfLrcd3Byov1P/+SfcvTeLsr29Rf5va7Jk1qumO2Qq?=
 =?us-ascii?Q?hvx8EbueNFv/e3C8z9MwQNK4+R4F2EnhUpYcBi9SnxFU+MTDdKmUplvHK8l1?=
 =?us-ascii?Q?ggxd6X4lb+FQ7Y3YOfo0pNs2+ReHtraandkVh4dFRT6lnVEeWNtUyKVEUM44?=
 =?us-ascii?Q?1qFuwJA66oBRCZdyKf/84tDAMXeuccff56/1vH2aChCawNEzwBtjJw95mMyW?=
 =?us-ascii?Q?McUHr185+ZldAnE910jjnrvAhJblUE0an2NTjx6yxIeMcfX8sRnPKEm1SW6O?=
 =?us-ascii?Q?YByEcFGFlYe+n3uIuUcZ7NDklDyKrueec3slkDiWBRDnABSVdM7wumBUNGgA?=
 =?us-ascii?Q?t1ITAGN253olYOJ1AwSvIOS8lrAygz0/5eQ5B2JvgOE0Fd3qOjB+uWxNqqFm?=
 =?us-ascii?Q?EN5pQADIVrBLfJPZI8W6+eXaiyzqZqgLSsUiuEmc41G1vjR7ZXAOZ9Y7q0MY?=
 =?us-ascii?Q?CPPc6dMhWabG9Ya89jrWMvnbvADw5/rGCNLHUXZqFVn+RspZOAZqceVB4HlK?=
 =?us-ascii?Q?Akberit9LTN7h1obbIWi0ztdknRLhbBVsNu6E9whp/lW5yAQHjs1WpPr/ZhE?=
 =?us-ascii?Q?eBNoNgIXGAYIr8ga6g8UTQCcZ9PN/jivDDBTY1XlmQx1B7vJRmTfh7oZllvp?=
 =?us-ascii?Q?i2EcrKmpc/ytPUpE5P0yIYd4gcBWwo16rDQ5TxQ9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0175144-89da-4a80-961d-08dac6ea02ee
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:16:00.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROpuxnol8ZFy5v8EdU2XKBiLnLfQ94A7OSh/JqhxXAlNG2aYXf1eEJPauoF/DU2wZDszVglFbbX1Rmzry5f/vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

enable fspi nor on imx8mp evk dts

Reviewed-by: Frank Li <frank.li@nxp.com>
Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 29472502d547..4164f69a89a6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -85,6 +85,20 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 	};
 };
 
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &A53_0 {
 	cpu-supply = <&reg_arm>;
 };
@@ -551,6 +565,17 @@ MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK           0x1c2
+			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B        0x82
+			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00      0x82
+			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01      0x82
+			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02      0x82
+			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03      0x82
+		>;
+	};
+
 	pinctrl_gpio_led: gpioledgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
-- 
2.37.1

