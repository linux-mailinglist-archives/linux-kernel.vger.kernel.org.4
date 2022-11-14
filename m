Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21974628094
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbiKNNHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbiKNNHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:07:01 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935872AC71;
        Mon, 14 Nov 2022 05:06:59 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N9qML5RsKz15MTK;
        Mon, 14 Nov 2022 21:06:38 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 21:06:57 +0800
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 21:06:57 +0800
Message-ID: <d0a3ea62-e600-483c-a5d5-4584b9e464dd@huawei.com>
Date:   Mon, 14 Nov 2022 21:06:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] tracing: Fix potential null-pointer-access of entry in
 list 'tr->err_log'
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20221114104632.3547266-1-zhengyejian1@huawei.com>
 <20221114214649.ecc18c3ee3f74377ce80e66d@kernel.org>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20221114214649.ecc18c3ee3f74377ce80e66d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/14 20:46, Masami Hiramatsu (Google) wrote:
> On Mon, 14 Nov 2022 18:46:32 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> Entries in list 'tr->err_log' will be reused after entry number
>> exceed TRACING_LOG_ERRS_MAX.
>>
>> The cmd string of the to be reused entry will be freed first then
>> allocated a new one. If the allocation failed, then the entry will
>> still be in list 'tr->err_log' but its 'cmd' field is set to be NULL,
>> later access of 'cmd' is risky.
>>
>> Currently above problem can cause the loss of 'cmd' information of first
>> entry in 'tr->err_log'. When execute `cat /sys/kernel/tracing/error_log`,
>> reproduce logs like:
>>    [   37.495100] trace_kprobe: error: Maxactive is not for kprobe(null) ^
>>    [   38.412517] trace_kprobe: error: Maxactive is not for kprobe
>>      Command: p4:myprobe2 do_sys_openat2
>>              ^
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> BTW, I'm interested in how did you reproduce it. Did you inject a memory
> allocation failure to reproduce it?

Yes. I happended to find this problem when I was looking at the code, 
then I inject an allocation failure to proof it.

> 
> Thank you,
> 
>>
>> Fixes: 1581a884b7ca ("tracing: Remove size restriction on tracing_log_err cmd strings")
>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>> ---
>>   kernel/trace/trace.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 47a44b055a1d..5ae776598106 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -7802,6 +7802,7 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr,
>>   						   int len)
>>   {
>>   	struct tracing_log_err *err;
>> +	char *cmd;
>>   
>>   	if (tr->n_err_log_entries < TRACING_LOG_ERRS_MAX) {
>>   		err = alloc_tracing_log_err(len);
>> @@ -7810,12 +7811,12 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr,
>>   
>>   		return err;
>>   	}
>> -
>> +	cmd = kzalloc(len, GFP_KERNEL);
>> +	if (!cmd)
>> +		return ERR_PTR(-ENOMEM);
>>   	err = list_first_entry(&tr->err_log, struct tracing_log_err, list);
>>   	kfree(err->cmd);
>> -	err->cmd = kzalloc(len, GFP_KERNEL);
>> -	if (!err->cmd)
>> -		return ERR_PTR(-ENOMEM);
>> +	err->cmd = cmd;
>>   	list_del(&err->list);
>>   
>>   	return err;
>> -- 
>> 2.25.1
>>
> 
> 
