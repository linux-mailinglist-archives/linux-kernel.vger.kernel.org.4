Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32706FBE6E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjEIEwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEIEwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:52:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B538A30F7
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 21:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/cIrhuskdbkJP5k5majVmDbT6qUbC7oTnBvHKp90+KrS1jXMpNxhpCADEisjDvylM/FhmiAChnCrGPEx2in/No5OBB7svSCUeckxyarbVkx0ffS5NWUmhCJasjgqIadgTqGun0uMxWjKoA/ozKAHJHhxZvxcgd8yDwrvLqM4yEES66i36kvv/vIoHlUQdlzJpWCkTb7tk1wSV4kOyVjjOcojiJjftBY8YlbbBZzxlvFYAcN5yiZH/vtLPRZcOrdlOZzgV76Qp7ifKY3U9aDRepNHwKYLPLpc7hQTdDTC4T7kKIfcci4aUa8/VseYhMLRe3swGoi5VVojs2K908YFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKUMrMClBvMFabvSmciN9jU21OPJcNHVS6oQNUMcJ9w=;
 b=ASgoQEVakC7sLFFmn+HvZDPyWL1xUa9jVzDStkAkcRwPRfOCzdQDMOMzbkL53eWT7h7aSIhGPYrtGodzhCiwNQa/y0TuDn2WbS6l9KmICLSrhLPXSjBpYXwVBbFTOqrzCvSzhXQJJFpdn1uIUY2R8HxfTB9nCX0mmpcd4Pdxkee9tloNsEtc4jQwKfaZlnRfgL7BHrBmbpO4f5aBs4flshPhYuUdRcXNvSYs56jiu3y9H3858cqt4+LbK2V/ylv0xf3M5Fgf0tSW9YbNtYTSNadZXR/ZDUorH21uFx3khCqbo2Bb7Bkeo4dpPDjmxCz8nw8rdYUVNb25EmTJUACiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKUMrMClBvMFabvSmciN9jU21OPJcNHVS6oQNUMcJ9w=;
 b=G4sdyky/TAQnMRd8lMXh+szO4MsiooV20H/Kl5iZwKrqzgAb++ZB9DBAsB6V/6V+Vd2IY4DrSYMRJgK+SDnXrzkf8TMZiptsClJID/DExVM/qj9KZDS01iHgWH6HvL8A9p+c0K2ogcrDSl3rvYQl5EK1+HdHROEAU9CMS32zFSwMYQbb056+8wJ0frH5UR93XFzWDdDXAAnFJJ6dfNzXPjL2MQMqBKIUTizpUmJOI9YBkY6sJf1p0w10h/bpArfX6gJjmTJX1LQ5fuLoW2VskU2k59AJDZJOp2XxG11nC/23g0Zaj3WfsbhcOI5kVHvRI81pbomDZ2Td2lhm4wYbZA==
Received: from BN0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:e7::8)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 04:52:09 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::16) by BN0PR03CA0033.outlook.office365.com
 (2603:10b6:408:e7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 04:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 04:52:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 21:51:56 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 21:51:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 21:51:55 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v4 1/4] iommu: Add set/unset_dev_user_data ops
Date:   Mon, 8 May 2023 21:51:47 -0700
Message-ID: <cb62f2d943543b1f281237062a147fe86a2bed54.1683593949.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683593949.git.nicolinc@nvidia.com>
References: <cover.1683593949.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c8e7c2-1559-4be3-f825-08db5049250c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsDvrWoEAkPALmw0TGPTuR4WDETZeWi0qMFRg0vLSfcAABT4qRl7kzgbnfwKQ/dbJ420NipPf4nwUSw1iSTx8aWJyEqP/5DSsM9PI+58HMTaCSTSCAz0fmhwjT1zx3MxRGvsi05w4uFuVdMPk+364QTTmUwLU0XvOoLaBRuAjNiRO2N1+rDymrOjzYLgD9vXXuL+d9JZS/mGcv+fUUT/9SVekFOdqcuux+ne1fOFtBg7bvFhLcyzRwA2cZswETG6kaLZu4xx++56pskhL1PqK2FyU2Z7AlFsG50tJ9G3REQNRXVmFGLHG8Vk/hvz48doUjG0yv39EOcq87dlGnEJzWKhTmjYKTGppxN7t5QxsEjWjTDTbgMpOah2hg1qyvwiNHpWGJFi9IkY0SfQf8i0sMK5H2voe2b3OdtOHBFjcJezc+omCls/EyGiO3roIjNPFDN2d6cY/l9lWO8zTp3r8pBycuMUZBIxNzvP/Em2x7/eowrMZFgmahm5W+f/l7ZGQ6+EutNA7N+GnRL2H5N0Kg0THxLejIqjPgDXB0acO9P24gRSUYUh/eKI4bMXvf4kcM1726xIyrDT8gN6GI9/dCrYxY6048UHecnenFmqBZ3PURi+qrueivmZIqiLTe+qwfh8alMZ7HF7ek6EoqfB72RnwyJGvbDs0r5EbuXTtbOt4ubUCdpaJyXhYyy4Bl4PnaWZN4W8n2naOmabUmml4A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(7696005)(6666004)(5660300002)(7416002)(40460700003)(8936002)(8676002)(478600001)(54906003)(110136005)(82740400003)(7636003)(40480700001)(316002)(356005)(41300700001)(4326008)(36756003)(70586007)(70206006)(2616005)(86362001)(2906002)(186003)(83380400001)(47076005)(336012)(36860700001)(426003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 04:52:08.5623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c8e7c2-1559-4be3-f825-08db5049250c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device behind an IOMMU might be used in the user space by a VM. So, it
might have some user space data. For example, a device behind an SMMU has
a static stream ID. In a virtualization use case, both a host environment
and a guest environment have their own Stream IDs. A link (a lookup table)
between the physical Stream ID and the virtual (user) Stream ID is needed
when the host handles the user cache invalidation commands.

Add a pair of new ops to allow user space to forward user_data of a device
via iommufd, and a new dev_user_data_len for data structure sanity done by
the iommufd core.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1131476017e2..1e1124f79b56 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -260,6 +260,15 @@ struct iommu_iotlb_gather {
  * @remove_dev_pasid: Remove any translation configurations of a specific
  *                    pasid, so that any DMA transactions with this pasid
  *                    will be blocked by the hardware.
+ * @set/unset_dev_user_data: set/unset an iommu specific device data from user
+ *                           space. The user device data info will be used by
+ *                           the driver to take care of user space requests.
+ *                           The device data structure must be defined in
+ *                           include/uapi/linux/iommufd.h.
+ * @dev_user_data_len: Length of the device data from user space (in bytes),
+ *                     simply the "sizeof" the data structure defined in the
+ *                     include/uapi/linux/iommufd.h. This is used by iommufd
+ *                     core to run a data length validation.
  * @hw_info_type: One of enum iommu_hw_info_type defined in
  *                include/uapi/linux/iommufd.h. It is used to tag the type
  *                of data returned by .hw_info callback. The drivers that
@@ -307,6 +316,10 @@ struct iommu_ops {
 	int (*def_domain_type)(struct device *dev);
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
 
+	int (*set_dev_user_data)(struct device *dev, const void *user_data);
+	void (*unset_dev_user_data)(struct device *dev);
+	size_t dev_user_data_len;
+
 	const struct iommu_domain_ops *default_domain_ops;
 	enum iommu_hw_info_type hw_info_type;
 	unsigned long long hwpt_type_bitmap;
-- 
2.40.1

