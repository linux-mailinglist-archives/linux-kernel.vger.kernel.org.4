Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C9E60CACE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiJYLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJYLWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:22:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF01382DC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6rHGxDSRKH7/ejAcJLi7ugcZ3Zusj0FQwU8RBAcUUHI=; b=enT5uEATH1DZv3r6WIDSAciIT6
        LgDxvfQlBqbdNOVarMJbvRKYHCMAOzrjijCrSA4nN+r46SWqPQUq4XZSmnJp8GcWN6kgu7tBZU8pd
        AHxs0WcwTXrM4Tc4cRrLvUjlgKvx1Tn2ydlD4kBIMguPD/ML4Upr/KZeCJbxRddNeqeTVmqzROufu
        3Ss32+xYQzCNdu1QCQFteaWeOkd5zvl0GIKFSwX8Fax9h8bUM1umRB/EKycT8OR8OvZKTRXqbJhxZ
        F2vR4MXvyKZPOMwnF2TS+JYPW4GB3PW/l4H9l2Fgz7AEoXv1UbdVxRJFO1qoBATvyYinbQLJjGnS0
        3Jyir26g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onI0l-006IbT-Py; Tue, 25 Oct 2022 11:22:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E848330035C;
        Tue, 25 Oct 2022 13:22:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D218C2C431FA9; Tue, 25 Oct 2022 13:22:22 +0200 (CEST)
Date:   Tue, 25 Oct 2022 13:22:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v3 2/5] locking/rwsem: Limit # of null owner retries for
 handoff writer
Message-ID: <Y1fG7nQxiLyKIhQ6@hirez.programming.kicks-ass.net>
References: <20221017211356.333862-1-longman@redhat.com>
 <20221017211356.333862-3-longman@redhat.com>
 <Y1aTpYba1Wwly48+@hirez.programming.kicks-ass.net>
 <980d882c-01b8-2ce1-663f-41a8a337f350@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <980d882c-01b8-2ce1-663f-41a8a337f350@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 11:55:53AM -0400, Waiman Long wrote:

> Looks like, There is still a window for a race.
> 
> There is a chance when a reader who came first added it's BIAS and goes to
> slowpath and before it gets added to wait list it got preempted by RT task
> which  goes to slowpath as well and being the first waiter gets its hand-off
> bit set and not able to get the lock due to following condition in
> rwsem_try_write_lock()
> 
>  630                 if (count & RWSEM_LOCK_MASK) {  ==> reader has sets its
> bias
> ..
> ...
> 
>  634
>  635                         new |= RWSEM_FLAG_HANDOFF;
>  636                 } else {
>  637                         new |= RWSEM_WRITER_LOCKED;
> 
> 
> ---------------------->----------------------->-------------------------
> 
> First reader (1)          writer(2) RT task             Lock holder(3)
> 
> It sets
> RWSEM_READER_BIAS.
> while it is going to
> slowpath(as the lock
> was held by (3)) and
> before it got added
> to the waiters list
> it got preempted
> by (2).
>                         RT task also takes
>                         the slowpath and add              release the
>                         itself into waiting list          rwsem lock
>             and since it is the first         clear the
>                         it is the next one to get         owner.
>                         the lock but it can not
>                         get the lock as (count &
>                         RWSEM_LOCK_MASK) is set
>                         as (1) has added it but
>                         not able to remove its
>             adjustment.
> 
> ----------------------
> 
> To fix that we either has to disable preemption in down_read() and reenable
> it in rwsem_down_read_slowpath after decrementing the RWSEM_READER_BIAS or
> to limit the number of trylock-spinning attempt like this patch. The latter
> approach seems a bit less messy and I am going to take it back out anyway in
> patch 4. I will put a summary of that special case in the patch description.

Funny, I find the former approach much saner. Disabling preemption
around the whole thing fixes the fundamental problem while spin-limiting
is a band-aid.

Note how rwsem_write_trylock() already does preempt_disable(), having
the read-side do something similar only makes sense.
