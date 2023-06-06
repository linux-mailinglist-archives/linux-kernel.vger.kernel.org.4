Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C5A7246D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbjFFOwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbjFFOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:52:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26A710F4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2N9lHAS3pkRjIW38Hcbd1rDqC1abhxrdqAO7ufmucn1306/gGa79AlFA6MYxpjB+CJrslWknBMIdyvkMgGRcQai673YT0s3ggRRO84Ko2vuArjHz5h/d15AQVBHAJ8Ll2MyEEMsWIdxpzRmp3TzaPBgdCUYNhU5nYYxQ4EukxKNuqW1Hxv/u9K6zav9nwJl14aXyUqmZcN9tuIVAC6XTS49U1k2dlb2Oi54H2R5Hg83+J3Bp3d5me0p7JEqj/UgU7EQjANEMl+OmMoawg9mj+IVeKFli3UhaO96b7m1cnwJQ+grHSHYiwuZfU5lR9Y+Dh+o9pkbtRkMcjXEwnC7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si0Y0hViSqZXgGsXUM4bYNOJ+CCiV+oRKTAmQV4GmTU=;
 b=gu8gaqjNi4Qp4rnvF/pdKy2lvuWqTnrRatYyZH6Ro0rE34qB5mCBw89/TmE1tjBN+P2bjE7c063OU7bHPkrEV3st2toqXUDCSwjHhCtVe9Zmu1iihoODFHrjYA+txXVMTaBWHflYADTUtUghb2Td7iFp3RW5Bz5868ddrvIs6GFdIJPbe+YL+vohPWF6cX3gUx+yEGDDOnYydjhvPf7CM2nfnGnZ5TEYAorFn41829Jgv6lMx1GGiGybFpv7qAPx2QiFnegfQJ8D7DDS7pSXFt3sUPJunZMgdsc8qRkUD6Szk4apUaiDSTJKJ8cbW766D++LaatWvOIl+mgTQ/fGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si0Y0hViSqZXgGsXUM4bYNOJ+CCiV+oRKTAmQV4GmTU=;
 b=ehUJZovdPXqLyz9qYNZXjMUSwEY5/Kltsdd3yl0SicHh2DvRCL9x/FEEOGOOWhhZSNX4y/psewCZMsye25KCbaLnDiJCEA4Dh8AMhyWrInPOskgh3xtbMHPixAiJhUq+M+lvO0fEwmp0fypMJhw4FwiMbKNMIwUi/goU7fjglAc=
Received: from MW4PR04CA0386.namprd04.prod.outlook.com (2603:10b6:303:81::31)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 14:51:59 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::14) by MW4PR04CA0386.outlook.office365.com
 (2603:10b6:303:81::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 14:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 14:51:58 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Jun 2023 09:51:56 -0500
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
Subject: [PATCH v9 2/6] x86/sev: Put PSC struct on the stack in prep for unaccepted memory support
Date:   Tue, 6 Jun 2023 09:51:23 -0500
Message-ID: <938865ea7f5ad88d4daa846b97c9414723b5639a.1686063086.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686063086.git.thomas.lendacky@amd.com>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com> <cover.1686063086.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9fa361-3a9f-4413-5025-08db669d9458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sq7LYwBA86WDWGPFP6F3vTNA9msSGUsWcnhQHltXWguctqvTR1jZD71gsJellpBwwRr3Kokjzl4YJ9iPhgnPKBu+ZDCcDkhqAIT4245c8brJugcDm1DaZ+/xd0jUGH9TaWvJVdsZ8q7EM6pGeyTkKsbqZm4JjWKjDp72GzdaYtajSGo2VirVLRhlpxAY7Uygsdp1s7kS/QttskIfl3+6VHZs/E9m0ZNTwY+zQL8hm4kwOqtUu4Dqkv6voenRMcn051hIiuOJYGQc+7vZ7YX9l4nD4TEaI+PSMODXw6leQVn8jTiLXcqKwkR8kCNeDqP3nD0qIQg/IgH07im8wUyJie6KVI+S/IeLlz18WW/3fO+DTcQC3RkClcquL46eV/JB7ezb6xI/0+MloTPLCPukgFWVzNlSEGFHDHDXDLKgVpvrfXGsOWxZ/MhlBHnAQ5PAvBwDE9rH0VPaGqQgFYhQRdgC8rByMG8ebRYbyie7l+zxVh37ej78A0xlMyPjSqkwQfHC21ydhojmzQS+K5m+KJLpIA+JjI5K9arUEHnSl1L/iAPnh4/3MKSAwdyFcrhIXIsvCVL+7iPlOFqk7/pvTnG1js42pyIsNQ8sZ2gnkG/+3bzdZ3x8+IJYHMHlvk5jcU7oP8XDd2cqYy0c+ZbipeYf0mri+40Vn7qhlY8UVhsYYdQ76FJ/G/k7IIhrdYjKRYkGZ3ZDYTtAwntSBgvjqbKUrAUGpx294uZMWF7KDxAN6OoQ5ZsG5j7qe1e1JnX4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(83380400001)(186003)(47076005)(426003)(2906002)(336012)(2616005)(36756003)(86362001)(82310400005)(82740400003)(81166007)(40480700001)(356005)(36860700001)(966005)(316002)(41300700001)(6666004)(5660300002)(8936002)(8676002)(110136005)(54906003)(478600001)(4326008)(70206006)(70586007)(26005)(16526019)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:51:58.6209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9fa361-3a9f-4413-5025-08db669d9458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
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
2.40.1

