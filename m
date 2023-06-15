Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC1730D02
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbjFOCEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbjFOCEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:04:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF841BD4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 19:04:35 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f9a81da5d7so119991cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 19:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686794674; x=1689386674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fquAwDeVuYM0VZipKQtkbgEQ+3PiCW8N+f0HW2toSpY=;
        b=JL/gSyqWIBXWvyeh5YCoVxfXjrkR/istd26OWCI77g/Cm0SQZOyJyImJnSjPRvl89L
         EkczAcLA2BAXNWYz9eFoWoje/FWvKLNXivbM+sdQN2KPiRofv3t5SfQSgBmmxWsN/Lgg
         /YKckBZSqmYA0v7w8PxC0G1FYeHLrnB+MnSuZHMNIFvOr5Q1NF0SwrNQIernjbJ8CW6I
         +JKMCqkpsCHphmmbI3RVsYCPOb4JDt+3Tv8c7/pp0/t+0qV6HMVdwV8lIUN8VCbatMUJ
         jB3E4sxRvW+ks/njQRR4WnC+C/YL40/nuvNB/JndwnwkLllAtV/SJx8INJfdBl2jVE4p
         fSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686794674; x=1689386674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fquAwDeVuYM0VZipKQtkbgEQ+3PiCW8N+f0HW2toSpY=;
        b=anynuCsyNO0t/O4RrP00ag6U477026AkxAgIZ+/mrCwbeEVx3/NlLmZG/Fujb1h9IG
         D3NNEkc5gWZZQq+QrnFuma6WumCf4LIUzwahwIl1fBqiR7sRaWONMNQJ5A1LYsYr29ET
         zRQpUVJeXxZA19e74RmECeHqQxIoUU1tt15LO8lSQbMLtRDWxGjTis3qqJk2/5AFS4jL
         UBR0yRTaJte6VGLVt5+M6B6VjY3JH0NQqQEp615eG0ak0SelsPUns2W0XXcJGHGsVKo8
         TX0woMss1O/kA/OoJvBDNyQTIG7QIfde9zk5aOKsiFMvQ/iuuk835L3JKrphkQxjziyc
         i42Q==
X-Gm-Message-State: AC+VfDyTOhGvyNamo+/9xT4ef1etT7iFJskU1HgmgaVksn1s3iwNjwnZ
        0SCTXZzc3h+Sf9Ozt7FuGGFbZ8DGfHI5TKQjNjgj/Q==
X-Google-Smtp-Source: ACHHUZ6gMoVE8P8K29p2bsGU0LQxXW3j2AYSGFnfygyZgt/gLOTLgZmBCEN83pWeCMG5SSD8PkU4i7u9jxxlo8ELBmQ=
X-Received: by 2002:ac8:5911:0:b0:3fd:ad1b:4e8a with SMTP id
 17-20020ac85911000000b003fdad1b4e8amr136184qty.22.1686794674354; Wed, 14 Jun
 2023 19:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230614151625.2077-1-yangjihong1@huawei.com> <CAP-5=fUf0+7HwZ+AHUR0nRD5QnfPn9_CPMEdJZP_5goPfrPB+Q@mail.gmail.com>
 <CAP-5=fVOXjjcusjv858SOGrnNgE2w2sb7zS=0sZUpdFfR1T_GA@mail.gmail.com> <668a6159-b7a8-ed25-d8fa-5584a4c04d37@huawei.com>
In-Reply-To: <668a6159-b7a8-ed25-d8fa-5584a4c04d37@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 19:04:23 -0700
Message-ID: <CAP-5=fX6nWRboZ2dWc1h_y0pe5TAgs0QC0qwCeaLcALfJ+5YEA@mail.gmail.com>
Subject: Re: [PATCH] perf top & record: Fix segfault when default cycles event
 is not supported
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jun 14, 2023 at 6:55=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Hello,
>
> On 2023/6/15 6:03, Ian Rogers wrote:
> > On Wed, Jun 14, 2023 at 9:18=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> >>
> >> On Wed, Jun 14, 2023 at 8:18=E2=80=AFAM Yang Jihong <yangjihong1@huawe=
i.com> wrote:
> >>>
> >>> The perf-record and perf-top call parse_event() to add a cycles event=
 to
> >>> an empty evlist. For the system that does not support hardware cycles
> >>> event, such as QEMU, the evlist is empty due to the following code pr=
ocess:
> >>>
> >>>    parse_event(evlist, "cycles:P" or ""cycles:Pu")
> >>>      parse_events(evlist, "cycles:P")
> >>>        __parse_events
> >>>          ...
> >>>          ret =3D parse_events__scanner(str, &parse_state);
> >>>          // ret =3D 0
> >>>          ...
> >>>          ret2 =3D parse_events__sort_events_and_fix_groups()
> >>>          if (ret2 < 0)
> >>>            return ret;
> >>>          // The cycles event is not supported, here ret2 =3D -EINVAL,
> >>>          // Here return 0.
> >>>          ...
> >>>          evlist__splice_list_tail(evlist)
> >>>          // The code here does not execute to, so the evlist is still=
 empty.
> >>>
> >>> A null pointer occurs when the content in the evlist is accessed late=
r.
> >>>
> >>> Before:
> >>>
> >>>    # perf list hw
> >>>
> >>>    List of pre-defined events (to be used in -e or -M):
> >>>
> >>>    # perf record true
> >>>    libperf: Miscounted nr_mmaps 0 vs 1
> >>>    WARNING: No sample_id_all support, falling back to unordered proce=
ssing
> >>>    perf: Segmentation fault
> >>>    Obtained 1 stack frames.
> >>>    [0xc5beff]
> >>>    Segmentation fault
> >>>
> >>> Solution:
> >>>    If cycles event is not supported, try to fall back to cpu-clock ev=
ent.
> >>>
> >>> After:
> >>>    # perf record true
> >>>    [ perf record: Woken up 1 times to write data ]
> >>>    [ perf record: Captured and wrote 0.006 MB perf.data ]
> >>>    #
> >>>
> >>> Fixes: 7b100989b4f6 ("perf evlist: Remove __evlist__add_default")
> >>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> >>
> >> Thanks, useful addition. The cpu-clock fall back wasn't present before
> >> 7b100989b4f6 so is the fixes tag correct?
> >
> > Hmm... it should be coming from evsel__fallback:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/too=
ls/perf/util/evsel.c?h=3Dtmp.perf-tools-next#n2840
> > so we shouldn't duplicate that logic. The question is why we're not
> > doing the fallback.
> >
>
> Yes, it's a bit of the same logic as evsel__fallback, or we can call
> evlist__add_default() as before, simply create an evsel of hardware
> cycles and add it directly to evlist.
>
> Please confirm whether this solution is feasible. If it is feasible, I
> will send a v2 version.

The previous evlist__add_default logic didn't handle wildcard PMUs for
cycles, hence wanting to reuse the parse events logic. The error is
that the logic now isn't doing the fallback properly. I think an
evlist__add_cycles which uses evsel__fallback makes sense matching the
previous logic. I'd be happy if you took a look. I'll write a patch so
that the perf_pmus list of core PMUs is never empty.

Thanks,
Ian

> Thanks,
> Yang
