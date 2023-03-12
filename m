Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA896B6278
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCLArO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjCLArL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:47:11 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59461574CE;
        Sat, 11 Mar 2023 16:46:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BK7/bxF9f4G5lsj5KG3JuFMTi2OIC4DLDbWbWTix8z80YtR8/aAadLkbFJDxIVaTu3fRaWngHFPLQul3MkFYBMO0A4MFntLDFAwyE7oWhqWgCEi29u03zHq5Q3+2SOVOdXxVWYEejB+wrb5QwRR/s93sekQzYuy2Gn/OEMQDwTQuEfFtE4M69eTXc2dRigxYYtysMUsxJyXKO9oXfvMqillbCzxp6WZC2mJuIHLQqEu5SgOXNdOJj1tk5mWhHOOGf5NycdeG7lJYMGiFoeSGj43z4/Cifzvhb6BWkSHHTg1NxCFe5gV8uGFp90RYgUhMF25HS5Pbeln9pLn4jfK62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpnIb1O3iD9+RUSdP9aH5CNIYVv5t5KX4+QyjF/xBm8=;
 b=QA1OR0pr25tWkzdqTvQstcJt2/QNIXxcq47yDT702veXlxPIqMy5sZ5PFlRzhlghiucQfmNTKXs8liU/sTloaooBSemCib9Mgk9ILTgv5bPtUPDRQCOn5UGKH4P53UQb5opbl2a7305B3uS12PakS+sBgI4jTkuHgZjVtGLixWk9JOzerNraAfVrTvHZbpjReeVLZGBJag0JzH6K6LAglTVWUuAkr8pMRWeY1+feR0lIsG0X5eSKblbPYN++7MfjvgWMHyWUUskh+SH8LrFJ/MukU9Gz9MpOckpK0DXGFUmiBta4N2ZuvjaoMQehNEbvzm7PZwvPYlcYft9UpGfWig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpnIb1O3iD9+RUSdP9aH5CNIYVv5t5KX4+QyjF/xBm8=;
 b=cC67+kwZ/4FuMXLstTixOIcPtudkMeGNUTpLOWE8MZWGS405yFrIsTQxs9rGbNBpNeEVHX/rz4z12zFuQmszM50hIN2qvDjr3fkM4BSTZdmamBMVF5F1bthBbbgJLIDFiKINALiN0bwq6O+Lof3f8CgQMWydEnLqhMQHigTwjKw=
Received: from DM6PR13CA0037.namprd13.prod.outlook.com (2603:10b6:5:134::14)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Sun, 12 Mar
 2023 00:46:18 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::34) by DM6PR13CA0037.outlook.office365.com
 (2603:10b6:5:134::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23 via Frontend
 Transport; Sun, 12 Mar 2023 00:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.22 via Frontend Transport; Sun, 12 Mar 2023 00:46:17 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:46:13 -0600
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
Subject: [PATCH v11 09/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
Date:   Sat, 11 Mar 2023 16:44:39 -0800
Message-ID: <20230312004445.15913-10-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2bde4f-5c07-4c96-5fb6-08db229330e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mODzHg6Dpnfv/AfKJl+pzOxgmsC+rVDx+IBC49WlfWt5R3X027svt62E3i24OEdU819Zcl8hxWu+892kFjZfOqk81GsKtV2S2MQAmYwvSMPOl6LuN9gA1eqp+0FkQz2zfXk1V7u5mphoOBngl56J/kW+rEbmFiZ4tuwClCOl+aQLNMffZdmzIbIeCcBJp6NI7596tkS58XA+ZCNG+/yFYEae9dDU+L7y9JIBxg/owzwHsGDa9O2tNy6NkVG24SGJzl/0fOdUDvbgUT5AzzppWUSDyhKdp9rZzQmWKpIGfUPovWBKeJJ73W4poWUZ7VqXpjKr/765Q7KAaG0KjfA7KLK+9dqejiuWb+MSWcbb97tcJ0TZDEbF/3z1nVX0R99/d5r29I9fI+8DXWHOVNURYKtfT9/Mf2ssU0YHycXCKK/d7pmBb0oYSkvlQZgvSJSQxA3HV2iD/FR/+UkLP9lSLT/9tErlPz4vVDul3dfjv9Ug5380yAgqa61SKXxPstNhJeBIx5QPX8wEKYUHUlbDkQiOOXlrpP5y7OgVzNoqQpE0+swOuHsLoM4dmXXwda29ZU74ZNfv5dpJXZsCropPGSEuXbZMyCpHXfWr+jsTLAc2QyLOhcPOncHC9mEPZiPLpuxdmvn26A9g4j6JpKRmP0Dofv56vgNEEElgO209HAzAdDANKj+FRr/GA1VaMozDEhyiAKSOUwiVKznv2I+NXFeq+dggqu4SVc28J3IhsQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(16526019)(36756003)(40460700003)(6666004)(54906003)(478600001)(4326008)(5660300002)(7416002)(2906002)(316002)(7406005)(70206006)(8676002)(70586007)(41300700001)(8936002)(81166007)(6916009)(186003)(36860700001)(356005)(40480700001)(2616005)(82740400003)(1076003)(26005)(82310400005)(426003)(47076005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:46:17.7995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2bde4f-5c07-4c96-5fb6-08db229330e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Pensando Elba SoC has the Cadence QSPI controller integrated.

The quirk CQSPI_NEEDS_APB_AHB_HAZARD_WAR is added and if enabled
a dummy readback from the controller is performed to ensure
synchronization.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v9 changes:
- Rebase to linux-next 6.2.0-rc1

---
 drivers/spi/spi-cadence-quadspi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 64b6a460d739..ad82d2ab3442 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -40,6 +40,7 @@
 #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
 #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
 #define CQSPI_SLOW_SRAM		BIT(4)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -90,6 +91,7 @@ struct cqspi_st {
 	u32			pd_dev_id;
 	bool			wr_completion;
 	bool			slow_sram;
+	bool			apb_ahb_hazard;
 };
 
 struct cqspi_driver_platdata {
@@ -1004,6 +1006,13 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->wr_delay)
 		ndelay(cqspi->wr_delay);
 
+	/*
+	 * If a hazard exists between the APB and AHB interfaces, perform a
+	 * dummy readback from the controller to ensure synchronization.
+	 */
+	if (cqspi->apb_ahb_hazard)
+		readl(reg_base + CQSPI_REG_INDIRECTWR);
+
 	while (remaining > 0) {
 		size_t write_words, mod_bytes;
 
@@ -1734,6 +1743,8 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->wr_completion = false;
 		if (ddata->quirks & CQSPI_SLOW_SRAM)
 			cqspi->slow_sram = true;
+		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
+			cqspi->apb_ahb_hazard = true;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
 					    "xlnx,versal-ospi-1.0"))
@@ -1859,6 +1870,10 @@ static const struct cqspi_driver_platdata versal_ospi = {
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
 
+static const struct cqspi_driver_platdata pensando_cdns_qspi = {
+	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1884,6 +1899,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "intel,socfpga-qspi",
 		.data = &socfpga_qspi,
 	},
+	{
+		.compatible = "amd,pensando-elba-qspi",
+		.data = &pensando_cdns_qspi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.17.1

