Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6036D0A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjC3Pxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjC3Pxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:53:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F8D5BA6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680191619; x=1711727619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NQBtoTtOarnK7I2M7dGSHlKc2KGRDM8RBMAE5oqHmuY=;
  b=GPF8VGSqBTXH4HOn57yk+NRS6wdrGOB+p1vUcMNpnuKn1ABkVYX1OqJp
   K9rkltBp//tET62HKVi8JnboVEV358ImsC0jdVl8xmkohB+c2OffsiRw3
   bRh0O6/rBidKy0oHPqjIYr3lJLQD01mq9um/8l52MYeexu5zRndGvHzft
   dFbkSMIMauopwjfy0Un8D+dNRbFfstbroRl+G5EBo+IWzZsB3msFrN8WD
   UqEB0EyU7RLgK0a49xHGk1bwHP7XkvBtKJlIF874VO+pZj6c8MeDWvPKL
   htQZ32QRt7deRw49AE39N0XbRDOItPkn0lGp32WNthZ2HonULUBPn6Asa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427484398"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="427484398"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 08:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="717357280"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="717357280"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.112])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2023 08:52:24 -0700
Date:   Fri, 31 Mar 2023 00:00:39 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 0/9] drm/i915: Replace kmap_atomic() with
 kmap_local_page()
Message-ID: <ZCWyJzuCZG79zxLi@liuzhao-OptiPlex-7080>
References: <20230329073220.3982460-1-zhao1.liu@linux.intel.com>
 <4498688.cEBGB3zze1@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4498688.cEBGB3zze1@suse>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Wed, Mar 29, 2023 at 06:03:38PM +0200, Fabio M. De Francesco wrote:
> Date: Wed, 29 Mar 2023 18:03:38 +0200
> From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Subject: Re: [PATCH v2 0/9] drm/i915: Replace kmap_atomic() with
>  kmap_local_page()
> 
> On mercoled¨¬ 29 marzo 2023 09:32:11 CEST Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Hi list,
> > 
> > Sorry for a long delay since v1 [1]. This patchset is based on 197b6b6
> > (Linux 6.3-rc4).
> > 
> > Welcome and thanks for your review and comments!
> > 
> > 
> > # Purpose of this patchset
> > 
> > The purpose of this pacthset is to replace all uses of kmap_atomic() in
> > i915 with kmap_local_page() because the use of kmap_atomic() is being
> > deprecated in favor of kmap_local_page()[1]. And 92b64bd (mm/highmem:
> > add notes about conversions from kmap{,_atomic}()) has declared the
> > deprecation of kmap_atomic().
> > 
> > 
> > # Motivation for deprecating kmap_atomic() and using kmap_local_page()
> > 
> > The main difference between atomic and local mappings is that local
> > mappings doesn't disable page faults or preemption (the preemption is
> > disabled for !PREEMPT_RT case, otherwise it only disables migration).
> > 
> > With kmap_local_page(), we can avoid the often unwanted side effect of
> > unnecessary page faults and preemption disables.
> > 
> > 
> > # Patch summary
> > 
> > Patch 1, 4-6 and 8-9 replace kamp_atomic()/kunmap_atomic() with
> >         kmap_local_page()/kunmap_local() directly. With thses local
> >         mappings, the page faults and preemption are allowed.
> > 
> > Patch 2 and 7 use memcpy_from_page() and memcpy_to_page() to replace
> >         kamp_atomic()/kunmap_atomic(). These two variants of memcpy()
> >         are based on the local mapping, so page faults and preemption
> >         are also allowed in these two interfaces.
> > 
> > Patch 3 replaces kamp_atomic()/kunmap_atomic() with kmap_local_page()/
> >         kunmap_local() and also diable page fault since the for special
> >         handling (pls see the commit message).
> > 
> > 
> > # Changes since v1
> > 
> > * Dropped hot plug related description in commit message since it has
> >   nothing to do with kmap_local_page().
> > * Emphasized the motivation for using kmap_local_page() in commit
> >   message.
> > * Rebased patch 1 on f47e630 (drm/i915/gem: Typecheck page lookups) to
> >   keep the "idx" variable of type pgoff_t here.
> > * Used memcpy_from_page() and memcpy_to_page() to replace
> >   kmap_local_page() + memcpy() in patch 2.
> > 
> > 
> > # Reference
> > 
> > [1]:
> > https://lore.kernel.org/lkml/20221017093726.2070674-1-zhao1.liu@linux.intel.c
> > om/ [1]:
> > https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com ---
> > Zhao Liu (9):
> >   drm/i915: Use kmap_local_page() in gem/i915_gem_object.c
> >   drm/i915: Use memcpy_[from/to]_page() in gem/i915_gem_pyhs.c
> >   drm/i915: Use kmap_local_page() in gem/i915_gem_shmem.c
> >   drm/i915: Use kmap_local_page() in gem/selftests/huge_pages.c
> >   drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_coherency.c
> >   drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_context.c
> >   drm/i915: Use memcpy_from_page() in gt/uc/intel_uc_fw.c
> >   drm/i915: Use kmap_local_page() in i915_cmd_parser.c
> >   drm/i915: Use kmap_local_page() in gem/i915_gem_execbuffer.c
> > 
> 
> I _think_ that the "long delay" you mentioned in the first sentence has paid 
> off in full. 
> 
> I don't see things to improve (except all those "kamp_atomic()" typo in the 
> patches summary; however, typos are only in the cover so I'm sure they won't 
> hurt anybody). 

Thanks a lot for your patience and your help! :-)

> 
> Each of the nine patches listed above looks good to me, so they are all¡­
> 
> Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Thanks!
> 
> Fabio
> 
> PS: Obviously there was no need to reconfirm my tag for patch 3/9. A single 
> tag that catches all patches is easier for a lazy person like me :-)

The typos and this description still can be improved. I'll pay
attention in the future!

Thanks,
Zhao

> 
> >
> >  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c       | 10 +++++-----
> >  drivers/gpu/drm/i915/gem/i915_gem_object.c           |  8 +++-----
> >  drivers/gpu/drm/i915/gem/i915_gem_phys.c             | 10 ++--------
> >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c            |  6 ++++--
> >  drivers/gpu/drm/i915/gem/selftests/huge_pages.c      |  6 +++---
> >  .../gpu/drm/i915/gem/selftests/i915_gem_coherency.c  | 12 ++++--------
> >  .../gpu/drm/i915/gem/selftests/i915_gem_context.c    |  8 ++++----
> >  drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c             |  5 +----
> >  drivers/gpu/drm/i915/i915_cmd_parser.c               |  4 ++--
> >  9 files changed, 28 insertions(+), 41 deletions(-)
> > 
> > --
> > 2.34.1
> 
> 
> 
> 
