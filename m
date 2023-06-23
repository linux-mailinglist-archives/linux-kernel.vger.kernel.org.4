Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB973B00A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjFWF1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjFWF1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:27:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8089A1FF7;
        Thu, 22 Jun 2023 22:27:16 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QnQj372FRz1GF2P;
        Fri, 23 Jun 2023 13:27:03 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 13:27:12 +0800
Subject: Re: [PATCH RESEND v4 1/4] perf trace-event-info: Add
 tracepoint_id_to_name() helper
To:     Namhyung Kim <namhyung@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <anshuman.khandual@arm.com>,
        <jesussanp@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230613033946.103515-1-yangjihong1@huawei.com>
 <20230613033946.103515-2-yangjihong1@huawei.com>
 <CAM9d7cjyVgJiVT4Lf+qGd+d2es6NcoN3H42onpN_t4Ed0JHgig@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <f1a428a5-add2-1c1e-df32-78ee4a1cbe7c@huawei.com>
Date:   Fri, 23 Jun 2023 13:27:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjyVgJiVT4Lf+qGd+d2es6NcoN3H42onpN_t4Ed0JHgig@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/6/21 6:35, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Jun 12, 2023 at 8:41 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Add tracepoint_id_to_name() helper to search for the trace events directory
>> by given event id and return the corresponding tracepoint.
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>   tools/perf/util/trace-event-info.c | 11 +++++++++++
>>   tools/perf/util/trace-event.h      |  6 ++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
>> index c24b3a15e319..a7901f4a6654 100644
>> --- a/tools/perf/util/trace-event-info.c
>> +++ b/tools/perf/util/trace-event-info.c
>> @@ -466,6 +466,17 @@ static struct tracepoint_path *tracepoint_id_to_path(u64 config)
>>          return NULL;
>>   }
>>
>> +char *tracepoint_id_to_name(u64 config)
>> +{
>> +       struct tracepoint_path *path = tracepoint_id_to_path(config);
>> +       char *buf = NULL;
>> +
>> +       if (path && asprintf(&buf, "%s:%s", path->system, path->name) > 0)
>> +               return buf;
> 
> I think we need to call put_tracepoints_path() before return.

Yes, here need to free tracepoints path, will fix in next version.

Thanks,
Yang
