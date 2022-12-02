Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9795640D3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiLBSaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiLBS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:29:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7F2ABA18;
        Fri,  2 Dec 2022 10:29:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47763B82234;
        Fri,  2 Dec 2022 18:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CE4C433C1;
        Fri,  2 Dec 2022 18:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670005792;
        bh=ByGluDAq5qvQsMpkBwn1FLyf2tEkLeHD+EMGMpc6avo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fExtj9E2YcdEia0rp6a/JL/dx3f73PFWV0nbLOTqxqPOeZSPm+YLh8l0rmokFYY5x
         HSbAroYqM+BRgzaTzQvZL9MZ1Gr9VzJLehoBTSFCX7VUH2FgBqWEEiKbo9owLKxO7y
         DnS/1eifgQ1fewq+0qg4Z6IMQxTFjzOkQSGglRPwRgp4zQlJnOMD8MjSe+txW+MBdk
         o8hERTjs9ouegMwqZeQ4EeihchMq5XzXxIqIglqYfC0Ye5DXZXjTTn1f5yOTCxbdYt
         XCovd88iYIQI/XbTeFGGEYFu4gK3xMw9mima5q4q/vCO+140+FkspwtACiMnUY7q0u
         /H4pSKP0uMzRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 341E24034E; Fri,  2 Dec 2022 15:29:50 -0300 (-03)
Date:   Fri, 2 Dec 2022 15:29:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
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
Subject: Re: [PATCH v2 3/4] perf build: Use libtraceevent from the system
Message-ID: <Y4pEHlmaT1i3j23J@kernel.org>
References: <20221130062935.2219247-1-irogers@google.com>
 <20221130062935.2219247-4-irogers@google.com>
 <CAM9d7chrsLHoGe=RcU2e5hRL22j=813j3uuEHDOPZrkpWqnSsw@mail.gmail.com>
 <CAP-5=fWZVHN5tDG+eKRr7v_RXKYA_uUgY-dFH_g3Yc3mFgkXbA@mail.gmail.com>
 <CAM9d7chsymFFq1di15w+s7jtDenV=kFnk=EDrFO_rDWcSQSa6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chsymFFq1di15w+s7jtDenV=kFnk=EDrFO_rDWcSQSa6g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 02, 2022 at 10:08:04AM -0800, Namhyung Kim escreveu:
> On Wed, Nov 30, 2022 at 12:13 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Nov 30, 2022 at 11:05 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Tue, Nov 29, 2022 at 10:30 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > Remove the LIBTRACEEVENT_DYNAMIC and LIBTRACEFS_DYNAMIC. If
> > > > libtraceevent isn't installed or NO_LIBTRACEEVENT=1 is passed to the
> > > > build, don't compile in libtraceevent and libtracefs support. This
> > > > also disables CONFIG_TRACE that controls "perf
> > > > trace". CONFIG_TRACEEVENT is used to control enablement in
> > > > Build/Makefiles, HAVE_LIBTRACEEVENT is used in C code. Without
> > > > HAVE_LIBTRACEEVENT tracepoints are disabled and as such the commands
> > > > kmem, kwork, lock, sched and timechart are removed. The majority of
> > > > commands continue to work including "perf test".
> > >
> > > Maybe we can have a different approach.  I guess the trace data
> > > access is isolated then we can make dummy interfaces when there's
> > > no libtraceevent.  This way we don't need to touch every command
> > > and let it fail when it's asked.
> >
> > Sounds like a worthwhile refactor that can land on top of this change.
> >
> > > The motivation is that we should be able to run the sub-commands
> > > as much as possible.  In fact, we could run 'record' part only on the
> > > target machine and pass the data to the host for analysis with a
> > > full-fledged perf.  Also some commands like 'perf lock contention'
> > > can run with or without libtraceevent (using BPF only).
> >
> > The issue here is that perf lock contention will use evsel__new_tp and
> > internally that uses libtraceevent. As such it is removed without
> > HAVE_LIBTRACEEVENT. Without the evsel there's not much perf lock
> > contention can do, so rather than litter the code with
> > HAVE_LIBTRACEEVENT and for it to be broken, I made the choice just to
> > remove it from the no libtraceevent build for now.
> 
> I don't think it needs evsel__new_tp() when BPF is used.
> The BPF program is attached to the raw tracepoint without
> perf_event and the result is written to the BPF map.
> 
> >
> > I think it is worth pursuing these patches in the shape they are in so
> > that we can land the removal of tools/lib/traceevent and ensure the
> > migration away from an out-of-date version of that library.
> 
> Yeah, I agree that we should remove the stale libtraceevent but
> I'd like to do it with minimal changes in the perf code base.
> Let me take a look at this.

Ok, was going to take a look at this patchkit, will wait for you now.

- Arnaldo
