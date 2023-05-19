Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC836708D21
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjESA4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjESA4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:56:11 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577FE4D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0up4405n7xj8UNb29HU1kfa/aIW2/9GadrZ6lM7l/jdZcBTYtuYq/yTZKHd/F30C6n5dQr5uDbxbo0/puZhw28le7a+Y0yPevkCB+IZ2yZkbwcbZnvuc9oaeYgbDuHdPxvekhPmZQZQsDu67VLmBtjdI2K0QsMVf6UPuuzXTAWFALi+db3XiyEgACOOLT4nPlZ3UMKncFPQei4YXdWSdOur5QXhRbESh+QLSWIIA4QhoUS4UMHfpLad0QlaWm4AbASlBOr0FWvqRVxAtXXi6pOMpUcLzm3EJJb9KV73Baz1SXTcROosaaVZGqhSWX2IfFxDLHCFduspx86dtysSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QRkdaTr/h82mc4KGaAUkBtPAdSTgCfBPg3JcGX/zcY=;
 b=jC33ijOu5mXj6RBNx67ZPhNR/+VNqPvAFnO+RceDvHmbOEv2VO4LZQi6yHQDlO0RGBmEX8Fk0XE2gdDrWBEEPQc3GqylWXHJ8N2JE9jpXO/GZ9qvVf8dF9lAsrp6pHe8I0YZWNkDChQ0Rw1aF0h96iGo+eQdeiA1ERuMYTBZD0c62Sx4/MH/X2JHXP8UD9FvMH7waXq9x8OEyQHrdTN+rPho17Tdwq9tW+lPTiwh0M4cmdn1UjtWvkkio58Bskn/TCxTyS1H02RD+MoDk3d0zVMtC0wT58wJXSxlO1SfoyE2wqnUREaLsb2uJPtEHvEkv1q90HYwJCJYpgNSdVFL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QRkdaTr/h82mc4KGaAUkBtPAdSTgCfBPg3JcGX/zcY=;
 b=jfR0xZB3nreRv6zdbAeFbwO4/+ZnKcebdNswbIf1z1YduRJRfrsAD9IphoVLII/Ty5KEmxTlNc4B4BrK6aKFr+Pf78IceK6wlRgRNSJzQ2s+Aip9jN7FKe9Sla/bw43ks/ZYLa30apsUXJUBaZjK0OSt9CWr1rP4qVc2hS3PULA=
Received: from MW4PR03CA0199.namprd03.prod.outlook.com (2603:10b6:303:b8::24)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 00:56:07 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::dd) by MW4PR03CA0199.outlook.office365.com
 (2603:10b6:303:b8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 00:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Fri, 19 May 2023 00:56:07 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 18 May 2023 19:56:04 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 3/5] iommu/amd: Introduce Disable IRTE Caching Support
Date:   Thu, 18 May 2023 20:55:27 -0400
Message-ID: <20230519005529.28171-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf0ae2e-cd22-450f-3f0b-08db5803d438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMhw6UF6czx4XAmZbsVsAeV3x5WG+cPS+s73wGpqEXmfFWKSoo1DO+d5IjF2P7BBBHwBX1Crvh64NAN+/XFeguumm89uRgPJl7QJqMJWn/NRVQZGo1U3QgKOvVqp/RQLO+hjBE5bVFugPD9Dcr06PZW8DsuAHEaq7i0ibSnlv76rPy4pAqOPL5P6Iue+8rs0kIUN1Kys7t+35hXoNCi0Vwnf1R/wNMcXaU/JL7TYlAXkT7naB6WRmWXdxUNjeE8bHzr8vljdsk7dQbILfjUurktxFKpv5F7BgU/7uy+DNN6omsZ1yYoWXi67+eFk+AI2DiTFHVMf8T0XmIPXFck2rTuLyNQ40qbduwCF50tNyrLtqk1bm1bHrWVOFrHDx/BLhp1SlVjkhF3OdYiW5Sh0B9Ubsi6KWlLVvPV/L/TQ11usJgI6RkBOVA/tLA9waOedapa6nFmEy+6BRcqWnAGZU4yoZh788YJ3SlkBh0YDEc/CWpE0dZFSphZBtuH7qyzyRoSWEFSTEnOKBgh7rlbSapuav6aKdsjUVnXf0Dkt1swvnP+kumptJJhb+qUeHOJ7rEYnHIfYrOCYFkjrkWB0SufuX5mYJIIn273bL7XcvrK0Zn89moxEvdhYj3CgZ858xa2us2NtAP2ejxpXo7XUvMtjJao5+XyRzh8W9qdwp9CmrNLiVjHy2dykm6bPKGAwNl0lLD/Y98gCsT6Tpin9X5SAbtbSScpHs5+ArGhXGWwE9jsnfuJ19CNCgUdmRlJrM9UL+TX4wR+cstvqQR3+sXytwth8zI6pzMk6RCtulTpC6QuwMPGrde/Wxk3Ja4Fg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(7696005)(110136005)(4326008)(478600001)(70206006)(316002)(70586007)(54906003)(40480700001)(6666004)(82310400005)(44832011)(8936002)(8676002)(2906002)(5660300002)(336012)(81166007)(356005)(41300700001)(82740400003)(36860700001)(16526019)(426003)(26005)(186003)(2616005)(47076005)(83380400001)(1076003)(86362001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 00:56:07.0096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf0ae2e-cd22-450f-3f0b-08db5803d438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
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
[Awaiting sign-off by Alejandro]
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

