Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2C1623084
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKIQwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiKIQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:52:35 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF0A240A8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668012737; x=1699548737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qQuq8QNGbNiZCBzAMV30JlXBLCHT9H1+EgK3GfrClpQ=;
  b=SaLl3i7TQAcy6FwgC5q8VE/gJfLmI8zS+1hzKKei6JPArTdZffD2hn5T
   Ncmj4HZ82vlQrszK0Zhf6HUfNh9phF4MT/6JDZigGj4Yx0VoJ9wwHhRrP
   WtPkK+y1JbIKV6gyMarq9N41wu13o9UETnLc9uwnE30A3l0wfa1lf41xT
   Cs6DuD5N9e45c7FNw1WFwE5SnHF9KHu4eTS1bLpQWA6rbDLCrKbRKIXBf
   l0loWXcSD8rQgA2LwwEql17RXe30OHtW3pP7J/v1Lu5HYM6NnXhfKzo4e
   OYphM4sNJvH8OidbPRwNEsimPM4yi6z95vbuNvXGXtyo0c598Ck2zgJGR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="298553708"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="298553708"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="587827255"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="587827255"
Received: from dschramm-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.219.85])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:10 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A93E0109474; Wed,  9 Nov 2022 19:52:00 +0300 (+03)
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
Subject: [PATCHv12 08/16] x86/mm: Reduce untagged_addr() overhead until the first LAM user
Date:   Wed,  9 Nov 2022 19:51:32 +0300
Message-Id: <20221109165140.9137-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
References: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 0db6f5451854..1d2c79246681 100644
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
index b8f2558a3aeb..457f79be8bc7 100644
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
@@ -798,6 +801,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	}
 
 	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+	static_branch_enable(&tagged_addr_key);
 out:
 	mmap_write_unlock(mm);
 	return ret;
-- 
2.38.0

