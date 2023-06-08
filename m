Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FEA72860A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjFHRNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjFHRNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:13:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1E7E59
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:13:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA395219BC;
        Thu,  8 Jun 2023 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686244387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zcwvri9EO5NgmPKueOn7NC6SyLLY9pSstgNvXylAdIw=;
        b=O8ZJ8Pyiu6ad1fjW2LpeHDPLJm7yd9dnHlsYk6/29iqbd/j4jp1uSSzrWqlHs1/Eg2Jorv
        Dq0BwIHM7DD0/T2Lod56QaRJCVwuDwMeYtE5XAzcfiBFt4c9kRGImzGMGSUYfBbJ2jolAj
        DJfbtf2g2NizOT63NJ91uTvf3xskc20=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A358813480;
        Thu,  8 Jun 2023 17:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Glv/JiMMgmQ5SQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 08 Jun 2023 17:13:07 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Andrei Vagin <avagin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Adam Majer <amajer@suse.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Subject: [RFC PATCH] mm: Sync percpu mm RSS counters before querying
Date:   Thu,  8 Jun 2023 19:12:56 +0200
Message-Id: <20230608171256.17827-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
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

Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
Reported-by: Adam Majer <amajer@suse.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/mm.h | 6 ++----
 kernel/fork.c      | 4 ----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..30cfde88d5b2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2547,13 +2547,11 @@ static inline void setmax_mm_hiwater_rss(unsigned long *maxrss,
 		*maxrss = hiwater_rss;
 }
 
-#if defined(SPLIT_RSS_COUNTING)
-void sync_mm_rss(struct mm_struct *mm);
-#else
 static inline void sync_mm_rss(struct mm_struct *mm)
 {
+	for (int i = 0; i < NR_MM_COUNTERS; ++i)
+		percpu_counter_sum(&mm->rss_stat[i]);
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
2.40.1

