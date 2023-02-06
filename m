Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31A568B8C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjBFJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFJgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:36:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FA312F3D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675676159; x=1707212159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OV4hu9Cv4oGEnss556qD7ZX4r/ehOr4vxxDxMa+/ABo=;
  b=Wfbjp2AIM3/y2oVw5ILHnF1Kq8tZ5DhZAScTXfT05edJthfId7wChJ7S
   G96AVGMw+a1U1W3SoZQ/xvKSpuU0PkSUFr726Zqudz+c6UIN8OXP2Wnif
   gqUa5l72c32TjHE6daTlIDUPst4rkiZ94NN0IYIJ2Om4BalBOB1vjjhyn
   Zsxx+zitbsnOtJKjj6hntXjN8MH4hbAv2pJdiaO/5MSib1Ej40DxLAFyL
   EXiGXBRfzqYmgwduB84WeCzTvnEaGBXbru08ZTE60pkf2H+qxygVTNpLY
   9ahguB4wap75to8vwKea3rTZjQ7wZ6Rm2qkkbJY04b+cXyCrgZa7MM5vU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="330458340"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="330458340"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 01:35:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="668360569"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="668360569"
Received: from vastrong-mobl.amr.corp.intel.com (HELO [10.213.203.226]) ([10.213.203.226])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 01:35:54 -0800
Message-ID: <e2403d2c-b088-fb05-64a6-f933f12dfb40@linux.intel.com>
Date:   Mon, 6 Feb 2023 09:35:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/i915: Move fd_install after last use of fence
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Matthew Brost <matthew.brost@intel.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        jason.ekstrand@collabora.com
References: <20230203164937.4035503-1-robdclark@gmail.com>
 <CAF6AEGvanLri-+Z5KgmgSFX2ShB09T7X7wxcSQk_0JV7PKGRng@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CAF6AEGvanLri-+Z5KgmgSFX2ShB09T7X7wxcSQk_0JV7PKGRng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/02/2023 18:15, Rob Clark wrote:
> On Fri, Feb 3, 2023 at 8:49 AM Rob Clark <robdclark@gmail.com> wrote:
>>
>> From: Rob Clark <robdclark@chromium.org>
>>
>> Because eb_composite_fence_create() drops the fence_array reference
>> after creation of the sync_file, only the sync_file holds a ref to the
>> fence.  But fd_install() makes that reference visable to userspace, so
>> it must be the last thing we do with the fence.
>>
> 
> Fixes: 00dae4d3d35d ("drm/i915: Implement SINGLE_TIMELINE with a syncobj (v4)")

This is correct and the fix looks good to me.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

CI is green so I will merge it, thanks again for a fix Rob!

Followup up question for Matthew Brost however is whether the composite 
fence flow could be simplified. This block here comes late in 
i915_gem_do_execbuffer and may mislead the user the composite fence is 
held to the end of the function:

	if (!out_fence && eb.composite_fence)
		dma_fence_put(eb.composite_fence);

Question is would it work to remove the !out_fence condition from here, 
and remove "consumption" of the reference from eb_composite_fence_create 
success path.

Regards,

Tvrtko

>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
>> index f266b68cf012..0f2e056c02dd 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
>> @@ -3476,38 +3476,38 @@ i915_gem_do_execbuffer(struct drm_device *dev,
>>
>>   err_request:
>>          eb_requests_get(&eb);
>>          err = eb_requests_add(&eb, err);
>>
>>          if (eb.fences)
>>                  signal_fence_array(&eb, eb.composite_fence ?
>>                                     eb.composite_fence :
>>                                     &eb.requests[0]->fence);
>>
>> +       if (unlikely(eb.gem_context->syncobj)) {
>> +               drm_syncobj_replace_fence(eb.gem_context->syncobj,
>> +                                         eb.composite_fence ?
>> +                                         eb.composite_fence :
>> +                                         &eb.requests[0]->fence);
>> +       }
>> +
>>          if (out_fence) {
>>                  if (err == 0) {
>>                          fd_install(out_fence_fd, out_fence->file);
>>                          args->rsvd2 &= GENMASK_ULL(31, 0); /* keep in-fence */
>>                          args->rsvd2 |= (u64)out_fence_fd << 32;
>>                          out_fence_fd = -1;
>>                  } else {
>>                          fput(out_fence->file);
>>                  }
>>          }
>>
>> -       if (unlikely(eb.gem_context->syncobj)) {
>> -               drm_syncobj_replace_fence(eb.gem_context->syncobj,
>> -                                         eb.composite_fence ?
>> -                                         eb.composite_fence :
>> -                                         &eb.requests[0]->fence);
>> -       }
>> -
>>          if (!out_fence && eb.composite_fence)
>>                  dma_fence_put(eb.composite_fence);
>>
>>          eb_requests_put(&eb);
>>
>>   err_vma:
>>          eb_release_vmas(&eb, true);
>>          WARN_ON(err == -EDEADLK);
>>          i915_gem_ww_ctx_fini(&eb.ww);
>>
>> --
>> 2.38.1
>>
