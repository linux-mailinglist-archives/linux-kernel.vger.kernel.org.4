Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE4F664352
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbjAJOdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbjAJOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:32:25 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA42392DB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:32:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRP/fqwjHyK6qLS/VpSQi10ghPsSvmD2qbo+4bm2qeVt3NYMc7n8VC50A+Ht+i1cw9pOGmruk3WcrVZubtIebzzZTyBP324QpimoPscrw9RLHjPjh43kcf4aW744jbLy09ZD58Se/HmgSghb6GwNMWBMMgWpEOqHN31JR7VY/cYBraC22YC9GDq7rn0ITHNQ+uSC6O3Vrg9dc+0ZDzsDgpP2oLT48OE2d2+VtWS2OX7zcEVXtU7OjjS/iELjz3tw2WKAAbbRQ14hWTfXiHr5hYu4MIBQddDNCJYFwDTSyAMT1A2cps8QAHyjF/MhLyCyGl3NZVZRPFShOAWY0S+kGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Hml2OgICGSdq5+zxCec5xRf761M3ZO15RZ+4MkXikk=;
 b=kEdxUk2fHdjQ2Gzw+eESpunJ2Dk814Glytl3mIBldTc1IiVv6vLQFk9m8HiFdgEYApux7C87D/fs4aBbEPVy1/joeHxXB5pXfjf5KWlFKkwr3BxbW/IE/5uchzecIpxujZXmtLt5H/DCZBrEWL2IbFlWNn2ltxTzQ8JAdSJ3Y5voU3Dpu+58WMwJtAMLwDtoOxylqWRxLBKpdKbXh3S9VVVpzUsiZpBEYEUJIqgbxX1pUVyhEWAPSkCf4e5vYwrFSMpAQZHTQb9ocGmdq6WGEXBrIIgPr1Tjngru8gLTSi8CnExQK3RdG4V9SPpqnyeWyPh2MhQQmGvsCJkDmiOaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Hml2OgICGSdq5+zxCec5xRf761M3ZO15RZ+4MkXikk=;
 b=O5TrMh2ZGy2CVChOeJMxD6u4ZxiucsM4vEbq8fqj/0P7tg3PaJEA9F3u/UFk3s+QzU2QcMjponkTyaLSedXFXM6xj5ln78gCUDFXycFgGvdWm68PpmAvv9Y7xrP3LTqcUxwPRLUBGIujPGAI5oYovAnFJW4c3QOa6jM0k4Ir9Yc=
Received: from MN2PR15CA0010.namprd15.prod.outlook.com (2603:10b6:208:1b4::23)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 14:32:21 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::cb) by MN2PR15CA0010.outlook.office365.com
 (2603:10b6:208:1b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 14:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 10 Jan 2023 14:32:21 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 08:32:15 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
        <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>,
        <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 4/4] iommu/amd: Force SNP-enabled VFIO domain to 4K page size
Date:   Tue, 10 Jan 2023 08:31:37 -0600
Message-ID: <20230110143137.54517-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: a3042d14-b2d6-448b-a695-08daf3177bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3wq/UUgiK6IHLmMEwGaKfEHuayOXsVMDi7GrVIx/4w479hmtJtFit/ADT2G+x2G2DEosafxZwVjuJ/1uZKmiqxP4IBEBh6N7hXAn4rl65F7OQDy9xUSf35AjZgQZwJDrPq3YfB3BIjX6CC2sG7GVaNYJ9AeCDcZ1Bgkm3eEIwFZuG2/MRvaDdpf4v29EVWozWuydr7KnREjYQisoBx5KIGEVrQYqDnRSTocGNlKXOJYFxZfmhnq6FlqBM7/IDK0horNTQu3vb8uFmtAqxZbWdR90OqWvE/j0rU2WVY0i05l8RNNQHWwMAAi2CuyEZJW1J3dgnsyTXDWtdn39j8O2/K6Edt9mp1hK/NEsq3FkNJSyCIBuCR23OOI4gSbXB6SrlRWfgMpK3aK49BAVqXxQCzVbiSCaUXvsaqiHEeqyu9G1jsFoS9GW6Q11Yq/cwNSEC+tONXJbOcy1d4NXrTgliNc2OTkeUjxXG7s3ltufhOltZpWC5bSE1Wmf4Aj5o0aDQjoPZ94u2krhkbN8ALaAf0S08U8pu7MFRy6WL/0TLtjdmsqkEk4ofYTnVngVfKCS+R9WF9OpmaUkt1FOhU+G6YVkJN+JWx2uBihgkAtPX49CI3mqHnBEas0DZRq74XYuQ1EonL4IPWxgt4xSYhPa8hU7DpeRfYCNxTcnunW7JqqMl9n+077otjiOgDDJcDZt6fgIp1+h3Hs95DqHgmBfF3j/03oza5GtNoZ1+3pGwc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(44832011)(8936002)(2906002)(5660300002)(4326008)(70586007)(8676002)(70206006)(41300700001)(82740400003)(82310400005)(40480700001)(426003)(40460700003)(316002)(47076005)(336012)(6666004)(36756003)(36860700001)(54906003)(86362001)(26005)(2616005)(186003)(110136005)(16526019)(1076003)(7696005)(478600001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 14:32:21.1963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3042d14-b2d6-448b-a695-08daf3177bc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SNP only supports 2M and 4K page sizes. Other page sizes requires
page smashing to supported sizes. For SNP-enabled guests
with pass-through devices (via VFIO), it also requires RMP and IOMMU
page sizes to match.

To simplify the support, for SNP-enabled guest, SNP will smash guest pages
to 4K page size only, and IOMMU driver will setup the IOMMU v1 page table
for the VFIO domain of the guest to match the 4K page size.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/iommu.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ad124959a26a..5249ac18ce6e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -279,6 +279,7 @@
 #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
 /* 4K, 2MB, 1G page sizes are supported */
 #define AMD_IOMMU_PGSIZES_V2	(PAGE_SIZE | (1ULL << 21) | (1ULL << 30))
+#define AMD_IOMMU_PGSIZES_4K	(PAGE_SIZE)
 
 /* Bit value definition for dte irq remapping fields*/
 #define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
@@ -440,6 +441,7 @@
 #define PD_IOMMUV2_MASK		(1UL << 3) /* domain has gcr3 table */
 #define PD_GIOV_MASK		(1UL << 4) /* domain enable GIOV support */
 #define PD_VFIO_MASK		(1UL << 5) /* domain enable VFIO support */
+#define PD_SNP_MASK		(1UL << 6) /* domain enable SNP support */
 
 extern bool amd_iommu_dump;
 #define DUMP_printk(format, arg...)				\
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a03723930f70..9a1b010a7d00 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2422,6 +2422,33 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
+static void amd_iommu_set_kvm(struct iommu_domain *domain, struct kvm *kvm)
+{
+	struct protection_domain *pdom = to_pdomain(domain);
+
+	if (!amd_iommu_snp_en || !amd_iommu_svm_ops ||
+	    !pdom || !(pdom->flags & PD_VFIO_MASK))
+		return;
+
+	/*
+	 * The parameter kvm can be NULL when calling from kvm_vfio_group_del()
+	 * and kvm_vfio_destroy().
+	 */
+	if (!kvm ||
+	    !amd_iommu_svm_ops->is_snp_guest ||
+	    !amd_iommu_svm_ops->is_snp_guest(kvm))
+		return;
+
+	/*
+	 * VFIO Domain for SNP guest requires IOMMU and RMP page-size to match,
+	 * which can only support 4K and 2M. Currently, only support 4K
+	 * IOMMU page-size.
+	 */
+	pdom->flags |= PD_SNP_MASK;
+	pdom->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_4K;
+	pr_debug("%s: Force domain %u page size to 4K.\n", __func__, pdom->id);
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -2444,6 +2471,7 @@ const struct iommu_ops amd_iommu_ops = {
 		.iotlb_sync	= amd_iommu_iotlb_sync,
 		.free		= amd_iommu_domain_free,
 		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
+		.set_kvm	= amd_iommu_set_kvm,
 	}
 };
 
-- 
2.32.0

