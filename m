Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB96EF995
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbjDZRpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjDZRpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C601635A5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682531082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFOLtpyLHj3LQRxvCiN2SdOhFROyPdkOD9iReg1b+zE=;
        b=SlqezUK5daOJ9cslzsv8AQ0SNutholTpLcPT7fVwDial9YMAwN4PUcFYMZHSskvvF80o55
        4mu5G4FJ/i7yqbWiQugxiobJ9kz8ehjWxFkZXx4k6iK9Xg5YxSzx5jFsnIkvdU+6WfYxBJ
        283YaZjQ/XhPXkTfyYQgaIr7eCb1UPI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-uMUD12DJNoaicn7Sa1VlPg-1; Wed, 26 Apr 2023 13:44:37 -0400
X-MC-Unique: uMUD12DJNoaicn7Sa1VlPg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2A75101A550;
        Wed, 26 Apr 2023 17:44:35 +0000 (UTC)
Received: from [10.22.18.92] (unknown [10.22.18.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12DA0492C13;
        Wed, 26 Apr 2023 17:44:34 +0000 (UTC)
Message-ID: <1ec831dd-1070-d1f0-1502-5b8e493caab0@redhat.com>
Date:   Wed, 26 Apr 2023 13:44:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 0/3] Introduce put_task_struct_atomic_sleep()
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>
References: <20230425114307.36889-1-wander@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230425114307.36889-1-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 07:43, Wander Lairson Costa wrote:
> The put_task_struct() function reduces a usage counter and invokes
> __put_task_struct() when the counter reaches zero.
>
> In the case of __put_task_struct(), it indirectly acquires a spinlock,
> which operates as a sleeping lock under the PREEMPT_RT configuration.
> As a result, invoking put_task_struct() within an atomic context is
> not feasible for real-time (RT) kernels.
>
> One practical example is a splat inside inactive_task_timer(), which is
> called in a interrupt context:
>
> CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
> Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
> Call Trace:
>   dump_stack_lvl+0x57/0x7d
>   mark_lock_irq.cold+0x33/0xba
>   ? stack_trace_save+0x4b/0x70
>   ? save_trace+0x55/0x150
>   mark_lock+0x1e7/0x400
>   mark_usage+0x11d/0x140
>   __lock_acquire+0x30d/0x930
>   lock_acquire.part.0+0x9c/0x210
>   ? refill_obj_stock+0x3d/0x3a0
>   ? rcu_read_lock_sched_held+0x3f/0x70
>   ? trace_lock_acquire+0x38/0x140
>   ? lock_acquire+0x30/0x80
>   ? refill_obj_stock+0x3d/0x3a0
>   rt_spin_lock+0x27/0xe0
>   ? refill_obj_stock+0x3d/0x3a0
>   refill_obj_stock+0x3d/0x3a0
>   ? inactive_task_timer+0x1ad/0x340
>   kmem_cache_free+0x357/0x560
>   inactive_task_timer+0x1ad/0x340
>   ? switched_from_dl+0x2d0/0x2d0
>   __run_hrtimer+0x8a/0x1a0
>   __hrtimer_run_queues+0x91/0x130
>   hrtimer_interrupt+0x10f/0x220
>   __sysvec_apic_timer_interrupt+0x7b/0xd0
>   sysvec_apic_timer_interrupt+0x4f/0xd0
>   ? asm_sysvec_apic_timer_interrupt+0xa/0x20
>   asm_sysvec_apic_timer_interrupt+0x12/0x20
> RIP: 0033:0x7fff196bf6f5
>
> To address this issue, this patch series introduces a new function
> called put_task_struct_atomic_safe(). When compiled with the
> PREEMPT_RT configuration, this function defers the call to
> __put_task_struct() to a process context.
>
> Additionally, the patch series rectifies known problematic call sites
> to ensure smooth functioning.
>
> Changelog
> =========
>
> v1:
> * Initial implementation fixing the splat.
>
> v2:
> * Isolate the logic in its own function.
> * Fix two more cases caught in review.
>
> v3:
> * Change __put_task_struct() to handle the issue internally.
>
> v4:
> * Explain why call_rcu() is safe to call from interrupt context.
>
> v5:
> * Explain why __put_task_struct() doesn't conflict with
>    put_task_sruct_rcu_user.
>
> v6:
> * As per Sebastian's review, revert back the implementation of v2
>    with a distinct function.
> * Add a check in put_task_struct() to warning when called from a
>    non-sleepable context.
> * Address more call sites.
>
> v7:
> * Fix typos.
> * Add an explanation why the new function doesn't conflict with
>    delayed_free_task().
>
> Wander Lairson Costa (3):
>    sched/core: warn on call put_task_struct in invalid context
>    sched/task: Add the put_task_struct_atomic_safe() function
>    treewide: replace put_task_struct() with the atomic safe version
>
>   include/linux/sched/task.h | 49 ++++++++++++++++++++++++++++++++++++++
>   kernel/events/core.c       |  6 ++---
>   kernel/fork.c              |  8 +++++++
>   kernel/locking/rtmutex.c   | 10 ++++----
>   kernel/sched/core.c        |  6 ++---
>   kernel/sched/deadline.c    | 16 ++++++-------
>   kernel/sched/rt.c          |  4 ++--
>   7 files changed, 78 insertions(+), 21 deletions(-)

This patch series looks good to me.

Acked-by: Waiman Long <longman@redhat.com>

I notice that __put_task_struct() invokes quite a bit of cleanup works 
from different subsystems. So it may burn quite a bit of cpu cycles to 
complete. This may not be something we want in an atomic context, maybe 
we should call call_rcu() irrespective of the PREEMPT_RT setting. 
Anyway, this can be a follow-up patch if we want to do that.

Cheers,
Longman

