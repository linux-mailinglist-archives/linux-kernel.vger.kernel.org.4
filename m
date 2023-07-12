Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554E1750B16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjGLOcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjGLOco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:32:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788081992;
        Wed, 12 Jul 2023 07:32:37 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R1Ks24TxHzPkB8;
        Wed, 12 Jul 2023 22:30:14 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 22:32:34 +0800
Subject: Re: [PATCH 2/5] perf evlist: Add evlist__findnew_tracking_event()
 helper
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230704074217.240939-1-yangjihong1@huawei.com>
 <20230704074217.240939-3-yangjihong1@huawei.com>
 <5882e592-641f-71cc-7a91-66f66b58d5a6@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <e77cf128-b8d2-9866-a80f-23ec46e2245b@huawei.com>
Date:   Wed, 12 Jul 2023 22:32:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5882e592-641f-71cc-7a91-66f66b58d5a6@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/7/11 21:13, Adrian Hunter wrote:
> On 4/07/23 10:42, Yang Jihong wrote:
>> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
>> tracking to the evlist. We may need to search for the dummy event for
>> some settings. Therefore, add evlist__findnew_tracking_event() helper.
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   tools/perf/builtin-record.c | 11 +++--------
>>   tools/perf/util/evlist.c    | 17 +++++++++++++++++
>>   tools/perf/util/evlist.h    |  1 +
>>   3 files changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index aec18db7ff23..8872cd037f2c 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1295,14 +1295,9 @@ static int record__open(struct record *rec)
>>   	 */
>>   	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>>   	    perf_pmus__num_core_pmus() > 1) {
>> -		pos = evlist__get_tracking_event(evlist);
>> -		if (!evsel__is_dummy_event(pos)) {
>> -			/* Set up dummy event. */
>> -			if (evlist__add_dummy(evlist))
>> -				return -ENOMEM;
>> -			pos = evlist__last(evlist);
>> -			evlist__set_tracking_event(evlist, pos);
>> -		}
>> +		pos = evlist__findnew_tracking_event(evlist);
>> +		if (!pos)
>> +			return -ENOMEM;
>>   
>>   		/*
>>   		 * Enable the dummy event when the process is forked for
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 7ef43f72098e..4621ddaeb8f3 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -1694,6 +1694,23 @@ void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_ev
>>   	tracking_evsel->tracking = true;
>>   }
>>   
>> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist)
>> +{
>> +	struct evsel *evsel;
>> +
>> +	evsel = evlist__get_tracking_event(evlist);
>> +	if (!evsel__is_dummy_event(evsel)) {
>> +		/* Set up dummy event. */
>> +		if (evlist__add_dummy(evlist))
> 
> evlist__add_dummy() does not exclude_kernel so it
> will end up relying on evsel__fallback() to work in
> cases where the user does not have kernel access.
> 
> evlist__add_aux_dummy() is probably better suited.
> Consequently perhaps pass system_wide as
> a parameter to evlist__findnew_tracking_event() and
> deal with that all inside evlist__findnew_tracking_event()
> 
OK. These two points will be modified in the next version.

Thanks,
Yang
