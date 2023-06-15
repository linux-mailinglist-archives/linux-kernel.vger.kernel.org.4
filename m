Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5D73164F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbjFOLRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343654AbjFOLRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:17:10 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF982947;
        Thu, 15 Jun 2023 04:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmorYjQyipi/fHroXiCpmy4YOP3Xim5Jqe1OEDWni3kGhFPvM1eYOSmVjViXRDiPY/zOApbGQGFqNtNy+J3gxAQFrXmBYAmdsRQvnFkdH9o8+UZB+QISQoWgKfN6uDHjbsbO6snul0cNDPT+a5KL3r65v/A49xzZYPd1Qh3SMhW1ZWWgW/u/OZgnXxEUvE/s+1DLKXQKgd5ZImhM8s7rivcrTVqilaQ1OQpBhA8PFvZuSJnK1ruFQ1YLRu9BysUiHr7Aa5CnyVG4ek/d3dCvnCokt5SVmhuvahO0bRtrRL2vgABuLZJAeY9ECpmChjBlS7/6tUjXbaA21gLbleISjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr1+zYjtepEiq7UlcHy7vwzAYrAfxjUoBXuNizs+2r0=;
 b=jQ8PdOuBaq/vKFL3nGYYaHrKQlgXBqTyYQELFjGWbnxEafKIAX/i+K5CMKu1kEZkn2nP3Fw1VYNqhyONlVINbBZbOOFRS2/bkXXOXsrCqkSG+RUek9vzqRX2bf5Lqh9MkVgkxN7NkVbD75sjyDVnL+FmUtIkKyBsjU8mtyTvXGqtY4HeKSW5WCFfEgVmMaiAvFxcQ/ZSCyfHOihDMEqW1S6fhaR+5j9ASVO37qJxccxhlHBHpmzpb6WrDrqYnvCkXbBcJR+RgNSbrbP/6LGBYznfyW0y/1QHafgmc5ulc3tV+f9w6NrKz6Rx5Lng22SQNS+E3GKUXAY5sF0XuD+Q2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr1+zYjtepEiq7UlcHy7vwzAYrAfxjUoBXuNizs+2r0=;
 b=ejScmY6cReE4MfJGi0GwMMytziCyoEMElCQhsEN2TT2Mdo6v2Ik6iu+WlqFhAgOWxjEoitBjHS86Pua0eZIT5BPEoBCypQuY94Fi2ot46nJgtIjDxm//fj1L5nq39UZXdLuIFHdwFNDlm7SIs9cRFF/bwZ5nXpp97hIs/jk0H4I=
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:312::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 11:17:05 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::d4) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 11:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Thu, 15 Jun 2023 11:17:05 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 06:17:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 15 Jun
 2023 04:17:04 -0700
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Thu, 15 Jun 2023 06:17:00 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <git@amd.com>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH 2/2] mtd: spi-nor: Avoid setting SRWD bit in SR if WP signal not connected
Date:   Thu, 15 Jun 2023 16:46:49 +0530
Message-ID: <20230615111649.36344-3-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615111649.36344-1-amit.kumar-mahapatra@amd.com>
References: <20230615111649.36344-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae19120-460b-40a2-1693-08db6d920ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyROXzdFB7BFYv71BvpiNkbF+DktKPNbimxweM94UZDypIWScPY3QhwpPdbGm+8MlgSnatyIwDHKczs9T3FjRaMr0SNanGNMp5ycB5QuqhjWcusO84kxRDq3lrbGdR/BuZb9tvHD6BH7YamO3E/ayhgLWiwgjebDwt4mbqfr5j0vXQdEwqlzZKmGerO4SH7LcRifRWYWuauCJ2E/kfDJzLb1DxK7dbsNlFH2iU0OhvPCEPhTe9HobMPt/2QaLVcFs/FGH9aYQL10+dVKk+hF1jlcOQKSXCjejrFXEATHQbiMKgw9NpudRMO06iSGAsipwo4ZKXg1U5DsUEooWBp23DSnslp47yHVXLa2zflwnFWZcUlhzJIL4t9b7bL9flHhE6iAb5Gx7VFelRaJKmqR0DshMI3/iJGM5VVKik8Qb0Mg1q8v3hZSANJ1/jVcw1db0F9t6GpLRsW/p0mtBnwMc5GD8O7MDA3b/XPkKzA1jq4iJ7IhmSfg2DlB44CRazKfiOHyZvrOW10d3M/tzsTEuHa70dxXsjv8XygU2FntprVE/eR5/GE1kAU+LOXV85Jm2cbHSSGfcNIXCTfka6SZEhnmRCnp4QEnTwUiEV4pXX5sBtvYFIp6nxc57GHu9QEZx01O5vKCrmeFzhzN4+ONS7azky1hBkFA3RZfLhxb8290092YjJfONqvubfF9Rx2ROG1fEmPzaxC4mjYKkiDJdv9nK9Xk9r7v7Dkuuw4nanaY7FDwjiMa4ed0Pl2cCBTN6raOayraDLBCXroV7ynlhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(478600001)(54906003)(40480700001)(8936002)(41300700001)(316002)(8676002)(1076003)(7416002)(186003)(4326008)(70206006)(70586007)(110136005)(6666004)(26005)(2616005)(47076005)(40460700003)(36860700001)(336012)(426003)(2906002)(83380400001)(356005)(82740400003)(81166007)(82310400005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 11:17:05.0784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae19120-460b-40a2-1693-08db6d920ce0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/mtd/spi-nor/swp.c  | 5 +++--
 3 files changed, 7 insertions(+), 2 deletions(-)

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
index 0ba716e84377..074f3bce2034 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -214,8 +214,9 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 	status_new = (status_old & ~mask & ~tb_mask) | val;
 
-	/* Disallow further writes if WP pin is asserted */
-	status_new |= SR_SRWD;
+	/* Disallow further writes if WP pin is connected */
+	if (!(nor->flags & SNOR_F_BROKEN_WP))
+		status_new |= SR_SRWD;
 
 	if (!use_top)
 		status_new |= tb_mask;
-- 
2.17.1

