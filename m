Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6D15F9C87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiJJKRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiJJKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:16:56 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087B6A4A6;
        Mon, 10 Oct 2022 03:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0lzxgIKUYBd8sZdH4RPmheugwwNo6r3uQ1ekV6iAEgjn8XDcsi9bZqI75xnrzH/ekd//lRkVB7iPkRJtfBDI1/enjzk19oL3B9GEML0fWzBEIWlneG0rPI08lgoSYQdjD6laX2dG6TrbQJ+8uPs6uYo4piaSK2jRywd0DW/Vag36pR0oo7JTdPtrWSPnjV7YGRE1BMT0L/sog6qK8v5If3wzgMvI+8DPm6zn2HhhuMLfly0Hb6XX5FMtnoa5zzeA4hPwlBtQPOEik46DSiw5tI+1+U2uXQJ++QCDTIqgG/uGpmfQAqWPg0mb0WifDkz/jnH6gbGvmtyyA4qTYGjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahOejVLbNPQKU2eO9Jbpawt73UF8vy00KzB1W6vGIbs=;
 b=hlyIoI9d7XLtyQNVCLnlIFAFwlqCiwhZOVbInK177klAzQyDVygCRlHcD4OGWf5gEVHrFh6gyA5Q1LLJmoplFNKCGZ6wuBNq79FXFfOq+8nhbYKQ/o/NkrBswt3JYTe7rM6tWDQC7TS63sybsef9sIbDSs5Puc4yQi0jVtp5WPXMlR4dbbyV/DWjROov7s9jWFGaoNPo952Ni7eholUxEF7HE3A3xccnd+PD+3fhVyyJOlivMAq5GVEK4HstZKQDe71bXHjw7hM/Mh8vgGbDAajMQra2OVukLdCymnrd30byXaMdEBWDofFoKNdixeKPexedAcuZLraJt9gB64Qn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahOejVLbNPQKU2eO9Jbpawt73UF8vy00KzB1W6vGIbs=;
 b=HG0nWG6Sax/Cfy2Ldr/IcsFlpCyswxT6s0WmZt5izmSiKKfu6Mj19Pzil8rM6lefTNtWJy8ZOOFA0J0zPKIAIMAp2FkQLdRGPS4mp4JaSIQzzz34cwMVmoY/vkRL+M4rnjOXM3XV1ZPNOGUxwgMUFQ+7cvEyEx1/1XyXLNbsM+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7783.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:16:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Mon, 10 Oct 2022
 10:16:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/6] dt-bindings: usb: ci-hdrc-usb2: convert to yaml
Date:   Mon, 10 Oct 2022 18:18:11 +0800
Message-Id: <20221010101816.298334-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221010101816.298334-1-peng.fan@oss.nxp.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: e51a2fdf-6170-48a9-db62-08daaaa88b46
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwNhIU6dEkV6MuVNXgIF/YRY0FeTx1ClX4yd7pIYR/JnNxTwN5CgdpkfSqJuufW23ORCdR44WPW2VIViCnN2b/5WUrg7iflu1MsoA9L39zRRInXzJn3vOw6fo+jnjZpMr2Rv5vrVABd8pp2t0l3YAfRieFGKPXsikI8y6XmC4bcOaAc+X9fvx55tCq12ml3lsfI/9t8/ETaNniaswhb79bpc81mZUbE2HbHSEIiBI9YEesecwD9qEOIp2qBFd9W9bIIwRQ+Y/EB1DHVCW1iDYE21NLcaLB9Dlwf6P6QLbOWj1tE8mtwwGOmu7tIpWQpR6SH4cgCfXAptaMcAktHXwpslZKbEdHKwjuJopj3m/u7xNIUoU1rC/xIHO5zn79igCbQVmKDaRUDhollZtSbfa0K4gJdsGdzCZNaMhRpft/cMoivs7bO/iZ0NKb2JtgWYFtx9u2eHRz1eAZk1MZEB0P7iJE52/alO/jVKNl9EeI1H1Pr9F7ShgI0/xSrJ1ruyoFfoNy2k9bLy5dF8+/CpwkeTE95BeWzWSS05+h+FbUGJtcQZ0SVfTCJjOccQeR91g8DZQm3GsSpAfvRboQ303I5sD16VpcnUZGT85e5NFmGsbQH/Mn7a+DYwgm9wFjgqr0sndqCXLwdHOdXy7x83dyOtFa5RrmvOFs86kZhPUVUZLJXOndZH9wCxYcnv4EHe13qKhzROzEqFJxP6PKKWYqlt7b/I0yAhi2Q7TZG2gnLSPcmhP8cAj25jpYjudMRu53i4HtVRHFBb7QRwwvUZCwR+U5hxDEYI3baGjyKMu77ac1u2NvqpM69tmBs3QbDF3xDkQXgdg3bo4X/h6vloIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(316002)(7416002)(2906002)(6486002)(186003)(1076003)(2616005)(66476007)(41300700001)(6666004)(66946007)(83380400001)(66556008)(478600001)(8936002)(8676002)(30864003)(4326008)(5660300002)(966005)(26005)(6506007)(52116002)(86362001)(38100700002)(6512007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3sJpOmWAByKasFNl+SURObPM7+oDPnQBjKSKKBMKmIlc6MgmxqZpBViZvSgY?=
 =?us-ascii?Q?BwkdiYBigqc9zfOyT+1Wc/oMpoPYu3ZNvQOwZCqpUKt6ULKvJqiE9RZZ7+L4?=
 =?us-ascii?Q?KlzNsQt7zuiUQyigtD+7N/v9SL3P3tO28ewZ0qp81APRtuwPd20c6n+8LfTH?=
 =?us-ascii?Q?grTzKH7nt3V0YlMzSPlUxs9KqgTMzq1KwPhJMdVXicgYtNxCML2Jx2GUGfiG?=
 =?us-ascii?Q?eSelKsi/rEf2yLK6vIeRUZWCWzKuGpB9rFLBLx9ydxQFZKCeFkdad21DfcIe?=
 =?us-ascii?Q?sS0oqIF09T4jngrz7VeEuISsTApW3EHEqUZPJDazRr1pDLG08eyDTDcdOP+y?=
 =?us-ascii?Q?D27tgZh76UxoYW+x+mdMm2DCI2nVQCsZ0d1UYAilEWr7J+73W60AJwl6KH3C?=
 =?us-ascii?Q?HqBfnPpzotjvf/HWmzlqI16g+gGu1fxf+vrqXuEDKuHajJVkkkzzXQ3EcrEU?=
 =?us-ascii?Q?ILAC154AFh30XNa5YMuO7uZh9/8lSFdOFLNDTeSmiRS7NZk57rn2s/2URkMr?=
 =?us-ascii?Q?LFHxl3vqtsUxlpvMXQ2ryP/iH83Jr4ixv64V2GVTru9dU0/Y3E8/Yb7TuzQb?=
 =?us-ascii?Q?WlC8Ao0ycaxIfTUS2SVlq1D6TFdvgzxzqgpsS6Jcxv9GiGmRYQeI99t3A9G8?=
 =?us-ascii?Q?dIXMAO6L6jpXeGn8Fm1VTywSuYe+8oTpZk1R7tQpDD6xmZp0hBExME5Tit+S?=
 =?us-ascii?Q?vgVo6zn8126EcKQlUvexc8UrOESnWHLy9m1nwbYbS9r40Nvqqy6rWDk8T+Mn?=
 =?us-ascii?Q?MB0jiq6TOnePcP5PyasBx4sMrOV25OtYQpLuCZ9WlJDQ6YlkKouGX+1vLsEP?=
 =?us-ascii?Q?K0/KH7q0Hy8CmdHBd19lPe46ItsU1iL0kYGsnGExEv+DPF9ntYrQkzeA4o30?=
 =?us-ascii?Q?rUUvSTmW9KQrDiOu8oTnyzrMgPI429Xvwfi7LCEVk5BbO7ehfSCJFkvslxmO?=
 =?us-ascii?Q?k+ifiOsxEQzfbyk1Jlpgorq2PEED4cr8thDLHbxei0JKoWPvlBnJg2coa/nh?=
 =?us-ascii?Q?7MpkujMlGwzarp3d2z9+ta94xWEzb9xwCZPTvK2ta3XRIwmbdyPBRPJmjbxb?=
 =?us-ascii?Q?27fILTRxkNDwULQPwroCjaatmtXOqx7e864V69iOHLa+49KTJy31GCahFa3p?=
 =?us-ascii?Q?EHJzaR6NEhMWsI/roLMFJlwKuG6rmWb9w/WgP0ZoZ9TdmtX2XK8Z/W+jKm9g?=
 =?us-ascii?Q?pseClLZPw+f1gFZdFkfww/8Wpld6OaeUhJKNg73iSqPUDIV+JZ3XENRtOIBw?=
 =?us-ascii?Q?afnXncv6k7hTZqBm822Byt/wDbf2qF7EtVpi3KKp6OQLidLKsLChKao+fXaV?=
 =?us-ascii?Q?xonZOsSkIwFn7SID9IpSeWH7aJkn1F4EbG70cgent+fnY1RX9D4dUjrIOoWB?=
 =?us-ascii?Q?spKh3CQkOi+1nwtJ/DYmUA+AEQfS5ps95pKY3Rx8gHXu2umw7ppZZ413lf8s?=
 =?us-ascii?Q?bsp+yBYe4n01JnBT8Z+Scgpb95UO5i5GE6jAQZoDyFkOlol1F6egS82tx9LU?=
 =?us-ascii?Q?w+cSqINB/3H2xDyjgu5Nt3YrM/Y+9Y+bM1rSO0EpKvDUosfs/SaqvHfT8I2H?=
 =?us-ascii?Q?fE9FeVRz8uf5xaEDKLCPXLwMOaNXqk//tR7M4Wed?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51a2fdf-6170-48a9-db62-08daaaa88b46
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:16:50.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgC9dlmUmF6le/7uBtbFGSR0SgxbLEVcozTzV7pf+IH9K0QG1hil01w+Mz9KhabT59hq0G8fXJYPqjFbFwTnbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert the binding to yaml format

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 158 ---------
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 306 ++++++++++++++++++
 2 files changed, 306 insertions(+), 158 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
deleted file mode 100644
index ba51fb1252b9..000000000000
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ /dev/null
@@ -1,158 +0,0 @@
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
index 000000000000..1c10691c45f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -0,0 +1,306 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB2 ChipIdea USB controller for ci13xxx Binding
+
+maintainers:
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
+              - fsl,imx6q-usb
+              - fsl,imx6sl-usb
+              - fsl,imx6sx-usb
+              - fsl,imx6ul-usb
+              - fsl,imx7d-usb
+          - const: fsl,imx27-usb
+      - items:
+          - const: fsl,imx7ulp-usb
+          - const: fsl,imx6ul-usb
+      - items:
+          - const: lsi,zevio-usb
+      - items:
+          - const: xlnx,zynq-usb-2.20a
+          - const: chipidea,usb2
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+  
+  clocks:
+    maxItems: 2
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
+
+  mux-control-names:
+    description: Shall be "usb_switch" if mux-controls is specified.
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
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: usb-drd.yaml#
+  - $ref: usb-hcd.yaml#
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
+
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
+          enum:
+            - fsl,imx23-usb
+            - fsl,imx25-usb
+            - fsl,imx27-usb
+            - fsl,imx28-usb
+            - fsl,imx6q-usb
+            - fsl,imx6sl-usb
+            - fsl,imx6sx-usb
+            - fsl,imx6ul-usb
+            - fsl,imx7d-usb
+            - fsl,imx7ulp-usb
+    then:
+      properties:
+        fsl,usbmisc: 
+          description:
+            Phandler of non-core register device, with one argument that
+            indicate usb controller index
+
+        disable-over-current:
+          description: disable over current detect
+
+        over-current-active-low:
+          description: over current signal polarity is active low
+
+        over-current-active-high:
+          description: |
+            Over current signal polarity is active high. It's recommended to
+            specify the over current polarity.
+
+        power-active-high:
+          description: power signal polarity is active high
+
+        external-vbus-divider:
+          description: enables off-chip resistor divider for Vbus
+
+        samsung,picophy-pre-emp-curr-control:
+          description: |
+            HS Transmitter Pre-Emphasis Current Control. This signal controls
+            the amount of current sourced to the USB_OTG*_DP and USB_OTG*_DN
+            pins after a J-to-K or K-to-J transition. The range is from 0x0 to
+            0x3, the default value is 0x1. Details can refer to TXPREEMPAMPTUNE0
+            bits of USBNC_n_PHY_CFG1.
+          $ref: /schemas/types.yaml#/definitions/uint32
+          minimum: 0x0
+          maximum: 0x3
+
+        samsung,picophy-dc-vol-level-adjust:
+          description: |
+            HS DC Voltage Level Adjustment. Adjust the high-speed transmitter DC
+            level voltage. The range is from 0x0 to 0xf, the default value is
+            0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
+          $ref: /schemas/types.yaml#/definitions/uint32
+          minimum: 0x0
+          maximum: 0xf
+
+additionalProperties: true
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
+        usbnet: ethernet@1 {
+            compatible = "usb424,9730";
+            reg = <1>;
+        };
+    };
+
+...
-- 
2.37.1

