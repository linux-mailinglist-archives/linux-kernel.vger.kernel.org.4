Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478716A1384
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBWXKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBWXJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:09:57 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C803217CD5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:09:50 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i10so5946264plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGMgmBSLyhLFoGSFHkx2Y2G/HHLhd5Of8wviRMsewqI=;
        b=jegeDERKDC8WKg/+bwMUhS8336wCPf0VOZo0NIhDxwPK2jOTjEixgjTVCV8c6zZc1T
         0rzJnWVRDjq0LbDOToTZLQr2MVIBDpGeFjTSkjdyCWdnNnBsoASJPvwDEdqSWGHlFKWU
         ur1QTn8ve5yxbNx27c5MulKh/+vqouQtRkkPu3wYQz/zv7XvvgQgJ6zE+KkFhykabgP7
         YhyVG0X9u3sstHR/tU/eLWMkUCnLzDlhqucNvV23EM8y9XOVTtn0oFbyxYcZF13MR+Vn
         hWVu1r09gwhZ+BlCsZDroFtLYjXcuxU3ktXqYu4Vrl4Oya+ceUQccadP7u2bik+baPGn
         iD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGMgmBSLyhLFoGSFHkx2Y2G/HHLhd5Of8wviRMsewqI=;
        b=2sGjid4Y5QHFzCK8SI43W+yZyLrSzJAVPTJaCCzhDQH9aLcsytM5j4TWXplitUIh9p
         anu9aLlf2VGIlugNq/czPk8zO+rIGUquqqW2DK8V7htbLwOSPvPJmFxZ7paq9SCNHVvj
         wfJZWBsquYDY3xebl9SPq2uzER3W/clRV0TWQv/+Sz+HYUXh+V2n8wqI9cdfIFIhhAW0
         dzdFnCxUvemslUBBG7syEPATyRgXzc8T0FbDz7OqDjHPMufbFMVEj4SyjeJhd9AW4UXA
         Ij8U71HNB2PzM/yfFwUupdPM9599HJ3nccz45SEUv6vSK1RAQkXStJJr3DgFZUBitfO6
         /4pg==
X-Gm-Message-State: AO0yUKWOpfKhyGZcQzIouF5Q80nZkUWV4Juz7taJJdsuyatkrbaXhOG4
        7B9ZUX4BgVB1WFbB3CpFe9L3PxgWTAapbL/zATU=
X-Google-Smtp-Source: AK7set8npseupx0BoYMDyOybZYr8W/HToiAXYQV9AYv6ytVHLUa5X5+WeiGad/wtRMcj2R9YePNwlg==
X-Received: by 2002:a17:903:6c7:b0:19c:c5d4:afd2 with SMTP id kj7-20020a17090306c700b0019cc5d4afd2mr20093plb.11.1677193789314;
        Thu, 23 Feb 2023 15:09:49 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id c186-20020a6335c3000000b00502f21d6c14sm1988548pga.94.2023.02.23.15.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:09:48 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, tglx@linutronix.de,
        srikar@linux.vnet.ibm.com, arjan@linux.intel.com,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] Interleave cfs bandwidth timers for improved single
 thread performance at low utilization
References: <20230223185153.1499710-1-sshegde@linux.vnet.ibm.com>
Date:   Thu, 23 Feb 2023 15:09:46 -0800
In-Reply-To: <20230223185153.1499710-1-sshegde@linux.vnet.ibm.com> (Shrikanth
        Hegde's message of "Fri, 24 Feb 2023 00:21:53 +0530")
Message-ID: <xm26356w3rnp.fsf@google.com>
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

Shrikanth Hegde <sshegde@linux.vnet.ibm.com> writes:

> CPU cfs bandwidth controller uses hrtimer. Currently there is no initial
> value set. Hence all period timers would align at expiry.
> This happens when there are multiple CPU cgroup's.
>
> There is a performance gain that can be achieved here if the timers are
> interleaved when the utilization of each CPU cgroup is low and total
> utilization of all the CPU cgroup's is less than 50%. If the timers are
> interleaved, then the unthrottled cgroup can run freely without many
> context switches and can also benefit from SMT Folding. This effect will
> be further amplified in SPLPAR environment.
>
> This commit adds a random offset after initializing each hrtimer. This
> would result in interleaving the timers at expiry, which helps in achieving
> the said performance gain.
>
> This was tested on powerpc platform with 8 core SMT=8. Socket power was
> measured when the workload. Benchmarked the stress-ng with power
> information. Throughput oriented benchmarks show significant gain up to
> 25% while power consumption increases up to 15%.
>
> Workload: stress-ng --cpu=32 --cpu-ops=50000.
> 1CG - 1 cgroup is running.
> 2CG - 2 cgroups are running together.
> Time taken to complete stress-ng in seconds and power is in watts.
> each cgroup is throttled at 25% with 100ms as the period value.
>            6.2-rc6                     |   with patch
> 8 core   1CG    power   2CG     power  |  1CG    power  2 CG    power
>         27.5    80.6    40      90     |  27.3    82    32.3    104
>         27.5    81      40.2    91     |  27.5    81    38.7     96
>         27.7    80      40.1    89     |  27.6    80    29.7    106
>         27.7    80.1    40.3    94     |  27.6    80    31.5    105
>
> Latency might be affected by this change. That could happen if the CPU was
> in a deep idle state which is possible if we interleave the timers. Used
> schbench for measuring the latency. Each cgroup is throttled at 25% with
> period value is set to 100ms. Numbers are when both the cgroups are
> running simultaneously. Latency values don't degrade much. Some
> improvement is seen in tail latencies.
>
> 		6.2-rc6        with patch
> Groups: 16
> 50.0th:          39.5            42.5
> 75.0th:         924.0           922.0
> 90.0th:         972.0           968.0
> 95.0th:        1005.5           994.0
> 99.0th:        4166.0          2287.0
> 99.5th:        7314.0          7448.0
> 99.9th:       15024.0         13600.0
>
> Groups: 32
> 50.0th:         819.0           463.0
> 75.0th:        1596.0           918.0
> 90.0th:        5992.0          1281.5
> 95.0th:       13184.0          2765.0
> 99.0th:       21792.0         14240.0
> 99.5th:       25696.0         18920.0
> 99.9th:       33280.0         35776.0
>
> Groups: 64
> 50.0th:        4806.0          3440.0
> 75.0th:       31136.0         33664.0
> 90.0th:       54144.0         58752.0
> 95.0th:       66176.0         67200.0
> 99.0th:       84736.0         91520.0
> 99.5th:       97408.0        114048.0
> 99.9th:      136448.0        140032.0
>
> Signed-off-by: Shrikanth Hegde<sshegde@linux.vnet.ibm.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Ben Segall <bsegall@google.com>

>
> Initial RFC PATCH, discussions and details on the problem:
> Link1: https://lore.kernel.org/lkml/5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com/
> Link2: https://lore.kernel.org/lkml/9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com/
>
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff4dbbae3b10..2a4a0969e04f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5923,6 +5923,10 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
>  	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
>  	cfs_b->period_timer.function = sched_cfs_period_timer;
> +
> +	/* Add a random offset so that timers interleave */
> +	hrtimer_set_expires(&cfs_b->period_timer,
> +			    get_random_u32_below(cfs_b->period));
>  	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
>  	cfs_b->slack_started = false;
> --
> 2.31.1
