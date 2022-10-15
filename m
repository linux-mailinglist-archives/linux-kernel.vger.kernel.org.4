Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52CC5FFA5F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJONxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 09:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJONxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 09:53:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5834752E7F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CnzUIp3qxALf1Dl1dPbjDjRUdaBdw43OChpkexPuzt8=; b=mVo8bL7K0RX1G2TKoODrfueYEO
        AwMiE74O871YdliJgvY0wjHAuLWH066+SMI4OPbUGmUAAGPu+PE0Hrp1CYHAAA433qbGFICTpQ1dx
        gRLLzzf8ftxj0bXZIKDQnsxNiby0xIYbsKtkkZRih/e89jvnKxsTOUAlPvx9WfyrfULk6vhdkvKeY
        j6yFQhSwlxVnueWbGk4nOGi6QFUPwqsYbIHIRKbyDfstOeyLpi8Ur+ueE4rQj8POUZaE8DAnXdRhv
        J8UcK6kJoFbjJ5QIjkXluqegwU0XM+fQvRmc9aFJukl3vf7zbqHPcAZPfqeTs4cAv20/ZBafZ2aNY
        SET8nW0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojhbN-003gtx-Vc; Sat, 15 Oct 2022 13:53:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3EC61300023;
        Sat, 15 Oct 2022 15:53:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11D3F201FF8A1; Sat, 15 Oct 2022 15:53:20 +0200 (CEST)
Date:   Sat, 15 Oct 2022 15:53:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, youssefesmat@google.com
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <Y0q7TyEWco/PfOAI@hirez.programming.kicks-ass.net>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-8-connoro@google.com>
 <Y0YeUhDZWb49mpLo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0YeUhDZWb49mpLo@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 01:54:26AM +0000, Joel Fernandes wrote:

> Here, for CFS, doesn't this mean that the ->vruntime of the blocked task does
> not change while it is giving the owner a chance to run?
> 
> So that feels like if the blocked task is on the left-most node of the cfs
> rbtree, then it will always proxy to the owner while not letting other
> unrelated CFS tasks to run. That sounds like a breakage of fairness.
> 
> Or did I miss something?

So CFS will pick the leftmost task, if it happens to be the lock owner,
it will run as normal, owner time will advance.

When owner time is advanced enough to not be elegible anymore, it is
likely a blocked task is selected, at which time we'll advance it's
vruntime.

All this repeats until the whole block chain has advanced enough to make
the owner elegible again and the whole thing repeats.

From this it is easy to see that the critical secion executes with the
direct sum of the blockchain as a whole (all of them will have donated
their relative time to make the owner elegible again) -- provided the
critical section is of course long enough for this to matter (or it's
owner's weight small enough etc..).

