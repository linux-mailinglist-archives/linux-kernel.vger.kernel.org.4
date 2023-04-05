Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107A36D79CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbjDEKgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDEKgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:36:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7550F4699;
        Wed,  5 Apr 2023 03:36:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so36837958pjb.0;
        Wed, 05 Apr 2023 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680690998;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDAQRFI014ms2XxMNlh+7fyGzfpnNxEo03ey2CBCbHE=;
        b=OikRdoPczzs1UoTqNBv/IU/1C2+QKdIS+V5wkVw/n/dLvjWOhUiNzl69r0SBRg/rLc
         BBlGU9tl0psFwt8pNTVsRA6s1lj2YeU27ddjIIUjq0wSFVCqJxgP32uiILk3hSZLI3Dx
         maBu6vQLX7ycML+xGWkfiWlR4rDL0BDJy/x3pjd0NruIRyOHGD6mvqBX3H15XcXxFI47
         9yVHzIEQHu9BpEGr0bHkE0otPgrXcra16haQMpLc1DwAHI/CwwNX6GRLT9Ap0sbtFjHA
         4KRCpLmiiVEfPsdB093d7GIgoTQI1sDWs/k427zgbwPvej34UZxPOzUwc9qvkmGgdZUa
         JyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680690998;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDAQRFI014ms2XxMNlh+7fyGzfpnNxEo03ey2CBCbHE=;
        b=EM5plEDiiDRP1hpRRKTCPaH5vtO9OYxOW6TkdSyW90ajGB67osvrcO3AMKMQw/kDzo
         3ZOSgbFMtZZJh3OUkJFq3qVr3SHGP+rZvRFsRYwhPsGNhRXw4bIZIjM3JjpUupN6Vc8t
         uml10+jUNZ9Gacs/pUUA3h/nT1Il51tBUkTs+jbB/T/SGcdamsg3aG6QYK6cmPBbGz5n
         0QMKSkK5m1FDFVvKCIDkoBUcqz/5UvLdMV9Cw7DrbN7R11dfEXvvYvlxoiXIbLaBiKKk
         sShG+cp+WG+tPE5P9PQCLORfZOCxqlO79oREB3/08ON2H8eTN7LXGP7J+Zkreu+/ol3p
         RvSg==
X-Gm-Message-State: AAQBX9edVudVuf7YUikw85ZqXVnLsDIA+1ivTi6ia7dMS2RYQNQpYMan
        E6w6dTzx67+WeGeicCJVuSw=
X-Google-Smtp-Source: AKy350ZqAxj5SPf47ZxqUUnVjJYpDUeIK/VJ7GZ5+we8GIT0HkQ+WDTlG9z2ud7B0Ds2CliipKfKrA==
X-Received: by 2002:a17:90b:3ece:b0:22c:6d7c:c521 with SMTP id rm14-20020a17090b3ece00b0022c6d7cc521mr6104080pjb.45.1680690997623;
        Wed, 05 Apr 2023 03:36:37 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id r3-20020a170902be0300b0019abb539cddsm9879069pls.10.2023.04.05.03.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:36:37 -0700 (PDT)
Date:   Wed, 5 Apr 2023 19:36:32 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        water.zhangjiantao@huawei.com, rafael@kernel.org,
        colin.i.king@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: BUG: unable to handle kernel paging request in __kernfs_new_node
Message-ID: <ZC1PMAWMO3dkp4KR@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We observed an issue "BUG: unable to handle kernel paging request in
__kernfs_new_node" during fuzzing.

Althogh the issue was detected in a kernfs API, we report this issue
to the usb gadget subsystem as we suspect that it is the most related
subsystem.

Unfortunately, we have not found a reproducer for the crash yet. We
will inform you if we have any update on this crash.
Detailed crash information is attached below.

Best regards,
Dae R. Jeong

-----
- Kernel version:
6.2-rc7

- Crash report:
BUG: unable to handle page fault for address: ffff8800302e746d
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 438 Comm: syz-executor.0 Not tainted 6.2.0-rc7-32171-g7f09e8f6ebfb #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:freelist_dereference mm/slub.c:388 [inline]
RIP: 0010:get_freepointer mm/slub.c:395 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:422 [inline]
RIP: 0010:__slab_alloc_node mm/slub.c:3347 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3442 [inline]
RIP: 0010:__kmem_cache_alloc_node+0x1b6/0x430 mm/slub.c:3491
Code: 48 89 df e8 6c 25 e7 ff 49 c1 ed 3a 44 3b 6d c0 0f 85 08 01 00 00 41 8b 5e 28 4c 8b 6d b8 4c 89 ef e8 0e 25 e7 ff 49 8d 3c 1c <49> 8b 1c 1c e8 41 25 e7 ff 49 8d 47 08 48 89 45 a0 49 8b 06 48 89
RSP: 0018:ffff888010c238f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: ffffc900078ee000
RDX: 0000000000000004 RSI: ffff888008441328 RDI: ffff8800302e746d
RBP: ffff888010c23968 R08: ffffffff8a667a61 R09: 00000000000009d6
R10: 0000000000000010 R11: ffff888011942180 R12: ffff8800302e7465
R13: ffff888008441328 R14: ffff888008441300 R15: 00000000000bd3f1
FS:  00007f288fea9700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8800302e746d CR3: 0000000040920000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc_node_track_caller+0xa6/0x2a0 mm/slab_common.c:988
 kstrdup mm/util.c:61 [inline]
 kstrdup_const+0x5a/0xa0 mm/util.c:84
 __kernfs_new_node+0x4d/0x3f0 fs/kernfs/dir.c:610
 kernfs_new_node fs/kernfs/dir.c:676 [inline]
 kernfs_create_dir_ns+0x70/0x180 fs/kernfs/dir.c:1032
 sysfs_create_dir_ns+0x96/0x1a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2be/0x640 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_init_and_add+0xa3/0xe0 lib/kobject.c:441
 bus_add_driver+0x145/0x3f0 drivers/base/bus.c:611
 driver_register+0x1de/0x2a0 drivers/base/driver.c:246
 usb_gadget_register_driver_owner+0x92/0x1b0 drivers/usb/gadget/udc/core.c:1560
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:546 [inline]
 raw_ioctl+0xbb9/0x1cf0 drivers/usb/gadget/legacy/raw_gadget.c:1253
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xe4/0x160 fs/ioctl.c:856
 __x64_sys_ioctl+0x4b/0x60 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x478ab7
Code: 8f 38 02 00 85 c0 78 df 48 83 c4 08 48 89 d8 5b 5d c3 90 48 89 e8 48 f7 d8 48 39 c3 0f 92 c0 eb b4 66 90 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f288fea6b18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000004d RCX: 0000000000478ab7
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 000000000000000b
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000020000940 R14: 00000000004022a0 R15: 0000000020000540
 </TASK>
Modules linked in:
CR2: ffff8800302e746d
---[ end trace 0000000000000000 ]---
RIP: 0010:freelist_dereference mm/slub.c:388 [inline]
RIP: 0010:get_freepointer mm/slub.c:395 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:422 [inline]
RIP: 0010:__slab_alloc_node mm/slub.c:3347 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3442 [inline]
RIP: 0010:__kmem_cache_alloc_node+0x1b6/0x430 mm/slub.c:3491
Code: 48 89 df e8 6c 25 e7 ff 49 c1 ed 3a 44 3b 6d c0 0f 85 08 01 00 00 41 8b 5e 28 4c 8b 6d b8 4c 89 ef e8 0e 25 e7 ff 49 8d 3c 1c <49> 8b 1c 1c e8 41 25 e7 ff 49 8d 47 08 48 89 45 a0 49 8b 06 48 89
RSP: 0018:ffff888010c238f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: ffffc900078ee000
RDX: 0000000000000004 RSI: ffff888008441328 RDI: ffff8800302e746d
RBP: ffff888010c23968 R08: ffffffff8a667a61 R09: 00000000000009d6
R10: 0000000000000010 R11: ffff888011942180 R12: ffff8800302e7465
R13: ffff888008441328 R14: ffff888008441300 R15: 00000000000bd3f1
FS:  00007f288fea9700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8800302e746d CR3: 0000000040920000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 df             	mov    %rbx,%rdi
   3:	e8 6c 25 e7 ff       	callq  0xffe72574
   8:	49 c1 ed 3a          	shr    $0x3a,%r13
   c:	44 3b 6d c0          	cmp    -0x40(%rbp),%r13d
  10:	0f 85 08 01 00 00    	jne    0x11e
  16:	41 8b 5e 28          	mov    0x28(%r14),%ebx
  1a:	4c 8b 6d b8          	mov    -0x48(%rbp),%r13
  1e:	4c 89 ef             	mov    %r13,%rdi
  21:	e8 0e 25 e7 ff       	callq  0xffe72534
  26:	49 8d 3c 1c          	lea    (%r12,%rbx,1),%rdi
* 2a:	49 8b 1c 1c          	mov    (%r12,%rbx,1),%rbx <-- trapping instruction
  2e:	e8 41 25 e7 ff       	callq  0xffe72574
  33:	49 8d 47 08          	lea    0x8(%r15),%rax
  37:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  3b:	49 8b 06             	mov    (%r14),%rax
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89
