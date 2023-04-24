Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF46ED8C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDXXZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjDXXZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708E5AD03
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 16:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682378529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBlguG2xYhqXDyNqVuNALlwUQTuLW6l7WKm5m0RyUvc=;
        b=gpkIQrJt6fQxQ2HgjcYZ1CZlmRTVgCxF8/+zfs3KI5KQprrFAEYOu5rt0y8WOzmaSGbIM5
        ee7BlQ2n6G1RushkXb6vHnJHeIuk6/3bLHyJLSYsfztNilF0kNGioD2NZJMLXef+5zz13j
        QkcK+Ifjau5+uSb8nbANuwHEMuVGRPU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-jo8_GkVBMV6nQ4b3jokK5Q-1; Mon, 24 Apr 2023 19:22:02 -0400
X-MC-Unique: jo8_GkVBMV6nQ4b3jokK5Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 337EA101A531;
        Mon, 24 Apr 2023 23:22:02 +0000 (UTC)
Received: from [10.22.18.234] (unknown [10.22.18.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDD1E492B03;
        Mon, 24 Apr 2023 23:22:00 +0000 (UTC)
Message-ID: <1a1ed12af47d00e093a81979dc25bcaab7e15e5c.camel@redhat.com>
Subject: Re: [PATCH] locking/rtmutex: Flush the plug before entering the
 slowpath.
From:   Crystal Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        John Keeping <john@metanate.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Date:   Mon, 24 Apr 2023 18:22:00 -0500
In-Reply-To: <20230419140450.qPX3cUl8@linutronix.de>
References: <20230322162719.wYG1N0hh@linutronix.de>
         <20230418151838.jNcnnDqL@linutronix.de>
         <e3f9c399a6ef26a145a9fcc53201bbd98d9428ee.camel@redhat.com>
         <20230419140450.qPX3cUl8@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-19 at 16:04 +0200, Sebastian Andrzej Siewior wrote:
> On 2023-04-18 18:43:48 [-0500], Crystal Wood wrote:
> > Sorry, got distracted.=C2=A0 It does appear to make the asserts go away=
 but I
> > ran
> > into other possibly related stalls when running rteval -- but if I
> > remove
> > both the asserts and your patch it hangs in a different way, so I need
> > to
> > investigate some more.
>=20
> So all is fine with the patch or does it still hang?

It hangs either way, but with different symptoms.

With unmodified v6.3-rc7-rt9 I get this very quickly after starting rteval:

[  178.366305] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  178.366325] rcu: 	Tasks blocked on level-1 rcu_node (CPUs 80-95): P819/1=
:b..l
[  178.366335] rcu: 	Tasks blocked on level-1 rcu_node (CPUs 128-143): P122=
0/2:b..l P1292/2:b..l
[  178.366343] rcu: 	Tasks blocked on level-1 rcu_node (CPUs 224-239): P206=
3/2:b..l
[  178.366361] rcu: 	(detected by 148, t=3D60002 jiffies, g=3D19421, q=3D12=
8303 ncpus=3D256)
[  178.366368] task:irq_work/88     state:R  running task     stack:0     p=
id:819   ppid:2      flags:0x00004000
[  178.366375] Call Trace:
[  178.366378]  <TASK>
[  178.366385]  __schedule+0x1fe/0x590
[  178.366400]  ? _raw_spin_lock+0x13/0x40
[  178.366406]  preempt_schedule_irq+0x39/0x60
[  178.366409]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  178.366418] RIP: 0010:__rcu_read_unlock+0xe/0x30
[  178.366426] Code: 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 65 48 8b 3c 25 40 18 03 00 <83=
> af 74 08 00 00 01 75 0a 8b 87 78 08 00 00 85 c0 75 05 c3 cc cc
[  178.366428] RSP: 0018:ffffa1218ecfbec0 EFLAGS: 00000246
[  178.366431] RAX: 0000000000000001 RBX: ffff944c0e032f48 RCX: 00000000000=
00000
[  178.366432] RDX: ffff942c173099c0 RSI: ffffffff9b997992 RDI: ffff942c173=
099c0
[  178.366433] RBP: ffff942c162e4bb0 R08: ffff942c1730a2f8 R09: ffff942c173=
0a2f8
[  178.366434] R10: 0000000000000282 R11: 0000000000000000 R12: 00000000000=
00000
[  178.366435] R13: 0000000000000001 R14: 0000000000000058 R15: ffff940cc82=
29500
[  178.366441]  rcuwait_wake_up+0x2e/0x40
[  178.366449]  run_irq_workd+0x39/0x50
[  178.366456]  smpboot_thread_fn+0x1c3/0x2b0
[  178.366463]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  178.366465]  kthread+0x108/0x130
[  178.366469]  ? __pfx_kthread+0x10/0x10
[  178.366470]  ret_from_fork+0x2c/0x50
[  178.366480]  </TASK>
[  178.366481] task:rcuc/140        state:R  running task     stack:0     p=
id:1292  ppid:2      flags:0x00004000
[  178.366484] Call Trace:
[  178.366485]  <TASK>
[  178.366486]  __schedule+0x1fe/0x590
[  178.366489]  preempt_schedule_irq+0x39/0x60
[  178.366491]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  178.366493] RIP: 0010:rcu_cblist_dequeue+0x15/0x30
[  178.366498] Code: 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 =
90 90 90 0f 1f 44 00 00 48 8b 07 48 85 c0 74 10 48 83 6f 10 01 48 8b 10 <48=
> 89 17 48 85 d2 74 05 c3 cc cc cc cc 48 89 7f 08 c3 cc cc cc cc
[  178.366500] RSP: 0018:ffffa1218fc93e10 EFLAGS: 00000202
[  178.366501] RAX: ffff940f12aedb80 RBX: 00000000000000c6 RCX: 00000000000=
00000
[  178.366501] RDX: ffff940f12aec500 RSI: ffffffff9b94e60e RDI: ffffa1218fc=
93e28
[  178.366502] RBP: ffff940cc88c3380 R08: 0000000000000001 R09: ffffffff9a5=
c1ea3
[  178.366503] R10: 00000000000002c8 R11: 0000000001a6b00f R12: ffff942b8e1=
32f00
[  178.366504] R13: 00000000000000c5 R14: 0000000000000000 R15: ffff942b8e1=
32f78
[  178.366505]  ? rcu_do_batch+0x1a3/0x4e0
[  178.366508]  rcu_do_batch+0x17f/0x4e0
[  178.366511]  rcu_core+0x2d4/0x4a0
[  178.366514]  rcu_cpu_kthread+0xb4/0x2f0
[  178.366517]  smpboot_thread_fn+0x1c3/0x2b0
[  178.366519]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  178.366521]  kthread+0x108/0x130
[  178.366522]  ? __pfx_kthread+0x10/0x10
[  178.366523]  ret_from_fork+0x2c/0x50
[  178.366527]  </TASK>
[  178.366528] task:rcuc/132        state:R  running task     stack:0     p=
id:1220  ppid:2      flags:0x00004000
[  178.366530] Call Trace:
[  178.366531]  <TASK>
[  178.366532]  __schedule+0x1fe/0x590
[  178.366534]  preempt_schedule_irq+0x39/0x60
[  178.366535]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  178.366537] RIP: 0010:kmem_cache_free+0xf6/0x430
[  178.366542] Code: 03 0d 76 de 25 01 48 29 c8 89 c1 48 0f af f1 0f b6 4d =
24 48 c1 ee 20 29 f0 d3 e8 0f b6 4d 25 01 f0 d3 e8 48 8d 0c c2 4c 8b 39 <4d=
> 85 ff 74 75 48 c7 01 00 00 00 00 8b 75 18 4c 89 ff 48 83 c6 08
[  178.366543] RSP: 0018:ffffa1218fa33de0 EFLAGS: 00000212
[  178.366544] RAX: 0000000000000019 RBX: 0000000000000006 RCX: ffff940fd06=
3c0c8
[  178.366545] RDX: ffff940fd063c000 RSI: 00000000000012c0 RDI: ffffffc206e=
93f40
[  178.366546] RBP: ffff940cc01f6f00 R08: 0000000000000001 R09: ffffffff9a5=
c1ea3
[  178.366546] R10: 000000000000004d R11: 00000000000000b5 R12: ffff940e13e=
69f40
[  178.366547] R13: ffffffff9a5c1ea3 R14: ffffcdd8894f9a00 R15: ffff940d62b=
27500
[  178.366548]  ? rcu_do_batch+0x1a3/0x4e0
[  178.366550]  ? rcu_do_batch+0x1a3/0x4e0
[  178.366553]  rcu_do_batch+0x1a3/0x4e0
[  178.366555]  rcu_core+0x2d4/0x4a0
[  178.366557]  rcu_cpu_kthread+0xb4/0x2f0
[  178.366559]  smpboot_thread_fn+0x1c3/0x2b0
[  178.366561]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  178.366564]  kthread+0x108/0x130
[  178.366565]  ? __pfx_kthread+0x10/0x10
[  178.366566]  ret_from_fork+0x2c/0x50
[  178.366570]  </TASK>
[  178.366571] task:rcuc/225        state:R  running task     stack:0     p=
id:2063  ppid:2      flags:0x00004000
[  178.366574] Call Trace:
[  178.366575]  <TASK>
[  178.366577]  __schedule+0x1fe/0x590
[  178.366579]  preempt_schedule_irq+0x39/0x60
[  178.366581]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  178.366583] RIP: 0010:rcu_cblist_dequeue+0x15/0x30
[  178.366585] Code: 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 =
90 90 90 0f 1f 44 00 00 48 8b 07 48 85 c0 74 10 48 83 6f 10 01 48 8b 10 <48=
> 89 17 48 85 d2 74 05 c3 cc cc cc cc 48 89 7f 08 c3 cc cc cc cc
[  178.366586] RSP: 0018:ffffa121915ffe10 EFLAGS: 00000216
[  178.366587] RAX: ffff942d4dd9bd40 RBX: 000000000000001f RCX: 00000000000=
00000
[  178.366588] RDX: ffff942d4dd99040 RSI: ffffffff9b94e60e RDI: ffffa121915=
ffe28
[  178.366588] RBP: ffff942c18908000 R08: 0000000000000001 R09: ffffffff9a5=
c1ea3
[  178.366589] R10: 000000000000005e R11: 000000000000000b R12: ffff944c0f2=
72f00
[  178.366590] R13: 000000000000001e R14: 0000000000000000 R15: ffff944c0f2=
72f78
[  178.366591]  ? rcu_do_batch+0x1a3/0x4e0
[  178.366593]  rcu_do_batch+0x17f/0x4e0
[  178.366595]  rcu_core+0x2d4/0x4a0
[  178.366598]  rcu_cpu_kthread+0xb4/0x2f0
[  178.366600]  smpboot_thread_fn+0x1c3/0x2b0
[  178.366602]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  178.366604]  kthread+0x108/0x130
[  178.366605]  ? __pfx_kthread+0x10/0x10
[  178.366606]  ret_from_fork+0x2c/0x50
[  178.366610]  </TASK>
[  178.366611] rcu: rcu_preempt kthread timer wakeup didn't happen for 5898=
9 jiffies! g19421 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
[  178.366613] rcu: 	Possible timer handling issue on cpu=3D144 timer-softi=
rq=3D91
[  178.366615] rcu: rcu_preempt kthread starved for 58993 jiffies! g19421 f=
0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D144
[  178.366617] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, O=
OM is now expected behavior.
[  178.366618] rcu: RCU grace-period kthread stack dump:
[  178.366619] task:rcu_preempt     state:I stack:0     pid:19    ppid:2   =
   flags:0x00004000
[  178.366620] Call Trace:
[  178.366621]  <TASK>
[  178.366622]  __schedule+0x1fe/0x590
[  178.366624]  schedule+0x5d/0xc0
[  178.366626]  schedule_timeout+0x88/0x190
[  178.366629]  ? __pfx_process_timeout+0x10/0x10
[  178.366634]  rcu_gp_fqs_loop+0x114/0x480
[  178.366639]  rcu_gp_kthread+0xf8/0x1c0
[  178.366642]  ? __pfx_rcu_gp_kthread+0x10/0x10
[  178.366644]  kthread+0x108/0x130
[  178.366645]  ? __pfx_kthread+0x10/0x10
[  178.366646]  ret_from_fork+0x2c/0x50
[  178.366650]  </TASK>
[  178.366650] rcu: Stack dump where RCU GP kthread last ran:
[  178.366651] Sending NMI from CPU 148 to CPUs 144:
[  178.366661] NMI backtrace for cpu 144 skipped: idling at poll_idle+0x5a/=
0xa4

-Crystal

