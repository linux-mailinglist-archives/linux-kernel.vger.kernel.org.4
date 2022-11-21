Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFBE631B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiKUITP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKUITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:19:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF519C2E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:19:12 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NG0Yx2LTWzqSbJ;
        Mon, 21 Nov 2022 16:15:17 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 16:19:10 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 16:19:09 +0800
Subject: Re: [PATCH v2] tracing: Fix infinite loop in tracing_read_pipe on
 overflowed print_trace_line
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221118102521.62362-1-yangjihong1@huawei.com>
 <20221120143852.7e84b50d@rorschach.local.home>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <befaafc6-ff84-3b98-87fd-1d85b322f330@huawei.com>
Date:   Mon, 21 Nov 2022 16:19:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221120143852.7e84b50d@rorschach.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/11/21 3:38, Steven Rostedt wrote:
> On Fri, 18 Nov 2022 18:25:21 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> print_trace_line may overflow seq_file buffer. If the event is not
>> consumed, the while loop keeps peeking this event, causing a infinite loop.
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>
>> Changes since v1:
>>    - Print partial line to show the broken trace event when overflowed print_trace_line
>>
>>   kernel/trace/trace.c | 27 ++++++++++++++++++++++++++-
>>   1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 47a44b055a1d..81c36dc80212 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -6786,7 +6786,32 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>>   
>>   		ret = print_trace_line(iter);
>>   		if (ret == TRACE_TYPE_PARTIAL_LINE) {
>> -			/* don't print partial lines */
>> +			/*
>> +			 * If one trace_line of the tracer overflows seq_file
>> +			 * buffer, trace_seq_to_user returns -EBUSY.
>> +			 * In this case, we need to consume, otherwise,
>> +			 * while loop will peek this event next time,
>> +			 * resulting in an infinite loop.
>> +			 */
>> +			if (trace_seq_has_overflowed(&iter->seq)) {
> 
> We need to only do this if save_len is zero. Because the reason that it
> returns TRACE_TYPE_PARTIAL_LINE is usually because it overflowed.
> 
> This loops until the trace_seq is full, so it's OK to have it overflow.
> The case I believe you are fixing, is the case were one
> print_trace_line() actually fills the entire trace_seq in one shot. In
> which case, it will never print, and in that case, save_len will be zero.
> 
Yes, I'm fixing the situation you mentioned.
For the sake of discussion, I've replied in the v1 patch to see if it's 
just add "trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");" or a more 
complex situation.

Thanks,
Yang
