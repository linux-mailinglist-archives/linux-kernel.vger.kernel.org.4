Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C633871962A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjFAI65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjFAI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:58:55 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DAB124;
        Thu,  1 Jun 2023 01:58:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Vk4Q6ol_1685609922;
Received: from 30.221.149.38(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vk4Q6ol_1685609922)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 16:58:44 +0800
Message-ID: <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
Date:   Thu, 1 Jun 2023 16:58:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
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
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/31 下午9:18, John Garry 写道:
> On 30/05/2023 10:19, Jing Zhang wrote:
>> The jevent "Compat" is used for uncore PMU alias or metric definitions.
>>
>> The same PMU driver has different PMU identifiers due to different hardware
>> versions and types, but they may have some common PMU event/metric. Since a
>> Compat value can only match one identifier, when adding the same event
>> alias and metric to PMUs with different identifiers, each identifier needs
>> to be defined once, which is not streamlined enough.
>>
>> So let "Compat" value supports matching multiple identifiers. For example,
>> the Compat value "arm_cmn600;arm_cmn700;arm_ci700" can match the PMU
>> identifier "arm_cmn600X" or "arm_cmn700X" or "arm_ci700X", where "X" is a
>> wildcard.
> 
> From checking the driver, it seems that we have model names "arm_cmn600" and "arm_cmn650". Are you saying that "arm_cmn600X" would match for those? I am most curious about how "arm_cmn600X" matches "arm_cmn650".
> 

Hi John,

From patch #1 we have identifiers "arm_cmn600_0" and "arm_cmn650_0" etc. The identifier consists of model_name and revision.
The compatible value "arm_cmn600;arm_cmn650" can match the identifier "arm_cmn600_0" or "arm_cmn650_0". Maybe the message log
is not clear enough.

For example in patch #3 the metric "slc_miss_rate" is a generic metric for cmn-any. So we can define:

+	{
+		"MetricName": "slc_miss_rate",
+		"BriefDescription": "The system level cache miss rate include.",
+		"MetricGroup": "arm_cmn",
+		"MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
+		"ScaleUnit": "100%",
+		"Unit": "arm_cmn",
+		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
+	},


It can match identifiers "arm_cmn600_{0,1,2..X}" or "arm_cmn650_{0,1,2..X}" or "arm_cmn700_{0,1,2..X}" or "arm_ci700_{ 0,1,2..X}".
In other words, it can match all identifiers prefixed with “arm_cmn600” or “arm_cmn650” or “arm_cmn700” or “arm_ci700”.

If a new model arm_cmn driver with identifier "arm_cmn750_0", it will not be matched, but if a new revision arm_cmn driver with identifier
"arm_cmn700_4", it can be matched.


>> Tokens in Unit field are delimited by ';'.
> 
> Thanks for taking a stab at solving this problem.
> 
> I have to admit that I am not the biggest fan of having multiple values to match in the "Compat" value possibly for every event. It doesn't really scale.
> 
> I would hope that there are at least some events which we are guaranteed to always be present. From what Robin said on the v2 series, for the implementations which we care about, events are generally added per subsequent version. So we should have some base set of fixed events.
> 
> If we are confident that we have a fixed set of base set of events, can we ensure that those events would not require this compat string which needs each version explicitly stated?
> 

If we are sure that some events will always exist in subsequent versions, we can set the Compat field to "arm_cmn;arm_ci". After that,
whether it is a different model or a different revision of the cmn PMU, it will be compatible. That is, it matches all whose identifier
is prefixed with “arm_cmn” or “arm_ci”.

Maybe it's not a perfect solution yet, looking forward to your suggestions.


Thanks,
Jing


> Robin, please let us know what you think of this.
> 
> Thanks,
> John
> 
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>   tools/perf/util/metricgroup.c | 24 +++++++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index f3559be..c12ccd9 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -456,6 +456,28 @@ struct metricgroup_iter_data {
>>       void *data;
>>   };
>>   +static bool match_pmu_identifier(const char *id, const char *compat)
>> +{
>> +    char *tmp = NULL, *tok, *str;
>> +    bool res;
>> +
>> +    str = strdup(compat);
>> +    if (!str)
>> +        return false;
>> +
>> +    tok = strtok_r(str, ";", &tmp);
>> +    for (; tok; tok = strtok_r(NULL, ";", &tmp)) {
>> +        if (!strncmp(id, tok, strlen(tok))) {
>> +            res = true;
>> +            goto out;
>> +        }
>> +    }
>> +    res = false;
>> +out:
>> +    free(str);
>> +    return res;
>> +}
>> +
>>   static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
>>                          const struct pmu_metrics_table *table,
>>                          void *data)
>> @@ -468,7 +490,7 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
>>         while ((pmu = perf_pmu__scan(pmu))) {
>>   -        if (!pmu->id || strcmp(pmu->id, pm->compat))
>> +        if (!pmu->id || !match_pmu_identifier(pmu->id, pm->compat))
>>               continue;
>>             return d->fn(pm, table, d->data);
