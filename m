Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F409652BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiLUDd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUDd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:33:56 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEC11DA6A;
        Tue, 20 Dec 2022 19:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671593634;
        bh=W/gpvU66y8WvPv5j83q8cjmT4u7QqYAtK/WZNmWtdrc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mTR23grIJbxbf8CfpLTefwN94spcZnF+2kfdsY5crudnAwyw8EXQz9vYsdfo+Evjw
         NARKWybwTcW7rvc/g9gPQ0wEeeHV3cvpTn4nWB01rGNzsK2Oir5nUWkqxjLoQIaIbG
         GOtFxnkLYdbMfvYqw07KtiguOwTWq2Diw7t2oRFHvsiF7oBPy1ThAb8r3owePEAn9y
         XmIawlqN8CUQ+PKY3viYfMFq89uyy9XHGAOlQlj+ZKkeHa8pKVf934iFdRqIuIEZ0F
         +UTyMhtqofwwYAHm/cp6eugERbNzObNxY+h25x1pxFbTTsFZs9eTsVObu48huXG0/d
         Kz4tCjJ7TdiRQ==
Received: from [10.1.0.30] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NcJvQ3MRJzbrv;
        Tue, 20 Dec 2022 22:33:54 -0500 (EST)
Message-ID: <c085be21-b45f-4186-6f41-5082771c79ca@efficios.com>
Date:   Tue, 20 Dec 2022 22:34:19 -0500
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221220225756.GB26563@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-20 17:57, Frederic Weisbecker wrote:
> On Tue, Dec 20, 2022 at 02:01:30PM -0500, Mathieu Desnoyers wrote:
>> On 2022-12-20 13:29, Joel Fernandes wrote:
>>>
>>
>>> I do want to finish my memory barrier studies of SRCU over the holidays since I have been deep in the hole with that already. Back to the post flip memory barrier here since I think now even that might not be needed…
>>
>> I strongly suspect the memory barrier after flip is useless for the same
>> reasons I mentioned explaining why the barrier before the flip is useless.
>>
>> However, we need to double-check that we have memory barriers at the
>> beginning and end of synchronize_srcu, and between load of "unlock" counters
>> and load of "lock" counters.
>>
>> Where is the barrier at the beginning of synchronize_srcu ?
> 
> rcu_seq_snap() ?

The memory barrier in rcu_seq_snap is not at the very beginning of synchronize_srcu.

For example we have:

unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
{
         // Any prior manipulation of SRCU-protected data must happen
         // before the load from ->srcu_gp_seq.
         smp_mb();
         return rcu_seq_snap(&ssp->srcu_gp_seq);

which happens to have an explicit barrier before issuing rcu_seq_snap().

So my question still stands: where is the memory barrier at the beginning of synchronize_srcu ?

The memory ordering constraint I am concerned about here is:

  * [...] In addition,
  * each CPU having an SRCU read-side critical section that extends beyond
  * the return from synchronize_srcu() is guaranteed to have executed a
  * full memory barrier after the beginning of synchronize_srcu() and before
  * the beginning of that SRCU read-side critical section. [...]

So if we have a SRCU read-side critical section that begins after the beginning
of synchronize_srcu, but before its first memory barrier, it would miss the
guarantee that the full memory barrier is issued before the beginning of that
SRCU read-side critical section. IOW, that memory barrier needs to be at the
very beginning of the grace period.

I suspect that the memory barrier in srcu_read_lock() invoked by srcu_gp_start_if_needed
may happen to be early enough, but I'm not sure, and it does not appear to be documented
as such.

Thanks,

Mathieu

> 
>>
>> Thanks,
>>
>> Mathieu
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

