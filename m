Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651796D6A9D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjDDRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjDDRbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:31:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5733A92
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMxGYzzlUyL7llyKmhl0RGb3kM6aV/CHhBICLMj2Fuxo9paE1lAaaxfE5pQ8ujua6zPq/1cMuE2kRmVXA5GEHeCdc9uG4f/0DdgS0rdSWFeIu3+xU8+g9Qh2Cirv0OpOVG2euaK6yiStKomnPY9yT3JtOlrNMg0e5tw0L6xAYpSBi2vN+3klzy9k5qZkyy8pD6S4PPBK+H1ghWPhKL4uzorLyFOnPAyKtkLZisJZGeoSsSEbOBf5eqDjdSaydUJAv75udWJaP1Jr5VHn3S6ECkSaKkMsHO8ESsNKwVbNt/MAe7f9M2vveyqWEqYs7VO84eEz9PhVg9SDfiw1DJKTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOv+ipaumDjrfPyK/wSJc9kHKtQOD+u7/vsqjciMkrM=;
 b=geJ4LvyuDPJ155DQQt+aakx1LgabUrEfY1IMsjo7v1LBREi/lkiU0tz+0tcr0qFefcFN+NKlIPELeyf9GF/QILCtq+ZcGDA4iK1XJfDUqvY+E6X5Y9wAKDzCKgZo6rCEEFwbri9U2oap1jPUrxeTe0U1yonOBW5TiQ2Zlt/xN/2MQ/cZftPIn9zvTeVwG/GqotToXC0TnY34rVI6TCgEEkwCmGU/cd/x79a8I1bz9I0sbT8LOGO017D530PmWRCYizyQXYYqvYWLqnJHL/ypCBVModMPKKH739G2NbN6g1a1jHCGInA+hR5oPcmaE8jNt7K5xRA7A1jasUaOl+L2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOv+ipaumDjrfPyK/wSJc9kHKtQOD+u7/vsqjciMkrM=;
 b=qX2X0eWQuLY5UNdSV8f4FNRDDW7fOeOmlDKTX5punyueFzOwHiVRP/sUZjJaC6T36uh0DFO/QW1sw4cAnFlNPlI/hBR5zlly0NqS5Vi6ktFbOjrtkVQJikCM3YS6YE2cwVjrWvbGHwP8sXJgGNmVAHjOFmLdfE9DEVldq4RITd0=
Received: from DS7PR03CA0168.namprd03.prod.outlook.com (2603:10b6:5:3b2::23)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 17:23:36 +0000
Received: from DS1PEPF0000E63F.namprd02.prod.outlook.com
 (2603:10b6:5:3b2:cafe::4) by DS7PR03CA0168.outlook.office365.com
 (2603:10b6:5:3b2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Tue, 4 Apr 2023 17:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63F.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 4 Apr 2023 17:23:36 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 4 Apr 2023 12:23:35 -0500
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
Subject: [PATCH v7 2/6] x86/sev: Put PSC struct on the stack in prep for unaccepted memory support
Date:   Tue, 4 Apr 2023 12:23:02 -0500
Message-ID: <da935b55e55e3eaf3b354770adacb7967dc2ccc3.1680628986.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680628986.git.thomas.lendacky@amd.com>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com> <cover.1680628986.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63F:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c92790c-9a8e-4e95-4893-08db35315301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqPJGGbHB2n7LFHJ7fhkTo8RqZewfINOOOdJgF154T8jBvA8k+07xI60V3iN+zdJHYEh0FL2VUM3XTE5IUNlZMRED7EwEwKMynuMAfxMiU77+TFyQ3tfebdU0JvIUkoIR7i0H0ogGfxKCsUUa0oOunpTjSkh0Gm7NO/9RzGVFA6nIDahFClFDszFnj1d8NC21/qDw8cUfCgskj2tzM7HSQPEVs8+bo+xOGTGwTzWUPUSTpPPp0cKY4FTBDbV342Nzw3YZ3qCwxvWyRm6TDVKNdYUA/ubHRzrpBsfvxLFm3k/pdks8jKrgWNK7KzJFJoyD6pZ1R51x+yDkU5segX1iSoY9DmwYxe5lDOJg7YHMjnl9uS26c7ICDqHbvMp1P4pB3pc720iiAg5V7N0NfvbQo+dEo6k1nqtnFoaqruFTa42nlNLR4H56YnP2tWzwP38Ey5BH8gInGa6Y/nhqIbqxnAdE3cLVEmB+9KDmxJTQhvk27LjOQ5Vq0KnFbqXQbkXlfXGiBSdwjeDfjY9Qz33evg9tU6SmIZLeO/2iv+8unkFnJ06mi47uy2k1gUhvSLq68WgghRjURha5qkhUHGg7uKq01kwCcSOLeCfaYoavyXlGsw6Y7b1L7ojKGLYrTrNoAL2Qr5mvbpx89Xoc3otSZ9M8yMqWKCS/Hw/P4AtL76I8nf1VGxFT4dn0mD2XzVG1n9ssRWE/zCZV/+xaeNEnjPLN1G/3xTStt5PKK5Dhik=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(81166007)(966005)(426003)(82740400003)(356005)(336012)(83380400001)(16526019)(2616005)(6666004)(186003)(8936002)(26005)(2906002)(7416002)(47076005)(40480700001)(5660300002)(36756003)(478600001)(4326008)(70206006)(54906003)(110136005)(70586007)(40460700003)(8676002)(41300700001)(86362001)(316002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:23:36.4382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c92790c-9a8e-4e95-4893-08db35315301
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In advance of providing support for unaccepted memory, switch from using
kmalloc() for allocating the Page State Change (PSC) structure to using a
local variable that lives on the stack. This is needed to avoid a possible
recursive call into set_pages_state() if the kmalloc() call requires
(more) memory to be accepted, which would result in a hang.

The current size of the PSC struct is 2,032 bytes. To make the struct more
stack friendly, reduce the number of PSC entries from 253 down to 64,
resulting in a size of 520 bytes. This is a nice compromise on struct size
and total PSC requests while still allowing parallel PSC operations across
vCPUs.

If the reduction in PSC entries results in any kind of performance issue
(that is not seen at the moment), use of a larger static PSC struct, with
fallback to the smaller stack version, can be investigated.

For more background info on this decision, see the subthread in the Link:
tag below.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/lkml/658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com
---
 arch/x86/include/asm/sev-common.h |  9 +++++++--
 arch/x86/kernel/sev.c             | 10 ++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b8357d6ecd47..8ddfdbe521d4 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -106,8 +106,13 @@ enum psc_op {
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
 
-/* SNP Page State Change NAE event */
-#define VMGEXIT_PSC_MAX_ENTRY		253
+/*
+ * SNP Page State Change NAE event
+ *   The VMGEXIT_PSC_MAX_ENTRY determines the size of the PSC structure, which
+ *   is a local stack variable in set_pages_state(). Do not increase this value
+ *   without evaluating the impact to stack usage.
+ */
+#define VMGEXIT_PSC_MAX_ENTRY		64
 
 struct psc_hdr {
 	u16 cur_entry;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 72ef1e1fef84..a3d76eb344d6 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -880,11 +880,7 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 {
 	unsigned long vaddr_end, next_vaddr;
-	struct snp_psc_desc *desc;
-
-	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
-	if (!desc)
-		panic("SNP: failed to allocate memory for PSC descriptor\n");
+	struct snp_psc_desc desc;
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
@@ -894,12 +890,10 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 		next_vaddr = min_t(unsigned long, vaddr_end,
 				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
 
-		__set_pages_state(desc, vaddr, next_vaddr, op);
+		__set_pages_state(&desc, vaddr, next_vaddr, op);
 
 		vaddr = next_vaddr;
 	}
-
-	kfree(desc);
 }
 
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
-- 
2.40.0

