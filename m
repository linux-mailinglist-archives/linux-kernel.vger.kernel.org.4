Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E5961F3D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiKGM6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiKGM57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:57:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463411C118
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667825821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Co6dmU2AipNRyEGi67jLUQspN4s6/EcY08afZyYotKg=;
        b=aIzc1h+xsSD8OzVYrR25MUwbrCyXVFL670lhuB/aArM9Kii2hytQ/eWCrWEvo8ijy96BBZ
        T49QQHOTDma5Mi28D8/o39igO7YSZYpm7JCzENt9qUrIjyHhrZSyOncg2flr5i1gsQwdtc
        YXDduFVSygLQIKgx3GB+wp7U3QOm08Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-BIay95aQMG-h8Cyr75fZmA-1; Mon, 07 Nov 2022 07:56:59 -0500
X-MC-Unique: BIay95aQMG-h8Cyr75fZmA-1
Received: by mail-wm1-f71.google.com with SMTP id s7-20020a1cf207000000b003cf56bad2e2so3066723wmc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Co6dmU2AipNRyEGi67jLUQspN4s6/EcY08afZyYotKg=;
        b=OsjG5bfaSH3XBidneVzxUF7GyBpDca2Gj+SU9ujA49oP4JDX197AOSYdxV9vKOeJxO
         nqJe6er9lT/eWbC+jyhWzu53di/aFV7fdSnEq1hsVsnAbFFPBCQvwN++lfeOsl10A9mY
         INKAkIAcTD3FSUkWgNtGglMWjKVKTxfioJ0OzpzPM3RJwKAYkc3otoLMGDzftNr1mERl
         OJIUrTLoAiErYjNrZTv3B1V4vCPXrBnw6X3kITzYWKJQ40dnxnSSf9Ra3mGkbIR1bHr5
         6dEpPfDXXjuId0rg7Yh8+9xpZwbdtseDvuyseSqldE31oo4VtT4SU50oUOhKFAeb0U4c
         Bg8A==
X-Gm-Message-State: ACrzQf0+S41KdrtCpoywGbR9Xr8kbIsDPNsje12fFqTkB8JO59GMVGV6
        jqA/s5O6NBwWQFo8UO8fF5qQuHhW3Je81ivnNzsw6nPkFQDwoavvwiqzA8pfqxUDbkkVPK7QaGp
        B/f/7K5lovHxxsFT2V9423rsZCT2OcDNVJv5F4iY8GWEiRq9T9wpPY1kA4tFwjAyGn87xJIeVNk
        zL
X-Received: by 2002:a7b:c3c4:0:b0:3c4:785a:36d7 with SMTP id t4-20020a7bc3c4000000b003c4785a36d7mr43821578wmj.138.1667825817707;
        Mon, 07 Nov 2022 04:56:57 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7xPXK9PWzkaGh5qFvQFx0xkYbRt6UfasmYGOz/OthTjuHChUjv94naPzKFxf9WFn6ijcMZIw==
X-Received: by 2002:a7b:c3c4:0:b0:3c4:785a:36d7 with SMTP id t4-20020a7bc3c4000000b003c4785a36d7mr43821555wmj.138.1667825817482;
        Mon, 07 Nov 2022 04:56:57 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d604f000000b00236705daefesm7186734wrt.39.2022.11.07.04.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:56:56 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Minor optimize ttwu_runnable()
In-Reply-To: <7b8bd69a-39cb-a1f0-6ccd-7b0810ef0db7@bytedance.com>
References: <20221102102343.57845-1-zhouchengming@bytedance.com>
 <xhsmhr0yivazl.mognet@vschneid.remote.csb>
 <7b8bd69a-39cb-a1f0-6ccd-7b0810ef0db7@bytedance.com>
Date:   Mon, 07 Nov 2022 12:56:55 +0000
Message-ID: <xhsmhwn86ncrs.mognet@vschneid.remote.csb>
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

On 05/11/22 09:34, Chengming Zhou wrote:
> On 2022/11/5 02:19, Valentin Schneider wrote:
>> On 02/11/22 18:23, Chengming Zhou wrote:
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 87c9cdf37a26..3785418de127 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -3718,9 +3718,8 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>>>
>>>       rq = __task_rq_lock(p, &rf);
>>>       if (task_on_rq_queued(p)) {
>>> -		/* check_preempt_curr() may use rq clock */
>>> -		update_rq_clock(rq);
>>> -		ttwu_do_wakeup(rq, p, wake_flags, &rf);
>>> +		WRITE_ONCE(p->__state, TASK_RUNNING);
>>> +		trace_sched_wakeup(p);
>>
>> This also loses the class->task_woken() call, AFAICT we could have
>> !p->on_cpu here (e.g. an IRQ hit before the task got to schedule()), but
>> then again if there is a need to push we should have done that at the IRQ
>> preempt via set_next_task_{rt, dl}()... So I'm starting to think this is
>> OK, but that needs elaborating in the changelog.
>
> Sorry, I don't get why we could have !p->on_cpu here?
>
> I thought if we have task_on_rq_queued(p) here, it means p hasn't got to
> __schedule() to deactivate_task(), so p should still be on_cpu?
>
> Thanks.
>

So p is still on the rq for sure, but it may not be the currently running
task. Consider, on a CONFIG_PREEMPT kernel, task p0 in a wait loop:

0    for (;;) {
1       set_current_state(TASK_UNINTERRUPTIBLE);
2
3       if (CONDITION)
4          break;
5
6       schedule();
7    }
8    __set_current_state(TASK_RUNNING);

Now further consider p0 executes line 1, but then gets interrupted by an
IRQ, at the end of which preempt_schedule_irq() happens. We enter
__schedule(SM_PREEMPT), so p0 isn't dequeued due to its non-zero task
state, but we *can* end up switching the CPU's current task.

ISTR that's why Peter renamed that function ttwu_*runnable*() and not
ttwu_*running*().

>>
>>
>>>               ret = 1;
>>>       }
>>>       __task_rq_unlock(rq, &rf);
>>> --
>>> 2.37.2
>>

