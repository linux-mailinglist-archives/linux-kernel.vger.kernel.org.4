Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7295C6CFBFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjC3Gxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjC3Gx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:53:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922C66582;
        Wed, 29 Mar 2023 23:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWazMZIX3RP9KMI6dnFC2IjHwwREmhImrAA7uOoGiJg2lAfwtL05MOOT+gHr9hBzOBGLipapyS15DJUTXmH0CiuBa7kkpOAq5h6OvsvrPwI3dXN/WTrb17FLm1foKMC4NRDUYxC/BsfWPmuVInPd9iJS/yawd7vi1NK3EQpxxeM+iCJ9cpFvYoEOW/JtyXOYNRrPPtkQdq8jgiJj6Ux89kH5lasrQzdD3dczH1gshM4PZE2iMUOsRWimVjkqpgTtsI0MRvx73rIdS9/XbonCwpTZjMB/1Jzvgpo6pdNlmp+QhpoTnuRAww2LdfYztBcBaUBD8SNifodVWj6QTYEo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixbSkJnrPXFaxe2s5KYMOtMYs+57S4a6uQEB3UcWw5I=;
 b=celO0DWQlNIF0/WJ2x4HVXHyvCoFOVtPgJ+H9DSl1gE3nHxlBEOXQxln5QUoMjS7eYd32um2w/ZES5WvdEQG9KxKq49b+milEyIYJP8Egx69OBLQE7zHgppPxBR7xhMSh++bsWD5OITrI0AxKPcDw0MsakjaGpj209C3LliogZCKWCVncjtnyM2LKTNJw5ixrB9uX/syz9LWNrOPsN3NVgo/aPN97wwFOfspFgv65um4RE5K7g0HuBfofuQ1ChZAbvfoPzxLBhdQsZjb6Vi+eJLyfAHeWzbPzY3/tw7jnoRTouFAbnsrX3q9nacaKRI58O0yDg16F3Nu8yFUgf2vRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixbSkJnrPXFaxe2s5KYMOtMYs+57S4a6uQEB3UcWw5I=;
 b=4kFpWlTfTrCbywWzRQFrFVuxO35FLSh4xQYd6bH2kiZp61TuKPypNVQEv/pE9sEt1unq6xPVFQX3dAt9Z+tX1YyjRMxXiGheuKH49+oZY8/fcwsGWv39keA3UG74AuMoOW8hf3gbMq+ig+wh0na+4dgSh1OrgX7n5oxKKTb8YTg=
Received: from BN9PR03CA0580.namprd03.prod.outlook.com (2603:10b6:408:10d::15)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 06:53:19 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::d6) by BN9PR03CA0580.outlook.office365.com
 (2603:10b6:408:10d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Thu, 30 Mar 2023 06:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 06:53:19 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 01:53:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 23:53:18 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 30 Mar 2023 01:53:15 -0500
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
Subject: [PATCH v2 2/2] mmc: sdhci-of-arasan: Add support for eMMC5.1 on Xilinx Versal Net platform
Date:   Thu, 30 Mar 2023 12:22:40 +0530
Message-ID: <20230330065240.3532010-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330065240.3532010-1-sai.krishna.potthuri@amd.com>
References: <20230330065240.3532010-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 02dcf5eb-e7ef-4124-ef04-08db30eb7238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLfHKxBe4CEkTd7b7/DPyviq5mgouq/+UqYzvzMzNrBTJAT4KkrYzZXea1JduXWSWnDTIYFtE/JKNGl+6U72IZ+ajHLPo8tfpmWI8TWn/Xs0q2fe9hXVME4YIi+33R0bu3Q32s2449cmMnePt9hAF3rAtrx04NqwQ0YUN1ou5yisKiTl2IkE6N2eZN4WNa/3m+OurnfpPw9cbycrcOQjjAbxZrLGK7gKglIjqnT7bf+zO756+nN+VnNctCzrw9cIS2hLvacmyohjStmvoj0ivQa1evSgdjMIOkKR/HbRi4YttKqTVefeAFe482hTJv48rNCbgQT/AOplCTDhW3VyKuCT1iIoNZuUmLcBfOit2vin3AkRXCp1MmfIZp22E5gbpHcP4zChInGwdtp0vkBN/oc50b4m3BellKSVBsNo9z4wMaZRsNxoKagxNjBKgnXRx7DZTIK6o6ZRrzD/FPpYnilBRsnHDD8s3gOISNv4hbpcM7LZVUHekz1sOIF5VZdkiYl0QXcxoPYcJE75cZs7TAYSPJuMMinQactyZgJ3DY81F4K+ZO2jMnHrdhRONqOp0vn0qHL+ASsX4LoILZ/eAELV4eKiOHIyfopNog4306FDyCHCERiJs22p3KSa30VzjzCArmw8Ei/A8HC7Pn+bQ/1PTAVoRxNdyVzGL1Ml67CjglJmhMlES52Tjv+dn8idWLgfJ4p7tVSZDaNvaTSlq/uHVulS5VkwRa432LyV5tE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(8676002)(70586007)(4326008)(186003)(40460700003)(70206006)(336012)(426003)(2906002)(36756003)(82310400005)(83380400001)(47076005)(30864003)(86362001)(5660300002)(356005)(36860700001)(103116003)(81166007)(7416002)(82740400003)(8936002)(6666004)(478600001)(54906003)(26005)(2616005)(40480700001)(316002)(1076003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 06:53:19.4369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dcf5eb-e7ef-4124-ef04-08db30eb7238
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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
- Add new compatible string(xlnx,versal-net-emmc).
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
index deb67daf179f..d9a29c346745 100644
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
+	if (of_device_is_compatible(dev->of_node, "xlnx,versal-net-emmc")) {
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
+		.compatible = "xlnx,versal-net-emmc",
+		.data = &sdhci_arasan_versal_net_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
@@ -1788,6 +2020,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
 	}
 
+	if (of_device_is_compatible(np, "xlnx,versal-net-emmc"))
+		sdhci_arasan->internal_phy_reg = true;
+
 	ret = sdhci_arasan_add_host(sdhci_arasan);
 	if (ret)
 		goto err_add_host;
-- 
2.25.1

