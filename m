Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6485ECAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiI0RUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiI0RUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:20:51 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555AEEE86
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:20:49 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id z2-20020a056402274200b004516734e755so8265965edd.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=xrimbA31oh12GrLjVo2B/hMpsltLczwvj4VfTLXOv0M=;
        b=OMULmYEIDkxRB7ENeb/uPGSUQ/EgKtqJfimZkvES7SP7Ltpiyr6iMf2rYJ/dQhl9he
         coiTT+OW7F8lFzNCnGgdwu5UwagfywnIiEyVoRcGQWlgoiTWZ4vO1fO049HmAt3CZrDy
         2DJsHAEhaWJXPTKd85/2FpQtiXDEOB1fRgMLGpV7NiSw0acPbNGYRZnzuQbb7X1sPj56
         rRsrbWFHxStB08zMuxe95EAr3Ym7aZ9iE4Y5l6UKgqKfWp1hXqGHVVJKHZB5mzhosmoP
         t2TbThc4MsAN5J73pZjoiCIbEFQRn867vj92luYVJYzkyuaMR/+gKSFWJfgmr0ZQK/7l
         PhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xrimbA31oh12GrLjVo2B/hMpsltLczwvj4VfTLXOv0M=;
        b=GMGBIOLT8JITdUTHBeI+X+T6USonl3Ffmm35iPolchQErxZ+pDwy9qZNgcDRxgfnih
         ViCwd8dcEI6y38tNVmqPC4RdmEzan4F5M4jS96zRogFCpKHnYObex5BgNib9ROX5hU6k
         GihHeJfjapt5BwLf8JONwhtMkbmB6f4oadZfbE+7SAXFb8EhrLk8dHxev4pvgRq06ROC
         uGRI8mOIYw9zqO+AwytVReazChZZMMO8Ourzsuc9VIaJE+4uO3L/5Gt3hYPmbi3L0npI
         AugaEI6JP320ayP5eWY1avzbwYG5I05heFK+taUfLtVXgMNUf4xEXIjqogtYJuusMb9Z
         8Pvg==
X-Gm-Message-State: ACrzQf02dRAhiGlruprYJzKxbMOFkpFSRm4ukoGVdqhgyfk7Kc5w8yBX
        1+q5YB2dOZnwI6JaiIzRh6zpxkNTww==
X-Google-Smtp-Source: AMsMyM6uYt0ZRUQWY1DWH18dz7dRb1NqJyLGAtrCnkwcNrvtTOz8ZQ4UdY9DmOFNcbdL/E3JVVvd5Zzptg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:693c:15a1:a531:bb4e])
 (user=elver job=sendgmr) by 2002:a05:6402:d5a:b0:457:b705:3280 with SMTP id
 ec26-20020a0564020d5a00b00457b7053280mr3560695edb.201.1664299247897; Tue, 27
 Sep 2022 10:20:47 -0700 (PDT)
Date:   Tue, 27 Sep 2022 19:20:25 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927172025.1636995-1-elver@google.com>
Subject: [PATCH -tip] perf, hw_breakpoint: Fix use-after-free if
 perf_event_open() fails
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
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
---
 kernel/events/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index df90777262bf..007a87c1599c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11776,11 +11776,9 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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
-- 
2.37.3.998.g577e59143f-goog

