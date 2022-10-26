Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C7860E6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiJZSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiJZSBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:01:37 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05359A0333
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:01:35 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id bb5so10511707qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=klV8RzaV/QSYOpMVWproVjBI7E4u+D4eP4WiGrNP5MI=;
        b=a+3V2M2GT9OhnUH5fcX//TLSqzcIWrTfhAjqGnSnLGAhiZxpP03UUVy8DHw60QRVsA
         aYg6ggXSSoP7nFwzKmNBD5reGVj8GvmKwvL1N96vBuUapQ+j7NNXcqaIfooxUrc8KJQg
         GRD5WjESJBhCc7qCbkJTYWHgE1NgoPzd1datHPvLUFU3sduEpGuDDTQjPNC0C+KpAx/g
         9LRiTbp4rZkO90C/wTqBcEMTa64qLQGCxZNHn7o3VBF3E1uGIJTKZ+C/md/hJ0U8u0fD
         ih8s5dcwgrWsu0PHQGASPWaGm+xt9sHBGJM3t/LDoTLM/NL953U6qxWB3qcWp8uvNnGn
         bMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=klV8RzaV/QSYOpMVWproVjBI7E4u+D4eP4WiGrNP5MI=;
        b=Cn29FBo23MByEitgcBvZxkdpOAZUHPyuuEYbiT4+I6fdsniYJhcySrTWJR+wZ5js5q
         35dadF/QsGsJ6a/GHkB0jOTF7cXmrPm0iAZpJkRieXvu8TJHYqv5wj/b7RqN3q1E9/To
         RTMv6QrMc6BUD8rg97hDSRc+Z63XGdscDs4X+BBJBGgsxBWkyEYutwvp9vJ8tv5AE7mJ
         t/8CIEW2LmdbgripFny47Tfa7Ww8FCBzCKAyszVADonyLTyEsLQ0H1iUgfwRZzBa9Y85
         dAJe51jqQdGdcjwYFWlUF5hnUy2HkY58HHnSlcqtebL286utgQS9HgDzCWOFlfU3q/ZS
         opCQ==
X-Gm-Message-State: ACrzQf0GaUOP9HIcWoCTSq35SuhdFu2vYYUMmeIT/pGke0UjE9va7NYA
        AYzFrjvSiXJIOah7Cpin9qEobzM7dz8sKw==
X-Google-Smtp-Source: AMsMyM7bAtNmx1jsUmP6nbHmg+jOd/twPQEEnuSbvM6tfX1QoSCCSyFdU1hNDwhPMsuudfb6GyoO/Q==
X-Received: by 2002:a05:622a:64e:b0:39c:f167:a5f6 with SMTP id a14-20020a05622a064e00b0039cf167a5f6mr37366597qtb.430.1666807293601;
        Wed, 26 Oct 2022 11:01:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id cn13-20020a05622a248d00b003a4cda52c95sm2169952qtb.63.2022.10.26.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:01:33 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Subject: [PATCH v2] mm: vmscan: split khugepaged stats from direct reclaim stats
Date:   Wed, 26 Oct 2022 14:01:33 -0400
Message-Id: <20221026180133.377671-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct reclaim stats are useful for identifying a potential source for
application latency, as well as spotting issues with kswapd. However,
khugepaged currently distorts the picture: as a kernel thread it
doesn't impose allocation latencies on userspace, and it explicitly
opts out of kswapd reclaim. Its activity showing up in the direct
reclaim stats is misleading. Counting it as kswapd reclaim could also
cause confusion when trying to understand actual kswapd behavior.

Break out khugepaged from the direct reclaim counters into new
pgsteal_khugepaged, pgdemote_khugepaged, pgscan_khugepaged counters.

Test with a huge executable (CONFIG_READ_ONLY_THP_FOR_FS):

pgsteal_kswapd 1342185
pgsteal_direct 0
pgsteal_khugepaged 3623
pgscan_kswapd 1345025
pgscan_direct 0
pgscan_khugepaged 3623

Reported-by: Eric Bergen <ebergen@meta.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  6 +++++
 include/linux/khugepaged.h              |  6 +++++
 include/linux/vm_event_item.h           |  3 +++
 mm/khugepaged.c                         |  5 ++++
 mm/memcontrol.c                         |  8 +++++--
 mm/vmscan.c                             | 32 ++++++++++++++++++-------
 mm/vmstat.c                             |  3 +++
 7 files changed, 53 insertions(+), 10 deletions(-)

v2: reclaimer_offset(): magic -> muggle (Willy)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index dc254a3cb956..74cec76be9f2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1488,12 +1488,18 @@ PAGE_SIZE multiple when read back.
 	  pgscan_direct (npn)
 		Amount of scanned pages directly  (in an inactive LRU list)
 
+	  pgscan_khugepaged (npn)
+		Amount of scanned pages by khugepaged  (in an inactive LRU list)
+
 	  pgsteal_kswapd (npn)
 		Amount of reclaimed pages by kswapd
 
 	  pgsteal_direct (npn)
 		Amount of reclaimed pages directly
 
+	  pgsteal_khugepaged (npn)
+		Amount of reclaimed pages by khugepaged
+
 	  pgfault (npn)
 		Total number of page faults incurred
 
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 70162d707caf..f68865e19b0b 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -15,6 +15,7 @@ extern void __khugepaged_exit(struct mm_struct *mm);
 extern void khugepaged_enter_vma(struct vm_area_struct *vma,
 				 unsigned long vm_flags);
 extern void khugepaged_min_free_kbytes_update(void);
+extern bool current_is_khugepaged(void);
 #ifdef CONFIG_SHMEM
 extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 				   bool install_pmd);
@@ -57,6 +58,11 @@ static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
 static inline void khugepaged_min_free_kbytes_update(void)
 {
 }
+
+static inline bool current_is_khugepaged(void)
+{
+	return false;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #endif /* _LINUX_KHUGEPAGED_H */
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 3518dba1e02f..7f5d1caf5890 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -40,10 +40,13 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGREUSE,
 		PGSTEAL_KSWAPD,
 		PGSTEAL_DIRECT,
+		PGSTEAL_KHUGEPAGED,
 		PGDEMOTE_KSWAPD,
 		PGDEMOTE_DIRECT,
+		PGDEMOTE_KHUGEPAGED,
 		PGSCAN_KSWAPD,
 		PGSCAN_DIRECT,
+		PGSCAN_KHUGEPAGED,
 		PGSCAN_DIRECT_THROTTLE,
 		PGSCAN_ANON,
 		PGSCAN_FILE,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315f7940..36318ebbf50d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2528,6 +2528,11 @@ void khugepaged_min_free_kbytes_update(void)
 	mutex_unlock(&khugepaged_mutex);
 }
 
+bool current_is_khugepaged(void)
+{
+	return kthread_func(current) == khugepaged;
+}
+
 static int madvise_collapse_errno(enum scan_result r)
 {
 	/*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d8549ae1b30..a17a5cfa6a55 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -661,8 +661,10 @@ static const unsigned int memcg_vm_event_stat[] = {
 	PGPGOUT,
 	PGSCAN_KSWAPD,
 	PGSCAN_DIRECT,
+	PGSCAN_KHUGEPAGED,
 	PGSTEAL_KSWAPD,
 	PGSTEAL_DIRECT,
+	PGSTEAL_KHUGEPAGED,
 	PGFAULT,
 	PGMAJFAULT,
 	PGREFILL,
@@ -1574,10 +1576,12 @@ static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
 	/* Accumulated memory events */
 	seq_buf_printf(&s, "pgscan %lu\n",
 		       memcg_events(memcg, PGSCAN_KSWAPD) +
-		       memcg_events(memcg, PGSCAN_DIRECT));
+		       memcg_events(memcg, PGSCAN_DIRECT) +
+		       memcg_events(memcg, PGSCAN_KHUGEPAGED));
 	seq_buf_printf(&s, "pgsteal %lu\n",
 		       memcg_events(memcg, PGSTEAL_KSWAPD) +
-		       memcg_events(memcg, PGSTEAL_DIRECT));
+		       memcg_events(memcg, PGSTEAL_DIRECT) +
+		       memcg_events(memcg, PGSTEAL_KHUGEPAGED));
 
 	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
 		if (memcg_vm_event_stat[i] == PGPGIN ||
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04d8b88e5216..a54d567c5e66 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -54,6 +54,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
+#include <linux/khugepaged.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -1047,6 +1048,24 @@ void drop_slab(void)
 		drop_slab_node(nid);
 }
 
+static int reclaimer_offset(void)
+{
+	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
+			PGDEMOTE_DIRECT - PGDEMOTE_KSWAPD);
+	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
+			PGSCAN_DIRECT - PGSCAN_KSWAPD);
+	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
+			PGDEMOTE_KHUGEPAGED - PGDEMOTE_KSWAPD);
+	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
+			PGSCAN_KHUGEPAGED - PGSCAN_KSWAPD);
+
+	if (current_is_kswapd())
+		return 0;
+	if (current_is_khugepaged())
+		return PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD;
+	return PGSTEAL_DIRECT - PGSTEAL_KSWAPD;
+}
+
 static inline int is_page_cache_freeable(struct folio *folio)
 {
 	/*
@@ -1599,10 +1618,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
 
-	if (current_is_kswapd())
-		__count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
-	else
-		__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
+	__count_vm_events(PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
 
 	return nr_succeeded;
 }
@@ -2475,7 +2491,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 				     &nr_scanned, sc, lru);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
-	item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
+	item = PGSCAN_KSWAPD + reclaimer_offset();
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
@@ -2492,7 +2508,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	move_folios_to_lru(lruvec, &folio_list);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
+	item = PGSTEAL_KSWAPD + reclaimer_offset();
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
@@ -4857,7 +4873,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 			break;
 	}
 
-	item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
+	item = PGSCAN_KSWAPD + reclaimer_offset();
 	if (!cgroup_reclaim(sc)) {
 		__count_vm_events(item, isolated);
 		__count_vm_events(PGREFILL, sorted);
@@ -5015,7 +5031,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	if (walk && walk->batched)
 		reset_batch_size(lruvec, walk);
 
-	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
+	item = PGSTEAL_KSWAPD + reclaimer_offset();
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, reclaimed);
 	__count_memcg_events(memcg, item, reclaimed);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b2371d745e00..1ea6a5ce1c41 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1271,10 +1271,13 @@ const char * const vmstat_text[] = {
 	"pgreuse",
 	"pgsteal_kswapd",
 	"pgsteal_direct",
+	"pgsteal_khugepaged",
 	"pgdemote_kswapd",
 	"pgdemote_direct",
+	"pgdemote_khugepaged",
 	"pgscan_kswapd",
 	"pgscan_direct",
+	"pgscan_khugepaged",
 	"pgscan_direct_throttle",
 	"pgscan_anon",
 	"pgscan_file",
-- 
2.38.1

