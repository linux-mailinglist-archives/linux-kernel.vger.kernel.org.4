Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834F16D6A89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjDDRZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbjDDRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:25:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B661F5FC8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrFLkOb4ufpLuJ9tNkc8mCkioIvwx6cpqlY6aSXkVhlf+NZe5S9g/eG1mHu/lPaN6dkjRNJCyrtX8L9/XTuf6wCdpGDC+yECnyvX1GWMJU5ebozOHJDqiKR1xWNdHP2lr25faWGTy6cpSd7bUbRIqJd501lqRK9ceutpbpruJ4No+nqJaDOSJwBJW0RMscQyDV0qZnXXUURGQWAoh+E72HtiNlG7+wYnPd940rzXtzbcD0t1UnnxLs63tF5GWw7hAWgqAwH0QZlWujTswyret+OYfVWLKMhznkYn3zj6AOVRUz1gSsmWpU0MOJgKOsVWQ9DrHxIq7CGOUSxFQxa6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlCvigrNEMo0Ctjl4Tqqx8py3ycZnDk/q6EPNAZHJ5E=;
 b=d/XSEeSJtcC37fdLl97eenSTYJwAm/ZqNHKanbu6OyX8vcw2fbuAx7+74oVtvn61ZxpC0mm6Ph+kXMaIDHL9x7XqA2XeN9kyB/Kb6Qb4+aIoo8/sGk6RG6nBW0KKv1oRLL8vMIa4y/YJQu7syAtcSmC2+XqF35Cz+c5iyEWq9meozDHBpGsvd7drFeNDhOOglzq6zXvbR2HqiUDnz0wDyJwgiIXTusYK9eSFAA0GUpbNc+jRQTmdraPqtsvuNPF2ibDZRYa3LLcIWMW5yFWqLUgM+L/E9OQ0YY+ErjO6TnYm+F+v7zv6flWy7lSZuFAx6VVZGoRO5PToC00rZ4wz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlCvigrNEMo0Ctjl4Tqqx8py3ycZnDk/q6EPNAZHJ5E=;
 b=QX5T0mfElCROUfoF8jQP9d/7wItt/aI5FgUP8QIg7gy1FkHJphNJt8asc7uyugDEyAcrZN+vQdBuizzq6+7eti3aEzFE2rEVf17IiJnbcb0CZWA+q2DxyFtv5Ry8T1IV766gMCzq5Cw/npM6ZiUvYbuZMS5jkuSEUU5jYjjDpfk=
Received: from DM6PR08CA0042.namprd08.prod.outlook.com (2603:10b6:5:1e0::16)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 17:23:21 +0000
Received: from DS1PEPF0000E643.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::b9) by DM6PR08CA0042.outlook.office365.com
 (2603:10b6:5:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Tue, 4 Apr 2023 17:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E643.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 4 Apr 2023 17:23:19 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 4 Apr 2023 12:23:18 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v7 0/6] Provide SEV-SNP support for unaccepted memory
Date:   Tue, 4 Apr 2023 12:23:00 -0500
Message-ID: <cover.1680628986.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E643:EE_|BL1PR12MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5e5d95-a5a5-4df8-3588-08db3531490d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcVqDRjdYt/HESHnr7GelVAze6nKtcOmQmsHl4y0J4FueRDMbUMqgjGZ+QbZvJ53Xu6e9H8OSAlLGBWw8VUezBjKz2EHOrXUrOAa6x2ZlL6y0ScLW/dKpLWKpUmjuahDp+xvVeEG7BubSQEgrqOSAFKWXU3gqxJbeHaFUjaRQBMKGjFdF1UWF0IYfbAGRNg9S/J6VFv27+uogQH8Z86FLff206K066alByeZM+dwL+9IGXEzkdV4Jr8hAJo4ooRHGve06OObpFbhORCPRNKkhw7I4B4b0q921t9yg6fV+QaEAcnVPeB37IX+urcJRCEWv3iFDPkP4wHjk5xLA6ZlzXAvRBuJbd6Pr2ovplBKU4+oG0a61GVN6YI7xiOy+a7lCbHYFfoObBf1iGt3kLjhTa/I9V+byCJXEurDB8X7FbBt052Rkb0bgV7AneOS0mdXk/0+BwZyWm9i3McdBuvaCja27gGMbVI21s86LnXfcDPcqxiEyB2UqtGrtKoobwCdAJPvlwsgW40s23Ml2ZY9IbC0bz08Fu1LRB8lQI3KDatfn4a0PBU2JZlR9U6QCRVqxU0z0b2sSoNFmdG0cGDtKK7gqICJerBSyDpamndx36qGkJHOTKT070luRNEh60yGMtuy/6HBD6zGWVazLRlI2+ZpJcN4Mafp/npeTWz2RP6fmuxSf7kDh5H9h81ZN61jjrK8dB7Sm+kFQoW6mb/pXgVSR+VaAaW9EtSpdzgDmvs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(26005)(16526019)(186003)(40460700003)(86362001)(36860700001)(82310400005)(478600001)(54906003)(110136005)(316002)(966005)(8936002)(5660300002)(36756003)(7416002)(82740400003)(70586007)(70206006)(8676002)(4326008)(2906002)(356005)(41300700001)(81166007)(40480700001)(6666004)(2616005)(336012)(426003)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:23:19.7547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5e5d95-a5a5-4df8-3588-08db3531490d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E643.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds SEV-SNP support for unaccepted memory to the patch series
titled:

  [PATCHv9 00/14] mm, x86/cc: Implement support for unaccepted memory

Currently, when changing the state of a page under SNP, the page state
change structure is kmalloc()'d. This leads to hangs during boot when
accepting memory because the allocation can trigger the need to accept
more memory. Additionally, the page state change operations are not
optimized under Linux since it was expected that all memory has been
validated already, resulting in poor performance when adding basic
support for unaccepted memory.

 This series consists of six patches:
  - One pre-patch fix which can be taken regardless of this series.

  - A pre-patch to switch from a kmalloc()'d page state change structure
    to a (smaller) stack-based page state change structure.

  - A pre-patch to allow the use of the early boot GHCB in the core kernel
    path.

  - A pre-patch to allow for use of 2M page state change requests and 2M
    page validation.

  - SNP support for unaccepted memory.

  - EFI support to inform EFI/OVMF to not accept all memory on exit boot
    services (from Dionna Glaze <dionnaglaze@google.com>)

The series is based off of and tested against Kirill Shutemov's tree:
  https://github.com/intel/tdx.git guest-unaccepted-memory

---

Changes since v6:
- Add missing Kconfig dependency on EFI_STUB.
- Include an EFI patch to tell OVMF to not accept all memory on the
  exit boot services call (from Dionna Glaze <dionnaglaze@google.com>)

Changes since v5:
- Replace the two fix patches with a single fix patch that uses a new
  function signature to address the problem instead of using casting.
- Adjust the #define WARN definition in arch/x86/kernel/sev-shared.c to
  allow use from arch/x86/boot/compressed path without moving them outside
  of the if statements.

Changes since v4:
- Two fixes for when an unsigned int used as the number of pages to
  process, it needs to be converted to an unsigned long before being
  used to calculate ending addresses, otherwise a value >= 0x100000
  results in adding 0 in the calculation.
- Commit message and comment updates.

Changes since v3:
- Reworks the PSC process to greatly improve performance:
  - Optimize the PSC process to use 2M pages when applicable.
  - Optimize the page validation process to use 2M pages when applicable.
  - Use the early GHCB in both the decompression phase and core kernel
    boot phase in order to minimize the use of the MSR protocol. The MSR
    protocol only allows for a single 4K page to be updated at a time.
- Move the ghcb_percpu_ready flag into the sev_config structure and
  rename it to ghcbs_initialized.

Changes since v2:
- Improve code comments in regards to when to use the per-CPU GHCB vs
  the MSR protocol and why a single global value is valid for both
  the BSP and APs.
- Add a comment related to the number of PSC entries and how it can
  impact the size of the struct and, therefore, stack usage.
- Add a WARN_ON_ONCE() for invoking vmgexit_psc() when per-CPU GHCBs
  haven't been created or registered, yet.
- Use the compiler support for clearing the PSC struct instead of
  issuing memset().

Changes since v1:
- Change from using a per-CPU PSC structure to a (smaller) stack PSC
  structure.


Dionna Glaze (1):
  x86/efi: Safely enable unaccepted memory in UEFI

Tom Lendacky (5):
  x86/sev: Fix calculation of end address based on number of pages
  x86/sev: Put PSC struct on the stack in prep for unaccepted memory
    support
  x86/sev: Allow for use of the early boot GHCB for PSC requests
  x86/sev: Use large PSC requests if applicable
  x86/sev: Add SNP-specific unaccepted memory support

 arch/x86/Kconfig                        |   2 +
 arch/x86/boot/compressed/mem.c          |   3 +
 arch/x86/boot/compressed/sev.c          |  54 ++++-
 arch/x86/boot/compressed/sev.h          |  23 +++
 arch/x86/include/asm/sev-common.h       |   9 +-
 arch/x86/include/asm/sev.h              |  23 ++-
 arch/x86/kernel/sev-shared.c            | 103 ++++++++++
 arch/x86/kernel/sev.c                   | 256 ++++++++++--------------
 arch/x86/mm/unaccepted_memory.c         |   4 +
 drivers/firmware/efi/libstub/x86-stub.c |  36 ++++
 include/linux/efi.h                     |   3 +
 11 files changed, 357 insertions(+), 159 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

-- 
2.40.0

