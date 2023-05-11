Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF96FFAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbjEKT6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjEKT6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:58:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4FF2D74;
        Thu, 11 May 2023 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683835089; x=1715371089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oZQ2G4WUfAcfYRxx/1cCaNzzx8xkE/WLQXfCP4Oc3BE=;
  b=J1Q9LW9qKHiIAECKGTfYpf0wRw0t0TKBr2XKntWceh6atxq2mcQwpcD7
   zosXh86LgRMA/Ovu+YtL59JbN8spLECJNs/rfZXs0v9Q+B01nOW7aMMcw
   qUxcDnIrFbenMxRocOVva1vbXfekzNLJ6L92NCDZsuOfYYfNV+iFy1LSR
   3BWB5lK8Bm8kIDQ+iPKFcUyBiYMdMn/1nP/qxWea0zJCXs5Uxo+Rn0rJB
   T59w9YnMKWeXYA/0IKmXO2uB0/Ou+FDcx0+Zymj1Zmoqk4btxPdmJp6V1
   W3Mv5LwrX/+bt2kuyYKHmBNyErmTpy4m8maym2vJs+CuAuaColSjfbm1x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="349456615"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="349456615"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 12:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="946319301"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="946319301"
Received: from acharach-mobl.ger.corp.intel.com (HELO [10.251.219.38]) ([10.251.219.38])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 12:58:03 -0700
Message-ID: <a7200fd7-769c-6a32-0fa7-6a37b7214d70@linux.intel.com>
Date:   Thu, 11 May 2023 21:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [Intel-gfx] [RFC PATCH 0/4] Add support for DRM cgroup memory
 accounting.
Content-Language: en-US
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        intel-xe@lists.freedesktop.org
References: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
 <ZFVeI2DKQXddKDNl@slm.duckdns.org>
 <4d6fbce3-a676-f648-7a09-6f6dcc4bdb46@linux.intel.com>
 <ZFvmaGNo0buQEUi1@slm.duckdns.org>
 <562bd20d-36b9-a617-92cc-460f2eece22e@linux.intel.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <562bd20d-36b9-a617-92cc-460f2eece22e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On 2023-05-11 12:14, Tvrtko Ursulin wrote:
>
> On 10/05/2023 19:46, Tejun Heo wrote:
>> Hello,
>>
>> On Wed, May 10, 2023 at 04:59:01PM +0200, Maarten Lankhorst wrote:
>>> The misc controller is not granular enough. A single computer may have any number of
>>> graphics cards, some of them with multiple regions of vram inside a single card.
>>
>> Extending the misc controller to support dynamic keys shouldn't be that
>> difficult.
>>
>> ...
>>> In the next version, I will move all the code for handling the resource limit to
>>> TTM's eviction layer, because otherwise it cannot handle the resource limit correctly.
>>>
>>> The effect of moving the code to TTM, is that it will make the code even more generic
>>> for drivers that have vram and use TTM. When using TTM, you only have to describe your
>>> VRAM, update some fields in the TTM manager and (un)register your device with the
>>> cgroup handler on (un)load. It's quite trivial to add vram accounting to amdgpu and
>>> nouveau. [2]
>>>
>>> If you want to add a knob for scheduling weight for a process, it makes sense to
>>> also add resource usage as a knob, otherwise the effect of that knob is very
>>> limited. So even for Tvrtko's original proposed usecase, it would make sense.
>>
>> It does make sense but unlike Tvrtko's scheduling weights what's being
>> proposed doesn't seem to encapsulate GPU memory resource in a generic enough
>> manner at least to my untrained eyes. ie. w/ drm.weight, I don't need any
>> specific knoweldge of how a specific GPU operates to say "this guy should
>> get 2x processing power over that guy". This more or less holds for other
>> major resources including CPU, memory and IO. What you're proposing seems a
>> lot more tied to hardware details and users would have to know a lot more
>> about how memory is configured on that particular GPU.
>>
>> Now, if this is inherent to how all, or at least most, GPUs operate, sure,
>> but otherwise let's start small in terms of interface and not take up space
>> which should be for something universal. If this turns out to be the way,
>> expanding to take up the generic interface space isn't difficult.
>>
>> I don't know GPU space so please educate me where I'm wrong.
>
> I was hoping it might be passable in principle (in some form, pending discussion on semantics) given how Maarten's proposal starts with only very specific per-device-per-memory regions controls, which is applicable to many devices. And hard limit at that, which probably has less complicated semantics, or at least implementation.
>
> My understanding of the proposal is that the allocation either fits, or it evicts from the parent's hierarchy (if possible) and then fits, or it fails. Which sounds simple enough.

Yeah, for vram itś that simple. I think for mapped and sysmem regions we may require the
possiblity to ignore the limits as well, as it's possible to move to those regions from
eviction. We probably don't want eviction to fail because of too low limits.

> I do however agree that it is a limited use case. So from the negative side of the debating camp I have to ask if this use case could be simply satisfied by providing a driver/device global over commit yes/no control? In other words, is it really important to partition the vram space ahead of time, and from the kernel side too? Wouldn't the relevant (highly specialised) applications work just fine with global over commit disabled? Even if the option to configure their maximum allowed working set from the userspace side was needed.

Disabling overcommit? Do you mean pinning the memory workload? This causes a denial of service if
done without limits, and that's what we're trying to avoid. There is no need for immunity from
eviction. Overcommit is still useful inside the cgroup itself, we only want immunity from being
evicted by another process performing another workload.

> Or if we conclude cgroup controller is the way to go, would adding less specific limits make it more palatable? I am thinking here some generic "device memory resident". Not per device, not per memory region. So userspace/admins have some chance of configuring generic limits. That would require coming up with more generic use cases though so another thing to discuss. Like who would use that and for what.

You would run into ambiguity with that. I think it's fine to assume any number of vram regions. In most cases, the number is 1.

I don't see that number going much higher, 2 is already on the high side. A simple controller could just half each region separately.

> Assuming also we can agree that "device memory resident" is a stable/solid concept across drm. Should be easier than for integrated GPUs, for which I have to admit I currently don't remember if allocations are already consistently covered by the memory controller. Even if they are ownership is probably wrong.
Likely, especially when evicting another process' memory. That needs some thought. Likely we have to keep the original cgroup as an owner.
> Group ownership is possibly a concern in this proposal too. Because I remember the previous attempt of adding some drm stats to memcg explained that for instance on Android all buffers are allocated by a central process and then handed over to other processes. So transferring ownership was explained as critical.
Is this done using dma-buf? Ownership could be handed over on import then. If not, what is the mechanism they use?
> Regards,
>
> Tvrtko
>
> P.S.
> On the matter of naming the uapi interface - in any case I wouldn't use the "unqualified" drm namespace such as drm.max/current/capacity. I think all those should include a specific prefix to signify it is about memory. In some way.

I've deliberately added region to each key, so what happens is that drm.capacity/max/current contains: $pciid region.vram0=$value, that way, if we want to add non-memory resources, it becomes possible to do so by choosing a different prefix.

For example number of engines that can be created would also be possible to add to those files, but that might be more driver specific.

I tried to keep it generic like that. In this way I didn't immediately pollute the entire namespace.

Of course, if needed, we can make it drm.region_max etc instead and drop it from the cgroup key entries instead.

Cheers,

Maarten

