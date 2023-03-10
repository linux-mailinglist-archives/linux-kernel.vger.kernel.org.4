Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34A6B5020
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjCJScO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 13:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCJScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:32:10 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEEB1091CD;
        Fri, 10 Mar 2023 10:32:09 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id j11so24240616edq.4;
        Fri, 10 Mar 2023 10:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678473127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vhle+6K5lcSTVeYkIgUr8IwNgitz8cHVNEe9xDNhtKw=;
        b=t7GGuj+gAyT6IZst+XTW2Bq87kc0WteWbAV9Zgqadi6D3r/Dt6r4q7MajvTcwi8Uqm
         a2LXSu+utTKclBMmJh2EWrDiqgJI0EU7xgBh6zBYjGPMC2gg9m1miXeLqwdlszpYMwJ9
         zLIRa9ed0cPekTy890z7lEYzHITUyVKPH7RfxyKXFuehcgNlSnSsvlqzIDJdVmGjAEFM
         faYBudiltUGgRSYQt+oQiF/r/WAYcVtCxd8ergKnt3MvtN8HSEuRMK3x8XhNxHKosXoM
         NMCbG3auQ/0Zsa2SNyONdY7RQqdrTCaRQOeIwPQntriH7ylaAWkRHJuoeQr+wfoJ4zn6
         C6Qg==
X-Gm-Message-State: AO0yUKX9QCO/YAgUc1DISEWcrs1XqtqkxbvtXEHfz+92N1BSyBXi8YTH
        0XSwoscL+O0/1fmpRvbuq5BleaAR4kSe7NqNrZw=
X-Google-Smtp-Source: AK7set8Whgyw4XUn06Ie6C7aHXNffp2O5UAX9qlCbbLhSjkBhgPqRnkIbFbzNXrcEToa7euMtB6x0qdP2xqxCruvhJU=
X-Received: by 2002:a50:d758:0:b0:4bd:ce43:9ee8 with SMTP id
 i24-20020a50d758000000b004bdce439ee8mr15032900edj.6.1678473127483; Fri, 10
 Mar 2023 10:32:07 -0800 (PST)
MIME-Version: 1.0
References: <2148907.irdbgypaU6@kreacher> <2885079.e9J7NaK4W3@kreacher> <bdafdb137ec992cee592606bc025f8f3e2cf3677.camel@intel.com>
In-Reply-To: <bdafdb137ec992cee592606bc025f8f3e2cf3677.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Mar 2023 19:31:56 +0100
Message-ID: <CAJZ5v0i+7AbFg1s8Bc+WA7ywOeFDcbrTVnJD8_1_DsY3abZVNA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] ACPI: processor: Reorder acpi_processor_driver_init()
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 5:55 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Fri, 2023-03-03 at 20:19 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The cpufreq policy notifier in the ACPI processor driver may as
> > well be registered before the driver itself, which causes
> > acpi_processor_cpufreq_init to be true (unless the notifier
> > registration fails, which is unlikely at that point) when the
> > ACPI CPU thermal cooling devices are registered, so the
> > processor_get_max_state() result does not change while
> > acpi_processor_driver_init() is running.
> >
> > Change the ordering in acpi_processor_driver_init() accordingly
> > to prevent the max_state value from remaining 0 permanently for all
> > ACPI CPU cooling devices.
> >
> > Fixes: a365105c685c("thermal: sysfs: Reuse cdev->max_state")
> > Reported-by: Wang, Quanxian <quanxian.wang@intel.com>
> > Link:
> > https://lore.kernel.org/linux-pm/53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/processor_driver.c |   12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/processor_driver.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/processor_driver.c
> > +++ linux-pm/drivers/acpi/processor_driver.c
> > @@ -263,6 +263,12 @@ static int __init acpi_processor_driver_
> >       if (acpi_disabled)
> >               return 0;
> >
> > +     if (!cpufreq_register_notifier(&acpi_processor_notifier_block,
> > +                                    CPUFREQ_POLICY_NOTIFIER)) {
> > +             acpi_processor_cpufreq_init = true;
> > +             acpi_processor_ignore_ppc_init();
> > +     }
> > +
> >       result = driver_register(&acpi_processor_driver);
> >       if (result < 0)
> >               return result;
> > @@ -276,12 +282,6 @@ static int __init acpi_processor_driver_
> >       cpuhp_setup_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD, "acpi/cpu-
> > drv:dead",
> >                                 NULL, acpi_soft_cpu_dead);
> >
> > -     if (!cpufreq_register_notifier(&acpi_processor_notifier_block,
> > -                                    CPUFREQ_POLICY_NOTIFIER)) {
> > -             acpi_processor_cpufreq_init = true;
> > -             acpi_processor_ignore_ppc_init();
> > -     }
> > -
> >       acpi_processor_throttling_init();
> >       return 0;
> >  err:
> >
> Just FYI.
> I need some time to ramp up on the ordering here to double confirm this
> does not break any dependency, too many things are involved here :p.

Unless I've overlooked something tricky, it should be fine, but of
course verifying this independently won't hurt.

> I will test the whole patch series later this week.

Thank you!
