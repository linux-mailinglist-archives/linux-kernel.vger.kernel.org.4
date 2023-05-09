Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041F46FC4D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjEILTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbjEILTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:19:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382D9559D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/YmRbYKNH3xsu0cnOBeVBDshBzKIa/fDivRcUpzv73l2/9xV76T44b18+ae+6my+xN8SEfW0xWe0QtAeajdyGg8npcz9hlqgKRKUrcgGMOXawZq+u6siDrnIXH2kqJ0lc8M+5mYivajAxAwJ1ORHbsePqikoT1vIQx6mBNm7C5qdSzDUeVMCIJj9ZfFgVBmFr+j1/kDCB/SaX+n6qWz4pEGWWWB96iIIO6Debac995jWts+sB/rI+Cby+yY4TcKHe8S4gOTlqSYk0yv8VNlcoapxyIMfj83Beoj8ECbaFAKxBAqbOyjNqY2O3h93jX/hcrEWsEgL4QURvWt8Ih5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na8XY8+v+09hLTC0mp6CNyfzjwdxw/Q+4594X4rFQQw=;
 b=k3qUKeBWoNoQw3z4C3qZXVZaUXpNaPCgpv++oljBlenmaJqDmzq87/ZDBzITYaqdDdAB06rhwzpPtXxChwYcHs/hL6yn9TUDjN9x/WK+kRO2LOT5cONGGQYgj9UIYkzpyjdEBapOEh45M1Iqlx3Rt0ZSVCVp019YEGArXsoHYcOkG8Psi6w2GM5yKBpC+OQXbA51EApCG92LRSe9hjaloHyTJgJABQNNeadHoZjRyiIIUI+lLz6H2BgTpscucOr/oMFR0yE/7GT0vA+/WXwjTNuSevlCmX4i7BQOuwVhKOdr55u/3AciskHbYFSKDAG4lVR2FuVIPS87i33ex27CrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na8XY8+v+09hLTC0mp6CNyfzjwdxw/Q+4594X4rFQQw=;
 b=wDxMlx/3CDmEQig4pr/ZX6OQcBHC9cvtajWxAbbX8xsTSY2801hUOHevyt/7TL+A/KZseXd+pajrndP4uBLCuxqeearFIGYc2NM4Q5VZvDA/yvS3N6EQz+h9HZj63xBmILP6+wq/kUEb06plZaYGDBbyJS7KpEffVAqpJc0r0No=
Received: from BN1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:408:e2::20)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 11:17:34 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::4d) by BN1PR13CA0015.outlook.office365.com
 (2603:10b6:408:e2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 11:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 11:17:34 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 9 May 2023 06:17:32 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/5] iommu/amd: Introduce Disable IRTE Caching Support
Date:   Tue, 9 May 2023 07:16:44 -0400
Message-ID: <20230509111646.369661-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230509111646.369661-1-suravee.suthikulpanit@amd.com>
References: <20230509111646.369661-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|IA1PR12MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: b84cb7c7-5881-4d04-b4bf-08db507efd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsYf1YGX80BtcybBQxjtVgD7bZqvipAUu0fZwrCOxTmSAP7v7atUFzVOc6iNlrRjIBk5+/+3cbEMQJSMvwJUHWVeBKZPC4vqF1LizDPle5lS8La4jaqGU2gv0xsfsp9cEzKoQ9IWnYJs1E192V82rChrvf7yXKJnuJiO7IT/T73Xfl+5eNVMtMRufYFjdrttzw2C5iGpasGP+yVPt40rv8dfhUyutXT3v84Rr+scoEPGlqrGksaXM/anoF1uxyUw3rRYQr3zfif5clumqhekG3diQ1zxYbSFdhoZRIkn380GysJknif0vqcsfSaw6XuBSZMrm7uR6BvO6EQ/Mz7LxmsIK4nq1ZO6awKFpjgbkBJ00DYa2Cf8gTdP1iD/wtydLc4LD+AcYX+B8O/u9ju2vcIfdjHfO3dpMl29L+dQAf0R6pE1Hrw+7195A8dRv4khyhSlBiYwKSeqeF9Gk2Mnonomru5/SrWTTUkokYw6w1KvLSmHBSnAih/Xfhmww3d46MmEzLUSD9mZ9gMGr7GqIKH3F4225QytHvAyPrtF7WIec5EdnHr8fh/eGVGfg0uVnEhdRpy7pxjZsULZcC0TDrSWNJ8QLoSUHJIBynxq21b/oYBtBtslBWYOTw3fuJI4vwXyzCmtzRkftH5912/ZRQlLjUzNjgf+uWTu1d4dHu14kRUkpv/gB+VdjNZBga6ty0OjcLtDyyf/SuYT8hNcAeyw+Uyyn8U/gZ3ZFHmufjo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(4326008)(2906002)(8936002)(478600001)(316002)(5660300002)(8676002)(41300700001)(16526019)(110136005)(6666004)(70586007)(44832011)(70206006)(7696005)(1076003)(26005)(83380400001)(186003)(82740400003)(47076005)(40460700003)(36756003)(2616005)(36860700001)(336012)(426003)(40480700001)(82310400005)(86362001)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:17:34.3896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84cb7c7-5881-4d04-b4bf-08db507efd08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224
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

Co-developed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
[Awaiting sign-off-by Alejandro]
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 drivers/iommu/amd/amd_iommu_types.h           |  4 +++
 drivers/iommu/amd/init.c                      | 25 +++++++++++++++++++
 3 files changed, 30 insertions(+)

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
index fd487c33b28a..01d131e75de4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -160,6 +160,7 @@ static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 static bool amd_iommu_detected;
 static bool amd_iommu_disabled __initdata;
 static bool amd_iommu_force_enable __initdata;
+static bool amd_iommu_irtcachedis __initdata;
 static int amd_iommu_target_ivhd_type;
 
 /* Global EFR and EFR2 registers */
@@ -2700,6 +2701,27 @@ static void iommu_enable_ga(struct amd_iommu *iommu)
 #endif
 }
 
+static void iommu_enable_irtcachedis(struct amd_iommu *iommu)
+{
+	u64 ctrl;
+
+	if (amd_iommu_irtcachedis) {
+		/*
+		 * Note:
+		 * The support for IRTCacheDis feature is dertermined by
+		 * checking if the bit is writable.
+		 */
+		iommu_feature_enable(iommu, CONTROL_IRTCACHEDIS);
+		ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
+		ctrl &= (1ULL << CONTROL_IRTCACHEDIS);
+		if (ctrl)
+			iommu->irtcachedis_enabled = true;
+		pr_info("iommu%d (%#06x) : IRT cache is %s\n",
+			iommu->index, iommu->devid,
+			iommu->irtcachedis_enabled ? "disabled" : "enabled");
+	}
+}
+
 static void early_enable_iommu(struct amd_iommu *iommu)
 {
 	iommu_disable(iommu);
@@ -2710,6 +2732,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_set_exclusion_range(iommu);
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
+	iommu_enable_irtcachedis(iommu);
 	iommu_enable(iommu);
 	iommu_flush_all_caches(iommu);
 }
@@ -3411,6 +3434,8 @@ static int __init parse_amd_iommu_options(char *str)
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

