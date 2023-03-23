Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0802E6C5B20
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjCWAKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCWAKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:10:10 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A712D2F791;
        Wed, 22 Mar 2023 17:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM/NWK2YiH6wlo4oR96ZLK3jvwhnACW/53ACmNwXSRygTwtyIxPoyyY34oawIpIYtmVJIMEAo/zYF+bGzm1Meb2EF/CQHusE4pGSHbVZYU5kwkPdn41ajL5INdCu44BHlzWxfRQueupTKBEy2UfSLbB3cODwOsDgWtgRQk0S5fvE6ie0RinhgkfQ74DBDpGOm8ACAwfonxHcJPyz2P2JKcuf1vV8GnlAMvmZSP4L7B7HHs2P/aKrZnvCHBylyCqENLW6Yz+ix5ndJsS9kIT6zkk74ZE0FfEl91m8xgBFQsqKwPf0+/hQsqMd2m26DwbeI73YYBXEVMwIUkobnyzpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpnIb1O3iD9+RUSdP9aH5CNIYVv5t5KX4+QyjF/xBm8=;
 b=Ct4KrryDmYMHKg1dX3sm/3RpSz+MqLA10AcqtRdn1yz4O70gW98wFLbY/JW9G7SGpxwojNlf8C+fTos33VSJiHDoCawH0x5d1yPAu+9CGnfyiz2ALchxX75FJeZUMWAARHRgzmE3VnanevtzqzJpxv2cC6pr0M2z0pukDE1/eJV2F+ygd8aPvqrAy2pv+n+TfccTvo6pa6KudEBstYMAI6yUuXQcNIXFXoLE6vbbwnlzYPRMpG2QhzGwGlkeV8oCDQR/iHxJokmgbC1GCgLbYHlfvbvHBnpycrlPlSRWU+8SpX6GVFh+ddEkRr+ixRZBRrH1ituEvovl52wIY6iqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpnIb1O3iD9+RUSdP9aH5CNIYVv5t5KX4+QyjF/xBm8=;
 b=MfejADrs6qf+YEWvrBc48mpJlGB+q6kNxuCkipNq/0Pe60DnIBbdgeOwCOOot5wTU1kHmOV9pV+tblbFK9XLhqNYOOR1n0nLiWgLeQrONeBRTwtthTT71HUG2Fi+x+6793zTSkFQvMKoi4dXE8VK6n1ocwN3Z0fAeKrjBpcHXFo=
Received: from BN9PR03CA0469.namprd03.prod.outlook.com (2603:10b6:408:139::24)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 00:09:22 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::c5) by BN9PR03CA0469.outlook.office365.com
 (2603:10b6:408:139::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 00:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 00:09:22 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 19:09:19 -0500
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
Subject: [PATCH v12 09/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
Date:   Wed, 22 Mar 2023 17:06:51 -0700
Message-ID: <20230323000657.28664-10-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe823b9-70b1-4af7-8352-08db2b32dad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNj/wH4N1SA9MJXhSqx4GO9TS5rO3yaeekqIxVFMhXbn89BtB0qAtLGrSLAN17Z9mrzo63/iwujkHPk09e3Z5JcizvCEGk1vpdDhYsw/bzeoaQi6XYtGOlkF5eWv2sdLViX0ifqQzxrO2ZbEx1tdq2xkIWxp4InElLh/0Y3t9j46AQ24calq5S/CIZ+WEZ0nWtlT327qhv/gqgH0OMeZEQqY6fStUZkhbAwSPauqGMLBlHlMxIvi3DWrXkND12jNv9/ZLZi8yhjEiYTIDWw0T48plcDbkN3vNIJqNWJF91vwLa2g3c9eJBjAipbhJ8s5mwoYJz7gVQhaTWbJOL5ryBYpaB/Bs2PZcTzvprSWM7kSUb9/zVtjc9Pz4XGvj+fPvDo29KQD+7B1rLLWKimw6Lq+5XXDmiS2jdFyWk8f0e2gSPwLJCKlPS1+2VPWUiMymLgjg/lgJEk+wXwHUl2RTKgVlcaL6ytNdF9iI2gCZLErpMOqSOx0irYoEYN6mq+IysoHnmEp1xQl4hk8wEdpkI1C4aCs+vtJNKrqQtDULKBFcB/dzKaV54xNvCzRztMWirUiIhrwT66WrAGl42q7piba64iJOpgA7116XL5pQlASfT7WSATSKuYWpNOPisOYPslx68BXoPRaoOZUCl5+KqBPSbjCsYfQcie//HjEDjT7fqdL1uvMeuKN4DdjsQH9efTx+soIFYLsKo8qCBYatoOWd4JUPZ3G/7EzOnJICdY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(8936002)(336012)(36756003)(7416002)(40460700003)(7406005)(5660300002)(40480700001)(426003)(47076005)(36860700001)(2616005)(2906002)(82310400005)(478600001)(316002)(54906003)(81166007)(41300700001)(82740400003)(4326008)(1076003)(26005)(8676002)(6916009)(70586007)(356005)(6666004)(186003)(16526019)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 00:09:22.1108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe823b9-70b1-4af7-8352-08db2b32dad0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

