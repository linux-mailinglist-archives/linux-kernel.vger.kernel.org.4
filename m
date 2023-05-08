Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6D76FABB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjEHLQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjEHLQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:16:15 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C937019;
        Mon,  8 May 2023 04:16:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vi4Yqgi_1683544567;
Received: from 30.221.149.87(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vi4Yqgi_1683544567)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 19:16:09 +0800
Message-ID: <68bfb845-5b65-73a6-aa37-6262604d5171@linux.alibaba.com>
Date:   Mon, 8 May 2023 19:16:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/5] perf vendor events: Add JSON metrics for CMN-700
To:     John Garry <john.g.garry@oracle.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Will Deacon <will@kernel.org>
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1682329456-19418-3-git-send-email-renyu.zj@linux.alibaba.com>
 <75c36607-9cdd-42fe-b3f3-bb049b3eb223@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <75c36607-9cdd-42fe-b3f3-bb049b3eb223@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/1 下午8:27, John Garry 写道:
> On 24/04/2023 10:44, Jing Zhang wrote:
>> Add JSON metrics for CMN-700. Currently just add part of CMN-700 PMU
>> metrics which are general and compatible for any SoC.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>   .../arch/arm64/arm/cmn700/sys/metrics.json         | 74 ++++++++++++++++++++++
>>   tools/perf/pmu-events/jevents.py                   |  1 +
>>   2 files changed, 75 insertions(+)
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json
>> new file mode 100644
>> index 0000000..1577d86
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json
> 
> I suppose putting these here is ok. Are all these events a must for a CMN-700 implementation? Is there potential for impdef event in some implementations?
> 

Yes, according it's driver code, all these events are a must for a CMN-700 implementation even in different revision. But if the revision is added
as an identifier, then these metrics need to be defined for each revision. This doesn't seem lean enough. So I also need to consider how to
match the common metrics of multiple rivisions. Could you provide some suggestions?

> Previously we considered ARM PMCG events would be put in a per-SoC sys folder only (and not in perf/pmu-events/arch/arm64/arm)
> 
>> @@ -0,0 +1,74 @@
>> +[
>> +    {
>> +        "MetricName": "slc_miss_rate",
>> +        "BriefDescription": "The system level cache miss rate include.",
>> +        "MetricGroup": "cmn700",
>> +        "MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
>> +        "ScaleUnit": "100%",
>> +        "Unit": "arm_cmn",
>> +        "Compat": "cmn700"
>> +    },
>> +    {
>> +        "MetricName": "hnf_message_retry_rate",
>> +        "BriefDescription": "HN-F message retry rate indicates whether a lack of credits is causing the bottlenecks.",
>> +        "MetricGroup": "cmn700",
>> +        "MetricExpr": "hnf_pocq_retry / hnf_pocq_reqs_recvd",
>> +        "ScaleUnit": "100%",
>> +        "Unit": "arm_cmn",
>> +        "Compat": "cmn700"
>> +    },
>> +    {
>> +        "MetricName": "sf_hit_rate",
>> +        "BriefDescription": "Snoop filter hit rate can be used to measure the Snoop Filter efficiency.",
>> +        "MetricGroup": "cmn700",
>> +        "MetricExpr": "hnf_sf_hit / hnf_slc_sf_cache_access",
>> +        "ScaleUnit": "100%",
>> +        "Unit": "arm_cmn",
>> +        "Compat": "cmn700"
>> +    },
>> +    {
>> +        "MetricName": "mc_message_retry_rate",
>> +        "BriefDescription": "The memory controller request retries rate indicates whether the memory controller is the bottleneck.",
>> +        "MetricGroup": "cmn700",
>> +        "MetricExpr": "hnf_mc_retries / hnf_mc_reqs",
>> +        "ScaleUnit": "100%",
>> +        "Unit": "arm_cmn",
>> +        "Compat": "cmn700"
>> +    },
>> +    {
>> +        "MetricName": "rni_actual_read_bandwidth.all",
>> +        "BriefDescription": "This event measure the actual bandwidth(MB/sec) that RN-I bridge sends to the interconnect.",
>> +        "MetricGroup": "cmn700",
>> +        "MetricExpr": "rnid_rxdat_flits * 32 / 1e6 / duration_time",
>> +        "ScaleUnit": "1MB/s",
>> +        "Unit": "arm_cmn",
>> +        "Compat": "cmn700"
>> +    },
>> +    {
>> +        "MetricName": "rni_actual_write_bandwidth.all",
>> +        "BriefDescription": "This event measures the actual write bandwidth(MB/sec) at RN-I bridges.",
>> +        "MetricGroup": "cmn700",
>> +        "MetricExpr": "rnid_txdat_flits * 32 / 1e6 / duration_time",
>> +        "ScaleUnit": "1MB/s",
>> +        "Unit": "arm_cmn",
>> +        "Compat": "cmn700"
>> +    },
>> +    {
>> +        "MetricName": "rni_retry_rate",
>> +        "BriefDescription": "RN-I bridge retry rate indicates whether the memory controller is the bottleneck.",
>> +        "MetricGroup": "cmn700",
>> +        "MetricExpr": "rnid_txreq_flits_retried / rnid_txreq_flits_total",
>> +        "ScaleUnit": "100%",
>> +        "Unit": "arm_cmn",
>> +        "Compat": "cmn700"
>> +    },
>> +    {
>> +        "MetricName": "sbsx_actual_write_bandwidth.all",
>> +        "BriefDescription": "sbsx actual write bandwidth(MB/sec).",
>> +        "MetricGroup": "cmn700",
>> +        "MetricExpr": "sbsx_txdat_flitv * 32 / 1e6 / duration_time",
>> +        "ScaleUnit": "1MB/s",
>> +        "Unit": "arm_cmn",
>> +        "Compat": "cmn700"
>> +    }
>> +]
>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>> index 2bcd07c..7cff2c6 100755
>> --- a/tools/perf/pmu-events/jevents.py
>> +++ b/tools/perf/pmu-events/jevents.py
>> @@ -256,6 +256,7 @@ class JsonEvent:
>>             'DFPMC': 'amd_df',
>>             'cpu_core': 'cpu_core',
>>             'cpu_atom': 'cpu_atom',
>> +          'arm_cmn': 'arm_cmn',
>>         }
>>         return table[unit] if unit in table else f'uncore_{unit.lower()}'
>>   
