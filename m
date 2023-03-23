Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEEE6C5B25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCWAKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCWAK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:10:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D46E30B29;
        Wed, 22 Mar 2023 17:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDwYu1SERZS1u63v6gVq7/HVvgTH9/BAshr0Hj0ac6EgX+NpWXbk9a+gQ8Su0MEQi1DQdErFpuRVoP5YX6bxrSErmQNPElb/HAEAYS2CpMH1nEzbEyjiE00XwrS0KK4+kl7TCCM8eqUCPYux/JX5l7K9VD8CkHzlBvPwgxNxtTDyc1c1upjSr6XbnCeXy49haPjy7kfDk3iqmnNV8sdCWmTXy4aWwmFwfyHZ+4zZ/jrCCSC7ayPKIL3lSmkz+U/dzo3/xsRL/a/Uq87aYKN49zZHtPpe9Tpj3iI3aVpxNl8+0aPzdPKt8HcmgBvEeD76pOyl7qoXcdabuZJuAKFqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYkoSlbMMUE1LcDfRYmOgiXWrpEnjJ0YKyuk1LOG4Ns=;
 b=DWWdBGnV71H1Iy8ljSA+B/crswydMIjFftDiyfQRD4CjlbAGXrtMAkGpnGZ97dAdTEPsgpi1JhgAc0GU4RkZcD6BfcdDENbwuNj7HZmyObMfrlmLzNe1BbyFZ0ZJGEJqaMcyXOUD1ZoIIHMnktVsbQL8OhYV1BtGXaAaQkxa62K75kjDPhnocG1Wb4u19eKsuKhSA2fE2q3KJg/4JL8Hh4RSFp3JkGlj9nut3AuY0B3hJoZ/+ram/liEQCoV7aJ4IcpaW3wFs4OXePre7VvJm+rCIOunYxRi/Dmv/r3npWe8Pv/ztFa32Xn/gEERkqOU1j3nHo78Yf5cjgZmrUlV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYkoSlbMMUE1LcDfRYmOgiXWrpEnjJ0YKyuk1LOG4Ns=;
 b=RSa1bRHUTMz108VQGOsOgGVLbBsEUU51X2hfhiylHI3ceXIFoOt2Zv0g4vUEU0sXUVpikp0Yp/baUdVcNe4DHNyiwJ5TuqzASru5TJrm+Q42+lr2Q/qrcyBRYvgzQlMwmpty16vh/FcSLs5AMgSvvpaTg71OSUC8YoPenckR4rY=
Received: from BL1PR13CA0241.namprd13.prod.outlook.com (2603:10b6:208:2ba::6)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 00:09:41 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::10) by BL1PR13CA0241.outlook.office365.com
 (2603:10b6:208:2ba::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.17 via Frontend
 Transport; Thu, 23 Mar 2023 00:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 00:09:41 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 19:09:37 -0500
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
Subject: [PATCH v12 10/15] spi: dw: Add support for AMD Pensando Elba SoC
Date:   Wed, 22 Mar 2023 17:06:52 -0700
Message-ID: <20230323000657.28664-11-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323000657.28664-1-blarson@amd.com>
References: <20230323000657.28664-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 6404ce8e-3265-46f8-8508-08db2b32e614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CV4MTeJz/rPCkS97zsoS7LRSsru/KNI+hugmHdpFSpSbMZOgPgywoVn2Hb4Eq/geejCnSZoEYcCAxA0bjRNCUJnQyV+b0TqugzM7luwneOnVj7mnZ5RB6K2i4NCXqOLqIhBWI4Ly/jMAzW1EQ9ivOt4Vof1RB2F6ImjRTp6yGh5dIwhtSQVULO+ynumQKKBtXQQDtbQwjojfKGu6jTDVdVWCQqstGPARrhxCzgs0saeFuvGkr9mJ7uQxeSEKbN0ZTX7w/I9VkcfQNYTsq+XhCJsnCRSVip8RHbe+pXSiA3BWLimG7b2mkJ4u+1gPQHwkitvGbJy3IpJrpYjp4iPu2J+CAtI7RUY2jJrN2eOyDiBYMHBHua1nO+LBebPd1Cule49EIqp0oF8H/5BVT535Dj3jeqVRTocRsfv7+jqsYfqW2lGC2gr3WFMu2xnxwn+Em8ta3vzziJPx8GDfhey1WrNDj9LVtO/r9R6lQiUmzqZWURwTOYFhv9qq/pHM1BCG+B6qfi6fqgzsj0pXJyPjBsvVat0kmZ3r6CTPgY7LY2L6+mbZwOQBf0VfV1AGtgc6M+tvLcYBYWYyAH1Fl03qLZVOGfWOUbaRckhAVGfNUEkOvKZhUBAbCULogJ/nGNzAMFjah/Lyhr/p3K6Ixoht3euRyXrYM0PUY2igpEPCHssE5pnvGhDwFPGgaMreiUs6EZ8WMEuiEFPZ4hfMVmIkEuFre6NIPNmfYbMxga741LA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(82740400003)(2616005)(16526019)(1076003)(26005)(6666004)(36756003)(336012)(7406005)(2906002)(7416002)(356005)(47076005)(426003)(81166007)(5660300002)(8936002)(36860700001)(41300700001)(40460700003)(83380400001)(478600001)(40480700001)(54906003)(186003)(6916009)(70586007)(316002)(8676002)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 00:09:41.0895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6404ce8e-3265-46f8-8508-08db2b32e614
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---

v12 changes:
- Add a newline in function dw_spi_elba_init()

v11 changes:
- Simplify dw_spi_elb_init by using syscon_regmap_lookup_by_phandle()

v10 changes:
- Delete struct dw_spi_elba, use regmap directly in priv

v9 changes:
- Add use of macros GENMASK() and BIT()
- Change ELBA_SPICS_SHIFT() to ELBA_SPICS_OFFSET()

---
 drivers/spi/spi-dw-mmio.c | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 26c40ea6dd12..8cfad64b5463 100644
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
@@ -237,6 +251,49 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
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
+	struct regmap *syscon;
+
+	syscon = syscon_regmap_lookup_by_phandle(dev_of_node(&pdev->dev),
+						 "amd,pensando-elba-syscon");
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
@@ -352,6 +409,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.17.1

