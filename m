Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC566D8FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjDFGyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbjDFGyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:54:20 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC85BE;
        Wed,  5 Apr 2023 23:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJD5J8UsqRQ9iN4YREn9msw+1k3Qf9qipZ26fELQyplewefF/uTaeiAHNExQ7hHT3dPP3BltRhMzKGLop9qJmwUSLvp4r7feyQlpMC5GZpqmz01fW63cqUFCM4rftMxrrNGSvmeYTKTj6MQCrFmrD0uqVz/Z0aeJRQbGEIe51h6DUIU2RGQNFCQi19C9HVuKie48OsLpmiiPnlA8IbrU+TcqYW+nblGSRqNL7fmLP/fnZKaXZ3xJKvsXAex+0O0mQknsteNeRLamUnGpbAxrwi3s7YM6I1D5bunMkTB8zlkpp1fkOZ4R276YFkOyB8L7TDlvcwN4IlyZ56arDC9ADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5KdSSDQ2nsI2TY2AaFPPmoyVvEQ1ALcxSgb22XsW3Y=;
 b=Pnfu7dA8PHsog7dxFEdU2AsIAFICcQ+5R/CEualA3NxiM7hBcfrwt4XSYiFeFru0i0CajcsnnquCsq1PRHCfhQVKA5kX8A69AZXzGyT95FlL0bTh3xJoY/XCSgO8oWd8ifFJbLxmHPts96wxGZ8HtiyZZH09mYeR6X8wKJW5vroBCpy1CynaCspaXPzz5P0hGFTN2QPrCwTsOVZ8KtRBW/xAvruhI53vTFPmlbyqBQP4QwYKNUq7svmwArC7a6UDk/nJNM/HZqKVIL/9fekxX/sbLA+qWsAKSvdqW8DvxA+bARgQNBG359I314Og9CoQ33ndx6hslPerSBj4rpTeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5KdSSDQ2nsI2TY2AaFPPmoyVvEQ1ALcxSgb22XsW3Y=;
 b=nBEVKC/miSDbefPBi8Z6RADLZQFO3Mq/R+0exA6H9t7Vpyil4BU1ZVL7KQ0imaNk7SPUKNXuAyJsAmNlnywcIEqQYIoKzbAmGd1Gnk3LeMzeePGmIRq58SbUQxENCMvmN5IwDNNC+Ozgzft5ShDQxLfw0YmZL0k/0K5jSWxzxtA=
Received: from DM6PR02CA0100.namprd02.prod.outlook.com (2603:10b6:5:1f4::41)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 06:54:14 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::7) by DM6PR02CA0100.outlook.office365.com
 (2603:10b6:5:1f4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Thu, 6 Apr 2023 06:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.30 via Frontend Transport; Thu, 6 Apr 2023 06:54:14 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 01:54:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 23:54:09 -0700
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 6 Apr 2023 01:54:04 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <git@amd.com>, <sbinding@opensource.cirrus.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH V7 5/7] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
Date:   Thu, 6 Apr 2023 12:23:34 +0530
Message-ID: <20230406065336.10980-6-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com>
References: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a67b598-4707-44e0-8b5f-08db366bbc21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1sMKOV80HDU6ZZ1rSmywQ8stj4iuZRpLh2ebhqbqP/IzRegsh/b2NMgzl51wHcosH68yLS+SsBe+tSqEqO7o3y77dRjNO9p6J2+QdhVqhV0VzJRqkwoNvZQ37b/Xdgl5d8FzsDefHouqzcSZEkguB43wREF7vjCBzBD8hWok4y8cK6DDkkxQ2HvrGXXtRAatJkLShao3i78D3trYBpLZ+5DqQkbSrp3QOu74EBIxWt2KO6nVRyJgNkHmvNlT0u4WMIK7ahYDo3R+QSEDO3YRDBqYuwIO194Gj3BvXquklyN4R6K+ApFZnDkVi93p4aLtFxUrP3So2wjJG0RWvANrbtsXfRNMiZ4Vr15oKFbJNhfzBxz0ITrxw/uVwOxrv/8YM2J1Ft959zi8daWq2YeE55YegqSaIrrutSzGBZ07Ndw7r+Ryo4Lb+/A0uYrZS47m/sM0QaYQBvPlvuoKWoQ2BtIu2LGhkztg9oMG/z3cCYg6sX/a7XmgWJhG6aTRFQyVtyury5dY9uJ1AMb44wpcyKDOzD7cDet1YxF4NvyMIMESlIoapJXx2TjTX6B1pMGzNmp9Vw1DlBtMJX0xntaU5Lp0teZIz2G7CYIhdqi/uMzXG/kqzJAQ6pvEHzl5BkDYZyxRefB4YIaHTh9zx/SvHrC47L+EuB6/DuI/iYSg+6H0Xz6lguhw2NQ1vp0Qtdj+nkuo9mlhdRbcXnl2bgnKyzn65wMX1oowz1U+qV9rdjfMejWTegbFm5/5Kkz4mOAT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(2906002)(82310400005)(40480700001)(6666004)(2616005)(47076005)(186003)(83380400001)(426003)(336012)(26005)(1076003)(478600001)(4326008)(8676002)(70206006)(41300700001)(40460700003)(36860700001)(81166007)(5660300002)(110136005)(82740400003)(70586007)(7416002)(316002)(54906003)(8936002)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:54:14.7991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a67b598-4707-44e0-8b5f-08db366bbc21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GQSPI supports two chip select CS0 & CS1. Update the driver to
assert/de-assert the appropriate chip select as per the bits set in
qspi->cs_index_mask.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index fb2ca9b90eab..3d2b92a88e8a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -156,6 +156,9 @@
 #define GQSPI_FREQ_100MHZ	100000000
 #define GQSPI_FREQ_150MHZ	150000000
 
+#define GQSPI_SELECT_LOWER_CS  BIT(0)
+#define GQSPI_SELECT_UPPER_CS  BIT(1)
+
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
@@ -467,15 +470,17 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 
 	genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
 
+	if (qspi->cs_index_mask & GQSPI_SELECT_UPPER_CS) {
+		zynqmp_gqspi_selectslave(xqspi,
+					 GQSPI_SELECT_FLASH_CS_UPPER,
+					 GQSPI_SELECT_FLASH_BUS_LOWER);
+	} else if (qspi->cs_index_mask & GQSPI_SELECT_LOWER_CS) {
+		zynqmp_gqspi_selectslave(xqspi,
+					 GQSPI_SELECT_FLASH_CS_LOWER,
+					 GQSPI_SELECT_FLASH_BUS_LOWER);
+	}
+	genfifoentry |= xqspi->genfifobus;
 	if (!is_high) {
-		if (!spi_get_chipselect(qspi, 0)) {
-			xqspi->genfifobus = GQSPI_GENFIFO_BUS_LOWER;
-			xqspi->genfifocs = GQSPI_GENFIFO_CS_LOWER;
-		} else {
-			xqspi->genfifobus = GQSPI_GENFIFO_BUS_UPPER;
-			xqspi->genfifocs = GQSPI_GENFIFO_CS_UPPER;
-		}
-		genfifoentry |= xqspi->genfifobus;
 		genfifoentry |= xqspi->genfifocs;
 		genfifoentry |= GQSPI_GENFIFO_CS_SETUP;
 	} else {
-- 
2.17.1

