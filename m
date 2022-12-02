Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A568B640CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiLBSIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiLBSIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:08:19 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FC0AE4C9;
        Fri,  2 Dec 2022 10:08:18 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id bg10so4104311wmb.1;
        Fri, 02 Dec 2022 10:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6dfUvFTdecR6lpJZTGznj4d2U4D5huECioJ15GqkJU=;
        b=iLeOESUjKvp/k8U1Q/+UxunW10X0D8M07H4RfL3PQ+T+92gBIFuiytROZpPEREwbeu
         lMUr4Mbl2gak2fVeD82NIhd3lqjdwBpTJdiPdIcHTKH5VzGiv1OjU+BxFx4KEi3yaR+S
         odbZW5rngkUcJ+z/CIB6aKJXD8Ics/iiKN7AHR2JopvQQ+yOwLJtiBHHu/p504JJ95qi
         qx/ewy1AvSrdemS4mR06+KU9Ym16JALnaJulLU5tsfpwBoGnytNdotbEskB9PfIe80im
         PtpEyrdOA3WOs9HpXat/9J/VXsXOmisK3i67srQRccBlOBjWh/6CKT/wn+xyt2bh4hWN
         zXPw==
X-Gm-Message-State: ANoB5pn8skG9MRGFWagF6IxG7h0x/BlYNpXWL4WINbMD/vDkW0zBMhC1
        oc+eFFgVY7NgJTD/gJpQwt+lLpfaLPg2wmU6MS0=
X-Google-Smtp-Source: AA0mqf6EwIMVFvNbPKMzpw/kja0QP5/Y+SftiuCe2Gtff0YClE1Y0LcHk709e5ihv/09TkbH8CrOPi73CEZp2NjE+M8=
X-Received: by 2002:a05:600c:3586:b0:3cf:a3b0:df6a with SMTP id
 p6-20020a05600c358600b003cfa3b0df6amr55647816wmq.126.1670004496659; Fri, 02
 Dec 2022 10:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20221130062935.2219247-1-irogers@google.com> <20221130062935.2219247-4-irogers@google.com>
 <CAM9d7chrsLHoGe=RcU2e5hRL22j=813j3uuEHDOPZrkpWqnSsw@mail.gmail.com> <CAP-5=fWZVHN5tDG+eKRr7v_RXKYA_uUgY-dFH_g3Yc3mFgkXbA@mail.gmail.com>
In-Reply-To: <CAP-5=fWZVHN5tDG+eKRr7v_RXKYA_uUgY-dFH_g3Yc3mFgkXbA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 2 Dec 2022 10:08:04 -0800
Message-ID: <CAM9d7chsymFFq1di15w+s7jtDenV=kFnk=EDrFO_rDWcSQSa6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf build: Use libtraceevent from the system
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Wed, Nov 30, 2022 at 12:13 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Nov 30, 2022 at 11:05 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Nov 29, 2022 at 10:30 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Remove the LIBTRACEEVENT_DYNAMIC and LIBTRACEFS_DYNAMIC. If
> > > libtraceevent isn't installed or NO_LIBTRACEEVENT=1 is passed to the
> > > build, don't compile in libtraceevent and libtracefs support. This
> > > also disables CONFIG_TRACE that controls "perf
> > > trace". CONFIG_TRACEEVENT is used to control enablement in
> > > Build/Makefiles, HAVE_LIBTRACEEVENT is used in C code. Without
> > > HAVE_LIBTRACEEVENT tracepoints are disabled and as such the commands
> > > kmem, kwork, lock, sched and timechart are removed. The majority of
> > > commands continue to work including "perf test".
> >
> > Maybe we can have a different approach.  I guess the trace data
> > access is isolated then we can make dummy interfaces when there's
> > no libtraceevent.  This way we don't need to touch every command
> > and let it fail when it's asked.
>
> Sounds like a worthwhile refactor that can land on top of this change.
>
> > The motivation is that we should be able to run the sub-commands
> > as much as possible.  In fact, we could run 'record' part only on the
> > target machine and pass the data to the host for analysis with a
> > full-fledged perf.  Also some commands like 'perf lock contention'
> > can run with or without libtraceevent (using BPF only).
>
> The issue here is that perf lock contention will use evsel__new_tp and
> internally that uses libtraceevent. As such it is removed without
> HAVE_LIBTRACEEVENT. Without the evsel there's not much perf lock
> contention can do, so rather than litter the code with
> HAVE_LIBTRACEEVENT and for it to be broken, I made the choice just to
> remove it from the no libtraceevent build for now.

I don't think it needs evsel__new_tp() when BPF is used.
The BPF program is attached to the raw tracepoint without
perf_event and the result is written to the BPF map.

>
> I think it is worth pursuing these patches in the shape they are in so
> that we can land the removal of tools/lib/traceevent and ensure the
> migration away from an out-of-date version of that library.

Yeah, I agree that we should remove the stale libtraceevent but
I'd like to do it with minimal changes in the perf code base.
Let me take a look at this.

Thanks,
Namhyung
