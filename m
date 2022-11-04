Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA94F61A0DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKDTWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKDTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:22:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB54874E;
        Fri,  4 Nov 2022 12:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQo0ERtFUGkHUr+C07lNaTTA+aPR8gYv3IIic0V/Hmk+smwS8SXHjJGacGdBdL3eyLh1nhkl6CZ+irPfSxdxzg6mQBxzIllokLdiMXmxWAy7caE9NWz0ie5hrwnBFoPbp2QCSmU+fUOIhUJBSUocO5iFReTd8RVdiSgXphP7Ax1La6aEJYNroIC8rVEbEMGJyaAuGte9fs+nw+YWlMfD01rYLX1on+NwKgu/Eh3sy02q6wzSXkQGYZTJ3pz3JLKiJIRmES+IumZgMIra3UZTdNehtLsY/uRFV35NDJ6QwU1lQ3ukfZglgVkdxzWaaCUC0q41NkFN56piUtq0/MaUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI8T5xRaMAHdP6raDpe9ht3wbW1wEmqh2K3whXBsdTI=;
 b=CB2dAd/CUPr3VJfyPmj2Y0vbgf1tAC5LZFkfwG7qfgS0CPN/Y+unfTxD6MirBV/mx7y1YAAcfCpIeiIUnReoJFeXk4UaZEPCchFzS5jHZ8DAqIPelRf9WECMHPg9x7FgOCCbPHQi8SBTFI6pqADo9d5f1kpxXXF109ZrhUBz9W6PL0lA58lMMhRtTsyHwJ6olIp0cvgdM1z3y7ch3splLf2HjZKB/ZqLexiewIWX9VsMwmTK8Pz2JB93fljMMoU+AePjGa57ZHMfTLlx7dj4NSER6h9itey9MmpdQ8tv4Y5fWaKxT/oMzBjbrfZBQF0GFLR92Gas9RJysuT/nHgZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI8T5xRaMAHdP6raDpe9ht3wbW1wEmqh2K3whXBsdTI=;
 b=fujCvpSXK7d3AWqnjvjGjaZwAKAxizdiBtX6rPCQNPZqXTSPIEQPuk96ZatAc3zblzJy3Q/jn/adnucIKFQNGppxxbet3ECSaVRBzQwwsnGUGCkUak/Hh19q54yN5A3+lgSeJdzjZShxlHLOadtYaiC9F0A8vwz5Svxnk05P/yA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Fri, 4 Nov
 2022 19:22:35 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%11]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 19:22:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     han.xu@nxp.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 2/3] arm64: dts: imx8dxl: add flexspi support
Date:   Fri,  4 Nov 2022 15:21:26 -0400
Message-Id: <20221104192135.1661541-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104192135.1661541-1-Frank.Li@nxp.com>
References: <20221104192135.1661541-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) To
 HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e206c9-ea14-4af7-6318-08dabe99edd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqJnyR+BRnQebziUQaNCV/sfQ6gA/Nm2e+0hw8pt9ASrU+ESAy+2nhzgLG54fCmPOoJXV32OWPVdNyoDTbnvkpXuKcXdu9sdbR5fxEdXZq5LBgcQMKtsOGWoOK2U1j6wyw5hvX2Op/ySYvpoJpggwAE7vtZqkNlmKnkOEscVHDYuDsmoQooislpDr7bsSPOVDBdlv1KZjoLxPYIaWPWLlSiGL/Xp/dUrVqtsc4h63txtxMGhPo4Ymytey70a16I8l94rq1BZQ95vcxn6aAI1PBctfTGJ1PVbb+hXw7w85efi+/6Lo3OqA3jiOXEe2K7Pllx7/smjxDNA1DWReMH8METeARYjGUmdp0CClyU//a/YQ/rbaZ1L1hiyscahzj6wGj4fvsxyHGPrquwKZ/668DiIPaGM3RHBSy0qZeIy9UxSeMhDAL0IqQmZaL5Pgjndi18dvvErrHvv1wzlLIKL279eeq9mwc+khEE5MivvHuOO6s628Ci22w4umUntUOFWvExXxK5197lvuad/HCqRK7x6M+pPmze44/Pll6NhFdxD5ounFyxPc3i8LZdLF1JWNDy60SMfM49BAVa3hlseJ+Gu2KxlS6zrT9l9gSqX03b7Voi2t3xUPu7NjHMsF+e1+7nxc1tX+qFnxM7k6fKX1vYHm0cqf4GNDmz4/eaRxOqO79uKjrXivIrTvfkzuSiyekC+E3/DNhnuCVAqPIcomdz+y/7bF5EB5pm4v35mDbXaoRs1H56Ki69TI5q7RcKNrkMH/AkLXSv3ldepXakKZHJmhHJ+uEs9wwBEZps3CsXUASmt35aOqbAuHzzTuqRGZt5s0vXOrhK6cJl1JLt/esc9Ny/8TNaYms4eB9ZqtIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(36756003)(110136005)(478600001)(2906002)(83380400001)(7416002)(5660300002)(86362001)(921005)(38350700002)(6512007)(8676002)(38100700002)(316002)(2616005)(186003)(6486002)(1076003)(26005)(66556008)(66476007)(41300700001)(66946007)(8936002)(6666004)(4326008)(6506007)(52116002)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aTLpTK0oRaCblyVsufuEFjyFznjCnglynwxAma67AYY5/4Rz3WTQD7sz3MBj?=
 =?us-ascii?Q?0kmo6EfrennKjS4FI7T3LXKceJDR35BPNLhnprPZwxrx6uwxknDP3oZcBsiE?=
 =?us-ascii?Q?czTZ0PnlzIs0CqndPu0CwKOKbbLS4Ya/2ABR/ZW46Uw9tj9f/l0H5pN31dy3?=
 =?us-ascii?Q?1mUc6VHB6DjAtr5ETB3/njCswdR2dlrl9W0Z48b/iVTFOzddnWmAgTzHy6Fv?=
 =?us-ascii?Q?aSHdvq7r6ARPm47UVtEk6VZJmZTDOJQWZZYmWz6pV5lPb1YA+5K9Nf4dWAuU?=
 =?us-ascii?Q?0G1amNUPE7x/eUqpyy8w1sQ7lR2S3TFT84qhDG387XnDrhOS9Jxui1K77AYI?=
 =?us-ascii?Q?wbzFn22dY8oSTEAfgW6Na8DnsIN2Snx+5bg9sUy60lrG/fHawh4HXAvNaUEs?=
 =?us-ascii?Q?q3IWHU6GCQT7DsSwdptch6TamdqKyuAqTA7UZgpAMGbs1ftn4KqPBBivSQjW?=
 =?us-ascii?Q?7w9i6YAE58G7LQYy4/+5AoVQ4X/ijkoQbLAcjdARuEGN8Nh1mf10KWr9hN7S?=
 =?us-ascii?Q?gK5SzI66ebOEurRBwGPdmauYOzWCy8CLkeeLoCOsysgkEkE3zpnLgBO1GraM?=
 =?us-ascii?Q?MCH6VVNlbzeaJCVnt935bsWYpoWyhJuIc9Pf943/LdoCdyXYjowyoYUR4JCa?=
 =?us-ascii?Q?tsWEIR0N/QcK2HJ2l/B9+d0ZgifVCnqw1tZSERuVvcoyqWzbp5bRN1UPSd5B?=
 =?us-ascii?Q?N+LgcbuMqyOcO2G/oXraOc51+Oy0/onHLzn7fw3i1IgIkIF9mSuSwQ5sCpKp?=
 =?us-ascii?Q?72rqXSUTNtsxzkUKmjfogma2gk2Pwzzh5QpTpzmPsomJXWfBilqwGVoS7PQr?=
 =?us-ascii?Q?5VC/y0ZOrOhsewNUDQe08hypu1fKYSqS1Awc3NLx7y8EP+Tvn/fvavGEsUGW?=
 =?us-ascii?Q?leb8UK9A96SbE+sK317Oh7SRVX/hBiUGwXogqy/QhEQ8bIomBatr4csVHny9?=
 =?us-ascii?Q?owt/UfBwzaAUwqxaIMTtm7M/4yiPj2t1dFsIqnF1kcXYsThkW97/udu1nMza?=
 =?us-ascii?Q?YbKPOANAz7nmIQlNx3rBcyMntib8blOfhIZh5Le0JOaVESqn4wjcYJa6qlli?=
 =?us-ascii?Q?GXPapr77lgLPaLQfX8TAT8WfNwzbEBvwq0LKBcOXxFJVX+apgyM3+pG82Y0A?=
 =?us-ascii?Q?kNTJPuGi8Az7Xi2lFIl28rT+Pomf5dLIIUCFDaQenXxoRRf4xlksDjQ0rOg4?=
 =?us-ascii?Q?fOuAHOkR/r5e9usSIfOOd9NZutkJh5zSVLgGwTzBouL8atVykdToNqJEARAz?=
 =?us-ascii?Q?FX/yLb8Wd4BmLO3ibHTjsUCCbrtq2RdiIrrGuguoAM7kQvRNG5TajuC2AF36?=
 =?us-ascii?Q?CCVMQaAhUL+sB6MLTQ4xgEaQGi93EmWMYGu3kRG1PoN8hGdmRUUuNh2Q6Jer?=
 =?us-ascii?Q?GUEcNZO3OM1pBa256Vw7W+QTCHqHW0R+ycE3vHPC2OrWp3uhGflTaKInmDAW?=
 =?us-ascii?Q?tYZOlz8VfAhwtE7Gu/Q9wFwHN5pGcDXMMhbVBrgEIotrqFD5/DOxe7K1A36Q?=
 =?us-ascii?Q?tLCoTL1fc+qrsy2mSzdhvCE4yRTyRIk454wLt0I/GOqRh+RSyfYxJD1xZm8K?=
 =?us-ascii?Q?DWzM1sksuLw9dya69dflwGx0BoNL+lXS/lP0ASth?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e206c9-ea14-4af7-6318-08dabe99edd0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 19:22:35.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pKam3RdKkzmkbf+UddbTMtU59RGyLCwPj8YtxJNxSaTKdaEHgRkVzJw47XRI+a22Cf/8qkKgJ8PJuEfyM00bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flexspi0 node at common lsio subsystem.
Enable flexspi0 at imx8dxl_evk boards dts.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      | 17 ++++++++-
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 36 +++++++++++++++++++
 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   |  5 +++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index 6446e6df7a9a..1f3d225e64ec 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -11,7 +11,8 @@ lsio_subsys: bus@5d000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
+	ranges = <0x5d000000 0x0 0x5d000000 0x1000000>,
+		 <0x08000000 0x0 0x08000000 0x10000000>;
 
 	lsio_mem_clk: clock-lsio-mem {
 		compatible = "fixed-clock";
@@ -107,6 +108,20 @@ lsio_gpio7: gpio@5d0f0000 {
 		power-domains = <&pd IMX_SC_R_GPIO_7>;
 	};
 
+	flexspi0: spi@5d120000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,imx8qxp-fspi";
+		reg = <0x5d120000 0x10000>, <0x08000000 0x10000000>;
+		reg-names = "fspi_base", "fspi_mmap";
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX_SC_R_FSPI_0 IMX_SC_PM_CLK_PER>,
+			 <&clk IMX_SC_R_FSPI_0 IMX_SC_PM_CLK_PER>;
+		clock-names = "fspi", "fspi_en";
+		power-domains = <&pd IMX_SC_R_FSPI_0>;
+		status = "disabled";
+	};
+
 	lsio_mu0: mailbox@5d1b0000 {
 		reg = <0x5d1b0000 0x10000>;
 		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 11b1ff90c06d..f8d416f7fd92 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -181,6 +181,23 @@ vddio1: vddio-regulator {
 	};
 };
 
+&flexspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	nxp,fspi-dll-slvdly = <4>;
+	status = "okay";
+
+	mt35xu512aba0: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &i2c2 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -386,6 +403,25 @@ IMX8DXL_ENET1_RGMII_TX_CTL_CONN_EQOS_RGMII_TX_CTL	0x06000020
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			IMX8DXL_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021
+			IMX8DXL_QSPI0A_DATA1_LSIO_QSPI0A_DATA1     0x06000021
+			IMX8DXL_QSPI0A_DATA2_LSIO_QSPI0A_DATA2     0x06000021
+			IMX8DXL_QSPI0A_DATA3_LSIO_QSPI0A_DATA3     0x06000021
+			IMX8DXL_QSPI0A_DQS_LSIO_QSPI0A_DQS         0x06000021
+			IMX8DXL_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B     0x06000021
+			IMX8DXL_QSPI0A_SCLK_LSIO_QSPI0A_SCLK       0x06000021
+			IMX8DXL_QSPI0B_SCLK_LSIO_QSPI0B_SCLK       0x06000021
+			IMX8DXL_QSPI0B_DATA0_LSIO_QSPI0B_DATA0     0x06000021
+			IMX8DXL_QSPI0B_DATA1_LSIO_QSPI0B_DATA1     0x06000021
+			IMX8DXL_QSPI0B_DATA2_LSIO_QSPI0B_DATA2     0x06000021
+			IMX8DXL_QSPI0B_DATA3_LSIO_QSPI0B_DATA3     0x06000021
+			IMX8DXL_QSPI0B_DQS_LSIO_QSPI0B_DQS         0x06000021
+			IMX8DXL_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B     0x06000021
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB0_PAD		0x000014a0
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
index 815bd987b09b..85e6131ec406 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
@@ -3,6 +3,11 @@
  * Copyright 2019~2020, 2022 NXP
  */
 
+&flexspi0 {
+	compatible = "nxp,imx8dxl-fspi";
+	interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &lsio_gpio0 {
 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
 	interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

