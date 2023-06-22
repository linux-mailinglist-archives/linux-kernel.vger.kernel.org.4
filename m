Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F62073AB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjFVVHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjFVVG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:06:58 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A56C35AC;
        Thu, 22 Jun 2023 14:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnAcnv7BM5hNj7AGqXJcvWvzkKXQH32uu0b4CR7eCa/zfF7tdaMZsKK3NVVacLopVt5eZnZgaN4L2TcjVX4cMikRRv1OW6dhYtKhcIbMed4l0vcVxfsLrkqkLNQO+yBEJAYvVntlJ6B3bRlMJ0sraHrPLq42DK6B+wMkZwHpcF14abW+40lqBTFQEsAVYH5aMPdgnmEYyeiGOJI41OZvp/BzNWC9uatnPVWseUpwkmJv8zU5/RtLDhvYO9JkQvFdU5s485PTHJmZTjG3pla66WQM6VTUcJA4hqlIYowiSN+6saFXI8uRCQ+ZpAaoue4JIfVV8om5D45tIt7EkdEw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM1Y2HT5GUHEggHvbmP3BKJbNGbRhgByztwyQcM4a8Q=;
 b=U9BirZRQ1McMr0X1HWzWBKf2yBhu9FV6tSir61EXDoQrD8ZrfhdxoHbK0ZwOf9Axy6jIBp0p40ZFt7QUKc41pdHRNr4nggVcNybPawd2ZTJnnYk9DBOJoN/rHssCfJCIy75ZD2xMbgYmvXC0r3bQ6Z66uL3CLbiLoxt8rdH6B8umrxJUbmQiCyRQ/Du9c+e0o2sMZ+Ew58lg8D2TuA7XuxKCGPZqdYjo6VCVtXs425i9pGml79Yn4H7TFR9BI+TM9mbbU++IcQvpgmgHo7wBUh+btmTmVZ9LaBvrGBKPBYQGItca6zOwAP52A9slPRt+Rm/NwT2/DBLhQF4vAK0iJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM1Y2HT5GUHEggHvbmP3BKJbNGbRhgByztwyQcM4a8Q=;
 b=g7QoHcqYIMErl2s43yhShmilF60Z39uT+jZ7A4g5ow+blw/fAiFN4MhYso/NPICOrfTfIlbPIR5rYEl15z47A7zSuukHFT54G84F33LnVVuLwU/YRH3VZFpmjm7GBZBZ8QBHJgdmuJ2+pRdtF5Tau40JULFUURKdb+4ItXwykPE=
Received: from CY5PR19CA0127.namprd19.prod.outlook.com (2603:10b6:930:64::14)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 21:00:30 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::c1) by CY5PR19CA0127.outlook.office365.com
 (2603:10b6:930:64::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 21:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:00:30 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:00:29 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 27/27] cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
Date:   Thu, 22 Jun 2023 15:55:23 -0500
Message-ID: <20230622205523.85375-28-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622205523.85375-1-terry.bowman@amd.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfd0e41-6c09-4338-2000-08db7363b65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENyJil2XjtzFvjtD4YrHoE1BwFLkELJs8oHUSG2lzQ2S3ra22LyF5xp9O2ee9YhITcF9F12hA3QPy8CHxUvPr/+PHe1mD+5b3djbFNai0bKqfJgHKg6vcUhWEu5nqrztcOS5VD+tWnsBs6jUpBzcZbR/BsBhoUx4jTfSPd0zqyMn9PfROrEyCulK5/IYkGFiQNGfuBVAQQaGyzKLvj+cShPMyB1HgrHot7gSAKH4xeYCVKYHEZzHWtKGevosld7WJFnwZJBDb0JFjdq2JQXemkJnMKn2xbdHFmHe4VGWfnAnMnUev8vO1n+exDijY9iMcD+cSWlISG0qqsd8nVNFwSU9GTFESdZJCnizhopq+A4qeoyY/ipaBfZay6+SivNL+prrp7nTWTdYUeHyKKn9FRaVHQktKvXqRPO6fza9wOrR80cTYAZQRpnaaobEerLkUoDZMS3UcqwhuNtiP3D3g9nOaP5dEF4qxR4dUFZvPzPIpJXtclbttlTYAL3RvS8ZLoa35KWbXSr7pRQRfG656kJgMBr9i30VFCpIY2nkQuxBqvq6O71vc+nwq8equ/Ccjou1dRBG9Jq6RspBSp3ggMRQKzPJ0KBZFffdtrmV53MnRkmzZiNa41OkjYoDB6aDLXYuGmGcXFv15xdaSdU9MY8DyJaJKv4jmZQOJGWONcaeURgxlVs2H367kf5Pl97H2hgO+ZVGXia99SMCuhCwhRvB4eMKcJdXDvbxL2dPliTWCFxLYYe2clDghFajDERVg1vP9zAEz/YnSBwu34TvMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(8936002)(40460700003)(36860700001)(36756003)(44832011)(7416002)(5660300002)(8676002)(81166007)(356005)(82740400003)(2906002)(82310400005)(40480700001)(478600001)(16526019)(186003)(7696005)(6666004)(110136005)(54906003)(2616005)(86362001)(26005)(1076003)(70206006)(70586007)(83380400001)(336012)(426003)(316002)(41300700001)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:00:30.0476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfd0e41-6c09-4338-2000-08db7363b65d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

Trivial change that renames variable phys_addr in
cxl_map_component_regs() to shorten its length to keep the 80 char
size limit for the line and also for consistency between the different
paths.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 982ef79670c7..ba351a887040 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -216,16 +216,16 @@ int cxl_map_component_regs(struct cxl_register_map *map,
 
 	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
 		struct mapinfo *mi = &mapinfo[i];
-		resource_size_t phys_addr;
+		resource_size_t addr;
 		resource_size_t length;
 
 		if (!mi->rmap->valid)
 			continue;
 		if (!test_bit(mi->rmap->id, &map_mask))
 			continue;
-		phys_addr = map->resource + mi->rmap->offset;
+		addr = map->resource + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
+		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
-- 
2.34.1

