Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC696FC4C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjEILRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEILRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:17:34 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50CA46B9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdgOV/4SU/hqRUwuTrOr246bRvkLr0Q5lhjbqBriVEojEbsgK9EhtfT6AwzVo17y76pihtTV6HCYZyYky2oxcEtVY0Rj+OPrrczDrZ9Ytdml3wbvNxspPNDNVmdEEXLxGlJSEAJ8znhbC3gk6GimzzcLjHQAlhXAsenpBYaUz2H4VnkUh9iLWf7+UqEel17OeJvja+SxeYmlQltWFJnXzdVxQNuNa03X3f/iTm/5Hi+NK1sZLDlYM0RtkeMdHNCE45joSegUOOO9Xr0tWv5bOmD888R+jElzImX4Ebh1rpzdwXg5eFxczmcp2l6we8MMCUYG9h1nRglAkcLVYPq0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Db2FFvXkPRwOozT7ly92aNAe6zN/j4mG4cTc05FGD+k=;
 b=G9ESxCXB3jLqR88oOp8Y9EolhfoDNACN1D1H2/qtwoJRLluLYtMNrjbB2+OA0IvHs/0ltiBxkpW5EfL6E4bjbbb7vcQdbso4eFkk05K/Tfe7UrCfYIalpbn+oxYZQh3IN/TWmv0RrTodjsP+RIxrJgemZhtjSO3IW9IRdttZmo04I2WPoW8VG62GG22/+1/+QVEiGRtfFzkfCTKMsWHFs33vkq8fJA+8YrDYI343sfmL0CO/nR3ILXz9MHc5ZGXDJn20pdlhtOhnQyeIxqOLg9FBEsxWXP9sg+Gz78dOG/MEo60o2WlrJYF7+flTaxxGyp78cGIlpPJQNWp41DV6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Db2FFvXkPRwOozT7ly92aNAe6zN/j4mG4cTc05FGD+k=;
 b=dqj0/jw7EcBImuS7SkBKHal0kjtqQI307bl3E0C9Jj6yW97lUV3MiXfJd6LACE9yQXu3MwBbkP0eRhNuRKShzNYtk4U+HxNkRVoTT3BtauhOchMwka8JbmcxthGbsXlfkDDPgP93dJEzs+te4nMs1CfduWZpvYQSkVxbScXB2Dg=
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Tue, 9 May
 2023 11:17:29 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::68) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 11:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 11:17:29 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 9 May 2023 06:17:27 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/5] iommu/amd: AVIC Interrupt Remapping Improvements
Date:   Tue, 9 May 2023 07:16:41 -0400
Message-ID: <20230509111646.369661-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: fab377a5-914a-447e-c1ae-08db507efa19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99crii/y8czKRsxvToXJdxtzJn5zhZeE02edQe/gtKNoRLCIM/yUrTJ4QQUM5PiI1nZZ6pN7DvGdrbHDH50MgChUiOQDcVTRiCRDpiCDGkXKgD+rD8TqYTieQoFiapUkmgA48D64CGslAkErxGs+qEEgEVb3M9QTCEqKtYTLeFtbvEIgTRQyEmfqtVK2Mp+agJpPIrvB5E/i00lcUpkZLyP2UNW9p9qQkdutGZu6ps517Fqj9kK8BkAzfBPMWLjKgnkhi37ANScZg5zZT8Bgni1UlXm27d2lFWVT12ed5X/PAjkUjKNvl9KxLziIUJFpydLNRgIo9h3kjF1ghTLX0hYh/jtFEir13I5CPwwDdbK0kN6NDNgGgcSnZDBuU4pPDZaSjUo687fa7vzD1bOtp7Gshzu+7gs8oUYNJZrpXsEknCitAMwsruvbcLDORtnsdhG2nYybaS3lHf2+oZEPKUUOBop/NzNW7UebDLeuJlcE6KZT4oGIfpHA0uwBC4M2hflFUA1plQ04A46AhJQ237VlnrY3adpAd5Uwvi+LlVHRrNRKGDevqmmKTf/BBddqH6O22RL9Ac4xXDj2wt3ocz1fs4wAJWCIRjymh8rY0aTu4d3EyUanIwGXDS/ief2Uit/3cgoZ1Lpn1zWxfShFxQ0iLtcnpeaQabyp2FaBQV/Ranr6/G1NDiJXfKoM88ySD5uf4lii5O+FdFyIu/wE6I5Lfqvq0CuXMJ80GkTBnyQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(7696005)(41300700001)(70586007)(70206006)(4326008)(478600001)(40480700001)(110136005)(316002)(6666004)(8936002)(1076003)(44832011)(5660300002)(40460700003)(82310400005)(86362001)(26005)(83380400001)(47076005)(336012)(8676002)(2616005)(426003)(82740400003)(36860700001)(2906002)(81166007)(356005)(36756003)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:17:29.4681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab377a5-914a-447e-c1ae-08db507efa19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For IOMMU AVIC, the IOMMU driver needs to keep track of vcpu scheduling
changes, and updates interrupt remapping table entry (IRTE) accordingly.
The IRTE is normally cached by the hardware, which requires the IOMMU
driver to issue IOMMU IRT invalidation command and wait for completion
everytime it updates the table.

Enabling IOMMU AVIC on a large scale system with lots of vcpus and
VFIO pass-through devices running interrupt-intensive workload,
it could result in high IRT invalidation rate. In such case, the overhead
from IRT invalidation could outweigh the benefit of IRTE caching.

Therefore, introduce a new AMD IOMMU driver option "amd_iommu=irtcachedis"
to allow disabling IRTE caching, and avoid the need for IRTE invalidation.

Patch 1,2 prepare the AMD IOMMU driver to support IRT cache disabling.
Patch 3,4 introduce IRT cache disabling support
Patch 5 improves the code path in IOMMU driver for updating vcpu scheduling
for AVIC.

Thank you,
Suravee

Joao Martins (1):
  iommu/amd: Switch amd_iommu_update_ga() to use modify_irte_ga()

Suravee Suthikulpanit (4):
  iommu/amd: Remove the unused struct amd_ir_data.ref
  iommu/amd: Introduce Disable IRTE Caching Support
  iommu/amd: Do not Invalidate IRT when disable IRTE caching
  iommu/amd: Improving Interrupt Remapping Table Invalidation

 .../admin-guide/kernel-parameters.txt         |  1 +
 drivers/iommu/amd/amd_iommu_types.h           |  7 +-
 drivers/iommu/amd/init.c                      | 27 +++++-
 drivers/iommu/amd/iommu.c                     | 97 ++++++++++---------
 4 files changed, 83 insertions(+), 49 deletions(-)

-- 
2.31.1

