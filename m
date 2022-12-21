Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED1B6534AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiLURLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiLURLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:11:23 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13696AE5C;
        Wed, 21 Dec 2022 09:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671642677;
        bh=ksJ8oib5hNthsIEV5bELiEdvWQP+tk9zdr8VeG0K7Xs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bIVw7gAgF1vptnGgLJLkVmJLtCdSXoXIFF38aT0CiGW8QwLYIVXCoPDhNFiJq9ZH4
         9GFMMAvZI3KZYZEDyfXPXTaLmJKryrPxihT4gx0ikP2eC733WJAR2dcS5dbCDT4D1I
         RTSDOEpN/36BhUuVd4kORMilxibAGXlbo0Mn56fiRjSp45Y2r+CbGxambzWovBeskC
         TCCMdYQaGpzNjmMUN2YPQFcXYKet2JVc7yHde9uZkEUMYatZe0c0tcHWccDjJyH2/C
         /28tW44tg7HMYTFmihkqb5+3fVriD4qTTXXBGSzu9BMENhz+nIwtJFLnmREA/kq9PL
         VB6cpyqWioETA==
Received: from [10.1.0.30] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Ncg2Y1MzBzc9V;
        Wed, 21 Dec 2022 12:11:17 -0500 (EST)
Message-ID: <bb794e83-992e-8181-d9b9-acc68536ce5a@efficios.com>
Date:   Wed, 21 Dec 2022 12:11:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
 <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
 <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
 <20221220225756.GB26563@lothringen>
 <c085be21-b45f-4186-6f41-5082771c79ca@efficios.com>
 <20221221115924.GA34934@lothringen>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221221115924.GA34934@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-21 06:59, Frederic Weisbecker wrote:
> On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoyers wrote:
[...]
>>
>> The memory ordering constraint I am concerned about here is:
>>
>>   * [...] In addition,
>>   * each CPU having an SRCU read-side critical section that extends beyond
>>   * the return from synchronize_srcu() is guaranteed to have executed a
>>   * full memory barrier after the beginning of synchronize_srcu() and before
>>   * the beginning of that SRCU read-side critical section. [...]
>>
>> So if we have a SRCU read-side critical section that begins after the beginning
>> of synchronize_srcu, but before its first memory barrier, it would miss the
>> guarantee that the full memory barrier is issued before the beginning of that
>> SRCU read-side critical section. IOW, that memory barrier needs to be at the
>> very beginning of the grace period.
> 
> I'm confused, what's wrong with this ?
> 
> UPDATER                  READER
> -------                  ------
> STORE X = 1              STORE srcu_read_lock++
> // rcu_seq_snap()        smp_mb()
> smp_mb()                 READ X
> // scans
> READ srcu_read_lock

What you refer to here is only memory ordering of the store to X and 
load from X wrt loading/increment of srcu_read_lock, which is internal 
to the srcu implementation. If we really want to model the provided 
high-level memory ordering guarantees, we should consider a scenario 
where SRCU is used for its memory ordering properties to synchronize 
other variables.

I'm concerned about the following Dekker scenario, where 
synchronize_srcu() and srcu_read_lock/unlock would be used instead of 
memory barriers:

Initial state: X = 0, Y = 0

Thread A                   Thread B
---------------------------------------------
STORE X = 1                STORE Y = 1
synchronize_srcu()
                            srcu_read_lock()
                            r1 = LOAD X
                            srcu_read_unlock()
r0 = LOAD Y

BUG_ON(!r0 && !r1)

So in the synchronize_srcu implementation, there appears to be two
major scenarios: either srcu_gp_start_if_needed starts a gp or expedited 
gp, or it uses an already started gp/expedited gp. When snapshotting 
with rcu_seq_snap, the fact that the memory barrier is after the 
ssp->srcu_gp_seq load means that it does not order prior memory accesses 
before that load. This sequence value is then used to identify which 
gp_seq to wait for when piggy-backing on another already-started gp. I 
worry about reordering between STORE X = 1 and load of ssp->srcu_gp_seq, 
which is then used to piggy-back on an already-started gp.

I suspect that the implicit barrier in srcu_read_lock() invoked at the
beginning of srcu_gp_start_if_needed() is really the barrier that makes
all this behave as expected. But without documentation it's rather hard 
to follow.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

