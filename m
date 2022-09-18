Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4769A5BBC62
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 10:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIRIB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 04:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIRIBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 04:01:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E5F25E8F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r62-20020a252b41000000b006af00577c42so18446655ybr.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=w/BQhND4xFeVh9dPIZ1hJXETNho1TtLdcQxdHsAZpjQ=;
        b=qjZvq0M5J5ZX9ESJ3Q/ODmhvcgA8qz3z3Bts6GoI5Ue+9979qh2HPC7KHXqe0TBTlA
         A0/GgVbuWcmTxdbhIdsiWpA+q2j9QsluNjBISUEBc8ETMPDvUiW2uV4AJHQjDqe/znFZ
         BdaVRkL2ZsjtqcfjrjZzvDkmgdyCbqpLlqEGJH7271vDvb/3gw0OYTpGkbnDYrQ9LAXl
         2Y5glVGaMxJY+sXrI7QwCJhCD1TfiabxI0piggFqApwrwLNjqH5jAgvClCXl9C0yQlig
         OeuWR1gX0o552s1QhtIUPn5dr4DxuA6XnjDvlVuRAhkwywKEqJJ7o6GcEqyBhDf8I7ox
         z0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=w/BQhND4xFeVh9dPIZ1hJXETNho1TtLdcQxdHsAZpjQ=;
        b=65bmHCqC0Jz9Y+n+Qymt8GBvo5LZq5JAgIDze46YC+E8k8VIDq4Ed2eZrOnv+a7e7X
         u75eIWyn3Z49/xng+BKClb/W3+76YOP5LUDAg6yFNjY1SddYkz06Zjhzt7Jls102O3z1
         9UDTwgYmDrMuQsPoZIh9OwO1ntzXtIvVjSwvsdmLrR0tI+6pf6PXg+3Q95cxj4pqzhLs
         /gMtYeZovBE+AkkW9gFja/VdAAGrVbK5b0yjQuGGyR+7vhFfygt4fWn+JCiUZ7+kq4p4
         /rc1r5AuHhG0nP3mTuHCHN0wYng9AX57BtpnTpIY+gMGVY/cjbk4/s4pTqsJz76zu0hA
         E4rA==
X-Gm-Message-State: ACrzQf0vi7GuLMe44xTXy6Zji3u02+0yQK8twPHwCoM69Nx3AM0MoIsv
        i5ZYCAuvMbt7BMHVI2fYTN1fLP0jGSE=
X-Google-Smtp-Source: AMsMyM6y6XunpwWz5KAhAH8K5fn3AZ0qXTpRZGN0F54SVImUgSS5I/Y1+n71h3opyybCL2W5fBCceE/kn7Q=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:c05a:2e99:29cd:d157])
 (user=yuzhao job=sendgmr) by 2002:a0d:d881:0:b0:349:241c:b164 with SMTP id
 a123-20020a0dd881000000b00349241cb164mr10965382ywe.372.1663488064047; Sun, 18
 Sep 2022 01:01:04 -0700 (PDT)
Date:   Sun, 18 Sep 2022 01:59:59 -0600
In-Reply-To: <20220918080010.2920238-1-yuzhao@google.com>
Message-Id: <20220918080010.2920238-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20220918080010.2920238-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Subject: [PATCH mm-unstable v15 02/14] mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>,
        Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures support the accessed bit in non-leaf PMD entries,
e.g., x86 sets the accessed bit in a non-leaf PMD entry when using it
as part of linear address translation [1]. Page table walkers that
clear the accessed bit may use this capability to reduce their search
space.

Note that:
1. Although an inline function is preferable, this capability is added
   as a configuration option for consistency with the existing macros.
2. Due to the little interest in other varieties, this capability was
   only tested on Intel and AMD CPUs.

Thanks to the following developers for their efforts [2][3].
  Randy Dunlap <rdunlap@infradead.org>
  Stephen Rothwell <sfr@canb.auug.org.au>

[1]: Intel 64 and IA-32 Architectures Software Developer's Manual
     Volume 3 (June 2021), section 4.8
[2] https://lore.kernel.org/r/bfdcc7c8-922f-61a9-aa15-7e7250f04af7@infradea=
d.org/
[3] https://lore.kernel.org/r/20220413151513.5a0d7a7e@canb.auug.org.au/

Signed-off-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Acked-by: Brian Geffon <bgeffon@google.com>
Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Acked-by: Steven Barrett <steven@liquorix.net>
Acked-by: Suleiman Souhlal <suleiman@google.com>
Tested-by: Daniel Byrne <djbyrne@mtu.edu>
Tested-by: Donald Carr <d@chaos-reins.com>
Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
Tested-by: Sofia Trinh <sofia.trinh@edi.works>
Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/Kconfig                   | 8 ++++++++
 arch/x86/Kconfig               | 1 +
 arch/x86/include/asm/pgtable.h | 3 ++-
 arch/x86/mm/pgtable.c          | 5 ++++-
 include/linux/pgtable.h        | 4 ++--
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 5dbf11a5ba4e..1c2599618eeb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1415,6 +1415,14 @@ config DYNAMIC_SIGFRAME
 config HAVE_ARCH_NODE_DEV_GROUP
 	bool
=20
+config ARCH_HAS_NONLEAF_PMD_YOUNG
+	bool
+	help
+	  Architectures that select this option are capable of setting the
+	  accessed bit in non-leaf PMD entries when using them as part of linear
+	  address translations. Page table walkers that clear the accessed bit
+	  may use this capability to reduce their search space.
+
 source "kernel/gcov/Kconfig"
=20
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..674d694a665e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,6 +85,7 @@ config X86
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_COPY_MC			if X86_64
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.=
h
index dc5f7d8ef68a..5059799bebe3 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -815,7 +815,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
=20
 static inline int pmd_bad(pmd_t pmd)
 {
-	return (pmd_flags(pmd) & ~_PAGE_USER) !=3D _KERNPG_TABLE;
+	return (pmd_flags(pmd) & ~(_PAGE_USER | _PAGE_ACCESSED)) !=3D
+	       (_KERNPG_TABLE & ~_PAGE_ACCESSED);
 }
=20
 static inline unsigned long pages_to_mb(unsigned long npg)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a932d7712d85..8525f2876fb4 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -550,7 +550,7 @@ int ptep_test_and_clear_young(struct vm_area_struct *vm=
a,
 	return ret;
 }
=20
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEA=
F_PMD_YOUNG)
 int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long addr, pmd_t *pmdp)
 {
@@ -562,6 +562,9 @@ int pmdp_test_and_clear_young(struct vm_area_struct *vm=
a,
=20
 	return ret;
 }
+#endif
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int pudp_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long addr, pud_t *pudp)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 375e8e7e64f4..a108b60a6962 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -213,7 +213,7 @@ static inline int ptep_test_and_clear_young(struct vm_a=
rea_struct *vma,
 #endif
=20
 #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEA=
F_PMD_YOUNG)
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
 					    pmd_t *pmdp)
@@ -234,7 +234,7 @@ static inline int pmdp_test_and_clear_young(struct vm_a=
rea_struct *vma,
 	BUILD_BUG();
 	return 0;
 }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=
 */
 #endif
=20
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
--=20
2.37.3.968.ga6b4b080e4-goog

