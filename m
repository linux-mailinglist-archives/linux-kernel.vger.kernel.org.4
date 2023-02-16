Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CA1698BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBPFVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBPFUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:20:14 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B0A474DA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:08 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4fa63c84621so8412227b3.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAnyYB3Nw50vBlFaI5emapvq5zyyV08CcfGYNR6eiBY=;
        b=a3wN6yhQzn6ykzBbjResLcztZyUFHxuHfZtRwk9INETFTCK3R+0qznDveEPm+o/T6G
         wJ3wEiieeEUcjgJFPl0Q1WJhoSjHld23FZEQoY2Aq8Bhu2X6QB+bcNMvcqIxTt4gpYGo
         62C0Ezu+RzKHJNHqe8a2WWwzq3BWBtjKwlH9vropbhb+eXqNxVp6cua3PyUJuPb2PSda
         pEBwm4EDV55dFWt5TRT7+9jNt1+V85COwPZnyzclXtLSHEwvb2nMc9rLXuPiU2TfsCi1
         1h3mje1L/1Q/DM34hGjfe9SSEWf4rBhdCLw8Ngy6TcviKT73/jmv3Lf0iRWhfdK1hSLg
         WjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAnyYB3Nw50vBlFaI5emapvq5zyyV08CcfGYNR6eiBY=;
        b=uYUQxAKDyWERMQyQmXI5wERwaB0DatQd0b7hpuNZDZSUUU/N+8V1LX42K1/2HCt/2m
         hklzVtBxRmaVEByojFJXUDiSpZVyoNLNfghPj3K1pXv8suL0m3RsObeLyE8RuG9Gm1nl
         JHluN9PadzpgHw7btQNOEzcHevZ3lDNlT5u9fV6b+TzCQj6vOqWxKqhK431FO9MQuGhb
         pu7qWFju0v4zOkujUNAe2N+/zUFqFhrrdBVekQUNOZuvBDDctrMuS24i1thIOV3riaw6
         MiiB2vZkzipPoke85ipDK0eEWDIgetTrPaZ8IZMlfdAGp+I/FiaOFwGfNFiN8vVMl01h
         Yu3w==
X-Gm-Message-State: AO0yUKXCCqqiQAPrEKLw3HPyLmpvJLvLj1myWeS7UoQmq/OXY9uttLmW
        M1ZOod600BFtLqzimwhhf52pS7NqJfk=
X-Google-Smtp-Source: AK7set9XJXC8LdbYcGXxryYVlcRlcBZQcF1FMhZd/N4oCcpN8tIB1OMR+nLJJI9Pn7NEIXJu3Q5fjvT0dR0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a05:6902:18cc:b0:8a3:d147:280b with SMTP id
 ck12-20020a05690218cc00b008a3d147280bmr5ybb.3.1676524746144; Wed, 15 Feb 2023
 21:19:06 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:45 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-31-surenb@google.com>
Subject: [PATCH v3 30/35] mm: introduce per-VMA lock statistics
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
index 751aebc1b29f..94194a45ffa7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5272,6 +5272,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	/* Check if the VMA got isolated after we found it */
 	if (vma->detached) {
 		vma_end_read(vma);
+		count_vm_vma_lock_event(VMA_LOCK_MISS);
 		/* The area was replaced with another one */
 		goto retry;
 	}
@@ -5280,6 +5281,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
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
2.39.1

