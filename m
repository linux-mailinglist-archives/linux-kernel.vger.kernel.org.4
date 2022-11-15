Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822BB629DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiKOPrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbiKOPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:46:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3EA2C652;
        Tue, 15 Nov 2022 07:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668527195; x=1700063195;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2h1puenqV2GbE9aSnvmb1LwGLVQPnIy1raebHUUmONY=;
  b=gjK+52V/49w3Ao/enpPmYbXfvHdZd4rhjV9UTzxkhGB8/+kQ7kFuLwM2
   PNYnOv83Y/KVdu/Y+QEePUTFRI4Tqt1LZ2HCooIMS36uTph0fY/ZBK53a
   IfBHU77C9RVxsWrQT10OAM17WPmtldIqJqDwpo9kCSx+oIv5u5NA06R4x
   4RQvvJHuniCdvZ9LwAk+WHqu/E9JBb+F/OZ2/qipMZulKzLSVldPSQYHL
   rSEdR0Syl3wJ0DOGRh03YYrnFfQLTUkPZoC0kvBHUBmaBijat9DhmUYww
   eyBcQE+S5jI58WQosTygT0ccmqAZKnLPr/vVjV7RtxObUyUGaBs+9+AQ4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="314093212"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="314093212"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:46:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="641248834"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="641248834"
Received: from golubevv-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.58.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:46:30 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/4] i915: Move list_count() to list.h for broader use
In-Reply-To: <20221114162207.62559-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221114162207.62559-1-andriy.shevchenko@linux.intel.com>
Date:   Tue, 15 Nov 2022 17:46:28 +0200
Message-ID: <87leoc2pbf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> Some of the existing users, and definitely will be new ones, want to
> count existing nodes in the list. Provide a generic API for that by
> moving code from i915 to list.h.

I think I'd find list_length() a much more natural name for this.

*shrug*

Acked-by: Jani Nikula <jani.nikula@intel.com>

regardless of what you decide to do with name or static inline etc.


>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: dropped the duplicate code in i915 (LKP)
>  drivers/gpu/drm/i915/gt/intel_engine_cs.c | 13 +------------
>  include/linux/list.h                      | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
> index 6ae8b07cfaa1..b5d474be564d 100644
> --- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
> @@ -2085,17 +2085,6 @@ static void print_request_ring(struct drm_printer *m, struct i915_request *rq)
>  	}
>  }
>  
> -static unsigned long list_count(struct list_head *list)
> -{
> -	struct list_head *pos;
> -	unsigned long count = 0;
> -
> -	list_for_each(pos, list)
> -		count++;
> -
> -	return count;
> -}
> -
>  static unsigned long read_ul(void *p, size_t x)
>  {
>  	return *(unsigned long *)(p + x);
> @@ -2270,7 +2259,7 @@ void intel_engine_dump(struct intel_engine_cs *engine,
>  	spin_lock_irqsave(&engine->sched_engine->lock, flags);
>  	engine_dump_active_requests(engine, m);
>  
> -	drm_printf(m, "\tOn hold?: %lu\n",
> +	drm_printf(m, "\tOn hold?: %zu\n",
>  		   list_count(&engine->sched_engine->hold));
>  	spin_unlock_irqrestore(&engine->sched_engine->lock, flags);
>  
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 61762054b4be..098eccf8c1b6 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -655,6 +655,19 @@ static inline void list_splice_tail_init(struct list_head *list,
>  	     !list_is_head(pos, (head)); \
>  	     pos = n, n = pos->prev)
>  
> +/**
> + * list_count - count nodes in the list
> + * @head:	the head for your list.
> + */
> +#define list_count(head)		\
> +({					\
> +	struct list_head *__tmp;	\
> +	size_t __i = 0;			\
> +	list_for_each(__tmp, head)	\
> +		__i++;			\
> +	__i;				\
> +})
> +
>  /**
>   * list_entry_is_head - test if the entry points to the head of the list
>   * @pos:	the type * to cursor

-- 
Jani Nikula, Intel Open Source Graphics Center
