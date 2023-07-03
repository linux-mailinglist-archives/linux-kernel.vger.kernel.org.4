Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D433745C81
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjGCMsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGCMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDD4AF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688388451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=RbSlouIZsPSd/8a9Ce8g/7RcyVMYy6eeMXf5foZHFwI=;
        b=CkcYy5/A+0Z4QSInzn1ClB8XoUXYSI1XckzsL5E3Dy02mR7aVwFuZyCwYXxStrGLjPQ2ia
        lOg1RESyiytCHGqOEuytMFIP8CvUpGQaOr0FksgFDG4gO9YY1g1dRGY7vSLBhlcsGBtwM0
        qvU6vItcRXtApE1ec/5/fZPjGbKJgCg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-zzC313NOPauVczKId5CHCA-1; Mon, 03 Jul 2023 08:47:30 -0400
X-MC-Unique: zzC313NOPauVczKId5CHCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 352F6185A791;
        Mon,  3 Jul 2023 12:47:30 +0000 (UTC)
Received: from fedora (unknown [10.22.8.203])
        by smtp.corp.redhat.com (Postfix) with SMTP id 70CCD15230A7;
        Mon,  3 Jul 2023 12:47:28 +0000 (UTC)
Date:   Mon, 3 Jul 2023 09:47:26 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com
Subject: Splat in kernel RT while processing incoming network packets
Message-ID: <bkw2aao62e3ppg7332dbhycgzdwr7k5brezj3bcij6zewphmnd@eigmbvjh6wuu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I am writing to report a splat issue we encountered while running the
Real-Time (RT) kernel in conjunction with Network RPS (Receive Packet
Steering).

During some testing of the RT kernel version 6.4.0 with Network RPS enabled,
we observed a splat occurring in the SoftIRQ subsystem. The splat message is as
follows:

[   37.168920] ------------[ cut here ]------------
[   37.168925] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:291 do_softirq_post_smp_call_flush+0x2d/0x60
[   37.168935] Modules linked in: xt_conntrack(E) ...
[   37.168976] Unloaded tainted modules: intel_cstate(E):4 intel_uncore(E):3
[   37.168994] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G            E     -------  ---  6.4.0-0.rc2.23.test.eln127.x86_64+rt #1
[   37.168996] Hardware name: Red Hat KVM, BIOS 1.15.0-2.module+el8.6.0+14757+c25ee005 04/01/2014
[   37.168998] RIP: 0010:do_softirq_post_smp_call_flush+0x2d/0x60
[   37.169001] Code: 00 0f 1f 44 00 00 53 89 fb 48 c7 c7 f7 98 be 96 e8 d8 97 d2 00 65 66 8b 05 f8 36 ...
[   37.169002] RSP: 0018:ffffffff97403eb0 EFLAGS: 00010002
[   37.169004] RAX: 0000000000000008 RBX: 0000000000000000 RCX: 0000000000000003
[   37.169005] RDX: ffff992db7a34840 RSI: ffffffff96be98f7 RDI: ffffffff96bc23d8
[   37.169006] RBP: ffffffff97410000 R08: ffff992db7a34840 R09: ffff992c87f8dbc0
[   37.169007] R10: 00000000fffbfc67 R11: 0000000000000018 R12: 0000000000000000
[   37.169008] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   37.169011] FS:  0000000000000000(0000) GS:ffff992db7a00000(0000) knlGS:0000000000000000
[   37.169013] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.169014] CR2: 00007f028b8da3f8 CR3: 0000000118f44001 CR4: 0000000000370eb0
[   37.169015] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   37.169015] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   37.169016] Call Trace:
[   37.169018]  <TASK>
[   37.169020]  flush_smp_call_function_queue+0x78/0x80
[   37.169026]  do_idle+0xb2/0xd0
[   37.169030]  cpu_startup_entry+0x1d/0x20
[   37.169032]  rest_init+0xd1/0xe0
[   37.169037]  arch_call_rest_init+0xe/0x30
[   37.169044]  start_kernel+0x342/0x420
[   37.169046]  x86_64_start_reservations+0x18/0x30
[   37.169051]  x86_64_start_kernel+0x96/0xa0
[   37.169054]  secondary_startup_64_no_verify+0x10b/0x10b
[   37.169059]  </TASK>
[   37.169060] ---[ end trace 0000000000000000 ]---

It comes from [1].

The issue lies in the mechanism of RPS to defer network packets processing to
other CPUs. It sends an IPI to the to the target CPU. The registered callback
is rps_trigger_softirq, which will raise a softirq, leading to the following
scenario:

CPU0                                    CPU1
| netif_rx()                            |
| | enqueue_to_backlog(cpu=1)           |
| | | net_rps_send_ipi()                |
|                                       | flush_smp_call_function_queue()
|                                       | | was_pending = local_softirq_pending()
|                                       | | __flush_smp_call_function_queue()
|                                       | | rps_trigger_softirq()
|                                       | | | __raise_softirq_irqoff()
|                                       | | do_softirq_post_smp_call_flush()

That has the undesired side effect of raising a softirq in a function call,
leading to the aforementioned splat.

The kernel version is kernel-ark [1], os-build-rt branch. It is essentially the
upstream kernel with the PREEMPT_RT patches, and with RHEL configs. I can
provide the .config.

The only solution I imagined so far was to modify RPS to process packtes in a
kernel thread in RT. But I wonder how would be that be different than processing
them in ksoftirqd.

Any inputs on the issue?

[1] https://elixir.bootlin.com/linux/latest/source/kernel/softirq.c#L306

Cheers,
Wander

