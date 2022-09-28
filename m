Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A165ED584
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiI1G54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiI1G53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:57:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7957FE7E;
        Tue, 27 Sep 2022 23:57:23 -0700 (PDT)
Date:   Wed, 28 Sep 2022 06:57:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664348241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZxjcfgGuoo6ocC/hZrG5mJbTTF5Bue+mmgkM6CdPos=;
        b=UJJIg6G57fcDmOWa1ZchMdgSepzUqwaUKhy+98Y+UvujfSZCC4PRSaXhS/9OiPzpNryjB3
        Yvijoe5kHCkUfjwb32x2TkrVQzefTwHRg9TYi/oBi3kYgcztrlkCHyV4AnQaGCl50tABKC
        5uMhMb0TXVn6sAS6/5K8gr+8zJsrfJpVQzH4CZQPkpalOTztU3FzBnPsgluIoXl5VsP2fl
        JyitEJ8Vzgw/eeepDVp9W5IH8vxNJ6asBifgP4S8GqOUALgpZevweQK3veqEuTBI9o6/bB
        em+2ZmPuxSG3cayRWgvYOANlbywdurV38Di5B3YUoL3sT8e75KvhNR77xyTlpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664348241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZxjcfgGuoo6ocC/hZrG5mJbTTF5Bue+mmgkM6CdPos=;
        b=9sfqQi2ZGGLUybuifA2k1ZRKbi6NwTFfEXKjnbaXqZtfe5XE9KbUfVnk6Nuj2HhD2iSaiB
        Qnaf13jeKUOPAkAA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf, hw_breakpoint: Fix use-after-free if
 perf_event_open() fails
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220927172025.1636995-1-elver@google.com>
References: <20220927172025.1636995-1-elver@google.com>
MIME-Version: 1.0
Message-ID: <166434824041.401.2424383909686511412.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4674ffe2fcad45a9b164401cc0794115702326cf
Gitweb:        https://git.kernel.org/tip/4674ffe2fcad45a9b164401cc0794115702326cf
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 27 Sep 2022 19:20:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Sep 2022 22:50:24 +02:00

perf, hw_breakpoint: Fix use-after-free if perf_event_open() fails

Local testing revealed that we can trigger a use-after-free during
rhashtable lookup as follows:

 | BUG: KASAN: use-after-free in memcmp lib/string.c:757
 | Read of size 8 at addr ffff888107544dc0 by task perf-rhltable-n/1293
 |
 | CPU: 0 PID: 1293 Comm: perf-rhltable-n Not tainted 6.0.0-rc3-00014-g85260862789c #46
 | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
 | Call Trace:
 |  <TASK>
 |  memcmp			lib/string.c:757
 |  rhashtable_compare		include/linux/rhashtable.h:577 [inline]
 |  __rhashtable_lookup		include/linux/rhashtable.h:602 [inline]
 |  rhltable_lookup		include/linux/rhashtable.h:688 [inline]
 |  task_bp_pinned		kernel/events/hw_breakpoint.c:324
 |  toggle_bp_slot		kernel/events/hw_breakpoint.c:462
 |  __release_bp_slot		kernel/events/hw_breakpoint.c:631 [inline]
 |  release_bp_slot		kernel/events/hw_breakpoint.c:639
 |  register_perf_hw_breakpoint	kernel/events/hw_breakpoint.c:742
 |  hw_breakpoint_event_init	kernel/events/hw_breakpoint.c:976
 |  perf_try_init_event		kernel/events/core.c:11261
 |  perf_init_event		kernel/events/core.c:11325 [inline]
 |  perf_event_alloc		kernel/events/core.c:11619
 |  __do_sys_perf_event_open	kernel/events/core.c:12157
 |  do_syscall_x64 		arch/x86/entry/common.c:50 [inline]
 |  do_syscall_64		arch/x86/entry/common.c:80
 |  entry_SYSCALL_64_after_hwframe
 |  </TASK>
 |
 | Allocated by task 1292:
 |  perf_event_alloc		kernel/events/core.c:11505
 |  __do_sys_perf_event_open	kernel/events/core.c:12157
 |  do_syscall_x64		arch/x86/entry/common.c:50 [inline]
 |  do_syscall_64		arch/x86/entry/common.c:80
 |  entry_SYSCALL_64_after_hwframe
 |
 | Freed by task 1292:
 |  perf_event_alloc		kernel/events/core.c:11716
 |  __do_sys_perf_event_open	kernel/events/core.c:12157
 |  do_syscall_x64		arch/x86/entry/common.c:50 [inline]
 |  do_syscall_64		arch/x86/entry/common.c:80
 |  entry_SYSCALL_64_after_hwframe
 |
 | The buggy address belongs to the object at ffff888107544c00
 |  which belongs to the cache perf_event of size 1352
 | The buggy address is located 448 bytes inside of
 |  1352-byte region [ffff888107544c00, ffff888107545148)

This happens because the first perf_event_open() managed to reserve a HW
breakpoint slot, however, later fails for other reasons and returns. The
second perf_event_open() runs concurrently, and during rhltable_lookup()
looks up an entry which is being freed: since rhltable_lookup() may run
concurrently (under the RCU read lock) with rhltable_remove(), we may
end up with a stale entry, for which memory may also have already been
freed when being accessed.

To fix, only free the failed perf_event after an RCU grace period. This
allows subsystems that store references to an event to always access it
concurrently under the RCU read lock, even if initialization will fail.

Given failure is unlikely and a slow-path, turning the immediate free
into a call_rcu()-wrapped free does not affect performance elsewhere.

Fixes: 0370dc314df3 ("perf/hw_breakpoint: Optimize list of per-task breakpoints")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220927172025.1636995-1-elver@google.com
---
 kernel/events/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 04e19a8..e1ffdb8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11734,11 +11734,9 @@ err_pmu:
 		event->destroy(event);
 	module_put(pmu->module);
 err_ns:
-	if (event->ns)
-		put_pid_ns(event->ns);
 	if (event->hw.target)
 		put_task_struct(event->hw.target);
-	kmem_cache_free(perf_event_cache, event);
+	call_rcu(&event->rcu_head, free_event_rcu);
 
 	return ERR_PTR(err);
 }
