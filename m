Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1A87246D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbjFFOvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbjFFOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:51:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4175610EC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpL+efdSGSWQIMao7SBPU27tJHrrGwMqSd1fsTHQbcRps1p5NSjtEHtOxZ1L8CUbtLSFSQVv/MoncBCjvfkTTlOy72bD/J9DUC1x3avLfZBlyIszC+/LOADcs9arMHdj0TWi/z1HtzHSJo3GlDS7NBetaIvug3Sl+4xVhmgTqwNNszGHzeod8ysMqCJum8MyemG4Vu/MdQYWBCm0xRf1+Ps0dZzwY9EV6zJzJrayM974D9dTObNCq8lIR3QDTHXQqWPXnvud5BmEpVxaRebJc3TqGb6RsvwXdXIWkv0beLeLSwLdk0IbccnoXvNqq5GkbSfZXAiJZWdJ3EeVoCsWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK67U85wIcIN0NlzA/F96e609ouIhUPCOK0e1j6NBzo=;
 b=fyQ5yETx23L+vM7suydx4ZspgWabG26ePjLDkK1qmwcgn3TwcR/HTmyHb5XG/ER9QpAdiULfgzBQI7FZIht26EiesxZmrzKRMVa6883RK1vbpipntjOodMDEFLqIgUHHJxdqyRqhKwqGaytOhlb5t5sJvpPhq0u9D490C/84chiUnL4c5wwSX6sm4Eh2odY0ldZTxW+svJZiTTcIHXwE5IdZ8G0Cv4B5Rs14MPxynM8PdZLW2AG07HTlsoi0+j/IsXuVtI1JImuweb2Nj56T2NrEql7rJqUBDWm/dm5w3QPhMdgQCw4kwMWngr+O1YgY2lERWm4H2mpsPzteGwnSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK67U85wIcIN0NlzA/F96e609ouIhUPCOK0e1j6NBzo=;
 b=uRvOA1dO0nPnD3cBh5I1lYUVkcVUyIxZ3869oh7h0jfbeiH9NbMS7zCOu9u7ypvG6FcnRpXyvZZCojJNh41I3B7t6XNtJ1e8MM8di+suNllTKV21/QgdkZZ0tyP1eNZ4OwtC2uh9rqxnKmg2Lx0klGnKYd0Hj8UROtadrkQm5NA=
Received: from MW3PR05CA0014.namprd05.prod.outlook.com (2603:10b6:303:2b::19)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 14:51:40 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::28) by MW3PR05CA0014.outlook.office365.com
 (2603:10b6:303:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 14:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.35 via Frontend Transport; Tue, 6 Jun 2023 14:51:40 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Jun 2023 09:51:38 -0500
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
Subject: [PATCH v9 0/6] Provide SEV-SNP support for unaccepted memory
Date:   Tue, 6 Jun 2023 09:51:21 -0500
Message-ID: <cover.1686063086.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f37381-aac3-47ef-88a5-08db669d897b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LccekH9RiJkrvIMQ74nbY53yNnGyW100QMGG8JoQTpOt1sWsNk/9IAslttzrFD8K6bLwGev1kepTpNuP01R9BG2OvJ9F/QYp3x7rMdlLBrrWVAiPqcQEuVVGH1+jF4pm7Mw63jToT7lNcPkVrSEMkVYqDGSed5Oxky13LbZbLiIY2aiLY+y7wyqq/qnWu9fEddGnFart6jmnGTExhebdx21CRn7+NdBGUfoaight+l4c20fbMHAmKcRL0hDUteGo9/GnclnGIf7MjvtCO7oITvQJvSjCBd9DxJVWq4aSNzNgRaH7pTT1LAACXhlPVhqXqtspLxAx7ZFjdAiW++wf9ayOxlCWLFLmuV1OMthTJWykNZU4w0BiJzNMg6cL4DEmMO0W9Ho9DKrUMUpiqBsuzZQ6CYQXfqhVzFlpo8THXd/hz379PoM+RyVkwV1sJIorNed9h57FL/pO67LlWZ4U2/tyeCCimba4SEn3BY5/NH/ZUqnYRf2Etg1gVHxiU8kQ6O436UW2bqLdBkwJXF0GfQkkPf4HuY1rmf0qAU21kPuLG+UzjazCax8nfzNk1XJRWbNa+yuFjURTUTgTg0Dt9dGfx8JrYPlHDtwxi3HnCbrjqkv+J/t0OpgCIf6OMrAzHuBSTu2tHWh/FCUxrz2f08R4B4GJTUxNw6lBWMAQxb6Pt90ho5RKE6jkdvH05cUlgfG8iMDZCh7yi0FNogO+RwABrHgj4PItwqotCidcnfJMT/dATsQPNeErcKrNPrNk85Hro6Ym+pToi+HydMD0Ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(47076005)(83380400001)(336012)(426003)(7416002)(478600001)(82740400003)(110136005)(40480700001)(8676002)(8936002)(316002)(81166007)(4326008)(70206006)(70586007)(356005)(5660300002)(40460700003)(41300700001)(86362001)(36756003)(6666004)(2906002)(54906003)(36860700001)(966005)(16526019)(186003)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:51:40.4124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f37381-aac3-47ef-88a5-08db669d897b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195
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

This series adds SEV-SNP support for unaccepted memory to the patch series
titled:

  [PATCHv14 0/9] mm, x86/cc, efi: Implement support for unaccepted memory

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

Changes since v8:
- Rebase on updated unaccepted memory series
- Incorporate minor comment to simplify boolean variable assignment

Changes since v7:
- Rebase on updated unaccepted memory series

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

 arch/x86/Kconfig                         |   2 +
 arch/x86/boot/compressed/mem.c           |   3 +
 arch/x86/boot/compressed/sev.c           |  54 ++++-
 arch/x86/boot/compressed/sev.h           |  23 ++
 arch/x86/include/asm/sev-common.h        |   9 +-
 arch/x86/include/asm/sev.h               |  23 +-
 arch/x86/include/asm/unaccepted_memory.h |   3 +
 arch/x86/kernel/sev-shared.c             | 103 +++++++++
 arch/x86/kernel/sev.c                    | 256 ++++++++++-------------
 drivers/firmware/efi/libstub/x86-stub.c  |  36 ++++
 include/linux/efi.h                      |   3 +
 11 files changed, 356 insertions(+), 159 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

-- 
2.40.1

