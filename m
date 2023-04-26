Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDF6EF5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbjDZOEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbjDZOEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:04:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF8E6591
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FrAb4eQWH3TbtEFEDBwTA8GTUoY1eVzC37hGOtqravc=; b=PtgcFBMK52iZ++p3KhpKXU/FA8
        ejRyQREXgNQzo74llkHHMmoHe18BbtYhCAYOshnbP4aldHXH4FkxfV58nJKMfPgA4cE6qdfZvEv3n
        qQ3GZ3WewH/TCC1BBvn82iQAheMq6nVpNEHLybJf3P8aJcEc5gRgDfupwoWGCDF4fpfFZ4Wv0yacf
        3xmZD7T3LYNcwHIjBzs9efhxUQ8V6odC9zlhkdWeafWTlNNwKfyYmXXD+VsA2YJdqP41Aok5mqq7L
        pR3dYbvYTgZNlhg06iGuPMk5RwTirn5d/pt18/QOdySYu+U4V3ftjcuFFNix5SGyzlqJoII295IiZ
        Y8otxAkQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1prfk5-00B1EF-0m;
        Wed, 26 Apr 2023 14:03:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75069300244;
        Wed, 26 Apr 2023 16:03:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DC272419A6E4; Wed, 26 Apr 2023 16:03:24 +0200 (CEST)
Date:   Wed, 26 Apr 2023 16:03:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] sched/fair: Introduce SIS_CURRENT to wake up
 short task on current CPU
Message-ID: <20230426140324.GB1377058@hirez.programming.kicks-ass.net>
References: <cover.1682060436.git.yu.c.chen@intel.com>
 <98257d0184b227cad8b4e947eedd9246d60191d3.1682060436.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98257d0184b227cad8b4e947eedd9246d60191d3.1682060436.git.yu.c.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 12:08:18AM +0800, Chen Yu wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4af5799b90fc..46c1321c0407 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6501,6 +6501,46 @@ static int wake_wide(struct task_struct *p)
>  	return 1;
>  }
>  
> +/*
> + * Wake up the task on current CPU, if the following conditions are met:
> + *
> + * 1. waker A is the only running task on this_cpu
> + * 3. A is a short duration task (waker will fall asleep soon)
> + * 4. wakee B is a short duration task (impact of B on A is minor)
> + * 5. A and B wake up each other alternately
> + */
> +static bool
> +wake_on_current(int this_cpu, struct task_struct *p)
> +{
> +	if (!sched_feat(SIS_CURRENT))
> +		return false;
> +
> +	if (cpu_rq(this_cpu)->nr_running > 1)
> +		return false;
> +
> +	/*
> +	 * If a task switches in and then voluntarily relinquishes the
> +	 * CPU quickly, it is regarded as a short duration task. In that
> +	 * way, the short waker is likely to relinquish the CPU soon, which
> +	 * provides room for the wakee. Meanwhile, a short wakee would bring
> +	 * minor impact to the target rq. Put the short waker and wakee together
> +	 * bring benefit to cache-share task pairs and avoid migration overhead.
> +	 */
> +	if (!current->se.dur_avg || ((current->se.dur_avg * 8) >= sysctl_sched_min_granularity))
> +		return false;
> +
> +	if (!p->se.dur_avg || ((p->se.dur_avg * 8) >= sysctl_sched_min_granularity))
> +		return false;
> +
> +	if (current->wakee_flips || p->wakee_flips)
> +		return false;
> +
> +	if (current->last_wakee != p || p->last_wakee != current)
> +		return false;
> +
> +	return true;
> +}

So I was going to play with this and found I needed to change things up
since these sysctl's no longer exist in my EEVDF branch.

And while I can easily do
's/sysctl_sched_min_granularity/sysctl_sched_base_slice/', it did make
me wonder if that's the right value to use.

min_gran/base_slice is related to how long we want a task to run before
switching, but that is not related to how long it needs to run to
establish a cache footprint.

Would not sched_migration_cost be a better measure to compare against?
That is also used in task_hot() to prevent migrations.
