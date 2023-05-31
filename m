Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D430B71895A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjEaS0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEaS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:26:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6839F126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:26:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso6861138e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1685557591; x=1688149591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suwwf3segF0JfVvw0RJx5BeLxnNIcxSxshqwjhCRkQY=;
        b=jRoN6yyuDRGkMKkx2B0Xe1d9pbTb6HKkELObgRxT5OUCyfyknFvQdKC58MCJS5r/JH
         5OGbz+/CKUmoOSXB6rAal7eb63DX1QZVVaD221FlZP2xkAdqG728/JGv3vEWhlki5dW5
         Sy9L6uS//A3e5IEH2tmw1sh0+uh2K5WEypwtY6VE4whn5vhRQ2MZU0/OhRfR4YAJflpa
         Ng5GgJK2MXut6oPEUuQPQEJfRD4x7Z3Gjd4U6T0BYxC+y9OkCQ7cUNzxxH8Bj9A49w3g
         X+44G4YZwLSFf03RqjWtEspvB+DAYNkwK0lc2AFQPPfUs8YxZxB7DM7Clb1Uvlvv2ZbL
         qk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685557591; x=1688149591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suwwf3segF0JfVvw0RJx5BeLxnNIcxSxshqwjhCRkQY=;
        b=IFJZlHiphwgp4pP2Iu3rrry/go0clCb5iIFfPQkxR6uVacNc3WbCM0eickqaEIfJlp
         zx7knW6m7LPqJCvRZCsUF0Uzds8DFdDoqvl9vW2E9d6FpG5Qe6EIBW7hNvA90bgwWNvE
         W8WtRGCwtavs6dPr3Bj2JLgiSNwqHoIU4idvoml745lPXHqTEUtBDeYFAGRGGW3B7RGI
         KnPteOrioY9BBMRDbq0qAB05ixUD0euWt4XUQe0T6tMOtvUU44U5EefpwiN3+VhokDDq
         BaxURzPiJcWSeHI0edxnC/sShKUy0o7GRGYJGirhhLibIvvHKQDFnhIBvmVAjTRlHrU3
         7x+w==
X-Gm-Message-State: AC+VfDxrjBw1wuB1N/yEkQESTrQ8JMIMFbexmszGgZL2FFH5aUUyC+du
        HQwUkZn1o2Bfy5KQ468ID3C3aA==
X-Google-Smtp-Source: ACHHUZ4ZGRRltCWJt4Gmd6jPcsg/hHzjXIvc8xDd9X7Zz8ZY24cy4NW87Ub0FC00KbmHHgQoG8XpoQ==
X-Received: by 2002:ac2:5598:0:b0:4f3:824e:a94b with SMTP id v24-20020ac25598000000b004f3824ea94bmr3482327lfg.54.1685557591120;
        Wed, 31 May 2023 11:26:31 -0700 (PDT)
Received: from airbuntu (host109-154-46-114.range109-154.btcentralplus.com. [109.154.46.114])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b003f42461ac75sm25172249wmf.12.2023.05.31.11.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 11:26:30 -0700 (PDT)
Date:   Wed, 31 May 2023 19:26:29 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, delyank@fb.com,
        qyousef@google.com
Subject: Re: [RESEND][PATCH v2 1/3] sched/tp: Add new tracepoint to track
 uclamp set from user-space
Message-ID: <20230531182629.nztie5rwhjl53v3d@airbuntu>
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
 <20230522145702.2419654-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522145702.2419654-2-lukasz.luba@arm.com>
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
> The user-space can set uclamp value for a given task. It impacts task
> placement decisions made by the scheduler. This is very useful information
> and helps to understand the system behavior or track improvements in
> middleware and applications which start using uclamp mechanisms and report
> better performance in tests.

Do you mind adding a generic one instead please? And explain why we can't just
attach to the syscall via kprobes? I think you want to bypass the permission
checks, so maybe a generic tracepoint after that might be justifiable?
Then anyone can use it to track how userspace has changed any attributes for
a task, not just uclamp.


Thanks

--
Qais Yousef

> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/trace/events/sched.h | 4 ++++
>  kernel/sched/core.c          | 5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index fbb99a61f714..dbfb30809f15 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
>  	TP_PROTO(struct rq *rq, int change),
>  	TP_ARGS(rq, change));
>  
> +DECLARE_TRACE(uclamp_update_tsk_tp,
> +	TP_PROTO(struct task_struct *tsk, int uclamp_id,  unsigned int value),
> +	TP_ARGS(tsk, uclamp_id, value));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 944c3ae39861..7b9b800ebb6c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -114,6 +114,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(uclamp_update_tsk_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  
> @@ -1956,12 +1957,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  	    attr->sched_util_min != -1) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>  			      attr->sched_util_min, true);
> +		trace_uclamp_update_tsk_tp(p, UCLAMP_MIN,
> +					   attr->sched_util_min);
>  	}
>  
>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
>  	    attr->sched_util_max != -1) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
>  			      attr->sched_util_max, true);
> +		trace_uclamp_update_tsk_tp(p, UCLAMP_MAX,
> +					   attr->sched_util_max);
>  	}
>  }
>  
> -- 
> 2.25.1
> 
