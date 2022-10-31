Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9726132D5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJaJfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJaJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:35:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48204DEBE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:35:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y6-20020a25b9c6000000b006c1c6161716so9933257ybj.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7abLUKvfL513QAFSaGq2FlNA+/gNLlKgxsoNfFkz71Q=;
        b=GEZadzE3OPQ69P/n9wzBiPa9xCjhhx07Ov1aXmlD2Yk58eKcXfjmchldx36yLgGfVS
         t2tQB10CpkjrukG5aa66VN9wk+v0Pg3AjiH16Hd3QS4hTKy3db8+P+8wMvaXl28CQfBW
         qu79LGcYMSlEyMWPjh8fPVvuGqimolUZ5zHAX5gZZSUynGiSjPW3y4LLpx6G+LFOz4t1
         kbGpfTh8yveIDW/MJcJlczu+YU4vsVJwrSvQ7f+fPNFxSDJ2Sh1fG7ivfUJI8N75yOcw
         kJ7obHNgX+4no4XOQheutxgZyJWDPfspzBu5fEbU2EHuB764OrsI0ivBIgAQhdmIx08p
         BvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7abLUKvfL513QAFSaGq2FlNA+/gNLlKgxsoNfFkz71Q=;
        b=scZer9NUlFMT4/iLl+FKOf4HuJ2ZnqiwcVhY8Wkuf0iENaz9w1zok2M1YU0pl99SAK
         78rxQ/XkFJEmWr2ZaQy2QBz9akvHAcVk0vKr7LhVrOKFGCl79JJlLZkKpCdVbCXVXri+
         ur3Et933sfo6CjSDmJi5e6Y09WH0EsN1LRqPQdzD/RHFP+tQbXeooYbsqqrmto02jmcI
         rRweZJbT33fMdHBPknnmU1OE3tdKw5kiON0rBg5K1MyvkWmGFmgq4Wg97XfrnKSTKetu
         3ONukgM5u8p5Fk6j5hrMklDul3T3fkUHiiyw84cjxWwS3uGGlO1k5HqpuPsqbu5lQnL4
         6Dfg==
X-Gm-Message-State: ACrzQf2X6LI3viamzDiuGExy2zRzOq9G4yW5ulUT9CE+f2igScm4M57O
        B1isFDrUTy49TqtJdY+8LisLbQ8/eQ==
X-Google-Smtp-Source: AMsMyM4AOPVeX6O6SMv4SCnvGU0VzNgzj9XEcJg1kKd63RW68m9UljlGzZdrBM8FICLmS1FlRAWoRPyjmA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3b03:2ab7:7f10:fc94])
 (user=elver job=sendgmr) by 2002:a81:5003:0:b0:368:40be:6e47 with SMTP id
 e3-20020a815003000000b0036840be6e47mr12022330ywb.477.1667208921550; Mon, 31
 Oct 2022 02:35:21 -0700 (PDT)
Date:   Mon, 31 Oct 2022 10:35:13 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221031093513.3032814-1-elver@google.com>
Subject: [PATCH] perf: Improve missing SIGTRAP checking
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
        syzbot+b8ded3e2e2c6adde4990@syzkaller.appspotmail.com
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

To catch missing SIGTRAP we employ a WARN in __perf_event_overflow(),
which fires if pending_sigtrap was already set: returning to user space
without consuming pending_sigtrap, and then having the event fire again
would re-enter the kernel and trigger the WARN.

This, however, seemed to miss the case where some events not associated
with progress in the user space task can fire and the interrupt handler
runs before the IRQ work meant to consume pending_sigtrap (and generate
the SIGTRAP).

syzbot gifted us this stack trace:

 | WARNING: CPU: 0 PID: 3607 at kernel/events/core.c:9313 __perf_event_overflow
 | Modules linked in:
 | CPU: 0 PID: 3607 Comm: syz-executor100 Not tainted 6.1.0-rc2-syzkaller-00073-g88619e77b33d #0
 | Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
 | RIP: 0010:__perf_event_overflow+0x498/0x540 kernel/events/core.c:9313
 | <...>
 | Call Trace:
 |  <TASK>
 |  perf_swevent_hrtimer+0x34f/0x3c0 kernel/events/core.c:10729
 |  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 |  __hrtimer_run_queues+0x1c6/0xfb0 kernel/time/hrtimer.c:1749
 |  hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 |  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1096 [inline]
 |  __sysvec_apic_timer_interrupt+0x17c/0x640 arch/x86/kernel/apic/apic.c:1113
 |  sysvec_apic_timer_interrupt+0x40/0xc0 arch/x86/kernel/apic/apic.c:1107
 |  asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
 | <...>
 |  </TASK>

In this case, syzbot produced a program with event type
PERF_TYPE_SOFTWARE and config PERF_COUNT_SW_CPU_CLOCK. The hrtimer
manages to fire again before the IRQ work got a chance to run, all while
never having returned to user space.

Improve the WARN to check for real progress in user space: approximate
this by storing a 32-bit hash of the current IP into pending_sigtrap,
and if an event fires while pending_sigtrap still matches the previous
IP, we assume no progress (false negatives are possible given we could
return to user space and trigger again on the same IP).

Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
Reported-by: syzbot+b8ded3e2e2c6adde4990@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/core.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 068412fe8dff..f87030487d9b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9312,14 +9312,27 @@ static int __perf_event_overflow(struct perf_event *event,
 	}
 
 	if (event->attr.sigtrap) {
-		/*
-		 * Should not be able to return to user space without processing
-		 * pending_sigtrap (kernel events can overflow multiple times).
-		 */
-		WARN_ON_ONCE(event->pending_sigtrap && event->attr.exclude_kernel);
+		unsigned int pending_id = 1;
+
+		if (regs)
+			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
 		if (!event->pending_sigtrap) {
-			event->pending_sigtrap = 1;
+			event->pending_sigtrap = pending_id;
 			local_inc(&event->ctx->nr_pending);
+		} else if (event->attr.exclude_kernel) {
+			/*
+			 * Should not be able to return to user space without
+			 * consuming pending_sigtrap; with exceptions:
+			 *
+			 *  1. Where !exclude_kernel, events can overflow again
+			 *     in the kernel without returning to user space.
+			 *
+			 *  2. Events that can overflow again before the IRQ-
+			 *     work without user space progress (e.g. hrtimer).
+			 *     To approximate progress (with false negatives),
+			 *     check 32-bit hash of the current IP.
+			 */
+			WARN_ON_ONCE(event->pending_sigtrap != pending_id);
 		}
 		event->pending_addr = data->addr;
 		irq_work_queue(&event->pending_irq);
-- 
2.38.1.273.g43a17bfeac-goog

