Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030E7697722
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjBOHHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjBOHHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:07:18 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84E34F58
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676444806; x=1707980806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v0HZJmds0TuG9z0N2FOHhx57xtypMjsdYvZDGJXnunQ=;
  b=LFo8VcB4n/GW4JghwRQlLPgiFAQJxp7imQgZ/8hMyffqLLBlN0EIsqP7
   NP0D5oF9TV0wbZdC50Y2A5rgFAPSQFyoBROTd/rsDkPl4zEPqiKh2nDOe
   SBnM3No1GLUApVCbPICB5KKOfNsVgpdu7c00ERpYwBuxjsjbJZ8FZN1S3
   vbrXPvpgJJKa1Ts0/gpt0CZLpadmO6FMlnBXEq5yfOX41fAMmYC4JIw4i
   0jbScQKYjBaYnbxVMcWoIlJ5pXCMT7Gti47bvLGtYfap1sc6+LDIJotu2
   RAiw17BIrVngbfaXg/k0rFPBQhOTK3KATar4qeSWSH4HDIaSEnwJb69id
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329079743"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="329079743"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 23:05:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="758296074"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="758296074"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.112])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Feb 2023 23:05:48 -0800
Date:   Wed, 15 Feb 2023 15:13:36 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Zhao Liu <zhao1.liu@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?utf-8?B?SGVsbHN0cu+/vW0=?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Christian =?utf-8?B?S++/vW5pZw==?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/9] drm/i915: Replace kmap_atomic() with
 kmap_local_page()
Message-ID: <Y+yGIPcTfirmdIdK@liuzhao-OptiPlex-7080>
References: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
 <63ec5ea4d162d_18bf5929443@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ec5ea4d162d_18bf5929443@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 08:25:08PM -0800, Ira Weiny wrote:
> Date: Tue, 14 Feb 2023 20:25:08 -0800
> From: Ira Weiny <ira.weiny@intel.com>
> Subject: Re: [PATCH 0/9] drm/i915: Replace kmap_atomic() with
>  kmap_local_page()
> 
> Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > The use of kmap_atomic() is being deprecated in favor of
> > kmap_local_page()[1].
> 
> Zhao,
> 
> Was there ever a v2 of this series?  I'm not finding it on Lore.

Sorry Ira, my delay is too long, I was busy with other patch work,
I will refresh v2 soon, and push this forward!

Best Regards,
Zhao

> 
> Thanks,
> Ira
> 
> > 
> > In the following patches, we can convert the calls of kmap_atomic() /
> > kunmap_atomic() to kmap_local_page() / kunmap_local(), which can
> > instead do the mapping / unmapping regardless of the context.
> > 
> > With kmap_local_page(), the mapping is per thread, CPU local and not
> > globally visible.
> > 
> > [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
> > ---
> > Zhao Liu (9):
> >   drm/i915: Use kmap_local_page() in gem/i915_gem_object.c
> >   drm/i915: Use kmap_local_page() in gem/i915_gem_pyhs.c
> >   drm/i915: Use kmap_local_page() in gem/i915_gem_shmem.c
> >   drm/i915: Use kmap_local_page() in gem/selftests/huge_pages.c
> >   drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_coherency.c
> >   drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_context.c
> >   drm/i915: Use memcpy_from_page() in gt/uc/intel_uc_fw.c
> >   drm/i915: Use kmap_local_page() in i915_cmd_parser.c
> >   drm/i915: Use kmap_local_page() in gem/i915_gem_execbuffer.c
> > 
> >  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c       | 10 +++++-----
> >  drivers/gpu/drm/i915/gem/i915_gem_object.c           |  8 +++-----
> >  drivers/gpu/drm/i915/gem/i915_gem_phys.c             |  8 ++++----
> >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c            |  6 ++++--
> >  drivers/gpu/drm/i915/gem/selftests/huge_pages.c      |  6 +++---
> >  .../gpu/drm/i915/gem/selftests/i915_gem_coherency.c  | 12 ++++--------
> >  .../gpu/drm/i915/gem/selftests/i915_gem_context.c    |  8 ++++----
> >  drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c             |  5 +----
> >  drivers/gpu/drm/i915/i915_cmd_parser.c               |  4 ++--
> >  9 files changed, 30 insertions(+), 37 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> 
> 
