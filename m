Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C2668CF51
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBGGKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjBGGJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:09:53 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6E62E0F9;
        Mon,  6 Feb 2023 22:09:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYlF2ONuqAUovnJFN5E4lcpjQouT6KTR6dJwtWeHgn4jSWzWdLbAN0Ro4WCEobB/zcXVJoI8kvuF48+kGnh3Gnb0OSXlmmDwX7mLGpbsh2hbiea1kkKgHWz/NzRP7eCOGzNFABqCrUaMupeYk9ld+WI6VsK7Y2+3+dZK9hQ6TiN5OQOnH+EJVGnhBPI5s4c5U9aWHH12SAmby+S6wTAVFGzQY2mJ7Awl8jTcLoGNkcmkW+Shh4GtM2sSh6blCNHsqjQ4Ed0QwiD7mWbTRqI/Tqr3pxOcQpkrlDpcT1WhHwGiTqQ5LAmm7GklLMMXxanHT4nIFR1uKFTp4kl3rxFu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPY6ZmdggQJDaY7b+MJS0Ehlu01syJw8PLd4AJejj8E=;
 b=jR07Etlaph1pF9Opv+PCPleABflvLD60eDzIAw4iaX8UWkTxVVrhud54kzfrrWnm41qnFKXA3kkGGiOFJ0QS42NF/CixfSDsfaMNBK86sFId7hzmitUYexBzWzNUyFcH0ZHNCOJdELTRNsmWnWPhGSAVwUv/Er6sawAhliYRahG+mefZ+RnRr9Ko6w3HSL3I5nzpkf6dM4Q3eWSd/5N8tW2A5ftWAWy+POyARBzztydGnsmGc0qERcqRKGGPD0K3RAA4vOv9VrkQqQNJLwhXvhL+2saQZmfVUPDznufu6eLKqnDv8J1uujYQzRffwFDL/SqWS7E+O1DabDqkWnfQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPY6ZmdggQJDaY7b+MJS0Ehlu01syJw8PLd4AJejj8E=;
 b=QFdfdE4S61bIfhQTh7yg5mepBvZPXAjTt2emrr4zI0sSIN9z142hQPLnz7EB3/TihyqgwaFblYLp39h3K7DZErWG4NI/VRTe/UIYARNgDf13s3NAwAcdvSPYlQ0VUwnhB85Si1H1NHPphMPZA8OvKzR0LHwt/61S4RzE0DbaxR8=
Received: from DM6PR11CA0003.namprd11.prod.outlook.com (2603:10b6:5:190::16)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 06:09:46 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::bb) by DM6PR11CA0003.outlook.office365.com
 (2603:10b6:5:190::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 06:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.35 via Frontend Transport; Tue, 7 Feb 2023 06:09:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 00:09:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 00:09:45 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 7 Feb 2023 00:09:41 -0600
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Michael Walle" <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 2/3] mtd: spi-nor: Add and update device_id field in spi_mem structure
Date:   Tue, 7 Feb 2023 11:39:23 +0530
Message-ID: <20230207060924.265789-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207060924.265789-1-sai.krishna.potthuri@amd.com>
References: <20230207060924.265789-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: c44c8167-6a1e-451a-87a4-08db08d1e969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Si8CGytmSLmdo4OLRe30DyvB5yQdtqxg902QQTCQSnm369i4JAvfv09zG4iiPEk3gYa9B5zJiD8M3UYJ056UaBZkozmx9mgFwab5UULQBrTHMSzBewPBNpnUwX/wzifKTWJRzvpy05pUaN7YIchCUJFnZLrHZYwlWpuDROCa1JLYds+rhrfgOpIPo3bw/h6NmhCv3pWymdQD+fGG04Gr8izpkDMEpCYYAxesaZL4uX0ieWXlHP6zSFIc+N0zrNtTDquTiHN5R9u6WnbkuTbEUOWCStSoiBAyr6W60RArqoBclOaflmu7kSz+qUxz4D/lUsHFYaC1iN0xeazCNnzlgcaOTAcO0e2K+30CYl3Y9/aTx/6XVRGLXLifLek577v5Ont8EA548LLTFvCJEOouaOInyP7wQMCs9wT9Chem4KXiowopIeql+s0bEld+GWbiEsqmeZdatBK6UOcIEjW1/Te4wEyDMVqXj057aXtW6rfFxRsFoPGeIycxFkhcuw5uQutmXpHaDb+48NMS9rF+lCVUDt11wA5ZDC68txJyPWh52gB+H+IxD3foMdIET7zfkeubpsNYq0xnoiwaUgUNcxe6VK9c3nPLaoT0ODYSuhbGv7wVeE8W1zxGC1JcktLN6rwv2iZdlJcRp9P2WSlcDcohXm8fLmqJQSyiCdSgXxHsxLLSpdHvMgnTRcsa97hxVA8J7DeFqr8erxaIQx65UEbmUqQU3SNvRS0wnrOEGo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(356005)(8676002)(86362001)(40460700003)(103116003)(316002)(70586007)(36756003)(70206006)(4326008)(41300700001)(82310400005)(110136005)(54906003)(8936002)(7416002)(5660300002)(2906002)(15650500001)(40480700001)(83380400001)(82740400003)(26005)(1076003)(186003)(36860700001)(6666004)(47076005)(336012)(426003)(81166007)(478600001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 06:09:45.9470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c44c8167-6a1e-451a-87a4-08db08d1e969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx Versal Octal SPI controller drivers might require the device id
information to perform the Rx tuning operation. Since there is no common
Tuning Data Pattern defined across all vendors, controllers which requires
Rx tuning to find out the optimal sampling point for data lines, this
device id information will be used as a golden data.
spi-nor core updates the device id information in device_id field
while reading the id of the flash device.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/mtd/spi-nor/core.c  | 1 +
 include/linux/spi/spi-mem.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bee8fc4c9f07..9811e74ef3b6 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1644,6 +1644,7 @@ static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
 			if (part->id_len &&
 			    !memcmp(part->id, id, part->id_len)) {
 				nor->manufacturer = manufacturers[i];
+				memcpy(nor->spimem->device_id, id, SPI_NOR_MAX_ID_LEN);
 				return part;
 			}
 		}
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 8e984d75f5b6..e9ae5c1b7391 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -181,11 +181,14 @@ struct spi_mem_dirmap_desc {
 	void *priv;
 };
 
+#define SPI_MEM_DEV_MAX_ID_LEN		6
+
 /**
  * struct spi_mem - describes a SPI memory device
  * @spi: the underlying SPI device
  * @drvpriv: spi_mem_driver private data
  * @name: name of the SPI memory device
+ * @device_id: device id of the SPI memory device
  *
  * Extra information that describe the SPI memory device and may be needed by
  * the controller to properly handle this device should be placed here.
@@ -197,6 +200,7 @@ struct spi_mem {
 	struct spi_device *spi;
 	void *drvpriv;
 	const char *name;
+	u8 device_id[SPI_MEM_DEV_MAX_ID_LEN];
 };
 
 /**
-- 
2.25.1

