Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8CC64118F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiLBXgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiLBXgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:36:39 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EF6DBF7D;
        Fri,  2 Dec 2022 15:36:38 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id bx10so10214780wrb.0;
        Fri, 02 Dec 2022 15:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VFZNeYDZEE61kEBhYKj8Sc/Tb0KAKtr1cnbkqjrwuM=;
        b=LzifJTJxeoLQIGWnGpLZdpgwyYgn8tsiJlTxm9P16FqTaLYti5Khgnqt/aQFH7KaI4
         YFbOv+wwssVQ3ELAlGxsiB8c5nZcHU679mnCVrblghsN1YADbl61vJSTQvxSdq6UJWFy
         bSg5kV+AznF22qRtSnEzkQtM35TLaPVNMrqwu4QGYoVKmna/cU9lmbl/+M49t/lSNUXn
         ehai9Cv4FyoKvH/ztgWc1PJAqKAfssv133CvQhgW5yQr+ADgVWk72E4c4cHI4QdFivaO
         ZjpqMkC+Ty6R8dOmZyDyMYNiSO2AktYp4Wd4A0UC7/mscj12h5g6KRcj1L+WBZBOm4u0
         Tr6Q==
X-Gm-Message-State: ANoB5pn3O9qwQzVd5xzSWgMPykKDXJOujizuIACR/ePyf/kBr1IwQ2Bj
        0Co52YJCMkUX5B2ZI5wDtWHB/fwV8zJPWpNd46o=
X-Google-Smtp-Source: AA0mqf5NMwR36Mx79LiVlhdZwFUMKsZC1CFbcvAAtduzdU6v9sEFCOxAPSik3rHXBe+CtZR7oPkokTq/GuIYgRKVNUg=
X-Received: by 2002:adf:e50d:0:b0:242:2d9d:c24b with SMTP id
 j13-20020adfe50d000000b002422d9dc24bmr8646142wrm.285.1670024196926; Fri, 02
 Dec 2022 15:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20221130062935.2219247-1-irogers@google.com> <20221130062935.2219247-4-irogers@google.com>
 <CAM9d7chrsLHoGe=RcU2e5hRL22j=813j3uuEHDOPZrkpWqnSsw@mail.gmail.com>
 <CAP-5=fWZVHN5tDG+eKRr7v_RXKYA_uUgY-dFH_g3Yc3mFgkXbA@mail.gmail.com>
 <CAM9d7chsymFFq1di15w+s7jtDenV=kFnk=EDrFO_rDWcSQSa6g@mail.gmail.com>
 <Y4pEHlmaT1i3j23J@kernel.org> <CAP-5=fUJ-X4vePcTN7DED4+R5NmqSuaO5Z=a5xLzV9mNbNwK-g@mail.gmail.com>
In-Reply-To: <CAP-5=fUJ-X4vePcTN7DED4+R5NmqSuaO5Z=a5xLzV9mNbNwK-g@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 2 Dec 2022 15:36:24 -0800
Message-ID: <CAM9d7cjNzWzq26+2F1xLV-+qrQ7WwQ-h_TY5_URqT+CymAUs+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf build: Use libtraceevent from the system
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Fri, Dec 2, 2022 at 11:45 AM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Dec 2, 2022 at 10:29 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Fri, Dec 02, 2022 at 10:08:04AM -0800, Namhyung Kim escreveu:
> > > On Wed, Nov 30, 2022 at 12:13 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Wed, Nov 30, 2022 at 11:05 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > On Tue, Nov 29, 2022 at 10:30 PM Ian Rogers <irogers@google.com> wrote:
> > > > > >
> > > > > > Remove the LIBTRACEEVENT_DYNAMIC and LIBTRACEFS_DYNAMIC. If
> > > > > > libtraceevent isn't installed or NO_LIBTRACEEVENT=1 is passed to the
> > > > > > build, don't compile in libtraceevent and libtracefs support. This
> > > > > > also disables CONFIG_TRACE that controls "perf
> > > > > > trace". CONFIG_TRACEEVENT is used to control enablement in
> > > > > > Build/Makefiles, HAVE_LIBTRACEEVENT is used in C code. Without
> > > > > > HAVE_LIBTRACEEVENT tracepoints are disabled and as such the commands
> > > > > > kmem, kwork, lock, sched and timechart are removed. The majority of
> > > > > > commands continue to work including "perf test".
> > > > >
> > > > > Maybe we can have a different approach.  I guess the trace data
> > > > > access is isolated then we can make dummy interfaces when there's
> > > > > no libtraceevent.  This way we don't need to touch every command
> > > > > and let it fail when it's asked.
> > > >
> > > > Sounds like a worthwhile refactor that can land on top of this change.
> > > >
> > > > > The motivation is that we should be able to run the sub-commands
> > > > > as much as possible.  In fact, we could run 'record' part only on the
> > > > > target machine and pass the data to the host for analysis with a
> > > > > full-fledged perf.  Also some commands like 'perf lock contention'
> > > > > can run with or without libtraceevent (using BPF only).
> > > >
> > > > The issue here is that perf lock contention will use evsel__new_tp and
> > > > internally that uses libtraceevent. As such it is removed without
> > > > HAVE_LIBTRACEEVENT. Without the evsel there's not much perf lock
> > > > contention can do, so rather than litter the code with
> > > > HAVE_LIBTRACEEVENT and for it to be broken, I made the choice just to
> > > > remove it from the no libtraceevent build for now.
> > >
> > > I don't think it needs evsel__new_tp() when BPF is used.
> > > The BPF program is attached to the raw tracepoint without
> > > perf_event and the result is written to the BPF map.
> > >
> > > >
> > > > I think it is worth pursuing these patches in the shape they are in so
> > > > that we can land the removal of tools/lib/traceevent and ensure the
> > > > migration away from an out-of-date version of that library.
> > >
> > > Yeah, I agree that we should remove the stale libtraceevent but
> > > I'd like to do it with minimal changes in the perf code base.
> > > Let me take a look at this.
> >
> > Ok, was going to take a look at this patchkit, will wait for you now.
> >
> > - Arnaldo
>
> So the problematic function is:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evsel.c?h=perf/core#n482
> struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
>
> on success it will always initialize:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evsel.c?h=perf/core#n499
> evsel->tp_format = trace_event__tp_format(sys, name);
>
> tp_format is a libtraceevent type so this patch makes the variable
> conditional on HAVE_LIBTRACEEVENT. I think this will remain true even
> with a new evsel__newtp function that isn't dependent on
> libtraceevent. I also think adding such things is best kept out of
> this patch which is trying to do the minimal (only 312 lines of
> addition) to have a build without libtraceevent.
>
> Given we expect builds to use libtraceevent and we should build off of
> this patch, I think we should look to land it for 6.2.

So I took a quick look and it seems not quite easy to isolate
libtraceevent accesses from perf trace, dynamic sort keys and
other places.  That would need some amount of work.

Now I think that we may apply this first and then work on enabling
more functionalities without libtraceevent gradually.

Also I think it'd be a major change for regular users if there's
no libtraceevent installed in their system.  Maybe we could add
a warning during the build?

Thanks,
Namhyung
