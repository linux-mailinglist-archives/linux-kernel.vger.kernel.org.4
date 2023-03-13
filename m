Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CACE6B7978
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCMNvK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 09:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCMNvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:51:08 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E452384C;
        Mon, 13 Mar 2023 06:51:07 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id j11so49002964edq.4;
        Mon, 13 Mar 2023 06:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1hTnZU4cvdt47U5xnDD3Ay69C4uLQZXNpsW2S+4FWE=;
        b=C57W/ix/Qotkyq657nbKVD0DVfPtj3gUxIx4GapbohxJzRK8uOboTBfpOVsZrmZnXN
         VLj4/SmC0v65v4oa8qU5vEO666O6IEn1DUVLBT1CKswFbCTaXztfVqfPwi9z8+MrDkI5
         H51izzISw3Oi5zS3+0pB/xWcPyqeYXiAL11pVgD3E1S/sYlgEyOJk+kDCwAaEQE/D+tt
         EPuVno5ulT9tC79M0SNnw3XgON1TKa0OHcES7jVXRO/623sqs4EVTfy8d//RGDSikvhf
         aywvS6qsKfVfrARgudsy/7bWBtHVPpRAuFS1dPvpeu/aF7gBGN3WQ/6Be9ajqe9Z3XcO
         sF8g==
X-Gm-Message-State: AO0yUKVb/aVR6qlYtJgmaY1Rp9cZreHJRORD12q1RwZA8zoS898CS4kg
        Rw1YQtMO5WxPPJq3Qg7pibprUlUvRqFhGbeSkig5yFQiWjA=
X-Google-Smtp-Source: AK7set8hwQHTFjvhuQeoG+olLyCmW0wqrl7IMkgOQIN+zOJPPCDgZ9CZnfgzmAaK2M7IZKPujn63mvdyI7FI/t43gBo=
X-Received: by 2002:a50:d59a:0:b0:4fb:f19:881 with SMTP id v26-20020a50d59a000000b004fb0f190881mr3027368edi.3.1678715465878;
 Mon, 13 Mar 2023 06:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <2148907.irdbgypaU6@kreacher> <1936685.PYKUYFuaPT@kreacher>
 <f8c87ea7a1fd8f763ff4ccf3c43706ae43f81ede.camel@intel.com>
 <CAJZ5v0i=EL_1ZFyqH4C3cWEVtagL4BB2gg7Xdj4Li1iRjMyM6A@mail.gmail.com> <8d1441fb730cb1ead3316fb5eb8651c2ce991dd8.camel@intel.com>
In-Reply-To: <8d1441fb730cb1ead3316fb5eb8651c2ce991dd8.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Mar 2023 14:50:54 +0100
Message-ID: <CAJZ5v0hMRsGZdYVhY_n3ePbpGbj-qeWtKUi20sShjCQ-qN5DVw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] ACPI: processor: thermal: Update CPU cooling
 devices on cpufreq policy changes
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 3:44 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Fri, 2023-03-10 at 19:29 +0100, Rafael J. Wysocki wrote:
> > On Tue, Mar 7, 2023 at 5:47 PM Zhang, Rui <rui.zhang@intel.com>
> > wrote:
> > > On Fri, 2023-03-03 at 20:23 +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > When a cpufreq policy appears or goes away, the CPU cooling
> > > > devices
> > > > for
> > > > the CPUs covered by that policy need to be updated so that the
> > > > new
> > > > processor_get_max_state() value is stored as max_state and the
> > > > statistics in sysfs are rearranged for each of them.
> > > >
> > > > Do that accordingly in acpi_thermal_cpufreq_init() and
> > > > acpi_thermal_cpufreq_exit().
> > > >
> > > > Fixes: a365105c685c("thermal: sysfs: Reuse cdev->max_state")
> > > > Reported-by: Wang, Quanxian <quanxian.wang@intel.com>
> > > > Link:
> > > > https://lore.kernel.org/linux-pm/53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com/
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/acpi/processor_thermal.c |   16 +++++++++++++---
> > > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/acpi/processor_thermal.c
> > > > =================================================================
> > > > ==
> > > > --- linux-pm.orig/drivers/acpi/processor_thermal.c
> > > > +++ linux-pm/drivers/acpi/processor_thermal.c
> > > > @@ -140,9 +140,14 @@ void acpi_thermal_cpufreq_init(struct cp
> > > >               ret = freq_qos_add_request(&policy->constraints,
> > > >                                          &pr->thermal_req,
> > > >                                          FREQ_QOS_MAX, INT_MAX);
> > > > -             if (ret < 0)
> > > > +             if (ret < 0) {
> > > >                       pr_err("Failed to add freq constraint for
> > > > CPU%d
> > > > (%d)\n",
> > > >                              cpu, ret);
> > > > +                     continue;
> > > > +             }
> > > > +
> > > > +             if (!IS_ERR(pr->cdev))
> > > > +                     thermal_cooling_device_update(pr->cdev);
> > >
> > > Although thermal_cooling_device_update() handles "pr->cdev == NULL"
> > > case, I think it is better to use !IS_ERR_OR_NULL() here.
> >
> > Why is it?
> >
> > I was thinking about doing that, but then I realized that the NULL
> > case had been covered and that's why I went for the change above.  If
> > there is a particular reason to check for NULL here, I can do that,
> > but I'm not sure what it is.
>
> I don't have a strong objection here.
>
> I thought this was a code bug at first glance, until I double checked t
> hermal_cooling_device_update().
>
> So I think the latter would be more straight forward without
> introducing code complexity.

Alternatively, thermal_cooling_device_update() can be made to do the
full check instead.
