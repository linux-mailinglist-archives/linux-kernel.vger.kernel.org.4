Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAB16F325B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjEAO4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjEAO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:56:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9090F109;
        Mon,  1 May 2023 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682952977; x=1714488977;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qEe6DzqdWPvfuzvn99oj33FUI9k1naa8jNwjde4DIDk=;
  b=gnMnEukLjEZv18A9UZ4GiyIkBVgb7CoT9nK+8G9CRz9ugMIof9memTcO
   gUr8r6XwMSTRNmu6A5xe/ffTmMLHLeLGCDlzMsgWTmnWj815/XuwevTIx
   pHiV9dYgGmAtQLIQtevq4tD/aldGN29i9tfom6Qqx91BXpXdYvzpeu7KE
   s+fiL9leq/iGPpuqfz0wGkBlklAMK/8kBibQCDTMlxanS7r7vOeQNKjlh
   mj4HPJVXZSNrPkOMl1xoDV8vI8KI1VfCIXz/aubj5UkoPPoPSxBu6hyBQ
   02hlESVLzzZ3NTLSoNypx42/afogJGbypRqUGhrCk441P4W4RbDrXIX/W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="345632707"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="345632707"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="785279468"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="785279468"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 01 May 2023 07:56:16 -0700
Received: from [10.209.15.48] (kliang2-mobl1.ccr.corp.intel.com [10.209.15.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4797958088B;
        Mon,  1 May 2023 07:56:12 -0700 (PDT)
Message-ID: <d6784858-2a5f-7920-f1ac-d7ec9ed89605@linux.intel.com>
Date:   Mon, 1 May 2023 10:56:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 03/46] perf stat: Introduce skippable evsels
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
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
References: <20230429053506.1962559-1-irogers@google.com>
 <20230429053506.1962559-4-irogers@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230429053506.1962559-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-29 1:34 a.m., Ian Rogers wrote:
> Perf stat with no arguments will use default events and metrics. These
> events may fail to open even with kernel and hypervisor disabled. When
> these fail then the permissions error appears even though they were
> implicitly selected. This is particularly a problem with the automatic
> selection of the TopdownL1 metric group on certain architectures like
> Skylake:
> 
> '''
> $ perf stat true
> Error:
> Access to performance monitoring and observability operations is limited.
> Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> access to performance monitoring and observability operations for processes
> without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> More information can be found at 'Perf events and tool security' document:
> https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> perf_event_paranoid setting is 2:
>   -1: Allow use of (almost) all events by all users
>       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>> = 0: Disallow raw and ftrace function tracepoint access
>> = 1: Disallow CPU event access
>> = 2: Disallow kernel profiling
> To make the adjusted perf_event_paranoid setting permanent preserve it
> in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> '''
> 
> This patch adds skippable evsels that when they fail to open won't
> cause termination and will appear as "<not supported>" in output. The
> TopdownL1 events, from the metric group, are marked as skippable. This
> turns the failure above to:
> 
> '''
> $ perf stat perf bench internals synthesize
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 49.287 usec (+- 0.083 usec)
>   Average num. events: 3.000 (+- 0.000)
>   Average time per event 16.429 usec
>   Average data synthesis took: 49.641 usec (+- 0.085 usec)
>   Average num. events: 11.000 (+- 0.000)
>   Average time per event 4.513 usec
> 
>  Performance counter stats for 'perf bench internals synthesize':
> 
>           1,222.38 msec task-clock:u                     #    0.993 CPUs utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                162      page-faults:u                    #  132.529 /sec
>        774,445,184      cycles:u                         #    0.634 GHz                         (49.61%)
>      1,640,969,811      instructions:u                   #    2.12  insn per cycle              (59.67%)
>        302,052,148      branches:u                       #  247.102 M/sec                       (59.69%)
>          1,807,718      branch-misses:u                  #    0.60% of all branches             (59.68%)
>          5,218,927      CPU_CLK_UNHALTED.REF_XCLK:u      #    4.269 M/sec
>                                                   #     17.3 %  tma_frontend_bound
>                                                   #     56.4 %  tma_retiring
>                                                   #      nan %  tma_backend_bound
>                                                   #      nan %  tma_bad_speculation      (60.01%)
>        536,580,469      IDQ_UOPS_NOT_DELIVERED.CORE:u    #  438.965 M/sec                       (60.33%)
>    <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
>          5,223,936      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u #    4.274 M/sec                       (40.31%)
>        774,127,250      CPU_CLK_UNHALTED.THREAD:u        #  633.297 M/sec                       (50.34%)
>      1,746,579,518      UOPS_RETIRED.RETIRE_SLOTS:u      #    1.429 G/sec                       (50.12%)
>      1,940,625,702      UOPS_ISSUED.ANY:u                #    1.588 G/sec                       (49.70%)
> 
>        1.231055525 seconds time elapsed
> 
>        0.258327000 seconds user
>        0.965749000 seconds sys


Which branch is this patch series based on?

I still cannot get the same output as the examples.

I'm using the latest perf-tools-next (The latest commit ID is
5d27a645f609 ("perf tracepoint: Fix memory leak in is_valid_tracepoint()")).
I only applied patch 2 and patch 3, since the patch 1 is already merged.

It's a single socket Cascade Lake. with kernel 5.19-8.
$ uname -r
5.19.8-100.fc35.x86_64

As you can see, all the topdown related events are displayed twice.

With root permission,

$ sudo ./perf stat perf bench internals synthesize
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 91.487 usec (+- 0.050 usec)
  Average num. events: 47.000 (+- 0.000)
  Average time per event 1.947 usec
  Average data synthesis took: 97.720 usec (+- 0.059 usec)
  Average num. events: 245.000 (+- 0.000)
  Average time per event 0.399 usec

 Performance counter stats for 'perf bench internals synthesize':

          2,077.81 msec task-clock                       #    0.998 CPUs
utilized
               466      context-switches                 #  224.274 /sec
                 4      cpu-migrations                   #    1.925 /sec
               775      page-faults                      #  372.988 /sec
     9,561,957,326      cycles                           #    4.602 GHz
                       (31.17%)
    24,466,854,021      instructions                     #    2.56  insn
per cycle              (37.42%)
     5,547,892,196      branches                         #    2.670
G/sec                       (37.48%)
        37,880,526      branch-misses                    #    0.68% of
all branches             (37.52%)
        49,576,109      CPU_CLK_UNHALTED.REF_XCLK        #   23.860 M/sec
                                                  #     59.9 %  tma_retiring
                                                  #      4.6 %
tma_bad_speculation      (37.47%)
       228,406,003      INT_MISC.RECOVERY_CYCLES_ANY     #  109.926
M/sec                       (37.52%)
        49,591,815      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE #   23.867
M/sec                       (24.99%)
     9,553,472,893      CPU_CLK_UNHALTED.THREAD          #    4.598
G/sec                       (31.25%)
    22,893,372,651      UOPS_RETIRED.RETIRE_SLOTS        #   11.018
G/sec                       (31.23%)
    24,180,375,299      UOPS_ISSUED.ANY                  #   11.637
G/sec                       (31.25%)
        49,562,300      CPU_CLK_UNHALTED.REF_XCLK        #   23.853 M/sec
                                                  #     28.1 %
tma_frontend_bound
                                                  #      7.2 %
tma_backend_bound        (31.24%)
    10,735,205,084      IDQ_UOPS_NOT_DELIVERED.CORE      #    5.167
G/sec                       (31.30%)
       228,798,426      INT_MISC.RECOVERY_CYCLES_ANY     #  110.115
M/sec                       (25.04%)
        49,559,962      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE #   23.852
M/sec                       (25.00%)
     9,538,354,333      CPU_CLK_UNHALTED.THREAD          #    4.591
G/sec                       (31.29%)
    24,207,967,071      UOPS_ISSUED.ANY                  #   11.651
G/sec                       (31.24%)

       2.082670856 seconds time elapsed

       0.812763000 seconds user
       1.252387000 seconds sys


With non-root, nothing is counted for the topdownL1 events.

$ ./perf stat perf bench internals synthesize
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 91.852 usec (+- 0.139 usec)
  Average num. events: 47.000 (+- 0.000)
  Average time per event 1.954 usec
  Average data synthesis took: 96.230 usec (+- 0.046 usec)
  Average num. events: 245.000 (+- 0.000)
  Average time per event 0.393 usec

 Performance counter stats for 'perf bench internals synthesize':

          2,051.95 msec task-clock:u                     #    0.997 CPUs
utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
               765      page-faults:u                    #  372.816 /sec
     3,601,662,523      cycles:u                         #    1.755 GHz
                       (16.72%)
     9,241,811,003      instructions:u                   #    2.57  insn
per cycle              (33.43%)
     2,238,848,485      branches:u                       #    1.091
G/sec                       (50.06%)
        19,966,181      branch-misses:u                  #    0.89% of
all branches             (66.77%)
     <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
   <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
     <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
     <not counted>      CPU_CLK_UNHALTED.THREAD:u
     <not counted>      UOPS_RETIRED.RETIRE_SLOTS:u
     <not counted>      UOPS_ISSUED.ANY:u
     <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE:u
   <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
     <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
     <not counted>      CPU_CLK_UNHALTED.THREAD:u
     <not counted>      UOPS_ISSUED.ANY:u

       2.057691297 seconds time elapsed

       0.766640000 seconds user
       1.275170000 seconds sys


Thanks,
Kan

