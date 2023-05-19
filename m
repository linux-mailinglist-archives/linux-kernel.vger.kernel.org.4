Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407C9709C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjESQae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjESQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:30:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92229C9
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxsmxEwdxrDoBo0JLHTAVf2MSVjdozCJjY20aHo4oJsGTm0nGEu3jim8I/QQU8pyhBiC2yule2j4KOlLtBEVxWFrzEcteQZ/b28R1QaFvgv2ctkke0UHLVcu+dcv0EKKfCw6MPbv+0A25GjareCIWZ34L6C2v5+1UzppJ+iRx0I5eyFmbg53f/M3rz/p5D/HV0A1mP+JlFU9cjxtWmJ6VdS6cW5eDd6xfgy0O5hTwq/VTKaQBR1Ali0t1JDhkRfHOl9F/5X6VaU9ivZz1vpSYm5Xc1TSO6yJqrmRvIlICyipzFZ3Zn62FvrBZZCWt4kC+h3WUFUpESoQK5CPWwTvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk/4nBx1cIzKeIvfLAVRm6qQ4Y0UVA1m7YAp61UIvwY=;
 b=AINxkW8Dz6nPiFjnuwybTfwu4psQW3ijyh14IBs8B+KhMAkIhItUut1NOByQfrHt+ILs8tFFx7v/r2cJveQrQUG0Ee7nxos3iSkbcMiihhAvvckn5A1Z1vgkj4bhGjneqcqDmgLzUzgLRAaRix/CtPvCpK5B8WRPLtT41AbWdnT2lfHws+A9iwBrHj+HyHabVeFpD8Dq0xVWBxa55L7LnSdObarKUYyyvmVwZdIWhOebEJqhiluX6Raa3lENWh73kUXJZusezidZj8uV7vjL9gT/DQx0z0Aarru1gwvSKho2ZokHZSMUPMC6K+KE2EIrcCgmVDCiSbp2aGaLrBCVJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk/4nBx1cIzKeIvfLAVRm6qQ4Y0UVA1m7YAp61UIvwY=;
 b=TdPhOfE+kZfHsvpZkqkqDI6kMhx0GEbQuDpEqs3EYjhBffaAEAVQHScw0jWG/70k76IMmiuS3n37U2MMWh02Na3Z5s9Xe5U8cobaBe3AlAjGi/l9GAlUjhYyZfAz3jHKRXuU9Upf1cwF2DXOYDb9IC5l8OHuc/fq3FCqUW/KC58=
Received: from DM6PR01CA0020.prod.exchangelabs.com (2603:10b6:5:296::25) by
 MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20; Fri, 19 May
 2023 16:30:22 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::a6) by DM6PR01CA0020.outlook.office365.com
 (2603:10b6:5:296::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 16:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 16:30:22 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 19 May 2023 11:30:20 -0500
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
Subject: [RESEND PATCH v8 0/6] Provide SEV-SNP support for unaccepted memory
Date:   Fri, 19 May 2023 11:30:07 -0500
Message-ID: <cover.1684513813.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 960f05a2-8e38-4c87-cca6-08db588657d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHZYtZpllvBjNKf5sa4V6roOxyhHlkd8QzPX54EgZxsVuJ/9qJJV6cTHKSpkQrUdQ5xl1y48lGx2BmzIFIN4/pFVQZn3IY999s18JieinrU7hwxdHdpp9WfktPqIMt0gU1zyyCr0Ooto+zhhP2+uKH96Z0JP3VZWD8IPWVW39Ax5eC1jsmjAJH/6/y7mssBbiy6oV6T+jWMnp0ZNXM6YSgxe7GRTXd60CaKlpEygijG15THfKFv/iBMh1K9Ve6qWTaC7mnY6Rt9xX4eUZWi66DvanEKOplSnRhysJvEVMgz6uBsw5xFil/b6s1sZTjxJ+w0wjbICm1SrNmAlVlFEHpxJCJE2Gh55jMivbPseuapVC2wPs5OmEZKWw9jHd7lLxNAYimNDFXGaNnvEOGSZyaUPByVfOw4wd0kh+GEeli5G9vSrBQHwIOO2517BcD/0lSuDeT+Ww2jAHe+VGKvsi2HUuSUk94u6d08QziXXh+uCVVuHiswGsUPcSb19bJJpjeLxTszEYxBWj0zB1z8W65Lwe88OTGAUXA6lYFdj6c1+z2ldWuXLmFu1saHgDjNhPG+Qg9SAvELmdm4h2axwwDxtZ+QnguqKdc7nvheC4GzET9tnQPLnpkhAaZkOJOV09sWu+Za0luMrRbTiP+O2gJAYIh6hRIEoQMg/aR8A5ozQgK/2ByTL/QASN50+8kw7Z4Pd0Css9URp7HJtQ6chMR1Xovba70vIPKZpDOxX36sGcLjxeNdf/rZyFSDH82YlnjTC5ZkvvI0BavNzxlLimg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(26005)(966005)(2616005)(36756003)(47076005)(426003)(83380400001)(336012)(86362001)(36860700001)(40480700001)(82310400005)(81166007)(186003)(82740400003)(16526019)(356005)(478600001)(54906003)(110136005)(5660300002)(2906002)(8936002)(316002)(4326008)(8676002)(7416002)(41300700001)(70586007)(70206006)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:30:22.4898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 960f05a2-8e38-4c87-cca6-08db588657d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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

  [PATCHv12 0/9] mm, x86/cc, efi: Implement support for unaccepted memory

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

Changes since v7:
- Rebase on update unaccepted memory series

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
2.40.0

