Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB7651B98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiLTH0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiLTHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:25:48 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EF26146
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s196so7792778pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcdvTJSUQptFc3AVHk0e+fX/02wn2fKXzabvFygcaXg=;
        b=eM2vnsugEhx9Fxi3d/0pz8nOmWBqT6WOzDrbW2LhnZvHmhw0chNBsYkvjN9VHvsJoE
         XDGGsi1BW5fvDjyFKw5DRpVKmd/q1UNAs2X7gpQCPCeM5unfWrK8STQMKuqo5m+tn9go
         0+vnQSFdH2xF64ozR84c/+1qjLCTk8g3LGNK1HF4gauRIInyVcbu4uDtltrrzuP7hpYL
         6xnBk5U0Sod8Q3OjEmpZwHe0xKZeNbnQo8Oosk8YJ3s0R8xbrKHj8svVdgtzpBKrYvC+
         VkfDBibWFHr5ZAjwx+ekYkHpMvMzJNRc7L7rEtQKsT6YkAzjevQWGv8xW9Fmrvl9nbQC
         m0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcdvTJSUQptFc3AVHk0e+fX/02wn2fKXzabvFygcaXg=;
        b=u8IQ7ScBU/5UTwWjO31Vaa2tymI7En2WWsJKGrcu4PBIWH4IrIIhLohFmcqbOC1WOf
         U7VI2brV0SdXIGeKRv7fHAI2eJWC3VfH9ZFMmq6hETnOf33kZ5zPhXUUfe/JilG8QuPr
         mYRO+UAy2uqf91fdp4kV91B7/9tvHbAMKKOTdIRe8Vi3HWqurL5CIpxHsXEBDzmYvmqT
         VbYMyWwWcOAyhyRzdQecMSUXpcZfbgb8Et40PYMgLnMgiQpaPtSzA8z5+nTyfHNdy6s2
         O73RY6T6MxT5CYFnn/aD7SfbSXBWEx9H3qwh3KFHyHkXYSIOJGWLDcD2DlMznCSLNXQS
         aHQg==
X-Gm-Message-State: ANoB5pl0T4mRGMbR2i5nKgIz4957Ak7Hl0MVz6xqh8Ja2hhguqFOBhwf
        EeaQK6YUDHXVx1h6KzlcApU=
X-Google-Smtp-Source: AA0mqf58qBYe4mGrS2Ei5/k0QEHKSaSFh9E15Ikmi+osvtgPbnlSPrbtQehqB3CGfj1ZyaecavszbA==
X-Received: by 2002:aa7:814f:0:b0:56c:232e:3b00 with SMTP id d15-20020aa7814f000000b0056c232e3b00mr41607310pfn.7.1671521147136;
        Mon, 19 Dec 2022 23:25:47 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:25:46 -0800 (PST)
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
Subject: [PATCH v3 05/14] mm/khugepaged: Break COW PTE before scanning pte
Date:   Tue, 20 Dec 2022 15:27:34 +0800
Message-Id: <20221220072743.3039060-6-shiyn.lin@gmail.com>
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

We should not allow THP to collapse COW-ed PTE. So, break COW PTE
before collapse_pte_mapped_thp() collapse to THP. Also, break COW
PTE before khugepaged_scan_pmd() scan PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/trace/events/huge_memory.h |  1 +
 mm/khugepaged.c                    | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 760455dfa8600..881553aa0f2f2 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -13,6 +13,7 @@
 	EM( SCAN_PMD_NULL,		"pmd_null")			\
 	EM( SCAN_PMD_NONE,		"pmd_none")			\
 	EM( SCAN_PMD_MAPPED,		"page_pmd_mapped")		\
+	EM( SCAN_COW_PTE,		"cowed_pte")			\
 	EM( SCAN_EXCEED_NONE_PTE,	"exceed_none_pte")		\
 	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
 	EM( SCAN_EXCEED_SHARED_PTE,	"exceed_shared_pte")		\
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a8d5ef2a77d24..106e1ce3931f7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -31,6 +31,7 @@ enum scan_result {
 	SCAN_PMD_NULL,
 	SCAN_PMD_NONE,
 	SCAN_PMD_MAPPED,
+	SCAN_COW_PTE,
 	SCAN_EXCEED_NONE_PTE,
 	SCAN_EXCEED_SWAP_PTE,
 	SCAN_EXCEED_SHARED_PTE,
@@ -1030,6 +1031,9 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 
+	/* We should already handled COW-ed PTE. */
+	VM_WARN_ON(test_bit(MMF_COW_PTE, &mm->flags) && !pmd_write(*pmd));
+
 	anon_vma_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
@@ -1139,6 +1143,16 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
+
+	/*
+	 * Before we scan each pte entry, we should first check PTE
+	 * could be modified. So, we break COW if PTE is COW-ed.
+	 */
+	if (break_cow_pte(vma, pmd, address) < 0) {
+		result = SCAN_COW_PTE;
+		goto out;
+	}
+
 	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
 	for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, _address += PAGE_SIZE) {
@@ -1197,6 +1211,10 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 			goto out_unmap;
 		}
 
+		/*
+		 * If we only trigger the break COW PTE, the page usually
+		 * still in COW mapping, which it still be shared.
+		 */
 		if (page_mapcount(page) > 1) {
 			++shared;
 			if (cc->is_khugepaged &&
@@ -1472,6 +1490,11 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto drop_hpage;
 	}
 
+	/* We shouldn't let COW-ed PTE collapse. */
+	if (break_cow_pte(vma, pmd, haddr) < 0)
+		goto drop_hpage;
+	VM_WARN_ON(test_bit(MMF_COW_PTE, &mm->flags) && !pmd_write(*pmd));
+
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
 	result = SCAN_FAIL;
 
-- 
2.37.3

