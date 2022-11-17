Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13A562D779
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiKQJxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbiKQJwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:52:55 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705036D482
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:52:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmGg8n+mt9jFoC34+HrrRPMuu85IL7ZPVS82nqdte6vETgbE4FjCsswufUJ1XuQtwC92qxMIrQcE/yd3ocDcdpSadh/b5hxwfKF1QXTaC1tKmmpVF9dzfh2Thk1v1DGSB6JBTDVOAztQ6vlm6mlnqSkdPfs7wjwSB7x+Lft1j6q0ZuDvuqBcjjP8BXidg5JOYR53CZwzaw18xY9L6c9+7gBBV8HNmO24VDSN4jm8UvUSgfZzYmochEne34xelqNxKMEfBljgvCj6+eXheqnYh4qzxvPIKuwpHzFTO8cRF4zdNCaXaiTOPTLXYOht7hP1oI0oPXin41iQ+02wADDnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94TR/gJ3QFYxCbPvYw8g71pvCpJSSj08ePQxdLAnyuQ=;
 b=jxpY5yitDooqtrBy1pYvckO9drLC0fLQzUv8qcFfFiLSj0wXp9EYic/RfDEtBtc1Jzottl9TVbNehkFIBzi2Fh6OTqqE1w0MZYTwfGauohPA2C6o+5br/IQzffB2nPPkAeQng/IXdA4CJ/kIds6MfKVWA4PoO6F0DxnnYk3AA2BTXmekjPH1ML9BR0ip7MjCJ2/fahHfG/boF6IlLopmEQ52fqf0iWxOW4pnAOnsWrmT3ONwIalP3Hlxnj/CO6nrt84TBxtI0BTyD+K6ZKX/0t5uamFdgbS+eB1UsEqqwEhJQNthnNZSU3fYJram0qSvkzaTDt1EnFguX7vugxMvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94TR/gJ3QFYxCbPvYw8g71pvCpJSSj08ePQxdLAnyuQ=;
 b=LcMB0ZXp5CQXvwSAz43A1K0D/brZk6Wk+acZ+4HcLwckIAs62rgk0m6HbC/Cux2F4muIb7efMQJtofGOfPw5WolsWJl0Lv3uEPoTF6nq4CIuZwUXH4hk6/JvHIDGfr1fRkcoHafDIWv5pVmd7kxwHu/kvyTaYCf0PxTLyIBzyPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 09:52:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:52:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Clark Wang <xiaoning.wang@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V6 03/12] ARM64: dts: imx8mp-evk: add pwm support
Date:   Thu, 17 Nov 2022 17:53:54 +0800
Message-Id: <20221117095403.1876071-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b32747b-d810-44bf-c959-08dac8817b9a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iw4a0VoSnSNUigNX/2qiIBxrt1sdwCisWeBPk54AYKCr5xtxGTmfNkOlQZeFlTQGlgmqGBIcPeFANnUWty1HiNoEv4EIF6SzmBtVc7rd1Z8EFrg9yMZNmjguhzeUsO0hHMOsmeK23d4CV+j+os+Y5KgMqs0l/55+JNQyXwpPlJSSvMgYfyrjdwvt8zXVde9z2PVrwYiQsjMPc54nPKd3s/y0oOhSz2N4P2vNAepZlGnrnixJy/xL6ZPYBIkKckOblmrNrWzSqQDGIxvQU60Do1BqNe+RnHutSRxpZjQDbHzoVjehEvS7oe9dIP2GgyLlMKDgc58fTjh2GxX9oBfxZzfg4hnmc4jzixWb6nMFGx3Ao0ycU0LhvddAEx2raFnU0Y72zEj4y8Sj3Hzpl9pPQ5blKh95CFIBXKHCGkxB/3CmAJMCaT7kNNQg3djuwGP06ZtGYwiQvTz4b22m2Zbai4m6/VojN7SFGXAjCBwQxPeoImuG828co5MmMul1lZ2A7YOPp7JsIWhCDBluzNRJhP9rIpAvPj6a43CokZkHNFyOcuHQ6PHQkOePhJnUgiYlcjVgoeHmROBMwWn/yMQFpvA7w6Woz2ojGUw8iX4PsLnUfeUYVQ377mOVzMEIAgYBlc1B3n9/JldOiolYfgDX8o//dztS1gabJKuh+mfxQyTK8hnpvft9HftbPowG/gaiRyVkIBnCq4ZVE3FW52lD/cXa3sB4mVQcAu2xT0wyYbrsNQnDyunsQpxR17XcqZCpbtnejaX+IC2GKYGS+z5Nbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(86362001)(38350700002)(38100700002)(8936002)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(52116002)(6666004)(6512007)(6506007)(26005)(2616005)(186003)(1076003)(316002)(54906003)(478600001)(6486002)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxUmBm9esGcGCU9YQRgP+iIvSHroEOb3ImyeOgPZzVpydVhpji/OpUzAS/jD?=
 =?us-ascii?Q?Mf3Wfg3B1+Uk+J+sRQTriasGRRM/l+emXLZsauz/kXekG3vl3OEu+hKWh4rt?=
 =?us-ascii?Q?wrp78hdK2fw8tSmjJLYBQlxaYo+tf64YqVS6vU81Tj9qVN/iUnVCFDsG3V9u?=
 =?us-ascii?Q?tp/z1hz/EosbanrMfuOC0YToEjt0aZKuoFvG4KfosRn/04HrviIM2Z/cYibX?=
 =?us-ascii?Q?by/+0txYvsDVSwSzQldB3mh/BNqCvTbOqqqP3Gw3GRofY5IVZQVPVjR+Q68H?=
 =?us-ascii?Q?KX8xEEFyvxqKHykG93umdRjjjLuJX1Nt2W2N5YMlBQAvX4ABclNbrfeXN2X5?=
 =?us-ascii?Q?ldjJmbLm+eBwSbA3SlTZlBRdXFVS0V8qC4nirhI3E4v1AlIm5DEa9wEy6q5g?=
 =?us-ascii?Q?mwYueyTsuQpx3CyOAJSX2DSYbWzpi+pz5mVGK49F8c+YCs3Cecb7bMCRiUZn?=
 =?us-ascii?Q?3MxK1pIcUkvDeq65pcr4uSxS9gh7iji/U1WsccEABLe09t4aWayJAv4ahmro?=
 =?us-ascii?Q?qs622Al/4tgZdmJeXoCKv+AP3kEhgK4r9W65S+nI7t3kDhwOlDJsgEzCeyQl?=
 =?us-ascii?Q?j4B/+4mY+V1bgaaZrk0eObM+CrBIjfCJ7NS1r/uIv5QW2xGbtL2Ak9HGd1p0?=
 =?us-ascii?Q?wBoMxVBV45P+G4RKTbHM/T7olbp0zlOFbXUAP6ngPt8qQOdxyoXEP3AOiXjw?=
 =?us-ascii?Q?Jq9Cd259rm6Bwn7X9XSVeE8F9+ky/UFEmqtyxrUv42YYkXa2SDXSzwSosffC?=
 =?us-ascii?Q?fexKeK4kP3WdxkJr8X5smz+KYlEoVyOtg17+ItuTTfSryoqprOgXofv8zM+K?=
 =?us-ascii?Q?MkXslGOBzjQ3KN5BvPJANz9PEUZq2fSK5w48WJqcxgiE/n07eEa3AUfAf+l4?=
 =?us-ascii?Q?WHw4YXmWMQ1hktkNrSuYBjqpPQ0a40opwBEm64xL5shgx4wsicSK+wdqtVBn?=
 =?us-ascii?Q?Bhb8ewLHGBdImixRLP5H55E7SrUuxiQK1fxLGH1AlgjEbO0ljshSHOLULQW5?=
 =?us-ascii?Q?17dUmRfjKzJIxINfmy6zOSk9HyJDgaFqqNEzlTm2ve2SUtAZSsu8CNJKvth9?=
 =?us-ascii?Q?5zSf7ZBKfOrPNI/yDxYOAl5Jnh80ceP762LG3E34VeIGu7C27TFpAGYS5ygx?=
 =?us-ascii?Q?FCrJbtx+JEMt4lvZ31Gao6QUyemWznX8AfGH0bNEBKuiWaVCIz1wVPRDuz9e?=
 =?us-ascii?Q?9txNa0QHwxqbFh0HDuXgBAjd+o8C1T7yG7XXRxJz3Vos0enZzX0FKolyzNaX?=
 =?us-ascii?Q?wDrenKgLr8PwAlKJRBn56YP6FEH4rj1aWwKUHDRnIhokDBaePKhuCpCLYt6t?=
 =?us-ascii?Q?IOVl5i44QYNGN+oa27aV70X/BMD+P0sdDcywuC9B5SFMMkfOXmgKoxetHuB8?=
 =?us-ascii?Q?OcBXwdf5PpomdDyNwAzqVsGmfvDPK3N4irnXzYEqocd7ow9w+pKNrb3OodSh?=
 =?us-ascii?Q?2y2TemS7FUnhjOxo7tnvYVdPMuE+SxUNKQbdcbxaiR6Uj/w6Jpy/MVYftw0y?=
 =?us-ascii?Q?CYSraHrkiu0OpyoNdXFP+Xg9Pl9R/DpCSBNc48TduYjc015FNT7qdKL3vXUQ?=
 =?us-ascii?Q?Iy616l6r7XbhXcfksQ/dfjhRdwIj8XjlgCTMIJch?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b32747b-d810-44bf-c959-08dac8817b9a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:52:47.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Va3GCkw4ql5FvR/3rWhLigcEaFSgTj8btIbXEGwpFHzg41evD7Q3voFcaBWwlRRQtchh6XzvIKE6yJhdlqXjrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7702
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clark Wang <xiaoning.wang@nxp.com>

Enable pwm1/2/4 support.
Enable pwm1 on pin GPIO1_IO01 for DSI_BL_PWM
       pwm2 on pin GPIO1_IO11 for LVDS_BL_PWM
       pwm4 on pin SAI5_RXFS for J21-32

Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index b4c1ef2559f2..e323e6f4b7e5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -390,6 +390,24 @@ &pcie {
 	status = "okay";
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -567,6 +585,24 @@ MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* Input pull-up. */
 		>;
 	};
 
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO01__PWM1_OUT	0x116
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO11__PWM2_OUT	0x116
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXFS__PWM4_OUT	0x116
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
-- 
2.37.1

