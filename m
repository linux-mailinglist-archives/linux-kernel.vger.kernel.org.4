Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0335F12D4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiI3TjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiI3TjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:39:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8B0166F3E;
        Fri, 30 Sep 2022 12:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4DC1624A3;
        Fri, 30 Sep 2022 19:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0976CC433C1;
        Fri, 30 Sep 2022 19:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664566754;
        bh=Fgx0odHsttSVunY7BVuF+r/nkvjLJG+HV6qs7cmohgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uhs0ereM/NblJqaBDw0the/mDnyUEQ9gAMWWEcfg3MKFV5/WSRVJafjkWKagvGgqf
         1qpKsqUF4Vh8/4KFROVG82P/feOfb0+cOskoMrwcw9As+VG77MrtGLid7qTBZo2DPP
         wTTAO5MjvDcV6+m8wGPhfA6vDvNh+UndYMtp4qOTab1MXLc9CePAGXvms+H7inAeNJ
         L1JK9EX0ktVVZDSRrusVsBAKm/VBcc53pKraKkPPf27v2eluJx/3Zr9anjYenRZfyo
         tyLBTbhkJJVxakqG1xTe4iAkEUbh1NTAA5UMpdSF8hxFWEsm/ZlFU3SeXm2VQ4xMOj
         YTe4PgJSNwWNQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 542624062C; Fri, 30 Sep 2022 16:39:10 -0300 (-03)
Date:   Fri, 30 Sep 2022 16:39:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 0/5] perf tools: Clean up cpu map handling for
 system-wide evsel (v2)
Message-ID: <YzdF3qfSmQM2Wu+7@kernel.org>
References: <20220930172714.711616-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930172714.711616-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 30, 2022 at 10:27:09AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> The system-wide evsel has a cpu map for all (online) cpus regardless
> of user requested cpus.  But the cpu map handling code has some
> special case for it and I think we can cleanup the code by making sure
> that such a evsel has a proper cpu/thread maps from the beginning.
> This patches should not cause any change in the behavior.
> 
> Changes from v1:
>  * use evlist->core.needs_map_propagation field
>  * add Reviewed-by from Adrian

Thanks, replaced v1 with this.

Adrian, please check if I can add the Reviewed-by to the ones without
it.

- Arnaldo
 
> You can get the code from 'perf/cpumap-update-v2' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> Namhyung Kim (5):
>   libperf: Populate system-wide evsel maps
>   libperf: Propagate maps only if necessary
>   perf tools: Get rid of evlist__add_on_all_cpus()
>   perf tools: Add evlist__add_sched_switch()
>   perf tools: Remove special handling of system-wide evsel
> 
>  tools/lib/perf/evlist.c                  | 23 ++++++------
>  tools/lib/perf/evsel.c                   |  3 --
>  tools/lib/perf/include/internal/evlist.h |  1 +
>  tools/perf/arch/x86/util/intel-pt.c      | 15 +++-----
>  tools/perf/builtin-script.c              |  3 --
>  tools/perf/tests/switch-tracking.c       | 15 +++-----
>  tools/perf/util/evlist.c                 | 46 ++++++++++--------------
>  tools/perf/util/evlist.h                 |  1 +
>  tools/perf/util/evsel.c                  | 12 ++-----
>  tools/perf/util/stat.c                   |  3 --
>  10 files changed, 46 insertions(+), 76 deletions(-)
> 
> 
> base-commit: 62e64c9d2fd12839c02f1b3e8b873e7cb34e8720
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog

-- 

- Arnaldo
