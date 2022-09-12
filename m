Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239695B5A21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiILM35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiILM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:29:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626126387;
        Mon, 12 Sep 2022 05:29:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bz13so15114683wrb.2;
        Mon, 12 Sep 2022 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=RSfTpQ3Y7DB2DDe6JeRPULjD6aZEdVo0MbnE/xG7+Bw=;
        b=V3NlzGGIalJ64v6EU/t92f2P6/AlEfx9NW7BVuSbbS92bDzwamX87/wNOi1NTXD/hC
         G/3tHOiQD9U3sH7+1rrpHbkpAzckOt4mQzjJNNuP9otHvd881t+wMo2AeVvWBHmQ5hhy
         bLUFFKmI5Pls4NCpteSOYPbGx4TB4UYdHeDfYLICiqE5MvT5iYMpdvRP740yniUPVQfg
         6ZDEXsa0+9kuRcERk1zIFwim6AZZtYHsHTVdpgIvprMwTbNbqv8yXUJnrGjVnt/uI4Rl
         SlNyg2nPwy/czEcK9/H8zBT3w8+EaTRNsnGcjFSAAReBUmhasiQ7jqTXkwNAUHDG5BbE
         nFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=RSfTpQ3Y7DB2DDe6JeRPULjD6aZEdVo0MbnE/xG7+Bw=;
        b=twIZO9Y+mvBx8/dfn49pv37L7GrXbXGxd8HrfBulV8enm5J1kYzjU/o4N1rPJhGXTq
         QyAMEG1IbfgfnQNcjcEw8Z1ymG0Bx1LlA5nePaAK4Z3ggQl2g6+afbJSCnyWPwFIMpDX
         vTVDUIcAUlhqCSIf677GAr+H6Jbhp32CiSfUIDKjJhUqUzcVEJn/8dnwGV/jzQrKophM
         +vu4RlgA5/6lPCoauTpH1KoOZXQ/cTlEwb80glO9TdHF+r7pykwvxgnM2q2bKUWvIpJo
         P9gsafeyqHA9nqPyuHxeZ7w7sEdUNb5IR9fRZBdC3DMeHNceBlKvsTQr2bgP/Daabodw
         ckNQ==
X-Gm-Message-State: ACgBeo3VhYCpZeFqU/ayqUVYqvFu/+3Uc6v2KIo0y11JWDYywb5wKxbz
        LTCuwxr8SXe8jlEvC7GVg4WwLwaijyieg4O/jnTEVWL+zMAmXA==
X-Google-Smtp-Source: AA6agR4pAMs827q3kNSpw+psirKD89eypSf75y5sZUJHOJXpo7JXodLFuUCZv9XD7Q3iMFa24SHW7qREfdCk9dscPwc=
X-Received: by 2002:a05:6000:110d:b0:228:db67:75c4 with SMTP id
 z13-20020a056000110d00b00228db6775c4mr15283516wrw.217.1662985787555; Mon, 12
 Sep 2022 05:29:47 -0700 (PDT)
MIME-Version: 1.0
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
Date:   Mon, 12 Sep 2022 15:29:21 +0300
Message-ID: <CAKErNvoqga1WcmoR3-0875esY6TVWFQDandbVZncSiuGPBQXLA@mail.gmail.com>
Subject: KASAN use-after-free in l2cap_rx_state_recv
To:     Mat Martineau <mathewm@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I got a KASAN use-after-free report while receiving a file over
Bluetooth (Intel AX201, but it doesn't look relevant to the driver).
Kernel version is 5.19.8. Could you take a look?

Decoded stacktrace follows:

[   +0,000018] BUG: KASAN: use-after-free in l2cap_rx_state_recv
(net/bluetooth/l2cap_core.c:6906) bluetooth
[  +0,000105] Read of size 1 at addr ffff88812025f2f0 by task
kworker/u17:3/43169

[  +0,000018] Hardware name: HP HP Elite Dragonfly G2 Notebook
PC/8716, BIOS T90 Ver. 01.09.01 05/05/2022
[  +0,000011] Workqueue: hci0 hci_rx_work [bluetooth]
[  +0,000113] Call Trace:
[  +0,000006]  <TASK>
[   +0,000007] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
[   +0,000015] print_report.cold (mm/kasan/report.c:314 mm/kasan/report.c:429)
[   +0,000017] ? l2cap_rx_state_recv (net/bluetooth/l2cap_core.c:6906) bluetooth
[   +0,000133] kasan_report (mm/kasan/report.c:162 mm/kasan/report.c:493)
[   +0,000020] ? l2cap_rx_state_recv (net/bluetooth/l2cap_core.c:6906) bluetooth
[   +0,000117] l2cap_rx_state_recv (net/bluetooth/l2cap_core.c:6906) bluetooth
[   +0,000131] l2cap_rx (net/bluetooth/l2cap_core.c:7236
net/bluetooth/l2cap_core.c:7271) bluetooth
[   +0,000124] ? sk_filter_trim_cap (net/core/filter.c:123)
[   +0,000013] ? l2cap_chan_hold_unless_zero
(./arch/x86/include/asm/atomic.h:202
./include/linux/atomic/atomic-instrumented.h:560
./include/linux/refcount.h:157 ./include/linux/refcount.h:227
./include/linux/refcount.h:245 ./include/linux/kref.h:111
net/bluetooth/l2cap_core.c:517) bluetooth
[   +0,000094] ? l2cap_rx_state_recv (net/bluetooth/l2cap_core.c:7252) bluetooth
[   +0,000100] l2cap_recv_frame (net/bluetooth/l2cap_core.c:7405
net/bluetooth/l2cap_core.c:7620 net/bluetooth/l2cap_core.c:7723)
bluetooth
[   +0,000098] ? lock_release (./include/trace/events/lock.h:69
kernel/locking/lockdep.c:5677)
[   +0,000012] ? hci_rx_work (net/bluetooth/hci_core.c:3637
net/bluetooth/hci_core.c:3832) bluetooth
[   +0,000093] ? reacquire_held_locks (kernel/locking/lockdep.c:5674)
[   +0,000010] ? trace_contention_end
(./include/trace/events/lock.h:122 ./include/trace/events/lock.h:122)
[   +0,000011] ? l2cap_config_rsp.isra.0
(net/bluetooth/l2cap_core.c:7674) bluetooth
[   +0,000094] ? hci_rx_work (./include/net/bluetooth/hci_core.h:1024
net/bluetooth/hci_core.c:3634 net/bluetooth/hci_core.c:3832) bluetooth
[   +0,000092] ? lock_acquire (./include/trace/events/lock.h:24
kernel/locking/lockdep.c:5637)
[   +0,000012] ? __mutex_unlock_slowpath
(./arch/x86/include/asm/atomic64_64.h:190
./include/linux/atomic/atomic-long.h:449
./include/linux/atomic/atomic-instrumented.h:1790
kernel/locking/mutex.c:924)
[   +0,000013] ? rcu_read_lock_sched_held (kernel/rcu/update.c:104
kernel/rcu/update.c:123)
[   +0,000013] ? memcpy (mm/kasan/shadow.c:65 (discriminator 1))
[   +0,000010] ? l2cap_recv_frag (net/bluetooth/l2cap_core.c:8340) bluetooth
[   +0,000096] l2cap_recv_acldata (net/bluetooth/l2cap_core.c:8486) bluetooth
[   +0,000096] hci_rx_work (net/bluetooth/hci_core.c:3642
net/bluetooth/hci_core.c:3832) bluetooth
[   +0,000099] process_one_work (kernel/workqueue.c:2289)
[   +0,000016] ? lock_downgrade (kernel/locking/lockdep.c:5634)
[   +0,000011] ? pwq_dec_nr_in_flight (kernel/workqueue.c:2184)
[   +0,000014] ? rwlock_bug.part.0 (kernel/locking/spinlock_debug.c:113)
[   +0,000016] worker_thread (./include/linux/list.h:292
kernel/workqueue.c:2437)
[   +0,000016] ? __kthread_parkme (./arch/x86/include/asm/bitops.h:207
(discriminator 4)
./include/asm-generic/bitops/instrumented-non-atomic.h:135
(discriminator 4) kernel/kthread.c:270 (discriminator 4))
[   +0,000011] ? process_one_work (kernel/workqueue.c:2379)
[   +0,000011] kthread (kernel/kthread.c:376)
[   +0,000009] ? kthread_complete_and_exit (kernel/kthread.c:331)
[   +0,000012] ret_from_fork (arch/x86/entry/entry_64.S:306)
[  +0,000020]  </TASK>

[  +0,000009] Allocated by task 43169:
[   +0,000007] kasan_save_stack (mm/kasan/common.c:39)
[   +0,000011] __kasan_slab_alloc (mm/kasan/common.c:45
mm/kasan/common.c:436 mm/kasan/common.c:469)
[   +0,000007] kmem_cache_alloc_node (mm/slab.h:750 mm/slub.c:3243
mm/slub.c:3293)
[   +0,000009] __alloc_skb (net/core/skbuff.c:414)
[   +0,000008] l2cap_recv_frag
(./include/net/bluetooth/bluetooth.h:425
net/bluetooth/l2cap_core.c:8329) bluetooth
[   +0,000090] l2cap_recv_acldata (net/bluetooth/l2cap_core.c:8442) bluetooth
[   +0,000090] hci_rx_work (net/bluetooth/hci_core.c:3642
net/bluetooth/hci_core.c:3832) bluetooth
[   +0,000113] process_one_work (kernel/workqueue.c:2289)
[   +0,000009] worker_thread (./include/linux/list.h:292
kernel/workqueue.c:2437)
[   +0,000009] kthread (kernel/kthread.c:376)
[   +0,000008] ret_from_fork (arch/x86/entry/entry_64.S:306)

[  +0,000013] Freed by task 27920:
[   +0,000005] kasan_save_stack (mm/kasan/common.c:39)
[   +0,000009] kasan_set_track (mm/kasan/common.c:45)
[   +0,000009] kasan_set_free_info (mm/kasan/generic.c:372)
[   +0,000008] ____kasan_slab_free (mm/kasan/common.c:368 mm/kasan/common.c:328)
[   +0,000009] slab_free_freelist_hook (mm/slub.c:1780)
[   +0,000009] kmem_cache_free (mm/slub.c:3536 mm/slub.c:3553)
[   +0,000009] skb_free_datagram (./include/net/sock.h:1578
./include/net/sock.h:1639 net/core/datagram.c:323)
[   +0,000010] bt_sock_recvmsg (net/bluetooth/af_bluetooth.c:295) bluetooth
[   +0,000090] l2cap_sock_recvmsg (net/bluetooth/l2cap_sock.c:1212) bluetooth
[   +0,000090] sock_read_iter (net/socket.c:1087)
[   +0,000008] new_sync_read (./include/linux/fs.h:2052 fs/read_write.c:401)
[   +0,000010] vfs_read (fs/read_write.c:482)
[   +0,000008] ksys_read (fs/read_write.c:620)
[   +0,000008] do_syscall_64 (arch/x86/entry/common.c:50
arch/x86/entry/common.c:80)
[   +0,000008] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

[  +0,000013] The buggy address belongs to the object at ffff88812025f2c0
which belongs to the cache skbuff_head_cache of size 232
[  +0,000009] The buggy address is located 48 bytes inside of
232-byte region [ffff88812025f2c0, ffff88812025f3a8)

[  +0,000013] The buggy address belongs to the physical page:
[  +0,000006] page:0000000009bb9048 refcount:1 mapcount:0
mapping:0000000000000000 index:0xffff88812025f180 pfn:0x12025e
[  +0,000012] head:0000000009bb9048 order:1 compound_mapcount:0
compound_pincount:0
[  +0,000008] memcg:ffff888154217801
[  +0,000005] flags:
0x2ffff0000010200(slab|head|node=0|zone=2|lastcpupid=0xffff)
[  +0,000014] raw: 02ffff0000010200 ffffea000565a680 dead000000000002
ffff888109b6e000
[  +0,000009] raw: ffff88812025f180 0000000080190018 00000001ffffffff
ffff888154217801
[  +0,000005] page dumped because: kasan: bad access detected

[  +0,000009] Memory state around the buggy address:
[  +0,000006]  ffff88812025f180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0,000007]  ffff88812025f200: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
[  +0,000006] >ffff88812025f280: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
[  +0,000006]                                                              ^
[  +0,000006]  ffff88812025f300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0,000006]  ffff88812025f380: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
[  +0,000006] ==================================================================
