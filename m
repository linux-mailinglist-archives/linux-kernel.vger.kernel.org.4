Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E37B702203
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbjEODJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjEODJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:09:52 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56021707
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 20:09:50 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-331a812aa1eso76358465ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 20:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684120190; x=1686712190;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRU0rjb8JefBTmoDMF+g1dYQsfw2AxmnXJwd6Giu3tg=;
        b=FsYqV+/JZVcil5EyeN2brnzfoM6F9+xZAydBqrEmVHGi0cJXkgF6+/zsv+gKeUi/U1
         GJjawUCDQ8PwLxY9C/BYRaDNkBGukzrCKLOyAnpZbQMn1gv25mMkAm57GGwFHk8vdot0
         kUN9kB5OFSMj/Xteimr22hY8efxJFeQfPeKxRV4X/RoAIGb/3PugtJULcA31nDu7GZZ0
         O7Z8N/4JTeCIrCswvU8xp7AONoCaiMRGKb/SdQ/hzz6+xATT53Qc8m4FfAw8HHIP3Qbl
         9XkxTUtSKUIdHMnrUUKFcjka+/Z1jvB7XcAQBEmnoKZYjDfeEIhPlnVs4ByOYtFaTpkN
         bLmw==
X-Gm-Message-State: AC+VfDxsqXOaomINVO5IaI7RNAekUbHwzbNs4zE+YS54iZJNKGBUo+n7
        8dHODZr+XMYnEdGa+FtBgfpS7cXi/jfBsha7iu/FEILKh2ZG
X-Google-Smtp-Source: ACHHUZ6vyiRKV66BJe2HM3So05t4s7Hvx7UV1Jc2piMsLNRNTvjOSAfEWvK0yNwAu0RWtZKgh2M2jkXd0OQElpHK3DCYUR1DSjWp
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:687:b0:333:74f7:a7ff with SMTP id
 o7-20020a056e02068700b0033374f7a7ffmr15178579ils.6.1684120190239; Sun, 14 May
 2023 20:09:50 -0700 (PDT)
Date:   Sun, 14 May 2023 20:09:50 -0700
In-Reply-To: <0000000000007fa2d705fb29f046@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2cbe305fbb2c9d9@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in __aria_aesni_avx_gfni_crypt_16way
From:   syzbot <syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    31f4104e392a Merge tag 'locking_urgent_for_v6.4_rc2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11768616280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
dashboard link: https://syzkaller.appspot.com/bug?extid=a6abcf08bad8b18fd198
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1737e3be280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149d4c06280000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-31f4104e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/967f88e07e18/vmlinux-31f4104e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b4e92e4df24e/bzImage-31f4104e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com

general protection fault, maybe for address 0xffffffff8c12a198: 0000 [#1] PREEMPT SMP KASAN
CPU: 2 PID: 5136 Comm: syz-executor269 Not tainted 6.4.0-rc1-syzkaller-00190-g31f4104e392a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:__aria_aesni_avx_gfni_crypt_16way+0x2a6/0x4f40 arch/x86/crypto/aria-aesni-avx-asm_64.S:1164
Code: d0 10 c4 e2 69 00 d7 c5 11 ef ea c5 e9 72 d0 08 c4 e2 69 00 d7 c5 09 ef f2 c4 e2 79 00 d7 c5 01 ef fa c5 f9 6f 05 7a 15 c9 0a <c5> f9 6f 0d 6a 15 c9 0a c5 f9 6f 15 7a 15 c9 0a c5 f9 6f 1d 52 15
RSP: 0018:ffffc9000384f210 EFLAGS: 00010286
RAX: ffff888026364890 RBX: 0000000000000000 RCX: ffff888026364890
RDX: ffff888026364890 RSI: ffff888026364890 RDI: ffff888023c79028
RBP: ffff88801fb3c900 R08: ffff888026364910 R09: ffff888023c79028
R10: ffff88801fb3c800 R11: ffff88801fb3c800 R12: ffff88801fb3c900
R13: ffff888023c79028 R14: dffffc0000000000 R15: ffff888026364890
FS:  0000000000000000(0000) GS:ffff88802c800000(0063) knlGS:0000000056fc72c0
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f29a06956a8 CR3: 000000001f222000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 aria_aesni_avx_gfni_ctr_crypt_16way+0x1d/0x110 arch/x86/crypto/aria-aesni-avx-asm_64.S:1339
 aria_avx_ctr_encrypt+0x180/0x680 arch/x86/crypto/aria_aesni_avx_glue.c:103
 crypto_skcipher_encrypt+0xbc/0x100 crypto/skcipher.c:653
 crypto_skcipher_encrypt+0xbc/0x100 crypto/skcipher.c:653
 crypto_gcm_encrypt+0x393/0x4b0 crypto/gcm.c:459
 crypto_aead_encrypt+0xbc/0x100 crypto/aead.c:121
 tls_do_encryption net/tls/tls_sw.c:544 [inline]
 tls_push_record+0x12d8/0x30f0 net/tls/tls_sw.c:777
 bpf_exec_tx_verdict+0xdf0/0x1210 net/tls/tls_sw.c:817
 tls_sw_sendmsg+0x100b/0x1850 net/tls/tls_sw.c:1033
 inet6_sendmsg+0x9d/0xe0 net/ipv6/af_inet6.c:651
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 sock_write_iter+0x295/0x3d0 net/socket.c:1140
 call_write_iter include/linux/fs.h:1868 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x945/0xd50 fs/read_write.c:584
 ksys_write+0x1ec/0x250 fs/read_write.c:637
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f45579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff8f022c EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020000580
RDX: 0000000000000278 RSI: 00000000f7fe8000 RDI: 0000000000000000
RBP: 00000000ff8f0290 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__aria_aesni_avx_gfni_crypt_16way+0x2a6/0x4f40 arch/x86/crypto/aria-aesni-avx-asm_64.S:1164
Code: d0 10 c4 e2 69 00 d7 c5 11 ef ea c5 e9 72 d0 08 c4 e2 69 00 d7 c5 09 ef f2 c4 e2 79 00 d7 c5 01 ef fa c5 f9 6f 05 7a 15 c9 0a <c5> f9 6f 0d 6a 15 c9 0a c5 f9 6f 15 7a 15 c9 0a c5 f9 6f 1d 52 15
RSP: 0018:ffffc9000384f210 EFLAGS: 00010286
RAX: ffff888026364890 RBX: 0000000000000000 RCX: ffff888026364890
RDX: ffff888026364890 RSI: ffff888026364890 RDI: ffff888023c79028
RBP: ffff88801fb3c900 R08: ffff888026364910 R09: ffff888023c79028
R10: ffff88801fb3c800 R11: ffff88801fb3c800 R12: ffff88801fb3c900
R13: ffff888023c79028 R14: dffffc0000000000 R15: ffff888026364890
FS:  0000000000000000(0000) GS:ffff88802c800000(0063) knlGS:0000000056fc72c0
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f29a06956a8 CR3: 000000001f222000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	d0 10                	rclb   (%rax)
   2:	c4 e2 69 00 d7       	vpshufb %xmm7,%xmm2,%xmm2
   7:	c5 11 ef ea          	vpxor  %xmm2,%xmm13,%xmm13
   b:	c5 e9 72 d0 08       	vpsrld $0x8,%xmm0,%xmm2
  10:	c4 e2 69 00 d7       	vpshufb %xmm7,%xmm2,%xmm2
  15:	c5 09 ef f2          	vpxor  %xmm2,%xmm14,%xmm14
  19:	c4 e2 79 00 d7       	vpshufb %xmm7,%xmm0,%xmm2
  1e:	c5 01 ef fa          	vpxor  %xmm2,%xmm15,%xmm15
  22:	c5 f9 6f 05 7a 15 c9 	vmovdqa 0xac9157a(%rip),%xmm0        # 0xac915a4
  29:	0a
* 2a:	c5 f9 6f 0d 6a 15 c9 	vmovdqa 0xac9156a(%rip),%xmm1        # 0xac9159c <-- trapping instruction
  31:	0a
  32:	c5 f9 6f 15 7a 15 c9 	vmovdqa 0xac9157a(%rip),%xmm2        # 0xac915b4
  39:	0a
  3a:	c5                   	.byte 0xc5
  3b:	f9                   	stc
  3c:	6f                   	outsl  %ds:(%rsi),(%dx)
  3d:	1d                   	.byte 0x1d
  3e:	52                   	push   %rdx
  3f:	15                   	.byte 0x15


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
