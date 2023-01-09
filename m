Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FAE663216
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbjAIU6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbjAIU5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:57:43 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9631A8CBEF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-46839d9ca5dso104917327b3.16
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mbt4mHoq0eWZO149X3WH8AIvdwQHHBNP+0MBWdKikso=;
        b=I5umo4kG0hMiq4gs5OujcHd7Sn1GGJbiybdYQYTj0HAR3QOkD0OA35qcaeXUMRzGAJ
         dIG3EBC52wC5ibcKgTHA/19I2NomM7CaXPc78eVykHWlIF2Vt/KiNizKg3yGh0eNsGHP
         jtagKS1D/qcsRmP7Fqc869E/kUJC8aHONABQKFab5CUW1r0+y/kJjLtE/M8OXtv+HWMx
         0jlTEySwEhV749+tPTyOU0MfX8AR34H6BYDnkbNQmdajk1IIrv1WChV6C7Fwj8u25gID
         LgF2w8/r6WitNZ0Roa2WVZN3Fbrz2yHOP70XPp57APsjpBjV3GkkefNK2oUkx1yrmoLm
         XvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbt4mHoq0eWZO149X3WH8AIvdwQHHBNP+0MBWdKikso=;
        b=Aria4KBkJ+vtSsUpTWbHvjsR2k24s+TWn07EEP5OBL86Vdk1r0+7GUf25CSAeyjLQv
         sVpGW439s+E0228Lf8cmJVJjgmI4do7CDuce4zvHznNG5BmE1rgkFETuIPxTK0D8zh8g
         pYxVrbzaArfyb651grDOl/rYlb/PVIcX4JA+A7HXQlZaBZ/i8Mef1RC+o3rbNv/vcHFg
         q3iF58+qZPWYjKwqrMSSfKMs2gAR1XlWwy0WhWZVh13hsX8BrSc2KIMR/1V7VHMKinnY
         vr9DWGFigvrkqrQLoHSeag5G5R4B9aieiQH/E1ow+76btGgBVPqVQyNGA+nnog1wvr/u
         9daA==
X-Gm-Message-State: AFqh2kpUBEMCNpS1c5G1bxerdvEBxB+BKJ+jUp0HpbxwjCcuL2qyv9HG
        BB3W2DO4KrDb456+SUY+QNZy2hE45pE=
X-Google-Smtp-Source: AMrXdXtYuIZxYJtCLtoqxn2YJzAdgg4PkVPb1cvNxFA+XZbpVDno2DZhvITBpFn/vgBWgY0+QZ+ehdsSMWQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:9d82:0:b0:774:df47:b5f with SMTP id
 v2-20020a259d82000000b00774df470b5fmr6154650ybp.405.1673297703709; Mon, 09
 Jan 2023 12:55:03 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:28 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-34-surenb@google.com>
Subject: [PATCH 33/41] mm: introduce per-VMA lock statistics
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
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
 mm/Kconfig.debug              | 8 ++++++++
 mm/vmstat.c                   | 6 ++++++
 4 files changed, 26 insertions(+)

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
index fca699ad1fb0..32a93b064590 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -207,3 +207,11 @@ config PTDUMP_DEBUGFS
 	  kernel.
 
 	  If in doubt, say N.
+
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
2.39.0

