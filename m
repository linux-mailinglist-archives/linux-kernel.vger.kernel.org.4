Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF03B67A806
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjAYAzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjAYAzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:55:03 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A522B903F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:55:01 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 88so5314211pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QltKSpTGzf0W2SQSXFYMm7GCriu7mCw+n+d5pfVUmzI=;
        b=SztRo/gPi1DtM3PLDVXZHbb6GoWTRcTNOAOWMzjHK3/chfZSoCPdh0W6jNWnJ57BTP
         Wn12B6epK1ZGv8TrlkTddxdGUYThbooFXWFKI7CAWtIYTz8gS7m2K1bkOi+7L8jtwGWH
         +efWvGCE0QjbK0vPfkUDwWPvcSTmOdmWOa+SASdTeG+QvveQSMSkU654JPcu0RdIPMMe
         zn49Gx+gVgIwiXTeKfBnVr9veVFUOEHuj/07R/C/Ufm0nLB1lsxMnTzR+hje+0iZWq+m
         cjhydTDCT5/68GIm2ebCSo26R6ICjPHskKvQb+mqyrIJWmhQjU4QLavkBXTkpl64Hd/a
         2XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QltKSpTGzf0W2SQSXFYMm7GCriu7mCw+n+d5pfVUmzI=;
        b=KyOMMUj6+LfdU2T1I0hs+q+l0i6eLCE+Fq4MjXzwBpYf2JrhoL7gq1Z5XVXuHr+iVP
         NDfLmYNtxzWvQW97g1B6QpYODLgNfui5RWCqcnBTtVgQ40/7qoxr9szFKXXU7qO/zSzr
         us8IVng+WxmGdGowntPcfLY8zCoIFv8RK179CU0zm9IjU2lRefI/TSaLLMkgKZp3+k3M
         KXowu03LP2aqBSrkVyolMhFMemfZZHfsWHmPD1p8cUqvOAA2wKDQmDkSl8Vb8TurE1Zl
         dqywudsdlbHljVNoR/xpsLpMma2XmBjZZVSLK/RenYISh/gVxDjv10IdB3qg93jsdZ5o
         koQA==
X-Gm-Message-State: AFqh2kqTRntcmqDc+ZbXAhEGORiYc4mh7LJmCwn8UkMHAjMPcu7icCR2
        WpLLwhFiyqOpI2e201TmIrk=
X-Google-Smtp-Source: AMrXdXuXfVYQVgjb4y/wKuQ2GTtGHjovV/L4akvHfBhP3XbcVnLuPp7MBsPsK9n+tArlnPdUcTY5dg==
X-Received: by 2002:a05:6a20:3a83:b0:b6:5bde:3064 with SMTP id d3-20020a056a203a8300b000b65bde3064mr29899507pzh.16.1674608101144;
        Tue, 24 Jan 2023 16:55:01 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7797:cacf:485:8c8])
        by smtp.gmail.com with ESMTPSA id cq6-20020a17090af98600b0022bffc59164sm177272pjb.17.2023.01.24.16.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:55:00 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2] mm/madvise: add vmstat statistics for madvise_[cold|pageout]
Date:   Tue, 24 Jan 2023 16:54:57 -0800
Message-Id: <20230125005457.4139289-1-minchan@kernel.org>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
shows the proactive reclaim efficiency so this patch adds those
two statistics in vmstat.

	madvise_pgscanned, madvise_pghinted

Since proactive reclaim using process_madvise(2) as userland
memory policy is popular(e.g,. Android ActivityManagerService),
those stats are helpful to know how efficiently the policy works
well.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---

* From v1 - https://lore.kernel.org/linux-mm/20230117231632.2734737-1-minchan@kernel.org/
  * not relying on the pageout for accounting - mhocko
  * drop unnecessary changes - mhocko
  
 include/linux/vm_event_item.h | 2 ++
 mm/madvise.c                  | 8 ++++++++
 mm/vmstat.c                   | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 7f5d1caf5890..3c117858946d 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -52,6 +52,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGSCAN_FILE,
 		PGSTEAL_ANON,
 		PGSTEAL_FILE,
+		MADVISE_PGSCANNED,
+		MADVISE_PGHINTED,
 #ifdef CONFIG_NUMA
 		PGSCAN_ZONE_RECLAIM_FAILED,
 #endif
diff --git a/mm/madvise.c b/mm/madvise.c
index 7db6622f8293..d2624e77f729 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -344,6 +344,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	spinlock_t *ptl;
 	struct folio *folio = NULL;
 	LIST_HEAD(folio_list);
+	unsigned int nr_scanned = 0;
+	unsigned int nr_hinted = 0;
 	bool pageout_anon_only_filter;
 
 	if (fatal_signal_pending(current))
@@ -357,6 +359,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		pmd_t orig_pmd;
 		unsigned long next = pmd_addr_end(addr, end);
 
+		nr_scanned += HPAGE_PMD_NR;
 		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
 		ptl = pmd_trans_huge_lock(pmd, vma);
 		if (!ptl)
@@ -414,6 +417,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			}
 		} else
 			folio_deactivate(folio);
+		nr_hinted += HPAGE_PMD_NR;
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
@@ -431,6 +435,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	arch_enter_lazy_mmu_mode();
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
+		nr_scanned++;
 
 		if (pte_none(ptent))
 			continue;
@@ -508,6 +513,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			}
 		} else
 			folio_deactivate(folio);
+		nr_hinted++;
 	}
 
 	arch_leave_lazy_mmu_mode();
@@ -515,6 +521,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	if (pageout)
 		reclaim_pages(&folio_list);
 	cond_resched();
+	count_vm_events(MADVISE_PGSCANNED, nr_scanned);
+	count_vm_events(MADVISE_PGHINTED, nr_hinted);
 
 	return 0;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1ea6a5ce1c41..84acc90820e1 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1283,6 +1283,8 @@ const char * const vmstat_text[] = {
 	"pgscan_file",
 	"pgsteal_anon",
 	"pgsteal_file",
+	"madvise_pgscanned",
+	"madvise_pghinted",
 
 #ifdef CONFIG_NUMA
 	"zone_reclaim_failed",
-- 
2.39.1.405.gd4c25cc71f-goog

