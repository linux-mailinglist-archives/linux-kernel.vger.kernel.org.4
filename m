Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DA05B9080
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiINWZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiINWZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:25:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7422F383
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663194327; x=1694730327;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZWoUPTKc7sh+5Vp757SvvaQZEfQpLpxlC+kz3jiUxxs=;
  b=KFD83YRGgqd/P9ZW5mEtod/Ioe8LM4CubQs73DgWmjsbYKm5qop3DKGI
   zuhwBkgfsgg2qFsBVQVPP7EAzdGjoQFsenbWfPGJzGbt+M8NIAkmy6bOn
   v1SCD3HGMA87u96E7DvuP/KtRGQ830VJ4jAFDNgs2pOCebtefQTw0ZULA
   R16HyxMKAArYGW02yDV8NuNCE6kK12yxqWXIL+Wx4bSBr8aVBskjBtBzo
   9wIgIo19ZE8/y3mGWECKlyWJDTi7/bmDK/7c4DLyU7AISi+K7l7QVdfEx
   96HZIyUoU7DvSFi/fJcAmaix+bPOk3ILx9GYGmDl4T0uNlRW+7kQOWGzU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298552926"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="298552926"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 15:25:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="650240132"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.26.213])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 15:25:24 -0700
Message-ID: <199f559267169850f2bcbca9a5df89df30aa168e.camel@linux.intel.com>
Subject: Re: [PATCH v5 2/5] sched/fair: Limited scan for idle cores when
 overloaded
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Date:   Wed, 14 Sep 2022 15:25:24 -0700
In-Reply-To: <20220909055304.25171-3-wuyun.abel@bytedance.com>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
         <20220909055304.25171-3-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-09 at 13:53 +0800, Abel Wu wrote:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5af9bf246274..7abe188a1533 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6437,26 +6437,42 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		time = cpu_clock(this);
>  	}
>  
> -	if (sched_feat(SIS_UTIL) && !has_idle_core) {
> +	if (sched_feat(SIS_UTIL)) {
>  		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
>  		if (sd_share) {
>  			/* because !--nr is the condition to stop scan */
>  			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
> -			/* overloaded LLC is unlikely to have idle cpu/core */
> -			if (nr == 1)
> +
> +			/*
> +			 * Overloaded LLC is unlikely to have idle cpus.
> +			 * But if has_idle_core hint is true, a limited
> +			 * speculative scan might help without incurring
> +			 * much overhead.
> +			 */
> +			if (has_idle_core)
> +				nr = nr > 1 ? INT_MAX : 3;

The choice of nr is a very abrupt function of utilization when has_idle_core==true,
it is either feast or famine.  Why is such choice better than a smoother
reduction of nr vs utilization?  I agree that we want to scan more aggressively than
!has_idle_core, but it is not obvious why the above work better, versus something
like nr = nr*2+1.

Tim

> +			else if (nr == 1)
>  				return -1;
>  		}
>  	}
>  
>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
> +		/*
> +		 * This might get the has_idle_cores hint cleared for a
> +		 * partial scan for idle cores but the hint is probably
> +		 * wrong anyway. What more important is that not clearing
> +		 * the hint may result in excessive partial scan for idle
> +		 * cores introducing innegligible overhead.
> +		 */
> +		if (!--nr)
> +			break;
> +
>  		if (has_idle_core) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
>  			if ((unsigned int)i < nr_cpumask_bits)
>  				return i;
>  
>  		} else {
> -			if (!--nr)
> -				return -1;
>  			idle_cpu = __select_idle_cpu(cpu, p);
>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
>  				break;

