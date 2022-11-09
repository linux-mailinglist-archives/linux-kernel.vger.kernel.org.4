Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311E562246F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKIHIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKIHIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:08:41 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E036341
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:08:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaVLJ0aoQAE2dBUK1G642aEosJ2PLPETuz0tAqm43xeCgmbhgdTHA6gCel/i7H2OJGKpaNnsSBp/KzGIT6r/Q+awbInZlNQs0UpoykON1modRfP0VbSENa2AzTOGIjHtrfua7LlUGDV72Qq89L26la512lt6aC4z0CXtNoZym2Xw4nQicdvRwWeMH80e+dbtGNDvflenL2o4rpQ1PvsHXvYM1nRGZXAx+F03eQZE+7Tayh58ht3KqNcGkiOA3SJR/CWZDvS/giWYljRxdBnU31z9MFw3TT0lpQmX+I5dZXV4LUVeEbJbc10ZAs3pC/r4/QY1bzbZ3xbUt7MRuLeDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjrdamAIX6BKa8x/tXqu/xSdsCJKHFG+RKkb462InVg=;
 b=b13lMMsE3Sh9usKGAreMqQ7Mq8/C5xPKXHHyf4a6OuqIPUxyPpqCBvN03rVeg9cmU4TEcEosZwbdXqxmGRJcHa4/tNyWLXE6jlFGJ8nGpKrq23xa6rSJGgmljn9ibUAP8KoubIPVWJ+cjkwObmr1ng2U39wUOtkg9Y8P/F3TbS/5etbssVRFpAKTizsYjChauf63KGbyqjT+Xki/mLpkwyDyhjDGNZZr2e3us4UjWKfN9eKIcfgNdifKgj3VwrR6logDfoJUQZr8MZ3nBfV05bwehc2UHhHNrhGyNSAOajnSKy2GLYaSWQgRTF1PIP2iJEFF1HShuVyI5WHskqGUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjrdamAIX6BKa8x/tXqu/xSdsCJKHFG+RKkb462InVg=;
 b=r0g9QixSoninAt6PO5i0567kzTwkdXaf3+P1iWToA3+fBIpXdWpCTFMGxxR6ZBXwRwqDXMuKUXaQiEDMoLKjoXvEWKxJULEns8llAoArbiS7km+T/i3V0gYUowkxc+9ozuVJyTy2etI8d7Nbu2BpNp8z9kqaxjdfu+eM29d7KMuLNoA4h4i30wRak8XX4zGaPOWAU49SZe4Kp92wThwfffs4iBWJXDg3yzl6cnTtG6vfTOiyknS3PKo4MnFLiNyQjaKcp9Rm0Lm4Wz4TDGzpdpmqoi6MqOcuCLyaU5y3uammY2+7P5g/lpr7qL1N5vKZtG1Xb68fHcYm5xIMxJLCvg==
Received: from MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::18)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Wed, 9 Nov
 2022 07:08:33 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::b5) by MW4P223CA0013.outlook.office365.com
 (2603:10b6:303:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Wed, 9 Nov 2022 07:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 07:08:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 8 Nov 2022
 23:08:20 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 8 Nov 2022
 23:08:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 8 Nov 2022 23:08:19 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <joro@8bytes.org>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <jgg@nvidia.com>,
        <robin.murphy@arm.com>
Subject: [PATCH] iommu/arm-smmu-v3: Restore prints in arm_smmu_attach_dev()
Date:   Tue, 8 Nov 2022 23:07:13 -0800
Message-ID: <20221109070713.9617-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d12837-1ad9-4453-c1ff-08dac221368f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6QmZGjBQ4eacFoC0nIjNm1UjGM8w2iSDRlaBmeOisAsWRP4FMfmNSQ4AP/VBQG4Ci3SpCWvJThYqIRY7lAzOxuPFQedoX4delWPQ/U6MFPFTd4Y2VAUT4hQimPywM9DSCsALWl8UDX28Cz6qTsIcG26M4RmrQiy7NFYroXHSdgZ/Vy/VmCeT9VjY3Cc0qW4mHbisVa3LCdb2p5ZsJNM0R1wA+xbQHQ1U374nYRn+/WcDEIWfDc8V29qnVwIDfS++ghc4Uuu/DB8MtnaWStgnxKyhWq/MesyPmRqNXUEHRWhcry2AMGFi0aR099itZxqkDraGe6PIx8qV6ph0JcpIYXPpGtreE2t6W9L+p6Y7cXQtbIQc/qvCZhEyeF3VgKHq+afj8oIk4z4hqU/Gp/hLJYC1bXT6nQkBmHLFc0FIPqYifWvMC4shH4kl3hATV5CLAoBX0KUT60LqaiE8uv9LbWRApefSwMX04Jfu2OdS4Fk8BpCpYgbtUbJfPxmMV7DuMMz3WcYWitT1DksMSJQmf9f+qnS5frOyd5zffOHsthlBLxM7bN1LNBt90TjzZzNjdjLPTgHIc4ptePWbfw6Yf6kfYRm+TvMTLClLV+fec0QTypfn5bZVu3Oxp4TCoRB4La2J/xSQ+Ac/Qqg4uEi1fnFH0MEVnxx7AO0Qp0+GkEUW8mgqosilSFUnJIL0gpyRnsaairFf42KjViILbaFTUEc1eVStlEDlmLDNG2ZQTMJelw5/v5DrtdFxkCeg1fPWKBlWMjNLI6sjef+ECuCJQig6n4qfOZ8htlB42bejlg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(40460700003)(82310400005)(86362001)(7636003)(82740400003)(8936002)(478600001)(26005)(110136005)(316002)(5660300002)(70206006)(426003)(2906002)(54906003)(8676002)(4326008)(7696005)(83380400001)(41300700001)(6666004)(356005)(186003)(70586007)(47076005)(1076003)(2616005)(336012)(66899015)(40480700001)(36756003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 07:08:32.9884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d12837-1ad9-4453-c1ff-08dac221368f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prints for incompatible failures in arm_smmu_attach_dev() might be
still useful for error diagnosis. As VFIO and IOMMUFD would do testing
attach() call, having previous dev_err() isn't ideal either.

Add the prints back using dev_dbg().

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab160198edd6..076d3710b1fe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2433,14 +2433,21 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			goto out_unlock;
 		}
 	} else if (smmu_domain->smmu != smmu) {
+		dev_dbg(dev, "cannot attach to SMMU %s (upstream of %s)\n",
+			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
 		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
+		dev_dbg(dev,
+			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
+			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
 		   smmu_domain->stall_enabled != master->stall_enabled) {
+		dev_dbg(dev, "cannot attach to stall-%s domain\n",
+			smmu_domain->stall_enabled ? "enabled" : "disabled");
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-- 
2.38.1

