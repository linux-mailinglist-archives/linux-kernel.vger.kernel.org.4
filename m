Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF32647308
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiLHPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiLHPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:30:13 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF493786BF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:30:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOS+CnovhpWk3kxaa6Vj1HK5f9IM3V4lHc7sDj7woFSf0z4N982XSOpm/xm8HT6oehmA5oah+zQeRcNayFs+wC0lKwS2unvZXFkvMbDojnBS5moeMVkIJC/BcKSX21ZpHKcrROyQRqH5SuzP3/v60b+7/TTf/2V1TlRDjV8T02vEbgTWZ/6KrwbEmT7XkXs/RBQvtwvcFyc729rUHZUVvfpav1PQyzj9xf7gl0JNYaFe27UuDtv3t6qB+j46IHF1KLmujvHoyuiRP+e/8GuaqeyePq/pRE9v7QAKdRT6uHb334r4k8jmaN3TMpWooFIyQy/a8bYAu9g3m5fm5NODvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QARjkQZFMOq7gtsotRHcZIPaXMpDlTYUxQ3E6T1ZA+s=;
 b=irsrZn/rmpIrB3TbkGzEU24KDvfCB59VJE9s4NYsOI/8I2dkP3fZiZKSLDmnFcz1oice/hqjvF0PHOzwebRquLzwU9t4+xE3scAKkKW+oAxGtqp1L6gnDYOyoER84H3ZVEJ3JaEWe/GHHm50Z0Xk3jzGW5GLMiKct99J5dSCx9K7OZHjYcMJDXtA5Hlti3upr2hVwvyaf9QZrpig6Q2RR6Lk8+lTKxw0kqWdgNlkLFvaf0VwTn76CG33vhIWmD2SySD7iYg8kYdSMt/OsygaJH1f53mw2nnSxayrcT/NPiUolbN84Wa5ezB0u0uK2qlDSYKjuk6vHat6IWI4RZ+bAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QARjkQZFMOq7gtsotRHcZIPaXMpDlTYUxQ3E6T1ZA+s=;
 b=m5B6wAUkQIFgmdxanUhheTR7G26mA6QYnEweTmazTWkzRv6evK3rkxPcuE0OXNZrCdQbrW743Td/HX1d59jVCppnu9ivjYqfTkyO3k9EaF8nnfKFaPET7QHKvLIkKgArlgOUBS8oYqnjUL7HhZ3yY1Z0QtzN3vKguzheXbuILAE=
Received: from BN9PR03CA0589.namprd03.prod.outlook.com (2603:10b6:408:10d::24)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Thu, 8 Dec
 2022 15:30:03 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::38) by BN9PR03CA0589.outlook.office365.com
 (2603:10b6:408:10d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 15:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 15:30:03 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 09:30:00 -0600
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
Subject: [PATCH v6 3/5] x86/sev: Allow for use of the early boot GHCB for PSC requests
Date:   Thu, 8 Dec 2022 09:29:11 -0600
Message-ID: <27bb9ed1a64712ea85acc94450c1095f1a67b9a2.1670513353.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670513353.git.thomas.lendacky@amd.com>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com> <cover.1670513353.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bc01f2-59c0-4031-3b63-08dad93113e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVBlWkYzzod1rGLFE8nU6nPTANhITLkWBnq+CZgJeaYxdh83yV0uLSb0fWuBw6owc0UCpW7oarefnFcLivlt2j5Tzrk4E2PsIPSuH/WB0tzmU51sebWptxJSAuppL+X/2R2yJVBZjbnL5eyhsgIbSJuVIq1YmXj+suZAaKQoSavopZiTnAUP8uxxHC90jIufVZMkraZIKfoITzcXCD38KK0/tGbfx/j2TYfewo/nvCexzKIp5tqTlMxophf3Tu6rEDWL5CH6P1fzqZkDTeDytODLxMg+CGXh6B+yUDadBTyhmifskwGfTdOWrMvewG/9tUy4HOhyJPKZWYXwtkpwYiJR7Wvm/zBUBR+XtKc3gqyI2bElrUmwyFayul/VfNrN3YFnyLA2LJLDvqy2SuQjD62JBttEWLMITPrXM6V37iK9jnZYZvGkRoCHTVigVFV28Uz0RnprLmxw28js+nOIJa+8YS8p2VyXoXfJnS7oY/KH4ay8tlz+lQlvuRd32Y/y6L1xbQG0sQGCupWYET8aOg7lpeXT4lqeP5hGS9tmKxVqS8clwRVnqnaYk4FHU70MFgbRR5DD3MWsKk6eYy9Skoc873e23i7Iqi0bmy0PFeL5d+jfabz2kVN+jL+diZ8uBk+9rUceresvqVwGTqBnfkF5Kmin6IfwkxHjCo8eHEriBXkEk9o7mwBtVONGFABm7uXfl38F8+POtDghfav2GB/gTcQjuoPIIqWpcqpZ1k0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(86362001)(336012)(16526019)(83380400001)(40480700001)(2616005)(70586007)(40460700003)(2906002)(36756003)(7416002)(5660300002)(8936002)(356005)(81166007)(41300700001)(316002)(4326008)(8676002)(70206006)(6666004)(54906003)(110136005)(426003)(47076005)(82310400005)(7696005)(82740400003)(26005)(478600001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 15:30:03.6227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bc01f2-59c0-4031-3b63-08dad93113e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a GHCB for a page stage change (as opposed to the MSR protocol)
allows for multiple pages to be processed in a single request. In prep
for early PSC requests in support of unaccepted memory, update the
invocation of vmgexit_psc() to be able to use the early boot GHCB and not
just the per-CPU GHCB structure.

In order to use the proper GHCB (early boot vs per-CPU), set a flag that
indicates when the per-CPU GHCBs are available and registered. For APs,
the per-CPU GHCBs are created before they are started and registered upon
startup, so this flag can be used globally for the BSP and APs instead of
creating a per-CPU flag. This will allow for a significant reduction in
the number of MSR protocol page state change requests when accepting
memory.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 61 +++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index f60733674731..8f40f9377602 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -117,7 +117,19 @@ static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
 struct sev_config {
 	__u64 debug		: 1,
-	      __reserved	: 63;
+
+	      /*
+	       * A flag used by __set_pages_state() that indicates when the
+	       * per-CPU GHCB has been created and registered and thus can be
+	       * used by the BSP instead of the early boot GHCB.
+	       *
+	       * For APs, the per-CPU GHCB is created before they are started
+	       * and registered upon startup, so this flag can be used globally
+	       * for the BSP and APs.
+	       */
+	      ghcbs_initialized	: 1,
+
+	      __reserved	: 62;
 };
 
 static struct sev_config sev_cfg __read_mostly;
@@ -660,7 +672,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned long npages, bool vali
 	}
 }
 
-static void __init early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
+static void early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -754,26 +766,13 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 		WARN(1, "invalid memory op %d\n", op);
 }
 
-static int vmgexit_psc(struct snp_psc_desc *desc)
+static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
 {
 	int cur_entry, end_entry, ret = 0;
 	struct snp_psc_desc *data;
-	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
-	unsigned long flags;
-	struct ghcb *ghcb;
 
-	/*
-	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
-	 * a per-CPU GHCB.
-	 */
-	local_irq_save(flags);
-
-	ghcb = __sev_get_ghcb(&state);
-	if (!ghcb) {
-		ret = 1;
-		goto out_unlock;
-	}
+	vc_ghcb_invalidate(ghcb);
 
 	/* Copy the input desc into GHCB shared buffer */
 	data = (struct snp_psc_desc *)ghcb->shared_buffer;
@@ -830,20 +829,18 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
 	}
 
 out:
-	__sev_put_ghcb(&state);
-
-out_unlock:
-	local_irq_restore(flags);
-
 	return ret;
 }
 
 static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 			      unsigned long vaddr_end, int op)
 {
+	struct ghcb_state state;
 	struct psc_hdr *hdr;
 	struct psc_entry *e;
+	unsigned long flags;
 	unsigned long pfn;
+	struct ghcb *ghcb;
 	int i;
 
 	hdr = &data->hdr;
@@ -873,8 +870,20 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 		i++;
 	}
 
-	if (vmgexit_psc(data))
+	local_irq_save(flags);
+
+	if (sev_cfg.ghcbs_initialized)
+		ghcb = __sev_get_ghcb(&state);
+	else
+		ghcb = boot_ghcb;
+
+	if (!ghcb || vmgexit_psc(ghcb, data))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	if (sev_cfg.ghcbs_initialized)
+		__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
 }
 
 static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
@@ -882,6 +891,10 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 	unsigned long vaddr_end, next_vaddr;
 	struct snp_psc_desc desc;
 
+	/* Use the MSR protocol when a GHCB is not available. */
+	if (!boot_ghcb)
+		return early_set_pages_state(__pa(vaddr), npages, op);
+
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
 
@@ -1259,6 +1272,8 @@ void setup_ghcb(void)
 		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 			snp_register_per_cpu_ghcb();
 
+		sev_cfg.ghcbs_initialized = true;
+
 		return;
 	}
 
-- 
2.38.1

