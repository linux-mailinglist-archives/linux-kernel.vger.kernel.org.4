Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426FC6E2112
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDNKiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDNKiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:38:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B254A9EDD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681468647; x=1713004647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CFmbTNZab9I7ir2+O5evjGn+3mmBidb0nlh8n5NmjpY=;
  b=lZXwMaKFl3ROHVlfAfbpDdrbLtCg/JNpS4S4p1sYAT2N1zRoj7qjw4na
   GjFuPltVvpZLmFqpoRK/a/chUo8sI3NCd8qnS+Q1tRpWzsWkJOUHp/wO5
   HhjLKDxJ+/ety0mxu0ZUp8XyeTOVxYg5c1I0rvP/He7KVfNpBAfR9L8Oq
   3m9wMU8sKx3OoKsTLUVB2Mw/w2Wf7erRsyw/iDJkGXmuW7JNmsfZuP33v
   xPF1BQuDMOA8yejxDHPzwfHGw9T43iIP9D/Z+yy59+jxOJE1Zu0SD8jNf
   fb29gb5VJo/ys2senc50420F7qVTIpJdSWO9FnJZ/8wnjwW4njWDvsSyM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="344433719"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="344433719"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:37:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="864170782"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="864170782"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.28])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2023 03:37:07 -0700
Date:   Fri, 14 Apr 2023 18:45:57 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 9/9] drm/i915: Use kmap_local_page() in
 gem/i915_gem_execbuffer.c
Message-ID: <ZDku5SJhl2Ve51UC@liuzhao-OptiPlex-7080>
References: <20230329073220.3982460-1-zhao1.liu@linux.intel.com>
 <64265ef8725fe_375f7e294a@iweiny-mobl.notmuch>
 <fdc8a470-1e6b-815d-e367-a9df1b0b14dd@linux.intel.com>
 <2177327.1BCLMh4Saa@suse>
 <1b341218-f0e2-a613-2ac6-107064a813ca@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b341218-f0e2-a613-2ac6-107064a813ca@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tvrtko,

On Wed, Apr 12, 2023 at 04:45:13PM +0100, Tvrtko Ursulin wrote:

[snip]

> > 
> > [snip]
> > > However I am unsure if disabling pagefaulting is needed or not. Thomas,
> > > Matt, being the last to touch this area, perhaps you could have a look?
> > > Because I notice we have a fallback iomap path which still uses
> > > io_mapping_map_atomic_wc. So if kmap_atomic to kmap_local conversion is
> > > safe, does the iomap side also needs converting to
> > > io_mapping_map_local_wc? Or they have separate requirements?
> > 
> > AFAIK, the requirements for io_mapping_map_local_wc() are the same as for
> > kmap_local_page(): the kernel virtual address is _only_ valid in the caller
> > context, and map/unmap nesting must be done in stack-based ordering (LIFO).
> > 
> > I think a follow up patch could safely switch to io_mapping_map_local_wc() /
> > io_mapping_unmap_local_wc since the address is local to context.
> > 
> > However, not being an expert, reading your note now I suspect that I'm missing
> > something. Can I ask why you think that page-faults disabling might be
> > necessary?
> 
> I am not saying it is, was just unsure and wanted some people who worked on this code most recently to take a look and confirm.
> 
> I guess it will work since the copying is done like this anyway:
> 
> 		/*
> 		 * This is the fast path and we cannot handle a pagefault
> 		 * whilst holding the struct mutex lest the user pass in the
> 		 * relocations contained within a mmaped bo. For in such a case
> 		 * we, the page fault handler would call i915_gem_fault() and
> 		 * we would try to acquire the struct mutex again. Obviously
> 		 * this is bad and so lockdep complains vehemently.
> 		 */
> 		pagefault_disable();
> 		copied = __copy_from_user_inatomic(r, urelocs, count * sizeof(r[0]));
> 		pagefault_enable();
> 		if (unlikely(copied)) {
> 			remain = -EFAULT;
> 			goto out;
> 		}
> 
> Comment is a bit outdated since we don't use that global "struct mutex" any longer, but in any case, if there is a page fault on the mapping where we need to recurse into i915 again to satisfy if, we seem to have code already to handle it. So kmap_local conversion I *think* can't regress anything.

Thanks for your explanation!

> 
> Patch to convert the io_mapping_map_atomic_wc can indeed come later.

Okay, I will also look at this.

> 
> In terms of logistics - if we landed this series to out branch it would be queued only for 6.5. Would that work for you?

Yeah, it's ok for me. But could I ask, did I miss the 6.4 merge time?

Thanks,
Zhao

> 
> Regards,
> 
> Tvrtko
