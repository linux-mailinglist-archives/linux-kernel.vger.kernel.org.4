Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0568BD33
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjBFMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBFMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:47:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F2A5FD1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675687618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1d0rh3nWEoqZY/ZNuGhezgAsd8sE5EE9U2j8wF/dmyw=;
        b=b5Djzwh9SIQVjA5QqtOHOmtT0Xb9OaaPCqJsqeXRcdlRFYADg/S/JpGYY1FCTh9/j1wAl3
        KluZWF8Kvj059pHjfRU9jyvdhxZFThgLI7fqwHy6/0erLij7SPL29SfwGNRM0ZkyBjz9Ow
        zNzgAkFtAHz5yysbpe2RsmzqZPh29v8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-Bdp1HkVkOJ209mxf2GprHg-1; Mon, 06 Feb 2023 07:46:54 -0500
X-MC-Unique: Bdp1HkVkOJ209mxf2GprHg-1
Received: by mail-qv1-f70.google.com with SMTP id k15-20020a0cd68f000000b00535261af1b1so5796589qvi.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 04:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1d0rh3nWEoqZY/ZNuGhezgAsd8sE5EE9U2j8wF/dmyw=;
        b=FqwhFDr2qUXwoYvY3WdaTCGPt0nXgJgUJoLoOWnmMLcbhau/324CIMXA7cXyX+y1oz
         T7qqFUhijRTA3jT+7utoqiLtSbENdzqk0GOJEYD6zg4f4j9gzH+nkQxgfm6KXtPyoiPN
         pvqQD4anhlRn77Rzyy5q7bdMofq8jZB6PBvSMwVCsrVlanptHiPhyK47ey9wBUr5Tivd
         TI4u0FtYiKMIboixtef0b5yYlzbCMZmm4jOSLWNpHBPQGs78cKrHrsmV47rZpjtMx6Cv
         tIuvY+/wXBtbdNylAgTvpFFYEP8mo4R9MQo4B/ZZvgsd1OQJ/UpeXyoMYxYzKV1fDWO/
         5W8Q==
X-Gm-Message-State: AO0yUKU4r7FvUmbnTNvQIqZfOfZb/UYSZ34EEniEtouQeIpod6NcNOP0
        R5IBVr4pPAZqFN4D/rzapFoqQjwxzpB0wYiUGn2Ps+h0U0mB7+Ql73ytKwMZqiEba90ilJLQzvR
        dsmiIfubKXeV29nAq5SLRlYrm
X-Received: by 2002:ac8:7f8e:0:b0:3b9:2b0:5e7a with SMTP id z14-20020ac87f8e000000b003b902b05e7amr35238656qtj.25.1675687614290;
        Mon, 06 Feb 2023 04:46:54 -0800 (PST)
X-Google-Smtp-Source: AK7set+Redv3mmetoUzlPGwkO8XZL0q4qme5pGLoZKixQ1KEVHI8kVvC0q/t9IuGl4QDkecF/nCN4w==
X-Received: by 2002:ac8:7f8e:0:b0:3b9:2b0:5e7a with SMTP id z14-20020ac87f8e000000b003b902b05e7amr35238629qtj.25.1675687614007;
        Mon, 06 Feb 2023 04:46:54 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id y18-20020ac87c92000000b003b630ea0ea1sm7093957qtv.19.2023.02.06.04.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 04:46:53 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Eder Zulian <ezulian@redhat.com>
Subject: Re: [RFC PATCH v1] sched/deadline: Add more reschedule cases to
 prio_changed_dl()
In-Reply-To: <Y9yydSfMvTHhyEqP@localhost.localdomain>
References: <20230202182854.3696665-1-vschneid@redhat.com>
 <Y9yydSfMvTHhyEqP@localhost.localdomain>
Date:   Mon, 06 Feb 2023 12:46:51 +0000
Message-ID: <xhsmhbkm7rmf8.mognet@vschneid.remote.csb>
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

On 03/02/23 08:06, Juri Lelli wrote:
> Hi,
>
> On 02/02/23 18:28, Valentin Schneider wrote:
>> I've been tracking down an issue on a ~5.17ish kernel where:
>>
>>   CPUx                           CPUy
>>
>>   <DL task p0 owns an rtmutex M>
>>   <p0 depletes its runtime, gets throttled>
>>   <rq switches to the idle task>
>>                               <DL task p1 blocks on M, boost/replenish p0>
>>                               <No call to resched_curr() happens here>
>>
>>   [idle task keeps running here until *something*
>>    accidentally sets TIF_NEED_RESCHED]
>>
>> On that kernel, it is quite easy to trigger using rt-tests's deadline_test
>> [1] with the test running on isolated CPUs (this reduces the chance of
>> something unrelated setting TIF_NEED_RESCHED on the idle tasks, making the
>> issue even more obvious as the hung task detector chimes in).
>>
>> I haven't been able to reproduce this using a mainline kernel, even if I
>> revert
>>
>>   2972e3050e35 ("tracing: Make trace_marker{,_raw} stream-like")
>>
>> which gets rid of the lock involved in the above test, *but* I cannot
>> convince myself the issue isn't there from looking at the code.
>>
>> Make prio_changed_dl() issue a reschedule if the current task isn't a
>> deadline one. While at it, ensure a reschedule is emitted when a
>> queued-but-not-current task gets boosted with an earlier deadline that
>> current's.
>
> As discussed offline I agree this needs fixing, but .. :)
>
>> [1]: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  kernel/sched/deadline.c | 45 ++++++++++++++++++++++++++---------------
>>  1 file changed, 29 insertions(+), 16 deletions(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 0d97d54276cc8..faa382ea084c1 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2663,17 +2663,28 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
>>  static void prio_changed_dl(struct rq *rq, struct task_struct *p,
>>                          int oldprio)
>>  {
>> -	if (task_on_rq_queued(p) || task_current(rq, p)) {
>> -#ifdef CONFIG_SMP
>
> Doesn't this break UP? Don't think earlierst_dl etc are defined in UP.
>

Indeed, I thought myself clever by getting rid of the ifdefs...

> Thanks,
> Juri

