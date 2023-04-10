Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8786DCB14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjDJSrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDJSr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:47:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8F02128;
        Mon, 10 Apr 2023 11:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l58tyMGHR97Y7yanEmyjIjZw9qu5cxG2kve9FUm0dO3NI58mU0C4Jrt+Z4/eKtZZt7T536Wk8j+Oo+MdvRgqM9xeuDZwQvQ2iAqv2loVQ4KCEue18kOzafDNlvqxF8/Um+XeMbxM0taoo1CJvM8u7PK3WUkqrggAF7WfHzuaq41f354FtIsfU5ebhbSQo32iBh4YNqzJU36wA2UoVo0tuq1gKuOxCmKQB9mNi5AIde3AhdaKYF7u3VhsHyxZyfyeOwBZYGnLpJrF5grghUj82mZk/icE4dd5N2MFo67gv40iFu9mOsVbzZ6F3rBK6w4ujt+a31CL6XByHYmWaOB5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYkoSlbMMUE1LcDfRYmOgiXWrpEnjJ0YKyuk1LOG4Ns=;
 b=IefYL9V1WsAsdGbSNw8FHeJgKbeK9D8OWaMPbqMrG2tLyV/e+MMmA7G5fdvKkZsGXaP5x9LX2h5RqTBG9a56Ndd8DkkVsNGxQt9jMHaBpZJGBY5fh06yCFQkvF6/6UvWGiGDMdUxJOW2pfWSEvuGWL4/uu57jjO5wZ1fV+B+u+U+T5md8zQANCOmpa9cYOPNBE0U0BVvK/x0c85eqPLACFFl8uD1wJoXDzqdIqWXVflGR6awDgXGLXkaXeAtW7gxNziWITs2PQsCdcVRGdz94Otf+9s5LZoTQ2lRk7AgR+84IrkfapPeQ97Z/1zDbh9EiSy1MNAcM2kNXfmSkeIHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYkoSlbMMUE1LcDfRYmOgiXWrpEnjJ0YKyuk1LOG4Ns=;
 b=V6wK6HxYpCDgDPVZEsRs6nX4DyEXu9dO1nzJSNyD2Ez6UVy6h8FWhtUtS6tDfSrMnw56U904PZj0X5nTX6Wpd9gbl1gGX/ZAK1RnFBbtZxTdcJL7eSTi6pucPELrAW6S9sX97ECXvOrbqdwqnSkrxfIcJQ2IbW51RO5t4jOIhcg=
Received: from DS7PR03CA0216.namprd03.prod.outlook.com (2603:10b6:5:3ba::11)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 18:47:20 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::cd) by DS7PR03CA0216.outlook.office365.com
 (2603:10b6:5:3ba::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36 via Frontend
 Transport; Mon, 10 Apr 2023 18:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.20 via Frontend Transport; Mon, 10 Apr 2023 18:47:19 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:47:16 -0500
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
Subject: [PATCH v13 10/15] spi: dw: Add support for AMD Pensando Elba SoC
Date:   Mon, 10 Apr 2023 11:45:21 -0700
Message-ID: <20230410184526.15990-11-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410184526.15990-1-blarson@amd.com>
References: <20230410184526.15990-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa9bb34-502b-453a-e85e-08db39f4036d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: er4wLw+L9f2c7Adn0wLJpHHAyHgsjSP3+IJRkM5ICU4kqXnI4iwNVfwU900U00GJZFpoXG9zY0I8iLUrTyonWlOjPSoZRiGwkb/FbkIjRQuxSeGTpgWKbTKA4jd8ZqSOHDY77VjSrxhu34e5kuvrBmKbZssjDfnVI0QtX5hxz4yg9yjlNep1yHqcoEneZe1CIYpQNsDKcDhbE5cqP4DGIwT5cMK9c1d8OhhMsk2t4fqGk2RlqvZEoQxdSpBMYsygzq1IL1WpvjO6yQBZNk3BnKzJ2AdMDwd21dWRMl60C2H3nf74jGQEbg+4RJvJxJkmIhiGghgFfFH00QlLHkn4seSjJg1R8RMQL0THAs5/kcX3FxfwMp7jHuwfKjIOaOLl1aXo8VkdklD8f2evk+6JTU49OdOAb7lSrBS1bpA07tLbhDRUJtEJThZ6toFO1uN4jZiPEznUCA+DH6h8OC5Y5AhF0zJZsjfv+vkEYKsyP7t4bBOjZQbPOjBY4r9r3pJ6xcgTEUG6G2w7FiImK2rmAYBRWJN2c1EcvuPm59+UMf/aUhI8Hqwv03gIsO2D2saBP/HK0H1R9G9Zt3JsUwhXE2Cme5J099zXn31gIwlI/cB2fkjHvdMK/LRyi6uSuPaOwOd+vO5SPn750sdiRwfC8OfYLXpjTZ5AdCyhH9giVaRN+L8PYBg03FoXve3DVWWhLRgpCXRlf6FHqSNLARfG1crshdqWch1uYSvjUyftfuc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(478600001)(40480700001)(47076005)(83380400001)(82740400003)(40460700003)(36756003)(81166007)(356005)(2616005)(36860700001)(426003)(336012)(2906002)(54906003)(316002)(186003)(16526019)(1076003)(26005)(5660300002)(7416002)(8676002)(6916009)(8936002)(4326008)(41300700001)(82310400005)(70586007)(70206006)(7406005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:47:19.4301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa9bb34-502b-453a-e85e-08db39f4036d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

