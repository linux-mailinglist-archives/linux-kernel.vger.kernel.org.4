Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CFC6E5835
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDREuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDREuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:50:21 -0400
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD771BDC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1681793421; x=1713329421;
  h=mime-version:from:date:message-id:subject:to;
  bh=exqRgkdkSA1PfDIxy/IwknTenS8IWnfSSg0a09RURMo=;
  b=tRzkwb6bb42MUcjP986yZRGFHkipQjSLmRkiI6p3SSdOVwmirk/Qehiv
   iqyy49jJvwKIW2N7h0Cm/qkyy+Dmc+Pg9ZzYKbLE3KH9TRH7QbSkeztp+
   +aY4emuK3Uk5Ig/ud69lDgE2Dukdbn8QurU8I+9yHPA8oA5sJFP5HvUp+
   M3qPxY1XDa0p1Ks7xorujfRYLAgxBCqeF+4oyFJXacVcZkU6BYNGhC1Lp
   EPHPbObJdVzPjDNeJBEZ6CyhKZOQ2N6pUGuqcZtYNXRgoekL6K/YkyDNS
   UZkR/VdMYGgkZ2K4LtyptHbmvfcQh8JXHLFih6JJHo46lsJyEDO0TPdtZ
   w==;
Received: from mail-wr1-f69.google.com ([209.85.221.69])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2023 21:50:20 -0700
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2fbb99cb244so376194f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1681793418; x=1684385418;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HpyqnahZ0dBtoFysZJW/vJkY2sBhJEsRqq8ZhFGwOjI=;
        b=QIBh8AZCfAo6mr+kt8fYn9MIl6Sn0AQNnIT9l7RcKAk+zUcS0eh2a2AjOnvb7/aUXa
         tVdkMqLIvsscwsah+Ste7AH5HoY5wOx4Vf+e5NMPiQ3/Tf6Runi1iKfaxbi9S/uKO8np
         t3SGO4fxxsu08hDkrHjxiVzVBxv5j0nruZj6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681793418; x=1684385418;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpyqnahZ0dBtoFysZJW/vJkY2sBhJEsRqq8ZhFGwOjI=;
        b=ftwvENDXvk49Vy3WUWzshMUmUQl3ygGYW42i7uDVeaVockFykaP42ULGQ/cZWaAwC+
         TDe7SUuq/hu1Zxc7G/p6dIoUXzoj4gZZkzWJ5l0F/aMgNQLme61YqNrZ87Z3A4EP9pgB
         gLe5KhdtJFmWG12t8QU8UuEVxRGd/58JUTatdcoXOPRAHnExcAuMUY7rlcfvG/OHHllS
         vcY2yhhmszWlUqd00bKaYi6uffckxAtm9vGGsyL+Beh1YrzvPkp4JxQcYXs8ukR0pqLH
         QEfmNBg4+fmLtg2UO7nfql0zWsZ8FkmLlFRaQt/v/HWTxSr3C6nk590HDQTagFIeSLlO
         2pNA==
X-Gm-Message-State: AAQBX9eBvp1x1Vf8dO5tJLMd+rQGRaRg8luT9i3It5eoc3rtqW9t1Olv
        NHa8Dxim+x8QVPt5ZTX2HETktHW07/lRFUY+Bui0QsFRS0YAWobDnYS6Ut9NJHLYyT1t1nYKT39
        VXi9juXOqMff25AFr/GYJxvSlRt/eg0kSy1qs4J8V3A==
X-Received: by 2002:a5d:60c3:0:b0:2e3:99d3:7a5 with SMTP id x3-20020a5d60c3000000b002e399d307a5mr658023wrt.24.1681793418097;
        Mon, 17 Apr 2023 21:50:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350bt+E4+5aYFJhzoP/eIld+GGePEmOqnh3yrE8Vw7ps59ymnbJkqulV2j2WnJG8R5W9ILDuMhbIodC9lbkhgOgE=
X-Received: by 2002:a5d:60c3:0:b0:2e3:99d3:7a5 with SMTP id
 x3-20020a5d60c3000000b002e399d307a5mr658015wrt.24.1681793417813; Mon, 17 Apr
 2023 21:50:17 -0700 (PDT)
MIME-Version: 1.0
From:   Yu Hao <yhao016@ucr.edu>
Date:   Mon, 17 Apr 2023 21:50:07 -0700
Message-ID: <CA+UBctCu7fXn4q41O_3=id1+OdyQ85tZY1x+TkT-6OVBL6KAUw@mail.gmail.com>
Subject: BUG: WARNING in dvb_frontend_get_event
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We found the following issue using syzkaller on Linux v6.2.0.

In the function `dvb_frontend_get_event`, function
`wait_event_interruptible` is called
and the condition is `dvb_frontend_test_event(fepriv, events)`.
In the function `dvb_frontend_test_event`, function
`down(&fepriv->sem);` is called.
However, function `wait_event_interruptible` would put the process to sleep.
And function `down(&fepriv->sem);` may block the process.
So there is the issue with "do not call blocking ops when !TASK_RUNNING".

The full report including the Syzkaller reproducer & C reproducer:
https://gist.github.com/ZHYfeng/4c5f8be6adc63b73dba68230d15ece2c

The brief report is below:

Syzkaller hit 'WARNING in dvb_frontend_get_event' bug.

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=1 set at
[<ffffffff8161186d>] prepare_to_wait_event+0x6d/0x690
kernel/sched/wait.c:333
WARNING: CPU: 0 PID: 8017 at kernel/sched/core.c:9968
__might_sleep+0x10a/0x160 kernel/sched/core.c:9968
Modules linked in:
CPU: 0 PID: 8017 Comm: syz-executor303 Not tainted 6.2.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__might_sleep+0x10a/0x160 kernel/sched/core.c:9968
Code: 9d 03 00 48 8d bb d8 16 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00
75 34 48 8b 93 d8 16 00 00 48 c7 c7 e0 68 4c 8a e8 38 55 72 08 <0f> 0b
e9 75 ff ff ff e8 1a 7b 7f 00 e9 26 ff ff ff 89 34 24 e8 1d
RSP: 0018:ffffc9000e537ac8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888018bdba80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff888018bdba80 RDI: fffff52001ca6f4b
RBP: ffffffff8a4cd200 R08: 0000000000000000 R09: ffffed1005944f32
R10: ffff88802ca2798b R11: ffffed1005944f31 R12: 000000000000003a
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888044057260
FS:  0000555555995880(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd34db66000 CR3: 000000001f479000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 down+0x1e/0xa0 kernel/locking/semaphore.c:58
 dvb_frontend_test_event drivers/media/dvb-core/dvb_frontend.c:277 [inline]
 dvb_frontend_get_event.isra.0+0x528/0x670
drivers/media/dvb-core/dvb_frontend.c:301
 dvb_frontend_handle_ioctl+0x1953/0x2ea0
drivers/media/dvb-core/dvb_frontend.c:2726
 dvb_frontend_do_ioctl+0x1c5/0x2f0 drivers/media/dvb-core/dvb_frontend.c:2097
 dvb_usercopy+0xbe/0x280 drivers/media/dvb-core/dvbdev.c:961
 dvb_frontend_ioctl+0x5a/0x80 drivers/media/dvb-core/dvb_frontend.c:2111
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x198/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f569e9f4a7d
Code: 28 c3 e8 36 29 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff77694948 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f569e9f4a7d
RDX: 0000000020000000 RSI: 0000000080286f4e RDI: 0000000000000003
RBP: 00007f569e9ae440 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f569e9ae4e0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
