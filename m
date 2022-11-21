Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A60631B18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiKUIPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKUIPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:15:41 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6118FF5A7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:15:40 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NG0Yp3nGXz15MmH;
        Mon, 21 Nov 2022 16:15:10 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 16:15:38 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 16:15:38 +0800
Subject: Re: [PATCH] tracing: Fix infinite loop in tracing_read_pipe on
 overflowed print_trace_line
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221114022946.66255-1-yangjihong1@huawei.com>
 <20221117164003.6e655615@gandalf.local.home>
 <188a48b7-f426-6348-086e-22e56bb07206@huawei.com>
 <20221120144956.30bb1725@rorschach.local.home>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <f4094266-fce6-b548-67cc-f0d5cdfdbcba@huawei.com>
Date:   Mon, 21 Nov 2022 16:15:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221120144956.30bb1725@rorschach.local.home>
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

On 2022/11/21 3:49, Steven Rostedt wrote:
> On Fri, 18 Nov 2022 18:21:12 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>>> That way we can see the broken trace event and not just silently drop it.
>>>    
>> Ok, will change in next version.(Because iter->seq.seq.len may be
>> smaller than strlen(dots), direct subtraction here may not be appropriate.)
> 
> We should only need to do this if the len is maxed out.
> 
> Hmm, len is only updated if it did actually copy it.
> 
> Perhaps we could just add:
> 
> 	trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
> 
> And perhaps that will work?
> 
Yes, as you mentioned in the v2 patch:

"The case I believe you are fixing, is the case were one 
print_trace_line() actually fills the entire trace_seq in one shot."
The problem I'm having is exactly that.

Just add "trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n"); " can solve 
this problem.

But I thought it might happen. (Not yet. Is it possible to support new 
tracers in the future?)

   print_one_line {
     char buf[4090];                          // there's some data in 
the buf.
     trace_seq_puts(s, buf);                  // trace_seq buffer write 
successfully
     trace_seq_puts(s, "test, test, test\n"); // trace_seq buffer overflow
   }

If we want to print out the boken event (buf[4090]), we may need to 
reserve space as we did before.
If we don't consider this situation, we can just add 
"trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");", it's fine.

> Anyway, what is triggering this?
In my environment, this problem may be triggered in the following ways:
   # echo 1 > /sys/kernel/debug/tracing/options/blk_classic
   # echo 1 > /sys/kernel/debug/tracing/options/blk_cgroup
   # echo 1 > /sys/kernel/debug/tracing/events/enable
   # echo blk > /sys/kernel/debug/tracing/current_tracer
   # cat /sys/kernel/debug/tracing/trace_pipe > /dev/null

trace_pipe enter the blk_log_dump_pdu function through the following 
call stack:

tracing_read_pipe
   -> print_trace_line
     -> iter->trace->print_line (current_trace == blk)
	  -> blk_tracer_print_line
	    -> print_one_line
		  -> blk_log_generic
		    -> blk_log_dump_pdu

static void blk_log_dump_pdu(struct trace_seq *s,
         const struct trace_entry *ent, bool has_cg)
{
...
         for (i = 0; i < pdu_len; i++) {

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
After the blk_classic option is enabled, blktrace writes all events in 
the ring buffer to the trace_seq buffer through blk_log_dump_pdu.
If the value of pdu_len is too large, the buffer overflow may occur.
(This problem may be caused by improper processing of blktrace.)

Thanks,
Yang
