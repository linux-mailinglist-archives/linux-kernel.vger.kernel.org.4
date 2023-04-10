Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDC76DC4C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDJJA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjDJJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:00:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BBC5277
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681117203; x=1712653203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dqF2REshPEPcaWNr3EMg4H0fo/5f+H+KwIw4rUrhjRc=;
  b=Ed98++yZoNyzl1mjpY8nP6BW+2PWeTk0i32Jqc5Jseg32cAWrt5d3itV
   gWBf4QTorATadSsYxxhS7UFFwkYhaN0oH37L07jZFBMPaGhnAaA3Jn4Jl
   SEOw6xCjrnRVAB5m8u8mpbHPGtkm11j+5dFWAyd4nfax9r/A/J9gGojc7
   9NTPVeTolGiB8uMsXCaXwFRdvs2IcL2A6RLHyDOL1fQtDx0Itn0cfBM0f
   dUvTjq0F1TnJycqXqcjfLVH9ZJ72WYqLK32iN5hzuFkPlkLfygR+Nrn3n
   Q+/qqYqeAp9R8dLnn1/nuvf6CR4z7jQEv+6UnpToqWPDI/nW6dNQDEmkG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="342081041"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="342081041"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 02:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="688209076"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="688209076"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Apr 2023 01:59:58 -0700
Date:   Mon, 10 Apr 2023 17:08:45 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Thomas =?utf-8?B?SGVsbHN0cu+/vW0=?= 
        <thomas.hellstrom@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Christian =?utf-8?B?S++/vW5pZw==?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 9/9] drm/i915: Use kmap_local_page() in
 gem/i915_gem_execbuffer.c
Message-ID: <ZDPSHYn02GWTSMG4@liuzhao-OptiPlex-7080>
References: <20230329073220.3982460-1-zhao1.liu@linux.intel.com>
 <64265ef8725fe_375f7e294a@iweiny-mobl.notmuch>
 <fdc8a470-1e6b-815d-e367-a9df1b0b14dd@linux.intel.com>
 <2177327.1BCLMh4Saa@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2177327.1BCLMh4Saa@suse>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks all for your review!

On Fri, Mar 31, 2023 at 05:32:17PM +0200, Fabio M. De Francesco wrote:
> Date: Fri, 31 Mar 2023 17:32:17 +0200
> From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Subject: Re: [PATCH v2 9/9] drm/i915: Use kmap_local_page() in
>  gem/i915_gem_execbuffer.c
> 
> On venerd? 31 marzo 2023 13:30:20 CEST Tvrtko Ursulin wrote:
> > On 31/03/2023 05:18, Ira Weiny wrote:
> 

[snip]

>  
> > However I am unsure if disabling pagefaulting is needed or not. Thomas,
> > Matt, being the last to touch this area, perhaps you could have a look?
> > Because I notice we have a fallback iomap path which still uses
> > io_mapping_map_atomic_wc. So if kmap_atomic to kmap_local conversion is
> > safe, does the iomap side also needs converting to
> > io_mapping_map_local_wc? Or they have separate requirements?
> 
> AFAIK, the requirements for io_mapping_map_local_wc() are the same as for 
> kmap_local_page(): the kernel virtual address is _only_ valid in the caller 
> context, and map/unmap nesting must be done in stack-based ordering (LIFO).
> 
> I think a follow up patch could safely switch to io_mapping_map_local_wc() / 
> io_mapping_unmap_local_wc since the address is local to context.
> 
> However, not being an expert, reading your note now I suspect that I'm missing 
> something. Can I ask why you think that page-faults disabling might be 
> necessary? 


About the disabling of pagefault here, could you please talk more about
it? :-)

From previous discussions and commit history, I didn't find relevant
information and I lack background knowledge about it...

If we have the reason to diable pagefault, I will fix and refresh the new
version.

Thanks,
Zhao

> 
> Thanks,
> 
> Fabio
> 
> > Regards,
> > 
> > Tvrtko
> 
> 
> 
