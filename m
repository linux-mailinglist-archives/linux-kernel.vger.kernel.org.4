Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3C46472F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLHP3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLHP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:29:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A85D78680
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqToaPuFfy118Xb/Vz8blgXjKpz3pX5bF8IyLLUNm+JMpNh1cyHe6oqwU8QOdEle48ZsCsniVyjB7DHziArd7HgMYIWjEXe430RziTNWe3dH/RB5rBIuA5JWX9D0DEexAB9k5409CsXMZMgqy4l8e0rOIEG++uStiC5zbHql1x6IeItkNahgk/DWY2etoYlHG1R9EufgI1SswJkYHpXyN/eUIAZbaxhb9ObnXifEgLqYyvuyzB/MHEZG9rw22+qcNDeYcECqZld1td9JRkQfpG1o3Fy0QqiC9xPtXJnvGOcJxwgVrvJSSzIKQJSkTmJlmGaSNQs42sTYEokfz/29aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpeHkbnzGOllVRcDUhVoTCDRvWaXe/2fJYdz7rVVsSQ=;
 b=i7bSKGB+moujD0g4mLLf/R8ZK4OXiSzjnfCIvn9Mk1NcUva9yzKInHtvLKj4HvJ9CD1IOUKprHcAs+IMAUvykOPI2pCsbPlgDvRXCZrCphUivRgBSROXUi/ven+6d3svTtSAvOV4qiVhOPpg6p3AVE3O/4gTL0L9Qw7GaNYixcPHZPZYfM9GITGsbDHxUOU8tT92ztfpfj0ERNAkb6Tt6+ZW/+piTsgruZVfnvyzL8d1277sWrFXW01Cr9C3lxVjkKVC7TPVdg+X5qD0nY2YcU9txLwzCLoCqhPNl1AhK2QyA6rmuafs8N3NMXA2z0VwfWqplbs+qlgbhGuN8rh7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpeHkbnzGOllVRcDUhVoTCDRvWaXe/2fJYdz7rVVsSQ=;
 b=W+oYjQUf7HJEPUegw+3P6pEfZhL20SnC0e/RJWEpmzr8H0Gw6rNwD5eYrB7OzKiI/G0l0f9YlG1LRbK4zQSIZEdxAFkYAkUxQJkF/yNicNGOdtqUNCJ5xX3WKlU2UyUwagUrQKTkHlHBCzWIuAnEd6UYlUV8uyWwIwvAakYjs2M=
Received: from BN8PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:70::36)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 15:29:27 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::55) by BN8PR04CA0023.outlook.office365.com
 (2603:10b6:408:70::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 15:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 15:29:26 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 09:29:25 -0600
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 0/5] Provide SEV-SNP support for unaccepted memory
Date:   Thu, 8 Dec 2022 09:29:08 -0600
Message-ID: <cover.1670513353.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|BY5PR12MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa566da-18a7-49ae-ad04-08dad930fdc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0OrYAw6/MrQ/M1IfQo46cAvVH8OtCxkXtExTz+JAcJfTuOnk7yo90b3Xvj2R97GCg3XTEKbPcTyZTOAzijBTiriorDeGk4WyoBpROBDugne8W+/Gh43HdcOoLeqE3VPPEUX1672axQAlEkc1cGgaqGDIxYXcS/fZzMd7FsCFFSmP2VJ8/5vEa8T13dW8dHcD3WlFYa+ANQUy2UGXQ9PXGheqtnyCgwOEDFYFS/Zow1t0FpsrN73lqYToHncuwihOTWfq73U8fEhmWURzdekFd88Kl+R6P4KJugHBbXLq/6PCWV2gx+FcIS2jB8B1HLf6lwxGZRdRDmXgdewtaO1PA7RMRB8Be+WFnKccP0sI2X40Uk1CLULCFwwOS+Av0NE0miHmhMAUhDZ8IHjiJleDI7qGMhrGWaM4dN538DFzFI9GrKi9Ou5oiDk441zq7FygziCZNPZT+qPe8B73qc3FvTs0f0ne36lY56JHlVnOkRv/etTOg15wH+5v+Vkb4Jq7gG21TRx1QpWgZGiAQnuTVa10/iopUv5plN2LbPVjZfPnLHiqqRp7pin6Qhso/lYKcHOvSDj1KYcRGX6VozCilh1IvjIosOvgSMzxRPdWpz05P45C2xKgOkQomEcppMz5JWaXLRyWkK0QDtHLNlsCZHUMIBoJGmzui2f4vMJ4Z0UVrXSbvslTwgD6oV+0X8cO038imFRu5RjfjqLQ6u1PBo8PtIk/wONlVgrvkWk2Jw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(7696005)(54906003)(110136005)(86362001)(26005)(2906002)(16526019)(186003)(83380400001)(336012)(426003)(41300700001)(2616005)(316002)(82310400005)(40460700003)(47076005)(8936002)(36756003)(7416002)(5660300002)(40480700001)(70206006)(70586007)(36860700001)(478600001)(82740400003)(81166007)(356005)(4326008)(8676002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 15:29:26.5478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa566da-18a7-49ae-ad04-08dad930fdc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds SEV-SNP support for unaccepted memory to the patch series
titled:

  [PATCHv8 00/14] mm, x86/cc: Implement support for unaccepted memory

Currently, when changing the state of a page under SNP, the page state
change structure is kmalloc()'d. This lead to hangs during boot when
accepting memory because the allocation can trigger the need to accept
more memory. Additionally, the page state change operations are not
optimized under Linux since it was expected that all memory has been
validated already, resulting in poor performance when adding basic
support for unaccepted memory.

 This series consists of five patches:
  - One pre-patch fix which can be taken regardless of this series.

  - A pre-patch to switch from a kmalloc()'d page state change structure
    to a (smaller) stack-based page state change structure.

  - A pre-patch to allow the use of the early boot GHCB in the core kernel
    path.

  - A pre-patch to allow for use of 2M page state change requests and 2M
    page validation.

  - SNP support for unaccepted memory.

The series is based off of and tested against Kirill Shutemov's tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git unaccepted-memory

---

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


Tom Lendacky (5):
  x86/sev: Fix calculation of end address based on number of pages
  x86/sev: Put PSC struct on the stack in prep for unaccepted memory
    support
  x86/sev: Allow for use of the early boot GHCB for PSC requests
  x86/sev: Use large PSC requests if applicable
  x86/sev: Add SNP-specific unaccepted memory support

 arch/x86/Kconfig                  |   1 +
 arch/x86/boot/compressed/mem.c    |   3 +
 arch/x86/boot/compressed/sev.c    |  54 ++++++-
 arch/x86/boot/compressed/sev.h    |  23 +++
 arch/x86/include/asm/sev-common.h |   9 +-
 arch/x86/include/asm/sev.h        |  23 ++-
 arch/x86/kernel/sev-shared.c      | 103 ++++++++++++
 arch/x86/kernel/sev.c             | 256 +++++++++++++-----------------
 arch/x86/mm/unaccepted_memory.c   |   4 +
 9 files changed, 317 insertions(+), 159 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

-- 
2.38.1

