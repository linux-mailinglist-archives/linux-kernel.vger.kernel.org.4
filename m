Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8C664351
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbjAJOcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbjAJOcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:32:23 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B537435920
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWi6imvJdllrdjJConVgEzKBdURG6IimciYyLUY7uBnHTV+MjwuhefSorgjEA+jC2aKfVP4o+0loEqmL+jEs7jhU0d5ZaXPmPHkgBYakaFgeu8VeaCH/tdpakSw3NMcSHwUw0/r5iyiL5m/eWCOfvOvnS20QtHejRt9z8EBWyQDsX508MinqJNCM9K0vvLNsW/gsBfHNWiyuOiaOVhNhQw2VHlvkVHo7IOYwknduFMPivfO0GAPv0+TNNQGVTzXN/z2YoTws8yJNTFZwBJuu1YwJZjm6EEUbM804qMJk0WrGz5AS3GmqbnTOQWhnFD/VYOJR0YQjjORjHALksqDqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObSra1/iNsAygRiv1o7a006n18bIyMdju24xnrqtOsQ=;
 b=izP8FD3BupP/F8sm++VbTGWEq9NrvUouYy9Rh4dZsgkx9JsuiODImwl4+ZmLsd0cMZu82ZBYI5/348ijBWhqO3Hr2JDZDTvz8ZYPjs7XjHPn07b4uFovGAYBo1p+2lIluevBVL9I6j1GusXa9aj3R7AYjp+vbIhF2/mXNB1h3AKfZ96LmLQov0FIO68gQ0Z8TTeDd1wNfQ7PnKGCJznbO89/44Je04NqH/08yzDpQ9DOo2vefVdFH/WbQBenWAplclI1MwXvmirui8U1VUtmk8phShfHacWtsolhpCsw9JhAe4TQ7ZdtCzi4FpzfX3AryKGVm+zg9Is7SlORuOnnAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObSra1/iNsAygRiv1o7a006n18bIyMdju24xnrqtOsQ=;
 b=qkjD0MssUalUPgwmfPczvbeKOGF+dw5WjDhtEmNxdEJ79jpIucKJzVBoSc7gtKEMnMbk5bNWAF/hEpYJUqWOmU3C8kYmaiXNDPCAVIyAargBypvF9wH734xrRv5KlSziMNo/ZdaFsbMqHixDJC7hdvJMxwq9zolmifOKUNnwyTk=
Received: from MN2PR15CA0010.namprd15.prod.outlook.com (2603:10b6:208:1b4::23)
 by DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 14:32:20 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::cb) by MN2PR15CA0010.outlook.office365.com
 (2603:10b6:208:1b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 14:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 10 Jan 2023 14:32:20 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 08:31:56 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
        <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>,
        <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/4] iommu: Introduce IOMMU call-back for processing struct KVM assigned to VFIO
Date:   Tue, 10 Jan 2023 08:31:36 -0600
Message-ID: <20230110143137.54517-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|DM6PR12MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be5586d-05a8-4307-d13e-08daf3177b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGxayu5ztePtiY4bjXpfNqFmhifipGaWnnyoF8DrcxhiBLscdInjdwDUiCb5xNuhJzir9gTG/v/J+fLSSt1g661aSrmGTHIF5wBm8ZizWAMmnQ/LYfwkVusVRSC8L81xpFcHHPb1494D2KXoa7a38K9B4IdayD8roL9DinhQIsnSNvLgSeDf8NmCtiM/GfQY0p+EeWVx/ujCkcH2GfmOsfcxj9+Q0of8CBZXxwoKJlhb65xY/d3yEQSSpH2fG6nC/7F/vUJGmhhmVkpfGcKf+knWpTckV/KozyDZ2CQ00Plm3N9gWVK94teMLxmCWPBEjDVCz+oiibjW8iGQutgmbrdUjqWMLi4LN/6uEOMUWMRrsECFwujjEXaJ5BHkzz2OgsiblykhcGYSvPosG9oRNzWwpeF+vaPsl3eIclRcEpYaC1y+m5UjCiG/xz8dgBQUChuXKkeMfSCZNN9Nz1QH4w+trQNffk3SwAFYuBozx3Mv1rSg+QvAWKaCb2a9eo4ezjqYZ43yNJlGmJvDGNn+LrmLWof5FtrJPPZIYGnkPNWFjW5vztMsAh7DDv3T2QMWkRKNbHhDrgzRS6qSdq9uzexPVDNA3b8/XnN1Fqs4PgIc3FwZ/4RgowNO1ol2YuBv7TaMaDaZ72OwXzO1YZgrbFDDfBNUpmSZlLz6GDhXO5iOzUYMcdTj5adZgEOHuwLF08xhnJwfU6BQXQjkpz8hYUYcUDyksxojL4mFoNWblBc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(82740400003)(2906002)(6666004)(81166007)(356005)(2616005)(1076003)(26005)(44832011)(7696005)(186003)(16526019)(40480700001)(478600001)(316002)(5660300002)(82310400005)(8936002)(83380400001)(36756003)(86362001)(47076005)(426003)(40460700003)(41300700001)(70586007)(8676002)(70206006)(4326008)(54906003)(336012)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 14:32:20.6338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be5586d-05a8-4307-d13e-08daf3177b6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, VFIO provide an kvm_vfio_file_set_kvm() interface for assigning
a KVM structure to a VFIO group. The information in struct KVM is also
useful for IOMMU drivers when setting up VFIO domain.

Introduce struct iommu_domain_ops.set_kvm call-back function to allow
IOMMU drivers to provide call-back to process the struct KVM assigned.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/iommu.c    | 10 ++++++++++
 drivers/vfio/vfio_main.c |  1 +
 include/linux/iommu.h    |  4 ++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 65a3b3d886dc..5116d5fe35f2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3231,3 +3231,13 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return user;
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+void iommu_set_kvm(struct iommu_group *group, struct kvm *kvm)
+{
+	if (!group || !group->domain || !group->domain->ops)
+		return;
+
+	if (group->domain->ops->set_kvm)
+		group->domain->ops->set_kvm(group->domain, kvm);
+}
+EXPORT_SYMBOL_GPL(iommu_set_kvm);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 2d168793d4e1..7641e3a0c986 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1652,6 +1652,7 @@ void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
 
 	mutex_lock(&group->group_lock);
 	group->kvm = kvm;
+	iommu_set_kvm(group->iommu_group, kvm);
 	mutex_unlock(&group->group_lock);
 }
 EXPORT_SYMBOL_GPL(vfio_file_set_kvm);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3c9da1f8979e..43000231d3d7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,7 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_fault_event;
 struct iommu_dma_cookie;
+struct kvm;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -314,6 +315,8 @@ struct iommu_domain_ops {
 				  unsigned long quirks);
 
 	void (*free)(struct iommu_domain *domain);
+
+	void (*set_kvm)(struct iommu_domain *domain, struct kvm *kvm);
 };
 
 /**
@@ -391,6 +394,7 @@ void iommu_device_sysfs_remove(struct iommu_device *iommu);
 int  iommu_device_link(struct iommu_device   *iommu, struct device *link);
 void iommu_device_unlink(struct iommu_device *iommu, struct device *link);
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain);
+void iommu_set_kvm(struct iommu_group *group, struct kvm *kvm);
 
 static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 {
-- 
2.32.0

