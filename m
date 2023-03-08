Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48846B1011
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCHRQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCHRQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:16:30 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3CEC858C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:15:18 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id k9so10281701ilu.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 09:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678295700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pg2CXYfzc/WTDquji0TW2Mdpepw4Jnm/5KTgUCpFsYs=;
        b=eA9abkj424I7Bk9UgGWnxfkK72qfNxDVXh0PTzZq0VYGXp/EWghlsM7uUKZ0c45Iyr
         qWbxyDuJ9lio3AbNH+ZWmetdQ4T4lZ98Asd6y2EA640B1o5m745XpkciuUhOitcItmpz
         Uo7wr9Rw2US8ksR05895D/qfDO6OlLrtjQdUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pg2CXYfzc/WTDquji0TW2Mdpepw4Jnm/5KTgUCpFsYs=;
        b=MJpFOb1MjKdO/kfcp2+40pfHAfwbniLAMs5F/CCrhbJtFkJfXFhGX+EwIE6K8OJxFn
         23zWj8JmWrRvhqWhih46Kodnbv8xXHSjfe3iEMER0zlLGz3zYbUTJPEN/w/OraEC3Dl0
         Cs4Urd8bmtpPrhHw4jbuTUZ2Zw97WBaaPIxNEG3LvOKhrA9Oc4eF3vQ+Pc0OYp0e2OPm
         NiwIJ5Ytv8PX1Pk50r+udRqZijnC8XMPYDUxvFXVDBeyc6LhZazpydY8rV4fNMOYbCt3
         5XhPArTXkkGDoToNtn9VMqNkPMaLm2Yl2dJwvQhEqhqpUxP5PcF7ivt12MZatAMIYZKK
         Rl1w==
X-Gm-Message-State: AO0yUKVnkTI1Wi+GTnne/hiBudwqo4HHOYq7W7UMcmWy9PTENboPsubm
        aiGdczmP0O8bwrTu7WAL7R3daQ==
X-Google-Smtp-Source: AK7set9F71PT/ydIVZkDvkzPR36BxReD7EzmnGMuIHot6IWeo4MSNQX9bVhi4Bldc6U3HI93ep5P2g==
X-Received: by 2002:a05:6e02:1bab:b0:316:61c1:d9d1 with SMTP id n11-20020a056e021bab00b0031661c1d9d1mr14730173ili.24.1678295700632;
        Wed, 08 Mar 2023 09:15:00 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id b18-20020a920b12000000b003157b2c504bsm4709315ilf.24.2023.03.08.09.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 09:15:00 -0800 (PST)
Date:   Wed, 8 Mar 2023 17:14:59 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 1/2] driver core: Add fw_devlink.sync_state command
 line param
Message-ID: <ZAjCk1w3YLRHzNnu@google.com>
References: <20230224070506.4157738-1-saravanak@google.com>
 <20230224070506.4157738-2-saravanak@google.com>
 <CAD=FV=XQnLpD1P8sRBcizTMjCQyHTjaiNvjcPdgyZc5JCzvOtw@mail.gmail.com>
 <CAGETcx9aRPEU3pW4Dtn_pp5c7dKd7ZhyyKWF6XnfLp+aCxo=OA@mail.gmail.com>
 <CAD=FV=W=EJ1LCDeKzHJ_X+nEtoqf8OzO1sqKFKOay5gSbUPjpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=W=EJ1LCDeKzHJ_X+nEtoqf8OzO1sqKFKOay5gSbUPjpQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 07:39:03AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Fri, Mar 3, 2023 at 4:53 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > > IMO better would be to say something like when sync_state=strict that
> > > you'll just leave resources in a high power state
> >
> > But this statement is not true either. Just because a device driver
> > has a sync_state() doesn't mean the device was left in a powered on
> > state by the bootloader.
> 
> Though I guess it's theoretically possible that a device using
> sync_state will leave resources in a _lower_ power state until
> sync_state is reached, I'm skeptical if that actually happens. Can you
> point to any examples? The sync state docs
> "sysfs-devices-state_synced" actually document that the common case is
> when the bootloader left a resource enabled and we won't disable the
> resource until sync_state is reached. That's almost certainly a higher
> power state.
> 
> I would also point to one of the users of sync_state: the interconnect
> framework. Take a look at commit b1d681d8d324 ("interconnect: Add sync
> state support"). You can see that in icc_node_add() if we can't read
> the bandwidth at bootup we end up at the max (INT_MAX). That's exactly
> the case we actually hit for Qualcomm. It's not that we just avoid
> touching the resources until sync state is reached--we actually max it
> out.

Another example is commit 3a39049f88e4 ("soc: qcom: rpmhpd: Use highest
corner until sync_state"), which does the same for rpmhpds.

> In general, something feels a bit awkward here in defining this as
> "however the bootloader left it". That concept makes sense for things
> where we need to manage a handoff from the bootloader for the kernel,
> but it's not the answer for all things. The bootloader's job is to
> boot the system and get out of the way, not to init all resources. It
> only inits resources that it cares about. That means if the bootloader
> displays a splash screen then it might init resources for the display.
> if it doesn't display a splash screen it might not. The kernel needs
> to handle either case.
> 
> In general, the problems being solved with sync_state seem to require
> resources to be left on and in high power until sync state is reached.
> Today, you define that as "the state the bootloader left it in".
> ...but if the bootloader didn't leave it in a high power state then
> you'd need to change this definition.
> 
> If you truly want to couch the verbiage, I guess I'd be OK with saying
> "when sync_state=strict that you'll _LIKELY_ leave resources in a high
> power state if sync_state is never reached"
> 
> 
> > > While I don't object to this being a kernel command line flag, the
> > > default should also be a Kconfig option. The kernel command line is
> > > not a great place for general configuration. As we jam too much stuff
> > > in the kernel command line it gets unwieldy quickly. IMO:
> > >
> > > * Kconfig: the right place for stuff for config options that a person
> > > building the kernel might want to tweak.
> > >
> > > * Kernel command line: the right place for a user of a pre-built
> > > kernel to tweak; also (sometimes) the right place for the bootloader
> > > to pass info to the kernel; also a good place for debug options that a
> > > kernel engineer might want to tweak w/out rebuilding the kernel.
> > >
> > > In this case it makes sense for the person building the kernel to
> > > choose a default that makes sense for the hardware that their kernel
> > > is targetting. It can also make sense for a user of a pre-built kernel
> > > to tweak this if their hardware isn't working correctly. Thus it makes
> > > sense for Kconfig to choose the default and the kernel command line to
> > > override.
> >
> > I don't mind adding a Kconfig to select the default behavior, but
> > maybe as a separate patch in the future so if there's any debate about
> > that, you'll at least get this option.
> 
> I don't mind it being a separate patch, but it should be part of the
> initial series.

+1

> > > Specifically, I think this warning message gets printed out after
> > > we've given up waiting for devices to show up. At this point
> > > -EPROBE_DEFER becomes an error that we won't retry.
> >
> > This is not true. We will always retry on an -EPROBE_DEFER, even after timeout.
> 
> OK, so I think this is the main point of contention here, so let's get
> to the bottom of it first and then we can address anything else.
> 
> I guess I'm trying to figure out what "deferred_probe_timeout" is
> supposed to be about. From reading
> driver_deferred_probe_check_state(), I see that the idea is that once
> the timeout expires then we'll start returning -ETIMEDOUT when we used
> to return -EPROBE_DEFER. I guess I mispoke then. You're correct that
> -EPROBE_DEFER will still be retried. That being said, things that used
> to be retired (because they returned -EPROBE_DEFER) will now become
> permanent/non-retired errors (because they return -ETIMEDOUT).
> 
> My point is that if we ever actually hit that case (where we return
> -ETIMEDOUT instead of -EPROBE_DEFER) we really enter a state where
> it's not going to be great to load any more drivers. Once a driver
> failed to probe (because it got back an -ETIMEDOUT instead of
> -EPROBE_DEFER) then the user needs to manually unbind/rebind the
> device to retry. That's not a good state.
> 
> So the above is the crux of my argument that once
> "deferred_probe_timeout" fires that the system really isn't in good
> shape to load more drivers.
> 
> So looking more carefully, I think I can understand where you're
> coming from. Specifically I note that very few subsystems have "opted
> in" to the deferred_probe_timeout on ToT. I can also see that recently
> you made the effort to delete driver_deferred_probe_check_state(),
> though those were reverted. That means that, as it stands, devices
> will _probably_ not end up with the problem I describe above (unless
> they depend on a subsystem that has opted-in). ...and, if your plans
> come to fruition, then eventually we'll never hit it.
> 
> Where does that leave us? I guess I will step back on my assertion
> that when the timeout fires that drivers can't load anymore. Certainly
> the state that ToT Linux is in is confusing. "deferred_probe_timeout"
> is still documented (in kernel-parameters.txt) to cause us to "give
> up" waiting for dependencies. ...and it still causes a few subsystems
> to give up. ...but I guess it mostly works.
> 
> 
> > > I would perhaps also make it sound a little scarier since,
> >
> > I definitely don't want to make it sound scarier and get everyone to
> > enable the timeout by default without actually knowing if it has a
> > power impact on their system.
> >
> > > IMO, this
> > > is a problem that really shouldn't be "shipped" if this is an embedded
> > > kernel. Maybe something like:
> >
> > This is how it's shipped on all Android devices in the past 2 years.
> > So it's not a global problem like you make it to be.
> 
> You're saying devices _shipped_ but booted up where devices never
> reached sync_state? ...and that's not a power consumption problem???
> I'm not saying that the sync_state concept couldn't ship, I'm saying
> that if this printout shows up in boot logs that it's highly likely
> there's a problem that needs to be fixed and that's causing extra
> power consumption. That's why I want the printout to sound scarier.

+1
