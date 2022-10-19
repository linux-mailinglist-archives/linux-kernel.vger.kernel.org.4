Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697516051B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiJSVBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJSVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:01:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E6A8E7AF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:01:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z20so18393822plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LrjhlLcaH7ZC8kApu56hA/bgG8Tw6ykXI1LeIwNELlo=;
        b=c5WpMqc40BgydFsnh9z8jS6foed/iuJcI5U0DswjwBuaVJTAFfIOGcivhesM0Hfplu
         khKtKZT2ttUY2cQZP4Iz3tPCqjelNvprzyp+IJxyP05eQZqtxSzP54LSuURX2JtEFOxj
         fpZKONKTvlfC1aHDdz7nTIcdhvF2Yz2sel1Lza9r3aX5wZcz8j9oiob71D/KZ6+cH3Jo
         HvGAlubrsUb3bYzpIse+/dIdDOuitYf3I6sJVNw5LfgKPcNBfRZJogBm8QUIIVQjkJSq
         3h5O0WcGMHobWsmLWjVheV3BBb40/vCoNyWq9wZ0R89IX5uM4ichlzycbq2OYwgmVK5n
         nBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrjhlLcaH7ZC8kApu56hA/bgG8Tw6ykXI1LeIwNELlo=;
        b=l0K6wl+tYWRpYoKOf9NuU3LK0gE6e6nbLoJbOIPkrQ0Kf8i8r68ifYKQQdEZ/DqXk6
         dzcbmZI90loMRsXgqCFcuVP+2eHqvcsN9EaX37KeOgc5iVO/3+1k8P5rGOGXar8r1doC
         W4gAKPH6Inbi/U9Xnrmf8zIbx9d75tzaEpEXK2khQc6IE2LhofmwUOmYkbRqMgndOcgr
         WhwkWC3rPUqTtKd/igmpmJ0uH0hr/F0ICtYo+HAO0x+M6/DcYdPINLgt/7nbDsioWJvt
         RZ5avTy/+bcF/LYKw9tvvSOcSoZGNvA76QxO7yjYawZ/KwyOHQwA0N/iH5f4tpsdHPnv
         wmkQ==
X-Gm-Message-State: ACrzQf2hO+3XuLuwP19V1XuasN8rMNvW+uWzB+jxDc7Vxvvo4707rAaX
        FuxcWUgBeRGYp/xAFjftg2Up31rCVYYbUg==
X-Google-Smtp-Source: AMsMyM71sLO/qRXdDLL+v7+daDzdSBVPck9mqvDe4rkbyIr95Y0PGwedq+SYt5jNU8GtvcOQLikKag==
X-Received: by 2002:a17:90b:1c88:b0:203:8400:13a9 with SMTP id oo8-20020a17090b1c8800b00203840013a9mr12140650pjb.46.1666213276656;
        Wed, 19 Oct 2022 14:01:16 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-67-188-112-16.hsd1.ca.comcast.net. [67.188.112.16])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b00179c99eb815sm11368127plh.33.2022.10.19.14.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 14:01:15 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        htejun@gmail.com, lizefan.x@bytedance.com, vschneid@redhat.com,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: Re: [RESEND] sched/fair: Add min_ratio for cfs bandwidth_control
References: <20221019031551.24312-1-zhouchuyi@bytedance.com>
Date:   Wed, 19 Oct 2022 14:01:12 -0700
In-Reply-To: <20221019031551.24312-1-zhouchuyi@bytedance.com> (Chuyi Zhou's
        message of "Wed, 19 Oct 2022 11:15:51 +0800")
Message-ID: <xm26mt9rle93.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chuyi Zhou <zhouchuyi@bytedance.com> writes:

> Tasks may be throttled when holding locks for a long time by current
> cfs bandwidth control mechanism once users set a too small quota/period
> ratio, which can result whole system get stuck[1].
>
> In order to prevent the above situation from happening, this patch adds
> sysctl_sched_cfs_bandwidth_min_ratio in /proc/sys/kernel, which indicates
> the minimum percentage of quota/period users can set. The default value is
> zero and users can set quota and period without triggering this
> constraint.


There's so many other sorts of bad inputs that can get you stuck here
that I'm not sure it's ever safe against lockups to provide direct write
access to an untrusted user. I'm not totally opposed but it seems like
an incomplete fix to a broken (non-default) configuration.


>
> Link[1]:https://lore.kernel.org/lkml/5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com/T/
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/linux/sched/sysctl.h |  4 ++++
>  kernel/sched/core.c          | 23 +++++++++++++++++++++++
>  kernel/sysctl.c              | 10 ++++++++++
>  3 files changed, 37 insertions(+)
>
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index 303ee7dd0c7e..dedb18648f0e 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -21,6 +21,10 @@ enum sched_tunable_scaling {
>  	SCHED_TUNABLESCALING_END,
>  };
>  
> +#ifdef CONFIG_CFS_BANDWIDTH
> +extern unsigned int sysctl_sched_cfs_bandwidth_min_ratio;
> +#endif
> +
>  #define NUMA_BALANCING_DISABLED		0x0
>  #define NUMA_BALANCING_NORMAL		0x1
>  #define NUMA_BALANCING_MEMORY_TIERING	0x2
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5800b0623ff3..8f6cfd889e37 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10504,6 +10504,12 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
>  }
>  
>  #ifdef CONFIG_CFS_BANDWIDTH
> +/*
> + * The minimum of quota/period ratio users can set, default is zero and users can set
> + * quota and period without triggering this constraint.
> + */
> +unsigned int sysctl_sched_cfs_bandwidth_min_ratio;
> +
>  static DEFINE_MUTEX(cfs_constraints_mutex);
>  
>  const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
> @@ -10513,6 +10519,20 @@ static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
>  
>  static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
>  
> +static int check_cfs_bandwidth_min_ratio(u64 period, u64 quota)
> +{
> +	u64 ratio;
> +
> +	if (!sysctl_sched_cfs_bandwidth_min_ratio)
> +		return 0;
> +
> +	ratio = div64_u64(quota * 100, period);
> +	if (ratio < sysctl_sched_cfs_bandwidth_min_ratio)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>  				u64 burst)
>  {
> @@ -10548,6 +10568,9 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>  				     burst + quota > max_cfs_runtime))
>  		return -EINVAL;
>  
> +	if (quota != RUNTIME_INF && check_cfs_bandwidth_min_ratio(period, quota))
> +		return -EINVAL;
> +
>  	/*
>  	 * Prevent race between setting of cfs_rq->runtime_enabled and
>  	 * unthrottle_offline_cfs_rqs().
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 188c305aeb8b..7d9743e8e514 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1652,6 +1652,16 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  	},
>  #endif /* CONFIG_NUMA_BALANCING */
> +#ifdef CONFIG_CFS_BANDWIDTH
> +	{
> +		.procname	= "sched_cfs_bandwidth_min_ratio",
> +		.data		= &sysctl_sched_cfs_bandwidth_min_ratio,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +	},
> +#endif /* CONFIG_CFS_BANDWIDTH */
>  	{
>  		.procname	= "panic",
>  		.data		= &panic_timeout,
