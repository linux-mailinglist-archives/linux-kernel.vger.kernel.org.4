Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC295E8D19
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 15:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiIXN0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 09:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiIXN0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 09:26:01 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833BA895EB
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 06:25:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chentao.kernel@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQa1A3M_1664025948;
Received: from 30.39.148.29(mailfrom:chentao.kernel@linux.alibaba.com fp:SMTPD_---0VQa1A3M_1664025948)
          by smtp.aliyun-inc.com;
          Sat, 24 Sep 2022 21:25:49 +0800
Message-ID: <0e3053c1-4a6b-987a-3bbd-1c01cdd31657@linux.alibaba.com>
Date:   Sat, 24 Sep 2022 21:25:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] tracing/eprobe: Fix alloc event dir failed when event
 name no set
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1663504148-40723-1-git-send-email-chentao.kernel@linux.alibaba.com>
 <20220923142914.3488abb9f60422f27584896e@kernel.org>
From:   Tao Chen <chentao.kernel@linux.alibaba.com>
In-Reply-To: <20220923142914.3488abb9f60422f27584896e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/9/23 下午1:29, Masami Hiramatsu (Google) 写道:
> On Sun, 18 Sep 2022 20:29:08 +0800
> Tao Chen <chentao.kernel@linux.alibaba.com> wrote:
> 
>> The event dir will alloc failed when event name no set, using the
>> command:
>> "echo "e:esys/ syscalls/sys_enter_openat file=\$filename:string"
>>>> dynamic_events"
>> It seems that dir name="syscalls/sys_enter_openat" is not allowed
>> in debugfs. So just use the "sys_enter_openat" as the event name.
> 
> Good catch!
> 
>>
>> Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace
>> events")
> 
> But actually, this code was introduced by below commit, so Fixes tag
> must be updated. (this is important because stable backport version
> will be decided by this tag.)
> 
> Fixes: 95c104c378dc ("tracing: Auto generate event name when creating a group of events")
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you!
> 
>> Signed-off-by: Tao Chen <chentao.kernel@linux.alibaba.com>
>> ---
>>   kernel/trace/trace_eprobe.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
>> index 1783e3478912..a8938e54cd34 100644
>> --- a/kernel/trace/trace_eprobe.c
>> +++ b/kernel/trace/trace_eprobe.c
>> @@ -968,8 +968,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>>   	}
>>   
>>   	if (!event) {
>> -		strscpy(buf1, argv[1], MAX_EVENT_NAME_LEN);
>> -		sanitize_event_name(buf1);
>> +		strscpy(buf1, sys_event, MAX_EVENT_NAME_LEN);
>>   		event = buf1;
>>   	}
>>   
>> -- 
>> 2.32.0
>>
> 
> 
Thank you for your review, i will change it in v2.
