Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7F96DDB06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDKMiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDKMix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:38:53 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A749D0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681216697;
        bh=CynmrVctmOLW2VdIhjAbLNRUDPLW50bg0JK95n3w3yA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Yyt7rlfT16P9dEJWmzIhqKm3Z8pr40LcTVkgQNNJfgBsIm6RWwE/eeUzgp2wx2OlE
         nd4UVtHuAimhYMlk7dFqlJ2I1u8symyb0EfLwqQ8F36Wf7BF0J03RcNvps/t7G00QP
         KTKN5n1wT74zKwT0qurwiqVN2ugShJsAVVPqrwTljoijZSYSFlIeFlBf/oBuJTC7ku
         QNs7zaT2pNKDtC12olxDayiJruvJtoZaOuOjQJS/unKd0c5e65/a7sMLqSVVLEWLPc
         kycxT5x1BjqIjwyYQ5AZuM8uIP9IK+l+hECxmjqCoefG14AuztKXAst+ER+jtWZtw3
         hLrWvzaWKNBiQ==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PwlkK3kWkzvTX;
        Tue, 11 Apr 2023 08:38:17 -0400 (EDT)
Message-ID: <29deabdb-5317-d64d-e05f-9bbe4438711d@efficios.com>
Date:   Tue, 11 Apr 2023 08:38:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
 <386a6e32-a746-9eb1-d5ae-e5bedaa8fc75@efficios.com>
 <20230406095122.GF386572@hirez.programming.kicks-ass.net>
 <fdaa7242-4ddd-fbe2-bc0e-6c62054dbde8@efficios.com>
 <20230411084634.GA576825@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230411084634.GA576825@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-11 04:46, Peter Zijlstra wrote:
> On Fri, Apr 07, 2023 at 07:50:42PM -0400, Mathieu Desnoyers wrote:
> 
>> Let's looks at the relevant combinations of TSA/TSB, and TMA transitions.
>>
>> Scenario A) (TSA)+(TMA) (from next task perspective)
>>
>> CPU0                                                 CPU1
>>
>> Context switch CS-1                                  Migrate-from
>>    - store to rq->curr: (N)->(Y) (TSA)                - cmpxchg to *pcpu_id to LAZY (TMA)
>>       *** missing barrier ?? ***                        (implied barrier after cmpxchg)
>>    - prepare_task_switch()
>>      - switch_mm_cid()
>>        - mm_cid_get (next)
>>          - READ_ONCE(*pcpu_cid)                       - rcu_dereference(src_rq->curr)
>>
>> This Dekker ensures that either task (Y) is observed by the rcu_dereference() or the LAZY
>> flag is observed by READ_ONCE(), or both are observed.
>>
>> If task (Y) store is observed by rcu_dereference(), it means that there is still
>> an active task on the cpu. Migrate-from will therefore not transition to UNSET, which
>> fulfills property (1). That observed task will itself eventually need a migrate-from
>> to be migrated away from that cpu, which fulfills property (2).
>>
>> If task (Y) is not observed, but the lazy flag is observed by READ_ONCE(), it will
>> move its state to UNSET, which clears the percpu cid perhaps uselessly (which is not
>> an issue for correctness). Because task (Y) is not observed, CPU1 can move ahead to
>> set the state to UNSET. Because moving state to UNSET is done with a cmpxchg expecting
>> that the old state has the LAZY flag set, only one thread will successfully UNSET.
>>
>> If both states (LAZY flag and task (Y)) are observed, the thread on CPU0 will observe
>> the LAZY flag and transition to UNSET (perhaps uselessly), and CPU1 will observe task
>> (Y) and do nothing more, which is fine.
>>
>> What we are effectively preventing with this Dekker is a scenario where neither LAZY
>> flag nor store (Y) are observed, which would fail property (1) because this would
>> UNSET a cid which is actively used.
> 
> OK, this I'll buy. Let me go stare at this more.
> 
>> Scenario B) (TSB)+(TMA) (from prev task perspective)
>>
>> CPU0                                                 CPU1
>>
>> Context switch CS-1                                  Migrate-from
>>    - store to rq->curr: (Y)->(N) (TSB)                - cmpxchg to *pcpu_id to LAZY (TMA)
>>      *** missing barrier ?? ***                         (implied barrier after cmpxchg)
>>    - prepare_task_switch()
>>      - switch_mm_cid()
>>        - cid_put_lazy() (prev)
>>          - READ_ONCE(*pcpu_cid)                       - rcu_dereference(src_rq->curr)
>>
> 
> This I'm conflicted about, if we're running Y, then how the heck do we
> get to setting LAZY in the first place?
> 
> For this scenario there must be at least an N->Y->N transition, such
> that the first:
> 
>    if (src_task->mm_cid_active && src_task->mm == mm) {
> 
> can observe N and proceed to setting LAZY. But that then leads us to the
> scenario above.

Remember that migrate-from does not hold any rq lock. Therefore, it's 
very much possible that the first check:

   if (src_task->mm_cid_active && src_task->mm == mm) {

observes (N), then gets delayed for a while, and then only sets the
LAZY flag when (Y) has been scheduled, leading us to Scenario B).

Thanks,

Mathieu





-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

