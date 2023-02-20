Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D86669D1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjBTRM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjBTRMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:12:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA120D07;
        Mon, 20 Feb 2023 09:12:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D6CF60D2D;
        Mon, 20 Feb 2023 17:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C379C433EF;
        Mon, 20 Feb 2023 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676913140;
        bh=K+WQrxm35AL6mxuGen7EEnIB+qmIkik493gpzXp+i6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIDa4PJkpe8nWW47apxX3M9MuiHHBTgDOLlhz0+Jv2iEyO+0mRyBsb2cjbmDh1aUR
         ZsS1jHpPiYxGdZrM1jONUER/tIEZYoJ/MeC7nYL+7o4qhbKX1v/s080k+ZxoUsntkc
         7ssO/LKSYex1liQLrvm39X8RXUjcYZBf30PxL/AvcXyIj/dGeC+ZbyGNvSvCNBzBSF
         Cdt2wsIbhpcyl9mva97T6mEs68iKtS076CHjbfADbjkIya4MTA/NHpBxQ/aOMlA/3M
         At/QFAKmmeACLFnq1mPNk78atZ89MJFgsRrreXXsOMtL9lnx9tb+zT8Ikem/MAVE6a
         VN8l+HCsWyPEg==
Date:   Mon, 20 Feb 2023 09:15:50 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
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
Message-ID: <20230220171550.43a3h56gznfc3gec@ripper>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org>
 <Y+E3T6bozU1K2sFb@google.com>
 <Y+E9Z+/+eCpPK6DE@linaro.org>
 <CAGETcx99ev_JdgYoifEdUg6rqNCs5LHc-CfwTc7j3Bd_zeizew@mail.gmail.com>
 <CAD=FV=X3nnwuTK2=w7DJfjL_Ai7MiuvTwv8BiVJPMVEWKzR-_g@mail.gmail.com>
 <CAGETcx-LJEZAXT1VazhRf7xtNpST0tfLNmgxH878gkOOP4TDAw@mail.gmail.com>
 <CAD=FV=WG1v4U5iQirG=-ECZFtXE=hwL=oY+6zjsu6TWCiBX=QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WG1v4U5iQirG=-ECZFtXE=hwL=oY+6zjsu6TWCiBX=QA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 03:45:35PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Feb 6, 2023 at 1:35 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Feb 6, 2023 at 1:10 PM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Feb 6, 2023 at 11:33 AM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Mon, Feb 6, 2023 at 9:48 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> > > > >
> > > > >
> > > > > CC'ed Saravana
> > > >
> > > > Thanks. Please do cc me for stuff like this from the start. I skimmed
> > > > the series and I think it's doing one of my TODO items. So, thanks for
> > > > the patch!
> > > >
> > > > I'll take a closer look within a few days -- trying to get through
> > > > some existing fw_devlink stuff.
> > > >
> > > > But long story short, it is the right thing to keep a supplier on
> > > > indefinitely if there's a consumer device (that's not disabled in DT)
> > > > that never gets probed. It's a pretty common scenario -- for example,
> > > > say a display backlight. The default case should be functional
> > > > correctness. And then we can add stuff that allows changing this
> > > > behavior with command line args or something else that can be done
> > > > from userspace.
> > > >
> > > > +1 to what Doug said elsewhere in this thread too. I'm trying to
> > > > consolidate the "when do we give up" decision at the driver core level
> > > > independent of what framework is being used.
> > >
> > > I'm not really sure I agree with the above, at least not without lots
> > > of discussion in the community. It really goes against what the kernel
> > > has been doing for years and years in the regulator and clock
> > > frameworks. Those frameworks both eventually give up and power down
> > > resources that no active drivers are using. Either changing the
> > > regulator/clock frameworks or saying that other frameworks should work
> > > in an opposite way seems like a recipe for confusion.
> > >
> > > Now, certainly I won't say that the way that the regulator and clock
> > > frameworks function is perfect nor will I say that they don't cause
> > > any problems. However, going the opposite way where resources are kept
> > > at full power indefinitely will _also_ cause problems.
> > >
> > > Specifically, let's look at the case you mentioned of a display
> > > backlight. I think you're saying that if there is no backlight driver
> > > enabled in the kernel that you'd expect the backlight to just be on at
> > > full brightness.
> >
> > No, I'm not saying that.
> >
> > > Would you expect this even if the firmware didn't
> > > leave the backlight on?
> >
> > sync_state() never turns on anything that wasn't already on at boot.
> > So in your example, if the firmware didn't turn on the backlight, then
> > it'll remain off.
> 
> As per offline discussion, part of the problems are that today this
> _isn't_ true for a few Qualcomm things (like interconnect). The
> interconnect frameway specifically maxes things out for early boot.
> 

The problem being solved here is that the bootloader leaves some vote at
1GB/s, as needed by hardware related to driver B.

Driver A is loaded first and votes for 1kb/s; what should the kernel do
now, without knowledge of the needs from the hardware associated with B,
or the ability to read back the bootloader's votes.

This was the behavior of the initial implementation, and the practical
implications was seen as the UART would typically come along really
early, cast a low vote on the various buses and it would take forever to
get to the probing of the drivers that actually gave us reasonable
votes.


Also consider the case where driver A probes, votes for bandwidth, does
it's initialization and then votes for 0. Without making assumptions
about the needs of B (or a potential B even), we'd turn off critical
resources - possible preventing us from ever attempting to probe B.



As such, the only safe solution is to assume that there might be a later
loaded/probed client that has a large vote and preemptively vote for
some higher bandwidth until then.

> 
> > > In any case, why do you say it's more correct?
> >
> > Because if you turn off the display, the device is unusable. In other
> > circumstances, it can crash a device because the firmware powered it
> > on left it in a "good enough" state, but we'd go turn it off and crash
> > the system.
> >
> > > I suppose you'd say that the screen is at least usable like this.
> > > ...except that you've broken a different feature: suspend/resume.
> >
> > If the display is off and the laptop is unusable, then we have bigger
> > problems than suspend/resume?
> 
> I suspect that here we'll have to agree to disagree. IMO it's a
> non-goal to expect hardware to work for which there is no driver. So
> making the backlight work without a backlight driver isn't really
> something we should strive for.
> 

Without trying to make you agree ;)

How can you differentiate between "the driver wasn't built" and "the
driver isn't yet available"?

Consider the case where I boot my laptop, I have some set of builtin
drivers, some set of drivers in the ramdisk and some set of drivers in
the root filesystem.

In the event that something goes wrong mounting the rootfs, I will now
be in the ramdisk console. Given the current timer-based disabling of
regulators, I have ~25 seconds to solve my problem before the backlight
goes blank.


Obviously this isn't a typical scenario in a consumer device, but it
seems conceivable that your ramdisk would run fsck for some amount of
time before mounting the rootfs and picking up the last tier of drivers.

Regards,
Bjorn
