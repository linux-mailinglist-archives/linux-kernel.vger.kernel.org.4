Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD67670F1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240534AbjEXJCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbjEXJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:02:38 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A594C132
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:02:36 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-45701a8a1b3so259843e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684918955; x=1687510955;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IoXIHN+JHAtPREdCxVNh60cv2ytT0eTrapPfp0USbr4=;
        b=qcqxbpozRm0YrX1b1eJxarTedM3Dnq8vzbpy9RbNvbtQoCihzSbk7g4ajlUP4ksIT0
         5wZShQwz1/Xdrny7gLi99EuiEpVTZUneIzU2plEbLvDXfOXzL5X9vZ55Sx+CfFV8IdkH
         GN+zkxD5pewpDbg+LzosdPgK/014XBxCyFNuOylE2M6nfFnHJ7StqOZF3v0kD+GY6FYG
         e8uc/y5TFxca5myghprMVJ66VdrHU7JfiJjHTxFEAyvft9BAen+WRfv3UtzUaN6L3BvF
         a29fikMCxqxbNluJEcAA0ere/Z1SmvrZ/0O7f2N8E7mV/IewbFeO7qMDGak2o5QL1UTN
         0EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684918955; x=1687510955;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IoXIHN+JHAtPREdCxVNh60cv2ytT0eTrapPfp0USbr4=;
        b=dyT8ViuqAK+AofLNmm7GVxjSszxHXnQV2hVOxvtqRgEXZdbugpxhKr9yKho0AcYmJJ
         Pd9WcNLvz0c98blJrIBsDkrbzEnJx2nMySaKSMZ2h0mmzzMQVexEjQNfhL/iMAyD2cQz
         9JjxquWfEis2yrGyLTT6mtUIhpq42S4XvSB8z/HRHu2NRpNz1tmq2QyFHDVovtCaByYQ
         CEc44MnT0O7vVHB5GA6Nf3ZbbVzQCPBDyJbhggzBYDMQ7RIrbyM+m+XPTzC+dchgLtMq
         uLbqqbaw4F9j79shwN/CWu3KFamo28WEguRT+U4mL+4Krl6f3DDIfX9vC9nr7MReuAYf
         n+Kg==
X-Gm-Message-State: AC+VfDwF2T8MRePIX2vCGM63JwDp+Id53z5/aijT/8NgURgHWaqf5zTF
        3tofwWz8Sse8mbb1025myNBeVPjFzGnMcUHj/8H6vkJH7u6Lz3dwOnmtnw==
X-Google-Smtp-Source: ACHHUZ4YxR4bNRCCAqY1snog2P8OIW025ESXTMcHLjDMXPhMhC8DfhdsNNOn+oX9uoHpz33lpTieLfl0whUtHXIb8fM=
X-Received: by 2002:a1f:eb42:0:b0:453:8a02:8e7 with SMTP id
 j63-20020a1feb42000000b004538a0208e7mr5231862vkh.6.1684918954432; Wed, 24 May
 2023 02:02:34 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 24 May 2023 14:32:23 +0530
Message-ID: <CA+G9fYtCCTxT78c0T+5JFw+sN01ZnX_kvBBgDLoVLfPARc9ZuA@mail.gmail.com>
Subject: Perf: RIP: 0010:__schedule on qemu-x86_64
To:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, rcu <rcu@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel crash noticed while running perf testing on qemu-x86_64
with stable-rc 6.3.4-rc2 + kselftest merge configs.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

logs:
=====
INFO: Performing perf record test...

Parse sched tracepoints fields: Ok
 16: syscalls:sys_enter_openat event fields     :
--- start ---
test child forked, pid 255
<4>[  152.221288] int3: 0000 [#1] PREEMPT SMP PTI
<4>[  152.221564] CPU: 0 PID: 255 Comm: perf Not tainted 6.3.4-rc2 #1
<4>[  152.221607] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[  152.221733] RIP: 0010:__schedule+0x29e/0xaa0
<4>[  152.222066] Code: 00 48 29 c1 49 01 8e 48 04 00 00 48 85 db 74
0f 48 01 8b 90 0c 00 00 48 83 83 88 0c 00 00 01 0f 1f 44 00 00 0f 1f
44 00 00 e9 <7a> 01 00 00 49 0f ba ac 24 18 0a 00 00 00 49 83 bc 24 08
0a 00 00
<4>[  152.222122] RSP: 0018:ffff94aec0677bc0 EFLAGS: 00000046
<4>[  152.222170] RAX: ffffffffa2e10900 RBX: ffff8b517bc2b700 RCX:
0000000000000004
<4>[  152.222184] RDX: 00000023711138c0 RSI: 0000000000000000 RDI:
ffff8b517bc2b700
<4>[  152.222197] RBP: ffff94aec0677c28 R08: ffff8b5102aa6a00 R09:
000000000000004e
<4>[  152.222211] R10: 0000000000000001 R11: 0000000000000001 R12:
ffff8b51009e3c00
<4>[  152.222223] R13: ffffffffa2cf3f48 R14: ffffffffa2e10900 R15:
ffff8b51009e4248
<4>[  152.222275] FS:  00007f6b8ea81800(0000)
GS:ffff8b517bc00000(0000) knlGS:0000000000000000
<4>[  152.222294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  152.222308] CR2: 00007f6b8dd204e0 CR3: 0000000105a1c000 CR4:
00000000000006f0
<4>[  152.222409] Call Trace:
<4>[  152.222500]  <TASK>
<4>[  152.222605]  schedule+0x6a/0xf0
<4>[  152.222664]  schedule_timeout+0x14f/0x160
<4>[  152.222680]  wait_for_completion+0x8c/0x140
<4>[  152.222696]  __wait_rcu_gp+0x13e/0x140
<4>[  152.222712]  synchronize_rcu+0x12f/0x140
<4>[  152.222731]  ? __pfx_call_rcu_hurry+0x10/0x10
<4>[  152.222748]  ? __pfx_wakeme_after_rcu+0x10/0x10
<4>[  152.222766]  perf_event_alloc+0xd53/0xdc0
<4>[  152.222783]  ? preempt_count_sub+0x50/0x80
<4>[  152.222795]  ? _raw_spin_unlock+0x1a/0x40
<4>[  152.222810]  __do_sys_perf_event_open+0x1df/0xd10
<4>[  152.222838]  __x64_sys_perf_event_open+0x26/0x30
<4>[  152.222849]  do_syscall_64+0x3e/0x90
<4>[  152.222863]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
<4>[  152.222920] RIP: 0033:0x7f6b8dd204f9
<4>[  152.223150] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00
00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c
24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 08 0d 00 f7 d8 64
89 01 48
<4>[  152.223158] RSP: 002b:00007ffd51880f68 EFLAGS: 00000202
ORIG_RAX: 000000000000012a
<4>[  152.223175] RAX: ffffffffffffffda RBX: 00000000ffffffff RCX:
00007f6b8dd204f9
<4>[  152.223181] RDX: 0000000000000000 RSI: 00000000000000ff RDI:
000055e658912b50
<4>[  152.223187] RBP: 00007ffd51881030 R08: 0000000000000008 R09:
00007ffd51881090
<4>[  152.223192] R10: 00000000ffffffff R11: 0000000000000202 R12:
0000000000000008
<4>[  152.223198] R13: 0000000000000000 R14: 0000000000000000 R15:
000055e658912b40
<4>[  152.223246]  </TASK>
<4>[  152.223308] Modules linked in:
<4>[  152.247884] ---[ end trace 0000000000000000 ]---
<4>[  152.248004] RIP: 0010:__schedule+0x29e/0xaa0
<4>[  152.248051] Code: 00 48 29 c1 49 01 8e 48 04 00 00 48 85 db 74
0f 48 01 8b 90 0c 00 00 48 83 83 88 0c 00 00 01 0f 1f 44 00 00 0f 1f
44 00 00 e9 <7a> 01 00 00 49 0f ba ac 24 18 0a 00 00 00 49 83 bc 24 08
0a 00 00
<4>[  152.248066] RSP: 0018:ffff94aec0677bc0 EFLAGS: 00000046
<4>[  152.248089] RAX: ffffffffa2e10900 RBX: ffff8b517bc2b700 RCX:
0000000000000004
<4>[  152.248099] RDX: 00000023711138c0 RSI: 0000000000000000 RDI:
ffff8b517bc2b700
<4>[  152.248269] RBP: ffff94aec0677c28 R08: ffff8b5102aa6a00 R09:
000000000000004e
<4>[  152.248282] R10: 0000000000000001 R11: 0000000000000001 R12:
ffff8b51009e3c00
<4>[  152.248294] R13: ffffffffa2cf3f48 R14: ffffffffa2e10900 R15:
ffff8b51009e4248
<4>[  152.248304] FS:  00007f6b8ea81800(0000)
GS:ffff8b517bc00000(0000) knlGS:0000000000000000
<4>[  152.248316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  152.248479] CR2: 00007f6b8dd204e0 CR3: 0000000105a1c000 CR4:
00000000000006f0
<0>[  152.248663] Kernel panic - not syncing: Fatal exception in interrupt
<4>[  152.248980] int3: 0000 [#2] PREEMPT SMP PTI
<4>[  152.249101] CPU: 1 PID: 32 Comm: kworker/u4:3 Tainted: G      D
          6.3.4-rc2 #1
<4>[  152.249124] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[  152.249292] Workqueue:  0x0 (events_unbound)
<4>[  152.249420] RIP: 0010:__schedule+0x29e/0xaa0
<4>[  152.249471] Code: 00 48 29 c1 49 01 8e 48 04 00 00 48 85 db 74
0f 48 01 8b 90 0c 00 00 48 83 83 88 0c 00 00 01 0f 1f 44 00 00 0f 1f
44 00 00 e9 <7a> 01 00 00 49 0f ba ac 24 18 0a 00 00 00 49 83 bc 24 08
0a 00 00
<4>[  152.249486] RSP: 0018:ffff94aec0117e38 EFLAGS: 00000046
<4>[  152.249502] RAX: ffff8b51002d8000 RBX: ffff8b517bd2b700 RCX:
0000000000000004
<4>[  152.249512] RDX: 0000002372bd853f RSI: ffffffffffa7caff RDI:
ffff8b517bd2b700
<4>[  152.249522] RBP: ffff94aec0117ea0 R08: 0000000000000400 R09:
0000000000000361
<4>[  152.249532] R10: 0000000000000001 R11: 0000000000000000 R12:
ffff8b51008a0f00
<4>[  152.249542] R13: ffffffffa2cf3f48 R14: ffff8b51002d8000 R15:
ffff8b51008a1548
<4>[  152.249552] FS:  0000000000000000(0000)
GS:ffff8b517bd00000(0000) knlGS:0000000000000000
<4>[  152.249565] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  152.249576] CR2: 00007ffd518816b8 CR3: 000000010591e000 CR4:
00000000000006e0
<4>[  152.249588] Call Trace:
<4>[  152.249603]  <TASK>
<4>[  152.249636]  schedule+0x6a/0xf0
<4>[  152.249658]  worker_thread+0xc0/0x3e0
<4>[  152.249684]  ? __pfx_worker_thread+0x10/0x10
<4>[  152.249704]  kthread+0xfc/0x120
<4>[  152.249721]  ? __pfx_kthread+0x10/0x10
<4>[  152.249739]  ret_from_fork+0x2c/0x50
<4>[  152.249797]  </TASK>
<4>[  152.249805] Modules linked in:
<4>[  152.250386] ---[ end trace 0000000000000000 ]---
<4>[  152.250399] RIP: 0010:__schedule+0x29e/0xaa0
<4>[  152.250421] Code: 00 48 29 c1 49 01 8e 48 04 00 00 48 85 db 74
0f 48 01 8b 90 0c 00 00 48 83 83 88 0c 00 00 01 0f 1f 44 00 00 0f 1f
44 00 00 e9 <7a> 01 00 00 49 0f ba ac 24 18 0a 00 00 00 49 83 bc 24 08
0a 00 00
<4>[  152.250434] RSP: 0018:ffff94aec0677bc0 EFLAGS: 00000046
<4>[  152.250448] RAX: ffffffffa2e10900 RBX: ffff8b517bc2b700 RCX:
0000000000000004
<4>[  152.250458] RDX: 00000023711138c0 RSI: 0000000000000000 RDI:
ffff8b517bc2b700
<4>[  152.250467] RBP: ffff94aec0677c28 R08: ffff8b5102aa6a00 R09:
000000000000004e
<4>[  152.250477] R10: 0000000000000001 R11: 0000000000000001 R12:
ffff8b51009e3c00
<4>[  152.250486] R13: ffffffffa2cf3f48 R14: ffffffffa2e10900 R15:
ffff8b51009e4248
<4>[  152.250496] FS:  0000000000000000(0000)
GS:ffff8b517bd00000(0000) knlGS:0000000000000000
<4>[  152.250508] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  152.250519] CR2: 00007ffd518816b8 CR3: 000000010591e000 CR4:
00000000000006e0
<0>[  154.015533] Shutting down cpus with NMI
<0>[  154.016784] Kernel Offset: 0x20000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

log links,
=====
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.3-364-ga37c304c022d/testrun/17169996/suite/log-parser-test/test/check-kernel-panic/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.3-364-ga37c304c022d/testrun/17169996/suite/log-parser-test/tests/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2QCeuajqUTZlyC4kEyQGxT6YwYv/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2QCeuajqUTZlyC4kEyQGxT6YwYv/config


--
Linaro LKFT
https://lkft.linaro.org
