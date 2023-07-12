Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AC0750B40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjGLOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjGLOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:44:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04809BB;
        Wed, 12 Jul 2023 07:44:26 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R1L5Z16XdzMqcq;
        Wed, 12 Jul 2023 22:41:06 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 22:44:22 +0800
Subject: Re: [PATCH 3/5] perf record: Tracking side-band events for all CPUs
 when tracing selected CPUs
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230704074217.240939-1-yangjihong1@huawei.com>
 <20230704074217.240939-4-yangjihong1@huawei.com>
 <206972a3-d44d-1c75-3fbc-426427614543@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <747a2780-10d8-8094-3251-8e2c15f961b0@huawei.com>
Date:   Wed, 12 Jul 2023 22:44:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <206972a3-d44d-1c75-3fbc-426427614543@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/7/11 21:13, Adrian Hunter wrote:
> On 4/07/23 10:42, Yang Jihong wrote:
>> User space tasks can migrate between CPUs, we need to track side-band
>> events for all CPUs.
>>
>> The specific scenarios are as follows:
>>
>>           CPU0                                 CPU1
>>    perf record -C 0 start
>>                                taskA starts to be created and executed
>>                                  -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>>                                     events only deliver to CPU1
>>                                ......
>>                                  |
>>                            migrate to CPU0
>>                                  |
>>    Running on CPU0    <----------/
>>    ...
>>
>>    perf record -C 0 stop
>>
>> Now perf samples the PC of taskA. However, perf does not record the
>> PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
>> Therefore, the comm and symbols of taskA cannot be parsed.
>>
>> The sys_perf_event_open invoked is as follows:
>>
>>    # perf --debug verbose=3 record -e cpu-clock -C 1 true
>>    <SNIP>
>>    Opening: cpu-clock
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             1
>>      size                             136
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>>      read_format                      ID|LOST
>>      disabled                         1
>>      inherit                          1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>>    Opening: dummy:HG
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             1
>>      size                             136
>>      config                           0x9
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>>      read_format                      ID|LOST
>>      inherit                          1
>>      mmap                             1
>>      comm                             1
>>      freq                             1
>>      task                             1
>>      sample_id_all                    1
>>      mmap2                            1
>>      comm_exec                        1
>>      ksymbol                          1
>>      bpf_event                        1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>>    sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>>    sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>>    sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>>    sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>>    sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>>    sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>>    <SNIP>
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   tools/perf/builtin-record.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 8872cd037f2c..69e0d8c75aab 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -908,6 +908,31 @@ static int record__config_off_cpu(struct record *rec)
>>   	return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>>   }
>>   
>> +static int record__config_tracking_events(struct record *rec)
>> +{
>> +	struct evsel *evsel;
>> +	struct evlist *evlist = rec->evlist;
>> +	struct record_opts *opts = &rec->opts;
>> +
>> +	/*
>> +	 * User space tasks can migrate between CPUs, so when tracing
>> +	 * selected CPUs, sideband for all CPUs is still needed.
>> +	 */
>> +	if (opts->target.cpu_list) {
> 
> I am not sure if anyone minds doing this by default, but perhaps
> we should say something about it on the perf record man page.
> 
Okay, will add comments to the man page.

>> +		evsel = evlist__findnew_tracking_event(evlist);
>> +		if (!evsel)
>> +			return -ENOMEM;
>> +
>> +		if (!evsel->core.system_wide) {
>> +			evsel->core.system_wide = true;
>> +			evsel__set_sample_bit(evsel, TIME);
>> +			perf_evlist__propagate_maps(&evlist->core, &evsel->core);
>> +		}
> 
> Perhaps better to export via internel/evsel.h
> 
> void perf_evsel__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *evsel)
> {
> 	if (!evsel->system_wide) {
> 		evsel->system_wide = true;
> 		if (evlist->needs_map_propagation)
> 			__perf_evlist__propagate_maps(evlist, evsel);
> 	}
> }
> 
> As suggested in response to patch 2, perhaps deal with system_wide
> inside evlist__findnew_tracking_event()
> 
Okay, I'll modify it as above, so maybe we need to export 
perf_evlist__propagate_maps().

As mentioned in the patch 1, __perf_evlist__propagate_maps is low-level 
and avoid to export it.
Or can we export perf_evsel__go_system_wide() via through internel/evlist.h?
In this way, we do not need to export perf_evlist__propagate_maps().
If so, would it be more appropriate to call perf_evlist__go_system_wide()?

Thanks,
Yang
