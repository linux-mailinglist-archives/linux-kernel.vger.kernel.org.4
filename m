Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94E46B5019
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjCJSaQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 13:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCJSaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:30:13 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0479F5D30;
        Fri, 10 Mar 2023 10:30:12 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id j11so24219413edq.4;
        Fri, 10 Mar 2023 10:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678473011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GR60+fEiaETdHtzviQu8JaeMsF3FmLDJs+QGXoqH9Gg=;
        b=P8hdpI+zRf0mdg8P+o17I1MCLDYmR2DkXh5wwilBNb1dD6fN5ZR9zQiSqjWFHMdA6p
         +aixLwDqZIHHnQV8QxM7eY7uMvorEpTQI4vQVZLkHLhLxJ/rqopQOIv5kslsRrSXTBd3
         F9XrdlJuDgi65TiUVx4uqr13/0+t1g5RXlv0XRV3/W8yL5rduj6FmwnP9NDUqmqhXT6i
         aFoNZr+NTdMk+00h49uXKc7K+a06Jey0qw3mf736U1XkugBzJfL1e8u0tyBi3ikwRBvm
         dSEqRpzYEU90XRjM+VDEFRPGimWgovXXoScHqcTeSLv/CHOy4mcGfAxqk/QhiFN6tqT+
         jvrA==
X-Gm-Message-State: AO0yUKVCBtO8nwZL45/lvlNPodVu50aL8TWVSrp/zyxTaoAEhUeD4D8G
        kbVhyxwADB22RKiIrEo1G6JfHqWIR8SD5TQkPDJ8APzGY00=
X-Google-Smtp-Source: AK7set9g64QvdRTPNdrqrbNKFyklgeYsTXS2pN8rdBqdhgEzfI59o2wbiqPgdaNhPSfr7oe9YF8QFg2vldNeZ0GFD3Q=
X-Received: by 2002:a50:f61b:0:b0:4bc:eec5:37f5 with SMTP id
 c27-20020a50f61b000000b004bceec537f5mr14794497edn.6.1678473011130; Fri, 10
 Mar 2023 10:30:11 -0800 (PST)
MIME-Version: 1.0
References: <2148907.irdbgypaU6@kreacher> <1936685.PYKUYFuaPT@kreacher> <f8c87ea7a1fd8f763ff4ccf3c43706ae43f81ede.camel@intel.com>
In-Reply-To: <f8c87ea7a1fd8f763ff4ccf3c43706ae43f81ede.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Mar 2023 19:29:59 +0100
Message-ID: <CAJZ5v0i=EL_1ZFyqH4C3cWEVtagL4BB2gg7Xdj4Li1iRjMyM6A@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] ACPI: processor: thermal: Update CPU cooling
 devices on cpufreq policy changes
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

On Tue, Mar 7, 2023 at 5:47 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Fri, 2023-03-03 at 20:23 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When a cpufreq policy appears or goes away, the CPU cooling devices
> > for
> > the CPUs covered by that policy need to be updated so that the new
> > processor_get_max_state() value is stored as max_state and the
> > statistics in sysfs are rearranged for each of them.
> >
> > Do that accordingly in acpi_thermal_cpufreq_init() and
> > acpi_thermal_cpufreq_exit().
> >
> > Fixes: a365105c685c("thermal: sysfs: Reuse cdev->max_state")
> > Reported-by: Wang, Quanxian <quanxian.wang@intel.com>
> > Link:
> > https://lore.kernel.org/linux-pm/53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/processor_thermal.c |   16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/processor_thermal.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/processor_thermal.c
> > +++ linux-pm/drivers/acpi/processor_thermal.c
> > @@ -140,9 +140,14 @@ void acpi_thermal_cpufreq_init(struct cp
> >               ret = freq_qos_add_request(&policy->constraints,
> >                                          &pr->thermal_req,
> >                                          FREQ_QOS_MAX, INT_MAX);
> > -             if (ret < 0)
> > +             if (ret < 0) {
> >                       pr_err("Failed to add freq constraint for CPU%d
> > (%d)\n",
> >                              cpu, ret);
> > +                     continue;
> > +             }
> > +
> > +             if (!IS_ERR(pr->cdev))
> > +                     thermal_cooling_device_update(pr->cdev);
>
> Although thermal_cooling_device_update() handles "pr->cdev == NULL"
> case, I think it is better to use !IS_ERR_OR_NULL() here.

Why is it?

I was thinking about doing that, but then I realized that the NULL
case had been covered and that's why I went for the change above.  If
there is a particular reason to check for NULL here, I can do that,
but I'm not sure what it is.
