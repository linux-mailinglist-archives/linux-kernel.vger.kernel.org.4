Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D216F391E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 22:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjEAUZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 16:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjEAUZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 16:25:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAF61FFD;
        Mon,  1 May 2023 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682972744; x=1714508744;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dSSFE7f/P6PcmnsEIgLI171TfEpCJk8AuOfpR+9LNgA=;
  b=gtd56SSStCo0oP5AuyRgCuoGTteZMtvkU5RaMbJ3IKQ3bH5iD6xl1XUE
   Onu7vp1WEbeooIdlNnQv+cN84sec6JRMHi6SkNGHP4qzPC1FZUlMdxu/B
   8vRy4LGlByii5ze1XI2cNpYr9n9RW1UHzx5AHqS0RkcdeLyCsHyWhGKGF
   dGTqPV++2udHaczV+cvtnwfZoui6yq1gNU/EXMh8ixyyg4m0wC8EQ1tOS
   9TTkpFCpBOUtBb9QntVqsORlktB+adbLA8DjMm223UVwpnj7/zG4MT8Qk
   eyNciVH7EQz0kzrz2AJ+P9TMb+XPiMJqRsSM9ob+VuOl4aimKZmNgivkA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="347039466"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="347039466"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 13:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="695901959"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="695901959"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2023 13:25:40 -0700
Received: from [10.209.15.48] (kliang2-mobl1.ccr.corp.intel.com [10.209.15.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 288A9580692;
        Mon,  1 May 2023 13:25:37 -0700 (PDT)
Message-ID: <a7020f11-3915-58e9-9d9e-792672ecbd61@linux.intel.com>
Date:   Mon, 1 May 2023 16:25:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 03/46] perf stat: Introduce skippable evsels
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Weilin Wang <weilin.wang@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
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
 <d6784858-2a5f-7920-f1ac-d7ec9ed89605@linux.intel.com>
 <CAP-5=fUtgEvgburjhE6HpazDh9dtn=DiSOwHaVnoE3N7sBynEw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUtgEvgburjhE6HpazDh9dtn=DiSOwHaVnoE3N7sBynEw@mail.gmail.com>
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



On 2023-05-01 11:29 a.m., Ian Rogers wrote:
> The events are displayed twice as there are 2 groups of events. This
> is changed by:
> https://lore.kernel.org/lkml/20230429053506.1962559-5-irogers@google.com/
> where the events are no longer grouped.

The trick seems don't work on a hybrid machine. I still got the
duplicate Topdown events on e-core.


         38,841.16 msec cpu-clock                        #   32.009 CPUs
utilized
               256      context-switches                 #    6.591 /sec
                33      cpu-migrations                   #    0.850 /sec
                84      page-faults                      #    2.163 /sec
        21,910,584      cpu_core/cycles/                 #  564.107 K/sec
       248,153,249      cpu_atom/cycles/                 #    6.389
M/sec                       (53.85%)
        27,463,908      cpu_core/instructions/           #  707.083 K/sec
       118,661,014      cpu_atom/instructions/           #    3.055
M/sec                       (63.06%)
         4,652,941      cpu_core/branches/               #  119.794 K/sec
        20,173,082      cpu_atom/branches/               #  519.374
K/sec                       (63.18%)
            72,727      cpu_core/branch-misses/          #    1.872 K/sec
         1,143,187      cpu_atom/branch-misses/          #   29.432
K/sec                       (63.51%)
       125,630,586      cpu_core/TOPDOWN.SLOTS/          #      nan %
tma_backend_bound
                                                  #      nan %  tma_retiring
                                                  #      0.0 %
tma_bad_speculation
                                                  #      nan %
tma_frontend_bound
        30,254,701      cpu_core/topdown-retiring/
       149,075,726      cpu_atom/TOPDOWN_RETIRING.ALL/   #    3.838 M/sec
                                                  #     14.8 %
tma_bad_speculation      (63.82%)
   <not supported>      cpu_core/topdown-bad-spec/
       523,614,383      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #   13.481 M/sec
                                                  #     42.0 %
tma_frontend_bound       (64.15%)
       385,502,477      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #    9.925 M/sec
                                                  #     30.9 %
tma_backend_bound
                                                  #     30.9 %
tma_backend_bound_aux    (64.39%)
       249,534,488      cpu_atom/CPU_CLK_UNHALTED.CORE/  #    6.424 M/sec
                                                  #     12.2 %
tma_retiring             (64.18%)
       151,729,465      cpu_atom/TOPDOWN_RETIRING.ALL/   #    3.906
M/sec                       (54.67%)
       530,621,769      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #   13.661
M/sec                       (54.30%)
   <not supported>      cpu_core/topdown-fe-bound/
       383,694,745      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #    9.879
M/sec                       (53.96%)
   <not supported>      cpu_core/topdown-be-bound/
           105,850      cpu_core/INT_MISC.UOP_DROPPING/  #    2.725 K/sec

       1.213449538 seconds time elapsed

Thanks,
Kan
