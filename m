Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122405F4771
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJDQWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJDQWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:22:15 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D6448CBB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:22:11 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id s9so8658548qkg.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JZ3iUDHSbQXvPSxh5byaUtyxn9JuSZxfLjzTGQtDdiI=;
        b=i9R1Ftpg4EB3iaDhSe4JE0wNr+N0VO/s0tEkp9MD9mPWT8JlfQJNtSJNoWkM9j6dNa
         7xITECxQb6zYNVgAWwobDDZNOcwiE8KIAJq236+XHPfUMJHrksId3IWM7WsBszWZDKzO
         njhPuYo8/mtRorpBuQwPZ20upuHZf7DQCJFcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JZ3iUDHSbQXvPSxh5byaUtyxn9JuSZxfLjzTGQtDdiI=;
        b=OfhibvVe9PXFfLuj5drFi+J6nhtpcNSmmC+Orw2rfHYyVfhbhLpfs6b71YnOjPRtjR
         hiP7r6/2oNGdm7fXAX1pBFMHxnxaAlQE8RTfwBgYBFEbyPRFtryrDraSSuBmVuOmYJha
         p0E6r/nWbC2hGKBMPclfzokuCZtjb0e96O8/mQzSx3K/fgNuKsfcNxKWzYgdyt+T0VZA
         3pIfDMXWImITJW9rvd5khKqZmFxQZs/eokskEerUHnupTteL/2f+DwlDFpDJL6K2KXDA
         D98TZU+f9xobsKnbHReUohNZz1XTYZynQr3CUIbihLQEvs3q5HLMcHMTFTzYumgpDioD
         Dw+Q==
X-Gm-Message-State: ACrzQf1vrWwclfb2L/Woxm6B0XFJuBo4tWfzdGPNLAHvfWsfpSTBnFBn
        RgEd1aXqrJ3eLezVBSYclu09iA==
X-Google-Smtp-Source: AMsMyM7J0hCHyR7qRUBm60QBLfdElNHebAIUKMkTx/+3jeJ8IX0WKoS6RhHoMoF0zxyfFDoo3GEFkg==
X-Received: by 2002:a05:620a:3706:b0:6e1:dc2d:4e86 with SMTP id de6-20020a05620a370600b006e1dc2d4e86mr129443qkb.428.1664900530016;
        Tue, 04 Oct 2022 09:22:10 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a454500b006bb87c4833asm15109434qkp.109.2022.10.04.09.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 09:22:09 -0700 (PDT)
Message-ID: <39cb5352-4b8d-7ca8-4414-6fbb27bab806@joelfernandes.org>
Date:   Tue, 4 Oct 2022 12:22:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
Content-Language: en-US
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org> <Yzwb8vgYhAvDJzK+@pc636>
 <20221004133004.GD4196@paulmck-ThinkPad-P17-Gen-1> <YzxI1frUjDnB6MOP@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <YzxI1frUjDnB6MOP@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/2022 10:53 AM, Uladzislau Rezki wrote:
> On Tue, Oct 04, 2022 at 06:30:04AM -0700, Paul E. McKenney wrote:
>> On Tue, Oct 04, 2022 at 01:41:38PM +0200, Uladzislau Rezki wrote:
>>>>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
>>>>  		rcu_nocb_lock_irqsave(rdp, flags);
>>>>  		lockdep_assert_held(&rdp->nocb_lock);
>>>>  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>>> -		if (bypass_ncbs &&
>>>> +		lazy_ncbs = READ_ONCE(rdp->lazy_len);
>>>> +
>>>> +		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
>>>> +		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
>>>> +		     bypass_ncbs > 2 * qhimark)) {
>>> Do you know why we want double "qhimark" threshold? It is not only this
>>> place, there are several. I am asking because it is not expected by the
>>> user.
>>
>> OK, I will bite...  What does the user expect?  Or, perhaps a better
>> question, how is this choice causing the user problems?
>>
> Yesterday when i was checking the lazy-v6 on Android i noticed the following:
> 
> <snip>
> ...
>      rcuop/4-48      [006] d..1   184.780328: rcu_batch_start: rcu_preempt CBs=15572 bl=121
>      rcuop/6-62      [000] d..1   184.796939: rcu_batch_start: rcu_preempt CBs=21503 bl=167
>      rcuop/6-62      [003] d..1   184.800706: rcu_batch_start: rcu_preempt CBs=24677 bl=192
>      rcuop/6-62      [005] d..1   184.803773: rcu_batch_start: rcu_preempt CBs=27117 bl=211
>      rcuop/6-62      [005] d..1   184.805732: rcu_batch_start: rcu_preempt CBs=22391 bl=174
>      rcuop/6-62      [005] d..1   184.809083: rcu_batch_start: rcu_preempt CBs=12554 bl=98
>      rcuop/6-62      [005] d..1   184.824228: rcu_batch_start: rcu_preempt CBs=16177 bl=126
>      rcuop/4-48      [006] d..1   184.836193: rcu_batch_start: rcu_preempt CBs=24129 bl=188
>      rcuop/4-48      [006] d..1   184.844147: rcu_batch_start: rcu_preempt CBs=25854 bl=201
>      rcuop/4-48      [006] d..1   184.847257: rcu_batch_start: rcu_preempt CBs=21328 bl=166
>      rcuop/4-48      [006] d..1   184.852128: rcu_batch_start: rcu_preempt CBs=21710 bl=169

This looks normal to me and working as intended, due to the first flush after
hitting the limit, future callbacks will not be considered lazy until the
existing ones are drained out of the queue. It is possible the additional
callbacks showed up before the whole queue was drained. Then add any scheduling
delays to the rcuop thread etc etc.

thanks,

 - Joel



> ...
> <snip>
> 
> On my device the "qhimark" is set to:
> 
> <snip>
> XQ-CT54:/sys/module/rcutree/parameters # cat qhimark
> 10000
> XQ-CT54:/sys/module/rcutree/parameters #
> <snip>
> 
> so i expect that once we pass 10 000 callbacks threshold the flush 
> should occur. This parameter gives us an opportunity to control a
> memory that should be reclaimed sooner or later.
> 
> --
> Uladzislau Rezki
