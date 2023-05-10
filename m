Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E3F6FD8E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjEJIJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbjEJIJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:09:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1000630D8;
        Wed, 10 May 2023 01:09:41 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QGSKh5skLzLpYR;
        Wed, 10 May 2023 16:06:48 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 16:09:38 +0800
Subject: Re: [PATCH 1/4] perf trace-event-info: Add tracepoint_id_to_name()
 helper
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <anshuman.khandual@arm.com>, <jesussanp@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230419122912.73746-1-yangjihong1@huawei.com>
 <20230419122912.73746-2-yangjihong1@huawei.com>
 <07770bac-cbeb-170e-b3c1-d0276d4ffef3@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <6d03b9cc-31c8-37c3-3e82-504be8712dee@huawei.com>
Date:   Wed, 10 May 2023 16:09:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <07770bac-cbeb-170e-b3c1-d0276d4ffef3@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/5/10 15:48, Adrian Hunter wrote:
> On 19/04/23 15:29, Yang Jihong wrote:
>> Add tracepoint_id_to_name() helper to search for the trace events directory
>> by given event id and return the corresponding tracepoint.
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   tools/perf/util/trace-event-info.c | 13 +++++++++++++
>>   tools/perf/util/trace-event.h      |  6 ++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
>> index c24b3a15e319..79907caaf0ca 100644
>> --- a/tools/perf/util/trace-event-info.c
>> +++ b/tools/perf/util/trace-event-info.c
>> @@ -466,6 +466,19 @@ static struct tracepoint_path *tracepoint_id_to_path(u64 config)
>>   	return NULL;
>>   }
>>   
>> +char *tracepoint_id_to_name(u64 config)
>> +{
>> +	char buf[MAX_EVENT_LENGTH];
>> +	struct tracepoint_path *path = NULL;
> 
> Initializer should be tracepoint_id_to_path(config) i.e.
> 
OK, will fix in next version.

> 	struct tracepoint_path *path = tracepoint_id_to_path(config);
> 
>> +
>> +	path = tracepoint_id_to_path(config);
>> +	if (path == NULL)
>> +		return NULL;
>> +
>> +	snprintf(buf, sizeof(buf), "%s:%s", path->system, path->name);
> 
> asprintf() can be used then buf and strdup() are not needed.
> 
OK, will fix in next version.

Thanks for correcting.

Thanks,
Yang
