Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAA169C68D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjBTI0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBTI0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:26:49 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF3C12863
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:26:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b12so1357293edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ox6jck2o4GGhqs86ktZk8BkoqIgSSF1hbrtYJ/AXHMU=;
        b=F/nV5mh58MnIkXzcx0l9CJwZ2asOXY2hGZ4He439hWVAbQ+xV+EvgPAHdhK4WlnXHX
         8T6Mn5rCLLAwzQVA/N+xznqo7uRNg+RKWm2Ba6I6wNYmFEX/HL/82JUN2zJVbEKVaADy
         A5yDuZ83mH3StmOkvsgznYT/WYgnlVNHlLz5K0pHBNvo9uAQdvX0PYH6xJtowkFYgAfO
         bjzCMmsNAniar1umM0e+nopiGmu3bSUsdKDAJeYlyI9qlUxwtu3ZxouGrd2PteDRrSwE
         wRtPKITFySs4rg3etD4px/mvcaHbWI4HL2BpOlqnV1wxbMJyaUe3gCfA8qDtdSjGIZmr
         LEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ox6jck2o4GGhqs86ktZk8BkoqIgSSF1hbrtYJ/AXHMU=;
        b=PXuxd27c3LUoOFo1pR9SCytY0trrNP/f8L9cINqfPTPtLIZQxGblZT1ONu9r/+v9eY
         kZZWbCl/WalqIW8q8fw34MEOz70kt6TLEOMl2zgzq4Srgll+Eq8OtBS8zUWBImtFCydK
         cB/TqEu5OvWjQer9VkPwr/cfGUKJiuWHqr7SbyDQA2L4G0k+uxg5zVHOjsgMGztq9+0m
         b2Orem58C2UjTtFtcuhY4L8jkmOKV1S+0pXwsIwBeD1VtRiDf/H+6xf72C/wqhbi5S8u
         faM0AlOQPs1uz9PLW5RMTgD7pZFCVSHpBWRYQPBWLlj7EWkqR70lwfjQXaic4LXO/ZCX
         aFJw==
X-Gm-Message-State: AO0yUKVQWEcl3xO/pt6e4aLKHLElpZWNEc7sJi6y+6N5RyURjj7B6Pj5
        P4PQFB5MEqj1EQXsC/1gXocfoWFcAzZWoUj0fas=
X-Google-Smtp-Source: AK7set/1K1Qv5nSTvlx+Fd5Pgt/mf5UDBtNt74K2MRwJny1kfl/m5gHPi0II3iiqJgjXTLoQqAVxL1VrxquuAya84ZM=
X-Received: by 2002:a50:f690:0:b0:4ac:20b:96b0 with SMTP id
 d16-20020a50f690000000b004ac020b96b0mr1120681edn.3.1676881606566; Mon, 20 Feb
 2023 00:26:46 -0800 (PST)
MIME-Version: 1.0
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Mon, 20 Feb 2023 00:26:35 -0800
Message-ID: <CAGyP=7fTKyew8AWO_Lj136U6UivEXRdoASKr60ea1gpW-7d6ZA@mail.gmail.com>
Subject: KASAN: use-after-free Read in run_unpack
To:     almaz.alexandrovich@paragon-software.com,
        LKML <linux-kernel@vger.kernel.org>, ntfs3@lists.linux.dev,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I found the following issue using syzkaller on:
HEAD commit : e60276b8c11ab4a8be23807bc67b048cfb937dfa (v6.0.8)
git tree: stable

C Reproducer : https://gist.github.com/oswalpalash/76ca8fcd92332c75a0a7efaa26269c42
Kernel .config :
https://gist.github.com/oswalpalash/0962c70d774e5ec736a047bba917cecb

Console log :
loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
==================================================================
BUG: KASAN: use-after-free in run_unpack+0x89a/0x940
Read of size 1 at addr ffff888024b21900 by task syz-executor.0/16961

CPU: 0 PID: 16961 Comm: syz-executor.0 Not tainted 6.0.8-pasta #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xcd/0x134
 print_report.cold+0xe5/0x63a
 kasan_report+0x8a/0x1b0
 run_unpack+0x89a/0x940
 run_unpack_ex+0xb8/0x620
 ntfs_iget5+0xc18/0x3270
 ntfs_fill_super+0x27de/0x3d30
 get_tree_bdev+0x440/0x760
 vfs_get_tree+0x89/0x2f0
 path_mount+0x121b/0x1cb0
 do_mount+0xf3/0x110
 __x64_sys_mount+0x18f/0x230
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcf8309146e
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcf83dc4a08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fcf8309146e
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fcf83dc4a60
RBP: 00007fcf83dc4aa0 R08: 00007fcf83dc4aa0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fcf83dc4a60 R15: 0000000020002a00
 </TASK>

Allocated by task 6460:
 kasan_save_stack+0x1e/0x40
 __kasan_kmalloc+0xa6/0xd0
 kmalloc_reserve+0x32/0xd0
 __alloc_skb+0x11a/0x320
 tcp_stream_alloc_skb+0x38/0x550
 tcp_sendmsg_locked+0xc44/0x2fd0
 tcp_sendmsg+0x2b/0x40
 inet_sendmsg+0x99/0xe0
 sock_sendmsg+0xc3/0x120
 sock_write_iter+0x291/0x3d0
 vfs_write+0x9ca/0xd90
 ksys_write+0x1e8/0x250
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 6460:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 kasan_set_free_info+0x20/0x30
 __kasan_slab_free+0xf5/0x180
 kfree+0x15e/0x540
 skb_free_head+0xac/0x110
 skb_release_data+0x56f/0x850
 skb_release_all+0x46/0x60
 __kfree_skb+0x11/0x20
 tcp_ack+0x1e54/0x5af0
 tcp_rcv_established+0x14b5/0x2130
 tcp_v4_do_rcv+0x701/0xd00
 __release_sock+0x12f/0x3a0
 release_sock+0x54/0x1b0
 tcp_sendmsg+0x36/0x40
 inet_sendmsg+0x99/0xe0
 sock_sendmsg+0xc3/0x120
 sock_write_iter+0x291/0x3d0
 vfs_write+0x9ca/0xd90
 ksys_write+0x1e8/0x250
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40
 __kasan_record_aux_stack+0x7e/0x90
 call_rcu+0x99/0x740
 xfrm_policy_kill+0x120/0x250
 xfrm_policy_delete+0x65/0x90
 sk_common_release+0x24e/0x330
 inet_release+0x12e/0x270
 __sock_release+0xcd/0x280
 sock_close+0x18/0x20
 __fput+0x27c/0xa90
 task_work_run+0xe0/0x1a0
 exit_to_user_mode_prepare+0x25d/0x270
 syscall_exit_to_user_mode+0x19/0x50
 do_syscall_64+0x42/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888024b21800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 256 bytes inside of
 1024-byte region [ffff888024b21800, ffff888024b21c00)

The buggy address belongs to the physical page:
page:ffffea000092c840 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x24b21
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0000a00188 ffffea000077b9c8 ffff888011840700
raw: 0000000000000000 ffff888024b21000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x2c2220(__GFP_HIGH|__GFP_ATOMIC|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_THISNODE),
pid 16, tgid 16 (ksoftirqd/0), ts 86734280820, free_ts 86664849571
 prep_new_page+0x2c6/0x350
 get_page_from_freelist+0xae9/0x3a80
 __alloc_pages+0x321/0x710
 cache_grow_begin+0x75/0x360
 kmem_cache_alloc_node_trace+0xbe2/0xd40
 __kmalloc_node_track_caller+0x38/0x60
 kmalloc_reserve+0x32/0xd0
 __alloc_skb+0x11a/0x320
 tcp_stream_alloc_skb+0x38/0x550
 tcp_write_xmit+0x1c72/0x6170
 __tcp_push_pending_frames+0xaa/0x380
 tcp_rcv_established+0x9d5/0x2130
 tcp_v4_do_rcv+0x701/0xd00
 tcp_v4_rcv+0x3cf0/0x3f70
 ip_protocol_deliver_rcu+0x9b/0x7c0
 ip_local_deliver_finish+0x2fb/0x4e0
page last free stack trace:
 free_pcp_prepare+0x5ab/0xd00
 free_unref_page+0x19/0x410
 slab_destroy+0x14/0x50
 drain_freelist+0x9c/0xe0
 cache_reap+0x1b9/0x2f0
 process_one_work+0x9c7/0x1650
 worker_thread+0x623/0x1070
 kthread+0x2e9/0x3a0
 ret_from_fork+0x1f/0x30

Memory state around the buggy address:
 ffff888024b21800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024b21880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888024b21900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888024b21980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024b21a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
