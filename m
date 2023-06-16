Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BB8732A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbjFPIzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244917AbjFPIze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:55:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6136C30F4;
        Fri, 16 Jun 2023 01:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElxdEKjMXuGKZ6umIkL9h3f+uqny6POgRMJzVCGlZ0cAMhsiid7+5zt64qCDjyQhMPEfiTDgH0ry2zQfdXVGlXBy1GoBRwPcfvylurj6+waqaxtL7m5DANZtvRXym1kwHoxq7g0DeFxzDNCR6HcLr170THbw8m3BhQjLm5tGPamm0rBReBnUN+vYK+58wccIZnczuFIGrdG36JhKvoImcdKW01zP1QjkQ//Vvb+LOweQgTvrqYYu83LO7psSLzeuC7MgZ+df4w4NUKqyZB3mKyTe+bxKCeQqiBYRupLozeKu2jcbl8jG5OfAqptDdrbHemY6PQTw32Hjs83RX7nswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUcwvPSeNEP61TNBLUnxBRn3FCI9LfPRUN4FULDF3MA=;
 b=WqkcyQyuCr78KI8s8kr3z5reJoHLKy9+akE2W9WQ5dEhGymHA/ukd57Yjq5Y1rQLsEbwJAw6QLLI/11Oj8I4vdI8VCXLVzyN2mIRyGqZTVLFmA0D4CJL60h8/o9RvM3tUUVaKtCn8BybOTALjn41mYQCtUcqz09uFt844RmjJRxBWe4eENzAmIaetBYa68jisBj/vdwtwNaHtP+0017pt6b/KLKXI3/15bOvbGYv0iM9GKCBi5BsP8gUPwcmrd8GhAwyCcX1XQstcc6kPWUsNuSEQ+lwc4z5fz9KQWYUTbsWEX4cJSfBe8/NHD2xsYIAHlGXxf9oXLURDcEzQU6I7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUcwvPSeNEP61TNBLUnxBRn3FCI9LfPRUN4FULDF3MA=;
 b=KphZIN8SgWZTY00n6oQaWFIqdFassKMleuXn7VMSz32BfyBqixz2rWEqH8LLfOk+RZ1P3bEikLuej+egb6JK3knAJmWOV0KXTF3y0KNsNQt/UbilNVCCe2DJtKRN2BsQh/ApdHlZYGiWjZo23X2Lx1Fc6l0EKOiGPGuJcfH4pTo=
Received: from DM6PR13CA0016.namprd13.prod.outlook.com (2603:10b6:5:bc::29) by
 LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 08:55:30 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::d2) by DM6PR13CA0016.outlook.office365.com
 (2603:10b6:5:bc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.11 via Frontend
 Transport; Fri, 16 Jun 2023 08:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 08:55:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 03:55:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 03:55:28 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Fri, 16 Jun 2023 03:55:24 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <git@amd.com>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v2 2/2] mtd: spi-nor: Avoid setting SRWD bit in SR if WP signal not connected
Date:   Fri, 16 Jun 2023 14:25:13 +0530
Message-ID: <20230616085513.17632-3-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616085513.17632-1-amit.kumar-mahapatra@amd.com>
References: <20230616085513.17632-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fd9a29-cb37-47a8-3d8e-08db6e476fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2xxJWOOph0QicVAa+eJDJzXkUp/JG/R27St2wuCyhY+sbKEqjMz8/R7jC4YhmXU2KtLqa+dmzV4KX/268zL6oC0BJ8LTPdfzUyHsu3jrgX0EzDlkRAadBmHY6hY3ysbZxOFkV0ntyIpqFH0c9gGAvaRgz000mU6KMg3vz0GPa+tQym1aK2Td37XNQuITJrXttz7axDAK5wM0p75Gg+Ss9Gh8jUaawL3xxVm7h/Tt54lmRoX/pbVfjp4tDNd+dMQFaqQ013ok8CywyNu7wPQof9DP9effFj+nRJwt5aA/0naElCzR05WH22VUSZPfZVrZiXCiNtYD83TOEpz53PdxTw6E/1ZBXFAovvQc0pH19agmjxFJUnUdC9VXihcyS7Fxx5r2tTK6IDGD5TTq6Ze9dJmQOU9nkKVvnVHxXlcAOMX20i9YTiuaxv8BDaN6PsXvI3m5X5IFaMnVVrAT3Fe9yasjTejWKqkSvxCzbShrDl+Lc07KbOZEhhaqp2syS87YTbLnOtGJo+B6A+HOS2kqBk6njBB3HFEMsUzqkRFvTHzFYXn9LiQSakSJFWgCAILR5LfGWX/JCuZoum7+YMw8XL8b75atK8+DpXrhkkaoAMFXo21ak/hh+pLIRLjknLkB8LOUKyPd8Z/bYRvw9xGC+UqjG4qlDY9lgwX2gUPwHkSz4T+0RVvWs0iXB1gDOfHnmuqetmHRfv9CbN7sV1E9KDkpKjCPMmnjATKiC66ngPzmn3UUZwkEeeWgWnerwfuBghzWzI2+Vxr+1QvinCwQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(82740400003)(5660300002)(81166007)(356005)(336012)(2616005)(83380400001)(1076003)(426003)(186003)(2906002)(36860700001)(7416002)(47076005)(26005)(478600001)(40480700001)(70206006)(6666004)(8936002)(316002)(8676002)(41300700001)(86362001)(82310400005)(36756003)(4326008)(70586007)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 08:55:29.8959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fd9a29-cb37-47a8-3d8e-08db6e476fc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the status register write disable (SRWD) bit in the status
register (SR) with WP signal of the flash not connected will configure the
SR permanently as read-only. If WP signal is not connected, avoid setting
SRWD bit while writing the SR during flash protection.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/mtd/spi-nor/core.c | 3 +++
 drivers/mtd/spi-nor/core.h | 1 +
 drivers/mtd/spi-nor/swp.c  | 9 +++++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0bb0ad14a2fc..81b57c51f41c 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2864,6 +2864,9 @@ static void spi_nor_init_flags(struct spi_nor *nor)
 	if (flags & NO_CHIP_ERASE)
 		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
 
+	if (of_property_read_bool(np, "broken-wp"))
+		nor->flags |= SNOR_F_BROKEN_WP;
+
 	if (flags & SPI_NOR_RWW && nor->info->n_banks > 1 &&
 	    !nor->controller_ops)
 		nor->flags |= SNOR_F_RWW;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 4fb5ff09c63a..6ac932eba913 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -132,6 +132,7 @@ enum spi_nor_option_flags {
 	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
 	SNOR_F_RWW		= BIT(14),
 	SNOR_F_ECC		= BIT(15),
+	SNOR_F_BROKEN_WP	= BIT(16),
 };
 
 struct spi_nor_read_command {
diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 0ba716e84377..5d91f152c2cc 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -214,8 +214,13 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 	status_new = (status_old & ~mask & ~tb_mask) | val;
 
-	/* Disallow further writes if WP pin is asserted */
-	status_new |= SR_SRWD;
+	/*
+	 * Disallow further writes if WP pin is not broken. WP pin is
+	 * considered broken only if the WP signal of the flash device
+	 * is not connected.
+	 */
+	if (!(nor->flags & SNOR_F_BROKEN_WP))
+		status_new |= SR_SRWD;
 
 	if (!use_top)
 		status_new |= tb_mask;
-- 
2.17.1

