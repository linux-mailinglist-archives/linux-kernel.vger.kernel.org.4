Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AFC6679B2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbjALPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbjALPmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:42:33 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348CD671B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:32:40 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso19538554pjl.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvNRo5TsbXJJ428tB14x7kU1AlvgmP7fU9qmiXnk6oM=;
        b=QDfSO1Am4vtsGOXiksfoxK4Viyu+BM5hWjfmy9GRQMHJ/moq8SRgAegjQ5J1FyrcBL
         wvWdJASZ9lw4VrpoxZMt+ciiSm0+o66EesUfyDYAE5E+w/ETxfQv9LywVHA136bEefqn
         UbjZJLHum5E7V7YubrCr5XvkG2MfY1X/lHhF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvNRo5TsbXJJ428tB14x7kU1AlvgmP7fU9qmiXnk6oM=;
        b=anVybotnh+2hbAyWBj9OOi7qtggtFYfz3r7K9QhpTm8sCNZim8spB3TDuOeNX+52Nd
         43rol0sEM03V6weAXHeOa/roEzgDmLeEodfJnNrZhfgOcpnoPpe5dGQY1V91CMtHipNi
         kGqKVah4dmHggga0ftZwfuQtU9Z/Ta8Lr3nWSEUcf9EdxRn0GVAAbKnLqogqrcp+QmGF
         bOabmsfVh9w6/RWyRKiSIQW8a7Jdor6uBjqp7IV3hJANn/7Q3GWcPC2SQP5OXWEmkdCv
         Bj5PSJf4k6NuJ7oAkTIei9e9iNdH6myiwmT/8nLuK8KxkOCOYu1hyjmcQUJ/so/Q2umj
         EkgQ==
X-Gm-Message-State: AFqh2krKoZ7cTJkkAhsCTMONM64N4BDcjLtMp7OfztlV9QC8PHVd3n6/
        NJDlP7+ejM1TEMpDLjfbfwnKf80bqqTDKn63lFN1UA==
X-Google-Smtp-Source: AMrXdXv2MoppONOGqdkEyjBeLdrqw13w0NYOWT7wBhK8e7avYxRNdmcM3IIRBOYC1g+YVx+mjNlKZtZYHggZh7NKnBY=
X-Received: by 2002:a17:902:b902:b0:190:e27b:b554 with SMTP id
 bf2-20020a170902b90200b00190e27bb554mr5183912plb.148.1673537560308; Thu, 12
 Jan 2023 07:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
 <20230111154112.90575-2-daniel.vetter@ffwll.ch> <bad82927-1c58-4c2a-c265-571e10d1f67d@suse.de>
 <Y7/Z5dvADG6AspV3@phenom.ffwll.local> <8a154783-b433-c9b8-bfe5-286dde1258e9@suse.de>
 <Y7/kw+JdGCHJdptI@phenom.ffwll.local> <c4f8ffde-2226-cc1f-a5a8-d7462b92cb24@suse.de>
In-Reply-To: <c4f8ffde-2226-cc1f-a5a8-d7462b92cb24@suse.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 12 Jan 2023 16:32:28 +0100
Message-ID: <CAKMK7uGFHMiAKHMHioUa-Gvc9LhWnCeapzpiWoymiRyBEQG1Xg@mail.gmail.com>
Subject: Re: [PATCH 02/11] drm/gma500: Use drm_aperture_remove_conflicting_pci_framebuffers
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 at 13:15, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:
>
> Hi
>
> Am 12.01.23 um 11:45 schrieb Daniel Vetter:
> > On Thu, Jan 12, 2023 at 11:24:13AM +0100, Thomas Zimmermann wrote:
> >> Hi
> >>
> >> Am 12.01.23 um 10:59 schrieb Daniel Vetter:
> >>> On Thu, Jan 12, 2023 at 10:04:48AM +0100, Thomas Zimmermann wrote:
> >>>> Hi
> >>>>
> >>>> Am 11.01.23 um 16:41 schrieb Daniel Vetter:
> >>>>> This one nukes all framebuffers, which is a bit much. In reality
> >>>>> gma500 is igpu and never shipped with anything discrete, so there s=
hould
> >>>>> not be any difference.
> >>>>>
> >>>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> >>>>> ---
> >>>>>     drivers/gpu/drm/gma500/psb_drv.c | 2 +-
> >>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma=
500/psb_drv.c
> >>>>> index cd9c73f5a64a..9b0daf90dc50 100644
> >>>>> --- a/drivers/gpu/drm/gma500/psb_drv.c
> >>>>> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> >>>>> @@ -429,7 +429,7 @@ static int psb_pci_probe(struct pci_dev *pdev, =
const struct pci_device_id *ent)
> >>>>>            * TODO: Refactor psb_driver_load() to map vdc_reg earlie=
r. Then we
> >>>>>            *       might be able to read the framebuffer range from=
 the device.
> >>>>>            */
> >>>>> - ret =3D drm_aperture_remove_framebuffers(true, &driver);
> >>>>> + ret =3D drm_aperture_remove_conflicting_pci_framebuffers(pdev, &d=
river);
> >>>>
> >>>> This does not work. The comment just above the changed line explains=
 why.
> >>>> The device uses shared memory similar to other integrated Intel chip=
s. The
> >>>> console is somewhere in a 16 MiB range, which has been stolen by the=
 BIOS
> >>>> from main memory. There's only a 1 MiB memory range on the device to=
 program
> >>>> the device. Unless you want to refactor as described, this call has =
to cover
> >>>> the whole memory for now.
> >>>
> >>> Uh. So it's maybe not so pretty, but what if I just call both functio=
ns?
> >>
> >> That's ways more ugly IMHO.
> >>
> >>> That way we get the vga handling through the pci one, and the "make s=
ure
> >>> there's no fb left" through the other one. Plus comment of course.
> >>>
> >>> Otherwise we'd need to somehow keep the vga stuff in the non-pci path=
s,
> >>> and that just feels all kinds of wrong to me.
> >>
> >> With your patch applied, aperture_detach_devices() does all the work o=
f
> >> removing. I'd add the following internal functions:
> >>
> >> static void aperture_detach_head(bool is_primary)
> >> {
> >>      /*
> >>       * lengthy comment here
> >>       */
> >>      if (is_primary)
> >>              sysfb_disable()
> >> }
> >>
> >> static void aperture_detach_tail(bool remove_vga)
> >> {
> >>      if (remove_vga) {
> >>              aperture_detach_devices(VGA_PHYS_)
> >>              vga_remove_vgacon()
> >>      }
> >> }
> >>
> >> And call both of them at the beginning/end of
> >> aperture_remove_conflicting_devices() and
> >> aperture_remove_conflicting_pci_devices().
> >>
> >> You'd still need to primary argument to
> >> aperture_remove_conflicting_devices(), but there will be no code dupli=
cation
> >> with the aperture helpers and the purpose of each code fragment will b=
e
> >> clearer.
> >
> > Yeah I don't want the primary argument. Aside from this one case here i=
t's
> > not needed. Also by pushing this special case into the one driver that
> > needs it we keep it contained, instead of spreading it all around.
> > Inflicting a parameter on every (and in total we have a lot of callers =
of
> > this stuff) just because of gma500 does not seem like a good idea to me=
.
>
> Unfortunately, vgacon and vgaarb require a PCI device. I don't like the
> proposal, but maybe it's the best for now. So go ahead if you like. I do
> expect that this needs additional work in future, however.
>
> Just some more thoughts.
>
> Grep for drm_aperture_remove_framebuffers(). Within DRM there are really
> just 10 drivers calling this function (vs. 12 callers of
> drm_aperture_remove_conflicting_pci_framebuffers()). In fbdev, there are
> many callers of the PCI helper (~40) and apparently only 3 for the
> non-PCI one. The other drivers are panels, USB, MIPI, etc and don't
> interact with the system framebuffer. Compared to the overall number of
> drivers, we have surprisingly few 'traditional graphics cards' in DRM.

This is largely historical. fbdev is from the 90s, when we had the
huge explosion in largely pci graphics cards, because that was the
place where all the growth and hence drivers were. 80% of these
companies/chipe all died within a short few years.

kms otoh had the huge growth in the 2010s, where there was the tail
end of the SoC mobile explosion, so that's where we have tons of
drivers. If you look at staging there's a pile more fbdev drivers for
SoC, but many of these never got beyond the "vendor hacked some stuff
together and shipped it" stage. So that's probably why they lack
polish like fw -> driver handover (most of these just booted directly
to the driver in real products).

> Another thing is that gma500 and the other 9 drivers simply don't bother
> to get the framebuffer range. They should be reworked to fetch the
> configured framebuffer from the device and release that region only. The
> practical impact is close to zero, so it hasn't happened.

I think that's ok, because trying to figure out the real fb means you
need fairly complete hw state readout (otherwise there's no
motivation), and i915 is the only driver that ever really did that.
Just for fw driver removal "nuke everything" gets the job done.
-Daniel

> Best regards
> Thomas
>
>
> > -Daniel
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
