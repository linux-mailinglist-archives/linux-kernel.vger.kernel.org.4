Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECCF60C08F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiJYBKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJYBIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:08:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F79BD995D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666657061; x=1698193061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fhYTon+Hc+WcBW6ZSEbgkDupKrv70IXcyEjN02jeYOc=;
  b=dHPpgQ4BKmJY7y1Q45e5b+p3PyuvPie1RT5xF8dfXBx9m20axl6bO1VB
   bCKIqkEZZXANaYQl/P9vF8vEJfubyja9sMfmVxCqYvqitfLkTm547WScz
   9/rKZ1jHnT5dTnGK1dqpaSIGmu+xW8HnJCXA/n895Xn21Oh/b9ioV6QVO
   R53WSO/LgMa7eSUkX91QPxoCGuijGdK4CtShCDhvZy1X1NDH6fIIBYuIp
   W18QSiooN+sT9pUwxMNsLnjLhNEVcN1JugYFB+Q4VuPstmFRorwMRQ02Y
   lYbeEjbc2gq7JsrPQ5et++lPvaE2RE/aiEP+0uNwLqDSRmjpMMOdpb95V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308644665"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="308644665"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:17:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582587477"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="582587477"
Received: from ghoyler-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.118])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:17:35 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id F05131095BD; Tue, 25 Oct 2022 03:17:25 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv11 08/16] x86/mm: Reduce untagged_addr() overhead until the first LAM user
Date:   Tue, 25 Oct 2022 03:17:14 +0300
Message-Id: <20221025001722.17466-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
References: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use static key to reduce untagged_addr() overhead.

The key only gets enabled when the first process enables LAM.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/uaccess.h | 8 ++++++--
 arch/x86/kernel/process_64.c   | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c6062c07ccd2..820234f1f750 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -23,6 +23,8 @@ static inline bool pagefault_disabled(void);
 #endif
 
 #ifdef CONFIG_X86_64
+DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
+
 /*
  * Mask out tag bits from the address.
  *
@@ -31,8 +33,10 @@ static inline bool pagefault_disabled(void);
  */
 #define untagged_addr(mm, addr)	({					\
 	u64 __addr = (__force u64)(addr);				\
-	s64 sign = (s64)__addr >> 63;					\
-	__addr &= (mm)->context.untag_mask | sign;			\
+	if (static_branch_likely(&tagged_addr_key)) {			\
+		s64 sign = (s64)__addr >> 63;				\
+		__addr &= (mm)->context.untag_mask | sign;		\
+	}								\
 	(__force __typeof__(addr))__addr;				\
 })
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index a98536101447..9952e9f517ec 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -743,6 +743,9 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
+DEFINE_STATIC_KEY_FALSE(tagged_addr_key);
+EXPORT_SYMBOL_GPL(tagged_addr_key);
+
 static void enable_lam_func(void *mm)
 {
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
@@ -792,6 +795,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	}
 
 	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+	static_branch_enable(&tagged_addr_key);
 out:
 	mmap_write_unlock(mm);
 	return ret;
-- 
2.38.0

