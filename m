Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425B7727168
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjFGWSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjFGWSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:18:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E0D2685;
        Wed,  7 Jun 2023 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9TaBrSyiouB7Nky+kqQc/QQO1sig2qxKvuT7hxOGSU=;
 b=jdbSo1NFNid9mnt9GYXoBOUat6o1fhXqo+aVI9+dqHJbfAzIfDrGjlr/zBGkLIo95Ugyknj3+ztCwvvTdvpZ0O/xdP/jhOh2lJ7ReR7stKhDWtRlKFi6LW/b9EZ0RGvKxkyOvYVxxXFniDqtIcyvGSp1Zb6pIJsShhRWKAs5odo=
Received: from SN4PR0501CA0102.namprd05.prod.outlook.com
 (2603:10b6:803:42::19) by CO6PR12MB5425.namprd12.prod.outlook.com
 (2603:10b6:303:13e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:17:50 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::ec) by SN4PR0501CA0102.outlook.office365.com
 (2603:10b6:803:42::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:17:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:17:49 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 04/26] cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
Date:   Wed, 7 Jun 2023 17:16:29 -0500
Message-ID: <20230607221651.2454764-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607221651.2454764-1-terry.bowman@amd.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CO6PR12MB5425:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d97e798-5210-4fb6-7467-08db67a5081f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zq3y6YDdzgG/dw9xltkfLYArnGjy4xv3TDq1bfVjnuOtWD0FbTp20mNPIC52u8lzT7M+KBtp1Q4hSGO/MgWW3szIvN0dqy+3fW5SeLmyvGpcY0sZDwq6at1Tik8hQNRFYLcnCroJcpR4eqilnO5l6OOjO+qzGrcFuB3DtqDEginKApQ0ZwW6psvapEjk1fnVxkWmbQLDDJrFCvD1viqu2d0fNfPYtm4Y6V96jZvzkLWhijKkhWkcBTJW/aEN/lxrDnj6EkxXVjQJGa3a9NPsGshss4qoJIWxbQZOrSbEn4s79u1twYorX7uVe40VQByYT9RPgaOMfxm+ulLjl+ZVcSYHsRutlw9DnxBwXQQfILCH335w4WdJNMarJ23PZ/4F1g7vx629Tn6gokQraeyar3OKw8vO6VVzQQlSSJfY/gAYynUyzrY/JhePODRla21LdIboeYPKIelydgSYoI/2dwkTO7D9t7FBVUqpWqYgpR7oAkVrsKCosbdS7gyDfNe5OuXddkBD7KNvM2e9LeYdfFDxynvVrkaMiwOO+OF/+p2PwqyssB/xVUPCg1exBaNnjNic5seNPK1Zx6m/3OIsXhNnwy/n1DOzfNmDgFIgY2J1SPfmUPeih2WhP9N8t1tKa034Pfhlihi1AsYZ3OBLttQk0k1JKTVP6EiupxsfINwQr0mFryxvuhPrvRmKcUfw9eWotsa99Z0ezpYqr9Fhcg3f2/+iARwuxP9Apesd2MScLdf2sky/0HPMKSxi/f2dF6uUmV4g+z5sB3t9Ho/Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(47076005)(86362001)(83380400001)(7416002)(336012)(426003)(40480700001)(82740400003)(44832011)(110136005)(478600001)(40460700003)(8936002)(8676002)(316002)(41300700001)(356005)(81166007)(54906003)(70586007)(70206006)(4326008)(5660300002)(7696005)(36756003)(6666004)(2906002)(36860700001)(82310400005)(26005)(186003)(16526019)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:17:50.5976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d97e798-5210-4fb6-7467-08db67a5081f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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
---
 drivers/cxl/core/regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 08da4c917f99..c2e6ec6e716d 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -213,16 +213,16 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 
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

