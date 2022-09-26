Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D974E5EA89E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiIZOjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiIZOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2EF40;
        Mon, 26 Sep 2022 05:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70DD060CF1;
        Mon, 26 Sep 2022 12:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B02C433D7;
        Mon, 26 Sep 2022 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664197171;
        bh=0u/qbW2hLR7DVa/4gbQr3gEGIsyeCeSemlVqVEFdBLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZ/sPMcgE2WDB7LY/xOkBVGsCB6PyKRNsMrimkz8ueHOncYThSIQPBZ6LpKwZog6h
         3fUR3O3yYvQsbohPEDDprtotHbdzaNyIF2VH4TXYRUa8YCAFV9C8NMmO4O1uBM9gRq
         zS5AFiX2Ly5BJbX2Hw8LfpB7Lp7M35YbWAcuf2dCfrX6WoYcD7KAnruyPpoadvZu7H
         dNwcJW6Z9fXHCasmjLddQ5Vi3+qSOF0mvvNUhoGJHFq34uG/EplJLuKIflKt43/xXG
         JrP4AQ5kgeWDB486p36qpfqinZrJeRi/+kdH6UINUcNEYZmuZjGyd1Lzowm0A02iMz
         Kd5OCxU8KbKKA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4C46A403B0; Mon, 26 Sep 2022 13:59:29 +0100 (IST)
Date:   Mon, 26 Sep 2022 13:59:29 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf record: Fix segmentation fault in
 record__read_lost_samples()
Message-ID: <YzGiMdIRRE8ibCiD@kernel.org>
References: <20220924113346.1110909-1-leo.yan@linaro.org>
 <CAM9d7ci2RJOTz08eGRgLMVpS0TmwN=q=UNA_Z3wbSHCC2pMygQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci2RJOTz08eGRgLMVpS0TmwN=q=UNA_Z3wbSHCC2pMygQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 24, 2022 at 09:52:09AM -0700, Namhyung Kim escreveu:
> Hi Leo,
> 
> On Sat, Sep 24, 2022 at 4:34 AM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Commit a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
> > causes segmentation fault when run the "perf mem record" command in
> > unprivileged mode, the output log is:
> >
> >   $ ./perf mem record --all-user -o perf_test.data -- ./test_program
> >   Error:
> >   Access to performance monitoring and observability operations is limited.
> >   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> >   access to performance monitoring and observability operations for processes
> >   without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> >   More information can be found at 'Perf events and tool security' document:
> >   https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> >   perf_event_paranoid setting is 4:
> >     -1: Allow use of (almost) all events by all users
> >         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >   >= 0: Disallow raw and ftrace function tracepoint access
> >   >= 1: Disallow CPU event access
> >   >= 2: Disallow kernel profiling
> >   To make the adjusted perf_event_paranoid setting permanent preserve it
> >   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> >   perf: Segmentation fault
> >   Obtained 16 stack frames.
> >   ./perf(dump_stack+0x31) [0x55b7aa1e8070]
> >   ./perf(sighandler_dump_stack+0x36) [0x55b7aa1e815e]
> >   ./perf(+0xc9120) [0x55b7aa0a9120]
> >   /lib/x86_64-linux-gnu/libc.so.6(+0x4251f) [0x7fd03ef8151f]
> >   ./perf(+0xccaca) [0x55b7aa0acaca]
> >   ./perf(+0xcf4ab) [0x55b7aa0af4ab]
> >   ./perf(cmd_record+0xd50) [0x55b7aa0b28df]
> >   ./perf(+0x112f77) [0x55b7aa0f2f77]
> >   ./perf(cmd_mem+0x53b) [0x55b7aa0f406c]
> >   ./perf(+0x19979c) [0x55b7aa17979c]
> >   ./perf(+0x199a37) [0x55b7aa179a37]
> >   ./perf(+0x199b95) [0x55b7aa179b95]
> >   ./perf(main+0x2c7) [0x55b7aa179fbd]
> >   /lib/x86_64-linux-gnu/libc.so.6(+0x29d8f) [0x7fd03ef68d8f]
> >   /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x7f) [0x7fd03ef68e3f]
> >   ./perf(_start+0x24) [0x55b7aa089974]
> >   Segmentation fault (core dumped)
> >
> > In the unprivileged mode perf fails to open PMU event, the function
> > record__open() returns error and "session->evlist" is NULL; this leads
> > to segmentation fault when iterates "session->evlist" in the function
> > record__read_lost_samples().
> >
> > This patch checks "session->evlist" in record__read_lost_samples(), if
> > "session->evlist" is NULL then the function directly bails out to avoid
> > segmentation fault.
> >
> > Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Thanks for the fix and sorry for the inconvenience.
> Actually I sent the same fix a few weeks ago.
> 
> https://lore.kernel.org/r/20220909235024.278281-1-namhyung@kernel.org

collecting it now, and adding that Fixes from Leo's patch, ok?

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/builtin-record.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 02e38f50a138..012b46dd4999 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1888,6 +1888,10 @@ static void record__read_lost_samples(struct record *rec)
> >         struct perf_record_lost_samples *lost;
> >         struct evsel *evsel;
> >
> > +       /* No any event is opened, directly bail out */
> > +       if (!session->evlist)
> > +               return;
> > +
> >         lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> >         if (lost == NULL) {
> >                 pr_debug("Memory allocation failed\n");
> > --
> > 2.34.1
> >

-- 

- Arnaldo
