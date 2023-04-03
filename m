Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679FB6D4617
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjDCNq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjDCNq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:46:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD362291E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:46:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so14574359wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1680529609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ak9wjHCHkwpCyxuipvIoIUoQo6Q2URYvn4sHkalAOo=;
        b=qUkkB11ujOtPJB8/2xV6qSc9suikRlsXXDIPqhNOWGRHEJ/9Lg45TlhjtAaxShzhyY
         ibs+X9Sw9zWemb3z7IeDw45xBZWZGVScLqmsLHy7CejWvOqpTgm9lBxREh2gXhX//LMu
         SGed8/va9SKs/5FrJT3vp4/5hqw5aMgHlvENQS9b+siDwYo5qmmPgj2g+TDc5OwLkN1K
         hwIWXPLdMHPjTcqpZLEWgYO5YkwsZkqbN50C8y5b6OLmJt8KQS0gYjy6isCItw6ZWbtj
         9ylbly5Fi9cmf1jWgiYU324Y5z6sYzFOe4UNHZ6PKkwpuAzEXLJlbmUsf1EpDT1UIij+
         QeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680529609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ak9wjHCHkwpCyxuipvIoIUoQo6Q2URYvn4sHkalAOo=;
        b=Dva5HD1Sgya8pCnQJ9rZNgBzrRuimfs8SBbKNJcrHpoXzjeo9Q0aBioHnt6zF0afxS
         643kCdTWwlOW8kXRQRyTjGa1jk5g1Y5v2pkb5MvmBlrlM3VZ5r2ZlVr9+bQ21GUn6d+b
         nIkJyIYWwIOSRogY+7CwpvMMw4uQ9QO3/e2I6+FTGav22Imyd8jaRhC4XOOO/wSfvQ9A
         NbKdjofZklJNv5Rl6gL0nPVitG1AcosTzEFV0yEvFn0CfvEXVLrycXO0WmeP0TBYzMPC
         ua8RaH2rwxP/+9B6xWEizq65C4kyFznEPQByYwQDrwYfr12xcN59XcgnflffoqBqQKTI
         sllQ==
X-Gm-Message-State: AAQBX9dNjyir8F/fYXzs+txp9zT8QwMClnFm6pXQRT8jgJFg8wfNfeeJ
        KGvWrxITmG3BBuJ6S1cIfeK6PMXevLtQ/qW5Gh8=
X-Google-Smtp-Source: AKy350a0xDBbQ4wSsfwWZtlWhl63L+ugXDuNCH7Ld+UsuEY+HL8mjdgplaxFLLsoHk0fk7if+xS/Qw==
X-Received: by 2002:a1c:f210:0:b0:3f0:48f4:8454 with SMTP id s16-20020a1cf210000000b003f048f48454mr5824843wmc.27.1680529609295;
        Mon, 03 Apr 2023 06:46:49 -0700 (PDT)
Received: from airbuntu (host86-163-35-64.range86-163.btcentralplus.com. [86.163.35.64])
        by smtp.gmail.com with ESMTPSA id bg11-20020a05600c3c8b00b003f04057bf1bsm12748840wmb.18.2023.04.03.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:46:48 -0700 (PDT)
Date:   Mon, 3 Apr 2023 14:46:46 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com
Subject: Re: [PATCH 3/3] schedutil: trace: Add tracing to capture filter out
 requests
Message-ID: <20230403134646.shc2m57yvvnf2o54@airbuntu>
References: <20230322151843.14390-1-lukasz.luba@arm.com>
 <20230322151843.14390-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322151843.14390-4-lukasz.luba@arm.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/23 15:18, Lukasz Luba wrote:
> Some of the frequency update requests coming form the task scheduler
> might be filter out. It can happen when the previous request was served
> not that long ago (in a period smaller than provided by the cpufreq driver
> as minimum for frequency update). In such case, we want to know if some of
> the frequency updates cannot make through.
> Export the new tracepoint as well. That would allow to handle it by a
> toolkit for trace analyzes.

I think you can use register_kretprobe() for this one. When functions are not
inlined it should be easy to hook into them and you can get the return value of
the function too.

Check the usage in lib/test_kprobes.c. Creating the event in sched_tp should be
the same way when registering for a tracepoint. They both are essentially the
same.

Patches to sched_tp module would be welcome ;-)


Cheers

--
Qais Yousef

> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/trace/events/schedutil.h | 17 +++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c | 14 ++++++++++++--
>  2 files changed, 29 insertions(+), 2 deletions(-)
>  create mode 100644 include/trace/events/schedutil.h
> 
> diff --git a/include/trace/events/schedutil.h b/include/trace/events/schedutil.h
> new file mode 100644
> index 000000000000..7f25122f7257
> --- /dev/null
> +++ b/include/trace/events/schedutil.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM schedutil
> +
> +#if !defined(_TRACE_SCHEDUTIL_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_SCHEDUTIL_H
> +
> +#include <linux/tracepoint.h>
> +
> +DECLARE_TRACE(schedutil_update_filtered_tp,
> +	TP_PROTO(int cpu),
> +	TP_ARGS(cpu));
> +
> +#endif /* _TRACE_SCHEDUTIL_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index f462496e5c07..45c18559f3a8 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -6,6 +6,12 @@
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/schedutil.h>
> +#undef CREATE_TRACE_POINTS
> +
> +EXPORT_TRACEPOINT_SYMBOL_GPL(schedutil_update_filtered_tp);
> +
>  #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
>  
>  struct sugov_tunables {
> @@ -318,8 +324,10 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>  
>  	ignore_dl_rate_limit(sg_cpu);
>  
> -	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
> +	if (!sugov_should_update_freq(sg_cpu->sg_policy, time)) {
> +		trace_schedutil_update_filtered_tp(sg_cpu->cpu);
>  		return false;
> +	}
>  
>  	sugov_get_util(sg_cpu);
>  	sugov_iowait_apply(sg_cpu, time, max_cap);
> @@ -446,8 +454,10 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
>  
>  	ignore_dl_rate_limit(sg_cpu);
>  
> -	if (!sugov_should_update_freq(sg_policy, time))
> +	if (!sugov_should_update_freq(sg_policy, time)) {
> +		trace_schedutil_update_filtered_tp(sg_cpu->cpu);
>  		goto unlock;
> +	}
>  
>  	next_f = sugov_next_freq_shared(sg_cpu, time);
>  
> -- 
> 2.17.1
> 
