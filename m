Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40F7746AA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGDH2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjGDH2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:28:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A66E47
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688455701; x=1719991701;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RaSyqjD0+GbzkuXBeufMAawG5Hy7Lop++mCBBUAJCK0=;
  b=cmHgrARIqOEUmtHFr5SNOfx+Wu/lxACUA07QACLYKSURmOT2qaJ+lK7V
   xofshoBPy0awvK4gqEtXYKsm5Dt33GcwLejxy/CmJzoBEUKHesZmD5QIH
   LcdgU8qzWcVX+2iDSlKP9YyJrJ1kusRtrusJ0HRkUnFvH65hTBuz4Vl0E
   5Ikinc9Pm0rawvPMqNM6gRdd/9bLV6BHsslswTY2KxknaKgDHlCfQHwaP
   LDL2XOsbtDjkZqWCGtBI5yHdpzvNbuIe8HEWOQ4rnCEahUJI0fI6Tne5X
   2Ay9PSWUoEPD/EdFD8Dggcb+a8GK3ysGzzSZyR7lQ8Sx6m60ADG3/8Re6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393801332"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="393801332"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 00:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="784127930"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="784127930"
Received: from jbouhlil-mobl.ger.corp.intel.com (HELO localhost) ([10.252.48.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 00:28:17 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Uros Bizjak <ubizjak@gmail.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/i915/pmu: Use local64_try_cmpxchg in
 i915_pmu_event_read
In-Reply-To: <20230703150859.6176-1-ubizjak@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230703150859.6176-1-ubizjak@gmail.com>
Date:   Tue, 04 Jul 2023 10:28:14 +0300
Message-ID: <87o7ks16gh.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023, Uros Bizjak <ubizjak@gmail.com> wrote:
> Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) == old
> in i915_pmu_event_read.  x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg (and related move instruction
> in front of cmpxchg).
>
> Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> fails. There is no need to re-read the value in the loop.
>
> No functional change intended.
>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  drivers/gpu/drm/i915/i915_pmu.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index d35973b41186..108b675088ba 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -696,12 +696,11 @@ static void i915_pmu_event_read(struct perf_event *event)
>  		event->hw.state = PERF_HES_STOPPED;
>  		return;
>  	}
> -again:
> -	prev = local64_read(&hwc->prev_count);
> -	new = __i915_pmu_event_read(event);
>  
> -	if (local64_cmpxchg(&hwc->prev_count, prev, new) != prev)
> -		goto again;
> +	prev = local64_read(&hwc->prev_count);
> +	do {
> +		new = __i915_pmu_event_read(event);
> +	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));

You could save everyone a lot of time by actually documenting what these
functions do. Assume you don't know what local64_try_cmpxchg() does, and
see how many calls you have to go through to figure it out.

Because the next time I encounter this code or a patch like this, I'm
probably going to have to do that again.

To me, the old one was more readable. The optimization is meaningless to
me if it's not quantified but reduces readability.


BR,
Jani.


>  
>  	local64_add(new - prev, &event->count);
>  }

-- 
Jani Nikula, Intel Open Source Graphics Center
