Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0505F682D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjAaNTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAaNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:19:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB962D4A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675171081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4bwdw1aSPYZ1pnRb1AP80waYO8ZcjQgvsJtbjc2ZE8=;
        b=SivkFE6aSzCA9aeeYoWDeI/2PAj/UoYn/OxaJ92vuryifY0xiaPNT0fWj/Fah5n2nYD/O+
        WDxZ3oC4I/D4sf+TYO3SrSB/dfMrl1AgF15D6uLt+Zo/oQSW9TbQFhT3HJ5iocD3uqKIx+
        Gmn2jfk9Pt/JXyfLMlEE0Tz/uoAs5eo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-144-KWjEXTL7PsCGwjvD8RrKbA-1; Tue, 31 Jan 2023 08:18:00 -0500
X-MC-Unique: KWjEXTL7PsCGwjvD8RrKbA-1
Received: by mail-qk1-f197.google.com with SMTP id a3-20020a05620a438300b007069b068069so9004725qkp.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4bwdw1aSPYZ1pnRb1AP80waYO8ZcjQgvsJtbjc2ZE8=;
        b=JtLVg44BT0m5AApIuqmoemlZ2fKOQNWF+1cvDIYqZa6+2Hu2jcrl1kBBnuGY2oOmlh
         07IvKvrSFj2NvBx0GHVtErXx+JhbYoy69SQdk4ILlN7pJ2QQ5m9F0OvY2yh495HDSAT9
         6k4VTu+8/h7qsxPh/9R+UWwrU1tuPOrYylVnO4HRBDjFq5xCRMFrsN2bffk+y8j2kkwB
         0pvXeO94yCG7fhWBSOftEg+FukDvnZ17nClWzxCfWgK8ICEGZmo2EtWNMxUUHYXtJhgW
         K8XDOk6OJAd1EPf8QM8bkp87z+NKySrDtip1D/MK/ZYrEIuGDC8AUgXHfZhgKnJo2NZB
         gbAA==
X-Gm-Message-State: AO0yUKXdBra2mRGAGPTj5kMHC0dng9KekKA3CZs6YFcxqBbFFadoUoXn
        pKlyV2D/jl90Lbeb+H5h2+JRb7b9zDVBI6f55u46xPv5ineImehQIhoShRiDfJYeoaIGNrHtY+g
        h2H7DijjETDz3mgXGWbLK7xhW
X-Received: by 2002:a05:622a:215:b0:3b9:b66a:2569 with SMTP id b21-20020a05622a021500b003b9b66a2569mr498716qtx.7.1675171080042;
        Tue, 31 Jan 2023 05:18:00 -0800 (PST)
X-Google-Smtp-Source: AK7set87ltHUQpsY7aACkxt04qwLLJLWImkbZ0WWvwja4PThcHH2OSExIMeBK3w6lfygc1WYOv+bTw==
X-Received: by 2002:a05:622a:215:b0:3b9:b66a:2569 with SMTP id b21-20020a05622a021500b003b9b66a2569mr498690qtx.7.1675171079768;
        Tue, 31 Jan 2023 05:17:59 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id d29-20020ac8615d000000b003b856b73e8bsm5300885qtm.16.2023.01.31.05.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:17:59 -0800 (PST)
Subject: Re: [PATCH] samples: ftrace: make some global variables static
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230130193708.1378108-1-trix@redhat.com>
 <Y9jo1SJpsBRTb2M5@FVFF77S0Q05N>
From:   Tom Rix <trix@redhat.com>
Message-ID: <159b128f-beee-a382-c2f7-bff39578ac8a@redhat.com>
Date:   Tue, 31 Jan 2023 05:17:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Y9jo1SJpsBRTb2M5@FVFF77S0Q05N>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/23 2:09 AM, Mark Rutland wrote:
> On Mon, Jan 30, 2023 at 11:37:08AM -0800, Tom Rix wrote:
>> smatch reports this representative issue
>> samples/ftrace/ftrace-ops.c:15:14: warning: symbol 'nr_function_calls' was not declared. Should it be static?
>>
>> The nr_functions_calls and several other global variables are only
>> used in ftrace-ops.c, so they should be static.
> This makes sense to me.
>
>> Remove the instances of initializing static int to 0.

Checkpatch complains loudly about the initializations, so I removed them.

bool is an int type and one of the things checkpatch caught.

Tom

> I appreciate that static variables get implicitly zero initialized, but
> dropping the initialization is inconsistent with the other control variables,
> and IMO it's quite confusing, so I'd prefer to keep that for clarity. I note
> you've also dropped the initialization of a bool to false, whereas the above
> just mentions int.
>
> I'd prefer to keep the initialization, but I'll defre to Steve if he thinks
> differently. :)
>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> With the above taken into account:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Thanks,
> Mark.
>
>> ---
>>   samples/ftrace/ftrace-ops.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
>> index 24deb51c7261..5e891a995dd3 100644
>> --- a/samples/ftrace/ftrace-ops.c
>> +++ b/samples/ftrace/ftrace-ops.c
>> @@ -12,7 +12,7 @@
>>    * Arbitrary large value chosen to be sufficiently large to minimize noise but
>>    * sufficiently small to complete quickly.
>>    */
>> -unsigned int nr_function_calls = 100000;
>> +static unsigned int nr_function_calls = 100000;
>>   module_param(nr_function_calls, uint, 0);
>>   MODULE_PARM_DESC(nr_function_calls, "How many times to call the relevant tracee");
>>   
>> @@ -21,7 +21,7 @@ MODULE_PARM_DESC(nr_function_calls, "How many times to call the relevant tracee"
>>    * be called directly or whether it's necessary to go via the list func, which
>>    * can be significantly more expensive.
>>    */
>> -unsigned int nr_ops_relevant = 1;
>> +static unsigned int nr_ops_relevant = 1;
>>   module_param(nr_ops_relevant, uint, 0);
>>   MODULE_PARM_DESC(nr_ops_relevant, "How many ftrace_ops to associate with the relevant tracee");
>>   
>> @@ -30,7 +30,7 @@ MODULE_PARM_DESC(nr_ops_relevant, "How many ftrace_ops to associate with the rel
>>    * tracers enabled for distinct functions can force the use of the list func
>>    * and incur overhead for all call sites.
>>    */
>> -unsigned int nr_ops_irrelevant = 0;
>> +static unsigned int nr_ops_irrelevant;
>>   module_param(nr_ops_irrelevant, uint, 0);
>>   MODULE_PARM_DESC(nr_ops_irrelevant, "How many ftrace_ops to associate with the irrelevant tracee");
>>   
>> @@ -38,15 +38,15 @@ MODULE_PARM_DESC(nr_ops_irrelevant, "How many ftrace_ops to associate with the i
>>    * On architectures with DYNAMIC_FTRACE_WITH_REGS, saving the full pt_regs can
>>    * be more expensive than only saving the minimal necessary regs.
>>    */
>> -bool save_regs = false;
>> +static bool save_regs;
>>   module_param(save_regs, bool, 0);
>>   MODULE_PARM_DESC(save_regs, "Register ops with FTRACE_OPS_FL_SAVE_REGS (save all registers in the trampoline)");
>>   
>> -bool assist_recursion = false;
>> +static bool assist_recursion;
>>   module_param(assist_recursion, bool, 0);
>>   MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RECURSION");
>>   
>> -bool assist_rcu = false;
>> +static bool assist_rcu;
>>   module_param(assist_rcu, bool, 0);
>>   MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RCU");
>>   
>> @@ -55,7 +55,7 @@ MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RCU");
>>    * overhead. Sometimes a consistency check using a more expensive tracer is
>>    * desireable.
>>    */
>> -bool check_count = false;
>> +static bool check_count;
>>   module_param(check_count, bool, 0);
>>   MODULE_PARM_DESC(check_count, "Check that tracers are called the expected number of times\n");
>>   
>> @@ -64,7 +64,7 @@ MODULE_PARM_DESC(check_count, "Check that tracers are called the expected number
>>    * runs, but sometimes it can be useful to leave them registered so that they
>>    * can be inspected through the tracefs 'enabled_functions' file.
>>    */
>> -bool persist = false;
>> +static bool persist;
>>   module_param(persist, bool, 0);
>>   MODULE_PARM_DESC(persist, "Successfully load module and leave ftrace ops registered after test completes\n");
>>   
>> @@ -114,8 +114,8 @@ static void ops_func_count(unsigned long ip, unsigned long parent_ip,
>>   	self->count++;
>>   }
>>   
>> -struct sample_ops *ops_relevant;
>> -struct sample_ops *ops_irrelevant;
>> +static struct sample_ops *ops_relevant;
>> +static struct sample_ops *ops_irrelevant;
>>   
>>   static struct sample_ops *ops_alloc_init(void *tracee, ftrace_func_t func,
>>   					 unsigned long flags, int nr)
>> @@ -163,8 +163,8 @@ static void ops_check(struct sample_ops *ops, int nr,
>>   	}
>>   }
>>   
>> -ftrace_func_t tracer_relevant = ops_func_nop;
>> -ftrace_func_t tracer_irrelevant = ops_func_nop;
>> +static ftrace_func_t tracer_relevant = ops_func_nop;
>> +static ftrace_func_t tracer_irrelevant = ops_func_nop;
>>   
>>   static int __init ftrace_ops_sample_init(void)
>>   {
>> -- 
>> 2.26.3
>>

