Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF1601055
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJQNfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJQNfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:35:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3460B7C1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666013750; x=1697549750;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=v7jjpT/TsnfTena0roBzKZdAI2vqN1rpegjWRfwsKyw=;
  b=HK9JgUGYVY3nTcxJtLj4GtJLvBVo6K3PtcmlLe6MK/IdkrYIeb70aqo4
   isWM1iooiRX+fFQwVz+MPfH6pDenR86/llpDo8+gUC6FmgjKwvknSy4BM
   5HSFCBOyaPo6It7l1iumRIQfWK0xUc6IfxHCqb3fTqplcffGxsdMLRlSL
   1eb63+SRZP4UgjMBylVD30jB/sgAlHT2Gvsp6IFEymXAGa3f8fnYugd5G
   E9oSlAfAQLUfH9qo6IKxFwSBEjzWtHjx/U5m0i2QYFpO4+ZqoFVHH8kCL
   yBSzngbURih3JOgVn6rKg0f469YzC50qwXWkTEUSMtz1Re/IgnYJVZxlb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="303412261"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="303412261"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 06:35:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="873466667"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="873466667"
Received: from mikkelan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.51.11])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 06:35:26 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] alderlake crashes (random memory corruption?) with
 6.0 i915 / ucode related
In-Reply-To: <fac9a564-edff-db25-20d4-7146ae2a7dc8@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
 <87a65usvgq.fsf@intel.com> <877d0ysv1e.fsf@intel.com>
 <717fb4ab-5225-884f-37f9-2032c265824e@redhat.com>
 <241af90a-4cec-9266-8fb0-3c69f9880b52@leemhuis.info>
 <fac9a564-edff-db25-20d4-7146ae2a7dc8@redhat.com>
Date:   Mon, 17 Oct 2022 16:35:24 +0300
Message-ID: <87tu42indv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 10/17/22 13:19, Thorsten Leemhuis wrote:
>> CCing the regression mailing list, as it should be in the loop for all
>> regressions, as explained here:
>> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
>
> Yes sorry about that I meant to Cc the regressions list, not you personally,
> but the auto-completion picked the wrong address-book entry
> (and I did not notice this).
>
>> On 17.10.22 12:48, Hans de Goede wrote:
>>> On 10/17/22 10:39, Jani Nikula wrote:
>>>> On Mon, 17 Oct 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>>>> On Thu, 13 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>> With 6.0 the following WARN triggers:
>>>>>> drivers/gpu/drm/i915/display/intel_bios.c:477:
>>>>>>
>>>>>>         drm_WARN(&i915->drm, min_size == 0,
>>>>>>                  "Block %d min_size is zero\n", section_id);
>>>>>
>>>>> What's the value of section_id that gets printed?
>>>>
>>>> I'm guessing this is [1] fixed by commit d3a7051841f0 ("drm/i915/bios:
>>>> Use hardcoded fp_timing size for generating LFP data pointers") in
>>>> v6.1-rc1.
>>>>
>>>> I don't think this is the root cause for your issues, but I wonder if
>>>> you could try v6.1-rc1 or drm-tip and see if we've fixed the other stuff
>>>> already too?
>>>
>>> 6.1-rc1 indeed does not trigger the drm_WARN and for now (couple of
>>> reboots, running for 5 minutes now) it seems stable. 6.0.0 usually
>>> crashed during boot (but not always).
>>>
>>> Do you think it would be worthwhile to try 6.0.0 with d3a7051841f0 ?
>
> So I have been trying 6.0.0 with d3a7051841f0 doing a whole bunch of
> reboots + general use and that seems stable, then I reverted it and
> the very first boot of the kernel with that broke again, so I'm
> pretty sure that d3a7051841f0 fixes things.
>
> So d3a7051841f0 seems to do more then just fix the WARN().

Wow, so I guess we do screw up the parsing royally then. :o

> So lets try to get d3a7051841f0 added to the official stable series
> ASAP (I just noticed that Mark Pearson from Lenovo has already added it
> to Fedora's 6.0.2 build.

I think I'd also pick d3a7051841f0^ i.e. both commits:

d3a7051841f0 ("drm/i915/bios: Use hardcoded fp_timing size for generating LFP data pointers")
4e78d6023c15 ("drm/i915/bios: Validate fp_timing terminator presence")

for stable.

BR,
Jani.


>
> Regards,
>
> Hans
>

-- 
Jani Nikula, Intel Open Source Graphics Center
