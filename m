Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C6D6EFC89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbjDZVdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbjDZVdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B384DAF;
        Wed, 26 Apr 2023 14:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 181A263938;
        Wed, 26 Apr 2023 21:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E60C433EF;
        Wed, 26 Apr 2023 21:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682544787;
        bh=ptc693z3N0PSNzcsMhi0tQWS82hj4La4NfG0lguyVVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJcJ9SZLGF6gJmFo21huRZU+iwlx9x8QGZC7b2qPeZdt+w2fmdCCmE5Z6e4jKWadW
         /UHtpH30896CKgV/GvhFstAxO+2b7P5ZyiI5Aa3w5Aoh5uMWjn+6rGBvqwqyRKhitV
         Aede2ZmyjckgwFNX5b7tjBiZXgI6TeM1U0k4hs//gfl4pRR3NaUEGPcLXLbXp6ENp8
         vmetoHxwijl+rHiJ5Pv1HoWFCXWjg/1yj7v925iGq2uJOgnYA6kii5B7OV2WutIWaI
         U45UGnlTbv5Jsl85w0BXItzon5hsxaPtOpeMgWBMP3L+nuxrmU5I7u4Ra7s5ZQ9DGm
         Qaze2DSzF9jYw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 73DE0403B5; Wed, 26 Apr 2023 18:33:04 -0300 (-03)
Date:   Wed, 26 Apr 2023 18:33:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Cc:     Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/40] Fix perf on Intel hybrid CPUs
Message-ID: <ZEmYkDPgdKXWM+/e@kernel.org>
References: <20230426070050.1315519-1-irogers@google.com>
 <ZEmTEHh0A6Uvy/k+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEmTEHh0A6Uvy/k+@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 26, 2023 at 06:09:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Apr 26, 2023 at 12:00:10AM -0700, Ian Rogers escreveu:
> > TL;DR: hybrid doesn't crash, json metrics work on hybrid on both PMUs
> > or individually, event parsing doesn't always scan all PMUs, more and
> > new tests that also run without hybrid, less code.
> > 
> > The first patches were previously posted to improve metrics here:
> > "perf stat: Introduce skippable evsels"
> > https://lore.kernel.org/all/20230414051922.3625666-1-irogers@google.com/
> > "perf vendor events intel: Add xxx metric constraints"
> > https://lore.kernel.org/all/20230419005423.343862-1-irogers@google.com/
> > 
> > Next are some general test improvements.
> 
> Kan,
> 
> 	Have you looked at this? I'm doing a test build on it now.

And just to make clear, this is for v6.5.

- Arnaldo
>  
> > Next event parsing is rewritten to not scan all PMUs for the benefit
> > of raw and legacy cache parsing, instead these are handled by the
> > lexer and a new term type. This ultimately removes the need for the
> > event parser for hybrid to be recursive as legacy cache can be just a
> > term. Tests are re-enabled for events with hyphens, so AMD's
> > branch-brs event is now parsable.
> > 
> > The cputype option is made a generic pmu filter flag and is tested
> > even on non-hybrid systems.
> > 
> > The final patches address specific json metric issues on hybrid, in
> > both the json metrics and the metric code. They also bring in a new
> > json option to not group events when matching a metricgroup, this
> > helps reduce counter pressure for TopdownL1 and TopdownL2 metric
> > groups. The updates to the script that updates the json are posted in:
> > https://github.com/intel/perfmon/pull/73
> > 
> > The patches add slightly more code than they remove, in areas like
> > better json metric constraints and tests, but in the core util code,
> > the removal of hybrid is a net reduction:
> >  20 files changed, 631 insertions(+), 951 deletions(-)
> > 
> > There's specific detail with each patch, but for now here is the 6.3
> > output followed by that from perf-tools-next with the patch series
> > applied. The tool is running on an Alderlake CPU on an elderly 5.15
> > kernel:
> > 
> > Events on hybrid that parse and pass tests:
> > '''
> > $ perf-6.3 version
> > perf version 6.3.rc7.gb7bc77e2f2c7
> > $ perf-6.3 test
> > ...
> >   6.1: Test event parsing                       : FAILED!
> > ...
> > $ perf test
> > ...
> >   6: Parse event definition strings             :
> >   6.1: Test event parsing                       : Ok
> >   6.2: Parsing of all PMU events from sysfs     : Ok
> >   6.3: Parsing of given PMU events from sysfs   : Ok
> >   6.4: Parsing of aliased events from sysfs     : Skip (no aliases in sysfs)
> >   6.5: Parsing of aliased events                : Ok
> >   6.6: Parsing of terms (event modifiers)       : Ok
> > ...
> > '''
> > 
> > No event/metric running with json metrics and TopdownL1 on both PMUs:
> > '''
> > $ perf-6.3 stat -a sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >          24,073.58 msec cpu-clock                        #   23.975 CPUs utilized             
> >                350      context-switches                 #   14.539 /sec                      
> >                 25      cpu-migrations                   #    1.038 /sec                      
> >                 66      page-faults                      #    2.742 /sec                      
> >         21,257,199      cpu_core/cycles/                 #  883.009 K/sec                     
> >          2,162,192      cpu_atom/cycles/                 #   89.816 K/sec                     
> >          6,679,379      cpu_core/instructions/           #  277.457 K/sec                     
> >            753,197      cpu_atom/instructions/           #   31.287 K/sec                     
> >          1,300,647      cpu_core/branches/               #   54.028 K/sec                     
> >            148,652      cpu_atom/branches/               #    6.175 K/sec                     
> >            117,429      cpu_core/branch-misses/          #    4.878 K/sec                     
> >             14,396      cpu_atom/branch-misses/          #  598.000 /sec                      
> >        123,097,644      cpu_core/slots/                  #    5.113 M/sec                     
> >          9,241,207      cpu_core/topdown-retiring/       #      7.5% Retiring                 
> >          8,903,288      cpu_core/topdown-bad-spec/       #      7.2% Bad Speculation          
> >         66,590,029      cpu_core/topdown-fe-bound/       #     54.1% Frontend Bound           
> >         38,397,500      cpu_core/topdown-be-bound/       #     31.2% Backend Bound            
> >          3,294,283      cpu_core/topdown-heavy-ops/      #      2.7% Heavy Operations          #      4.8% Light Operations         
> >          8,855,769      cpu_core/topdown-br-mispredict/  #      7.2% Branch Mispredict         #      0.0% Machine Clears           
> >         57,695,714      cpu_core/topdown-fetch-lat/      #     46.9% Fetch Latency             #      7.2% Fetch Bandwidth          
> >         12,823,926      cpu_core/topdown-mem-bound/      #     10.4% Memory Bound              #     20.8% Core Bound               
> > 
> >        1.004093622 seconds time elapsed
> > 
> > $ perf stat -a sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >          24,064.65 msec cpu-clock                        #   23.973 CPUs utilized             
> >                384      context-switches                 #   15.957 /sec                      
> >                 24      cpu-migrations                   #    0.997 /sec                      
> >                 71      page-faults                      #    2.950 /sec                      
> >         19,737,646      cpu_core/cycles/                 #  820.192 K/sec                     
> >        122,018,505      cpu_atom/cycles/                 #    5.070 M/sec                       (63.32%)
> >          7,636,653      cpu_core/instructions/           #  317.339 K/sec                     
> >         16,266,629      cpu_atom/instructions/           #  675.955 K/sec                       (72.50%)
> >          1,552,995      cpu_core/branches/               #   64.534 K/sec                     
> >          3,208,143      cpu_atom/branches/               #  133.314 K/sec                       (72.50%)
> >            132,151      cpu_core/branch-misses/          #    5.491 K/sec                     
> >            547,285      cpu_atom/branch-misses/          #   22.742 K/sec                       (72.49%)
> >         32,110,597      cpu_atom/TOPDOWN_RETIRING.ALL/   #    1.334 M/sec                     
> >                                                   #     18.4 %  tma_bad_speculation      (72.48%)
> >        228,006,765      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #    9.475 M/sec                     
> >                                                   #     38.1 %  tma_frontend_bound       (72.47%)
> >        225,866,251      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #    9.386 M/sec                     
> >                                                   #     37.7 %  tma_backend_bound      
> >                                                   #     37.7 %  tma_backend_bound_aux    (72.73%)
> >        119,748,254      cpu_atom/CPU_CLK_UNHALTED.CORE/  #    4.976 M/sec                     
> >                                                   #      5.2 %  tma_retiring             (73.14%)
> >         31,363,579      cpu_atom/TOPDOWN_RETIRING.ALL/   #    1.303 M/sec                       (73.37%)
> >        227,907,321      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #    9.471 M/sec                       (63.95%)
> >        228,803,268      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #    9.508 M/sec                       (63.55%)
> >        113,357,334      cpu_core/TOPDOWN.SLOTS/          #     30.5 %  tma_backend_bound      
> >                                                   #      9.2 %  tma_retiring           
> >                                                   #      8.7 %  tma_bad_speculation    
> >                                                   #     51.6 %  tma_frontend_bound     
> >         10,451,044      cpu_core/topdown-retiring/                                            
> >          9,687,449      cpu_core/topdown-bad-spec/                                            
> >         58,703,214      cpu_core/topdown-fe-bound/                                            
> >         34,540,660      cpu_core/topdown-be-bound/                                            
> >            154,902      cpu_core/INT_MISC.UOP_DROPPING/  #    6.437 K/sec                     
> > 
> >        1.003818397 seconds time elapsed
> > '''
> > 
> > Json metrics that don't crash:
> > '''
> > $ perf-6.3 stat -M TopdownL1 -a sleep 1
> > WARNING: events in group from different hybrid PMUs!
> > WARNING: grouped events cpus do not match, disabling group:
> >   anon group { topdown-retiring, topdown-retiring, INT_MISC.UOP_DROPPING, topdown-fe-bound, topdown-fe-bound, CPU_CLK_UNHALTED.CORE, topdown-be-bound, topdown-be-bound, topdown-bad-spec, topdown-bad-spec }
> > Error:
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-retiring).
> > /bin/dmesg | grep -i perf may provide additional information.
> > 
> > $ perf stat -M TopdownL1 -a sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >            811,810      cpu_atom/TOPDOWN_RETIRING.ALL/   #     26.6 %  tma_bad_speculation    
> >          3,239,281      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #     38.8 %  tma_frontend_bound     
> >          2,037,667      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #     24.4 %  tma_backend_bound      
> >                                                   #     24.4 %  tma_backend_bound_aux  
> >          1,670,438      cpu_atom/CPU_CLK_UNHALTED.CORE/  #      9.7 %  tma_retiring           
> >            808,138      cpu_atom/TOPDOWN_RETIRING.ALL/                                        
> >          3,234,707      cpu_atom/TOPDOWN_FE_BOUND.ALL/                                        
> >          2,081,420      cpu_atom/TOPDOWN_BE_BOUND.ALL/                                        
> >        122,795,280      cpu_core/TOPDOWN.SLOTS/          #     31.7 %  tma_backend_bound      
> >                                                   #      7.0 %  tma_bad_speculation    
> >                                                   #     54.1 %  tma_frontend_bound     
> >                                                   #      7.2 %  tma_retiring           
> >          8,817,636      cpu_core/topdown-retiring/                                            
> >          8,480,817      cpu_core/topdown-bad-spec/                                            
> >          3,108,926      cpu_core/topdown-heavy-ops/                                           
> >         66,566,215      cpu_core/topdown-fe-bound/                                            
> >         38,958,811      cpu_core/topdown-be-bound/                                            
> >            134,194      cpu_core/INT_MISC.UOP_DROPPING/                                       
> > 
> >        1.003607796 seconds time elapsed
> > 
> > $ perf stat -M TopdownL2 -a sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >        162,334,218      cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_LATENCY/ #     27.7 %  tma_fetch_latency        (38.99%)
> >         16,191,486      cpu_atom/INST_RETIRED.ANY/                                              (45.76%)
> >         68,443,205      cpu_atom/TOPDOWN_BE_BOUND.MEM_SCHEDULER/ #     32.2 %  tma_memory_bound       
> >                                                   #      5.8 %  tma_core_bound           (45.77%)
> >         14,920,109      cpu_atom/UOPS_RETIRED.MS/        #      2.9 %  tma_base                 (45.92%)
> >         14,829,879      cpu_atom/UOPS_RETIRED.MS/        #      2.5 %  tma_ms_uops              (46.31%)
> >         31,860,520      cpu_atom/TOPDOWN_RETIRING.ALL/                                          (46.71%)
> >        117,323,055      cpu_atom/CPU_CLK_UNHALTED.CORE/  #     18.7 %  tma_branch_mispredicts 
> >                                                   #     11.5 %  tma_fetch_bandwidth    
> >                                                   #      0.3 %  tma_machine_clears     
> >                                                   #     37.9 %  tma_resource_bound       (53.49%)
> >        222,579,768      cpu_atom/TOPDOWN_BE_BOUND.ALL/                                          (53.90%)
> >         13,672,174      cpu_atom/MEM_SCHEDULER_BLOCK.ST_BUF/                                        (54.23%)
> >         24,264,262      cpu_atom/LD_HEAD.ANY_AT_RET/                                            (47.46%)
> >         13,872,813      cpu_atom/MEM_SCHEDULER_BLOCK.ALL/                                        (47.45%)
> >        223,722,007      cpu_atom/TOPDOWN_BE_BOUND.ALL/                                          (47.31%)
> >          2,005,972      cpu_atom/TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS/                                        (46.91%)
> >        109,423,013      cpu_atom/TOPDOWN_BAD_SPECULATION.MISPREDICT/                                        (39.72%)
> >         67,420,790      cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH/                                        (39.33%)
> >         92,790,312      cpu_core/TOPDOWN.SLOTS/          #     24.3 %  tma_core_bound         
> >                                                   #      3.0 %  tma_heavy_operations   
> >                                                   #      5.6 %  tma_light_operations   
> >                                                   #     10.8 %  tma_memory_bound       
> >                                                   #      7.8 %  tma_branch_mispredicts 
> >                                                   #     40.4 %  tma_fetch_latency      
> >                                                   #      0.2 %  tma_machine_clears     
> >                                                   #      7.8 %  tma_fetch_bandwidth    
> >          8,041,595      cpu_core/topdown-retiring/                                            
> >         10,060,500      cpu_core/topdown-mem-bound/                                           
> >          7,314,344      cpu_core/topdown-bad-spec/                                            
> >          2,824,600      cpu_core/topdown-heavy-ops/                                           
> >         37,630,164      cpu_core/topdown-fetch-lat/                                           
> >          7,278,843      cpu_core/topdown-br-mispredict/                                       
> >         44,863,148      cpu_core/topdown-fe-bound/                                            
> >         32,573,458      cpu_core/topdown-be-bound/                                            
> >          5,785,074      cpu_core/INST_RETIRED.ANY/                                            
> >          2,325,424      cpu_core/UOPS_RETIRED.MS/                                             
> >         15,972,774      cpu_core/CPU_CLK_UNHALTED.THREAD/                                      
> >            117,750      cpu_core/INT_MISC.UOP_DROPPING/                                       
> > 
> >        1.003519749 seconds time elapsed
> > '''
> > 
> > Note, flags are added below to reduce the size of the output by
> > removing event groups and threshold printing support:
> > '''
> > $ perf stat --metric-no-threshold --metric-no-group -M TopdownL3 -a sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >          3,506,641      cpu_atom/TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS/ #      0.6 %  tma_alloc_restriction    (17.14%)
> >        133,962,390      cpu_atom/TOPDOWN_BE_BOUND.SERIALIZATION/ #     22.2 %  tma_serialization        (17.48%)
> >         11,201,207      cpu_atom/TOPDOWN_FE_BOUND.ITLB/  #      1.9 %  tma_itlb_misses          (17.88%)
> >         63,876,838      cpu_atom/TOPDOWN_BE_BOUND.MEM_SCHEDULER/ #     10.6 %  tma_mem_scheduler      
> >                                                   #     10.5 %  tma_store_bound        
> >                                                   #      2.4 %  tma_other_load_store     (18.28%)
> >         14,386,940      cpu_atom/UOPS_RETIRED.MS/                                               (18.68%)
> >         14,432,493      cpu_atom/UOPS_RETIRED.MS/        #      2.7 %  tma_other_ret            (19.09%)
> >         81,582,687      cpu_atom/TOPDOWN_FE_BOUND.ICACHE/ #     13.5 %  tma_icache_misses        (19.14%)
> >         30,467,546      cpu_atom/TOPDOWN_RETIRING.ALL/                                          (19.14%)
> >         16,788,753      cpu_atom/MEM_BOUND_STALLS.LOAD/  #      4.2 %  tma_dram_bound         
> >                                                   #      3.7 %  tma_l2_bound           
> >                                                   #      6.7 %  tma_l3_bound             (19.14%)
> >         14,514,040      cpu_atom/TOPDOWN_FE_BOUND.DECODE/ #      2.4 %  tma_decode               (19.14%)
> >            688,307      cpu_atom/TOPDOWN_BAD_SPECULATION.NUKE/ #      0.1 %  tma_nuke                 (19.13%)
> >                  0      cpu_atom/UOPS_RETIRED.FPDIV/                                            (19.12%)
> >          4,408,466      cpu_atom/MEM_BOUND_STALLS.LOAD_L2_HIT/                                        (19.12%)
> >        120,556,998      cpu_atom/CPU_CLK_UNHALTED.CORE/  #      9.3 %  tma_branch_detect      
> >                                                   #      1.0 %  tma_branch_resteer     
> >                                                   #      5.8 %  tma_cisc               
> >                                                   #      0.3 %  tma_fast_nuke          
> >                                                   #      0.0 %  tma_fpdiv_uops         
> >                                                   #      4.3 %  tma_l1_bound           
> >                                                   #      3.2 %  tma_non_mem_scheduler  
> >                                                   #      1.9 %  tma_other_fb           
> >                                                   #      1.1 %  tma_predecode          
> >                                                   #      0.1 %  tma_register           
> >                                                   #      0.1 %  tma_reorder_buffer       (22.30%)
> >         34,773,106      cpu_atom/TOPDOWN_FE_BOUND.CISC/                                         (22.30%)
> >            591,112      cpu_atom/TOPDOWN_BE_BOUND.REGISTER/                                        (22.30%)
> >         11,286,706      cpu_atom/TOPDOWN_FE_BOUND.OTHER/                                        (22.30%)
> >          5,082,636      cpu_atom/MEM_BOUND_STALLS.LOAD_DRAM_HIT/                                        (22.30%)
> >         14,146,185      cpu_atom/MEM_SCHEDULER_BLOCK.ST_BUF/                                        (22.31%)
> >         55,833,686      cpu_atom/TOPDOWN_FE_BOUND.BRANCH_DETECT/                                        (22.30%)
> >         25,714,051      cpu_atom/LD_HEAD.ANY_AT_RET/                                            (19.12%)
> >            456,549      cpu_atom/TOPDOWN_BE_BOUND.REORDER_BUFFER/                                        (19.12%)
> >          1,616,862      cpu_atom/TOPDOWN_BAD_SPECULATION.FASTNUKE/                                        (19.12%)
> >          6,680,782      cpu_atom/TOPDOWN_FE_BOUND.PREDECODE/                                        (19.12%)
> >         14,229,195      cpu_atom/MEM_SCHEDULER_BLOCK.ALL/                                        (19.12%)
> >          8,128,921      cpu_atom/MEM_BOUND_STALLS.LOAD_LLC_HIT/                                        (19.12%)
> >         20,941,725      cpu_atom/LD_HEAD.L1_MISS_AT_RET/                                        (19.11%)
> >          6,177,125      cpu_atom/TOPDOWN_FE_BOUND.BRANCH_RESTEER/                                        (18.78%)
> >        228,066,346      cpu_atom/TOPDOWN_BE_BOUND.ALL/                                          (18.38%)
> >          5,204,897      cpu_atom/LD_HEAD.L1_BOUND_AT_RET/                                        (17.99%)
> >         19,060,104      cpu_atom/TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER/                                        (17.58%)
> >                  0      cpu_atom/UOPS_RETIRED.FPDIV/                                            (17.19%)
> >        864,565,692      cpu_core/TOPDOWN.SLOTS/          #      4.7 %  tma_microcode_sequencer
> >                                                   #      0.4 %  tma_few_uops_instructions
> >                                                   #      0.3 %  tma_fused_instructions 
> >                                                   #      1.8 %  tma_memory_operations  
> >                                                   #      0.1 %  tma_nop_instructions   
> >                                                   #      8.9 %  tma_ms_switches        
> >                                                   #      0.4 %  tma_non_fused_branches 
> >                                                   #      0.0 %  tma_fp_arith           
> >                                                   #      0.0 %  tma_int_operations     
> >                                                   #     35.7 %  tma_ports_utilization  
> >                                                   #      3.8 %  tma_other_light_ops      (18.03%)
> >        100,519,954      cpu_core/topdown-retiring/                                              (18.03%)
> >         68,964,454      cpu_core/topdown-bad-spec/                                              (18.03%)
> >         44,732,021      cpu_core/topdown-heavy-ops/                                             (18.03%)
> >        435,618,316      cpu_core/topdown-fe-bound/                                              (18.03%)
> >        262,842,804      cpu_core/topdown-be-bound/                                              (18.03%)
> >         10,368,608      cpu_core/BR_INST_RETIRED.ALL_BRANCHES/                                        (18.43%)
> >         55,947,727      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (18.84%)
> >        125,718,255      cpu_core/UOPS_ISSUED.ANY/                                               (19.24%)
> >         23,178,652      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (19.65%)
> >                  0      cpu_core/INT_VEC_RETIRED.ADD_256/                                        (20.05%)
> >          1,119,514      cpu_core/DSB2MITE_SWITCHES.PENALTY_CYCLES/ #      0.5 %  tma_dsb_switches         (20.46%)
> >         27,684,795      cpu_core/MEMORY_ACTIVITY.STALLS_L1D_MISS/ #     10.6 %  tma_l1_bound           
> >                                                   #      0.7 %  tma_l2_bound             (20.86%)
> >        108,813,079      cpu_core/UOPS_EXECUTED.THREAD/                                          (21.27%)
> >         16,563,036      cpu_core/IDQ.MITE_CYCLES_ANY/    #      5.2 %  tma_mite                 (19.14%)
> >         53,037,471      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (19.14%)
> >         41,005,510      cpu_core/UOPS_RETIRED.MS/                                               (19.14%)
> >            575,534      cpu_core/ARITH.DIV_ACTIVE/       #      0.2 %  tma_divider              (19.14%)
> >                  0      cpu_core/FP_ARITH_INST_RETIRED.SCALAR_SINGLE,umask=0x03/                                        (19.14%)
> >          2,207,021      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/ #      0.9 %  tma_store_bound          (19.13%)
> >          5,685,032      cpu_core/UOPS_RETIRED.MS,cmask=1,edge/                                        (19.13%)
> >             25,523      cpu_core/DECODE.LCP/             #      0.0 %  tma_lcp                  (19.12%)
> >         26,095,298      cpu_core/MEMORY_ACTIVITY.STALLS_L2_MISS/ #     10.8 %  tma_l3_bound             (19.13%)
> >            108,516      cpu_core/MEMORY_ACTIVITY.STALLS_L3_MISS/ #      0.0 %  tma_dram_bound           (19.13%)
> >        192,239,590      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (19.12%)
> >              5,978      cpu_core/LSD.CYCLES_ACTIVE/      #     -0.0 %  tma_lsd                  (19.12%)
> >                  0      cpu_core/INT_VEC_RETIRED.VNNI_128/                                        (19.13%)
> >        137,530,949      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/ #      0.1 %  tma_dsb                  (19.12%)
> >        240,070,549      cpu_core/CPU_CLK_UNHALTED.THREAD/ #     17.5 %  tma_icache_misses      
> >                                                   #      6.1 %  tma_itlb_misses        
> >                                                   #     40.3 %  tma_branch_resteers      (21.52%)
> >                  0      cpu_core/FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE,umask=0x3c/                                        (21.51%)
> >            595,051      cpu_core/ARITH.DIV_ACTIVE/                                              (21.52%)
> >            461,041      cpu_core/IDQ.DSB_CYCLES_ANY/                                            (21.51%)
> >                  0      cpu_core/INT_VEC_RETIRED.MUL_256/                                        (21.52%)
> >                  0      cpu_core/UOPS_EXECUTED.X87/                                             (21.52%)
> >            237,196      cpu_core/IDQ.DSB_CYCLES_OK/                                             (21.52%)
> >            125,009      cpu_core/LSD.CYCLES_OK/                                                 (21.52%)
> >                  0      cpu_core/INT_VEC_RETIRED.ADD_128/                                        (21.40%)
> >         28,388,778      cpu_core/MEM_UOP_RETIRED.ANY/                                           (18.61%)
> >          1,806,629      cpu_core/INST_RETIRED.NOP/                                              (18.21%)
> >         41,928,018      cpu_core/ICACHE_DATA.STALLS/                                            (17.81%)
> >                  0      cpu_core/INT_VEC_RETIRED.VNNI_256/                                        (17.41%)
> >         18,230,137      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (17.02%)
> >         28,052,001      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (16.61%)
> >          4,073,568      cpu_core/INST_RETIRED.MACRO_FUSED/                                        (16.20%)
> >         66,509,871      cpu_core/INT_MISC.UNKNOWN_BRANCH_CYCLES/                                        (15.92%)
> >          2,307,447      cpu_core/IDQ.MITE_CYCLES_OK/                                            (15.91%)
> >         30,345,769      cpu_core/INT_MISC.CLEAR_RESTEER_CYCLES/                                        (15.91%)
> >                  0      cpu_core/INT_VEC_RETIRED.SHUFFLES/                                        (15.91%)
> >         14,722,079      cpu_core/ICACHE_TAG.STALLS/                                             (15.90%)
> > 
> >        1.004474469 seconds time elapsed
> > 
> > $ perf stat --metric-no-threshold --metric-no-group -M TopdownL4 -a sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >      1,004,834,399 ns   duration_time                    #      0.3 %  tma_false_sharing      
> >                                                   #     40.2 %  tma_l3_hit_latency     
> >                                                   #      4.4 %  tma_contested_accesses 
> >                                                   #      1.6 %  tma_data_sharing       
> >          3,762,410      cpu_atom/LD_HEAD.PGWALK_AT_RET/  #      3.1 %  tma_stlb_miss            (33.58%)
> >                 10      cpu_atom/MACHINE_CLEARS.SMC/     #      0.0 %  tma_smc                  (33.98%)
> >         66,500,689      cpu_atom/TOPDOWN_BE_BOUND.MEM_SCHEDULER/ #      0.0 %  tma_ld_buffer          
> >                                                   #      0.0 %  tma_rsv                
> >                                                   #     11.0 %  tma_st_buffer            (29.60%)
> >          1,051,312      cpu_atom/LD_HEAD.OTHER_AT_RET/   #      0.9 %  tma_other_l1             (30.00%)
> >         14,740,093      cpu_atom/UOPS_RETIRED.MS/                                               (30.39%)
> >            117,899      cpu_atom/LD_HEAD.DTLB_MISS_AT_RET/ #      0.1 %  tma_stlb_hit             (30.79%)
> >            701,548      cpu_atom/TOPDOWN_BAD_SPECULATION.NUKE/ #      0.0 %  tma_disambiguation     
> >                                                   #      0.0 %  tma_fp_assist          
> >                                                   #      0.1 %  tma_memory_ordering    
> >                                                   #      0.0 %  tma_page_fault           (31.08%)
> >             12,873      cpu_atom/MACHINE_CLEARS.MEMORY_ORDERING/                                        (31.07%)
> >             58,321      cpu_atom/MEM_SCHEDULER_BLOCK.LD_BUF/                                        (31.07%)
> >             43,458      cpu_atom/MEM_SCHEDULER_BLOCK.RSV/                                        (31.07%)
> >         14,256,005      cpu_atom/MEM_SCHEDULER_BLOCK.ALL/                                        (31.06%)
> >        122,156,534      cpu_atom/CPU_CLK_UNHALTED.CORE/  #      0.0 %  tma_store_fwd_blk        (36.16%)
> >                  0      cpu_atom/MACHINE_CLEARS.FP_ASSIST/                                        (35.76%)
> >             13,804      cpu_atom/MACHINE_CLEARS.SLOW/                                           (35.35%)
> >         14,388,300      cpu_atom/MEM_SCHEDULER_BLOCK.ST_BUF/                                        (34.95%)
> >        493,070,443      cpu_atom/CPU_CLK_UNHALTED.REF_TSC/                                        (39.73%)
> >                  2      cpu_atom/MACHINE_CLEARS.PAGE_FAULT/                                        (39.33%)
> >              1,101      cpu_atom/LD_HEAD.ST_ADDR_AT_RET/                                        (38.93%)
> >                929      cpu_atom/MACHINE_CLEARS.DISAMBIGUATION/                                        (38.55%)
> >         14,241,213      cpu_atom/MEM_SCHEDULER_BLOCK.ALL/                                        (33.45%)
> >      1,010,981,054      cpu_core/TOPDOWN.SLOTS/          #      0.0 %  tma_assists            
> >                                                   #      4.3 %  tma_cisc               
> >                                                   #      0.0 %  tma_fp_scalar          
> >                                                   #      0.0 %  tma_fp_vector          
> >                                                   #      0.0 %  tma_shuffles           
> >                                                   #      0.0 %  tma_int_vector_128b    
> >                                                   #      0.0 %  tma_x87_use            
> >                                                   #      0.0 %  tma_int_vector_256b    
> >                                                   #      0.7 %  tma_clears_resteers    
> >                                                   #     12.4 %  tma_mispredicts_resteers  (8.14%)
> >        132,375,316      cpu_core/topdown-retiring/                                              (8.14%)
> >         88,303,327      cpu_core/topdown-bad-spec/                                              (8.14%)
> >         85,519,216      cpu_core/topdown-br-mispredict/                                         (8.14%)
> >        495,722,455      cpu_core/topdown-fe-bound/                                              (8.14%)
> >        298,147,134      cpu_core/topdown-be-bound/                                              (8.14%)
> >         21,418,803      cpu_core/UOPS_EXECUTED.CYCLES_GE_3/ #      8.8 %  tma_ports_utilized_3m    (10.12%)
> >         35,208,716      cpu_core/OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD,cmask=4/ #     14.5 %  tma_mem_bandwidth      
> >                                                   #     33.3 %  tma_mem_latency          (10.52%)
> >             17,358      cpu_core/OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM/                                        (10.91%)
> >         55,883,811      cpu_core/RESOURCE_STALLS.SCOREBOARD/ #     24.1 %  tma_ports_utilized_0     (12.91%)
> >                  0      cpu_core/INT_VEC_RETIRED.ADD_256/                                        (14.89%)
> >            139,890      cpu_core/DTLB_STORE_MISSES.STLB_HIT,cmask=1/ #      2.8 %  tma_dtlb_store           (15.30%)
> >            216,886      cpu_core/MEM_INST_RETIRED.LOCK_LOADS/ #      3.8 %  tma_store_latency      
> >                                                   #      0.1 %  tma_lock_latency         (15.71%)
> >        115,948,790      cpu_core/UOPS_EXECUTED.THREAD/                                          (17.69%)
> >         52,155,508      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (15.93%)
> >                  6      cpu_core/ASSISTS.ANY,umask=0x1B/                                        (15.93%)
> >         87,422,517      cpu_core/CYCLE_ACTIVITY.CYCLES_MEM_ANY/ #      5.2 %  tma_dtlb_load            (15.81%)
> >         37,420,652      cpu_core/MEMORY_ACTIVITY.CYCLES_L1D_MISS/                                        (15.44%)
> >         43,527,357      cpu_core/UOPS_RETIRED.MS/                                               (15.04%)
> >         31,787,227      cpu_core/INT_MISC.CLEAR_RESTEER_CYCLES/                                        (14.64%)
> >                  0      cpu_core/FP_ARITH_INST_RETIRED.SCALAR_SINGLE,umask=0x03/                                        (14.24%)
> >          4,899,130      cpu_core/XQ.FULL_CYCLES/         #      2.0 %  tma_sq_full              (13.84%)
> >              1,365      cpu_core/OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM/                                        (13.44%)
> >         23,904,338      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/ #      9.9 %  tma_ports_utilized_1     (13.05%)
> >            251,479      cpu_core/L2_RQSTS.ALL_RFO/                                              (12.76%)
> >        188,701,010      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (12.74%)
> >              6,909      cpu_core/MEM_INST_RETIRED.SPLIT_STORES/ #      0.0 %  tma_split_stores         (12.74%)
> >            619,775      cpu_core/MEM_LOAD_RETIRED.L1_MISS/                                        (9.56%)
> >        136,716,345      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/ #      0.9 %  tma_decoder0_alone       (11.15%)
> >                  0      cpu_core/INT_VEC_RETIRED.VNNI_128/                                        (12.74%)
> >            605,850      cpu_core/L1D_PEND_MISS.FB_FULL/  #      0.2 %  tma_fb_full              (12.73%)
> >             60,079      cpu_core/MEM_STORE_RETIRED.L2_HIT/                                        (11.14%)
> >        242,508,080      cpu_core/CPU_CLK_UNHALTED.THREAD/ #      4.2 %  tma_ports_utilized_2   
> >                                                   #      0.2 %  tma_store_fwd_blk      
> >                                                   #      0.0 %  tma_streaming_stores   
> >                                                   #     27.5 %  tma_unknown_branches   
> >                                                   #      0.0 %  tma_split_loads          (12.74%)
> >                  0      cpu_core/FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE,umask=0x3c/                                        (14.33%)
> >             32,573      cpu_core/LD_BLOCKS.STORE_FORWARD/                                        (12.74%)
> >              1,130      cpu_core/OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD/                                        (12.74%)
> >              4,029      cpu_core/MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS/                                        (9.56%)
> >          4,844,548      cpu_core/INST_DECODED.DECODERS,cmask=1/                                        (9.56%)
> >              5,266      cpu_core/MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD/                                        (6.37%)
> >                  0      cpu_core/UOPS_EXECUTED.X87/                                             (7.96%)
> >                  0      cpu_core/INT_VEC_RETIRED.MUL_256/                                        (9.56%)
> >          2,786,473      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/                                        (9.56%)
> >        961,614,001      cpu_core/CPU_CLK_UNHALTED.REF_TSC/                                        (11.15%)
> >          2,433,107      cpu_core/INST_DECODED.DECODERS,cmask=2/                                        (11.15%)
> >                  0      cpu_core/INT_VEC_RETIRED.ADD_128/                                        (12.74%)
> >          9,058,046      cpu_core/OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO/                                        (12.74%)
> >          6,399,992      cpu_core/MEM_INST_RETIRED.ALL_STORES/                                        (12.74%)
> >         45,519,749      cpu_core/L1D_PEND_MISS.PENDING/                                         (9.56%)
> >         12,200,559      cpu_core/DTLB_LOAD_MISSES.WALK_ACTIVE/                                        (7.97%)
> >        115,944,190      cpu_core/OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD/                                        (6.37%)
> >                  0      cpu_core/INT_VEC_RETIRED.VNNI_256/                                        (7.96%)
> >          1,885,278      cpu_core/INT_MISC.UOP_DROPPING/                                         (9.56%)
> >            524,819      cpu_core/MEM_LOAD_RETIRED.FB_HIT/                                        (9.56%)
> >         26,866,872      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (11.15%)
> >         10,265,977      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL/                                        (12.74%)
> >         66,662,934      cpu_core/INT_MISC.UNKNOWN_BRANCH_CYCLES/                                        (12.74%)
> >                  0      cpu_core/OCR.STREAMING_WR.ANY_RESPONSE/                                        (12.74%)
> >             12,499      cpu_core/MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD/                                        (12.74%)
> >                  0      cpu_core/INT_VEC_RETIRED.SHUFFLES/                                        (12.74%)
> >             47,649      cpu_core/DTLB_LOAD_MISSES.STLB_HIT,cmask=1/                                        (12.74%)
> >            106,424      cpu_core/L2_RQSTS.RFO_HIT/                                              (12.74%)
> >                  0      cpu_core/LD_BLOCKS.NO_SR/                                               (7.97%)
> >          1,343,692      cpu_core/MEM_LOAD_COMPLETED.L1_MISS_ANY/                                        (7.96%)
> >             28,517      cpu_core/L1D_PEND_MISS.L2_STALLS/                                        (6.37%)
> >            394,101      cpu_core/MEM_LOAD_RETIRED.L3_HIT/                                        (6.36%)
> >     76,860,165,929      TSC                                                                   
> > 
> >        1.004834399 seconds time elapsed
> > 
> > $ perf stat --metric-no-threshold --metric-no-group -M TopdownL5 -a sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >        839,538,302      cpu_core/TOPDOWN.SLOTS/          #      0.0 %  tma_avx_assists        
> >                                                   #      0.0 %  tma_fp_assists         
> >                                                   #      0.0 %  tma_page_faults        
> >                                                   #      0.0 %  tma_fp_vector_128b     
> >                                                   #      0.0 %  tma_fp_vector_256b       (32.40%)
> >        100,274,045      cpu_core/topdown-retiring/                                              (32.40%)
> >         77,425,642      cpu_core/topdown-bad-spec/                                              (32.40%)
> >        424,563,652      cpu_core/topdown-fe-bound/                                              (32.40%)
> >        245,420,564      cpu_core/topdown-be-bound/                                              (32.40%)
> >                  0      cpu_core/FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE/                                        (32.79%)
> >         54,372,921      cpu_core/RESOURCE_STALLS.SCOREBOARD/ #     22.2 %  tma_serializing_operation  (33.20%)
> >         23,018,585      cpu_core/UOPS_DISPATCHED.PORT_6/ #      8.0 %  tma_alu_op_utilization   (33.61%)
> >         17,748,101      cpu_core/UOPS_DISPATCHED.PORT_2_3_10/ #      4.2 %  tma_load_op_utilization  (34.02%)
> >                  0      cpu_core/FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE/                                        (34.43%)
> >          7,616,700      cpu_core/UOPS_DISPATCHED.PORT_0/                                        (34.83%)
> >             96,571      cpu_core/DTLB_STORE_MISSES.STLB_HIT,cmask=1/ #      0.6 %  tma_store_stlb_hit       (35.25%)
> >         84,909,672      cpu_core/CYCLE_ACTIVITY.CYCLES_MEM_ANY/ #      0.2 %  tma_load_stlb_hit        (35.66%)
> >         32,935,744      cpu_core/MEMORY_ACTIVITY.CYCLES_L1D_MISS/                                        (31.95%)
> >         16,597,385      cpu_core/UOPS_DISPATCHED.PORT_5_11/                                        (31.95%)
> >          9,452,844      cpu_core/UOPS_DISPATCHED.PORT_1/                                        (31.94%)
> >          2,620,695      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/ #      1.8 %  tma_store_stlb_miss      (31.95%)
> >         15,699,364      cpu_core/UOPS_DISPATCHED.PORT_7_8/ #      5.7 %  tma_store_op_utilization  (31.95%)
> >                  0      cpu_core/FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE/                                        (31.94%)
> >        142,096,670      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/                                        (31.95%)
> >        244,591,239      cpu_core/CPU_CLK_UNHALTED.THREAD/ #      5.2 %  tma_load_stlb_miss     
> >                                                   #      0.0 %  tma_mixing_vectors       (35.92%)
> >          2,728,385      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/                                        (35.66%)
> >                  0      cpu_core/ASSISTS.SSE_AVX_MIX/                                           (35.27%)
> >                  0      cpu_core/FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE/                                        (34.86%)
> >         12,664,768      cpu_core/DTLB_LOAD_MISSES.WALK_ACTIVE/                                        (34.46%)
> >         12,629,733      cpu_core/DTLB_LOAD_MISSES.WALK_ACTIVE/                                        (34.04%)
> >                  0      cpu_core/ASSISTS.FP/                                                    (33.63%)
> >                 12      cpu_core/ASSISTS.PAGE_FAULT/                                            (33.23%)
> >         16,704,699      cpu_core/UOPS_DISPATCHED.PORT_4_9/                                        (32.81%)
> >             48,386      cpu_core/DTLB_LOAD_MISSES.STLB_HIT,cmask=1/                                        (28.68%)
> > 
> >        1.002806967 seconds time elapsed
> > 
> > $ perf stat --metric-no-threshold --metric-no-group -M TopdownL6 -a sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >            743,684      cpu_core/UOPS_DISPATCHED.PORT_0/ #      4.6 %  tma_port_0             
> >              1,514      cpu_core/MISC2_RETIRED.LFENCE/   #      0.1 %  tma_memory_fence       
> >             22,120      cpu_core/CPU_CLK_UNHALTED.PAUSE/ #      0.1 %  tma_slow_pause         
> >         16,187,637      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/ #      4.5 %  tma_port_1             
> >                                                   #     12.6 %  tma_port_6             
> >         16,754,672      cpu_core/CPU_CLK_UNHALTED.THREAD/                                      
> >            728,805      cpu_core/UOPS_DISPATCHED.PORT_1/                                      
> >          2,040,181      cpu_core/UOPS_DISPATCHED.PORT_6/                                      
> > 
> >        1.002727371 seconds time elapse
> > '''
> > 
> > Using --cputype:
> > '''
> > $ perf stat --cputype=core -M TopdownL1 -a sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >         90,542,172      cpu_core/TOPDOWN.SLOTS/          #     31.3 %  tma_backend_bound      
> >                                                   #      7.0 %  tma_bad_speculation    
> >                                                   #     54.0 %  tma_frontend_bound     
> >                                                   #      7.6 %  tma_retiring           
> >          6,917,885      cpu_core/topdown-retiring/                                            
> >          6,242,227      cpu_core/topdown-bad-spec/                                            
> >          2,353,956      cpu_core/topdown-heavy-ops/                                           
> >         49,034,945      cpu_core/topdown-fe-bound/                                            
> >         28,390,484      cpu_core/topdown-be-bound/                                            
> >             98,299      cpu_core/INT_MISC.UOP_DROPPING/                                       
> > 
> >        1.002395582 seconds time elapsed
> > 
> > $ perf stat --cputype=atom -M TopdownL1 -a sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >            645,836      cpu_atom/TOPDOWN_RETIRING.ALL/   #     26.4 %  tma_bad_speculation    
> >          2,404,468      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #     38.9 %  tma_frontend_bound     
> >          1,455,604      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #     23.6 %  tma_backend_bound      
> >                                                   #     23.6 %  tma_backend_bound_aux  
> >          1,235,109      cpu_atom/CPU_CLK_UNHALTED.CORE/  #     10.4 %  tma_retiring           
> >            642,124      cpu_atom/TOPDOWN_RETIRING.ALL/                                        
> >          2,398,892      cpu_atom/TOPDOWN_FE_BOUND.ALL/                                        
> >          1,503,157      cpu_atom/TOPDOWN_BE_BOUND.ALL/                                        
> > 
> >        1.002061651 seconds time elapsed
> > '''
> > 
> > Ian Rogers (40):
> >   perf stat: Introduce skippable evsels
> >   perf vendor events intel: Add alderlake metric constraints
> >   perf vendor events intel: Add icelake metric constraints
> >   perf vendor events intel: Add icelakex metric constraints
> >   perf vendor events intel: Add sapphirerapids metric constraints
> >   perf vendor events intel: Add tigerlake metric constraints
> >   perf stat: Avoid segv on counter->name
> >   perf test: Test more sysfs events
> >   perf test: Use valid for PMU tests
> >   perf test: Mask config then test
> >   perf test: Test more with config_cache
> >   perf test: Roundtrip name, don't assume 1 event per name
> >   perf parse-events: Set attr.type to PMU type early
> >   perf print-events: Avoid unnecessary strlist
> >   perf parse-events: Avoid scanning PMUs before parsing
> >   perf test: Validate events with hyphens in
> >   perf evsel: Modify group pmu name for software events
> >   perf test: Move x86 hybrid tests to arch/x86
> >   perf test x86 hybrid: Don't assume evlist order
> >   perf parse-events: Support PMUs for legacy cache events
> >   perf parse-events: Wildcard legacy cache events
> >   perf print-events: Print legacy cache events for each PMU
> >   perf parse-events: Support wildcards on raw events
> >   perf parse-events: Remove now unused hybrid logic
> >   perf parse-events: Minor type safety cleanup
> >   perf parse-events: Add pmu filter
> >   perf stat: Make cputype filter generic
> >   perf test: Add cputype testing to perf stat
> >   perf test: Fix parse-events tests for >1 core PMU
> >   perf parse-events: Support hardware events as terms
> >   perf parse-events: Avoid error when assigning a term
> >   perf parse-events: Avoid error when assigning a legacy cache term
> >   perf parse-events: Don't auto merge hybrid wildcard events
> >   perf parse-events: Don't reorder atom cpu events
> >   perf metrics: Be PMU specific for referenced metrics.
> >   perf metric: Json flag to not group events if gathering a metric group
> >   perf stat: Command line PMU metric filtering
> >   perf vendor events intel: Correct alderlake metrics
> >   perf jevents: Don't rewrite metrics across PMUs
> >   perf metrics: Be PMU specific in event match
> > 
> >  tools/perf/arch/x86/include/arch-tests.h      |   1 +
> >  tools/perf/arch/x86/tests/Build               |   1 +
> >  tools/perf/arch/x86/tests/arch-tests.c        |  10 +
> >  tools/perf/arch/x86/tests/hybrid.c            | 275 ++++++
> >  tools/perf/arch/x86/util/evlist.c             |   4 +-
> >  tools/perf/builtin-list.c                     |  19 +-
> >  tools/perf/builtin-record.c                   |  13 +-
> >  tools/perf/builtin-stat.c                     |  73 +-
> >  tools/perf/builtin-top.c                      |   5 +-
> >  tools/perf/builtin-trace.c                    |   5 +-
> >  .../arch/x86/alderlake/adl-metrics.json       | 275 +++---
> >  .../arch/x86/alderlaken/adln-metrics.json     |  20 +-
> >  .../arch/x86/broadwell/bdw-metrics.json       |  12 +
> >  .../arch/x86/broadwellde/bdwde-metrics.json   |  12 +
> >  .../arch/x86/broadwellx/bdx-metrics.json      |  12 +
> >  .../arch/x86/cascadelakex/clx-metrics.json    |  12 +
> >  .../arch/x86/haswell/hsw-metrics.json         |  12 +
> >  .../arch/x86/haswellx/hsx-metrics.json        |  12 +
> >  .../arch/x86/icelake/icl-metrics.json         |  23 +
> >  .../arch/x86/icelakex/icx-metrics.json        |  23 +
> >  .../arch/x86/ivybridge/ivb-metrics.json       |  12 +
> >  .../arch/x86/ivytown/ivt-metrics.json         |  12 +
> >  .../arch/x86/jaketown/jkt-metrics.json        |  12 +
> >  .../arch/x86/sandybridge/snb-metrics.json     |  12 +
> >  .../arch/x86/sapphirerapids/spr-metrics.json  |  23 +
> >  .../arch/x86/skylake/skl-metrics.json         |  12 +
> >  .../arch/x86/skylakex/skx-metrics.json        |  12 +
> >  .../arch/x86/tigerlake/tgl-metrics.json       |  23 +
> >  tools/perf/pmu-events/jevents.py              |  10 +-
> >  tools/perf/pmu-events/metric.py               |  28 +-
> >  tools/perf/pmu-events/metric_test.py          |   6 +-
> >  tools/perf/pmu-events/pmu-events.h            |   2 +
> >  tools/perf/tests/evsel-roundtrip-name.c       | 119 ++-
> >  tools/perf/tests/parse-events.c               | 826 +++++++++---------
> >  tools/perf/tests/pmu-events.c                 |  12 +-
> >  tools/perf/tests/shell/stat.sh                |  44 +
> >  tools/perf/util/Build                         |   1 -
> >  tools/perf/util/evlist.h                      |   1 -
> >  tools/perf/util/evsel.c                       |  30 +-
> >  tools/perf/util/evsel.h                       |   1 +
> >  tools/perf/util/metricgroup.c                 | 111 ++-
> >  tools/perf/util/metricgroup.h                 |   3 +-
> >  tools/perf/util/parse-events-hybrid.c         | 214 -----
> >  tools/perf/util/parse-events-hybrid.h         |  25 -
> >  tools/perf/util/parse-events.c                | 646 ++++++--------
> >  tools/perf/util/parse-events.h                |  61 +-
> >  tools/perf/util/parse-events.l                | 108 +--
> >  tools/perf/util/parse-events.y                | 222 ++---
> >  tools/perf/util/pmu-hybrid.c                  |  20 -
> >  tools/perf/util/pmu-hybrid.h                  |   1 -
> >  tools/perf/util/pmu.c                         |  16 +-
> >  tools/perf/util/pmu.h                         |   3 +
> >  tools/perf/util/pmus.c                        |  25 +-
> >  tools/perf/util/pmus.h                        |   3 +
> >  tools/perf/util/print-events.c                |  85 +-
> >  tools/perf/util/stat-display.c                |   6 +-
> >  56 files changed, 1939 insertions(+), 1627 deletions(-)
> >  create mode 100644 tools/perf/arch/x86/tests/hybrid.c
> >  delete mode 100644 tools/perf/util/parse-events-hybrid.c
> >  delete mode 100644 tools/perf/util/parse-events-hybrid.h
> > 
> > -- 
> > 2.40.1.495.gc816e09b53d-goog
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
