Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF775B9086
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiINWhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiINWhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:37:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF967F256
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663195056; x=1694731056;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YFXaXof79mww4Loh9N42gVv+6OfztCBM3O7BFT4aSe8=;
  b=PRRhHJxvj0sOX6ZAwrr8xTNzI2FZSlefC6n16ubrUg9sCPFMAyGsYZBi
   q42bSidnoIUdrwQfdkxNwFg7mn//a+a4rxU2b+Lv+v9cjuZ2VHguV7/Eq
   vybO2M3Bbhvat4+iHim44q66OhSZdfsqCxBB5Sls/FXjliRP97VTxr16y
   vPDDbEchkCwb2wUzSnCsM/PmkVfU9/0/OKDuDvuA611vZ9kqG8naoarci
   SelSM6YKnUBEGCX9mFlI0eOAcmyuYZcsYA1RPwXSxPUzBKuokmoh1mVv4
   xWZUQVR+DZZ1wkWB9SrvMbK+6oJJpICahWfc4D93dy+JWfSKEyaJQakWf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299916860"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="299916860"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 15:37:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="594569094"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.26.213])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 15:37:34 -0700
Message-ID: <3f4f98cf61e4b08dcc85e3ac308a80f0b9cf814e.camel@linux.intel.com>
Subject: Re: [PATCH v5 3/5] sched/fair: Skip core update if task pending
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Sep 2022 15:37:34 -0700
In-Reply-To: <20220909055304.25171-4-wuyun.abel@bytedance.com>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
         <20220909055304.25171-4-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-09 at 13:53 +0800, Abel Wu wrote:
> The function __update_idle_core() considers this cpu is idle so
> only checks its siblings to decide whether the resident core is
> idle or not and update has_idle_cores hint if necessary. But the
> problem is that this cpu might not be idle at that moment any
> more, resulting in the hint being misleading.
> 
> It's not proper to make this check everywhere in the idle path,
> but checking just before core updating can make the has_idle_core
> hint more reliable with negligible cost.
> 

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7abe188a1533..fad289530e07 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6294,6 +6294,9 @@ void __update_idle_core(struct rq *rq)
>  	int core = cpu_of(rq);
>  	int cpu;
>  
> +	if (rq->ttwu_pending)
> +		return;
> +
>  	rcu_read_lock();
>  	if (test_idle_cores(core, true))
>  		goto unlock;

