Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8FD66BB66
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjAPKNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjAPKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:12:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725D21ABD6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:11:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F67260F3F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231B4C433D2;
        Mon, 16 Jan 2023 10:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673863910;
        bh=XGM2GdNthJK25Wl+CewKBCUakOt96N+q96d+FiYSESU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZZDVOkxRWSCA1ie1B0UbEfIL41FOyXxkSWqQLa8RVsoKL5QIXi+FGAUVx6n90YvBM
         6uo42aI3UkhkZxmtlXAJy7MW1T2TVCZEiRWrmqax6GuYQ0LYN/rRuti/uZHh1ve10+
         XZzltwQXjA23hcuK5scucioo6mc5nFQZ4FsK4bMnwFCOHakCA1MGJq+QZ7U+03dM6Q
         nocDSxH25sbuOyxBMAz6fkr21w3SejnKz00RKJxiS7qSdgj/61Fjz1xCt0roheNDys
         AxpUhrlpuFqJuU42fIrzlEmgJ7SeMvXDbBatrq/C16u8fNdN0nPC2eMmPNFp7u7id0
         Gi667aufxkYZg==
Message-ID: <073cf067-908f-0bdd-e3b9-e6c5a5e3c910@kernel.org>
Date:   Mon, 16 Jan 2023 11:11:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] sched/idle: Make idle poll dynamic per-cpu
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20230112162426.217522-1-bristot@kernel.org>
 <Y8UQdKx+004a28fL@hirez.programming.kicks-ass.net>
 <Y8USikoCYTBl7VFr@gmail.com> <Y8UYtEepRT3xC8O/@gmail.com>
 <CAKfTPtCBn20ECopZoT5iC0by8SgpRN_xi4Q0Q8Uc8VQ6BR=u=Q@mail.gmail.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAKfTPtCBn20ECopZoT5iC0by8SgpRN_xi4Q0Q8Uc8VQ6BR=u=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/23 10:51, Vincent Guittot wrote:
> On Mon, 16 Jan 2023 at 10:28, Ingo Molnar <mingo@kernel.org> wrote:
>>
>>
>> * Ingo Molnar <mingo@kernel.org> wrote:
>>
>>>> Urgh, can we please make this a cpuidle governor thing or so? So that
>>>> we don't need to invent new interfaces and such.
>>>
>>> I think the desired property here would be to make this interface on top
>>> of pretty much any governor. Ie. have a governor, but also a way to drop
>>> any CPU into idle-poll, overriding that.
>>
>> ... with the goal of having the best governor for power efficiency by
>> default - but also the ability to drop a handful of CPUs into the highest
>> performance / lowest latency idle mode.
>>
>> It's a special kind of nested policy, for workload exceptions.
> 
> User can set per cpu latency constraint with
> /sys/devices/system/cpu/cpu*/power/pm_qos_resume_latency_us
> Which is then used by cpuidle governor when selecting an idle state.
> The cpuidle governor should then select the idle state that matches
> with the wakeup latency for those CPUs but select the most power
> efficient for others. Setting a low value should filter all idle
> states except the polling one

Yep, that is a possibility, but it does not always work as expected. For example,
on virtual machines the vCPU gets scheduled out, even with this option set :-/.

-- Daniel

> Regards
> Vincent
>>
>> Thanks,
>>
>>         Ingo

