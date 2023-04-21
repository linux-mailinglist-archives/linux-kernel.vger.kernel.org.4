Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAF16EA9D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjDUL7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjDUL7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:59:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B923585;
        Fri, 21 Apr 2023 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682078355; x=1713614355;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GlskIVbpC/T4dBmlRS8eqI09qaAdrtmiII1F3Y+p6K0=;
  b=UnbW9gNe5H8MndovTbl7rDYiaWTOH8O0G9VmZtLL+TkBmzqj8q1uWZvG
   726fynghcl4VvEZgUXgonSFNMgOkbE64VHR4UAnAWi612XG1H0BQbAiyP
   U2BpesfzjM58OzKeL7XhCG9t5x5Fbg/UQjz6LKEtt8sdv7SPOPrHuX6tb
   THM7CcKdb4AlyoBPrxNtGNea36CZ79qgn8irAWjj6+fZus9Nw5S+E+6RS
   nUZhq8XdMzeHF9ya4eDbpzlqdiQhyA7CpaOip9P4AfWygMZNnKoqiNfMc
   PD6zS3WF2A6LH0ixhkG8PglUbi9nTiOdurZfY6DvJDy92IWzyQio46vh8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="345994919"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="345994919"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 04:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="938458823"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="938458823"
Received: from vhavelx-mobl2.ger.corp.intel.com (HELO [10.213.192.37]) ([10.213.192.37])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 04:59:10 -0700
Message-ID: <e16dc626-30bf-be19-8668-bdc14dfd051a@linux.intel.com>
Date:   Fri, 21 Apr 2023 12:59:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 5/6] drm: Add fdinfo memory stats
Content-Language: en-US
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230412224311.23511-1-robdclark@gmail.com>
 <20230412224311.23511-6-robdclark@gmail.com>
 <CACvgo525ogS4LSZDUyaqjSqjJWj=qLRkphji5469=3obFXoMrQ@mail.gmail.com>
 <f2a423c2-302a-024a-cf65-199f4be6caec@linux.intel.com>
 <CACvgo53dP03r1BuxntyyoYjua5k6XPvVhu4iTGqXJq31UMUgxg@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CACvgo53dP03r1BuxntyyoYjua5k6XPvVhu4iTGqXJq31UMUgxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/04/2023 12:45, Emil Velikov wrote:
> On Fri, 21 Apr 2023 at 12:23, Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
> 
>> On 21/04/2023 11:26, Emil Velikov wrote:
>>> On Wed, 12 Apr 2023 at 23:43, Rob Clark <robdclark@gmail.com> wrote:
>>>
>>>> +/**
>>>> + * enum drm_gem_object_status - bitmask of object state for fdinfo reporting
>>>> + * @DRM_GEM_OBJECT_RESIDENT: object is resident in memory (ie. not unpinned)
>>>> + * @DRM_GEM_OBJECT_PURGEABLE: object marked as purgeable by userspace
>>>> + *
>>>> + * Bitmask of status used for fdinfo memory stats, see &drm_gem_object_funcs.status
>>>> + * and drm_show_fdinfo().  Note that an object can DRM_GEM_OBJECT_PURGEABLE if
>>>> + * it still active or not resident, in which case drm_show_fdinfo() will not
>>>
>>> nit: s/can/can be/;s/if it still/if it is still/
>>>
>>>> + * account for it as purgeable.  So drivers do not need to check if the buffer
>>>> + * is idle and resident to return this bit.  (Ie. userspace can mark a buffer
>>>> + * as purgeable even while it is still busy on the GPU.. it does not _actually_
>>>> + * become puregeable until it becomes idle.  The status gem object func does
>>>
>>> nit: s/puregeable/purgeable/
>>>
>>>
>>> I think we want a similar note in the drm-usage-stats.rst file.
>>>
>>> With the above the whole series is:
>>> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
>>
>> Have you maybe noticed my slightly alternative proposal? (*) I am not a
>> fan of putting this flavour of accounting into the core with no way to
>> opt out. I think it leaves no option but to add more keys in the future
>> for any driver which will not be happy with the core accounting.
>>
>> *) https://patchwork.freedesktop.org/series/116581/
>>
> 
> Indeed I saw it. Not a fan of it, I'm afraid.

Hard to guess the reasons. :)

Anyway, at a minimum I suggest that if the no opt out version has to go 
in, it is clearly documented drm-*-memory-* is *not* about the full 
memory use of the client, but about memory belonging to user visible 
buffer objects *only*. Possibly going as far as naming the keys as 
drm-user-bo-memory-... That way there is a way to implement proper 
drm-*-memory- in the future.

Regards,

Tvrtko

>>> Fwiw: Keeping the i915 patch as part of this series would be great.
>>> Sure i915_drm_client->id becomes dead code, but it's a piece one can
>>> live with for a release or two. Then again it's not my call to make.
>>
>> Rob can take the i915 patch from my RFC too.
>>
> 
> Indeed.
> 
> -Emil
