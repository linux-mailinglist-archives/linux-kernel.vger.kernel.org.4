Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFABB6DFA87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDLPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDLPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:45:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F4F59F0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681314320; x=1712850320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IERnqLXMW+gb74vzXKSwdmaOj1kubqs2Fl+YWa4aSvM=;
  b=n4zGrM1xRbZcY8kOR2T1GC27T2z2fvkrGwYeivp4YEA9cIB8pNSIr6ej
   J3MR1+fS706QKDq3HWDATkRbp38ez3Kx6eT3BwBKn7SKu80VvFTV1EGDk
   6+Mu5zUN/LM5obarNEvwp7yHM7yWM6XMDSUoED4D/Reyx3F7xPxTnhamc
   A822XFewtqQ05+IUd+NcULci54/X9eGuwXtsW9iSWbWB0+7gxl3BnyHn9
   Pc1DDwXCog4slY0FNznTGZoB4GTz6YWfXtr/axttZQaHPgVu/mZj6eFuX
   6DNc1rsLf+Zw97gDV/Sd+HeohgsmkAbI5rnpV4OtEGKkioHF/RmaMYQUE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324297150"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324297150"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="719416191"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="719416191"
Received: from amurkovx-mobl.ger.corp.intel.com (HELO [10.213.229.123]) ([10.213.229.123])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:45:15 -0700
Message-ID: <1b341218-f0e2-a613-2ac6-107064a813ca@linux.intel.com>
Date:   Wed, 12 Apr 2023 16:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 9/9] drm/i915: Use kmap_local_page() in
 gem/i915_gem_execbuffer.c
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
References: <20230329073220.3982460-1-zhao1.liu@linux.intel.com>
 <64265ef8725fe_375f7e294a@iweiny-mobl.notmuch>
 <fdc8a470-1e6b-815d-e367-a9df1b0b14dd@linux.intel.com>
 <2177327.1BCLMh4Saa@suse>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <2177327.1BCLMh4Saa@suse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/03/2023 16:32, Fabio M. De Francesco wrote:
> On venerdì 31 marzo 2023 13:30:20 CEST Tvrtko Ursulin wrote:
>> On 31/03/2023 05:18, Ira Weiny wrote:
>>> Zhao Liu wrote:
>>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>>
>>>> The use of kmap_atomic() is being deprecated in favor of
>>>> kmap_local_page()[1], and this patch converts the calls from
>>>> kmap_atomic() to kmap_local_page().
>>>>
>>>> The main difference between atomic and local mappings is that local
>>>> mappings doesn't disable page faults or preemption (the preemption is
>>>> disabled for !PREEMPT_RT case, otherwise it only disables migration).
>>>>
>>>> With kmap_local_page(), we can avoid the often unwanted side effect of
>>>> unnecessary page faults and preemption disables.
>>>>
>>>> In i915_gem_execbuffer.c, eb->reloc_cache.vaddr is mapped by
>>>> kmap_atomic() in eb_relocate_entry(), and is unmapped by
>>>> kunmap_atomic() in reloc_cache_reset().
>>>
>>> First off thanks for the series and sticking with this.  That said this
>>> patch kind of threw me for a loop because tracing the map/unmap calls did
>>> not make sense to me.  See below.
>>>
>>>> And this mapping/unmapping occurs in two places: one is in
>>>> eb_relocate_vma(), and another is in eb_relocate_vma_slow().
>>>>
>>>> The function eb_relocate_vma() or eb_relocate_vma_slow() doesn't
>>>> need to disable pagefaults and preemption during the above mapping/
>>>> unmapping.
>>>>
>>>> So it can simply use kmap_local_page() / kunmap_local() that can
>>>> instead do the mapping / unmapping regardless of the context.
>>>>
>>>> Convert the calls of kmap_atomic() / kunmap_atomic() to
>>>> kmap_local_page() / kunmap_local().
>>>>
>>>> [1]:
>>>> https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
>>>>
>>>> v2: No code change since v1. Added description of the motivation of
>>>>
>>>>       using kmap_local_page() and "Suggested-by" tag of Fabio.
>>>>
>>>> Suggested-by: Ira Weiny <ira.weiny@intel.com>
>>>> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>>> ---
>>>>
>>>> Suggested by credits:
>>>>     Ira: Referred to his task document, review comments.
>>>>     Fabio: Referred to his boiler plate commit message and his description
>>>>     
>>>>            about why kmap_local_page() should be preferred.
>>>>
>>>> ---
>>>>
>>>>    drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 10 +++++-----
>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
> 
> [snip]
>   
>> However I am unsure if disabling pagefaulting is needed or not. Thomas,
>> Matt, being the last to touch this area, perhaps you could have a look?
>> Because I notice we have a fallback iomap path which still uses
>> io_mapping_map_atomic_wc. So if kmap_atomic to kmap_local conversion is
>> safe, does the iomap side also needs converting to
>> io_mapping_map_local_wc? Or they have separate requirements?
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

I am not saying it is, was just unsure and wanted some people who worked on this code most recently to take a look and confirm.

I guess it will work since the copying is done like this anyway:

		/*
		 * This is the fast path and we cannot handle a pagefault
		 * whilst holding the struct mutex lest the user pass in the
		 * relocations contained within a mmaped bo. For in such a case
		 * we, the page fault handler would call i915_gem_fault() and
		 * we would try to acquire the struct mutex again. Obviously
		 * this is bad and so lockdep complains vehemently.
		 */
		pagefault_disable();
		copied = __copy_from_user_inatomic(r, urelocs, count * sizeof(r[0]));
		pagefault_enable();
		if (unlikely(copied)) {
			remain = -EFAULT;
			goto out;
		}

Comment is a bit outdated since we don't use that global "struct mutex" any longer, but in any case, if there is a page fault on the mapping where we need to recurse into i915 again to satisfy if, we seem to have code already to handle it. So kmap_local conversion I *think* can't regress anything.

Patch to convert the io_mapping_map_atomic_wc can indeed come later.

In terms of logistics - if we landed this series to out branch it would be queued only for 6.5. Would that work for you?

Regards,

Tvrtko
