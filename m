Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5161F808
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiKGPzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiKGPzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:55:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5271A3BA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667836486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YabqmVzhZdls/3EUqgs8pshTJ7VCeuwq0mqH1C9NSOU=;
        b=ExFCCtQVFRlYG8W/plmTOi2Hfx4gxknVEg4Hz1q0HJVmLiCY0wAljyEWu3WNEk9x82dSbm
        WRHyF7gDpW7oP2SJLRS9pSCGNUn0xpPfJfXMVWsXE/pBugTi7z3n1tDGTjageQuiRCrX3q
        BT/YTmcxh8Dk7f0rJfPPMDDvzYsJeAo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-136-HcfnB_dGP-K7m-uJuOwP9A-1; Mon, 07 Nov 2022 10:54:45 -0500
X-MC-Unique: HcfnB_dGP-K7m-uJuOwP9A-1
Received: by mail-wm1-f69.google.com with SMTP id h8-20020a1c2108000000b003cf550bfc8dso8628482wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 07:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YabqmVzhZdls/3EUqgs8pshTJ7VCeuwq0mqH1C9NSOU=;
        b=tt65MJMBRGfwCvXTYWsmSMl8tJLPe9m/Ld4WStS9IGW1qTOPMZZnJvIX/na2WQmPFz
         Q9WpoM6Q3rXlh1GhpeaanpKY9HKbrbsax2oUk6kTUeKq66pPza8/VY1q8ar4AWy+53P8
         d5ijZCT4XcUg7t7bPZWD81JddAjkoYrn0cFq1QR1SiMhzm36uc4kk82HwgelrZc5xa8x
         rNHOhOF55uQ1KtKjMEhmEVV4i8KUQ7Q1oExPtkAavA0xH77SWGtHZGUX4VEmioB+S8ZY
         Af3T+Z839p7/CGHJHTXD6NCc/wlMT/tKdgmUmExjjItpYwFiWhCrC5Tw6eveHljWYF9q
         r5gQ==
X-Gm-Message-State: ACrzQf2SOEZoVs+d4WEROu+Fv7uILzTsPayznkECsXTsPvndh8cgB8qD
        OxDU8oiNJtWCHoy1dUY+8vnky4cW+c2s4oJ6P0cn9Ctuh73Bx0v+51kAX/x5gSrZ9V42BPCoZg5
        njqJdk595D/6vDgwUEtoBqD/6CTY+E3mVZCpiOIjJJZuWoQ4oNvgDNqthlP+bB+VMaV8rSp050Y
        E2
X-Received: by 2002:a05:600c:1609:b0:3cf:4dc4:5a99 with SMTP id m9-20020a05600c160900b003cf4dc45a99mr34003218wmn.67.1667836480388;
        Mon, 07 Nov 2022 07:54:40 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7wRSURd/j/gH4rr4MXh6mv5jpGHd7t9wOiujsPklT7XdHS28jX3FXYjxwWgWhZ6dW2niIyeA==
X-Received: by 2002:a05:600c:1609:b0:3cf:4dc4:5a99 with SMTP id m9-20020a05600c160900b003cf4dc45a99mr34003194wmn.67.1667836480094;
        Mon, 07 Nov 2022 07:54:40 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id f17-20020a056000129100b002368a6deaf8sm7697217wrx.57.2022.11.07.07.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:54:39 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Minor optimize ttwu_runnable()
In-Reply-To: <346228d3-8b80-4e9b-0157-662429b11a05@bytedance.com>
References: <20221102102343.57845-1-zhouchengming@bytedance.com>
 <xhsmhr0yivazl.mognet@vschneid.remote.csb>
 <7b8bd69a-39cb-a1f0-6ccd-7b0810ef0db7@bytedance.com>
 <xhsmhwn86ncrs.mognet@vschneid.remote.csb>
 <346228d3-8b80-4e9b-0157-662429b11a05@bytedance.com>
Date:   Mon, 07 Nov 2022 15:54:38 +0000
Message-ID: <xhsmhtu3an4jl.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/22 21:19, Chengming Zhou wrote:
> On 2022/11/7 20:56, Valentin Schneider wrote:
>>
>> So p is still on the rq for sure, but it may not be the currently running
>> task. Consider, on a CONFIG_PREEMPT kernel, task p0 in a wait loop:
>>
>> 0    for (;;) {
>> 1       set_current_state(TASK_UNINTERRUPTIBLE);
>> 2
>> 3       if (CONDITION)
>> 4          break;
>> 5
>> 6       schedule();
>> 7    }
>> 8    __set_current_state(TASK_RUNNING);
>>
>> Now further consider p0 executes line 1, but then gets interrupted by an
>> IRQ, at the end of which preempt_schedule_irq() happens. We enter
>> __schedule(SM_PREEMPT), so p0 isn't dequeued due to its non-zero task
>> state, but we *can* end up switching the CPU's current task.
>
> Thank you very much for this detailed explanation, I get it. Yes, this
> process can be seen on CONFIG_PREEMPT kernel.
>
>>
>> ISTR that's why Peter renamed that function ttwu_*runnable*() and not
>> ttwu_*running*().
>
> So this task p didn't really sleep, it's preempted, later scheduled in,
> get to execute line 6 schedule(), but its state has been set to TASK_RUNNING,
> it won't deactivate_task(p).
>

Right!

> Looks like this patch is still reasonable? Should I put this detailed
> explanation in the changelog and send v2?
>

So that's the part for the p->sched_class->task_woken() callback, which
only affects RT and DL (and only does something when !p->on_cpu). I *think*
it's fine to remove it from ttwu_runnable() as any push/pull should have
happened when other tasks were enqueued on the same CPU - with that said,
it wouldn't hurt to double check this :-)


As for the check_preempt_curr(), since per the above p can be preempted,
you could have scenarios right now with CFS tasks where
ttwu_runnable()->check_preempt_curr() causes NEED_RESCHED to be set.

e.g. p0 does

  set_current_state(TASK_UNINTERRUPTIBLE)

but then gets interrupted by the tick, a p1 gets selected to run instead
because of check_preempt_tick(), and then runs long enough to have
check_preempt_curr() decide to let p0 preempt p1.

That does require specific timing (lower tick frequency should make this
more likely) and probably task niceness distribution too, but isn't
impossible.

Maybe try reading p->on_cpu, and only do the quick task state update if
it's still the current task, otherwise do the preemption checks?

> Thanks!
>

