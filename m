Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA28765187D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 02:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiLTBrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 20:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiLTBqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 20:46:39 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E01F12AEA;
        Mon, 19 Dec 2022 17:40:08 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NbfPH67TJzmWgw;
        Tue, 20 Dec 2022 09:38:59 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 09:40:05 +0800
Message-ID: <ed4ea9ae-78bf-b323-9380-47b1fd58c72b@huawei.com>
Date:   Tue, 20 Dec 2022 09:40:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing: Add a way to filter function addresses to
 function names
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Tom Zanussi <zanussi@kernel.org>
References: <20221214125209.09d736dd@gandalf.local.home>
 <68fa6a9d-7a7f-00ba-e5a2-9b64f0aa7db3@huawei.com>
 <20221219132102.0dc6b7b9@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20221219132102.0dc6b7b9@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/20 02:21, Steven Rostedt wrote:
> On Mon, 19 Dec 2022 10:38:50 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>>> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
>>> index 33e0b4f8ebe6..db6e2f399440 100644
>>> --- a/kernel/trace/trace_events.c
>>> +++ b/kernel/trace/trace_events.c
>>> @@ -2822,7 +2822,7 @@ static __init int setup_trace_triggers(char *str)
>>>    		if (!trigger)
>>>    			break;
>>>    		bootup_triggers[i].event = strsep(&trigger, ".");
>>> -		bootup_triggers[i].trigger = strsep(&trigger, ".");
>>> +		bootup_triggers[i].trigger = strsep(&trigger, "");
>>
>> Would it be better to change to:
>>
>>        bootup_triggers[i].trigger = trigger;
>>
> 
> Sure, I'll make the update.
> 
>> Because there is unnecessary loop if call strsep(s, "") :-)
>>     strsep(s, ct) {
>>       strpbrk(cs, ct) {
>>         // when 'ct' is empty string, here will always return NULL
>>         // after traversing string 'cs'
> 
> I'm not sure what you mean about an extra loop.

I just mean above "traversing string 'cs'" in strpbrk(s, "") is 
unnecessary. Sorry for making the ambiguity :-(

> 
> Thanks,
> 
> -- Steve
> 
