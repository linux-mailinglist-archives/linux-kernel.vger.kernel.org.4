Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0828619FA4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiKDSUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiKDSUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3525A2B8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667585954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ex9OEuHs0aTNNPLGPOtl1yzC2jO7IMU/SQhGh1kmkX8=;
        b=T1yrG6QQpFTqQ+ykDnbDxnpXRXaJ3mzQnKDkHaU7nutoyhWfc5gXFerZeigwnQz/CaWL58
        ETPqIJdmmFOW8V/9I4eIZiR/7JAJhvwQSOp0crGjJY+n5mSSHWn53c5Eeel1nxi2+kQbR2
        9xWyUypdSFuqYwdQQO4HMp7sXJSRO1Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-75-t-b6G-d0OUy8h7wLPREzRw-1; Fri, 04 Nov 2022 14:19:13 -0400
X-MC-Unique: t-b6G-d0OUy8h7wLPREzRw-1
Received: by mail-wm1-f71.google.com with SMTP id h204-20020a1c21d5000000b003cf4e055442so2673482wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex9OEuHs0aTNNPLGPOtl1yzC2jO7IMU/SQhGh1kmkX8=;
        b=73Nzmus585duYGJvGpr1yMELWg58bscygCvzwsHaPpaNWRBe1HowJYUFjW+vQEEPor
         5ApcypmOZ0wmgveKaAw9OoBGdqflQy82yVY3Ze+T0ZXCIgns7ko3IyTI2VPtVGwPU99n
         4rN+WH5jsDe7+Aa3ak8e5TeGiyKU8f8KEgxsxNR8a7kJVixbjHOSZcQTUSiSMAiJGKup
         86WQRAJFl8GL93g7/wxWLZWz+f/qm1wUFAwq7N+PfKhnagyVWptRvVBYJgTvlvxTthpw
         1Krk5B4YN7izsGJGTk3vwPaHtiYco0N4x3QxOD2F7CB9zb63uBoHKdLY4azGOq69mtd2
         A16Q==
X-Gm-Message-State: ACrzQf1nj0p962/Wd1pWPXRaLqGBMHOmiNJ4vxKQJZcrAnZHph0Rk6MX
        h8GMOR6PRr5F4xIR4Hl5TtI3GE1vtHS8YWp4tFNbVM+ipN2fJ+RD09KUJEkpSlb4QsQcs7qWMBm
        8tg8tLa+NMNwr7p7tJ6FXUs9r
X-Received: by 2002:a05:600c:4105:b0:3cf:815e:90a8 with SMTP id j5-20020a05600c410500b003cf815e90a8mr14400165wmi.73.1667585952151;
        Fri, 04 Nov 2022 11:19:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7D4UZkM59N8uGstFGJxYCtqVKmml7FCfowqiC+r9E4WhR7Cb0Y3y6UhvJuKDcPXp+c65SMBg==
X-Received: by 2002:a05:600c:4105:b0:3cf:815e:90a8 with SMTP id j5-20020a05600c410500b003cf815e90a8mr14400155wmi.73.1667585951953;
        Fri, 04 Nov 2022 11:19:11 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000008200b0023662d97130sm39747wrx.20.2022.11.04.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:19:11 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] sched/core: Minor optimize ttwu_runnable()
In-Reply-To: <20221102102343.57845-1-zhouchengming@bytedance.com>
References: <20221102102343.57845-1-zhouchengming@bytedance.com>
Date:   Fri, 04 Nov 2022 18:19:10 +0000
Message-ID: <xhsmhr0yivazl.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/22 18:23, Chengming Zhou wrote:
> ttwu_runnable() is used as a fast wakeup path when the wakee task
> is between set_current_state() and schedule(), in which case all
> we need to do is change p->state back to TASK_RUNNING. So we don't
> need to update_rq_clock() and check_preempt_curr() in this case.
>
> Some performance numbers using mmtests/perfpipe on Intel Xeon server:
>
>                            linux-next                patched
> Min       Time        8.67 (   0.00%)        8.66 (   0.13%)
> 1st-qrtle Time        8.83 (   0.00%)        8.72 (   1.19%)
> 2nd-qrtle Time        8.90 (   0.00%)        8.76 (   1.57%)
> 3rd-qrtle Time        8.98 (   0.00%)        8.82 (   1.82%)
> Max-1     Time        8.67 (   0.00%)        8.66 (   0.13%)
> Max-5     Time        8.67 (   0.00%)        8.66 (   0.13%)
> Max-10    Time        8.79 (   0.00%)        8.69 (   1.09%)
> Max-90    Time        9.01 (   0.00%)        8.84 (   1.94%)
> Max-95    Time        9.02 (   0.00%)        8.85 (   1.86%)
> Max-99    Time        9.02 (   0.00%)        8.88 (   1.56%)
> Max       Time        9.59 (   0.00%)        8.89 (   7.29%)
> Amean     Time        8.92 (   0.00%)        8.77 *   1.65%*
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 87c9cdf37a26..3785418de127 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3718,9 +3718,8 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>
>       rq = __task_rq_lock(p, &rf);
>       if (task_on_rq_queued(p)) {
> -		/* check_preempt_curr() may use rq clock */
> -		update_rq_clock(rq);
> -		ttwu_do_wakeup(rq, p, wake_flags, &rf);
> +		WRITE_ONCE(p->__state, TASK_RUNNING);
> +		trace_sched_wakeup(p);

This also loses the class->task_woken() call, AFAICT we could have
!p->on_cpu here (e.g. an IRQ hit before the task got to schedule()), but
then again if there is a need to push we should have done that at the IRQ
preempt via set_next_task_{rt, dl}()... So I'm starting to think this is
OK, but that needs elaborating in the changelog.


>               ret = 1;
>       }
>       __task_rq_unlock(rq, &rf);
> --
> 2.37.2

