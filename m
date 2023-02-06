Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A468C84B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBFVKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBFVKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:10:36 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A182241FB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:10:32 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id v1so1185447ilg.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 13:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei4VFwLuleRaOtoRA5G2QYwC0Oa6+F6aM5uPuhmObpA=;
        b=PlIRFIUWOG3snK2ir5MVbWiqkHxoiQiL87CxnahwXyFLOxkF4QxihR74Xuqis0pyOS
         7/yvGUhMgVSQ2sn6rGAuEblMfRjs4tXiZ6eE0XdjyQNQ9m8QEtNV5bxRkv5ydo2btGv2
         vpfmlKw4l3+o4Et8xGpmNryTdEhrP16dkDshs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ei4VFwLuleRaOtoRA5G2QYwC0Oa6+F6aM5uPuhmObpA=;
        b=JQ/V0LoyOBiOuUd5HiYML0vUs4nGgyGOcVlIY4mGComOs2N+fNSePIFOOzV0CJFCVY
         vvAVd4sGJ+RmwJF2GULh2CG6kCF0gY4AoZyQggn+y6LmyNqgA87+PSFm8Dn84bROa5Cj
         QkjwhRO8x6p1RUv0QzUP1qU2z5P9gF+qZbuCA2SXqkrxDcoNCZHw37cihvJhiEVV0WPO
         wouMhyvSKQAMNlucjuiLsGT40jiqKrm6JdnIRtFVVKH+LC5fVa5M0OO34A6jpcb5ymb+
         o4uoJJ/wRNk5CnsHjuTl6BCNvG31kmvC+EyhbAeM7afORRcvT4ARVJHUmGhx0v0ChdaQ
         qBbA==
X-Gm-Message-State: AO0yUKUl8+C3lyV6EuUIZr4HgPt1HQ+tb/KMmHp2uI1cT90cZ7M7ZciK
        dc8LHusZBtUiBXKU0HII1NYIAx3DJHhCr2dB
X-Google-Smtp-Source: AK7set8htGarudmQyhaEoOoYw5k3iiN8lkQFQaI0YA0EViVMZEkzYw/5F0skEBCtyfm0kKFyLZ8MwQ==
X-Received: by 2002:a92:700c:0:b0:310:ae72:32a0 with SMTP id l12-20020a92700c000000b00310ae7232a0mr429407ilc.21.1675717832001;
        Mon, 06 Feb 2023 13:10:32 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id l13-20020a02cd8d000000b0039d750a1823sm3837257jap.1.2023.02.06.13.10.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 13:10:31 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id l7so4947364ioa.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 13:10:31 -0800 (PST)
X-Received: by 2002:a05:6638:5af:b0:3b1:4f93:69b8 with SMTP id
 b15-20020a05663805af00b003b14f9369b8mr245586jar.117.1675717830923; Mon, 06
 Feb 2023 13:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20230127104054.895129-1-abel.vesa@linaro.org> <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org> <Y+E3T6bozU1K2sFb@google.com>
 <Y+E9Z+/+eCpPK6DE@linaro.org> <CAGETcx99ev_JdgYoifEdUg6rqNCs5LHc-CfwTc7j3Bd_zeizew@mail.gmail.com>
In-Reply-To: <CAGETcx99ev_JdgYoifEdUg6rqNCs5LHc-CfwTc7j3Bd_zeizew@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Feb 2023 13:10:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X3nnwuTK2=w7DJfjL_Ai7MiuvTwv8BiVJPMVEWKzR-_g@mail.gmail.com>
Message-ID: <CAD=FV=X3nnwuTK2=w7DJfjL_Ai7MiuvTwv8BiVJPMVEWKzR-_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
To:     Saravana Kannan <saravanak@google.com>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 6, 2023 at 11:33 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Feb 6, 2023 at 9:48 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> >
> > CC'ed Saravana
>
> Thanks. Please do cc me for stuff like this from the start. I skimmed
> the series and I think it's doing one of my TODO items. So, thanks for
> the patch!
>
> I'll take a closer look within a few days -- trying to get through
> some existing fw_devlink stuff.
>
> But long story short, it is the right thing to keep a supplier on
> indefinitely if there's a consumer device (that's not disabled in DT)
> that never gets probed. It's a pretty common scenario -- for example,
> say a display backlight. The default case should be functional
> correctness. And then we can add stuff that allows changing this
> behavior with command line args or something else that can be done
> from userspace.
>
> +1 to what Doug said elsewhere in this thread too. I'm trying to
> consolidate the "when do we give up" decision at the driver core level
> independent of what framework is being used.

I'm not really sure I agree with the above, at least not without lots
of discussion in the community. It really goes against what the kernel
has been doing for years and years in the regulator and clock
frameworks. Those frameworks both eventually give up and power down
resources that no active drivers are using. Either changing the
regulator/clock frameworks or saying that other frameworks should work
in an opposite way seems like a recipe for confusion.

Now, certainly I won't say that the way that the regulator and clock
frameworks function is perfect nor will I say that they don't cause
any problems. However, going the opposite way where resources are kept
at full power indefinitely will _also_ cause problems.

Specifically, let's look at the case you mentioned of a display
backlight. I think you're saying that if there is no backlight driver
enabled in the kernel that you'd expect the backlight to just be on at
full brightness. Would you expect this even if the firmware didn't
leave the backlight on? In any case, why do you say it's more correct?
I suppose you'd say that the screen is at least usable like this.
...except that you've broken a different feature: suspend/resume.
Without being able to turn the backlight off at suspend time the
device would drain tons of power. It could also overheat when you
stuffed it in your backpack and damage the battery or start a fire.
Even if you argue that in the case of the display backlight you're
better off, what about a keyboard backlight? It's pretty easy to use a
laptop without the keyboard backlight and if you didn't have a driver
for it you'd be in better shape leaving it off instead of leaving it
on 100% of the time, even when the device is suspended.

Overall: if a kernel isn't configured for a given driver we shouldn't
be expecting the hardware controlled by that driver to work. The best
we can hope for is that it's at least in a low power state.

In general I think that having a well-defined way to know it's time to
give up and power off anything for which a driver didn't probe needs
to be an important part of any designs here.


> -Saravana
>
> >
> > On 23-02-06 17:22:23, Matthias Kaehlcke wrote:
> > > On Mon, Feb 06, 2023 at 06:31:21PM +0200, Abel Vesa wrote:
> > > > On 23-02-02 18:24:15, Matthias Kaehlcke wrote:
> > > > > Hi Abel,
> > > > >
> > > > > On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
> > > > > > Currently, there are cases when a domain needs to remain enabled until
> > > > > > the consumer driver probes. Sometimes such consumer drivers may be built
> > > > > > as modules. Since the genpd_power_off_unused is called too early for
> > > > > > such consumer driver modules to get a chance to probe, the domain, since
> > > > > > it is unused, will get disabled. On the other hand, the best time for
> > > > > > an unused domain to be disabled is on the provider's sync_state
> > > > > > callback. So, if the provider has registered a sync_state callback,
> > > > > > assume the unused domains for that provider will be disabled on its
> > > > > > sync_state callback. Also provide a generic sync_state callback which
> > > > > > disables all the domains unused for the provider that registers it.
> > > > > >
> > > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > This approach has been applied for unused clocks as well.
> > > > > > With this patch merged in, all the providers that have sync_state
> > > > > > callback registered will leave the domains enabled unless the provider's
> > > > > > sync_state callback explicitly disables them. So those providers will
> > > > > > need to add the disabling part to their sync_state callback. On the
> > > > > > other hand, the platforms that have cases where domains need to remain
> > > > > > enabled (even if unused) until the consumer driver probes, will be able,
> > > > > > with this patch in, to run without the pd_ignore_unused kernel argument,
> > > > > > which seems to be the case for most Qualcomm platforms, at this moment.
> > > > >
> > > > > I recently encountered a related issue on a Qualcomm platform with a
> > > > > v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
> > > > > highest corner until sync_state"). The issue involves a DT node with a
> > > > > rpmhpd, the DT node is enabled, however the corresponding device driver
> > > > > is not enabled in the kernel. In such a scenario the sync_state callback
> > > > > is never called, because the genpd consumer never probes. As a result
> > > > > the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
> > > > > system suspend, which results in a substantially higher power consumption
> > > > > in S3.
> > > >
> > > > If I get this correctly, one of the providers is missing (doesn't matter
> > > > the reason), in which case, your kernel needs that driver, period. There
> > > > is no reason why you would expect the consumer to work without the
> > > > provider. Or, you could just remove the property in the devicetree node,
> > > > the property that makes the consumer wait for that provider. Anyway, you
> > > > should never end up with a consumer provider relationship in devicetree
> > > > without providing the provider driver.
> > >
> > > I would agree if it was actually a provider that's missing, however it's a
> > > 'missing' consumer that prevents the sync_state() call.
> >
> > Oh, my bad.
> >
> > Still, why would you keep the consumer node enabled in devicetree if you don't
> > intend to allow its driver to ever probe?
> >
> > >
> > > > > I wonder if genpd (and some other frameworks) needs something like
> > > > > regulator_init_complete(), which turns off unused regulators 30s after
> > > > > system boot. That's conceptually similar to the current
> > > > > genpd_power_off_unused(), but would provide time for modules being loaded.
> > > >
> > > > NACK, timeouts are just another hack in this case, specially when we
> > > > have a pretty reliable mechanism like sync_state.
> > >
> > > It does not work properly unless all consumers are probed successfully. It
> > > makes sense to wait some time for the consumers to probe, but not eternally,
> > > it's perfectly valid that a driver for a (potential) consumer is not enabled.
> >
> > Usually, if you have a consumer devicetree node that you consider it
> > should not probe, you should consider disabling that node in your board
> > dts, specially if you don't intend to provide its driver.
> >
> > Again, timeouts are bad all-around. What happens if rootfs doesn't get
> > mounted in time? Will 30 seconds be enough for every scenario? What
> > happens if I want to load the driver (module) for a consumer a day after boot?
> >
> > IMHO, I think even the regulator_init_complete should be switched to some sync
> > state approach.
