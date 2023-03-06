Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFCE6AB574
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCFEKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCFEKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:10:05 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD62C126F4;
        Sun,  5 Mar 2023 20:09:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRPgVfB0xl8KBN2pJDi8qN16YoGbQdcO0pvAdDBEDtZ3LxK+VeezPM3fEAUZ7jusCAXNf9pU5xYduGOg7m3u28nB0ZLuYdO6otMXxT4YcxL/qn+kAtI/sA6xpyj9QwxX+i7qf5pAsIFzFO/n86Nf05joEYSKXYVFctyj+vkYvsgHRQ8RGfTmEkTBQNDLVAjbUhWRJ1V/yVGvtoyk2ep0YiGVmUusVLgFVvFS6b3SwEU+i3cZ3rXIvls7ji7MCHRfQu24+NgUIqfdqQmobEKLiCyjeV26VkBZpEJad1c+UcvpfAfMtbnoVDasU9Z+dA1JMDIRqVTwqPg0YMLxIKB8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnUqoRNlmrg2CnO03HCAj+rueJrCSLHBVMKR8mS/enU=;
 b=m+5DLzT/S8N8IWqONroLiAQWNhC8jcmj/nFuRuW19gg/VrF8yvUgjnyfz3cwVh8jFiaNv3vYNzSCS5NORx9+pzXzK4Pe5yxV9B+0ljGKbQ1xMS9M6HX/qgWoMRxzZckulkssEkKoea1peRHP9Bq15Yj8wQnJYNC6RdcYs/qCepJBkqiGZsFT1RUZxr+4TjVbmuLP44luickKZi9Zja+DTR8ajJrQ4Gra5jpgwbRs8Ed7UOsWypCLznzYgxGzUilnz4Uo26jLXH/Y6DZtIGtGxemeCUoIct4YKZCinsBAf5TdKZ6fb7IVACyAK/qXd4yV371c8oVd2QL9VaQ6gWLVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnUqoRNlmrg2CnO03HCAj+rueJrCSLHBVMKR8mS/enU=;
 b=tB4KxY4jOSyIWzz5lvXNv3dmrMv0lV6tESOb2vmKzH/r1EpNxRq8B56Q4hijAHPcjx5N4DGmUsBXB2MdA1m1DOXTkb593861waYmRNlJ8iz0UFiTMfwiIrYr/Bk06JgA19KfGZxeIBrxaMQihLYIM2afpp+QuGQeRotAZbZOTEU=
Received: from BN9PR03CA0503.namprd03.prod.outlook.com (2603:10b6:408:130::28)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Mon, 6 Mar
 2023 04:09:55 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::26) by BN9PR03CA0503.outlook.office365.com
 (2603:10b6:408:130::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 04:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:09:54 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:09:51 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v10 10/15] spi: dw: Add support for AMD Pensando Elba SoC
Date:   Sun, 5 Mar 2023 20:07:34 -0800
Message-ID: <20230306040739.51488-11-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8e8664-739c-481e-32a8-08db1df8a431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0W+wlAM83nJxCW/9bjLzLqw40mAuit03OV8LD4cAmvP/u3JnZ0u+v5at8MyW2ZdfxdoIcjBsHi+EOaQVjYUK82V4nzCU0Oqy1tRL9W5MUbsieXJa52yingoV8R7WltUipjkzQqwyO3HeN30s9AuXk91q6++M51lAbgdbGadHAmGz0cEntum047f0q0OsOwj+Zu516ab6YbFdWUbG0ZvCH9Bp7btbMqDprCRxJXqq3+201eQ/CAJMdAlVrGf35qTiGb2CxmLgnI1yAbOWSCBjIfAikbFMnD3U/2hInFuus8uyHUwqBfGqqn6yjaH/xyhV56Xgf9+koTNtQ/rh2em5y89rzl+ECagCzdoyE9B1Tmit2jI2TjlzkR90SBh/KjXH/sSEVjVg2jl3d84S0fRpqVj/hWmxNUc5hnHcEb93DcyZ3PM3e27pdi7KWSvLYDFLq8HGUQHVsSVKAcIrpd8hqXi1wyeNqfVEt4iuxNvJruIiGuH7D5fEbO8mHLJjnPB6KMLvTC/JGiykVh6d7221w0x/5uxga5O+y+yGu3QQlKkyR7QUmwssVHOUyJLAnLCi5zSDMIvyhh3zpYSvN+gt4JBpy4O9N8WOfO0SZ+cbkfHw6XKA0mfIIdkshmi153gVtMPKOBqVQdX38Ifavhg+d+15F1AQEGh2sF09uVNv7mX3aEau9yVLbVr5vKEWHYegW4empQhTZbqUupwtP8O6SinCsTzS4DM+BB9uX10RvI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(1076003)(6666004)(36756003)(36860700001)(47076005)(426003)(83380400001)(82310400005)(356005)(40460700003)(81166007)(40480700001)(82740400003)(336012)(16526019)(186003)(2616005)(26005)(41300700001)(70586007)(70206006)(8676002)(4326008)(6916009)(2906002)(8936002)(7406005)(7416002)(5660300002)(478600001)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:09:54.6058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8e8664-739c-481e-32a8-08db1df8a431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
with device specific chip-select control.  The Elba SoC
provides four chip-selects where the native DW IP supports
two chip-selects.  The Elba DW_SPI instance has two native
CS signals that are always overridden.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v10 changes:
- Delete struct dw_spi_elba, use regmap directly in priv

v9 changes:
- Add use of macros GENMASK() and BIT()
- Change ELBA_SPICS_SHIFT() to ELBA_SPICS_OFFSET()

---
 drivers/spi/spi-dw-mmio.c | 65 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 26c40ea6dd12..2076cb83a11b 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -53,6 +53,20 @@ struct dw_spi_mscc {
 	void __iomem        *spi_mst; /* Not sparx5 */
 };
 
+/*
+ * Elba SoC does not use ssi, pin override is used for cs 0,1 and
+ * gpios for cs 2,3 as defined in the device tree.
+ *
+ * cs:  |       1               0
+ * bit: |---3-------2-------1-------0
+ *      |  cs1   cs1_ovr   cs0   cs0_ovr
+ */
+#define ELBA_SPICS_REG			0x2468
+#define ELBA_SPICS_OFFSET(cs)		((cs) << 1)
+#define ELBA_SPICS_MASK(cs)		(GENMASK(1, 0) << ELBA_SPICS_OFFSET(cs))
+#define ELBA_SPICS_SET(cs, val)		\
+		((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
+
 /*
  * The Designware SPI controller (referred to as master in the documentation)
  * automatically deasserts chip select when the tx fifo is empty. The chip
@@ -237,6 +251,56 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
 	return 0;
 }
 
+static void dw_spi_elba_override_cs(struct regmap *syscon, int cs, int enable)
+{
+	regmap_update_bits(syscon, ELBA_SPICS_REG, ELBA_SPICS_MASK(cs),
+			   ELBA_SPICS_SET(cs, enable));
+}
+
+static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
+{
+	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
+	struct regmap *syscon = dwsmmio->priv;
+	u8 cs;
+
+	cs = spi->chip_select;
+	if (cs < 2)
+		dw_spi_elba_override_cs(syscon, spi->chip_select, enable);
+
+	/*
+	 * The DW SPI controller needs a native CS bit selected to start
+	 * the serial engine.
+	 */
+	spi->chip_select = 0;
+	dw_spi_set_cs(spi, enable);
+	spi->chip_select = cs;
+}
+
+static int dw_spi_elba_init(struct platform_device *pdev,
+			    struct dw_spi_mmio *dwsmmio)
+{
+	const char *syscon_name = "amd,pensando-elba-syscon";
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *node;
+	struct regmap *syscon;
+
+	node = of_parse_phandle(np, syscon_name, 0);
+	if (!node)
+		return dev_err_probe(&pdev->dev, -ENODEV, "failed to find %s\n",
+				     syscon_name);
+
+	syscon = syscon_node_to_regmap(node);
+	if (IS_ERR(syscon))
+		return dev_err_probe(&pdev->dev, PTR_ERR(syscon),
+				     "syscon regmap lookup failed\n");
+
+	dwsmmio->priv = syscon;
+	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -352,6 +416,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.17.1

