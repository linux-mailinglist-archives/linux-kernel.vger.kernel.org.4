Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBED69D3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjBTTGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjBTTGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:06:19 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263FE2202A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:05:51 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id ck15so9633567edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kBn+CnOK1Wga0Zp5sp/eTaCX/3lqDyWIW2DiHniYLFA=;
        b=nylC6j1fVo/a5AfYrU1GE44d8EfSdoa0n8hgPuRA7LDAIIrOsTzhtqqeE//GHksYxz
         K1XnEmB/VAdVJMWYp6K8y/LsvhTz6yIRdLKN+UYDg0eCjOiLokyueKBgU7alQSsyx1AE
         hon1FQApsj7Ekh1aSUUFlaE8jrVYN4a7Mm/fkdlSKrQyN7sEQpIlj2mfD4O4Njosv7uo
         BVXLdm9T7+OJU4bXbR8/TlzXNKgVpFPEuQVAQ28JWoWuwL9Fq9qngmo4pcAecGcxjj0N
         HU43Ldcg90EdoRHl19Ixi9lo43oTQfi/64/Kby5Qh+n9zqaumhv1RE1pXNFDqPqJ/L9l
         y1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBn+CnOK1Wga0Zp5sp/eTaCX/3lqDyWIW2DiHniYLFA=;
        b=PT+pBpijQIrYGxQ9fHWfVQdBqHuEPRGQzxW9DuPFcVKz/Z8tEKo+eet8ilC68XwMW8
         F9V39YMqJDJQQJ/QnwQuf1uqwG0pzAI+M081oJqSoB6RLRpVisgaQk0eaf7RhpJzEi6E
         XPCK0ljVKfkDzppgFmIKQT37MXBVa8IJ3Z9RSlf1xGNpqANPphbcTaqJemw6aPWm9kMb
         o7p9v7DLCkfTU+ew5rC86WnQbk/CeYyVXTu8Xm6wMBsmsT5LHB+6tdEmQrEjquypKMFL
         7h08Ear+tKu0s/yu+Liu7gP3yLEJzZ/3CDbhRZ2GOqQFNCOD614aTuD2wmrtmyPmX0td
         tFFw==
X-Gm-Message-State: AO0yUKW4rb4SQAuFgsFKfUkB2rBstoCrMfd+H+DGWC10lRnKiDFB5mQg
        379MmGmtgK/p/6hqmM46KInCUy3e0xEwqv7wqPE=
X-Google-Smtp-Source: AK7set/PTssuZtB3AzZXBXARJWCebafgCY1/KqB01H8pEy2dBmZ+wI5pfBdxAXri32HLjgtIcLxAFDeMW7zNtzUr9Iw=
X-Received: by 2002:a50:9f04:0:b0:4ad:6fc8:69c1 with SMTP id
 b4-20020a509f04000000b004ad6fc869c1mr728081edf.3.1676919811432; Mon, 20 Feb
 2023 11:03:31 -0800 (PST)
MIME-Version: 1.0
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Mon, 20 Feb 2023 11:03:19 -0800
Message-ID: <CAGyP=7cgTARo7opXbtgNvPbAg0RFTdO2+NVHXgr5LkC0ZAPkSQ@mail.gmail.com>
Subject: KASAN: use-after-free Read in ntfs_trim_fs
To:     almaz.alexandrovich@paragon-software.com,
        LKML <linux-kernel@vger.kernel.org>, ntfs3@lists.linux.dev,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I found the following issue using syzkaller on:
HEAD commit : e60276b8c11ab4a8be23807bc67b04
8cfb937dfa (v6.0.8)
git tree: stable

C Reproducer : https://gist.github.com/oswalpalash/113c274067bc9c4c653a6dd09fb2e456
Kernel .config :
https://gist.github.com/oswalpalash/0962c70d774e5ec736a047bba917cecb

Console log :

==================================================================
BUG: KASAN: use-after-free in ntfs_trim_fs+0x84e/0x960
Read of size 2 at addr ffff888104fea640 by task syz-executor.0/8081

CPU: 1 PID: 8081 Comm: syz-executor.0 Not tainted 6.0.8-pasta #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xcd/0x134
 print_report.cold+0xe5/0x63a
 kasan_report+0x8a/0x1b0
 ntfs_trim_fs+0x84e/0x960
 ntfs_ioctl_fitrim+0x23e/0x340
 ntfs_ioctl+0x9c/0xd0
 __x64_sys_ioctl+0x193/0x200
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fac7f88eacd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fac805f9bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fac7f9bbf80 RCX: 00007fac7f88eacd
RDX: 0000000020000040 RSI: 00000000c0185879 RDI: 0000000000000003
RBP: 00007fac7f8fcb05 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcb363e05f R14: 00007ffcb363e200 R15: 00007fac805f9d80
 </TASK>

Allocated by task 8074:
 kasan_save_stack+0x1e/0x40
 __kasan_kmalloc+0xa6/0xd0
 __kmalloc+0x349/0xd40
 tomoyo_encode2.part.0+0xec/0x3b0
 tomoyo_encode+0x28/0x50
 tomoyo_realpath_from_path+0x186/0x620
 tomoyo_path_perm+0x219/0x420
 security_inode_getattr+0xcf/0x140
 vfs_getattr+0x22/0x60
 vfs_fstat+0x49/0x90
 __do_sys_newfstat+0x81/0x100
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 8074:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 kasan_set_free_info+0x20/0x30
 __kasan_slab_free+0xf5/0x180
 kfree+0x15e/0x540
 tomoyo_path_perm+0x240/0x420
 security_inode_getattr+0xcf/0x140
 vfs_getattr+0x22/0x60
 vfs_fstat+0x49/0x90
 __do_sys_newfstat+0x81/0x100
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888104fea640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 32-byte region [ffff888104fea640, ffff888104fea660)

The buggy address belongs to the physical page:
page:ffffea000413fa80 refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff888104feafc1 pfn:0x104fea
flags: 0x57ff00000000200(slab|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000200 ffffea00043f1b88 ffffea000414bec8 ffff888011840100
raw: ffff888104feafc1 ffff888104fea000 000000010000003d 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE),
pid 6509, tgid 6509 (syz-executor.3), ts 50269499850, free_ts
50269456139
 prep_new_page+0x2c6/0x350
 get_page_from_freelist+0xae9/0x3a80
 __alloc_pages+0x321/0x710
 cache_grow_begin+0x75/0x360
 kmem_cache_alloc_node_trace+0xbe2/0xd40
 __kmalloc_node+0x38/0x60
 __vmalloc_node_range+0x3d3/0x1320
 vzalloc+0x67/0x80
 alloc_counters.isra.0+0x5d/0x6f0
 do_ipt_get_ctl+0x5de/0x980
 nf_getsockopt+0x72/0xd0
 ip_getsockopt+0x164/0x1c0
 tcp_getsockopt+0x86/0xd0
 __sys_getsockopt+0x216/0x690
 __x64_sys_getsockopt+0xba/0x150
 do_syscall_64+0x35/0xb0
page last free stack trace:
 free_pcp_prepare+0x5ab/0xd00
 free_unref_page+0x19/0x410
 __vunmap+0x6ff/0xaa0
 __vfree+0x3c/0xd0
 vfree+0x5a/0x90
 do_ipt_get_ctl+0x7b2/0x980
 nf_getsockopt+0x72/0xd0
 ip_getsockopt+0x164/0x1c0
 tcp_getsockopt+0x86/0xd0
 __sys_getsockopt+0x216/0x690
 __x64_sys_getsockopt+0xba/0x150
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888104fea500: fa fb fb fb fc fc fc fc 02 fc fc fc fc fc fc fc
 ffff888104fea580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff888104fea600: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                           ^
 ffff888104fea680: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff888104fea700: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================
