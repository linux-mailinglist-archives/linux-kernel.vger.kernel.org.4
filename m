Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59D167FB18
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 22:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjA1VSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 16:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjA1VSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 16:18:36 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CE85594
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:18:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2uJoPscV4EakUceoZ5gQcvZKK8iYr/5axakidVaxr6nYTdsQCrOiJMp+rgymuayPMbB1KUlZb+YtGGb8W2h4BTfdDb6RugwmW4VwKIT0ri4eZIjv+t2O+6vJgplCeZbSOcrDGMuH6i6H7zjafHYusxHjOJ/0l7uVktj7mYCbNZJhwsmFy5QMb7z8GzFAroN6+lfQPC01HMHxNBjUo9e7h02eXp4hQryTLmLHKyxg9whQePQKkNd37FJvBnmDE+aC1q0qx9l2vdhvsw8wqhDxz0yBLYifvCy0ebR0noHq1kJcqDjKbwhkE/Zxj6hs8ohakLSGAAouTIwRayxXhKM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aWMGcXQVNAN9lZL32+cKA11taZBiVCr7fCTxeRXQ+0=;
 b=g5/qZxSvFoEzciy5Cr0rSDnwC7t48dk2ILKkBbteA05U3tiqnmSyZijo05uaaypR/JLFfgk1rHITrPdUmFBdhW4ozNRC+c9MYPjuL38+tj6u3tqEDHekhWvWxnIDKdxunL3f8gYL+TK9P9MNIidu7Gz8B4UYjQPIzMhPJYbsr1VXluf+kVdvFIz8suViRON9VFLkpWP7q41QctrDtRLHfABFby6YrBLVljm4zgXABBEUekqK4I0Td5edYJQcuXGN/6988CDy8D9lFWF0TzWcgvMsCs0HZnc8HX8VaM+dne7gtbSd5bmZCSkgItdl4cj1J9hmWs9zNV8eN1weljxTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aWMGcXQVNAN9lZL32+cKA11taZBiVCr7fCTxeRXQ+0=;
 b=D8GzNgDjH6wONJ78t1Lo7yV3SHgduBHMmfFerrozbiYTwcEualzbuXc9wZG7vlTrvzRoL57O8zeEaZNmFv1Qypr70tBjITlXyLLYnd8OckkY+6mg4U+LthzEe3fzKtRaB8ZgsYCwOBOFNCSdWd94eM63tikUQTkZLGj0X7bO5cC5g1BtSFh1j2ICmIOx8jF5K9TiNSsh3kueG6k0zuz+sjGtzbyHQ0Ahm+0qNk/aj0Npt33/6+S9ulL7RUC+GEwG6n3X4OfeCyK2bCROkfwEjiQicsyTAPqhMt/Fycxy8f639WlH5Wm6RX3UY0jmv1NxOWuZBKVEPIyp6NCMQ7rhNw==
Received: from DM6PR21CA0029.namprd21.prod.outlook.com (2603:10b6:5:174::39)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Sat, 28 Jan
 2023 21:18:32 +0000
Received: from DS1PEPF0000E639.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::7c) by DM6PR21CA0029.outlook.office365.com
 (2603:10b6:5:174::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.0 via Frontend
 Transport; Sat, 28 Jan 2023 21:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E639.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Sat, 28 Jan 2023 21:18:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 28 Jan
 2023 13:18:25 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 28 Jan
 2023 13:18:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sat, 28 Jan 2023 13:18:24 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] iommufd: Add devices_users to track the hw_pagetable usage by device
Date:   Sat, 28 Jan 2023 13:18:09 -0800
Message-ID: <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674939002.git.nicolinc@nvidia.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E639:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 290459a8-780f-467a-d9aa-08db01753596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJ2zW8pBwY8qdZTSNWN3F2Hv1Ewj9S9IOc1Mvk6WvknCYwFk1lCy2ZbQoc+DOBJeKifx/dXBdHaiGY3PVz8L0AEQfxv1wSZruxk1vzp2A1cRdjWlWaivEl6kdGOgPYMpgcxUM0Hb5d7mJw+mrT938L8wiQV6In55HkzhqmRtw+PEDTv7OtML+V2eTRB5jEdenKBolSs+/tgwrzMbmNTMWialrocDxK39RM6pLpTYlbI/MMvtU1qSiBiPUmXdKkNPUrtZdFSodoGUMn4KQ3rHsfHj9MX6O5deCitUjEFWOYTmnICmg+QheXa4v7nSwGCmYfTCWtZMCTwt1TMC5k2fk8Azy/DVDkX3GIYYC5kZDMWx6RQis4vfX+ZjpSrtSQuozc48nu9rhMgDzj4HHBeHAeegpuSwEXDU1Om0MZkqe4gTcGyd7R44luFoaMlaf6yAn1Ltys4LaRnmRZy1HGraHMeYfubg6CBImAyUyNgTG9XFBltVpyOM+wVzOBhMI2T6GAgSv0RcHXkaS3TZaNAKkZD1m2RFMXx9cZFSa7LC+wfkx8dAqoTsnXfuDulOZ7RYr1sDfmOyZgYk2mYGCSjxKWGscT9LeKZf899inI8PG110PQemOaj6cXCat+Tk2aNsJYz6XTCX+sxiJOzFD2fQee3ze/AtqPxpcbe1L/pl2UNA2tyxjdLSzpwnJgpH5cHQqMqM18PobfjWWyJ77QtSHg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(5660300002)(54906003)(316002)(110136005)(478600001)(6666004)(7696005)(41300700001)(8936002)(8676002)(4326008)(70586007)(70206006)(40480700001)(82310400005)(186003)(36860700001)(82740400003)(7636003)(26005)(86362001)(336012)(83380400001)(47076005)(426003)(2616005)(36756003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 21:18:32.3374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290459a8-780f-467a-d9aa-08db01753596
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E639.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Liu <yi.l.liu@intel.com>

Currently, hw_pagetable tracks the attached devices using a device list.
When attaching the first device to the kernel-managed hw_pagetable, it
should be linked to IOAS. When detaching the last device from this hwpt,
the link with IOAS should be removed too. And this first-or-last device
check is done with list_empty(hwpt->devices).

However, with a nested configuration, when a device is attached to the
user-managed stage-1 hw_pagetable, it will be added to this user-managed
hwpt's device list instead of the kernel-managed stage-2 hwpt's one. And
this breaks the logic for a kernel-managed hw_pagetable link/disconnect
to/from IOAS/IOPT. e.g. the stage-2 hw_pagetable would be linked to IOAS
multiple times if multiple device is attached, but it will become empty
as soon as one device detached.

Add a devices_users in struct iommufd_hw_pagetable to track the users of
hw_pagetable by the attached devices. Make this field as a pointer, only
allocate for a stage-2 hw_pagetable. A stage-1 hw_pagetable should reuse
the stage-2 hw_pagetable's devices_users, because when a device attaches
to a stage-1 hw_pagetable, linking the stage-2 hwpt to the IOAS is still
required. So, with a nested configuration, increase the devices_users on
the stage-2 (parent) hwpt, no matter a device is attached to the stage-1
or the stage-2 hwpt.

Adding this devices_users also reduces the dependency on the device list,
so it helps the following patch to remove the device list completely.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  8 +++++---
 drivers/iommu/iommufd/hw_pagetable.c    | 11 +++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 9f3b9674d72e..208757c39c90 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -212,7 +212,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 				hwpt->domain->ops->enforce_cache_coherency(
 					hwpt->domain);
 		if (!hwpt->enforce_cache_coherency) {
-			WARN_ON(list_empty(&hwpt->devices));
+			WARN_ON(refcount_read(hwpt->devices_users) == 1);
 			rc = -EINVAL;
 			goto out_unlock;
 		}
@@ -236,7 +236,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 		if (rc)
 			goto out_iova;
 
-		if (list_empty(&hwpt->devices)) {
+		if (refcount_read(hwpt->devices_users) == 1) {
 			rc = iopt_table_add_domain(&hwpt->ioas->iopt,
 						   hwpt->domain);
 			if (rc)
@@ -246,6 +246,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 
 	idev->hwpt = hwpt;
 	refcount_inc(&hwpt->obj.users);
+	refcount_inc(hwpt->devices_users);
 	list_add(&idev->devices_item, &hwpt->devices);
 	mutex_unlock(&hwpt->devices_lock);
 	return 0;
@@ -387,9 +388,10 @@ void iommufd_device_detach(struct iommufd_device *idev)
 
 	mutex_lock(&hwpt->ioas->mutex);
 	mutex_lock(&hwpt->devices_lock);
+	refcount_dec(hwpt->devices_users);
 	list_del(&idev->devices_item);
 	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		if (list_empty(&hwpt->devices)) {
+		if (refcount_read(hwpt->devices_users) == 1) {
 			iopt_table_remove_domain(&hwpt->ioas->iopt,
 						 hwpt->domain);
 			list_del(&hwpt->hwpt_item);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 43d473989a06..910e759ffeac 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -16,6 +16,8 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	iommu_domain_free(hwpt->domain);
 	refcount_dec(&hwpt->ioas->obj.users);
 	mutex_destroy(&hwpt->devices_lock);
+	WARN_ON(!refcount_dec_if_one(hwpt->devices_users));
+	kfree(hwpt->devices_users);
 }
 
 /**
@@ -46,11 +48,20 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	INIT_LIST_HEAD(&hwpt->devices);
 	INIT_LIST_HEAD(&hwpt->hwpt_item);
 	mutex_init(&hwpt->devices_lock);
+	hwpt->devices_users = kzalloc(sizeof(*hwpt->devices_users), GFP_KERNEL);
+	if (!hwpt->devices_users) {
+		rc = -ENOMEM;
+		goto out_free_domain;
+	}
+	refcount_set(hwpt->devices_users, 1);
+
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
 	return hwpt;
 
+out_free_domain:
+	iommu_domain_free(hwpt->domain);
 out_abort:
 	iommufd_object_abort(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 222e86591f8a..f128d77fb076 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -247,6 +247,7 @@ struct iommufd_hw_pagetable {
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
 	struct mutex devices_lock;
+	refcount_t *devices_users;
 	struct list_head devices;
 };
 
-- 
2.39.1

