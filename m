Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95EE5BA04F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIORUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIORU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:20:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3B73C8D8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663262425; x=1694798425;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2WLOCR8nEHkIsfVkGyX+fsuayLLsJnENsO67vUDUfdA=;
  b=nOBL+r0ALBdPyR3nm9a7XOV1dyZxQZY797OahD82UhfaD98rh8IurMzB
   V3eULzd79EKdyRo8n7/Aze3EaVC9UeC++L65ruOm3H9fsaOEGsBmHL+HG
   EH2N7aJwkN4g5bUayMYjnMDQBzaPA26xJLm7kjJI3ebKVLuIu+VN/ckNU
   dVgJBaeNm11fvFkKHWfhS1Okbf2wBvvrEIHoLMHJHw//F6zfrD3ijT/ya
   PZc0ZR0EZeS2VBEhJ8/azYxh87++4PJNdyHrkkxCSuReNmqtw34AqnbAJ
   /+GAssXLw9YcSDkBTCSIf7z6/MKElUCqKR1W7lVHhnRPrMh4v9LFsVi1N
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="278511417"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="278511417"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 10:10:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="721087639"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.178.221])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 10:10:26 -0700
Message-ID: <bb7dd6ac32403e96943a6e51c60e72960c2942fd.camel@linux.intel.com>
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
        linux-kernel@vger.kernel.org
Date:   Thu, 15 Sep 2022 10:10:25 -0700
In-Reply-To: <20220915165407.1776363-1-yu.c.chen@intel.com>
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-16 at 00:54 +0800, Chen Yu wrote:
> 
> +/*
> + * If a task switches in and then voluntarily relinquishes the
> + * CPU quickly, it is regarded as a short running task.
> + * sysctl_sched_min_granularity is chosen as the threshold,
> + * as this value is the minimal slice if there are too many
> + * runnable tasks, see __sched_period().
> + */
> +static int is_short_task(struct task_struct *p)
> +{
> +	return (p->se.sum_exec_runtime <=
> +		(p->nvcsw * sysctl_sched_min_granularity));
> +}
> +
>  /*
>   * The purpose of wake_affine() is to quickly determine on which CPU we can run
>   * soonest. For the purpose of speed we only consider the waking and previous
> @@ -6050,7 +6063,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>  	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>  		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>  
> -	if (sync && cpu_rq(this_cpu)->nr_running == 1)
> +	if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
> +	    is_short_task(cpu_curr(this_cpu)))
>  		return this_cpu;
>  
>  	if (available_idle_cpu(prev_cpu))
> @@ -6434,6 +6448,21 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
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
> +			 * "idle" CPU. If the waker on target CPU is a short
> +			 * task and the wakee is also a short task, pick
> +			 * target directly.
> +			 */
> +			if (!has_idle_core && (5 * nr < 3 * sd->span_weight) &&
> +			    is_short_task(p) && is_short_task(cpu_curr(target)))

Should we check if target's rq's nr_running is 1, and if there's pending waking
task before picking it?

> +				return target;
>  		}
>  	}
>  

Thanks.

Tim

