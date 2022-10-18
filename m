Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8F603777
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 03:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiJSBTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 21:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJSBTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:19:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157ED12AFA;
        Tue, 18 Oct 2022 18:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66B00B821C4;
        Wed, 19 Oct 2022 01:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAE5C433B5;
        Wed, 19 Oct 2022 01:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666142370;
        bh=7a5CqPfRhLttK49+bhMSj+r+3pzVAxclnnGr46/f5iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsKnivlB+7709WkN48FxPBVCKHeYiurdffEu+MwQ2VPg4GeVP7F+gSblJXPSL33ib
         LQOq7JiKwkThGFhZj5zpBx1tQA1me5n31UyrxVg+YVeSe/YuUybw/g4F12KCH/FcHi
         1kE248A4IguKXw5WNmHoiKa0ozC4c1PnjdelCG5bkITEn8HyICtohaHAiUNW/6KJnp
         ktnTntr/GAyGRNMQZd3Ib6cdC74yUCJXXpQ7d02PyLUtlnBT9ZKIKXqU6FH/boOdCY
         LEoRqAhBkFAvz2YGH0mfBDsSlbxNY7XWh/rUalBQg46FgH2Cg9wF/MEsDjgG4WfICj
         RIoHfbYnlBP2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7380740B65; Tue, 18 Oct 2022 16:20:38 -0300 (-03)
Date:   Tue, 18 Oct 2022 16:20:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 0/2] perf: Fix "kernel lock contention analysis" test
 by not printing warnings in quiet mode
Message-ID: <Y078hmAhP0oZivYc@kernel.org>
References: <20221018094137.783081-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018094137.783081-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 18, 2022 at 10:41:34AM +0100, James Clark escreveu:
> This is V2, but the previous patch was titled 'perf: Fix "Track with
> sched_switch" test by not printing warnings in quiet mode'
> 
> Changes since V1:
> 
>   * Add a commit to make the behavior consistent between tools and
>     update the docs
>   * Fix the incorrect test name in the commit message

Namhyung, can I have your Acked-by, even you having some reservation
about this? You said that if this was the way forward, then
documentation should reflect that, which James did, so, wdyt?

- Arnaldo
 
> James Clark (2):
>   perf: Fix "kernel lock contention analysis" test by not printing
>     warnings in quiet mode
>   perf: Make quiet mode consistent between tools
> 
>  tools/perf/Documentation/perf-annotate.txt | 2 +-
>  tools/perf/Documentation/perf-diff.txt     | 2 +-
>  tools/perf/Documentation/perf-lock.txt     | 2 +-
>  tools/perf/Documentation/perf-probe.txt    | 2 +-
>  tools/perf/Documentation/perf-record.txt   | 2 +-
>  tools/perf/Documentation/perf-report.txt   | 2 +-
>  tools/perf/Documentation/perf-stat.txt     | 4 ++--
>  tools/perf/bench/numa.c                    | 9 +++++----
>  tools/perf/builtin-annotate.c              | 2 +-
>  tools/perf/builtin-diff.c                  | 2 +-
>  tools/perf/builtin-lock.c                  | 2 +-
>  tools/perf/builtin-probe.c                 | 7 +++----
>  tools/perf/builtin-record.c                | 2 +-
>  tools/perf/builtin-report.c                | 2 +-
>  tools/perf/builtin-stat.c                  | 8 ++++----
>  tools/perf/ui/util.c                       | 5 +++++
>  tools/perf/util/stat.h                     | 1 -
>  17 files changed, 30 insertions(+), 26 deletions(-)
> 
> -- 
> 2.28.0

-- 

- Arnaldo
