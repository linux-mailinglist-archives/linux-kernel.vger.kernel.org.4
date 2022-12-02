Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E471640827
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiLBOFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiLBOEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:04:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CC0DFB73;
        Fri,  2 Dec 2022 06:04:29 -0800 (PST)
Date:   Fri, 02 Dec 2022 14:04:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669989867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgesFIhirQ56l6RZnTYg9BoZk9NoSnbAmIIs3vJGpqU=;
        b=uGTPyOCWEdXhqUisMdVRn8ldi5QoWIAX3Gv5c+hyy+76Lr/aJHZBLpbSITBHE++Cryn7qz
        8TxkDZHkvtT6fNp51o030iEf2ByVr27Lx4/WcdhsSxpl/STTRiZ1kN1v1NIQXhI1EUMg21
        sW8Sgn6NCF+qweWltvXjGWJthO3C8wOSYSidusZsADgzcEj5nzK10g1kYbLeDMzTnJySJj
        lByyxK6OylV6fuFLcEJmgqw42WaRNmeVDG//SRmK42l5GUZhlvOW0WDroDdaPevNGGnez9
        hc3P/be814l6ZBPF/FiXN8N8XeViPgMkF5MIY6rsU7fNw6dLLeJZ0kpaauT5Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669989867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgesFIhirQ56l6RZnTYg9BoZk9NoSnbAmIIs3vJGpqU=;
        b=PrUj5jKTr4CfVnuyUqm2TzZlOFO5fPXhvqfxg1R1JkHNADLDaoIU6posKH4XsgmdC6nwQB
        Xk66uycU6tvsGlAw==
From:   "tip-bot2 for Kristen Carlson Accardi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Replace kmap/kunmap_atomic() calls
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221115161627.4169428-1-kristen@linux.intel.com>
References: <20221115161627.4169428-1-kristen@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166998986573.4906.1118337438012920133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     89e927bbcd45d507e5612ef72fda04182e544a38
Gitweb:        https://git.kernel.org/tip/89e927bbcd45d507e5612ef72fda04182e544a38
Author:        Kristen Carlson Accardi <kristen@linux.intel.com>
AuthorDate:    Tue, 15 Nov 2022 08:16:26 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 14:59:56 +01:00

x86/sgx: Replace kmap/kunmap_atomic() calls

kmap_local_page() is the preferred way to create temporary mappings when it
is feasible, because the mappings are thread-local and CPU-local.

kmap_local_page() uses per-task maps rather than per-CPU maps. This in
effect removes the need to disable preemption on the local CPU while the
mapping is active, and thus vastly reduces overall system latency. It is
also valid to take pagefaults within the mapped region.

The use of kmap_atomic() in the SGX code was not an explicit design choice
to disable page faults or preemption, and there is no compelling design
reason to using kmap_atomic() vs. kmap_local_page().

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: https://lore.kernel.org/linux-sgx/Y0biN3%2FJsZMa0yUr@kernel.org/
Link: https://lore.kernel.org/r/20221115161627.4169428-1-kristen@linux.intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c  | 12 ++++++------
 arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
 arch/x86/kernel/cpu/sgx/main.c  |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 2c25825..68f8b18 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -160,8 +160,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
 		return ret;
 
 	pginfo.addr = encl_page->desc & PAGE_MASK;
-	pginfo.contents = (unsigned long)kmap_atomic(b.contents);
-	pcmd_page = kmap_atomic(b.pcmd);
+	pginfo.contents = (unsigned long)kmap_local_page(b.contents);
+	pcmd_page = kmap_local_page(b.pcmd);
 	pginfo.metadata = (unsigned long)pcmd_page + b.pcmd_offset;
 
 	if (secs_page)
@@ -187,8 +187,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	 */
 	pcmd_page_empty = !memchr_inv(pcmd_page, 0, PAGE_SIZE);
 
-	kunmap_atomic(pcmd_page);
-	kunmap_atomic((void *)(unsigned long)pginfo.contents);
+	kunmap_local(pcmd_page);
+	kunmap_local((void *)(unsigned long)pginfo.contents);
 
 	get_page(b.pcmd);
 	sgx_encl_put_backing(&b);
@@ -197,10 +197,10 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
 
 	if (pcmd_page_empty && !reclaimer_writing_to_pcmd(encl, pcmd_first_page)) {
 		sgx_encl_truncate_backing_page(encl, PFN_DOWN(page_pcmd_off));
-		pcmd_page = kmap_atomic(b.pcmd);
+		pcmd_page = kmap_local_page(b.pcmd);
 		if (memchr_inv(pcmd_page, 0, PAGE_SIZE))
 			pr_warn("PCMD page not empty after truncate.\n");
-		kunmap_atomic(pcmd_page);
+		kunmap_local(pcmd_page);
 	}
 
 	put_page(b.pcmd);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index ef87482..03c50f1 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -221,11 +221,11 @@ static int __sgx_encl_add_page(struct sgx_encl *encl,
 	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
 	pginfo.addr = encl_page->desc & PAGE_MASK;
 	pginfo.metadata = (unsigned long)secinfo;
-	pginfo.contents = (unsigned long)kmap_atomic(src_page);
+	pginfo.contents = (unsigned long)kmap_local_page(src_page);
 
 	ret = __eadd(&pginfo, sgx_get_epc_virt_addr(epc_page));
 
-	kunmap_atomic((void *)pginfo.contents);
+	kunmap_local((void *)pginfo.contents);
 	put_page(src_page);
 
 	return ret ? -EIO : 0;
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 0aad028..e5a37b6 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -165,17 +165,17 @@ static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
 	pginfo.addr = 0;
 	pginfo.secs = 0;
 
-	pginfo.contents = (unsigned long)kmap_atomic(backing->contents);
-	pginfo.metadata = (unsigned long)kmap_atomic(backing->pcmd) +
+	pginfo.contents = (unsigned long)kmap_local_page(backing->contents);
+	pginfo.metadata = (unsigned long)kmap_local_page(backing->pcmd) +
 			  backing->pcmd_offset;
 
 	ret = __ewb(&pginfo, sgx_get_epc_virt_addr(epc_page), va_slot);
 	set_page_dirty(backing->pcmd);
 	set_page_dirty(backing->contents);
 
-	kunmap_atomic((void *)(unsigned long)(pginfo.metadata -
+	kunmap_local((void *)(unsigned long)(pginfo.metadata -
 					      backing->pcmd_offset));
-	kunmap_atomic((void *)(unsigned long)pginfo.contents);
+	kunmap_local((void *)(unsigned long)pginfo.contents);
 
 	return ret;
 }
