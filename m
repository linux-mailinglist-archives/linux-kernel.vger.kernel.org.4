Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A75A6D8FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjDFGyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjDFGyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:54:35 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D96E9749;
        Wed,  5 Apr 2023 23:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBOzzbiOuSiz7QoB4qEXIja4Me2OxQ5WZAIarQiPqj2gsAPb8LQYjMfovdLOuHbhjcYFREUfe8gDrXyB7DrdeQVlU/+SNez1x+SfeT7EKjdfKU8XWmHHSjlKAizc2EyorbwS86B4sQ/5qQZtt92AqDZg2St8qpMJvBSIfHqun++RnFFHAMpX9NKpxZWmBX/PT62jm4PMxsw9y4hDS44o2dw9kAq1eZgyCygXgD/lBYg8iRLUSO5/XTamMRIOyYiyqG68jI82ymYDtKXFWZs9FziWbpex11gKi13BbWsaEYj5jDOJbeRp4R9Va4YeH9swy8CDDzq/qDqzkG8hDRUkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10fu7ZZd0l92XvAWoJHjN6HGfEBScM7nngeHU9oviG4=;
 b=CirgwLeovH2UzlVYrCanREwRjZrXlJkJpfsq8DQpQCrFSxMdypGzjc43Uo52STuYj97BSqHcyLdlY3969emYRWbYsj+uXJihioXy9iQxLkhfBUWYoVZhnkAE5sGprU2cW1W66TVN4QVVz8cSTPy67Gi2uXvXQEIKDHzQcEl1hd0PUDa7OtHKbc3LareiJmGq1iPhPb0j8hOQ6hNn0Fq6aqSvEpmsqbNVV1htJpefLrLUK1y4uEc5N2eSRtIgk6dwpQqwSXHU6zZkh8lfo3usClhybCsDNmvZskbpN6DIfagXmpNH2LxyMws3aPsKvXL2dT9f8QbCIK20YfB5B6g/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10fu7ZZd0l92XvAWoJHjN6HGfEBScM7nngeHU9oviG4=;
 b=Vhq3XFw+ii4yAWZsDdojUgDLV5KQN7gqWCa3wN5oFsuCGQ+mkRyQ1x38WOr/GoU+3xtjELYYhB3S2Wwp3r9P+0kuZp+klEt/d2YXQPkTwLP0dBFh8bI+1Lz3ts1EeL4Z/UuyjSlutGqYw8Hx3T2CRd+nq+Ed1NVXRtYHKpK4dFE=
Received: from DM6PR10CA0020.namprd10.prod.outlook.com (2603:10b6:5:60::33) by
 CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Thu, 6 Apr 2023 06:54:19 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::89) by DM6PR10CA0020.outlook.office365.com
 (2603:10b6:5:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37 via Frontend
 Transport; Thu, 6 Apr 2023 06:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.31 via Frontend Transport; Thu, 6 Apr 2023 06:54:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 01:54:14 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 6 Apr 2023 01:54:09 -0500
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
Subject: [PATCH V7 6/7] mtd: spi-nor: Add parallel memories support in spi-nor
Date:   Thu, 6 Apr 2023 12:23:35 +0530
Message-ID: <20230406065336.10980-7-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com>
References: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: b8833b20-1eca-4583-4624-08db366bbef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uw0aPTovPWUMTnKSB/6v+5y7OTgPWGLOEFa1x0wRSabWWDCZL0CLMjVxtrLSI3tJU9JOwT47EVpat8xmyUuSZXH7eQPA4L84WeJn4EbmJFzzOGyxFmPtA0bernaF6UN48c+rFS3ei6b3rLQzjQgr3y6IjuRYFKvpCbHwo+H5DJ6QBMRtZ5w6mS5PALj45wqmFzKnxBXEgrC2H7fl7++GaxNlTMJ1puP4fDKTyaIsQrb8DKldffgFbC1AQvrKlL8majSWLEqb6fCn7pDZpezRx5hvb39ftTG+2iw1Xqi2sUgfE51jvp1MxMZy4xPLlTowjxjbfTKyoUT/6Z/4hvouRK/VhtJtDf2obw85aAmTEGLbgxQmex0MQi7uat8VgTFKbpQWkE3M63LKFxdHGnXDmbQLJKpZo/7vxfugPXfrNuqHQWYBlRvaQTk3Cb7GQzcIj9LaNcElbktWxfy2A2/qcwNcGIpnqd7EjusnYYY4knfLSOH7RqEg5qjLOJzBu+ZO+fCtEHmVmbWUe1CsW+bRkzcfAmGWObMvxh564w0C5Nd/W6WaaBAltfcUF3vc5qNmeGibPYVOTwtCIkozsXnQaKv0acNwBX8uCUktOI5NJg6Nn8vbCLV4MNx39PKxlyfpQWh1d9rdUv9b91Amkhf2P+wu927COK8b+i+0XFfpx2a2EqRwwWaF995YxdFsQFajbZMH+sDLJ2XHiDXHlIoXyLcdLf8mlrXGEF4nhxr92kzUR0FpWlhwk3c5KWokNOHr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(356005)(1076003)(26005)(70586007)(8676002)(40460700003)(70206006)(82310400005)(36756003)(36860700001)(478600001)(110136005)(316002)(7416002)(5660300002)(8936002)(30864003)(54906003)(2906002)(81166007)(82740400003)(4326008)(86362001)(41300700001)(186003)(40480700001)(6666004)(2616005)(336012)(426003)(83380400001)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:54:19.5421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8833b20-1eca-4583-4624-08db366bbef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation assumes that a maximum of two flashes are
connected in parallel mode. The QSPI controller splits the data evenly
between both the flashes so, both the flashes that are connected in
parallel mode should be identical.
During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
nor->spimem->spi->cs_index_mask. The QSPI driver will then assert/de-assert
CS0 & CS1.
Write operation in parallel mode are performed in page size * 2 chunks as
each write operation results in writing both the flashes. For doubling the
address space each operation is performed at addr/2 flash offset, where
addr is the address specified by the user.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/mtd/spi-nor/core.c      | 514 +++++++++++++++++++++++---------
 drivers/mtd/spi-nor/core.h      |   4 +
 drivers/mtd/spi-nor/micron-st.c |   5 +
 3 files changed, 384 insertions(+), 139 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0bc6b42f276c..18fc4a1c28d4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -464,17 +464,29 @@ int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 			op.data.nbytes = 2;
 		}
 
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			op.data.nbytes = 2;
+
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_RDSR, sr,
-						      1);
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			ret = spi_nor_controller_ops_read_reg(nor,
+							      SPINOR_OP_RDSR,
+							      sr, 2);
+		else
+			ret = spi_nor_controller_ops_read_reg(nor,
+							      SPINOR_OP_RDSR,
+							      sr, 1);
 	}
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading SR\n", ret);
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		sr[0] |= sr[1];
+
 	return ret;
 }
 
@@ -1466,12 +1478,122 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	if (ret)
 		return ret;
 
-	/* whole-chip erase? */
-	if (len == mtd->size && !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
-		unsigned long timeout;
+	if (!(nor->flags & SNOR_F_HAS_PARALLEL)) {
+		/* whole-chip erase? */
+		if (len == mtd->size && !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
+			unsigned long timeout;
+
+			while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && params) {
+				nor->spimem->spi->cs_index_mask = 1 << cur_cs_num;
+				ret = spi_nor_write_enable(nor);
+				if (ret)
+					goto erase_err;
+
+				ret = spi_nor_erase_chip(nor);
+				if (ret)
+					goto erase_err;
+
+				/*
+				 * Scale the timeout linearly with the size of the flash, with
+				 * a minimum calibrated to an old 2MB flash. We could try to
+				 * pull these from CFI/SFDP, but these values should be good
+				 * enough for now.
+				 */
+				timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
+					      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
+					      (unsigned long)(params->size /
+							      SZ_2M));
+				ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
+				if (ret)
+					goto erase_err;
+
+				cur_cs_num++;
+				params = spi_nor_get_params(nor, cur_cs_num);
+			}
+
+		/* REVISIT in some cases we could speed up erasing large regions
+		 * by using SPINOR_OP_SE instead of SPINOR_OP_BE_4K.  We may have set up
+		 * to use "small sector erase", but that's not always optimal.
+		 */
+
+		/* "sector"-at-a-time erase */
+		} else if (spi_nor_has_uniform_erase(nor)) {
+			/* Determine the flash from which the operation need to start */
+			while ((cur_cs_num < SNOR_FLASH_CNT_MAX) &&
+			       (addr > sz - 1) && params) {
+				cur_cs_num++;
+				params = spi_nor_get_params(nor, cur_cs_num);
+				sz += params->size;
+			}
+			while (len) {
+				nor->spimem->spi->cs_index_mask = 1 << cur_cs_num;
+				ret = spi_nor_write_enable(nor);
+				if (ret)
+					goto erase_err;
+
+				offset = addr;
+				if (nor->flags & SNOR_F_HAS_STACKED) {
+					params = spi_nor_get_params(nor, cur_cs_num);
+					offset -= (sz - params->size);
+				}
+				ret = spi_nor_erase_sector(nor, offset);
+				if (ret)
+					goto erase_err;
+
+				ret = spi_nor_wait_till_ready(nor);
+				if (ret)
+					goto erase_err;
+
+				addr += mtd->erasesize;
+				len -= mtd->erasesize;
+
+				/*
+				 * Flash cross over condition in stacked mode.
+				 */
+				if ((nor->flags & SNOR_F_HAS_STACKED) && (addr > sz - 1)) {
+					cur_cs_num++;
+					params = spi_nor_get_params(nor, cur_cs_num);
+					sz += params->size;
+				}
+			}
+
+		/* erase multiple sectors */
+		} else {
+			u64 erase_len = 0;
+
+			/* Determine the flash from which the operation need to start */
+			while ((cur_cs_num < SNOR_FLASH_CNT_MAX) &&
+			       (addr > sz - 1) && params) {
+				cur_cs_num++;
+				params = spi_nor_get_params(nor, cur_cs_num);
+				sz += params->size;
+			}
+			/* perform multi sector erase onec per Flash*/
+			while (len) {
+				erase_len = (len > (sz - addr)) ? (sz - addr) : len;
+				offset = addr;
+				nor->spimem->spi->cs_index_mask = 1 << cur_cs_num;
+				if (nor->flags & SNOR_F_HAS_STACKED) {
+					params = spi_nor_get_params(nor, cur_cs_num);
+					offset -= (sz - params->size);
+				}
+				ret = spi_nor_erase_multi_sectors(nor, offset, erase_len);
+				if (ret)
+					goto erase_err;
+				len -= erase_len;
+				addr += erase_len;
+				params = spi_nor_get_params(nor, cur_cs_num);
+				sz += params->size;
+			}
+		}
+	} else {
+		nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+
+		/* whole-chip erase? */
+		if (len == mtd->size && !(nor->flags &
+					  SNOR_F_NO_OP_CHIP_ERASE)) {
+			unsigned long timeout;
 
-		while (cur_cs_num < SNOR_FLASH_CNT_MAX && params) {
-			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
 			ret = spi_nor_write_enable(nor);
 			if (ret)
 				goto erase_err;
@@ -1488,90 +1610,45 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			 */
 			timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
 				      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
-				      (unsigned long)(params->size / SZ_2M));
+				      (unsigned long)(mtd->size / SZ_2M));
 			ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
 			if (ret)
 				goto erase_err;
-			cur_cs_num++;
-		}
-
-	/* REVISIT in some cases we could speed up erasing large regions
-	 * by using SPINOR_OP_SE instead of SPINOR_OP_BE_4K.  We may have set up
-	 * to use "small sector erase", but that's not always optimal.
-	 */
 
-	/* "sector"-at-a-time erase */
-	} else if (spi_nor_has_uniform_erase(nor)) {
-		/* Determine the flash from which the operation need to start */
-		while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (addr > sz - 1) && params) {
-			cur_cs_num++;
-			params = spi_nor_get_params(nor, cur_cs_num);
-			sz += params->size;
-		}
+		/* REVISIT in some cases we could speed up erasing large regions
+		 * by using SPINOR_OP_SE instead of SPINOR_OP_BE_4K.  We may have set up
+		 * to use "small sector erase", but that's not always optimal.
+		 */
 
-		while (len) {
-			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
-			ret = spi_nor_write_enable(nor);
-			if (ret)
-				goto erase_err;
+		/* "sector"-at-a-time erase */
+		} else if (spi_nor_has_uniform_erase(nor)) {
+			while (len) {
+				ret = spi_nor_write_enable(nor);
+				if (ret)
+					goto erase_err;
 
-			offset = addr;
-			if (nor->flags & SNOR_F_HAS_STACKED) {
-				params = spi_nor_get_params(nor, cur_cs_num);
-				offset -= (sz - params->size);
-			}
+				offset = addr / 2;
 
-			ret = spi_nor_erase_sector(nor, offset);
-			if (ret)
-				goto erase_err;
-
-			ret = spi_nor_wait_till_ready(nor);
-			if (ret)
-				goto erase_err;
+				ret = spi_nor_erase_sector(nor, offset);
+				if (ret)
+					goto erase_err;
 
-			addr += mtd->erasesize;
-			len -= mtd->erasesize;
+				ret = spi_nor_wait_till_ready(nor);
+				if (ret)
+					goto erase_err;
 
-			/*
-			 * Flash cross over condition in stacked mode.
-			 */
-			if ((nor->flags & SNOR_F_HAS_STACKED) && (addr > sz - 1)) {
-				cur_cs_num++;
-				params = spi_nor_get_params(nor, cur_cs_num);
-				sz += params->size;
+				addr += mtd->erasesize;
+				len -= mtd->erasesize;
 			}
-		}
-
-	/* erase multiple sectors */
-	} else {
-		u64 erase_len = 0;
 
-		/* Determine the flash from which the operation need to start */
-		while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (addr > sz - 1) && params) {
-			cur_cs_num++;
-			params = spi_nor_get_params(nor, cur_cs_num);
-			sz += params->size;
-		}
-		/* perform multi sector erase onec per Flash*/
-		while (len) {
-			erase_len = (len > (sz - addr)) ? (sz - addr) : len;
-			offset = addr;
-			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
-			if (nor->flags & SNOR_F_HAS_STACKED) {
-				params = spi_nor_get_params(nor, cur_cs_num);
-				offset -= (sz - params->size);
-			}
-			ret = spi_nor_erase_multi_sectors(nor, offset, erase_len);
+		/* erase multiple sectors */
+		} else {
+			offset = addr / 2;
+			ret = spi_nor_erase_multi_sectors(nor, offset, len);
 			if (ret)
 				goto erase_err;
-			len -= erase_len;
-			addr += erase_len;
-			cur_cs_num++;
-			params = spi_nor_get_params(nor, cur_cs_num);
-			sz += params->size;
 		}
 	}
-
 	ret = spi_nor_write_disable(nor);
 
 erase_err:
@@ -1771,34 +1848,59 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	struct spi_nor_flash_parameter *params;
 	ssize_t ret, read_len;
 	u32 cur_cs_num = 0;
-	u64 sz;
+	u_char *readbuf;
+	bool is_ofst_odd = false;
+	u64 sz = 0;
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
 
-	ret = spi_nor_lock_and_prep(nor);
-	if (ret)
-		return ret;
-
 	params = spi_nor_get_params(nor, 0);
 	sz = params->size;
 
-	/* Determine the flash from which the operation need to start */
-	while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (from > sz - 1) && params) {
-		cur_cs_num++;
-		params = spi_nor_get_params(nor, cur_cs_num);
-		sz += params->size;
+	/*
+	 * Cannot read from odd offset in parallel mode, so read
+	 * len + 1 from offset + 1 and ignore offset[0] data.
+	 */
+	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (from & 0x01)) {
+		from = (loff_t)(from - 1);
+		len = (size_t)(len + 1);
+		is_ofst_odd = true;
+		readbuf = kmalloc(len, GFP_KERNEL);
+		if (!readbuf)
+			return -ENOMEM;
+	} else {
+		readbuf = buf;
+	}
+
+	if (!(nor->flags & SNOR_F_HAS_PARALLEL)) {
+		/* Determine the flash from which the operation need to start */
+		while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (from > sz - 1) && params) {
+			cur_cs_num++;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			sz += params->size;
+		}
 	}
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
 	while (len) {
 		loff_t addr = from;
 
-		nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
-		read_len = (len > (sz - addr)) ? (sz - addr) : len;
-		params = spi_nor_get_params(nor, cur_cs_num);
-		addr -= (sz - params->size);
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			read_len = len;
+			addr /= 2;
+		} else {
+			nor->spimem->spi->cs_index_mask = 1 << cur_cs_num;
+			read_len = (len > (sz - addr)) ? (sz - addr) : len;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			addr -= (sz - params->size);
+		}
 
 		addr = spi_nor_convert_addr(nor, addr);
 
-		ret = spi_nor_read_data(nor, addr, len, buf);
+		ret = spi_nor_read_data(nor, addr, read_len, readbuf);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
 			ret = -EIO;
@@ -1808,8 +1910,20 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			goto read_err;
 
 		WARN_ON(ret > read_len);
-		*retlen += ret;
+		if (is_ofst_odd) {
+			/*
+			 * Cannot read from odd offset in parallel mode.
+			 * So read len + 1 from offset + 1 from the flash
+			 * and copy len data from readbuf[1].
+			 */
+			memcpy(buf, (readbuf + 1), (len - 1));
+			*retlen += (ret - 1);
+		} else {
+			*retlen += ret;
+		}
 		buf += ret;
+		if (!is_ofst_odd)
+			readbuf += ret;
 		from += ret;
 		len -= ret;
 
@@ -1827,6 +1941,9 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	ret = 0;
 
 read_err:
+	if (is_ofst_odd)
+		kfree(readbuf);
+
 	spi_nor_unlock_and_unprep(nor);
 	return ret;
 }
@@ -1852,13 +1969,38 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	page_size = params->page_size;
 	sz = params->size;
 
-	/* Determine the flash from which the operation need to start */
-	while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (to > sz - 1) && params) {
-		cur_cs_num++;
-		params = spi_nor_get_params(nor, cur_cs_num);
-		sz += params->size;
-	}
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		/*
+		 * Cannot write to odd offset in parallel mode,
+		 * so write 2 byte first.
+		 */
+		if (to & 0x01) {
+			u8 two[2] = {0xff, buf[0]};
+			size_t written_len;
+
+			ret = spi_nor_write(mtd, to & ~1, 2, &written_len, two);
+			if (ret < 0)
+				return ret;
+			*retlen += 1; /* We've written only one actual byte */
+			++buf;
+			--len;
+			++to;
+		}
+		/*
+		 * Write operation are performed in page size chunks and in
+		 * parallel memories both the flashes are written simultaneously,
+		 * hence doubled the page_size.
+		 */
+		page_size <<= 1;
 
+	} else {
+		/* Determine the flash from which the operation need to start */
+		while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (to > sz - 1) && params) {
+			cur_cs_num++;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			sz += params->size;
+		}
+	}
 	ret = spi_nor_lock_and_prep(nor);
 	if (ret)
 		return ret;
@@ -1882,9 +2024,14 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		/* the size of data remaining on the first page */
 		page_remain = min_t(size_t, page_size - page_offset, len - i);
 
-		nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
-		params = spi_nor_get_params(nor, cur_cs_num);
-		addr -= (sz - params->size);
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			addr /= 2;
+		} else {
+			nor->spimem->spi->cs_index_mask = 1 << cur_cs_num;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			addr -= (sz - params->size);
+		}
 
 		addr = spi_nor_convert_addr(nor, addr);
 
@@ -2332,7 +2479,15 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 		if (!erase)
 			return -EINVAL;
 		nor->erase_opcode = erase->opcode;
-		mtd->erasesize = erase->size;
+		/*
+		 * In parallel-memories the erase operation is
+		 * performed on both the flashes simultaneously
+		 * so, double the erasesize.
+		 */
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			mtd->erasesize = erase->size * 2;
+		else
+			mtd->erasesize = erase->size;
 		return 0;
 	}
 
@@ -2350,7 +2505,15 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 	if (!erase)
 		return -EINVAL;
 
-	mtd->erasesize = erase->size;
+	/*
+	 * In parallel-memories the erase operation is
+	 * performed on both the flashes simultaneously
+	 * so, double the erasesize.
+	 */
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		mtd->erasesize = erase->size * 2;
+	else
+		mtd->erasesize = erase->size;
 	return 0;
 }
 
@@ -2668,7 +2831,22 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 				nor->flags |= SNOR_F_HAS_STACKED;
 		}
 	}
-	if (nor->flags & SNOR_F_HAS_STACKED) {
+	i = 0;
+	idx = 0;
+	while (i < SNOR_FLASH_CNT_MAX) {
+		rc = of_property_read_u64_index(np, "parallel-memories", idx, &flash_size[i]);
+		if (rc == -EINVAL) {
+			break;
+		} else if (rc == -EOVERFLOW) {
+			idx++;
+		} else {
+			idx++;
+			i++;
+			if (!(nor->flags & SNOR_F_HAS_PARALLEL))
+				nor->flags |= SNOR_F_HAS_PARALLEL;
+		}
+	}
+	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
 		for (idx = 1; idx < SNOR_FLASH_CNT_MAX; idx++) {
 			params = spi_nor_get_params(nor, idx);
 			params = devm_kzalloc(nor->dev, sizeof(*params), GFP_KERNEL);
@@ -2890,24 +3068,42 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 	struct spi_nor_flash_parameter *params;
 	int err, idx;
 
-	for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
-		params = spi_nor_get_params(nor, idx);
-		if (params) {
-			if (!params->quad_enable)
-				return 0;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		params = spi_nor_get_params(nor, 0);
+		if (!params->quad_enable)
+			return 0;
 
-			if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
-			      spi_nor_get_protocol_width(nor->write_proto) == 4))
-				return 0;
-			/*
-			 * Set the appropriate CS index before
-			 * issuing the command.
-			 */
-			nor->spimem->spi->cs_index_mask = 0x01 << idx;
+		if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
+		      spi_nor_get_protocol_width(nor->write_proto) == 4))
+			return 0;
+		/*
+		 * In parallel mode both chip selects i.e., CS0 &
+		 * CS1 need to be asserted simulatneously.
+		 */
+		nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+		err = params->quad_enable(nor);
+		if (err)
+			return err;
+	} else {
+		for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
+			params = spi_nor_get_params(nor, idx);
+			if (params) {
+				if (!params->quad_enable)
+					return 0;
 
-			err = params->quad_enable(nor);
-			if (err)
-				return err;
+				if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
+				      spi_nor_get_protocol_width(nor->write_proto) == 4))
+					return 0;
+				/*
+				 * Set the appropriate CS index before
+				 * issuing the command.
+				 */
+				nor->spimem->spi->cs_index_mask = 1 << idx;
+
+				err = params->quad_enable(nor);
+				if (err)
+					return err;
+			}
 		}
 	}
 	return err;
@@ -2957,17 +3153,29 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
-			params = spi_nor_get_params(nor, idx);
-			if (params) {
-				/*
-				 * Select the appropriate CS index before
-				 * issuing the command.
-				 */
-				nor->spimem->spi->cs_index_mask = 0x01 << idx;
-				err = params->set_4byte_addr_mode(nor, true);
-				if (err && err != -ENOTSUPP)
-					return err;
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			/*
+			 * In parallel mode both chip selects i.e., CS0 &
+			 * CS1 need to be asserted simulatneously.
+			 */
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			params = spi_nor_get_params(nor, 0);
+			err = params->set_4byte_addr_mode(nor, true);
+			if (err && err != -ENOTSUPP)
+				return err;
+		} else {
+			for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
+				params = spi_nor_get_params(nor, idx);
+				if (params) {
+					/*
+					 * Select the appropriate CS index before
+					 * issuing the command.
+					 */
+					nor->spimem->spi->cs_index_mask = 1 << idx;
+					err = params->set_4byte_addr_mode(nor, true);
+					if (err && err != -ENOTSUPP)
+						return err;
+				}
 			}
 		}
 	}
@@ -3090,20 +3298,39 @@ void spi_nor_restore(struct spi_nor *nor)
 	/* restore the addressing mode */
 	if (nor->addr_nbytes == 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET) {
-		for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
-			params = spi_nor_get_params(nor, idx);
-			if (params) {
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			/*
+			 * In parallel mode both chip selects i.e., CS0 &
+			 * CS1 need to be asserted simulatneously.
+			 */
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			params = spi_nor_get_params(nor, 0);
+			ret = params->set_4byte_addr_mode(nor, false);
+			if (ret)
+				/*
+				 * Do not stop the execution in the hope that the flash
+				 * will default to the 3-byte address mode after the
+				 * software reset.
+				 */
+				dev_err(nor->dev,
+					"Failed to exit 4-byte address mode, err = %d\n",
+					ret);
+		} else {
+			for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
+				params = spi_nor_get_params(nor, idx);
+				if (!params)
+					break;
 				/*
 				 * Select the appropriate CS index before
 				 * issuing the command.
 				 */
-				nor->spimem->spi->cs_index_mask = 0x01 << idx;
+				nor->spimem->spi->cs_index_mask = 1 << idx;
 				ret = params->set_4byte_addr_mode(nor, false);
 				if (ret)
 					/*
-					 * Do not stop the execution in the hope that the flash
-					 * will default to the 3-byte address mode after the
-					 * software reset.
+					 * Do not stop the execution in the hope that the
+					 * flash will default to the 3-byte address mode
+					 * after the software reset.
 					 */
 					dev_err(nor->dev,
 						"Failed to exit 4-byte address mode, err = %d\n",
@@ -3193,7 +3420,16 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 	else
 		mtd->_erase = spi_nor_erase;
 	mtd->writesize = params->writesize;
-	mtd->writebufsize = params->page_size;
+	/*
+	 * In parallel-memories the write operation is
+	 * performed on both the flashes simultaneously
+	 * one page per flash, so double the writebufsize.
+	 */
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		mtd->writebufsize = params->page_size << 1;
+	else
+		mtd->writebufsize = params->page_size;
+
 	for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
 		params = spi_nor_get_params(nor, idx);
 		if (params)
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index cff2f9c389b8..6c6df417a9c6 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -14,6 +14,9 @@
 /* In single configuration enable CS0 */
 #define SPI_NOR_ENABLE_CS0     BIT(0)
 
+/* In parallel configuration enable multiple CS */
+#define SPI_NOR_ENABLE_MULTI_CS	(BIT(0) | BIT(1))
+
 /* Standard SPI NOR flash operations. */
 #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 0),			\
@@ -134,6 +137,7 @@ enum spi_nor_option_flags {
 	SNOR_F_SOFT_RESET	= BIT(12),
 	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
 	SNOR_F_HAS_STACKED      = BIT(14),
+	SNOR_F_HAS_PARALLEL	= BIT(15),
 };
 
 struct spi_nor_read_command {
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index b93e16094b6c..9be39f237dfc 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -357,6 +357,9 @@ static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 			op.data.nbytes = 2;
 		}
 
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			op.data.nbytes = 2;
+
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
@@ -368,6 +371,8 @@ static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading FSR\n", ret);
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		fsr[0] &= fsr[1];
 	return ret;
 }
 
-- 
2.17.1

