Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB564FBF6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiLQS6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiLQSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5613F21B3;
        Sat, 17 Dec 2022 10:55:40 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNyD44yWy6JwQaRoaXR6NPzMW9MUXqh7rjDEnEHPRWQ=;
        b=CzoVP/hoku14o4ojK3XL8gv9DAnNX8kVplrSBKqqW6SCu4NmBfzCsL3ClK4oK4tKpxmPbq
        b7FV5EXRhOXDOR/Kb7SlAm4nCWx18HpQ+8SROQho2px+RJ28t4OU7O3qQfuyrQjQoaZrup
        OPGhtA4P6JDwCCZH0PLTicpT8bu4nvz2KO85/+RJqQHVZDW/EAwYunYU4VmjCTUxTgm/8f
        LQd4SCKqOPP2H8fa/8NYM64iuInGg00YGIzANjzU1C+86//1zilgnENODH3whmakxR09Lc
        ZKdUlucqDtpTtekfP/jubd7LO+ZQLf/Gw+HyPq8cG/Ag5+sw2ItYblrUvQgFPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNyD44yWy6JwQaRoaXR6NPzMW9MUXqh7rjDEnEHPRWQ=;
        b=cYOFmcWuoyTJkglvf5J5LDZXe+sHp/U0QpS7pogG+0r1HAyWCCA+o9K7ixmV3pyo5PQGr5
        0h1oLOrERbene5Ag==
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
Message-ID: <167130333575.4906.1395970810008123745.tip-bot2@tip-bot2>
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

Commit-ID:     af80602799681c78f14fbe20b6185a56020dedee
Gitweb:        https://git.kernel.org/tip/af80602799681c78f14fbe20b6185a56020dedee
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 Oct 2022 21:38:18 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:26 -08:00

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
