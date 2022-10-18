Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6912D60295B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJRKcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJRKck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:32:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51378FD5B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666089159; x=1697625159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B9QBkZdiEKRXds6f01qLYgOxmjJ0WM3LSkhM7gknqPs=;
  b=fZHaD1MuiHRNlzrBESw2oBdnI2MlBOevx0SyXDJ6di0zbtc0LIGFSH+x
   W2BKNAsZgoYIWfc06B6k1ywEEDFpQstm983nMfiiDH4HL9gXlAGorXjY8
   PphbcAl1ZpT1PoSMha+7J5qkOf6NCjD+/LoJZsQQQ1fio4oOTCpo0emIk
   hiOR7T/Izdw8IEEv2UlOjag7wCAP+AYc3UyIkRaEyozpRhyno6vebtLPA
   Kxq+ZwU+npqiXfCeH7W/s6X5M7OWjdrCYvNywNfePYlGugVWmzGOjrDzd
   r6py0QcWY4iS2SvY4ZZbkGHPEQTNzJqgcogzIc9jAmVVqgWa9L82qxVvd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="332606597"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="332606597"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 03:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="803693165"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="803693165"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga005.jf.intel.com with SMTP; 18 Oct 2022 03:32:36 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 18 Oct 2022 13:32:35 +0300
Date:   Tue, 18 Oct 2022 13:32:35 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] alderlake crashes (random memory corruption?) with
 6.0 i915 / ucode related
Message-ID: <Y06Awzhqr8FutEgK@intel.com>
References: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
 <87a65usvgq.fsf@intel.com>
 <877d0ysv1e.fsf@intel.com>
 <717fb4ab-5225-884f-37f9-2032c265824e@redhat.com>
 <241af90a-4cec-9266-8fb0-3c69f9880b52@leemhuis.info>
 <fac9a564-edff-db25-20d4-7146ae2a7dc8@redhat.com>
 <87tu42indv.fsf@intel.com>
 <490bed5d-8db4-dc31-7aed-bc5941c974c5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <490bed5d-8db4-dc31-7aed-bc5941c974c5@redhat.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:32:28PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/17/22 15:35, Jani Nikula wrote:
> > On Mon, 17 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
> >> Hi,
> >>
> >> On 10/17/22 13:19, Thorsten Leemhuis wrote:
> >>> CCing the regression mailing list, as it should be in the loop for all
> >>> regressions, as explained here:
> >>> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> >>
> >> Yes sorry about that I meant to Cc the regressions list, not you personally,
> >> but the auto-completion picked the wrong address-book entry
> >> (and I did not notice this).
> >>
> >>> On 17.10.22 12:48, Hans de Goede wrote:
> >>>> On 10/17/22 10:39, Jani Nikula wrote:
> >>>>> On Mon, 17 Oct 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >>>>>> On Thu, 13 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>>>> With 6.0 the following WARN triggers:
> >>>>>>> drivers/gpu/drm/i915/display/intel_bios.c:477:
> >>>>>>>
> >>>>>>>         drm_WARN(&i915->drm, min_size == 0,
> >>>>>>>                  "Block %d min_size is zero\n", section_id);
> >>>>>>
> >>>>>> What's the value of section_id that gets printed?
> >>>>>
> >>>>> I'm guessing this is [1] fixed by commit d3a7051841f0 ("drm/i915/bios:
> >>>>> Use hardcoded fp_timing size for generating LFP data pointers") in
> >>>>> v6.1-rc1.
> >>>>>
> >>>>> I don't think this is the root cause for your issues, but I wonder if
> >>>>> you could try v6.1-rc1 or drm-tip and see if we've fixed the other stuff
> >>>>> already too?
> >>>>
> >>>> 6.1-rc1 indeed does not trigger the drm_WARN and for now (couple of
> >>>> reboots, running for 5 minutes now) it seems stable. 6.0.0 usually
> >>>> crashed during boot (but not always).
> >>>>
> >>>> Do you think it would be worthwhile to try 6.0.0 with d3a7051841f0 ?
> >>
> >> So I have been trying 6.0.0 with d3a7051841f0 doing a whole bunch of
> >> reboots + general use and that seems stable, then I reverted it and
> >> the very first boot of the kernel with that broke again, so I'm
> >> pretty sure that d3a7051841f0 fixes things.
> >>
> >> So d3a7051841f0 seems to do more then just fix the WARN().
> > 
> > Wow, so I guess we do screw up the parsing royally then. :o
> 
> I'm running the kernel with lockdep + list-debugging enabled and
> I could not reproduce this (not easily at least) on a standard
> Fedora 6.0.0 build without that. So maybe the parsing just manages
> to write out of binds a tiny bit which just happens to hit a list_head
> somewhere ... ?

We don't parse any of the LFP data stuff if we didn't manage
to generate the data ptrs. So can't really see how that would
happen. Another theory might be that something else gets
screwed up if we fail to parse anything, but can't really
think how that would lead to list corruption either.

> 
> Either way things look stable with d3a7051841f0 and it turns out
> that Fedora already had that cherry-picked downstream in the
> 5.19.13 kernel which was stable for me too.
> 
> >> So lets try to get d3a7051841f0 added to the official stable series
> >> ASAP (I just noticed that Mark Pearson from Lenovo has already added it
> >> to Fedora's 6.0.2 build.
> > 
> > I think I'd also pick d3a7051841f0^ i.e. both commits:
> > 
> > d3a7051841f0 ("drm/i915/bios: Use hardcoded fp_timing size for generating LFP data pointers")
> > 4e78d6023c15 ("drm/i915/bios: Validate fp_timing terminator presence")
> > 
> > for stable.

Ack from me.

> 
> That sounds good, can you take care of submitting these to gkh ?
> 
> Regards,
> 
> Hans

-- 
Ville Syrjälä
Intel
