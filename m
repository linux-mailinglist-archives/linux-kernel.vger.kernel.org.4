Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EF067580C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjATPE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjATPEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:04:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F0D7CCC1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674227013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iRsFgdyFm9aCh9hJwwja26lzouAKLjx2fwTp+CTHC4=;
        b=NeBGpfJuLOkvMoRl6iRI/RQzWMebyjXrhuvP/kniEbjccQ0kxvmIiEPg5Van3hOi73TXky
        r74zGYPbgeIbjTC6Oq0sYQjJ9DtLtGg4nOXVvrKB36mbQ/yQRzU6U+ghvUeBVVeJmhElgN
        WJLn1hZL1rYbn7qflw1SbAbP40s6nsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-0x9ArX0hPPaHNE5UgIfsEQ-1; Fri, 20 Jan 2023 10:03:26 -0500
X-MC-Unique: 0x9ArX0hPPaHNE5UgIfsEQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACE998588E7;
        Fri, 20 Jan 2023 15:03:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5AA8492B03;
        Fri, 20 Jan 2023 15:03:20 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/4] sched/deadline: fix inactive_task_timer splat
Date:   Fri, 20 Jan 2023 12:02:40 -0300
Message-Id: <20230120150246.20797-3-wander@redhat.com>
In-Reply-To: <20230120150246.20797-1-wander@redhat.com>
References: <20230120150246.20797-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inactive_task_timer() executes in interrupt (atomic) context. It calls
put_task_struct(), which indirectly acquires sleeping locks under
PREEMPT_RT.

Below is an example of a splat that happened in a test environment:

 CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
 Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
 Call Trace:
 dump_stack_lvl+0x57/0x7d
 mark_lock_irq.cold+0x33/0xba
 ? stack_trace_save+0x4b/0x70
 ? save_trace+0x55/0x150
 mark_lock+0x1e7/0x400
 mark_usage+0x11d/0x140
 __lock_acquire+0x30d/0x930
 lock_acquire.part.0+0x9c/0x210
 ? refill_obj_stock+0x3d/0x3a0
 ? rcu_read_lock_sched_held+0x3f/0x70
 ? trace_lock_acquire+0x38/0x140
 ? lock_acquire+0x30/0x80
 ? refill_obj_stock+0x3d/0x3a0
 rt_spin_lock+0x27/0xe0
 ? refill_obj_stock+0x3d/0x3a0
 refill_obj_stock+0x3d/0x3a0
 ? inactive_task_timer+0x1ad/0x340
 kmem_cache_free+0x357/0x560
 inactive_task_timer+0x1ad/0x340
 ? switched_from_dl+0x2d0/0x2d0
 __run_hrtimer+0x8a/0x1a0
 __hrtimer_run_queues+0x91/0x130
 hrtimer_interrupt+0x10f/0x220
 __sysvec_apic_timer_interrupt+0x7b/0xd0
 sysvec_apic_timer_interrupt+0x4f/0xd0
 ? asm_sysvec_apic_timer_interrupt+0xa/0x20
 asm_sysvec_apic_timer_interrupt+0x12/0x20
 RIP: 0033:0x7fff196bf6f5

Use put_task_struct_atomic_safe() instead.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0d97d54276cc..03400c61a994 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1442,7 +1442,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	dl_se->dl_non_contending = 0;
 unlock:
 	task_rq_unlock(rq, p, &rf);
-	put_task_struct(p);
+	put_task_struct_atomic_safe(p);
 
 	return HRTIMER_NORESTART;
 }
-- 
2.39.0

