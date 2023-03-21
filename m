Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461526C357F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjCUPUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjCUPUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:20:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C57113E0;
        Tue, 21 Mar 2023 08:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJC4pyMrbcIjgTB/vxOGl8fwN1hsNkNkuDp7Q/vu7GZEPewvvVd+qO4oeaR+Yi9OarPlhzs5F5omxmsLPO79PNwxZwyHf8rsMbUcRrPynZMy44+ya993pTEMyjAGyrindz7pnWQ/GM1YYmppGqfZ9Pr2l5QP46sKgyizS4106MvKk+5e1FCICSdw3fYvpNGbbJKPjOfb+qCBask1UqvOQkmDvWQJWSw4pRDBuyG9HqBdt9RLHHR9bOTZq+rx2CUp+l7d6nkCzsRu39AR5VfeK4WJEHKXwp+X7toOgQNOc+s2iRDhb0roo6fNLKyAmtNyd3TgO1an//g1W6JiZ6hHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiCfg2sbposVG4AshhsZtpXQkZDoheM9EzRdN54sZqA=;
 b=SBWUJ4wIQUU5AKEEfN87Pvu69eWDMqD83szpocuEyhtDQLUVV9ZmFR4SsTzVdxV6/jfmzsmjqG5L47Kz/dh0vHraDdetaCSQj2FFT5lDxy6F6jSBXdTsE6Nr1TQ8ND6hCVEQbhw1rzLNS8yv2FqIn/2zrTTh7EqUM+cCefqI69flfBWcw72q7yCnk0CcqmEWqGXhATmVOhJGfgF/D2ZmFviWFFUGHguLOFVbFPZ4IMykMpKxu+RQzho/QhydXeTOOVfoMe4RN3TZqXacu15HIPNaRtae+0rumbQRtH6IXQyp/C69K9pvqi0uNfezqaAkz5bo8j2A7CpZHfmiz9o/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiCfg2sbposVG4AshhsZtpXQkZDoheM9EzRdN54sZqA=;
 b=Xism+cYJFTdhphpj3yAeicspIs97nOO1NFzFbXsNVfx6xX8pLz9hTjUzw73DOg94mdfSPdwm+azTyZVnTjKd9w5GSdwreS2X39QmHi+cOi0718q0xL7QJhCfZqMTkzW2PPaP1WdX73b7jfxfAx31z5gqF7MyAZUSt4+KGWN06hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8819.eurprd04.prod.outlook.com (2603:10a6:20b:42e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 15:20:20 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 15:20:20 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     devicetree@vger.kernel.org, festevam@gmail.com, frank.li@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v3 3/3] arm64: dts: freescale: imx8qxp-mek: enable cadence usb3
Date:   Tue, 21 Mar 2023 11:19:51 -0400
Message-Id: <20230321151951.2784286-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321151951.2784286-1-Frank.Li@nxp.com>
References: <20230321151951.2784286-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: faf22b86-5704-44cd-757d-08db2a1fc892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdEctXbx5Fbt14dQ/QGEglwBGV07cNDp5SZzChNxuFk+1BryC/F63owMJVV3QA8k2EerZsfV6SMFKVv2VxPJCIAnl75Xe91U6PrOE5GvhP7H1ZIa6PhKzLnT0yUw7dA+hdQAezO7+WPMmO/RXzg4HnbkOIp3j6N63yRtmAnzfhPUfCsawQ/1Wfhw2M1ZNaJPhdWMACgryvZSJw48xMBgAT5VpD6hRSLQbcTLUJt59qB0pRJo9E+nn2UKEaIyoSGdS4FGZgAAXcasJbrvELvDnGrCntT2JxYL7xxhdflNClAaJy8fzlc7J3mJE7Bghp+xujMqNq7kuu+cgtUtG9LqBi0p6phhKe2YgHk5nTCQpjWbp23Yie34yDqKkGwtmaRbSbpxQSETK+dcfz0QVctMkn5TwQ9OxMfeNWqdHiNMNwZCj4zVYK3RROEBhUa22DOE8LG9xU+d+W5LqM3lxuu96NggvTXzjRrM/FUfNBgAUv4iXl14La46cqikwyJjWsNC8H5RdWwEZyI3Sx06fb1q5TwkO5UJcEubc2Elq/4yDoWq6+bsgU4UkV17ZAjHcK5qbbtLQIWur7kJZwIP97pAHK22b+/Tm5SQcWRElAcwSnLVozi5jkpLIKTWbCBMIAeBxv8Lc4M8vK/DJWut8RACLh9i8J+BY0YnlYZ3+2NVVQ6aHRiy1xUQFDOo6eBVsZyfB36NCVW24jPRZ3cyoBPqw7LA23XzKhTMkrKFHW64beVdCLq2yxYTzLdxXggIRJIU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199018)(8936002)(41300700001)(5660300002)(7416002)(4326008)(86362001)(36756003)(38100700002)(2906002)(38350700002)(6916009)(6486002)(478600001)(52116002)(6506007)(2616005)(6666004)(186003)(26005)(1076003)(316002)(8676002)(6512007)(66556008)(66946007)(66476007)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hy7W965suAXQjI2Qnd/yQJuMGVf7+iYG9y2HI7qIHbmEtOUyY+ITXbjCsGQ4?=
 =?us-ascii?Q?tnTd9wUM0QhznIgtB67Y/T+Kf/oQPYJayBx4sHnYWlkmydJnhceqENyQCV+k?=
 =?us-ascii?Q?tQfhw2YZl+BhREs8ZlgN62ItigjIDVlQ298zBw4GyOVI+AtC5TOaxRftuHQ9?=
 =?us-ascii?Q?cLsGYqOUqbnCGQxhrwt2eQgjm0N+daJFV9pNZdMWinHAlLXm8nPwyCKHXq37?=
 =?us-ascii?Q?oj80MOPg6cRIC2NCFD/UGC5zGytvH7Mf8HRMarTQeBuFe4Nly2uR+cDehhCB?=
 =?us-ascii?Q?KF4DJW4HeiMeWxpAPMq+kYlgDDT7K0+K8U6fS8YqmRFkf3zpR0EOurZIycrI?=
 =?us-ascii?Q?XZwPVPJHcxjdt4fE3ZRcgGF0O8DSKn2KtpSgn9MdRQDGlYCyxCrpRemLbFmf?=
 =?us-ascii?Q?sMlmJgwcFCBe+jROmSFlS4rgPWD2g5TgP+ZhRefYEgciaCn14gXIz5iZzqYZ?=
 =?us-ascii?Q?To/oKrnRe+S2Eqi+2ENkle1tgCikMTLTCSPMkN9pxWVVoF9YukeOxEqR3tOK?=
 =?us-ascii?Q?MGN789RcIRS/KBrkFZjKR+0eVAHCFV+YvU+JM2mCBNn30XjCeoON0az03exL?=
 =?us-ascii?Q?q3W1JB1W55zKKCEA/sRDFPf2XiSmL4Xfv6Fg9NxvVtPZWp+RNzuZKeC03zVm?=
 =?us-ascii?Q?WKgfXadVE2xKNLZRkfRLEJYJrIBydWQsJrp/DQrl/rMhqHgCKyphDg7zl7la?=
 =?us-ascii?Q?GuOBZhlLldrDAhuaC1KUQcD+dkDL6+fSlhDsh/MxXHx8gp1gCwFYQJ1i4ZzX?=
 =?us-ascii?Q?F4DJy8gAxx3D1Q0mXqEmWwQG+ezISVaFmRkvr3XjPH7evqXe6gWxzBQborPX?=
 =?us-ascii?Q?p4T1ufb6iDD1l3tS80CCbCKma/SsJfGDkwqA91SqmCQS9uf7gzAjSrg5UTnW?=
 =?us-ascii?Q?ZC143SsNr2mg8OkrQsS7wvlCuQ+B1mYk9ZSovbtXcOeureEVX33MKuHIKq8x?=
 =?us-ascii?Q?/stk3xmhIgulnv3SAsxrhgjktg6OqwAgepCastTFu/p/EZxYF8pQ2R9VdWeD?=
 =?us-ascii?Q?6r/8rccIT7eizO4S2Mz2y5KDEV/Rafys7LDZho+c07iYjkkrMd86P1Klq2LN?=
 =?us-ascii?Q?g8ads+fr1Z7t/UsUPIpE3MlaQr+zTfciqOxHtlRJ6HX/7KwwRTIohhjdbiEH?=
 =?us-ascii?Q?VX/itSYfH0Pi5AyffPDSp0EKWxBZj7OhVE8uCLtlL1SDZSuolH5lhfEBMjlj?=
 =?us-ascii?Q?dZJgbrndf2EGgTfZt3OKycFb9RSo9cTFcQ2HX/cUKI0C55hEgaCsWsbUVeU2?=
 =?us-ascii?Q?Wj3yvGvhHdHFwA8hpfmDeSnjQ/0io7olnNNHA1tNwHO1zmtr1D79rOo2goWy?=
 =?us-ascii?Q?5RPNkBuVPCc1GS8vi+Pd23NGYRSy1mTX1IMfvdMrYV+qxLEk3FQplybednbe?=
 =?us-ascii?Q?uk6umaRRZ4dOGzSVUiFzIvWDJ9HYZBsFns0piAaMFtE8QPgzQWThlPRSEigN?=
 =?us-ascii?Q?hq0GCzRQFDIrZsU/2jK6ODjUPZ10a9l7JbHEjfNcQ0cP3B5vFstfBwLFJHmy?=
 =?us-ascii?Q?2c8yTF9la8jcTlyLQpUOJnFzbD7qvAv/0ZVT84ZHh933wDkE/je5qEJem9zV?=
 =?us-ascii?Q?14m+/0XvxVXqANCKFpEUjazd4qX1nZVkyqC+DJVn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf22b86-5704-44cd-757d-08db2a1fc892
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 15:20:20.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce1UWCmiS6NTouoLn3LtYojtJVMCBXCsbV0dFQySA1r2PhqwYZiBbrahZWlNHFjY0puuCY/lXuLbR4uALVdKdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB3 controller, phy and typec related nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

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

