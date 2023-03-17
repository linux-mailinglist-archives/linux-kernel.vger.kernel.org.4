Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E386BE941
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCQMcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCQMcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:32:20 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C5B72032;
        Fri, 17 Mar 2023 05:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDG1nif3pt+Wkji5xjTSdtHZueiv72MpX2zCVoy28aNskXhdH7syX+mQUvweYu8tpOnEGwVtmMsWGP9bfNt2vplAgVU+ROrwqNj7vXfLb7b5LkaWGMXmoG0JX8gMz8ckz8b1ZcQQ6SeB7UNe1G56829wKQhQubvokIM//g3+lgSejTG9MAOXNgo3UlB7KN6RChkR3ac2FuI+eNWXrd2zRAKib7i1b/5vl2jUKE0YLntB0Yiedc0K7/NQOASEgySWTgRB1zFhI3wqLNzRCfIgcytQr5ryoxOrv7zwpeWgOGh3K+UuvHJPcuxLEWPT/maac7vS/gkomeNow+LEDvJ2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWsk2smpWg6PDK1Y/ZhxtWZ166K2yQoiBLdXU8D2YmU=;
 b=dl087fQrrXtZojjx7eee49G5QK7nuAH/GELsIF/d2ObqW51tdd1wiSsWHP8TZTpJ60R0Jgab2cMVDuVzJynwb2V5dDFlAXs9JrAuyMWr39GkSHI5mLC2qLu5urY0am1QYzF1O4zJ/uRBYs2uBciX3moVBqTWPBTQAvSNtM9augMIRIH4mwRp5XQsBDKdRfuLAVS2e5j1H6We5eT0fRiwvZNbVN6N4gAxh/Dki6dFgutFStqtFtjxXYcl5Pv3qlkQBanR7V/YLDWoy2EjxIktY72DZXiaAwJeVPMjNovUvd0C8uINBhqYEUTu548pRG1/Ss83s2psN8o26bElhjQJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWsk2smpWg6PDK1Y/ZhxtWZ166K2yQoiBLdXU8D2YmU=;
 b=CC3WRPQrEG/Yi2U/qacx4pRA3TfA7CdevMU+rp6jBBRI5MashpGSw63iXpA5qamUtUk/1SPgwb1JUHH2yXhpVYHDIc4YjaAr0UgE9IZdyyjonf1XGcxs0zDt+A+LnRji4jW8U61zeuzmU0T7jMa37tSiZm3SEuRH1jXe3RFHTPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 12:32:13 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf%6]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 12:32:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 2/6] dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format
Date:   Fri, 17 Mar 2023 20:37:04 +0800
Message-Id: <20230317123708.337286-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230317123708.337286-1-peng.fan@oss.nxp.com>
References: <20230317123708.337286-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM8PR04MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4d5fbc-0bdb-4c98-e6f2-08db26e3a240
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WphPlFAFZbblTqTLqR6RaPCIz7sbWLFzEjNaEIHT+S8wv2qEzP2lcXjl1jG9emlw2PZQwAmHkz+p8uwzYUp2tvm+pah3oxw/44Wp/f4I3fdidcBASKh9+KBti3d1X+3eNwR28zQGZ4J7OGCByOpC7CMT2mfrXFROntdnMu9LEyO3VqdZypKmPhApxJo9qxyJDcTzbIPsmexa9K7GpIIbS+5S7Rs+OR2phn1LYApGMQtEjApEF4LBOIupOEJLWxSwM84XajBVJDlyMyjk6py22NTqRiC+GzlECOvpdBXRJQ+s/cO20O5bUSV00tmOTIZMQT2AIR5bhmNafliaNtEmBPXqwgK8g0JIZ27crfpXMNdn6UFf+K+51XpD65F9FHSoAQG3IJzlJ8of35NSjz3OW5l6vuYrXAFrLakttUcElJTWHE+pTUZu+mYDPvafiWSllzzDsNwA/1wnr4K+xdbI6TdNH/k+DX2NoQmBEuqcIEHgo4G9azEDZbzeeBuC51U4H2t2qc5VvnilZ5ivgg2zmU1KcvKa8Y0fnbFG+PW0PXOUxbDEBrDgyhBIU4CNdezxP84zsFF9SO/E2fQCwyCH2QojMvrv+UiVzQj05PnSh0ediYpbR+qjQp/OTRxoylj6KaNGSPkpB+wx3fouzj+C8EMySZKkay4B5PLm2CwwIhbEVXWyV2KNnsK4RJvdVHhxvxBrGFX8Dn6byYgFKHAecKvAF9ZrfeLR0iE2fD75DE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(38350700002)(316002)(38100700002)(2906002)(478600001)(4326008)(8936002)(5660300002)(41300700001)(66556008)(66946007)(66476007)(8676002)(30864003)(83380400001)(7416002)(86362001)(186003)(52116002)(26005)(6512007)(6506007)(2616005)(1076003)(6666004)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VdGuxLtwphxGqjGR8SsHr3oaJW7Lp5CtN9qbi4zYg/Yivh5XxhPEz5ZB1HL?=
 =?us-ascii?Q?QFTQ9D6sPaOo6AMhdg83TNQt0dJ9B5MPmEgiUw5fPjDpjnp+HkxKIAXnZ4yj?=
 =?us-ascii?Q?0L+uixY68aj1LostT3MtHkjgbJ/kedttyHv+PQs5rUAOGGKbQMXvKRAqP2HL?=
 =?us-ascii?Q?rfXxqnk/9Co1uvkNSaLsA0ExLTqnuBYmBvnwxzb9X3FSKlT4en4J0Kk3h2am?=
 =?us-ascii?Q?N1yM4+5UyUID9p+1+y324YqE3g5vPOmxW3VXkf8Ok396dGJYkSpw5HDZJz+0?=
 =?us-ascii?Q?eSSYAt9kudveNnFtTZa+9FPC1na1xPGXr3XlsMmvtFlANDd1rBHzOHEGmtRz?=
 =?us-ascii?Q?QeHCn/vULh4YqVdLX/zHW9GgpxklWKnmoMupW7FHKhIqTl8J+18vtx5n/Ee5?=
 =?us-ascii?Q?ZOHLPhh3d43cJLpTNMy+Ytms+S7NAKIAyA7uy/2fRGPh/9Zr10ZhrgOvopKB?=
 =?us-ascii?Q?HsGJ3UeNkAqZARm+J1So9JqoBwGGfjtIPLaLlGd4Tz8splJVwux4ky8mzyBW?=
 =?us-ascii?Q?PlPE+pv6sd3lAjFg1XDuYbRlVZhzzFNJmklZIsfEaWeGNjXNIARVdAkSOb/x?=
 =?us-ascii?Q?ZnW5lMrzJvUavGpT68r4FmsVXrOVqkuogzqTjBQ00GNzplKcV3RgcrM3wNhL?=
 =?us-ascii?Q?RSheoE5+bgTow4E4Udydllmed4sK68EtakEqAfEhhJnOxZVqE4H7TA6v51x2?=
 =?us-ascii?Q?UkVAOb/BcaScpgsf0SEio9ehbhWgcSZW7BJPcr9FW6Tyxc6pmlROM+cuEDwk?=
 =?us-ascii?Q?YIVVkdTsmpqAdHlwbI+m1hlz1A8M/OLzNjLChQNgmayUiZjWn3Obdm8VKXTf?=
 =?us-ascii?Q?tbsVxrw/JJHp2a7d5I+CZ4Lh96eH9vzHVtVvuXmhg48QRZPVEnh2JmEV3kOs?=
 =?us-ascii?Q?gBVdq/0cFYN95unEtxTcw1DZgjHjgYG4TYwH1QD1d5ZYLNGPqROoDmxDAaUn?=
 =?us-ascii?Q?RN7iN6ZDcSmgLbvims3tdZGygoKkztHH8KavFdHH3Nl4EhzJWWSZ0Wntf3am?=
 =?us-ascii?Q?tYlxox69bZ8edCxD3zAGy0JiOj/7t8E+haboiFyCsyo73EIKNSDIWEIaFTXj?=
 =?us-ascii?Q?MxQJGlZ+ZUM5nSu5MtMTkruhFQEcAGlPpgaRvU96ekMaAP/vx0hP2R59DUXt?=
 =?us-ascii?Q?Ap/Em3VMc8SsPCDsbaG4ZBA4s8oBHqpb12y/mHZReyiIfx1WLp3Cp3tRz093?=
 =?us-ascii?Q?O3Y4GXzB0xMvo+0N1PvOBjIpfqGJkfGmwcElwK5eX9kcVOsNumK39+bVmDq2?=
 =?us-ascii?Q?EGvst3yfa7aeDM0RQoO6n82j177dMwmNmk+dSCiUwC48ggz48qaEWCVmoQai?=
 =?us-ascii?Q?WD0gZQc9Vz2zpENc2Zv/uEvhXdVMH8vatm3x8lmetAoUnJOgydN4IWIdsgYR?=
 =?us-ascii?Q?utC40InlnpjAWRizosuL4jwKpaToE4qjz4wrWsjPVMUSKEjQkaaQRTSy6Anf?=
 =?us-ascii?Q?Tb2kCqXX7HBuKq4GnzE4NMov5/XBqWX9AqZuh631XHv89yksDv7MElwzJGy8?=
 =?us-ascii?Q?zBGUsXUOxaNDkd6mRiKwItpRLxBt9XRSuvOwPJkw+QnPIcDPSmgrU7crk3UD?=
 =?us-ascii?Q?knnj74nnOz0htNWNQv6Q8zEUvSotkCmBwlz4L/TF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4d5fbc-0bdb-4c98-e6f2-08db26e3a240
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 12:32:13.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLT2DT1P3RWjDh1qfEzVb2HzB9m+qdW38nAsT+aE2LTqn80P7WrqSxGKSP37xOuLEPwXUPcn8UM+mF+BG1jO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert the binding to DT schema format. To fix the dtbs_check
error, some properties were also added, such as nvidia,phy, reset-names
ulpi; missing compatibles are added.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 159 -------
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 412 ++++++++++++++++++
 2 files changed, 412 insertions(+), 159 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
deleted file mode 100644
index 72ceea575d58..000000000000
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ /dev/null
@@ -1,159 +0,0 @@
-* USB2 ChipIdea USB controller for ci13xxx
-
-Required properties:
-- compatible: should be one of:
-	"fsl,imx23-usb"
-	"fsl,imx27-usb"
-	"fsl,imx28-usb"
-	"fsl,imx6q-usb"
-	"fsl,imx6sl-usb"
-	"fsl,imx6sx-usb"
-	"fsl,imx6ul-usb"
-	"fsl,imx7d-usb"
-	"fsl,imx7ulp-usb"
-	"fsl,imx8mm-usb"
-	"lsi,zevio-usb"
-	"qcom,ci-hdrc"
-	"chipidea,usb2"
-	"xlnx,zynq-usb-2.20a"
-	"nvidia,tegra20-udc"
-	"nvidia,tegra30-udc"
-	"nvidia,tegra114-udc"
-	"nvidia,tegra124-udc"
-- reg: base address and length of the registers
-- interrupts: interrupt for the USB controller
-
-Recommended properies:
-- phy_type: the type of the phy connected to the core. Should be one
-  of "utmi", "utmi_wide", "ulpi", "serial" or "hsic". Without this
-  property the PORTSC register won't be touched.
-- dr_mode: One of "host", "peripheral" or "otg". Defaults to "otg"
-
-Deprecated properties:
-- usb-phy:      phandle for the PHY device. Use "phys" instead.
-- fsl,usbphy: phandle of usb phy that connects to the port. Use "phys" instead.
-
-Optional properties:
-- clocks: reference to the USB clock
-- phys: reference to the USB PHY
-- phy-names: should be "usb-phy"
-- vbus-supply: reference to the VBUS regulator
-- maximum-speed: limit the maximum connection speed to "full-speed".
-- tpl-support: TPL (Targeted Peripheral List) feature for targeted hosts
-- itc-setting: interrupt threshold control register control, the setting
-  should be aligned with ITC bits at register USBCMD.
-- ahb-burst-config: it is vendor dependent, the required value should be
-  aligned with AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This
-  property is used to change AHB burst configuration, check the chipidea
-  spec for meaning of each value. If this property is not existed, it
-  will use the reset value.
-- tx-burst-size-dword: it is vendor dependent, the tx burst size in dword
-  (4 bytes), This register represents the maximum length of a the burst
-  in 32-bit words while moving data from system memory to the USB
-  bus, the value of this property will only take effect if property
-  "ahb-burst-config" is set to 0, if this property is missing the reset
-  default of the hardware implementation will be used.
-- rx-burst-size-dword: it is vendor dependent, the rx burst size in dword
-  (4 bytes), This register represents the maximum length of a the burst
-  in 32-bit words while moving data from the USB bus to system memory,
-  the value of this property will only take effect if property
-  "ahb-burst-config" is set to 0, if this property is missing the reset
-  default of the hardware implementation will be used.
-- extcon: phandles to external connector devices. First phandle should point to
-  external connector, which provide "USB" cable events, the second should point
-  to external connector device, which provide "USB-HOST" cable events. If one
-  of the external connector devices is not required, empty <0> phandle should
-  be specified.
-- phy-clkgate-delay-us: the delay time (us) between putting the PHY into
-  low power mode and gating the PHY clock.
-- non-zero-ttctrl-ttha: after setting this property, the value of register
-  ttctrl.ttha will be 0x7f; if not, the value will be 0x0, this is the default
-  value. It needs to be very carefully for setting this property, it is
-  recommended that consult with your IC engineer before setting this value.
-  On the most of chipidea platforms, the "usage_tt" flag at RTL is 0, so this
-  property only affects siTD.
-  If this property is not set, the max packet size is 1023 bytes, and if
-  the total of packet size for pervious transactions are more than 256 bytes,
-  it can't accept any transactions within this frame. The use case is single
-  transaction, but higher frame rate.
-  If this property is set, the max packet size is 188 bytes, it can handle
-  more transactions than above case, it can accept transactions until it
-  considers the left room size within frame is less than 188 bytes, software
-  needs to make sure it does not send more than 90%
-  maximum_periodic_data_per_frame. The use case is multiple transactions, but
-  less frame rate.
-- mux-controls: The mux control for toggling host/device output of this
-  controller. It's expected that a mux state of 0 indicates device mode and a
-  mux state of 1 indicates host mode.
-- mux-control-names: Shall be "usb_switch" if mux-controls is specified.
-- pinctrl-names: Names for optional pin modes in "default", "host", "device".
-  In case of HSIC-mode, "idle" and "active" pin modes are mandatory. In this
-  case, the "idle" state needs to pull down the data and strobe pin
-  and the "active" state needs to pull up the strobe pin.
-- pinctrl-n: alternate pin modes
-
-i.mx specific properties
-- fsl,usbmisc: phandler of non-core register device, with one
-  argument that indicate usb controller index
-- disable-over-current: disable over current detect
-- over-current-active-low: over current signal polarity is active low.
-- over-current-active-high: over current signal polarity is active high.
-  It's recommended to specify the over current polarity.
-- power-active-high: power signal polarity is active high
-- external-vbus-divider: enables off-chip resistor divider for Vbus
-- samsung,picophy-pre-emp-curr-control: HS Transmitter Pre-Emphasis Current
-  Control. This signal controls the amount of current sourced to the
-  USB_OTG*_DP and USB_OTG*_DN pins after a J-to-K or K-to-J transition.
-  The range is from 0x0 to 0x3, the default value is 0x1.
-  Details can refer to TXPREEMPAMPTUNE0 bits of USBNC_n_PHY_CFG1.
-- samsung,picophy-dc-vol-level-adjust: HS DC Voltage Level Adjustment.
-  Adjust the high-speed transmitter DC level voltage.
-  The range is from 0x0 to 0xf, the default value is 0x3.
-  Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
-
-Example:
-
-	usb@f7ed0000 {
-		compatible = "chipidea,usb2";
-		reg = <0xf7ed0000 0x10000>;
-		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&chip CLKID_USB0>;
-		phys = <&usb_phy0>;
-		phy-names = "usb-phy";
-		vbus-supply = <&reg_usb0_vbus>;
-		itc-setting = <0x4>; /* 4 micro-frames */
-		 /* Incremental burst of unspecified length */
-		ahb-burst-config = <0x0>;
-		tx-burst-size-dword = <0x10>; /* 64 bytes */
-		rx-burst-size-dword = <0x10>;
-		extcon = <0>, <&usb_id>;
-		phy-clkgate-delay-us = <400>;
-		mux-controls = <&usb_switch>;
-		mux-control-names = "usb_switch";
-	};
-
-Example for HSIC:
-
-	usb@2184400 {
-		compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
-		reg = <0x02184400 0x200>;
-		interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks IMX6QDL_CLK_USBOH3>;
-		fsl,usbphy = <&usbphynop1>;
-		fsl,usbmisc = <&usbmisc 2>;
-		phy_type = "hsic";
-		dr_mode = "host";
-		ahb-burst-config = <0x0>;
-		tx-burst-size-dword = <0x10>;
-		rx-burst-size-dword = <0x10>;
-		pinctrl-names = "idle", "active";
-		pinctrl-0 = <&pinctrl_usbh2_idle>;
-		pinctrl-1 = <&pinctrl_usbh2_active>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usbnet: ethernet@1 {
-			compatible = "usb424,9730";
-			reg = <1>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
new file mode 100644
index 000000000000..1cf747311ea9
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -0,0 +1,412 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB2 ChipIdea USB controller
+
+maintainers:
+  - Xu Yang <xu.yang_2@nxp.com>
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - chipidea,usb2
+          - lsi,zevio-usb
+          - nvidia,tegra20-udc
+          - nvidia,tegra30-udc
+          - nvidia,tegra114-udc
+          - nvidia,tegra124-udc
+          - qcom,ci-hdrc
+      - items:
+          - enum:
+              - fsl,imx23-usb
+              - fsl,imx25-usb
+              - fsl,imx28-usb
+              - fsl,imx50-usb
+              - fsl,imx51-usb
+              - fsl,imx53-usb
+              - fsl,imx6q-usb
+              - fsl,imx6sl-usb
+              - fsl,imx6sx-usb
+              - fsl,imx6ul-usb
+              - fsl,imx7d-usb
+              - fsl,vf610-usb
+          - const: fsl,imx27-usb
+      - items:
+          - const: fsl,imx8dxl-usb
+          - const: fsl,imx7ulp-usb
+          - const: fsl,imx6ul-usb
+      - items:
+          - enum:
+              - fsl,imx8mm-usb
+              - fsl,imx8mn-usb
+          - const: fsl,imx7d-usb
+          - const: fsl,imx27-usb
+      - items:
+          - enum:
+              - fsl,imx6sll-usb
+              - fsl,imx7ulp-usb
+          - const: fsl,imx6ul-usb
+          - const: fsl,imx27-usb
+      - items:
+          - const: xlnx,zynq-usb-2.20a
+          - const: chipidea,usb2
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+
+  dr_mode: true
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+  phy_type: true
+
+  itc-setting:
+    description:
+      interrupt threshold control register control, the setting should be
+      aligned with ITC bits at register USBCMD.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  ahb-burst-config:
+    description:
+      it is vendor dependent, the required value should be aligned with
+      AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This property is
+      used to change AHB burst configuration, check the chipidea spec for
+      meaning of each value. If this property is not existed, it will use
+      the reset value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x7
+
+  tx-burst-size-dword:
+    description:
+      it is vendor dependent, the tx burst size in dword (4 bytes), This
+      register represents the maximum length of a the burst in 32-bit
+      words while moving data from system memory to the USB bus, the value
+      of this property will only take effect if property "ahb-burst-config"
+      is set to 0, if this property is missing the reset default of the
+      hardware implementation will be used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x20
+
+  rx-burst-size-dword:
+    description:
+      it is vendor dependent, the rx burst size in dword (4 bytes), This
+      register represents the maximum length of a the burst in 32-bit words
+      while moving data from the USB bus to system memory, the value of
+      this property will only take effect if property "ahb-burst-config"
+      is set to 0, if this property is missing the reset default of the
+      hardware implementation will be used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x20
+
+  extcon:
+    description: |
+      Phandles to external connector devices. First phandle should point
+      to external connector, which provide "USB" cable events, the second
+      should point to external connector device, which provide "USB-HOST"
+      cable events. If one of the external connector devices is not
+      required, empty <0> phandle should be specified.
+
+  phy-clkgate-delay-us:
+    description: |
+      The delay time (us) between putting the PHY into low power mode and
+      gating the PHY clock.
+
+  non-zero-ttctrl-ttha:
+    description: |
+      After setting this property, the value of register ttctrl.ttha
+      will be 0x7f; if not, the value will be 0x0, this is the default
+      value. It needs to be very carefully for setting this property, it
+      is recommended that consult with your IC engineer before setting
+      this value.  On the most of chipidea platforms, the "usage_tt" flag
+      at RTL is 0, so this property only affects siTD.
+
+      If this property is not set, the max packet size is 1023 bytes, and
+      if the total of packet size for pervious transactions are more than
+      256 bytes, it can't accept any transactions within this frame. The
+      use case is single transaction, but higher frame rate.
+
+      If this property is set, the max packet size is 188 bytes, it can
+      handle more transactions than above case, it can accept transactions
+      until it considers the left room size within frame is less than 188
+      bytes, software needs to make sure it does not send more than 90%
+      maximum_periodic_data_per_frame. The use case is multiple
+      transactions, but less frame rate.
+
+  mux-controls:
+    description: |
+      The mux control for toggling host/device output of this controller.
+      It's expected that a mux state of 0 indicates device mode and a mux
+      state of 1 indicates host mode.
+    maxItems: 1
+
+  mux-control-names:
+    const: usb_switch
+
+  pinctrl-names:
+    description: |
+      Names for optional pin modes in "default", "host", "device".
+      In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
+      In this case, the "idle" state needs to pull down the data and
+      strobe pin and the "active" state needs to pull up the strobe pin.
+    items:
+      enum: [ default, host, device, idle, active ]
+
+  pinctrl-0:
+    maxItems: 1
+
+  pinctrl-1:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: usb-phy
+
+  vbus-supply:
+    description: reference to the VBUS regulator.
+
+  fsl,usbmisc:
+    description:
+      Phandler of non-core register device, with one argument that
+      indicate usb controller index
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to usbmisc node
+          - description: index of usb controller
+
+  fsl,anatop:
+    description: phandle for the anatop node.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  disable-over-current:
+    type: boolean
+    description: disable over current detect
+
+  over-current-active-low:
+    type: boolean
+    description: over current signal polarity is active low
+
+  over-current-active-high:
+    type: boolean
+    description: |
+      Over current signal polarity is active high. It's recommended to
+      specify the over current polarity.
+
+  power-active-high:
+    type: boolean
+    description: power signal polarity is active high
+
+  external-vbus-divider:
+    type: boolean
+    description: enables off-chip resistor divider for Vbus
+
+  samsung,picophy-pre-emp-curr-control:
+    description: |
+      HS Transmitter Pre-Emphasis Current Control. This signal controls
+      the amount of current sourced to the USB_OTG*_DP and USB_OTG*_DN
+      pins after a J-to-K or K-to-J transition. The range is from 0x0 to
+      0x3, the default value is 0x1. Details can refer to TXPREEMPAMPTUNE0
+      bits of USBNC_n_PHY_CFG1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x3
+
+  samsung,picophy-dc-vol-level-adjust:
+    description: |
+      HS DC Voltage Level Adjustment. Adjust the high-speed transmitter DC
+      level voltage. The range is from 0x0 to 0xf, the default value is
+      0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0xf
+
+  usb-phy:
+    description: phandle for the PHY device. Use "phys" instead.
+    $ref: /schemas/types.yaml#/definitions/phandle
+    deprecated: true
+
+  fsl,usbphy:
+    description: phandle of usb phy that connects to the port. Use "phys" instead.
+    $ref: /schemas/types.yaml#/definitions/phandle
+    deprecated: true
+
+  nvidia,phy:
+    description: phandle of usb phy that connects to the port. Use "phys" instead.
+    $ref: /schemas/types.yaml#/definitions/phandle
+    deprecated: true
+
+  port:
+    description:
+      Any connector to the data bus of this controller should be modelled
+      using the OF graph bindings specified, if the "usb-role-switch"
+      property is used.
+    $ref: /schemas/graph.yaml#/properties/port
+
+  reset-gpios:
+    maxItems: 1
+
+  ulpi:
+    type: object
+    properties:
+      phy:
+        description: The phy child node for Qcom chips.
+        type: object
+        $ref: /schemas/phy/qcom,usb-hs-phy.yaml
+
+dependencies:
+  port: [ usb-role-switch ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: usb-hcd.yaml#
+  - $ref: usb-drd.yaml#
+  - if:
+      properties:
+        mux-controls:
+          true
+    then:
+      properties:
+        mux-control-names:
+          const: usb_switch
+  - if:
+      properties:
+        phy_type:
+          const: hsic
+      required:
+        - phy_type
+    then:
+      properties:
+        pinctrl-names:
+          items:
+            - const: idle
+            - const: active
+    else:
+      properties:
+        pinctrl-names:
+          minItems: 1
+          maxItems: 2
+          oneOf:
+            - items:
+                - const: default
+                - enum:
+                    - host
+                    - device
+            - items:
+                - const: default
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - chipidea,usb2
+              - lsi,zevio-usb
+              - nvidia,tegra20-udc
+              - nvidia,tegra30-udc
+              - nvidia,tegra114-udc
+              - nvidia,tegra124-udc
+              - qcom,ci-hdrc
+              - xlnx,zynq-usb-2.20a
+    then:
+      properties:
+        fsl,usbmisc: false
+        disable-over-current: false
+        over-current-active-low: false
+        over-current-active-high: false
+        power-active-high: false
+        external-vbus-divider: false
+        samsung,picophy-pre-emp-curr-control: false
+        samsung,picophy-dc-vol-level-adjust: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/berlin2.h>
+
+    usb@f7ed0000 {
+        compatible = "chipidea,usb2";
+        reg = <0xf7ed0000 0x10000>;
+        interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&chip CLKID_USB0>;
+        phys = <&usb_phy0>;
+        phy-names = "usb-phy";
+        vbus-supply = <&reg_usb0_vbus>;
+        itc-setting = <0x4>; /* 4 micro-frames */
+         /* Incremental burst of unspecified length */
+        ahb-burst-config = <0x0>;
+        tx-burst-size-dword = <0x10>; /* 64 bytes */
+        rx-burst-size-dword = <0x10>;
+        extcon = <0>, <&usb_id>;
+        phy-clkgate-delay-us = <400>;
+        mux-controls = <&usb_switch>;
+        mux-control-names = "usb_switch";
+    };
+
+  # Example for HSIC:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+
+    usb@2184400 {
+        compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+        reg = <0x02184400 0x200>;
+        interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX6QDL_CLK_USBOH3>;
+        fsl,usbphy = <&usbphynop1>;
+        fsl,usbmisc = <&usbmisc 2>;
+        phy_type = "hsic";
+        dr_mode = "host";
+        ahb-burst-config = <0x0>;
+        tx-burst-size-dword = <0x10>;
+        rx-burst-size-dword = <0x10>;
+        pinctrl-names = "idle", "active";
+        pinctrl-0 = <&pinctrl_usbh2_idle>;
+        pinctrl-1 = <&pinctrl_usbh2_active>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@1 {
+            compatible = "usb424,9730";
+            reg = <1>;
+        };
+    };
+
+...
-- 
2.37.1

