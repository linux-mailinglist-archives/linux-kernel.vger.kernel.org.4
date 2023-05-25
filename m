Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9E7710F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbjEYPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbjEYPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:21:31 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F9194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:21:29 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba8cf3cb34fso997585276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685028088; x=1687620088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUuvOZp4ohZVs+06f+xW0E2DzMyZOkJ0sYTaDlgT1vs=;
        b=f82LooSd7Z8HPJYxwPF9j5/XV5x/T1dTocoQbusc6c1IUKGSUAuk9Ir1SOkxO0WNbN
         b2opwYAOqYOC4KkwzFjmYl168YBnmaOSz/DleuyrzHukBjDwPyLhgHqlAy/6nc9XqxKv
         /gwu60eypgCA/tV78al/ca4tdpRg6RRfpASV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685028088; x=1687620088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUuvOZp4ohZVs+06f+xW0E2DzMyZOkJ0sYTaDlgT1vs=;
        b=Zq3XFaFC2Omcg93KXB9E7lGmmIhT8WLRGAXpdlT7O6UCvEi2RkW60HFfHUq05kHeL9
         HgOo31Zl2aQq71v39cPmZXt1mJibgqxnxpfbHGKwOnurJtZyzdN8LPyMfLe3lYsdhx36
         z7/OZL8dEU5LaGZQ2+7EnUlmb+gXrK4UyTbyREbtdcEg49Qc2/BcfrcYyfC7nBddJctk
         yhhEKzw79PX68t1wY3SflW7WTut+lumIA144vD6KjoawVq6aMH2/lA+LkYvR3tN/zVnP
         0JpvR1D8f4HtnSHh61ZDV4wdd9BNNpEJ85Iskb1IcVp62hJQqj7zOCSf8CwiFwvUG0pY
         ddlw==
X-Gm-Message-State: AC+VfDyxrbguON6zE9QOl3o6wabnIO7ZC3MG2CwxMgI/qqaHgMdKRQML
        cHMOd12tUCLmFRqLQ5bJ2iyfNp32KHyNZkbuPZwDHA==
X-Google-Smtp-Source: ACHHUZ5klVKxazSQswoLgBHRkEqznQCwIYHY0bNpzGBBflEWsBmG5N8Vg50kHOHw7oPG/n7cky7LPcnxXNlxCIOmkok=
X-Received: by 2002:a25:73cc:0:b0:ba7:46b3:5c91 with SMTP id
 o195-20020a2573cc000000b00ba746b35c91mr3107549ybc.2.1685028088239; Thu, 25
 May 2023 08:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtCCTxT78c0T+5JFw+sN01ZnX_kvBBgDLoVLfPARc9ZuA@mail.gmail.com>
In-Reply-To: <CA+G9fYtCCTxT78c0T+5JFw+sN01ZnX_kvBBgDLoVLfPARc9ZuA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 25 May 2023 11:21:17 -0400
Message-ID: <CAEXW_YQwBy9xNRV9Xrdti46cC8vNE8nOocoL9pRrhjNMGdEWeg@mail.gmail.com>
Subject: Re: Perf: RIP: 0010:__schedule on qemu-x86_64
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, rcu <rcu@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Naresh,

On Wed, May 24, 2023 at 5:02=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Following kernel crash noticed while running perf testing on qemu-x86_64
> with stable-rc 6.3.4-rc2 + kselftest merge configs.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> logs:
> =3D=3D=3D=3D=3D
> INFO: Performing perf record test...
>
> Parse sched tracepoints fields: Ok
>  16: syscalls:sys_enter_openat event fields     :
> --- start ---
> test child forked, pid 255
> <4>[  152.221288] int3: 0000 [#1] PREEMPT SMP PTI
> <4>[  152.221564] CPU: 0 PID: 255 Comm: perf Not tainted 6.3.4-rc2 #1
> <4>[  152.221607] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.14.0-2 04/01/2014
> <4>[  152.221733] RIP: 0010:__schedule+0x29e/0xaa0
> <4>[  152.222066] Code: 00 48 29 c1 49 01 8e 48 04 00 00 48 85 db 74
> 0f 48 01 8b 90 0c 00 00 48 83 83 88 0c 00 00 01 0f 1f 44 00 00 0f 1f
> 44 00 00 e9 <7a> 01 00 00 49 0f ba ac 24 18 0a 00 00 00 49 83 bc 24 08
> 0a 00 00
> <4>[  152.222122] RSP: 0018:ffff94aec0677bc0 EFLAGS: 00000046
> <4>[  152.222170] RAX: ffffffffa2e10900 RBX: ffff8b517bc2b700 RCX:
> 0000000000000004
> <4>[  152.222184] RDX: 00000023711138c0 RSI: 0000000000000000 RDI:
> ffff8b517bc2b700
> <4>[  152.222197] RBP: ffff94aec0677c28 R08: ffff8b5102aa6a00 R09:
> 000000000000004e
> <4>[  152.222211] R10: 0000000000000001 R11: 0000000000000001 R12:
> ffff8b51009e3c00
> <4>[  152.222223] R13: ffffffffa2cf3f48 R14: ffffffffa2e10900 R15:
> ffff8b51009e4248
> <4>[  152.222275] FS:  00007f6b8ea81800(0000)
> GS:ffff8b517bc00000(0000) knlGS:0000000000000000
> <4>[  152.222294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  152.222308] CR2: 00007f6b8dd204e0 CR3: 0000000105a1c000 CR4:
> 00000000000006f0
> <4>[  152.222409] Call Trace:
> <4>[  152.222500]  <TASK>
> <4>[  152.222605]  schedule+0x6a/0xf0
> <4>[  152.222664]  schedule_timeout+0x14f/0x160
> <4>[  152.222680]  wait_for_completion+0x8c/0x140
> <4>[  152.222696]  __wait_rcu_gp+0x13e/0x140
> <4>[  152.222712]  synchronize_rcu+0x12f/0x140
> <4>[  152.222731]  ? __pfx_call_rcu_hurry+0x10/0x10
> <4>[  152.222748]  ? __pfx_wakeme_after_rcu+0x10/0x10
> <4>[  152.222766]  perf_event_alloc+0xd53/0xdc0
> <4>[  152.222783]  ? preempt_count_sub+0x50/0x80
> <4>[  152.222795]  ? _raw_spin_unlock+0x1a/0x40
> <4>[  152.222810]  __do_sys_perf_event_open+0x1df/0xd10
> <4>[  152.222838]  __x64_sys_perf_event_open+0x26/0x30
> <4>[  152.222849]  do_syscall_64+0x3e/0x90
> <4>[  152.222863]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> <4>[  152.222920] RIP: 0033:0x7f6b8dd204f9
> <4>[  152.223150] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00
> 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c
> 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 08 0d 00 f7 d8 64
> 89 01 48
> <4>[  152.223158] RSP: 002b:00007ffd51880f68 EFLAGS: 00000202
> ORIG_RAX: 000000000000012a
> <4>[  152.223175] RAX: ffffffffffffffda RBX: 00000000ffffffff RCX:
> 00007f6b8dd204f9
> <4>[  152.223181] RDX: 0000000000000000 RSI: 00000000000000ff RDI:
> 000055e658912b50
> <4>[  152.223187] RBP: 00007ffd51881030 R08: 0000000000000008 R09:
> 00007ffd51881090
> <4>[  152.223192] R10: 00000000ffffffff R11: 0000000000000202 R12:
> 0000000000000008
> <4>[  152.223198] R13: 0000000000000000 R14: 0000000000000000 R15:
> 000055e658912b40
> <4>[  152.223246]  </TASK>
> <4>[  152.223308] Modules linked in:
> <4>[  152.247884] ---[ end trace 0000000000000000 ]---
> <4>[  152.248004] RIP: 0010:__schedule+0x29e/0xaa0
> <4>[  152.248051] Code: 00 48 29 c1 49 01 8e 48 04 00 00 48 85 db 74
> 0f 48 01 8b 90 0c 00 00 48 83 83 88 0c 00 00 01 0f 1f 44 00 00 0f 1f
> 44 00 00 e9 <7a> 01 00 00 49 0f ba ac 24 18 0a 00 00 00 49 83 bc 24 08
> 0a 00 00
> <4>[  152.248066] RSP: 0018:ffff94aec0677bc0 EFLAGS: 00000046
> <4>[  152.248089] RAX: ffffffffa2e10900 RBX: ffff8b517bc2b700 RCX:
> 0000000000000004
> <4>[  152.248099] RDX: 00000023711138c0 RSI: 0000000000000000 RDI:
> ffff8b517bc2b700
> <4>[  152.248269] RBP: ffff94aec0677c28 R08: ffff8b5102aa6a00 R09:
> 000000000000004e
> <4>[  152.248282] R10: 0000000000000001 R11: 0000000000000001 R12:
> ffff8b51009e3c00
> <4>[  152.248294] R13: ffffffffa2cf3f48 R14: ffffffffa2e10900 R15:
> ffff8b51009e4248
> <4>[  152.248304] FS:  00007f6b8ea81800(0000)
> GS:ffff8b517bc00000(0000) knlGS:0000000000000000
> <4>[  152.248316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  152.248479] CR2: 00007f6b8dd204e0 CR3: 0000000105a1c000 CR4:
> 00000000000006f0
> <0>[  152.248663] Kernel panic - not syncing: Fatal exception in interrup=
t
> <4>[  152.248980] int3: 0000 [#2] PREEMPT SMP PTI
> <4>[  152.249101] CPU: 1 PID: 32 Comm: kworker/u4:3 Tainted: G      D
>           6.3.4-rc2 #1
> <4>[  152.249124] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.14.0-2 04/01/2014
> <4>[  152.249292] Workqueue:  0x0 (events_unbound)
> <4>[  152.249420] RIP: 0010:__schedule+0x29e/0xaa0
> <4>[  152.249471] Code: 00 48 29 c1 49 01 8e 48 04 00 00 48 85 db 74
> 0f 48 01 8b 90 0c 00 00 48 83 83 88 0c 00 00 01 0f 1f 44 00 00 0f 1f
> 44 00 00 e9 <7a> 01 00 00 49 0f ba ac 24 18 0a 00 00 00 49 83 bc 24 08
> 0a 00 00
> <4>[  152.249486] RSP: 0018:ffff94aec0117e38 EFLAGS: 00000046
> <4>[  152.249502] RAX: ffff8b51002d8000 RBX: ffff8b517bd2b700 RCX:
> 0000000000000004
> <4>[  152.249512] RDX: 0000002372bd853f RSI: ffffffffffa7caff RDI:
> ffff8b517bd2b700
> <4>[  152.249522] RBP: ffff94aec0117ea0 R08: 0000000000000400 R09:
> 0000000000000361
> <4>[  152.249532] R10: 0000000000000001 R11: 0000000000000000 R12:
> ffff8b51008a0f00
> <4>[  152.249542] R13: ffffffffa2cf3f48 R14: ffff8b51002d8000 R15:
> ffff8b51008a1548
> <4>[  152.249552] FS:  0000000000000000(0000)
> GS:ffff8b517bd00000(0000) knlGS:0000000000000000
> <4>[  152.249565] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  152.249576] CR2: 00007ffd518816b8 CR3: 000000010591e000 CR4:
> 00000000000006e0
> <4>[  152.249588] Call Trace:
> <4>[  152.249603]  <TASK>
> <4>[  152.249636]  schedule+0x6a/0xf0
> <4>[  152.249658]  worker_thread+0xc0/0x3e0
> <4>[  152.249684]  ? __pfx_worker_thread+0x10/0x10
> <4>[  152.249704]  kthread+0xfc/0x120
> <4>[  152.249721]  ? __pfx_kthread+0x10/0x10

I wonder if this is a deadlock related to runqueue lock since another
CPU call stack are similarly in schedule.

I tried to run gdb on your vmlinux but it does not have symbols, would
it be possible for you to provide a copy of vmlinux with symbols?

Were you able to narrow down the commit/release using git bisect to
see when it started happening?

Thank you,

 - Joel
