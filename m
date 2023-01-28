Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C067F401
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjA1CaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjA1CaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:30:10 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5C88CAAB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6tKitHNous9gkS+mWidlJEQDL9iOPj9yDOOs5qxSzfuf6OPZFES/2JThzRrhsSP6RccOIrcKasvlGqKKgQz5oEKYbiaqNxgJ1vqyKnPBBDeR4VlBAV7EJWNl51vhlF8PwUMC6MrIX/cM3iQ1aN5666IQDXCbXiyxbWVCkF2+HOOK9GK7hZMaz1ABwNb6z6fs31R/CaFv7+JXKYmDJ4gwDQSLbDtlPd+noqG7gTZlOSSAzRbWqfzskupzxChs/9M1BrQyvdgY2dY+A0v928OGA8cw4fM7EnNDDPm4W9LTILg1iE4R1SiAOZr/8KIABKXpIB68ilw0fTUtQHTPnbEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aWMGcXQVNAN9lZL32+cKA11taZBiVCr7fCTxeRXQ+0=;
 b=MpRO8AaKPQmRex2z5/PvraYx/tV5RNBeNet97MijsTTpXkFkApL96TWM9X6fZJCO2hpb7D7u7n+FQJ+o8gfna4R0Q/017MGQUD95FyuPsXeKmwmP6uyp8ebYEzA5B9kRAExhREAeTEhp/30iq76z9yMYlMBOG3ZvwEM8YO7mgzL8WzjOmm+llHTVjQ5/Vvl/KSA5rmLC0ZJHtZ2PJfljGPwyeXX8yySBuzxBQ2hhLSqq20THPtqEWQLEAw+epiZ63mon9GNs9fMMpHiANvxd1Ieg9fpHQ2IA8R5KMl4m/YYNwPminGjM/HkfhcrW6UZRQ91Ykq6+KGw/PpkSlW0X8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aWMGcXQVNAN9lZL32+cKA11taZBiVCr7fCTxeRXQ+0=;
 b=lpuYtYkMJpvarmPqc2QZViZgdArKwjC0G9QbzKbfilLhM6LC8CRpmIhHeotOFtdByMvIfdiu28DTF4WValu8lFwGoCdZ9WHDfexPHxOQDJmqgBL2nwKoj5zJPT5XXyAHfQBE57HKSiYigb+ABOpTCBeKpjZ62sYnAv6EkDXZIlHz1pOjpLnt1kfe2hBU16ntqsPJvfQi1a4mn8K8TXmL5vXgXCyhQM8g8Xa+b7b9SHWJ6TIV4Yt7qPmMbC0f6+n8iOpMTkeQ93jA3gPx782cYX+CnSDvHcHBZkoMKWBgbCR2v5IC9tGgmggknyNsVpzM986iZBsqH5K78YOgACBwzw==
Received: from MW4PR03CA0119.namprd03.prod.outlook.com (2603:10b6:303:b7::34)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Sat, 28 Jan
 2023 02:30:07 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::3b) by MW4PR03CA0119.outlook.office365.com
 (2603:10b6:303:b7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Sat, 28 Jan 2023 02:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.23 via Frontend Transport; Sat, 28 Jan 2023 02:30:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 18:30:00 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 27 Jan 2023 18:30:00 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 27 Jan 2023 18:29:59 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] iommufd: Add devices_users to track the hw_pagetable usage by device
Date:   Fri, 27 Jan 2023 18:29:40 -0800
Message-ID: <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674872884.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674872884.git.nicolinc@nvidia.com>
References: <cover.1674872884.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|BN9PR12MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ef947f-d985-4948-d1eb-08db00d791ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5IOeQykiHF1x/HYORjve4tbNx8OjjrHF0smMqv6KzH06xPRAQV/JhdGHkfXqyD9vspcSwWmGei3vSV4Z7AvnZc6KXVfBWSYGUKkS5Nt+DwUc3MGmXDU5g1xZIXgmJ7pePojkhR6Cqzdiurhn9bIjF6j9ps5xV+QtmAlqp7WaqRVpASZmF5NVAeA25nVWI3kOJxzdrlOFRPVJzxqBZ0S0p3g2dEvD+mbVtCcCGPzOCv0s/Iho+eORjdgqGJ4O6yBy6OnK++b8jkab3oCtfrKi7KAIFvrsv62CIYkOLkCPBhOmzY+G4ovAekgrH6KzM0HdoH2JOsIiQK0Oof7HezY4+r45KvE+E3LqNoN2m90pIA086YK0I6D41nm4arVzqw0QaNfAehgNPevMA1GZUhqVaGke90wIAAAI+zWUI3b2IJSChTTQIQdgpF4IYup9DDSeZdO56uYlEINvw00cBed3otwYuhnj3ld0RU2p6/4aJYgwpY9uciHXiVRmAvDf4K5hXUNpObHL/FP7mZSJ6l2uWlgJ132MiOwMX/3aXdQn926sMXkBpReewTjcUYYz1cqAEaTxNe8rsYguC1HFWvQRvIJaFeAiYI9zMNlGZlMVM/eHkDoNxhTMzhQQNtU82uWco2MnZqjAVVaGRH82miEvjRFUrJE+c55fItt/CIXf0omyIpmnOYoDgVEde6vYIRBHoAkQXsfIL8jHYZZDVoBNA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(7696005)(186003)(26005)(478600001)(47076005)(2616005)(336012)(82310400005)(426003)(83380400001)(6666004)(316002)(54906003)(41300700001)(7636003)(8676002)(356005)(70206006)(82740400003)(110136005)(8936002)(40460700003)(86362001)(5660300002)(4326008)(70586007)(36756003)(2906002)(40480700001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 02:30:06.6182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ef947f-d985-4948-d1eb-08db00d791ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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

