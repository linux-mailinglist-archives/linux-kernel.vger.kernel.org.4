Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E886B6283
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCLArb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCLAr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:47:28 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29B66BDE3;
        Sat, 11 Mar 2023 16:47:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdHD0j9KJfhx7xwcNlMOiLKL4OTN/01U1sICMOFtmTu8jCgKC2avtlYaKwPhL6aD5trnu4U/WfwFZuGGyIqEZiw7pjUuz6fJm5DijD+MZ2aPSc7YSpj+CTT/b7NzOAXTnflVLf3FeBtGykYAPE7jPzhxojoy206yH4v1PWZej4uPk/kz4YLH0pkCi07YXflzmCk2wPZ7DbIzBX4EQR227McBbsJMEJM+77DloPFKbP7MswWFf4I6H/oYJyvQqi97JyBYgUxUcToazR2DAwxg5BwmEdAeIkCTyka2FVcjsYGe0sXZJQAAXug+IKwqSZCYXjzgndr5qrExbb51qnaObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk5SH2as85ZqLhTJF5Vp455zKYM3VN7V67ZRGnbutrE=;
 b=LIzGb7xX7TgUbpAQDz5SdjMTzpFWgKzETFiRZRFaxKYog8bS885hD/WVAc5JClYHQkcJs9anf2PX1zjsSiqBjwA3kMaeaJYBhTBAhSUuQvLeSpIN2g5UIIL3L4gukIK6nkqVDoFvDuGWoJlVdNzx7XfZ6BVaEAC+oXctfTkufOmhFv5gvyH6zxE+HMD8a+iEYHiIujEJTbYWJ+BlaAW801B/0+4b3a9DAwKQZpxULZxxCNCwPQOxGpf5zi6Ak7HjjojSAiIRLVwWnGVcyJXsKdcO3/gnhCTrEwe7JtPNTOJRz9iTeYzLZTsv8pdsyLfJ+sUgLXYWB2ctjxZHy2jdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk5SH2as85ZqLhTJF5Vp455zKYM3VN7V67ZRGnbutrE=;
 b=UpdNNSI6ItY8a2i5I2MBa7K+2UbAi5c5LU2O5OjXOltYSsEQhIVvZTCu2smjwtDYjcGztIZS3ZHHKeUZufkTfNZlkWRP+QxZ13luivKZOge9iRWi/7mKtbBwIBh77IdEwtaOLC8NQtpKVGm5+RqDA6D1p+ynbaFQ67fsW+Id0fc=
Received: from DM6PR12CA0013.namprd12.prod.outlook.com (2603:10b6:5:1c0::26)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sun, 12 Mar
 2023 00:46:27 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::d4) by DM6PR12CA0013.outlook.office365.com
 (2603:10b6:5:1c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24 via Frontend
 Transport; Sun, 12 Mar 2023 00:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Sun, 12 Mar 2023 00:46:26 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:46:22 -0600
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
Subject: [PATCH v11 10/15] spi: dw: Add support for AMD Pensando Elba SoC
Date:   Sat, 11 Mar 2023 16:44:40 -0800
Message-ID: <20230312004445.15913-11-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230312004445.15913-1-blarson@amd.com>
References: <20230312004445.15913-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 44549a0f-6b68-47a2-0aa7-08db22933643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+1Z/dLwKZWGZ21UJFg2plJLnH6rxzQKEqRn58K8Fu/APSJ9eQLGfbFNBbEXwLU4efPHOb/GFgBqTtySxJd2b0+I5caCQwgRthHgRXukojEBLoPC0UnEYLT6+3br2cY7vOOsLNRsqPdGG6Ev741Fg7V0b8gqzbVgShq5yapwDgLWXz9sXyRlaqo5ofxYmTeGbVYc/OObAOyZI3n6jjS8VT0iJcvuZHZgG/Z5UDqMhjFeB5iBZS6mSjHca2jDZEbaYBQUDMaC3wXde0JNcvbWOYOGrRoWIqxoSZBYGM1QuETiKhvAPKWG1UloQzOGzs5qCVKgy/pKJ5ICxop7i/xLT75IYh6cld/EyWLlZBrKq3NQFA6riftPHJPEGmjdrk8zKBVY+EhAWjVZoIxiskbHrsK/ZgCXkTe26KeT99tPtOroL3QfZMzY+XRLnARz9y6R4pesu0/sNX3cdHlP6aidHuNNXWQAnK7nRVRLiV3nZssx6AWT+pZoWsO2E/3PL7j60LR1CjGMzOGWdzCKSSdTzZFQnM26SvUk+7VtyPVEHBPOSOVAsAK1y83MuhJV0gBmWJaOdLe2uV8AELu+lFX7UAaMOq0GIy4bNALW9Sdw+r2xHOHV9NOhEyESURQ9R3A38VuCnSEQGku72ry8/6CHmG/SzrGM0J0RCWKsZONS8rx1wccMGUpSgRDbOO4Yj3OdCLuqm7WxIJKl6N01uSN+YMSmiz+OzcDDhiftbQT+deQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(8676002)(4326008)(6916009)(70586007)(70206006)(83380400001)(5660300002)(41300700001)(316002)(36860700001)(54906003)(2616005)(8936002)(47076005)(2906002)(36756003)(478600001)(82740400003)(7406005)(426003)(7416002)(40460700003)(40480700001)(81166007)(82310400005)(336012)(356005)(6666004)(186003)(16526019)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:46:26.7863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44549a0f-6b68-47a2-0aa7-08db22933643
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
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

v11 changes:
- Simplify dw_spi_elb_init by using syscon_regmap_lookup_by_phandle()

v10 changes:
- Delete struct dw_spi_elba, use regmap directly in priv

v9 changes:
- Add use of macros GENMASK() and BIT()
- Change ELBA_SPICS_SHIFT() to ELBA_SPICS_OFFSET()

---
 drivers/spi/spi-dw-mmio.c | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 26c40ea6dd12..5851ecc6e1e9 100644
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
@@ -237,6 +251,48 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
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
+	dwsmmio->priv = syscon;
+	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -352,6 +408,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.17.1

