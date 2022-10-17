Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4021E600DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJQLko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJQLkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:40:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020FF4686F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666006840; x=1697542840;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=IdGO6IfyT+ocAbiU/wKF72a1Ut/HAZwIM/FP+c6ddn0=;
  b=VaQbAkNQrtxKdryWo3LIdVaXrnZYgyN189b6lz6WifUfkiuQNgZvKg+W
   qA7dAYfLb4LjOxdPuLmLg9uL+LXifyXKYXbqa818cVqKpw6kQEbdKL67Y
   5BoMyn7jSKSq4//bV/z4xSC622QpKyMQgsf9o2E3dk1Yfq5DbEF7X5igu
   L1ooKwJ3aBw3+wqeYdmGtQBgehR4kIBO/NUTw5EldWcpkUWNri8tDzXtp
   cr74nA8PEevSb50gcn4Ti5/i8J4MuwBpFWlmaRospXiBl59wmQhMBon4p
   JRl9xOoV6ky2ZUBoYtLjsVhGgKOxcjrcuOVnuo5MF/ftud77OyeZ42U1Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="305762240"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="305762240"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 04:40:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="606095234"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="606095234"
Received: from mikkelan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.51.11])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 04:40:20 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
Cc:     ville.syrjala@linux.intel.com
Subject: Re: [Intel-gfx] alderlake crashes (random memory corruption?) with
 6.0 i915 / ucode related
In-Reply-To: <717fb4ab-5225-884f-37f9-2032c265824e@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
 <87a65usvgq.fsf@intel.com> <877d0ysv1e.fsf@intel.com>
 <717fb4ab-5225-884f-37f9-2032c265824e@redhat.com>
Date:   Mon, 17 Oct 2022 14:40:17 +0300
Message-ID: <877d0yk7a6.fsf@intel.com>
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
> On 10/17/22 10:39, Jani Nikula wrote:
>> On Mon, 17 Oct 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>> On Thu, 13 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> With 6.0 the following WARN triggers:
>>>> drivers/gpu/drm/i915/display/intel_bios.c:477:
>>>>
>>>>         drm_WARN(&i915->drm, min_size == 0,
>>>>                  "Block %d min_size is zero\n", section_id);
>>>
>>> What's the value of section_id that gets printed?
>> 
>> I'm guessing this is [1] fixed by commit d3a7051841f0 ("drm/i915/bios:
>> Use hardcoded fp_timing size for generating LFP data pointers") in
>> v6.1-rc1.
>> 
>> I don't think this is the root cause for your issues, but I wonder if
>> you could try v6.1-rc1 or drm-tip and see if we've fixed the other stuff
>> already too?
>
> 6.1-rc1 indeed does not trigger the drm_WARN and for now (couple of
> reboots, running for 5 minutes now) it seems stable. 6.0.0 usually
> crashed during boot (but not always).
>
> Do you think it would be worthwhile to try 6.0.0 with d3a7051841f0 ?

My guess is that d3a7051841f0 is a red herring. Sure, it's a warning
splat that would be nice to get fixed in v6.0, but I doubt it has
relevance to the problems you're seeing.

Cc: Ville, your thoughts?

> Any other commits which I can try before I go down the bisect route ?

Seems pretty vague I'm afraid. I know it's painful, but likely bisect is
the fastest way to pinpoint the issue and get at the root cause.

Also, filing a bug at [1] would help us get more attention.


BR,
Jani.


[1] https://gitlab.freedesktop.org/drm/intel/issues/new


>
> (I'm assuming this will also affect other users, so we really need
> to fix this for 6.0.x before it starts hitting Arch + Fedora users)
>
> Regards,
>
> Hans
>
>
>
>> [1] https://gitlab.freedesktop.org/drm/intel/-/issues/6592
>

-- 
Jani Nikula, Intel Open Source Graphics Center
