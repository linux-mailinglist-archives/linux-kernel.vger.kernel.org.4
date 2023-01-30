Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8857B6811AC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbjA3OPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbjA3OPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:15:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E13BDB8;
        Mon, 30 Jan 2023 06:15:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B79F261047;
        Mon, 30 Jan 2023 14:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E455EC433EF;
        Mon, 30 Jan 2023 14:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675088149;
        bh=1TPEq50BwTQPmWyFZ+PLnU1UmPOhK0Av22uGK6NAEVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTIuQ1Ob+B8K1/QzmPWSTUBK/9sEIJKaYsBabVNdrmJL3013Nlc0WBlOnplfAynCK
         H+HcTHukJ8ndyNC80dpSmUzOGA5AUhkYv2CXHazlphU6M/7KYxNy8rkiCHSopP4YzJ
         nw4qqrTEJO6PFWVHMuohQhaMio7E9avhj/rnOXA1nc5Y5AuN62WXvo5RkTemVE4LbJ
         QCzQ8ew/311vXYIqMEeyICfc7YG8gKMXAXE0I5/VgDw54DZQNZhbIAyK2uRP+Sg1lf
         xFbFSH8SaBwXKtmxXgj2uuVhDJF36bwN4eeN9+QoNq4dDwxA9DhW0yEd0RwIidGL2G
         rEXXn93ZjY3PA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C6865405BE; Mon, 30 Jan 2023 11:15:45 -0300 (-03)
Date:   Mon, 30 Jan 2023 11:15:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v1)
Message-ID: <Y9fREY3BxROqYYBO@kernel.org>
References: <20230127001951.3432374-1-namhyung@kernel.org>
 <bda606c2-2b1b-de9f-1386-8ee2bf925b4b@intel.com>
 <CAM9d7cg_7LNKrXtBuo2QUR1Voi9NKM98qYLC+pznMf4-5yo4Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg_7LNKrXtBuo2QUR1Voi9NKM98qYLC+pznMf4-5yo4Dg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 27, 2023 at 02:54:36PM -0800, Namhyung Kim escreveu:
> Hi Adrian,
> 
> On Thu, Jan 26, 2023 at 11:22 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 27/01/23 02:19, Namhyung Kim wrote:
> > > Hello,
> > >
> > > I found some problems in Intel-PT and auxtrace in general with pipe.
> > > In the past it used to work with pipe, but recent code fails.
> >
> > Pipe mode is a problem for Intel PT and possibly other auxtrace users.
> > Essentially the auxtrace buffers do not behave like the regular perf
> > event buffers.  That is because the head and tail are updated by
> > software, but in the auxtrace case the data is written by hardware.
> > So the head and tail do not get updated as data is written.  In the
> > Intel PT case, the head and tail are updated only when the trace is
> > disabled by software, for example:
> >     - full-trace, system wide : when buffer passes watermark
> >     - full-trace, not system-wide : when buffer passes watermark or
> >     context switches
> >     - snapshot mode : as above but also when a snapshot is made
> >     - sample mode : as above but also when a sample is made
> >
> > That means finished-round ordering doesn't work.  An auxtrace buffer
> > can turn up that has data that extends back in time, possibly to the
> > very beginning of tracing.
> 
> Ok, IIUC we want to process the main buffer and auxtrace buffer
> together in time order but there's no guarantee to get the auxtrace
> data in time, right?
> 
> I wonder if it's possible to use 2 pass processing for pipe mode.
> We may keep the events in the ordered queue and auxtrace queue
> in the first pass, and process together from the beginning in the
> second pass. But I guess the data size would be a problem.
> 
> Or, assuming that the auxtrace buffer comes later than (or equal to)
> the main buffer, we may start processing the main buffer as soon as
> every auxtrace queue gets some data.  Thoughts?
> 
> >
> > For a perf.data file, that problem is solved by going through the trace
> > and queuing up the auxtrace buffers in advance.
> >
> > For pipe mode, the order of events and timestamps can presumably
> > be messed up.
> >
> > For Intel PT, it is a bit of a surprise that there is not
> > validation to error out in pipe mode.
> 
> What kind of validation do you have in mind?  Checking pid/tid?
> 
> >
> > At the least, a warning is needed, and the above explanation needs
> > to be added to the documentation.
> 
> Thanks, I'll add it to the documentation.

Ok, so I'll wait for v2 of this patch series, Adrian, apart from what
you mentioned, are you ok with the patches, or a subset of them? The
first ones looks ok, right?

- Arnaldo
 
> How about showing something like this for pipe mode?
> 
>   WARNING: Intel-PT with pipe mode may not work correctly.
> 
> Thanks,
> Namhyung
> 
> 
> >
> > >                                                                As it
> > > also touches the generic code, other auxtrace users like ARM SPE will
> > > be affected too.  I added a test case to verify it works with pipes.
> > >
> > > At last, I can run this command without a problem.
> > >
> > >   $ perf record -o- -e intel_pt// true | perf inject -b | perf report -i- --itrace=i1000
> > >
> > > The code is available at 'perf/auxtrace-pipe-v1' branch in
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > >
> > > Thanks,
> > > Namhyung
> > >
> > > Namhyung Kim (4):
> > >   perf inject: Use perf_data__read() for auxtrace
> > >   perf intel-pt: Do not try to queue auxtrace data on pipe
> > >   perf session: Avoid calling lseek(2) for pipe
> > >   perf test: Add pipe mode test to the Intel PT test suite
> > >
> > >  tools/perf/builtin-inject.c             |  6 +++---
> > >  tools/perf/tests/shell/test_intel_pt.sh | 17 +++++++++++++++++
> > >  tools/perf/util/auxtrace.c              |  3 +++
> > >  tools/perf/util/session.c               |  9 +++++++--
> > >  4 files changed, 30 insertions(+), 5 deletions(-)
> > >
> > >
> > > base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
> > > prerequisite-patch-id: 4ccdf9c974a3909075051f4ffe498faecab7567b
> >

-- 

- Arnaldo
