Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5E1745E81
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjGCO3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjGCO3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:29:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE27E59;
        Mon,  3 Jul 2023 07:29:15 -0700 (PDT)
Date:   Mon, 3 Jul 2023 16:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688394553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4eXTSstuIJtNfCSirswPN+SDcANih1rBvCVlFV4lb4=;
        b=Hy/0MJ7RO7NXMGP8iuM0zBhLtQFzhh2IcLKMKCoPxX90Zf0UbbR3ZrIKwIsp3qaxkKfkHw
        d/ESnbEiW7oo784QU2dG6sMXeQmbBhHwde1mkVw8KpOda0X34/59ks1zp6OwZrCECChPoK
        DbecWG+j0rSXCXd9+a+lX1rHQxxUFvz4vOHA3Fj9mlDky+sEYUEW0W0itWYqA0wwXQ4mEq
        qSgwlZaT3IhJ63ujd7ti+o+TyiTjoSrvkv8iBoAUU/0IAF4OFMKHUNDYxspnppOP3LnuAo
        SvH1a8nj82qrgfthfBggc5fZnr0FjROFvfdET955is1hp8rzscv+cgKnKrdTWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688394553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4eXTSstuIJtNfCSirswPN+SDcANih1rBvCVlFV4lb4=;
        b=EzUh5gfl6vKO4+59Fotn/unNfk2mVlawDqvGPIgo5E3VDXYDEwJmsK8Mf2v+C55F1h678m
        zfBXwIpQuHawyZAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        juri.lelli@redhat.com
Subject: Re: Splat in kernel RT while processing incoming network packets
Message-ID: <20230703142908.RcxjjF_E@linutronix.de>
References: <bkw2aao62e3ppg7332dbhycgzdwr7k5brezj3bcij6zewphmnd@eigmbvjh6wuu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bkw2aao62e3ppg7332dbhycgzdwr7k5brezj3bcij6zewphmnd@eigmbvjh6wuu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-03 09:47:26 [-0300], Wander Lairson Costa wrote:
> Dear all,
Hi,

> I am writing to report a splat issue we encountered while running the
> Real-Time (RT) kernel in conjunction with Network RPS (Receive Packet
> Steering).
>=20
> During some testing of the RT kernel version 6.4.0 with Network RPS enabl=
ed,
> we observed a splat occurring in the SoftIRQ subsystem. The splat message=
 is as
> follows:
>=20
> [   37.168920] ------------[ cut here ]------------
> [   37.168925] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:291 do_softirq_=
post_smp_call_flush+0x2d/0x60
=E2=80=A6
> [   37.169060] ---[ end trace 0000000000000000 ]---
>=20
> It comes from [1].
>=20
> The issue lies in the mechanism of RPS to defer network packets processin=
g to
> other CPUs. It sends an IPI to the to the target CPU. The registered call=
back
> is rps_trigger_softirq, which will raise a softirq, leading to the follow=
ing
> scenario:
>=20
> CPU0                                    CPU1
> | netif_rx()                            |
> | | enqueue_to_backlog(cpu=3D1)           |
> | | | net_rps_send_ipi()                |
> |                                       | flush_smp_call_function_queue()
> |                                       | | was_pending =3D local_softirq=
_pending()
> |                                       | | __flush_smp_call_function_que=
ue()
> |                                       | | rps_trigger_softirq()
> |                                       | | | __raise_softirq_irqoff()
> |                                       | | do_softirq_post_smp_call_flus=
h()
>=20
> That has the undesired side effect of raising a softirq in a function cal=
l,
> leading to the aforementioned splat.

correct.

> The kernel version is kernel-ark [1], os-build-rt branch. It is essential=
ly the
> upstream kernel with the PREEMPT_RT patches, and with RHEL configs. I can
> provide the .config.

It is fine, I see it.

> The only solution I imagined so far was to modify RPS to process packtes =
in a
> kernel thread in RT. But I wonder how would be that be different than pro=
cessing
> them in ksoftirqd.
>=20
> Any inputs on the issue?

Not sure how to proceed. One thing you could do is a hack similar like
net-Avoid-the-IPI-to-free-the.patch which does it for defer_csd.
On the other hand we could drop net-Avoid-the-IPI-to-free-the.patch and
remove the warning because we have now commit
   d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")

Prior that, raising softirq from hardirq would wake ksoftirqd which in
turn would collect all pending softirqs. As a consequence all following
softirqs (networking, =E2=80=A6) would run as SCHED_OTHER and compete with
SCHED_OTHER tasks for resources. Not good because the networking work is
no longer processed within the networking interrupt thread. Also not a
DDoS kind of situation where one could want to delay processing.

With that change, this isn't the case anymore. Only an "unrelated" IRQ
thread could pick up the networking work which is less then ideal. That
is because the global softirq set is added, ksoftirq is marked for a
wakeup and could be delayed because other tasks are busy. Then the disk
interrupt (for instance) could pick it up as part of its threaded
interrupt.

Now that I think about, we could make the backlog pseudo device a
thread. NAPI threading enables one thread but here we would need one
thread per-CPU. So it would remain kind of special. But we would avoid
clobbering the global state and delay everything to ksoftird. Processing
it in ksoftirqd might not be ideal from performance point of view.

> [1] https://elixir.bootlin.com/linux/latest/source/kernel/softirq.c#L306
>=20
> Cheers,
> Wander

Sebastian
