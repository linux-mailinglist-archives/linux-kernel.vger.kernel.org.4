Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD0651B97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiLTH0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiLTHZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:25:42 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF10CD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:39 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x66so7935205pfx.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw94Wcad60kQlYesoGk9k3xA8YOcC6tDHrdqJDeUZPo=;
        b=lOCNCFWA/meHRThX8tIrSKBWtWjAtAFAyTPKlIuo8gru7rOJ1Pvq2cOSUhJWnYwZAG
         NA4typtr3ombOUIegnjNrJMPy96dI39GU/kqXDwBXKU6O6AZrdab21FuHKwTV50WR0AG
         DEWXzS5FvL9qGjCBlJcEYZ+pdC06SWcoxwGgj/LBSrItS/fBZkzEC2WclkyQvniUVxMN
         pYUGvbHtTMOF3+JJTaKVVd2J1V50tbGsShfgdJlCHyJYHvApYGLQ/g0u9YMsoJJYi88C
         xlznrMzHPtlQTh0YLGf3btaJN5LXFvogN1OrDAIhPXGVH9zQPZMJGSIUnnRAiz3kxzU5
         JoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nw94Wcad60kQlYesoGk9k3xA8YOcC6tDHrdqJDeUZPo=;
        b=eJDYTlYwPFRpGyhdIPf2GB8c86orND2PXIi5nj7WV8WzdikSZ8MVm4/KnAknh6YTqP
         /jTwko8D4f9J+PtJzfdW2hoCKfQb1aHcGojowGcRNka/hxd7H6A6WZlJ7IgAbjpvWq5x
         iw/pQfpdHIethOMsbEgcZj6mVUbtMUEqU/StAedVfYCz2xGrEScPwRzyHOvarNEebqoC
         BYhLL1S/pCZbuH4P6LIEkH3LoSDaPeZFPj+DQJ2SRIm7qi6dO409FMhory2V2AgAGQux
         7HEqj9gVji3K9WMgpIIYh65mgAd8lv9lja5JK44PKzMDshmXG4JEcH1VfFZEkqTC/lXv
         hpXA==
X-Gm-Message-State: ANoB5pk6/Nf9kefI1L8Txa7cQNPYrfYWYRj2w3V9aALwUzs5fN/I/rh6
        TdK0Q9zitYlLRti/c9gElZM=
X-Google-Smtp-Source: AA0mqf7n84R2otGmDntmZWp0jMee4xwTkCP+PYpGZJXN4hyRsMyg3xqv9rZ8VL6h/5SY66ibtNHinQ==
X-Received: by 2002:aa7:87c3:0:b0:577:1857:57fa with SMTP id i3-20020aa787c3000000b00577185757famr43877192pfo.18.1671521138524;
        Mon, 19 Dec 2022 23:25:38 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:25:37 -0800 (PST)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Zach O'Keefe <zokeefe@google.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Barry Song <baohua@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Brian Geffon <bgeffon@google.com>, Yu Zhao <yuzhao@google.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Barret Rhoden <brho@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH v3 04/14] mm/rmap: Break COW PTE in rmap walking
Date:   Tue, 20 Dec 2022 15:27:33 +0800
Message-Id: <20221220072743.3039060-5-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221220072743.3039060-1-shiyn.lin@gmail.com>
References: <20221220072743.3039060-1-shiyn.lin@gmail.com>
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

Some of the features (unmap, migrate, device exclusive, mkclean, etc)
might modify the pte entry via rmap. Add a new page vma mapped walk
flag, PVMW_BREAK_COW_PTE, to indicate the rmap walking to break COW PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/rmap.h |  2 ++
 mm/migrate.c         |  3 ++-
 mm/page_vma_mapped.c |  2 ++
 mm/rmap.c            | 12 +++++++-----
 mm/vmscan.c          |  7 ++++++-
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index bd3504d11b155..d0f07e5519736 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -368,6 +368,8 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 #define PVMW_SYNC		(1 << 0)
 /* Look for migration entries rather than present PTEs */
 #define PVMW_MIGRATION		(1 << 1)
+/* Break COW-ed PTE during walking */
+#define PVMW_BREAK_COW_PTE	(1 << 2)
 
 struct page_vma_mapped_walk {
 	unsigned long pfn;
diff --git a/mm/migrate.c b/mm/migrate.c
index dff333593a8ae..a4be7e04c9b09 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -174,7 +174,8 @@ void putback_movable_pages(struct list_head *l)
 static bool remove_migration_pte(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr, void *old)
 {
-	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
+	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr,
+			      PVMW_SYNC | PVMW_MIGRATION | PVMW_BREAK_COW_PTE);
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 93e13fc17d3cb..5dfc9236dc505 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -251,6 +251,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
+		if (pvmw->flags & PVMW_BREAK_COW_PTE)
+			break_cow_pte(vma, pvmw->pmd, pvmw->address);
 		if (!map_pte(pvmw))
 			goto next_pte;
 this_pte:
diff --git a/mm/rmap.c b/mm/rmap.c
index 2ec925e5fa6a9..b1b7dcbd498be 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -807,7 +807,8 @@ static bool folio_referenced_one(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long address, void *arg)
 {
 	struct folio_referenced_arg *pra = arg;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	/* it will clear the entry, so we should break COW PTE. */
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
 	int referenced = 0;
 
 	while (page_vma_mapped_walk(&pvmw)) {
@@ -1012,7 +1013,8 @@ static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 			     unsigned long address, void *arg)
 {
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_SYNC);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address,
+			      PVMW_SYNC | PVMW_BREAK_COW_PTE);
 	int *cleaned = arg;
 
 	*cleaned += page_vma_mkclean_one(&pvmw);
@@ -1471,7 +1473,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
 	pte_t pteval;
 	struct page *subpage;
 	bool anon_exclusive, ret = true;
@@ -1842,7 +1844,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
 	pte_t pteval;
 	struct page *subpage;
 	bool anon_exclusive, ret = true;
@@ -2195,7 +2197,7 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long address, void *priv)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
 	struct make_exclusive_args *args = priv;
 	pte_t pteval;
 	struct page *subpage;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 026199c047e0e..980d2056adfd1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1781,6 +1781,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			}
 		}
 
+		/*
+		 * Break COW PTE since checking the reference
+		 * of folio might modify the PTE.
+		 */
 		if (!ignore_references)
 			references = folio_check_references(folio, sc);
 
@@ -1864,7 +1868,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 		/*
 		 * The folio is mapped into the page tables of one or more
-		 * processes. Try to unmap it here.
+		 * processes. Try to unmap it here. Also, since it will write
+		 * to the page tables, break COW PTE if they are.
 		 */
 		if (folio_mapped(folio)) {
 			enum ttu_flags flags = TTU_BATCH_FLUSH;
-- 
2.37.3

