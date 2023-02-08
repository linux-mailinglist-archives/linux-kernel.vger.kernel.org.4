Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B8C68EE4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjBHLwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:52:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FCD58A6A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:52:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D09D1477;
        Wed,  8 Feb 2023 03:53:18 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57E8B3F703;
        Wed,  8 Feb 2023 03:52:34 -0800 (PST)
Message-ID: <d7f29def-7004-b62d-9266-3ad997111e2f@arm.com>
Date:   Wed, 8 Feb 2023 12:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/3] sched/uclamp: Ignore (util == 0) optimization in
 feec() when p_util_max = 0
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-3-qyousef@layalina.io>
 <CAKfTPtCf4+orEhYmFBg+tsMH7e5sV5zJZ1k8apjZkYwSAxAu+w@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtCf4+orEhYmFBg+tsMH7e5sV5zJZ1k8apjZkYwSAxAu+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 11:04, Vincent Guittot wrote:
> On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
>>
>> find_energy_efficient_cpu() bails out early if effective util of the
>> task is 0. When uclamp is being used, this could lead to wrong decisions
>> when uclamp_max is set to 0. Cater for that.

IMHO this needs a little bit more explanation. Someone could argue that
'util > 0, uclamp_min=0, uclamp_max=0' is a valid setup for a task which
should let it appear as a task with 0 util (capped to 0).

>> Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
>> Signed-off-by: Qais Yousef <qyousef@layalina.io>
>> ---
>>  kernel/sched/fair.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7a21ee74139f..a8c3d92ff3f6 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7374,7 +7374,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>         target = prev_cpu;
>>
>>         sync_entity_load_avg(&p->se);
>> -       if (!uclamp_task_util(p, p_util_min, p_util_max))
>> +       if (!uclamp_task_util(p, p_util_min, p_util_max) && p_util_max != 0)
> 
> The below should do the same without testing twice p_util_max:
> uclamp_task_util(p, p_util_min, ULONG_MAX)

Since uclamp_task_util() is only used here and we don't want to test for
capping to 0 anymore, why not just get rid of this function and use:

  !(task_util_est(p) || p_util_min)

[...]
