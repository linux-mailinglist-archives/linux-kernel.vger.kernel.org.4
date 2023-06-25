Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEF473D003
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjFYKD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFYKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:03:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E8F0;
        Sun, 25 Jun 2023 03:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1BX6HY1K8spIjeWf+1ooQzFYKIaoh2ejfRJNAAcPeyEwAstDVKTI+/JlVC8S61YcU9iJuE/0kxxNKdFx1ASlv82GimaKL2586iuQ2CJlGvnDUzhRZRtq5pfI8v8Ec26RLh8Px9tkWuiyPFF+gmcP+DoSjq+5Vq9mp5cplIcFlewN6hW/8sJn91Z6R1tyTqmhZ70sRW4EY1VInbNL6a1eoLj6Li5q5MfTSpcdhfZoIUfJJfse6neuvjzjKXcncc4Db7REsI3Iv4LvZW9Wiw/RVdJheGjcPZQI4yW1gjYPOJZJLlm1OZYKYf36YYWGn8tGLyzIEX+PYjPhgDwU4Smsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4uBAgCYxrsLXKWGHhrN5/X0JBm659Q8rBhmD2c7a4k=;
 b=NGeJfyGYjT8RenH52H/wGby1SdhBGThvNWy0Jz6Lc6sgBClHwrPIPKAiA1nKOQgM5Ftmo4KMsyxUidS/VnzydYhbk0Os8t3RMD1iS50Ab+H1TqYYQqvOZA3FrDeQW9Xm0BYtzdaQG/JOuS5kR+u+sWwLz+RkJ4a0BKV8+2Mfq9N6n9lYwNVzSTen0MSrDXi0oqagX0+g8IuIvze5RpiKGJXOA27kxMzxhAYaiD+L5cFke0MRFfonjbNjRcJzQNVi7pUhLar+cdTF3dO1+z2piyPLzDqYwpsRH0OOqn1UMDQrZJrqRlfDkHjfujk/5pw2hpYuJM4Csvc2LiGPisnv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4uBAgCYxrsLXKWGHhrN5/X0JBm659Q8rBhmD2c7a4k=;
 b=E36D8Z4uvrZubB75tJdJ2tkpXjrBr+kqStV+ZV56QZzPMQO9nNpJ/rKxvhf1eK0oMnw4xslX9bpNSrKy5rJSObIlmdH4bq34ntJXqIO7AgTkTTIf6m8Rx7s5kXGZths/no2Yvh1nkKImKtu7vEDoECByiTkXjABFbOCOctsb0Uo=
Received: from BYAPR06CA0059.namprd06.prod.outlook.com (2603:10b6:a03:14b::36)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 10:03:08 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:14b:cafe::f1) by BYAPR06CA0059.outlook.office365.com
 (2603:10b6:a03:14b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.32 via Frontend
 Transport; Sun, 25 Jun 2023 10:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.45 via Frontend Transport; Sun, 25 Jun 2023 10:03:07 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 25 Jun
 2023 05:03:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Sun, 25 Jun
 2023 03:03:05 -0700
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Sun, 25 Jun 2023 05:03:01 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <git@amd.com>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v3 2/2] mtd: spi-nor: Avoid setting SRWD bit in SR if WP# signal not connected
Date:   Sun, 25 Jun 2023 15:32:51 +0530
Message-ID: <20230625100251.31589-3-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230625100251.31589-1-amit.kumar-mahapatra@amd.com>
References: <20230625100251.31589-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: b60f50be-09c7-4a6a-43e8-08db75636037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndAGr/MRvywHrXlHZDUbsRGbUs1paDHNQhWZYRFSVl1TIOu+eXY8ONnzlP3ZT57GoTSU9n5CJzZpcGddW2d72ClcMdLWxtJ1S1/NOwl0van4HhntJnXk77NXC7TxRQfYHlgFuxf81N+ayusP5T7tDMN47J3idAKDnR33CGg2dQQVCz0EZGAllum70tkSPux5FZkF4oKv9b4oIVbc191SOUClzZq0K9iWpin0l+MqsPn9m+7cfwc/Ht+WpfanTXU0toVr0KdZrpSH+3I+mv/eXoa//SNeYGoiF4A4aKWUaLmyOal53P7LPDpcSSWFNbyDANOy+/tkum/ai7DqVvyCq/mA0jXnkO20LnX/yKrt3eAQU8HMn4AFaMFoxhIpFwiuLlV1KZ6rsHzVa8Q6rtm2H+G3YR+aM7Eutq10WQLr+eMIrKo5WLosApkePG2hjtIUL7xovkrdwpWGt17h0EdulL2cCglAWH77aI4n55qwsja4TW8GyD75qMnUKMeCREIL0aNjjW3YpAVm/2gWwj0lOlADMzspQ80O4C6oY7LtoEMgJirZbkyIH3zZ3MjzqvwhD4+2fXueEayPyJAjYsQpvzZI++fEPnp+7xKTvoZQOeOFMU4ZrWOQxuMWLeHg0oUhNupysEDgqDvKxohSWaIu/f6qnoBrRQIazqPoHJdf9zihcl+wFZIcTUhi5ZCeen1HvAKLPtPqCrwwzuLkm4SW61cSjzXaaN9tYcdQCVWfXjCfYzKDPvg5zeetEaWOpyT0HzEQw2Dikq97Jmey75LqMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(36860700001)(36756003)(40460700003)(70206006)(356005)(5660300002)(7416002)(86362001)(8936002)(8676002)(41300700001)(81166007)(4326008)(40480700001)(316002)(70586007)(82740400003)(47076005)(1076003)(26005)(2906002)(186003)(6666004)(478600001)(54906003)(110136005)(426003)(83380400001)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 10:03:07.7941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b60f50be-09c7-4a6a-43e8-08db75636037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the status register write disable (SRWD) bit in the status
register (SR) with WP# signal of the flash left floating or wrongly tied to
GND (that includes internal pull-downs), will configure the SR permanently
as read-only. If WP# signal is left floating or wrongly tied to GND, avoid
setting SRWD bit while writing the SR during flash protection.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/mtd/spi-nor/core.c | 3 +++
 drivers/mtd/spi-nor/core.h | 1 +
 drivers/mtd/spi-nor/swp.c  | 9 +++++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0bb0ad14a2fc..520f5ab86d2b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2864,6 +2864,9 @@ static void spi_nor_init_flags(struct spi_nor *nor)
 	if (flags & NO_CHIP_ERASE)
 		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
 
+	if (of_property_read_bool(np, "no-wp"))
+		nor->flags |= SNOR_F_NO_WP;
+
 	if (flags & SPI_NOR_RWW && nor->info->n_banks > 1 &&
 	    !nor->controller_ops)
 		nor->flags |= SNOR_F_RWW;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 4fb5ff09c63a..55b5e7abce6e 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -132,6 +132,7 @@ enum spi_nor_option_flags {
 	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
 	SNOR_F_RWW		= BIT(14),
 	SNOR_F_ECC		= BIT(15),
+	SNOR_F_NO_WP		= BIT(16),
 };
 
 struct spi_nor_read_command {
diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 0ba716e84377..cfaba41d74d6 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -214,8 +214,13 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 	status_new = (status_old & ~mask & ~tb_mask) | val;
 
-	/* Disallow further writes if WP pin is asserted */
-	status_new |= SR_SRWD;
+	/*
+	 * Disallow further writes if WP# pin is neither left floating nor
+	 * wrongly tied to GND(that includes internal pull-downs).
+	 * WP# pin hard strapped to GND can be a valid use case.
+	 */
+	if (!(nor->flags & SNOR_F_NO_WP))
+		status_new |= SR_SRWD;
 
 	if (!use_top)
 		status_new |= tb_mask;
-- 
2.17.1

