Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276346DD5DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjDKIrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjDKIrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:47:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E98A40D9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3khVLoBfpRkaDI9aLJ8kBWbdvPzWvw0wqVeYqr67WlY=; b=LowT5nMcD8rw4uiYJVFZhxuxNr
        PnSTfc0JZIRgHMxYNfIhClyFWzm5rNlqBGSMWffXQXke8eyqz2De7nZ4iV88Oz/721mYIb1L+rFKx
        H/jWh7IuNk4h1HQoWmKCJ/VVp2sSG0y9oaOJitDJowQTSBsETZHzAe4y1U9LShKs3pyDpyiLj0M97
        Q3M3G2HSLED5UaU3+3f6DoM9WbYdsyu/hVW+JeUdwbAPOeCb8WY9bdw+xn1jXYSnIWyD6HV3yvW+8
        RxbSkiLPxhPV8AHhiuIdkVrdsI0Lbbb1/mlhzMVtglLoeHVPh0FSfY1ZwJmJVvlLy2cykMic/DjBq
        CnKq9X5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pm9e9-00DI5p-36;
        Tue, 11 Apr 2023 08:46:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35BAE300244;
        Tue, 11 Apr 2023 10:46:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03C8F2BC3D07B; Tue, 11 Apr 2023 10:46:34 +0200 (CEST)
Date:   Tue, 11 Apr 2023 10:46:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230411084634.GA576825@hirez.programming.kicks-ass.net>
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
 <386a6e32-a746-9eb1-d5ae-e5bedaa8fc75@efficios.com>
 <20230406095122.GF386572@hirez.programming.kicks-ass.net>
 <fdaa7242-4ddd-fbe2-bc0e-6c62054dbde8@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdaa7242-4ddd-fbe2-bc0e-6c62054dbde8@efficios.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 07:50:42PM -0400, Mathieu Desnoyers wrote:

> Let's looks at the relevant combinations of TSA/TSB, and TMA transitions.
> 
> Scenario A) (TSA)+(TMA) (from next task perspective)
> 
> CPU0                                                 CPU1
> 
> Context switch CS-1                                  Migrate-from
>   - store to rq->curr: (N)->(Y) (TSA)                - cmpxchg to *pcpu_id to LAZY (TMA)
>      *** missing barrier ?? ***                        (implied barrier after cmpxchg)
>   - prepare_task_switch()
>     - switch_mm_cid()
>       - mm_cid_get (next)
>         - READ_ONCE(*pcpu_cid)                       - rcu_dereference(src_rq->curr)
> 
> This Dekker ensures that either task (Y) is observed by the rcu_dereference() or the LAZY
> flag is observed by READ_ONCE(), or both are observed.
> 
> If task (Y) store is observed by rcu_dereference(), it means that there is still
> an active task on the cpu. Migrate-from will therefore not transition to UNSET, which
> fulfills property (1). That observed task will itself eventually need a migrate-from
> to be migrated away from that cpu, which fulfills property (2).
> 
> If task (Y) is not observed, but the lazy flag is observed by READ_ONCE(), it will
> move its state to UNSET, which clears the percpu cid perhaps uselessly (which is not
> an issue for correctness). Because task (Y) is not observed, CPU1 can move ahead to
> set the state to UNSET. Because moving state to UNSET is done with a cmpxchg expecting
> that the old state has the LAZY flag set, only one thread will successfully UNSET.
> 
> If both states (LAZY flag and task (Y)) are observed, the thread on CPU0 will observe
> the LAZY flag and transition to UNSET (perhaps uselessly), and CPU1 will observe task
> (Y) and do nothing more, which is fine.
> 
> What we are effectively preventing with this Dekker is a scenario where neither LAZY
> flag nor store (Y) are observed, which would fail property (1) because this would
> UNSET a cid which is actively used.

OK, this I'll buy. Let me go stare at this more.

> Scenario B) (TSB)+(TMA) (from prev task perspective)
> 
> CPU0                                                 CPU1
> 
> Context switch CS-1                                  Migrate-from
>   - store to rq->curr: (Y)->(N) (TSB)                - cmpxchg to *pcpu_id to LAZY (TMA)
>     *** missing barrier ?? ***                         (implied barrier after cmpxchg)
>   - prepare_task_switch()
>     - switch_mm_cid()
>       - cid_put_lazy() (prev)
>         - READ_ONCE(*pcpu_cid)                       - rcu_dereference(src_rq->curr)
> 

This I'm conflicted about, if we're running Y, then how the heck do we
get to setting LAZY in the first place?

For this scenario there must be at least an N->Y->N transition, such
that the first:

  if (src_task->mm_cid_active && src_task->mm == mm) {

can observe N and proceed to setting LAZY. But that then leads us to the
scenario above.

(And apparently I ended up doing an N->N transition, which really isn't
*that* interesting :-)
