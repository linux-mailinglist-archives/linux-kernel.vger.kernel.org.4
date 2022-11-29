Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1A763BF03
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiK2Lbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiK2Lb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:31:27 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1905ADC9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:31:26 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NM0Wn32XpzRpZ2;
        Tue, 29 Nov 2022 19:30:45 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 19:31:24 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 19:31:23 +0800
Subject: Re: [PATCH v3] tracing: Fix infinite loop in tracing_read_pipe on
 overflowed print_trace_line
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221124125850.155449-1-yangjihong1@huawei.com>
 <20221128114613.1c664e81@gandalf.local.home>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <624676a8-cea1-cfc6-e3e6-f4ac12ad5f9d@huawei.com>
Date:   Tue, 29 Nov 2022 19:31:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221128114613.1c664e81@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/29 0:46, Steven Rostedt wrote:
> On Thu, 24 Nov 2022 20:58:50 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> print_trace_line may overflow seq_file buffer. If the event is not
>> consumed, the while loop keeps peeking this event, causing a infinite loop.
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   kernel/trace/trace.c | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index a7fe0e115272..55733224fa88 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -6787,7 +6787,27 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>>   
>>   		ret = print_trace_line(iter);
>>   		if (ret == TRACE_TYPE_PARTIAL_LINE) {
>> -			/* don't print partial lines */
>> +			/*
>> +			 * If one trace_line of the tracer overflows seq_file
>> +			 * buffer, trace_seq_to_user returns -EBUSY.
>> +			 * In this case, we need to consume it, otherwise,
>> +			 * while loop will peek this event next time,
>> +			 * resulting in an infinite loop.
>> +			 */
>> +			if (trace_seq_has_overflowed(&iter->seq)) {
> 
> The only way to get here is if the above is true, and that is not going to
> cause the infinite loop. What does is if save_len == 0. In fact, that's
> all you need to check for:
> 
> 			if (save_len == 0) {
> 
> Should do the trick.
Yes, Has been tested to be feasible, will change in next version.

By the way, the problem mentioned in the v1 patch:
"Anyway, what is triggering this?"

The problem is caused by the print_line callback function 
(blk_tracer_print_line) of blktrace.
The blktrace does not filter out the events whose type is !=TRACK_BLK.
It parses and prints all trace events in the ring buffer as blktrace 
events. As a result, the seq_file buffer may overflow in the 
blk_log_dump_pdu function:

static void blk_log_dump_pdu()
{
...
         for (i = 0; i < pdu_len; i++) { // pdu_len may exceed the 
seq_file buffer size.

                 trace_seq_printf(s, "%s%02x",
                                  i == 0 ? "" : " ", pdu_buf[i]);

                 /*
                  * stop when the rest is just zeros and indicate so
                  * with a ".." appended
                  */
                 if (i == end && end != pdu_len - 1) {
                         trace_seq_puts(s, " ..) ");
                         return;
                 }
         }
...
}

The fixed patch has been sent:
https://lore.kernel.org/lkml/20221122040410.85113-1-yangjihong1@huawei.com/T/


Thanks,
Yang
