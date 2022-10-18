Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3757760308F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJRQMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJRQMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:12:25 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F858260F;
        Tue, 18 Oct 2022 09:12:24 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id z30so8930261qkz.13;
        Tue, 18 Oct 2022 09:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oLs+QsOzkmiNlMjR8fuZzVNUhlaSm8kh1JoS+Jw7L0=;
        b=En6H/sEZeP8ZMdVNTiDOG4c8212B/Kh1vih33Ec/XVJA9m0JoCBnhgrA3ylwSzEmgW
         JnC5cqnpYdzRTP+ckyJUgCdfmllSwBo4ltIskJvTWir/4WsW4+Bz7OXC1z8Pp6b+4CRp
         q1knc0hYuZbxZoCiDcw204hpQdEBqcW33gIsCKyvMX3D45jMBIScOkv+LJtp0XzZ+LAO
         nHeGniLAGt59KnfQ+EUAI+K0uNsjSUg55QjXhd5JF6TmY54OcFDihKqaBiLyvT8D09r6
         KBA0Akjaeoesk/yaMk6VFCdAtTw9QeprweSw0ofFOjg/WoupLrodDN3jUAsgYnpJmhZ/
         CdgQ==
X-Gm-Message-State: ACrzQf1pyicaeFp7EBLN6HM73ZpaoArck+IY4cujMlqTQZ6oqFb3UGnH
        akImCtUoDmp7FJQY0eIuFm9Xvl/NLT5Xrj61A0E=
X-Google-Smtp-Source: AMsMyM7gjP1K+rJbhxMmfc23JOACTvRuD582MmHwQU1Jojbvm0x1tC5KdzBlmTg066LhtJcWMVOwRnpoeDoYiyugQd4=
X-Received: by 2002:a05:620a:4687:b0:6ee:e69c:e3f1 with SMTP id
 bq7-20020a05620a468700b006eee69ce3f1mr2288665qkb.285.1666109543177; Tue, 18
 Oct 2022 09:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <5629262.DvuYhMxLoT@kreacher> <20221012205757.GA3118709@bhelgaas>
 <CAJZ5v0gWG1qVzwSy19SSqFmxL7NZRf1pkLR_buPoyCcj4f0FLw@mail.gmail.com> <Y0iEaxyO8Jj6tKSC@mail.local>
In-Reply-To: <Y0iEaxyO8Jj6tKSC@mail.local>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Oct 2022 18:12:12 +0200
Message-ID: <CAJZ5v0iOEP=ukAnu7Rs84AfDx=ULKb2eF_0vV5qCb8=66KFPiw@mail.gmail.com>
Subject: Re: [PATCH] rtc: rtc-cmos: Fix event handler registration ordering issue
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Thu, Oct 13, 2022 at 11:34 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 13/10/2022 13:38:31+0200, Rafael J. Wysocki wrote:
> > On Wed, Oct 12, 2022 at 11:00 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Wed, Oct 12, 2022 at 08:07:01PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Because acpi_install_fixed_event_handler() enables the event
> > > > automatically on success, it is incorrect to call it before the
> > > > handler routine passed to it is ready to handle events.
> > > >
> > > > Unfortunately, the rtc-cmos driver does exactly the incorrect thing
> > > > by calling cmos_wake_setup(), which passes rtc_handler() to
> > > > acpi_install_fixed_event_handler(), before cmos_do_probe(), because
> > > > rtc_handler() uses dev_get_drvdata() to get to the cmos object
> > > > pointer and the driver data pointer is only populated in
> > > > cmos_do_probe().
> > > >
> > > > This leads to a NULL pointer dereference in rtc_handler() on boot
> > > > if the RTC fixed event happens to be active at the init time.
> > > >
> > > > To address this issue, change the initialization ordering of the
> > > > driver so that cmos_wake_setup() is always called after a successful
> > > > cmos_do_probe() call.
> > > >
> > > > While at it, change cmos_pnp_probe() to call cmos_do_probe() after
> > > > the initial if () statement used for computing the IRQ argument to
> > > > be passed to cmos_do_probe() which is cleaner than calling it in
> > > > each branch of that if () (local variable "irq" can be of type int,
> > > > because it is passed to that function as an argument of type int).
> > > >
> > > > Note that commit 6492fed7d8c9 ("rtc: rtc-cmos: Do not check
> > > > ACPI_FADT_LOW_POWER_S0") caused this issue to affect a larger number
> > > > of systems, because previously it only affected systems with
> > > > ACPI_FADT_LOW_POWER_S0 set, but it is present regardless of that
> > > > commit.
> > > >
> > > > Fixes: 6492fed7d8c9 ("rtc: rtc-cmos: Do not check ACPI_FADT_LOW_POWER_S0")
> > > > Fixes: a474aaedac99 ("rtc-cmos: move wake setup from ACPI glue into RTC driver")
> > > > Link: https://lore.kernel.org/linux-acpi/20221010141630.zfzi7mk7zvnmclzy@techsingularity.net/
> > > > Reported-by: Mel Gorman <mgorman@techsingularity.net>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > Yep, I blew it with a474aaedac99, sorry about that.
> > >
> > > Possibly could call cmos_wake_setup() from cmos_do_probe() instead of
> > > from cmos_pnp_probe() and cmos_platform_probe()?
> >
> > Sounds good.
> >
> > I would prefer to send a separate patch for this on top of the
> > $subject one, unless Alexandre wants me to do it all in one go.
> >
> > Alexandre, what's your preference here?  Or would you prefer if I
> > pushed this forward?
> >
>
> I applied your patch, feel free to improve on top of that ;)

Thank you!

Unfortunately, I broke the wake alarm with this change and a fix has
just been posted:

https://lore.kernel.org/linux-acpi/5887691.lOV4Wx5bFT@kreacher/
