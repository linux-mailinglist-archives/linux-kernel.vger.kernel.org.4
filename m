Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDA9629344
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiKOIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKOIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:31:28 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865316580
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:31:26 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k15so13500881pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g30bH/0ivDnYW95TPAIrzo/Zs+p4nn/JKTft0SuQRw8=;
        b=7HOeVtkLulBGzohCH87MOdxnmeiFN/rdUE3UH2WQnjBy/pspcGpBA1BPF8O74fWj0P
         Q0H64ZpuNvJdD+V0RL9YNMVnq+KHx/fKfQ9+S3yAPnmz5RB4ypSfdsx7SMcIsRLB92hv
         ifrsedlUu1ya3FAMyXC8laNwYsqFmufELydbSpzo4YY9YsmWmGuWDsGxSczFLBlA260G
         0ncf42GUeTJjoZVHKjr5ZHy8FLc0A55L/B/2OpQI6CjWaYtUyVTTxTivtZWvSTuNH5+w
         UNpTp36kCPPQs//stOsO/Fz/5GEaZmZFGeew5s+vBUz/yokLugm62ffXWTAjLMS2HUxk
         6h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g30bH/0ivDnYW95TPAIrzo/Zs+p4nn/JKTft0SuQRw8=;
        b=dKljHL56WNGMuvShW/unwfsREQNUog6LzvjX7MImwoQUjzG2QRtgXJaUIi+u/ZkpTO
         6j+YB0J9zfA6oydGKoBhvph4v2JW0wMqJvwV/JmRYhygMu6zMk3Qgh842zJfCTM4VI57
         NszYZSHm2eIEqEHaD8R83YyObUHV3P0yTciI6wBcU17aY9CbaLJzOhrhuCKy9x02BDOp
         SyClsvuEcRcXCqEACtCrdikXtIgYCXkHJvqYV/X2qNftf/VbiLiYLIkJJ+72FeNSRP50
         4AB5Of4EcZolButONI08Z5wMaayT3VY/88bFOUnz7RXvafiU05sAIXbTibfvg15VF3NY
         So7g==
X-Gm-Message-State: ANoB5pktjj1ggvmcnseYm5WSLXrnkKWmOxFwS3IewkqZI/jnpEF1a4jz
        wI47ifmGpu1a8giu8JuqoVxURA==
X-Google-Smtp-Source: AA0mqf7rmTrPVbnP0EfqzVeAWLJ5vf+dNZm+RBEqtrm9UpFE6+d/OlFnF5Z51dDAiNpZqyM88vJxnw==
X-Received: by 2002:a62:b41a:0:b0:56e:ad31:b98b with SMTP id h26-20020a62b41a000000b0056ead31b98bmr17151967pfn.40.1668501085967;
        Tue, 15 Nov 2022 00:31:25 -0800 (PST)
Received: from [10.255.4.35] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id c65-20020a621c44000000b005624e2e0508sm8044725pfc.207.2022.11.15.00.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 00:31:25 -0800 (PST)
Message-ID: <2a049755-57cb-4943-0850-cbbf2537c97e@bytedance.com>
Date:   Tue, 15 Nov 2022 16:31:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v6 0/4] sched/fair: Improve scan efficiency of SIS
Content-Language: en-US
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
 <c7c5a654-8d26-28d9-7b33-e7b2b7bf2401@amd.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <c7c5a654-8d26-28d9-7b33-e7b2b7bf2401@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek, thanks very much for your detailed testing!

On 11/14/22 1:45 PM, K Prateek Nayak wrote:
> Hello Abel,
> 
> Sorry for the delay. I've tested the patch on a dual socket Zen3 system
> (2 x 64C/128T)
> 
> tl;dr
> 
> o I do not notice any regressions with the standard benchmarks.
> o schbench sees a nice improvement to the tail latency when the number
>    of worker are equal to the number of cores in the system in NPS1 and
>    NPS2 mode. (Marked with "^")
> o Few data points show improvements in tbench in NPS1 and NPS2 mode.
>    (Marked with "^")
> 
> I'm still in the process of running larger workloads. If there is any
> specific workload you would like me to run on the test system, please
> do let me know. Below is the detailed report:

Not particularly in my mind, and I think testing larger workloads is
great. Thanks!

> 
> Following are the results from running standard benchmarks on a
> dual socket Zen3 (2 x 64C/128T) machine configured in different
> NPS modes.
> 
> NPS Modes are used to logically divide single socket into
> multiple NUMA region.
> Following is the NUMA configuration for each NPS mode on the system:
> 
> NPS1: Each socket is a NUMA node.
>      Total 2 NUMA nodes in the dual socket machine.
> 
>      Node 0: 0-63,   128-191
>      Node 1: 64-127, 192-255
> 
> NPS2: Each socket is further logically divided into 2 NUMA regions.
>      Total 4 NUMA nodes exist over 2 socket.
>     
>      Node 0: 0-31,   128-159
>      Node 1: 32-63,  160-191
>      Node 2: 64-95,  192-223
>      Node 3: 96-127, 223-255
> 
> NPS4: Each socket is logically divided into 4 NUMA regions.
>      Total 8 NUMA nodes exist over 2 socket.
>     
>      Node 0: 0-15,    128-143
>      Node 1: 16-31,   144-159
>      Node 2: 32-47,   160-175
>      Node 3: 48-63,   176-191
>      Node 4: 64-79,   192-207
>      Node 5: 80-95,   208-223
>      Node 6: 96-111,  223-231
>      Node 7: 112-127, 232-255
> 
> Benchmark Results:
> 
> Kernel versions:
> - tip:          5.19.0 tip sched/core
> - sis_core: 	5.19.0 tip sched/core + this series
> 
> When we started testing, the tip was at:
> commit fdf756f71271 ("sched: Fix more TASK_state comparisons")
> 
> ~~~~~~~~~~~~~
> ~ hackbench ~
> ~~~~~~~~~~~~~
> 
> o NPS1
> 
> Test:			tip			sis_core
>   1-groups:	   4.06 (0.00 pct)	   4.26 (-4.92 pct)	*
>   1-groups:	   4.14 (0.00 pct)	   4.09 (1.20 pct)	[Verification Run]
>   2-groups:	   4.76 (0.00 pct)	   4.71 (1.05 pct)
>   4-groups:	   5.22 (0.00 pct)	   5.11 (2.10 pct)
>   8-groups:	   5.35 (0.00 pct)	   5.31 (0.74 pct)
> 16-groups:	   7.21 (0.00 pct)	   6.80 (5.68 pct)
> 
> o NPS2
> 
> Test:			tip			sis_core
>   1-groups:	   4.09 (0.00 pct)	   4.08 (0.24 pct)
>   2-groups:	   4.70 (0.00 pct)	   4.69 (0.21 pct)
>   4-groups:	   5.05 (0.00 pct)	   4.92 (2.57 pct)
>   8-groups:	   5.35 (0.00 pct)	   5.26 (1.68 pct)
> 16-groups:	   6.37 (0.00 pct)	   6.34 (0.47 pct)
> 
> o NPS4
> 
> Test:			tip			sis_core
>   1-groups:	   4.07 (0.00 pct)	   3.99 (1.96 pct)
>   2-groups:	   4.65 (0.00 pct)	   4.59 (1.29 pct)
>   4-groups:	   5.13 (0.00 pct)	   5.00 (2.53 pct)
>   8-groups:	   5.47 (0.00 pct)	   5.43 (0.73 pct)
> 16-groups:	   6.82 (0.00 pct)	   6.56 (3.81 pct)

Although each cpu will get 2.5 tasks when 16-groups, which can
be considered overloaded, I tested in AMD EPYC 7Y83 machine and
the total cpu usage was ~82% (with some older kernel version),
so there is still lots of idle time.

I guess cutting off at 16-groups is because it's enough loaded
compared to the real workloads, so testing more groups might just
be a waste of time?

Thanks & Best Regards,
	Abel

> 
> ~~~~~~~~~~~~
> ~ schbench ~
> ~~~~~~~~~~~~
> 
> o NPS1
> 
> #workers:	tip			sis_core
>    1:	  33.00 (0.00 pct)	  33.00 (0.00 pct)
>    2:	  35.00 (0.00 pct)	  35.00 (0.00 pct)
>    4:	  39.00 (0.00 pct)	  38.00 (2.56 pct)
>    8:	  49.00 (0.00 pct)	  48.00 (2.04 pct)
>   16:	  63.00 (0.00 pct)	  66.00 (-4.76 pct)
>   32:	 109.00 (0.00 pct)	 107.00 (1.83 pct)
>   64:	 208.00 (0.00 pct)	 216.00 (-3.84 pct)
> 128:	 559.00 (0.00 pct)	 469.00 (16.10 pct)     ^
> 256:	 45888.00 (0.00 pct)	 47552.00 (-3.62 pct)
> 512:	 80000.00 (0.00 pct)	 79744.00 (0.32 pct)
> 
> o NPS2
> 
> #workers:	=tip			sis_core
>    1:	  30.00 (0.00 pct)	  32.00 (-6.66 pct)
>    2:	  37.00 (0.00 pct)	  34.00 (8.10 pct)
>    4:	  39.00 (0.00 pct)	  36.00 (7.69 pct)
>    8:	  51.00 (0.00 pct)	  49.00 (3.92 pct)
>   16:	  67.00 (0.00 pct)	  66.00 (1.49 pct)
>   32:	 117.00 (0.00 pct)	 109.00 (6.83 pct)
>   64:	 216.00 (0.00 pct)	 213.00 (1.38 pct)
> 128:	 529.00 (0.00 pct)	 465.00 (12.09 pct)     ^
> 256:	 47040.00 (0.00 pct)	 46528.00 (1.08 pct)
> 512:	 84864.00 (0.00 pct)	 83584.00 (1.50 pct)
> 
> o NPS4
> 
> #workers:	tip			sis_core
>    1:	  23.00 (0.00 pct)	  28.00 (-21.73 pct)
>    2:	  28.00 (0.00 pct)	  36.00 (-28.57 pct)
>    4:	  41.00 (0.00 pct)	  43.00 (-4.87 pct)
>    8:	  60.00 (0.00 pct)	  48.00 (20.00 pct)
>   16:	  71.00 (0.00 pct)	  69.00 (2.81 pct)
>   32:	 117.00 (0.00 pct)	 115.00 (1.70 pct)
>   64:	 227.00 (0.00 pct)	 228.00 (-0.44 pct)
> 128:	 545.00 (0.00 pct)	 545.00 (0.00 pct)
> 256:	 45632.00 (0.00 pct)	 47680.00 (-4.48 pct)
> 512:	 81024.00 (0.00 pct)	 76416.00 (5.68 pct)
> 
> Note: For lower worker count, schbench can show run to
> run variation depending on external factors. Regression
> for lower worker count can be ignored. The results are
> included to spot any large blow up in the tail latency
> for larger worker count.
> 
> ~~~~~~~~~~
> ~ tbench ~
> ~~~~~~~~~~
> 
> o NPS1
> 
> Clients:	tip			sis_core
>      1	 578.37 (0.00 pct)	 582.09 (0.64 pct)
>      2	 1062.09 (0.00 pct)	 1063.95 (0.17 pct)
>      4	 1800.62 (0.00 pct)	 1879.18 (4.36 pct)
>      8	 3211.02 (0.00 pct)	 3220.44 (0.29 pct)
>     16	 4848.92 (0.00 pct)	 4890.08 (0.84 pct)
>     32	 9091.36 (0.00 pct)	 9721.13 (6.92 pct)     ^
>     64	 15454.01 (0.00 pct)	 15124.42 (-2.13 pct)
>    128	 3511.33 (0.00 pct)	 14314.79 (307.67 pct)
>    128    19910.99 (0.00pct)      19935.61 (0.12 pct)   [Verification Run]
>    256	 50019.32 (0.00 pct)	 50708.24 (1.37 pct)
>    512	 44317.68 (0.00 pct)	 44787.48 (1.06 pct)
>   1024	 41200.85 (0.00 pct)	 42079.29 (2.13 pct)
> 
> o NPS2
> 
> Clients:	tip			sis_core
>      1	 576.05 (0.00 pct)	 579.18 (0.54 pct)
>      2	 1037.68 (0.00 pct)	 1070.49 (3.16 pct)
>      4	 1818.13 (0.00 pct)	 1860.22 (2.31 pct)
>      8	 3004.16 (0.00 pct)	 3087.09 (2.76 pct)
>     16	 4520.11 (0.00 pct)	 4789.53 (5.96 pct)
>     32	 8624.23 (0.00 pct)	 9439.50 (9.45 pct)     ^
>     64	 14886.75 (0.00 pct)	 15004.96 (0.79 pct)
>    128	 20602.00 (0.00 pct)	 17730.31 (-13.93 pct) *
>    128    20602.00 (0.00 pct)     19585.20 (-4.93 pct)   [Verification Run]
>    256	 45566.83 (0.00 pct)	 47922.70 (5.17 pct)
>    512	 42717.49 (0.00 pct)	 43809.68 (2.55 pct)
>   1024	 40936.61 (0.00 pct)	 40787.71 (-0.36 pct)
> 
> o NPS4
> 
> Clients:	tip			sis_core
>      1	 576.36 (0.00 pct)	 580.83 (0.77 pct)
>      2	 1044.26 (0.00 pct)	 1066.50 (2.12 pct)
>      4	 1839.77 (0.00 pct)	 1867.56 (1.51 pct)
>      8	 3043.53 (0.00 pct)	 3115.17 (2.35 pct)
>     16	 5207.54 (0.00 pct)	 4847.53 (-6.91 pct)	*
>     16	 4722.56 (0.00 pct)	 4811.29 (1.87 pct)	[Verification Run]
>     32	 9263.86 (0.00 pct)	 9478.68 (2.31 pct)
>     64	 14959.66 (0.00 pct)	 15267.39 (2.05 pct)
>    128	 20698.65 (0.00 pct)	 20432.19 (-1.28 pct)
>    256	 46666.21 (0.00 pct)	 46664.81 (0.00 pct)
>    512	 41532.80 (0.00 pct)	 44241.12 (6.52 pct)
>   1024	 39459.49 (0.00 pct)	 41043.22 (4.01 pct)
> 
> Note: On the tested kernel, with 128 clients, tbench can
> run into a bottleneck during C2 exit. More details can be
> found at:
> https://lore.kernel.org/lkml/20220921063638.2489-1-kprateek.nayak@amd.com/
> This issue has been fixed in v6.0 but was not part of the
> tip kernel when I started testing. This data point has
> been rerun with C2 disabled to get representative results.
> 
> ~~~~~~~~~~
> ~ Stream ~
> ~~~~~~~~~~
> 
> o NPS1
> 
> -> 10 Runs:
> 
> Test:		tip			sis_core
>   Copy:	 328419.14 (0.00 pct)	 337857.83 (2.87 pct)
> Scale:	 206071.21 (0.00 pct)	 212133.82 (2.94 pct)
>    Add:	 235271.48 (0.00 pct)	 243811.97 (3.63 pct)
> Triad:	 253175.80 (0.00 pct)	 252333.43 (-0.33 pct)
> 
> -> 100 Runs:
> 
> Test:		tip			sis_core
>   Copy:	 328209.61 (0.00 pct)	 339817.27 (3.53 pct)
> Scale:	 216310.13 (0.00 pct)	 218635.16 (1.07 pct)
>    Add:	 244417.83 (0.00 pct)	 245641.47 (0.50 pct)
> Triad:	 237508.83 (0.00 pct)	 255387.28 (7.52 pct)
> 
> o NPS2
> 
> -> 10 Runs:
> 
> Test:		tip			sis_core
>   Copy:	 336503.88 (0.00 pct)	 339684.21 (0.94 pct)
> Scale:	 218035.23 (0.00 pct)	 217601.11 (-0.19 pct)
>    Add:	 257677.42 (0.00 pct)	 258608.34 (0.36 pct)
> Triad:	 268872.37 (0.00 pct)	 272548.09 (1.36 pct)
> 
> -> 100 Runs:
> 
> Test:		tip			sis_core
>   Copy:	 332304.34 (0.00 pct)	 341565.75 (2.78 pct)
> Scale:	 223421.60 (0.00 pct)	 224267.40 (0.37 pct)
>    Add:	 252363.56 (0.00 pct)	 254926.98 (1.01 pct)
> Triad:	 266687.56 (0.00 pct)	 270782.81 (1.53 pct)
> 
> o NPS4
> 
> -> 10 Runs:
> 
> Test:		tip			sis_core
>   Copy:	 353515.62 (0.00 pct)	 342060.85 (-3.24 pct)
> Scale:	 228854.37 (0.00 pct)	 218262.41 (-4.62 pct)
>    Add:	 254942.12 (0.00 pct)	 241975.90 (-5.08 pct)
> Triad:	 270521.87 (0.00 pct)	 257686.71 (-4.74 pct)
> 
> -> 100 Runs:
> 
> Test:		tip			sis_core
>   Copy:	 374520.81 (0.00 pct)	 369353.13 (-1.37 pct)
> Scale:	 246280.23 (0.00 pct)	 253881.69 (3.08 pct)
>    Add:	 262772.72 (0.00 pct)	 266484.58 (1.41 pct)
> Triad:	 283740.92 (0.00 pct)	 279981.18 (-1.32 pct)
> 
> On 10/19/2022 5:58 PM, Abel Wu wrote:
>> This patchset tries to improve SIS scan efficiency by recording idle
>> cpus in a cpumask for each LLC which will be used as a target cpuset
>> in the domain scan. The cpus are recorded at CORE granule to avoid
>> tasks being stack on same core.
>>
>> v5 -> v6:
>>   - Rename SIS_FILTER to SIS_CORE as it can only be activated when
>>     SMT is enabled and better describes the behavior of CORE granule
>>     update & load delivery.
>>   - Removed the part of limited scan for idle cores since it might be
>>     better to open another thread to discuss the strategies such as
>>     limited or scaled depth. But keep the part of full scan for idle
>>     cores when LLC is overloaded because SIS_CORE can greatly reduce
>>     the overhead of full scan in such case.
>>   - Removed the state of sd_is_busy which indicates an LLC is fully
>>     busy and we can safely skip the SIS domain scan. I would prefer
>>     leave this to SIS_UTIL.
>>   - The filter generation mechanism is replaced by in-place updates
>>     during domain scan to better deal with partial scan failures.
>>   - Collect Reviewed-bys from Tim Chen
>>
>> v4 -> v5:
>>   - Add limited scan for idle cores when overloaded, suggested by Mel
>>   - Split out several patches since they are irrelevant to this scope
>>   - Add quick check on ttwu_pending before core update
>>   - Wrap the filter into SIS_FILTER feature, suggested by Chen Yu
>>   - Move the main filter logic to the idle path, because the newidle
>>     balance can bail out early if rq->avg_idle is small enough and
>>     lose chances to update the filter.
>>
>> v3 -> v4:
>>   - Update filter in load_balance rather than in the tick
>>   - Now the filter contains unoccupied cpus rather than overloaded ones
>>   - Added mechanisms to deal with the false positive cases
>>
>> v2 -> v3:
>>   - Removed sched-idle balance feature and focus on SIS
>>   - Take non-CFS tasks into consideration
>>   - Several fixes/improvement suggested by Josh Don
>>
>> v1 -> v2:
>>   - Several optimizations on sched-idle balancing
>>   - Ignore asym topos in can_migrate_task
>>   - Add more benchmarks including SIS efficiency
>>   - Re-organize patch as suggested by Mel Gorman
>>
>> Abel Wu (4):
>>    sched/fair: Skip core update if task pending
>>    sched/fair: Ignore SIS_UTIL when has_idle_core
>>    sched/fair: Introduce SIS_CORE
>>    sched/fair: Deal with SIS scan failures
>>
>>   include/linux/sched/topology.h |  15 ++++
>>   kernel/sched/fair.c            | 122 +++++++++++++++++++++++++++++----
>>   kernel/sched/features.h        |   7 ++
>>   kernel/sched/sched.h           |   3 +
>>   kernel/sched/topology.c        |   8 ++-
>>   5 files changed, 141 insertions(+), 14 deletions(-)
>>
> 
> I ran pgbench from mmtest but realised there is too much run to run
> variation on the system. Planning on running MongoDB benchmark which
> is more stable on the system and couple more workloads but the
> initial results look good. I'll get back with results later this week
> or by early next week. Meanwhile, if you need data for any specific
> workload on the test system, please do let me know.
> 
> --
> Thanks and Regards,
> Prateek
