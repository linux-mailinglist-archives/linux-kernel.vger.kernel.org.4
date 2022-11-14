Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1F627A12
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiKNKJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiKNKIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:08:21 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973B31F616;
        Mon, 14 Nov 2022 02:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668420482; x=1699956482;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yOVQIHkuUCyb9yuVJwgc7s85bbeRz6iUd3ajHxZ7HeA=;
  b=hvYCy6RUS2mAVENf+xJqPHk9zxmTRdJdCGWfeZT4p/b8Fzu02n4hdHW2
   L7AnOh/0uLlf/YDA7xvBa1+VNljIb1EMKFCSkFoTQPOeXLAEtkMepqwPM
   fAaZS/4DxD8PIgk8quiRIhsmtNLEqMranvgYJsZkF70cr+0N9VrYesQfa
   BQGAG223wTeE+1XVSvDmahwcSudTum/wXF4wnFbHBhifjllY/KOhuhHk2
   YrRqD5IEnioZWV6seBmtohkAHx8s5h1zIGUGdengiiechqgbGCGwKI5t9
   mS9RWxfj+E3gHwYPlg73Miui2+jZkXWux/QNAPEIPwgJdcudugSNMfanm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="376198076"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="376198076"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 02:08:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="727466802"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="727466802"
Received: from dsmahang-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.240])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 02:07:57 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Karol Herbst <kherbst@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        "Nathan E. Egge" <unlord@xiph.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: nouveau_dp_irq(): Null pointer dereferences
In-Reply-To: <CACO55tvaXFyAMiAYmx2DKNj9fNtapThejHkRsvZd_5StYXTy+w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <202211100850.7A8DD75@keescook> <87iljl6ehe.fsf@intel.com>
 <202211111110.11B554B@keescook>
 <CACO55tt5KOgDYMEw=spDeoMaYuj2GQOuHU+BEgadr1nQiFOGhw@mail.gmail.com>
 <202211111215.1F421B7E@keescook>
 <CACO55tvaXFyAMiAYmx2DKNj9fNtapThejHkRsvZd_5StYXTy+w@mail.gmail.com>
Date:   Mon, 14 Nov 2022 12:07:55 +0200
Message-ID: <87fsel4zno.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022, Karol Herbst <kherbst@redhat.com> wrote:
> On Fri, Nov 11, 2022 at 9:16 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Fri, Nov 11, 2022 at 09:06:54PM +0100, Karol Herbst wrote:
>> > On Fri, Nov 11, 2022 at 8:21 PM Kees Cook <keescook@chromium.org> wrote:
>> > >
>> > > On Fri, Nov 11, 2022 at 11:13:17AM +0200, Jani Nikula wrote:
>> > > > On Thu, 10 Nov 2022, coverity-bot <keescook@chromium.org> wrote:
>> > > > > Hello!
>> > > > >
>> > > > > This is an experimental semi-automated report about issues detected by
>> > > > > Coverity from a scan of next-20221110 as part of the linux-next scan project:
>> > > > > https://scan.coverity.com/projects/linux-next-weekly-scan
>> > > > >
>> > > > > You're getting this email because you were associated with the identified
>> > > > > lines of code (noted below) that were touched by commits:
>> > > > >
>> > > > >   Mon Aug 31 19:10:08 2020 -0400
>> > > > >     a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")
>> > > >
>> > > > Hi Kees, this looks like a good idea, but maybe double check the Cc list
>> > > > generation? I was Cc'd on four mails today that I thought were
>> > > > irrelevant to me.
>> > >
>> > > Hi!
>> > >
>> > > Heh, I was recently asked to _expand_ the CC list. :)
>> > >
>> > > For these last pass of reports, I added a get_maintainers.pl run to the
>> > > identified commit. In this instance, the commit touched:
>> > >
>> > >  drivers/gpu/drm/nouveau/dispnv04/disp.c     |    6 +
>> > >  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  192 ++++++++++++++++++++++--------------------------
>> > >  drivers/gpu/drm/nouveau/nouveau_connector.c |   14 ---
>> > >  drivers/gpu/drm/nouveau/nouveau_display.c   |    2
>> > >  drivers/gpu/drm/nouveau/nouveau_display.h   |    2
>> > >  drivers/gpu/drm/nouveau/nouveau_dp.c        |  132 ++++++++++++++++++++++++++++-----
>> > >  drivers/gpu/drm/nouveau/nouveau_encoder.h   |   33 +++++++-
>> > >  7 files changed, 244 insertions(+), 137 deletions(-)
>> > >
>> > > And the get_maintainers.pl rationale was:
>> > >
>> > > Ben Skeggs <bskeggs@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:1/1=100%,commit_signer:6/16=38%,authored:4/16=25%,added_lines:23/124=19%,removed_lines:36/152=24%)
>> > > Karol Herbst <kherbst@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:2/1=100%)
>> > > Lyude Paul <lyude@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:9/16=56%,authored:6/16=38%,added_lines:92/124=74%,removed_lines:107/152=70%)
>> > > David Airlie <airlied@gmail.com> (maintainer:DRM DRIVERS)
>> > > Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
>> > > Ilia Mirkin <imirkin@alum.mit.edu> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
>> > > "Nathan E. Egge" <unlord@xiph.org> (commit_signer:1/1=100%)
>> > > Jani Nikula <jani.nikula@intel.com> (commit_signer:6/16=38%)
>> > > Dave Airlie <airlied@redhat.com> (commit_signer:5/16=31%)
>> > > Thomas Zimmermann <tzimmermann@suse.de> (commit_signer:4/16=25%,authored:4/16=25%)
>> > > dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)
>> > > nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)
>> > >
>> >
>> > I'd say it's good enough to message supporters and the mailing lists
>> > for at least Nouveau code, maybe even all drm drivers.
>>
>> i.e. leave out the commit_signer hits?
>>
>
> yes.

Agreed.

I understand the point of commit_signer, but I don't think
get_maintainers.pl does a very good job with the heuristics, or
filtering out "insignificant" contributions to the files being changed.

BR,
Jani.

>
>> > Not sure what to do about actual maintainers, but I doubt Dave and
>> > Daniel want to be CCed on every Coverity report here either.
>>
>> I updated the CC logic based on this feedback:
>> https://lore.kernel.org/linux-hardening/87h6zgfub4.fsf@kernel.org/
>>
>> So maybe just mailing lists?
>>
>
> That should be good enough, but maybe the DRM subsystem is big enough
> so it's reasonable to add special rules. For Nouveau either way is
> fine.
>
>> --
>> Kees Cook
>>
>

-- 
Jani Nikula, Intel Open Source Graphics Center
