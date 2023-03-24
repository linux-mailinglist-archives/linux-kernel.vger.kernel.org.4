Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65966C78F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjCXHh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjCXHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:37:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366E715549;
        Fri, 24 Mar 2023 00:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASWPkXpmypuAoStubz8BPTiylsMF7gw4/MKPss9yo5rMNT5EbqIadekQyCj6XZe2ZcGMwbZPSYNfTFubGhA0snGZsYnWDJJxkgdZj64nSCSZW2Ll2xaEPf9oRey7hZsaZKggrez9XFREzUInxYaZVnPS38T4ukHXblAnVQSQG/xM+QSYRM+cYQLv9OheO/5X8I7sK9S8XrQn4VHjH4HeS9inybxQxT7Wpty5Y7Y/B/drZxMQ6phZZ/WXxshJMsURPmkY6fhrkokBqT1QrlGRCf9ABBYYhVwBo8UxiKefggXO4Sukn4c81BmCQIWSRzKi0dH0NPkfxtL58/82BIryHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ibzeUoTZwDVcpPOUy7MU1pDmuURUtr7teR0/5OxpVE=;
 b=ZVFwNlEqQ5g04eTbsNtgBY0/RryJq+9Yz8kjOHUX45wcXEgnlvtxbgpalp1TTrgSzHR2jByiO8Yq2ZByBaAZ9Vqnf2RQxdH7K+04aBEZ5GjKqREgtsZydu8kOSUMFbsLBHEW8ARZdBG1/t2qMjIHSMfGFBiis278psAf3S8SVHuavlnliZvCCNL5/RgLviE2KI98AUvtNeBCgNLA2c+BkczROpmj2cHFepMLBMNDK8cJEinEyiYMuWE+g+CiM6PoVGDFZjaL5gwZ/+R9YnZJqnH4kp0sk05GcmGDFZryOpznADTc4OptTNjIDZNye6w0YmL44U9IKoVWOlt5dHv63Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ibzeUoTZwDVcpPOUy7MU1pDmuURUtr7teR0/5OxpVE=;
 b=0VahCP/2Gre0tNFa3uvEbyY1pCqySJLmFW9+rPyF++sz2l6qx8FESecQMw5PV6nRb63oqxWJFAJlAnsJGaFkOkEp13YYag1Hkb+7+TYj0bo+51sr/svsyhvTbDUVErEe/090YnY7XSyVyFhn/iO3H/xk7qBZ8GE3e3OcALv4qKY=
Received: from DM6PR01CA0002.prod.exchangelabs.com (2603:10b6:5:296::7) by
 PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Fri, 24 Mar 2023 07:37:14 +0000
Received: from CY4PEPF0000C978.namprd02.prod.outlook.com
 (2603:10b6:5:296:cafe::93) by DM6PR01CA0002.outlook.office365.com
 (2603:10b6:5:296::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 07:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C978.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 24 Mar 2023 07:37:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 02:37:07 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 24 Mar 2023 02:37:03 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <saikrishna12468@gmail.com>, Swati Agarwal <swati.agarwal@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 2/2] mmc: sdhci-of-arasan: Add support for eMMC5.1 on Xilinx Versal Net platform
Date:   Fri, 24 Mar 2023 13:06:30 +0530
Message-ID: <20230324073630.3194724-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324073630.3194724-1-sai.krishna.potthuri@amd.com>
References: <20230324073630.3194724-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C978:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 0064c629-f860-4722-f431-08db2c3a962a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOCGitgPe2aMula2jBuInc78uJmPly+odfkFJAXx1n4Mh6yaj8N8y/LRDUlf1cYr7xMaoLaW6mPUukBmO47k3h2etd+0WPaFU5Bnwz6smPb4hMbRm1QvULEywv43pJnH8D+AW+B2rVCrGUFCOF+fCOIx6gkcDj/iRALtzm8lRdxizMSqpFe3vHEvRkRw7XcJS7QXo7D+y+lxEv/vhMOY+5YB8QZ0D+qkoEGh1VW1jqBCbwEW7/lpIsOYYCwTPm7/cU84FN1strH0NU9ZA57KnB/5kT3njoMZIaw7aIEBTss8qapWF0oaApoRXQULrwYxXH267c+jxAZYThv82r5Iio0dYmPxxblnKWpi1+HoP6O103Xi1eqX5xHQaHwwsW82HV84slyWp2/YN8rRMlouex8AMgK5pQzYGMo/MTCP4E4F4A2Mill4AfoF8C4NNfMWgGANwC3SHiAuZXNiV1zSVbCNqWZT8+6QaqM/eIaNmBw0aaWRjtEc33ujZhHsriW+PI8WL+pMbBxifKlsx62NbuTfL1dzk2e3QaGtg2/4lYW4IE1ntHy8jYAv0OqbhVSQIdCTeW/RygKvys/0eTtISNS+HB4FhxmrmGChc/sKzpvh6uydnX5VBGVh5sJfe5l6qqa08AiSCmZt4qlGa0mD/dtMbocclz/pMnjLVL9mkYpNNtf/KSFC6fz2J2cFmO5Z7Z0q5OwacX3TCYYs4Td87g6LB1i6K+53qXR7HTfjykE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199018)(36840700001)(40470700004)(46966006)(103116003)(86362001)(36756003)(356005)(36860700001)(81166007)(82740400003)(30864003)(40460700003)(7416002)(5660300002)(4326008)(8676002)(2906002)(41300700001)(40480700001)(82310400005)(8936002)(1076003)(2616005)(336012)(186003)(83380400001)(54906003)(426003)(47076005)(110136005)(478600001)(70586007)(6666004)(26005)(316002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 07:37:14.1086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0064c629-f860-4722-f431-08db2c3a962a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C978.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swati Agarwal <swati.agarwal@amd.com>

Add support for eMMC5.1 on Xilinx Versal Net platform
- Add new compatible string(xlnx,versal-net-5.1-emmc).
- Add support for PHY which is part of Host Controller register space.
- Add DLL and Delay Chain mode support and corresponding tap delays for
all eMMC modes.
- Add Strobe select tap for HS400 mode.

Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>
Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 237 ++++++++++++++++++++++++++++-
 1 file changed, 236 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index deb67daf179f..2d53bd7af44b 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -41,11 +41,41 @@
 #define VENDOR_ENHANCED_STROBE		BIT(0)
 
 #define PHY_CLK_TOO_SLOW_HZ		400000
+#define MIN_PHY_CLK_HZ			50000000
 
 #define SDHCI_ITAPDLY_CHGWIN		0x200
 #define SDHCI_ITAPDLY_ENABLE		0x100
 #define SDHCI_OTAPDLY_ENABLE		0x40
 
+#define PHY_CTRL_REG1			0x270
+#define PHY_CTRL_ITAPDLY_ENA_MASK	BIT(0)
+#define PHY_CTRL_ITAPDLY_SEL_MASK	GENMASK(5, 1)
+#define PHY_CTRL_ITAPDLY_SEL_SHIFT	1
+#define PHY_CTRL_ITAP_CHG_WIN_MASK	BIT(6)
+#define PHY_CTRL_OTAPDLY_ENA_MASK	BIT(8)
+#define PHY_CTRL_OTAPDLY_SEL_MASK	GENMASK(15, 12)
+#define PHY_CTRL_OTAPDLY_SEL_SHIFT	12
+#define PHY_CTRL_STRB_SEL_MASK		GENMASK(23, 16)
+#define PHY_CTRL_STRB_SEL_SHIFT		16
+#define PHY_CTRL_TEST_CTRL_MASK		GENMASK(31, 24)
+
+#define PHY_CTRL_REG2			0x274
+#define PHY_CTRL_EN_DLL_MASK		BIT(0)
+#define PHY_CTRL_DLL_RDY_MASK		BIT(1)
+#define PHY_CTRL_FREQ_SEL_MASK		GENMASK(6, 4)
+#define PHY_CTRL_FREQ_SEL_SHIFT		4
+#define PHY_CTRL_SEL_DLY_TX_MASK	BIT(16)
+#define PHY_CTRL_SEL_DLY_RX_MASK	BIT(17)
+#define FREQSEL_200M_170M		0x0
+#define FREQSEL_170M_140M	        0x1
+#define FREQSEL_140M_110M	        0x2
+#define FREQSEL_110M_80M	        0x3
+#define FREQSEL_80M_50M			0x4
+#define FREQSEL_275M_250M		0x5
+#define FREQSEL_250M_225M		0x6
+#define FREQSEL_225M_200M		0x7
+#define PHY_DLL_TIMEOUT_MS		100
+
 /* Default settings for ZynqMP Clock Phases */
 #define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
 #define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 0}
@@ -53,6 +83,11 @@
 #define VERSAL_ICLK_PHASE {0, 132, 132, 0, 132, 0, 0, 162, 90, 0, 0}
 #define VERSAL_OCLK_PHASE {0,  60, 48, 0, 48, 72, 90, 36, 60, 90, 0}
 
+#define VERSAL_NET_EMMC_ICLK_PHASE {0, 0, 0, 0, 0, 0, 0, 0, 39, 0, 0}
+#define VERSAL_NET_EMMC_OCLK_PHASE {0, 113, 0, 0, 0, 0, 0, 0, 113, 79, 45}
+
+#define VERSAL_NET_PHY_CTRL_STRB90_STRB180_VAL		0X77
+
 /*
  * On some SoCs the syscon area has a feature where the upper 16-bits of
  * each 32-bit register act as a write mask for the lower 16-bits.  This allows
@@ -135,6 +170,7 @@ struct sdhci_arasan_clk_data {
  * @clk_ahb:		Pointer to the AHB clock
  * @phy:		Pointer to the generic phy
  * @is_phy_on:		True if the PHY is on; false if not.
+ * @internal_phy_reg:	True if the PHY is within the Host controller.
  * @has_cqe:		True if controller has command queuing engine.
  * @clk_data:		Struct for the Arasan Controller Clock Data.
  * @clk_ops:		Struct for the Arasan Controller Clock Operations.
@@ -147,6 +183,7 @@ struct sdhci_arasan_data {
 	struct clk	*clk_ahb;
 	struct phy	*phy;
 	bool		is_phy_on;
+	bool		internal_phy_reg;
 
 	bool		has_cqe;
 	struct sdhci_arasan_clk_data clk_data;
@@ -207,6 +244,61 @@ static const struct sdhci_arasan_soc_ctl_map intel_keembay_soc_ctl_map = {
 	.hiword_update = false,
 };
 
+static void sdhci_arasan_phy_set_delaychain(struct sdhci_host *host, bool enable)
+{
+	u32 reg;
+
+	reg = readl(host->ioaddr + PHY_CTRL_REG2);
+	if (enable)
+		reg |= (PHY_CTRL_SEL_DLY_TX_MASK | PHY_CTRL_SEL_DLY_RX_MASK);
+	else
+		reg &= ~(PHY_CTRL_SEL_DLY_TX_MASK | PHY_CTRL_SEL_DLY_RX_MASK);
+
+	writel(reg, host->ioaddr + PHY_CTRL_REG2);
+}
+
+static int sdhci_arasan_phy_set_dll(struct sdhci_host *host, bool enable)
+{
+	u32 reg;
+
+	reg = readl(host->ioaddr + PHY_CTRL_REG2);
+	if (enable)
+		reg |= PHY_CTRL_EN_DLL_MASK;
+	else
+		reg &= ~PHY_CTRL_EN_DLL_MASK;
+
+	writel(reg, host->ioaddr + PHY_CTRL_REG2);
+
+	if (!enable)
+		return 0;
+
+	return readl_relaxed_poll_timeout(host->ioaddr + PHY_CTRL_REG2, reg,
+					  (reg & PHY_CTRL_DLL_RDY_MASK), 10,
+					  1000 * PHY_DLL_TIMEOUT_MS);
+}
+
+static void sdhci_arasan_phy_dll_set_freq(struct sdhci_host *host, int clock)
+{
+	u32 reg, freq_sel, freq;
+
+	freq = DIV_ROUND_CLOSEST(clock, 1000000);
+	if (freq <= 200 && freq > 170)
+		freq_sel = FREQSEL_200M_170M;
+	else if (freq <= 170 && freq > 140)
+		freq_sel = FREQSEL_170M_140M;
+	else if (freq <= 140 && freq > 110)
+		freq_sel = FREQSEL_140M_110M;
+	else if (freq <= 110 && freq > 80)
+		freq_sel = FREQSEL_110M_80M;
+	else
+		freq_sel = FREQSEL_80M_50M;
+
+	reg = readl(host->ioaddr + PHY_CTRL_REG2);
+	reg &= ~PHY_CTRL_FREQ_SEL_MASK;
+	reg |= (freq_sel << PHY_CTRL_FREQ_SEL_SHIFT);
+	writel(reg, host->ioaddr + PHY_CTRL_REG2);
+}
+
 /**
  * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
  *
@@ -321,11 +413,24 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	/* Set the Input and Output Clock Phase Delays */
-	if (clk_data->set_clk_delays)
+	if (clk_data->set_clk_delays && clock > PHY_CLK_TOO_SLOW_HZ)
 		clk_data->set_clk_delays(host);
 
+	if (sdhci_arasan->internal_phy_reg && clock >= MIN_PHY_CLK_HZ) {
+		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+		sdhci_arasan_phy_set_dll(host, 0);
+		sdhci_arasan_phy_set_delaychain(host, 0);
+		sdhci_arasan_phy_dll_set_freq(host, clock);
+	} else if (sdhci_arasan->internal_phy_reg) {
+		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+		sdhci_arasan_phy_set_delaychain(host, 1);
+	}
+
 	sdhci_set_clock(host, clock);
 
+	if (sdhci_arasan->internal_phy_reg && clock >= MIN_PHY_CLK_HZ)
+		sdhci_arasan_phy_set_dll(host, 1);
+
 	if (sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE)
 		/*
 		 * Some controllers immediately report SDHCI_CLOCK_INT_STABLE
@@ -897,6 +1002,101 @@ static const struct clk_ops versal_sampleclk_ops = {
 	.set_phase = sdhci_versal_sampleclk_set_phase,
 };
 
+static int sdhci_versal_net_emmc_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct sdhci_arasan_clk_data *clk_data =
+		container_of(hw, struct sdhci_arasan_clk_data, sdcardclk_hw);
+	struct sdhci_arasan_data *sdhci_arasan =
+		container_of(clk_data, struct sdhci_arasan_data, clk_data);
+	struct sdhci_host *host = sdhci_arasan->host;
+	u8 tap_delay, tap_max = 0;
+
+	switch (host->timing) {
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_MMC_DDR52:
+		tap_max = 16;
+		break;
+	case MMC_TIMING_MMC_HS200:
+	case MMC_TIMING_MMC_HS400:
+		 /* For 200MHz clock, 32 Taps are available */
+		tap_max = 32;
+		break;
+	default:
+		break;
+	}
+
+	tap_delay = (degrees * tap_max) / 360;
+
+	/* Set the Clock Phase */
+	if (tap_delay) {
+		u32 regval;
+
+		regval = sdhci_readl(host, PHY_CTRL_REG1);
+		regval |= PHY_CTRL_OTAPDLY_ENA_MASK;
+		sdhci_writel(host, regval, PHY_CTRL_REG1);
+		regval &= ~PHY_CTRL_OTAPDLY_SEL_MASK;
+		regval |= tap_delay << PHY_CTRL_OTAPDLY_SEL_SHIFT;
+		sdhci_writel(host, regval, PHY_CTRL_REG1);
+	}
+
+	return 0;
+}
+
+static const struct clk_ops versal_net_sdcardclk_ops = {
+	.recalc_rate = sdhci_arasan_sdcardclk_recalc_rate,
+	.set_phase = sdhci_versal_net_emmc_sdcardclk_set_phase,
+};
+
+static int sdhci_versal_net_emmc_sampleclk_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct sdhci_arasan_clk_data *clk_data =
+		container_of(hw, struct sdhci_arasan_clk_data, sampleclk_hw);
+	struct sdhci_arasan_data *sdhci_arasan =
+		container_of(clk_data, struct sdhci_arasan_data, clk_data);
+	struct sdhci_host *host = sdhci_arasan->host;
+	u8 tap_delay, tap_max = 0;
+	u32 regval;
+
+	switch (host->timing) {
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_MMC_DDR52:
+		tap_max = 32;
+		break;
+	case MMC_TIMING_MMC_HS400:
+		/* Strobe select tap point for strb90 and strb180 */
+		regval = sdhci_readl(host, PHY_CTRL_REG1);
+		regval &= ~PHY_CTRL_STRB_SEL_MASK;
+		regval |= VERSAL_NET_PHY_CTRL_STRB90_STRB180_VAL << PHY_CTRL_STRB_SEL_SHIFT;
+		sdhci_writel(host, regval, PHY_CTRL_REG1);
+		break;
+	default:
+		break;
+	}
+
+	tap_delay = (degrees * tap_max) / 360;
+
+	/* Set the Clock Phase */
+	if (tap_delay) {
+		regval = sdhci_readl(host, PHY_CTRL_REG1);
+		regval |= PHY_CTRL_ITAP_CHG_WIN_MASK;
+		sdhci_writel(host, regval, PHY_CTRL_REG1);
+		regval |= PHY_CTRL_ITAPDLY_ENA_MASK;
+		sdhci_writel(host, regval, PHY_CTRL_REG1);
+		regval &= ~PHY_CTRL_ITAPDLY_SEL_MASK;
+		regval |= tap_delay << PHY_CTRL_ITAPDLY_SEL_SHIFT;
+		sdhci_writel(host, regval, PHY_CTRL_REG1);
+		regval &= ~PHY_CTRL_ITAP_CHG_WIN_MASK;
+		sdhci_writel(host, regval, PHY_CTRL_REG1);
+	}
+
+	return 0;
+}
+
+static const struct clk_ops versal_net_sampleclk_ops = {
+	.recalc_rate = sdhci_arasan_sampleclk_recalc_rate,
+	.set_phase = sdhci_versal_net_emmc_sampleclk_set_phase,
+};
+
 static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u32 deviceid)
 {
 	u16 clk;
@@ -1107,7 +1307,17 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
 			clk_data->clk_phase_out[i] = versal_oclk_phase[i];
 		}
 	}
+	if (of_device_is_compatible(dev->of_node, "xlnx,versal-net-5.1-emmc")) {
+		u32 versal_net_iclk_phase[MMC_TIMING_MMC_HS400 + 1] =
+			VERSAL_NET_EMMC_ICLK_PHASE;
+		u32 versal_net_oclk_phase[MMC_TIMING_MMC_HS400 + 1] =
+			VERSAL_NET_EMMC_OCLK_PHASE;
 
+		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
+			clk_data->clk_phase_in[i] = versal_net_iclk_phase[i];
+			clk_data->clk_phase_out[i] = versal_net_oclk_phase[i];
+		}
+	}
 	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_LEGACY,
 				 "clk-phase-legacy");
 	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
@@ -1225,6 +1435,14 @@ static const struct sdhci_pltfm_data sdhci_arasan_zynqmp_pdata = {
 			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
+static const struct sdhci_pltfm_data sdhci_arasan_versal_net_pdata = {
+	.ops = &sdhci_arasan_ops,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+			SDHCI_QUIRK2_STOP_WITH_TC |
+			SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
+};
+
 static const struct sdhci_arasan_clk_ops zynqmp_clk_ops = {
 	.sdcardclk_ops = &zynqmp_sdcardclk_ops,
 	.sampleclk_ops = &zynqmp_sampleclk_ops,
@@ -1245,6 +1463,16 @@ static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
 	.clk_ops = &versal_clk_ops,
 };
 
+static const struct sdhci_arasan_clk_ops versal_net_clk_ops = {
+	.sdcardclk_ops = &versal_net_sdcardclk_ops,
+	.sampleclk_ops = &versal_net_sampleclk_ops,
+};
+
+static struct sdhci_arasan_of_data sdhci_arasan_versal_net_data = {
+	.pdata = &sdhci_arasan_versal_net_pdata,
+	.clk_ops = &versal_net_clk_ops,
+};
+
 static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
 	.soc_ctl_map = &intel_keembay_soc_ctl_map,
 	.pdata = &sdhci_keembay_emmc_pdata,
@@ -1314,6 +1542,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 		.compatible = "xlnx,versal-8.9a",
 		.data = &sdhci_arasan_versal_data,
 	},
+	{
+		.compatible = "xlnx,versal-net-5.1-emmc",
+		.data = &sdhci_arasan_versal_net_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
@@ -1788,6 +2020,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
 	}
 
+	if (of_device_is_compatible(np, "xlnx,versal-net-5.1-emmc"))
+		sdhci_arasan->internal_phy_reg = true;
+
 	ret = sdhci_arasan_add_host(sdhci_arasan);
 	if (ret)
 		goto err_add_host;
-- 
2.25.1

