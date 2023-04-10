Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17576DCB0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjDJSr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDJSrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:47:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A8E1737;
        Mon, 10 Apr 2023 11:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB2p7dvYphkhMsuZcu+FXIe4BY1Qf0+a5X4gtlAUH8dhohE1AJuGHsPX8dRwMMlDULZfOdVHagf5f1uwh2bUezXc/0A49Wg8OX2P7SfnqDluQaU/xfcXHi9njFL9JJ8886Vo5k+iHTwd7b9yLihJqqUtU7wBDX82QcBYnQDqiFR2bQiX2ENtHUVxASlobttXY4cqmF90poJA8ozJa44VKbjv6pkVt/xL8EKu2/8Gwp9v64QUbGzNezlMZj3TCq4gCy6+9nf0y4j39Qp9/7unXP2sa4KKeSzS2fTnnGD6SnwNtnKDgsMYb3Tf8yxHjvF1fOhawzrEtKFxw3LW3hWwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpnIb1O3iD9+RUSdP9aH5CNIYVv5t5KX4+QyjF/xBm8=;
 b=lrE6H6OJZyOrCw2vO4JwoiJNBwhGgzXFjVmPJbWWiMmMoqeDMHqqjwMRkjn+5YB5sn0hhvLQZzKHS4MOyciCjmsWbxgy4ZRwiIFglv0T1k0sdZiY0TUS8Li+dWJlg4kV2hnEyHwXlz2m6/gd91PU3P15t+3GVhc1nAR2egn4e0NqcXM0gMWaYR9yS/6Fn1VabsE7k1AtpnUGPHrMIJPIFQHcO9CBnqH2xqthqkoI3ACIVPNWO0h5BuC8zdzmpw+Jyz8r0sYKtmULmW4CGfJuic/q7cQ+yEfMqyugRU/WeZKHH6BuyK7gHe30rGpp3Fl0ePgH6Ys/icWaXmGJ432V3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpnIb1O3iD9+RUSdP9aH5CNIYVv5t5KX4+QyjF/xBm8=;
 b=a5jx0VRXw0j+XyFaxH7mlB2jvO2TPXjYYHv/b61BkvlDvQRx54393oUE+iZPnObbnSHycM/Pjmbeh/uNF4a/tewbhSeGjgT91YIdpvxP69pAoqTMU3prAPVZl25LgykQO1UwXbGUREGNxIO27VG1n/0RopWgrZPa4/nuCXrIUQI=
Received: from DS7PR03CA0273.namprd03.prod.outlook.com (2603:10b6:5:3ad::8) by
 SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Mon, 10 Apr 2023 18:47:09 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::2b) by DS7PR03CA0273.outlook.office365.com
 (2603:10b6:5:3ad::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35 via Frontend
 Transport; Mon, 10 Apr 2023 18:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.20 via Frontend Transport; Mon, 10 Apr 2023 18:47:09 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:47:06 -0500
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
Subject: [PATCH v13 09/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
Date:   Mon, 10 Apr 2023 11:45:20 -0700
Message-ID: <20230410184526.15990-10-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa20993-3530-46d4-acbb-08db39f3fd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uI9FOduZ3iiJaZSLmz23XTT1UsyGR8PAHV1x9D3cH1hoZnrAsORD8AxZC5ybtUHfoTRd2tPUm1NwwOuZNEHnNw6Um9Z+or0UjETXbqj5wkSP4dTye/R1lpYdr8h0Q8aw4D+RP2e6npZRtGdzWv/pSlcEnzjb484ywk0r8qDl2bMx60LqLzrakTFAu2e8/3TEiV9bauXPev3Vdk13gXXPf4wvR7HS8449QYKdhS+Xrq6rfjBlrjvYQ4ucpJRT68E0RG0BMbvwpySHixcK2I6Sooj0wHhtKGX1qEtNLGbI7Jv/GWQ4QnOSvFZX97sd4q0v6s4mOHPMsd8jQ3owg55+BESoaF/faFAXNuFyXP7UIvIEX7VvQdjMsy5Scsob7d7GbDmvn1yyIEQeIt5vaPmnvkamUfCvAxvu06dB1jqp1MoU5pCYsh1AHyQVFtA1Qp2eNpE6BtmhhYHEUfTER8z06vgz8GqnwyPoi38NkdzSsTJa9/QqRHflZOd97vmBdeD0CQv2Djj3gPTtRrAA3FjADiju2Jl1W8QPDyw2HdMpLD7AnjBiBBFM0IYBoh8YZFJSXHgd0ZT2IOhyfIsA10Oucw0Zy89bxJZwH6Qqc9sWdVFBGQHyI4rY7zXU8fMNqHIHlXiqRjciWn+NetN18BLQHdUEgyE5aQpdXOvElsw2EkXdGDxeDVCanSSzqlby8erGUh1Wr8+VnaG3L3UlakNBK76DmrDAlZRZl67rNTJwC7o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(6916009)(8676002)(316002)(54906003)(70586007)(70206006)(478600001)(426003)(82740400003)(186003)(36756003)(26005)(1076003)(40460700003)(47076005)(336012)(81166007)(82310400005)(7406005)(16526019)(356005)(4326008)(2906002)(41300700001)(6666004)(8936002)(36860700001)(40480700001)(5660300002)(7416002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:47:09.5508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa20993-3530-46d4-acbb-08db39f3fd85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

