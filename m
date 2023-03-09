Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DEE6B21FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCIK4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjCIKzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:55:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE7159E7A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5t4uakCxMpGR0K+0YPb5jylaVti0xnhytb4t8HVU7uEyocXesbcpVPme4nKdti7UG1EPnzKwnnxVBaHZiReC1YU8eJd8OGYsXjjUAHp0QNO1HCP1GwjSJqIlr/JhMfA7/4nMpB3HQYO4h9TwjH8/XyRgnaCprTaqVRduxhai99fRhrfk9Pi/tkMWx0kVr77QQYdU29jTD2uONvgXG2Xzzs1bwRz81y5cDfHd9Qtzp4nNm7pbthnZCgfJKnqPUfearl32pWMMpNePFMnvIYByhrX0VPohWcEAbPYJMmudQhbftF3qNQwTi6EysYBdxpcB4wqewYfN5JIWQMMfYayLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIfOVDKmZ8OXI3O0ZYUaQ7tXZq1RKFWIxLbQkns0a+o=;
 b=d245wBaZcVJ+Xb/gDH/JmmFQgrG98jPrxDS2dSOLg3nT/CAMZkkE+XEmFUgqZ+UmyuWrrKvjD1KLxH6Qh4GUCsTgr8JmRaglhWVnR1tG8DdQQ8+PoMsvwNEbTBh3aOgZY7rIcVWsvf4/yocuSasQ+CRaG8HQ2TZ+e8u1+8UWdEC29qO7iw5P/Bg1ZLDEnC7a8ZoUpjkJ0ylR6UrQidElUTDFQDr3UvWFp61kC/tLqjMezp83oGXkCm91o4K+IbeCuqhCuFH5OtN4wuRDASwX6kVUBcmMjLRndnys36aQnxIyzHZWlke3BzoGvqWx/0uKU7q6toJn19fcG/cjhdywXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIfOVDKmZ8OXI3O0ZYUaQ7tXZq1RKFWIxLbQkns0a+o=;
 b=qxClTDW+11qo6475HBfp6IzH/JAeER4mQ4MdXLCPxp0lbvjDPdSJZKauZE7NAOZBLcBKkDy9c6e5A7zapIR/Db7sjnLT++WYfsib6NsJUTQPSWTdgXX0CxDhmM2JRc9WzRSZ4l3Py9R0t/vSaVk0lzoI426D8Cj/wXepdC+JJchknfEBGrUAMWeAgIRELWaNnlArku4fByziRXG47nb2fxq8OYg8eotHxFtKjnjIL4eOeLwwiKxg1+EfaYah/13g+7LpA05u8F/BBzxUVkptVS7lf4FV3b4TDuZLRyMTDqfvFpi97FbQig5TP09FT0WAbr9oN0YAMvZ5/sLJ4xjRJg==
Received: from MN2PR22CA0015.namprd22.prod.outlook.com (2603:10b6:208:238::20)
 by DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 10:54:57 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::c2) by MN2PR22CA0015.outlook.office365.com
 (2603:10b6:208:238::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17 via Frontend Transport; Thu, 9 Mar 2023 10:54:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:44 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:44 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:43 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 13/14] iommu/arm-smmu-v3: Add CMDQ_OP_TLBI_NH_VAA and CMDQ_OP_TLBI_NH_ALL
Date:   Thu, 9 Mar 2023 02:53:49 -0800
Message-ID: <3b059f4b0bda1e83d402248114a774186f678387.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|DM6PR12MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: e29bf047-9f56-4d24-76e3-08db208cb8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G60v53t1DrhomcTjc9JQINaiVEMjq537xZJbzQ3EcfLS1CEnnR0GT5f38KoE+t72ej4O7+cpEH9kn56O+Vrn3Cdt1Vptul0J/6iFoiwU0xH3dqx7HKvntgMKTOJ6kwupbGSGixUsREFzLFUl6BW+a4XSnTdwSotACUMRIfYcScTc6ReSBr0iKp/+jaVgnFJG9y57H2lm79PhHICwnBysQg+OTfu0VN7VJ93T+ZRsz6T+XRbadhEJw4nN5xJjbAMifs8ZlSp33Rz5cYbicHlKl1RDq5hCC4F7pXmfKVlVqSILwoyzfIgURRXXsYx9j/ylRpE37kpUUrzXnWtn9asQuQxYUYgGZqjFls/+K4hHPkK49575la/ispih/+85euskJwMojsyRD3/vd3H5ioTDx03yo9gX87JqVEVUR8hmD6F9HC01T6T6WsR8LJJaFVOGKaVhxZtjlSFSvPmledDSP7pPQPy4DAOT0JdINkcJOMKwfvBhfjc4U+unCM4pLo/KwepF/Isqkcr6zbg7reEXRIDtMv55D+yglYhrUzusqveUldJB4Zdn3FoHvwiWWZHVt04HQXLuZ8FEXBLS+EaCKKmZKNGpozx2bKrZxX65/7XTlwUy1Cvr0XURipHW1I1H2FvYZMg0QmJKh5HVxxCow3tw3Ch2PKD6OrJhP97LUNNECz2fu/WagOjCs2QaIuLPL9QWuddSPFjMyEIzv64vzjuM80qzzGr+IQWOdbHzpL4jyjKP+x/2Jfr3NtvzyN5Y
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(40470700004)(36840700001)(46966006)(356005)(186003)(336012)(2906002)(82740400003)(26005)(2616005)(7636003)(5660300002)(36860700001)(7416002)(8936002)(41300700001)(82310400005)(110136005)(47076005)(86362001)(40460700003)(70586007)(8676002)(40480700001)(70206006)(4326008)(478600001)(426003)(316002)(7696005)(83380400001)(54906003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:57.0410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e29bf047-9f56-4d24-76e3-08db208cb8e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a nested translation setup, a stage-1 Context Descriptor table can be
managed by a guest OS in the user space. So, the kernel driver should not
assume that the guest OS will use a user space device driver that doesn't
support TLBI_NH_VAA and TLBI_NH_ALL commands.

Add them in the arm_smmu_cmdq_build_cmd(), to prepare for support of these
two TLBI invalidation requests from the guest level.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1f318b5e0921..ac63185ae268 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -277,6 +277,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		/* Cover the entire SID range */
 		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
 		break;
+	case CMDQ_OP_TLBI_NH_VAA:
+		ent->tlbi.asid = 0;
+		fallthrough;
 	case CMDQ_OP_TLBI_NH_VA:
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
 		fallthrough;
@@ -301,6 +304,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	case CMDQ_OP_TLBI_NH_ASID:
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
 		fallthrough;
+	case CMDQ_OP_TLBI_NH_ALL:
 	case CMDQ_OP_TLBI_S12_VMALL:
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
 		break;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6cf516852721..6181d6cd8b51 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -454,8 +454,10 @@ struct arm_smmu_cmdq_ent {
 			};
 		} cfgi;
 
+		#define CMDQ_OP_TLBI_NH_ALL	0x10
 		#define CMDQ_OP_TLBI_NH_ASID	0x11
 		#define CMDQ_OP_TLBI_NH_VA	0x12
+		#define CMDQ_OP_TLBI_NH_VAA	0x13
 		#define CMDQ_OP_TLBI_EL2_ALL	0x20
 		#define CMDQ_OP_TLBI_EL2_ASID	0x21
 		#define CMDQ_OP_TLBI_EL2_VA	0x22
-- 
2.39.2

