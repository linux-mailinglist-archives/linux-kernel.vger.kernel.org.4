Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4795FD880
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJMLir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJMLip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:38:45 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B0BC4C12;
        Thu, 13 Oct 2022 04:38:44 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id f8so876388qkg.3;
        Thu, 13 Oct 2022 04:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWN7H2+6MSzS1ZPwajWdcQHk62/gsP/CgW++ecohkHU=;
        b=3bocm3actAI1etw9mt6eK2YbAOMxyzikpvzEj8orQ0adaEqjjpQZW1gzZ2qxV8jFMR
         qOrkM30igjOOEgVXR6WecoQ6bZgPRnU/Oz87ZnR5ZMmASyX7FLitN7Hi9E7Jq8+wtpcT
         gtSmhYCt1kngA/WvdmoV8ikOe2CClK1Jj3JZ7n2Qi1F5VPwO5ia8WvGAw6Bs1pXQ/7MA
         1iENGjp901guCsijdA4wzZFrCPvhBtyD4yddHxYAwjRetqoaYeWDulFjxFisBGwe3EYH
         ICmpkk68k5eTUS8G+BkyE565Df4AFVGtQCWsFlMDdGkPi5u4NGtE4u20c2UwZuJwczab
         1Rww==
X-Gm-Message-State: ACrzQf19Mj0NgtiuITzz6lVnLEPKKB8z6+Dyeuesocqx6xUBStFpA0TT
        VFFHBuVdyerQy58U9npS0AXG2NnJAOGgQ/rf5MeaR90zISw=
X-Google-Smtp-Source: AMsMyM488hY3nbJvSEY2w/yu3ij8jcZa7xeyCHDQ5NtcwtOruuTRb0PgDOzjakcpFJPu4RWlvx7mZUH0igQaPY2kEIU=
X-Received: by 2002:a05:620a:2988:b0:6ce:cc3f:73b9 with SMTP id
 r8-20020a05620a298800b006cecc3f73b9mr23607372qkp.9.1665661123781; Thu, 13 Oct
 2022 04:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <5629262.DvuYhMxLoT@kreacher> <20221012205757.GA3118709@bhelgaas>
In-Reply-To: <20221012205757.GA3118709@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Oct 2022 13:38:31 +0200
Message-ID: <CAJZ5v0gWG1qVzwSy19SSqFmxL7NZRf1pkLR_buPoyCcj4f0FLw@mail.gmail.com>
Subject: Re: [PATCH] rtc: rtc-cmos: Fix event handler registration ordering issue
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 11:00 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 12, 2022 at 08:07:01PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Because acpi_install_fixed_event_handler() enables the event
> > automatically on success, it is incorrect to call it before the
> > handler routine passed to it is ready to handle events.
> >
> > Unfortunately, the rtc-cmos driver does exactly the incorrect thing
> > by calling cmos_wake_setup(), which passes rtc_handler() to
> > acpi_install_fixed_event_handler(), before cmos_do_probe(), because
> > rtc_handler() uses dev_get_drvdata() to get to the cmos object
> > pointer and the driver data pointer is only populated in
> > cmos_do_probe().
> >
> > This leads to a NULL pointer dereference in rtc_handler() on boot
> > if the RTC fixed event happens to be active at the init time.
> >
> > To address this issue, change the initialization ordering of the
> > driver so that cmos_wake_setup() is always called after a successful
> > cmos_do_probe() call.
> >
> > While at it, change cmos_pnp_probe() to call cmos_do_probe() after
> > the initial if () statement used for computing the IRQ argument to
> > be passed to cmos_do_probe() which is cleaner than calling it in
> > each branch of that if () (local variable "irq" can be of type int,
> > because it is passed to that function as an argument of type int).
> >
> > Note that commit 6492fed7d8c9 ("rtc: rtc-cmos: Do not check
> > ACPI_FADT_LOW_POWER_S0") caused this issue to affect a larger number
> > of systems, because previously it only affected systems with
> > ACPI_FADT_LOW_POWER_S0 set, but it is present regardless of that
> > commit.
> >
> > Fixes: 6492fed7d8c9 ("rtc: rtc-cmos: Do not check ACPI_FADT_LOW_POWER_S0")
> > Fixes: a474aaedac99 ("rtc-cmos: move wake setup from ACPI glue into RTC driver")
> > Link: https://lore.kernel.org/linux-acpi/20221010141630.zfzi7mk7zvnmclzy@techsingularity.net/
> > Reported-by: Mel Gorman <mgorman@techsingularity.net>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Yep, I blew it with a474aaedac99, sorry about that.
>
> Possibly could call cmos_wake_setup() from cmos_do_probe() instead of
> from cmos_pnp_probe() and cmos_platform_probe()?

Sounds good.

I would prefer to send a separate patch for this on top of the
$subject one, unless Alexandre wants me to do it all in one go.

Alexandre, what's your preference here?  Or would you prefer if I
pushed this forward?

> Then there would be a single call site and it would be closer to the actual dependency on
> dev_set_drvdata().  Either way is fine with me.

OK

> Unrelated, but I happened to notice that pnp_irq() returns -1 for
> failure, and this note suggests that possibly returning 0 would be
> better:
>
>   https://lore.kernel.org/r/CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com

Probably.

In that case, though, it would be prudent to also explicitly discard
IRQ resources where start is equal to 0.

>
> > ---
> >  drivers/rtc/rtc-cmos.c |   29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > Index: linux-pm/drivers/rtc/rtc-cmos.c
> > ===================================================================
> > --- linux-pm.orig/drivers/rtc/rtc-cmos.c
> > +++ linux-pm/drivers/rtc/rtc-cmos.c
> > @@ -1352,10 +1352,10 @@ static void cmos_check_acpi_rtc_status(s
> >
> >  static int cmos_pnp_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
> >  {
> > -     cmos_wake_setup(&pnp->dev);
> > +     int irq, ret;
> >
> >       if (pnp_port_start(pnp, 0) == 0x70 && !pnp_irq_valid(pnp, 0)) {
> > -             unsigned int irq = 0;
> > +             irq = 0;
> >  #ifdef CONFIG_X86
> >               /* Some machines contain a PNP entry for the RTC, but
> >                * don't define the IRQ. It should always be safe to
> > @@ -1364,13 +1364,17 @@ static int cmos_pnp_probe(struct pnp_dev
> >               if (nr_legacy_irqs())
> >                       irq = RTC_IRQ;
> >  #endif
> > -             return cmos_do_probe(&pnp->dev,
> > -                             pnp_get_resource(pnp, IORESOURCE_IO, 0), irq);
> >       } else {
> > -             return cmos_do_probe(&pnp->dev,
> > -                             pnp_get_resource(pnp, IORESOURCE_IO, 0),
> > -                             pnp_irq(pnp, 0));
> > +             irq = pnp_irq(pnp, 0);
> >       }
> > +
> > +     ret = cmos_do_probe(&pnp->dev, pnp_get_resource(pnp, IORESOURCE_IO, 0), irq);
> > +     if (ret)
> > +             return ret;
> > +
> > +     cmos_wake_setup(&pnp->dev);
> > +
> > +     return 0;
> >  }
> >
> >  static void cmos_pnp_remove(struct pnp_dev *pnp)
> > @@ -1454,10 +1458,9 @@ static inline void cmos_of_init(struct p
> >  static int __init cmos_platform_probe(struct platform_device *pdev)
> >  {
> >       struct resource *resource;
> > -     int irq;
> > +     int irq, ret;
> >
> >       cmos_of_init(pdev);
> > -     cmos_wake_setup(&pdev->dev);
> >
> >       if (RTC_IOMAPPED)
> >               resource = platform_get_resource(pdev, IORESOURCE_IO, 0);
> > @@ -1467,7 +1470,13 @@ static int __init cmos_platform_probe(st
> >       if (irq < 0)
> >               irq = -1;
> >
> > -     return cmos_do_probe(&pdev->dev, resource, irq);
> > +     ret = cmos_do_probe(&pdev->dev, resource, irq);
> > +     if (ret)
> > +             return ret;
> > +
> > +     cmos_wake_setup(&pdev->dev);
> > +
> > +     return 0;
> >  }
> >
> >  static int cmos_platform_remove(struct platform_device *pdev)
> >
> >
> >
