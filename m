Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C3B5F7950
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJGN6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJGN6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:58:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8579AC90D0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:58:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o21so11445801ejm.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AP/oJRI89Z7SdscCK80uHrEIj3Uy4MR+Wink1jXvZa4=;
        b=cOU+Ngw77btloon+LB49N1sb+m7ShyWtqA/MhXIbjwZo/v+hUUJVpeG+8z6N4ZodzV
         PKPsBC59tQSQ7VKGTyRMZYqi8hBbxo3g7etiU9dJjrB04rYSNHf+X7EPdh+K9z19dIJ9
         o+ursUUw/mhVZ5/MWe7z0qaEbBR0DN6uiq574FgiTusJlroyyrPCgb3AeLi0/1MQsCR3
         TgZifXoGODyaO3rPyq9Z68/QPbq87PdTlcvb8oRiq+CRwtm+u2APjyB847G48Ggo9+s9
         0uWkMGYuqaWX51M+xCI8aEPhpSiiod9dX4K8xndD1HeMiwWtrQscum8mN16XvkHB7tk7
         80Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AP/oJRI89Z7SdscCK80uHrEIj3Uy4MR+Wink1jXvZa4=;
        b=WYe6epKFSboWXGw07Fhg/iZ8YR1w3unoFsFSamBPlFQU0XDDILbQ0P5fu4rRT0Kjeh
         g74EwybKKLzJ8kOqWsfpUkHL+VMmX6mE9GCAnRYe0iFbMgKltJ5UOvXSRtDPfe49v+Ka
         xwrBluuj5AZgec8d9a7aL4v5mf2Y1T1uHzvEXdon7LVZtFzgjpH9+jgp15oj80FxTXbo
         oiTPuG5Usbhu8iKsH+HshrF5UIXdRhLCZqSRycgntWc4Qa0s2WPrkNiu3mer0kuitCdJ
         FZJQnlwJ2HGXUK82aczBTF2p0J2rSCmOv8azE9qBpk0wIdQb74+aNdFIMvc77wacS3Ao
         IGEA==
X-Gm-Message-State: ACrzQf2r9+fkjKSeX/B2RZjgJWdvJznUgUAAZu6UlttPeVum6Bpqwo6U
        4tsBqTloGMSDKeXlLW26aeQFjEPxB0LNPQ==
X-Google-Smtp-Source: AMsMyM6o3dEs42Movv5rqRS3uwCBX67YsY34e3v+QnTac6Dp4W6WEQfJ7F16XkJfbZzIyLzG5VzHbg==
X-Received: by 2002:a17:907:2cd8:b0:776:64a8:1adf with SMTP id hg24-20020a1709072cd800b0077664a81adfmr4204610ejc.151.1665151091895;
        Fri, 07 Oct 2022 06:58:11 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:4e4:454c:b135:33f2])
        by smtp.gmail.com with ESMTPSA id o6-20020a170906768600b00773c60c2129sm1266134ejm.141.2022.10.07.06.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 06:58:11 -0700 (PDT)
Date:   Fri, 7 Oct 2022 15:58:03 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs
Message-ID: <Y0AwaxcJNOWhMKXP@elver.google.com>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Yz7fWw8duIOezSW1@elver.google.com>
 <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
 <Yz/zXpF1yLshrJm/@elver.google.com>
 <Y0Ak/D05KhJeKaed@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0Ak/D05KhJeKaed@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 03:09PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 07, 2022 at 11:37:34AM +0200, Marco Elver wrote:
> 
> > That worked. In addition I had to disable the ctx->task != current check
> > if we're in task_work, because presumably the event might have already
> > been disabled/moved??
> 
> Uhmmm... uhhh... damn. (wall-time was significantly longer)
> 
> Does this help?

No unfortunately - still see:

[   82.300827] ------------[ cut here ]------------
[   82.301680] WARNING: CPU: 0 PID: 976 at kernel/events/core.c:6466 perf_sigtrap+0x60/0x70
[   82.303069] Modules linked in:
[   82.303524] CPU: 0 PID: 976 Comm: missed_breakpoi Not tainted 6.0.0-rc3-00017-g1472d7e42f41-dirty #68
[   82.304825] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[   82.306204] RIP: 0010:perf_sigtrap+0x60/0x70
[   82.306858] Code: e6 59 fa ff 48 8b 93 50 01 00 00 8b b3 d8 00 00 00 48 8b bb 30 04 00 00 e8 dd cf e8 ff 5b 5d e9 c6 59 fa ff e8 c1 59 fa ff 90 <0f> 0b 90 5b 5d e9 b6 59 fa ff 66 0f 1f 44 00 00 e8 ab 59 fa ff bf
[   82.309515] RSP: 0000:ffffa52041cbbee0 EFLAGS: 00010293
[   82.310295] RAX: 0000000000000000 RBX: ffff902fc966a228 RCX: ffffffffa761a53f
[   82.311336] RDX: ffff902fca39c340 RSI: 0000000000000000 RDI: ffff902fc966a228
[   82.312376] RBP: ffff902fca39c340 R08: 0000000000000001 R09: 0000000000000001
[   82.313412] R10: 00000000ffffffff R11: 00000000ffffffff R12: ffff902fca39cbf0
[   82.314456] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   82.315561] FS:  00007fbae0636700(0000) GS:ffff9032efc00000(0000) knlGS:0000000000000000
[   82.316815] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   82.317708] CR2: 000000001082d318 CR3: 0000000109430002 CR4: 0000000000770ef0
[   82.318839] DR0: 00000000008aca98 DR1: 00000000008acb38 DR2: 00000000008acae8
[   82.319955] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[   82.321068] PKRU: 55555554
[   82.321505] Call Trace:
[   82.321913]  <TASK>
[   82.322267]  perf_pending_task+0x7d/0xa0
[   82.322900]  task_work_run+0x73/0xc0
[   82.323476]  exit_to_user_mode_prepare+0x19d/0x1a0
[   82.324209]  irqentry_exit_to_user_mode+0x6/0x30
[   82.324887]  asm_sysvec_call_function_single+0x16/0x20
[   82.325623] RIP: 0033:0x27d10b
[   82.326092] Code: 43 08 48 8d 04 80 48 c1 e0 04 48 8d 0d 5e f9 62 00 48 01 c8 48 83 c0 08 b9 01 00 00 00 66 90 48 8b 10 48 39 ca 75 f8 88 48 41 <f0> 48 ff 40 08 48 8b 50 10 48 39 ca 75 f7 88 48 43 f0 48 ff 40 18
[   82.328696] RSP: 002b:00007fbae0635a60 EFLAGS: 00000246
[   82.329470] RAX: 00000000008acaa8 RBX: 000024073fc007d0 RCX: 0000000000001add
[   82.330521] RDX: 0000000000001add RSI: 0000000000000070 RDI: 0000000000000007
[   82.331557] RBP: 00007fbae0635a70 R08: 00007fbae0636700 R09: 00007fbae0636700
[   82.332593] R10: 00007fbae06369d0 R11: 0000000000000202 R12: 00007fbae06369d0
[   82.333630] R13: 00007ffe8139de16 R14: 00007fbae0636d1c R15: 00007fbae0635a80
[   82.334713]  </TASK>
[   82.335093] irq event stamp: 546455
[   82.335657] hardirqs last  enabled at (546465): [<ffffffffa7513ef6>] __up_console_sem+0x66/0x70
[   82.337032] hardirqs last disabled at (546476): [<ffffffffa7513edb>] __up_console_sem+0x4b/0x70
[   82.338414] softirqs last  enabled at (546084): [<ffffffffa8c0034f>] __do_softirq+0x34f/0x4d5
[   82.339769] softirqs last disabled at (546079): [<ffffffffa7493821>] __irq_exit_rcu+0xb1/0x120
[   82.341128] ---[ end trace 0000000000000000 ]---

I now have this on top:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9319af6013f1..7de83c42d312 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2285,9 +2285,10 @@ event_sched_out(struct perf_event *event,
 			 */
 			local_dec(&event->ctx->nr_pending);
 		} else {
-			WARN_ON_ONCE(event->pending_work);
-			event->pending_work = 1;
-			task_work_add(current, &event->pending_task, TWA_RESUME);
+			if (!event->pending_work) {
+				event->pending_work = 1;
+				task_work_add(current, &event->pending_task, TWA_RESUME);
+			}
 		}
 	}
 
@@ -6466,7 +6467,8 @@ static void perf_sigtrap(struct perf_event *event)
 		return;
 
 	/*
-	 * perf_pending_irq() can race with the task exiting.
+	 * Both perf_pending_task() and perf_pending_irq() can race with the
+	 * task exiting.
 	 */
 	if (current->flags & PF_EXITING)
 		return;
@@ -6495,8 +6497,8 @@ static void __perf_pending_irq(struct perf_event *event)
 	if (cpu == smp_processor_id()) {
 		if (event->pending_sigtrap) {
 			event->pending_sigtrap = 0;
-			local_dec(&event->ctx->nr_pending);
 			perf_sigtrap(event);
+			local_dec(&event->ctx->nr_pending);
 		}
 		if (event->pending_disable) {
 			event->pending_disable = 0;
@@ -6563,16 +6565,18 @@ static void perf_pending_task(struct callback_head *head)
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
 	 */
+	preempt_disable_notrace();
 	rctx = perf_swevent_get_recursion_context();
 
 	if (event->pending_work) {
 		event->pending_work = 0;
-		local_dec(&event->ctx->nr_pending);
 		perf_sigtrap(event);
+		local_dec(&event->ctx->nr_pending);
 	}
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
+	preempt_enable_notrace();
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS

I'm throwing more WARN_ON()s at it to see what's going on...
