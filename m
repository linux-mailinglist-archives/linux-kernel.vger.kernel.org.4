Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3511F6D8F5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbjDFG0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjDFG0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:26:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4439011
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngv/2j97fH1q1u+HPZNw+myQJYneziGA/lnYoMA8F4GOyvcTRoSaSB8sNe4aNJxHqBq5H5lpSB650G2C46iGKbUpR8F+Oyim5qrdVCC48iYvXOOBPzPzsJbGZYvbUfBeAUuPjfTIbKPKPZXa6tW1AFL9FkEQllpJIjd67MvP1F1GLqND4T7c7n7vc+G9lAYYh6ECXCHXifM65T6aSVxC9BcPI1XQchvcscH9tKChyqGp/s8KlQrCsp+PADDpfrhLAYD11zIF1t1FcRIBOoyhV9x6eNqLp4tczOxKKAnIuWirjEZ8FTZyV6TlnDYCu2A/W2k0BCYS42iLpUipVg5U6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQ1ZD3yQu0tlpaYnsC5KDJ0bq7VJM6KFLaBFEEW8p0k=;
 b=eLJfhzdGl906hxGEjNT5Majm0qduDnFp0xW/Lgdu8x/QZlFt2YLjp02dstLPGktMViDaoep3wPypoDxq3PkRW389Go1S3osQ/zhgziLAPVuzMLd2Tfv6RS47vIRvCxJe9T015tcDe+D2y/aBaPPq8LMatYj/e+lYTaWdEeLrqc7F22mmB7sGICEBPM2C4eZrSoF04RngZtSOGHJ5yqmy+MKXnCT2Df2Z1ZM0Z7JuaFRGOh8LxXQqoMiY/631YyhhW23TSip8L73SngMNP2GDWaSuHewDPk+Mbqut2j9B5WYjNxkkzJDC7vI66uDruBWTVG9kulcZ7Ji2fmjXd6nIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQ1ZD3yQu0tlpaYnsC5KDJ0bq7VJM6KFLaBFEEW8p0k=;
 b=q/09NP+8cEVWyGD6I/xTOZV5KQ4WGuiNhv7gKnlf8UvuntW3qNxMR9JQcO7arE0ta0G71PzuRnUOF+r42Fkg4leQPDLvPlHTZUuuXfYFLDsDeBtxa+jQq2cAYtx4wIXTjKHDEl1+uyEnhnjxPJ6UdcTV4Na9d6ITK7ItD0FQx+iMECB/KeCwRnvBfPyRYXZwC+HG5AsYnABAs2rhxl9X7xpjsfRKLzf07/qzKZYpsdSaC6GHCc9+v5edREbbAF3rVjdx9wMlUsM7n2wOBehgJyXwcDF4L7eoVplGUPC2e7u/Ia8/2/TSuhGoI5795IPKN1MbBd0OCcKZqDDlwndycQ==
Received: from BN8PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:94::47)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 06:26:37 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::85) by BN8PR03CA0034.outlook.office365.com
 (2603:10b6:408:94::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30 via Frontend
 Transport; Thu, 6 Apr 2023 06:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.31 via Frontend Transport; Thu, 6 Apr 2023 06:26:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 5 Apr 2023
 23:26:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 5 Apr 2023 23:26:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 5 Apr 2023 23:26:21 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <kevin.tian@intel.com>
CC:     <eric.auger@redhat.com>, <yi.l.liu@intel.com>,
        <baolu.lu@linux.intel.com>, <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v1 3/3] iommu/arm-smmu-v3: Implement set_rid_user and unset_rid_user
Date:   Wed, 5 Apr 2023 23:25:36 -0700
Message-ID: <2f00c7faa5c8ddfb4b94e85d3c5af7a0fa8df35d.1680762112.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680762112.git.nicolinc@nvidia.com>
References: <cover.1680762112.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f1a9c2-1c8d-410f-e396-08db3667dff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XqCRCi2antXc8Tnl/pm7D6EtEgtrmjiS1pqhz6r6h8IP2hwdzs4yXVZ2IL1D3klqPTBE2JwCQGUaXjBwhZjm/tIU9GuMDyiOin/gJRto2fhy5TTRMi13Q/ZseQBgBGrJmq929bsjlbLQk4pK22mmBZocEBcCxFALYJpj1t7EhPpdDViaZHxMuVq41/fQsrlMWwToA1RskAOiLmSwtFJjYxTKfl36SkDHmL+9D7c12gP9lmnVUBX+vVRDChtTeYEL2Ge9OBoIHqJoNKQJZrf8Bly1l77n/Wo5OaprYWj64T2Al4RNNmHNQl1qMqFkmspbt8ZDQYBDjZmJEpcyKjylf4eMpfPlROmWIChmG0rzTFp+6wjqUTEtf/RssP/wkPigH5r3AakdeUQ3luhYM7niYQTVFtcIIlaH6AJUZE9Ej3J1ngze9nz8AI6X3UmP9d1F4/5RmBZuSMhnWZqWcmsvVDG8FUtHv1r7wK7lckVjKMgvp928j60LfAiSLcdrHBK7+orZ6mnfaEmGZtkjS9xIg+oVEfLmw4W/JH70cUVEieR3SvEPOQ5o87MWWHVy/EBJKE/MJVEZF7aeAQXRgh9QSl7jj6+S0OcC7212vz8ogz1d92keomOQdxRmVxmuEwSdTXTUuNtkJwyjbHB+um2dc+YqKRwf/K+/B1dssQvGBJEZc1rPNOWPCxXge9l3jbQjSiGVWAwmaf4bzxB8ZprZmK3iYuZVfpJO0jL8qL3Zp1HT6Qgau75NI7UZfsBn48r
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(8676002)(70206006)(110136005)(316002)(70586007)(54906003)(6666004)(4326008)(7636003)(2906002)(82310400005)(40460700003)(5660300002)(356005)(7416002)(41300700001)(8936002)(40480700001)(82740400003)(36860700001)(86362001)(7696005)(2616005)(26005)(426003)(336012)(47076005)(36756003)(186003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:26:36.8278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f1a9c2-1c8d-410f-e396-08db3667dff7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the new set_rid_user and unset_rid_user ops, by using an xarray
to store the stream pointer indexed by a given user space Stream ID. This
will be used by user cache invalidation hypercall, to check the SID field
of an ATC_INV command and replace it with the corresponding physical SID.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f2425b0f0cd6..17bb90e78547 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2843,6 +2843,48 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
 }
 
+static int arm_smmu_set_rid_user(struct device *dev, u32 rid, u32 rid_base)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_stream *stream = &master->streams[0];
+	struct arm_smmu_device *smmu = master->smmu;
+	u32 sid_user = rid_base | rid;
+	int ret = 0;
+
+	if (!sid_user)
+		return -EINVAL;
+
+	ret = xa_alloc(&smmu->streams_user, &sid_user, stream,
+			XA_LIMIT(sid_user, sid_user), GFP_KERNEL_ACCOUNT);
+	if (ret)
+		return ret;
+	stream->id_user = sid_user;
+	return 0;
+}
+
+static int arm_smmu_unset_rid_user(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_stream *stream = &master->streams[0];
+	struct arm_smmu_device *smmu = master->smmu;
+	u32 sid_user = stream->id_user;
+
+	if (!sid_user)
+		return -ENODEV;
+
+	xa_lock(&smmu->streams_user);
+	stream = __xa_erase(&smmu->streams_user, sid_user);
+	if (stream != master->streams) {
+		WARN_ON(__xa_alloc(&smmu->streams_user, &sid_user, stream,
+				   XA_LIMIT(sid_user, sid_user),
+				   GFP_KERNEL_ACCOUNT));
+		xa_unlock(&smmu->streams_user);
+		return -EINVAL;
+	}
+	xa_unlock(&smmu->streams_user);
+	return 0;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -2854,6 +2896,8 @@ static struct iommu_ops arm_smmu_ops = {
 	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
+	.set_rid_user		= arm_smmu_set_rid_user,
+	.unset_rid_user		= arm_smmu_unset_rid_user,
 	.page_response		= arm_smmu_page_response,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
@@ -3082,6 +3126,7 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 
 	mutex_init(&smmu->streams_mutex);
 	smmu->streams = RB_ROOT;
+	xa_init_flags(&smmu->streams_user, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8d772ea8a583..8ccea2e84bbb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -674,10 +674,12 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+	struct xarray			streams_user;
 };
 
 struct arm_smmu_stream {
 	u32				id;
+	u32				id_user;
 	struct arm_smmu_master		*master;
 	struct rb_node			node;
 };
-- 
2.40.0

