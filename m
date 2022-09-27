Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788895EC97B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiI0Q2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiI0Q2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:28:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490D41D66E6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:28:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d82so10121440pfd.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XuRjx7DiMyFErohU6l5P8iRkgXDYC8Q+F8gmrtJ+ilo=;
        b=BUZqiRpZc+y9cuKG56oBy+Cfa11WNSqYjMXnosAmPhlk/lSKqYHn4hBSpj/jIf58w5
         I9qqOV/xm+s71mwq9zjCCSYffCPx9a50VMkrfSsqXCK+mN/b4e6hEOlKOolaJUTLxIqC
         VwRC3b9iS7HmqV77y7pGxVVKSrzAOhQgEcl/7dch2nR+pKj1CxC+vlFOZChPdDepcxnv
         UFDQMokXHNYITZHeIoOXNkO4NIDhzmsx66zSvT78H/d0eIndhhGEjIwAVklKSYQZiD/V
         6H7xjsp1lbsiNpMH3hkT8bqlX2SYf2GrGg3f8YRsP/r9wEive/ykWyXiTUmWSniup8Hj
         W8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XuRjx7DiMyFErohU6l5P8iRkgXDYC8Q+F8gmrtJ+ilo=;
        b=wTTcOwfVJsgAbqv4d1S3rJKGtyiHZrV7ip4PkOU0BGXImBJZt0xuxM8QbL+iB9ueyu
         44RMxPrgUs6YGxERZAAUgYPdyUloTnVKr3jHlBncm+5r8BX8yuKC2cX3J9MAF54aTXSf
         DFgWrL/FDgdYs5ycPGJA9Tai+VogjH8blDF2qvLUGy1Q5LSEjnuRoAZC6Y/BueQ5QCbx
         HDgNHKeJ+kRYdcxXxEVrIrqE6JDWz7ZSLkxxf+VNUYZhzbvl2kHN2CYyCJRmoEgatgIM
         7UGJFiSO5gnCNdRZz0eCJL+XfXFPG7tAfsLEXiRY6NQiNZaEOoch9njLdEiEy9X4W596
         IoRw==
X-Gm-Message-State: ACrzQf3AR/ADlO0oVVY9YToVxjpKRyPbwrvN2UPpqIZpwYeSTb12ysu7
        UDrvTqavJxdfQqlNuc9vGfc=
X-Google-Smtp-Source: AMsMyM4GbFT0PuBeQyFV0l8Zleho1UdvgIIpjeUqz6KjGWEv03YsI5DcOCows8rB9mxqR/VT7zNmkg==
X-Received: by 2002:a05:6a00:1253:b0:546:3d50:3284 with SMTP id u19-20020a056a00125300b005463d503284mr29961879pfi.72.1664296083652;
        Tue, 27 Sep 2022 09:28:03 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id 9-20020a17090a0f0900b001f333fab3d6sm8602360pjy.18.2022.09.27.09.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:28:02 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>, Nadav Amit <namit@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [RFC PATCH v2 5/9] mm, pgtable: Add a refcount to PTE table
Date:   Wed, 28 Sep 2022 00:29:53 +0800
Message-Id: <20220927162957.270460-6-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927162957.270460-1-shiyn.lin@gmail.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the _refcount in struct page for the page table to maintain the
number of process references to COWed PTE table. Before decreasing the
refcount, it will check whether refcount is one or not for reusing
shared PTE table.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/mm.h      |  1 +
 include/linux/pgtable.h | 28 ++++++++++++++++++++++++++++
 mm/memory.c             |  1 +
 3 files changed, 30 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 965523dcca3b8..bfe6a8c7ab9ed 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2290,6 +2290,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
 	page->cow_pte_owner = NULL;
+	set_page_count(page, 1);
 	return true;
 }
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 25c1e5c42fdf3..8b497d7d800ed 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -9,6 +9,7 @@
 #ifdef CONFIG_MMU
 
 #include <linux/mm_types.h>
+#include <linux/page_ref.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
 #include <asm-generic/pgtable_uffd.h>
@@ -628,6 +629,33 @@ static inline bool cow_pte_owner_is_same(pmd_t *pmd, pmd_t *owner)
 	return smp_load_acquire(&pmd_page(*pmd)->cow_pte_owner) == owner;
 }
 
+static inline int pmd_get_pte(pmd_t *pmd)
+{
+	return page_ref_inc_return(pmd_page(*pmd));
+}
+
+/*
+ * If the COW PTE refcount is 1, instead of decreasing the counter,
+ * clear write protection of the corresponding PMD entry and reset
+ * the COW PTE owner to reuse the table.
+ * But if the reuse parameter is false, do not thing. This help us
+ * to handle the situation that PTE table we already handled.
+ */
+static inline int pmd_put_pte(struct vm_area_struct *vma, pmd_t *pmd,
+			      unsigned long addr, bool reuse)
+{
+	if (!page_ref_add_unless(pmd_page(*pmd), -1, 1) && reuse) {
+		cow_pte_fallback(vma, pmd, addr);
+		return 1;
+	}
+	return 0;
+}
+
+static inline int cow_pte_count(pmd_t *pmd)
+{
+	return page_count(pmd_page(*pmd));
+}
+
 #ifndef pte_access_permitted
 #define pte_access_permitted(pte, write) \
 	(pte_present(pte) && (!(write) || pte_write(pte)))
diff --git a/mm/memory.c b/mm/memory.c
index d29f84801f3cd..3e66e229f4169 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2875,6 +2875,7 @@ void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
 	pmd_t new;
 
 	VM_WARN_ON(pmd_write(*pmd));
+	VM_WARN_ON(cow_pte_count(pmd) != 1);
 
 	start = addr & PMD_MASK;
 	end = (addr + PMD_SIZE) & PMD_MASK;
-- 
2.37.3

