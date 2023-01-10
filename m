Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0C66434B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbjAJOcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbjAJOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:32:07 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0425241D7C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:31:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaszTPqkvEcmE/8fcVs4Mcyzai/5t4TCjwTrpSP2TlA6aHCJDALGd1gwRvZ0MaKdk3MgUmTDP+nn95XTUzg97ndiXzjPDpym/0FTRxOWQAmjrDsCCBOIwqdDZAnld6Kky5ZJcSuDId7qP+s2/agdMYMhvw7Cpa2WSmXZ6ERXfYNDw64tTlM7lX1rrMF0IcTQYdhjK07FzhX/N0BxT0dAkVbFW9GdLELZ4YzsB7ZD4kaBp2EhyZlvIpNEpruL1ugQ75Gt9dxGpfSoWs7DjW4e5qA6xHU2yVhdQ1ztVYdWipxV3iGNTWcy59dZji65OHAMFWTtS71ACYQ8IYC7CEm4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUCzaRAo3/Yhy4I3ec5wExZ7AcrrNC5IZfPzg0OxckE=;
 b=CRjIzsYmsVz13yENzbWTOGNpFBVzHT/h64afpQFyMUJuEi0gIFs+UwLNsepOj56V4JkljIumXT0MrKF4D4fc6/TOLTYcrVtqCopZWsdB1inLgoNwQTlvJyEye4tBbYY9FBgyGeIpPdScdHea8T3jcLpldAVO5u2iFQQgzKKva22HDuazlQxTUyRawJ1TPGG4i9BZbraZ8IxHWLzKUgN/PhJquUCkb5GCNqgTTjezZAC977a+lImJ0FiP7sMfffGtOeORQh5Eh4lq/ly5UBAPeGNu6I3UnaXc/iOdZ3fpfy8Ex8yu7Ge4Xt1vEhXs1l4oeVXGAy4gCzL9A6dkbdosTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUCzaRAo3/Yhy4I3ec5wExZ7AcrrNC5IZfPzg0OxckE=;
 b=0yHTxesf4E5KOXebAmpjXXMbm0bwZVRiWGkTxKy2ZPkUU6S40isCXVionVZ182AGmH5ooNXS0MpZlW9UUW0jEXYMpggIvjzd0p5rtHwxqWlOrRJJqqeWFxL6UzN2YdV40nh/BS3/ckusAmoBCiSwN8041K8Xc5o9F8aOXGRVEko=
Received: from BL1PR13CA0259.namprd13.prod.outlook.com (2603:10b6:208:2ba::24)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 14:31:56 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::7a) by BL1PR13CA0259.outlook.office365.com
 (2603:10b6:208:2ba::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 14:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 10 Jan 2023 14:31:55 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 08:31:54 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
        <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>,
        <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/4] iommu/amd: Force SNP-enabled VFIO domain to 4K page size
Date:   Tue, 10 Jan 2023 08:31:33 -0600
Message-ID: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 9968f72c-d354-433f-4541-08daf3176c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9tuynT7aGP782gWOg/g1ixc/DulzjlcxHtvzurOv9myZJ4uGb0bPuOvSvZ44Cqi4hWjbgPbZhStQVshSHNp+Rag/MAavRmPvkwLLMtI+vQnmiZkAntiuYZFCtKKtXoSGRitWlvR/dA06PRqxIZdzpYOD7SYFxYX6tGlhyey+L7/r/hOqMYdKWbF6aoe7WpUmQikxdkvfozuEeIDMf6pwOoIPd4fiztz0VbIlh0KSZGRMiEhayzHu0P33eq66mHZfNU+q0yrHj/gxYPqWg7cYoG7MzvZ8q2ltN7nTiLCGZdI/S12rVOPJGyTVro/KvVW9p+CYORdR0f2j71QoAN6MWHG8uA7DKKSQ8tIFdauZ9f83aDwAOraqOFaf2HSLqS/U4acyoI/KColra0v9zEVBfE1ttnsrbjBRSQRTJYW5+NlgvGEAR99A1v5YKzJGQfS8yhM/29CHdomeQsFKiEvXJEibtS3AmrZFxUYUcuYWDNxuzPHcRLW2MwONKGmUKobF4UFG4f+qo2VNG7pguop2eQgjWCDef2dYwaujuvXIEBY+KxhcZMf5JV46ZX+aNDb1CwwInvAYpREoJJdpI422AKtET320tdg/I43zvrAzDP7K2+RgEnL7YiQCwiAoTg0JfBAJSqdzjNUwyXSxsNcjtYlf6CDHdZRWFSUbgDsc6jei7b4xCV5AB9PYgwnyOFz8IJCyxcr4tKFDJDhWqG2o6nQUfBJ1GVlaDqGmOhhwKI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(6666004)(478600001)(40480700001)(2616005)(1076003)(4326008)(26005)(336012)(186003)(70206006)(316002)(8676002)(70586007)(16526019)(110136005)(54906003)(7696005)(36860700001)(40460700003)(86362001)(82740400003)(356005)(81166007)(426003)(83380400001)(82310400005)(41300700001)(36756003)(5660300002)(2906002)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 14:31:55.5758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9968f72c-d354-433f-4541-08daf3176c7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support VFIO pass-through device with SNP-enabled guest, IOMMU needs to
setup IOMMU page table with matching page size to the RMP. In order for
the IOMMU driver to setup page table appropriately, it needs to determine:

1. If an IOMMU domain is a VFIO domain (PATCH 1)
2. If an IOMMU domain belongs to an SNP-enabled guest (PATCH 2,3)
3. Appropriate page size the IOMMU domain (PATCH 4)

Please note that patch 2/4 is a preparatory patch for an upcoming series
to support SNP, which implements the call-back for the struct
amd_iommu_svm_ops.is_snp_guest().

Best Regards,
Suravee

Suravee Suthikulpanit (4):
  iommu/amd: Introduce Protection-domain flag VFIO
  iommu/amd: Introduce structure amd_iommu_svm_ops.is_snp_guest()
  iommu: Introduce IOMMU call-back for processing struct KVM assigned to
    VFIO
  iommu/amd: Force SNP-enabled VFIO domain to 4K page size

 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/iommu.c           | 45 +++++++++++++++++++++++++++--
 drivers/iommu/iommu.c               | 10 +++++++
 drivers/vfio/vfio_main.c            |  1 +
 include/linux/amd-iommu.h           |  6 ++++
 include/linux/iommu.h               |  4 +++
 6 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.32.0

