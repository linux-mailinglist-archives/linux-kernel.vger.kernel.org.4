Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDD868CF53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBGGKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBGGKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:10:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4605530E9D;
        Mon,  6 Feb 2023 22:09:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxnXYO6NiCPQGgmeBY8KKTUilRsKEoh3h5Lvr5z32zppWj2eBcelMKSI15zkvh5ADyuOZseIfaT/CUn4UIGlJEsPUrQCQqFqP9i52Dqin3tGk9KIW0fYdReuLmviaO99ZkLlXcyypRc0CbETNbtjicYY6SOQyWLuRQYPME9mb4kZM1JNaH8E/mCYC5ZEGXHFr1QZZa+wR4rlRlKAOWvFu/yKqqsyG+RF7NJXKDYL5Tv9sEBnQmcqaUin+LkCJW1v//8JdBcqWm0SRmdv1sucIgZxpggVvmKOm2YbmP+G9CvONg+jIP7gOdFDiTW0EeypMZWr52O/xudzrbzwj34Bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGiQ1T+cc3d0ZhOnWiM1lRPCy2eKoeVpTZBC5m6QBLI=;
 b=iFrqXZAHXvbl+MCgoE5jCeMa693KQNXBnDVzVtOUr0t/zBEqkYV85gIs0hK1xWhl95cF+8z+80/QpSh39gWNg+Birnoocnren1np4MMejOA8u4bc0MXvEPQHzcUVQSRBnXuRp7jYFGAZ3nr6JSnxNTLne7GERvgYTxuNYVuuH4cQzDjnlsvbsTTrduTwZVydHd10zBy8BHePc35mANcmIQYljkraaDOof8QhgI94wwUblsFcpWft9SzYwrcWr7OXIKfeQSKFnAhI3stOXJVNx+Vn0oxbtBqXhvVpj+YJgIe0xe3oJyj2C3ywhaf/aJozgqQtTOXvnFAeRRIrUQOUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGiQ1T+cc3d0ZhOnWiM1lRPCy2eKoeVpTZBC5m6QBLI=;
 b=EQBahLWY+ZwAY8k96ck1Db8rw8CORcLXUBNq+sTmQq/aBnCAIZCD0wWOE+XUgsqdhbrQlVZ9h7yhSNB+psWkp2WucLt/BfiPSJzfaUYx+KroyGtjYPgdDrs91CjZ5vx6WeHhDd1yJeAi5BVHwjBQYcpIfYps42IaklVTOb9GZqA=
Received: from DS7PR03CA0057.namprd03.prod.outlook.com (2603:10b6:5:3b5::32)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 06:09:50 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::6c) by DS7PR03CA0057.outlook.office365.com
 (2603:10b6:5:3b5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Tue, 7 Feb 2023 06:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.35 via Frontend Transport; Tue, 7 Feb 2023 06:09:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 00:09:49 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 00:09:48 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 7 Feb 2023 00:09:45 -0600
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Michael Walle" <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 3/3] spi: cadence-quadspi: Add Rx tuning support for Xilinx Versal OSPI
Date:   Tue, 7 Feb 2023 11:39:24 +0530
Message-ID: <20230207060924.265789-4-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207060924.265789-1-sai.krishna.potthuri@amd.com>
References: <20230207060924.265789-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|PH8PR12MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: edf78648-911f-49dd-9db0-08db08d1ebb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1CHsZcdVRkjr9eWNmqFqx7s8VXJRZLxDTi0yFcw8CCa348s0/oRWk50EiNUa2OtZbbuUzCgimfdGSF65Kh0Q910+tUTkeM9LolBC2si1pI2UrxxLw3YjJ+jYEyESo26vRtj6IyuY1eH64DUyEl2/vmOPH0PwttH1KzKkELaNaPMBVz2L/jCJtpnlvljKI/6gWFjIzjMt1NA+ywvoaQ3SLKmW22byjXUaq9x2TRWLEF31V7HsmJ6AZgOiDHybWMdcjkfMV1UqbS4t2NlDWjcWFrlFPIJWescHWOXUe+w1k1BSwiJmVRocrnVoKAKGYlnIz53U0k+zQEJTRTTHOras2M6a4fUeALCwArcl5cNibs86Bm+0uQpOw6nfZd+RspDq73Bpa608nJkA863xCNIvrh768PJ52p1wEMK7ecRvzdsrHOY/GvcpStws+paTsgDngH6K1egKUUpE1p4hcH8m7MG1/VWnIj5hYo8c1P5sVluKYeIFoe1FeOu0al8IlgN0PtaW8uQ766sq/lrFmlFhW82gvKCeDPyFIwPC/lSxA6MPHqlqx8ko66BoFAjgHobi6be8rBQ5YpABaBZu7hhlzisuwLsyAgaO5+hzrG8GpRHuoBwt6RXPUx6P39KGCLpeTmb3CyWxmUDuNLmos7qQ7pkvLUbzwx2Sm9nQbViQtLObvjRJnxkae964xBr2aN85A+HH+K8M7FICDnCxkEdiROkzhQRd9lZm8PzdCe/1UU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(30864003)(5660300002)(41300700001)(7416002)(8936002)(82740400003)(8676002)(4326008)(2616005)(70206006)(70586007)(356005)(54906003)(478600001)(316002)(336012)(1076003)(40460700003)(110136005)(36756003)(26005)(83380400001)(186003)(81166007)(103116003)(426003)(6666004)(86362001)(40480700001)(36860700001)(47076005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 06:09:49.7880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf78648-911f-49dd-9db0-08db08d1ebb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Rx tuning support for Xilinx Versal Octal SPI Controller(OSPI).
Xilinx Versal Octal SPI controller requires Rx tuning to find out the
optimal tap value when running at higher clock in DTR protocol. As there
is no common Tuning Data Pattern defined across all vendors, Xilinx Versal
Octal SPI uses READ_ID based tuning algorithm for which this device_id
field in spi_mem will be used as a Tuning data pattern.
After enabling the DTR protocol, spi-nor sends READ ID command to verify
the DTR protocol switching is successfully done or not. If execute_tuning
is defined(not NULL) and clk_tuned is not set then Rx tuning algorithm
will be executed before it actually read the ID in DTR protocol.
Xilinx Versal tuning algorithm (as suggested by IP design team):
- Sweep all possible 127 taps to read the flash id for each tap.
- To consider a particular tap as valid make sure to get the correct id
for 10 times.
- Once valid window is found(window size >= 3), stop parsing the
remaining taps.
- Perform the above steps with extra dummy clock 1.
- Identify the maximum window size between extra dummy clock 0 and 1 and
configure the median of min and max valid tap of the corresponding window.
- If the maximum window size is with dummy clock 1 then all the subsequent
read operations should be performed with one extra dummy clock.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/spi/spi-cadence-quadspi.c | 201 ++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b55b763003f0..bc4395736def 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -93,6 +93,8 @@ struct cqspi_st {
 	bool			slow_sram;
 	bool			use_phy;
 	bool			use_dqs;
+	bool			clk_tuned;
+	u8			extra_dummy_clks;
 };
 
 struct cqspi_driver_platdata {
@@ -101,6 +103,7 @@ struct cqspi_driver_platdata {
 	int (*indirect_read_dma)(struct cqspi_flash_pdata *f_pdata,
 				 u_char *rxbuf, loff_t from_addr, size_t n_rx);
 	u32 (*get_dma_status)(struct cqspi_st *cqspi);
+	int (*execute_tuning)(struct spi_mem *mem, const struct spi_mem_op *op);
 };
 
 /* Operation timeout value */
@@ -192,6 +195,7 @@ struct cqspi_driver_platdata {
 
 #define CQSPI_REG_IRQSTATUS			0x40
 #define CQSPI_REG_IRQMASK			0x44
+#define CQSPI_REG_VERSAL_ECO			0x48
 
 #define CQSPI_REG_INDIRECTRD			0x60
 #define CQSPI_REG_INDIRECTRD_START_MASK		BIT(0)
@@ -238,6 +242,19 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_POLLING_STATUS		0xB0
 #define CQSPI_REG_POLLING_STATUS_DUMMY_LSB	16
 
+#define CQSPI_REG_VERSAL_PHY_CONFIG		0xB4
+#define CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK	BIT(31)
+#define CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK	BIT(30)
+#define CQSPI_REG_PHY_CONFIG_TX_DLL_DLY_LSB	16
+
+#define CQSPI_REG_VERSAL_PHY_MASTER_CTRL	0xB8
+#define CQSPI_REG_DLL_LOWER			0xBC
+#define CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK	BIT(15)
+#define CQSPI_REG_DLL_LOWER_DLL_LOCK_MASK	BIT(0)
+
+#define CQSPI_REG_VERSAL_DLL_OBSVBLE_UPPER	0xC0
+#define CQSPI_REG_DLL_UPPER_RX_FLD_MASK		0x7F
+
 #define CQSPI_REG_OP_EXT_LOWER			0xE0
 #define CQSPI_REG_OP_EXT_READ_LSB		24
 #define CQSPI_REG_OP_EXT_WRITE_LSB		16
@@ -282,6 +299,12 @@ struct cqspi_driver_platdata {
 #define CQSPI_DMA_UNALIGN		0x3
 
 #define CQSPI_REG_VERSAL_DMA_VAL		0x602
+#define CQSPI_VERSAL_MAX_DLL_TAPS		127
+#define CQSPI_VERSAL_TX_TAP_MASTER		0x1E
+#define CQSPI_VERSAL_ECO_MIN_FREQ		120000000
+#define CQSPI_VERSAL_INIT_DLY			4
+#define CQSPI_VERSAL_RDID_MAX_CNT		10
+#define CQSPI_VERSAL_MIN_WINDOW_SZ		3
 
 static int cqspi_wait_for_bit(void __iomem *reg, const u32 mask, bool clr)
 {
@@ -540,6 +563,14 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
 
+	/*
+	 * Based on the tuning, some controllers requires extra dummy clocks due to additional
+	 * delays in read path. For such controllers add required extra dummy clocks for all
+	 * subsequent read operations.
+	 */
+	if (cqspi->extra_dummy_clks)
+		dummy_clk += cqspi->extra_dummy_clks;
+
 	if (dummy_clk)
 		reg |= (dummy_clk & CQSPI_REG_CMDCTRL_DUMMY_MASK)
 		     << CQSPI_REG_CMDCTRL_DUMMY_LSB;
@@ -662,6 +693,14 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
 
+	/*
+	 * Based on the tuning, some controllers requires extra dummy clocks due to additional
+	 * delays in read path. For such controllers add required extra dummy clocks for all
+	 * subsequent read operations.
+	 */
+	if (cqspi->extra_dummy_clks)
+		dummy_clk += cqspi->extra_dummy_clks;
+
 	if (dummy_clk)
 		reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
 		       << CQSPI_REG_RD_INSTR_DUMMY_LSB;
@@ -1056,6 +1095,157 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static int cqspi_versal_execute_tuning(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
+	u8 dummy_incr, dummy_flag = 0, count, max_index, min_index;
+	u8 min_rxtap, max_rxtap, avg_index, max_tap, windowsize;
+	struct platform_device *pdev = cqspi->pdev;
+	struct cqspi_flash_pdata *f_pdata;
+	bool id_matched, rxtapfound;
+	u32 val, i, reg, txtap = 0;
+	s8 max_windowsize = -1;
+	int ret;
+
+	f_pdata = &cqspi->f_pdata[mem->spi->chip_select];
+
+	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+	reg &= CQSPI_REG_CONFIG_ENABLE_MASK;
+	if (!reg)
+		return 0;
+
+	if (cqspi->master_ref_clk_hz >= CQSPI_VERSAL_ECO_MIN_FREQ)
+		writel(1, cqspi->iobase + CQSPI_REG_VERSAL_ECO);
+
+	/* Drive DLL reset bit to low */
+	writel(0, cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
+
+	/* Set initial delay value */
+	writel(CQSPI_VERSAL_INIT_DLY, cqspi->iobase + CQSPI_REG_VERSAL_PHY_MASTER_CTRL);
+
+	/* Set DLL reset bit */
+	writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK,
+	       cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
+
+	/* Check for loopback lock */
+	ret = cqspi_wait_for_bit(cqspi->iobase + CQSPI_REG_DLL_LOWER,
+				 CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "Loopback lock bit error (%i)\n", ret);
+		return ret;
+	}
+
+	/* Re-synchronize slave DLLs */
+	writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK, cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
+	writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK | CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK,
+	       cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
+
+	txtap = CQSPI_VERSAL_TX_TAP_MASTER << CQSPI_REG_PHY_CONFIG_TX_DLL_DLY_LSB;
+	max_tap = CQSPI_VERSAL_MAX_DLL_TAPS;
+
+	for (dummy_incr = 0; dummy_incr <= 1; dummy_incr++) {
+		/* Update the extra dummy clocks required to read the ID */
+		cqspi->extra_dummy_clks = dummy_incr;
+		rxtapfound = false;
+		min_rxtap = 0;
+		max_rxtap = 0;
+		max_index = 0;
+		min_index = 0;
+
+		for (i = 0; i <= max_tap; i++) {
+			val = txtap | i | CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK;
+			writel(val, cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
+			writel(val | CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK,
+			       cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
+			ret = cqspi_wait_for_bit(cqspi->iobase + CQSPI_REG_DLL_LOWER,
+						 CQSPI_REG_DLL_LOWER_DLL_LOCK_MASK, 0);
+			if (ret)
+				return ret;
+
+			/*
+			 * To consider the tap as valid, make sure to read the Flash ID
+			 * 10 times(recommended by IP design team). This makes the algorithm more
+			 * robust and gives more confidence about the valid tap, this will also
+			 * avoid getting the correct id by a fluke with a particular tap.
+			 * In any one of the iteration if the Flash ID is not matches with the
+			 * device_id, then that particular tap should not be considered as valid.
+			 */
+			count = 0;
+			do {
+				/* Execute the command and wait for the complete */
+				ret = cqspi_command_read(f_pdata, op);
+				if (ret < 0) {
+					dev_err(&pdev->dev,
+						"error %d reading JEDEC ID\n", ret);
+					return ret;
+				}
+
+				id_matched = true;
+				if (memcmp(mem->device_id, op->data.buf.in, op->data.nbytes)) {
+					id_matched = false;
+					break;
+				}
+			} while (id_matched && (count++ <= CQSPI_VERSAL_RDID_MAX_CNT));
+
+			if (id_matched) {
+				u8 current_rxtap = readl(cqspi->iobase +
+							 CQSPI_REG_VERSAL_DLL_OBSVBLE_UPPER) &
+							 CQSPI_REG_DLL_UPPER_RX_FLD_MASK;
+
+				if (!rxtapfound) {
+					min_rxtap = current_rxtap;
+					min_index = i;
+					rxtapfound = true;
+				}
+
+				max_rxtap = current_rxtap;
+				max_index = i;
+			}
+
+			if (!rxtapfound)
+				continue;
+
+			/* If ID doesn't match or reach the max tap, calculate the window size */
+			if (!id_matched || i == max_tap) {
+				windowsize = max_rxtap - min_rxtap + 1;
+				if (windowsize > max_windowsize) {
+					dummy_flag = dummy_incr;
+					max_windowsize = windowsize;
+					avg_index = (max_index + min_index) / 2;
+				}
+
+				rxtapfound = false;
+				if (windowsize >= CQSPI_VERSAL_MIN_WINDOW_SZ)
+					break;
+			}
+		}
+	}
+
+	/*
+	 * Look for minimum window size to ensure reliable data sampling even during drifts due
+	 * to PVT, so that a drift either towards left or right can be well addressed.
+	 */
+	if (max_windowsize < CQSPI_VERSAL_MIN_WINDOW_SZ)
+		return -EINVAL;
+
+	/* Update the extra dummy clocks based on the maximum window size */
+	cqspi->extra_dummy_clks = dummy_flag;
+
+	val = txtap | avg_index | CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK;
+	writel(val, cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
+	writel((CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK | val),
+	       cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
+
+	ret = cqspi_wait_for_bit(cqspi->iobase + CQSPI_REG_DLL_LOWER,
+				 CQSPI_REG_DLL_LOWER_DLL_LOCK_MASK, 0);
+	if (ret)
+		return ret;
+
+	cqspi->clk_tuned = true;
+
+	return 0;
+}
+
 static void cqspi_chipselect(struct cqspi_flash_pdata *f_pdata)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
@@ -1345,11 +1535,21 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
+	const struct cqspi_driver_platdata *ddata;
+	struct device *dev = &cqspi->pdev->dev;
 	struct cqspi_flash_pdata *f_pdata;
 
+	ddata = of_device_get_match_data(dev);
 	f_pdata = &cqspi->f_pdata[mem->spi->chip_select];
 	cqspi_configure(f_pdata, mem->spi->max_speed_hz);
 
+	if (op->cmd.dtr && ddata && ddata->execute_tuning && !cqspi->clk_tuned) {
+		int ret = ddata->execute_tuning(mem, op);
+
+		if (ret)
+			return ret;
+	}
+
 	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
 		if (!op->addr.nbytes)
 			return cqspi_command_read(f_pdata, op);
@@ -1846,6 +2046,7 @@ static const struct cqspi_driver_platdata versal_ospi = {
 			| CQSPI_HAS_PHY | CQSPI_HAS_DQS,
 	.indirect_read_dma = cqspi_versal_indirect_read_dma,
 	.get_dma_status = cqspi_get_versal_dma_status,
+	.execute_tuning = cqspi_versal_execute_tuning,
 };
 
 static const struct of_device_id cqspi_dt_ids[] = {
-- 
2.25.1

