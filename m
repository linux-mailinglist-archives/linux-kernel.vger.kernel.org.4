Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E791F5F585D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJEQdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJEQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:33:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C021659EE;
        Wed,  5 Oct 2022 09:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJAi52TobbJ/q7+elLwkjIolP7mxGqJhA7BPiyAY9UZ0accezrAWP6dk/gnip5xuUB9cSg9zSc5YKg2kCG9lf7eOb5VkA/lHl4MVrU6toj32qFne9ORXR7DaojLEF54ktV1meDIGn5VyJGWCqmNe0TW9GxniXofV4bLwBpchKw5HNgkCWuJBVfY5lsbz7NBc0Qz28IlZF0Xj9jWx991WFjZI9/uyGSlaiP7oKgUI6e1oYnFokrdKMByrsXueZvqxx/YjRn/mHTRqs2hHqWaBxffOveD1bZfqrECYDNfJ/75UdTnkx41ynd/ERiaA/RxG9SE/mMc/YB1DSkVYqQ7z0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkJkH3sTDf9f5zCEYluJNom8sZfVif8I5KIIUqa3e1Q=;
 b=DRhbUdzsz6PNMXqN2VXXlcWZikFTr9J/kBQJCaP5vD9oNPPMO6FmSvZ45SkPD+sPaYEfP4JrZJuGQgcTlUxwqshBJXeM9GPRBddZ6Y3BYQIqmaPIjSRi3vd9CkV5C1rDye+0p9tdfjgOeGRdwqYaXMnb15NUAG45XjpACmADcAcjA3JQN49ST6xmnoPL0AtMNOChJcnXDzXQkwHAhPz44yfBkCRHQQOVAG7a3aXn+T72UhvwLRqDmITGjg1Em5agDvz8FYyUsAPxs3N90qAwog25yCaEpSNlWRKWc/PJnQi8AjDnhQ5+UXC0hWwpvWywfWG/On0egllvVev2L40eYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkJkH3sTDf9f5zCEYluJNom8sZfVif8I5KIIUqa3e1Q=;
 b=IYX9A9GcCu92YrSUR5lwrbvJ45L1GebsG789J7sSddxxr+rbBivWY2kOPb0XOTe8trMw0CJZSihc/WGdQ9Oq1LqVaB0F/Ioy8OxshT53lOrgFRWZsw++1oW44qcpbD7aW+ohrUjbd431JGg7T6XQtITpDPp9M2ChgtJwK/lH/v8=
Received: from DS7PR03CA0340.namprd03.prod.outlook.com (2603:10b6:8:55::21) by
 DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.24; Wed, 5 Oct 2022 16:33:05 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::48) by DS7PR03CA0340.outlook.office365.com
 (2603:10b6:8:55::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Wed, 5 Oct 2022 16:33:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 16:33:05 +0000
Received: from ashkalraubuntuserver.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 5 Oct 2022 11:33:03 -0500
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>
Subject: [PATCH v2] ACPI: APEI: Fix num_ghes to unsigned int
Date:   Wed, 5 Oct 2022 16:32:53 +0000
Message-ID: <20221005163253.455910-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|DM4PR12MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: f3562d2f-a854-47fd-6796-08daa6ef4789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGoJUAEqkWgM0Gkq0EoySNozgqUjsH4pHiLW4noRxSHVp6tM1s088LJJSmTTi/J5RegY5t/T+6Qwe1FWTb90ITeId5eQ4T+GKCaV7O/JfZfBVdUpnr6WrdU2NxBfBnpaWlaDvYXkPPJqqSfQ/oCMSq3cuxQgVI+SEBBL8dkSAxPu7BJz0MhIgIzx9iTYu5uiw6CtxlzbTLNSLwrapfKNvSpEk8xcG5zJyb1YRLc+e7yijR/mIdFIvmlgf+RUebkTdQ7m2JNR8GIrVoo3Q7EwjsRK738mHyBrQlOkumsVVtukaXpJd6RX1CheIXXuX2n5xieOJkuDxkwnAktx1/teMIpIwnGo+FYD3LfCUK/DqW66A+yJfOpGbfa16UTymhtf2vsnLz1tAWD/Y387VUWeRX/m89FkpWz+JNFmJEXFLpaT+/veUVy3r1XTlHpg8tvaFVX+IgDftl8wcbp6hRvEcaqFYZm+zj3Salo4dMsAXS3jPWn3n8dkJ3C5jUccIlDmKD4T/WpXOjFBpBHF/SxYttq9PnW/Rw6uD4KJuQEehL3PxSor6qK+/a2oTd0XxtvKLlYA8WuPjZ+uBVR3yg79/BQgxplSjBRuF6pvewxi7A8yv8VWtth8E87+oeBgAFbNOo46zxiJhu+mGe9OzctGatyDDXzZJKLmOgXRVIsMLYLGNnL2cj3KTVw9yat8MlKz0UQKh+fzs3x6RFNzq7cY80/lEGR5TKSJ+zGDeqLjg6mCLKjCUSZOgTDa0lBOPY9fdWkUmH/B/XqbOzJ0YB+jZZmAIu4uZ1FZIZoABCka9uTRM/8IxFsuuaqq3+5tpyca
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(2906002)(7696005)(41300700001)(26005)(36756003)(5660300002)(478600001)(6666004)(82740400003)(86362001)(40480700001)(40460700003)(8936002)(81166007)(356005)(82310400005)(47076005)(186003)(426003)(1076003)(16526019)(336012)(36860700001)(83380400001)(2616005)(316002)(110136005)(70586007)(70206006)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 16:33:05.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3562d2f-a854-47fd-6796-08daa6ef4789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

Change num_ghes from int to unsigned int, preventing an overflow
and causing subsequent vmalloc to fail.

The overflow happens in the ghes_estatus_pool_init() when calculating
len during execution of the statement below as both multiplication
operands here are signed int :

len += (num_ghes * GHES_ESOURCE_PREALLOC_MAX_SIZE);

The following call trace is observed because of this bug:

[    9.317108] swapper/0: vmalloc error: size 18446744071562596352, exceeds total pages, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0-1
[    9.317131] Call Trace:
[    9.317134]  <TASK>
[    9.317137]  dump_stack_lvl+0x49/0x5f
[    9.317145]  dump_stack+0x10/0x12
[    9.317146]  warn_alloc.cold+0x7b/0xdf
[    9.317150]  ? __device_attach+0x16a/0x1b0
[    9.317155]  __vmalloc_node_range+0x702/0x740
[    9.317160]  ? device_add+0x17f/0x920
[    9.317164]  ? dev_set_name+0x53/0x70
[    9.317166]  ? platform_device_add+0xf9/0x240
[    9.317168]  __vmalloc_node+0x49/0x50
[    9.317170]  ? ghes_estatus_pool_init+0x43/0xa0
[    9.317176]  vmalloc+0x21/0x30
[    9.317177]  ghes_estatus_pool_init+0x43/0xa0
[    9.317179]  acpi_hest_init+0x129/0x19c
[    9.317185]  acpi_init+0x434/0x4a4
[    9.317188]  ? acpi_sleep_proc_init+0x2a/0x2a
[    9.317190]  do_one_initcall+0x48/0x200
[    9.317195]  kernel_init_freeable+0x221/0x284
[    9.317200]  ? rest_init+0xe0/0xe0
[    9.317204]  kernel_init+0x1a/0x130
[    9.317205]  ret_from_fork+0x22/0x30
[    9.317208]  </TASK>

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 drivers/acpi/apei/ghes.c | 2 +-
 include/acpi/ghes.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d91ad378c00d..6d7c202142a6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -163,7 +163,7 @@ static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
 	clear_fixmap(fixmap_idx);
 }
 
-int ghes_estatus_pool_init(int num_ghes)
+int ghes_estatus_pool_init(unsigned int num_ghes)
 {
 	unsigned long addr, len;
 	int rc;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 34fb3431a8f3..292a5c40bd0c 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -71,7 +71,7 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 #endif
 
-int ghes_estatus_pool_init(int num_ghes);
+int ghes_estatus_pool_init(unsigned int num_ghes);
 
 /* From drivers/edac/ghes_edac.c */
 
-- 
2.25.1

