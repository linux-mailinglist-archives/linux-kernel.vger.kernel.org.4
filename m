Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FC567EEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjA0Tph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjA0ToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:44:07 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4103E2E811
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-50660dd3263so65585197b3.19
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTC+ocJD/ZK0d8AWah1kQLEh3QM8J68abwl+vLpX/MY=;
        b=mU8gu/pWf6zIsQFo9qZJmzO+C9Rz2zywIzJAt0hiLsBb0sfMScn0ga1WT0lJP4+cuU
         jnlE49/hYrnAMYh/RLEYzocL5Jy7mfCziMb33lJyjegHt186LkbV/WCwUSBxzV0FGK1I
         xrqhc33jx9MJLtdss02+APSdeRf2XUnFG09IUKfXCIr+hkTGBQo7qLvcD8/EZZarD0c6
         9RiTDx0vtERha59paJtaKyAUCno0Vzl4l7lvqpJzE2nTjhpBkjOXcTvShnV68JU8Wm5n
         IoRxYa+gg9A7UVOaBxUJpIYlD0HzhsBk7iegMRGVNF5IQVYNK1FSZGz91UjWgsue8k5N
         kYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTC+ocJD/ZK0d8AWah1kQLEh3QM8J68abwl+vLpX/MY=;
        b=n9nUVyn4N6fMDpHmkxC+XdURepWGHSxPuHIFb3iKjAdaDV6xGuNdCfPfgGkiTDt66J
         wZJqzfJZU6i4HdFuWDrywN9Zj5miz93KzTq6Tqt9As08EMSG5T5WyWf0c0vj52fqVrGp
         kOhOLZjJ1KwV3+NhZIcTHtHfumls35Wizc3IGJBg79AgWTFugIo9rzq+QY+Cc85/9GF6
         dOKEB7Pf7bmz+q1Ounfx5XkCmKIkksfhTtKEWzUUYdV/PAS0qbpTfPPJXZztpBZ+FIB2
         W4HH0glsLr5jySTjGCggSCeDtl+9LfA+6Qqs0YPZ/eb4oaOTVFvOokhfClkPlEmBla2U
         Y4nA==
X-Gm-Message-State: AO0yUKVa6UcDtteJJQ+yq6F6KSQhUaXi8ZiuIUcwnAZK1WR2DKjLHKol
        tXa82CvKE247czvBGnQ+3zTQ9QZpE7w=
X-Google-Smtp-Source: AK7set93uG4w1kFwIB1zyvlDAWxZcHXpTslQnEHpzoDHLwlIEt0PkMVZGLSp9rtobNPjvtDDJk1UuyFV7ts=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a25:e705:0:b0:80b:bdc5:5060 with SMTP id
 e5-20020a25e705000000b0080bbdc55060mr930533ybh.27.1674848540634; Fri, 27 Jan
 2023 11:42:20 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:41:05 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-29-surenb@google.com>
Subject: [PATCH v2 28/33] mm: introduce per-VMA lock statistics
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new CONFIG_PER_VMA_LOCK_STATS config option to dump extra
statistics about handling page fault under VMA lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/vm_event_item.h | 6 ++++++
 include/linux/vmstat.h        | 6 ++++++
 mm/Kconfig.debug              | 7 +++++++
 mm/vmstat.c                   | 6 ++++++
 4 files changed, 25 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 7f5d1caf5890..8abfa1240040 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -149,6 +149,12 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
+#endif
+#ifdef CONFIG_PER_VMA_LOCK_STATS
+		VMA_LOCK_SUCCESS,
+		VMA_LOCK_ABORT,
+		VMA_LOCK_RETRY,
+		VMA_LOCK_MISS,
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 19cf5b6892ce..fed855bae6d8 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -125,6 +125,12 @@ static inline void vm_events_fold_cpu(int cpu)
 #define count_vm_tlb_events(x, y) do { (void)(y); } while (0)
 #endif
 
+#ifdef CONFIG_PER_VMA_LOCK_STATS
+#define count_vm_vma_lock_event(x) count_vm_event(x)
+#else
+#define count_vm_vma_lock_event(x) do {} while (0)
+#endif
+
 #define __count_zid_vm_events(item, zid, delta) \
 	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
 
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 9191897e76af..4965a7333a3f 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -278,3 +278,10 @@ config DEBUG_KMEMLEAK_AUTO_SCAN
 	  memory leaks.
 
 	  If unsure, say Y.
+
+config PER_VMA_LOCK_STATS
+	bool "Statistics for per-vma locks"
+	depends on PER_VMA_LOCK
+	default y
+	help
+	  Statistics for per-vma locks.
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1ea6a5ce1c41..4f1089a1860e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1399,6 +1399,12 @@ const char * const vmstat_text[] = {
 	"direct_map_level2_splits",
 	"direct_map_level3_splits",
 #endif
+#ifdef CONFIG_PER_VMA_LOCK_STATS
+	"vma_lock_success",
+	"vma_lock_abort",
+	"vma_lock_retry",
+	"vma_lock_miss",
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.39.1

