Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A037744526
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjF3XUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjF3XTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:19:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B60F3C1B;
        Fri, 30 Jun 2023 16:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF5MawLWFVagbjLudU+1AKsDxNf/JPD+Fo3y0WWDgOEivuiLZ1sDW4YRoOQ6D/7gz7iQ2CjBmw6ky3tgmVA0pxa65r7sQtYi06xyewmrCqLDZ2EKiXj0IWwEKitRRI8UWMRbshvq0pTtHuH115j0VkSf2K3eM4B9eeWNy2O9uUOeHEhNDtMlGJqbQTULrVf7KycKOW3FWE0PNv+4hbRKORYPhP7/elA3ZAzUwCSs7JctfzXCYtCtEYBgTqMbAu6UoNU//5WqDOjd7kRUF61hMCKrGnN/YPMgiguIzf7dCPpDFMRerO61w1T9L4HXTZpOgskdaKIB7ho7/RCfoPyIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7sqbY0FFYnSFzTHSkwg15SUS/JBih7C1nHHGnH4Nfc=;
 b=N3+pewyTz75N5ZgyKlz0d+4grfa7rrODbv5VDb5MdE2yqrXVjOAVhwGgtIk6YQbcV4sDe4U0pJsilwSb45nPHupWIu12yjFvcE2/gBkyU2/ipbxwiLji6HOw9Gsei8zG/Yqqu4jUwLXRIWVCYWdKZJ09sbtNv830xgfSEeg+JZ7UnVUloFgZYXSxILzQojLCp1VjD7NhHeRrefZ7eZKfLD8x4YIXa68VtJ9lEa3PpCGkJyPvL6MnTEIGPAOIqIc50ink1Opak8sPstWmA/3eykKIhY5dDRE2Mp1phf+q6b5F8M1M0G4IG8oVnKSIpTzSq92lbV1+sjXeyEDg6ksM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7sqbY0FFYnSFzTHSkwg15SUS/JBih7C1nHHGnH4Nfc=;
 b=o+ETQ40Wn2DOuHlTXPhZYMrp/P8D5Uvp/OYr/8hKFCEeFcTygJqQgXNfiPh5e/fZOEJChr+5dAS9eFfHSzPDahJBvhLB0eQnh85wR1W6KuySe2sp+X6sBNRZ4K5soqZBxnMjWnuiIT0rDZUMG7BSyTBmki/W8H7sA4tgZJdyZFk=
Received: from DM6PR07CA0109.namprd07.prod.outlook.com (2603:10b6:5:330::17)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 23:19:24 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::3c) by DM6PR07CA0109.outlook.office365.com
 (2603:10b6:5:330::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 23:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Fri, 30 Jun 2023 23:19:24 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:19:23 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v8 14/14] cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
Date:   Fri, 30 Jun 2023 18:16:35 -0500
Message-ID: <20230630231635.3132638-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630231635.3132638-1-terry.bowman@amd.com>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df72fff-f781-46ac-fd74-08db79c0711e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YtPJn/MjlYYMw2HyteGIUwDfkfZxnf1LsvYpJgPd2bYwFEsmWkb5e1IMybCIpFtTagXHdChYlkF+kT4mFEKg82T+EZZ5xXiJ3hLYT/0V9nGc5XV0zJ3N2nKTtNAQVigVMG2gh+SgLpIk1bba5pCBoi8M0dTw7/1xZnC8G5la47wnCTKzxG6czz72bfQImlAejvFJeD54LA8sjXRfkNNDdQh+02ERDPQquRMVUbKriI57ms6XbVT2TlNXxHXBuJq5mAqZ8dx/+IKoiGefe1WpfrCc+gljAqFBhSANDx3S3k10ycqOLBeWYtwk876VqCBfcPcUvB8rcTvGm+xxPq6FpUufDjK0Y+r78BbeUm5gPMTWgdbePPUKjSMBkXN4+UDOxOe+wnAbmY7CIYVhIV3NshvJefpQHfkIDo6gpzhOg7LoVOOiBv+yEH4Wlk1w0zelATc45LumPZRaiysyI9mgG7DghU/WTd6xqzog72YSphhfeSoOFPbH8X1x/v32tAiradei34pfBP/SycijTlFLHP8jsvFB8eLuSdbBGY8GGhZzHHQUjSfPBSiQDw6XqjaFh23Yc6quyTs9Nj5RWZ5UsBdFXvRe4LUds2D+sDha2cBFjm6F30sLviJ3dELn54Le1yHujkY/GURX9avllxWgPG43TOR7c4RhXfzET4ogIX0M7c5qlr2PuImfowO/fi+y4nPNAAJ231XmPovIg/JijGKs/kN3dCKt35tFamAWC+BUx9Ch3AbU82q5PLXaNl6SXHXlcVpnDzvx8HUdJHblkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(26005)(4326008)(82310400005)(8936002)(36860700001)(110136005)(478600001)(54906003)(2616005)(1076003)(7696005)(336012)(426003)(6666004)(83380400001)(186003)(356005)(2906002)(82740400003)(44832011)(70206006)(7416002)(47076005)(36756003)(41300700001)(40480700001)(316002)(81166007)(70586007)(5660300002)(86362001)(40460700003)(8676002)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:19:24.0814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df72fff-f781-46ac-fd74-08db79c0711e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
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

From: Robert Richter <rrichter@amd.com>

Trivial change that renames variable phys_addr in
cxl_map_component_regs() to shorten its length to keep the 80 char
size limit for the line and also for consistency between the different
paths.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 2360b480c5c5..d22ba5a76b33 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -217,16 +217,16 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 
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

