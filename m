Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A908750B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjGLPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGLPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:00:13 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66481BD1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:59:49 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-77dcff76e35so80516339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689173989; x=1691765989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73Q2LUKaHkEInMcGI3hfR5vZE3EAkWRBg1FUkub3XI8=;
        b=3nwG65LFC2Xji1PZZlpa0GJch9cAM8oLw4tB7FB6zM1ptaXNoRAvoUJdDaCXK1Auw0
         XlaEO4LzsddRX0bFOaWcjMU2M+ulY4dozlMw2xIMisB296usJJorQ9NP4t27RIsj6e4N
         EgLGFtKn6VIV+bkBVm7cxbX7i+3BAoNWLFWEhQhE2uoolcXiHXP2zugb6awn0hSyhGjw
         St2K1qom2vYe58qQ0q4uAhspWH+kFaGaXRVBvtAmByfZJ2G2PeGYgDsGTsMZQSZzGJ/4
         Z1O2ot2coSML7CNjuKg9zvoNEM1Ym8rnkh6kyhtkgve9UQAE0cZCBZzZWUWYjtcnEwhC
         FaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173989; x=1691765989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73Q2LUKaHkEInMcGI3hfR5vZE3EAkWRBg1FUkub3XI8=;
        b=FA91YLEzAlQ3IPx6hGbpCG7TqxuxICi6SyQU3ZSvv1OBuk0kHoPpD9wIweuL42NNy7
         tlATRHAaBF0Gzmsiq90x1ZhzCaEYz1EQ1WyNEQd6JJK+QAXko8qOAQGqlp2ImZQNNLNR
         N6af/LlL64xO6M302svLuFJKT1fdQet/Tau+3rC3cF+4D+f+9AImwpxR5o06Tn6JMb5J
         4TBdyyxJjpKLf43ui6/JR1IB5BVIwLtk9NKcztLMsILaWAgR/UE8cotSbD+S3jTeBsKn
         +1NdxnQedwiDFYVH4YIz1HrkNjcHZ0UoXDbRWvBSAdIVX6YG0S3GIbbEVfYVTzG3evdz
         n9Yg==
X-Gm-Message-State: ABy/qLYxmsqpGFnQLMmnhF4ngty8L87coJ8w57ubHjqD7kZxAEBLfCZN
        JHGdTShyUFMAscfrUI71tIHRaw==
X-Google-Smtp-Source: APBJJlEn7IZ9QPLBSvTNc8AoO1rn4qhSaXl1olPoleFGWEXeURKcCg/asxZkxK/j7HLFL/AWw0SgJQ==
X-Received: by 2002:a05:6e02:1292:b0:341:c98a:529 with SMTP id y18-20020a056e02129200b00341c98a0529mr16541888ilq.0.1689173989107;
        Wed, 12 Jul 2023 07:59:49 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ep9-20020a0566384e0900b0042b326ed1ebsm1266649jab.48.2023.07.12.07.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:59:48 -0700 (PDT)
Message-ID: <0ae2fc52-5097-480a-d2f1-c112f1e514f3@kernel.dk>
Date:   Wed, 12 Jul 2023 08:59:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/7] futex: abstract out futex_op_to_flags() helper
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com
References: <20230712004705.316157-1-axboe@kernel.dk>
 <20230712004705.316157-2-axboe@kernel.dk>
 <20230712081617.GB3100107@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230712081617.GB3100107@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 2:16 AM, Peter Zijlstra wrote:
> On Tue, Jul 11, 2023 at 06:46:59PM -0600, Jens Axboe wrote:
>> Rather than needing to duplicate this for the io_uring hook of futexes,
>> abstract out a helper.
>>
>> No functional changes intended in this patch.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  kernel/futex/futex.h    | 15 +++++++++++++++
>>  kernel/futex/syscalls.c | 11 ++---------
>>  2 files changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
>> index b5379c0e6d6d..d2949fca37d1 100644
>> --- a/kernel/futex/futex.h
>> +++ b/kernel/futex/futex.h
>> @@ -291,4 +291,19 @@ extern int futex_unlock_pi(u32 __user *uaddr, unsigned int flags);
>>  
>>  extern int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int trylock);
>>  
>> +static inline bool futex_op_to_flags(int op, int cmd, unsigned int *flags)
>> +{
> 	*flags = 0;
> 
>> +	if (!(op & FUTEX_PRIVATE_FLAG))
>> +		*flags |= FLAGS_SHARED;
>> +
>> +	if (op & FUTEX_CLOCK_REALTIME) {
>> +		*flags |= FLAGS_CLOCKRT;
>> +		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI &&
>> +		    cmd != FUTEX_LOCK_PI2)
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
> 
> 
>> diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
>> index a8074079b09e..75ca8c41cc94 100644
>> --- a/kernel/futex/syscalls.c
>> +++ b/kernel/futex/syscalls.c
>> @@ -88,15 +88,8 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
>>  	int cmd = op & FUTEX_CMD_MASK;
>>  	unsigned int flags = 0;
> 
> and skip the initializer here.
> 
>>  
>> -	if (!(op & FUTEX_PRIVATE_FLAG))
>> -		flags |= FLAGS_SHARED;
>> -
>> -	if (op & FUTEX_CLOCK_REALTIME) {
>> -		flags |= FLAGS_CLOCKRT;
>> -		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI &&
>> -		    cmd != FUTEX_LOCK_PI2)
>> -			return -ENOSYS;
>> -	}
>> +	if (!futex_op_to_flags(op, cmd, &flags))
>> +		return -ENOSYS;
>>  
> 
> then the helper is more self sufficient and doesn't rely on the caller
> to initialize the flags word.

Good idea - done, thanks.

-- 
Jens Axboe


