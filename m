Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3537667F186
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjA0Wzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjA0Wzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:55:31 -0500
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF68B075;
        Fri, 27 Jan 2023 14:55:02 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id e204so2496225iof.1;
        Fri, 27 Jan 2023 14:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYF/yXTRINjRoA9CarrAExdf6+EpqrCOoU1zTz5/EqA=;
        b=PasfAHlV6CaqHDOp3wGkUpNGHecaCrLyrwlsA62WiaJK+asQLoarQLCsefeUBTnFK/
         6RuOtYVBMpFB+FRm52jWMdq/seSEZ5SXfbRoP04LMZIqPwMjhbtCx3zUR55yEzOwBUUx
         E4X8DQP6MY+pvtLw5frOzARcdElbH+WzkFV6y7xEpscAX4y0hwuPNBXAvadVVPw1b27X
         NCENLj+2LRAiIp+QHOEeYpZ9jVDz63aSrhw7537lDCnl47IMa6KDh4p/s9hUGymjFQ4L
         1yVHnyunMsNO33Dha9gun/D+6tKqGtiuDvVxEAzjBxkcS/DEkLYb6nMzi7RKX4XwpB8z
         oA7A==
X-Gm-Message-State: AFqh2kq4x3laorEeFT+i7ufEpFQICPBVao8iW7xTuf/28evTjOqM/mTc
        uAWNvrwP8lR3v1S3S/3gBHInhj8zlCApV0Rehq17Toa6
X-Google-Smtp-Source: AMrXdXtaKWbOEfc5hzWTJDhNksyqdJuTXYE+DJ+OBagKo+g/+vNdUaXpyMjpAGd/ZTFuY72pTeSOBOjsWWv7ndqDlOY=
X-Received: by 2002:a05:6638:4916:b0:375:c16b:7776 with SMTP id
 cx22-20020a056638491600b00375c16b7776mr4787211jab.54.1674860087574; Fri, 27
 Jan 2023 14:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20230127001951.3432374-1-namhyung@kernel.org> <bda606c2-2b1b-de9f-1386-8ee2bf925b4b@intel.com>
In-Reply-To: <bda606c2-2b1b-de9f-1386-8ee2bf925b4b@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 27 Jan 2023 14:54:36 -0800
Message-ID: <CAM9d7cg_7LNKrXtBuo2QUR1Voi9NKM98qYLC+pznMf4-5yo4Dg@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v1)
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, Jan 26, 2023 at 11:22 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 27/01/23 02:19, Namhyung Kim wrote:
> > Hello,
> >
> > I found some problems in Intel-PT and auxtrace in general with pipe.
> > In the past it used to work with pipe, but recent code fails.
>
> Pipe mode is a problem for Intel PT and possibly other auxtrace users.
> Essentially the auxtrace buffers do not behave like the regular perf
> event buffers.  That is because the head and tail are updated by
> software, but in the auxtrace case the data is written by hardware.
> So the head and tail do not get updated as data is written.  In the
> Intel PT case, the head and tail are updated only when the trace is
> disabled by software, for example:
>     - full-trace, system wide : when buffer passes watermark
>     - full-trace, not system-wide : when buffer passes watermark or
>     context switches
>     - snapshot mode : as above but also when a snapshot is made
>     - sample mode : as above but also when a sample is made
>
> That means finished-round ordering doesn't work.  An auxtrace buffer
> can turn up that has data that extends back in time, possibly to the
> very beginning of tracing.

Ok, IIUC we want to process the main buffer and auxtrace buffer
together in time order but there's no guarantee to get the auxtrace
data in time, right?

I wonder if it's possible to use 2 pass processing for pipe mode.
We may keep the events in the ordered queue and auxtrace queue
in the first pass, and process together from the beginning in the
second pass. But I guess the data size would be a problem.

Or, assuming that the auxtrace buffer comes later than (or equal to)
the main buffer, we may start processing the main buffer as soon as
every auxtrace queue gets some data.  Thoughts?

>
> For a perf.data file, that problem is solved by going through the trace
> and queuing up the auxtrace buffers in advance.
>
> For pipe mode, the order of events and timestamps can presumably
> be messed up.
>
> For Intel PT, it is a bit of a surprise that there is not
> validation to error out in pipe mode.

What kind of validation do you have in mind?  Checking pid/tid?

>
> At the least, a warning is needed, and the above explanation needs
> to be added to the documentation.

Thanks, I'll add it to the documentation.

How about showing something like this for pipe mode?

  WARNING: Intel-PT with pipe mode may not work correctly.

Thanks,
Namhyung


>
> >                                                                As it
> > also touches the generic code, other auxtrace users like ARM SPE will
> > be affected too.  I added a test case to verify it works with pipes.
> >
> > At last, I can run this command without a problem.
> >
> >   $ perf record -o- -e intel_pt// true | perf inject -b | perf report -i- --itrace=i1000
> >
> > The code is available at 'perf/auxtrace-pipe-v1' branch in
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> >
> > Thanks,
> > Namhyung
> >
> > Namhyung Kim (4):
> >   perf inject: Use perf_data__read() for auxtrace
> >   perf intel-pt: Do not try to queue auxtrace data on pipe
> >   perf session: Avoid calling lseek(2) for pipe
> >   perf test: Add pipe mode test to the Intel PT test suite
> >
> >  tools/perf/builtin-inject.c             |  6 +++---
> >  tools/perf/tests/shell/test_intel_pt.sh | 17 +++++++++++++++++
> >  tools/perf/util/auxtrace.c              |  3 +++
> >  tools/perf/util/session.c               |  9 +++++++--
> >  4 files changed, 30 insertions(+), 5 deletions(-)
> >
> >
> > base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
> > prerequisite-patch-id: 4ccdf9c974a3909075051f4ffe498faecab7567b
>
