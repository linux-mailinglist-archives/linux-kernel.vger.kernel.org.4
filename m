Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD06EC6F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjDXHWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjDXHWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:22:20 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB126B9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:21:47 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-32ac22bff76so68971605ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320905; x=1684912905;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfEreKeYTqaaybtHAxb82NeFUj+2/QJlezil8gQ3ut0=;
        b=FNbHLVAjLDb+iZrll6u/XkVmQa78rHkAOAlA8MBmuNcxT+0pXxELn9c3QnF7kbh/J+
         l5nH4cD++UBJQTgYHNQJRNIveFs4dUkceEntPXirqW9UKvZstiKB1ryXP8O8/b8XAz0L
         7GMrYz/MwcCB0gDwj79m4uU52qv30x+UccLlKRhcyZPECxPbAVkXzNKqDbirZczDf+H+
         XCyvT7+4fWQ2jty+QQ79UzN/mu4JU15cKdbXqUnRXcdehMCCVIzg1vxRZHKT5kj24J5W
         H9lyOz+qHwgoMC074xx46pLa3s7yrLfFZsBRExMp7fU+wWtGqsE8Eu2B4+4YjuGd9QdY
         SpMQ==
X-Gm-Message-State: AAQBX9cuBdtdhvx48k0prieyiPcKZsf2X0mrMQh///UoBKk7VPuBSxsq
        84UdBng2B6PPcdYGH8NnDDD6lfmzGNPPIF6bh7ziHUXlrdYF
X-Google-Smtp-Source: AKy350b1cmHFGxvyqOwsEF9FP1I8yH5ugBTNp4hRlmbiuP5Lqaxf/avESMtcvK27Cbb2zTei9Q/k+TZoZpzkf27c87yz3N+8fxUT
MIME-Version: 1.0
X-Received: by 2002:a92:c60c:0:b0:326:bcc4:dabb with SMTP id
 p12-20020a92c60c000000b00326bcc4dabbmr4361426ilm.5.1682320905685; Mon, 24 Apr
 2023 00:21:45 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:21:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb55ed05fa0fdb4b@google.com>
Subject: [syzbot] [mm?] [fs?] KCSAN: data-race in __filemap_remove_folio / shmem_get_folio_gfp
From:   syzbot <syzbot+ec4650f158c91a963120@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb0856346a60 Merge tag 'mm-hotfixes-stable-2023-04-19-16-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170802cfc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
dashboard link: https://syzkaller.appspot.com/bug?extid=ec4650f158c91a963120
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a02dd7789fb2/disk-cb085634.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1a1eac454f6/vmlinux-cb085634.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb0447014913/bzImage-cb085634.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec4650f158c91a963120@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __filemap_remove_folio / shmem_get_folio_gfp

read-write to 0xffff888136bf8960 of 8 bytes by task 19402 on cpu 1:
 page_cache_delete mm/filemap.c:147 [inline]
 __filemap_remove_folio+0x22f/0x330 mm/filemap.c:225
 filemap_remove_folio+0x6c/0x220 mm/filemap.c:257
 truncate_inode_folio+0x19f/0x1e0 mm/truncate.c:196
 shmem_undo_range+0x24d/0xc20 mm/shmem.c:942
 shmem_truncate_range mm/shmem.c:1041 [inline]
 shmem_fallocate+0x2fc/0x8d0 mm/shmem.c:2779
 vfs_fallocate+0x369/0x3d0 fs/open.c:324
 madvise_remove mm/madvise.c:1001 [inline]
 madvise_vma_behavior mm/madvise.c:1025 [inline]
 madvise_walk_vmas mm/madvise.c:1260 [inline]
 do_madvise+0x77b/0x28a0 mm/madvise.c:1439
 __do_sys_madvise mm/madvise.c:1452 [inline]
 __se_sys_madvise mm/madvise.c:1450 [inline]
 __x64_sys_madvise+0x60/0x70 mm/madvise.c:1450
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888136bf8960 of 8 bytes by task 19400 on cpu 0:
 shmem_recalc_inode mm/shmem.c:359 [inline]
 shmem_get_folio_gfp+0xc0a/0x1120 mm/shmem.c:1977
 shmem_fault+0xd9/0x3d0 mm/shmem.c:2152
 __do_fault mm/memory.c:4155 [inline]
 do_read_fault mm/memory.c:4506 [inline]
 do_fault mm/memory.c:4635 [inline]
 handle_pte_fault mm/memory.c:4923 [inline]
 __handle_mm_fault mm/memory.c:5065 [inline]
 handle_mm_fault+0x115d/0x21d0 mm/memory.c:5211
 faultin_page mm/gup.c:925 [inline]
 __get_user_pages+0x363/0xc30 mm/gup.c:1147
 populate_vma_page_range mm/gup.c:1543 [inline]
 __mm_populate+0x23a/0x360 mm/gup.c:1652
 mm_populate include/linux/mm.h:3026 [inline]
 vm_mmap_pgoff+0x174/0x210 mm/util.c:547
 ksys_mmap_pgoff+0xc5/0x320 mm/mmap.c:1410
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x0000000000000437 -> 0x0000000000000430

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 19400 Comm: syz-executor.3 Not tainted 6.3.0-rc7-syzkaller-00089-gcb0856346a60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
