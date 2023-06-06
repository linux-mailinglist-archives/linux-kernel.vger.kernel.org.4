Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371F6724D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbjFFTnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbjFFTmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:42:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFA610F8;
        Tue,  6 Jun 2023 12:42:38 -0700 (PDT)
Date:   Tue, 06 Jun 2023 19:42:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686080557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLXa1THRzBA0rvWLifkwVhv+vx6rwJktV26Xtre25Gw=;
        b=NuIfvg8GOS93pxKHMUBebHCUcTvQKd30v0CXnJH4x8HjojYs4pJs8CtqBz3H91a7Y+DeKB
        oWhrBQcUgZ0LswJDjRgjapZSLGQqeWACE5+zP+Tu/EWi61FSFWe0L5ToJ+nKDHxApExvye
        bdm7XagNzk+ysIC5ZjJA/QEFhKxK9Id6WSd/ij3mmZlaumqmsGS0x/m7nyuZZMPUVN4Cml
        D1X6kV3btsETN1GxpmmpiNMXGpyn4fQVcCpckaQDeq9tLZQzCvsw0zFGUTGwcrZZvUAQla
        ZEYcFiN0O5nCf7xQJm+4GtWfPwcYdqdY7MSZCQkdmhRCq+RSMtQiJd70c7IO/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686080557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLXa1THRzBA0rvWLifkwVhv+vx6rwJktV26Xtre25Gw=;
        b=GQtDfZHJUfzCmhrweCXjSIk6zJzYQdN5gUwK//lDILVHh0KXA9MU3a3rYZ7kcHyIwU9gp9
        Dft9oThhkXmkwdBw==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/sev: Allow for use of the early boot GHCB for PSC requests
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd6cbb21f87f81eb8282dd3bf6c34d9698c8a4bbc=2E16860?=
 =?utf-8?q?63086=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cd6cbb21f87f81eb8282dd3bf6c34d9698c8a4bbc=2E168606?=
 =?utf-8?q?3086=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <168608055685.404.12449337233179053718.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     7006b75592feb1902563ac1decfd98d7e4a0dd6c
Gitweb:        https://git.kernel.org/tip/7006b75592feb1902563ac1decfd98d7e4a0dd6c
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Tue, 06 Jun 2023 09:51:24 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Jun 2023 18:29:00 +02:00

x86/sev: Allow for use of the early boot GHCB for PSC requests

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/d6cbb21f87f81eb8282dd3bf6c34d9698c8a4bbc.1686063086.git.thomas.lendacky@amd.com
---
 arch/x86/kernel/sev.c | 61 ++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 7b0144a..973756c 100644
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
 
