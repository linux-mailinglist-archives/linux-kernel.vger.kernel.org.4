Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A9F60D541
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiJYULm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJYULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:11:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E29979EC6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UvZ0A5YMgLIp6qjx93Bx4vopUfVlvYD0i9vsQFxAYRM=; b=dW/slevqqrlkPqDipH2N24ioFq
        ulGSbcJXeRK+kDZeRbpzM/GVbrIP5v+bIK6nxrlTWlYLAjZL9RqVI1CcRgUEixULXAjglX4tSAtO4
        4h/WClTyNIB+h5I+CLuPWdrodL4uWnbgDRBJ5XjQw8y8pxTB8IQW78KQ/vCqr9xUQvwEJUeLCYQog
        lRcIoCihCgWvzvGTxehh/oOHS4PiC1FKaXRX3Nk9VqqNP+WwJGbiFlKw+YXlQAt1OaJiJEYT1ooE9
        Xw4o6aPkkJYgQmXcT6IicdEl63ccikyBVzubCY/al2LoQHMk7/1hx88xb2M+jgOTyht+aJTpFGll7
        VaP2/YVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onQGm-00GWF4-EP; Tue, 25 Oct 2022 20:11:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3C13300169;
        Tue, 25 Oct 2022 22:11:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8C43F2C4502E9; Tue, 25 Oct 2022 22:11:22 +0200 (CEST)
Message-ID: <20221025201057.751153381@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 25 Oct 2022 22:06:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, rostedt@goodmis.org,
        dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: [PATCH 1/5] mm: Move mm_cachep initialization to mm_init()
References: <20221025200656.951281799@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow using mm_alloc() much earlier, move initializing
mm_cachep into mm_init().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/task.h |    1 +
 init/main.c                |    1 +
 kernel/fork.c              |   32 ++++++++++++++++++--------------
 3 files changed, 20 insertions(+), 14 deletions(-)

--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -65,6 +65,7 @@ extern void sched_dead(struct task_struc
 void __noreturn do_task_dead(void);
 void __noreturn make_task_dead(int signr);
 
+extern void mm_cache_init(void);
 extern void proc_caches_init(void);
 
 extern void fork_init(void);
--- a/init/main.c
+++ b/init/main.c
@@ -860,6 +860,7 @@ static void __init mm_init(void)
 	/* Should be run after espfix64 is set up. */
 	pti_init();
 	kmsan_init_runtime();
+	mm_cache_init();
 }
 
 #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
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


