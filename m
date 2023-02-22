Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BD269FB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjBVStH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjBVStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:49:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92993F0;
        Wed, 22 Feb 2023 10:48:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A7C5B81369;
        Wed, 22 Feb 2023 18:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52CAC433D2;
        Wed, 22 Feb 2023 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677091706;
        bh=FYMqOiIIy9np/VxKzpqBftMcfXiqDX0xtjyKH6Crjno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eWnn8NSSar6P6nnLUzk+dShNoRsnFGlxB1QE/9RG6Iy04pn7I8yTGebLqHETotcqy
         RfK+R9CmRJq7OAbX28QCTltLx4BQB1HS50CdAYAhgxbcWgSnpK049CNVJAa4ZmTrTJ
         nLVUOD9Luo12zV2gLpq45/KfJk+h38m7mrkJJWqG1bXt6bsanUPG4EhwdANgcfoi93
         2Agl65idt6oeqP0+2qF6xnXgVYczt1g4MKk5FjlaAzwklTjHiXkhsMQls//L4Ix7Mg
         IHGTbLBDj9SV8ouzEeeIIqen8HNOFFrqZ8NE1o+POTowNEYH/GL2v4eHkF3b/MiC6q
         +sxQWbF9yYn9Q==
Date:   Wed, 22 Feb 2023 10:51:52 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>,
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
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Message-ID: <20230222185152.tkculzvabvmjc3n4@ripper>
References: <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org>
 <Y+E3T6bozU1K2sFb@google.com>
 <Y+E9Z+/+eCpPK6DE@linaro.org>
 <CAGETcx99ev_JdgYoifEdUg6rqNCs5LHc-CfwTc7j3Bd_zeizew@mail.gmail.com>
 <CAD=FV=X3nnwuTK2=w7DJfjL_Ai7MiuvTwv8BiVJPMVEWKzR-_g@mail.gmail.com>
 <CAGETcx-LJEZAXT1VazhRf7xtNpST0tfLNmgxH878gkOOP4TDAw@mail.gmail.com>
 <CAD=FV=WG1v4U5iQirG=-ECZFtXE=hwL=oY+6zjsu6TWCiBX=QA@mail.gmail.com>
 <20230220171550.43a3h56gznfc3gec@ripper>
 <Y/UOJtyIMEMzuPqN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/UOJtyIMEMzuPqN@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 06:32:06PM +0000, Matthias Kaehlcke wrote:
> On Mon, Feb 20, 2023 at 09:15:50AM -0800, Bjorn Andersson wrote:
> > On Tue, Feb 07, 2023 at 03:45:35PM -0800, Doug Anderson wrote:
> > > Hi,
> > > 
> > > On Mon, Feb 6, 2023 at 1:35 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Mon, Feb 6, 2023 at 1:10 PM Doug Anderson <dianders@chromium.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Mon, Feb 6, 2023 at 11:33 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 6, 2023 at 9:48 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> > > > > > >
> > > > > > >
> > > > > > > CC'ed Saravana
> > > > > >
> > > > > > Thanks. Please do cc me for stuff like this from the start. I skimmed
> > > > > > the series and I think it's doing one of my TODO items. So, thanks for
> > > > > > the patch!
> > > > > >
> > > > > > I'll take a closer look within a few days -- trying to get through
> > > > > > some existing fw_devlink stuff.
> > > > > >
> > > > > > But long story short, it is the right thing to keep a supplier on
> > > > > > indefinitely if there's a consumer device (that's not disabled in DT)
> > > > > > that never gets probed. It's a pretty common scenario -- for example,
> > > > > > say a display backlight. The default case should be functional
> > > > > > correctness. And then we can add stuff that allows changing this
> > > > > > behavior with command line args or something else that can be done
> > > > > > from userspace.
> > > > > >
> > > > > > +1 to what Doug said elsewhere in this thread too. I'm trying to
> > > > > > consolidate the "when do we give up" decision at the driver core level
> > > > > > independent of what framework is being used.
> > > > >
> > > > > I'm not really sure I agree with the above, at least not without lots
> > > > > of discussion in the community. It really goes against what the kernel
> > > > > has been doing for years and years in the regulator and clock
> > > > > frameworks. Those frameworks both eventually give up and power down
> > > > > resources that no active drivers are using. Either changing the
> > > > > regulator/clock frameworks or saying that other frameworks should work
> > > > > in an opposite way seems like a recipe for confusion.
> > > > >
> > > > > Now, certainly I won't say that the way that the regulator and clock
> > > > > frameworks function is perfect nor will I say that they don't cause
> > > > > any problems. However, going the opposite way where resources are kept
> > > > > at full power indefinitely will _also_ cause problems.
> > > > >
> > > > > Specifically, let's look at the case you mentioned of a display
> > > > > backlight. I think you're saying that if there is no backlight driver
> > > > > enabled in the kernel that you'd expect the backlight to just be on at
> > > > > full brightness.
> > > >
> > > > No, I'm not saying that.
> > > >
> > > > > Would you expect this even if the firmware didn't
> > > > > leave the backlight on?
> > > >
> > > > sync_state() never turns on anything that wasn't already on at boot.
> > > > So in your example, if the firmware didn't turn on the backlight, then
> > > > it'll remain off.
> > > 
> > > As per offline discussion, part of the problems are that today this
> > > _isn't_ true for a few Qualcomm things (like interconnect). The
> > > interconnect frameway specifically maxes things out for early boot.
> > > 
> > 
> > The problem being solved here is that the bootloader leaves some vote at
> > 1GB/s, as needed by hardware related to driver B.
> > 
> > Driver A is loaded first and votes for 1kb/s; what should the kernel do
> > now, without knowledge of the needs from the hardware associated with B,
> > or the ability to read back the bootloader's votes.
> > 
> > This was the behavior of the initial implementation, and the practical
> > implications was seen as the UART would typically come along really
> > early, cast a low vote on the various buses and it would take forever to
> > get to the probing of the drivers that actually gave us reasonable
> > votes.
> 
> I generally understand this problem and agree that it makes sense to bump
> the resources *initially*. Doug and I primarily question the 'wait forever'
> part of it.
> 

The question is when "initially" ends.

> > Also consider the case where driver A probes, votes for bandwidth, does
> > it's initialization and then votes for 0. Without making assumptions
> > about the needs of B (or a potential B even), we'd turn off critical
> > resources - possible preventing us from ever attempting to probe B.
> 
> For the most critical devices that are probed during early boot this
> would still work if the resources are initially bumped and then turned
> off after some timeout.
> 

The resources that needs to be kept on are those which we rely on for
the system to reach said driver 'B'.

The obvious ones are those allowing us to execute code (e.g. some form
of DDR vote) and things such as earlycon - until the console driver is
probed properly and can cast a interconnect vote.

But the typical example here is display, which depending on system
configuration might rely on the hardware being able to fetch data from
DDR until all the relevant display driver components is starting to take
care of the voting.

> Could you provide an example for some other type of device that is/would
> be probed later? Except for auto-probing buses like USB or PCI the device
> should probe regardless of the resources being enabled and then vote
> during probe for the required bandwidth, voltage, etc., which should put
> the resources into the required state. Am I missing something here?
> 

What do you mean with "later"?

We have one consistent definition of "later", and that's
late_initcall(). By that definition it's pretty much everything beyond
gcc, interconnect and UART is or may probe "later" (because starting
userspace without a valid /dev/console is suboptimal)..


Looking at something specific, if you where to try to boot sc7280 using
the upstream defconfig I don't think you have anyone ensuring that the
CPU is allowed to reach DDR at this point.

> > As such, the only safe solution is to assume that there might be a later
> > loaded/probed client that has a large vote and preemptively vote for
> > some higher bandwidth until then.
> 
> > > > > In any case, why do you say it's more correct?
> > > >
> > > > Because if you turn off the display, the device is unusable. In other
> > > > circumstances, it can crash a device because the firmware powered it
> > > > on left it in a "good enough" state, but we'd go turn it off and crash
> > > > the system.
> > > >
> > > > > I suppose you'd say that the screen is at least usable like this.
> > > > > ...except that you've broken a different feature: suspend/resume.
> > > >
> > > > If the display is off and the laptop is unusable, then we have bigger
> > > > problems than suspend/resume?
> > > 
> > > I suspect that here we'll have to agree to disagree. IMO it's a
> > > non-goal to expect hardware to work for which there is no driver. So
> > > making the backlight work without a backlight driver isn't really
> > > something we should strive for.
> > > 
> > 
> > Without trying to make you agree ;)
> > 
> > How can you differentiate between "the driver wasn't built" and "the
> > driver isn't yet available"?
> 
> Unfortunately you can't AFAIK.
> 
> > Consider the case where I boot my laptop, I have some set of builtin
> > drivers, some set of drivers in the ramdisk and some set of drivers in
> > the root filesystem.
> > 
> > In the event that something goes wrong mounting the rootfs, I will now
> > be in the ramdisk console. Given the current timer-based disabling of
> > regulators, I have ~25 seconds to solve my problem before the backlight
> > goes blank.
> > 
> > 
> > Obviously this isn't a typical scenario in a consumer device, but it
> > seems conceivable that your ramdisk would run fsck for some amount of
> > time before mounting the rootfs and picking up the last tier of drivers.
> 
> If the laptop is running a kernel that is tailored for this device I'd
> say the most practial solution would be to either build the backlight
> driver into the kernel or have it on the ramdisk as a module.
> 
> However the laptop might be running a distribution like Debian or Red Hat
> with (I assume) a single kernel+ramdisk for all systems of a given
> architecture (e.g. aarch64). In that case it might not be desirable to
> have all possible backlight drivers in the kernel image or ramdisk. For
> this kind of system 'wait forever' might be a suitable solution.
> 

For most users, most of the time, I don't think "wait forever" is very
good either; e.g. if a distro is lacking one .ko the user would see
significant worse battery performance...

But at the same time, when your distro asks for your crypto key for your
rootfs and the kernel decides that times up, that's pretty bad user
experience as well..

> I have the impression we might want both options, a timeout after which
> resources are turned off unless they have been voted for, and 'wait
> forever', with a Kconfig option to select the desired behavior.
> 
> For most tailored systems the timout is probably a more suitable solution.
> The maintainer of the kernel/system can decide to not enable certain
> drivers because they aren't needed and include essential drivers into
> the kernel image or ramdisk. The timeout ensures that the system doesn't
> burn extra power for reasons that aren't evident for the maintainer (who
> might not even be aware of the whole sync_state story).
> 
> On the other hand general purpose distributions might want to wait
> forever, since they have to support a wide range of hardware and enable
> most available drivers anyway.
> 
> If we end up with such an option I think the timeout should be the
> default. Why? There are hundreds of maintainers of tailored kernels
> who might run into hard to detect/debug power issues with 'wait
> forever'. On the other hand there is a limited number of general purpose
> distributions, with kernel teams that probably already know about
> 'sync_state'. They only have to enable 'wait forever' once and then
> carry it forward to future versions.

In your tailored system you test every hardware and driver combinations,
so the wait forever seems like a very easy thing to handle.

In a general purpose distribution, the distribution doesn't have a way
to test every single system. So it's quite likely that they won't enable
some optional set of drivers (e.g. camera, venus) and wait forever would
be the wrong thing to do. Except when the user needs that backlight, or
the framebuffer etc.

I don't know how to solve this, the global timeout is likely the best
way we have for now - at least it works, for all cases except when
someone needs to stay in their initramfs for more than 30 seconds...

Regards,
Bjorn
