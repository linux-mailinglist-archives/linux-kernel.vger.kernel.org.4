Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CAB5ECA67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiI0REs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiI0REp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:04:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAACC13EAA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6wOsjNmZynLILNr+9jPZ6IJj0fEX2agUrrWfp9f77SHmo68L8NRbAcYpMP6xmzrNpzm9J+1sXSRWrPX3GwH9AicCvF3k0caVoCiO0NoRm2bjrhx5wMp2jpdydjRy5RS61rRwQ9MI61mJJpn/LUPcK/Uk5QFoti0fMisg4iMHcPNTk6B/vgagMsX0vWgadjP+7e3/Gj2s4aDyElsUlqgWHWNu1UqNOyw1yfrz6Pj39p1z6nv8u6DIzc2M2O1l6Q6OBK73JQdYOFTq130ikwdoMCmV91xmj7qwc9IFC1HGB5r9YC7PdhfnBaV8OfYoTpAx9l9NHQTP5RoghTHu/7HkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHZUq/H5G8Rgv5kcY8NklmHkRp6rKP2xh0S+Karjo0I=;
 b=E31EE9jmjVj/il+VN3jHy2FjEK5FZlhIgbLzFMq6zuBUphD3oJHjI3smZPh3+N/hcUO0X6WVzuvacIhqu5Z13eKazakqWlCtBCnBtQ9Z8dVAB5x/Hgh1OfkFpAMlqDy6S9yiBJ0xdgRNThGqdDGSzn/7+ys9g/+rmsxpLRBT/Olosxqp8sWXx28F3UBcacYpK8gVwouy6qkyO36yrRjIOsCXLDcpZvryWqlF+qQMXEPyC8EcoixH6zSGNKph1PevKK7tzwZX3igYjVNdmiFaMldlMBfc7/ij4mgiSMsWp2aVXG0qIoVzgcjx/syx9S2aIMTmJfNkta+6NJMRo6Q0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHZUq/H5G8Rgv5kcY8NklmHkRp6rKP2xh0S+Karjo0I=;
 b=Vov5asqDzn4EsOmISjw8KsuZeTWNuAXOxg+tVmIBcM5BS4oQA08Iq8skRBLyGjVqvyNb6sl5Yr4JWKL/xQajYbuCKE2ABYNr2HvQaeX8EZfyFi18UuQg4Whuu1kM3mBAmCxhSg61YupK58UBf/om8CW/idl+/JdeV17E/AHu1sM=
Received: from BN8PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:94::14)
 by PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 17:04:37 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::67) by BN8PR03CA0001.outlook.office365.com
 (2603:10b6:408:94::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 17:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 17:04:36 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 12:04:35 -0500
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
Subject: [PATCH v5 0/6] Provide SEV-SNP support for unaccepted memory
Date:   Tue, 27 Sep 2022 12:04:15 -0500
Message-ID: <cover.1664298261.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|PH0PR12MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a9fcf1-aece-44cb-8acc-08daa0aa5b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FioHqQ417GUxKAWyjXhe7IbjE6IKJmHjXz3nJ4BLRCgZj3I2ESRPuIVHVQOMXY3P4mLmi0nx8QMaaPIm0+ry+tfTYQ6Qt1CYfqMchPXN81CL95GRy1enNXKh0NN1kJjivie263HsjO9NQp+tAkY/682gxEpK6sJgqWGNdyJKGs0h9yffxQM+Ph9vC7ReGWlj5yI55hamfuxs7OvSqHWrb1DFHOFSlvvjdqc9QZuwWoMDAlxFCsOttyeoQe9RWm5NYR8wkTaPKNsyl1UDHE6mwKRj4GwtAYOD7xmOg/lKRpMtXuI/ixeWoXJFId7vREsprMcEBNMTenTGGHWM3DjSPtVmw94ZjjC1Yx1h/F/DOT7tDXKjEYnlTQrw+mv7NSdwrJ6RyIcw6ne4xzkRdABJcR8T1SRfpmDIGWbLpGtMY3h5MHnD3qpkVJ893rOjQBOfMygk4mlJIvixPu5j/ekI0DGbRX/NKgvmKOlvimxz0hSTecxGI8gdRUba2zh1zHXIbfg6yYcInOFR0oBzGCqly//OlILhl6KukVJcA/tTU6rr0t8BIokVgtFfTaZ8VldOMDeQSbuc1N2Ph+GBfZpyCzTh6bkB9NGqSo38wTbBMahpzAp9ESq0kzcVy45vx6K1bKEysz0Up1HejntwhBPJnnJlCn13p481/4fL6fZmbJDPuEL+r0eyev5sGCVLTtn2tf4OHiWFrp/ad2gkWnaVuzB4b4n0W7d6VzJFAxgxINrHGbG+kcOEFmrqlvdcDJR/wBHqG8VUffFisAH6n1C0e3WAvFCOaKeL4n+Xmf3DgCzF+IZZMYAZPegWFrIXA+IZ0erpusVYquOSAbZt97Ex9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(36756003)(40480700001)(40460700003)(81166007)(7416002)(5660300002)(47076005)(966005)(86362001)(2906002)(426003)(2616005)(26005)(83380400001)(82310400005)(16526019)(6666004)(336012)(70586007)(7696005)(70206006)(186003)(8936002)(8676002)(4326008)(356005)(316002)(110136005)(36860700001)(41300700001)(54906003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 17:04:36.7067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a9fcf1-aece-44cb-8acc-08daa0aa5b94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
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

  [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory

Currently, when changing the state of a page under SNP, the page state
change structure is kmalloc()'d. This lead to hangs during boot when
accepting memory because the allocation can trigger the need to accept
more memory. Additionally, the page state change operations are not
optimized under Linux since it was expected that all memory has been
validated already, resulting in poor performance when adding basic
support for unaccepted memory.

 This series consists of six patches:
  - Two pre-patch fixes which can be taken regardless of this series.

  - A pre-patch to switch from a kmalloc()'d page state change structure
    to a (smaller) stack-based page state change structure.

  - A pre-patch to allow the use of the early boot GHCB in the core kernel
    path.

  - A pre-patch to allow for use of 2M page state change requests and 2M
    page validation.

  - SNP support for unaccepted memory.

The series is based off of and tested against Kirill Shutemov's tree:
  https://github.com/intel/tdx.git guest-unaccepted-memory

---

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


Tom Lendacky (6):
  x86/sev: Fix calculation of end address based on number of pages
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
 arch/x86/include/asm/sev.h        |   7 +
 arch/x86/kernel/sev-shared.c      | 104 +++++++++++++
 arch/x86/kernel/sev.c             | 250 +++++++++++++-----------------
 arch/x86/mm/unaccepted_memory.c   |   4 +
 9 files changed, 307 insertions(+), 148 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

-- 
2.37.3

