Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB7969D5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjBTV3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBTV3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:29:14 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149D4A251
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:29:13 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id a20so1035328ybj.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoa38bWcSU5AvS0Y3iSqtsnZYpfYEJuiT9kOUkb3z4U=;
        b=Lyej5Pf9V9eO3hYgwTr4jTRP6JCD0vky/cVkZXFF/oGy8BAr6OzPM8z4wMd0A1sAzV
         CBWHxkYtLFoLJWpyRwvY5sc4sWu5dyL802E3W+Kz83N8pNVR3xl0usp4KSY+PiHnPaNq
         T8zWufkeIxuMPnwl+cDNsMONVvlmrmwI6MmgwnfJzFDvXwznm4JmiCAWarf4SdK6sv5e
         QFBm0CALUtqzyxHiTnxsa+Q2mF4+4HmsN/KmY2YE7XFywn8ZDwu//HVI+pTTUAGG7+3w
         OkS1XGK7L1fWd4AbWT+Zx75wmaz7x4YlUqNJhhSzuz61i4kvEkm1IiYIFf9/bc5O6wEW
         W8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoa38bWcSU5AvS0Y3iSqtsnZYpfYEJuiT9kOUkb3z4U=;
        b=Y2Qycx2G4lLz86/SMPYPjoso5Eds6iOcElPhVqp0XCGAElo19qxD/VbmgDAanroj6c
         ZeFMIXPk9PpaNYqp2H59DNfwZseDXOMSkGTSf9gPdhQeVd0LlO2v/rYu30cUVnwa0Kvp
         Cve6tdofBV+PjwAxGu8jJcPHWReKceVw5C2XK+qLbLfaO3MY419h7W9K7hEIRX/xOqwf
         T+deTHg3UikqBf5EtGhZ8b2x6x0aBhV7DAMkEiUlhHohtrmRsoV8LZuO+GxEDC11Ut9Z
         J5KG0oEmlfNSVBLxm6vK52TVs5pz+lQsrjr+y8YFz7Vwl7PCZUQbqbAiL96Ia1073p4e
         FvWQ==
X-Gm-Message-State: AO0yUKXYrBrrV7YLJUaLJVchhFT6rHTBU0LxCrMi8wfg9M/Q3tcicOTa
        64ao9spLqSDUWXvZ5gycrHo7gZMP7wQXuhGv70s+Zw==
X-Google-Smtp-Source: AK7set9kpd6JcEBUVB/qa0CqN9WHwn5a2oc+c+rrwDdyoOtkWMCa1yQlnK7AYznBeukmO4eQRKKTD1hoIOhVYRf7wPo=
X-Received: by 2002:a25:918c:0:b0:8da:d0ab:258a with SMTP id
 w12-20020a25918c000000b008dad0ab258amr196628ybl.5.1676928552065; Mon, 20 Feb
 2023 13:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20230217161354.129442-1-wyes.karny@amd.com> <Y/NdUjLiQu+D0q7b@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/NdUjLiQu+D0q7b@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 20 Feb 2023 13:29:01 -0800
Message-ID: <CABPqkBTU_gnTr9ayvg220T4pO5NAguvu_UJAkZO2RUATWuMJ3A@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/rapl: Enable Core RAPL for AMD
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wyes Karny <wyes.karny@amd.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 3:45=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Feb 17, 2023 at 04:13:54PM +0000, Wyes Karny wrote:
> > AMD processors support per-package and per-core energy monitoring
> > through RAPL counters which can be accessed by users running in
> > supervisor mode.
> >
> > Core RAPL counters gives power consumption information per core.  For
> > AMD processors the package level RAPL counter are already exposed to
> > perf. Expose the core level RAPL counters also.
> >
> > sudo perf stat -a --per-core -C 0-127 -e power/energy-cores/
> >
> > Output:
> > S0-D0-C0           2               8.73 Joules power/energy-cores/
> > S0-D0-C1           2               8.73 Joules power/energy-cores/
> > S0-D0-C2           2               8.73 Joules power/energy-cores/
> > S0-D0-C3           2               8.73 Joules power/energy-cores/
> > S0-D0-C4           2               8.73 Joules power/energy-cores/
> >
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> >  arch/x86/events/rapl.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> > index 52e6e7ed4f78..d301bbbc3b93 100644
> > --- a/arch/x86/events/rapl.c
> > +++ b/arch/x86/events/rapl.c
> > @@ -537,7 +537,7 @@ static struct perf_msr intel_rapl_spr_msrs[] =3D {
> >   * - want to use same event codes across both architectures
> >   */
> >  static struct perf_msr amd_rapl_msrs[] =3D {
> > -     [PERF_RAPL_PP0]  =3D { 0, &rapl_events_cores_group, 0, false, 0 }=
,
> > +     [PERF_RAPL_PP0]  =3D { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_c=
ores_group, test_msr, false, RAPL_MSR_MASK },
>
> Stephane, this was an oversight?
>
I think it may depend on the CPU model. I remember it returning either
0 or bogus values on my systems. They may have improved that.
The commit msg does not show which CPU model this is run on.

>
> >       [PERF_RAPL_PKG]  =3D { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_p=
kg_group,   test_msr, false, RAPL_MSR_MASK },
> >       [PERF_RAPL_RAM]  =3D { 0, &rapl_events_ram_group,   0, false, 0 }=
,
> >       [PERF_RAPL_PP1]  =3D { 0, &rapl_events_gpu_group,   0, false, 0 }=
,
> > @@ -764,7 +764,8 @@ static struct rapl_model model_spr =3D {
> >  };
> >
> >  static struct rapl_model model_amd_hygon =3D {
> > -     .events         =3D BIT(PERF_RAPL_PKG),
> > +     .events         =3D BIT(PERF_RAPL_PP0) |
> > +                       BIT(PERF_RAPL_PKG),
> >       .msr_power_unit =3D MSR_AMD_RAPL_POWER_UNIT,
> >       .rapl_msrs      =3D amd_rapl_msrs,
> >  };
> > --
> > 2.34.1
> >
