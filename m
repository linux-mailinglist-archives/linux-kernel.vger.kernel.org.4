Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79816D6820
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjDDQAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjDDQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:00:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4440FD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680624042; x=1712160042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B2VCrvRDMzzWoBj/sY/dOe8TgaAA+UY1ACaoJ3AXUvM=;
  b=Q5wZ1s0uGdMt7Wig2ryzrnjOqY/FCu9URqIx0GKMfT2UnxuhICHGl8rv
   j6s//xVYm18YY8I8rj8c57bIBSW6KSmAeHZiXe4CRsqZL9vdB1q9TLggS
   T2WgBCdcF0IqYPoIf3NT9KckIPMCz0BfvVPAa1VqmJ150MLstj6uSHDd3
   3GIrzhxM/kvC5EkzVZe/Jf04e1RBG6MxNYQFcad/lX36K57zLD35C7P2B
   P7CFF33S5pWS2MjBAUAutxmSXugV5xRm01FOyBIgSwjy5TzQU8o52QsrQ
   5xYyu/Pa0idlV1tBDj21WbdG9GGfdtfT2bYkGBgsMq43yasylJErMRi87
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="339716599"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="339716599"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 09:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="755693328"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="755693328"
Received: from vferra-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.53.196])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 09:00:37 -0700
Date:   Tue, 4 Apr 2023 18:00:10 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH v2] drm/i915/gt: Hold a wakeref for the active VM
Message-ID: <ZCxJitP+XtC2/run@ashyti-mobl2.lan>
References: <20230330-hold_wakeref_for_active_vm-v2-1-724d201499c2@intel.com>
 <ZCxEoelnOSpRiy6A@ashyti-mobl2.lan>
 <f193eb7f-19f9-b9a8-7edf-438dafb74da4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f193eb7f-19f9-b9a8-7edf-438dafb74da4@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tvrtko,

> > > diff --git a/drivers/gpu/drm/i915/gt/intel_context.h b/drivers/gpu/drm/i915/gt/intel_context.h
> > > index 0a8d553da3f439..48f888c3da083b 100644
> > > --- a/drivers/gpu/drm/i915/gt/intel_context.h
> > > +++ b/drivers/gpu/drm/i915/gt/intel_context.h
> > > @@ -14,6 +14,7 @@
> > >   #include "i915_drv.h"
> > >   #include "intel_context_types.h"
> > >   #include "intel_engine_types.h"
> > > +#include "intel_gt_pm.h"
> > >   #include "intel_ring_types.h"
> > >   #include "intel_timeline_types.h"
> > >   #include "i915_trace.h"
> > > @@ -207,8 +208,11 @@ void intel_context_exit_engine(struct intel_context *ce);
> > >   static inline void intel_context_enter(struct intel_context *ce)
> > >   {
> > >   	lockdep_assert_held(&ce->timeline->mutex);
> > > -	if (!ce->active_count++)
> > > -		ce->ops->enter(ce);
> > > +	if (ce->active_count++)
> > > +		return;
> > > +
> > > +	ce->ops->enter(ce);
> > > +	intel_gt_pm_get(ce->vm->gt);
> > >   }
> > >   static inline void intel_context_mark_active(struct intel_context *ce)
> > > @@ -222,8 +226,11 @@ static inline void intel_context_exit(struct intel_context *ce)
> > >   {
> > >   	lockdep_assert_held(&ce->timeline->mutex);
> > >   	GEM_BUG_ON(!ce->active_count);
> > > -	if (!--ce->active_count)
> > > -		ce->ops->exit(ce);
> > > +	if (--ce->active_count)
> > > +		return;
> > > +
> > > +	intel_gt_pm_put_async(ce->vm->gt);
> > > +	ce->ops->exit(ce);
> > 
> > shouldn't these two be swapped?

maybe I wasn't clear here... shouldn't it be

	ce->ops->exit(ce);
	intel_gt_pm_put_async(ce->vm->gt);

Don't we need to hold the pm until exiting?

> > >   }
> > >   static inline struct intel_context *intel_context_get(struct intel_context *ce)
> > > diff --git a/drivers/gpu/drm/i915/gt/intel_engine_pm.c b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
> > > index e971b153fda976..ee531a5c142c77 100644
> > > --- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
> > > +++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
> > > @@ -114,6 +114,15 @@ __queue_and_release_pm(struct i915_request *rq,
> > >   	ENGINE_TRACE(engine, "parking\n");
> > > +	/*
> > > +	 * Open coded one half of intel_context_enter, which we have to omit
> > > +	 * here (see the large comment below) and because the other part must
> > > +	 * not be called due constructing directly with __i915_request_create
> > > +	 * which increments active count via intel_context_mark_active.
> > > +	 */
> > > +	GEM_BUG_ON(rq->context->active_count != 1);
> > > +	__intel_gt_pm_get(engine->gt);
> > 
> > where is it's brother "put"?
> 
> It's in request retire via intel_context_exit. Ie. request construction is
> special here, while retirement is standard.

Thank you!
Andi
