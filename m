Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9BB5F4969
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJDSsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJDSsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:48:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC276A48A;
        Tue,  4 Oct 2022 11:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1D47B81BB2;
        Tue,  4 Oct 2022 18:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75366C433C1;
        Tue,  4 Oct 2022 18:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664909317;
        bh=z4OQphxZALQAbOjByiz5t3jF8Ed70usTd7TciSFoyTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAAKD9ONA0/x4mpGhOCrqSrIkXNgvjfM0TDwUKtDGzie6kvRUqca4xkTTDHjzs/IC
         F2UvEO+q/1Ts8awHxXHoTiiWN9AMUF1hVI6ZS9YeuaLiK6qKc15BaVcBhxu7oauToP
         bizS1vZhCGojniOZuPYtedrEl9YB5dRD1TquwoR6ZRVIMjNx/ncgTDXRoZbsp9eKgx
         MjZzL5ew6n9igZ41uMqzPXZJaEXCW1hn3vIo/qKGPOq0XJ6YRe7BJiE2Cb0qf9Htmu
         DPWy4LaxVWqxPfY7KcMIQICDX4FkQFPl5x0eQUHD2AcB56QE78BtpOm3ApHSXTmE7/
         PqJywIAx4Z3PQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37E1F4062C; Tue,  4 Oct 2022 15:48:35 -0300 (-03)
Date:   Tue, 4 Oct 2022 15:48:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCHSET 0/7] perf stat: Small random cleanups (v2)
Message-ID: <YzyAA/RaIGoxCbGI@kernel.org>
References: <20220930202110.845199-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930202110.845199-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 30, 2022 at 01:21:03PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> I'm working on perf stat and I found some items to clean up.  This time
> I removed runtime stats for per-thread aggregation mode which we can simply
> use thread map index to compare the shadow stat values in the rt_stat.
> 
> Changes from v1)
>  * renaming missing parts in headers  (James)
>  * add a comment for map_idx  (Ian)
>  * add Reviewed-by from James
> 
> The code is available at 'perf/stat-cleanup-v2' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Applied locally, testing.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (7):
>   perf stat: Convert perf_stat_evsel.res_stats array
>   perf stat: Don't call perf_stat_evsel_id_init() repeatedly
>   perf stat: Rename saved_value->cpu_map_idx
>   perf stat: Use thread map index for shadow stat
>   perf stat: Kill unused per-thread runtime stats
>   perf stat: Don't compare runtime stat for shadow stats
>   perf stat: Rename to aggr_cpu_id.thread_idx
> 
>  tools/perf/builtin-stat.c      |  54 ------
>  tools/perf/tests/topology.c    |  10 +-
>  tools/perf/util/cpumap.c       |   8 +-
>  tools/perf/util/cpumap.h       |   2 +-
>  tools/perf/util/stat-display.c |  32 ++--
>  tools/perf/util/stat-shadow.c  | 320 ++++++++++++++++-----------------
>  tools/perf/util/stat.c         |  20 +--
>  tools/perf/util/stat.h         |  10 +-
>  8 files changed, 189 insertions(+), 267 deletions(-)
> 
> 
> base-commit: 62e64c9d2fd12839c02f1b3e8b873e7cb34e8720
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog

-- 

- Arnaldo
