Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC26813F3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjA3O7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjA3O7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:59:01 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3CE18ABA;
        Mon, 30 Jan 2023 06:59:00 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id gr7so7905991ejb.5;
        Mon, 30 Jan 2023 06:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXpn0pvpxd/hsTOS/Zxnka5NhAaFb1JpHZULVuihYL0=;
        b=riTrcH9Sv6Hqpc9OC0FUXm2ykvr9/FruKK+w/dNHussYZtzo3Rib1naPNr4FE4c4m/
         cOVbN5uPI3QZT+pD8F4HzPicPw2o2tWNruNgT8a6DIIoAacNt4WuPEKy51thm9p42Z7p
         n0v1kiq5H8hwV94EvxduEdo4UhA/4nUFnhVIWmEGT10vqjWUK4jUh/5W6nCOww2IbS0J
         yBv/hmGGbrQxch2vkwdglnFHV1u/LMFwyPqPsYY96myoDNs2o2VSGzk+GWl33+lFKqIg
         1D7YKdDmSm+Q/ghVNHCbho7FdcaSiQxQZiisfwwfPFPW/NuL1C6HnJT1H0by5PY+K/N4
         4skA==
X-Gm-Message-State: AO0yUKUBu96QT3d4G0ZBx4zrskm3F72JVYctkZ3lhn3m1wPoj0MA/CD4
        2qMSRCxmxFTnnTC3ZPIvZRkklC9I2OGOyDcySuY=
X-Google-Smtp-Source: AK7set9qw9Mc3nCBkoXqXHHY3ekTjdcOGuVO/iIRdcNKDMjis+Lmxf5OWPNnF2YvbljAJSVsHpdfkDWpYZaW2nZ5UG0=
X-Received: by 2002:a17:906:1dcd:b0:87f:575a:9b67 with SMTP id
 v13-20020a1709061dcd00b0087f575a9b67mr2531895ejh.274.1675090739222; Mon, 30
 Jan 2023 06:58:59 -0800 (PST)
MIME-Version: 1.0
References: <12138067.O9o76ZdvQC@kreacher> <12124970.O9o76ZdvQC@kreacher>
 <mafs0sfgybc3q.fsf_-_@amazon.de> <CAJZ5v0hAjKvinPqX2VuCv1jVu50jrnDpECaO=sA2CQZFHZpJdA@mail.gmail.com>
 <mafs0zga0ds30.fsf_-_@amazon.de>
In-Reply-To: <mafs0zga0ds30.fsf_-_@amazon.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Jan 2023 15:58:47 +0100
Message-ID: <CAJZ5v0j1CBe7Hjhg7Tzm3HkuinA9zgtPffMtd96ZaOds=US+xQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: processor: perflib: Use the "no limit"
 frequency QoS
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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

On Mon, Jan 30, 2023 at 3:18 PM Pratyush Yadav <ptyadav@amazon.de> wrote:
>
> Hi Rafael,
>
> On Thu, Dec 29 2022, Rafael J. Wysocki wrote:
>
> > On Thu, Dec 29, 2022 at 1:58 PM Pratyush Yadav <ptyadav@amazon.de> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On Wed, Dec 28 2022, Rafael J. Wysocki wrote:
> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >
> >> > When _PPC returns 0, it means that the CPU frequency is not limited by
> >> > the platform firmware, so make acpi_processor_get_platform_limit()
> >> > update the frequency QoS request used by it to "no limit" in that case.
> >> >
> >> > This addresses a problem with limiting CPU frequency artificially on
> >> > some systems after CPU offline/online to the frequency that corresponds
> >> > to the first entry in the _PSS return package.
> >> >
> >> > Reported-by: Pratyush Yadav <ptyadav@amazon.de>
> >> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> > ---
> [...]
> >>
> >> One small thing I noticed: in acpi_processor_ppc_init() "no limit" value
> >> is set to INT_MAX and here it is set to FREQ_QOS_MAX_DEFAULT_VALUE. Both
> >> should evaluate to the same value but I think it would be nice if the
> >> same thing is used in both places. Perhaps you can fix that up when
> >> applying?
> >
> > Yes, I'll do that.
>
> Following up on this series. I do not see it queued anywhere in the
> linux-pm [0] tree. I would like to have this in the v6.3 merge window if
> possible.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/

It's already in the mainline:

e8a0e30b742f cpufreq: intel_pstate: Drop ACPI _PSS states table patching
99387b016022 ACPI: processor: perflib: Avoid updating frequency QoS
unnecessarily
c02d5feb6e2f ACPI: processor: perflib: Use the "no limit" frequency QoS
