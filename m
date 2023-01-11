Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B471766565F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjAKIoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbjAKIn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:43:27 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D916542
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1673426538; bh=KoVgyzHofNvsfxU3iLQZtrwKbN6bHAYrV7gkyQq2px8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=wFba+scBlp5eEKXHkkgePqb6kAocgsKjyyZ1xuBacniGPTplix/P4diFoLgimrbrA
         q9PbSJUZ/t2AC4/KF/RP4XdAwvxTMP7e10Dk9iizCASAKLO33jvu2syES7yWHs0HxF
         XMOcWZa/bu0PPCBiqcU42tC80oOwPsLXk4SEpRJe6TJwA7M0A0T/nSawQFkOqEAKA3
         cgaHh7cNESHsg2LCvmJQFnb6hARlrmwPjp2Mq8CVYC21tNIqRifkxCYAtSgbcagy5V
         LLETxp2jq+Fx3RrbJjPjTmAunktIWuLqXZ5EpXKp3JQEDovw9PDzv7XFWruDiEOzk5
         h6BDmMKYwmIKQ==
Received: by gentwo.de (Postfix, from userid 1001)
        id B984AB001DF; Wed, 11 Jan 2023 09:42:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id B7AE2B00129;
        Wed, 11 Jan 2023 09:42:18 +0100 (CET)
Date:   Wed, 11 Jan 2023 09:42:18 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     Frederic Weisbecker <frederic@kernel.org>, atomlin@atomlin.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 2/6] mm/vmstat: Use vmstat_dirty to track CPU-specific
 vmstat discrepancies
In-Reply-To: <Y73F4tbfxT6Kb9kZ@tpad>
Message-ID: <60183179-3a28-6bf9-a6ab-8a8976f283d@gentwo.de>
References: <20230105125218.031928326@redhat.com> <20230105125248.813825852@redhat.com> <b89a9828-d4e-9874-d482-dbb6cbe46@gentwo.de> <Y71XpnJGumySL9ej@lothringen> <7c2af941-42a9-a59b-6a20-b331a4934a3@gentwo.de> <Y73F4tbfxT6Kb9kZ@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023, Marcelo Tosatti wrote:

> > The basic primitives add a  lot of weight.
>
> Can't see any alternative given the necessity to avoid interruption
> by the work to sync per-CPU vmstats to global vmstats.

this_cpu operations are designed to operate on a *single* value (a counter) and can
be run on an arbitrary cpu, There is no preemption or interrupt
disable required since the counters of all cpus will be added up at the
end.

You want *two* values (the counter and the dirty flag) to be modified
together and want to use the counters/flag to identify the cpu where
these events occurred. this_cpu_xxx operations are not suitable for that
purpose. You would need a way to ensure that both operations occur on the
same cpu.

> > > And the pre cpu atomic updates operations require the modification
> > of multiple values. The operation
> > cannot be "atomic" in that sense anymore and we need some other form of
> > synchronization that can
> > span multiple instructions.
>
>     So use this_cpu_cmpxchg() to avoid the overhead. Since we can no longer
>     count on preremption being disabled we still have some minor issues.
>     The fetching of the counter thresholds is racy.
>     A threshold from another cpu may be applied if we happen to be
>     rescheduled on another cpu.  However, the following vmstat operation
>     will then bring the counter again under the threshold limit.
>
> Those small issues are gone, OTOH.

Well you could use this_cpu_cmpxchg128 to update a 64 bit counter and a
flag at the same time. Otherwise you will have to switch off preemption or
interrupts when incrementing the counters and updating the dirty flag.

Thus you do not really need the this_cpu operations anymore. It would
best to use a preempt_disable section and uuse C operators -- ++ for the
counter and do regular assignment for the flag.

