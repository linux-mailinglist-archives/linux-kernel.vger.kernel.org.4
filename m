Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62575F3780
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJCVMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJCVL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:11:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8EA5142D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664831221; x=1696367221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q+A9j7rbet3l4iyEXFd7FCMMWn4NnBtOFkDeuOIybOw=;
  b=bZMS2B7MaejXuUFeeceuKsdEe/F6/EvSsVGRaDZt8KlsKwL6gDlIxVeU
   hGYpKn/fasOYyu5t4Q00HCR6kHKbseEt4AXl/KkI1ajo2unO88lc+Frgr
   YBAukXjRn3eNpjCMV9SxYY/PUBzHvxR45P8gkBmljR3H5pbW9aDiMC1vS
   N4bVgRQWFHHNVYac2Y6AX744GP5HKBKrclFWiA0Za0ox7lfDjEBxsNZpn
   gALMvPxZCi6emGSjfWh3ojHcNli98D7fpXPA1n1Y91f7xMt4EIKw4lYFL
   BmD1WwjwDn7Zz6+WcUMv38ZoWIO5JINKPsev7j4VB26tQxpr4VADyXTzw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="366858616"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="366858616"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 14:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="749146590"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="749146590"
Received: from viggo.jf.intel.com (HELO ray2.amr.corp.intel.com) ([10.54.77.144])
  by orsmga004.jf.intel.com with ESMTP; 03 Oct 2022 14:07:00 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/mm: Ease W^X enforcement back to just a warning
Date:   Mon,  3 Oct 2022 14:06:59 -0700
Message-Id: <20221003210659.3837868-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

I'd like to get to a point where we can turn on W^X enforcement
and keep it on.  But, we're not quite there yet.  I'm planning
on applying this to x86/mm before it goes to Linus during this
merge window.  Any objections?

--

Currently, the "change_page_attr" (CPA) code refuses to create
W+X mappings on 64-bit kernels.  There have been reports both
from 32-bit[1] and from BPF[2] users where this change kept the
system from booting.

These reports are showing up even after about a month of soak
time in -next.

To avoid breaking anything, never enforce W^X.  Always warn
and return the requested permissions even if a problem is
detected.

1. https://lore.kernel.org/all/CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com/
2. https://lore.kernel.org/bpf/c84cc27c1a5031a003039748c3c099732a718aec.camel@kernel.org/T/#u

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/mm/pat/set_memory.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index efe882c753ca..97342c42dda8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -580,7 +580,7 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
 }
 
 /*
- * Validate and enforce strict W^X semantics.
+ * Validate strict W^X semantics.
  */
 static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
 				  unsigned long pfn, unsigned long npg)
@@ -595,7 +595,7 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 	if (IS_ENABLED(CONFIG_X86_32))
 		return new;
 
-	/* Only enforce when NX is supported: */
+	/* Only verify when NX is supported: */
 	if (!(__supported_pte_mask & _PAGE_NX))
 		return new;
 
@@ -606,13 +606,17 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 		return new;
 
 	end = start + npg * PAGE_SIZE - 1;
-	WARN_ONCE(1, "CPA refuse W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",
+	WARN_ONCE(1, "CPA detected W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",
 		  (unsigned long long)pgprot_val(old),
 		  (unsigned long long)pgprot_val(new),
 		  start, end, pfn);
 
-	/* refuse the transition into WX */
-	return old;
+	/*
+	 * For now, allow all permission change attempts by returning the
+	 * attempted permissions.  This can 'return old' to actively
+	 * refuse the permission change at a later time.
+	 */
+	return new;
 }
 
 /*
-- 
2.34.1

