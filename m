Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E6D709C63
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjESQZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjESQY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:24:56 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666FAC1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb14FCvh8duijrLk6DyLDeLI976c9Dr+7vPp3N7AMXeGocPCnuxuzZ1AjcZYV2i7XxWisSNa4lRBIlrDdOfQJPKstp3BzCr8FQXsHprEY7hDVKdCcqzZU/NSuFNHTrZo1xM5rvgvCiye3kNBibgMtjmJFi0y/sKwRzGvx6Bzr4bNpyd+/BsRVoK0ggDWnEb5R0gG2ffx7NtlJieCHcoTMosyULZEOlcby1eqONSN9Y+LxfSGiHceCBKKcpUTphSa9ZzX7NpDGzDnHfJ5vmucMIapRYLUoaWWcJrS2bvzbpEswjX47GJ3Gxg232mn2kJGb/2aVKyW7mq9n+TPVfJWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adTuFZ8iQMiM83q2NY8/acoI9AbzAM/9fd4rMUYoVsk=;
 b=em1acvEUOOtwDdP/JrdfKcF1vn1l5G/1sXa499m1kcXxKhe2uA/UwWSWOwjLjm7ugljO7hLF2HoE8AsRj7qXAFB0+bQ71bijHKCtf5Vs/Jc7YybjZIm/CsQ0aeL062QNYfgzflfnZvlnYr//uMfuCYXVwnhuDkBTB1TUuqquQyBV6hiAucwAWtIDyWwWSzg7E5rbqrKxGm4QWA6888X95Aux9HBzRR5kXxXmL4MyxSEej/uRdHfSeziJmx4y07b7UA8WNFmB6qbZsgjGCXki3yzlcgOrhm8+8j4srbS1jAYGak4/ClI2cJ2wfH48s+JSAa/vuvt31i1c1KSUXwqlOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adTuFZ8iQMiM83q2NY8/acoI9AbzAM/9fd4rMUYoVsk=;
 b=COXpEhbZB8PgQs2QSXWTSdK2je5LsvK9VH/o8OlfdFEHDB21SEf6rbxO44JgYnPu1eFOuruYtYoJIAl6vlViKJxhnk+XTft0rTFosQ+iviiTBYgmRMBpOX6n11qu2B79Q113xcgekk0Y428NQftO9re7H9wUL0Yj7q+ws2+qCjQ=
Received: from MW4PR04CA0037.namprd04.prod.outlook.com (2603:10b6:303:6a::12)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 16:24:50 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::de) by MW4PR04CA0037.outlook.office365.com
 (2603:10b6:303:6a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 16:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.22 via Frontend Transport; Fri, 19 May 2023 16:24:50 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 19 May 2023 11:24:48 -0500
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
Subject: [PATCH 3/6] x86/sev: Allow for use of the early boot GHCB for PSC requests
Date:   Fri, 19 May 2023 11:24:14 -0500
Message-ID: <49e0e596d71de92150f5d27b773d738eaf7dd68b.1684513457.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b157a7-8088-4237-21b6-08db588591eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmTzUGgB70iKmQ9jfRtHovD61UPCrVQL1s3yKWpkJy6agqzc7OfOS9UotXltCvftMTTvv2R9oQmVzbkN2xKwFYXzLuwOCJvHtu0DPcQS04cQD/6TpZSNyiEKuuZTs6L99axrqUqXIsFdcJUUPfIcOOnEZHZYHU0k89TDnpJNMBmDwC6/2BRBp66/goALUiyx0arPXM+WhTZ4MtI1hH0mCkDvtnmtTxUkOiEv8puzuRploswD32EG8H9RYBYD4SXqWI8hMD0KEE/+oKMdZpVLgU0/5jGC+tYHwuxO3RvgnhcV0uTnwdecn+skNTTPgG17uIcIk29t3lmWB3lsrb9njlUh2jTiJFe+VtwjMBvNM5QXiGy09Ut+wwQWpcWDQ8taulZt/xXyn0wwUB+vY1UL6701FYuC76weSOOSx1U978mwjbJKUkp2PNKgS7z55bH5khgZzZJX5mypBX5pAeTDPZHv6exuIuS51UmF/DhB/tjhNcgyfy7Lt6IfwyZ7bb2hMohg9bgW+83+xUuYOjWH3BFIuHCb6wVaIyY/cDqq46rae9u0BQ1LPc+pIz+Ch0duP2tnWJFnNVxXyo+AR++mQ8/rM/fHk2j1rMucexVJn856Fyh4jNLwEZp3fEY13CXSShCsz+9Q2/a/uUOrDXMENNw4qTKKOEuQV5cj9qiAhQfNALZoAijd/3X4AztyxUNiYYspVR4gktj6ZtKlLYZhWlDpfA5c4WYFx3EZKzklbQAogESWpr+gCMHLzzJwBDU+hbaw15bfkNdAXUBvenkOUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(316002)(2906002)(478600001)(41300700001)(4326008)(8676002)(8936002)(54906003)(110136005)(7416002)(6666004)(70206006)(70586007)(5660300002)(26005)(40460700003)(186003)(82740400003)(16526019)(356005)(40480700001)(47076005)(2616005)(83380400001)(36860700001)(36756003)(82310400005)(86362001)(336012)(426003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:24:50.3651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b157a7-8088-4237-21b6-08db588591eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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
index 7b0144acd7bf..973756c89dac 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -119,7 +119,19 @@ static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
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
@@ -662,7 +674,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned long npages, bool vali
 	}
 }
 
-static void __init early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
+static void early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -756,26 +768,13 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
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
@@ -832,20 +831,18 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
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
@@ -875,8 +872,20 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
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
@@ -884,6 +893,10 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 	unsigned long vaddr_end, next_vaddr;
 	struct snp_psc_desc desc;
 
+	/* Use the MSR protocol when a GHCB is not available. */
+	if (!boot_ghcb)
+		return early_set_pages_state(__pa(vaddr), npages, op);
+
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
 
@@ -1261,6 +1274,8 @@ void setup_ghcb(void)
 		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 			snp_register_per_cpu_ghcb();
 
+		sev_cfg.ghcbs_initialized = true;
+
 		return;
 	}
 
-- 
2.40.0

