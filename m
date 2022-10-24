Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7252609885
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJXDND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJXDMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:12:49 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A07548E;
        Sun, 23 Oct 2022 20:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsScf00KdoWPxoEgVTFlgxog8MXkUFG3v/T7jugvHzFapg0XKvdboy4/Mts7bIoFQgjQg8GPI6CQj8DnbEoL3RoTbP9grMsNmGOs0JwzTXuyRbcR0ELtH09/glo2j+EA4aokR2mlaM32HyeFasJ4Sc11SZRLNy1NfxgFiFHSEoiI+Sr3t2BwquCJVlWPZr4zOkM0Lh1Ur1oRmqp+tFwzJsvlRAd4tmDTfL1+gonEYWJLRWAIY00oCQ4AWmulzi/sSFcHeNvaTABBuukaV5m6XvOxQKqh14vyXD1cjYBGnG744LszF/8nx0iAhwrVou8P9jpGfVfosHky/a0TkDBa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIE8t1AQh/TYo6wZj/b7tgEOcuRmTY1MDCdfZExBjFQ=;
 b=iMsg6YONZaAEMk6UcbyNLOfOBqFEtbnAqlOTN7kkDSkAfJQDISyqp0aojl0M7L7/MYGBR659qWyzvShmgizDITLhli8okX6OtKNhN5+U0HPYKEYnkwXDuXDfG3hSt6Ih/SA9wFClwiiRNW1p8ShiypnJy2ADcpb+EhMT2TCg7Mx3xpww2giwk2r4ntLT/rRZ9HIA6RzLgmAN4H4H5whdqayyNkifl5TtXoOL6PKeeVtmurrrr2k/czD1JbXY4HCkNdvyzH5Vkwy9XgGeralMpQ32gUlwjUwKM67wdWhKKBFZaq9b3K05x74tzej4fya66UuwvClS6m4OLukhSghj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIE8t1AQh/TYo6wZj/b7tgEOcuRmTY1MDCdfZExBjFQ=;
 b=iXgVbVR+1xfm0i9oGkEWBYinh/6rYcXYmx77ySkQCNcUvOj8sRYA11gjsLqfChe99zrSZFKjzb6m2vGeApc7D/2fRXKei79uKYq+iM9uu1Fx1Y0+agpYZ2VqF1U1stVchbLnJO3n0KuGoFEuk7CclZiUPv8Re+35F97hjdvuu/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8340.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 03:12:36 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:12:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Clark Wang <xiaoning.wang@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 04/15] ARM64: dts: imx8mp-evk: add pwm support
Date:   Mon, 24 Oct 2022 11:13:40 +0800
Message-Id: <20221024031351.4135651-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM9PR04MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee1d40d-fd8f-4c03-436b-08dab56d998c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htsYLgJgs2hxqHuM4VvxEVNdXrbuVZ/5/nP6wSUT/fNcmnou1+X6JUegNzuNgsKuEYUzPrhvo/fVwy0/jV6Ry+OJorDfBcj3yEYYThkJPPcwqEQe8W4beQ5I/V5SNInM0LbxOKMKeun9MqlZ/3Q9bSxJaSdF8Pmn9El5PV21oW19rBjhM1pw28gtZo8B3rIYINnBc0OOLa9bUYaHfsRTTE1X6TsKWoLJWWvAJ0ciOxmhfzCpU1YqBfMLbitU9k9MHmXhHntaoSZE0rer8P426IPwUGZVCiQP5C5xxSFZo7W12gTpeamEFhr3Z2uRmIxfv/AP4P5ZRPW3lYe1ZjZZnMKPB46CLdTKF3hgA8/Fd+5Luh3HPLVILmJ7/FwGHT/iq/eKzTNhtjbiqCOZvtZDj58jx1CWTZ1FYhbuUDCtKkxhhPudaHoEiWyHkl+5qZ60h7Ayv1FrsqAH3FURQr7egXOydYD20Pq9R0vmLeRj6Wn6yTL3hGFgIKidWRYheOJyCXYG7XKXhvZIejF4ImHe0H/rDF9/EMBjFEQgCvgeRi6hxuPULBsX1N0fTRyoMRr52Kj6gh3boWc98YxichalgQtiBx7eMMtnzCPD/6V4p57DVcYB29t9aWuG0pJ7vfRUKKsd+1y8BZUTlYeqng6DiDOzF0WjUY4GFY3Oyn2YeUfHz7GBhFgWqdkVt431LDkdPNDYkupbTywENlDCnJRysMQxCGNp6mlxPVofAkL56zuS0DYX3ZOWCDmU3kn5/tE+NSonHe7W2BMyLcjk1M66CFXIKxkpUAD4KytmN7Hirah5PsESkxGWis5cUx1f6R3DkxXvKWzkObWaB/nbkeXgTJzzaEr5QAosaAYi0spwCFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(2906002)(41300700001)(52116002)(86362001)(54906003)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(5660300002)(1076003)(186003)(2616005)(6512007)(26005)(6486002)(478600001)(6506007)(38100700002)(38350700002)(6666004)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NhsqerEpskhsrrP2wjWQDd3RQseH22QLw/Gt39Nbz4WghHr6vy1G15eiFWby?=
 =?us-ascii?Q?EKj7Q9iWv+NNqG1QmsIAsqQPz8g8bS/HKK08TZtkuuXyBrxY/0yLd7i1E+1l?=
 =?us-ascii?Q?9uYMIWKY6wXUI3/3o5PHsC8yFPWfIjpv8/6QdIzwdAgBqt+YyuP1hm+VqJGk?=
 =?us-ascii?Q?W5AdDtJXQnIlU1+c2JaPILwPumca3TbnmyVfGBMVrb3AWpJ/e3QfATYxKbVm?=
 =?us-ascii?Q?tG7DNdVpoqxsCmH7OxUj8dz+b5q/cH9PDxHD/xCQDiCIOIP2hjabP8PxxcKV?=
 =?us-ascii?Q?dF1sOvcDXFweLv8nhB3q1iwxEdXU3Brn89VxjpJ59Zcwkn3ATKvdHplMd8VX?=
 =?us-ascii?Q?ErSZ4jS7dqrchO4ZzmMLAnbjxmC8B16njzf9nWwXzJ2CjOsKo6LgVswZzltQ?=
 =?us-ascii?Q?KHW3fiZIvLZYKTdkpzPDBlc9GaW1bCONcYRNkFdDwvOuswJQKjjqPUnnNwM+?=
 =?us-ascii?Q?xh0vkge7YJ1lRiPTVjq0kK/EuFOnqBGQI/MuismUF1XYK7o/1IH6xub7fwVY?=
 =?us-ascii?Q?SWc8N/rniD3kDspczexuUwDG26/SJMIWabZIPjUARueeuomsMR7egmNAzSJL?=
 =?us-ascii?Q?vrUBL1NaLE16K9+KBkOj7k+am/f/PNdUsPUUGonSC1C4aZxuBVmwXPEdyWxz?=
 =?us-ascii?Q?yJFjL6UU0ORQGor9dcp876sPuBRzgEtY0Ipt03ElBUZvIROsw8dGmA8ZYV/A?=
 =?us-ascii?Q?Z20WeS0X+qp9sVqLifNaBCVvgGnh6+I3acot8RR4kPNq5tJmiKNnEQ4AMOqS?=
 =?us-ascii?Q?AGd/P5pbIerogboHXBf+ZYTblS0Eu/Q0KNWhxZ93lbmLmKobNLmKoPuvTHQV?=
 =?us-ascii?Q?21LaxOhnDNId2a6pKiaHwrwxjjy7Bgomsmn+svhYLjGz2MKEVknEykFkiBXw?=
 =?us-ascii?Q?XZfQbJtQusmJJNz17srIxXYUB9RAY9bLv7UwtirIfdNWLnHArnvjr9vgEXJW?=
 =?us-ascii?Q?sclz9kuwAl+R9pD+SlBhG4hvNbareng1HZ9QQt2dnUBu+hNg8JsXqmAM48bg?=
 =?us-ascii?Q?6tb7v8YTk4uvPpnKXxjV6ku7u3Cak+Anqq4O32iC38CTt1vaal95jrK8uGVP?=
 =?us-ascii?Q?DmfCFSoNaR7Uue+smjPM34mEAt/DgqHNBoN9MsSaT4FVUy4oJ89Fn2crrPXI?=
 =?us-ascii?Q?sjSKcqEYMuIlBEIJHNUIYnZz3ZejuFWmRCnePVmP+k5fuYmIJvIhDSIv1ZxN?=
 =?us-ascii?Q?VQ9lbWHy+068juCMIj2JgcP+nG/dEZs5Qnn5NtuyYzYbeRaDa1gHnheYJays?=
 =?us-ascii?Q?2XwX/pLStVhjinGvBAp5gENxOUi6It6/rNkuLVwOPJVyXLkNYMTQKo9mrqZc?=
 =?us-ascii?Q?bMc/SgVvF5qe9pVUx2f53EvSvrtLy+6QeW7aQbFDY2SGKn9dMevb8qpn9ONU?=
 =?us-ascii?Q?5EG2BBxylYjZE7bt55nfnzTPjtpdQFWTVrvXDq4u0jFj+IOWVOiQgWx8Kdey?=
 =?us-ascii?Q?K1MbD+JZ65GJBJPffB2TEf37+CT4OThFDNA2V0moFfZKMszONivxHqoajhb9?=
 =?us-ascii?Q?HmzHLpk+Bg1oXmsCUCugqJboF2pML0vLGunwrp7s/oZ/YXWdt+cNoHfyvIWm?=
 =?us-ascii?Q?6MQwwT2FI5z9hd84p/9CSnbO5sUv8rQRX7yuh/85?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee1d40d-fd8f-4c03-436b-08dab56d998c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:12:36.1171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9se3FG9POImjD4DDKdoMmHDOOp5TR19w7npFOM8KaRGnwPkd+1XBK68L3X+dIJaoGHWy9vScmu50zWXYbauMiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8340
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
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index a4cddc5a8620..316390f917a4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -406,6 +406,24 @@ &pcie {
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
@@ -583,6 +601,24 @@ MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* Input pull-up. */
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

