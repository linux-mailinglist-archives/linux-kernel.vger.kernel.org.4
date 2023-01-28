Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5B67FB19
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 22:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjA1VS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 16:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjA1VSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 16:18:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E253C37
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:18:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezel19QnPKE8dDF5KMql0+HhsVpQanqFEjmcWV2vjZLYoSISlcX/uaMmKhtjQ5P4LThbla/bOgrUdzy+keKqTX+vJqGoj9ig8hGLXHpIZKNCOw7adtzU1HYYiumr/YM0U5qhpAxIF6TZhWlY4MFobayalpJf7R6Nff6kcu+Kia10mLRm4FglAq7tTdxvvRBRoRNy8397gahlUsMkwfzOny9AvxQve6N43Hr8AK7OIHW56H/o30I3wjiXQUg4u2HiYUcCNJcXpvEpj3k9/xce0C3MaloeQtXMMVWpHGv9grr/nl2GD7EcPhSONPV8nRxiINfyDUM9h5YX5in/3YsklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIipKpqrcQaTmexwsgwIspS2mdrDvb9370ZdA/njTBU=;
 b=nobznFNhaM9Bg+JFjOE0c1qMg2DrSRA1Vt84Ss7ShLZ+97oyLiPo/TmELj0hUwk+ZiFlfEe6K4YR+GHMWlTlhEDQt5Je3fLd6DZ3nkAdgxtWGYWkbpVJC/aJPuCxkSrNNJrRtmViBbNozQPSfFnZbwZdfAgxeB8er+xIihTLbVAqMwqqLw95jMCIX1gielNF11y1CHBLUWqJ0vDrM9zNXf9Eqx2F1hTHl1f18gaH2Yn7Pd76EJwVIWqnLlphIamgkvWeInMkWLBFZJxz5Bpg+ITH/wHols15mefkGE6OI/6g4NxPbxoKvgXXY6ItSJ8iWTKyKfNbszJdP5JO7KhtJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIipKpqrcQaTmexwsgwIspS2mdrDvb9370ZdA/njTBU=;
 b=W17xJuv0fMvHOSDXNS6qspmpXwN+O0HbQ5Gg6bG8MlgvjnST1RTlDuQJDlUVHWxlnhh6MNoP85K6EcPT2jcPb3TaBQ+okDHJbVdTwAV6T048vvY3JKAQ45TW20MhRBjUox4Lc/lu3JrHMMv8RwyRE4RVCB41HISd+15Lr/AWQMDaGhkU1r66MNxULapDiWVaolidZBWw7KGmqWWZFlDIXeKnrPwQYh1ktWM6nOdH3lOGgUYcoDl6/MIPmp74UsG6Z8SsdavyedyzmWJCJut8Zh436Usj3g6NyCnaZssKsHLhrT5HNzBUETatsG08rFBTSIssnWhQ3UWIVuMF2QBHew==
Received: from DS7PR03CA0127.namprd03.prod.outlook.com (2603:10b6:5:3b4::12)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Sat, 28 Jan
 2023 21:18:36 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:3b4:cafe::ea) by DS7PR03CA0127.outlook.office365.com
 (2603:10b6:5:3b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30 via Frontend
 Transport; Sat, 28 Jan 2023 21:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Sat, 28 Jan 2023 21:18:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 28 Jan
 2023 13:18:26 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 28 Jan
 2023 13:18:25 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sat, 28 Jan 2023 13:18:25 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] iommufd/device: Make hwpt_list list_add/del symmetric
Date:   Sat, 28 Jan 2023 13:18:10 -0800
Message-ID: <6f388b1f20622957518ec5a9ddc7f0037e7671c4.1674939002.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674939002.git.nicolinc@nvidia.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f34f023-f9bf-4dbd-5295-08db0175377b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYOcQ2oesGF/62gSEkCity2QT2wMBquzNUGzMs86AvD/KBLjHQYIjD2R30O54VYzHVXa7JGzoFqoz/YPlb5lw+yoX4JFlnfLzC/MnIP2sWiRSO0cq2rQxsTZyAkfCB+2k5q03EKs2Id8mYwcSi58u7ygIJoLHFhRR4HCp9C/+wNBdgkOfMFWTH4DKRhC4eXXYY4sbP6ji4ztbD+RBsLgvu1WDKj7cQzA3wGBoOciYTHIBcr3fSeKPGwV6JKB4H8jf6kHnqXjiBzete6B7PvVwkt057BFWOg02WX4Od2LFAiqna5TYlnjrJLDMAiKr6WAIlLpznjIr4fji1aMedaZvkmnoBAsYpZbN+q46q1tuAhWwzurC5HmA9xZXAyT+ao6OoB+PWUA9ZSow54g0iXSKk4OnsIs48cryHxPK/k++U5TPGDniz10MhNUz9voCeD8XPH2oSZPuz8jVbhMuooat0hXdaQh93MUdTBMZA3FNX7sAMa3z44Mhldi2tK4xu7lfHVNwXP7wpOKnQSvQzdRKBDvRDxZHVEhXT4nUlMZMX4zKM/XNd8VP0q2rQYjtmtHsNyNcqRQ8RkVhNfPZEPbYzig6e8tvgGj1/9eixK41/rl3evI1aRQHeOUOjWXKQRRAtCRXnKSMTp6KLQSCPV/ZZOcKjEp047KwRC4w7iobVNaSt/Mj8JVvNVdpD7clFObtb7w0pgZHZTS25C2QdoE9w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(40470700004)(36840700001)(46966006)(70586007)(7696005)(82310400005)(26005)(186003)(86362001)(478600001)(6666004)(36860700001)(40460700003)(316002)(110136005)(54906003)(40480700001)(8676002)(4326008)(70206006)(356005)(336012)(41300700001)(2616005)(47076005)(426003)(8936002)(36756003)(83380400001)(82740400003)(5660300002)(2906002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 21:18:35.5125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f34f023-f9bf-4dbd-5295-08db0175377b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the list_del() of hwpt_item is done in iommufd_device_detach(), move
its list_add_tail() to a similar place in iommufd_device_do_attach().

Also move and place the mutex outside the iommufd_device_auto_get_domain()
and iommufd_device_do_attach() calls, to serialize attach/detach routines.
This adds an additional locking protection so that the following patch can
safely remove devices_lock.

Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 208757c39c90..9375fcac884c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -198,6 +198,8 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
+	lockdep_assert_held(&hwpt->ioas->mutex);
+
 	mutex_lock(&hwpt->devices_lock);
 
 	/*
@@ -241,6 +243,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 						   hwpt->domain);
 			if (rc)
 				goto out_detach;
+			list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
 		}
 	}
 
@@ -271,12 +274,13 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
+	lockdep_assert_held(&ioas->mutex);
+
 	/*
 	 * There is no differentiation when domains are allocated, so any domain
 	 * that is willing to attach to the device is interchangeable with any
 	 * other.
 	 */
-	mutex_lock(&ioas->mutex);
 	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
 		if (!hwpt->auto_domain)
 			continue;
@@ -290,29 +294,23 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		 */
 		if (rc == -EINVAL)
 			continue;
-		goto out_unlock;
+		return rc;
 	}
 
 	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev->dev);
-	if (IS_ERR(hwpt)) {
-		rc = PTR_ERR(hwpt);
-		goto out_unlock;
-	}
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
 	hwpt->auto_domain = true;
 
 	rc = iommufd_device_do_attach(idev, hwpt);
 	if (rc)
 		goto out_abort;
-	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
 
-	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
 	return 0;
 
 out_abort:
 	iommufd_object_abort_and_destroy(idev->ictx, &hwpt->obj);
-out_unlock:
-	mutex_unlock(&ioas->mutex);
 	return rc;
 }
 
@@ -342,20 +340,20 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
+		mutex_lock(&hwpt->ioas->mutex);
 		rc = iommufd_device_do_attach(idev, hwpt);
+		mutex_unlock(&hwpt->ioas->mutex);
 		if (rc)
 			goto out_put_pt_obj;
-
-		mutex_lock(&hwpt->ioas->mutex);
-		list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
-		mutex_unlock(&hwpt->ioas->mutex);
 		break;
 	}
 	case IOMMUFD_OBJ_IOAS: {
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
+		mutex_lock(&ioas->mutex);
 		rc = iommufd_device_auto_get_domain(idev, ioas);
+		mutex_unlock(&ioas->mutex);
 		if (rc)
 			goto out_put_pt_obj;
 		break;
-- 
2.39.1

