Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C0E709C73
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjESQay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjESQas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:30:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECD3198
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKt4wkoZKFck51bjffuzdQB7KNXuMbzNoS+kmuxxC5LnW2P6NXRzbPqca/kQaC+AhxKjGsJLJomp6bQxdH2os95V1wsgg5gx9v0YJmqVZH8oPiyIMyVmf8Y5amvhVlDaM9NPXhtLqr5NEBy6ocdAZ5KzZhVP8Mxrh96M/AQixV08e2ad2/FTmNl3Q5MZy3R0j0Wy8pbXMSPWqIyWe7XbwpwbM/aVYxKHL4tGLOA0bD5EGHMAN8vSjz/pPEcSdK3AxEPuLDaTgrgw6Jrd6qDj/vpEZYrtWN2FjBnQmWjSRdxguO7TEbrJApiCKdwlsvy+CcYHQEYLQQ8jAp5Nn2n9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMQqH5m4QXLuZBkFFVr61vvEYj4Js0xBdEZitHzZIe0=;
 b=JGeLJ7S8dI8Z5AsUz8/7ALKI4ybaGf6ik9avL6pyQRPKV4nrfB3YlKB4knlRnq150yy/9uYtJi2Q5fcz+mcnbZ6lJtxI3Sn6KELlcO2umcCtdt7aigsbv8+Es+BZL2uckCEG6z/dzb+0Hr88iqEuYkTKvHyKsM66MHnZLp9nEvkmwlhBTUwkH7It4cj7m6vMoXoN3O+jQbq5G1esO5rFPQuT5jgKD4iG2ylZMRL3aPTDWPFYJUNAxzT1URHEuoUpuSvSkbMgoo0q9S8IJ2ZSVQJYk9MgYczkr4CJ8W+D7xFKtzy8reueB8K8l6SFohfqRlTVxhyvMDFCHRm+m62T1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMQqH5m4QXLuZBkFFVr61vvEYj4Js0xBdEZitHzZIe0=;
 b=FiIkF9CmfT5vMw/rlf54sw8JJkG2r7lJWscgQ1jjUQv64UqT+EiHXLa3iH7ZDs4TkMPNL33uZOpJREtgkjFeYooUWAhfguXzOWKR74BRD+K2cGhlfOkXS0KEN5AhbgNIuRHnexHS/+78xlixW/5GFnRWOSCQai/OYjhYY/7duMQ=
Received: from DM6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:333::19)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 16:30:42 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::60) by DM6PR03CA0086.outlook.office365.com
 (2603:10b6:5:333::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 16:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 16:30:42 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 19 May 2023 11:30:40 -0500
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
Subject: [RESEND PATCH v8 2/6] x86/sev: Put PSC struct on the stack in prep for unaccepted memory support
Date:   Fri, 19 May 2023 11:30:09 -0500
Message-ID: <12e07432b4f4db949ef7ca5b93c0b2adb5b80a1b.1684513813.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1684513813.git.thomas.lendacky@amd.com>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com> <cover.1684513813.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcaad32-4a6b-4531-2d87-08db588663b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OI5+MrBdDBSCmgmF42/8X2B3ZJpiyyDzkIcdFf4JBZzrXelNuw9owSGOBKPww+YCeN3NZ1Hsmok8NqZqbzT8Eda6RLlP8Y6k2pNVZbRnTxMsOzu7jRS8eUCcMdWHy2QY/IXJLZLO2B+dKYICHx04kA19nTtlZU3SIQkED87oW5A75AScGrv6gQ65ci+hqK7lRUI26tMlr4nNeHSk3lKr5/1A7mqW+Tsja3BgtRB6HO/Qmw/fCassRpsrNp/GVLq2NJZXjJj7bPIRyfOaxYQei2IIu8LCDP74dNF5elG+yEncafeBNDq4IW/HnToLLf9+foRYltbLjsxHDiBnsrCdHSuCS2cd2LPfwyTzHwfLuMNbu13GdLxFraI+1/ATdRZgNOQPoIoKzPvuYNxYDEz6BOr2MkXS7XTXq5qmmpkEwxoOgQmVlG7ZUFTYnGkiVmHguYCmoBlR0Z+k/vxMFLhGhMpeuNMtqm2kMWBkxes42xr8c602MpLEBSbonxJsu6SU9N+4qq87TjkXVDnU5GsW6B6Tis8dweoydwdyB0APJMxm3bsQdzmSQQD5smttkApeN2dUgtGoBlfiO8KVd/0CDr3d/NprLgyGjj4DZxCEkXFLc2L6azuvLBqZPLsRJN53yQWPHP8dkJ8Dcp+mKSqMxv52tokOhVdY8kpPHjNRUUmYlNyd8R04qnaI6y7uoAGy7xrndmpBWaZG2au10h5ZnoV4JgDtbi24BeRrAkMdO/O+M70tp682QKY8ToBl4RAL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(26005)(966005)(36756003)(426003)(36860700001)(83380400001)(47076005)(40480700001)(336012)(86362001)(82310400005)(2616005)(81166007)(16526019)(82740400003)(186003)(356005)(54906003)(110136005)(7416002)(5660300002)(478600001)(316002)(2906002)(4326008)(8676002)(8936002)(41300700001)(70206006)(70586007)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:30:42.4152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcaad32-4a6b-4531-2d87-08db588663b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
index 0759af9b1acf..b463fcbd4b90 100644
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
index 108bbae59c35..7b0144acd7bf 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -882,11 +882,7 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
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
@@ -896,12 +892,10 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
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

