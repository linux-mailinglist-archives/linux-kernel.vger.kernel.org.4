Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D651F71634B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjE3OMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjE3OMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:12:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C428FA0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+rMbqzsyFs7sAMww2Mz6mJtnRNQmgJOdlr/kunaDgLrXK7hVw5NiFEfMUe53k+dlB9kRATMvHwgjJwodNAOtblXwhxrBV5toZ/TJK6qIKlt8Te1Qh/FArt6hDGSHMElXrWBlU0xBmNsfLt9zZ1gEi/iPPAZH4144JSASQ9MbKmiAgqaTmojQDauP0UFjoGMV5/Ia4LHGYfRkdz69/IhQS9zaPsVdQbsEawFVpqpUTjhmy7Jo0dB8mlK/pfNBPZSTatQ4AXbcFwELKh5PUfe3xUOzm6kFKUkLn+cDhHB0OSiuzkv5xPRpVVyXgYYHfHokfOOWh6+ZJ2dJPymaD0TaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZYs+r8uNjVf/8lOAlN48BpcDCsnxQBl31dbkVBXYTA=;
 b=IgQwfOdlPknHfXYZvIG8OaU96reqam774Lzejy+O83ZIITuo0/lLbOzn1RxfzsM5p/qBNVQHC66JFHywkstW+PnCgROkKrde9pRLdo1T9eRG0qg6Ws0F4oIJCbY4rO4STP77Vvo5V/6FHyGHFfhE0NkvgYudnQXBXp3kEFH2x07p+0JDk617P+IIYlJTUKhYIsAIhtG/ktTc7FfxsZzwgkS7LE54QfUHezh/APWpcM+trKeeSTnfc0nM8oi1lMtmGzLtJALgjJXCYgQvW+wnjKf9s60y6S2tZUtl0j9317t5my1tEAmME7bwOyLsKkYBig4Bnb9p50T2mF9FznI+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZYs+r8uNjVf/8lOAlN48BpcDCsnxQBl31dbkVBXYTA=;
 b=KehOOcJoLT/H1QWp2XzTYPeOXukSPuSH3Gw8kdmpx2+y4geg1AIVb+/MTz3MZ2sAo1G0S+WX1nt+6f9BOaTKZhZGpfm0TMxQqBKhh2spms5H9WCam2ht90+R0FAdAjleyHDgIWWfan3g4qEV7gV29+BHJQdZF3+0LlirnL8rxVs=
Received: from SJ0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:a03:3a0::32)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:12:05 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a0:cafe::6e) by SJ0PR03CA0267.outlook.office365.com
 (2603:10b6:a03:3a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 14:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:12:04 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 30 May 2023 09:12:00 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        <jsnitsel@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 3/5] iommu/amd: Introduce Disable IRTE Caching Support
Date:   Tue, 30 May 2023 10:11:35 -0400
Message-ID: <20230530141137.14376-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
References: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb980ea-2f3e-4d8b-e24d-08db6117d8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7axUAzPtV9sPuoqUQjmnq5fpc1A++9wVUR/iONPcsimFDiBIKGAAzpMLfKTqf3ReSQhpQnd+JyjbKPxGxFULBBhb53al4Gb+Xyp/hlgl68bAO/M/xxbIYNaIcnS5FoxN2pKCVZUgBjMTJKNy4XnCfUY3vlNJgDRtRJa6SffZ4I17NHiHpZ4plfKV4PqyU7qXYNWHM+yhnBLhwGFdLe55Jvf2Ookop0ZFI5OnphyTm6YINXK7ndewZsOPH2OgmqbohwY7lipj7alYXoD6zc2AbH/deK7FoZ+jJV8BcClOAR58WADpPmMFVTaPQ5/Af/gj0/cj1AhizL5BX9h0pyolMZE/ND7bBxnrA/p3wp3YXbgirePfQ7XFXWurchl6FCNMlL6okjNaAEG4oJv84z7FJTaPCHH3DD6wzW6LCGHmPj6b8urfQPcL51oljb/vdnABnvUfsp+QzMnQXT1i0z9BsI/ugWiOwc9SeQ1C5/wT752d1N4aznrJlglJEu0YgitjNCMevBU6KWCYie0kPN7eiH5wC6Yb0O3j+xU2tPk5MmpiFMgIr2my8t8C5UbtJZoPNa+/TajxKwyj2sFGmdlQCruDjG5fLLTtcQkX4MxmeWVKQCw6dOcY7Bo0GskQjgZ/17jZh+C936axCpUZKGBHDykFz/Mh/s7tLwLquX7TzEj0iRGL6IY6lNEhq73tUmvfMVoPPVcP6eNsoqo3z8SKmV8pcysD0mW0rP1rG3H8gI1yQwxJw7C4MhL/M6c+tj916TnIi9WUnEFy3vWjkuLNEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(40460700003)(54906003)(110136005)(8936002)(8676002)(5660300002)(44832011)(86362001)(82310400005)(36756003)(2906002)(356005)(81166007)(4326008)(82740400003)(70206006)(70586007)(316002)(40480700001)(41300700001)(2616005)(16526019)(186003)(1076003)(26005)(47076005)(36860700001)(7696005)(6666004)(426003)(336012)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:12:04.8346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb980ea-2f3e-4d8b-e24d-08db6117d8a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An Interrupt Remapping Table (IRT) stores interrupt remapping configuration
for each device. In a normal operation, the AMD IOMMU caches the table
to optimize subsequent data accesses. This requires the IOMMU driver to
invalidate IRT whenever it updates the table. The invalidation process
includes issuing an INVALIDATE_INTERRUPT_TABLE command following by
a COMPLETION_WAIT command.

However, there are cases in which the IRT is updated at a high rate.
For example, for IOMMU AVIC, the IRTE[IsRun] bit is updated on every
vcpu scheduling (i.e. amd_iommu_update_ga()). On system with large
amount of vcpus and VFIO PCI pass-through devices, the invalidation
process could potentially become a performance bottleneck.

Introducing a new kernel boot option:

    amd_iommu=irtcachedis

which disables IRTE caching by setting the IRTCachedis bit in each IOMMU
Control register, and bypass the IRT invalidation process.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Co-developed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 drivers/iommu/amd/amd_iommu_types.h           |  4 +++
 drivers/iommu/amd/init.c                      | 36 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..f29dee600faf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -323,6 +323,7 @@
 				       option with care.
 			pgtbl_v1     - Use v1 page table for DMA-API (Default).
 			pgtbl_v2     - Use v2 page table for DMA-API.
+			irtcachedis  - Disable Interrupt Remapping Table (IRT) caching.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a0ff1e852efc..486a052e37ca 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -172,6 +172,7 @@
 #define CONTROL_GAINT_EN	29
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
 
 #define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
@@ -708,6 +709,9 @@ struct amd_iommu {
 	/* if one, we need to send a completion wait command */
 	bool need_sync;
 
+	/* true if disable irte caching */
+	bool irtcachedis_enabled;
+
 	/* Handle for IOMMU core code */
 	struct iommu_device iommu;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index fd487c33b28a..fc0392d706db 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -160,6 +160,7 @@ static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 static bool amd_iommu_detected;
 static bool amd_iommu_disabled __initdata;
 static bool amd_iommu_force_enable __initdata;
+static bool amd_iommu_irtcachedis;
 static int amd_iommu_target_ivhd_type;
 
 /* Global EFR and EFR2 registers */
@@ -477,6 +478,9 @@ static void iommu_disable(struct amd_iommu *iommu)
 
 	/* Disable IOMMU hardware itself */
 	iommu_feature_disable(iommu, CONTROL_IOMMU_EN);
+
+	/* Clear IRTE cache disabling bit */
+	iommu_feature_disable(iommu, CONTROL_IRTCACHEDIS);
 }
 
 /*
@@ -2700,6 +2704,33 @@ static void iommu_enable_ga(struct amd_iommu *iommu)
 #endif
 }
 
+static void iommu_disable_irtcachedis(struct amd_iommu *iommu)
+{
+	iommu_feature_disable(iommu, CONTROL_IRTCACHEDIS);
+}
+
+static void iommu_enable_irtcachedis(struct amd_iommu *iommu)
+{
+	u64 ctrl;
+
+	if (!amd_iommu_irtcachedis)
+		return;
+
+	/*
+	 * Note:
+	 * The support for IRTCacheDis feature is dertermined by
+	 * checking if the bit is writable.
+	 */
+	iommu_feature_enable(iommu, CONTROL_IRTCACHEDIS);
+	ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
+	ctrl &= (1ULL << CONTROL_IRTCACHEDIS);
+	if (ctrl)
+		iommu->irtcachedis_enabled = true;
+	pr_info("iommu%d (%#06x) : IRT cache is %s\n",
+		iommu->index, iommu->devid,
+		iommu->irtcachedis_enabled ? "disabled" : "enabled");
+}
+
 static void early_enable_iommu(struct amd_iommu *iommu)
 {
 	iommu_disable(iommu);
@@ -2710,6 +2741,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_set_exclusion_range(iommu);
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
+	iommu_enable_irtcachedis(iommu);
 	iommu_enable(iommu);
 	iommu_flush_all_caches(iommu);
 }
@@ -2760,10 +2792,12 @@ static void early_enable_iommus(void)
 		for_each_iommu(iommu) {
 			iommu_disable_command_buffer(iommu);
 			iommu_disable_event_buffer(iommu);
+			iommu_disable_irtcachedis(iommu);
 			iommu_enable_command_buffer(iommu);
 			iommu_enable_event_buffer(iommu);
 			iommu_enable_ga(iommu);
 			iommu_enable_xt(iommu);
+			iommu_enable_irtcachedis(iommu);
 			iommu_set_device_table(iommu);
 			iommu_flush_all_caches(iommu);
 		}
@@ -3411,6 +3445,8 @@ static int __init parse_amd_iommu_options(char *str)
 			amd_iommu_pgtable = AMD_IOMMU_V1;
 		} else if (strncmp(str, "pgtbl_v2", 8) == 0) {
 			amd_iommu_pgtable = AMD_IOMMU_V2;
+		} else if (strncmp(str, "irtcachedis", 11) == 0) {
+			amd_iommu_irtcachedis = true;
 		} else {
 			pr_notice("Unknown option - '%s'\n", str);
 		}
-- 
2.31.1

