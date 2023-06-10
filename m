Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778EC72A9D0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 09:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjFJHW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 03:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFJHW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:22:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B4B3AA4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686381775; x=1717917775;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cZ3y13O9a+VnlQM8pm98l7UsnYGvVfxkqNekXMNb3v4=;
  b=Vb8LdU2L1HDdzi1MlUpRlavWuHihtH3BJFld1fBJIr7v4L98Thb9nlFf
   bHdom0uYmYqbgNducibUO7IkV9eV/E52t3IenxugkI8rlFCj/lnaZ2fGE
   IyhVGeUXMzRqWThXILZCRPuuHutpy3F61iSYi5L2v/3IbfkAqVDPkQgau
   BJMxP1uGYSXO5fzRgczkcuJ8myxpL+UePwJHiqIalIqP4VkfRSp6z/oRX
   hXX4k2R7KpcgMg+BjS27RSPRpNDyjz6kvq+duffxszJIGFZ1Qzs1OU//3
   M3JH7hGIVfHzb3vA/eW1RKLkDiBO0+FcC5dFtil8WvuT167VgInaQiy38
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="355231348"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="355231348"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 00:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="743725436"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="743725436"
Received: from mnovakov-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.60.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 00:22:35 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Ralph Campbell <rcampbell@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/edid: Add quirk for OSVR HDK 2.0
In-Reply-To: <09cc666a-bc52-44b3-230c-26dc705c5a56@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230609014207.2759720-1-rcampbell@nvidia.com>
 <87y1ktqa75.fsf@intel.com>
 <09cc666a-bc52-44b3-230c-26dc705c5a56@nvidia.com>
Date:   Sat, 10 Jun 2023 10:22:32 +0300
Message-ID: <87r0qjpyrr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023, Ralph Campbell <rcampbell@nvidia.com> wrote:
> On 6/9/23 02:03, Jani Nikula wrote:
>> On Thu, 08 Jun 2023, Ralph Campbell <rcampbell@nvidia.com> wrote:
>>> The OSVR virtual reality headset HDK 2.0 uses a different EDID
>>> vendor and device identifier than the HDK 1.1 - 1.4 headsets.
>>> Add the HDK 2.0 vendor and device identifier to the quirks table so
>>> that window managers do not try to display the desktop screen on the
>>> headset display.
>> At some point in time we requested bugs to be filed about quirks, with
>> EDIDs attached, so we could look at them later, and maybe remove the
>> quirks.
>>
>> The headset non-desktop thing started off as a quirk, but since then
>> we've added both Microsoft VSDB and DisplayID primary use as ways to
>> indicate this without quirks.
>>
>> BR,
>> Jani.
>
> If you want me to file a bug, I can do that and I have the EDID too.
> Where would I file it?

I suppose at https://gitlab.freedesktop.org/drm/misc/-/issues

We should then reference the issue in the commit message (no need to
resend, this can be added while applying).

> I did see the DisplayID 2.0 code. This headset is no longer being
> manufactured so updating the EDID is not practical.

I'm not saying the EDID should be updated, just that we might drop the
quirk if we find another generic way to identify non-desktops that
covers the EDID in question.

If the device isn't covered by the existing mechanisms, I'm not opposed
to merging as-is, with the issue reference added.


Thanks,
Jani.


>
>>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>>> Tested-by: Ralph Campbell <rcampbell@nvidia.com>
>>> ---
>>>   drivers/gpu/drm/drm_edid.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> I don't know how many of these VR headsets are still around but I have a
>>> working one and I saw and entry for HDK 1.x so I thought it would be good
>>> to add HDK 2.0.
>>>
>>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>>> index 0454da505687..3b8cc1fe05e8 100644
>>> --- a/drivers/gpu/drm/drm_edid.c
>>> +++ b/drivers/gpu/drm/drm_edid.c
>>> @@ -230,6 +230,7 @@ static const struct edid_quirk {
>>>   
>>>   	/* OSVR HDK and HDK2 VR Headsets */
>>>   	EDID_QUIRK('S', 'V', 'R', 0x1019, EDID_QUIRK_NON_DESKTOP),
>>> +	EDID_QUIRK('A', 'O', 'U', 0x1111, EDID_QUIRK_NON_DESKTOP),
>>>   };
>>>   
>>>   /*

-- 
Jani Nikula, Intel Open Source Graphics Center
