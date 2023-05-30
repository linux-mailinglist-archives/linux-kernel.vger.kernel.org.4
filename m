Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBA7716347
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjE3OME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjE3OMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:12:03 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10389A0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhImHMAU7bJGwoYjJ5W68CS7kp/TO/UGk/6bQojWZ70OLSf6DykJ1pCsquoTPCv97ev0GdtpsZCKh5caydoGKcXr9I2M+1DPO2j6L2cBylflqSL+PxIUCfSOch2Zv8bp7GrrNlOaub9UtZY/Fhlfm5Lp9BYg3m77XfagMpRfHHkQixaqi8VG4fLoK8PIJB2GlBfStzXbOkTiOFfYGECIhXrTuJt/cWWBFouq8MEv3dAwbCxDqaNBZcgkUkKuPrMf595qlmGAoOLvWgL5T7o4ynIbPPm7r1UqDa+fh+YzQBYq9SrRYbVgfv/l6qsmRaURkWFWsW4rCsJr21bsQ6udrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjP3ab+xSviWP4d0uyYpHVIPaTPRBMkkb4Km3Va90RQ=;
 b=OCpw3b1SpeTeVFrF6Sc4/aSLv9LkdJvVVgBe4huMUgT9mkALZiojC4ApojMxjX7GI8sDyL4gZpzbmhiZeyk9A52qWSIrO4s9KZOE+nVLPx3ENdijGT5tTLH79BXRq5MkRknir2bpsOBBRY1zfIw+vJ6eqPlrbI/MvN7tDoaTToh+o4NmTZ/rPSQ9m4MBhaFNl0pd7cPAsGuBYHSOv4NjQpqs7Zcc61JTDRdD48siRn0IK3xJKi19MC0k+/jxW/oWt7zgBkWkF/6sGnP5Hu1/LueKBqdin5YnWP2i1LeEFcOV1y9GwhPAQknVMt/Ejc7Bt8HfWnVt6oElJTrf0LmW7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjP3ab+xSviWP4d0uyYpHVIPaTPRBMkkb4Km3Va90RQ=;
 b=Mrr39pepufMCIe5ZuvwYEAHWVkVfbV/SCReCNXgI3HMXac+Wb34eqm0qC3OP/8KFuHhnTsBBYHGZerAhn+NBkt9nXyfqEyORi71cR1GCnqtZAPoIhJdcU0O3FyUyzOER19G4DYnrXG3V7svenqd2MTQlxRwwSuAdD/w2Szfu0Qk=
Received: from SJ0PR03CA0260.namprd03.prod.outlook.com (2603:10b6:a03:3a0::25)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:12:00 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a0:cafe::44) by SJ0PR03CA0260.outlook.office365.com
 (2603:10b6:a03:3a0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 14:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:11:59 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 30 May 2023 09:11:56 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        <jsnitsel@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 0/5] iommu/amd: AVIC Interrupt Remapping Improvements
Date:   Tue, 30 May 2023 10:11:32 -0400
Message-ID: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 866f4179-da01-4cff-9ab6-08db6117d586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiflYZ5R7kmWRFGXWP9y0D5UGMx4FhB2+WrEsiMK2WzrmwrsGXbExir1RUbtyNcNgpm6LKtrBWoHLi+rQ1gUNZ2fyII+nXnokN86QnP+NCxT8ZqPMKQWcoC/XKLuYG/k5/V78Uiqiz4jEuEHrv9z2x32koHHu0eT1RdRaz72jj5I+zv2lZPqUac6WcNSwtZE0qwL0a1AvMY4XjQXJm691kQC+5+a8lDpOiQUJXCM0tQm/iTgvA3nlVoqS21edshD5ChFGlS1wIFZnCVfxzZuA3LaDV0k1lAvNLKT9m9XZ7XkBSypO92svk5rXmP6gvZlo+9vc90XVx1AQCP0NDVOy+EMWRO3PS6CKC+kKctBEtVk3AqQnGjF+UtkbNAJlOIr3aiYLKrfkCbskzgNpXrBE4p0cLFaJCT1WLICjXxitJiwZM2wAAF/Wg/g1Pk28ElhsmAkRp4lpOkaAsGFJydrs3q4ATVJPbgbWW751B19Lv1UaD2Dv8vYJZMiAaf2Q5UPtJXcFpFPPk4O7jex9pGCTC1PO8xmDCLRZ2don9oqYWMi7cdP8qoiDhIegQDHBTcL7GHYrD25rdGcH/9dxTWwnwQSkqo5tcSyDb2dtDnT4qf+sl6q46XbYBAX/1bHZU9+86JEzWpZ+VElZrYzmHUkaLbxcyImQGDDJukE0KqDjsYJLbPvf/R4XY9aIQFn6QvYtmIpWe3Dh95clmu9hlUcjl+uttzvQii+j+vLwIC1ajfm7xXMYaU1dtRa7NdRbZ9AzadEhpqRigfmO2PuZSg6ptjuaP0x/6f1qBDpHhSOOz0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(26005)(336012)(426003)(47076005)(1076003)(82310400005)(36756003)(16526019)(186003)(41300700001)(36860700001)(83380400001)(4326008)(316002)(70206006)(70586007)(478600001)(2616005)(8676002)(5660300002)(8936002)(110136005)(54906003)(86362001)(44832011)(356005)(82740400003)(81166007)(7696005)(6666004)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:11:59.6005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866f4179-da01-4cff-9ab6-08db6117d586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

Changes from V2
(https://lore.kernel.org/linux-iommu/rlurmw6n6eyyhtnfr6wva6azur2gvgcrdn4mvykr3nvsosj5py@ieaivyv6cqrv/T/)
* Added Reviewed-by and Sign-off-by.
* Patch 4: Reword the commit summary (per Jerry suggestion).

Changes from V1
(https://lore.kernel.org/lkml/20230509111646.369661-1-suravee.suthikulpanit@amd.com/T/)
* Patch 3: Add logic to clean up the IRTE cache disabling
  and handle kdump code path (per Alejandro)

Joao Martins (1):
  iommu/amd: Switch amd_iommu_update_ga() to use modify_irte_ga()

Suravee Suthikulpanit (4):
  iommu/amd: Remove the unused struct amd_ir_data.ref
  iommu/amd: Introduce Disable IRTE Caching Support
  iommu/amd: Do not Invalidate IRT when IRTE caching is disabled
  iommu/amd: Improving Interrupt Remapping Table Invalidation

 .../admin-guide/kernel-parameters.txt         |  1 +
 drivers/iommu/amd/amd_iommu_types.h           |  7 +-
 drivers/iommu/amd/init.c                      | 38 +++++++-
 drivers/iommu/amd/iommu.c                     | 97 ++++++++++---------
 4 files changed, 94 insertions(+), 49 deletions(-)

-- 
2.31.1

