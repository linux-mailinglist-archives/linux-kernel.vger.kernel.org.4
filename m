Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8836A85E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCBQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCBQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:10:25 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CC41BAC8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:10:24 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e13so5532341wro.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 08:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677773422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW2Fv/dLrDNZnUSVAjrQLRhdPmysQ5son7O3258Q2aY=;
        b=rastKU+uQCQA+5HnKRmbJF7aq90705G+ZLNOmygZSeCv1y19ToAuYXL4Qnb+nWZFRq
         ICgaNnyc60TyRo1dXxVVyQA7k4KvgadLdv1FNqevIpZ3yNTgA9LNveC6UU0DC8Kvty2k
         vDlla5D18NSFRVrq8cIoddhTT4u9FhJ9Eb1lqBSwcf2dIaQEQvgEyIJQSbrDS99qpb1e
         /jhBdzDF30xZGs4RHYCZRc6ja7M1ve63t/GMHOT9LX06j3Tc8IxbIZJE/J+yBVnyRKAy
         W7bC7x7suQ4XPic0flKj03eZ3lrjJtDHnPgPTsns8KSDmIRrrL55QPRvXk4XFDWnr4Nx
         GZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677773422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oW2Fv/dLrDNZnUSVAjrQLRhdPmysQ5son7O3258Q2aY=;
        b=yswwyx16C5rWBpsuqfwIIdSljL/trpTIUKPcyFdn5p1szCtuP99Mp1kdQVqFx4Fuoo
         pDZbgH3L8/Z9AJq5lSOYDTpxnNltIL8UezwaQZA9+KZJVmopndVE4q5R1N0/ouB4Tg5x
         k7yNR2E4HhvsTTd+c2gzrLfQftN4LkGWgacDCTxMyvCNUwcPhAiEhek0Wsw8N8ATv01C
         9jeeyy73xtpEujdfxDuxU9vkJudx3wZxSQj4JNVDviWsjVMWUOo4NaLX/QdbAs48yVvh
         0EExV85sWWCym96nyZ4g7wcaRJl6/E+qftTwZJIS9EcZkiE2QtAvwjAix+o6/Tfpmdh/
         hrrg==
X-Gm-Message-State: AO0yUKVht5nJdh5sGwlv898OGz6XKniZmpzsklNhTN7ry7FpRCc//jxd
        X7DDY8ORbs5BQaYJNWQH0qUcJkUwCW+63SRPUf6Jbw==
X-Google-Smtp-Source: AK7set/ipYXKag1e9vnesLZbvbHv7qmSFavWidoOGmvDdrjVDkTB6kLe5bP5bKHXJd0SP8ZTEx5JhtC57CKh/zOumKs=
X-Received: by 2002:a5d:6485:0:b0:2c5:4adc:6e52 with SMTP id
 o5-20020a5d6485000000b002c54adc6e52mr597945wri.3.1677773422436; Thu, 02 Mar
 2023 08:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com> <20230302041211.852330-5-irogers@google.com>
 <ZACz+ypWOFxtsu92@kernel.org>
In-Reply-To: <ZACz+ypWOFxtsu92@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Mar 2023 08:10:08 -0800
Message-ID: <CAP-5=fVTviA3y0rLWUOs=WkB5B1Fw_dd9PMZXBhLN38c5F_u3Q@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] perf stat: Modify the group test
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 6:34=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Mar 01, 2023 at 08:12:05PM -0800, Ian Rogers escreveu:
> > Previously nr_members would be 0 for an event with no group. The
> > previous change made that count 1, the event is its own leader without
> > a group. Make the find_stat logic consistent with this, an improvement
> > suggested by Namhyung Kim.
>
> Is this the only place where this change in behaviour needs to be taken
> into account?
>
> - Arnaldo

Actually, I reordered the patches and so the review comment is off.
The nr_members change is in the sorting patch 9. I'll fix up the
comment. I did look for other uses and didn't spot any. I also think
we can add some kind of helper. The current evsel__is_leader functions
are weird. When thinking about the helper I couldn't think of a good
name as I want groups greater than size 1. I'll tweak this.

Thanks,
Ian

> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-shadow.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shado=
w.c
> > index ef85f1ae1ab2..eeccab6751d7 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -163,7 +163,7 @@ static double find_stat(const struct evsel *evsel, =
int aggr_idx, enum stat_type
> >                       continue;
> >
> >               /* Ignore evsels that are part of different groups. */
> > -             if (evsel->core.leader->nr_members &&
> > +             if (evsel->core.leader->nr_members > 1 &&
> >                   evsel->core.leader !=3D cur->core.leader)
> >                       continue;
> >               /* Ignore evsels with mismatched modifiers. */
> > --
> > 2.39.2.722.g9855ee24e9-goog
> >
>
> --
>
> - Arnaldo
