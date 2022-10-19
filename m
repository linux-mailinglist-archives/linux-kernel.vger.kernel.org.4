Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6FA603782
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 03:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJSB1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 21:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJSB1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:27:12 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB75913F57
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:27:08 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:36590.744589612
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-111.162.158.155 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 4F112100305;
        Wed, 19 Oct 2022 09:27:06 +0800 (CST)
Received: from  ([111.162.158.155])
        by gateway-153622-dep-787c977d48-25qs2 with ESMTP id 79626ea22f3c426a98c26742de124d33 for mhiramat@kernel.org;
        Wed, 19 Oct 2022 09:27:07 CST
X-Transaction-ID: 79626ea22f3c426a98c26742de124d33
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 111.162.158.155
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <19306ab7-6fda-e995-e61d-2ddf4910e126@189.cn>
Date:   Wed, 19 Oct 2022 09:27:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] trace/kprobe: remove duplicated call of
 ring_buffer_event_data
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, xiehuan09@gmail.com
References: <1666077186-6042-1-git-send-email-chensong_2000@189.cn>
 <20221018095932.7b955e96@gandalf.local.home>
 <20221019002243.8729040161290e17c6581e84@kernel.org>
Content-Language: en-US
From:   Song Chen <chensong_2000@189.cn>
In-Reply-To: <20221019002243.8729040161290e17c6581e84@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/10/18 23:22, Masami Hiramatsu (Google) 写道:
> Hi,
> 
> On Tue, 18 Oct 2022 09:59:32 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>
>> [ Added Masami who's the new co-maintainer, and this is his code ]
>>
>> On Tue, 18 Oct 2022 15:13:06 +0800
>> Song Chen <chensong_2000@189.cn> wrote:
>>
>>> Function __kprobe_trace_func calls ring_buffer_event_data to get
>>> a ring buffer, however, it has been done in above call
>>> trace_event_buffer_reserve.
>>>
>>> So remove one of them.
>>>
>>
>> May as well add:
>>
>> Fixes: 5e6cd84e2f8bd ("tracing/kprobes: Do not open code event reserve logic")
>>
>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Oops, and we have another line in __kretprobe_trace_func() too.
> 
> Song, can you update this patch to fix the __kretprobe_trace_func() too?
> 
> Thank you,
> 

will do

Song
>>
>> -- Steve
>>
>>
>>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>>> ---
>>>   kernel/trace/trace_kprobe.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
>>> index 23f7f0ec4f4c..dfd5809a4a65 100644
>>> --- a/kernel/trace/trace_kprobe.c
>>> +++ b/kernel/trace/trace_kprobe.c
>>> @@ -1394,7 +1394,6 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
>>>   		return;
>>>   
>>>   	fbuffer.regs = regs;
>>> -	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
>>>   	entry->ip = (unsigned long)tk->rp.kp.addr;
>>>   	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
>>>   
>>
> 
> 
