Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7BA708115
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjERMVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjERMVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:21:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA6E45;
        Thu, 18 May 2023 05:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69AB564EF6;
        Thu, 18 May 2023 12:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D269C433D2;
        Thu, 18 May 2023 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684412458;
        bh=KKZPRS0xF/hTezYiAJ0wumZlpCMawfGzOrHjOXNCBJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKjx41j5hDow9bRVd1XazgfMgWUlbhIHTeCEhth74fQSD1cNpTFMqjGMZHDmXSH+d
         etvyfXe+ocWbOK+uSMbZsw1w/Zs5OLd1XdE8qeqTRHUZhEejPP1RzNkEqJtv2bsWiw
         Tidbqp+IeSOoLmMRjCfABLqyXBrYNJnsiQRLMZ1ePoATQoXRzUW0+2LD4faOieCzCB
         qhVE7XISDh0yRmDKrkupOkq2kD8R556unNdYhHdR7AcSQHA+49WXBc8TWHcFWP1O9D
         wcz4/Bi9XvaL6drjQFc7sCFnF5j9FVD6sV1RXZ9EiDvzm4RzPYxMxAWgZr4NhCyAB3
         PBM28N9u4nQXg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE42F403B5; Thu, 18 May 2023 09:20:55 -0300 (-03)
Date:   Thu, 18 May 2023 09:20:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH v1 1/2] perf test attr: Update no event/metric
 expectations
Message-ID: <ZGYYJ/biKyeFNJjL@kernel.org>
References: <20230517225707.2682235-1-irogers@google.com>
 <64f329a9-09a3-aa84-a354-23a919062d09@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f329a9-09a3-aa84-a354-23a919062d09@arm.com>
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

Em Thu, May 18, 2023 at 08:50:14AM +0100, James Clark escreveu:
> 
> 
> On 17/05/2023 23:57, Ian Rogers wrote:
> > Previously hard coded events/metrics were used, update for the use of
> > the TopdownL1 json metric group.
> > 
> > Fixes: 94b1a603fca7 ("perf stat: Add TopdownL1 metric as a default if present")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/attr/base-stat            |   2 +-
> >  tools/perf/tests/attr/test-stat-default    |  80 ++++++++-----
> >  tools/perf/tests/attr/test-stat-detailed-1 |  95 +++++++++------
> >  tools/perf/tests/attr/test-stat-detailed-2 | 119 +++++++++++--------
> >  tools/perf/tests/attr/test-stat-detailed-3 | 127 ++++++++++++---------
> >  5 files changed, 249 insertions(+), 174 deletions(-)
> > 
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied both patches to perf-tools.

- Arnaldo

 
> > diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
> > index a21fb65bc012..fccd8ec4d1b0 100644
> > --- a/tools/perf/tests/attr/base-stat
> > +++ b/tools/perf/tests/attr/base-stat
> > @@ -16,7 +16,7 @@ pinned=0
> >  exclusive=0
> >  exclude_user=0
> >  exclude_kernel=0|1
> > -exclude_hv=0
> > +exclude_hv=0|1
> >  exclude_idle=0
> >  mmap=0
> >  comm=0
> > diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tests/attr/test-stat-default
> > index d8ea6a88163f..a1e2da0a9a6d 100644
> > --- a/tools/perf/tests/attr/test-stat-default
> > +++ b/tools/perf/tests/attr/test-stat-default
> > @@ -40,7 +40,6 @@ fd=6
> >  type=0
> >  config=7
> >  optional=1
> > -
> >  # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_BACKEND
> >  [event7:base-stat]
> >  fd=7
> > @@ -89,79 +88,98 @@ enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> > +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >  [event13:base-stat]
> >  fd=13
> >  group_fd=11
> >  type=4
> > -config=33024
> > +config=33280
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> > +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >  [event14:base-stat]
> >  fd=14
> >  group_fd=11
> >  type=4
> > -config=33280
> > +config=33536
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> > +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >  [event15:base-stat]
> >  fd=15
> >  group_fd=11
> >  type=4
> > -config=33536
> > +config=33024
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> > +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >  [event16:base-stat]
> >  fd=16
> > -group_fd=11
> >  type=4
> > -config=33792
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=4109
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> > +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
> >  [event17:base-stat]
> >  fd=17
> > -group_fd=11
> >  type=4
> > -config=34048
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=17039629
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >  [event18:base-stat]
> >  fd=18
> > -group_fd=11
> >  type=4
> > -config=34304
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=60
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> > +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >  [event19:base-stat]
> >  fd=19
> > -group_fd=11
> >  type=4
> > -config=34560
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=2097421
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> > +[event20:base-stat]
> > +fd=20
> > +type=4
> > +config=316
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> > +[event21:base-stat]
> > +fd=21
> > +type=4
> > +config=412
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> > +[event22:base-stat]
> > +fd=22
> > +type=4
> > +config=572
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> > +[event23:base-stat]
> > +fd=23
> > +type=4
> > +config=706
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> > +[event24:base-stat]
> > +fd=24
> > +type=4
> > +config=270
> >  optional=1
> > diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/tests/attr/test-stat-detailed-1
> > index b656ab93c5bf..1c52cb05c900 100644
> > --- a/tools/perf/tests/attr/test-stat-detailed-1
> > +++ b/tools/perf/tests/attr/test-stat-detailed-1
> > @@ -90,89 +90,108 @@ enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> > +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >  [event13:base-stat]
> >  fd=13
> >  group_fd=11
> >  type=4
> > -config=33024
> > +config=33280
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> > +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >  [event14:base-stat]
> >  fd=14
> >  group_fd=11
> >  type=4
> > -config=33280
> > +config=33536
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> > +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >  [event15:base-stat]
> >  fd=15
> >  group_fd=11
> >  type=4
> > -config=33536
> > +config=33024
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> > +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >  [event16:base-stat]
> >  fd=16
> > -group_fd=11
> >  type=4
> > -config=33792
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=4109
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> > +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
> >  [event17:base-stat]
> >  fd=17
> > -group_fd=11
> >  type=4
> > -config=34048
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=17039629
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >  [event18:base-stat]
> >  fd=18
> > -group_fd=11
> >  type=4
> > -config=34304
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=60
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> > +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >  [event19:base-stat]
> >  fd=19
> > -group_fd=11
> >  type=4
> > -config=34560
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=2097421
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> > +[event20:base-stat]
> > +fd=20
> > +type=4
> > +config=316
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> > +[event21:base-stat]
> > +fd=21
> > +type=4
> > +config=412
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> > +[event22:base-stat]
> > +fd=22
> > +type=4
> > +config=572
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> > +[event23:base-stat]
> > +fd=23
> > +type=4
> > +config=706
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> > +[event24:base-stat]
> > +fd=24
> > +type=4
> > +config=270
> >  optional=1
> >  
> >  # PERF_TYPE_HW_CACHE /
> >  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event20:base-stat]
> > -fd=20
> > +[event25:base-stat]
> > +fd=25
> >  type=3
> >  config=0
> >  optional=1
> > @@ -181,8 +200,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event21:base-stat]
> > -fd=21
> > +[event26:base-stat]
> > +fd=26
> >  type=3
> >  config=65536
> >  optional=1
> > @@ -191,8 +210,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event22:base-stat]
> > -fd=22
> > +[event27:base-stat]
> > +fd=27
> >  type=3
> >  config=2
> >  optional=1
> > @@ -201,8 +220,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event23:base-stat]
> > -fd=23
> > +[event28:base-stat]
> > +fd=28
> >  type=3
> >  config=65538
> >  optional=1
> > diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/tests/attr/test-stat-detailed-2
> > index 97625090a1c4..7e961d24a885 100644
> > --- a/tools/perf/tests/attr/test-stat-detailed-2
> > +++ b/tools/perf/tests/attr/test-stat-detailed-2
> > @@ -90,89 +90,108 @@ enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> > +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >  [event13:base-stat]
> >  fd=13
> >  group_fd=11
> >  type=4
> > -config=33024
> > +config=33280
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> > +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >  [event14:base-stat]
> >  fd=14
> >  group_fd=11
> >  type=4
> > -config=33280
> > +config=33536
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> > +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >  [event15:base-stat]
> >  fd=15
> >  group_fd=11
> >  type=4
> > -config=33536
> > +config=33024
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> > +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >  [event16:base-stat]
> >  fd=16
> > -group_fd=11
> >  type=4
> > -config=33792
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=4109
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> > +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
> >  [event17:base-stat]
> >  fd=17
> > -group_fd=11
> >  type=4
> > -config=34048
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=17039629
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >  [event18:base-stat]
> >  fd=18
> > -group_fd=11
> >  type=4
> > -config=34304
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=60
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> > +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >  [event19:base-stat]
> >  fd=19
> > -group_fd=11
> >  type=4
> > -config=34560
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=2097421
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> > +[event20:base-stat]
> > +fd=20
> > +type=4
> > +config=316
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> > +[event21:base-stat]
> > +fd=21
> > +type=4
> > +config=412
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> > +[event22:base-stat]
> > +fd=22
> > +type=4
> > +config=572
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> > +[event23:base-stat]
> > +fd=23
> > +type=4
> > +config=706
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> > +[event24:base-stat]
> > +fd=24
> > +type=4
> > +config=270
> >  optional=1
> >  
> >  # PERF_TYPE_HW_CACHE /
> >  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event20:base-stat]
> > -fd=20
> > +[event25:base-stat]
> > +fd=25
> >  type=3
> >  config=0
> >  optional=1
> > @@ -181,8 +200,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event21:base-stat]
> > -fd=21
> > +[event26:base-stat]
> > +fd=26
> >  type=3
> >  config=65536
> >  optional=1
> > @@ -191,8 +210,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event22:base-stat]
> > -fd=22
> > +[event27:base-stat]
> > +fd=27
> >  type=3
> >  config=2
> >  optional=1
> > @@ -201,8 +220,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event23:base-stat]
> > -fd=23
> > +[event28:base-stat]
> > +fd=28
> >  type=3
> >  config=65538
> >  optional=1
> > @@ -211,8 +230,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event24:base-stat]
> > -fd=24
> > +[event29:base-stat]
> > +fd=29
> >  type=3
> >  config=1
> >  optional=1
> > @@ -221,8 +240,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event25:base-stat]
> > -fd=25
> > +[event30:base-stat]
> > +fd=30
> >  type=3
> >  config=65537
> >  optional=1
> > @@ -231,8 +250,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event26:base-stat]
> > -fd=26
> > +[event31:base-stat]
> > +fd=31
> >  type=3
> >  config=3
> >  optional=1
> > @@ -241,8 +260,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event27:base-stat]
> > -fd=27
> > +[event32:base-stat]
> > +fd=32
> >  type=3
> >  config=65539
> >  optional=1
> > @@ -251,8 +270,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event28:base-stat]
> > -fd=28
> > +[event33:base-stat]
> > +fd=33
> >  type=3
> >  config=4
> >  optional=1
> > @@ -261,8 +280,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event29:base-stat]
> > -fd=29
> > +[event34:base-stat]
> > +fd=34
> >  type=3
> >  config=65540
> >  optional=1
> > diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/tests/attr/test-stat-detailed-3
> > index d555042e3fbf..e50535f45977 100644
> > --- a/tools/perf/tests/attr/test-stat-detailed-3
> > +++ b/tools/perf/tests/attr/test-stat-detailed-3
> > @@ -90,89 +90,108 @@ enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> > +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >  [event13:base-stat]
> >  fd=13
> >  group_fd=11
> >  type=4
> > -config=33024
> > +config=33280
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> > +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >  [event14:base-stat]
> >  fd=14
> >  group_fd=11
> >  type=4
> > -config=33280
> > +config=33536
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> > +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >  [event15:base-stat]
> >  fd=15
> >  group_fd=11
> >  type=4
> > -config=33536
> > +config=33024
> >  disabled=0
> >  enable_on_exec=0
> >  read_format=15
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> > +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >  [event16:base-stat]
> >  fd=16
> > -group_fd=11
> >  type=4
> > -config=33792
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=4109
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> > +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
> >  [event17:base-stat]
> >  fd=17
> > -group_fd=11
> >  type=4
> > -config=34048
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=17039629
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >  [event18:base-stat]
> >  fd=18
> > -group_fd=11
> >  type=4
> > -config=34304
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=60
> >  optional=1
> >  
> > -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> > +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >  [event19:base-stat]
> >  fd=19
> > -group_fd=11
> >  type=4
> > -config=34560
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=15
> > +config=2097421
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> > +[event20:base-stat]
> > +fd=20
> > +type=4
> > +config=316
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> > +[event21:base-stat]
> > +fd=21
> > +type=4
> > +config=412
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> > +[event22:base-stat]
> > +fd=22
> > +type=4
> > +config=572
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> > +[event23:base-stat]
> > +fd=23
> > +type=4
> > +config=706
> > +optional=1
> > +
> > +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> > +[event24:base-stat]
> > +fd=24
> > +type=4
> > +config=270
> >  optional=1
> >  
> >  # PERF_TYPE_HW_CACHE /
> >  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event20:base-stat]
> > -fd=20
> > +[event25:base-stat]
> > +fd=25
> >  type=3
> >  config=0
> >  optional=1
> > @@ -181,8 +200,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event21:base-stat]
> > -fd=21
> > +[event26:base-stat]
> > +fd=26
> >  type=3
> >  config=65536
> >  optional=1
> > @@ -191,8 +210,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event22:base-stat]
> > -fd=22
> > +[event27:base-stat]
> > +fd=27
> >  type=3
> >  config=2
> >  optional=1
> > @@ -201,8 +220,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event23:base-stat]
> > -fd=23
> > +[event28:base-stat]
> > +fd=28
> >  type=3
> >  config=65538
> >  optional=1
> > @@ -211,8 +230,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event24:base-stat]
> > -fd=24
> > +[event29:base-stat]
> > +fd=29
> >  type=3
> >  config=1
> >  optional=1
> > @@ -221,8 +240,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event25:base-stat]
> > -fd=25
> > +[event30:base-stat]
> > +fd=30
> >  type=3
> >  config=65537
> >  optional=1
> > @@ -231,8 +250,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event26:base-stat]
> > -fd=26
> > +[event31:base-stat]
> > +fd=31
> >  type=3
> >  config=3
> >  optional=1
> > @@ -241,8 +260,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event27:base-stat]
> > -fd=27
> > +[event32:base-stat]
> > +fd=32
> >  type=3
> >  config=65539
> >  optional=1
> > @@ -251,8 +270,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event28:base-stat]
> > -fd=28
> > +[event33:base-stat]
> > +fd=33
> >  type=3
> >  config=4
> >  optional=1
> > @@ -261,8 +280,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event29:base-stat]
> > -fd=29
> > +[event34:base-stat]
> > +fd=34
> >  type=3
> >  config=65540
> >  optional=1
> > @@ -271,8 +290,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> > -[event30:base-stat]
> > -fd=30
> > +[event35:base-stat]
> > +fd=35
> >  type=3
> >  config=512
> >  optional=1
> > @@ -281,8 +300,8 @@ optional=1
> >  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
> >  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> > -[event31:base-stat]
> > -fd=31
> > +[event36:base-stat]
> > +fd=36
> >  type=3
> >  config=66048
> >  optional=1

-- 

- Arnaldo
