Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1B62CB65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiKPUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKPUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:49:48 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B176450AE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:49:47 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id d185so19286376vsd.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NOjf12PHoM1OYZLKsMEeUOGFT677LGF3WYDBKawYbZ0=;
        b=AcfdSmjpvVUWIRp6C+vqD+EYVifdXhB5F3CIKTwuC8GUd4Grdb7nyFeDNZhDYDvZ42
         yr0CWdNqFqP+QRvs9WE8NllTVkSOgj6AAKvwokioRnhjcLfjhAWbkqWW1pkjuaOOrbWA
         j+eDzYaoaTZxyCVuLrLayl3VM3+l4gDDb7YUJ76GvaLQmn6OX8bTXlyWpw1495hwdNFS
         y99687FP7SR2zhVrYVCVfnpVkTdRtxhggPoJEya6MDK1q5vqgzlCXp2CV4P/hBDFqDQL
         vHgsRKsJdePRr7pARL6XtjAANyOwLwVhfREhFDMK1D8ShDX6DE9GoHqxTfRuH7Q3t+Hk
         OqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOjf12PHoM1OYZLKsMEeUOGFT677LGF3WYDBKawYbZ0=;
        b=IfI5gaeoGgXRwqv637ZMKGZTFSrXK4kYgY9m/pXWQglw3+HJIlcWNjNk+iPibBgQhI
         /RB95i6h2Gd5n03KAxy/pfjZU/UAzK54lU2aEu9n5X12EInJgezRyW4NS8BEo1cPS0c+
         OfXrZOhLCZlL8T3ElJQ8ypgELEfdQ2EQ1xueks1VEP7LuawLkX7ndIZDOB8zh7L/woeY
         HfkjXrH+zcZVak8SIDVDBbuXETk5UDClv4fYN5WZ2rsMk7EN3ZlQ061CSfCaB23k+rP1
         xP+QL+PCLQXJs1sXQf80Nib8HMvKcUVIM3geUBvXSx3+SSDBLwRPTO6yfS710HpIzspg
         wHDg==
X-Gm-Message-State: ANoB5plJe2j+xaHMk2iPOsoT3wMkWEqjNn7IYWY5jk7+SQGI5qGy1PKI
        /HYdyTVpd9bNqOek8Jg6tEeRkc17uUYc/f9yLFPT
X-Google-Smtp-Source: AA0mqf7z5e/3zQEDd96hj2DgE6XQy/LsQ7cKArOs/nw6BWo111zmV877c3c+x/vyL0j/S2SfVOWHHb7Vvt2k+nuUmjw=
X-Received: by 2002:a05:6102:c0d:b0:3af:2b1c:9908 with SMTP id
 x13-20020a0561020c0d00b003af2b1c9908mr45953vss.18.1668631786600; Wed, 16 Nov
 2022 12:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20221114104333.3695531-1-javierm@redhat.com> <CANDhNCrSO_kByOCEHUyrdnbmaypt+u2Fw86iASDAjwbTNU3j3Q@mail.gmail.com>
 <b3f51e18-0a38-10f6-8072-bc2c5c2c6102@redhat.com>
In-Reply-To: <b3f51e18-0a38-10f6-8072-bc2c5c2c6102@redhat.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 16 Nov 2022 12:49:34 -0800
Message-ID: <CANDhNCrTk09RF=4OwS_yj=DeDRcz34xRmbUj_-+isJtnvWZTwg@mail.gmail.com>
Subject: Re: [PATCH] driver core: Disable driver deferred probe timeout by default
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh@kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Nov 15, 2022 at 2:53 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 11/15/22 10:33, John Stultz wrote:
> > So I don't think it's true that before the change the driver core
> > would defer the probe forever when there was no timeout.
> >
>
> I see. I thought that the driver_deferred_probe_check_state_continue()
> function would check for the return value and return -EPROBE_DEFER if
> if __driver_deferred_probe_check_state() returned 0.

Yes, but that was only used by the pinctrl driver, I think mostly as a
result of the confusing semantics of the
driver_deferred_probe_check_state() behavior.
After the semantics were improved (at least in my view - again
apologies for any trouble I've caused you looking over all this :) it
was switched it back.
But yes, in that case, it would absorb the results and return
-EPROBE_DEFER indefinitely if modules were enabled.

> But probably there was code calling driver_deferred_probe_check_state()
> and not returning -EPROBE_DEFER after initcalls_done.

I'm not sure I recall any other than the pinctrl case.


> In any case, what I tried to say is that originally the semantics of the
> deferred_probe_timeout= parameter was that it was disabled by default
> and that it had to be explicitly set. But at some point that default was
> switched and it became enabled by default unless is explicitly disabled.

True, I tried to set it to 30, then to zero and Saravana has set it to 10.
But I believe that the timeout of zero was functionally identical to
that of -1 behavior before my patches.
The only difference is before w/ -1 you'd get -ENODEV at
late_initcall, whereas with my changes (after ce68929f07de) and the
default value set to 0, you get -ETIMEDOUT after late_initcall.

To my understanding, in neither case did you ever get -EPROBE_DEFER
after late_initcall.


> > The problem we had at the time was that there were dts optional links
> > (like iommus that may be in the dts but may not have a kernel driver),
> > so if there is no module to load, we don't want to defer probing
> > forever. The cutoff point was originally set to late_initcall time
> > with a timeout option to extend it further.  However, with Android,
> > modules often wouldn't get a chance to load until much after
> > late_initcall time.
> >
>
> But do we need to tie the probe deferral to the optional links? Now both
> driver_deferred_probe_timeout = 0 and fw_devlink_drivers_done() are done
> in the deferred_probe_timeout_work_func() worker function handler.
>
> Could we untangle the two? That is, have a timeout to relax the links but
> still keep the probe deferral mechanism so that drivers with required
> dependencies have an opportunity to re-probe if deferred once the modules
> are loaded by user-land later in the boot?
>

Potentially? I'd defer to Saravana, as the fwdevlink effort was in a
large part resolving the dependency links in a sane way, which allowed
for not having to set the deferred_probe_timeout boot option in order
to get modules to load on devices.

> > But setting the timeout didn't actually help to extend the probe time,
> > because it would return -ENODEV after late_initcall. -  That's what my
> > patch was trying to address.
> >
>
> Yes. I don't think that having a 0 by default makes sense. As mentioned
> in my commit message, if a system wants a 0 (no probe deferral after the
> initcalls are done) then should either disable modules (since basically
> makes module loading a no-op) or set deferred_probe_timeout=0 in cmdline.
>
> What I'm arguing is that a default of -1 (don't timeout probe deferral)
> is what should be the default.

I don't think that's really an option. I'm not a fan of the deferred
probe timeout, but it resolved the optional links and at least my
efforts to change to a longer timeout value weren't able to work
without causing regressions to someone. And until the fwdevlink stuff
landed, some devices I dealt with just required booting with the
deferred_probe_timeout=30 boot option set.
I'm pretty sure that defaulting to indefinite probe deferral will
cause regressions.


> > I also tried to move the default to 30 so we'd not need to set a boot
> > parameter to get modules to load on a normal boot, but that caused
> > some trouble w/ with NFS root systems and the fix there would mean
> > that they'd have to wait 30 seconds before the rootfs would mount.
> >
>
> Right. I saw that in the git log history too. But I believe that's a corner
> case that in any case should be handled separately. For example, the probe
> deferral worker could be canceled if wait_for_init_devices_probe() is called?
>
> Something like the following (pseudo-code):
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d02501933467..d2cc04fef1f5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1737,6 +1737,12 @@ void __init wait_for_init_devices_probe(void)
>         if (!fw_devlink_flags || fw_devlink_is_permissive())
>                 return;
>
> +       /*
> +        * Cancel deferred probe to allow drivers with optional suppliers to
> +        * be probed, even if those optional dependencies are still missing.
> +        */
> +       deferred_probe_cancel_timeout();
> +


Potentially? I'd defer to Saravana as I've not kept up with recent
changes. Though it seems sort of similar to the initcalls_done
semantics?

One of the foggy ideas I had was that it seemed like instead of a boot
timer, we sort of really wanted a per-driver-probe timer, so that
after init, if a module load happens, there's a new timer that gives a
30 seconds or so window for any dependent drivers to be loaded before
continuing on. But I hadn't time to fully think it out.


> > Hrm.  So -1 sort of changed meaning after my initial
> > change(c8c43cee29f6), because after that it did indeed change to being
> > indefinite EPROBE_DEFER.
>
> Yes, but that was also the case for the original commit from Rob (25b4e70dcce9)
> since driver_deferred_probe_check_state() was just:
>
> int driver_deferred_probe_check_state(struct device *dev)
> {
>        if (initcalls_done) {
>                if (!deferred_probe_timeout) {
>                        dev_WARN(dev, "deferred probe timeout, ignoring dependency");
>                        return -ETIMEDOUT;
>                }
>                dev_warn(dev, "ignoring dependency for device, assuming no driver");
>                return -ENODEV;
>        }
>        return -EPROBE_DEFER;
> }
>
> So -1 being indefinite -EPROBE_DEFER was the original semantic and the default.

I think you're misreading this? In the code above, as soon as
initcalls_done is set (at late_initcall), it returns -ENODEV.
So even with deferred_probe_timeout = -1, after late_initcall, it will
return -ENODEV and probing will stop.

I sadly can't respond to all your points, but hopefully the above
helps clarify some details.  I do agree the deferred_probe_timeout and
optional links logic is unfortunate, and by providing a working
solution for optional links, it creates hardships for late module
loading on other systems. But once it landed, fixing the latter would
break for the former, (and sometimes fixing the latter would break
other use cases) and we were sort of stuck with having to require
devices that do later module loading to specify the timeout boot
option.  I think Saravana's immense fwdevlink efforts have improved
things greatly, but I'm glad others are looking for better solutions
as well, so I look forward to your proposals (hopefully I can read
over your patches from last night soon).

thanks
-john
