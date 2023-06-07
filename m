Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D669472634F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbjFGOwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbjFGOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:52:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 095EF1702
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:52:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 355E5AB6;
        Wed,  7 Jun 2023 07:52:49 -0700 (PDT)
Received: from [10.57.24.86] (unknown [10.57.24.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48BD13F587;
        Wed,  7 Jun 2023 07:52:02 -0700 (PDT)
Message-ID: <c5722699-d366-3f26-635d-a45f746a3658@arm.com>
Date:   Wed, 7 Jun 2023 15:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
 <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 2023-02-11 17:50, Qais Yousef wrote:
> [...]
>>
>> So EAS keeps packing on the cheaper PD/clamped OPP.
> 
> Which is the desired behavior for uclamp_max?
> 
> The only issue I see is that we want to distribute within a pd. Which is
> something I was going to work on and send after later - but can lump it in this
> series if it helps.

I more or less share the same concern with Dietmar, which is packing 
things on the same small CPU when everyone has spare cpu_cap of 0.

I wonder if this could be useful: On the side of cfs_rq->avg.util_avg, 
we have a cfs_rq->avg.util_avg_uclamp_max. It is keeping track of 
util_avg, but each task on the rq is capped at its uclamp_max value, so 
even if there's two always-running tasks with uclamp_max values of 100 
with no idle time, the cfs_rq only sees cpu_util() of 200 and still has 
remaining capacity of 1024 - 200, not 0. This also helps balancing the 
load when rqs have no idle time. Even if two CPUs both have no idle 
time, but one is running a single task clamped at 100, the other running 
2 such tasks, the first sees a remaining capacity of 1024 - 100, while 
the 2nd is 1024 - 200, so we still prefer the first one.

And I wonder if this could also help calculating energy when there's no 
idle time under uclamp_max. Instead of seeing a util_avg at 1024, we 
actually see a lower value. This is also what cpu_util_next() does in 
Android's sum aggregation, but I'm thinking of maintaining it right 
beside util_avg so that we don't have to sum up everything every time.

Hongyan
