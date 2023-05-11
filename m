Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5645A6FECDC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjEKHcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbjEKHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:31:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8797DBF;
        Thu, 11 May 2023 00:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY3ts4ZSpOpeV4EMXBe+8M+OzbbHeJSE4zjW2KFH0Qyh1HSEsiJslEGzko1OnHIQlakf/CVtS62IFpRArrTLu1uUh04HWoERiEXRUqosFzmma/aO1vsAdZfEknpx8Y0/dfaBMXLSOrRtzyHTaArYs+3JeP451VdeavYhv+ceDqXLGsCZPi3h8aNeqI4TplX29SXdkTJ5vPivrsa+v3z8uVv01qDAZtQfquIA/VQl7UsFspZVaD+g62tNge70MlYJSwSXleS693yIXe2VjR91Aeb2x/ZzRCe1e8KcPRCZezN81k9Ac8/M9pTvMIxcURiv164dREiLtHMXYU7OuIl4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5mqpHnfYMEPp/K3f3bZgmug97OgZD/HN9a0e4dtXkU=;
 b=i0K9yB+NZnwFOtT7KEwxUEZ8LqdtL4TncN1WvpdDOUyf019GKgLMGlbtjhKj6xyHhWC4NZx67eQSwaX1Olbn5wXHEk6/nnCHo6/eh+zfGuuqowMqHhV6EOhYyFgQV1wxb+a7RggDI8T6Vz8reMyyIiG6+wXf0YwRc34CtcyoFxZU4NX/7svaG32z8Cc8l1O9Z5VuitT1xkZ3RHcyg2o0EysK8Pia+SkCRZphBzcWczM/IwgFPyYj7H8ApdEzl3BOTagjdMAlx6iPLYuXZbotHeD5aGsNvzezwG9n+C8jr58A015+8z4MkG5SS9GG7OT3A0dC4H8pnvV2OAcw/GsxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5mqpHnfYMEPp/K3f3bZgmug97OgZD/HN9a0e4dtXkU=;
 b=LXTy9jPsm6XgpFUZCpvulgic7LKy+XA7vJVuFGlpGn8hhZKGKc7VdeRf4SgbYF9lsyN50NssoAOT0zftNQSKrOpXAqBi/VZi+B2VQ9cjonNDoC96QV1zfU68T5DB0/47Rwi1WmVhH4t4PMrmCbRfJmA0X56c0aa4hFrJfJurGAQ=
Received: from MW4PR03CA0240.namprd03.prod.outlook.com (2603:10b6:303:b9::35)
 by BL0PR12MB4996.namprd12.prod.outlook.com (2603:10b6:208:1c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 07:31:53 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::97) by MW4PR03CA0240.outlook.office365.com
 (2603:10b6:303:b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21 via Frontend
 Transport; Thu, 11 May 2023 07:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 07:31:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 02:31:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 00:31:52 -0700
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 11 May 2023 02:31:47 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <michael@walle.cc>
CC:     <sbinding@opensource.cirrus.com>, <git@amd.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH V8 2/7] mtd: spi-nor: Convert macros with inline functions
Date:   Thu, 11 May 2023 13:01:29 +0530
Message-ID: <20230511073134.41180-3-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511073134.41180-1-amit.kumar-mahapatra@amd.com>
References: <20230511073134.41180-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT030:EE_|BL0PR12MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: e96a6a92-c115-4d46-3dff-08db51f1cad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UgscT75HcWclaA8ySCls8Pc4Dk40hyo9Khd4A8Nvep/wkf9Ud+s/ILV1PnlRcG5FS41WsZKhG4xpv1gW6RJTVMLmbNt3ZXsacFOq1gv+X1p5cjqe2NoILpMhWqBZrRWKzvRKZF9RtWqaWvKj23l7TmqhN4RJSuHFurlSwjpyFn9LzQ9k6tODWL6HM8e6OndD8AOVxNiSjzPNyqI4B0rNW3c7/yvbBvFbCtGEJs6pjUIOd0G5+cZC+mPJYcrGBt+9JCT9qylQy350+8KR6Q/MJgg60Aho29S0lONeRUfbdzTKIu3gygG+bH7+ZUZM0NeCiW4DF8k1SXGhLzAxRIMS9gfMC422HZWSL0OJjVgZ823iSkqSGIG8ZpHSEmOfynnD6i0OS++v6k1kvzRetTwwuLkfC1eAPiPtYvW9Tl+/63l41VTnPVs0zo8WBvej1lvDCTV4uUNws+ANOzREDoEoe4ch/jN501sOsL8NQ/TzE7spENxMn0xGBLGk9B2oczCtMzHvL0L9OMRk5Kjaanu++KxiPg+Ug7eH0C/q1GifmxuGOZOxSKATdWTGCLN1lyK0XiU9bKlAOiFSLG2BbpviXIOm5F2hvmAqmMjLQiVyO3s35GMG8udo2GSnhp4r59Ae6YU4GhwSTw4JT9/ANNswMJo2itnyZp3ykNTU6M4roR4AWf9+u6nbkkSxl97+Qe7BgfvFbOVT7LWlvqnPKX4bh64HLvoPbPKzUX+il6Lx93g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(4326008)(26005)(6666004)(316002)(7416002)(81166007)(41300700001)(356005)(82740400003)(110136005)(86362001)(1076003)(70206006)(70586007)(54906003)(8676002)(186003)(8936002)(2906002)(82310400005)(36860700001)(36756003)(478600001)(40460700003)(83380400001)(47076005)(426003)(2616005)(336012)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 07:31:53.3082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96a6a92-c115-4d46-3dff-08db51f1cad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4996
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 9a729aa3452d..23fe75ddc9cf 100644
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

