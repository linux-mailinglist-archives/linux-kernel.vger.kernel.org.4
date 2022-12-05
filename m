Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32D6428A8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiLEMk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiLEMkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:40:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DBF10B4B;
        Mon,  5 Dec 2022 04:40:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EA7A61088;
        Mon,  5 Dec 2022 12:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBB2C433C1;
        Mon,  5 Dec 2022 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670244053;
        bh=fKariYRutBSyoSuP7+hy8qpLdIJw9oh1VmzhVjeiWUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2sXnRQdK94DC3rG7Y1YZdbJdA5SnsF3Fr+j/13QLvYz8bTgfCPVWNpQkr5Nhrdkp
         c00WIqYSRFj5r+7EhLls6/avpZVNBpeYZzYwn4H8H9yBvGROYHM0tB/VBLQYsoFFZr
         G7HbTNxtjTi7mvAV6fR1Ki6/zXuSSKSKS7sOiUoSn7JhUtrzdPFZNjR43vSQzi3hyc
         lzQDXpBN79XpPqcOa9KJwWTPjOvNUUGeFZGMlCjYe0Gc0g1pAPbXWlqenfIbbIBsXH
         0LCDYqIHFP0+W6footQfZpqdtx8Geje6eI2ozR3MxG0w4mtk7QrgjLkyLRGDklEldu
         nkKn1d4+lNL9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 09CC740404; Mon,  5 Dec 2022 09:40:51 -0300 (-03)
Date:   Mon, 5 Dec 2022 09:40:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/15] perf stat: Remove prefix argument in
 print_metric_headers()
Message-ID: <Y43m03wU9+wENNB6@kernel.org>
References: <20221123180208.2068936-1-namhyung@kernel.org>
 <20221123180208.2068936-6-namhyung@kernel.org>
 <CAP-5=fWZ27QW+XvZx0bzEMmUbyKpmmmZudB9u=SyxiLcH3CCqw@mail.gmail.com>
 <CAP-5=fXsWfOmavOAmxsUcX+g3cve2r20JmseDF7Bn1jO6tPX-Q@mail.gmail.com>
 <CAP-5=fUOjSM5HajU9TCD6prY39LbX4OQbkEbtKPPGRBPBN=_VQ@mail.gmail.com>
 <Y43ib0gPvjC1SicU@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y43ib0gPvjC1SicU@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 05, 2022 at 09:22:07AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 29, 2022 at 09:13:11PM -0800, Ian Rogers escreveu:
> > More specifically, I think os->prefix needs testing for NULL:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/stat-display.c?h=perf/core#n356
> > so:
> > fputs(os->prefix, os->fh);
> > should be:
> > if (os->prefix)
> >   fputs(os->prefix, os->fh);
 
> Going thru the messages, for now I just added the test.

So I added this, as the patch introducing the problem was already in
acme/perf/core, please see if this is acceptable.

- Arnaldo

commit e21eb4d4fbd298a94ac200e2b6c3bea431e8cbca
Author: Ian Rogers <irogers@google.com>
Date:   Mon Dec 5 09:34:04 2022 -0300

    perf stat: Check existence of os->prefix, fixing a segfault
    
    We need to check if we have a OS prefix, otherwise we stumble on a
    metric segv that I'm now seeing in Arnaldo's tree:
    
      $ gdb --args perf stat -M Backend true
      ...
      Performance counter stats for 'true':
    
              4,712,355      TOPDOWN.SLOTS                    #     17.3 % tma_core_bound
    
      Program received signal SIGSEGV, Segmentation fault.
      __strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
      77      ../sysdeps/x86_64/multiarch/strlen-evex.S: No such file or directory.
      (gdb) bt
      #0  __strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
      #1  0x00007ffff74749a5 in __GI__IO_fputs (str=0x0, fp=0x7ffff75f5680 <_IO_2_1_stderr_>)
      #2  0x0000555555779f28 in do_new_line_std (config=0x555555e077c0 <stat_config>, os=0x7fffffffbf10) at util/stat-display.c:356
      #3  0x000055555577a081 in print_metric_std (config=0x555555e077c0 <stat_config>, ctx=0x7fffffffbf10, color=0x0, fmt=0x5555558b77b5 "%8.1f", unit=0x7fffffffbb10 "%  tma_memory_bound", val=13.165355724442199) at util/stat-display.c:380
      #4  0x00005555557768b6 in generic_metric (config=0x555555e077c0 <stat_config>, metric_expr=0x55555593d5b7 "((CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES))"..., metric_events=0x555555f334e0, metric_refs=0x555555ec81d0, name=0x555555f32e80 "TOPDOWN.SLOTS", metric_name=0x555555f26c80 "tma_memory_bound", metric_unit=0x55555593d5b1 "100%", runtime=0, map_idx=0, out=0x7fffffffbd90, st=0x555555e9e620 <rt_stat>) at util/stat-shadow.c:934
      #5  0x0000555555778cac in perf_stat__print_shadow_stats (config=0x555555e077c0 <stat_config>, evsel=0x555555f289d0, avg=4712355, map_idx=0, out=0x7fffffffbd90, metric_events=0x555555e078e8 <stat_config+296>, st=0x555555e9e620 <rt_stat>) at util/stat-shadow.c:1329
      #6  0x000055555577b6a0 in printout (config=0x555555e077c0 <stat_config>, os=0x7fffffffbf10, uval=4712355, run=325322, ena=325322, noise=4712355, map_idx=0) at util/stat-display.c:741
      #7  0x000055555577bc74 in print_counter_aggrdata (config=0x555555e077c0 <stat_config>, counter=0x555555f289d0, s=0, os=0x7fffffffbf10) at util/stat-display.c:838
      #8  0x000055555577c1d8 in print_counter (config=0x555555e077c0 <stat_config>, counter=0x555555f289d0, os=0x7fffffffbf10) at util/stat-display.c:957
      #9  0x000055555577dba0 in evlist__print_counters (evlist=0x555555ec3610, config=0x555555e077c0 <stat_config>, _target=0x555555e01c80 <target>, ts=0x0, argc=1, argv=0x7fffffffe450) at util/stat-display.c:1413
      #10 0x00005555555fc821 in print_counters (ts=0x0, argc=1, argv=0x7fffffffe450) at builtin-stat.c:1040
      #11 0x000055555560091a in cmd_stat (argc=1, argv=0x7fffffffe450) at builtin-stat.c:2665
      #12 0x00005555556b1eea in run_builtin (p=0x555555e11f70 <commands+336>, argc=4, argv=0x7fffffffe450) at perf.c:322
      #13 0x00005555556b2181 in handle_internal_command (argc=4, argv=0x7fffffffe450) at perf.c:376
      #14 0x00005555556b22d7 in run_argv (argcp=0x7fffffffe27c, argv=0x7fffffffe270) at perf.c:420
      #15 0x00005555556b26ef in main (argc=4, argv=0x7fffffffe450) at perf.c:550
      (gdb)
    
    Fixes: f123b2d84ecec9a3 ("perf stat: Remove prefix argument in print_metric_headers()")
    Acked-by: Namhyung Kim <namhyung@kernel.org>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: James Clark <james.clark@arm.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
    Link: http://lore.kernel.org/lkml/CAP-5=fUOjSM5HajU9TCD6prY39LbX4OQbkEbtKPPGRBPBN=_VQ@mail.gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f1ee4b052198690f..9b7772e6abf6538f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -353,7 +353,8 @@ static void do_new_line_std(struct perf_stat_config *config,
 			    struct outstate *os)
 {
 	fputc('\n', os->fh);
-	fputs(os->prefix, os->fh);
+	if (os->prefix)
+		fputs(os->prefix, os->fh);
 	aggr_printout(config, os->evsel, os->id, os->nr);
 	if (config->aggr_mode == AGGR_NONE)
 		fprintf(os->fh, "        ");
