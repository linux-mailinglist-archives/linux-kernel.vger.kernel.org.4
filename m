Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C65668901E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjBCHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBCHHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:07:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E2B20683
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675407996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V3TCQfqKt1A0MuEx+OJF5RKyrF31u1zNDSiWDW03EO8=;
        b=hZbcs8W/BF92ME7F0Y55vSXxblF7AX+QRBSCjhHbjmQYwich+dqm4Ip6USfmTtvXDlpwN9
        OVacKboZdT4rUsH1dMifMGBV1xjarQlc6Zv4bWj7l52ymbpK/eaYj7MS7csXL4MMIRzbSo
        JZmgnY9qZF3pUNCYk/gzjR2HcJyJGzo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-374-9jPf3mMtPgyp9W46E5ceEQ-1; Fri, 03 Feb 2023 02:06:35 -0500
X-MC-Unique: 9jPf3mMtPgyp9W46E5ceEQ-1
Received: by mail-qv1-f71.google.com with SMTP id jh2-20020a0562141fc200b004c74bbb0affso2310649qvb.21
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 23:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3TCQfqKt1A0MuEx+OJF5RKyrF31u1zNDSiWDW03EO8=;
        b=v+gKn3pWxmhCQtR8kRP4MUHvYDpt1s5tDzFO2jucTcZAT6qEs5heSZcx8p3zxLgZpg
         eKHw+vWVUS1vfBwx3yRKk5qjJ/GaHYPAwFQ39V7QvHqgcssQjmTZqTpmj+Ef83oey52i
         SEBq9hSDzZuCEfjU6FaVJypA3ouzeR49xnafOQET/MxZT31igMDGzzoZ2LdX5HNI9OZF
         LGz4+U+p6g6Rn85mdp7OD9S4BxJMl1Pcy0mcRfn/gkCEV+FiIRzjzmBP1mXjjiadqvIm
         JPXTAW872gch1z0k90KfAWW78XjgpqytCbTLGCcEO7yRnY3qnLuUce5uxQMMK6NsKQrb
         skAg==
X-Gm-Message-State: AO0yUKWjYwOPCN2G39nFO+ftUx/iSuW9L6xTHNMKHSP9vs79PWUToXxB
        GppDnowYhGkam/E5P5AHPYAEf1H0ob2JeIXrQYddMovnuvCriIpS86gmVzE37KoTppY4+o7vvdU
        2Jk06lzcIMpbbuSB5iph0ToOw
X-Received: by 2002:ac8:5f8e:0:b0:3b9:e2a6:cb0b with SMTP id j14-20020ac85f8e000000b003b9e2a6cb0bmr6896499qta.12.1675407994412;
        Thu, 02 Feb 2023 23:06:34 -0800 (PST)
X-Google-Smtp-Source: AK7set+tAu4UzSTzGCHByyrM09TqVcbu/hIXYC9HP6+SOUmuarzgtCVdTRg5uFbYdJ2Zr9n4P7tQNg==
X-Received: by 2002:ac8:5f8e:0:b0:3b9:e2a6:cb0b with SMTP id j14-20020ac85f8e000000b003b9e2a6cb0bmr6896474qta.12.1675407994097;
        Thu, 02 Feb 2023 23:06:34 -0800 (PST)
Received: from localhost.localdomain ([151.29.157.139])
        by smtp.gmail.com with ESMTPSA id g15-20020ac87f4f000000b003b86b99690fsm1129550qtk.62.2023.02.02.23.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:06:33 -0800 (PST)
Date:   Fri, 3 Feb 2023 08:06:29 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
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
Message-ID: <Y9yydSfMvTHhyEqP@localhost.localdomain>
References: <20230202182854.3696665-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202182854.3696665-1-vschneid@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/02/23 18:28, Valentin Schneider wrote:
> I've been tracking down an issue on a ~5.17ish kernel where:
> 
>   CPUx                           CPUy
> 
>   <DL task p0 owns an rtmutex M>
>   <p0 depletes its runtime, gets throttled>
>   <rq switches to the idle task>
> 				 <DL task p1 blocks on M, boost/replenish p0>
> 				 <No call to resched_curr() happens here>
> 
>   [idle task keeps running here until *something*
>    accidentally sets TIF_NEED_RESCHED]
> 
> On that kernel, it is quite easy to trigger using rt-tests's deadline_test
> [1] with the test running on isolated CPUs (this reduces the chance of
> something unrelated setting TIF_NEED_RESCHED on the idle tasks, making the
> issue even more obvious as the hung task detector chimes in).
> 
> I haven't been able to reproduce this using a mainline kernel, even if I
> revert
> 
>   2972e3050e35 ("tracing: Make trace_marker{,_raw} stream-like")
> 
> which gets rid of the lock involved in the above test, *but* I cannot
> convince myself the issue isn't there from looking at the code.
> 
> Make prio_changed_dl() issue a reschedule if the current task isn't a
> deadline one. While at it, ensure a reschedule is emitted when a
> queued-but-not-current task gets boosted with an earlier deadline that
> current's.

As discussed offline I agree this needs fixing, but .. :)

> [1]: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/sched/deadline.c | 45 ++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0d97d54276cc8..faa382ea084c1 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2663,17 +2663,28 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
>  static void prio_changed_dl(struct rq *rq, struct task_struct *p,
>  			    int oldprio)
>  {
> -	if (task_on_rq_queued(p) || task_current(rq, p)) {
> -#ifdef CONFIG_SMP

Doesn't this break UP? Don't think earlierst_dl etc are defined in UP.

Thanks,
Juri

