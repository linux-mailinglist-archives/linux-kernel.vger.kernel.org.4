Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD066C0104
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCSLuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCSLuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:50:10 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E051F5F1;
        Sun, 19 Mar 2023 04:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XB90D9vMRhi2YTCPLgHwgn7wGkamIScmLQN6VCt/lvTHaCyz/68EmWCgxp9Ye9xpOwTlRd9Bwx6/wHYKQO2ftnMU/sv5Bq75rLJF0NVCZnjb9EkaHS3nilmlhsre+ZvqX2bJ82dcXAbs3JcpKuDePU9RjwLLblJjEFUPPuxWkrj3ydRnkRuqnJWmZVhtk8fPmw59tgDOpX14ptY60NjTAQRnwQeiB3atUP6v1aIsc4BgcXFDhGVMgPf0N68Q6PkzJW58jyqfLxkRDGtonYsziyPCnwUwfHReZeNc/8Bklt3fl0U4Q4fmej1VRNqav0zU8KseDDW0vS8I7pTo7mvBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beXNOsjsQGr+JX8+No25ESFLgF4GOj+X9qeIgtGThK8=;
 b=DddGJBWaUCMXuOy6U7/A0aimmsmgSa21QP4inv8xokyqA4UTIWs+PaUg9fiQOemhLHWYgnHziOv77kymiClsL7Ih7og6r7+htCgqxnfzRYj+GE/joZJZfuX02Oz6cYmzZCjfFdD3ccLQD86/qtDsYLhc7FiAC1vPFHwWWFX4biQ49XEjaud5pxN11SNHXKhy61VQI2ZqP0dfhM+F4ToscxDSGTe+fbDT+yGu5088AK9b7aMjAOboc3lK1rabIu2h+KCjSN8BDiE9Kzg35atmmIRLfFyyknJ+iMU6ZQyua+rzfh7/97NVTKjwb9Ku3ujolvyr12vza5Sqyj5Ik5+KVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beXNOsjsQGr+JX8+No25ESFLgF4GOj+X9qeIgtGThK8=;
 b=Gl5vJbgcrxCMv7D5udhMeiU6ioI+inurxkA9hTdEV3syvM4SwNLD1e6Taheg6qwcIB5yXfN8UONrgAvevC6U7H10V/fJgOeZ4wO0M2VNHcDepRbgVu/Qeltvvy+jOIf6xRWOswW26rbUVwq+CKnipYCe8p4ffjy9ypMLPEMkwdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB10075.eurprd04.prod.outlook.com (2603:10a6:800:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sun, 19 Mar
 2023 11:50:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 11:49:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 2/9] dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format
Date:   Sun, 19 Mar 2023 19:54:49 +0800
Message-Id: <20230319115456.716969-3-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB10075:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d882779-657e-4340-db76-08db2870113c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymuKOYLoUR5Om5IElK/blKWzNM/nK0qGss6y/IbdqdZr4AvG8pyMoNvp118veiJs+w6wOUDgn8Y5efyEqmHJRuDcMtdAY0U6sQRTlbp0bcNuzvy79g7FTaQ7iGUhwXeiR60IoL+qRekw95dQJm2mhPCoxxnH4ta4QAciWIdpV6yc/csmTZsDqU+q+tpAvum8Ti3WXbrVw6opLUCNC3fVe6nBzTC/IWO1lB4UjnwT9OJQ9ej54kYxnaha4WZ84DXJSQRpHenHfdPKKDkrUS4xwQ6YQ7yf537zCSTx4zGe/RVi0a9EvwfXcOtjD3/w6HyjbIkY7tV2DxUCUs7ZRg+nolxqrX2mAJRy7RvMHoJDh4BMG+EpMnYr88FXs2YTAIqg6qxhtO9SWQR8kWNaGz2VlS7hPt8Lauyeg1MFiNLF/PVXjVulrn0L2YfPbWHmHmGh8Dhm5cJwXPqAsJnfsQdOXD0O5StC/OL7z/6NxzQY0DJ3nLXu6CQKhrN72oEBMmAXnx1BK4RnYZZ+hT3bdktil2shrAqhFqa0dEBkKVBGD+aWcP+p9ykG3MuW3HAKLWyCQtADemeh/+EqEbfGxwCd/U/7S1XOhwBCbUAZmS4ytXU2Py6jKn/HyJ5sK1DXuJ5BBGpDknG1c8MqSfSv85fD6L1zmaPhsk0lWa+mwivPHv0ua+AYk3bMDnKqZV/6f2RU+slJvFDHsIXt6C72jUWzhkF3pTZx0YsFWNFPOHKQrFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39850400004)(366004)(451199018)(86362001)(2616005)(186003)(1076003)(6506007)(6512007)(26005)(6666004)(38100700002)(30864003)(38350700002)(2906002)(7416002)(8936002)(5660300002)(41300700001)(8676002)(6486002)(4326008)(966005)(478600001)(66556008)(66946007)(66476007)(316002)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3U30kaKHPnEnp5uOHswa7tBy6pZBFlXzbI0r9iCBLrge5YG4ihTCqJvRNYuI?=
 =?us-ascii?Q?jMoIMz1vB/XC8sNnl1GaxSdrEqkfl/GL3jzZ4LiKZF7a7Op72YJKAOo1SYzF?=
 =?us-ascii?Q?R/NaNcvi/2gSX+hbyIsBVkK2xV0dKOOC40GOKNtgO8V8xte6vOhClUqLJG69?=
 =?us-ascii?Q?2Wpk4bjwbNfLD4s1XTjoI40hui/HrzvV//vmzu7NUkAwtL5u5ldmYt4r34q4?=
 =?us-ascii?Q?bgd5QRrlrPZjcd+szitVph5zoCDCitcWwJNBlp3eYAktxhmtmzbMuFdefvdd?=
 =?us-ascii?Q?7DRbAS/G4h2CosdarBFihqv8SvpTScx2vHhPwAZXg0i1PIE3gPkBUPNb02MV?=
 =?us-ascii?Q?2YYfMB3hbnT0iW68q0i2CldKxnTihVrMq0cmlBGFFrs8Oprh65vtuG+cfsCG?=
 =?us-ascii?Q?53oJHfxn+RVx9PAifKT1MzcinurHYbhgL6Vtlb9qLDNPODql+XzVLfBXhDc1?=
 =?us-ascii?Q?NDNSkqnI6kKxvjC8IhqTKiKtpnzcM+gn70SefxHuBBcko97dp324fkS/CKak?=
 =?us-ascii?Q?tRXK83nRsZrM1WzjXxe9eKfsJfNZlUNWi6Fq26GAy+VYQqehrg9a2MLMoL/c?=
 =?us-ascii?Q?WEtaHGz2Wjb0Iq5EB+MviOB3y0dyAOO8knGohcj56tlVbWOJPLFtBakQljs4?=
 =?us-ascii?Q?tCTU/Ze6Om7Oug275Dxk/nU9YBUWgnGEDL5scvMunfSLUsLZZkoM+QuTyVt+?=
 =?us-ascii?Q?kK6lcUdavn1nYu9XRgg1G7FSXWKK8Ldwh9rdeG1gb+GjP3O9O7m6Kc5xt2Rg?=
 =?us-ascii?Q?55KbQzVKsgphBoJaECkIZBsmL5FjgwYPO6w/AGFFQTiHTexr3+F+W4LKPtq+?=
 =?us-ascii?Q?eHPzzRyF0wZEMzVzu7o9rRZ8ipPkDGmFtpEgPfK3BARs/2IDOxRtLQoMf80g?=
 =?us-ascii?Q?oS18iADI5ZF6UiNRr02LoYp7TMFEs40x+IzFxuIGnJBNYJIjiPDEK4TFS0lY?=
 =?us-ascii?Q?TYLy+zVRMmRN8veyhzn5WiarMMH/hwlX36qaP790wXpuPpXTiW4/RfSOtNkC?=
 =?us-ascii?Q?wog5QZIyDAPsmXG377bH+l/b3sPhpAcysNWqbeaOQ/hT3IzTPAZPhK/e6C0/?=
 =?us-ascii?Q?mA1e7R/ETXxidQiBptmRkaXMHge6fRWRvEQH1G87P59ckj7lFydZPITXAjqv?=
 =?us-ascii?Q?vgEPmIFhMy9rya6Z0nHAcvkU1dp1smvdX3Wn1/Vbl57ywKsEJJOWWF+ja2Bn?=
 =?us-ascii?Q?NhmoA/Dit8B3+s4LLQzWAGmP8l5ZLlqML8rrLTa/QfljvCecAm6tzf+FrBu3?=
 =?us-ascii?Q?WFXY9+hZ1eQsK3eOLFDEjZYvAkLqUXtvY9qNgDYM7B7EzCZSGCkmt9BEDnZG?=
 =?us-ascii?Q?aD7tGn4tL5m+7CEODFI/iyzBQSSDz6T6iuvyvjW1r2SFdX7ODsrMjO0YtyhR?=
 =?us-ascii?Q?0QcPLUg0vS0JfOc56GCbdPuZXYklpodgb0iv7l5tQQ2AZ8W/7HH4mTRHHWLX?=
 =?us-ascii?Q?61lnOp/AZl7FmZk0AS3HKNWVZ2H9JdUONbBr3rVXTi2Bx+nDKN4aNbyXUU/e?=
 =?us-ascii?Q?SQ7pRqmzc9/t+g70dxi0ENqEzN8FTD9oQ4ZwIWOL+31DLeR4vwwXwRfWiqVc?=
 =?us-ascii?Q?tzRIuK01XK7bxThJwykerMhzOvNE5IZzSHJ7GJvP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d882779-657e-4340-db76-08db2870113c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 11:49:59.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjH+MDtzoxwN3KStQ1SPTEAi/dbJMRa8XgEIy2NR9iW0p6cTFTF1N13tfSt+4wFbTwqNsgef00XNQmaf6QV1oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10075
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 449 ++++++++++++++++++
 2 files changed, 449 insertions(+), 159 deletions(-)
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
index 000000000000..758bebb1deaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -0,0 +1,449 @@
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
+          - nvidia,tegra20-ehci
+          - nvidia,tegra20-udc
+          - nvidia,tegra30-ehci
+          - nvidia,tegra30-udc
+          - nvidia,tegra114-udc
+          - nvidia,tegra124-udc
+          - qcom,ci-hdrc
+      - items:
+          - enum:
+              - nvidia,tegra114-ehci
+              - nvidia,tegra124-ehci
+              - nvidia,tegra210-ehci
+          - const: nvidia,tegra30-ehci
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
+  operating-points-v2:
+    description: A phandle to the OPP table containing the performance states.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  pinctrl-names:
+    description: |
+      Names for optional pin modes in "default", "host", "device".
+      In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
+      In this case, the "idle" state needs to pull down the data and
+      strobe pin and the "active" state needs to pull up the strobe pin.
+    oneOf:
+      - items:
+          - const: idle
+          - const: active
+      - items:
+          - const: default
+          - enum:
+              - host
+              - device
+      - items:
+          - const: default
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
+  phy-select:
+    description:
+      Phandler of TCSR node with two argument that indicate register
+      offset, and phy index
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to TCSR node
+          - description: register offset
+          - description: phy index
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
+  nvidia,needs-double-reset:
+    description: Indicates double reset or not.
+    type: boolean
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

