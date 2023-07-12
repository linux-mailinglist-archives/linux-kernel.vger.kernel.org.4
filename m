Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5388D750BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjGLPJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjGLPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:08:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2261FCC;
        Wed, 12 Jul 2023 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689174490; x=1720710490;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5CFiEMl7BqDo1OvWWAOo8ubtcAGSEuhwKZCoQaZtgwI=;
  b=UbIakJrftQp2dGMqO1++84qkTBfx4cAY+rFGg03nBQNIDC6/b40KqZo+
   f476E9idUUQbmza9CzaqBWcy1/8RAYVNebsRb3zTKWLY6N9js6xmeyITn
   ljifbjq2nYWQ+qfb7Epg7Qsnk06U2LAKPzk3RlJIjn7+sv/hW1cZZ65pD
   lhhAbOv7Z3rO4ioTXGa2pRv9hJ67i/brwWO7sMB96SE0F5Zo1u0iFWOTu
   EemicGkvUh5jlnJQdjT9kiw7dcpMPTGQsEOBV9nfQZB6GjTq5kw4H6FUG
   MXfbr3dbJjrFV8b8Dd7jOEN1hyTkmzHKKFYjXPqTQ2MJfTXIndEYV+hux
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367534224"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="367534224"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="721531738"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="721531738"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.166])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:04:00 -0700
Message-ID: <1d99287a-e76d-9beb-f795-da5e34ab10fe@intel.com>
Date:   Wed, 12 Jul 2023 18:03:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] perf record: Tracking side-band events for all CPUs
 when tracing selected CPUs
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230704074217.240939-1-yangjihong1@huawei.com>
 <20230704074217.240939-4-yangjihong1@huawei.com>
 <206972a3-d44d-1c75-3fbc-426427614543@intel.com>
 <747a2780-10d8-8094-3251-8e2c15f961b0@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <747a2780-10d8-8094-3251-8e2c15f961b0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/23 17:44, Yang Jihong wrote:
> Hello,
> 
> On 2023/7/11 21:13, Adrian Hunter wrote:
>> On 4/07/23 10:42, Yang Jihong wrote:
>>> User space tasks can migrate between CPUs, we need to track side-band
>>> events for all CPUs.
>>>
>>> The specific scenarios are as follows:
>>>
>>>           CPU0                                 CPU1
>>>    perf record -C 0 start
>>>                                taskA starts to be created and executed
>>>                                  -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>>>                                     events only deliver to CPU1
>>>                                ......
>>>                                  |
>>>                            migrate to CPU0
>>>                                  |
>>>    Running on CPU0    <----------/
>>>    ...
>>>
>>>    perf record -C 0 stop
>>>
>>> Now perf samples the PC of taskA. However, perf does not record the
>>> PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
>>> Therefore, the comm and symbols of taskA cannot be parsed.
>>>
>>> The sys_perf_event_open invoked is as follows:
>>>
>>>    # perf --debug verbose=3 record -e cpu-clock -C 1 true
>>>    <SNIP>
>>>    Opening: cpu-clock
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             1
>>>      size                             136
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>>>      read_format                      ID|LOST
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>>>    Opening: dummy:HG
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             1
>>>      size                             136
>>>      config                           0x9
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>>>      read_format                      ID|LOST
>>>      inherit                          1
>>>      mmap                             1
>>>      comm                             1
>>>      freq                             1
>>>      task                             1
>>>      sample_id_all                    1
>>>      mmap2                            1
>>>      comm_exec                        1
>>>      ksymbol                          1
>>>      bpf_event                        1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>>>    sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>>>    sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>>>    sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>>>    sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>>>    sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>>>    sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>>>    <SNIP>
>>>
>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>> ---
>>>   tools/perf/builtin-record.c | 31 +++++++++++++++++++++++++++++++
>>>   1 file changed, 31 insertions(+)
>>>
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index 8872cd037f2c..69e0d8c75aab 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -908,6 +908,31 @@ static int record__config_off_cpu(struct record *rec)
>>>       return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>>>   }
>>>   +static int record__config_tracking_events(struct record *rec)
>>> +{
>>> +    struct evsel *evsel;
>>> +    struct evlist *evlist = rec->evlist;
>>> +    struct record_opts *opts = &rec->opts;
>>> +
>>> +    /*
>>> +     * User space tasks can migrate between CPUs, so when tracing
>>> +     * selected CPUs, sideband for all CPUs is still needed.
>>> +     */
>>> +    if (opts->target.cpu_list) {
>>
>> I am not sure if anyone minds doing this by default, but perhaps
>> we should say something about it on the perf record man page.
>>
> Okay, will add comments to the man page.
> 
>>> +        evsel = evlist__findnew_tracking_event(evlist);
>>> +        if (!evsel)
>>> +            return -ENOMEM;
>>> +
>>> +        if (!evsel->core.system_wide) {
>>> +            evsel->core.system_wide = true;
>>> +            evsel__set_sample_bit(evsel, TIME);
>>> +            perf_evlist__propagate_maps(&evlist->core, &evsel->core);
>>> +        }
>>
>> Perhaps better to export via internel/evsel.h
>>
>> void perf_evsel__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *evsel)
>> {
>>     if (!evsel->system_wide) {
>>         evsel->system_wide = true;
>>         if (evlist->needs_map_propagation)
>>             __perf_evlist__propagate_maps(evlist, evsel);
>>     }
>> }
>>
>> As suggested in response to patch 2, perhaps deal with system_wide
>> inside evlist__findnew_tracking_event()
>>
> Okay, I'll modify it as above, so maybe we need to export perf_evlist__propagate_maps().
> 
> As mentioned in the patch 1, __perf_evlist__propagate_maps is low-level and avoid to export it.
> Or can we export perf_evsel__go_system_wide() via through internel/evlist.h?

Yes

> In this way, we do not need to export perf_evlist__propagate_maps().
> If so, would it be more appropriate to call perf_evlist__go_system_wide()?

Sure

> 
> Thanks,
> Yang

