Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71253713989
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjE1NT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1NT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 09:19:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAB0B2;
        Sun, 28 May 2023 06:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8F6160FC5;
        Sun, 28 May 2023 13:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB901C433D2;
        Sun, 28 May 2023 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685279964;
        bh=SYztQZUYixZlZrxgpJOdXKy6B3XNpotZJslGGMY1kgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzPxMxjbds0l5fk1N8m0h5r2N0mFfwZgtgAaLe7Z+Ox1zg2n2/AvUkVfL/FiUnt/o
         klGd5g0wFasLRc/Ek2uSoRhwf1pfhHUBLj/EhAspVovIhu5I+xPekxku7F/ljUXvfo
         pGSf8sYid/RnCa22lS5nd/h0qUQDCr8pAtM40jt7IzFO/PbBlb+vEqK//Ajpvoy1xQ
         34+0IHLdMSATuS5QCwaUX2/6k2U2Bh5rAEAzx22RNXJ89016Vw1ilOGNheDmXSWvIn
         yHxgy7RGmhpEfr5yf7dU/WflZBLyZGBYRlCyjadFUFBdAsIR206YuF4uBaGhrnn/fU
         8naDlk1A/TIcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6BB59403B5; Sun, 28 May 2023 10:19:21 -0300 (-03)
Date:   Sun, 28 May 2023 10:19:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Changbin Du <changbin.du@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Fixes from evsel__group_pmu_name asan error
Message-ID: <ZHNU2ULCyO/H6uWA@kernel.org>
References: <20230526194442.2355872-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526194442.2355872-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 26, 2023 at 12:44:40PM -0700, Ian Rogers escreveu:
> evsel__group_pmu_name triggered an asan error as a list_head was cast
> to an evsel, when it was the head, and the accessed as if it were a
> full evsel. Further investigation showed problematic list iteration
> for evsel__group_pmu_name whilst the list was being sorted so switch
> to pre-computation.
> 
> v3: Rebase on perf-tools-next (branch getting ready for 6.5) rather
>     than perf-tools (fixes for 6.4).
> v2: Address review comments/feedback from Adrian Hunter
>     <adrian.hunter@intel.com>.

Thanks, applied.

- Arnaldo

 
> Ian Rogers (2):
>   perf evsel: evsel__group_pmu_name fixes
>   perf evsel: for_each_group fixes
> 
>  tools/perf/util/evsel.c         | 31 ++++-----------
>  tools/perf/util/evsel.h         | 26 +++++++-----
>  tools/perf/util/evsel_fprintf.c |  1 +
>  tools/perf/util/parse-events.c  | 70 +++++++++++++++++++++++++++------
>  4 files changed, 84 insertions(+), 44 deletions(-)
> 
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 

-- 

- Arnaldo
