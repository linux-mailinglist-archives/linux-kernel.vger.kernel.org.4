Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCAA5B3D24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiIIQhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiIIQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:37:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C0813FA7F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662741432; x=1694277432;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=axQDD1e0+9YXYZpyuAeHcsK5y6w1wt57SYTlNV2Ts68=;
  b=Cj44paFID5ztUy7tkl44iAcG/u45W4cas9uZB2S9P3pXZ/G/tK1bMOCV
   K0UH1f0ikmKyyh1K4pYNWjZCYIUyCabMzRtTExXyeWKeK3y/ZGWP60vYN
   hoYyCh7LCdgcjn2A4IglAHfFyKjXClKSrtQmIP/iutzrvYmN/M8kZkxDG
   K0EYKTinx6lptgUEIQO533LtDafhWYJ4UmUDn1kqI8pXOsmV8TTUA5hlr
   YWeOIsDS8yW8JLcP31+Z8TQPqboKvUKVDnAujOtdoEPVaoE32zsx/kDTB
   R5RP3VH424Tfw2xKekmPEuVXNzcbXUCyLR0UZ7yGU3FR1FCCpXW8CrRP2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298855911"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="298855911"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 09:37:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="943835618"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.177.99])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 09:37:10 -0700
Message-ID: <346eb3cc79a657f3e45d3fa2bea2fdffa741af3d.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/2] percpu: Add percpu_counter_add_local and
 percpu_counter_sub_local
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiebin Sun <jiebin.sun@intel.com>, akpm@linux-foundation.org,
        vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, manfred@colorfullife.com,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com
Date:   Fri, 09 Sep 2022 09:37:09 -0700
In-Reply-To: <20220909203636.2652466-2-jiebin.sun@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
         <20220909203636.2652466-1-jiebin.sun@intel.com>
         <20220909203636.2652466-2-jiebin.sun@intel.com>
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

On Sat, 2022-09-10 at 04:36 +0800, Jiebin Sun wrote:
> The batch size in percpu_counter_add_batch should be very large
> in heavy writing and rare reading case. Add the "_local" version,
> and mostly it will do local adding, reduce the global updating
> and mitigate lock contention in writing.
> 
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> ---
>  include/linux/percpu_counter.h | 38 ++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> index 01861eebed79..6dd7eaba8527 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -15,6 +15,9 @@
>  #include <linux/types.h>
>  #include <linux/gfp.h>
>  
> +/* percpu_counter batch for local add or sub */
> +#define PERCPU_COUNTER_LOCAL_BATCH	INT_MAX
> +
>  #ifdef CONFIG_SMP
>  
>  struct percpu_counter {
> @@ -56,6 +59,27 @@ static inline void percpu_counter_add(struct percpu_counter *fbc, s64 amount)
>  	percpu_counter_add_batch(fbc, amount, percpu_counter_batch);
>  }
>  
> +/*
> + * Use this function in heavy writing but rare reading case. The large
> + * batch size will reduce the global updating.

Suggest revising the comment, so it is clear we need to use
percpu_counter_sum() to access the counter: 

With percpu_counter_add_local() and percpu_counter_sub_local(),
counts are accumulated in local per cpu counter and not in
fbc->count until local count overflows PERCPU_COUNTER_LOCAL_BATCH.
This makes counter write efficient.

But percpu_counter_sum(), instead of percpu_counter_read(),
needs to be used to add up the counts
from each CPU to account for all the local counts.
So percpu_counter_add_local() and percpu_counter_sub_local()
should be used when a counter is updated frequently and read
rarely.


> + */
> +static inline void
> +percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
> +{
> +	percpu_counter_add_batch(fbc, amount, PERCPU_COUNTER_LOCAL_BATCH);
> +}
> +
> +/*
> + * Similar with percpu_counter_add_local, use it in heavy writing but
> + * rare reading case. The large batch size will reduce the global
> + * updating.
> + */
> +static inline void
> +percpu_counter_sub_local(struct percpu_counter *fbc, s64 amount)
> +{
> +	percpu_counter_add_batch(fbc, -amount, PERCPU_COUNTER_LOCAL_BATCH);
> +}
> +
>  static inline s64 percpu_counter_sum_positive(struct percpu_counter *fbc)
>  {
>  	s64 ret = __percpu_counter_sum(fbc);
> @@ -138,6 +162,20 @@ percpu_counter_add(struct percpu_counter *fbc, s64 amount)
>  	preempt_enable();
>  }
>  
> +/* no smp percpu_counter_add_local is the same with percpu_counter_add */
> +static inline void
> +percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
> +{
> +	percpu_counter_add(fbc, amount);
> +}
> +
> +/* no smp percpu_counter_sub_local is the same with percpu_counter_sub */
> +static inline void
> +percpu_counter_sub_local(struct percpu_counter *fbc, s64 amount)
> +{
> +	percpu_counter_sub(fbc, amount);
> +}
> +
>  static inline void
>  percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
>  {

