Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A61702778
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjEOImh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbjEOIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:42:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7985EC;
        Mon, 15 May 2023 01:42:25 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QKXq73GrszLq1c;
        Mon, 15 May 2023 16:39:31 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 16:42:23 +0800
Subject: Re: [PATCH v2 1/4] perf trace-event-info: Add tracepoint_id_to_name()
 helper
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <anshuman.khandual@arm.com>, <jesussanp@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230511075154.240163-1-yangjihong1@huawei.com>
 <20230511075154.240163-2-yangjihong1@huawei.com>
 <14f09d56-d4f1-8602-6a98-5588cbef8c81@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <6955e0df-5835-e79b-2ba4-cddc3bb7c976@huawei.com>
Date:   Mon, 15 May 2023 16:42:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <14f09d56-d4f1-8602-6a98-5588cbef8c81@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/5/12 18:33, Adrian Hunter wrote:
> On 11/05/23 10:51, Yang Jihong wrote:
>> Add tracepoint_id_to_name() helper to search for the trace events directory
>> by given event id and return the corresponding tracepoint.
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   tools/perf/util/trace-event-info.c | 11 +++++++++++
>>   tools/perf/util/trace-event.h      |  6 ++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
>> index c24b3a15e319..a5c65cb02a28 100644
>> --- a/tools/perf/util/trace-event-info.c
>> +++ b/tools/perf/util/trace-event-info.c
>> @@ -466,6 +466,17 @@ static struct tracepoint_path *tracepoint_id_to_path(u64 config)
>>   	return NULL;
>>   }
>>   
>> +char *tracepoint_id_to_name(u64 config)
>> +{
>> +	char *buf = NULL;
>> +	struct tracepoint_path *path = tracepoint_id_to_path(config);
> 
> It is considered slightly nicer to put local declarations
> in descending order of line length. i.e.
OK, will fix in v3.
> 
> 	struct tracepoint_path *path = tracepoint_id_to_path(config);
> 	char *buf = NULL;
> 
>> +
>> +	if ((path != NULL) && (asprintf(&buf, "%s:%s", path->system, path->name) > 0))
> 
> The parentheses are unnecessary and kernel style tends to avoid "!= NULL"
> i.e.
OK, will fix in v3.

Thanks,
Yang
