Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB2F670E55
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjARAEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjARAD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:03:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44BEBC8BC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:16:42 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y3-20020a17090a390300b00229add7bb36so423268pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMrwqounr0oUuG21W3XQfHvNf7os8CE1mar5f82JgxI=;
        b=pS/gUVrldsYuEvQWJem29eVikSvSY6AeGUnyAPPRx6JDLPalLF60OpyhtfbbhHVVNM
         blAGDRem/RXiBLYfhuMkVXlzQoEevYfTJApvZpXgxChB0zanFmX4sQTTir8d8RU7VdnS
         5etir+xvETOpNvcIV9bzFP2EgZAASyCC2oVNPvv2pyP3VQB+zJ2eOPbHDGk9+TlUNMV+
         f01T0BGb5Ozy++CKL4jWy5zgrnLZasNM3iqlSlU8yqlG08r7PqBbBHHQs2LU8plQM83n
         vdvOozKeSEhUDGgoZk0NuVQgif0pLhdH2EwrlcSLqO2NbFyZr5bBJ4WlwhLAcHJPGLkO
         cW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMrwqounr0oUuG21W3XQfHvNf7os8CE1mar5f82JgxI=;
        b=FyQAiGa3zC2gPZVsa5YHBd7DYOS/c6tbajDVpM1MTGpXFtEi0WeNirfBZ0brZdfXKy
         Qv6uZAi03F/WyJ9GVADO4Cwl8wteadoZxg8ifgQMZlxtQ4HsJXGx8sBuN6W6/o2cZ2FQ
         qAawAA+QSiTL7HOc+BV0Lt61T4nDwkDjWImD0x3kQ51cNDcqXZf89kPnTYQFKT7KvBpK
         cs6bJxw4tc0VnjnpfDbYwJAcXjumkYPZJeDtZHdepIQy7rxOJA+Ze9ADRnheppIw19/R
         uiWTF1A5rizlbFRuDzBricYSmToxveKjrTB2hWSXNZTcH2j1RzkvtLpINKR+NdGVVtVF
         0w5Q==
X-Gm-Message-State: AFqh2ko7fMoKvyMTrBcbPovuVzLREK0i9gCA6sWN8Iw9GIwGoRxmw6IW
        2nxdxgBm1eZl7mhEcxjwtKY=
X-Google-Smtp-Source: AMrXdXvqtSKvPavOcMP4zOcjlEw09DB95at5PzXmZy3YQqaMHkTZhaqtBL/dDhIgMMCEEiBr3o9T/A==
X-Received: by 2002:a05:6a20:4e26:b0:b8:a148:63b5 with SMTP id gk38-20020a056a204e2600b000b8a14863b5mr4792999pzb.3.1673997401048;
        Tue, 17 Jan 2023 15:16:41 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:27ce:97b5:ee13:dbfe])
        by smtp.gmail.com with ESMTPSA id c24-20020aa79538000000b0057447bb0ddcsm5180965pfp.49.2023.01.17.15.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 15:16:40 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 3/3] mm: add vmstat statistics for madvise_[cold|pageout]
Date:   Tue, 17 Jan 2023 15:16:32 -0800
Message-Id: <20230117231632.2734737-3-minchan@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230117231632.2734737-1-minchan@kernel.org>
References: <20230117231632.2734737-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

madvise LRU manipulation APIs need to scan address ranges to find
present pages at page table and provides advice hints for them.

Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
shows the proactive reclaim efficiency so this patch addes those
two statistics in vmstat.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/vm_event_item.h |  2 ++
 mm/madvise.c                  | 19 +++++++++++++++----
 mm/vmstat.c                   |  2 ++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 3518dba1e02f..8b9fb2e151eb 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -49,6 +49,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGSCAN_FILE,
 		PGSTEAL_ANON,
 		PGSTEAL_FILE,
+		MADVISE_PGSCANNED,
+		MADVISE_PGHINTED,
 #ifdef CONFIG_NUMA
 		PGSCAN_ZONE_RECLAIM_FAILED,
 #endif
diff --git a/mm/madvise.c b/mm/madvise.c
index a4a03054ab6b..0e58545ff6e9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -334,6 +334,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	spinlock_t *ptl;
 	struct page *page = NULL;
 	LIST_HEAD(page_list);
+	unsigned int nr_scanned = 0;
+	unsigned int nr_hinted = 0;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -343,6 +345,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		pmd_t orig_pmd;
 		unsigned long next = pmd_addr_end(addr, end);
 
+		nr_scanned += HPAGE_PMD_NR
 		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
 		ptl = pmd_trans_huge_lock(pmd, vma);
 		if (!ptl)
@@ -396,11 +399,15 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					list_add(&page->lru, &page_list);
 			}
 		} else
-			deactivate_page(page);
+			if (deactivate_page(page))
+				nr_hinted += HPAGE_PMD_NR;
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
-			paging_out(&page_list);
+			nr_hinted += paging_out(&page_list);
+
+		count_vm_events(MADVISE_PGSCANNED, nr_scanned);
+		count_vm_events(MADVISE_PGHINTED, nr_hinted);
 		return 0;
 	}
 
@@ -414,6 +421,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	arch_enter_lazy_mmu_mode();
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
+		nr_scanned++;
 
 		if (pte_none(ptent))
 			continue;
@@ -485,14 +493,17 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					list_add(&page->lru, &page_list);
 			}
 		} else
-			deactivate_page(page);
+			if (deactivate_page(page))
+				nr_hinted++;
 	}
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
 	if (pageout)
-		paging_out(&page_list);
+		nr_hinted += paging_out(&page_list);
 	cond_resched();
+	count_vm_events(MADVISE_PGSCANNED, nr_scanned);
+	count_vm_events(MADVISE_PGHINTED, nr_hinted);
 
 	return 0;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b2371d745e00..0139feade854 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1280,6 +1280,8 @@ const char * const vmstat_text[] = {
 	"pgscan_file",
 	"pgsteal_anon",
 	"pgsteal_file",
+	"madvise_pgscanned",
+	"madvise_pghinted",
 
 #ifdef CONFIG_NUMA
 	"zone_reclaim_failed",
-- 
2.39.0.314.g84b9a713c41-goog

