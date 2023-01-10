Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987F9664D16
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjAJUL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjAJULA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5184C72E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673381373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJ+Y7Gt+N5DuU0ItM2Y0xzY3E6CfBcAA2aVtb1Bx88Q=;
        b=RqHep7Bxc8LUFDR1QryCBRZL2oCiqehFAdtyQPa2v4mR8USNoHqvWgiAaThJRYTY9M3SLl
        DeAhVQKPSoq7a2yWsRfs70Hjt55o4IdQ7Fb/qlWxN+WFI2q6FWLlX0Ut/PRaeJ3ysabInA
        HERjxQ6fGqNYtgfGUlb7g9p1uLuu3ns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-KULDvi_0PEGqfoqE9wf3vA-1; Tue, 10 Jan 2023 15:09:28 -0500
X-MC-Unique: KULDvi_0PEGqfoqE9wf3vA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5BFD101B42B;
        Tue, 10 Jan 2023 20:09:27 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9734E492C14;
        Tue, 10 Jan 2023 20:09:26 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 6BF854050D7B8; Tue, 10 Jan 2023 17:09:06 -0300 (-03)
Date:   Tue, 10 Jan 2023 17:09:06 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>, atomlin@atomlin.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 2/6] mm/vmstat: Use vmstat_dirty to track
 CPU-specific vmstat discrepancies
Message-ID: <Y73F4tbfxT6Kb9kZ@tpad>
References: <20230105125218.031928326@redhat.com>
 <20230105125248.813825852@redhat.com>
 <b89a9828-d4e-9874-d482-dbb6cbe46@gentwo.de>
 <Y71XpnJGumySL9ej@lothringen>
 <7c2af941-42a9-a59b-6a20-b331a4934a3@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c2af941-42a9-a59b-6a20-b331a4934a3@gentwo.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 02:39:08PM +0100, Christoph Lameter wrote:
> On Tue, 10 Jan 2023, Frederic Weisbecker wrote:
> 
> > Note I'm absolutely clueless with vmstat. But I was wondering about it as well
> > while reviewing Marcelo's series, so git blame pointed me to:
> >
> > 7c83912062c801738d7d19acaf8f7fec25ea663c ("vmstat: User per cpu atomics to avoid
> > interrupt disable / enable")
> >
> > And this seem to mention that this can race with IRQs as well, hence the local
> > cmpxchg operation.
> 
> The race with irq could be an issue but I thought we avoided that and were
> content with disabling preemption.
> 
> But this issue illustrates the central problem of the patchset: It makes
> the lightweight counters not so lightweight anymore. 

https://lkml.iu.edu/hypermail/linux/kernel/0903.2/00569.html

With added

static void do_test_preempt(void)
{
        unsigned long flags;
        unsigned int i;
        cycles_t time1, time2, time;
        u32 rem;

        local_irq_save(flags);
        preempt_disable();
        time1 = get_cycles();
        for (i = 0; i < NR_LOOPS; i++) {
                preempt_disable();
                preempt_enable();
        }
        time2 = get_cycles();
        local_irq_restore(flags);
        preempt_enable();
        time = time2 - time1;

        printk(KERN_ALERT "test results: time for disabling/enabling preemption\n");
        printk(KERN_ALERT "number of loops: %d\n", NR_LOOPS);
        printk(KERN_ALERT "total time: %llu\n", time);
        time = div_u64_rem(time, NR_LOOPS, &rem);
        printk(KERN_ALERT "-> enabling/disabling preemption takes %llu cycles\n",
time);
        printk(KERN_ALERT "test end\n");
}


model name	: 11th Gen Intel(R) Core(TM) i7-11850H @ 2.50GHz

[  423.676079] test init
[  423.676249] test results: time for baseline
[  423.676405] number of loops: 200000
[  423.676676] total time: 104274
[  423.676910] -> baseline takes 0 cycles
[  423.677051] test end
[  423.678150] test results: time for locked cmpxchg
[  423.678353] number of loops: 200000
[  423.678498] total time: 2473839
[  423.678630] -> locked cmpxchg takes 12 cycles
[  423.678810] test end
[  423.679204] test results: time for non locked cmpxchg
[  423.679394] number of loops: 200000
[  423.679527] total time: 740298
[  423.679644] -> non locked cmpxchg takes 3 cycles
[  423.679817] test end
[  423.680755] test results: time for locked add return
[  423.680951] number of loops: 200000
[  423.681089] total time: 2118185
[  423.681229] -> locked add return takes 10 cycles
[  423.681411] test end
[  423.681846] test results: time for enabling interrupts (STI)
[  423.682063] number of loops: 200000
[  423.682209] total time: 861591
[  423.682335] -> enabling interrupts (STI) takes 4 cycles
[  423.682532] test end
[  423.683606] test results: time for disabling interrupts (CLI)
[  423.683852] number of loops: 200000
[  423.684006] total time: 2440756
[  423.684141] -> disabling interrupts (CLI) takes 12 cycles
[  423.684588] test end
[  423.686626] test results: time for disabling/enabling interrupts (STI/CLI)
[  423.686879] number of loops: 200000
[  423.687015] total time: 4802297
[  423.687139] -> enabling/disabling interrupts (STI/CLI) takes 24 cycles
[  423.687389] test end
[  423.688025] test results: time for disabling/enabling preemption
[  423.688258] number of loops: 200000
[  423.688396] total time: 1341001
[  423.688526] -> enabling/disabling preemption takes 6 cycles
[  423.689276] test end

> The basic primitives add a  lot of weight. 

Can't see any alternative given the necessity to avoid interruption
by the work to sync per-CPU vmstats to global vmstats.

> And the pre cpu atomic updates operations require the modification
> of multiple values. The operation 
> cannot be "atomic" in that sense anymore and we need some other form of
> synchronization that can
> span multiple instructions.

    So use this_cpu_cmpxchg() to avoid the overhead. Since we can no longer
    count on preremption being disabled we still have some minor issues.
    The fetching of the counter thresholds is racy.
    A threshold from another cpu may be applied if we happen to be
    rescheduled on another cpu.  However, the following vmstat operation
    will then bring the counter again under the threshold limit.

Those small issues are gone, OTOH.





