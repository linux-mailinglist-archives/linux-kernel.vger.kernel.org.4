Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8969C733208
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345615AbjFPNTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345597AbjFPNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02592D6B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686921511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLIOb+a2wstZ29K3bzTPcm77FOoyIKi9zKAYbmzihy0=;
        b=SFgFPIxYKR4gTCHVnXaKLEM+kVwUsf7kWmBi7NFrta52NpWBYTQL+UvhbbR9kXrjJSMf/+
        ReSPwy7jz4QnAHhpwk0Sf1z602qjhnzLTfU+g/2zCGR+LewrDtXSfchOqL1yhZEQN57vDE
        rvTiNLR/cAKR+AlYCb+isQE7ZpyxkbY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-PTUkPYLoPeyQBc2X6cQgWw-1; Fri, 16 Jun 2023 09:18:26 -0400
X-MC-Unique: PTUkPYLoPeyQBc2X6cQgWw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-98655eb409aso34452866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686921505; x=1689513505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLIOb+a2wstZ29K3bzTPcm77FOoyIKi9zKAYbmzihy0=;
        b=K3VG2gQhoNGfXG029WyIdNOyHKzbqijD8hqLavm+rpTbql97mNNaX/gUxTINIIKePS
         N9Vb68qacrre//dDwMm0pBlErqfx8I+iLeD9Wa5XYK0Tw/6xoQOvNqEUXUp0vyqaSbHA
         eOgK6adP2P1RmW4KfKMBBpOwoXPJA/co/Un6UNXUejXVhfFJ73AOPgMSLDevybDKOSdR
         q/+h3YgrPR0waYf60ba8mqLNUhRjf+52wbwp1kPiohYU/+STjxhlZux1vSXVuz536Yg0
         jDLxT3etgVvMR1+taX3O3T9mFPQuTL+NExCvytYmMh7D1vTtHn54K1IUJnxCXGKbbkTZ
         9r/A==
X-Gm-Message-State: AC+VfDzKhg2IVj5yaUoDHFXliUKCVV2Nj4fLOv8uwgDPMUnPkQvYlC4o
        m7EwLOokjkilUGQwe1thy55zRkIrtQBv7IebJtCdCM2+b3QK+PJcyQf/GugrbxEL6PjyTqfhDhE
        WKQzHxJY1HoNc+o+dcfWa2gqK
X-Received: by 2002:a17:907:62a1:b0:977:befe:d888 with SMTP id nd33-20020a17090762a100b00977befed888mr2069601ejc.13.1686921505552;
        Fri, 16 Jun 2023 06:18:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KyRgk64pRdV+kUcpS375HlH5soMGx18ivEQqrRikgMzb/QTnLolrS9/BwR2Dl3tXp3BDLpA==
X-Received: by 2002:a17:907:62a1:b0:977:befe:d888 with SMTP id nd33-20020a17090762a100b00977befed888mr2069590ejc.13.1686921505268;
        Fri, 16 Jun 2023 06:18:25 -0700 (PDT)
Received: from [192.168.0.224] (host-79-49-207-213.retail.telecomitalia.it. [79.49.207.213])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090625c400b00982cfe1fe5dsm1405234ejb.65.2023.06.16.06.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 06:18:24 -0700 (PDT)
Message-ID: <01191fe9-72f5-e9a3-ea11-2f0ce8a2933b@redhat.com>
Date:   Fri, 16 Jun 2023 15:18:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH V3 5/6] sched/fair: Add trivial fair server
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <8db5a49ea92ad8b875d331d6136721645a382fe8.1686239016.git.bristot@kernel.org>
 <20230616125946.GN83892@hirez.programming.kicks-ass.net>
 <c8a48cd8-b3bf-743c-55c5-f942fbe08792@kernel.org>
 <20230616131243.GO83892@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230616131243.GO83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 15:12, Peter Zijlstra wrote:
> On Fri, Jun 16, 2023 at 03:00:57PM +0200, Daniel Bristot de Oliveira wrote:
>> On 6/16/23 14:59, Peter Zijlstra wrote:
>>> On Thu, Jun 08, 2023 at 05:58:17PM +0200, Daniel Bristot de Oliveira wrote:
>>>> +void fair_server_init(struct rq *rq)
>>>> +{
>>>> +	struct sched_dl_entity *dl_se = &rq->fair_server;
>>>> +
>>>> +	init_dl_entity(dl_se);
>>>> +
>>>> +	dl_se->dl_runtime = TICK_NSEC;
>>>> +	dl_se->dl_deadline = 20 * TICK_NSEC;
>>>> +	dl_se->dl_period = 20 * TICK_NSEC;
>>>> +
>>>> +	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
>>>> +}
>>>
>>> These here numbers should obviously become a tunable somewhere... :-)
>>
>> From sched_rt_runtime and sched_rt_period, no?
> 
> Well, probably new names. IIRC those are also limits on the whole
> rt-cgroup mess, so e can't trivially change it without also ripping all
> that out, and that's a little bit more work.
> 
> Ripping out the basic throttle is much simpler than replacing all that
> and should be done earlier.
> 

Life is easier then. Should them be a sysctl?

Like:
  kernel.sched_other_min_runtime_us ?
  kernel.sched_other_min_period_us ?

I bet you can come up with better names.

-- Daniel



