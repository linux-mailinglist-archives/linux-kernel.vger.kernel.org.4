Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344CD67F3FE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjA1CaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA1CaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:30:07 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F0C125A7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:30:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gceOGWsEyQX1zBfuSuoPdMzFcD16jFqQ2jtStRhvO1VRpeAJkKgGqmIy/solH0uIX0i6zo607kTNUhxTEtpWGrYTjpd0poab9NHmXEoX4d1hdiau2RR1hSmo/vtgTbbWogNSDqHxuMpZdyzDd9rbxZ89zb+m8WCYunPCfZTxWi9L+3+ugbc9g4Gj6oFoOz7s/xk/3rVwU70rqnwsAggZgVAwoKMAPj5HDfv74SgWSYNR24CmtpgWPfoSP58BAJONCZfQYx+80ZDSAmp6CmIpQxuqjWOkyUaCWJklnv/ikK27GBTvc5dCuFfFUeVtvnodllwK62lwLlQ5k1+s+tfzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sy8OoCaxDiGvWsvGp05HRDhS0I8R3PAh8VFw1URM8NQ=;
 b=Qx2fB87QI67psAsOYW0OB5npwDqckcDt4xeqytBEA3r3wZsSLIFSaC5Er4uDI/ZBxdQbbo3GzVpZ/wwQTv1lRmby3OfFLNGyqL/EnUCss97UYBhhSuQrT9truN70UUnpdOqeZAYGz3i7Z/vdKCBBlym2hiwli0k0CjiQO0rklTUW68m+eTcSk4atI11wFiktkVironnB9g9hBKfZBhHbQ33xC/pgmLDSep51y6WOGWdbfsIyCm/KrhKILqn3dtigFf2iU6dpJsb8Md46rGbqKxND0xPgGcvxd2z0fHKDNhDmANwokGKN5ytGTChq+CpozMuKHXUtx5J5HutPqZPcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sy8OoCaxDiGvWsvGp05HRDhS0I8R3PAh8VFw1URM8NQ=;
 b=oGI0v3xJ6OpXMoQ7BMNu9DuqTtYm+7WKyuKEMP1qP44nElkh6Cp9qxLltPBGSrkf6/CEeXYtoAxlzINHNVxSI8Ma1RydVrA31sHYH+zl7wpb5IihRu7yJCxIZXtp/IPVb2jVENFiyenJwqvgKNFuR7gg/Kub+anm9rFh09cSRiGnIcyfIAp22gdmR80AlhkyFaFczQf0nLILvi562EAwvX8tNESeqpEiFZVWHQBXqxkdCYmeDHeQoX5JT+FXyR+X/dIEpxv5A8eIN4Se+p/jTDgDBJNZdoGAmxkLxkLjn9HxlFz81Y3VH1/dLdzPkxof7TBV25AjZtN2CEi7mKS7Nw==
Received: from CY5PR14CA0018.namprd14.prod.outlook.com (2603:10b6:930:2::18)
 by PH7PR12MB6612.namprd12.prod.outlook.com (2603:10b6:510:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Sat, 28 Jan
 2023 02:30:02 +0000
Received: from CY4PEPF0000C96C.namprd02.prod.outlook.com
 (2603:10b6:930:2:cafe::72) by CY5PR14CA0018.outlook.office365.com
 (2603:10b6:930:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28 via Frontend
 Transport; Sat, 28 Jan 2023 02:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000C96C.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.16 via Frontend Transport; Sat, 28 Jan 2023 02:30:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 18:30:01 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 27 Jan 2023 18:30:00 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 27 Jan 2023 18:30:00 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] iommufd/device: Make hwpt_list list_add/del symmetric
Date:   Fri, 27 Jan 2023 18:29:41 -0800
Message-ID: <25b3b85b03fc2a7968c476b0533f451acecdfd13.1674872884.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674872884.git.nicolinc@nvidia.com>
References: <cover.1674872884.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96C:EE_|PH7PR12MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d016266-2ef6-42c8-c7d6-08db00d78f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHKNdfOXLsmmNrvdw5205Zgary/k58gnm9VUqLE4ZE3A8S3kNTlLmoQTjDfXRNxf50xtERMU3IoDJHoCfbQWK7i3ULt+zzBrJLPDRZKH0k5aLEqLM4FDEzMalq20ooZIZ3nMlsbjvjXumCUJ30TbgERZ+jyl2BZpV71IzyA9TXvPGjcpm3KyBFuyCluB2i+S3JKTSvavKBqFLKBMcddgLMG8/OBm1twDAUayK+QUzfBLtad+OzJi9E0OP1A7Tc+q6i/93/AZ9PomU5TMzZPHCX25Pm5t3j+krHP17Cc71syEB384lhKvOcp+EwmDJ7gu6bW9wDeSmUXAzjkppNwrtpGRsveJScVWpCP6V0XU8uTfrFXxPbJXvmu2pQMNG92W/mwEvJfQJejoUdSseihX601R4qnwLLT13bvato3Y0WaJaaYcpzz+FuxIqIZ1xX/IEB36jahoULYDa7CgeeidMtbWFoNP5gXY4msq10ZlPMXRdlm44DxI9pOgbBK/g1T3oGqVmMBwASFkP5aV2BCrRWSsH8iIsJuEWFFFeNFZgkyNA/7XT4kbRdo2RT28HqlS+A3coFR1QYbCn/R74/6tXpd6tuw2iW9Qkln5DgK6ahMFWft1XWtRwgwcBUmBQvkvr6JkwVSQwcxkpgNXWMvT+IKCJkw0c0SNQV2sQVeQ6RLPVR/gFF84r/rExzKpwgq1inc1wqQ6w9cd2Uocb0BhAQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(46966006)(36840700001)(40470700004)(47076005)(82310400005)(86362001)(40480700001)(40460700003)(356005)(36756003)(36860700001)(7636003)(110136005)(54906003)(82740400003)(2906002)(70206006)(8936002)(41300700001)(4326008)(186003)(5660300002)(8676002)(2616005)(70586007)(26005)(316002)(478600001)(426003)(7696005)(83380400001)(6666004)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 02:30:02.3319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d016266-2ef6-42c8-c7d6-08db00d78f40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6612
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
index 208757c39c90..0248073e3169 100644
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
 
+	lockdep_assert_held(&hwpt->ioas->mutex);
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

