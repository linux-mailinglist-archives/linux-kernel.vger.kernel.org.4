Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704A8629EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiKOQQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbiKOQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFCB2AE16;
        Tue, 15 Nov 2022 08:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668528997; x=1700064997;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y3hO9w9U7Sm/Kr+NV1OeBCHXa0PIh0mzuLu98vZzr4E=;
  b=Mvg/ejvu9AvLvRoFAnmphvlr+YP97PU4TNCyv1+/Ise2hVATcKdw4evN
   njNPs8wOM+tPxTY8aDFZo58REQLRWR+DkZR+7mA64zwT+hwxsi+QRmgyM
   bB0rx/hm8tHembFwSr6nV8QezIu3s99DRT7H5PRq5YWcbL1krpj3zGh5X
   s9frZgsNigdywqJJdjq2aF21JX8vDMFqe7p+SwvIflvTH8/ORbovbHV3S
   F3f9036HJ18TcsaB6zPm4YMCeNNDsNgd0LotaOIXMAfcJt4x9u93UJvBv
   3HkEBhhPfkHjIhDFKZsHqETQOb6/GR+/8UPYIOu3Xvo1mfwn6wDRuaMdn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292687561"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="292687561"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:16:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="672044261"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="672044261"
Received: from kuilincl-mobl2.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.165.212])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:16:35 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, ira.weiny@intel.com,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/sgx: Replace kmap/kunmap_atomic calls
Date:   Tue, 15 Nov 2022 08:16:26 -0800
Message-Id: <20221115161627.4169428-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap_local_page() is the preferred way to create temporary mappings
when it is feasible, because the mappings are thread-local and
CPU-local. kmap_local_page() uses per-task maps rather than per-CPU
maps. This in effect removes the need to preemption in the
local CPU while kmap is active, and thus vastly reduces overall
system latency. It is also valid to take pagefaults.

The use of kmap_atomic() in the SGX code was not an explicit design
choice to disable page faults or preemption, and there is no compelling
design reason to using kmap_atomic() vs. kmap_local_page().

Link: https://lore.kernel.org/linux-sgx/Y0biN3%2FJsZMa0yUr@kernel.org/

For more information on the use of kmap_local_page() vs.
kmap_atomic(), please see Documentation/mm/highmem.rst

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
Changes since V1:

- Reword commit message to make it more clear why it is preferred
  to use kmap_local_page() vs. kmap_atomic().

 arch/x86/kernel/cpu/sgx/encl.c  | 12 ++++++------
 arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
 arch/x86/kernel/cpu/sgx/main.c  |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 2c258255a629..68f8b18d2278 100644
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
index ef874828fa6b..03c50f11ad75 100644
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
index 0aad028f04d4..e5a37b6e9aa5 100644
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
-- 
2.38.1

