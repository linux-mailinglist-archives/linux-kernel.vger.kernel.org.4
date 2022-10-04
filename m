Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6745F49DB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJDTsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJDTsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:48:40 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA27E5AA0F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:48:37 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id s9so9029012qkg.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hClfyRuCgKRD0+KfRQKTdVkszyiLg9TSg/tRPHRgy2E=;
        b=qPxOoW6S5g+MFtkNvmfwC+qH3Y3n5l5/InQdlZjuX2HTWp4UxkxYX+FC/ybflpBBr5
         W4lrYVBTEmu/xF8hVh9tybTt0odM/AsiV1dU0tPNwo6kxAyP3cbtBZ19fv9p10/vKSK+
         3LFVzYZrDlmDqN02MOi5PLUaQwLX99uX5lILU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hClfyRuCgKRD0+KfRQKTdVkszyiLg9TSg/tRPHRgy2E=;
        b=DjMK9qbLRUW9MARx5wjjd07ZrEAMdh7S1yyLmnzX8llp8Tofv9YKe1UD4saknDYTvA
         PAp9zWPGH9mdPY2JULf43TcgxGZA2jAdf8N3w+m2cTx+B7vGi/j7RNJvUYcsY2Rc1NHS
         zwQAZEWo65ax9X7Jb3i8M+i1OmhHDWw1tBXaqKfjaaqIQAussMX1Krn5AolwavuiH8e8
         oRK34dghGGXxdDHvhNpPRUsb9RAlb4s0D0sibbVUqOarQ+FpsAjUNAvfjsPcPU7BfnFt
         p0mrDDMmPpPW8Lcj+GhWUVodYvAym4xS6Iu7Z0wthM1MjjHgL3rpdm/7pFjb9Dc/mmEp
         2ZKw==
X-Gm-Message-State: ACrzQf3RYh5CyD1SrcpS7ARQm6ceE8Hay6hVe0Mk2diGEAwRusvV+9GT
        2A3AWFBaNzumeMoOsIPRafKw4w==
X-Google-Smtp-Source: AMsMyM4LO20n7UjZCIDoZsyMd71lEH6KyYsxNV5WRtQhVrW0qbaO1PQo2J+YCLmjbqEeyVsxN+NHtA==
X-Received: by 2002:a05:620a:4246:b0:6d3:e126:447a with SMTP id w6-20020a05620a424600b006d3e126447amr11106169qko.604.1664912916804;
        Tue, 04 Oct 2022 12:48:36 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id br31-20020a05620a461f00b006b9bf03d9c6sm15323873qkb.104.2022.10.04.12.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 12:48:36 -0700 (PDT)
Message-ID: <0773b853-afdf-4368-3494-a5bd1cf01893@joelfernandes.org>
Date:   Tue, 4 Oct 2022 15:48:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Sum of weights idea for CFS PI
Content-Language: en-US
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Youssef Esmat <youssefesmat@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu>
 <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
 <20221003161404.kdow5uyj7kvbqyxs@wubuntu>
 <160a2ded-b8e0-acf0-a8b6-df1b0f2c0fa8@joelfernandes.org>
 <20221004163039.vv3byszpg5dqjhy5@wubuntu>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20221004163039.vv3byszpg5dqjhy5@wubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/2022 12:30 PM, Qais Yousef wrote:
> On 10/03/22 12:27, Joel Fernandes wrote:
>> There's a lot to unwind so I will reply in pieces after spending some time
>> thinking about it, but just for this part:
>>
>> On 10/3/2022 12:14 PM, Qais Yousef wrote:
>>>> In this case, there is no lock involved yet you have a dependency. But I don't
>>>> mean to sound depressing, and just because there are cases like this does not
>>>> mean we should not solve the lock-based ones. When I looked at Android, I saw
>>>> that it uses futex directly from Android Runtime code instead of using pthread.
>>>> So perhaps this can be trivially converted to FUTEX_LOCK_PI and then what we do
>>>> in the kernel will JustWork(Tm) ?
>>> I guess it will depend on individual libc implementation, but I thought all of
>>> them use FUTEX under the hood for pthreads mutexes.
>>>
>>> Maybe we can add a bootparam to force all futexes to be FUTEX_LOCK_PI?
>>>
>>
>> In the case of FUTEX_LOCK_PI, you have to store the TID of the 'lock owner' in
>> the futex word to signify that lock is held.
> 
> Right. So userspace has to opt-in.
> 
>> That wont work for the case above, Producer/Consumer signalling each other on a
>> bounded-buffer, right? That's not locking even though it is acquiring and
>> release of a limited resource.
> 
> Yes but as I tried to point out I don't think proxy-execution handles this case
> where you don't hold a lock explicitly. But I could be wrong.

I don't disagree. Proxy execution is an implementation detail, without more
information from userspace, any implementation cannot help. I was just
responding to your point about converting all futexes which you cannot do
without knowing what the futex is used for.

But I am thinking of messing around with rt_mutex_setprio() and some userspace
tests to see if I can make the sum of weights thing work for the *userspace
locking* usecases (FUTEX_LOCK_PI). Then run some tests and collect some traces.
Perhaps you can do that on the Android side as well.

> IIUC Sebastian's
> understanding is similar to mine. Only 'locks' (FUTEX_LOCK_PI which ends up
> using rt-mutex) do PI inheritance.
> 
> So this signaling scenario is a new class of problems that wasn't handled
> before; to my understanding.
Most certainly, agreed.

Thanks!

 - Joel
