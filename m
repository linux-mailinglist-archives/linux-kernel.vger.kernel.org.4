Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F667464C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGCVQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGCVQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA7FE59
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 14:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688418963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NENXXCiC7OAFQilxnhjqx6Ufv54FNd/+AfsLgRs78Ig=;
        b=JTY98jAH8p+GkWuM9+58k/D9w4geo53dsMpHMhwN0WWkQQbo+1+dS4WeT2k6F3OAPBqOL5
        pJia5WuS7P5yzm00sJeJ2DcZ8rvF0XLrl6dC22NxgZgnhg7CamCc2VFqCTWR+pGvRNftdF
        Ej+n3EnZjL6DwDzgx/ZWsUoqCtc9nFM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-PK909c3uPwCditIylMbwqA-1; Mon, 03 Jul 2023 17:16:01 -0400
X-MC-Unique: PK909c3uPwCditIylMbwqA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 530193C01DEC;
        Mon,  3 Jul 2023 21:16:01 +0000 (UTC)
Received: from fedora (unknown [10.22.8.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90257492C13;
        Mon,  3 Jul 2023 21:15:59 +0000 (UTC)
Date:   Mon, 3 Jul 2023 18:15:58 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        juri.lelli@redhat.com
Subject: Re: Splat in kernel RT while processing incoming network packets
Message-ID: <x6d2ae4ss4wvvuib2hmop6ztysjsbyno7gbjkyek5xng2kmgyd@yfmnfognlj5n>
References: <bkw2aao62e3ppg7332dbhycgzdwr7k5brezj3bcij6zewphmnd@eigmbvjh6wuu>
 <20230703142908.RcxjjF_E@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230703142908.RcxjjF_E@linutronix.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 04:29:08PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-07-03 09:47:26 [-0300], Wander Lairson Costa wrote:
> > Dear all,
> Hi,
> 
> > I am writing to report a splat issue we encountered while running the
> > Real-Time (RT) kernel in conjunction with Network RPS (Receive Packet
> > Steering).
> > 
> > During some testing of the RT kernel version 6.4.0 with Network RPS enabled,
> > we observed a splat occurring in the SoftIRQ subsystem. The splat message is as
> > follows:
> > 
> > [   37.168920] ------------[ cut here ]------------
> > [   37.168925] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:291 do_softirq_post_smp_call_flush+0x2d/0x60
> …
> > [   37.169060] ---[ end trace 0000000000000000 ]---
> > 
> > It comes from [1].
> > 
> > The issue lies in the mechanism of RPS to defer network packets processing to
> > other CPUs. It sends an IPI to the to the target CPU. The registered callback
> > is rps_trigger_softirq, which will raise a softirq, leading to the following
> > scenario:
> > 
> > CPU0                                    CPU1
> > | netif_rx()                            |
> > | | enqueue_to_backlog(cpu=1)           |
> > | | | net_rps_send_ipi()                |
> > |                                       | flush_smp_call_function_queue()
> > |                                       | | was_pending = local_softirq_pending()
> > |                                       | | __flush_smp_call_function_queue()
> > |                                       | | rps_trigger_softirq()
> > |                                       | | | __raise_softirq_irqoff()
> > |                                       | | do_softirq_post_smp_call_flush()
> > 
> > That has the undesired side effect of raising a softirq in a function call,
> > leading to the aforementioned splat.
> 
> correct.
> 
> > The kernel version is kernel-ark [1], os-build-rt branch. It is essentially the
> > upstream kernel with the PREEMPT_RT patches, and with RHEL configs. I can
> > provide the .config.
> 
> It is fine, I see it.
> 
> > The only solution I imagined so far was to modify RPS to process packtes in a
> > kernel thread in RT. But I wonder how would be that be different than processing
> > them in ksoftirqd.
> > 
> > Any inputs on the issue?
> 
> Not sure how to proceed. One thing you could do is a hack similar like
> net-Avoid-the-IPI-to-free-the.patch which does it for defer_csd.

At first sight it seems straightforward to implement.

> On the other hand we could drop net-Avoid-the-IPI-to-free-the.patch and
> remove the warning because we have now commit
>    d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")

But I am more in favor of a solution that removes code than one that
adds more :)

> 
> Prior that, raising softirq from hardirq would wake ksoftirqd which in
> turn would collect all pending softirqs. As a consequence all following
> softirqs (networking, …) would run as SCHED_OTHER and compete with
> SCHED_OTHER tasks for resources. Not good because the networking work is
> no longer processed within the networking interrupt thread. Also not a
> DDoS kind of situation where one could want to delay processing.
> 
> With that change, this isn't the case anymore. Only an "unrelated" IRQ
> thread could pick up the networking work which is less then ideal. That
> is because the global softirq set is added, ksoftirq is marked for a
> wakeup and could be delayed because other tasks are busy. Then the disk
> interrupt (for instance) could pick it up as part of its threaded
> interrupt.
> 
> Now that I think about, we could make the backlog pseudo device a
> thread. NAPI threading enables one thread but here we would need one
> thread per-CPU. So it would remain kind of special. But we would avoid
> clobbering the global state and delay everything to ksoftird. Processing
> it in ksoftirqd might not be ideal from performance point of view.

Before sending this to the ML, I talked to Paolo about using NAPI
thread. He explained that it is implemented per interface. For example,
for this specific case, it happened on the loopback interface, which
doesn't implement NAPI. I am cc'ing him, so the can correct me if I am
saying something wrong.

> 
> > [1] https://elixir.bootlin.com/linux/latest/source/kernel/softirq.c#L306
> > 
> > Cheers,
> > Wander
> 
> Sebastian
> 

