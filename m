Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA06284F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiKNQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKNQUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:20:02 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385B52F6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:20:01 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id d9so14513622wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s+c8+8/YBoK8BFLCw0RrIgotfd+DpUu9sfN/WyWsOk=;
        b=Mba4iCYN1RV93ftTZxUIdhbeihGiw3tcj1GqPiSoYFGTVKF+iPF3JTVst7k1D5ts+Y
         xhYS1rCDuyIxRRw34oldB3zfS7LXoR6KxODw4AIWQv7xZw+GTmm7ovRtibP9UW738Vuh
         M6X6RgGwtWmlXxDPcfrk3dHVyYDx87TozqxFh6Uw3zwnF/q1Go4p84Al7fWzlnp2OQqV
         FL26hZvULFRflCVQIQIv1qfvEa+Ow8/DR9darBHH3pLhYxNfHlu9nqSX1RVCDNKd9G60
         yotPHJa1z7CT47LM/eGsFCS1ACJ57UMvFrI1QWB/4bcw1Ve+zEg+C1F6HO53hZfmVrkr
         fsvg==
X-Gm-Message-State: ANoB5pnHwH5hP7QR5nG0aoUkrCiK+QdrjDSrS0Jt9vcsxVFgy6e6Velr
        L9mlxPOwvXL4Ec3Vl/2W/I0=
X-Google-Smtp-Source: AA0mqf559DCSezNJKos84NDssoZ/HRRlTX9OuTy8pFRWi0RoEj4DMcjA/M0XKaqAbeDgaCzsQ5YnJQ==
X-Received: by 2002:a5d:4b0c:0:b0:236:6101:7b7d with SMTP id v12-20020a5d4b0c000000b0023661017b7dmr7890393wrq.484.1668442799544;
        Mon, 14 Nov 2022 08:19:59 -0800 (PST)
Received: from google.com ([51.154.17.58])
        by smtp.gmail.com with ESMTPSA id l16-20020a1c7910000000b003cfd4e6400csm8956822wme.19.2022.11.14.08.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:19:59 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:19:57 +0100
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: Re: [PATCH v8 1/9] sched/fair: fix unfairness at wakeup
Message-ID: <Y3JqrQJWOyHMY+G2@google.com>
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110175009.18458-2-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent!

On 10-Nov 18:50, Vincent Guittot wrote:

[...]
  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1fc198be1ffd..14879d429919 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2432,9 +2432,9 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
>  extern const_debug unsigned int sysctl_sched_nr_migrate;
>  extern const_debug unsigned int sysctl_sched_migration_cost;
>  
> -#ifdef CONFIG_SCHED_DEBUG
>  extern unsigned int sysctl_sched_latency;
>  extern unsigned int sysctl_sched_min_granularity;
> +#ifdef CONFIG_SCHED_DEBUG
>  extern unsigned int sysctl_sched_idle_min_granularity;
>  extern unsigned int sysctl_sched_wakeup_granularity;
>  extern int sysctl_resched_latency_warn_ms;
> @@ -2448,6 +2448,34 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
>  extern unsigned int sysctl_numa_balancing_scan_size;
>  #endif
>  
> +static inline unsigned long  get_sched_latency(bool idle)
                                ^^^^^^^^^^^^^^^^^

This can be confusing since it's not always returning the sysctl_sched_latency
value. It's also being used to tune the vruntime at wakeup time.

Thus, what about renaming this to something more close to what's used for, e.g.
   get_wakeup_latency(se)
?

Also, in the following patches we call this always with a false parametr.
Thus, perhaps in a following patch, we can better add something like:
   #define max_wakeup_latency get_wakeup_latency(false)
?

> +{
> +	unsigned long thresh;
> +
> +	if (idle)
> +		thresh = sysctl_sched_min_granularity;
> +	else
> +		thresh = sysctl_sched_latency;
> +
> +	/*
> +	 * Halve their sleep time's effect, to allow
> +	 * for a gentler effect of sleepers:
> +	 */
> +	if (sched_feat(GENTLE_FAIR_SLEEPERS))
> +		thresh >>= 1;
> +
> +	return thresh;
> +}
> +
> +static inline unsigned long  get_latency_max(void)
                                ^^^^^^^^^^^^^^^

This is always used to cap some form of vruntime deltas in:
 - check_preempt_tick()
 - wakeup_latency_gran()
 - wakeup_preempt_entity()
It's always smaller then the max_wakeup_latency (as defined above).

Thus, does not seems something like:
   wakeup_latency_threshold()
a better documenting naming?

> +{
> +	unsigned long thresh = get_sched_latency(false);
> +
> +	thresh -= sysctl_sched_min_granularity;
> +
> +	return thresh;
> +}

[...]

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi

