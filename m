Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C7D73F020
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjF0BIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjF0BIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:08:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF3C134
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 18:08:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so34532e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 18:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1687828082; x=1690420082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RWrfpt/+w/ne20GaR2tJsRjatoeyo2MXcStbAht4XY=;
        b=Qt+J5v1zstpwCUMgEJVkxzShPCBbP8sUrZOYow7rh/KwOpC+InyZc97KPTyDb3IwpI
         3edabsCzSzqoveKYwY8Vg+Uvp92+zM0Qp6KzGk3jGeC2KOPr1m2JRfZGRW55+sMVXaEy
         Z8myd/Qk8SGty64CyEF4KUWc9F9Jp4bdU+0B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687828082; x=1690420082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RWrfpt/+w/ne20GaR2tJsRjatoeyo2MXcStbAht4XY=;
        b=ZIaNj4vpXafZa6F3loi3EIJ3tm4UCvpOHFtehOwnRCoyRgMqT0AKEEyaaLbl0+hLPt
         PkL6Xy01xamhGoTOODbNiIeUR/NUGrl7tny82/VFfKLrsANKj0TXSbKvoK3K+kjVUcAQ
         Q6F1LrcccAC7WnJ09KwON4Vpahtk0r3SzC9TH6K12vcUo2hdA8WVTJAS0Z6ryuZt2e0X
         4ceIBQR1UB/3rAB6VOfc2x/JGpdH0Pi1Z0dVIWpqlE+A9zEUoaiHVQI0zQSrZce4LQm3
         LXEs98BO3P8jTlUZ0/m6KOdUEMAomISE+gu0F2wN5f3qNT/PZOJbCamVxgOFNhibRETh
         jN7w==
X-Gm-Message-State: AC+VfDxdVpUulkfSMpwM73v0fvjRdVU5Jjn/te5U7dfajKG43PuKmI0T
        XdNXaGCqgT82Ez6X6mUWdy8fxg==
X-Google-Smtp-Source: ACHHUZ7O9ggFGcXq/8f41K74mXpG8A6WniAuIi5GhyoAbDct8Ga9CKMvCSxaYngcIXebIH8wtfDfBg==
X-Received: by 2002:ac2:4e8a:0:b0:4f3:b61a:a94b with SMTP id o10-20020ac24e8a000000b004f3b61aa94bmr17299743lfr.53.1687828081452;
        Mon, 26 Jun 2023 18:08:01 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u22-20020ac243d6000000b004f9fdb0ed8esm1205548lfl.304.2023.06.26.18.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 18:08:00 -0700 (PDT)
Message-ID: <47c1dc89-2a1e-99df-aae1-7147dc281a67@joelfernandes.org>
Date:   Mon, 26 Jun 2023 21:07:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] sched/core: introduce sched_core_idle_cpu()
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        boqun.feng@gmail.com, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, qiang1.zhang@intel.com, jstultz@google.com,
        clingutla@codeaurora.org, nsaenzju@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <1687631295-126383-1-git-send-email-CruzZhao@linux.alibaba.com>
 <ZJixj2RJrp8A8POz@localhost.localdomain>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZJixj2RJrp8A8POz@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 17:28, Frederic Weisbecker wrote:
>>   drivers/tty/sysrq.c     |  2 +-
>>   include/linux/sched.h   |  2 ++
>>   kernel/rcu/tree_stall.h |  2 +-
>>   kernel/sched/core.c     | 13 +++++++++++++
>>   kernel/softirq.c        |  2 +-
>>   5 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>> index b6e70c5cfa17..8a6586800385 100644
>> --- a/drivers/tty/sysrq.c
>> +++ b/drivers/tty/sysrq.c
>> @@ -232,7 +232,7 @@ static void showacpu(void *dummy)
>>   	unsigned long flags;
>>   
>>   	/* Idle CPUs have no interesting backtrace. */
>> -	if (idle_cpu(smp_processor_id())) {
>> +	if (sched_core_idle_cpu(smp_processor_id())) {
>>   		pr_info("CPU%d: backtrace skipped as idling\n", smp_processor_id());
> Actually perhaps an idle injection's backtrace is worth dumping. I guess
> it might accidentally produce lockups and it's worth knowing the source then.
> 
> Though I don't have a strong opinion on that...
> 
>>   		return;
>>   	}
>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> index b10b8349bb2a..6169faf30ecd 100644
>> --- a/kernel/rcu/tree_stall.h
>> +++ b/kernel/rcu/tree_stall.h
>> @@ -418,7 +418,7 @@ static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp
>>   		return false;
>>   
>>   	cpu = task_cpu(rcuc);
>> -	if (cpu_is_offline(cpu) || idle_cpu(cpu))
>> +	if (cpu_is_offline(cpu) || sched_core_idle_cpu(cpu))
> An idle injection could possibly starve the RCU boost kthread, and then it's
> worth knowing about it. I would suggest keeping idle_cpu() here.
> 

Actually I think it should just be idle_cpu() for rcu_is_rcuc_kthread_starving() 
and showacpu() because "force idling" is different from "idling".

Force idling happens because there is something incompatible on the sibling 
runqueue in the core. That just makes the 2 runqueues on the core appear to be a 
single runqueue. The concept of "force idling" is more closer to "preemption of 
tasks on a single runqueue".

Considering that, I would vote for only converting the tick user. If force 
idling happens for too long, it'd be good to know that as Frederic also mentioned.

thanks,

  - Joel






