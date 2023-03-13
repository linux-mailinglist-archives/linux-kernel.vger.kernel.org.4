Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDE06B7B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjCMPAn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCMPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:00:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6D45AB69;
        Mon, 13 Mar 2023 07:59:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so20409555edo.2;
        Mon, 13 Mar 2023 07:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678719523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i02P5ataXv/WIcmNp45CNsGdsz6XbuPwbFbqKbd3wps=;
        b=7Be2/OZw1OoDWuhXsJlOWQPRDGRPmCodv4KohcABlLHYFEbqldKxZ+SbDmC15qeUhe
         8dI/Ek6YdtCcn+dLsvkXLWWIrjgmUy/XXWePj/RcaCQsYFYWbv53mmjHhnkMoVHu65eC
         xfxnlO6cVJ26NId5SIE9xFWRnPJ0sOHz/Y5ls/q17qRrvSYqqQPr3gMXDDe1Knmmn7fJ
         4OFhY5twlNhOykC1nBUxdS8EM/iNxId51fNrNFgVa5Toub+wnOPKbvUWImg/tgdnyR9w
         l3PNShDkLxulUQPljBUcbW3nuapOTRxMVf8F8ysWAXVbPLrh517iEreB4+jjVB8Der/a
         k2QQ==
X-Gm-Message-State: AO0yUKWPRZxm0gMwpz2wR960itabUsLTF4UY+DkPthy/xkvllg9IZ3Et
        qLGBNnxB62OOFDUzB4vc2aFx+SMg/L3rNBMsHpvwZ6Hg
X-Google-Smtp-Source: AK7set9xN+eHg7+H6zPIHDwWACMtSISETGGrfN66v/i18u1amy9ku+gp8Q/MhuuLsvrS0KKfxqJdEfrrQVjaia7z0RA=
X-Received: by 2002:a50:f684:0:b0:4fa:3c0b:74b with SMTP id
 d4-20020a50f684000000b004fa3c0b074bmr4126916edn.3.1678719522937; Mon, 13 Mar
 2023 07:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <2148907.irdbgypaU6@kreacher> <2885079.e9J7NaK4W3@kreacher>
 <49cefdcb5d50c1920b9c9533d30e886e368f3fe7.camel@intel.com>
 <CAJZ5v0hm3S_3eOsVm5vTUX23ynPXhY469ctZUpLdHZFt+b2KHA@mail.gmail.com> <ff9d343113b184f08877952608d3424d87687a42.camel@intel.com>
In-Reply-To: <ff9d343113b184f08877952608d3424d87687a42.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Mar 2023 15:58:31 +0100
Message-ID: <CAJZ5v0g_560Rwm6owHxX0L0NrSy4H3MvL9JfGShzXmvihgGtdw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] ACPI: processor: Reorder acpi_processor_driver_init()
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 3:54 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Mon, 2023-03-13 at 14:48 +0100, Rafael J. Wysocki wrote:
> > On Sun, Mar 12, 2023 at 5:09 PM Zhang, Rui <rui.zhang@intel.com>
> > wrote:
> > > On Fri, 2023-03-03 at 20:19 +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > The cpufreq policy notifier in the ACPI processor driver may as
> > > > well be registered before the driver itself, which causes
> > > > acpi_processor_cpufreq_init to be true (unless the notifier
> > > > registration fails, which is unlikely at that point) when the
> > > > ACPI CPU thermal cooling devices are registered, so the
> > > > processor_get_max_state() result does not change while
> > > > acpi_processor_driver_init() is running.
> > > >
> > > > Change the ordering in acpi_processor_driver_init() accordingly
> > > > to prevent the max_state value from remaining 0 permanently for
> > > > all
> > > > ACPI CPU cooling devices.
> > > >
> > > > Fixes: a365105c685c("thermal: sysfs: Reuse cdev->max_state")
> > > > Reported-by: Wang, Quanxian <quanxian.wang@intel.com>
> > > > Link:
> > > > https://lore.kernel.org/linux-pm/53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com/
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The full patch series fixes the problem but this one does not.
> >
> > That is a correct observation, but the $subject patch fixes part of
> > the problem (which is not addressed by the rest of the series AFAICS)
> > and so it deserves a Fixes tag of its own IMO.
>
> Am I understanding this correctly that this patch helps in below case?
>
> cpufreq driver like intel_pstate is registered before we register the
> notifier callback in processor_driver. In this case, we are not able to
> catch the CPUFREQ_CREATE_POLICY notification and cpufreq should be
> counted as part of cooling states when registering the ACPI CPU cooling
> device. (acpi_processor_cpufreq_init must be set at this time)

Yes.

> Or else, in normal case, the ACPI CPU cdev->max_state always return 0
> (when t-state not available) until we receive the CPUFREQ_CREATE_POLICY
> notification and call thermal_cooling_device_update(), both with and
> without this patch.
>
> Patch 2,3,4 works on my test platform, without applying patch 1/4.

OK

> > I guess I should clarify that in the changelog.
> >
> > > This is because,
> > >
> > > static int cpu_has_cpufreq(unsigned int cpu)
> > > {
> > >         struct
> > > cpufreq_policy *policy;
> > >
> > >         if (!acpi_processor_cpufreq_init)
> > >                 return 0;
> > >
> > >         policy = cpufreq_cpu_get(cpu);
> > >         if (policy) {
> > >                 cpufreq_cpu_put(policy);
> > >                 return 1;
> > >         }
> > >         return 0;
> > > }
> > >
> > > Although acpi_processor_cpufreq_init is set to true with patch 1/4,
> > > but
> > > we don't have cpufreq driver registered, thus cpufreq_cpu_get()
> > > return
> > > NULL.
> > > so acpi_processor_cpufreq_init is not the only dependency here. :(
> >
> > Right.  That's why the other patches in the series are needed too.
> >
> > > > ---
> > > >  drivers/acpi/processor_driver.c |   12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/acpi/processor_driver.c
> > > > =================================================================
> > > > ==
> > > > --- linux-pm.orig/drivers/acpi/processor_driver.c
> > > > +++ linux-pm/drivers/acpi/processor_driver.c
> > > > @@ -263,6 +263,12 @@ static int __init acpi_processor_driver_
> > > >       if (acpi_disabled)
> > > >               return 0;
> > > >
> > > > +     if
> > > > (!cpufreq_register_notifier(&acpi_processor_notifier_block,
> > > > +                                    CPUFREQ_POLICY_NOTIFIER)) {
> > > > +             acpi_processor_cpufreq_init = true;
> > > > +             acpi_processor_ignore_ppc_init();
> > > > +     }
> > > > +
> > > >       result = driver_register(&acpi_processor_driver);
> > > >       if (result < 0)
> > > >               return result;
> > > > @@ -276,12 +282,6 @@ static int __init acpi_processor_driver_
> > > >       cpuhp_setup_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD,
> > > > "acpi/cpu-
> > > > drv:dead",
> > > >                                 NULL, acpi_soft_cpu_dead);
> > > >
> > > > -     if
> > > > (!cpufreq_register_notifier(&acpi_processor_notifier_block,
> > > > -                                    CPUFREQ_POLICY_NOTIFIER)) {
> > > > -             acpi_processor_cpufreq_init = true;
> > > > -             acpi_processor_ignore_ppc_init();
> > > > -     }
> > > > -
> > > >       acpi_processor_throttling_init();
> > > >       return 0;
> > > >  err:
> > > >
> > > >
> > > >
