Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B078A67E711
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjA0Nu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjA0Nu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:50:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3291E1420D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674827455; x=1706363455;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ssj3B8e8skHTVBIpV4x8AC0AZSa8szTkYCtA0AUVYFU=;
  b=JPHEDEgUWRyuxhxZdeq82ROlgaazijhIaDosKGNE+qG0odD3VFj4YWOR
   oo7jI6PA6k3AmOq0aVmL9XoR83E9pprflbDGyTh5z571pbj/XjItqUHMQ
   GIZrcQLEMhm24GbqixLaXx8+fm6iuxOtzLHvfcOYB8lQV5XNAX2knFsAy
   TL7IPXPlBawW0M2ATxr2QICJZ0f4k6UWVzF6fD8+pChB6FzZQc5EZeX72
   gTKmoTR7eg4/eOAkBStPGY8Ynho3SUl5X1XLTgIp9KbiGkN5tK1qC2Pz1
   LzH6OAmuvyWnt2Lg+rfJiGoGVF0+yHJqrWMMeLGohaHe6pVLs0bhi3nwx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="325760643"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="325760643"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 05:50:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="656600167"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="656600167"
Received: from jgeary-mobl1.ger.corp.intel.com (HELO [10.213.233.162]) ([10.213.233.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 05:50:51 -0800
Message-ID: <314aff2e-c1be-61b1-d764-330f1c276f92@linux.intel.com>
Date:   Fri, 27 Jan 2023 13:50:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Avoid potential vm use-after-free
Content-Language: en-US
To:     Matthew Auld <matthew.william.auld@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        katrinzhou <katrinzhou@tencent.com>
References: <20230119173321.2825472-1-robdclark@gmail.com>
 <f24be4ca-edde-819a-5bcc-070e0d2e23d1@linux.intel.com>
 <CAM0jSHMwbUHu4kH-Y7F956+Us=TiQLJm_7y+1JbGNDaD-2J8pA@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CAM0jSHMwbUHu4kH-Y7F956+Us=TiQLJm_7y+1JbGNDaD-2J8pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/01/2023 13:10, Matthew Auld wrote:
> On Mon, 23 Jan 2023 at 16:57, Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
>>
>>
>> + some more people based on e1a7ab4fca0c
>>
>> On 19/01/2023 17:32, Rob Clark wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> Adding the vm to the vm_xa table makes it visible to userspace, which
>>> could try to race with us to close the vm.  So we need to take our extra
>>> reference before putting it in the table.
>>>
>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>> ---
>>> Note, you could list commit e1a7ab4fca0c ("drm/i915: Remove the vm open
>>> count") as the "fixed" commit, but really the issue seems to go back
>>> much further (with the fix needing some backporting in the process).
>>
>> It would probably be rather essential to identify the correct Fixes: tag.
>>
>> Since Thomas, Matt and Niranjana you were directly involved in the patch
>> which changed significantly how this works, perhaps there is something
>> still somewhat easily retrievable from your memory lanes to help with this?
> 
> Sorry for the delay. Fix looks good to me,
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> 
> Looking at the git history, the fixes tag I think needs to be:
> 
> Fixes: 9ec8795e7d91 ("drm/i915: Drop __rcu from gem_context->vm")
> Cc: <stable@vger.kernel.org> # v5.16+

As discussed offline this looks correct to me too. Thanks for looking 
into it!

Since the CI was green I have now merged the patch. Thanks for the fix Rob!

Regards,

Tvrtko

P.S. Backport to kernels which do not contain e1a7ab4fca0c ("drm/i915: 
Remove the vm open count"), so 5.16 to 5.18, will require a slightly 
different patch as Matt has also mentioned offline.

> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>>
>>>    drivers/gpu/drm/i915/gem/i915_gem_context.c | 14 +++++++++++---
>>>    1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>>> index 6250de9b9196..e4b78ab4773b 100644
>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>>> @@ -1861,11 +1861,19 @@ static int get_ppgtt(struct drm_i915_file_private *file_priv,
>>>        vm = ctx->vm;
>>>        GEM_BUG_ON(!vm);
>>>
>>> +     /*
>>> +      * Get a reference for the allocated handle.  Once the handle is
>>> +      * visible in the vm_xa table, userspace could try to close it
>>> +      * from under our feet, so we need to hold the extra reference
>>> +      * first.
>>> +      */
>>> +     i915_vm_get(vm);
>>> +
>>>        err = xa_alloc(&file_priv->vm_xa, &id, vm, xa_limit_32b, GFP_KERNEL);
>>> -     if (err)
>>> +     if (err) {
>>> +             i915_vm_put(vm);
>>>                return err;
>>> -
>>> -     i915_vm_get(vm);
>>> +     }
>>>
>>>        GEM_BUG_ON(id == 0); /* reserved for invalid/unassigned ppgtt */
>>>        args->value = id;
