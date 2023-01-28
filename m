Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E519967F3FF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjA1CaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjA1CaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:30:07 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0CC8BBB9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:30:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh+PgJGsngVaCHk76AgL97VJQESX11IsTB1rKGXNqVSaQ6K82+65NgrWmIClgG1TLlEAc/0zN7oc9Q1jtslQ5tiWebTB8I3KLUk3u5S3YCVe0eenJujBTK01bVknEiK0NAjHKbGIK/tIr2b/+TXbNjYqaSgDT+TtNrLyHn6WJqA9vcQy5a82Zd/pVcw/vtSAFAPJf/nJ98EZYmjzQzx1uj8Rl8ZNapw7wcLYCQYKpx1LTpYTWymfGlFch9Vy+0DLp97XwC2XeTqJIRqcXq157SjEBsC1/eShab5JtO2BAx1eLZGjq0KuJ/HbnEoPwXV4leEooNIN1Hh5oN/i1AxYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t2ZR0hLSHK2a5Qm+twx7zepvhYl9ngyuAURrM04Xo0=;
 b=Cfl88Hi0lpplPtj/ADW35axzfDfrFs4L/ZV4ug1NvnFB572XlMX0MqPSXcU3GGlO3rOHY2RufbUG/fUmfp/IX+KyK+YMr7nSHzyBThOA3vuUOSchw+7hihqYMY9sMNf1FNbs0iFrXIKtIx6esf3dzFb2+735YznJu0yvQPWzNRwgkZqUwVjr8t+N4JDmSubgC1FPNj/qKrnZRp6VyEZiJw20Ddr635UYahA+vmjJ698c+ct8tVjE2SI4OiwGxBsvmCGfjA9mrpWIaMaISyfa0brOlZy+MKI7MH+CrUUgeHAxyQIEClm2KiPkWSoa7kWuhRroTF6HjqnzX8KABvk5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t2ZR0hLSHK2a5Qm+twx7zepvhYl9ngyuAURrM04Xo0=;
 b=rrEoMA11tWJejPHJeUWHQDKl3MiRFFKzSdgLpUTLneCc2N9+aLYSU78HUTMBpjmeqhXnki+0hsEoiWjwSnUXdWcTkuXj5CI2p6U2lWKN8GU+lSyb7xz1AIypb1tpvOy6BERXomylZYzyfAzifxOPsDm0oQIKhr0RsiLQRKJbHjaaynMVRtaxeKx7BJE9V9FYvHBQZa7lwYDdwr1j3lkwxAwkVg6cvDAn0H8Cbmp6cAA/MQ86LY3oIZnwMcagAP4hsaIhr4iDMVyVeTeF5dd7POQLLr/PyBzpyYgKr8mg8rom+8hEd7T5OtLDlSkDKZbCnB7eMZ9vo/FrA+OzdVrUEA==
Received: from CY5PR14CA0030.namprd14.prod.outlook.com (2603:10b6:930:2::24)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Sat, 28 Jan
 2023 02:30:04 +0000
Received: from CY4PEPF0000C96C.namprd02.prod.outlook.com
 (2603:10b6:930:2:cafe::c6) by CY5PR14CA0030.outlook.office365.com
 (2603:10b6:930:2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Sat, 28 Jan 2023 02:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000C96C.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.16 via Frontend Transport; Sat, 28 Jan 2023 02:30:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 18:30:01 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 27 Jan 2023 18:30:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 27 Jan 2023 18:30:01 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] iommufd/device: Change iommufd_hw_pagetable_has_group to device centric
Date:   Fri, 27 Jan 2023 18:29:42 -0800
Message-ID: <5c706a533bb4fd145614d630358fb21c215f8eca.1674872884.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674872884.git.nicolinc@nvidia.com>
References: <cover.1674872884.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96C:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e36187-9ab2-4619-0bd1-08db00d79047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ne07qw7/aKlHUa//ibe5LR19aQq0Cx+c/8q1UdObzikN1qaWi02+vKIGG+TAfZ2x09dD4Vsj6c92/Vq2h4VCt/HOX7bXOrS5vJkRg6Ifzb1qb8WPesGdQURzIAx8EMI3ifxyzrWpAoL86WJkNUcdwEkudh0BjJpHL9HJ4V3qgNjf5N64M/sdMVCPpRb/0bEZbJf7bzJUXYCnfy4FvHmyNp+iJpT9WS7TSwVCBkOChXAWqvdycWw+w+0qxpeju+dAQPSVCyzHcpbtRgNgx0kOXaU7E7JlBRCBghuVtxdqWKvWAm03elv8UNeQPyM5Rt7m68R0Oengp4itIOs5ZmPvXAltFvgJ1/2wvswwFh0SUI4TsL/DCcHAKL0qeoU0nluLJ9p6EenvmMeDY1MHL9QwB3VNlAlh+fx4/IBFGZQ3OWK+hilAAKUGMyyhJqJ4iMlZdAV2v/1gVk4rCS2Tid6dvYUDwNNIl/RNVqyMBbM6hPHO0OtjKZy3U3tiKZCV3tGkAdyhn8T2Wx+NHOWOTNDUYasEZf2LxKxrO56wwNb+VOWD+CaiaXhLcTRu0QT4zvSTDT4hnDy/Cb2XNEHikaeFpPO8Q6v9CXP7x2yC1AU93P29UpAk7ndWUx++gM1AOP1gUIt8uPC8mrA/UeJ9LwYvRz5sTKJt+4ZTHB6PEDb7S5girJxwOATUmVgvJHUyJvRNcEMnvbjvuVe5ipProFmCSg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(54906003)(110136005)(5660300002)(47076005)(426003)(40480700001)(2616005)(36860700001)(7696005)(40460700003)(336012)(356005)(36756003)(2906002)(478600001)(83380400001)(41300700001)(26005)(7636003)(82310400005)(186003)(8676002)(4326008)(70586007)(70206006)(86362001)(82740400003)(6666004)(8936002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 02:30:04.0507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e36187-9ab2-4619-0bd1-08db00d79047
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
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
index 0248073e3169..5a5dfc0c4ca0 100644
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

