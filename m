Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A149617D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiKCNGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKCNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:06:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B006E15832
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bQ7wVo9azd1UxJDp0M0W17Go7DfIYKRa93Ql2gb2yls=; b=rWtbiUXrcvPtR/CkSaSaL600BG
        w20/IKgmhTs5futklTUnbJiOnPXnWKIeChR9q96iH1/zFfhijjWR46ruO0FcDKrONot/6g+PKPG60
        Db0D2oxKaMVFob7dSaj8J5W5yK7sjgJ0Ne997pkz8h1SRYg2QzdGkvkt2/RflOVhP6VcPeki435E2
        FlaLy50Ocd46Otc8m2GkN4bAD7aaAU9Z+BpHMSZoci7zhEhmHfuYMKi4AgVW70UZYXDQI3fET7WUe
        hP1Wf3XeIV86Q0m/VT9rpW3IhmUXc1zq79FAKjNxIQAyzWm3gW6uS3z+0RaehbN5peIJTG9Jsm9V6
        Kg8HkfFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqZtn-008gi0-Vk; Thu, 03 Nov 2022 13:04:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BDAD300130;
        Thu,  3 Nov 2022 14:04:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72F1720AB9A11; Thu,  3 Nov 2022 14:04:43 +0100 (CET)
Date:   Thu, 3 Nov 2022 14:04:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] sched/fair: Choose the CPU where short task
 is running during wake up
Message-ID: <Y2O8a/Ohk1i1l8ao@hirez.programming.kicks-ass.net>
References: <cover.1666531576.git.yu.c.chen@intel.com>
 <1a34e009de0dbe5900c7b2c6074c8e0c04e8596a.1666531576.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a34e009de0dbe5900c7b2c6074c8e0c04e8596a.1666531576.git.yu.c.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 11:33:39PM +0800, Chen Yu wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8820d0d14519..3a8ee6232c59 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6249,6 +6249,11 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>  	if (available_idle_cpu(prev_cpu))
>  		return prev_cpu;
>  
> +	/* The only running task is a short duration one. */
> +	if (cpu_rq(this_cpu)->nr_running == 1 &&
> +	    is_short_task(cpu_curr(this_cpu)))
> +		return this_cpu;
> +
>  	return nr_cpumask_bits;
>  }

This is very close to using is_short_task() as dynamic WF_SYNC hint, no?

> @@ -6623,6 +6628,23 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  			/* overloaded LLC is unlikely to have idle cpu/core */
>  			if (nr == 1)
>  				return -1;
> +
> +			/*
> +			 * If nr is smaller than 60% of llc_weight, it
> +			 * indicates that the util_avg% is higher than 50%.
> +			 * This is calculated by SIS_UTIL in
> +			 * update_idle_cpu_scan(). The 50% util_avg indicates
> +			 * a half-busy LLC domain. System busier than this
> +			 * level could lower its bar to choose a compromised
> +			 * "idle" CPU, so as to avoid the overhead of cross
> +			 * CPU wakeup. If the task on target CPU is a short
> +			 * duration one, and it is the only running task, pick
> +			 * target directly.
> +			 */
> +			if (!has_idle_core && (5 * nr < 3 * sd->span_weight) &&
> +			    cpu_rq(target)->nr_running == 1 &&
> +			    is_short_task(cpu_curr(target)))
> +				return target;
>  		}
>  	}

And here you're basically saying that if the domain is 'busy' and the
task is short, don't spend time searching for a better location.

Should we perhaps only consider shortness; after all, spending more time
searching for an idle cpu than the task would've taken to run is daft.
Business of the domain seems unrelated to that.


Also, I'm not sure on your criteria for short; but I don't have enough
thoughts on that yet.
