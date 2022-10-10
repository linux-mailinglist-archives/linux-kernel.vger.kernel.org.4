Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC065F967A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 03:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJJBO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 21:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJJBOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 21:14:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7066B140CF
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 18:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665364492; x=1696900492;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VGGPwBHGLwERXIfkIPubMUi+JQYDZtScG1pfjIgGyQc=;
  b=CEKBtdFD+198C8+b3xKsnRFMAo04kgr//Srk3bQ1QlwjSN/3hPvLyAds
   LYKsEPJvBN44Vq1v6aHK4cvJNdcb8A7kuG4/GIxReopZohE3paRzfZnnD
   9+vx/IxsZSxDyBMic+WScCpzO/nqo6nYA/TPnrnPQvREFpEul+qQG+msE
   EXJZ5HU5twPVwkS94k69ayEHvm/s4T4OpsJHivS0fpPrGI9lIQYQbXIrK
   QoOb7AF7JO9dlsIjPl+iI8FxKcyqzkhvQGXETz84p+efnus7OoEtoZ5vn
   2wINB1p2GGFRfgW+1dqJJhM8+emrf+gKzfIx/jyE0N08qhRz+3dtQ/2ha
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="287354886"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="scan'208";a="287354886"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 18:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="620865724"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="scan'208";a="620865724"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by orsmga007.jf.intel.com with ESMTP; 09 Oct 2022 18:14:48 -0700
Message-ID: <f0f73a14-8738-6a17-b442-ec111a3b1064@linux.intel.com>
Date:   Mon, 10 Oct 2022 09:14:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH -next] sched/core: Fix the bug that traversal in
 sched_group_cookie_match is wrong
Content-Language: en-US
To:     Lin Shengwang <linshengwang1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cj.chengjian@huawei.com
References: <20221008022709.642-1-linshengwang1@huawei.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
In-Reply-To: <20221008022709.642-1-linshengwang1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/22 10:27, Lin Shengwang wrote:
> In commit 97886d9dcd86 ("sched: Migration changes for core scheduling"),
> sched_group_cookie_match() was added to help finding cookie matched
> group, but was inconsistent with the actual purpose.
> 
> Using cpu_rq(cpu) instead of rq to fix the bug.
> 
> Fixes: 97886d9dcd86 ("sched: Migration changes for core scheduling")
> Signed-off-by: Lin Shengwang <linshengwang1@huawei.com>
> ---
>  kernel/sched/sched.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 23c6f9f42ba1..1ba602139840 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1182,6 +1182,14 @@ static inline bool is_migration_disabled(struct task_struct *p)
>  #endif
>  }
>  
> +DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +
> +#define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
> +#define this_rq()		this_cpu_ptr(&runqueues)
> +#define task_rq(p)		cpu_rq(task_cpu(p))
> +#define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
> +#define raw_rq()		raw_cpu_ptr(&runqueues)
> +
>  struct sched_group;
>  #ifdef CONFIG_SCHED_CORE
>  static inline struct cpumask *sched_group_span(struct sched_group *sg);
> @@ -1269,7 +1277,7 @@ static inline bool sched_group_cookie_match(struct rq *rq,
>  		return true;
>  
>  	for_each_cpu_and(cpu, sched_group_span(group), p->cpus_ptr) {
> -		if (sched_core_cookie_match(rq, p))
> +		if (sched_core_cookie_match(cpu_rq(cpu), p))>  			return true;
>  	}
>  	return false;
This looks a proper fix to me. Thanks!

-Aubrey
