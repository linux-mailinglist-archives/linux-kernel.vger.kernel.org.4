Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448B4651B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiLTH04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiLTH0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:26:07 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5D2B491
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:04 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q71so7773139pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qeG6PpkfzCDCCR2FoWrTPHP2/xjfirILLn+aFk9hwU=;
        b=kxywGUZZeAuKFns3+pAcT6BLDXR+/Kz44ORCc9msg+h0jxLyHCxe0TVfC51CCemZiw
         lPK0mCZDKx2zNcxYQh15+8mErgYabTVvmXneeJbCUW7tTxoe8MZFNs+a3Ct9gkvam6G3
         zViHBUPs7vX9GhKjdG/guIzrg+nppnH01Y7h5jt+0NKDrn8vAFPoUQsBP6vsmy7ruptW
         2FohIsekZhDiWBPnI91e6jfyZYlAj0OpOaCEYL4Yr5HyN0g9UySXS/bVGVn30RwhUCZ7
         vKbq4lJxlog20ykfCsbI7ibllD957ydpe1NRTNKsUPqsdXVY+RS54QMXgP9wNeNT2y0D
         By/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qeG6PpkfzCDCCR2FoWrTPHP2/xjfirILLn+aFk9hwU=;
        b=ox465yDv/TCqGJeUPPH60lRPjq5Cmp5ILyv+MyxmuoTgglAA8UdN2azdsqwITJ/QBh
         ZI0WRQuILcIkpe2cIICKbJZFl7R9+E5hpedmSOt635LdDTAZXVV4kMflSSOIcKKAXX+N
         YpTlMrSLfoj/Xhl+qe12znb5MRTbYDQEUhcQSI8hNeaRMO6szFpOJj+CWrxtTBp6W0+r
         d/CBEbGKoEoBGlYv3Mv5aGVN1wQOg5TO76vuJRCSLBhO3j7TMav/DKm+DM4WtZ84CwwE
         FRkghMAikx7SJLdozXcnj6YYP9Xu7KEf1IjSOMmfNWWQqehnf6F3/moqWadTZQye6PgH
         aLeg==
X-Gm-Message-State: ANoB5pnsCyczxzf1hj5i+xuQLY+eSzvBgkKZF45G6zJMb4t8+QJ1Y68X
        IA7JICJdcKZsdvbQez8/44k=
X-Google-Smtp-Source: AA0mqf55kHPKQwj+Olza1S2CIKLn4EriHod9gAjefV9IM3bc3ZIZf34hXZGOaqVw0YtOQTGKdsoWyA==
X-Received: by 2002:aa7:911a:0:b0:577:5afa:6321 with SMTP id 26-20020aa7911a000000b005775afa6321mr49726979pfh.26.1671521164189;
        Mon, 19 Dec 2022 23:26:04 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:26:03 -0800 (PST)
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
Subject: [PATCH v3 07/14] mm/madvise: Handle COW-ed PTE with madvise()
Date:   Tue, 20 Dec 2022 15:27:36 +0800
Message-Id: <20221220072743.3039060-8-shiyn.lin@gmail.com>
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

Break COW PTE if madvise() modify the pte entry of COW-ed PTE.
Following are the list of flags which need to break COW PTE. However,
like MADV_HUGEPAGE and MADV_MERGEABLE, we should handle it respectively.

- MADV_DONTNEED: It calls to zap_page_range() which already be handled.
- MADV_FREE: It uses walk_page_range() with madvise_free_pte_range() to
	     free the page by itself, so add break_cow_pte().
- MADV_REMOVE: Same as MADV_FREE, it remove the page by itself, so add
	       break_cow_pte_range().
- MADV_COLD: Similar to MAD_FREE, break COW PTE before pageout.
- MADV_POPULATE: Let GUP deal with it.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/madvise.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index c7105ec6d08c0..58bccec7caa88 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -408,6 +408,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 #endif
+	if (break_cow_pte(vma, pmd, addr) < 0)
+		return 0;
+
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	flush_tlb_batched_pending(mm);
@@ -614,6 +617,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
+	/* We should only allocate PTE. */
+	if (break_cow_pte(vma, pmd, addr) < 0)
+		goto next;
+
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	flush_tlb_batched_pending(mm);
@@ -974,6 +981,12 @@ static long madvise_remove(struct vm_area_struct *vma,
 	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
 		return -EACCES;
 
+	error = break_cow_pte_range(vma, start, end);
+	if (error < 0)
+		return error;
+	else if (error > 0)
+		return -ENOMEM;
+
 	offset = (loff_t)(start - vma->vm_start)
 			+ ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 
-- 
2.37.3

