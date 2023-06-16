Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D687337E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFPSHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFPSH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:07:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9284430FE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:07:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 40FE321C3A;
        Fri, 16 Jun 2023 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686938842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bm9Vw5H6yGrwn4tTzKc5q8OJHix81Wz2+IxzfBcuFEw=;
        b=QvJrVkKiH+XeJGuNdMS5Su60VmPHay4I0XeSzYlltz06ro5xEuwX9jSff4IG+wmDRNut+D
        OivGqOuBREkZic7P0vGnuwg5cTFXMI3L5WNfJPwPmJG17y4vT90o2NHyiw865vSOinYWt1
        w4OyzF3V7B1D4MiwQ+P/KfBIbxvm8xc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA487138E8;
        Fri, 16 Jun 2023 18:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1gwSONmkjGSTPwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 16 Jun 2023 18:07:21 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Adam Majer <amajer@suse.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH] mm: Sync percpu mm RSS counters before querying
Date:   Fri, 16 Jun 2023 20:07:18 +0200
Message-ID: <20230616180718.17725-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An issue was observed with stats collected in struct rusage on ppc64le
with 64kB pages. The percpu counters use batching with
	percpu_counter_batch = max(32, nr*2) # in PAGE_SIZE
i.e. with larger pages but similar RSS consumption (bytes), there'll be
less flushes and error more noticeable.

In this given case (getting consumption of exited child), we can request
percpu counter's flush without worrying about contention with updaters.

Fortunately, the commit f1a7941243c1 ("mm: convert mm's rss stats into
percpu_counter") didn't eradicate all traces of SPLIT_RSS_COUNTING and
this mechanism already provided some synchronization points before
reading stats.
Therefore, use sync_mm_rss as carrier for percpu counters refreshes and
forget SPLIT_RSS_COUNTING macro for good.

Impact of summing on a 8 CPU machine:
Benchmark 1: taskset -c 1 ./shell-bench.sh

Before
  Time (mean ± σ):      9.950 s ±  0.052 s    [User: 7.773 s, System: 2.023 s]

After
  Time (mean ± σ):      9.990 s ±  0.070 s    [User: 7.825 s, System: 2.011 s]

cat >shell-bench.sh <<EOD
for (( i = 0; i < 20000; i++ )); do
	/bin/true
done
EOD

The script is meant to stress fork-exit path (exit is where sync_mm_rss
is most called, add_mm_rss_vec should be covered in fork).

Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
Reported-by: Adam Majer <amajer@suse.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---

Notes:
    - dummy approach to fix correctness, performance should be treated separately
    - add percpu_counter_set to really update the value
    - RFC https://lore.kernel.org/r/20230608171256.17827-1-mkoutny@suse.com/

 include/linux/mm.h | 7 +++----
 kernel/fork.c      | 4 ----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..c7ac1cbc6fb3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2547,13 +2547,12 @@ static inline void setmax_mm_hiwater_rss(unsigned long *maxrss,
 		*maxrss = hiwater_rss;
 }
 
-#if defined(SPLIT_RSS_COUNTING)
-void sync_mm_rss(struct mm_struct *mm);
-#else
 static inline void sync_mm_rss(struct mm_struct *mm)
 {
+	for (int i = 0; i < NR_MM_COUNTERS; ++i)
+		percpu_counter_set(&mm->rss_stat[i],
+				   percpu_counter_sum(&mm->rss_stat[i]));
 }
-#endif
 
 #ifndef CONFIG_ARCH_HAS_PTE_SPECIAL
 static inline int pte_special(pte_t pte)
diff --git a/kernel/fork.c b/kernel/fork.c
index 81cba91f30bb..e030eb902e4b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2412,10 +2412,6 @@ __latent_entropy struct task_struct *copy_process(
 	p->io_uring = NULL;
 #endif
 
-#if defined(SPLIT_RSS_COUNTING)
-	memset(&p->rss_stat, 0, sizeof(p->rss_stat));
-#endif
-
 	p->default_timer_slack_ns = current->timer_slack_ns;
 
 #ifdef CONFIG_PSI
-- 
2.41.0

