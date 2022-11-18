Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DB562F264
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiKRKVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbiKRKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:21:17 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7F91522
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:21:16 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NDCV11VNQzHvrW;
        Fri, 18 Nov 2022 18:20:41 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 18:21:13 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 18:21:13 +0800
Subject: Re: [PATCH] tracing: Fix infinite loop in tracing_read_pipe on
 overflowed print_trace_line
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221114022946.66255-1-yangjihong1@huawei.com>
 <20221117164003.6e655615@gandalf.local.home>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <188a48b7-f426-6348-086e-22e56bb07206@huawei.com>
Date:   Fri, 18 Nov 2022 18:21:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221117164003.6e655615@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/11/18 5:40, Steven Rostedt wrote:
> On Mon, 14 Nov 2022 10:29:46 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> print_trace_line may overflow seq_file buffer. If the event is not
>> consumed, the while loop keeps peeking this event, causing a infinite loop.
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   kernel/trace/trace.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 47a44b055a1d..2a8d5c68c29b 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -6788,6 +6788,19 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>>   		if (ret == TRACE_TYPE_PARTIAL_LINE) {
>>   			/* don't print partial lines */
>>   			iter->seq.seq.len = save_len;
>> +
>> +			/*
>> +			 * If one trace_line of the tracer overflows seq_file
>> +			 * buffer, trace_seq_to_user returns -EBUSY because
>> +			 * nothing in the sequence (iter->seq.seq.len = \
>> +			 * iter->seq.seq.readpos = 0).
>> +			 * In this case, we need to consume, otherwise,
>> +			 * "while" will peek this event next time, resulting
>> +			 * in an infinite loop.
>> +			 */
>> +			if (trace_seq_has_overflowed(&iter->seq))
>> +				trace_consume(iter);
> 
> Instead of consuming it, I think the right solution is to print the partial
> line. Something like:
> 
> 			if (trace_seq_has_overflowed(&iter->seq)) {
> 				char dots[] = "...";
> 
> 				iter->seq.seq.len -= sizeof(dots) + 1;
> 				iter->seq.seq.full = 0;
> 				trace_seq_puts(&iter->seq, dots);
> 				trace_consume(iter);
> 				break;
> 			}
> 
> 			iter->seq.seq.len = save_len;
> 			break;
> 
> That way we can see the broken trace event and not just silently drop it.
> 
Ok, will change in next version.(Because iter->seq.seq.len may be 
smaller than strlen(dots), direct subtraction here may not be appropriate.)

Thanks,
Yang
