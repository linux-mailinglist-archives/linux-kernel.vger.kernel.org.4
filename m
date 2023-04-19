Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FFC6E7A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjDSNUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjDSNTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:19:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560481544C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:19:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f08b6a9f8aso127745e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681910386; x=1684502386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j983YFludd/GyMTEasQelz3+1RiLp31tfO0wT/ETbtM=;
        b=o3ZP9xclPR9616VadFNj8rnyYb4qGniegdajvA77WQzJe4XoEmbMNMavaf3w9qQx+C
         CosjpVtrISjbAjuUgq0rbTY7iR3WuHeK5tosWKU+uhz3VNygtE47jDk7cs+flnw/gUJk
         J9VnV1+AQyaEuNBd+eGR6X7nPsnDIIn9IlI6FjZnGUfRYFB+YmyC28DSWxISCpG0W+bT
         HO2qd7JVqQiQPFJ+70ZGuziAMp3qLisW5JrP8OhVENc8AsQqghQXr++bdg5+ezgJa9NK
         HX4MiHTunwFsOJgyrx7+gCvwt0zXE3TO9+3iK35AI1JNKoW3XXRUYDC6RvE52Z07XcZ2
         uLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681910386; x=1684502386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j983YFludd/GyMTEasQelz3+1RiLp31tfO0wT/ETbtM=;
        b=c+AXLRINDaB6513K++tpZMws8rk2EjIQ3cpNZY2fVtJp7tA1eJHxTTNB8rQ6i9LObV
         yR5BmUK7eifouUlMFOIQQS8YLZV8pCQ2zBWYaxc9KJMDReJEvOejnGKUva/vD2Kl+Jxh
         UXMmR/2qCC7f0LOKnrYJJlXhtnYgl90PyKj2NH1DK2wPJ5beu2loGXys79+ZWN2lwIH3
         KBnwfobhOb1X/j/XfMwM/P4QtueyT6PC+dXd4r6V+ZHe7ypt6G/dFzwBNmNlZYjyKfkp
         SFLT86Nd78bWJ5HIXDcKQonv5Dm9XeFH6HBX27cNTYu5R/0WPWCxoksIchEBGYI0SjHN
         PQJw==
X-Gm-Message-State: AAQBX9fkXMyKeylxmrSWdNlsV0j6nlm+gZSnIjgWU9CM1uJTpxqERXdY
        oxlY/i5YBbg/OXymsxhDo+B1w8dy8YpwtkZeE0NGsA==
X-Google-Smtp-Source: AKy350bxeStL2sqZdJTM0uS74kWxjTyWkgtDGK4eJo2trp3qCazP4s142SML6zxLZUufbEynbEAxDaqQhH17tJD2OZY=
X-Received: by 2002:a05:600c:1c27:b0:3f1:6fe9:4a98 with SMTP id
 j39-20020a05600c1c2700b003f16fe94a98mr146850wms.5.1681910385676; Wed, 19 Apr
 2023 06:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <56ac61a0-ccf0-210e-e429-11062a07b8bf@linux.intel.com>
 <CAP-5=fXz1vw48A2tWgcNDSZsnvnOO7_jA+py3p_Khi_igz0hJw@mail.gmail.com>
 <5031f492-9734-be75-3283-5961771d87c8@linux.intel.com> <CAP-5=fW2aAijt8tqydszQHQFmsfeQO2S0hb7Z27RtXxG4Zmm-w@mail.gmail.com>
 <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com> <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
 <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com> <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com> <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com> <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com> <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com>
In-Reply-To: <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Apr 2023 06:19:29 -0700
Message-ID: <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 5:31=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-04-18 9:00 p.m., Ian Rogers wrote:
> > On Tue, Apr 18, 2023 at 5:12=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> >>
> >> On Tue, Apr 18, 2023 at 2:51=E2=80=AFPM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2023-04-18 4:08 p.m., Ian Rogers wrote:
> >>>> On Tue, Apr 18, 2023 at 11:19=E2=80=AFAM Liang, Kan <kan.liang@linux=
.intel.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2023-04-18 11:43 a.m., Ian Rogers wrote:
> >>>>>> On Tue, Apr 18, 2023 at 6:03=E2=80=AFAM Liang, Kan <kan.liang@linu=
x.intel.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 2023-04-17 2:13 p.m., Ian Rogers wrote:
> >>>>>>>> The json TopdownL1 is enabled if present unconditionally for per=
f stat
> >>>>>>>> default. Enabling it on Skylake has multiplexing as TopdownL1 on
> >>>>>>>> Skylake has multiplexing unrelated to this change - at least on =
the
> >>>>>>>> machine I was testing on. We can remove the metric group Topdown=
L1 on
> >>>>>>>> Skylake so that we don't enable it by default, there is still th=
e
> >>>>>>>> group TmaL1. To me, disabling TopdownL1 seems less desirable tha=
n
> >>>>>>>> running with multiplexing - previously to get into topdown analy=
sis
> >>>>>>>> there has to be knowledge that "perf stat -M TopdownL1" is the w=
ay to
> >>>>>>>> do this.
> >>>>>>>
> >>>>>>> To be honest, I don't think it's a good idea to remove the Topdow=
nL1. We
> >>>>>>> cannot remove it just because the new way cannot handle it. The p=
erf
> >>>>>>> stat default works well until 6.3-rc7. It's a regression issue of=
 the
> >>>>>>> current perf-tools-next.
> >>>>>>
> >>>>>> I'm not so clear it is a regression to consistently add TopdownL1 =
for
> >>>>>> all architectures supporting it.
> >>>>>
> >>>>>
> >>>>> Breaking the perf stat default is a regression.
> >>>>
> >>>> Breaking is overstating the use of multiplexing. The impact is less
> >>>> accuracy in the IPC and branch misses default metrics,
> >>>
> >>> Inaccuracy is a breakage for the default.
> >>
> >> Can you present a case where this matters? The events are already not
> >> grouped and so inaccurate for metrics.
> >
> > Removing CPUs without perf metrics from the TopdownL1 metric group is
> > implemented here:
> > https://lore.kernel.org/lkml/20230419005423.343862-6-irogers@google.com=
/
> > Note, this applies to pre-Icelake and atom CPUs as these also lack
> > perf metric (aka topdown) events.
> >
>
> That may give the end user the impression that the pre-Icelake doesn't
> support the Topdown Level1 events, which is not true.
>
> I think perf should either keep it for all Intel platforms which
> supports tma_L1_group, or remove the TopdownL1 name entirely for Intel
> platform (let the end user use the tma_L1_group and the name exposed by
> the kernel as before.).

How does this work on hybrid systems? We will enable TopdownL1 because
of the presence of perf metric (aka topdown) events but this will also
enable TopdownL1 on the atom core.

>
> > With that change I don't have a case that requires skippable evsels,
> > and so we can take that series with patch 6 over the v1 of that series
> > with this change.
> >
>
> I'm afraid this is not the only problem the commit 94b1a603fca7 ("perf
> stat: Add TopdownL1 metric as a default if present") in the
> perf-tools-next branch introduced.
>
> The topdown L2 in the perf stat default on SPR and big core of the ADL
> is still missed. I don't see a possible fix for this on the current
> perf-tools-next branch.

I thought in its current state the json metrics for TopdownL2 on SPR
have multiplexing. Given L1 is used to drill down to L2, it seems odd
to start on L2, but given L1 is used to compute the thresholds for L2,
this should be to have both L1 and L2 on these platforms. However,
that doesn't work as you don't want multiplexing.

This all seems backward to avoid potential multiplexing on branch miss
rate and IPC, just always having TopdownL1 seems cleanest with the
skippable evsels working around the permissions issue - as put forward
in this patch. Possibly adding L2 metrics on ADL/SPR, but only once
the multiplexing issue is resolved.

Thanks,
Ian

> Thanks,
> Kan
