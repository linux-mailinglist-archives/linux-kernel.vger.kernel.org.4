Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3E5EB13A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIZTY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIZTY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:24:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2DF3A16D;
        Mon, 26 Sep 2022 12:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECF56B80C75;
        Mon, 26 Sep 2022 19:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FB0C433D6;
        Mon, 26 Sep 2022 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664220292;
        bh=KGe/GdLiOyJuVfNEKfybS6bLyBJmzPyi8wQtB65+SAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvyKo7rv5awsxlVfri8Z8FJxHXZTJWE1eTX9SY4sJG8o0zVQMMwMHlHvAHFWL/KYc
         esHUzpqs0BHh6YzWVPqXc1zul4RsGSd91wPPoOqiHm0FnLG+H+bbOHV83hykoIN1V5
         7C5GaX7vZ2s3cZWTWlXk86jKrjoPUHWiECibhI8Qw/WEsJk64M6CqlTLHm3YoOXTov
         CoYnnu/ihI2/QM4kBTPAVIeApAWVXN6+rjkyhH63b0cA/SQvyZueNm2lPBzkcrTw1P
         +tZ3PFMzQfbPIqSDF97s7E9mrBRFBhnxskaODSqZeeQ/j0oDGAWkc/99O41c0pMwrx
         iwYpgkvg14Wjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2329C403B0; Mon, 26 Sep 2022 20:24:50 +0100 (IST)
Date:   Mon, 26 Sep 2022 20:24:50 +0100
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
Subject: Re: [PATCH 0/5] perf tools: Clean up cpu map handling for a
 system-wide evsel (v1)
Message-ID: <YzH8gkVo3wNwGZbu@kernel.org>
References: <20220924165737.956428-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924165737.956428-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 24, 2022 at 09:57:32AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> The system-wide evsel has a cpu map for all (online) cpus regardless
> of user requested cpus.  But the cpu map handling code has some
> special case for it and I think we can cleanup the code by making sure
> that such a evsel has a proper cpu/thread maps from the beginning.
> This patches should not cause any change in the behavior.
> 
> You can get the code from 'perf/cpumap-update-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>   
> Thanks,
> Namhyung

Looks sane, applied locally for testing.

- Arnaldo
 
> 
> Namhyung Kim (5):
>   libperf: Populate system-wide evsel maps
>   libperf: Propagate maps only if necessary
>   perf tools: Get rid of evlist__add_on_all_cpus()
>   perf tools: Add evlist__add_sched_switch()
>   perf tools: Remove special handling of system-wide evsel
> 
>  tools/lib/perf/evlist.c             | 23 ++++++++-------
>  tools/lib/perf/evsel.c              |  3 --
>  tools/perf/arch/x86/util/intel-pt.c | 15 ++++------
>  tools/perf/builtin-script.c         |  3 --
>  tools/perf/tests/switch-tracking.c  | 15 ++++------
>  tools/perf/util/evlist.c            | 46 ++++++++++++-----------------
>  tools/perf/util/evlist.h            |  1 +
>  tools/perf/util/evsel.c             | 12 ++------
>  tools/perf/util/stat.c              |  3 --
>  9 files changed, 44 insertions(+), 77 deletions(-)
> 
> -- 
> 2.37.3.998.g577e59143f-goog

-- 

- Arnaldo
