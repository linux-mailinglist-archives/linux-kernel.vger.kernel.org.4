Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075CE6E7096
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 03:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjDSBBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 21:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjDSBBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 21:01:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AA940DB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 18:01:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso91515e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 18:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681866072; x=1684458072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1rx+m5Z6UGaWShqcvQELqKclnr+1AoDgrwesBcsh70=;
        b=OapUE/Rh/nYaMV3PsPio//NxFTIG+wsQlt1EFGdFWTI1eiQi+N4PUFHtydaOBgGOfC
         Xx8FetkE0QyXk9UTTYZZmB0uZAoULLOOAIeD8D9shM0iUchQZ23sK650LoCrFDNImuAj
         jOLwHYS/GsOs/a/cmPdaAYs94tmqqvYdVkrhEOyTG95zY2uxM+i7i8/U1RkG3cPgA7LQ
         yxU3QTPNYaPk/B9fgAJaQEOZvMknfqDgjJphWfu8hOlyDz9Mo3Z6DbzXmhwXxAJ5p13f
         QHomlNi8Y7tfy/RJ65c3jzTX3l25ZrumYV1w4B30I+KIe6FQ2OiFxZ4AUX0waSXZyvam
         3Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681866072; x=1684458072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1rx+m5Z6UGaWShqcvQELqKclnr+1AoDgrwesBcsh70=;
        b=cVgX1b5/XEd48yd3stYhC0uX2JwCb4CLKEACCjEkc8fWzRbEyTIzRSbV8V2rUavd9n
         DQ1KWv3DETraHrBna8vOAVa/00Te5CeTZllkMQzL/tqB67XG3BLUUT/LHDiaYSn030qf
         WuVASKuNhREPE+SKTRchwTMXmrHLyy/IJluNdNR55WJMXE05FwN3EJo4tcyIwbHAh4x7
         FJvivSbsgicmKTc9r+8xaepTjMnj6CCjhbSBJ6Y/iyIRNTwyo7zZiLL+koohKkM75oRk
         eiQJ89sSCIVZ9GrS7QYZ3JfzUPB5SE5Xj6ciDoqRoBWc0lXWpFt8ODnkYcWiga7hRYeG
         OQuw==
X-Gm-Message-State: AAQBX9druSuc3sIaukWN0HNDBkKMKmtrVXObxi8gBbreEHc+CicaoIrD
        8gnkbq3jtW75Ou1vGjtdfAd+qIy8ZABSuU3L1hSDiw==
X-Google-Smtp-Source: AKy350ZEoJ5Nd1q3ZxGfKsmW4RlsA40Kyx54QHJHhJqao8isWKDpO0XbjYWcX2UVR7MSWo5Qoc1LbpPkMHRWWv5NfLA=
X-Received: by 2002:a05:600c:468c:b0:3f1:664a:9a52 with SMTP id
 p12-20020a05600c468c00b003f1664a9a52mr38673wmo.7.1681866071630; Tue, 18 Apr
 2023 18:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <56ac61a0-ccf0-210e-e429-11062a07b8bf@linux.intel.com>
 <CAP-5=fXz1vw48A2tWgcNDSZsnvnOO7_jA+py3p_Khi_igz0hJw@mail.gmail.com>
 <5031f492-9734-be75-3283-5961771d87c8@linux.intel.com> <CAP-5=fW2aAijt8tqydszQHQFmsfeQO2S0hb7Z27RtXxG4Zmm-w@mail.gmail.com>
 <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com> <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
 <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com> <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com> <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com> <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
In-Reply-To: <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 18 Apr 2023 18:00:53 -0700
Message-ID: <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
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

On Tue, Apr 18, 2023 at 5:12=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Apr 18, 2023 at 2:51=E2=80=AFPM Liang, Kan <kan.liang@linux.intel=
.com> wrote:
> >
> >
> >
> > On 2023-04-18 4:08 p.m., Ian Rogers wrote:
> > > On Tue, Apr 18, 2023 at 11:19=E2=80=AFAM Liang, Kan <kan.liang@linux.=
intel.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2023-04-18 11:43 a.m., Ian Rogers wrote:
> > >>> On Tue, Apr 18, 2023 at 6:03=E2=80=AFAM Liang, Kan <kan.liang@linux=
.intel.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 2023-04-17 2:13 p.m., Ian Rogers wrote:
> > >>>>> The json TopdownL1 is enabled if present unconditionally for perf=
 stat
> > >>>>> default. Enabling it on Skylake has multiplexing as TopdownL1 on
> > >>>>> Skylake has multiplexing unrelated to this change - at least on t=
he
> > >>>>> machine I was testing on. We can remove the metric group TopdownL=
1 on
> > >>>>> Skylake so that we don't enable it by default, there is still the
> > >>>>> group TmaL1. To me, disabling TopdownL1 seems less desirable than
> > >>>>> running with multiplexing - previously to get into topdown analys=
is
> > >>>>> there has to be knowledge that "perf stat -M TopdownL1" is the wa=
y to
> > >>>>> do this.
> > >>>>
> > >>>> To be honest, I don't think it's a good idea to remove the Topdown=
L1. We
> > >>>> cannot remove it just because the new way cannot handle it. The pe=
rf
> > >>>> stat default works well until 6.3-rc7. It's a regression issue of =
the
> > >>>> current perf-tools-next.
> > >>>
> > >>> I'm not so clear it is a regression to consistently add TopdownL1 f=
or
> > >>> all architectures supporting it.
> > >>
> > >>
> > >> Breaking the perf stat default is a regression.
> > >
> > > Breaking is overstating the use of multiplexing. The impact is less
> > > accuracy in the IPC and branch misses default metrics,
> >
> > Inaccuracy is a breakage for the default.
>
> Can you present a case where this matters? The events are already not
> grouped and so inaccurate for metrics.

Removing CPUs without perf metrics from the TopdownL1 metric group is
implemented here:
https://lore.kernel.org/lkml/20230419005423.343862-6-irogers@google.com/
Note, this applies to pre-Icelake and atom CPUs as these also lack
perf metric (aka topdown) events.

With that change I don't have a case that requires skippable evsels,
and so we can take that series with patch 6 over the v1 of that series
with this change.

Thanks,
Ian

> > > if multiplexing
> > > is necessary on your Intel architecture. I believe TopdownL1 is more
> > > useful than either of these metrics and so having TopdownL1 be a
> > > default is an improvement. We can add a patch, as I keep repeating
> > > this is off-topic for this patch, to make it so that TopdownL1 isn't
> > > enabled on Intel CPUs pre-Icelake, but I would discourage this.
> >
> >
> > We need the TopdownL1. We just don't need TopdownL1 in the perf stat
> > default when perf metrics feature is not available.
>
> Perf metrics is an Intel only Icelake+ feature. I suggest the simplest
> way to achieve this would be to remove the TopdownL1 metric group from
> all Intel metrics before Icelake. This will mean on these
> architectures the group TmaL1 will need using instead.
>
> Thanks,
> Ian
>
> > >
> > >> The reason we once added the TopdownL1 for ICL and later platform is
> > >> that it doesn't break the original design (a *clean* output).
> > >
> > > Right, and in 6.3-rc7 the aggregation of counts was broken because of
> > > duplicated counts and hard coded metrics (I did a last minute partial
> > > fix). In perf-tools-next aggregation was fixed and we switched to the
> > > json metrics, that are accurate and up-to-date with the latest TMA
> > > metrics, so that we wouldn't need to maintain a duplicate code path.
> > > What keys enabling TopdownL1 in 6.3 is the presence of topdown events
> > > whilst in perf-tools-next it is the presence of TopdownL1 metric
> > > group, as this is a more consistent approach and had first been
> > > proposed by ARM.
> >
> > A consistent approach is good only when it can benefits all parties
> > rather than sacrifices any of them.
> >
> > Apparently, the approach in the perf-tools-next brings all kinds of
> > issues, multiplexing/inaccuracy in the perf stat default on Intel
> > platforms. Why cannot we fix it properly before applying the approach?
> >
> > I think Andi also mentioned the similar request when ARM introduced the
> > TopdownL1 metrics.
> > https://lore.kernel.org/linux-perf-users/12e0deef-08db-445f-4958-bcd5c3=
e10367@linux.intel.com/
> >
> > Thanks,
> > Kan
