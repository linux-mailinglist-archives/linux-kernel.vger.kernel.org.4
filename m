Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CEE6AB56D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCFEKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjCFEJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:09:51 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6E81115B;
        Sun,  5 Mar 2023 20:09:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QErwMjSigRJ36no1A+PKdSFjpxki471UAMc/3Rxxv/vuYl7xuv2wVocfa12vQLkXmeb5LlmgRrhDmTxgkaSU6xFu6RdtB6sAHCMdauSbNr2tpwzvH06LVikQSrdE1ViFhR3SRAPiEfqof9g54ECg2DDtc1Z+DO/6OX42/Ybvt9l62osMHgWSaDUhfmKmiHUDXTx1sLqDOaaW8H+AvJfEtkf00K/c1ek7988k+WmM8yrOJW9t4S++W8zc78YR1/94EE8hDN1jaHATu9JoBPDHRTG6i6Zvj1cvbPqD7Ql4bA9NcEuuR4AtiL85bLTqrAPqWY1/oqlyRJwezE951F6EWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpnIb1O3iD9+RUSdP9aH5CNIYVv5t5KX4+QyjF/xBm8=;
 b=auMxz5frSmIy9Ap7ajx9+VhpfhPV/anCp/9FkyBlKFD3vA6nDZUZGz++r69zJZ5bfyZa18GmG5Mc9WlIpreY635BuXQAh7SFdLnsz2efYXoZOGjBTdcCnIManiheWbcrzNz4flgIJrqY10dHtu+ev3OEEkJagBBA6VCOAZvSwqkRdYkSbise9tmlfS3ynPmkpR/Dh5ebiS/OP6I6/GynwUQW1MGwA4OOWbYph2BIF92e/MQKdDP0njZEDrKmXGrOpMUPOBfKBN6/ll9XGLvP765yhZsCMc90557NjcMC49v/XGVcxB0v5bFj7/rUS7JmyGThrsgZLhYFfYWJmjrmkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpnIb1O3iD9+RUSdP9aH5CNIYVv5t5KX4+QyjF/xBm8=;
 b=3iwZZPylWwQd4EKiDO5ljJgqGeViNJShaJ6aGEjtvTCBoLQRF427dor8YWlfr8DqiHb3WrED63nNWQgCZbNz6JxktDv0ZV3ZB5z4qWVX0xOpmpdaXW44cpHe7oWaGN5okOp9NNbwXcV3Q3xd+jzAb8TNU59pdUPRb5kr17LdQ+o=
Received: from DM6PR07CA0061.namprd07.prod.outlook.com (2603:10b6:5:74::38) by
 MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 04:09:43 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::a6) by DM6PR07CA0061.outlook.office365.com
 (2603:10b6:5:74::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 04:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:09:43 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:09:39 -0600
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
Subject: [PATCH v10 09/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
Date:   Sun, 5 Mar 2023 20:07:33 -0800
Message-ID: <20230306040739.51488-10-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 249ddea2-1c2f-4bec-59b5-08db1df89d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4YyyQZvqn0nOU6KfkG2zLLmg3/a4MU+DIbop/X6FngkwFw2vcgFXgDTBK0tuQK2fF9gc4yvdDnlMzZ8VwSvvJC95Dh5B1HPMlv4axiOTsybhaiYbSXfoRzHF8yvGxrXx4b6oqSG0oULEK3y0y6IJRpomqQsc3tys7TlkyfxFph/fvAZ2Quh2XbY7RhtaTCxV/1R2oOlwrbbi0uAtwku3WYo8+AMolEdGA+Yv/Ph6Fq0JZpAXAEejVr0mK+MHi/aub8S4joeUcpkqJchC7mElXBfsy67eRTyoqlI65Pi0glmjLbjDhUvX8hwdLLj3jEqHLLm328HxvdrCIq+d+AvgFF+ReculHTJlylQ4Yy/dUEhqKFy3g2y8hSzOZ/44DsAkoRIGCzxbFjbvp0/+txoYOQGZSLErlZl4iO5XnHun6Mgfwiz0gNkVAKn21aPo4D7aLKc8Lh6zHlBkPzvuCG8Boib5PuWBb6fabxjW9nvy11QTaPhXnmYI0eX/iSQ6MvSLybvnTxORbMzuSl0lnEYuYFFBirARJr4yZd82nPsgww0/G2exWh9HnD3BiLp7JPoiFXk3fm8UuJ8Lzw6wyrbYch/ulma/DeHZgZfSFY5cMxZHcKzQVbQSRC0V+UCR/mVO3ci5HP1EHC+8Uxi+XNBAZ5VtWUmxNZQo26YWMSGEcl/8Mr/KVn29uxtq4fLGFWMg9mpdn8xC8Yj64CwvgrFoqbHkoOXXckXaClPZyMObl0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(36756003)(426003)(47076005)(82740400003)(36860700001)(6666004)(1076003)(16526019)(186003)(26005)(336012)(40460700003)(2616005)(41300700001)(8936002)(70206006)(70586007)(40480700001)(4326008)(2906002)(8676002)(6916009)(7406005)(7416002)(5660300002)(81166007)(356005)(316002)(54906003)(478600001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:09:43.1773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 249ddea2-1c2f-4bec-59b5-08db1df89d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
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

