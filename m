Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1C6B21FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCIK4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCIKzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:55:18 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E8BE8423
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3XSa1NB+uZX5VhKQzls4q9LKhD6ZgSmJ5aALTxhcaDRX3MNeOvsqd/HmX3pHpVh34qfBLfdxrW3Z5oWM4YO7eytMN1pWfLTmu27JGHc+9yUf8SM52MINJgSAWcRWrWuuiPu4yOiRq3nuOcaM3RjY/Iz9BLb5mPF9vICN5BzPKiwZNykzcchYXLoGoLHZu4m1Ua8BiRq5tbJm5YDHZEwPJ1//v6NbVPiFxXu42jmax7lGWUDBQsO2G0XVh7HUWhB0gaz5hbIGC6KpnP5qEPmYuIE/3bOvbci/0HShvcPyAx5apJCiu5BullmdOO70Tm21rPlfC3ywbHeN3Spt1Y/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBztAGL4Dhn5vTJ1Bs0zPepM3SJkBS2uuAlsDyd2xI4=;
 b=S09oMd43mcSTG/f3Tc2bZrMf3tBIDvahXaF6YzrrG4LBm5Ms7qQj4x09vIdnB+PY1/Q2MmJf1Z7iYJsCGEKmL5cbjS+9AuoAENyzlxBrHilTcUS4f5GpfsG2+GSDYLz1FiKUNIedjsoewXKjac/BurPWZQKlN7nFp9JCo2w4mAirHWQRT4A2SBfr0+L/E+o0dMgukb41Owamojqv1nMoqYgL57v8F7IxUoHRwz+6fxJRADbw8QB6WJAeChrD1SvGmlzisnbNem7UNmebPnZzCffIDDl1948WgFpbLzBuF9bv19+QmrP/NRojWAgxa5bZC31VmCAiS+TtlCH3mv725A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBztAGL4Dhn5vTJ1Bs0zPepM3SJkBS2uuAlsDyd2xI4=;
 b=td0QXMooG6zi+WawQit4BaEbkmS/5ZeJlYPqfa+g7K/rlZVte1NDR/MDvgVm75JlEgCKPpO3d97xn7EP9Lco/TZyt4VF5U53yPvLAMAlRFB2b5RTESNK0KWETicGTwsiwQso9otXwC6E19UClTNY+2h3m39CzZ4rXc2uNkUJ0V1+Qcp9V1e15CrVWYJ8iZr/1WPy0iFxHZFUdI+fjdEos8PRLDU3BA4cjbJeACVLFAHk+eCga8dC0rT4ejDgJrDSMM6zGG8z0EgH0b9A/FywBS1CbtbIAbs5hbfi+4vw+smH7doGasw2sAypo0HMpi3fIg+F6T+KL5F5KbJVvPIzzQ==
Received: from BN9PR03CA0792.namprd03.prod.outlook.com (2603:10b6:408:13f::17)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 10:54:57 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::9b) by BN9PR03CA0792.outlook.office365.com
 (2603:10b6:408:13f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Thu, 9 Mar 2023 10:54:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:45 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:44 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:44 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 14/14] iommu/arm-smmu-v3: Add arm_smmu_cache_invalidate_user
Date:   Thu, 9 Mar 2023 02:53:50 -0800
Message-ID: <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 707da11f-994c-464f-4114-08db208cb91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNxCBgug5Qm10VaMVAHqAoU6X5M/+cDj7TjdChldMWsHNo/Zpta018FEGS9eXf5E/Wt2BBVIEOh/GdrkvpjE7PVXukYF2uf2fo9YTjMKRpVQ/0xleADGVlkNoh+SYy4XaqjmWCpDSTP9z4wexw5Os5+9SRiUZPgU1J8Ansvv7ow+z9IdfAw1/Rppq4hWdPEsYXKrhptwtvcGA4T03+VtumbgFP8mcq7fT0V5eIYnaMExcjXs/m2L+gvbQ4CJVL0y0a1gbuEn4l5MXwyQtQYZ/sibn61d+1wE3nvCwQi5Kqy3V991YyjVOkFgaKe3upyneWz9GkkUUs8VT+dcnPmsWHqWACA8boJfHGeI7n+kmGHlrDA7YhLPDztEEbsTpp3pjtesErJ7lxFkUQ3G6kGbmK3l3IWLN83+AGNSwRVZa9xZF6pvJgtL3qabwAZfHARtc7+Yz85B1d9yg21ih2P0TaIHPTiKcyDfCDKcV4+GkjX/0odwhk4OBVjOFT53mn/Zm0uMhj0Dz3vx+268vAOjwz6QV7cDkgFwwmr4pvPAPkMjnX8SBLFIqK78TFOE/okqlpQBt0ajX/5PFY+HNGIFuum8REUjiBEIE/OE/OndThGPjg/3BRRYLu+SvoS/ObcK/NsKa+vin8qlsUNbp2Lc+wpj5b9p+6yPkCcoLy/3yvUfNpv58neVf2E/9fb+geOssubSWzLRfFcC/UdCV85ce2ZxhjkrGfUTR0JBmksKLdnbdyVLJgnUGUpYfU/Co1AN
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(36756003)(54906003)(110136005)(478600001)(316002)(7696005)(7416002)(5660300002)(2906002)(8936002)(70206006)(8676002)(70586007)(4326008)(41300700001)(82740400003)(7636003)(36860700001)(40480700001)(356005)(86362001)(6666004)(186003)(2616005)(26005)(83380400001)(82310400005)(336012)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:57.4525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 707da11f-994c-464f-4114-08db208cb91f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arm_smmu_cache_invalidate_user() function for user space to invalidate
TLB entries and Context Descriptors, since either an IO page table entrie
or a Context Descriptor in the user space is still cached by the hardware.

The input user_data is defined in "struct iommu_hwpt_invalidate_arm_smmuv3"
that contains the essential data for corresponding invalidation commands.

Co-developed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 56 +++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ac63185ae268..7d73eab5e7f4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2880,9 +2880,65 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
 }
 
+static void arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
+					   void *user_data)
+{
+	struct iommu_hwpt_invalidate_arm_smmuv3 *inv_info = user_data;
+	struct arm_smmu_cmdq_ent cmd = { .opcode = inv_info->opcode };
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	size_t granule_size = inv_info->granule_size;
+	unsigned long iova = 0;
+	size_t size = 0;
+	int ssid = 0;
+
+	if (!smmu || !smmu_domain->s2 || domain->type != IOMMU_DOMAIN_NESTED)
+		return;
+
+	switch (inv_info->opcode) {
+	case CMDQ_OP_CFGI_CD:
+	case CMDQ_OP_CFGI_CD_ALL:
+		return arm_smmu_sync_cd(smmu_domain, inv_info->ssid, true);
+	case CMDQ_OP_TLBI_NH_VA:
+		cmd.tlbi.asid = inv_info->asid;
+		fallthrough;
+	case CMDQ_OP_TLBI_NH_VAA:
+		if (!granule_size || !(granule_size & smmu->pgsize_bitmap) ||
+		    granule_size & ~(1ULL << __ffs(granule_size)))
+			return;
+
+		iova = inv_info->range.start;
+		size = inv_info->range.last - inv_info->range.start + 1;
+		if (!size)
+			return;
+
+		cmd.tlbi.vmid = smmu_domain->s2->s2_cfg.vmid;
+		cmd.tlbi.leaf = inv_info->flags & IOMMU_SMMUV3_CMDQ_TLBI_VA_LEAF;
+		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule_size, smmu_domain);
+		break;
+	case CMDQ_OP_TLBI_NH_ASID:
+		cmd.tlbi.asid = inv_info->asid;
+		fallthrough;
+	case CMDQ_OP_TLBI_NH_ALL:
+		cmd.tlbi.vmid = smmu_domain->s2->s2_cfg.vmid;
+		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+		break;
+	case CMDQ_OP_ATC_INV:
+		ssid = inv_info->ssid;
+		iova = inv_info->range.start;
+		size = inv_info->range.last - inv_info->range.start + 1;
+		break;
+	default:
+		return;
+	}
+
+	arm_smmu_atc_inv_domain(smmu_domain, ssid, iova, size);
+}
+
 static const struct iommu_domain_ops arm_smmu_nested_domain_ops = {
 	.attach_dev		= arm_smmu_attach_dev,
 	.free			= arm_smmu_domain_free,
+	.cache_invalidate_user	= arm_smmu_cache_invalidate_user,
 };
 
 static struct iommu_domain *
-- 
2.39.2

