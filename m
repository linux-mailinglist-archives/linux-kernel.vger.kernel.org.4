Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ECC6D0C14
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjC3Q77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjC3Q7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:59:47 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B7D72A2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:59:24 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3e0965f70ecso532181cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680195562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7akp0Ej3ybKTtSvJmlVCO91f+z9Y4B731b6732Wg8Y=;
        b=kj8zI+ocoSj82Je2zA1JoXvjC2y0OvYJkSAoLrdeg8HrwyJ6I5YZVj/yjENQUYAtHQ
         ehTSTFDKnH2VBA5wUGZTxh9uOgN03WLqbWJTaKq+oq/rXgj+xw2JLn41QSDiCZmPsxgo
         +Qau9sjscmvkVy3C8hlQJlourjG728IMl2I5QBdEKLMWg6MPxywQ4cRTAEbLGJOAuVNm
         P42bRwImN32orsZKDwrqwGG4o2xLyfdFhf7N2j75D4f8Kzv9IAV34c7UYgBmBxKHRmfQ
         ICt3CY0I3p6LnJwWIR26tybK90sQnMcXEmZz2p/Y7nmfMk0X+dtDmoqq12WtJ8E65GzG
         hyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680195562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7akp0Ej3ybKTtSvJmlVCO91f+z9Y4B731b6732Wg8Y=;
        b=c2wr1uiRdnuMPqiiMttqJcyj3kUFY5lMgFtUaHndcxa4GDDEgpWhl0JmNcMWiltQxn
         cuxaUCtRYTTKmAn4XFfOdCDKD3nfjSLuJAdy3ODyKj5ieerCk0BafNonSpAfqYCZmnaV
         efgk+M2GvR+lDPGy/zB7bVjwxc8sXfyjm+/o+l/bOEpTO0MSX9ElU6PGquK8D9I3+i2C
         jFdDq/69TR1ta7n8BirtobDst4MWKmta5EaRRzcbcjk29XmtteBshFcs4ect39jq/Rv2
         Nf2Wei5jndrDTkOBFgz23QWBLY9+cx8bFAqKWiHUxSnvcF3su0puQsXhA5deEgxVY2EG
         adpg==
X-Gm-Message-State: AAQBX9e3BPOjFPMGLDIiHUEzYR1E6lPXyAaCuW/agHg1AcJNrbzoRQb1
        zJ2bMOSkxZEzU8ao6w7JneMUAsrU0onInIh9r6NfoA==
X-Google-Smtp-Source: AKy350YmGF+RklGr0Q9QWyeuDfLojVGr4FVRoQSQ0Mlc6cG6w5SKVlN9G+P0VVnFT0LTzmOcP7YDX0QA2529VJmwK5g=
X-Received: by 2002:a05:622a:1309:b0:3b9:f660:be05 with SMTP id
 v9-20020a05622a130900b003b9f660be05mr327826qtk.18.1680195562424; Thu, 30 Mar
 2023 09:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235543.1082207-1-irogers@google.com> <20230328235543.1082207-2-irogers@google.com>
 <ZCQ4nERbit/f6yhh@kernel.org> <ZCQ6kqhODsxSCXdP@kernel.org>
 <CAM9d7cjSEx_=UTMpDHMwGb=5H6Yf8UdHTMt1xO=4CVToh60oSA@mail.gmail.com> <ZCVxXTc0kyRAQ+XA@kernel.org>
In-Reply-To: <ZCVxXTc0kyRAQ+XA@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Mar 2023 09:59:08 -0700
Message-ID: <CAP-5=fWZpfo62iN3YWWKm_VZZqMFCyddyg_JQTGe7j6nV+DbmQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf annotate: Delete session for debug builds
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, James Clark <james.clark@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Andres Freund <andres@anarazel.de>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 4:24=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Mar 29, 2023 at 05:13:17PM -0700, Namhyung Kim escreveu:
> > On Wed, Mar 29, 2023 at 6:18=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Wed, Mar 29, 2023 at 10:09:48AM -0300, Arnaldo Carvalho de Melo es=
creveu:
> > > > Em Tue, Mar 28, 2023 at 04:55:38PM -0700, Ian Rogers escreveu:
> > > > > Use the debug build indicator as the guide to free the session. T=
his
> > > > > implements a behavior described in a comment, which is consequent=
ially
> > > > > removed.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >  tools/perf/builtin-annotate.c | 16 ++++++----------
> > > > >  1 file changed, 6 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-a=
nnotate.c
> > > > > index 4750fac7bf93..98d1b6379230 100644
> > > > > --- a/tools/perf/builtin-annotate.c
> > > > > +++ b/tools/perf/builtin-annotate.c
> > > > > @@ -692,16 +692,12 @@ int cmd_annotate(int argc, const char **arg=
v)
> > > > >
> > > > >  out_delete:
> > > > >     /*
> > > > > -    * Speed up the exit process, for large files this can
> > > > > -    * take quite a while.
> > > > > -    *
> > > > > -    * XXX Enable this when using valgrind or if we ever
> > > > > -    * librarize this command.
> > > > > -    *
> > > > > -    * Also experiment with obstacks to see how much speed
> > > > > -    * up we'll get here.
> > > > > -    *
> > > > > -    * perf_session__delete(session);
> > > > > +    * Speed up the exit process by only deleting for debug build=
s. For
> > > > > +    * large files this can save time.
> > > > >      */
> > > > > +#ifndef NDEBUG
> > > > > +   perf_session__delete(annotate.session);
> > > > > +#endif
> > > >
> > > > So now, but default, we will call this, as we don't have this defin=
ed
> > > > only if DEBUG=3D1 is set, right?
> > > >
> > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ find tools/perf/ -type f |=
 xargs grep NDEBUG
> > > > tools/perf/util/mutex.c:#ifndef NDEBUG
> > > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > >
> > > We can discuss this later, applied the series with just that zfree()
> > > change to annotation_options__exit().
> >
> > I don't think it's just an issue in the perf annotate.  Maybe we can
> > do the same for perf report and so on.
>
> Yes, I thought at some point of setting some flag, perf_exiting, and
> then we would stop releasing memory, zfree comes to mind, but then we
> would still be traversing data structures, taking locks, etc.
>
> And we can't just exit() as we may need to flush caches, etc.
>
> IIRC this specific case appeared in profiles, so was commented out.
>
> > Anyway we could define NDEBUG=3D1 for release builds from now on.
>
> Yes, we should do it.

I'll send out a patch. Just a heads up that this will also disable
asserts for non-debug builds.

Thanks,
Ian

> - Arnaldo
