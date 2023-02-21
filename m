Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8096569E776
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjBUScM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBUScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:32:10 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA64F2F783
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:32:08 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id f9so2958588iox.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DNzMVtpp2+kg1GJxk8GdpB3Nfi5vZFWQOL56NZqTi6o=;
        b=C1Y6eAodHC0d8wFI9BeJYYKzbUA2AOv17hZCsSYz3jr6SZTZqxpO7AQfcHuQqp7aco
         uPXhwJSB+OjD8YzH0nIJnQqOncOERoT8hmvvZVcVS09lqxJm7gSWsED6arQIlPt9xeKH
         dZ0vVvycP0SB7pZiCKO9ufRFhEA9kigXJIYKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNzMVtpp2+kg1GJxk8GdpB3Nfi5vZFWQOL56NZqTi6o=;
        b=rhIkYwSZktBdAD+AROvyN2SsC7xIZdPQc2jeKhDKk2Q58sMLlPd9Nw4lkjGBHQEV1/
         Y9jLsIOoh+G6v0x+6ZdN1DzfnPgfQ8gU1NqdW2/4LmQsY4LidZKwokChzl8ltH2B2w5N
         p8W53wzjv8D1V8C7t+IQmb20v9QJzxhnfNlhFlnj0ZvjArLVs68OgJXFrgWI7kyFeMSq
         TvFKIiyMf3kfaEIkYtPQTIYDl0B7Ryz/FzHbGKyDm7kXC5EGGkVOhGnpE/PwWUjRBkrS
         LR2UeKs8/NfVyVbhpwLFrnp6sACvGfONOpzYg31remraHuVCfgNSdnnCa0og9YHFf1Vn
         IyXA==
X-Gm-Message-State: AO0yUKWcQasq18I4kvaacPa0f6jY4tAm7QtnD0BPHFP6Nxz4xwDAxkuf
        1MoLHHHZGcuw6aW71A0QOx/Cyw==
X-Google-Smtp-Source: AK7set9UuiOrKDR4F3+4jTMS7f1T3UNYvXL0uzKMLahB8K+F6/r9LqMT+9JRkYbNf3BizQwp2Im4ZA==
X-Received: by 2002:a6b:5906:0:b0:72a:ef42:2fd7 with SMTP id n6-20020a6b5906000000b0072aef422fd7mr3397776iob.2.1677004328132;
        Tue, 21 Feb 2023 10:32:08 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id r24-20020a6b4418000000b0074555814e73sm318731ioa.32.2023.02.21.10.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 10:32:07 -0800 (PST)
Date:   Tue, 21 Feb 2023 18:32:06 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
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
Message-ID: <Y/UOJtyIMEMzuPqN@google.com>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org>
 <Y+E3T6bozU1K2sFb@google.com>
 <Y+E9Z+/+eCpPK6DE@linaro.org>
 <CAGETcx99ev_JdgYoifEdUg6rqNCs5LHc-CfwTc7j3Bd_zeizew@mail.gmail.com>
 <CAD=FV=X3nnwuTK2=w7DJfjL_Ai7MiuvTwv8BiVJPMVEWKzR-_g@mail.gmail.com>
 <CAGETcx-LJEZAXT1VazhRf7xtNpST0tfLNmgxH878gkOOP4TDAw@mail.gmail.com>
 <CAD=FV=WG1v4U5iQirG=-ECZFtXE=hwL=oY+6zjsu6TWCiBX=QA@mail.gmail.com>
 <20230220171550.43a3h56gznfc3gec@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230220171550.43a3h56gznfc3gec@ripper>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 09:15:50AM -0800, Bjorn Andersson wrote:
> On Tue, Feb 07, 2023 at 03:45:35PM -0800, Doug Anderson wrote:
> > Hi,
> > 
> > On Mon, Feb 6, 2023 at 1:35 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Mon, Feb 6, 2023 at 1:10 PM Doug Anderson <dianders@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Feb 6, 2023 at 11:33 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > On Mon, Feb 6, 2023 at 9:48 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> > > > > >
> > > > > >
> > > > > > CC'ed Saravana
> > > > >
> > > > > Thanks. Please do cc me for stuff like this from the start. I skimmed
> > > > > the series and I think it's doing one of my TODO items. So, thanks for
> > > > > the patch!
> > > > >
> > > > > I'll take a closer look within a few days -- trying to get through
> > > > > some existing fw_devlink stuff.
> > > > >
> > > > > But long story short, it is the right thing to keep a supplier on
> > > > > indefinitely if there's a consumer device (that's not disabled in DT)
> > > > > that never gets probed. It's a pretty common scenario -- for example,
> > > > > say a display backlight. The default case should be functional
> > > > > correctness. And then we can add stuff that allows changing this
> > > > > behavior with command line args or something else that can be done
> > > > > from userspace.
> > > > >
> > > > > +1 to what Doug said elsewhere in this thread too. I'm trying to
> > > > > consolidate the "when do we give up" decision at the driver core level
> > > > > independent of what framework is being used.
> > > >
> > > > I'm not really sure I agree with the above, at least not without lots
> > > > of discussion in the community. It really goes against what the kernel
> > > > has been doing for years and years in the regulator and clock
> > > > frameworks. Those frameworks both eventually give up and power down
> > > > resources that no active drivers are using. Either changing the
> > > > regulator/clock frameworks or saying that other frameworks should work
> > > > in an opposite way seems like a recipe for confusion.
> > > >
> > > > Now, certainly I won't say that the way that the regulator and clock
> > > > frameworks function is perfect nor will I say that they don't cause
> > > > any problems. However, going the opposite way where resources are kept
> > > > at full power indefinitely will _also_ cause problems.
> > > >
> > > > Specifically, let's look at the case you mentioned of a display
> > > > backlight. I think you're saying that if there is no backlight driver
> > > > enabled in the kernel that you'd expect the backlight to just be on at
> > > > full brightness.
> > >
> > > No, I'm not saying that.
> > >
> > > > Would you expect this even if the firmware didn't
> > > > leave the backlight on?
> > >
> > > sync_state() never turns on anything that wasn't already on at boot.
> > > So in your example, if the firmware didn't turn on the backlight, then
> > > it'll remain off.
> > 
> > As per offline discussion, part of the problems are that today this
> > _isn't_ true for a few Qualcomm things (like interconnect). The
> > interconnect frameway specifically maxes things out for early boot.
> > 
> 
> The problem being solved here is that the bootloader leaves some vote at
> 1GB/s, as needed by hardware related to driver B.
> 
> Driver A is loaded first and votes for 1kb/s; what should the kernel do
> now, without knowledge of the needs from the hardware associated with B,
> or the ability to read back the bootloader's votes.
> 
> This was the behavior of the initial implementation, and the practical
> implications was seen as the UART would typically come along really
> early, cast a low vote on the various buses and it would take forever to
> get to the probing of the drivers that actually gave us reasonable
> votes.

I generally understand this problem and agree that it makes sense to bump
the resources *initially*. Doug and I primarily question the 'wait forever'
part of it.

> Also consider the case where driver A probes, votes for bandwidth, does
> it's initialization and then votes for 0. Without making assumptions
> about the needs of B (or a potential B even), we'd turn off critical
> resources - possible preventing us from ever attempting to probe B.

For the most critical devices that are probed during early boot this
would still work if the resources are initially bumped and then turned
off after some timeout.

Could you provide an example for some other type of device that is/would
be probed later? Except for auto-probing buses like USB or PCI the device
should probe regardless of the resources being enabled and then vote
during probe for the required bandwidth, voltage, etc., which should put
the resources into the required state. Am I missing something here?

> As such, the only safe solution is to assume that there might be a later
> loaded/probed client that has a large vote and preemptively vote for
> some higher bandwidth until then.

> > > > In any case, why do you say it's more correct?
> > >
> > > Because if you turn off the display, the device is unusable. In other
> > > circumstances, it can crash a device because the firmware powered it
> > > on left it in a "good enough" state, but we'd go turn it off and crash
> > > the system.
> > >
> > > > I suppose you'd say that the screen is at least usable like this.
> > > > ...except that you've broken a different feature: suspend/resume.
> > >
> > > If the display is off and the laptop is unusable, then we have bigger
> > > problems than suspend/resume?
> > 
> > I suspect that here we'll have to agree to disagree. IMO it's a
> > non-goal to expect hardware to work for which there is no driver. So
> > making the backlight work without a backlight driver isn't really
> > something we should strive for.
> > 
> 
> Without trying to make you agree ;)
> 
> How can you differentiate between "the driver wasn't built" and "the
> driver isn't yet available"?

Unfortunately you can't AFAIK.

> Consider the case where I boot my laptop, I have some set of builtin
> drivers, some set of drivers in the ramdisk and some set of drivers in
> the root filesystem.
> 
> In the event that something goes wrong mounting the rootfs, I will now
> be in the ramdisk console. Given the current timer-based disabling of
> regulators, I have ~25 seconds to solve my problem before the backlight
> goes blank.
> 
> 
> Obviously this isn't a typical scenario in a consumer device, but it
> seems conceivable that your ramdisk would run fsck for some amount of
> time before mounting the rootfs and picking up the last tier of drivers.

If the laptop is running a kernel that is tailored for this device I'd
say the most practial solution would be to either build the backlight
driver into the kernel or have it on the ramdisk as a module.

However the laptop might be running a distribution like Debian or Red Hat
with (I assume) a single kernel+ramdisk for all systems of a given
architecture (e.g. aarch64). In that case it might not be desirable to
have all possible backlight drivers in the kernel image or ramdisk. For
this kind of system 'wait forever' might be a suitable solution.

I have the impression we might want both options, a timeout after which
resources are turned off unless they have been voted for, and 'wait
forever', with a Kconfig option to select the desired behavior.

For most tailored systems the timout is probably a more suitable solution.
The maintainer of the kernel/system can decide to not enable certain
drivers because they aren't needed and include essential drivers into
the kernel image or ramdisk. The timeout ensures that the system doesn't
burn extra power for reasons that aren't evident for the maintainer (who
might not even be aware of the whole sync_state story).

On the other hand general purpose distributions might want to wait
forever, since they have to support a wide range of hardware and enable
most available drivers anyway.

If we end up with such an option I think the timeout should be the
default. Why? There are hundreds of maintainers of tailored kernels
who might run into hard to detect/debug power issues with 'wait
forever'. On the other hand there is a limited number of general purpose
distributions, with kernel teams that probably already know about
'sync_state'. They only have to enable 'wait forever' once and then
carry it forward to future versions.
