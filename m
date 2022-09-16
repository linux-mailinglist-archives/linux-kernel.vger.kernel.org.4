Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98945BA583
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIPDkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiIPDkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:40:12 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61074B4BB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 20:40:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d17so14074738qko.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 20:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=f7Dedq3xGqYpR1IKZv28AjC3YkvbSUftE26YGjrDJOc=;
        b=xEKi7IUsaBNopFadBFQFAsbaaciiQqoIUav4DZ2DyFFM9Q17iNsCxOr6sNRmr3DBHJ
         +uBl/V8KIBgdLqCWKXgPS/I7oLdOsO1T1uP8d0zrx/9QSxS9iIep9znFvCs+kva7LwWY
         l1unRPjQQMUb4QUHIQ1qxE9zvdBqOgBvjIkT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=f7Dedq3xGqYpR1IKZv28AjC3YkvbSUftE26YGjrDJOc=;
        b=B+WuKtuF92/EIG5OyNh/0iBNbN02PtX/i5ZZbtqhrzvxNt2q+qzLfqai4kEFRJwJbE
         HNeC0np4RrjmEDSbir1eBktYTwCDGWnVsBa4o6SL5j/yBrzHoi6zsX//GtwZrWLgAQsW
         X/G+yX7ZVEK1Vkypp9xcAyvFA+CJK98oWKKVLcIJ86zPnhkFqwCIDMw6Gpa0NW71EA9w
         ll5TkaL0aNNqR/1pijoeX1mNeVji5Ijj3E6SXVXk/SqnKPAasQhCwkQ+Wk5HaDWlMMDY
         cXXqnUkzW+wxG3bCJvZu8RY4axv11vH33IZqC+T/H34zvB0XqQvpnnkppfa0unc1KiLL
         r1hw==
X-Gm-Message-State: ACrzQf1cnXTsmIVMdxyN+PJaqZkFh/4Vopkjjj9ggHP4l6FesaWqR79k
        zauYeOtFayGIkb5lJwvcfOHGY5SMzx9+Yg2o3yolQg==
X-Google-Smtp-Source: AMsMyM5+o6JfN/I5VT8mKUhfR4cPPdvmzt6N0krwcSK17nshc14FmRT2UvrIbmq0GilTrF87Q6WofA==
X-Received: by 2002:a37:38d:0:b0:6cd:fd39:10e5 with SMTP id 135-20020a37038d000000b006cdfd3910e5mr2523222qkd.784.1663299609752;
        Thu, 15 Sep 2022 20:40:09 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id v6-20020a05620a440600b006bb87c4833asm5926313qkp.109.2022.09.15.20.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 20:40:09 -0700 (PDT)
Message-ID: <051a4ae9-cae9-9ff1-d732-62cf8751dafd@joelfernandes.org>
Date:   Thu, 15 Sep 2022 23:40:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: RCU vs NOHZ
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2022 6:30 PM, Peter Zijlstra wrote:
>>>>> These deep idle states are only feasible during NOHZ idle, and the NOHZ
>>>>> path is already relatively expensive (which is offset by then mostly
>>>>> staying idle for a long while).
>>>>>
>>>>> Specifically my thinking was that when a CPU goes NOHZ it can splice
>>>>> it's callback list onto a global list (cmpxchg), and then the
>>>>> jiffy-updater CPU can look at and consume this global list (xchg).
>>>>>
>>>>> Before you say... but globals suck (they do), NOHZ already has a fair
>>>>> amount of global state, and as said before, it's offset by the CPU then
>>>>> staying idle for a fair while. If there is heavy contention on the NOHZ
>>>>> data, the idle governor is doing a bad job by selecting deep idle states
>>>>> whilst we're not actually idle for long.
>>>>>
>>>>> The above would remove the reason for RCU to inhibit NOHZ.
>>>>>
>>>>>
>>>>> Additionally; when the very last CPU goes idle (I think we know this
>>>>> somewhere, but I can't reaily remember where) we can insta-advance the
>>>>> QS machinery and run the callbacks before going (NOHZ) idle.
>>>>>
>>>>>
>>>>> Is there a reason this couldn't work? To me this seems like a much
>>>>> simpler solution than the whole rcu-cb thing.
>>>> To restate Joel's reply a bit...
>>>>
>>>> Maybe.
>>>>
>>>> Except that we need rcu_nocbs anyway for low latency and HPC applications.
>>>> Given that we have it, and given that it totally eliminates RCU-induced
>>>> idle ticks, how would it help to add cmpxchg-based global offloading?
>>> Because that nocb stuff isn't default enabled?
>> Last I checked, both RHEL and Fedora were built with CONFIG_RCU_NOCB_CPU=y.
>> And I checked Fedora just now.
>>
>> Or am I missing your point?
> I might be missing the point; but why did Joel have a talk if it's all
> default on?

It was not default on until recently for Intel ChromeOS devices. Also, my talk
is much more than just idle-ticks/NOCB. I am talking about delaying grace
periods by long amounts of times using various techniques, with data to show
improvements, and new tool rcutop to show the problems :-) The discussion of
ticks which disturb idle was more for background information for the audience
(Sorry if I was not clear about that).

thanks,

 - Joel
