Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CBA6C6DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjCWQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCWQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:32:26 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4170D35ED7;
        Thu, 23 Mar 2023 09:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDIeVyK+JKI3QZk5u1feYc4+Ss/ScwgsNWhLJVhgyOgq6YMR9bR+BIIGPoFhBGikZ7IWYrY4JKJTNtcnqhbS2M7sLqOPxDLlb805sHP0uMAz7nEUJBuaY+19JQjLPAkYE239IRJ620jB5hzaPddy9Rhe3bQ64jt7g5c+uF7VcyHfAulm47EuiMlok3dPsVgpVaxz/uHrCZ23h5qSu8PpCZ89VKMGWLycMFjzMXBZMxw/Vv+ERHTdvIE6FeV0mmlucZihQjokasPyZiPSX0weVvwUQPtjZ78h3K9gRNK6YW6LOrls5v1FY/dU0qUh/kx9pA/wfLPoMHCgg7WQtoCx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjejZvwnMde33FvDsX0tRKy2AfY+6bT9nKsFQeO3/3Q=;
 b=WVJcCH2KcXx6WznPt319ZtMwyukp0wk1LJeiK9ImqtauAajQcbVY7OJqWrE3XmfcQwmLcBpACWfFjBKlE5XQRNi7A62bwqIVjD7rxOao+02D5pWi+X/Jr8dcmlr9aOGNQnnis4zf+iQOMzJWoweuggl8e506uQD4UkD7/LbitAgF5SUI/7XL6fvg2mvHCZ6h5Z9we1oBWujXFDrxQvZigq/Hv19NBciT1qRaf1b1vSVDu/ft1ot/sT434Pk0/a7e4NxyKFrkff/C9zaZrnQQpdFINz3y2cs7gTqvTSbJDOnMKt+xT5VXVRI2v1KcUFxsFX0YsToYVyapdHfrHaRCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjejZvwnMde33FvDsX0tRKy2AfY+6bT9nKsFQeO3/3Q=;
 b=EvLW+meMEqyH+eOqkm0NG6vqV4yd7E375opoWDai/POyj6HhWbMGyg0eT8pzOyFg2Ogro/sf3Zlw1iUlSeyhlBGK7JhxSmondc7bXfvlFXon8+p0xbkDXJ4AY3tAJxgu6524Y7s6CO5TDxwdK9sV9CSM0pTfajyXO7BdspBhNHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7789.eurprd04.prod.outlook.com (2603:10a6:102:c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 16:31:46 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 16:31:46 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4 3/3] arm64: dts: freescale: imx8qxp-mek: enable cadence usb3
Date:   Thu, 23 Mar 2023 12:31:16 -0400
Message-Id: <20230323163116.2921999-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323163116.2921999-1-Frank.Li@nxp.com>
References: <20230323163116.2921999-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0ccce8-7ee3-4232-e369-08db2bbc1875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8mRvFhdQ5TcGXGfsCjbmT3o247NGZZ8QMnrTzz6ZIBHQF5g+kFWEUrZFOg4Cr1GjgO3bYKo8syWoKTbvku6XqNJBrCtmga278BjE/kQwIys8ZecPHUijJfDhleaiCMSBkjRnwCQ7K5MqtZgBOBqydyr2mjsOd7WxjKn9io1JB7ceWQmaPEoWFqJXQPSdwVsybx6LW4tyjwJQkHmde5fncqds/+7ytcRJo3PGPYZCeY9xqrXXL9WEcdGnux1kuYSscePkn3noiN8AA/O5Kh5Z7M70K3rJSrBQQToTLBLH3aJOb09gJwjdsjC7/bKI+LZnj4m6WgPjwtIN1pFqIjcAS+8lpYzvZpXxy3ppHnjMy1zqtWHT+2ls/i2cPJP6/2WDt1dO3W/iw/t2iz10NEV7WViunfXgrQON95ERFgVrbJ8Qfvocd8jSNjIvqJDO3ALLwfqf59j76UALPajvWVePNfZAkkLiVuJAA9FMuklHvxAR6fXskkGRCV36WUFhcx2lB+lwMpAz34LMeILtpkTbWbI8BBzn4nfnXFMyWLfAmyt49EW10dx9VuIuYcOBAUAGyPJ6h5WJ7cOYZnoC5GJcGLoDBDFKLASnDXwc/dLwuSi00xcvCtSiv9te5G1+I59Z0pv4jaC3LVSayRhR4b3QbKA/F27t967xSmjzRoMrtWZnXB32+cTw7zdK8OWWQ2BZytwQpomkap9jZWYiO9bK34CUolbKIFmpW81rS4rUxc9ss6TOBbt+H2bAwX4kJmP7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199018)(38350700002)(8936002)(34206002)(66946007)(66476007)(66556008)(41300700001)(4326008)(86362001)(8676002)(36756003)(38100700002)(6512007)(6506007)(1076003)(26005)(2616005)(186003)(6666004)(52116002)(316002)(478600001)(6486002)(37006003)(2906002)(5660300002)(7416002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cyeXRmHFLeg5VxT6lkgEQ0MKvJkDj4aw9WAD6VCg0F7ULPsRI+uA325jD7sp?=
 =?us-ascii?Q?fmy/RaZD//7w6otR3zHm6f1J70pusP6xFKVEC39OAe4i2kljxwIQQfGxFf5l?=
 =?us-ascii?Q?PWvu7tOX3nnVB+WK/JocXbzheCTss3iheBz+Q+gypQWzBFf4s6V74mG1MgwA?=
 =?us-ascii?Q?Z9jpstwty6Al/GhHPx2jYLWizOV4GwjNV8YemQ7jpaMc/raB1atz4eVz+2vb?=
 =?us-ascii?Q?4FkWb+S+90j9WQzVa9uuD6T7bSrP+7ptrrkdA8+FVipuWEyRJzprqMnQzWvN?=
 =?us-ascii?Q?xd2JW/FnpKECrnS0T/+4VH0FzKDn1OABSR2c4KJ2qHNS8nMky5dolC9DyWxK?=
 =?us-ascii?Q?InAZT47Fjh0wiuh9em3+nkwlxms9NMmusEg3EFBJ5LHTHy3SMaz85WY9e3Df?=
 =?us-ascii?Q?EolvnIETlpnGdk3GAXX6LLStrXCVm7ovaAxHyMIt/rdIF68tQz+9SXaEfefY?=
 =?us-ascii?Q?TGKuGhU1Uk2xGrROzbrUmHqw6/zTK8kxOa0hl72dr3OheV/Gvk3cuTz/fS50?=
 =?us-ascii?Q?ID30qVomrSUyOwHgH/bo1CS6NB+Tp7fAN6QBEGzDNu36g+0jA5M16N5ssuth?=
 =?us-ascii?Q?960Lam2aC+1zsPiF0vbii/nBs5p7A3PxOdxSrbUVijVN/1OJKyP748QDjYY0?=
 =?us-ascii?Q?SyFZEkuzdiF32SN/n0jKBsWn+r1qDRScw5bAGkhyd46B+tqzhc6FeThN77nl?=
 =?us-ascii?Q?xdPk3ZbAPm/b0w1WmKOItGl1hWWPuYSNTRBxTprOR/TfJ60VgFVmx+IB/oC2?=
 =?us-ascii?Q?3dZxBVZ/SEcMiDkwDL8VN4pLjRMckhZvYUdxCkDEBttC+814DL65jSM1X4Qz?=
 =?us-ascii?Q?Q1PcvZS/AqZPMZC6Vtr60OBSifNj3lzIBLuuJsVtETP3n5WEylfOAj8nLTZX?=
 =?us-ascii?Q?Beq4jlA5YYVpXJK4Ve6j9JLVY5tGTlo5Abwgz81oP83F6HoIZJy5uIkKcC9M?=
 =?us-ascii?Q?/t1tBQmji2SXbsvqGYaTYMicOxn6pA8yPlhTGciAthkVteukSJSB7GqoeLjK?=
 =?us-ascii?Q?UQ1D5dQP4qvg/h6VyFuQ3sYzfs0ZHLG1rsOl9hybB8UtgafP+jOwQ6CxFOOA?=
 =?us-ascii?Q?SdS/mFxojqPq18nIMBd1Ge46WPBnZq6B8ktmrVo4LBG694NkeE2ktdfSjyVN?=
 =?us-ascii?Q?VY3glunApMCAGXDe93NdzNwxroEHixFN+uhWBZpQ8duIEot20TvhFDdVlFQJ?=
 =?us-ascii?Q?9rHNdp88yq1iCGjMIJVEmJjGrlsNHIgIaoMWRvOFkrvcGPvCJkHq3jg6hHPH?=
 =?us-ascii?Q?1bLEyTFULVMvjbEDxIhO6MtDb493W1c6KQJ07iia+GaJCNFf58yXenT8fGrf?=
 =?us-ascii?Q?EVTB3weQbirldDiuA6263owKKEe1M1OPL6+KIgy07mz2bqUnC8wLzDUgruPx?=
 =?us-ascii?Q?AerLcy4K1NZVzYPUp+0xc0kH2LLiFZlJ4e+UFHRyik4yZICIZY/3alVJ/38w?=
 =?us-ascii?Q?Iw6/ybrUtdqqpaP4hKvLBY7/oTxMh2em0Aj2laqOkZnd/XQPVequa3BCKN4f?=
 =?us-ascii?Q?IlGdG6V64Xx0HBvmmu5uWp4jmPDSruj39/zo2iRPhsVafIUimA+9FEwE5B8y?=
 =?us-ascii?Q?xM23rrctknLKt8Z5q9sP/vNeI2QDf6LgrKLfSm98?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0ccce8-7ee3-4232-e369-08db2bbc1875
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 16:31:46.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrWIIhbCklEkxTdILGDDengEh0VHtT5rKXXFycK6VB4vzcwCl8iSWwhNt2XdEQKh0QclkPJF1lR1oF/TDn21Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7789
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB3 controller, phy and typec related nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
-none
Change from v2 to v3
-none
Change from v1 to v2
-fix shawn's comments.

 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index afa883389456..9ba4c72f0006 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "imx8qxp.dtsi"
+#include <dt-bindings/usb/pd.h>
 
 / {
 	model = "Freescale i.MX8QXP MEK";
@@ -28,6 +29,21 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	gpio-sbu-mux {
+		compatible = "gpio-sbu-mux";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec_mux>;
+		select-gpios = <&lsio_gpio5 9 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pca9557_a 7 GPIO_ACTIVE_LOW>;
+		orientation-switch;
+
+		port {
+			usb3_data_ss: endpoint {
+				remote-endpoint = <&typec_con_ss>;
+			};
+		};
+	};
 };
 
 &dsp {
@@ -127,6 +143,42 @@ light-sensor@44 {
 			};
 		};
 	};
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		reg = <0x50>;
+		interrupt-parent = <&lsio_gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		port {
+			typec_dr_sw: endpoint {
+				remote-endpoint = <&usb3_drd_sw>;
+			};
+		};
+
+		usb_con1: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "source";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+					typec_con_ss: endpoint {
+						remote-endpoint = <&usb3_data_ss>;
+					};
+				};
+			};
+		};
+	};
+
 };
 
 &lpuart0 {
@@ -204,6 +256,27 @@ &usdhc2 {
 	status = "okay";
 };
 
+&usb3_phy {
+	status = "okay";
+};
+
+&usbotg3 {
+	status = "okay";
+};
+
+&usbotg3_cdns3 {
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		usb3_drd_sw: endpoint {
+			remote-endpoint = <&typec_dr_sw>;
+		};
+	};
+};
+
+
 &vpu {
 	compatible = "nxp,imx8qxp-vpu";
 	status = "okay";
@@ -267,6 +340,18 @@ IMX8QXP_UART0_TX_ADMA_UART0_TX				0x06000020
 		>;
 	};
 
+	pinctrl_typec: typecgrp {
+		fsl,pins = <
+			IMX8QXP_SPI2_SCK_LSIO_GPIO1_IO03                        0x06000021
+		>;
+	};
+
+	pinctrl_typec_mux: typecmuxgrp {
+		fsl,pins = <
+			IMX8QXP_ENET0_REFCLK_125M_25M_LSIO_GPIO5_IO09           0x60
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK			0x06000041
-- 
2.34.1

