Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A832C7246DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjFFOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbjFFOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:52:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49001712
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grJfLwnPcbOE84w+4X/9qFjPR9K1y7VGJIsVQxQKnMQjN05mvGb9DraDr+ekc2+uSRTCZrbWjG5en/gVuGocz/Vt4EFdrZtoXUOe+XuO1cXtvM3QQkzePhfl+3/OXENSwjv9zJbyau/G341HXVKnNIuOUO4HZoWafEYk+JS2sZk9orut7hS8+wJUIr53y6kmbl5cAqMnbmM3UYDsqU5LX/GeRu/Jcu/tYXukoXRA4Lccp2Jn7XhrU/uyHE6jfBsyzNetoRvCKgoafb/Leb5pRVwxUcTyAyL2i/ZDdLZzJraak3c6kiSQ0J0OcY9pCs9S3NYW13ic2bXRcRSFHz1mmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttXehVqZk6zYQofdpqGfIuBmlp/XNPqRNVhMzzATcOs=;
 b=PmZEfOhxm+u7wjLt6vIQycZDLiS7OyfVu8zanYE4Q+FFuT8m4+ttbPsc5hqrQy5yE7J36+cponr9wU/SLutp9TI0Ud5chJ1zBwiL1e1/abw/kb8/BLZEIw44PG91xq/cfVRIp+jYA6SZoHRTEg8gDxHvmGnZARpOGLhLZ3DaRagOKYHpAj/qocFWdToxR6z1d7kOjI0cSUO7f1mFCciysOf7FAs7YrdUDisYimLRTOCtblclF47D3PejElAvqEefs8k9imSwIBUPBi3o0pNlDNmwKQnADrYY5o73h0qMFfmqo7dVB2Q4cG1D0LWgA2vmmf9OIDhfKb2Z7tOC1CaOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttXehVqZk6zYQofdpqGfIuBmlp/XNPqRNVhMzzATcOs=;
 b=Ns+0RXiazmJMYchGPIK71eWOQvFx49cVBc5voabHHrpswKLe9YTDmrUmH6zYF0re9PTpUv96Gv/Tj3UmV1Sc5c9OlhOSh/+6LFBBhIVyDl+MjY/Tfm/YoMd+tzZoOeAMhtHa0nHHRCHchUs+sypjP1sPG4KcreUjlZZht8/vpC4=
Received: from MW4PR03CA0340.namprd03.prod.outlook.com (2603:10b6:303:dc::15)
 by DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 14:52:07 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::cf) by MW4PR03CA0340.outlook.office365.com
 (2603:10b6:303:dc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 14:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.36 via Frontend Transport; Tue, 6 Jun 2023 14:52:07 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Jun 2023 09:52:05 -0500
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
Subject: [PATCH v9 3/6] x86/sev: Allow for use of the early boot GHCB for PSC requests
Date:   Tue, 6 Jun 2023 09:51:24 -0500
Message-ID: <d6cbb21f87f81eb8282dd3bf6c34d9698c8a4bbc.1686063086.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT100:EE_|DM4PR12MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: bb00c4cf-53b4-4ba4-ea92-08db669d997f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hI8O12Qn5Vc81F+4IkNvdVAdR8Iv6Fcul7x7/nlGq1BXUlxjVrfwf2MNBwg+uxcONbg7nJjuZDgm0J4dBwB0lLewxB3Vf2Hy8/SskK1Gc4iq6W+vzeVlbCJkV5XJH4XHplQFdKWwSoOosVEmRKcP3wjehQ4YONltn4kHYrsNMJiRb7plgtphC0rlpAWrONd7lbfTSWX51mGeep5Lrm5426OkoYgV+yZWvOGYSy+j+IwywAtgGYPUIl6xWjR1l4sKgBpxXVvDjDHzddzYib+Rv2UmrqHXzz4WqwEFyOWCD9ausW6FRu1C1n5GU73l3lmlkA2fcky21OPwRTAlZ7GH0T1HslnFQKNpL7cY6IRrv0XMTLwISzzYE/3kmQhfZOIuZdn48/Lj3kHV7FwMkw1B2AjLfl7FuyIdK0nv3vUeG4aPuhifgPKzq5R+QMF2DlCBZtjEYywSFU4faZiZJr7mzJpsAO/Pg37nH/1JURFdynlosVBNGRXU1/BkcTNcZcZrXZ4+FG/CrpFNUINPAQT0WYLQruCXYJ0sINbEqWr+FUFWQJAi9ZRjesr/Z/m0erBONbFj3g9Z37UUT5B8R8MQlKj/w4QH+AVx1VwdQPVrF+JvJGSkOBYwU48XfoGi9942Xz0I86AVU6ceuJ4ndXdVmQ4fCN85wbOCejmEveEmVrAHZ+78h3q6SB//pZAYwMVhEerHxXljI/nk5qMnjSWd2g3URwB+m6SHGsjhumcL/+x7nR137YYbVpvPQ87epMlwfAsEPzTERR/JEiXWORYTUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(110136005)(40460700003)(478600001)(40480700001)(8936002)(5660300002)(7416002)(8676002)(36756003)(86362001)(2906002)(70206006)(4326008)(81166007)(82740400003)(70586007)(316002)(82310400005)(356005)(41300700001)(2616005)(26005)(36860700001)(16526019)(47076005)(83380400001)(186003)(6666004)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:52:07.2846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb00c4cf-53b4-4ba4-ea92-08db669d997f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
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
2.40.1

