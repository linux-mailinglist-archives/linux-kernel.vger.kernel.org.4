Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC4659134
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 20:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiL2T0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 14:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2T0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 14:26:21 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0304312AA2;
        Thu, 29 Dec 2022 11:26:21 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id i83so10120044ioa.11;
        Thu, 29 Dec 2022 11:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96swl6SBp+iRyjcWKsO/bgYdGhEEyZ7jRkRVKCzJmJk=;
        b=fdKTNdPVOBepco6nv3uEAsCFFERupaUvDVX858ZK91t7Oe34XK0hduVhMLW21VH+4D
         aBUI/MQQUXloczNZMU7gsBR83VMWZYe1DEaF7GOaRn4fOeH5T6N2uv0OhiDBWIkLVjqd
         RVTLs3sHJ1NmoOt+E9xhRB3VLFwttodRyzgRgPXkbnaaG7Q51aIczZJI/0j5Fk3nubyp
         WPX71UzviJpxrNtvYQC0shFM4Zx/oT5uUQIkXEIVDCamkRbRoubS6fdWzJ7iELkVHKGd
         jCrbpehXVJ41wLmrcHU/PoeiLm0XQZf1OEGs5hE6zseRx160AqJqJFD36jtzaRcqGNb1
         KyKg==
X-Gm-Message-State: AFqh2koAOgCpK3ZaYzWwsp0fR28ZaFgMHFrPc+cXhQzaEOqVfnzwYsLU
        qjCgN7heGkB3aJHHqf2FTy9obMgiXJxx6FZhd88=
X-Google-Smtp-Source: AMrXdXug5nzJqTiSBaZlx0Ltj5ScsXErS+NOcnzdRiPgRut+i2hNmOhohpwnNYeoRje1Nu/W3DqNAERoEMjMk7P0kBc=
X-Received: by 2002:a02:9707:0:b0:396:2348:340e with SMTP id
 x7-20020a029707000000b003962348340emr2793714jai.195.1672341980204; Thu, 29
 Dec 2022 11:26:20 -0800 (PST)
MIME-Version: 1.0
References: <12138067.O9o76ZdvQC@kreacher> <12124970.O9o76ZdvQC@kreacher> <mafs0sfgybc3q.fsf_-_@amazon.de>
In-Reply-To: <mafs0sfgybc3q.fsf_-_@amazon.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Dec 2022 20:26:07 +0100
Message-ID: <CAJZ5v0hAjKvinPqX2VuCv1jVu50jrnDpECaO=sA2CQZFHZpJdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: processor: perflib: Use the "no limit"
 frequency QoS
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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

On Thu, Dec 29, 2022 at 1:58 PM Pratyush Yadav <ptyadav@amazon.de> wrote:
>
> Hi Rafael,
>
> On Wed, Dec 28 2022, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When _PPC returns 0, it means that the CPU frequency is not limited by
> > the platform firmware, so make acpi_processor_get_platform_limit()
> > update the frequency QoS request used by it to "no limit" in that case.
> >
> > This addresses a problem with limiting CPU frequency artificially on
> > some systems after CPU offline/online to the frequency that corresponds
> > to the first entry in the _PSS return package.
> >
> > Reported-by: Pratyush Yadav <ptyadav@amazon.de>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >    * Move some changes into a separate patch
> >    * Update the changelog accordingly
> >
> > ---
> >  drivers/acpi/processor_perflib.c |   20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
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
> > @@ -72,17 +74,27 @@ static int acpi_processor_get_platform_l
> >                 }
> >         }
> >
> > +       index = ppc;
> > +
> >         pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
> > -                      (int)ppc, ppc ? "" : "not");
> > +                index, index ? "is" : "is not");
> >
> > -       pr->performance_platform_limit = (int)ppc;
> > +       pr->performance_platform_limit = index;
> >
> >         if (ppc >= pr->performance->state_count ||
> >             unlikely(!freq_qos_request_active(&pr->perflib_req)))
> >                 return 0;
> >
> > -       ret = freq_qos_update_request(&pr->perflib_req,
> > -                       pr->performance->states[ppc].core_frequency * 1000);
> > +       /*
> > +        * If _PPC returns 0, it means that all of the available states can be
> > +        * used ("no limit").
> > +        */
> > +       if (index == 0)
> > +               qos_value = FREQ_QOS_MAX_DEFAULT_VALUE;
>
> One small thing I noticed: in acpi_processor_ppc_init() "no limit" value
> is set to INT_MAX and here it is set to FREQ_QOS_MAX_DEFAULT_VALUE. Both
> should evaluate to the same value but I think it would be nice if the
> same thing is used in both places. Perhaps you can fix that up when
> applying?

Yes, I'll do that.

> Other than this,
>
> Reviewed-by: Pratyush Yadav <ptyadav@amazon.de>
> Tested-by: Pratyush Yadav <ptyadav@amazon.de>

Thanks!

> Thanks for working on this.

You're welcome.
