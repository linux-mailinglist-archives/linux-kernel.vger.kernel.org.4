Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6ED6A4849
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjB0RjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjB0RiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:22 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF7F10DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c6ce8d74so152382247b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UPo8VnsZti2aeY7Ox0qRgfNdvo1gTkzbfBEHZWtvw/0=;
        b=IGWknCp/kisFoGwJNllVFcIXkGMt1odnhFRD9r74JJb+hle3qs+rysH7Cj7LxfSYl3
         UW6Inlffa9zMrz18VMYTmm0mCybg9uuWP8GtlbTG3g9pftAlYiYDxCOgQ9yUPTQuNgUQ
         7e5+Qgd8nKAvibx0XVaMl/6g6MRebcr67sOkD0X7DIV3NuMKmZV7fQCQn8tLNb6YhgpG
         HIOQasloSO/5ARX6XcV70hiI9ZtHPTCNioAp7z9/k/Sfdb6q0fhN5YCiCRhR+ImXzmes
         BXS9C1iWs23SeFAwT6rFElobGU5I0Xf+MXK56mAXr/Sbo1qNfZi6LCRNAeWAjz+RO9FM
         dTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPo8VnsZti2aeY7Ox0qRgfNdvo1gTkzbfBEHZWtvw/0=;
        b=qrwrq9+uWULfbxP/eCqTbBzGWri3FsM3pmJ1pHYtvet+YekeR/dZEnWnd8+Oe9avAq
         p1J2ecvnsUdMKLW4zLGcY3Fx1DYrVjQYVUEDjXJ3a+zkIC1dyowUBr1G2BniW3r2wWk+
         GhkwITEsy/g20z0PyLbjBHuiU23njJRimy5m3u2vXZBgtJU0h8yQbCesY8Ha0+334nfV
         l5v8DbVJteFLfdGiPtke1ucxZC9gIi9a1gXc8nD34lRTS21H8rKt0OuAhZX1pta9eT/t
         RHFNPJ60K4diSPY63gl7wQW2d73kspoTfLYch3Bplo3EbWnr257vIggqNqV0SYjTVfGr
         +CcA==
X-Gm-Message-State: AO0yUKU140pdtxvTvIoNIdF+Od0l7eCagfVLKDjUkK9x/RDvZT+JZWly
        iK20r/c3r5PMHZfuS3owkx1I+oisSZo=
X-Google-Smtp-Source: AK7set9Qr99NowsWp6cjcp1aWhoq+Zdc9tJrNQG4gE1aZ9h1lXPmI6kCw99Bwq0EMQ8NeKIO2QVO54vN80s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a0d:d002:0:b0:527:ae97:e8fe with SMTP id
 s2-20020a0dd002000000b00527ae97e8femr357186ywd.42.1677519463716; Mon, 27 Feb
 2023 09:37:43 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:27 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-29-surenb@google.com>
Subject: [PATCH v4 28/33] mm: introduce per-VMA lock statistics
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
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
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
 mm/Kconfig.debug              | 6 ++++++
 mm/memory.c                   | 2 ++
 mm/vmstat.c                   | 6 ++++++
 5 files changed, 26 insertions(+)

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
index c3547a373c9c..4965a7333a3f 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -279,3 +279,9 @@ config DEBUG_KMEMLEAK_AUTO_SCAN
 
 	  If unsure, say Y.
 
+config PER_VMA_LOCK_STATS
+	bool "Statistics for per-vma locks"
+	depends on PER_VMA_LOCK
+	default y
+	help
+	  Statistics for per-vma locks.
diff --git a/mm/memory.c b/mm/memory.c
index f734f80d28ca..255b2f4fdd4a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5273,6 +5273,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	/* Check if the VMA got isolated after we found it */
 	if (vma->detached) {
 		vma_end_read(vma);
+		count_vm_vma_lock_event(VMA_LOCK_MISS);
 		/* The area was replaced with another one */
 		goto retry;
 	}
@@ -5281,6 +5282,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	return vma;
 inval:
 	rcu_read_unlock();
+	count_vm_vma_lock_event(VMA_LOCK_ABORT);
 	return NULL;
 }
 #endif /* CONFIG_PER_VMA_LOCK */
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
2.39.2.722.g9855ee24e9-goog

