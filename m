Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC6E6C9A48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 05:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjC0Dkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 23:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjC0Dkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:40:42 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4249F1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 20:40:41 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id w8-20020a92db48000000b00322124084f3so4975002ilq.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 20:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679888440;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBmRuY0titHxK9jm3zIYfXCs7kYdreINgFapoYnk6EY=;
        b=nwwkHf228DxTjyd+say7swcjXFfEFLEgkxoPKD6/FAe7ioKa8COzchsO6syCRb7KL9
         onD9g1QQUt0LJrWd4Rwb2wJvrBCKzeNG+4sIq85sKLsTW6HUjn9q/fg3ovvc8Wn7aSyx
         hl1/N5+0vji6Yn7rTeGVncOMX+HYHDoDXosj5UQX3LAlWi+XQM6lPs69s3pFVF5ms6IT
         GGgBiEAkEkclzCAB/xFb7Dzk81KaSO1KvhA1CMiwo1mAM8J5J8hm3LCjJYez2weC05PE
         Ho4Aij0E0Rr4s4S+YwtOgXe9D0jHTHLgQKwAxERJABWM3o9Te6hppBpFgbfNl/PIYjDm
         IUUQ==
X-Gm-Message-State: AO0yUKU9IV/tLmFyoZttstVO+R+3MR88IuUZlhDnRBPI6WMpEOWeXVTG
        eUV8vicLhHjdBtJIwCw7pwibYO6uXOj6LsRi6bwMbJNl+rBf
X-Google-Smtp-Source: AK7set+y267l1chfZnErITPTXtnox2QC9BSFt9ulwJPdMTQrRZoaXqzPt3xAsPp/rCrEh5PoTA/7SzRxcSTSrS1K9Yd2dgjhr8ei
MIME-Version: 1.0
X-Received: by 2002:a5e:9901:0:b0:745:c41a:8f0f with SMTP id
 t1-20020a5e9901000000b00745c41a8f0fmr3899286ioj.2.1679888440391; Sun, 26 Mar
 2023 20:40:40 -0700 (PDT)
Date:   Sun, 26 Mar 2023 20:40:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0822e05f7d9812d@google.com>
Subject: [syzbot] linux-next test error: general protection fault in vma_merge
From:   syzbot <syzbot+a2fd5af4a33891110a79@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c4a254d78f8 Add linux-next specific files for 20230323
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15f70246c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20fd034702e6edd2
dashboard link: https://syzkaller.appspot.com/bug?extid=a2fd5af4a33891110a79
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dc0bbbecd2a5/disk-7c4a254d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b2c8c7cfd4b/vmlinux-7c4a254d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae312a388585/bzImage-7c4a254d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2fd5af4a33891110a79@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000018: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
CPU: 1 PID: 5080 Comm: syz-fuzzer Not tainted 6.3.0-rc3-next-20230323-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:vma_merge+0x234/0x1fd0 mm/mmap.c:952
Code: 08 00 0f 84 b0 03 00 00 e8 e9 54 bf ff 48 8b 44 24 08 48 8d b8 a8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 18 00 00 48 8b 44 24 08 48 8b b0 a8 00 00 00
RSP: 0018:ffffc90003d0f998 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff88802974b800 RCX: 0000000000000000
RDX: 0000000000000018 RSI: ffffffff81c37957 RDI: 00000000000000c7
RBP: ffff888079aaa400 R08: 0000000000000006 R09: 0000000000000000
R10: 000000c001ffffff R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 000000c002000000 R15: 0000000000000000
FS:  000000c000524890(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe510676000 CR3: 00000000249a5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 madvise_update_vma+0x23f/0xd40 mm/madvise.c:153
 madvise_vma_behavior+0x7f6/0x20e0 mm/madvise.c:1091
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1260
 do_madvise.part.0+0x193/0x470 mm/madvise.c:1439
 do_madvise mm/madvise.c:1452 [inline]
 __do_sys_madvise mm/madvise.c:1452 [inline]
 __se_sys_madvise mm/madvise.c:1450 [inline]
 __x64_sys_madvise+0x117/0x150 mm/madvise.c:1450
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x46b557
Code: 8b 24 24 48 8b 6c 24 10 48 83 c4 18 c3 cc cc cc cc cc cc 48 8b 7c 24 08 48 8b 74 24 10 8b 54 24 18 48 c7 c0 1c 00 00 00 0f 05 <89> 44 24 20 c3 cc cc cc cc 48 8b 7c 24 08 8b 74 24 10 8b 54 24 14
RSP: 002b:000000c00022de60 EFLAGS: 00000206 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 0000000000a12000 RCX: 000000000046b557
RDX: 000000000000000e RSI: 0000000000800000 RDI: 000000c001c00000
RBP: 000000c00022de88 R08: 0000000000000509 R09: 000000c001b6a000
R10: 00000000000012bd R11: 0000000000000206 R12: 0000000000000509
R13: 0000000000000003 R14: 000000c0003f1a00 R15: 00000000010e0700
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vma_merge+0x234/0x1fd0 mm/mmap.c:952
Code: 08 00 0f 84 b0 03 00 00 e8 e9 54 bf ff 48 8b 44 24 08 48 8d b8 a8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 18 00 00 48 8b 44 24 08 48 8b b0 a8 00 00 00
RSP: 0018:ffffc90003d0f998 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff88802974b800 RCX: 0000000000000000
RDX: 0000000000000018 RSI: ffffffff81c37957 RDI: 00000000000000c7
RBP: ffff888079aaa400 R08: 0000000000000006 R09: 0000000000000000
R10: 000000c001ffffff R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 000000c002000000 R15: 0000000000000000
FS:  000000c000524890(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564702bbb078 CR3: 00000000249a5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 00                	or     %al,(%rax)
   2:	0f 84 b0 03 00 00    	je     0x3b8
   8:	e8 e9 54 bf ff       	callq  0xffbf54f6
   d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  12:	48 8d b8 a8 00 00 00 	lea    0xa8(%rax),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 4d 18 00 00    	jne    0x1881
  34:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  39:	48 8b b0 a8 00 00 00 	mov    0xa8(%rax),%rsi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
