Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BF46C2CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCUIte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCUIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E398A3CE2C;
        Tue, 21 Mar 2023 01:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyTPISU9EPbn964l+DbYjmPTk3aS0+asl5cmkYFdsc6PfJHT5CYX8zFx7SIw/nKfGIM1tpmnmp+cXmGgwO94jPg/qzy+v2sMvicB6O8wVBDgrZrXQXXukJSan5tPPNvuo+HrcOAMKpRX8r+g370KQHg7hwDmrFTN9r/Yu25yB6/vktbt1mq5iC8ckiqGu2ZzEH6MKdOu3PiYarHKZU+zBJBEkeIzyZkR6ncvWglZhrh1uJp82JZljFHMXOuNU1nyQPKyg1m+p0yvNKQkNPdozYfU5bW5KPuywdrHlAZnrfGWY5qmMOjJF7wXoojk01ZopMwYWXw06+pR98jqdA01Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beXNOsjsQGr+JX8+No25ESFLgF4GOj+X9qeIgtGThK8=;
 b=jutgsJakpRW8XZZnlpsCG29hUKWtvi8YYjCuw/VPxM2/X294xe7oUzf7UOZmBx1sXZJ+1qusdoX4vCDLZQBzRY0JWGX7pY82PcKmDL1V/i+LuQeEXMJzvHaRuV6d0wu3xqtappI/RBVxy/YSlLsTp3nqedLvDE7Z/mgZba9Bmtny/ddGgM6wLYme5HhBGTfRPDPgithZ8d+AqjfUFmMmrGzW0HxOZLidgat8v0IxDBzAKOGZ5P2HGC/UiV7/mhWf1l5vpZYQApFJ6vhh6Th8fmfJWGm91ZIZjwvdZDMAt3aRXjwsVsxpPTbSOX2XWv7d6AjMkEcV5co0cP08EKLDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beXNOsjsQGr+JX8+No25ESFLgF4GOj+X9qeIgtGThK8=;
 b=QI+ujsy0JYwrojlXF+GcyqeCRcoT/BQinD+muIXEuzwhi9dwQdu33CAAl0PlQks0kzjBeAdyMu5njQ+yHUqN0xLzzVdg/S+sKfdKIyyeZnAa7UFBEiu5ataImqYndUFB4QW+4XE0KVP2M++Z9dVruWOxYqz2nzjPxk8XYnksgAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7849.eurprd04.prod.outlook.com (2603:10a6:10:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:47:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:47:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 02/10] dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format
Date:   Tue, 21 Mar 2023 16:52:05 +0800
Message-Id: <20230321085213.1624216-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
References: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: b75e7c87-9c1a-448a-f7c2-08db29e8e1cb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sPa0T7tjIjbNUpAYzSn4H9fjvPmN1UN7VQve/9tDTinRSfxUsUBZC8fmRTiNjBdfVo1GSVRUIpDHzUYC38naS2uMyl6PAink/BUaePy2CHa/fmlu2AFPDcBYnPkabdmqrARmzyPhIFCrCH6o4wBuWHCFGrBJrZzlJA2cQ7Nwpu9LkGtOrlutuhwbSDxYiJCfWjVl0WFF/4wgK7LIJwY/woHqgChyCjhryThDZyZLJgKtjspqjWEIvChqj1snLp31OKk5ukPtgWYkgVxF8fQlnpJvhrslAO+O1l3zvdfpSJCKdYVS3w/mXD4Z3X/uVSeE0Ie4KcnSV6aDxuENtFucgbBYU154lpVbVfBjSZm21WC0m2K9A5RldpMBqHNAXtnHXywUFogxizNsOUPx77OMbqx7WHpkrQ4j21Z9VFa+q2c0H+8PgVF/AqvpdoLyh1fBW//nHqS/DRfbPtHCNOFeyMkIKxinpkMyt+cu8lzot0Al5fv0jjM42O4bXkpJJfdQsSkxJOlCG92HC1Sz+k4hm7UTpHik+eo2RLJB1R8vP+Cuypwg9S5DoMmvzGdzBWRFQDOQycJ4eyd1/PtpFACRufm7ppN8o9vYcyTM0cJea4GsBZtiVA6mZYZsFxqxducBCpWsT9cgRQ+ub9UfK0y5n2jXYRAbXNBDq1z6w2QNxx8CONDj1UtyDIYFwgxoRK1NeH91iKGYNfPj9alcK76oTUq/3QQVMaZ/31rumVfovA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(2616005)(6666004)(6486002)(966005)(6512007)(186003)(26005)(6506007)(1076003)(52116002)(38350700002)(38100700002)(478600001)(2906002)(83380400001)(86362001)(66946007)(316002)(7416002)(30864003)(8676002)(4326008)(5660300002)(8936002)(41300700001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9TGspGYLnhucGRfXzo39KJffoxCzOPxsZfWb2MFNUUwdLLyCITpVp5aFIc2P?=
 =?us-ascii?Q?mTeo0pC4aJAElIV2PqNIuhUt8fWjI84XXdiOtgq85yNlKoV7KBUmcGGiFSRU?=
 =?us-ascii?Q?DZ8A3ktynRn0lYP4J0DD4Kx2p4CJaG/NWllCi1XxC0YG9RWZX+tE+LdCXKko?=
 =?us-ascii?Q?AzzgkC7me38So/jDeL1rJ9spnI3NL2qLoXEConhW6p9Z1oPhWMdZLGgI0Hk9?=
 =?us-ascii?Q?ymMAU5g+WFKVb6OIF+eZMrByHO8JBVd+lQnAqF/kz1WAzm2AyImD0LDUZShB?=
 =?us-ascii?Q?hc5btihDUpypNWM1g8Yp7iZToysnpYWYunsUPS7jDNKEi/iXKCpx1FA5Rc0A?=
 =?us-ascii?Q?lYm2P0kp00snLFtw0vZQA2ysYGcGAd0HUUhY3R2ggPFBuErziXf6sLGk325n?=
 =?us-ascii?Q?l7rH78ZEfzYvxqVTbWXkP/wCE3E7II5ETpY3Y3eNtaS5LfwrwsVQSspv5Szy?=
 =?us-ascii?Q?+Ae2xXhgeiKlVUy9YMCepyDfy2ZR7RjpWeDh+fIvx1gIWiqwhF6iTwe4jAej?=
 =?us-ascii?Q?oAx47UkYm+ib6j10C2pov2wSv/KVaAvrz+rkg3QlNMmP0v+JmNTTKRH9rv/n?=
 =?us-ascii?Q?4zdkPYl1R6Y5JXGxgb17QWig/ppZmxJBMlHZ3H1wff932rFXiRwZb5i6/Rb0?=
 =?us-ascii?Q?m0hReQ0a0Da2pY+U7Y2CAVNwwuPCl0R09wWWPNX9cWZGRQcbFjOAS+CcAOvl?=
 =?us-ascii?Q?4S3ClvGI954dDsHh7r2TXvWRofH7EAbF+JskeRMZtpj+hGVFz8DkVS2RQnCx?=
 =?us-ascii?Q?aoAV4w/pBnAoWZ4zPAz36bZa4MbLDTAB1+wQjXItxgFyZJSFR0R/8PXJUhTa?=
 =?us-ascii?Q?GXyI56jwq1asmTZ6w1y5VhspeCs32XrZv4MqNlfmgR3k6WIabtRLbFcoVNdz?=
 =?us-ascii?Q?qDbqftNdritBduPN5wgRvvNwEe6vX1GB7aLZon3r6mp1XE1ZCuiklB2RwAr9?=
 =?us-ascii?Q?PlFFPZ8245ZPxlEb5+fSam/gdurIIgI55r3HtpYja2VIoLCzbVNiDUNGXgvk?=
 =?us-ascii?Q?LRCmtKfj83aoESP3Xi7LPkgwG+qL2v1EhxgViJNuCrH3YpHpsFQixkA79TTx?=
 =?us-ascii?Q?CPi9YHzcsGagHgwiVZY3zOkneRoFg9J7tyDJKk+uyfM92CUy0onqfBbGCXIt?=
 =?us-ascii?Q?NRiC9Ehhwj204Emoj7ycc8O1zYApYf+D5guictwtIiNWQpQwdfeDygSWaj6k?=
 =?us-ascii?Q?r6uTU6wzHM2d0GHNJqyjR49gHz5iWJH0BWWLpAqDxhei0uyrCxH2BjQUkeM7?=
 =?us-ascii?Q?13XNyZ2CQcK7gSR+OilCqjx/5g6RvdH/psjlndK+nXQYeNkoiu2KUD3sruC7?=
 =?us-ascii?Q?OzxIR+b6grzVHPa9EGVsL7aj912Aal7PQscQfmkDGwAroI6vowo7WBPk9RM5?=
 =?us-ascii?Q?nNgMvu8YfxBHJE+XXwASZeEA4OqP9Up0PBFBnzVMO6vNEt6bFRFF0m6/BGw5?=
 =?us-ascii?Q?iySJmgL8O1OQeEAyv2yBzycWraionYd/dkbJeb1KkLTQlY/ACbMSNzLdOdFw?=
 =?us-ascii?Q?0JShUyjDYMmiz7eEjx9LD3Zh+049VQkUWJUbM4+JdlOZRDQecgczcUd9vdkS?=
 =?us-ascii?Q?ifGM47HJL3FlxKyPt3aAd9JKfCUjt2f3SE1+G2o1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75e7c87-9c1a-448a-f7c2-08db29e8e1cb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:47:20.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhO8xZIxiXi86qU+E2ubvDCowEsC7wAPtAJURwH7Ed2K/5veSKo6U7LnQ6Fix8Rlv6DSC/DT6H8ptsfjlnjUaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7849
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

