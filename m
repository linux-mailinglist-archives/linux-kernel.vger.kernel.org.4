Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C066D8F5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjDFG0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjDFG0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:26:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259E29772
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGA7Br04d1gtgipSkMm4Uvouel3i6YJtw3SaERIPmqJ+kOBuQwcgLBoNztBxHCnnRSBBB11vYCWYD0bqTS8d/N0W+WTjAgUH05AvG8Wh7+VK28LMab+LCfTVPUZsTH5F+ZjffJp/R5ZlH6upM2fyHx8MqfGTl46LDsDrpOXXwFPBQZOS0VEcpXEhr5z6C1ENvvl38K7IkogLKPgU+/R519nUnyQZK8X9GcXcV9QnnH31Sh06gl+Rv3MQAjjs/Dmez+RNBT/TGqgd0Z8eZr3VtxM22yUIA/zf/1z5Abv0bLYT7O4VCuq2cQtMQqb2JFjR9MMWxhOMHZiIBQxQ5fyfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfYrwGLhZXyOzEPzO/lU+YoRB4gD5bgyS2QNeKyQH0M=;
 b=WXF3Fq5+I77WJembUd1hwWQbDagwFiRCQIkynV4W/BiBRrAOjz6JZezI9lWw4BAM/UYcpSLrSnA1yEFlhOFBxDn4P9fILiEIZFAQxy91mlAry3Wdm3jcvSrgdMxIidDcuZTaZquJrgmjP0f9IXo0Xuk/tFRGOam3ur8blQi1hfOYEAFK2bDeeJzNi+ERSvgK+h+d/eTxFRxv9H+5bwZo23V7xNW43fbpVoVs6oLbMSORkAo7/jTZ9VsetQndCvtOa0AOPaEBAsK4TtuzqDRRv96pa7T0dFouP1/do70yDHeO2OVmiaQrbFbF78jHPIWU3q498pEw+NjbD5+yCEy1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfYrwGLhZXyOzEPzO/lU+YoRB4gD5bgyS2QNeKyQH0M=;
 b=JDZk1/dELkyMbDrD3C3sUaadx8ishlwEeaJg0JHCymt8rWVIpUgaJKatbQqwGQsSx8vsB2zbnOlHNANshlez3++bxS+ZAKMQ+3UmkViUa/FE5bFiqJTqosuy33osUdWtkmaB/Qj6UPDRssH7iqEAOQUscFKi65qNWF7K3zMhzSbVsU7EMM0Re0SFKJrsrVe0taJkkzH+3TqvbV9w9Udjk/z6lkBC2BB7DkPZkXqkqp5qozQ+dcNSoIx/NuBMgYaa1XxdSpFa+tyHH0ASLdHbWTlw8Qnib3emQJBJVpCKxr8z8GVVQXPV14DIh2sJqcrVEJnVlkUzgyoaOPB/dqYfIw==
Received: from MW2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:907:1::38)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 06:26:28 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::e1) by MW2PR16CA0061.outlook.office365.com
 (2603:10b6:907:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 6 Apr 2023 06:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.30 via Frontend Transport; Thu, 6 Apr 2023 06:26:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 5 Apr 2023
 23:26:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 5 Apr 2023 23:26:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 5 Apr 2023 23:26:20 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <kevin.tian@intel.com>
CC:     <eric.auger@redhat.com>, <yi.l.liu@intel.com>,
        <baolu.lu@linux.intel.com>, <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v1 1/3] iommu: Add set/unset_rid_user ops
Date:   Wed, 5 Apr 2023 23:25:34 -0700
Message-ID: <1944e8b2226585e309081a541e51addc137e6684.1680762112.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680762112.git.nicolinc@nvidia.com>
References: <cover.1680762112.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d3829a-a1b7-46a2-ce89-08db3667daaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/ySf+sZ+mfeWOL/IPD78V5amjBGkoBXmVViB+YJ+gmZJI4RTJssNGAQ94ncAAUJ5QHcf+4+6tNaoHyJx5thSCYNlcEBVjQgMDctCIobGjMBgWXf/HH/SeBy5SoqpRuJk5SydUd+pBrljR7/LxUPc3IuYZoZRVkjoSc6KHMefCUrqBYDnSmwaQCSnktvQOSNIFr/y70i5rl/goz2aDWblzY0Q2s8WxnmAttjpNZA8tCCYSoIBkCr5PY2d5J9hg1IISF1i7EarN8FXWpMZec+L2gpezYsCnhcAaA24nybQab8K91H0qmarJYgLQKjFTQ0MGzwPT4xtUF5R/xg5XaJtFNSQJIRSGBR68KEBOgwOirTNlLBSMXlAUOUj/z/YxRVs/1bwVWkPo2hsa7qkHYAvzkFMhmMam8oT/9cWBSZ4cPHHNw2xZXKAIfYOCJ1aBrS69TAhhWF6kKE31rAXIvaAH4VFT1T6xM6fGUyNFLznLj8q1vMSJEAiK6exTsI8+m+VOuWmMpp9N+DtpXwbu6Iu5QEBsl9gOoEZ1c+MJuHCdFlRq11bHgBSl07n+34cu/LJpyejlGDuozGVAMRRVqonLevU9qXvMEZkoVHoLAU5FNzMB7BxB4hvhEGwITZHuwVIOS1bqpqwmxUAkxPr+fz1Fz5QC6O6I4BMlTSKIhtBlB1uBBRTs0d2PmfSYlR5aUvjAlhRqpzvqbMZOr8IQBGkR7XKX8QXS6KZczEI3XptQkR3zmMSOPD88kHWTZdOzOg
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(8936002)(40480700001)(40460700003)(82740400003)(478600001)(54906003)(70206006)(36860700001)(70586007)(8676002)(4326008)(7636003)(316002)(110136005)(41300700001)(7416002)(5660300002)(356005)(47076005)(83380400001)(186003)(426003)(7696005)(336012)(26005)(6666004)(86362001)(36756003)(82310400005)(2906002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:26:28.0605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d3829a-a1b7-46a2-ce89-08db3667daaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pair of new ops to allow user space to set virtual RID of a device.
This can be converted to Stream ID for SMMUv3, so as to create the link
between a physical Stream ID and a virtual Stream ID.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 080278c8154d..f85ce6f01408 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -248,6 +248,7 @@ struct iommu_iotlb_gather {
  *                      driver init to device driver init (default no)
  * @dev_enable/disable_feat: per device entries to enable/disable
  *                               iommu specific features.
+ * @set/unset_rid_user: per device entries to set/unset user space Request ID
  * @page_response: handle page request response
  * @def_domain_type: device default domain type, return value:
  *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
@@ -291,6 +292,9 @@ struct iommu_ops {
 	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
 	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
 
+	int (*set_rid_user)(struct device *dev, u32 rid, u32 rid_base);
+	int (*unset_rid_user)(struct device *dev);
+
 	int (*page_response)(struct device *dev,
 			     struct iommu_fault_event *evt,
 			     struct iommu_page_response *msg);
-- 
2.40.0

