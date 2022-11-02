Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45BA615FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKBJbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKBJbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:31:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D2665FB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:31:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so2993270pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5vJjpZUP6Df3WgXvyEwzQX7839DymC1MDleHo3NzumQ=;
        b=lK8mezEHoK+bQ3SBLa6p5aZS+Hm2wxr02GbjTbG8znDKJPeYLrg0fXTjRkykogcxI+
         CXgZcHZ0+sUtbj7odHT5HJIAFukBEVnqZ1Ue9mqtM7l6aY/5DeUHaF3wPDwXpm1hjcTG
         e4yMVW2u+Ru1+vFZvKxGrlAYPj2xrZxdpmS602PiDs/A5QPaGKlob4nG08paTMyJ7ACE
         9lNw/gi93k5sbtiNWDp7CYcUblSTK6gvjpwzZKxRmOQcXAKRR6SKVdSvP7nT+W4Hg9VA
         5WBLn4/Wx1PhCIv7upXJ+bGIv7cdnT/72Blxt+xWFz13zbuylo71BJUhVu+Hr2IJjxwD
         QZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vJjpZUP6Df3WgXvyEwzQX7839DymC1MDleHo3NzumQ=;
        b=rEHVIsSKXu042hcpAm0hUWFSlz+bX4U/hyzdu0e1fb/met6JqnsW/6LucMAOBjzkd2
         NK6iMoNUmxb6PJ+SZF1FqotpVY34kuiLQfXwY27sX9BekGU8ieQe8cNLXa6/0hQ3v01p
         tspQ/nGoiOuEOPJbTPZvmrX3zsaiiTBWnvkyS5E+Qfgm875M2BnvywUG0z9CibmFIEmh
         ITKkQ1QSZWRLuGJjVdHi4U6xPGzpd4Vlr8cvzz1xvic3Q6140Q3VltxhUriHUJhBAGso
         0w1FQZyO7ty3tom2uEsr/RlBHbbjkgOVCXoMgfNixLC6hld4YEG/LnVykIoARYC+jVVF
         tPlQ==
X-Gm-Message-State: ACrzQf0oEjV3fFCXqzbh0Ry8tI4XM3n8xxb+tCZg95lIQAzkj/V1K/p8
        euM6J6HkYEjIghu8powKMWsqzQ==
X-Google-Smtp-Source: AMsMyM5dgqK5P+IkbrfpOI1FVmChGL1WlIa/+jC1kvFZPmi9nkAZUpv8t8m1tIex8SnuSCBhyMzScg==
X-Received: by 2002:a17:90a:1690:b0:20a:8f70:14bb with SMTP id o16-20020a17090a169000b0020a8f7014bbmr24534952pja.115.1667381462622;
        Wed, 02 Nov 2022 02:31:02 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id d17-20020a17090ac25100b0020ad26fa65dsm998737pjx.56.2022.11.02.02.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:31:02 -0700 (PDT)
Date:   Wed, 2 Nov 2022 17:30:55 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] PM: domains: Consolidate genpd_restore_noirq()
 and genpd_resume_noirq()
Message-ID: <20221102093055.GA1963677@dragon>
References: <20221101024736.1509207-1-shawn.guo@linaro.org>
 <20221101024736.1509207-3-shawn.guo@linaro.org>
 <CAPDyKFqjf3P8GDfNinEeO57peM=7qVVP_M4yu1vsQY6N2wNcqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqjf3P8GDfNinEeO57peM=7qVVP_M4yu1vsQY6N2wNcqA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:23:45AM +0100, Ulf Hansson wrote:
> On Tue, 1 Nov 2022 at 03:47, Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > Most of the logic between genpd_restore_noirq() and genpd_resume_noirq()
> > are same except GENPD_STATE_OFF status reset for hibernation restore.
> > The suspended_count decrement for restore should be the right thing to do
> > anyway, considering there is an increment in genpd_finish_suspend() for
> > hibernation.
> >
> > Consolidate genpd_restore_noirq() and genpd_resume_noirq() into
> > genpd_finish_resume() and handle GENPD_STATE_OFF status reset for
> > restore case specially.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I have a comment, see more below.
> 
> Nevertheless, please add:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> > ---
> >  drivers/base/power/domain.c | 70 ++++++++++++++++++-------------------
> >  1 file changed, 35 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 54f6b0dd35fb..b81baeb38d81 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1247,12 +1247,14 @@ static int genpd_suspend_noirq(struct device *dev)
> >  }
> >
> >  /**
> > - * genpd_resume_noirq - Start of resume of device in an I/O PM domain.
> > + * genpd_finish_resume - Completion of resume of device in an I/O PM domain.
> >   * @dev: Device to resume.
> > + * @resume_noirq: Generic resume_noirq callback.
> >   *
> >   * Restore power to the device's PM domain, if necessary, and start the device.
> >   */
> > -static int genpd_resume_noirq(struct device *dev)
> > +static int genpd_finish_resume(struct device *dev,
> > +                              int (*resume_noirq)(struct device *dev))
> >  {
> >         struct generic_pm_domain *genpd;
> >         int ret;
> > @@ -1264,9 +1266,25 @@ static int genpd_resume_noirq(struct device *dev)
> >                 return -EINVAL;
> >
> >         if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
> > -               return pm_generic_resume_noirq(dev);
> > +               return resume_noirq(dev);
> >
> >         genpd_lock(genpd);
> > +
> > +       /*
> > +        * Special handling for hibernation restore:
> > +        * At this point suspended_count == 0 means we are being run for the
> > +        * first time for the given domain in the present cycle.
> > +        */
> > +       if (resume_noirq == pm_generic_restore_noirq &&
> > +           genpd->suspended_count++ == 0) {
> > +               /*
> > +                * The boot kernel might put the domain into arbitrary state,
> > +                * so make it appear as powered off to genpd_sync_power_on(),
> > +                * so that it tries to power it on in case it was really off.
> > +                */
> > +               genpd->status = GENPD_STATE_OFF;
> 
> This has really never worked as intended. Resetting the status like
> this, needs more careful actions.
> 
> For example, if the genpd->status was GENPD_STATE_ON, the parent
> domain's ->sd_count have been increased - so that needs to be adjusted
> too.
> 
> By looking at patch3/3, I wonder if we shouldn't try to align the
> hibernation behaviors so the above hack can be dropped. Do you think
> that could work?

To be honest, I found this piece of code suspicious when I was fixing my
problem.  To be on the safe side, I chose to leave it there because I'm
not sure if it's handling any special cases or platform quirks.

I tested on my platform with dropping the code.  Worked perfectly fine.
So I will repost the series by starting with this cleanup.

Shawn
