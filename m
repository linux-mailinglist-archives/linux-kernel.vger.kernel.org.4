Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDA568E48B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBGXp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBGXpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:45:55 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9394B2E81B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:45:53 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id l12so9429671edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 15:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qfqrnLQnGkyM5B5CF5dy5w8PteGopQkGaSXHd5snYE0=;
        b=nFJSduTKqwmvbZ3xqyy+H3figWon3BTfeTNr+S2Ze/2FE1CvsAuJ+97ns0AOteGJLF
         I8Z+1U/+3BNTZbQYkg298JCh3jcleVFF8/+A5u9lqwa2wgXfBVVMyuVVsW7w6cv1JutL
         wt9jyE9B6IeFpu1A4jzcOy6vPRHIbUDIZo2e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfqrnLQnGkyM5B5CF5dy5w8PteGopQkGaSXHd5snYE0=;
        b=AyEvhC6q7gMVCBS78QNRuJcIhDANNTa46lw6Dr6C5V11RUBwZU8N8HecX3TTSGLGTX
         4fA6GjxXHi8BuXOJgVrbMK3AZzLiUXbF9acq0Cb3usLZ0aAaWyOn6kuM2CmhmrBF8O2s
         MoF99xq3630f3GL/B3Z/4z2dZli4n/CcqfhEl+7LRE/902BLS34apDB+aph4jg+Zecu4
         6C7KofmKsSNrdcSuXZAjnfRVEm8+QZD2OPn0s/dcAYJUt9z/14D/cbdWr8LNydVIbuAF
         YY6mVPM/oW8aoblDsGjkQwtQgzsEzJ7dCpmnOMZIz5vIaXrgy3m5x1DYODynv2zMGxWG
         C03w==
X-Gm-Message-State: AO0yUKW+/nQ230BTAyVPP331hcQGWw5lNqh7VJEmOI0V5iWoCkWgG/PH
        6Aoq59Oc4D+3v/IDSg+ZUUR4L3APv6AsmUaLIuk=
X-Google-Smtp-Source: AK7set+volr+aL9z841pazPdRa9CS3cojL0RLJbgGoh9Zjr6QJzGbEUJ+LbW2H2mA0b+1aYZDAlCSA==
X-Received: by 2002:a50:cdd9:0:b0:4aa:b392:d01f with SMTP id h25-20020a50cdd9000000b004aab392d01fmr5848430edj.34.1675813552016;
        Tue, 07 Feb 2023 15:45:52 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id cq25-20020a056402221900b004a0afea4c9csm7084856edb.18.2023.02.07.15.45.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 15:45:50 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id q8so12171871wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 15:45:49 -0800 (PST)
X-Received: by 2002:a05:600c:19d2:b0:3dc:4c79:211a with SMTP id
 u18-20020a05600c19d200b003dc4c79211amr38074wmq.170.1675813549115; Tue, 07 Feb
 2023 15:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20230127104054.895129-1-abel.vesa@linaro.org> <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org> <Y+E3T6bozU1K2sFb@google.com>
 <Y+E9Z+/+eCpPK6DE@linaro.org> <CAGETcx99ev_JdgYoifEdUg6rqNCs5LHc-CfwTc7j3Bd_zeizew@mail.gmail.com>
 <CAD=FV=X3nnwuTK2=w7DJfjL_Ai7MiuvTwv8BiVJPMVEWKzR-_g@mail.gmail.com> <CAGETcx-LJEZAXT1VazhRf7xtNpST0tfLNmgxH878gkOOP4TDAw@mail.gmail.com>
In-Reply-To: <CAGETcx-LJEZAXT1VazhRf7xtNpST0tfLNmgxH878gkOOP4TDAw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Feb 2023 15:45:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WG1v4U5iQirG=-ECZFtXE=hwL=oY+6zjsu6TWCiBX=QA@mail.gmail.com>
Message-ID: <CAD=FV=WG1v4U5iQirG=-ECZFtXE=hwL=oY+6zjsu6TWCiBX=QA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 6, 2023 at 1:35 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Feb 6, 2023 at 1:10 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, Feb 6, 2023 at 11:33 AM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Mon, Feb 6, 2023 at 9:48 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> > > >
> > > >
> > > > CC'ed Saravana
> > >
> > > Thanks. Please do cc me for stuff like this from the start. I skimmed
> > > the series and I think it's doing one of my TODO items. So, thanks for
> > > the patch!
> > >
> > > I'll take a closer look within a few days -- trying to get through
> > > some existing fw_devlink stuff.
> > >
> > > But long story short, it is the right thing to keep a supplier on
> > > indefinitely if there's a consumer device (that's not disabled in DT)
> > > that never gets probed. It's a pretty common scenario -- for example,
> > > say a display backlight. The default case should be functional
> > > correctness. And then we can add stuff that allows changing this
> > > behavior with command line args or something else that can be done
> > > from userspace.
> > >
> > > +1 to what Doug said elsewhere in this thread too. I'm trying to
> > > consolidate the "when do we give up" decision at the driver core level
> > > independent of what framework is being used.
> >
> > I'm not really sure I agree with the above, at least not without lots
> > of discussion in the community. It really goes against what the kernel
> > has been doing for years and years in the regulator and clock
> > frameworks. Those frameworks both eventually give up and power down
> > resources that no active drivers are using. Either changing the
> > regulator/clock frameworks or saying that other frameworks should work
> > in an opposite way seems like a recipe for confusion.
> >
> > Now, certainly I won't say that the way that the regulator and clock
> > frameworks function is perfect nor will I say that they don't cause
> > any problems. However, going the opposite way where resources are kept
> > at full power indefinitely will _also_ cause problems.
> >
> > Specifically, let's look at the case you mentioned of a display
> > backlight. I think you're saying that if there is no backlight driver
> > enabled in the kernel that you'd expect the backlight to just be on at
> > full brightness.
>
> No, I'm not saying that.
>
> > Would you expect this even if the firmware didn't
> > leave the backlight on?
>
> sync_state() never turns on anything that wasn't already on at boot.
> So in your example, if the firmware didn't turn on the backlight, then
> it'll remain off.

As per offline discussion, part of the problems are that today this
_isn't_ true for a few Qualcomm things (like interconnect). The
interconnect frameway specifically maxes things out for early boot.


> > In any case, why do you say it's more correct?
>
> Because if you turn off the display, the device is unusable. In other
> circumstances, it can crash a device because the firmware powered it
> on left it in a "good enough" state, but we'd go turn it off and crash
> the system.
>
> > I suppose you'd say that the screen is at least usable like this.
> > ...except that you've broken a different feature: suspend/resume.
>
> If the display is off and the laptop is unusable, then we have bigger
> problems than suspend/resume?

I suspect that here we'll have to agree to disagree. IMO it's a
non-goal to expect hardware to work for which there is no driver. So
making the backlight work without a backlight driver isn't really
something we should strive for.


> > Without being able to turn the backlight off at suspend time the
> > device would drain tons of power. It could also overheat when you
> > stuffed it in your backpack and damage the battery or start a fire.
> > Even if you argue that in the case of the display backlight you're
> > better off, what about a keyboard backlight? It's pretty easy to use a
> > laptop without the keyboard backlight and if you didn't have a driver
> > for it you'd be in better shape leaving it off instead of leaving it
> > on 100% of the time, even when the device is suspended.
>
> I think you are again assuming sync_state() will cause stuff to be
> turned on if the firmware didn't leave it on before booting the
> kernel. This is not the case.
>
> But let's assume you had the same understanding, then I'd argue that
> between the default kernel configuration crashing some systems vs
> having power impact on others, I'd prefer the former. The firmware
> shouldn't have left the keyboard backlight on if it cared about
> suspend/resume.

The keylight is a bit of a contrived example, of course. ...but not
that contrived. It's entirely possible that the keyboard backlight is
controlled by a GPIO and that the default state of that GPIO at bootup
enables the backlight regulator. That would mean that the firmware
"left" the keyboard backlight on. The firmware's job is not to init
all hardware. It's to init whatever hardware was needed to boot the
kernel and then get out of the way and boot the kernel. Ideally the
kernel should assume as little about the firmware as possible except
in cases where the firmware actually needs to hand something off to
the kernel (serial console, boot splash, etc).


> > Overall: if a kernel isn't configured for a given driver we shouldn't
> > be expecting the hardware controlled by that driver to work. The best
> > we can hope for is that it's at least in a low power state.
> >
> > In general I think that having a well-defined way to know it's time to
> > give up and power off anything for which a driver didn't probe needs
> > to be an important part of any designs here.
>
> Btw, the current compromise for deferred probes/optional suppliers is
> "keep extending the timeout by 10 seconds as long as modules are being
> loaded".
>
> As I said in my earlier email, this is just what I think it should be
> like and there's still stuff to figure out before I send out a patch
> like that. For example, we could have a sysfs file to write to to
> release sync_state() for a device. Then you'd just echo to that file
> in your example and go about your day.

We don't need to get into a centi-thread here, but I'll at least say
that it's my opinion that we need some way to get the same type of
behavior that the existing regulator / clock frameworks have. That is:
if there are resources that no driver has enabled that there should be
some way to get them to shut off eventually.

-Doug
