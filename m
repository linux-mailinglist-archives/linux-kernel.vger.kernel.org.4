Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1901C718968
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjEaSbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjEaSbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:31:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D1F194
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:31:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso7435566e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1685557867; x=1688149867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7PA/kuSsG3SQ44Ob6dTk9/jtnQJTTK0jHBW73mzFeY=;
        b=h8tiHuBrFDLXkl9nrdp7fgm7bO1t2C6I1bCrClPe3KXQBr3z89mukHeXMS/qLg6yXf
         X/ayxJ4h59Q4L6OuLHp59JwNueqnsZIfDG9rfBSzu7/xGs4C23XFC8zG9j6DPDdgBnru
         g/NGf0v4af63JRO2VhxtHrMUHENUfjv8IJxt+0o4d4z0UHP7/ZqTSWR4KG68dXjiTdT2
         8yXb9OgI+INjF8MUNRzd/8fub8kqRnz3byaFAhco0oZrPUN8+AwhqxoX0tUw5DL8Iqjf
         NMx9krkmI/si/Tt3shu1AcReVlwKpBAMgg/DWHNbA0Cxl94jbkdQvZSFaqXgIk5nFnX8
         cmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685557867; x=1688149867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7PA/kuSsG3SQ44Ob6dTk9/jtnQJTTK0jHBW73mzFeY=;
        b=XAyhQV16pv6qU+ESh9gxyQHoqjB+QizIvwxk9PAYYVCN3Au4FC8q9NfHKZwxa08h+G
         HOBUTwNJAiVeYs1Br0cdr/f/4eNSpAc8RXVxeKr24937aIjeeS+laOUiIEk4IVfvEJ56
         m+E00ANnmAJktw7y6E0xcIiA9AhUKY5zSzH2IqJ0c7LoNjExmgre5K6kqNsM1rKf9+Ie
         7yJh9+VCrTJJ9ARTtzrPdZ9yIq32PdHHAcBRi0dtENnNHT49gjs28HzAsCskqBx+bD6x
         WA6GJliK2Qg09skFC9WiAF6RoPPINyi1yWL7uWckK0lp+okoojkIivcW3jcuXExP9AtH
         YRXg==
X-Gm-Message-State: AC+VfDxe/nBwPH4Yzg8X78dti8cv1bayXmyFXEdyEP7iglxlXDSqbSfw
        L88XY4ZfyyvQzadJRGXKTAsoog==
X-Google-Smtp-Source: ACHHUZ4bcBJ3dEfE+Ms+4JAf3HYi0nt2YoJWh5X16fmQivwwguL0D6rldA0fxzTXBTLWdFWY9pX9SQ==
X-Received: by 2002:a19:a409:0:b0:4f4:af2c:97e with SMTP id q9-20020a19a409000000b004f4af2c097emr2916729lfc.11.1685557867403;
        Wed, 31 May 2023 11:31:07 -0700 (PDT)
Received: from airbuntu (host109-154-46-114.range109-154.btcentralplus.com. [109.154.46.114])
        by smtp.gmail.com with ESMTPSA id b9-20020adfe309000000b003079986fd71sm7808799wrj.88.2023.05.31.11.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 11:31:07 -0700 (PDT)
Date:   Wed, 31 May 2023 19:31:05 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, delyank@fb.com,
        qyousef@google.com, kernel test robot <lkp@intel.com>
Subject: Re: [RESEND][PATCH v2 3/3] schedutil: trace: Add tracing to capture
 filter out requests
Message-ID: <20230531183105.r5tqpdx5axoogkzp@airbuntu>
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
 <20230522145702.2419654-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522145702.2419654-4-lukasz.luba@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/23 15:57, Lukasz Luba wrote:
> Some of the frequency update requests coming form the task scheduler
> might be filter out. It can happen when the previous request was served
> not that long ago (in a period smaller than provided by the cpufreq driver
> as minimum for frequency update). In such case, we want to know if some of
> the frequency updates cannot make through.
> Export the new tracepoint as well. That would allow to handle it by a
> toolkit for trace analyzes.
> 
> Reported-by: kernel test robot <lkp@intel.com> # solved tricky build
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/trace/events/sched.h     |  4 ++++
>  kernel/sched/cpufreq_schedutil.c | 10 ++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index dbfb30809f15..e34b7cd5de73 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -739,6 +739,10 @@ DECLARE_TRACE(uclamp_update_tsk_tp,
>  	TP_PROTO(struct task_struct *tsk, int uclamp_id,  unsigned int value),
>  	TP_ARGS(tsk, uclamp_id, value));
>  
> +DECLARE_TRACE(schedutil_update_filtered_tp,
> +	TP_PROTO(int cpu),
> +	TP_ARGS(cpu));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index f462496e5c07..4f9daf258a65 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -6,6 +6,8 @@
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */
>  
> +EXPORT_TRACEPOINT_SYMBOL_GPL(schedutil_update_filtered_tp);
> +
>  #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
>  
>  struct sugov_tunables {
> @@ -318,8 +320,10 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>  
>  	ignore_dl_rate_limit(sg_cpu);
>  
> -	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
> +	if (!sugov_should_update_freq(sg_cpu->sg_policy, time)) {
> +		trace_schedutil_update_filtered_tp(sg_cpu->cpu);
>  		return false;
> +	}

Can't we have something more generic here too? Are you interested to count
these events? How do you plan to use it?

I think this will be a very noisy event by the way.


Thanks

--
Qais Yousef

>  
>  	sugov_get_util(sg_cpu);
>  	sugov_iowait_apply(sg_cpu, time, max_cap);
> @@ -446,8 +450,10 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
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
> 2.25.1
> 
