Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBBB680CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjA3ME3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjA3MEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:04:22 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B251C13D72
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcNcZncByriMl0o6vwo5CVd8M2e3vZOtR7RJeONcgPujYxJqltg356s25/JF3fzmZ/9swYE8Se/sty+uRpDerXpEc/oJ3crN1gFllE6qAA0azh8uuADAFFR8NlYZ3JWObKHobdOW7P0OL6G8vWlzv+tlT4FrPESzvexRcSPOKaFx01pFbwfBMIuH4WCMfMtoOM7PAUrO1tsG+S5wjnbED1zo6lO3Ic9iuu9PMkZmHzTxPOHxrR4hMosiIoB78m+fOiTKRzPLheklft5QtMX2WTbC//odMkZHET9XjRlwgSoXSfHjiHIi85RpVbDhYSIDP50QVU24VTLTLl/nQtrL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFIp0vd2eg7S9uuq2sGlFDIgJhoC6W3a0+PVUnSx/2I=;
 b=Vh3ZYivxH7eBuLCRrSgR1PTzsaQ13WiMrtVgTpv/6xvpY6j7csIesjc5caRljjvz7K8P+cjD9JsE0jlXLTTHLi9P9h6g/ay8ymRMKngn7SkDg4dJbG9n0ufidixKkQhOsaxYC/Z2aWdGI1pqcrair6UXuo+aokK8G9nA9AJitJ24MO9nK1N97dnGAgVPa6W09qdu14TYe2bVwnloVpB9KSiTOOilcMdaHMEnVZOFo6bGr/0UEjvKIa4BWXrUfI/OFHPbC9wu1fRCSm6Uk1CSY4Ap0JY7l8iPYGEpd7pyQx+89/1UAtGTyXSVn8r9AbRqGkCTHzzYO3LFtNVavn9/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFIp0vd2eg7S9uuq2sGlFDIgJhoC6W3a0+PVUnSx/2I=;
 b=LDD+BYK2AOOK6VQ10ll7lJp6Uf+drob0f3G4/mD7hxc34BXEWb16tPpEGaFOXp2hkZ6Po9ZePcRXbcU5qk9jnx/b8re8Oee5ZM0eMfZAPXXtLz6jqwbFYYEEQkAMpbI6aSvaXau8dk5L/XTc75kUmpHJEfVX6ejb9HUoTJ5Zc40=
Received: from MW4PR04CA0173.namprd04.prod.outlook.com (2603:10b6:303:85::28)
 by CH0PR12MB5044.namprd12.prod.outlook.com (2603:10b6:610:e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 12:04:13 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::7b) by MW4PR04CA0173.outlook.office365.com
 (2603:10b6:303:85::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Mon, 30 Jan 2023 12:04:13 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 06:04:09 -0600
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <jroedel@suse.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [RFC PATCH 00/11] Add Secure TSC support for SNP guests
Date:   Mon, 30 Jan 2023 17:33:16 +0530
Message-ID: <20230130120327.977460-1-nikunj@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|CH0PR12MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5c0703-f238-42b3-1ad1-08db02ba1a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftwlJDz6oJ5W4wWhA9pNMZzF668j35scYx7F1ShdZtfO5aAt3DyTqwiRTwVPZitMcGEFYHIjWgvefozrm+0+ezFd74Ho9JDJK2TyU/JhpAHMljiPfxniXURpwtuXMq22kEx0Qbq/Ak8LHtfpxH6nCw2EfZ6sE6+Oph+V8QVbw4q/bdbb3riQ5X0aiztmVWv7tUx6v0TqSMiCAmlJg34eea9ajBHIkX3jQ6GswLA2qNnTOCVi7/oXfTnMOJq47VSYS6RTUxSXo9/PcO7M7FAgRf+fI7jue8fCSmGnZyLl4hEpukyfa4zSKk4OSnpEQiqrUJPZEUq/Qzzb7LyV6NdhFViowebRUNGcwe/O0e+Dzgy5xcMTLdyypeWvMsL76B/eUzgHaKha35V3Q3ZafHq+TwChklI1ZIicp8i90B0Qu9l00Dq/RwExtNN25Plhh2I4+OgoHGMySRvPOyI0GyNjn38YHA67Yh2s7cmePGuA4IWCkPpgnWmuwD3QpaXXSn5TV+IGoFq2xYmECgJXs4YjFch3kE1ieWtXL2A4cd7n00eCbmxlHF63RCpRJrqsZX2ksELuh3lIlKqoCRdu23/qwdT7UT6t1dcHIYqERWFLI+vMOREmNUyb11980IEmi34dSIGM81x6NX2eY43uWfL5Detx0Wp0m35pIBFgsf6DzqAozdVjOn8dUC16cg36c3HXb75nYoiSH85R3UfNClY8DQ3ZAMxflnP9QRvcJGPzLOmHel9VZTem5UEtgWlsDkejPNVeZ5t+zr7dvAqfg2qq8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(40470700004)(36840700001)(46966006)(8936002)(81166007)(41300700001)(356005)(40460700003)(5660300002)(7416002)(426003)(83380400001)(47076005)(336012)(36860700001)(2616005)(110136005)(82740400003)(54906003)(16526019)(316002)(70206006)(70586007)(4326008)(40480700001)(8676002)(6666004)(26005)(1076003)(186003)(966005)(7696005)(36756003)(478600001)(82310400005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 12:04:13.3008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5c0703-f238-42b3-1ad1-08db02ba1a7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5044
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
encrypted between the security processor and the guest, hypervisor is just the
conduit to deliver the guest messages to the security processor. Each message
is protected with an AEAD (AES-256 GCM). See "SEV Secure Nested Paging Firmware
ABI Specification" document (currently at
https://www.amd.com/system/files/TechDocs/56860.pdf) section "TSC Info"

Use minimal GCM library to encrypt/decrypt SNP Guest messages to communicate
with the PSP which is available at earlyboot.

SEV-guest driver has the implementation for guest and security coprocessor
communication. As the TSC_INFO needs to be initialized during early boot before
smp cpus are started, move most of the sev-guest driver code as part to
kernel/sev.c and provide well defined APIs to the sev-guest driver to use the
interface to avoid code-duplication.

Patches:
01-05: Preparation and movement of sev-guest driver code
   06: Adds generic guest initialization hook
07-11: SecureTSC enablement patches. 

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
 .../x86/include/asm}/sev-guest.h              |  43 ++
 arch/x86/include/asm/sev.h                    |  24 +
 arch/x86/include/asm/svm.h                    |   6 +-
 arch/x86/include/asm/x86_init.h               |   2 +
 arch/x86/kernel/kvmclock.c                    |   2 +-
 arch/x86/kernel/sev-shared.c                  |   7 +
 arch/x86/kernel/sev.c                         | 500 +++++++++++++++-
 arch/x86/kernel/tsc.c                         |   2 +-
 arch/x86/kernel/x86_init.c                    |   2 +
 arch/x86/mm/mem_encrypt.c                     |  13 +-
 arch/x86/mm/mem_encrypt_amd.c                 |   6 +
 drivers/virt/coco/sev-guest/Kconfig           |   2 -
 drivers/virt/coco/sev-guest/sev-guest.c       | 553 ++----------------
 include/linux/cc_platform.h                   |   8 +
 17 files changed, 664 insertions(+), 512 deletions(-)
 rename {drivers/virt/coco/sev-guest => arch/x86/include/asm}/sev-guest.h (57%)


base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
-- 
2.32.0

