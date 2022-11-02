Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD1E615F54
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiKBJPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiKBJNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:13:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772EE29364;
        Wed,  2 Nov 2022 02:12:56 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMREbSjW1m1DQRIRobOJxb5WF+kSzXiQo4pLiuFB+9U=;
        b=H/8/yUcd8R/Of3fTGJL6zoT8ERF7Jc/zIW1itBszOao4E+qWJJmvnXakiOYnfTZ2grepIA
        fr4Fp+y+gJL9nQLDwYl7tuuGozlXy5is1rmgmRl+ih2nENufb3LGDUljvX/KZJmnOsz2nD
        V0P29xM/z+0vh7Vi3yXM8Rx9SHlnq6MEHDeT6n+SAUVD4XFtxZ5+zrI9+tc4c9KUhFTt7a
        JvYBIMPz1N8DiDJlDgoXyWddBh/uQnw58nnYNQCbGEwUMnGMhuqVIkJbQwqorzxP1P0FeT
        I5euODlWio0QsyVrZAkdGMXYkDEXjw1ZKXtLn8Wm+t1fkwPT+Y9WeQ9Yjw4UBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMREbSjW1m1DQRIRobOJxb5WF+kSzXiQo4pLiuFB+9U=;
        b=9QUDXiZeBBe6Lzl1bfCFhYiXnCF/oaqw2pZbMemy/gQSw/95y7oLEIv3kJ2MpX/y7p1Y+Q
        wvxUcXjFRU5y6BDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Move mm_cachep initialization to mm_init()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221025201057.751153381@infradead.org>
References: <20221025201057.751153381@infradead.org>
MIME-Version: 1.0
Message-ID: <166738037356.7716.15264994823926137234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     a2e87952bf54b99e8d560c095a2c75ebc676e1fb
Gitweb:        https://git.kernel.org/tip/a2e87952bf54b99e8d560c095a2c75ebc676e1fb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 Oct 2022 21:38:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:43:56 +01:00

mm: Move mm_cachep initialization to mm_init()

In order to allow using mm_alloc() much earlier, move initializing
mm_cachep into mm_init().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221025201057.751153381@infradead.org
---
 include/linux/sched/task.h |  1 +
 init/main.c                |  1 +
 kernel/fork.c              | 32 ++++++++++++++++++--------------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index d6c4816..8431558 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -65,6 +65,7 @@ extern void sched_dead(struct task_struct *p);
 void __noreturn do_task_dead(void);
 void __noreturn make_task_dead(int signr);
 
+extern void mm_cache_init(void);
 extern void proc_caches_init(void);
 
 extern void fork_init(void);
diff --git a/init/main.c b/init/main.c
index aa21add..f1d1a54 100644
--- a/init/main.c
+++ b/init/main.c
@@ -860,6 +860,7 @@ static void __init mm_init(void)
 	/* Should be run after espfix64 is set up. */
 	pti_init();
 	kmsan_init_runtime();
+	mm_cache_init();
 }
 
 #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5..451ce80 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3015,10 +3015,27 @@ static void sighand_ctor(void *data)
 	init_waitqueue_head(&sighand->signalfd_wqh);
 }
 
-void __init proc_caches_init(void)
+void __init mm_cache_init(void)
 {
 	unsigned int mm_size;
 
+	/*
+	 * The mm_cpumask is located at the end of mm_struct, and is
+	 * dynamically sized based on the maximum CPU number this system
+	 * can have, taking hotplug into account (nr_cpu_ids).
+	 */
+	mm_size = sizeof(struct mm_struct) + cpumask_size();
+
+	mm_cachep = kmem_cache_create_usercopy("mm_struct",
+			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
+			offsetof(struct mm_struct, saved_auxv),
+			sizeof_field(struct mm_struct, saved_auxv),
+			NULL);
+}
+
+void __init proc_caches_init(void)
+{
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
@@ -3036,19 +3053,6 @@ void __init proc_caches_init(void)
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
 
-	/*
-	 * The mm_cpumask is located at the end of mm_struct, and is
-	 * dynamically sized based on the maximum CPU number this system
-	 * can have, taking hotplug into account (nr_cpu_ids).
-	 */
-	mm_size = sizeof(struct mm_struct) + cpumask_size();
-
-	mm_cachep = kmem_cache_create_usercopy("mm_struct",
-			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
-			offsetof(struct mm_struct, saved_auxv),
-			sizeof_field(struct mm_struct, saved_auxv),
-			NULL);
 	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
 	mmap_init();
 	nsproxy_cache_init();
