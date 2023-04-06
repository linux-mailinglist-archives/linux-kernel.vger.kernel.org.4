Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6085D6D8FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjDFGyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjDFGyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:54:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD78A68;
        Wed,  5 Apr 2023 23:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQt3dvuL1Ew75FOMzTm+rKhdF6camaw2g4STMgud/NK9LgYVTgseW9UJ2C6fWPqwMRv3ApqPxMSIVYFGUxd4cHNVmWu+Lpj2Nqo3LtnBZ/eNHSdjgdeVI6JVVyfgK2yWRw6h1HVDA4LVBhaJAM/LRspGv/a1/pZb7ROuvSgg48ftSVyzsjaKQBsJ8Gt2bYXMe3bP1i2O66aEIuQeAAJQybjxZMZyAFKopJ6+m40gMmQ6z9R92eb5Xdx8kuQXDv+V+t9GawBu0fwzXvI0C1DRAXzn2pIszQJbIdR4sjshc+r/gqEVB15aPQdsiClaiVc+hNHIxh0GRTkkuqOZ8DnZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFdPC4H/yFm8w4hdcbiaqBt469txgayvPinEtD/egWs=;
 b=ntUxEHLBAVt9p4xsAPxAYh6S+iDzf1VGj8E9Rwb8FrziUV8iwQuIXGdHj0TvwB+n9zL+m6JFgpaMf43qI1XpPRL+oVcuaVVsVxY4zUnVlND7txSpD4WWOn95TkSOnnjxA0IH8ddrvr670Q6nYE6du64fH3ndanST5QPo1zi2ZumPPjgkk+MuNi51vK++DJBtvMC7WIg3M3qmt1gWdkdBNMzJ8CL3pOl8Q6BhKf3Qpbc8/cNHGUlzN76643NUS/iQ9ePGJ3NzCsgAD/8lr9W9ebjmPvfLVGbIRCHwvf8vtPf6t6MlDjAr6M1X7gyetk2m+PcBig3YY0jQ/HD4vY8PXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFdPC4H/yFm8w4hdcbiaqBt469txgayvPinEtD/egWs=;
 b=gtDcP8M83JQRErvG6NMqNdEyrFqDmN8zkpGtgdF6z0qC/baphMwTilQmLmvgKd5ra6y6o5tf1JX9S3klYQbsWf0IrLrhEce2aMtEnCgnFUAFZ8mbX8W0Gjt1nmTrCBBQb2nWnTvlw7Qt2sDyt7/2O8t0ZOlApzQ4x3FbU57ydfc=
Received: from DM6PR02CA0098.namprd02.prod.outlook.com (2603:10b6:5:1f4::39)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Thu, 6 Apr
 2023 06:54:12 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::e0) by DM6PR02CA0098.outlook.office365.com
 (2603:10b6:5:1f4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Thu, 6 Apr 2023 06:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.30 via Frontend Transport; Thu, 6 Apr 2023 06:54:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 01:53:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 23:53:53 -0700
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 6 Apr 2023 01:53:48 -0500
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
Subject: [PATCH V7 2/7] mtd: spi-nor: Convert macros with inline functions
Date:   Thu, 6 Apr 2023 12:23:31 +0530
Message-ID: <20230406065336.10980-3-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com>
References: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8571ef-6a74-4152-e21d-08db366bba6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxCpxLlYiq+m17BeLGsibaou7Dd+djoS8cDbxoUgg8DgcEgLhAGGTc6DCUDOinecnEOpK+zvOpDxSWGICI01UpsrRaiBYY6ScSQBpla5YHYOOKS1mmFle6jMzvD5k3sl0huVQEln+tHUFz467nXbiC4XHXDegSUy9AB1gJArzasTd4Bh0XjRifQxAiatge/V2OicTyr9i4TyBjd3m2Im1jCzILpNEcNBvw0vLBivvbQrIqIMdEw5G/gWyztxs/rU/Ul4RzPTDpwleYQXKvWjnhqCMiCp+FKAJ36YAQU+I1StswCbnUKert8YSPUTqWSsytvYcQ3DL14l0/lJqo/bBULgWzh9+PJyTY0Fv+zrxEEcMRsWPJxRgcNTumbXsaAlNxfLdiIO/+AgEUBgok3ubsvczhP/MADvpgPoraWY+mEd51ThhtebxZ7IRRJyyUXQrXCQS/x5seWqmGRrtTZ6irQmkWHK8PJPY1YzFQhSPC6oPQfWKUyyHNOaid1Rsduwm1QaG65eo2yG4Po9TcQL7WePk0cg52gVTxxJICc7h3lIZ9sqn0lFkOnu42Bt1+jzjbzuE3xZdoj/JpCbui1pvh83NkbsNPBALiy6yXwd6vyYlTy8q6rySucq2yniVOy+kWciSXjt5MVN1UbroHSLwvy/hgrAPKuf/OCmJDzGd/XENHmQ5kmdRvl5ncotBOq5Gv9vvRZW1IOkxw6oSZAoNBkwqQH5OPGR+ykwDyAecio5yZEaeQCUjiyKx6jVkSyc
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(36756003)(40480700001)(316002)(6666004)(4326008)(110136005)(8676002)(70586007)(70206006)(54906003)(40460700003)(8936002)(41300700001)(82310400005)(7416002)(2906002)(82740400003)(478600001)(36860700001)(356005)(5660300002)(86362001)(186003)(336012)(2616005)(81166007)(26005)(1076003)(426003)(47076005)(83380400001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:54:11.9243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8571ef-6a74-4152-e21d-08db366bba6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In further patches the nor->params references in
spi_nor_otp_region_len(nor) & spi_nor_otp_n_regions(nor) macros will be
replaced with spi_nor_get_params() API. To make the transition smoother,
first converting the macros into static inline functions.

Suggested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/mtd/spi-nor/otp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 00ab0d2d6d2f..3d75899de303 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -11,8 +11,27 @@
 
 #include "core.h"
 
-#define spi_nor_otp_region_len(nor) ((nor)->params->otp.org->len)
-#define spi_nor_otp_n_regions(nor) ((nor)->params->otp.org->n_regions)
+/**
+ * spi_nor_otp_region_len() - get size of one OTP region in bytes
+ * @nor:        pointer to 'struct spi_nor'
+ *
+ * Return: size of one OTP region in bytes
+ */
+static inline unsigned int spi_nor_otp_region_len(struct spi_nor *nor)
+{
+	return nor->params->otp.org->len;
+}
+
+/**
+ * spi_nor_otp_n_regions() - get number of individual OTP regions
+ * @nor:        pointer to 'struct spi_nor'
+ *
+ * Return: number of individual OTP regions
+ */
+static inline unsigned int spi_nor_otp_n_regions(struct spi_nor *nor)
+{
+	return nor->params->otp.org->n_regions;
+}
 
 /**
  * spi_nor_otp_read_secr() - read security register
-- 
2.17.1

