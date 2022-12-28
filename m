Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FECC6586CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 21:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiL1Uln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 15:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiL1Ulk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 15:41:40 -0500
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C6C10ED;
        Wed, 28 Dec 2022 12:41:38 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id d10so8736112ilc.12;
        Wed, 28 Dec 2022 12:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uBOQQYDQCIH7OuKYOssxy4KhYY8m5RLan038W/LXmQ=;
        b=gUgagun4p8kPK3znssZQqmHmLAY9t7WcXzRdmjlqg1W7LanXj4dPThdLA8Luq38bSW
         jNR1EOrb2WAlaD4XhVJoJ3/AZku76pEko39JydqScCYoMgsUU/z/WjSSYUSk+Ub6AtG1
         5fOaApnd9hOku3mP8+x4HRyYmoMTasdvGk8do4G0VdnvhWWj5HJaMbQ4CZEifEOcEBA0
         wBgysXoIArJ4L6ngFvfTaW2XxJBwtbA2r/uSFbMQ04ciNOfZxL9ijDStD+0cmVsHzxBn
         m7IBE1v+D2oMYm4h1F9VQNAumrLh+R1eNN73Yun9kM9uOw97SXtxCzswnX/u9GkZHXJt
         egPQ==
X-Gm-Message-State: AFqh2kpNRnaZDwxdrnpViGoMCx6nm1mCacm4LnvI3U8+tkolssjYmsLY
        TBY5jhOT66Kthn5sdg2uiuLXGlbJlnfx2PRNHdQjJwTdfCQ=
X-Google-Smtp-Source: AMrXdXtVFTOYdLYC6urrEdam3FcpQgdgrbXEsoSsRSMqw6Empx6ZePHd+m5ebqd/PzjGesSIvGKSR1KSrzAfQ7un8BE=
X-Received: by 2002:a05:6e02:1d8c:b0:303:814:dc0d with SMTP id
 h12-20020a056e021d8c00b003030814dc0dmr2830249ila.131.1672260097365; Wed, 28
 Dec 2022 12:41:37 -0800 (PST)
MIME-Version: 1.0
References: <12138067.O9o76ZdvQC@kreacher> <24821308109ba20d845e11caf32bede92fec5d8e.camel@linux.intel.com>
In-Reply-To: <24821308109ba20d845e11caf32bede92fec5d8e.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Dec 2022 21:41:24 +0100
Message-ID: <CAJZ5v0j1km2y6RAZcfJ8ERnn8r73vm2mSd6MUq2mHj32hFXu-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: processor: perflib: Use the "no limit"
 frequency QoS
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pratyush Yadav <ptyadav@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 9:55 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2022-12-27 at 20:51 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When _PPC returns 0, it means that the CPU frequency is not limited
> > by
> > the platform firmware, so make acpi_processor_get_platform_limit()
> > update the frequency QoS request used by it to "no limit" in that
> > case
> > and avoid updating the QoS request when the _PPC return value has not
> > changed.
> >
> > This addresses a problem with limiting CPU frequency artificially on
> > some systems after CPU offline/online to the frequency that
> > corresponds
> > to the first entry in the _PSS return package.
> >
> > While at it, move the _PPC return value check against the state count
> > earlier to avoid setting performance_platform_limit to an invalid
> > value.
> >
> > Reported-by: Pratyush Yadav <ptyadav@amazon.de>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/processor_perflib.c |   27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/processor_perflib.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/processor_perflib.c
> > +++ linux-pm/drivers/acpi/processor_perflib.c
> > @@ -53,6 +53,8 @@ static int acpi_processor_get_platform_l
> >  {
> >         acpi_status status = 0;
> >         unsigned long long ppc = 0;
> > +       s32 qos_value;
> > +       int index;
> >         int ret;
> >
> >         if (!pr)
> > @@ -72,17 +74,30 @@ static int acpi_processor_get_platform_l
> >                 }
> >         }
> >
> > +       index = ppc;
> > +
> > +       if (pr->performance_platform_limit == index ||
> > +           ppc >= pr->performance->state_count)
> > +               return 0;
>
> Do we need to re initialize pr->performance_platform_limit to 0 in
> acpi_processor_unregister_performance()?
>
> If PPC was 1 before the offline and after online the above check will
> cause it to return as the pr->performance_platform_limit is not
> changed. Not sure if the PM QOS state is preserved after offline and
> online. This is stored in a per CPU variable, not in dynamically
> allocated memory which will be reallocated during online again.

Good point in general, but the QoS request is tied to the cpufreq
policy, so it is not freed on offline.

However, if the policy goes away and is created again for the same CPU
(like when the intel_pstate mode is changed via its 'status' attribute
in sysfs), there may be a stale value in performance_platform_limit,
so it needs to be cleared in acpi_processor_ppc_init() when the QoS
request is first set to "no limit".

I'll update the patch accordingly.  I think I'll also split it in two
to avoid making too many changes in one go.
