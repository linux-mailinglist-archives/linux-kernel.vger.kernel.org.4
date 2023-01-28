Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1067FB1A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 22:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjA1VS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 16:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjA1VSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 16:18:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445E16EA9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:18:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVyPwMwxFBGvyrsjujhLW+a1FTntg+g/2mQL0fyAW1AewOxE4JjTGw9X3eoJjxUdxX5u34Ftvqge2LkQMeOhY8iMRoUp+9RdvYektg8RMgcWbn4BTMPXWe1v1wrb1HyOSIZqmGINvzLC6FbW6MEt+Cb6EDtkLWpOlHFLXd6ONpL+ODMInRhe/jdYMbeqmuyfdhBDNVlQAKc/68TP9LHU2Zkhg73fNq3LG2ncZp1maGvxx+Em3Z/Rwnc+RCB6cwxE0q+VzatkdrZ92qK0rmA6jYXgd7fhomMaKNIOPDfnIbHTSZCN8BtO1Q+QEvRdFW7K1e34n5lHpVAxKjLaGWDtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Elr8tRH0Mk5pSvopf14vfXOYoAvYzfwkw58ucbxy0/s=;
 b=nGZjFaQkDturyBDiwEuuGMPxx34XvNOBWHyvVgCsdleDfsMrvOeKZbY2XndIcLNxlCUjhG0/ZOXm8It0Y4dxlFyGJvy0K/xfVvpGQH1cRIfIL6t5ZE8Pbu2wgxz+WtjVzlChIN4iSR9meQg+1E633pXe43XkkjYLHBFeUQ+wb2xYvRWxiSYk+33l+Hfp7tyLFd5Wafm1LBd74KTiHW6zhyn+FYy9Rx4Gn4gAWgVFysvg/rSuy9157ndyPuM6vzBzK8MYWiC9vPV2Trkd1z5Dt+fCOi+AwS1QnsM8cJCOKaWb5GHb05DIu1WOjke8A44BvrNiw8nm1GkbdZbmMLXBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elr8tRH0Mk5pSvopf14vfXOYoAvYzfwkw58ucbxy0/s=;
 b=dBX4Dp9iaARNHCP8UBq0z9HyNo9GQ+rznAZhmF2ogrR8yE1aphSW1BiGnelkIjslcgtrl/SAgdIGyc1OrB3K24EVopPrvW/7U8IMh3nASJ+ln9kfWfG8qic3FC9KkO9sMXkkGxD+9tjjrZSTEsIEfSZLbCw5zBn5Fnq0Vfw8EAadtceP9vd/LguON8HX/2Bw0IgQm7nzIwCaNsbRy9xiODs1/XOoBvN/emQ+f2SIqHRxjoFxKw9H3YHsoiYTETVMuoU3+7gVO8rrrcx5gQ8hs20hlVq2zM0FmyJdfeSveE00g0yzYHaB+a1xTjR8ilLjik0YdwKCrpIRZ7odl/qqwQ==
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by MW3PR12MB4524.namprd12.prod.outlook.com (2603:10b6:303:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Sat, 28 Jan
 2023 21:18:37 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::8c) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Sat, 28 Jan 2023 21:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Sat, 28 Jan 2023 21:18:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 28 Jan
 2023 13:18:26 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 28 Jan
 2023 13:18:26 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sat, 28 Jan 2023 13:18:26 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] iommufd/device: Change iommufd_hw_pagetable_has_group to device centric
Date:   Sat, 28 Jan 2023 13:18:11 -0800
Message-ID: <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674939002.git.nicolinc@nvidia.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|MW3PR12MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e73893-a083-49bd-e2e1-08db017538a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xR75AOUJhTCk22XmsqJw9qOBriRniXiTTTiE2Ex7Y4jqkF4wvhyIzEzRwmVgBNR8LYlYOPmlnuFnLg5S/X7QEI5kF3eSj1yAT4CmS5Ba2AbL4CTU+ZD9MVw37BVRzf2QLyBwrZsrFTKrterTvi+8GJPwFA2yqGAxPdMIMM17dV8kDTwpWsQ0OM6FCe978Zm7uGp3UP+4rTm8LEbSQ10lKsoYZJ1eUy5u7epacAoFt40qASRJFGae86zcCd+ftM8aY1DYX6cQga8BZ+d7Jj8PaG7ZoB2wJ4ax2uLp1RmbUbzjY8NLoG+/Xlgec2QqX/nzQY+rAqJ1Qcr/g8K+0CbHltwkUcDNAvU/Dup9lK+Dyk2z4DFUW2DdZosM+rfGe+gTu1BTEkIH00exQnH06ug5R50+ymNfkIC/Y1oEjoy4bYAjHEOXtNrdneQzc2Yri0RIPseRd0hgflE5hKit8Uz0ZxXOhgLiLrJjRpDm4WerHXYlRiNHnmLlmGoSPvHJLWS0Yb+0IE5pPP2hh4eZeZJHodwuQOqBH+Pzo2E/5LILLdNS2YTxmscIMfKM8M76luSY9yzk+zSZM/DwnbvEqPjt13lfiLwGIIqKAoNgd/xcXsvJEJ6yx7RJXooLMBUyvcID7q79n+OEqJ4qm1Sz67xNLn8DQrH9YNfNciy+pZ6cdzkN2GHtgjOO8kE9prNyGhefAvm/JXd5e/zyPfjt01EQeQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(2616005)(7636003)(82740400003)(40460700003)(36756003)(186003)(356005)(26005)(40480700001)(7696005)(6666004)(478600001)(86362001)(2906002)(82310400005)(316002)(110136005)(54906003)(5660300002)(70206006)(47076005)(36860700001)(41300700001)(70586007)(4326008)(426003)(83380400001)(8676002)(8936002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 21:18:37.3572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e73893-a083-49bd-e2e1-08db017538a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4524
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommufd_hw_pagetable_has_group() is a little hack to check whether
a hw_pagetable has an idev->group attached. This isn't device-centric
firstly, but also requires the hw_pagetable to maintain a device list
with a devices_lock, which gets overcomplicated among the routines for
different use cases, upcoming nested hwpts especially.

Since we can compare the iommu_group->domain and the hwpt->domain to
serve the same purpose while being device centric, change it and drop
the device list with the devices_lock accordingly.

Note that, in the detach routine, it previously checked !has_group as
there was a list_del on the device list. But now, the device is still
being attached to the hwpt, so the if logic gets inverted.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 40 ++++++++-----------------
 drivers/iommu/iommufd/hw_pagetable.c    |  5 ----
 drivers/iommu/iommufd/iommufd_private.h |  2 --
 3 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 9375fcac884c..f582e59cc51c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -24,8 +24,6 @@ struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_hw_pagetable *hwpt;
-	/* Head at iommufd_hw_pagetable::devices */
-	struct list_head devices_item;
 	/* always the physical device */
 	struct device *dev;
 	struct iommu_group *group;
@@ -181,15 +179,15 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 	return 0;
 }
 
-static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
-					   struct iommu_group *group)
+static bool iommufd_hw_pagetable_has_device(struct iommufd_hw_pagetable *hwpt,
+					    struct device *dev)
 {
-	struct iommufd_device *cur_dev;
-
-	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
-		if (cur_dev->group == group)
-			return true;
-	return false;
+	/*
+	 * iommu_get_domain_for_dev() returns an iommu_group->domain ptr, if it
+	 * is the same domain as the hwpt->domain, it means that this hwpt has
+	 * the iommu_group/device.
+	 */
+	return hwpt->domain == iommu_get_domain_for_dev(dev);
 }
 
 static int iommufd_device_do_attach(struct iommufd_device *idev,
@@ -200,8 +198,6 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 
 	lockdep_assert_held(&hwpt->ioas->mutex);
 
-	mutex_lock(&hwpt->devices_lock);
-
 	/*
 	 * Try to upgrade the domain we have, it is an iommu driver bug to
 	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
@@ -215,25 +211,20 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 					hwpt->domain);
 		if (!hwpt->enforce_cache_coherency) {
 			WARN_ON(refcount_read(hwpt->devices_users) == 1);
-			rc = -EINVAL;
-			goto out_unlock;
+			return -EINVAL;
 		}
 	}
 
 	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
 						   idev->group, &sw_msi_start);
 	if (rc)
-		goto out_unlock;
+		return rc;
 
 	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
 	if (rc)
 		goto out_iova;
 
-	/*
-	 * FIXME: Hack around missing a device-centric iommu api, only attach to
-	 * the group once for the first device that is in the group.
-	 */
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
+	if (!iommufd_hw_pagetable_has_device(hwpt, idev->dev)) {
 		rc = iommu_attach_group(hwpt->domain, idev->group);
 		if (rc)
 			goto out_iova;
@@ -250,16 +241,12 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 	idev->hwpt = hwpt;
 	refcount_inc(&hwpt->obj.users);
 	refcount_inc(hwpt->devices_users);
-	list_add(&idev->devices_item, &hwpt->devices);
-	mutex_unlock(&hwpt->devices_lock);
 	return 0;
 
 out_detach:
 	iommu_detach_group(hwpt->domain, idev->group);
 out_iova:
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
-out_unlock:
-	mutex_unlock(&hwpt->devices_lock);
 	return rc;
 }
 
@@ -385,10 +372,8 @@ void iommufd_device_detach(struct iommufd_device *idev)
 	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
 
 	mutex_lock(&hwpt->ioas->mutex);
-	mutex_lock(&hwpt->devices_lock);
 	refcount_dec(hwpt->devices_users);
-	list_del(&idev->devices_item);
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
+	if (iommufd_hw_pagetable_has_device(hwpt, idev->dev)) {
 		if (refcount_read(hwpt->devices_users) == 1) {
 			iopt_table_remove_domain(&hwpt->ioas->iopt,
 						 hwpt->domain);
@@ -397,7 +382,6 @@ void iommufd_device_detach(struct iommufd_device *idev)
 		iommu_detach_group(hwpt->domain, idev->group);
 	}
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
-	mutex_unlock(&hwpt->devices_lock);
 	mutex_unlock(&hwpt->ioas->mutex);
 
 	if (hwpt->auto_domain)
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 910e759ffeac..868a126ff37d 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -11,11 +11,8 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	struct iommufd_hw_pagetable *hwpt =
 		container_of(obj, struct iommufd_hw_pagetable, obj);
 
-	WARN_ON(!list_empty(&hwpt->devices));
-
 	iommu_domain_free(hwpt->domain);
 	refcount_dec(&hwpt->ioas->obj.users);
-	mutex_destroy(&hwpt->devices_lock);
 	WARN_ON(!refcount_dec_if_one(hwpt->devices_users));
 	kfree(hwpt->devices_users);
 }
@@ -45,9 +42,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
-	INIT_LIST_HEAD(&hwpt->devices);
 	INIT_LIST_HEAD(&hwpt->hwpt_item);
-	mutex_init(&hwpt->devices_lock);
 	hwpt->devices_users = kzalloc(sizeof(*hwpt->devices_users), GFP_KERNEL);
 	if (!hwpt->devices_users) {
 		rc = -ENOMEM;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f128d77fb076..1c8e59b37f46 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -246,9 +246,7 @@ struct iommufd_hw_pagetable {
 	bool msi_cookie : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
-	struct mutex devices_lock;
 	refcount_t *devices_users;
-	struct list_head devices;
 };
 
 struct iommufd_hw_pagetable *
-- 
2.39.1

