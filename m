Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED35A6A2FAC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBZNCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBZNCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:02:43 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC0312F0A;
        Sun, 26 Feb 2023 05:02:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQPQyR0z73j2BeVErK/6GGfCROcAB3AlfLESNZHcFQ/8+ufqrmrxQdLMAQDVE8yog3FgEyxtID5rZX3fK1945OlEUe+Ge0elCd4kPkXQxmPy7Rxn/FKs+R5U/0JBje9/f7qj8MWrksZVjrgcuPP8HxNR8gAD2EXmMQKMfn2UkTB0HbMf3FY5lMc4VaYbv1Hoc8vMGi8sbyStg6m+JHlUCB1kmyBFY3GBwhb3syl6yGNlKUL4MAeF2lWMNy/ZL7T5dNRJlveyrEJTUXg2sZANSBZ9CGT2bOhvkbsiu+Q+cz3F7GoljwRWpe7vuJJj5pObWTvE1o4Te7leebKfMo6kSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHeaICmLd1yx0hQWnMlGQCtt6ch+0I5oZCNI8bgMkT0=;
 b=i0c7DbcPO+7RSJUcJVa9+HnQwDNQY7L7If7DQNCEHlGAGsBDopdHJAeAZ1Km+ddQy/8sSriBuKhyQoWBS84mwnoLg67KNYMv4R4feo/cvlVKt/Hw6lyHNey1GAVgi9LvLvXkg+6+TJlmf5MUEMPS2r00N9ict/ZkkzjDpEDecAlU3sls11sdQWhPu8ffMRmoJbXzj9S8AxKm2I0MY9AK7hDdC3QwAbxB1Cj8ZZfOH/ZqAIlUwSmboua20LFh5Yro15//bkMxz99DF5Evk3+jpHjNXkt6fU20DcuiPHafn5adSYPk3qAeNzqfqaBTGLmyf+aWt6dBdN6ppQ9Cj0SccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHeaICmLd1yx0hQWnMlGQCtt6ch+0I5oZCNI8bgMkT0=;
 b=iIcxPewQk6cevJRHVaaq/hv9eRsOfkqWgU4Mt+n1v/X3HPuc2Lh9VNujqBYxQ4kJsX2fECLCCtzbSJacq6+/PVX4jKzjdYMegLuWZeuAoGdomYoCzehXe74Fznr4lngsODEtjnmuxXw6nFn+jwPN5+3voH+5QKrvtuJJArYMz98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:00:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 13:00:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/7] dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format
Date:   Sun, 26 Feb 2023 21:05:36 +0800
Message-Id: <20230226130539.277336-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230226130539.277336-1-peng.fan@oss.nxp.com>
References: <20230226130539.277336-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 430aaf52-91c6-4758-2fdd-08db17f97ca1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hh4bdU4kEUJMaJC/5TF4tN3M13W35gmUZ16sEs1LYw7+/NRwmYBCzvszcayKbitVhOtUY1YVqiRsH2Vlk5Pf6NROe2qA67G3dgKuvAoEff1UB+u5Jb5NlIM4UZAAE7U2zwDe0p2McTTfy3BrLYBLJ+tRiFb5ksos30+AUKbh3+Xw+j9AyYKKsp98hlRO85Rwr1Jm+EEFRzIv8ngnau1Oy75VanaATvmMhsMrOnEALo6Fg7JHNCIol68SLBZP3JaUyLWqwoJUp8Ipyvh3qh4I9UbQ1yKN480fHfw5qCAErKE3FpV8KsQ86msOrkMzlsdONODaxiK8Y7f2rAP5fxfPZ3CDYfu+onwFmf6T6LUIQg++CIRGSOG5eOC6toaRIJ3RA+ziBZk5+SKcLcbIIkfqAIBxNA2/frHkwLKsw/TbU2sLDUGeSDVpttAQlm6XFtXNgJFjKHAd/JB4ga0n8klUxpTjN36EYmbZyyf9rZXxriAraSeAkWFEck2B03asz3ov622800pHKb9Yn2IuCuaHxc50LIsLs3ELJaU+k80aYfmzK8k5aeVwqg6Wv6Aj0uRKic6Ztq3Zf2DjTeyp7d/mLc9nG99BzLQzy/TAPV1tO+d8ANjSk2E5l/D78wNKygkHU3PgQu+9CfRsg0Th0IXgWhc0RmkFsC6/ZnV82n6BNiDBrMPA5JFh6BFz+qIYRnER
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(83380400001)(8676002)(6666004)(38350700002)(38100700002)(86362001)(8936002)(5660300002)(478600001)(30864003)(7416002)(2616005)(26005)(6486002)(966005)(1076003)(6512007)(6506007)(66556008)(66476007)(4326008)(2906002)(66946007)(316002)(52116002)(186003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qIML3KBs5eAs9LhUxkxD55/FyfAIiSH8Mk5HTUX8sQrB2FpwbcXa5YprAHyh?=
 =?us-ascii?Q?lN0hfA2Kob9n3HI4TMf5L97SsY2DytM4KLryWYi8l4qgeiPKKq73VXWmUjlw?=
 =?us-ascii?Q?sUYncGP5h6NQzbIMNKSGF/CzBAu48KyfJ57gHYiCfRmVoqa77wmmGTHUiUb0?=
 =?us-ascii?Q?Iylh/+ln1KbrmmRckTpcYd438oGxdicggpYn6KbxcEqtV4dge99TxMIYbZZH?=
 =?us-ascii?Q?X597yxZugszHrIAUzijTfWsL2aiaUE8vSTZMJe1hqerVHFTosDSP7vWYKX4s?=
 =?us-ascii?Q?YsK2pz1k+ZqECOqWUfzW4yw4kb9PX2lOOJFIK1BZr/f/cxgD6YbO8aGpHwQA?=
 =?us-ascii?Q?OxgULqerw2E+XsE9T62Nwfv6szpfg3Oe4xokKVk+ZDu/BMmWVNNv8a/xA4ga?=
 =?us-ascii?Q?gbnR9qbJIz+YQ9zqJrw9NMFy0BvgleUBPDFIPEP9tWlio/xbNAZKpMpJxSf8?=
 =?us-ascii?Q?UhEf+lI48BN3+Nj1vphzId1wZcv8VnLqu1CVykEEHmw6XdYeP8yjG7dnfLe3?=
 =?us-ascii?Q?AnOKJYJpciTk7/hariML01k+pn2hZorw0xm4+YazrijklLWbBKGWQlgxNhgy?=
 =?us-ascii?Q?thZ08c3Hj0bVMzLc8/+d+snykCDvHx7R7uAUAcMOv68oLE0/qJhDy3Az+4XM?=
 =?us-ascii?Q?bNzaCS08fJV59ko21vAkpcQv7032/T7ltaIRl73s0+i9ALevC1r3XZvNN9LZ?=
 =?us-ascii?Q?R1kognrjXz7iEY/+L3HNPG9bwIvRU8XhDQb9j0rKgBP17diOYqUVL9OqXVdz?=
 =?us-ascii?Q?vzlyyTUZ2xlYScVR88FpU9r1mSTnz5JnBesWdO/Dd9YG4Gsf0EV9yxFSrMMW?=
 =?us-ascii?Q?oQ1de9CZONruSJlIghpV1JtISWUyU/IC5ZNWZI0+ftZ4Lc7u5zmjAEB4Gnyx?=
 =?us-ascii?Q?Wpe1eEA3hZ3ESNW+uiFzqdWUk4HO215iBuNed+WLCQIwdeMQwLukDnA9lVm7?=
 =?us-ascii?Q?lptnNXVxXSnrgC3GOWiX1DEQ8RalMK6p/dI121weSc+tS/PyqsqXEM2lOLFK?=
 =?us-ascii?Q?XqLlhkUu34q9OaDw9TomGokLeL2QXvye8jxZ5TUO+uxWnalwxnBwfvYafgNv?=
 =?us-ascii?Q?ezIgwtXamYfy+84r+HBk1UECuASq+xoVSIc1rbYz75ylYqrsHDyF+lFxEHlV?=
 =?us-ascii?Q?nBzy0arGp4p1N0TT5TBW3AvWSfgQKqLwtf+GRh1kJLMqLwjDg68YqOPatF8F?=
 =?us-ascii?Q?4P8kTs9cJd5VrOKgHbkEZGC5lWGLcoc+Gk8BDwomw5eRyEI9VksA7uszvbfw?=
 =?us-ascii?Q?eFCm+C4FvBXxQJrkTFv+JWQNfW94aIyv6jMc3Sm1z2NaO04qa2zinDtJC6Wm?=
 =?us-ascii?Q?V8ocqC8At+Yc+kpqh82O154SJSWCCpr8riXGsNmZeEW2wWJUQXRJtbvZTiY0?=
 =?us-ascii?Q?4xkxEhjN0McFvPYrbsj7q2mROi9HCDZ2a+46S6Qlr/lEJ09TApZHjwLC653p?=
 =?us-ascii?Q?mscCtmrXUd3MU38JnvamA7D/AZ92wC+maAh2sVlgZWjpT5i2Bz1sS5SgtIyu?=
 =?us-ascii?Q?Dv2LBc1jtpZEq0z5sKLqLqJW+1DzYxPQSMTY9FmRpC3r3cQRvAzWEz8jkQBp?=
 =?us-ascii?Q?9szfUivpmmG+sg4hBj/KnDVf2/vNoQiicZlxWkus?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430aaf52-91c6-4758-2fdd-08db17f97ca1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:00:51.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+Ou70B9Dhc3D9fayTNOkYgA5GCdWazznqHuRg8j+PcG6WmNAHBOFvQw1PuOVCNjvDeLlMwUlBJF0SJUdGyKfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968
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
ulpi.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 159 -------
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 408 ++++++++++++++++++
 2 files changed, 408 insertions(+), 159 deletions(-)
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
index 000000000000..b30ed11fa22f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -0,0 +1,408 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB2 ChipIdea USB controller for ci13xxx Binding
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
+          - fsl,imx7ulp-usb
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
+              - fsl,imx6q-usb
+              - fsl,imx6sl-usb
+              - fsl,imx6sx-usb
+              - fsl,imx6ul-usb
+              - fsl,imx7d-usb
+          - const: fsl,imx27-usb
+      - items:
+          - const: fsl,imx8mm-usb
+          - const: fsl,imx7d-usb
+      - items:
+          - const: fsl,imx7ulp-usb
+          - const: fsl,imx6ul-usb
+      - items:
+          - const: xlnx,zynq-usb-2.20a
+          - const: chipidea,usb2
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
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
+patternProperties:
+  "^.*@[0-9a-f]{1,2}$":
+    description: The hard wired USB devices
+    type: object
+    $ref: /schemas/usb/usb-device.yaml
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

