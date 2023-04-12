Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BE16DFCA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjDLRZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjDLRZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:25:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6034EEA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:24:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-242cb01a788so1163760a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681320287; x=1683912287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKaO1cc6CIWs24NhirNiWA4O/KpNriiBwvpslyVSCVQ=;
        b=MsEoUCC18gKG1ugjbCxJ5Vx4mbZWgAFiWn/rhfnzm0/G8l5mqdKOCM228ApK7QX9nM
         +xHXuWtUg4/t30Nniyc2ShYa4wXVS8sFlmZ44iyj9B/4Bc3R11kC1yAL2+yCzLED0GSZ
         4HtmBEFABZ8YRJhYCojZL/9JQrSY6M4+XAF4bGSiY4TDZMUn7fIzvIR106FucO9apqo/
         iGn+E7EhcdJopQEYUjXVknP+4EP1UEcLCUYTmr3Yarlwg+/GQ+bql7rEuFrqK6nJs0Ql
         SXoYcmVnbTFJ8GSt5825hwFUWLuLx64B0tuJtuFTDa+dKAAwIyxmNvDJ9fnaI1D7yg6X
         Gx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681320287; x=1683912287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKaO1cc6CIWs24NhirNiWA4O/KpNriiBwvpslyVSCVQ=;
        b=OZyou7SluqtHUBhMG3SMNjTKyvA2wqV23DFRygPexwDEt2U68PElUWYmp3Uiyxljdb
         Y+yACzPJNo8OYkid0QeIqfQygif5QCFF8IQBcOfoofI+OOqEYUtp+j2AFZiNuj82mAfc
         9QEyaTebrcJ6dc08tlPH2klEuC2rs8zIVxe5FUIvqJu9tvzJqhlOXNOKyAluV0hNSRq2
         CEDOnKJicgCVneCotVe4cwoNGRIJ9ebjyJp8DGeNgYW5yOlvnUVsjbrFnKo/HW3k9+vK
         wEOkmEfZMnMlUUoqPOg+ZDNLVPZBJv3ga4uNiOtKeuOVjxPI3ISizO42h9z3JJAjv/dO
         VsMg==
X-Gm-Message-State: AAQBX9einF+kJrq+/MLmVu8FEi2B0JzZJjp2wGD5958z6JghpdVB8zJ4
        7UoZd6ABOLMyhoQRSF04s/YprA==
X-Google-Smtp-Source: AKy350YjXfbDAUqe4ubJKlFmaiXA1YMXlc2SqhXABMWU6ZcIT2xvPP8lzqJAt142+eKBSK4on1KvTw==
X-Received: by 2002:a17:90a:357:b0:246:60ed:742d with SMTP id 23-20020a17090a035700b0024660ed742dmr2681959pjf.0.1681320287640;
        Wed, 12 Apr 2023 10:24:47 -0700 (PDT)
Received: from [10.200.10.123] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090aab0200b00246a7401d23sm1735143pjq.41.2023.04.12.10.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 10:24:47 -0700 (PDT)
Message-ID: <60a168b7-2e86-26b0-a903-fab38b74411d@bytedance.com>
Date:   Thu, 13 Apr 2023 01:24:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] x86: make __get_wchan() use arch_stack_walk()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     keescook@chromium.org, dave.hansen@linux.intel.com, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de, rostedt@goodmis.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
 <20230330081552.54178-3-zhengqi.arch@bytedance.com>
 <20230408050822.ezdbhc6j7zuvutrm@treble>
 <20230412131533.GH628377@hirez.programming.kicks-ass.net>
 <20230412132327.GA629496@hirez.programming.kicks-ass.net>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230412132327.GA629496@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/12 21:23, Peter Zijlstra wrote:
> On Wed, Apr 12, 2023 at 03:15:33PM +0200, Peter Zijlstra wrote:
>> On Fri, Apr 07, 2023 at 10:08:22PM -0700, Josh Poimboeuf wrote:
>>> On Thu, Mar 30, 2023 at 04:15:52PM +0800, Qi Zheng wrote:
>>>> Make __get_wchan() use arch_stack_walk() directly to
>>>> avoid open-coding of unwind logic.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> Can we just have a shared version of __get_wchan() for all
>>> CONFIG_ARCH_STACKWALK arches?
>>
>> Didn't I do that a while back ? I can't seem to actually find the
>> patch-set though :/
> 
> Could be this series:
> 
>    https://lkml.kernel.org/r/20211022150933.883959987@infradead.org

Oh, I vaguely remember the beginning because I was trying to fix
get_wchan() not supporting ORC unwinder on x86 [1], and then you sent a
patch set, and the patch [2] in this patch set tried to implement the
shared version of __get_wchan().

[1]. https://lore.kernel.org/all/20211008111626.271115116@infradead.org/
[2]. https://lore.kernel.org/all/20211008111626.392918519@infradead.org/

> 
> And this here:
> 
>    https://lore.kernel.org/lkml/CAHk-=wjHbKfck1Ws4Y0pUZ7bxdjU9eh2WK0EFsv65utfeVkT9Q@mail.gmail.com/
> 
> might be why I dropped it.. I can't remember.

Didn't realize I had replied to this email before.

But I also don't see why you dropped it. Looks like you have fixed the
UAF problem.

So do we still need to implement a shared version of __get_wchan()?
If we still need it, do I need to send it again? Or just pick your
previous patch directly? Both are fine to me. :)

Thanks,
Qi

