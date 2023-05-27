Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51917131C4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbjE0Bs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjE0Bsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:48:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D5114;
        Fri, 26 May 2023 18:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6F2161032;
        Sat, 27 May 2023 01:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181FEC433D2;
        Sat, 27 May 2023 01:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685152133;
        bh=4mmYOZvNxvMfe1IUufij5Lxc6zDSw4qsl3m4tlE5ekc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9vBh/ULEZy1gUw5IVHbetfP2uNUTMt6WwztNmEwPdbDzeAhiykNErou+fOo0jymS
         ygkNNILUhxPWXIjEGH8B6vYDhP1UkRxPghCppxFS12KRDbjhn1OZ+TsNd9tgpVp6bE
         di6CsMBtf82C/JMwVR7rBAyosrsPWvs3eZBkkX3sbe6F2UhMp3rhYoWmGstase/Sl0
         6ao/GVhWc+oMWMqmxsUseEdFsTdmd2Yrcx7GKd7YUEK6BtPrFMtJV20dFdcYUBGCK7
         saqfyd2G931ZZ4nNNAv2hLHg8uiMMTH2fl1DBL7DGe5uHeUMPp2IRvMwcRxmkd5+lJ
         +wQkzwA0tKwUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6798403B5; Fri, 26 May 2023 22:48:50 -0300 (-03)
Date:   Fri, 26 May 2023 22:48:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Fix perf stat JSON output test
Message-ID: <ZHFhghGjBRPH3UpB@kernel.org>
References: <20230524210600.3095830-1-namhyung@kernel.org>
 <d06cac04-00b5-651d-14af-378fc25f37c4@amd.com>
 <CAP-5=fVMR0Y1=_W2scQBg_uWceOHrHaZ2GMwOai4Veq7OaGJ4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVMR0Y1=_W2scQBg_uWceOHrHaZ2GMwOai4Veq7OaGJ4A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 26, 2023 at 03:41:29PM -0700, Ian Rogers escreveu:
> On Wed, May 24, 2023 at 8:01 PM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >
> > Hello Namhyung,
> >
> > On 5/25/2023 2:36 AM, Namhyung Kim wrote:
> > > The recent --per-cache option test caused a problem.  According to
> > > the option name, I think it should check args.per_cache instead of
> > > args.per_cache_instance.
> > >
> > >   $ sudo ./perf test -v 99
> > >    99: perf stat JSON output linter                                    :
> > >   --- start ---
> > >   test child forked, pid 3086101
> > >   Checking json output: no args [Success]
> > >   Checking json output: system wide [Success]
> > >   Checking json output: interval [Success]
> > >   Checking json output: event [Success]
> > >   Checking json output: per thread [Success]
> > >   Checking json output: per node [Success]
> > >   Checking json output: system wide no aggregation [Success]
> > >   Checking json output: per core [Success]
> > >   Checking json output: per cache_instance Test failed for input:
> > >   ...
> > >   Traceback (most recent call last):
> > >     File "linux/tools/perf/tests/shell/lib/perf_json_output_lint.py", line 88, in <module>
> > >       elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cache_instance:
> > >   AttributeError: 'Namespace' object has no attribute 'per_cache_instance'
> > >   test child finished with -1
> > >   ---- end ----
> > >   perf stat JSON output linter: FAILED!
> > >
> > > Fixes: bfce728db317 ("pert tests: Add tests for new "perf stat --per-cache" aggregation option")
> >
> > Another oversight on my part. Thank you for fixing this :)
> >
> >    $ sudo perf test -v 99
> >    99: perf stat JSON output linter                                    :
> >    --- start ---
> >    test child forked, pid 25046
> >    Checking json output: no args [Success]
> >    Checking json output: system wide [Success]
> >    Checking json output: interval [Success]
> >    Checking json output: event [Success]
> >    Checking json output: per thread [Success]
> >    Checking json output: per node [Success]
> >    Checking json output: system wide no aggregation [Success]
> >    Checking json output: per core [Success]
> >    Checking json output: per cache_instance [Success]
> >    Checking json output: per die [Success]
> >    Checking json output: per socket [Success]
> >    test child finished with 0
> >    ---- end ----
> >    perf stat JSON output linter: Ok
> >
> > Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Thanks Namhyung and Prateek, Arnaldo could we get this in
> perf-tools-next so that the failing test goes away?
> 
> Acked-by: Ian Rogers <irogers@google.com>

Applied and pushed to perf-tools-next, please continue from there.

⬢[acme@toolbox perf-tools-next]$ git log --oneline -10
540c910c65a94fb4 (HEAD -> perf-tools-next) perf test: Fix perf stat JSON output test
5cebb33fd929dc67 perf tests: Organize cpu_map tests into a single suite
237d41d4a2d7d45e perf cpumap: Add intersect function
6ac2230b55d392e6 perf vendor events intel: Add metricgroup descriptions for all models
66c6e0c100277175 perf jevents: Add support for metricgroup descriptions
bfce728db3179042 pert tests: Add tests for new "perf stat --per-cache" aggregation option
aab667ca8837e45f perf stat: Add "--per-cache" aggregation option and document it
4b87406a3b590888 perf stat record: Save cache level information
995ed074b829f293 perf stat: Setup the foundation to allow aggregation based on cache topology
2b72cec9eef19d73 perf: Extract building cache level for a CPU into separate function
⬢[acme@toolbox perf-tools-next]$

- Arnaldo
