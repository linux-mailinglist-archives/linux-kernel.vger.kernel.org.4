Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A269C6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjBTImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBTImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:42:43 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF92FF10;
        Mon, 20 Feb 2023 00:42:41 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4C0B9400DA;
        Mon, 20 Feb 2023 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676882558;
        bh=StrKTfKysBD3dfJrS86VzFRzi9AR6e25y4+PwBzyDu8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=L8VCslT2auUvAwpKcsP2g9o9bsfIyV6qdgJeSQKzSZnQYDuZbvoS+Ff4Z2omsIE56
         eKFGKopkfcJ6Uti4i75w1p6DlApbEdL7l+C2c1h3gqqR7xdOgMwVVzLRgKZxVGjPyN
         tHyjrjNBqDsWj0/klp0jqqAPpzUdiXNz4HSeb5Uu/qslJ6yfIoIPopXKD8/rTo1ZP9
         7NKmEgntlttAbdr5APjcp4b0PjcszgFFRIA8euLanq6hj2kUdp9wnE+2owd2Uv2bFD
         4zAFIWjfS5/lOO69FdiV8DfqaMtZW3i6J0BXLeDjujyclJP945wvLYhU44JQQrvYrW
         jC4Z6NQCM4h8A==
Message-ID: <f3fd5dd8-9d78-43be-fc5c-bf990ad3a64d@canonical.com>
Date:   Mon, 20 Feb 2023 00:42:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] apparmor: global buffers spin lock may get contended
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-security-module@vger.kernel.org,
        Anil Altinay <aaltinay@google.com>
References: <YO2S+C7Cw7AS7bsg@google.com>
 <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
 <Y19GhTg8Q/3ym/VD@google.com>
 <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
 <4595e7b4-ea31-5b01-f636-259e84737dfc@canonical.com>
 <Y+9aoFjrYkpFSvuE@linutronix.de>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <Y+9aoFjrYkpFSvuE@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 02:44, Sebastian Andrzej Siewior wrote:
> On 2023-02-16 16:08:10 [-0800], John Johansen wrote:
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -49,12 +49,19 @@ union aa_buffer {
>>   	char buffer[1];
>>   };
>> +struct aa_local_cache {
>> +	unsigned int contention;
>> +	unsigned int hold;
>> +	struct list_head head;
>> +};
> 
> if you stick a local_lock_t into that struct, then you could replace
> 	cache = get_cpu_ptr(&aa_local_buffers);
> with
> 	local_lock(&aa_local_buffers.lock);
> 	cache = this_cpu_ptr(&aa_local_buffers);
> 
> You would get the preempt_disable() based locking for the per-CPU
> variable (as with get_cpu_ptr()) and additionally some lockdep
> validation which would warn if it is used outside of task context (IRQ).
> 
I did look at local_locks and there was a reason I didn't use them. I
can't recall as the original iteration of this is over a year old now.
I will have to dig into it again.

> I didn't parse completely the hold/contention logic but it seems to work
> ;)
> You check "cache->count >=  2" twice but I don't see an inc/ dec of it
> nor is it part of aa_local_cache.
> 
sadly I messed up the reordering of this and the debug patch. This will be
fixed in v4.

> I can't parse how many items can end up on the local list if the global
> list is locked. My guess would be more than 2 due the ->hold parameter.
> 
So this iteration, forces pushing back to global list if there are already
two on the local list. The hold parameter just affects how long the
buffers remain on the local list, before trying to place them back on
the global list.

Originally before the count was added more than 2 buffers could end up
on the local list, and having too many local buffers is a waste of
memory. The count got added to address this. The value of 2 (which should
be switched to a define) was chosen because no mediation routine currently
uses more than 2 buffers.

Note that this doesn't mean that more than two buffers can be allocated
to a tasks on a cpu. Its possible in some cases to have a task have
allocated buffers and to still have buffers on the local cache list.

> Do you have any numbers on the machine and performance it improved? It
> sure will be a good selling point.
> 

I can include some supporting info, for a 16 core machine. But it will
take some time to for me to get access to a bigger machine, where this
is much more important. Hence the call for some of the other people
on this thread to test.

thanks for the feedback

