Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C07C679F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjAXQm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjAXQmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:42:52 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D1147EC8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:42:34 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b12so11655595pgj.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4dXgVQ/sDHAYzw501aurfy46z+qwW2H4oOIf6VBPHk=;
        b=Gd37GJp/ayIRBKGiOBIgsJHcvh/ekkJW9SUoeDwKZtHwAcLGVA6C3MsP3CXGgSN/69
         vBjAnj93XCghnuXGOOvLfa7orL4tGSKXy/DJtUPM0rp2cZksqvLeajrZluUHx89KVd0I
         IMl4QeBCCB81kuVsWqvoP05kHgH4SP8Swq8r2+Z/mqCtI9GG0kmhn6s2/tWVjfGQWUoX
         y+ACqb9GrxBSAViFno8tu8PB8OVV4BrJDhyIXO6AggloTY1r9KuAdk7shjA/FyLO5W/D
         /SKycrRbRVoLv1DEjvKtQwaeUeTKGDjZoxiuvydj9/SDdxtbzx2Tr6lvYac8epnIu12I
         f3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4dXgVQ/sDHAYzw501aurfy46z+qwW2H4oOIf6VBPHk=;
        b=xrgha7F2n8usp+B3b3gqfmsGezNoHIzOYIsqiY2jCfolPIcLVEIIPBVNwE8nMqKp6d
         fmE+nNIwJS+5N5vTO2wPl+VEO1rgLDNMeAwVNfed4UMTruvA4GIioCVUjb8aHRuYcDLi
         qHNb95sbhMpMPwwUhnj+AxhaqMrQmk3Gy65o7DG3IZcTfnwG+5Nyxi8uTieabA4gJP+E
         Eql6lK/jejGFFnIhdLyu1NUVWmsmF9jgvfLvDswxpAgKVggwzNS6SX5gcA8bStPjn01W
         N/xf0EUkGbRxHpvftDuRCRAk2swN+08Ud7dhgEyCKcQnjCs4Cp1v/Ck8twTyXX38Bq3C
         cdng==
X-Gm-Message-State: AFqh2koxWAaLmG/ErM9zQp/eq2WibmF1bD0iYWV71WBr9aNLQooHIPaO
        MpWnrzSRKnYdvZABflTxEyGmfA==
X-Google-Smtp-Source: AMrXdXtZnv7mOMeBLuwTA3TB5pvXlau5W5plfoPs5JcFcE6YM0Ig0xJ1h9cs06DTR4wLEXS5Xx10tQ==
X-Received: by 2002:aa7:9114:0:b0:57f:d5d1:41d0 with SMTP id 20-20020aa79114000000b0057fd5d141d0mr6612680pfh.3.1674578548519;
        Tue, 24 Jan 2023 08:42:28 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b0058bc745026csm1864269pfo.97.2023.01.24.08.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:42:28 -0800 (PST)
Message-ID: <700dbf3b-db4c-43bb-2c12-7531622a308e@kernel.dk>
Date:   Tue, 24 Jan 2023 09:42:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] x86/fpu: don't set TIF_NEED_FPU_LOAD for PF_IO_WORKER
 threads
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <560c844c-f128-555b-40c6-31baff27537f@kernel.dk>
 <Y8/8CFwtpmjzdK9c@hirez.programming.kicks-ass.net>
 <b03383e3-cb10-8b70-a042-dbc2170ee3ec@kernel.dk>
 <Y9AGBXf5mhZ5geGC@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y9AGBXf5mhZ5geGC@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 9:23 AM, Peter Zijlstra wrote:
> On Tue, Jan 24, 2023 at 09:06:08AM -0700, Jens Axboe wrote:
>> On 1/24/23 8:40 AM, Peter Zijlstra wrote:
>>> On Tue, Jan 24, 2023 at 08:23:20AM -0700, Jens Axboe wrote:
>>>> We don't set it on PF_KTHREAD threads as they never return to userspace,
>>>> and PF_IO_WORKER threads are identical in that regard. As they keep
>>>> running in the kernel until they die, skip setting the FPU flag on them.
>>>
>>> No objection to the actual patch; but this changelog fails to tell us
>>> why this is important.
>>>
>>> What made you get up and write this patch :-) Presumably this is a
>>> performance issue? If so, can you quantify how much?
>>
>> You snipped the part where that was explained, but arguably that should
>> probably go into the commit message itself:
>>
>> "Not urgent, more of a cosmetic thing that was found while debugging and
>> issue and pondering why the FPU flag is set on these threads."
> 
> Duh, I stopped reading at the --- just like a patch tool.. :/

Yeah... Half of that should've been in the commit message, my bad.

>> So it's not really a performance issue, it was just something odd that
>> got me scratching my head when debugging another issue and poking at
>> the flags.
>>
>> Want a resend of it, or will you just augment the commit message?
> 
> I think tglx typically takes fpu patches, but sure can do.

Thanks!

-- 
Jens Axboe


