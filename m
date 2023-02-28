Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718616A55F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjB1JiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjB1JiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:38:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E487711EBD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:38:14 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o15so34726052edr.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRng4Dbz0KTlP7iHTWbk/N66GwOIpUYPGAXbI8iil+o=;
        b=fJ1oi536eKBQpODGF7+miG33HoXLPgp/qmehTbrVhsogXwfVgT02EyopY30dDAFT3q
         CCO13TiQvcuuWYKG7TzSz6LUwz5t2i43KFVgM5l54bMGTz80r4xh6YClV92G/SY1geO8
         Tzhquqfe4YY6rkOCdG8qK+87Gndh4sgSZ3GqmlCGXZecrWhC94q4nZFOgJg46YeDRJXC
         TrhBbMAxnIBstAz9eBL0GqU9Mk72ajWqayl0Ur5MB435qfddyu1hh6vCvVMJu6fyhaUf
         TYP5WOlvYJuq4rb9uVw59oEb5SUgvt8xMujLXKLuaRSXniXlDK19Cc+s8xSCsYuVfbzt
         NjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRng4Dbz0KTlP7iHTWbk/N66GwOIpUYPGAXbI8iil+o=;
        b=ho1RIFwyv5Ee3hK0vaVQWUgKwxoTtOSSD/8aMssn4aWyHBQ6xbHPTg+Gad74g4+XZs
         yTW4X1KVgt6wIepCXGz5R+VdDSyjA9LGSL5E2dKbPxVGfEJ5KKypFxNcn365UXTItvW7
         Oys9wL+AKCtpesDH8uP/shjeDvdqAqugrdG8Ne/q60JfIGNyS6h/zTe8ODVS8X+pweKc
         gYYEA2vq6OIV6D/zonNO3L+qsiw5RSHWhufm5gczGrAh7mSjSDqu/0p/RA9BYfB/j/rX
         WgvsY6lub1Y3wbEozE1mf3HZ370lW+1rC9Gh093CRRwZKwYDyzezb7YevD3CF/yO4R7+
         cQFw==
X-Gm-Message-State: AO0yUKXWXqVVnmKJvODWYv+D8rxHvCokw/J56bRA51GDYgV9v0PR/hCp
        ZwPiePTJmWIYsQ8CfjV7ZHc=
X-Google-Smtp-Source: AK7set/e2pZsaIHTjAljVDopE8Ap9wc3Ix3MbKCuZQA7X/XYDYt2/Ksfqr21LlPlgP+spkEFvT32aw==
X-Received: by 2002:a17:906:33d7:b0:878:7a0e:5730 with SMTP id w23-20020a17090633d700b008787a0e5730mr1992674eja.56.1677577093354;
        Tue, 28 Feb 2023 01:38:13 -0800 (PST)
Received: from [192.168.0.20] ([212.21.133.177])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906375500b008d398a4e687sm4277921ejc.158.2023.02.28.01.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 01:38:12 -0800 (PST)
Message-ID: <6e35e516-e567-57cb-ac1f-013228a04df4@gmail.com>
Date:   Tue, 28 Feb 2023 11:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] sched: Fix rq nr_uninterruptible count
Content-Language: en-US
To:     zhenggy <zhenggy@chinatelecom.cn>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, srw@sladewatkins.net
Cc:     linux-kernel@vger.kernel.org
References: <95d8be30-986c-4a2f-6913-a7813556874a@chinatelecom.cn>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
In-Reply-To: <95d8be30-986c-4a2f-6913-a7813556874a@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.02.23 г. 10:46 ч., zhenggy wrote:
> When an uninterrptable task is queue to a differect cpu as where
> it is dequeued, the rq nr_uninterruptible will be incorrent, so
> fix it.
> 
> Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>


    37  *  - cpu_rq()->nr_uninterruptible isn't accurately tracked 
per-CPU because
    38  *    this would add another cross-CPU cacheline miss and atomic 
operation
    39  *    to the wakeup path. Instead we increment on whatever CPU 
the task ran
    40  *    when it went into uninterruptible state and decrement on 
whatever CPU
    41  *    did the wakeup. This means that only the sum of 
nr_uninterruptible over
    42  *    all CPUs yields the correct result.

> ---
>   kernel/sched/core.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 25b582b..cd5ef6e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4068,6 +4068,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
>   {
>   	unsigned long flags;
>   	int cpu, success = 0;
> +	struct rq *src_rq, *dst_rq;
> 
>   	preempt_disable();
>   	if (p == current) {
> @@ -4205,6 +4206,16 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
>   			atomic_dec(&task_rq(p)->nr_iowait);
>   		}
> 
> +		if (p->sched_contributes_to_load) {
> +			src_rq = cpu_rq(task_cpu(p));
> +			dst_rq = cpu_rq(cpu);
> +
> +			double_rq_lock(src_rq, dst_rq);
> +			src_rq->nr_uninterruptible--;
> +			dst_rq->nr_uninterruptible++;
> +			double_rq_unlock(src_rq, dst_rq);
> +		}
> +
>   		wake_flags |= WF_MIGRATED;
>   		psi_ttwu_dequeue(p);
>   		set_task_cpu(p, cpu);
