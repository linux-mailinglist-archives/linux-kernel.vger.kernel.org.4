Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2827A606467
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJTP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJTP0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:26:19 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7BAA1011AC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:26:01 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:50674.1344431831
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-111.162.158.155 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 72CF0100336;
        Thu, 20 Oct 2022 23:25:57 +0800 (CST)
Received: from  ([111.162.158.155])
        by gateway-151646-dep-6564d57998-q98bv with ESMTP id e5d67e78f5b744b687abe74e01b14167 for xiehuan09@gmail.com;
        Thu, 20 Oct 2022 23:25:58 CST
X-Transaction-ID: e5d67e78f5b744b687abe74e01b14167
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 111.162.158.155
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Subject: Re: [PATCH] trace/ring_buffer: remove unused arguments
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, xiehuan09@gmail.com
References: <1666274811-24138-1-git-send-email-chensong_2000@189.cn>
 <20221020101549.06e3fa5b@gandalf.local.home>
From:   chensong <chensong_2000@189.cn>
Message-ID: <e3547bc8-3acf-187c-1671-f5274112d01c@189.cn>
Date:   Thu, 20 Oct 2022 23:25:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20221020101549.06e3fa5b@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/10/20 下午10:15, Steven Rostedt wrote:
> On Thu, 20 Oct 2022 22:06:51 +0800
> Song Chen <chensong_2000@189.cn> wrote:
> 
>> As a argument, event has nothing to do with either
>> ring_buffer_unlock_commit or rb_commit and cleaning
>> it up has no side effect.
> 
> OK, so this is because of a389d86f7fd0 ("ring-buffer: Have nested events
> still record running time stamp") which removed the usage of event in rb_commit():
> 
>   static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
>                        struct ring_buffer_event *event)
>   {
>          local_inc(&cpu_buffer->entries);
> -       rb_update_write_stamp(cpu_buffer, event);
>          rb_end_commit(cpu_buffer);
>   }
> 
> 
> I guess this doesn't hurt.
> 
> -- Steve
> 

I was reading __kprobe_trace_func, store_trace_args stores args in 
fbuffer.entry,which is event->array, but at the end, rb_commit uses 
fbuffer.buffer instead of event.

Then i thought, if it's useless, why not just clean it up.

Song

>>
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>> ---
>>   include/linux/ring_buffer.h          |  3 +--
>>   kernel/trace/ring_buffer.c           | 12 +++++-------
>>   kernel/trace/ring_buffer_benchmark.c |  2 +-
>>   kernel/trace/trace.c                 |  2 +-
>>   4 files changed, 8 insertions(+), 11 deletions(-)
> 
