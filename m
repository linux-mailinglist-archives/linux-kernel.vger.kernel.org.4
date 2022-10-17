Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A05601D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiJQXCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiJQXBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:01:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07978306A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKPQ7UeYM60ohN+JTCQD3V5C0NAa6BhY4x+LLIIEQEu1QUhclWKftlTZaniYk4rHzFINwwumZs5/7XF3to2kMcJjQKWEcIMpSzhXeOTd1L9UYgSyS4yaw05aWP5oSYk6CBXpJH0vczwy0XEVwOAtafiutFpCfLjA1rwMD31VW/7acG77uiqmM3d16f6lWUcxynoxtpUFdyLFt2Ox7oX6hVQ+a8mI8baxu63PAX29n5B4e4FjZ5aU6DUZvvqiRbDU0Dc28szos2RqCOMs4gK42Wa8f8I9yGTaBEiHUWDfGeG7k2r1PSiGVQGyI8Pqsf2DXzDgxGetQSRG90UU2Be0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT0lY3mbgmiFSnOeSMckMtE9MFTGdyP0vg2ZAYNExvM=;
 b=TDbTgL5UBsmGmIKGQKnaj+tMdsa7JlcfUz9EFDzRgp/dLBwaMzxsNU+W6+BKvIonFnZHj1o37aA014Yrdal5mI4RxtA92U8VBCjzSTuINzIrFxpGgBlPT54Gx6HzwYKgGX24zaVsM9SfKE5LZbSTgt+Y9GVuzRUre3j9bH7YTgSadsEh87Crw6HRV6Bu86XN9PrdMAbneFRvemJ/k0zVr6ny3/ADwR8Mez1cFpCqKOIyFz1d+QPuZXRa0SuoC8AYGTpZsVr+15aV1agLHYil6yCUFEku+/m/1CwRnQWbTmxkWAo5Pib1K0HJGdHxcoorG2dQu4yrKgzIDUAAIcFeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT0lY3mbgmiFSnOeSMckMtE9MFTGdyP0vg2ZAYNExvM=;
 b=THjdEk0obZh1hgE67JTJeQcAXS1+aDwkHwPxbNJsdohK+dt8LyuL+JbxTJGJlgJEkbb9NMosCrRlYS0l7lj+9SOROnKETbJVd9yne8iLF3p+Y7NDoN6w+ajDMD2jQ7zxKLQlK8eBj0bF+KnE6w06YMwR5At+F6QBA51nYIKTQH716JXaTO9WK1kKwplHhOgfo6nrCMiANdMKR3N9jM2P5GcnoUMEENawVxQQByvSlquSwE/lNfDzuVSVygWKlnWQrs/SBfjvMENvdd75aC0HGg+TSwlvnAu4DHk66xSutfAOYrH9+o3IsMvRyTwhxL1vUnP3tu83dfxShfq+TV4y9w==
Received: from MW4PR04CA0105.namprd04.prod.outlook.com (2603:10b6:303:83::20)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 23:01:03 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::e8) by MW4PR04CA0105.outlook.office365.com
 (2603:10b6:303:83::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Mon, 17 Oct 2022 23:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 23:01:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 16:00:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 17 Oct
 2022 16:00:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 17 Oct 2022 16:00:47 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 1/5] iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
Date:   Mon, 17 Oct 2022 16:00:45 -0700
Message-ID: <c054654a81f2b675c73108fe4bf10e45335a721a.1666042872.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1666042872.git.nicolinc@nvidia.com>
References: <cover.1666042872.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|BL1PR12MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: be357109-64db-4c7c-37ce-08dab09375f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+6g8VUjorM8f9Ep4W6pB7a8pWxhoIzVWCqzZQdtbF9IzafTzF/ofcX9G0oSfVs8V+ibJ/cWG6DW97ePUnS/7rla7py/qaUIpvFcwyb46FQ/083kWqOJeKJrQ/frpehP/3V3qbPp45bPeeyuJU16RLnNZ4QeFQft+52mb/KSY1ximO8N/ip8WVX9JgDpq55bwI9xHe9enC4F8v0vYYfcQVDR5S+NLennNVeUjgO91vAfoUaBEgZL42N0ijinsBAjfihuvTM3JqTpQge9wonKFsOf0Svz2mGwmg2V1WgppIZBUvy1MzZYAvksc17zmXvk/8ivlSxwlJP6qpm8C7hUUeb/hK4DYnxPnFum6mZOFbTteWtMlvZur5720RhigEGICv9aPnZG+xYKynEgZ2OguXVYJ9MTaF7JYxC+sN6J/H0KEfRETdWDP+gbYIv/wAkmaUXrdHCXCM6PxXaYe+sW5crcypGuvA7UmE3r9bj2Wn6dGDu77pEW+RH6XRI/84YyW5z1gF5X/xFrnm6IHZK3MvKxm25ePisd/X1EDRdHZC8lcA3c9vsM/e68PQdQQ6zfN+MZ/h/Nn9aupn42KkccFA1odxbWnrPBl+dgyTZfjTAjPTzbOeeFN7xl0E9HcrmtAZ+TjmqhJX/4/FU1UHCC/OYcQavanvHLah9es8E3v8mWnWrT2SZ0BwHe7aQcJeWcIP5/JNanflnGHsDzO57OawA2eoyP4mVFlYx1x8SaeofzLm51Yxc0pJ4U/CqbAC+EbRJuudb8Oe2s/r9s0heNrA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(2906002)(2616005)(336012)(186003)(426003)(40460700003)(8676002)(7696005)(26005)(4326008)(82740400003)(47076005)(40480700001)(86362001)(82310400005)(356005)(7636003)(36756003)(316002)(54906003)(41300700001)(5660300002)(8936002)(36860700001)(70206006)(110136005)(70586007)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 23:01:01.1226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be357109-64db-4c7c-37ce-08dab09375f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same checks are done in amd_iommu_probe_device(). If any of them fails
there, then the device won't get a group, so there's no way for it to even
reach amd_iommu_attach_device anymore.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 65856e401949..fbb2d1be76a0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2155,21 +2155,13 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
-	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
+	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
 	int ret;
 
-	if (!check_device(dev))
-		return -EINVAL;
-
-	dev_data = dev_iommu_priv_get(dev);
 	dev_data->defer_attach = false;
 
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return -EINVAL;
-
 	if (dev_data->domain)
 		detach_device(dev);
 
-- 
2.17.1

