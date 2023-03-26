Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBC16C95C2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjCZOrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjCZOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:47:32 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4049D7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey3ZqDZj2VpWQkAfimMFS+jhLO0g5VkWf6KzW4sxSuNJYG8rFsQ6ULQXIhCNYz/S0goaTf7//sydzQ83q75dQpYwbn5fhdvHLC88mY8VW1CxBEmKckRIqkCxnWAEiaDNlvnOF2ynUD4CcMggHsa58RDtJeXgekS+leRFY/9SB0cEAxp2bXth6rpldq/tGPpkQiRe2OLZL6TYU50b2YimO5DDYXLBBk9ETxl+x3aZaAKhUapjfjc/zqCSvXrSAd7fq2WKnc1KKnhCsFm5aHU5V59NWyuJhiqHD39qiQ4Tkr0UklP0hrsiVlemQe2k0MZDvzNLq9efzvbf5nUphnwzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4SrKnC4oDT/pJ7M89h9etlw9YZb2zcUvL3QhWfRfCA=;
 b=Ye2f9reJyv1JeMmSy4l2JIM/xPmkraRd4xzyHGyn+eLVhCGlM6QjrWEwYinNPiEMnIoLDKSxgi+mELQ/njHIVetnaAsu6sZuML6pifoEjnH3G87tgYeGk1axxze87gX6UH3tA37mEszMR2iVkvPcvp+lmOL6o3vW325bSDtmNBYS2d9z5C+yf/bwamazqGY+2T08NTWUDVGwXCJ5LlLV5PN+s7tnAvzsL1qAutoJIxpQv+8Bq9qEGo5ETFKx85oUKazLhnAoe0k816yi65NpFDOcLm6VKempuRwFco2PNrF+YEtSaQaF1rH86qdoDi/hnknikGGsQWBHW+Z5Rw8Pxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4SrKnC4oDT/pJ7M89h9etlw9YZb2zcUvL3QhWfRfCA=;
 b=hPBsg17FqANqCJymzHdijCROBv3zhS1SUea9qtLOLKHRtfEmFzYzGTBtXT2QBh97ezQb8cYbFKRxFsY1RlBfgS4hF5b6S+/mYJhBknkM+TkOvyqgRw3+e3dVgpnpXJul55uEKKfIh6hgsasNiISiWML85dhsU/UsEuZbldCEt+c=
Received: from BLAPR03CA0051.namprd03.prod.outlook.com (2603:10b6:208:32d::26)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Sun, 26 Mar
 2023 14:47:24 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::3c) by BLAPR03CA0051.outlook.office365.com
 (2603:10b6:208:32d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Sun, 26 Mar 2023 14:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Sun, 26 Mar 2023 14:47:23 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Mar
 2023 09:47:19 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [PATCH v2 00/11] Add Secure TSC support for SNP guests
Date:   Sun, 26 Mar 2023 20:16:50 +0530
Message-ID: <20230326144701.3039598-1-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2642b2-267a-4627-02c2-08db2e0902cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFxRn3icy/Xz2otWmJSCVq0spFpph+eF2aasJIq7v7SbP6SYVThrCAlycVzV+K9x3YZiLyYqta+qWNb0YccFVy4ljYWclZlqIy2fYeRc47ozROu8GE+3RzEUOcOozRkOQMGKub4TgaALZ5lAiDvF0MbSn7lmuba7f8L9FkbnjyDDUCtstFe+wsI6vmlQsb0QP7jWofSbpUCrrPgcBVm4asPZsp0Adeaq/5AwELy6X61MD/QefaFg6VZn39cwHFwZfQQ0alPhX/1w0XJiRdgGuhn1aMw6YZrvnGnV5hHCbBea3dg/wQVeAt0d/SQ6K71SqZd5nl9L9bCPk0pNLdiJqe/wmwsfvyJWnhKQ5roYNdsDtqAzTkpiD4MXHy5VIO0Ycdi5jlzc2GkAgO2WYr0jqlZEScSWIJsVj75GqFWansQSFJPmZJkxdBT2hCVqBR99MC9dnApSp/euw9zX7iZHVUHUn7BlFtOo0SKyIu0FZa5rmdOSSud29i7yfvucNgzFwFjDqmHfeBTT2FrbR3+guo1X9CCRrkEe5VPBfl6GlLAaT9sLnsSTYfMW7qtb6ptm7hAzDmFx26zYCB/vCrWSkvm/ZD2BQGPpPW3UPpH1dL6OsLqA/RPv775dmqiyWmw2uInr+E+MJleKewJTMgNyYeofdoGLtdiWwtCM+bzyFjEzB4eW87VF4kljJnQn4oeVo6+oYHuXSSx2LT03B9zbJj6ja6cCjaaVCyjMw4QBupfGfeCHMHY/xmayLVhg8GhK1isDFGCu4COkndUM+1T0lQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(16526019)(186003)(36756003)(110136005)(7696005)(36860700001)(356005)(82740400003)(41300700001)(54906003)(316002)(8676002)(82310400005)(40480700001)(26005)(1076003)(70206006)(8936002)(70586007)(478600001)(336012)(966005)(2906002)(81166007)(40460700003)(5660300002)(4326008)(47076005)(83380400001)(2616005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 14:47:23.9030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2642b2-267a-4627-02c2-08db2e0902cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secure TSC allows guest to securely use RDTSC/RDTSCP instructions as the
parameters being used cannot be changed by hypervisor once the guest is
launched. More details in the AMD64 APM Vol 2, Section "Secure TSC".

During the boot-up of the secondary cpus, SecureTSC enabled guests need to
query TSC info from Security processor (PSP). This communication channel is
encrypted between the security processor and the guest, hypervisor is just
the conduit to deliver the guest messages to the security processor. Each
message is protected with an AEAD (AES-256 GCM). See "SEV Secure Nested
Paging Firmware ABI Specification" document (currently at
https://www.amd.com/system/files/TechDocs/56860.pdf) section "TSC Info"

Use minimal GCM library to encrypt/decrypt SNP Guest messages to
communicate with the PSP which is available at earlyboot.

SEV-guest driver has the implementation for guest and security coprocessor
communication. As the TSC_INFO needs to be initialized during early boot
before smp cpus are started, move most of the sev-guest driver code as part
to kernel/sev.c and provide well defined APIs to the sev-guest driver to
use the interface to avoid code-duplication.

Patches:
01-05: Preparation and movement of sev-guest driver code
   06: Adds generic guest initialization hook
07-11: SecureTSC enablement patches.

Testing SecureTSC
-----------------

SecureTSC hypervisor patches based on top of SEV-SNP UPM series:
https://github.com/nikunjad/linux/tree/upmv10-snpv8_securetsc

QEMU changes:
https://github.com/nikunjad/qemu/tree/upmv10b-snpv3-wip-securetsc

QEMU commandline SEV-SNP-UPM with SecureTSC:

  qemu-system-x86_64 -cpu EPYC-Milan-v2 \
    -object memory-backend-memfd-private,id=ram1,size=1G,share=true \
    -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,secure-tsc=on \
    -machine q35,confidential-guest-support=sev0,memory-backend=ram1,kvm-type=protected \
    ...

Changelog:
----------
v2:
* Rebased on top of v6.3-rc3 that has Boris's sev-guest cleanup series
  https://lore.kernel.org/r/20230307192449.24732-1-bp@alien8.de/

v1: https://lore.kernel.org/r/20230130120327.977460-1-nikunj@amd.com/

Nikunj A Dadhania (11):
  virt: sev-guest: Use AES GCM crypto library
  virt: sev-guest: Move mutex to SNP guest device structure
  virt: sev-guest: Add snp_guest_req structure
  virt: sev-guest: Add simplified helper to assign vmpck
  x86/sev: Move and reorganize sev guest request api
  x86/mm: Add generic guest initialization hook
  x86/sev: Change TSC MSR behavior for Secure TSC enabled guests
  x86/sev: Add Secure TSC support for SNP guests
  x86/kvmclock: Use Secure TSC as clock if available
  x86/tsc: Mark Secure TSC as reliable clocksource
  x86/sev: Enable Secure TSC for SNP guests

 arch/x86/Kconfig                              |   1 +
 arch/x86/boot/compressed/sev.c                |   2 +-
 arch/x86/coco/core.c                          |   3 +
 .../x86/include/asm}/sev-guest.h              |  46 ++
 arch/x86/include/asm/sev.h                    |  24 +
 arch/x86/include/asm/svm.h                    |   6 +-
 arch/x86/include/asm/x86_init.h               |   2 +
 arch/x86/kernel/kvmclock.c                    |   2 +-
 arch/x86/kernel/sev-shared.c                  |   7 +
 arch/x86/kernel/sev.c                         | 541 +++++++++++++++-
 arch/x86/kernel/tsc.c                         |   2 +-
 arch/x86/kernel/x86_init.c                    |   2 +
 arch/x86/mm/mem_encrypt.c                     |  13 +-
 arch/x86/mm/mem_encrypt_amd.c                 |   6 +
 drivers/virt/coco/sev-guest/Kconfig           |   2 -
 drivers/virt/coco/sev-guest/sev-guest.c       | 592 ++----------------
 include/linux/cc_platform.h                   |   8 +
 17 files changed, 708 insertions(+), 551 deletions(-)
 rename {drivers/virt/coco/sev-guest => arch/x86/include/asm}/sev-guest.h (54%)


base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
-- 
2.34.1

