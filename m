Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ABF6D35BB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 08:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDBGIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 02:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDBGIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 02:08:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C4124AC6
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 23:08:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id q16so34040105lfe.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 23:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680415680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rAo+DRSwh7FJ+gZYY6HhvkzXtqzRaUEfkCmlmQccCKc=;
        b=KCEaOfIFyzCbQg6fAJlfqsKuFMYP1kgmQoigyb5UAb+PL4KNPvIK7SU9BklEH2+1nm
         Q28ZeVnNKhFvlt2sgRRMV1sJrSacPP/SZEAGDpRi9VqjZ8yv6uqTPQKWSqURqS2XIyRd
         TbagPia1lmbN/US89EDzogEWMLDX9P8SwFu77lg43V1eRqEeeP1+vyinTnSuAbShqtEK
         EI7W88RYsqibdPmgi70yRSPg8WckqfYuxLhFzJRYL9oOBqjoAe2rgppnfY8eQJz7NWkp
         gbCOZiSHVtv5ckBRuxfrrIHMatIlO5MvLYwoYIX4Pux0lrV/amBMlyocfCTgx826PBnD
         JeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680415680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAo+DRSwh7FJ+gZYY6HhvkzXtqzRaUEfkCmlmQccCKc=;
        b=DW+8wP5zZn3TeD54MrqxUqFtot/6tBAGYdjfEQsXlcXjTGl2I0TLwYyLY5V00ccnIf
         nVeiqVJA4//z9ZR/IfrRVVSX8K5sjXrzjRZ24aK3vIGI2dqkLry/6z3h45MQJecWk73z
         2Zheo1FHcOiHE92n63xzg9+GNRj+NdS1AOYCzBwYHzw0AkKgGeffGuGdtSzn3B8WAt1Q
         6uqS/UuyPbR7AnuVkeX25YGGoRPL9rchNO6m+heLIud1GOxcgTbjzf4hLHSamc3UKek2
         Mivmx65W1T+H9YXfPQ1JFq7n1W8O03JKKi+YMpljKvqH20m/nzZJxUzyCUiZTEZBIB4J
         xfRg==
X-Gm-Message-State: AAQBX9eNegUEB2oxuWKCVb4PuLqJ8LLIXIWNDplV+XHOpM3jCj7xVA5E
        cekjTTa+dLoYx3Sd6vUAycMWkpwwT2iL1Maa81T8lQ==
X-Google-Smtp-Source: AKy350bDU3/PLShu1sv2NZXRotzFT1zhbIpUhCSEsI0j3S7qUAuZqriNSF3+gnGXt5UcgILJBW0hB5HZkHuCYDvnmuU=
X-Received: by 2002:ac2:44d7:0:b0:4eb:30f9:eed1 with SMTP id
 d23-20020ac244d7000000b004eb30f9eed1mr1850720lfm.6.1680415679884; Sat, 01 Apr
 2023 23:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e0df2d05ef2d8b91@google.com>
In-Reply-To: <000000000000e0df2d05ef2d8b91@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 2 Apr 2023 08:07:48 +0200
Message-ID: <CACT4Y+bya0z1iU_z3WbqjG_4qQG=32ASnPns_eXqeDUVmvHpyQ@mail.gmail.com>
Subject: Re: [syzbot] memory leak in tcindex_set_parms (3)
To:     syzbot <syzbot+2f9183cb6f89b0e16586@syzkaller.appspotmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     davem@davemloft.net, edumazet@google.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2022 at 20:09, syzbot
<syzbot+2f9183cb6f89b0e16586@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    355479c70a48 Merge tag 'efi-fixes-for-v6.1-4' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16aef6bd880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=979161df0e247659
> dashboard link: https://syzkaller.appspot.com/bug?extid=2f9183cb6f89b0e16586
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d1ac47880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154f3bad880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/104ddf75422d/disk-355479c7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d32483369fdb/vmlinux-355479c7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f10fb444c08d/bzImage-355479c7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2f9183cb6f89b0e16586@syzkaller.appspotmail.com

#syz fix: net/sched: Retire tcindex classifier

> executing program
> BUG: memory leak
> unreferenced object 0xffff888107813900 (size 256):
>   comm "syz-executor147", pid 3623, jiffies 4294944130 (age 12.710s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814eda10>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1045
>     [<ffffffff83c0dda7>] kmalloc include/linux/slab.h:553 [inline]
>     [<ffffffff83c0dda7>] kmalloc_array include/linux/slab.h:604 [inline]
>     [<ffffffff83c0dda7>] kcalloc include/linux/slab.h:636 [inline]
>     [<ffffffff83c0dda7>] tcf_exts_init include/net/pkt_cls.h:250 [inline]
>     [<ffffffff83c0dda7>] tcindex_set_parms+0xa7/0xbe0 net/sched/cls_tcindex.c:342
>     [<ffffffff83c0e9bf>] tcindex_change+0xdf/0x120 net/sched/cls_tcindex.c:553
>     [<ffffffff83b91842>] tc_new_tfilter+0x4f2/0x1100 net/sched/cls_api.c:2147
>     [<ffffffff83ae1b6c>] rtnetlink_rcv_msg+0x4dc/0x5d0 net/core/rtnetlink.c:6082
>     [<ffffffff83c2fae7>] netlink_rcv_skb+0x87/0x1d0 net/netlink/af_netlink.c:2540
>     [<ffffffff83c2ec07>] netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>     [<ffffffff83c2ec07>] netlink_unicast+0x397/0x4c0 net/netlink/af_netlink.c:1345
>     [<ffffffff83c2f0c6>] netlink_sendmsg+0x396/0x710 net/netlink/af_netlink.c:1921
>     [<ffffffff83a812f6>] sock_sendmsg_nosec net/socket.c:714 [inline]
>     [<ffffffff83a812f6>] sock_sendmsg+0x56/0x80 net/socket.c:734
>     [<ffffffff83a81668>] ____sys_sendmsg+0x178/0x410 net/socket.c:2482
>     [<ffffffff83a86218>] ___sys_sendmsg+0xa8/0x110 net/socket.c:2536
>     [<ffffffff83a86565>] __sys_sendmmsg+0x105/0x330 net/socket.c:2622
>     [<ffffffff83a867b4>] __do_sys_sendmmsg net/socket.c:2651 [inline]
>     [<ffffffff83a867b4>] __se_sys_sendmmsg net/socket.c:2648 [inline]
>     [<ffffffff83a867b4>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2648
>     [<ffffffff8485b3b5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff8485b3b5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff88810ea1af00 (size 256):
>   comm "syz-executor147", pid 3623, jiffies 4294944131 (age 12.700s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814eda10>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1045
>     [<ffffffff83c0dda7>] kmalloc include/linux/slab.h:553 [inline]
>     [<ffffffff83c0dda7>] kmalloc_array include/linux/slab.h:604 [inline]
>     [<ffffffff83c0dda7>] kcalloc include/linux/slab.h:636 [inline]
>     [<ffffffff83c0dda7>] tcf_exts_init include/net/pkt_cls.h:250 [inline]
>     [<ffffffff83c0dda7>] tcindex_set_parms+0xa7/0xbe0 net/sched/cls_tcindex.c:342
>     [<ffffffff83c0e9bf>] tcindex_change+0xdf/0x120 net/sched/cls_tcindex.c:553
>     [<ffffffff83b91842>] tc_new_tfilter+0x4f2/0x1100 net/sched/cls_api.c:2147
>     [<ffffffff83ae1b6c>] rtnetlink_rcv_msg+0x4dc/0x5d0 net/core/rtnetlink.c:6082
>     [<ffffffff83c2fae7>] netlink_rcv_skb+0x87/0x1d0 net/netlink/af_netlink.c:2540
>     [<ffffffff83c2ec07>] netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>     [<ffffffff83c2ec07>] netlink_unicast+0x397/0x4c0 net/netlink/af_netlink.c:1345
>     [<ffffffff83c2f0c6>] netlink_sendmsg+0x396/0x710 net/netlink/af_netlink.c:1921
>     [<ffffffff83a812f6>] sock_sendmsg_nosec net/socket.c:714 [inline]
>     [<ffffffff83a812f6>] sock_sendmsg+0x56/0x80 net/socket.c:734
>     [<ffffffff83a81668>] ____sys_sendmsg+0x178/0x410 net/socket.c:2482
>     [<ffffffff83a86218>] ___sys_sendmsg+0xa8/0x110 net/socket.c:2536
>     [<ffffffff83a86565>] __sys_sendmmsg+0x105/0x330 net/socket.c:2622
>     [<ffffffff83a867b4>] __do_sys_sendmmsg net/socket.c:2651 [inline]
>     [<ffffffff83a867b4>] __se_sys_sendmmsg net/socket.c:2648 [inline]
>     [<ffffffff83a867b4>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2648
>     [<ffffffff8485b3b5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff8485b3b5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff88810a452680 (size 64):
>   comm "kworker/0:1", pid 42, jiffies 4294944576 (age 8.250s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     ff ff ff ff 00 00 00 00 00 00 00 00 30 30 00 00  ............00..
>   backtrace:
>     [<ffffffff814eda10>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1045
>     [<ffffffff842bb5c2>] kmalloc include/linux/slab.h:553 [inline]
>     [<ffffffff842bb5c2>] kzalloc include/linux/slab.h:689 [inline]
>     [<ffffffff842bb5c2>] regulatory_hint_core+0x22/0x60 net/wireless/reg.c:3248
>     [<ffffffff842c1720>] restore_regulatory_settings+0x690/0x910 net/wireless/reg.c:3582
>     [<ffffffff842c1aad>] crda_timeout_work+0x1d/0x30 net/wireless/reg.c:540
>     [<ffffffff8129197a>] process_one_work+0x2ba/0x5f0 kernel/workqueue.c:2289
>     [<ffffffff81292299>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
>     [<ffffffff8129c315>] kthread+0x125/0x160 kernel/kthread.c:376
>     [<ffffffff8100224f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>
> BUG: memory leak
> unreferenced object 0xffff88810e11c100 (size 256):
>   comm "syz-executor147", pid 3629, jiffies 4294944659 (age 7.420s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814eda10>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1045
>     [<ffffffff83c0dda7>] kmalloc include/linux/slab.h:553 [inline]
>     [<ffffffff83c0dda7>] kmalloc_array include/linux/slab.h:604 [inline]
>     [<ffffffff83c0dda7>] kcalloc include/linux/slab.h:636 [inline]
>     [<ffffffff83c0dda7>] tcf_exts_init include/net/pkt_cls.h:250 [inline]
>     [<ffffffff83c0dda7>] tcindex_set_parms+0xa7/0xbe0 net/sched/cls_tcindex.c:342
>     [<ffffffff83c0e9bf>] tcindex_change+0xdf/0x120 net/sched/cls_tcindex.c:553
>     [<ffffffff83b91842>] tc_new_tfilter+0x4f2/0x1100 net/sched/cls_api.c:2147
>     [<ffffffff83ae1b6c>] rtnetlink_rcv_msg+0x4dc/0x5d0 net/core/rtnetlink.c:6082
>     [<ffffffff83c2fae7>] netlink_rcv_skb+0x87/0x1d0 net/netlink/af_netlink.c:2540
>     [<ffffffff83c2ec07>] netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>     [<ffffffff83c2ec07>] netlink_unicast+0x397/0x4c0 net/netlink/af_netlink.c:1345
>     [<ffffffff83c2f0c6>] netlink_sendmsg+0x396/0x710 net/netlink/af_netlink.c:1921
>     [<ffffffff83a812f6>] sock_sendmsg_nosec net/socket.c:714 [inline]
>     [<ffffffff83a812f6>] sock_sendmsg+0x56/0x80 net/socket.c:734
>     [<ffffffff83a81668>] ____sys_sendmsg+0x178/0x410 net/socket.c:2482
>     [<ffffffff83a86218>] ___sys_sendmsg+0xa8/0x110 net/socket.c:2536
>     [<ffffffff83a86565>] __sys_sendmmsg+0x105/0x330 net/socket.c:2622
>     [<ffffffff83a867b4>] __do_sys_sendmmsg net/socket.c:2651 [inline]
>     [<ffffffff83a867b4>] __se_sys_sendmmsg net/socket.c:2648 [inline]
>     [<ffffffff83a867b4>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2648
>     [<ffffffff8485b3b5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff8485b3b5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000e0df2d05ef2d8b91%40google.com.
