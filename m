Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDCD631D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiKUJyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiKUJxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:53:47 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C7FF59B;
        Mon, 21 Nov 2022 01:53:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VVKH0rx_1669024405;
Received: from 30.221.147.226(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VVKH0rx_1669024405)
          by smtp.aliyun-inc.com;
          Mon, 21 Nov 2022 17:53:28 +0800
Message-ID: <cd016aa9-d43d-c585-0b77-a2e112777ec1@linux.alibaba.com>
Date:   Mon, 21 Nov 2022 17:53:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [External] : [RFC PATCH v2 1/6] perf vendor events arm64: Add
 topdown L1 metrics for neoverse-n2
To:     John Garry <john.g.garry@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1668411720-3581-2-git-send-email-renyu.zj@linux.alibaba.com>
 <590ff032-d271-48ee-a4d8-141cc070c335@oracle.com>
 <f3823c3e-d45e-40ce-1981-e726b4b6be62@linux.alibaba.com>
 <f6e26e2d-2f10-e973-6c9f-47594da2fc99@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <f6e26e2d-2f10-e973-6c9f-47594da2fc99@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/15 下午7:19, John Garry 写道:
> On 15/11/2022 08:43, Jing Zhang wrote:
>> I didn't find out how to put the metric as an arch std event, it would be best if you could provide me with an example in the upstream code,
>> thank you very much.
> 
> As things stand, I don't think it's supported. We only support regular events for std arch events (and not metrics).
> 
> However we could expand support for metrics.
> 
> For the example of hip08 and FRONTEND_BOUND, we would have:
> 
> --->8---
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> index 6443a061e22a..5b1ca45224de 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> @@ -1,10 +1,6 @@
>  [
>      {
> -        "MetricExpr": "FETCH_BUBBLE / (4 * CPU_CYCLES)",
> -        "PublicDescription": "Frontend bound L1 topdown metric",
> -        "BriefDescription": "Frontend bound L1 topdown metric",
> -        "MetricGroup": "TopDownL1",
> -        "MetricName": "frontend_bound"
> +        "ArchStdEvent": "FRONTEND_BOUND"
>      },
>      {
>          "MetricExpr": "(INST_SPEC - INST_RETIRED) / (4 * CPU_CYCLES)",
> diff --git a/tools/perf/pmu-events/arch/arm64/sbsa.json b/tools/perf/pmu-events/arch/arm64/sbsa.json
> new file mode 100644
> index 000000000000..10b9c0cccc40
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/sbsa.json
> @@ -0,0 +1,9 @@
> +[
> +    {
> +        "MetricExpr": "FETCH_BUBBLE / (4 * CPU_CYCLES)",
> +        "PublicDescription": "Frontend bound L1 topdown metric",
> +        "BriefDescription": "Frontend bound L1 topdown metric",
> +        "MetricGroup": "TopDownL1",
> +        "MetricName": "FRONTEND_BOUND"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 0daa3e007528..77049853c0bf 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -352,6 +352,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
>        for event in read_json_events(item.path, topic=''):
>          if event.name:
>            _arch_std_events[event.name.lower()] = event
> +        if event.metric_name:
> +          _arch_std_events[event.metric_name.lower()] = event
> 
> 
>  def print_events_table_prefix(tblname: str) -> None:


Sorry for slow response.

I tried the method you provided, but it didn't work, is there any other steps I am missing?
Or is this method not currently supported?


diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics
index 8ff1dfe..2ad30ec 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
@@ -1,10 +1,6 @@
 [
     {
-        "MetricExpr": "(stall_slot_frontend - cpu_cycles) / (5 * cpu_cycles)",
-        "PublicDescription": "Frontend bound L1 topdown metric",
-        "BriefDescription": "Frontend bound L1 topdown metric",
-        "MetricGroup": "TopDownL1",
-        "MetricName": "frontend_bound"
+        "ArchStdEvent": "FRONTEND_BOUND"
     },


diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeli
index f9fae15..e8536e2 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
@@ -6,9 +6,6 @@
     {
         "ArchStdEvent": "STALL_BACKEND_MEM"
-    }
+    },
+    {
+        "MetricExpr": "(stall_slot_frontend - cpu_cycles) / (5 * cpu_cycles)",
+        "PublicDescription": "Frontend bound L1 topdown metric",
+        "BriefDescription": "Frontend bound L1 topdown metric",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "FRONTEND_BOUND"
+    }
 ]


diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 0daa3e0..7704985 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -352,6 +352,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
       for event in read_json_events(item.path, topic=''):
         if event.name:
           _arch_std_events[event.name.lower()] = event
+        if event.metric_name:
+          _arch_std_events[event.metric_name.lower()] = event


#./perf stat -e FRONTEND_BOUND sleep 1
event syntax error: 'FRONTEND_BOUND'
                     \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events



diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeli
index f9fae15..1089ca0 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
@@ -6,18 +6,24 @@
         "ArchStdEvent": "STALL_BACKEND"
     },
     {
-        "ArchStdEvent": "STALL_SLOT_FRONTEND"
+        "ArchStdEvent": "STALL_SLOT_FRONTEND",
+        "MetricExpr": "STALL_SLOT_FRONTEND - CPU_CYCLES"
     },
     {

#./perf stat -e stall_slot_frontend sleep 1
Add CPU_CYCLES event to groups to get metric expression for stall_slot_frontend

 Performance counter stats for 'sleep 1':

         5,125,457      stall_slot_frontend  //it's still the original value.

       1.001017680 seconds time elapsed

       0.001162000 seconds user
       0.000000000 seconds sys


Thanks,
Jing
