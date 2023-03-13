Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7C56B796D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCMNs7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCMNs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:48:57 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550AB222DD;
        Mon, 13 Mar 2023 06:48:56 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id j11so48976115edq.4;
        Mon, 13 Mar 2023 06:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOWyGFTY/xJlQJMCFh16k9w4f6amBshkfJRcKKZky/8=;
        b=KCVdx7mCUphng3VirAgMyh7eJMJg9KRXdoyFPOjVpWtHbGc1HF8XPBuuqwj7H42Y3j
         laoSivZSr+AMWyXSnGfJOISX1lcS3nSQQYUqj7DMPtroF5zZorL3MfHqpfoWZflGFnpS
         w8dcPoJD2r/ckCY7DdU9sQ42/EP9DeifFvdMZYyQLEG5/mFIYmA++uWGR6dTBzhUMy4v
         8UaxyDVaJq2pgRnqqNZwtsJ6Ta5pRxfD5xD2GOVOA04thz63liEJkcUaeCcuQD0V8Lpi
         uz0TjW8c/kSrnZ4cLbIrCLVGp3n9OyeedBfJfQ6eiMUoywfaVhJ1X01ArGRurfbsj7MG
         jG5Q==
X-Gm-Message-State: AO0yUKXUAkddlcQTUR72lVWr+yKEPPSuMsR4z5iE1y4cJ3VWYc38q9Z2
        mNKKQ5yGQ2msUEOBAKn14/v9RNfUYaaA4Nh7Gc4u48JcJMA=
X-Google-Smtp-Source: AK7set8LqlRBfErMcK1miWLcFwwW6Y59eFcKui8BVGayriWaMc9CbRy6ix5DOViNcRdx53/NmNkzr3a6ssLzALSD/WM=
X-Received: by 2002:a17:906:13c2:b0:8b1:7aec:c8e6 with SMTP id
 g2-20020a17090613c200b008b17aecc8e6mr18041172ejc.2.1678715334857; Mon, 13 Mar
 2023 06:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <2148907.irdbgypaU6@kreacher> <2885079.e9J7NaK4W3@kreacher> <49cefdcb5d50c1920b9c9533d30e886e368f3fe7.camel@intel.com>
In-Reply-To: <49cefdcb5d50c1920b9c9533d30e886e368f3fe7.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Mar 2023 14:48:23 +0100
Message-ID: <CAJZ5v0hm3S_3eOsVm5vTUX23ynPXhY469ctZUpLdHZFt+b2KHA@mail.gmail.com>
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

On Sun, Mar 12, 2023 at 5:09 PM Zhang, Rui <rui.zhang@intel.com> wrote:
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
>
> The full patch series fixes the problem but this one does not.

That is a correct observation, but the $subject patch fixes part of
the problem (which is not addressed by the rest of the series AFAICS)
and so it deserves a Fixes tag of its own IMO.

I guess I should clarify that in the changelog.

> This is because,
>
> static int cpu_has_cpufreq(unsigned int cpu)
> {
>         struct
> cpufreq_policy *policy;
>
>         if (!acpi_processor_cpufreq_init)
>                 return 0;
>
>         policy = cpufreq_cpu_get(cpu);
>         if (policy) {
>                 cpufreq_cpu_put(policy);
>                 return 1;
>         }
>         return 0;
> }
>
> Although acpi_processor_cpufreq_init is set to true with patch 1/4, but
> we don't have cpufreq driver registered, thus cpufreq_cpu_get() return
> NULL.
> so acpi_processor_cpufreq_init is not the only dependency here. :(

Right.  That's why the other patches in the series are needed too.

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
> >
> >
