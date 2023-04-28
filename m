Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1A6F1951
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346249AbjD1NYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346240AbjD1NYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:24:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A68173E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:24:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f6dd3b329so165596317b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682688252; x=1685280252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+FzrFpmnoCmeFQ217D+x4Ju8+C0DQecKfFykJdZXOk=;
        b=ahJ5tf1zjA7jhOV/9LiwCRyuWOWHRwEdLk7R0d3XMmILa09rKnfx5nny2uPly2tetM
         yQe3PTogi+hkDTWAyAo3/jS9Bq4LZKPSzrbVPycPHL0j37hx58O3J7vo7Edyyivmccmm
         18Pb9GBVLPvYnxrvGeLG3aEwVfIhh0fflwdlhi4SSOB7+PY4t+ZYcJNyWcYRam9KFuAA
         PmhzEKiIFCk0EIXEsZHJ8Nv/iwsB92yyqpsd4da+lc/aDt5ZKzGH3eSQwh3kWSWXQgsr
         XAdD201Y1DEr8SPDG9gavkbwwkpUB/LVYwXboCYPhs7zxuzM6GotdmSf09vq72UBrtAr
         SZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688252; x=1685280252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+FzrFpmnoCmeFQ217D+x4Ju8+C0DQecKfFykJdZXOk=;
        b=YsEiJbdvCoUsmajNtqb1KGP7jA4W7VuyvzBeCEXcInhi52u4fyVvNB4fF/cAWVA8gO
         Ufwndifr93qolXfxgULesk3rgSMHLedjnifzBSG579uLIotACvq21tERVZzSAM/ZXUe3
         ZxrGXLs1cHqIyVvfj3L4LxWBgvjQoANjCyS0Vk6bZ/bQvHwkc80bzpeGKLujyIkwYKPA
         CmrK9W3o0NBTW4dxGmfT2qCoB9CqonV7vKIPsSrdIqrMWQn/jhujBLmcAV5YmYNcD1ku
         MyERzJuqSg1YpbUib3NYKjYqLpF/XSIGt2INb8J4s/Flmfgl4zyjiAclz9BzzpqzymUN
         VixQ==
X-Gm-Message-State: AC+VfDydmKWCmTBrtKPpJ1g0wYFRmn7bVCjoK1clGHtcOVxGwGh6e6Xp
        Fbz9lc95yCb0ZPG35I97N8W7WaGFm6hAMFMF
X-Google-Smtp-Source: ACHHUZ6GoDmbt3beV9QlXSTxOyplLo7KKBwAqbwxaQGER72TavmJAupPAyv7ANVUtRJ7bxflY5Y1p3fIF8lhgUMf
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:431e:0:b0:54c:fd7:476e with SMTP id
 q30-20020a81431e000000b0054c0fd7476emr3309474ywa.3.1682688252124; Fri, 28 Apr
 2023 06:24:12 -0700 (PDT)
Date:   Fri, 28 Apr 2023 13:24:05 +0000
In-Reply-To: <20230428132406.2540811-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230428132406.2540811-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428132406.2540811-2-yosryahmed@google.com>
Subject: [PATCH v2 1/2] memcg: use seq_buf_do_printk() with mem_cgroup_print_oom_meminfo()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we format all the memcg stats into a buffer in
mem_cgroup_print_oom_meminfo() and use pr_info() to dump it to the logs.
However, this buffer is large in size. Although it is currently working
as intended, ther is a dependency between the memcg stats buffer and the
printk record size limit.

If we add more stats in the future and the buffer becomes larger than
the printk record size limit, or if the prink record size limit is
reduced, the logs may be truncated.

It is safer to use seq_buf_do_printk(), which will automatically break
up the buffer at line breaks and issue small printk() calls.

Refactor the code to move the seq_buf from memory_stat_format() to its
callers, and use seq_buf_do_printk() to print the seq_buf in
mem_cgroup_print_oom_meminfo().

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/memcontrol.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..5922940f92c9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1551,13 +1551,10 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
 }
 
-static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
+static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
-	struct seq_buf s;
 	int i;
 
-	seq_buf_init(&s, buf, bufsize);
-
 	/*
 	 * Provide statistics on the state of the memory subsystem as
 	 * well as cumulative event counters that show past behavior.
@@ -1574,21 +1571,21 @@ static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
 		u64 size;
 
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
-		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
+		seq_buf_printf(s, "%s %llu\n", memory_stats[i].name, size);
 
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
 			size += memcg_page_state_output(memcg,
 							NR_SLAB_RECLAIMABLE_B);
-			seq_buf_printf(&s, "slab %llu\n", size);
+			seq_buf_printf(s, "slab %llu\n", size);
 		}
 	}
 
 	/* Accumulated memory events */
-	seq_buf_printf(&s, "pgscan %lu\n",
+	seq_buf_printf(s, "pgscan %lu\n",
 		       memcg_events(memcg, PGSCAN_KSWAPD) +
 		       memcg_events(memcg, PGSCAN_DIRECT) +
 		       memcg_events(memcg, PGSCAN_KHUGEPAGED));
-	seq_buf_printf(&s, "pgsteal %lu\n",
+	seq_buf_printf(s, "pgsteal %lu\n",
 		       memcg_events(memcg, PGSTEAL_KSWAPD) +
 		       memcg_events(memcg, PGSTEAL_DIRECT) +
 		       memcg_events(memcg, PGSTEAL_KHUGEPAGED));
@@ -1598,13 +1595,13 @@ static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
 		    memcg_vm_event_stat[i] == PGPGOUT)
 			continue;
 
-		seq_buf_printf(&s, "%s %lu\n",
+		seq_buf_printf(s, "%s %lu\n",
 			       vm_event_name(memcg_vm_event_stat[i]),
 			       memcg_events(memcg, memcg_vm_event_stat[i]));
 	}
 
 	/* The above should easily fit into one page */
-	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
+	WARN_ON_ONCE(seq_buf_has_overflowed(s));
 }
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
@@ -1642,6 +1639,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 	/* Use static buffer, for the caller is holding oom_lock. */
 	static char buf[PAGE_SIZE];
+	struct seq_buf s;
 
 	lockdep_assert_held(&oom_lock);
 
@@ -1664,8 +1662,9 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 	pr_info("Memory cgroup stats for ");
 	pr_cont_cgroup_path(memcg->css.cgroup);
 	pr_cont(":");
-	memory_stat_format(memcg, buf, sizeof(buf));
-	pr_info("%s", buf);
+	seq_buf_init(&s, buf, sizeof(buf));
+	memory_stat_format(memcg, &s);
+	seq_buf_do_printk(&s, KERN_INFO);
 }
 
 /*
@@ -6573,10 +6572,12 @@ static int memory_stat_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	struct seq_buf s;
 
 	if (!buf)
 		return -ENOMEM;
-	memory_stat_format(memcg, buf, PAGE_SIZE);
+	seq_buf_init(&s, buf, PAGE_SIZE);
+	memory_stat_format(memcg, &s);
 	seq_puts(m, buf);
 	kfree(buf);
 	return 0;
-- 
2.40.1.495.gc816e09b53d-goog

