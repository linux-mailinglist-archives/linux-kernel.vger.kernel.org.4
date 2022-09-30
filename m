Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF405F11AD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiI3SfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiI3SfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:35:12 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70AC54666;
        Fri, 30 Sep 2022 11:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5SMFPddtkmkdSv18GYj8R7/frCBzljvj+zyBoSSxJcb8Exy236nUWMLyEMsdgOaIbD0e71xR/asezqQT+Yw5xMaS+/WIp/iba/GV8rbz58IhKpBkMDiDtfcyvSmWdiTE1uwbva0eo7Jgz14novY6R3ehgk5xSebryRsTBjAezTJ9NE/VoZA4FLgZcELYq616kN9NB/31k80nvPJPUEaq/aEX63hjxz9gO3RBpPCbpX+69FC200EPlr4zJhOVUj4bjF9dPmuTQLCv5nSI7uT5+9ARAqg7tNkT/lqXtJ3Bu3Eg8NoE3W79+kUts1pA9kyWWE594XjZ4woc/xQvQpOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxQAxOpKvxqFsvJpMQI43AF34ymdkXadTcBVW4ZA+uo=;
 b=Rl57jP03H/nJrpYnIPEA2Vb6aFaumWlOWxBWcXc/1rDSXWm+4rfXu1rNr/J0faFaQqEEJjkiDTcpCX5EA8RPgev7jJpXy5ujWW6Rl7IWVsB7agGgi+s8U0BoROhOg2y2HtJjiq1KoVotxRX5s8byBE7Li1Wout5phfelQvadwnZizAZBotGnxvtKSSerpLE3b7ulZszm62tMnImoB4aaT8LwwxaXhguqrwEWGrWpo4cY7/g9+is9aTojRYYVJA2w+2JuaT9wW849mY2eLHv2hZMSUAMfaF9hNjgZ5cdFKGdwkpa2Xj6Hneb96T+or1m5x2V+DhB/MWb+l7GIQniwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxQAxOpKvxqFsvJpMQI43AF34ymdkXadTcBVW4ZA+uo=;
 b=KCXiEfEM4nWRy+0Gt1RI72V3UEvgoFg4+Urf5U6swZt53lQy+sE5pN+zfLP1BSO9E97I1XT2Iu3JAX/0kPLyngOM11YeQZPGKTnN3EDu3FEi6l6i5qrJJ6Eew/TLR97+OVF/Ukhxs4cZWKfIBlz0W9R/oggDnp3tZ9mvEllawCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8942.eurprd04.prod.outlook.com (2603:10a6:102:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 18:35:07 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::4d5d:40ae:e0c0:63a3]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::4d5d:40ae:e0c0:63a3%7]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 18:35:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] arm64: dts: imx8dxl: add usb1 and usb2 support
Date:   Fri, 30 Sep 2022 13:34:25 -0500
Message-Id: <20220930183426.1130641-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220930183426.1130641-1-Frank.Li@nxp.com>
References: <20220930183426.1130641-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::7) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: de1fdf34-b801-4094-04b9-08daa3127f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdQ2UeQqleDJpIKrZza5C3rl/EmBhFjhYFUFzAKFLtYaPpYMWyFicovaGPDMQZmj3rUeBcbLDNmXQSqWcWNEXHpQLnBPsSz2Ie8UFUPY7XW2rtXrYIu8pk+F4pGrtec3qxG4ADMIBuiPFyD/U1cBWcrdQHrAdh2w90PGKdW1s8/5xCqCFpPY5BTZoflC1eNQgc2iSJduEirZC/BWzudikqGiNiAZm+gYTMG8XdmFLQ0+zGno74/Hv3/ixSW8tSdu7aqMlTJPjf650XluuZBKPPtt+sKfXd3BAS26BGq6D3WBhSmVev6Ihw2bvYZLHr0EmpJw83IoAnuG2TAE8xxSXtM1XreFy6qfVXwYgGTGnM8B/3nTquxc32UQj6X05kuT2IS9m+b2Y5Kge4hMmdEFH1VlNNA901JOlLNjYa8ysd13L9oRnlX6qZG4zpYqn2rBUA8X7mZcXVoaJCS5VAfDXScT5fHngzTl7AiMQHmE9eY1GN3j0qsALKbhp85lmVdfpGdXbKwkGK4ra+MLsDMkC5a5ORoaq7/KcxzZ5MRPzADpgM766thmK+ZaP/TxuEOPkQCKvy8X36AxFxVNTxX/QRFmqEzN+jxMc5ja7hthKUQ3FB666O2s3o57WF7q1dYxRNchFKZBQ5430DrcoPfRuPENJl1nfAmFCYvdoirAi3hjpad8fzxSF6/adgBHl1mHglSWOTDleMvAJaG+O162wbnZzv+C5s1zxJ2cI9Ip48aYtYn1ErDflvJCqmVaPn35oOxRUOHtPmZEwZRgLxWYcUAHhxLL7TZ6t1Lw/y2xFlNfH/0fqHyIife9IG91oJU1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199015)(2616005)(478600001)(921005)(6486002)(2906002)(110136005)(316002)(5660300002)(86362001)(38350700002)(38100700002)(8936002)(26005)(7416002)(66476007)(83380400001)(6666004)(66946007)(186003)(41300700001)(6512007)(52116002)(36756003)(6506007)(1076003)(8676002)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+EGA9M8fyN+oQM2Og0JT2vh6wxmD93WrWtA3uWlKkHLHieDAzDQxNcVVjeHT?=
 =?us-ascii?Q?WK/Z3mAF5K1jeiI9rQnk6cc7Ot5n/pOpJGoUTTIIgR8My7titEYDNs0jeB0t?=
 =?us-ascii?Q?Xh5dURvjyGOha4yfcCHWBmzz2DO4WEwzZUDP+4rDsAPhCFFa4vvEBtKSeF0A?=
 =?us-ascii?Q?y1aUsjQkLlPYeXatvRwdidyXi7qOgAyjyRgt6wPpe4uSKqzLlD63afx84rcL?=
 =?us-ascii?Q?LxIG8nyQNzEB1Uw7exrfk3ynGF3ZIHxNr2lOqduMnzaJ75PQGTTWTqxH1+5E?=
 =?us-ascii?Q?kAWKQCTT7MauMZSyJ4XUyrcRNSZmf8K1pLGgtvTxYCQpG2mjPF5OEWMx49OK?=
 =?us-ascii?Q?IDZbm1FSlhI0lTF67zZ9rzytc2QmtMXfBXNbkaCeNeTad2T4l8qluyTsVt9z?=
 =?us-ascii?Q?+kAzCItMZXZaqkC6iLjyBZRlTwhripizomjo58GeUb0oLD93qHfP9RGDlV4m?=
 =?us-ascii?Q?BtfO6C4pIsmzoV2Pv79bzqrL2lflGnNUHuzc17aW8fILobZTO5GvfZd3W5uq?=
 =?us-ascii?Q?+NZSRZHCZzOpts3GhuP0pZGqYMd2h4NJoYmb1sM8992z5/deIGXVWIHf2O9y?=
 =?us-ascii?Q?q38yuqca02TO8QKsrIm1K9uvcOOkmSUNjuNvWqKK/uIRNEds7CR4sBgpMhLL?=
 =?us-ascii?Q?2B0OrnzWSBJM/prR8q7NORUjUpCRnQMyMaz5ohjyqYCRUFlTJ+GLEPFc0r6n?=
 =?us-ascii?Q?iijGvtr3USSW99X0AIMLwbXto08/YTpMp+NlSwWZWhCINEG3nyiiTGmHFnCk?=
 =?us-ascii?Q?48+hCdNkleTPFGVHYljlu6k3eSDz+gEgYrberyNkE60qPchNb98n2xTGuda0?=
 =?us-ascii?Q?dq2fsulU+JMEK4UNrD+oCk9eCbs+B+XzBOygRsMvcAYmEj6B7vr8zYxCif/4?=
 =?us-ascii?Q?gTFfjBArmWRPEg/WcfIHaL7XuVnwa5exZ4/MoOPEtNH4wCOGzK49s8ciYKJU?=
 =?us-ascii?Q?InkUhDi5r8LruFyCfgLVLSAcVkWuSIx2EL1pDtuIPQXCrTLAjzLaeSZANAib?=
 =?us-ascii?Q?MZc/BMsl8qktsiAWM+mTuqUJtTKjLvIfrZf/8lZ3R5Axp7fKkuegvzVaj/0Z?=
 =?us-ascii?Q?v+eVX4UheJPBPkWti9jSQG/ehpbz0GJuZL0dVFOFjGUQ30bHMk4R06/xEoUP?=
 =?us-ascii?Q?KmcL8sXYwM2yjkmRNeyzYW0LbJaFFBi68MK9u0q5aQDdzSWOHR3EUljG6Y5G?=
 =?us-ascii?Q?C1FkaiSSnPYOiR9y9SjYlpvzOy7zO8179Fn04ZuASEMy/Grnh5+5+kArlj5x?=
 =?us-ascii?Q?rBS3F+BBgL5QKf307N1oh5Nb8Kstx5CPXf5qfnT2sdny9EhqaaIRvM3sVZoI?=
 =?us-ascii?Q?w/McMnSplitAWevAncFN0ZrUfYFhmohsGAGGuN0o4oMVgN3EEcNfX3rPGkih?=
 =?us-ascii?Q?d0EoUo73WohpUrPv9JOF42EvpwuMbRK5RbDdRfVz2WBg2F6TKdadQR5u4Md4?=
 =?us-ascii?Q?qljM4a8LF33DeKoxHtXvAxACFeS1Il5J9bYeJeaDhBetaL4n3n9kX2Lcu5Cl?=
 =?us-ascii?Q?bE9BZGNGAzjVv8YZ/keRl+BbBQwFmCoOFT4VYh9B/VSZwSzBxwtgiscQFLQT?=
 =?us-ascii?Q?PsGKsfd4dbNu7nzeR0FlYALU64V1tyVgpAtMxuHw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1fdf34-b801-4094-04b9-08daa3127f68
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 18:35:07.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLYTwLmIgUXXuImNemuUxqpt/2Tmhsy4CdsU07W/A0ujHe+AfvBRPr6TE2IbdWZhKLUX3EpuxGqyheO7akmtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8942
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two chipidea usb controller in 8dxl.
Add usb node at common connect subsystem.
Enable two usb at imx8dxl_evk boards dts.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-conn.dtsi      | 39 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 34 ++++++++++++++++
 .../boot/dts/freescale/imx8dxl-ss-conn.dtsi   | 10 +++++
 3 files changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 82a1c44883786..bf72732e311a6 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -34,6 +34,35 @@ conn_ipg_clk: clock-conn-ipg {
 		clock-output-names = "conn_ipg_clk";
 	};
 
+	usbotg1: usb@5b0d0000 {
+		compatible = "fsl,imx7ulp-usb";
+		reg = <0x5b0d0000 0x200>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,usbphy = <&usbphy1>;
+		fsl,usbmisc = <&usbmisc1 0>;
+		clocks = <&usb2_lpcg 0>;
+		ahb-burst-config = <0x0>;
+		tx-burst-size-dword = <0x10>;
+		rx-burst-size-dword = <0x10>;
+		power-domains = <&pd IMX_SC_R_USB_0>;
+		status = "disabled";
+	};
+
+	usbmisc1: usbmisc@5b0d0200 {
+		#index-cells = <1>;
+		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx6q-usbmisc";
+		reg = <0x5b0d0200 0x200>;
+	};
+
+	usbphy1: usbphy@5b100000 {
+		compatible = "fsl,imx7ulp-usbphy";
+		reg = <0x5b100000 0x1000>;
+		clocks = <&usb2_lpcg 1>;
+		power-domains = <&pd IMX_SC_R_USB_0_PHY>;
+		status = "disabled";
+	};
+
 	usdhc1: mmc@5b010000 {
 		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b010000 0x10000>;
@@ -195,4 +224,14 @@ enet1_lpcg: clock-controller@5b240000 {
 				     "enet1_lpcg_ipg_s_clk";
 		power-domains = <&pd IMX_SC_R_ENET_1>;
 	};
+
+	usb2_lpcg: clock-controller@5b270000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5b270000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&conn_ahb_clk>, <&conn_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_6>, <IMX_LPCG_CLK_7>;
+		clock-output-names = "usboh3_ahb_clk", "usboh3_phy_ipg_clk";
+		power-domains = <&pd IMX_SC_R_USB_0_PHY>;
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index ca2a43e0cbf61..a91a70651ea4f 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -266,6 +266,40 @@ map0 {
 	};
 };
 
+&usbphy1 {
+	/* USB eye diagram tests result */
+	fsl,tx-d-cal = <114>;
+	status = "okay";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	power-active-high;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbphy2 {
+	/* USB eye diagram tests result */
+	fsl,tx-d-cal = <111>;
+	status = "okay";
+};
+
+&usbotg2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg2>;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	power-active-high;
+	disable-over-current;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index 69c4849f21321..6b416fb760d59 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -140,3 +140,13 @@ &usdhc3 {
 	compatible = "fsl,imx8dxl-usdhc", "fsl,imx8qxp-usdhc";
 	interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&usbotg1 {
+	interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+	/*
+	 * usbotg1 and usbotg2 share one clock
+	 * scfw disable clock access and keep it always on
+	 * in case other core (M4) use one of these.
+	 */
+	clocks = <&clk_dummy>;
+};
-- 
2.35.1

