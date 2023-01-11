Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BFE665C75
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjAKNZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjAKNYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:24:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D2F25EF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673443442; x=1704979442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKZbUwdFl1OELkYDtSril3bPVHQFFQ9B8sbyyX7BAAY=;
  b=EQ2ZbevFjOEvN9UyTZaGVsOxOPKZ8o2xgIq4ro1gin8J9WRslxBEv48V
   AHg6EJg7dqabeKEHImrNfIMJ3WonY2XGS2h1Ohy6Szhz6wNPRZ2F1u/vP
   1A3QBu5NoXaHpjPkjxGjrzrb+UpsY90lSPdwYtWuph/DRoe3KNItY9eZZ
   n2L4RmFBMhnAVJ25nQBYylqaidjCA0Bs3UViqaulQSAWKxeh8vdU8LlIG
   wBBbHfwD4L5aXf3HcOBi7gADkZr+IQnXaE9PZw8azPkKcNxHHTRBKFnDo
   jVR2PjadwviMfMd8BkJACq9yecxCTBD4K7HgscHq4kJ1oVJ+cHGmU4lfG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="387872549"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="387872549"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:24:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687927431"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="687927431"
Received: from bachaue1-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.250])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:23:56 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 53F0E109CB3; Wed, 11 Jan 2023 15:37:41 +0300 (+03)
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
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until the first LAM user
Date:   Wed, 11 Jan 2023 15:37:27 +0300
Message-Id: <20230111123736.20025-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
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

Use static key to reduce untagged_addr() overhead.

The key only gets enabled when the first process enables LAM.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/uaccess.h | 8 ++++++--
 arch/x86/kernel/process_64.c   | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 32c9dd052e43..f9f85d596581 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -24,6 +24,8 @@ static inline bool pagefault_disabled(void);
 #endif
 
 #ifdef CONFIG_ADDRESS_MASKING
+DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
+
 /*
  * Mask out tag bits from the address.
  *
@@ -32,8 +34,10 @@ static inline bool pagefault_disabled(void);
  */
 #define __untagged_addr(untag_mask, addr)	({			\
 	u64 __addr = (__force u64)(addr);				\
-	s64 sign = (s64)__addr >> 63;					\
-	__addr &= untag_mask | sign;					\
+	if (static_branch_likely(&tagged_addr_key)) {			\
+		s64 sign = (s64)__addr >> 63;				\
+		__addr &= untag_mask | sign;				\
+	}								\
 	(__force __typeof__(addr))__addr;				\
 })
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 88aae519c8f8..1b41c60ebf6e 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -745,6 +745,9 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 
 #ifdef CONFIG_ADDRESS_MASKING
 
+DEFINE_STATIC_KEY_FALSE(tagged_addr_key);
+EXPORT_SYMBOL_GPL(tagged_addr_key);
+
 #define LAM_U57_BITS 6
 
 static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
@@ -781,6 +784,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 
 	mmap_write_unlock(mm);
 
+	static_branch_enable(&tagged_addr_key);
 	return 0;
 }
 #endif
-- 
2.38.2

