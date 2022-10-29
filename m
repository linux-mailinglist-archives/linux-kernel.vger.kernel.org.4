Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6361236B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJ2N63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJ2N60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:58:26 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9481627CEA;
        Sat, 29 Oct 2022 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667051903;
        bh=SjEXVlrM7QtPJHNiPEUkuWpPg7Fp6YZ34g5udIk/1O0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AQRlpKglle10SwG+lWoPr8TY+HdYODxM76E2VxOACZ7j/vCuXfhb+1UUakWOWEVAK
         Ir6b7ZCYGnH/EJyBScIKo0kehjs7tUSYuBAWEHAgYsAip+0f2HrN5WUaHI5IKlrBWR
         i6+dtzLkKyZ9UfPC8yLOkPF7oMFnr/mhknBEeNwpYzfz4kKpqiHAy5nVnTaRR2f7Hg
         pKt0SOsAesAVrIVcDS06UmsXMfTbuV6h2+FkxzHSwgz21x5u5vBOf7Gix+aVNXE01h
         28fqUoHgaJA5cxpztefwv0n/8vCfplvhYHckpQbA+vocfiC/t1ztxKkJke2Ow4wPH2
         5ZaTdBabIYgWg==
Received: from [10.1.0.216] (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N01GR1qQGzy1t;
        Sat, 29 Oct 2022 09:58:23 -0400 (EDT)
Message-ID: <01d10e59-0ea6-e60f-8561-84aa5dee40d3@efficios.com>
Date:   Sat, 29 Oct 2022 09:58:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH 0/2] tracing/user_events: Remote write ABI
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <96d9f066-2f39-78e6-9be7-f9c69235615e@efficios.com>
 <20221028221728.GA162@W11-BEAU-MD.localdomain>
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221028221728.GA162@W11-BEAU-MD.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-28 18:17, Beau Belgrave wrote:
> On Fri, Oct 28, 2022 at 05:50:04PM -0400, Mathieu Desnoyers wrote:
>> On 2022-10-27 18:40, Beau Belgrave wrote:

[...]
> 
>>>
>>> NOTE:
>>> User programs that wish to have the enable bit shared across forks
>>> either need to use a MAP_SHARED allocated address or register a new
>>> address and file descriptor. If MAP_SHARED cannot be used or new
>>> registrations cannot be done, then it's allowable to use MAP_PRIVATE
>>> as long as the forked children never update the page themselves. Once
>>> the page has been updated, the page from the parent will be copied over
>>> to the child. This new copy-on-write page will not receive updates from
>>> the kernel until another registration has been performed with this new
>>> address.
>>
>> This seems rather odd. I would expect that if a parent process registers
>> some instrumentation using private mappings for enabled state through the
>> user events ioctl, and then forks, the child process would seamlessly be
>> traced by the user events ABI while being able to also change the enabled
>> state from the userspace tracer libraries (which would trigger COW).
>> Requiring the child to re-register to user events is rather odd.
>>
> 
> It's the COW that is the problem, see below.
> 
>> What is preventing us from tracing the child without re-registration in this
>> scenario ?
>>
> 
> Largely knowing when the COW occurs on a specific page. We don't make
> the mappings, so I'm unsure if we can ask to be notified easily during
> these times or not. If we could, that would solve this. I'm glad you are
> thinking about this. The note here was exactly to trigger this
> discussion :)
> 
> I believe this is the same as a Futex, I'll take another look at that
> code to see if they've come up with anything regarding this.
> 
> Any ideas?

Based on your description of the symptoms, AFAIU, upon registration of a 
given user event associated with a mm_struct, the user events ioctl 
appears to translates the virtual address into a page pointer 
immediately, and keeps track of that page afterwards. This means it 
loses track of the page when COW occurs.

Why not keep track of the registered virtual address and struct_mm 
associated with the event rather than the page ? Whenever a state change 
is needed, the virtual-address-to-page translation will be performed 
again. If it follows a COW, it will get the new copied page. If it 
happens that no COW was done, it should map to the original page. If the 
mapping is shared, the kernel would update that shared page. If the 
mapping is private, then the kernel would COW the page before updating it.

Thoughts ?

Thanks,

Mathieu

> 
> Thanks,
> -Beau

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

