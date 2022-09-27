Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9C5ECA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiI0RFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiI0RFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:05:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDD3422E9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKAyC3fiYxLQsMdhTv1B0SD0NqpC8J/umoAYep12FZAG9GY4vdj7HMMnCUgIjOsGWnziKISIobtrqRxv2MT5KXXXN3ZB/m7U6yUkpvrlHITfvaVfHhHOEs3Fzj/AVCh6UxF0Hy8OXDmkRZMF82B/Cd2OUkRdkLuvvsKHsjJoYs9MxZCdM6O3xN5r2FssNVZr5FgYHiv324/JNsp4SDx8e2MQOTvnL6uTvr3wD6li7inZ94UfJRRSSuiq+TtyV0IBEOG8YWp5TnKivIb23ve6BdLgd6go4/q3MH8DbarLc3k6vuMFmKBIKP5uZVpqCwKns4fncNus+y9Wc0PlXHw/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn+ZXEmGVcAuT1CZTQkzVKxUSVjP/Os7EjiaQTEFKwU=;
 b=f+vHksxRP/UPj0lQJFutA2cV5LNIIDonNhcqLC+a6eL0cfm/V255/0KLXk7V3KIRkiMVzJHGWFWAYFSCM0DzNnlp0Nhc/nSGIiPex7Du5CgNuHy8Qs8K0SoTDEK6EgBf7kJufA+LnBtPm8ukXpRujnfN700QcZdz+bTbKOxlJrXKMrllCYeTNlCi8DBHPaUWFmuPg9AjV3JSxZ2gpyQEA/1pvQWKDFViKhNNwdtGsnCTFDO4hY8JkBWxowEHYYy1593H8zgxyu6B8RzTaLuFHO4TAWkhIB1lttuVoQFr5CrzokEGn4Fm2dw19TkvpPE0cs7wPJuIcuXM20OT54RLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn+ZXEmGVcAuT1CZTQkzVKxUSVjP/Os7EjiaQTEFKwU=;
 b=usUtWGTS2rqOx3CTkY4N7r5TC19phwWLOzxWWpmRnhJt4WVSddObLcDD3QkQyv2TTn63xynIbTGHkQvg/TtpErlY/jYSo5hTL3BuVhpwab8wpcQYz3IxFUkFRh6UHZKflmI+QLrDq6+GPxzOWIbQVCnri4N/A4ke/YUHK8Ph38c=
Received: from BN6PR17CA0040.namprd17.prod.outlook.com (2603:10b6:405:75::29)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 17:04:59 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::ef) by BN6PR17CA0040.outlook.office365.com
 (2603:10b6:405:75::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Tue, 27 Sep 2022 17:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 17:04:59 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 12:04:57 -0500
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
Subject: [PATCH v5 3/6] x86/sev: Put PSC struct on the stack in prep for unaccepted memory support
Date:   Tue, 27 Sep 2022 12:04:18 -0500
Message-ID: <ba0b07a9ffa60c8857e3def166eb02ac0d06dd4f.1664298261.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664298261.git.thomas.lendacky@amd.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com> <cover.1664298261.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|DM4PR12MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: ec687d74-ed00-4337-e2e8-08daa0aa68f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F467Oo4AIwLNAlNPTphBET8gPuO8VFOPFi752IhT1p3erg2bWU8ATfW5+iERQLzEwWAXZ5VPBjeByC1WbMq98LJLbMHBLYxCv9nM7F1WOZuL6FPaD8pZYWMNbnlJleBr9gM7uXmYFslAj/Bwn6WbaISdyQeHK74OOvdr34ERvR2CR08rAAagc4uMizi8JvgG2BvD8Z9HYH2B91lSJU4rhr11R35fOJBlb3phsZ+lkFKv3F9Q6LCbOGZ72FFzS2nyFFh6Noz5q+13ksk+mFAz2hWs+kTqfI6Voi0hb/Xl4KL7pVnkY7C+w8dt2yQ2mLIXqqn6z/5pvvfACpejsBhGD0NSmAewTZo3u9OjrUEiRLGztF5pVOIYf1/frEUPankVG9yrsDtiyGR0sCwDzMdvy0JteMDeB4NHoNDssLHiyGAuto/spLdfEUwUQm8yNJdxmpCds3VZr6RiXbnKaveyHWbs2uzkFyMFbccVYQY/AWZrxK+hi1gKWgFtlqD3wx7bm+UBo9PJ9w+b4bTvB6NDNR2jASuTnrBzWgvk6yE39/UNGw3m79WG4ME0WZK2/5TpDVkbZ/rsard25zsQvSbIa4IqwqJVWrzJ/fOAJZ4rPohFWRd3hHsHetvF053KAjc30I1wsDlkfL/z5AxGv4qAhIa13bHQMI/4mo2V8QVxT2uhfpdFUTNTay27GH79uWexwo7LgFdd13Ey67RV2ObF9ioRcHjC2THIJ/fc9i4mhSQ7QWIF8y3WXqSHbVsURhOLQZPPYApR6QaBn0mx6o10yFsjaZmX2QaGyLPwkF4efF6o0USWVXB0MMmkSLgA0kXkr4Is3CmT8rLwqVaoecZmmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(26005)(54906003)(110136005)(8936002)(966005)(6666004)(41300700001)(186003)(478600001)(70586007)(8676002)(4326008)(7696005)(7416002)(5660300002)(70206006)(2906002)(2616005)(81166007)(356005)(82310400005)(40460700003)(36756003)(82740400003)(83380400001)(336012)(47076005)(16526019)(426003)(316002)(86362001)(40480700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 17:04:59.1419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec687d74-ed00-4337-e2e8-08daa0aa68f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
index c90a47c39f6b..664a4de91757 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -868,11 +868,7 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 {
 	unsigned long vaddr_end, next_vaddr;
-	struct snp_psc_desc *desc;
-
-	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
-	if (!desc)
-		panic("SNP: failed to allocate memory for PSC descriptor\n");
+	struct snp_psc_desc desc;
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + ((unsigned long)npages << PAGE_SHIFT);
@@ -882,12 +878,10 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 		next_vaddr = min_t(unsigned long, vaddr_end,
 				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
 
-		__set_pages_state(desc, vaddr, next_vaddr, op);
+		__set_pages_state(&desc, vaddr, next_vaddr, op);
 
 		vaddr = next_vaddr;
 	}
-
-	kfree(desc);
 }
 
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
-- 
2.37.3

