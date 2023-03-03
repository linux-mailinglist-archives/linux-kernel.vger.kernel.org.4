Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A31F6A9A3E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjCCPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjCCPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:08:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1157D20575;
        Fri,  3 Mar 2023 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677856102; x=1709392102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s8d3oS7J43u4ul75ZgButvm6v6s/YZ4L8cHni8MIrkk=;
  b=WIT1QlHRsxZdkpSecnm+qJoK+9rFLqKPGVJyrVQ+3aW2KsPu1+CFgK3D
   IWFH139XiGNU8OYeAEin9qZK8wUN0oYc1tPkzDaZG8W91eJ5/XKbukkfa
   KzDY1ypB+SHr7PxAupbdIg9Yj/otWLZ41J5o3bOD8ujcVEA99Lb26ccXk
   P7aCJ3yA+O60mC55oeBqP0pKQyAbU3MGa/FdpppdoVYebRsd4DirnpF+b
   qdZ5R+68Nrn6YwbVzRdWpu3r4/ntQOvIFVFCnl8rTy2VUtlMY+ryzaw5i
   KvuikupUNIcfvQo4LdOKZvguDj7mgeIHK8ROUIl6HX3KoQXcpZiXYNMIT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="399871692"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="399871692"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 07:07:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="739528150"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="739528150"
Received: from npalanis-mobl1.ger.corp.intel.com (HELO [10.213.202.105]) ([10.213.202.105])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 07:07:06 -0800
Message-ID: <a5ced581-4060-0fa2-d2fc-d18beee6fdb5@linux.intel.com>
Date:   Fri, 3 Mar 2023 15:07:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 15/15] drm/i915: Add deadline based boost support
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Matt Turner <mattst88@gmail.com>
References: <20230302235356.3148279-1-robdclark@gmail.com>
 <20230302235356.3148279-16-robdclark@gmail.com> <ZAFnqbycMleLmRe9@intel.com>
 <3bded9d7-9796-4a9b-7c11-aac994d4fdc6@linux.intel.com>
 <CAF6AEGs6QYTESuwB8E9cTbv9LqQX16tz6-geeu9BCyFos9=sOA@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CAF6AEGs6QYTESuwB8E9cTbv9LqQX16tz6-geeu9BCyFos9=sOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/03/2023 14:48, Rob Clark wrote:
> On Fri, Mar 3, 2023 at 1:58 AM Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
>>
>>
>> On 03/03/2023 03:21, Rodrigo Vivi wrote:
>>> On Thu, Mar 02, 2023 at 03:53:37PM -0800, Rob Clark wrote:
>>>> From: Rob Clark <robdclark@chromium.org>
>>>>
>>>
>>> missing some wording here...
>>>
>>>> v2: rebase
>>>>
>>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>>> ---
>>>>    drivers/gpu/drm/i915/i915_request.c | 20 ++++++++++++++++++++
>>>>    1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
>>>> index 7503dcb9043b..44491e7e214c 100644
>>>> --- a/drivers/gpu/drm/i915/i915_request.c
>>>> +++ b/drivers/gpu/drm/i915/i915_request.c
>>>> @@ -97,6 +97,25 @@ static bool i915_fence_enable_signaling(struct dma_fence *fence)
>>>>       return i915_request_enable_breadcrumb(to_request(fence));
>>>>    }
>>>>
>>>> +static void i915_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>>>> +{
>>>> +    struct i915_request *rq = to_request(fence);
>>>> +
>>>> +    if (i915_request_completed(rq))
>>>> +            return;
>>>> +
>>>> +    if (i915_request_started(rq))
>>>> +            return;
>>>
>>> why do we skip the boost if already started?
>>> don't we want to boost the freq anyway?
>>
>> I'd wager Rob is just copying the current i915 wait boost logic.
> 
> Yup, and probably incorrectly.. Matt reported fewer boosts/sec
> compared to your RFC, this could be the bug

Hm, there I have preserved this same !i915_request_started logic.

Presumably it's not just fewer boosts but lower performance. How is he 
setting the deadline? Somehow from clFlush or so?

Regards,

Tvrtko

P.S. Take note that I did not post the latest version of my RFC. The one 
where I fix the fence chain and array misses you pointed out. I did not 
think it would be worthwhile given no universal love for it, but if 
people are testing with it more widely that I was aware perhaps I should.

>>>> +
>>>> +    /*
>>>> +     * TODO something more clever for deadlines that are in the
>>>> +     * future.  I think probably track the nearest deadline in
>>>> +     * rq->timeline and set timer to trigger boost accordingly?
>>>> +     */
>>>
>>> I'm afraid it will be very hard to find some heuristics of what's
>>> late enough for the boost no?
>>> I mean, how early to boost the freq on an upcoming deadline for the
>>> timer?
>>
>> We can off load this patch from Rob and deal with it separately, or
>> after the fact?
> 
> That is completely my intention, I expect you to replace my i915 patch ;-)
> 
> Rough idea when everyone is happy with the core bits is to setup an
> immutable branch without the driver specific patches, which could be
> merged into drm-next and $driver-next and then each driver team can
> add there own driver patches on top
> 
> BR,
> -R
> 
>> It's a half solution without a smarter scheduler too. Like
>> https://lore.kernel.org/all/20210208105236.28498-10-chris@chris-wilson.co.uk/,
>> or if GuC plans to do something like that at any point.
>>
>> Or bump the priority too if deadline is looming?
>>
>> IMO it is not very effective to fiddle with the heuristic on an ad-hoc
>> basis. For instance I have a new heuristics which improves the
>> problematic OpenCL cases for further 5% (relative to the current
>> waitboost improvement from adding missing syncobj waitboost). But I
>> can't really test properly for regressions over platforms, stacks,
>> workloads.. :(
>>
>> Regards,
>>
>> Tvrtko
>>
>>>
>>>> +
>>>> +    intel_rps_boost(rq);
>>>> +}
>>>> +
>>>>    static signed long i915_fence_wait(struct dma_fence *fence,
>>>>                                  bool interruptible,
>>>>                                  signed long timeout)
>>>> @@ -182,6 +201,7 @@ const struct dma_fence_ops i915_fence_ops = {
>>>>       .signaled = i915_fence_signaled,
>>>>       .wait = i915_fence_wait,
>>>>       .release = i915_fence_release,
>>>> +    .set_deadline = i915_fence_set_deadline,
>>>>    };
>>>>
>>>>    static void irq_execute_cb(struct irq_work *wrk)
>>>> --
>>>> 2.39.1
>>>>
