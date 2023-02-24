Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB0A6A1C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjBXNDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjBXNDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:03:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C4C11EA1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677243775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a1W3hnLdDA1vYkLVql4lAQzXqEWqGXhPistOdxEFTyw=;
        b=B+SXqsO1+4AKdm4bmEdjWRaVk4F1QLJmkqHFcSGM3Xkg1hp9U2S8P2wN+cxPTGPj9T6jtf
        x3M4f6aBnBSGJQUDt0G1QqP7AlFFsP6o9mYt+iLNZrxzCuypEbIcf6AfdBrLVtrUGcKfMe
        x51QOpHabA8SHJ+tlIBhapK98WmjpkM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-uVbISPULMzaxy7U8qF1W-g-1; Fri, 24 Feb 2023 08:02:53 -0500
X-MC-Unique: uVbISPULMzaxy7U8qF1W-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D30D280A337;
        Fri, 24 Feb 2023 13:02:47 +0000 (UTC)
Received: from fedora (unknown [10.22.8.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9510F404BEC0;
        Fri, 24 Feb 2023 13:02:41 +0000 (UTC)
Date:   Fri, 24 Feb 2023 10:02:40 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/task: Add the put_task_struct_atomic_safe
 function
Message-ID: <20230224130240.dzbtk7w564heup3d@fedora>
References: <20230120150246.20797-2-wander@redhat.com>
 <20230123163002.GB6268@redhat.com>
 <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
 <xhsmhbkmkdla4.mognet@vschneid.remote.csb>
 <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
 <8632d9c6-7ec7-c3aa-f9e7-fa63cc82f6ae@redhat.com>
 <20230217200437.551ad7c2@nowhere>
 <20230222184237.hkfznxm3ts3gye2i@fedora>
 <20230222220034.02c38eb3@nowhere>
 <20230224094648.69cfa411@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224094648.69cfa411@luca64>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 09:46:48AM +0100, luca abeni wrote:
> On Wed, 22 Feb 2023 22:00:34 +0100
> luca abeni <luca.abeni@santannapisa.it> wrote:
> 
> > On Wed, 22 Feb 2023 15:42:37 -0300
> > Wander Lairson Costa <wander@redhat.com> wrote:
> > [...]
> > > > I triggered this "BUG: Invalid wait context" with a 5.15.76
> > > > kernel, without PREEMPT_RT. I can reproduce it easily on a
> > > > KVM-based VM; if more information or tests are needed, let me
> > > > know. 
> > > 
> > > Does it happen in linux-6.1 or linux-6.2?  
> > 
> > I only tried with 5.15.76... I am going to test 6.2 and I'll let you
> > know ASAP.
> 
> For various reasons it took more time than expected, but I managed to
> reproduce the bug with 6.2... Here are the relevant kernel messages:
> 
> [ 1246.556100] =============================
> [ 1246.559104] [ BUG: Invalid wait context ]
> [ 1246.562270] 6.2.0 #4 Not tainted
> [ 1246.564854] -----------------------------
> [ 1246.567260] swapper/3/0 is trying to lock:
> [ 1246.568665] ffff8c2c7ebb2c10 (&c->lock){..-.}-{3:3}, at: put_cpu_partial+0x24/0x1c0
> [ 1246.571325] other info that might help us debug this:
> [ 1246.573045] context-{2:2}
> [ 1246.574166] no locks held by swapper/3/0.
> [ 1246.575434] stack backtrace:
> [ 1246.576207] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.2.0 #4
> [ 1246.578184] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [ 1246.580815] Call Trace:
> [ 1246.581723]  <IRQ>
> [ 1246.582570]  dump_stack_lvl+0x49/0x61
> [ 1246.583860]  __lock_acquire.cold+0xc8/0x31c
> [ 1246.584923]  ? __lock_acquire+0x3be/0x1df0
> [ 1246.585915]  lock_acquire+0xce/0x2f0
> [ 1246.586819]  ? put_cpu_partial+0x24/0x1c0
> [ 1246.588177]  ? lock_is_held_type+0xdb/0x130
> [ 1246.589519]  put_cpu_partial+0x5b/0x1c0
> [ 1246.590996]  ? put_cpu_partial+0x24/0x1c0
> [ 1246.592212]  inactive_task_timer+0x263/0x4c0
> [ 1246.593509]  ? __pfx_inactive_task_timer+0x10/0x10
> [ 1246.594953]  __hrtimer_run_queues+0x1bf/0x470
> [ 1246.596297]  hrtimer_interrupt+0x117/0x250
> [ 1246.597528]  __sysvec_apic_timer_interrupt+0x99/0x270
> [ 1246.599015]  sysvec_apic_timer_interrupt+0x8d/0xc0
> [ 1246.600416]  </IRQ>
> [ 1246.601170]  <TASK>
> [ 1246.601918]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [ 1246.603377] RIP: 0010:default_idle+0xf/0x20
> [ 1246.604640] Code: f6 5d 41 5c e9 72 4a 6e ff cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 03 52 2a 00 fb f4 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> [ 1246.609718] RSP: 0018:ffffa1a2c009bed0 EFLAGS: 00000202
> [ 1246.611259] RAX: ffffffffa4961a60 RBX: ffff8c2c4126b000 RCX: 0000000000000000
> [ 1246.613230] RDX: 0000000000000000 RSI: ffffffffa510271b RDI: ffffffffa50d5b15
> [ 1246.615266] RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000001
> [ 1246.617275] R10: 0000000000000000 R11: ffff8c2c4126b000 R12: ffff8c2c4126b000
> [ 1246.619318] R13: ffff8c2c4126b000 R14: 0000000000000000 R15: 0000000000000000
> [ 1246.621293]  ? __pfx_default_idle+0x10/0x10
> [ 1246.622581]  default_idle_call+0x71/0x220
> [ 1246.623790]  do_idle+0x210/0x290
> [ 1246.624827]  cpu_startup_entry+0x18/0x20
> [ 1246.626016]  start_secondary+0xf1/0x100
> [ 1246.627200]  secondary_startup_64_no_verify+0xe0/0xeb
> [ 1246.628707]  </TASK>
> 
> 
> Let me know if you need more information, or
> I should run other tests/experiments.
> 

This seems to be a different (maybe related?) issue. Would you mind
sharing your .config and steps to reproduce it?

> 
> 				Luca
> 

