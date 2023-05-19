Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C31E709C61
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjESQYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjESQYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:24:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E6DF
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9J10nNIi727LGM+fSG6SVJNycm0XCsyehjU8UxRETNMWQlVijJiWPVgo81iEzIc5VBdnOY3GeyHBcJqCEeOP1ONJOfrsOQTUfMExCVI8UUiaU2c6KL8oEWHqZgt9dYWGp0tkwwrv6hVsijqIr5KIXwXgIO7f61sN7ajuo4kj4KajXCrYwlKr+E0BTd0YxVToh7xg/78xifT04BPG/1roHW09vEuqaApNZjzS1ZFj9DCSKqAaUukBl4DycjrdnbO1SKTorqNeUR+l5uZ6meuBuTzV9r5pzoSg7lRCH2AlI8pMggUIdqk/FNn5peH5LCXJZwH+HWjArXb14EkgzIXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMQqH5m4QXLuZBkFFVr61vvEYj4Js0xBdEZitHzZIe0=;
 b=FAx49FJqz7ybkN6dUucvz3+ZPiYiIXZx4RNZYKWpx2S3ChGmBG9+QaasHr4nHx/HKy52OyWUTM8uW/aM9PE5xC1SdUFs7DiP+dX69q+RvFN4cXwf5FVhN8UMS+3U1OkFweMY11oI4CYbYWDw2Z9T7UKb6Nrf1SAqDJDjYMLDFsi/TJ2w9/fgowWjyveDehLOPi1rm6P68NccL984OKeOidQOxHfD5jjASX3k9XTdn1Wxo137pYxSzZltJYGWSQ4M3wzf4OtqDns+4VZKA6zSJSHWqFl+sTsCkqxcN+FKFwe8AH8NNVHhdyPJJHysGqX+mBXjsyausp4X3wxnuSCDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMQqH5m4QXLuZBkFFVr61vvEYj4Js0xBdEZitHzZIe0=;
 b=ozAjbzRBOOjvs8xKXsYKKTLZpqwg8lY7kyChsO4HXy+6QiXYwU96YRzPkd8P6gU3CIKUSuSdybJlp88q7VbXx8xsxYM7rudZa6RX8MgWLwNTDxW25Bz724VwT9uF77j1DLSEW/ObmgU0e/eFEM3DGLyb8x0xxl8MD3gNXLKF9bw=
Received: from MW2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:907::20) by
 DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21; Fri, 19 May 2023 16:24:41 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::79) by MW2PR16CA0007.outlook.office365.com
 (2603:10b6:907::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 16:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 16:24:40 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 19 May 2023 11:24:38 -0500
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
Subject: [PATCH 2/6] x86/sev: Put PSC struct on the stack in prep for unaccepted memory support
Date:   Fri, 19 May 2023 11:24:13 -0500
Message-ID: <12e07432b4f4db949ef7ca5b93c0b2adb5b80a1b.1684513457.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: c36180e3-56fa-4c65-57a6-08db58858c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AFpn7HstYonnYPhzfPL7FrsB/qE+fFcM0uSP1RAC6CwVP6I9DuLVzNomjoY5EY32yeiWga3ScaHn36+URdpMjVeeIlcOSzZnqymBIGSdje/Z0GDG04MxYUt9EpTaciTfP0RZsbXJGQ5CEf804iVI/qdh4vP6InxOov/FwEaXa8t6D+XOlwYp8N1lNfBLwOwH6YUhIjOYFYmXdlmsPcSZ8evfz2iiA1HokAHKx42CMaeaafm/MjbKTvtBTG3TiqL2qrD6WmJF0oAJIwGEFqrM0DUW58porZYix/+Oyj8256bF2JxZg0IGa3SPJnKB8d7xTFgvZLdksVJB+brA8WFe4Q2XmWVgVXmpBMJUcxomEo2CiYISbWoyCZX+zSsgY1FBjFqhNzjruTh0yA6lOE2dtiYxE63SjGKBaiNGayyiFsPGFTfNHIYI7dwm5hNbqQmxl2TvW2O/ptH9v2SaEF8x+uu4LEQqdvQN7+Tn/PehH3k4WXH6307783SEVkeFmnTdMZR1m4IcSLLsidmvGQAwVB3Eir/tgx/E5Vq6tkIRll1V6D1xKDNbiXP/emCVbHXaWgnJeKiH/zh6zl4yp3zWPiYYvtvcNYHcj7JR9pR5oKZS00xj1YsNQlYkHzrVXcmkl3a120S0nVgi+R8Q8hiCwdtSGDpRur24Nrmu7+TDxpDShpDsUTYPJdsViDUdtmaNf+tgHT1H4ENeW8lPrVoPvBMmVilXG+rAu5EiUHNq6YkRetV73ia8+Uuy7BVGUyl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(83380400001)(81166007)(82740400003)(356005)(40460700003)(36756003)(8936002)(5660300002)(8676002)(7416002)(41300700001)(82310400005)(40480700001)(86362001)(4326008)(316002)(70206006)(70586007)(426003)(966005)(47076005)(16526019)(110136005)(26005)(186003)(336012)(2906002)(6666004)(478600001)(2616005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:24:40.9686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36180e3-56fa-4c65-57a6-08db58858c51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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
2.40.0

