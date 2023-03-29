Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3216CD21C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC2Gbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjC2Gbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:31:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2F271B;
        Tue, 28 Mar 2023 23:31:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23823B81EAF;
        Wed, 29 Mar 2023 06:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2E8C433EF;
        Wed, 29 Mar 2023 06:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680071496;
        bh=P9/TB1qBMW5QFzAH9SkR4I2Xesn5PxwRRnIYxnPmfQQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kxN82WA16Q0vdI2CREy+FB0eCojo+ECD4jmRMCkIJ8JBd5NEZD5r1+yGk07iPqZ7y
         M8llyyT2HMSSh46d3lTcd19j2Em47c+W0/aiWu0X+KbyTk9aNjgRXrO3b+OBtJ7Hzh
         g1SmXvQkn2bPojUuO/LQp3V7PRUglLLOXqXOBE1amh3/K60ODM3rfvFvRXBcgxKQ8h
         afGT/nkb/yRoRzQ0JAi68hA09R152oYSZjnCDnZPtqVEgtlgREGTqX0VhQa4MxVEnt
         unlHmMmLEUe4xiOj6KCXyRSWTjVcDjoF4icdv6S/C7zb00BQrcLnjgSU2iaYz4um+b
         dmRcFPWt6lh2A==
Message-ID: <7607caa6-d76b-519b-b798-0603b7ea70cc@kernel.org>
Date:   Wed, 29 Mar 2023 08:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] tracing/osnoise: Fix notify new tracing_max_latency
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <c22302a7db3cee6bcabf87462ed22a35dd38690f.1679675521.git.bristot@kernel.org>
 <20230328191613.33ac3f5e@gandalf.local.home>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230328191613.33ac3f5e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 01:16, Steven Rostedt wrote:
> On Fri, 24 Mar 2023 18:51:35 +0100
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> timerlat is not reporting a new tracing_max_latency for the thread
>> latency. Also, the tracer is reporting new max latency on instances
>> where the tracing is off, creating inconsistencies between the max
>> reported values in the trace and in the tracing_max_latency. Thus
>> only report new tracing_max_latency on active tracing instances.
> 
> Sounds to me this patch fixes two different bugs. If so, can you please
> break it up into two different patches?

Yeah, I was dubious about sending one or two patches when I sent this one... But
it makes sense making two of them... so I will do.

Thanks!

-- Daniel

> Thanks!
> 
> -- Steve
> 
>>
>> Fixes: dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
>> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> ---
>>  kernel/trace/trace_osnoise.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
>> index 210e1f168392..2a1b337ac643 100644
>> --- a/kernel/trace/trace_osnoise.c
>> +++ b/kernel/trace/trace_osnoise.c
>> @@ -1296,7 +1296,7 @@ static void notify_new_max_latency(u64 latency)
>>  	rcu_read_lock();
>>  	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
>>  		tr = inst->tr;
>> -		if (tr->max_latency < latency) {
>> +		if (tracer_tracing_is_on(tr) && tr->max_latency < latency) {
>>  			tr->max_latency = latency;
>>  			latency_fsnotify(tr);
>>  		}
>> @@ -1738,6 +1738,8 @@ static int timerlat_main(void *data)
>>  
>>  		trace_timerlat_sample(&s);
>>  
>> +		notify_new_max_latency(diff);
>> +
>>  		timerlat_dump_stack(time_to_us(diff));
>>  
>>  		tlat->tracing_thread = false;
> 

