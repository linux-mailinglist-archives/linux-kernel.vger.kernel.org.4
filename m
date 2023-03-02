Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1446A8AE0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCBU5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBU5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:57:30 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2160F55054;
        Thu,  2 Mar 2023 12:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7XzithwABBKpjUP+ImeT8dDzz5mUCD+3HB7Rsbgw3M73JRvWSbSGDhE7OosqtvX8GHoWr8424NpiihPqaBx+k3xPsI38DgM7AUdb35ONea9z/tqhqKxKue6BwDaLrQTiEZ7uPrBDKO/AJqK48xE3nPBC4gmYFc8u/xUQfwI31lbgQd8kBJLmuA8B/5bWn0SJ6o1oFgQjpDmjIOiiOjcBL1cLXEEa9LN/YhaAJ5Lboe+v+kurJew0pr2URzTk2IqWvyc2rrcPnLQ0WD3RwhHr6wHWA9hWATSwII600HiPR/iXwhIV0n4vlFzbnWZ+voy8dY3ztjcOfdXXamIZkjc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E0s18b1bkSSDtNJBWZmzyAZKiBmzRwIq9U2pAte5uQ=;
 b=W+kBEzysLeKtN/TgznJHyNkfpVhkxWIPegwvZ+eITIjxCGK8Et8e2XKJATAsUf3Ni3zHE745QTlPyd7T/q+DpF4+9eVR/WFGo3OFj+qGRB4UpGJ9y/qQ7XllW6jHQsy6jhIapTm1pPCuiW9D5GI9bDSJg2KkqBAUXsB9kSGLI2+Asy/Fv5vNphK+1nzlfmd5Gnr7uHq+xIIweUGXQ1is0OBh5FAZPy0+TPovuVnS7j1m7CnNlcoJip1iv7uVIFXHMJRSQdFYtfoh2ud4azVaSGSlCIoolK91Vm4rl7OM/ASTgVtMJt6vr3egG/+CIz+p/0wF4PrgUKIlR/HyD7rCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E0s18b1bkSSDtNJBWZmzyAZKiBmzRwIq9U2pAte5uQ=;
 b=HmAazkm2wiO5FnkNPiY/J4ihH6q9GogkOYdiciheMnysSnrCCLxtdpcRLnDDVYJgq+gghGVz3wqgEj8sztSCIoq0b4DHDNzwUI4J7qGbpKbhDkuzMP+1lzhD2c0gfy9vSO7nT5lW8M2WyTrSb2rcCsRI+mB6YST44NniXkDMxEAJIz6yImOzdhwYCLw4VnXVmF9SeofAUvuK5hkMIAry+oWfrTYfsLvhU6q7+s8R7Cp2PDD2lvx0dzyJmHcj/k6DrgQBkO/j2f6xxWnV4jSrWDxn7JzC8rAOA+OvvB9caF5twoXsMtYoyvdhbuo8rlFD6TuyOeLtyWNxKrUV2nVuhA==
Received: from DM6PR07CA0080.namprd07.prod.outlook.com (2603:10b6:5:337::13)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 20:57:26 +0000
Received: from DS1PEPF0000E64A.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::fe) by DM6PR07CA0080.outlook.office365.com
 (2603:10b6:5:337::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 20:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0000E64A.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 20:57:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 2 Mar 2023
 12:57:25 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 2 Mar 2023 12:57:25 -0800
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Thu, 2 Mar 2023 12:57:24 -0800
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <rdunlap@infradead.org>, <suzuki.poulose@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH v2] perf: arm_cspmu: Fix variable dereference warning
Date:   Thu, 2 Mar 2023 14:57:01 -0600
Message-ID: <20230302205701.35323-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64A:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d17d723-a623-4949-b939-08db1b60baa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eB15WaeRydlYFiQ29luRwUMdpmUfsCRRO7yPDLsJG0KOHwWnLAEVjNkwWgHVHrYUkzcxbWTQwcQ5sfggMmyePMp3NCMnPYsvIpntBVF2qP6K1Jdf0Cj5pF94MohI0MbwhsUZt9lksRndBBe6pAFvR1kheRL2O3sJKtxyAopMJKrgPRySmYUW6mBrKeWdAY0sP8Dv3bFKWpkclBfUpIvhkbpZrTQKW2K1cuBj91cfmaxPopZOQAUdVfS7nSGo3LTnXxFRg2mqOx2eS7IapMx11NwDLgkY25DSBwJ3d8Q8JFeeNbfagrp8zWsw0z7sdEsXzQCS930NOpZ7Nlnb8lcv8ICv4v8m2iuOF0BIXiS7glxvUc4GIgjK0cH6De6RORUtxMgnx6ZdJNIAMhK4Zok/cyUMYKR/vVkbx+DW01tJZW+OFP3UB7vsKM5dqfrJXMz3p/X8Z5rKALPvVGtViumZ340Bgak7ebZmRtdKyB72Oh8ajPrgzaS4Brl3ypy/vGUOS0WZTE89crJ6tKcMZSV3C2Oq+4mUzXLT0IYnkP86kQofk6R2E64aFLKSrlENftqhKNGU1sRJVW9LfVQ8tA5Pvhsf3/M4L1DTlmWSI7YBLXdC4/klsQrsKvm4NyC3aCYVUvA7GO7ZvY95OHm3SMRhPZT+N/6SlpZyPRwbed11qOHvH3SLkK1KxOpZObgy/h0x5A6EQCiEFFsHVhQ//uK+KTfqjFSqOEl+HUoEe2pvvjMEtLgpVTqu/dfTQhPwT6+dibydjuJN6qLKaRznMcFs9mgUdRw86xGD0O7s2Z34lIo=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(46966006)(40470700004)(36840700001)(2616005)(36756003)(82310400005)(8936002)(41300700001)(54906003)(40480700001)(40460700003)(8676002)(70586007)(70206006)(336012)(4326008)(186003)(86362001)(2906002)(36860700001)(426003)(83380400001)(47076005)(356005)(26005)(5660300002)(1076003)(107886003)(6666004)(316002)(7696005)(478600001)(966005)(110136005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 20:57:26.3818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d17d723-a623-4949-b939-08db1b60baa4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning message from smatch tool:
  | smatch warnings:
  | drivers/perf/arm_cspmu/arm_cspmu.c:1075 arm_cspmu_find_cpu_container()
  |    warn: variable dereferenced before check 'cpu_dev' (see line 1073)

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202302191227.kc0V8fM7-lkp@intel.com/
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---

Changes from v1:
 * Update commit subject and description
 * Added Reviewed-by from Suzuki
v1: https://lore.kernel.org/linux-arm-kernel/20230301225657.30211-1-bwicaksono@nvidia.com/T/#u

---
 drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index e31302ab7e37..a3f1c410b417 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1078,12 +1078,14 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
 static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 {
 	u32 acpi_uid;
-	struct device *cpu_dev = get_cpu_device(cpu);
-	struct acpi_device *acpi_dev = ACPI_COMPANION(cpu_dev);
+	struct device *cpu_dev;
+	struct acpi_device *acpi_dev;
 
+	cpu_dev = get_cpu_device(cpu);
 	if (!cpu_dev)
 		return -ENODEV;
 
+	acpi_dev = ACPI_COMPANION(cpu_dev);
 	while (acpi_dev) {
 		if (!strcmp(acpi_device_hid(acpi_dev),
 			    ACPI_PROCESSOR_CONTAINER_HID) &&

base-commit: 7f7a8831520f12a3cf894b0627641fad33971221
-- 
2.17.1

