Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5846194A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKDKjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiKDKiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:38:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AD52B63C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667558316; x=1699094316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fqqtKLRYN5kDsLEk0+TvNtixmex/4vGMe3XB0EEHNbU=;
  b=jAd+CvP7N6HTeZjrhSRZfUygebTveHbFYX29YqYeVIlk6sFOyika8fRV
   /iN/R7SnyIksEWXAZ5IBItOTpq/p69xZ4StOGgFOdmcMIObTJkORUZZl4
   h/FusBvU0LUzcyugLNFlWj7C0ajgxzYHLdscmAy9h6WsPzhiQg5OAcSQM
   pth/0ZS/oftxAau5hDu3/R8HM3sv75R3aeAQc/qofLiIt1EMX4TUm4cYX
   MdHLurGzFQzytikFXispW3y5zkKO5xZBN1oltpx6lynOdp1ziPqy3inby
   njhXd2eMDWSJ7VsnrWeje71E7PeqXuzbzE9e1mYfMr5NDSoPAMZMgBZEe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="336638712"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="336638712"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 03:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="586146016"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="586146016"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.132])
  by orsmga003.jf.intel.com with ESMTP; 04 Nov 2022 03:38:31 -0700
Date:   Fri, 4 Nov 2022 18:44:16 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/9] drm/i915: Replace kmap_atomic() with
 kmap_local_page()
Message-ID: <Y2TtAAqSyAgTVIL8@liuzhao-OptiPlex-7080>
References: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
 <10176905.nUPlyArG6x@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10176905.nUPlyArG6x@suse>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 09:12:27AM +0200, Fabio M. De Francesco wrote:
> Date: Sat, 29 Oct 2022 09:12:27 +0200
> From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Subject: Re: [PATCH 0/9] drm/i915: Replace kmap_atomic() with
>  kmap_local_page()

Hi Fabio, thanks for your review!! (I'm sorry I missed the previous mails).

> 
> On luned? 17 ottobre 2022 11:37:16 CEST Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > The use of kmap_atomic() is being deprecated in favor of
> > kmap_local_page()[1].
> 
> Some words to explain why kmap_atomic was deprecated won't hurt. Many 
> maintainers and reviewers, and also casual readers might not yet be aware of 
> the reasons behind that deprecation.
>  
> > In the following patches, we can convert the calls of kmap_atomic() /
> > kunmap_atomic() to kmap_local_page() / kunmap_local(), which can
> > instead do the mapping / unmapping regardless of the context.
> 
> Readers are probably much more interested in what you did in the following 
> patches and why you did it, instead of being informed about what "we can" do.
> 
> I would suggest something like "The following patches convert the calls to 
> kmap_atomic() to kmap_local_page() [the rest looks OK]".
> 
> This could also be the place to say something about why we prefer 
> kmap_local_page() to kmap_atomic(). 
> 
> Are you sure that the reasons that motivates your conversions are merely 
> summarized to kmap_local_page() being able to do mappings regardless of 
> context? I think you are missing the real reasons why. 

Thanks for your reminder, I'll emphasize the motivation here.

> What about avoiding the often unwanted side effect of unnecessary page faults 
> disables?

Good suggestion! I'll add this into this cover message.

What I think is that we have two reasons to do the replacement work:
1. (main motication) Avoid unnessary pagefaulta and preemption disabling to gain
performance benefits.
2. We are trying to deprecate the old kmap/kmap_atomic interface. Some maintainer
said it's also a good reason especially for the case that the performance is not
critical [1].

In addition, also from [1], I find in some case people chooses kmap_atomic() for
the consideration that they want the atomic context. So, the explaination about
why the atomic context is not needed is also a reasion? I understand that I need
to make special explaination in each commit depending on the situation (In this
case, it is not suitable to describe in the cover?).

[1]: https://lore.kernel.org/lkml/YzRVaJA0EyfcVisW@liuwe-devbox-debian-v2/#t

> 
> > 
> > With kmap_local_page(), the mapping is per thread, CPU local and not
> > globally visible.
> 
> No news here. kmap_atomic() is "per thread, CPU local and not glocally 
> visible". I cannot see any difference here between kmap_atomic() and 
> kmap_local_page().

What about the below description which refers to your doc?
"kmap_atomic() in the kernel creates a non-preemptible section
and disable pagefaults. This could be a source of unwanted latency.
And kmap_local_page effectively overcomes this issue because it doesn't
disable pagefault and preemption."

Thanks,
Zhao

