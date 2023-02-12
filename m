Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E7B6938E1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 18:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBLRAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 12:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBLRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 12:00:32 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9419AB767
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 09:00:30 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id cz14so8450786oib.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pKSudmSKQOMoI7Uau6/tXCIQk6s6H4oNiWkUO6Tzb3U=;
        b=L0mdtYNyIscc8/RoxRcp3LgoUN/BOzRiAcdjmysCJENqUUg7gOJrjJ68WZ8ymH6jSh
         Wq9M8NTvDYHhGbhKGAEiiLbPG+2Gf7EFqbT7ua3otvd4oOj+TYuHt6BVzSjwUfNDctPT
         N2ZQ38U3X80Tr8dtcGHNomiULvkCK6v4wJ/J5muqjI/PW4o5SS/VrA4v2pYAzompTqBf
         g/YBaDnJMimHlhRQuPACvNMGaxcW9ufgDRUjVSgXQqjHho5EnY4q7fioTY7/3Wmi8p4K
         bJkbX3H74LjJZxKLsudElFUCTwSf6sRtFNszbPLy47vBj2aUayzIA0/HkBPPYLiQHGsT
         iV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKSudmSKQOMoI7Uau6/tXCIQk6s6H4oNiWkUO6Tzb3U=;
        b=oB/8o6sUsWlNhsrJX3zKfLdcXj5Z/i9Bk+1A7lCTZFp8XPIEtWCcPOuId/U1t+mdmH
         /te5QSUIm/YkmoG1PJbKq4KKafgShUeqvEozeJr8whjRbImTgYG9CXO1EJITrXvi3mGQ
         GQniHScJhaYeC39gmpWekFX/ERsVI9XHgZHN0cD0BNfZdnNMVNP1Ct0R5tgTW55OBurY
         vFL9gyNmjaEe2HIeDrb6cVsVYg2etO64+QfExVftGMLF8p/q/PT/tMRg3Lz71dUc4F7r
         XtYXVIGjCe/1ZkKy7r+OwQycb1dFy1w1+LCbuskhxcEHNIcjM0oxPg+Fr0kYEZAdYisx
         Bfvw==
X-Gm-Message-State: AO0yUKUo+L8DZfS3+HzFktwue69pZ3MUvQXcBZ/zl10OdOVPFOaJ2M0Z
        PqxxzY1+345LmZUgj+1B1i5EfAJspwW9rvDY594=
X-Google-Smtp-Source: AK7set+Va9rar+l/Ty4Y8fW4zOIq868h6JZPlNXas56MxXfTDG9ymeSIwYWcXXACi1dka85thcCL6Q0zlTPvQkOE0Yw=
X-Received: by 2002:a05:6808:1312:b0:378:2775:39fd with SMTP id
 y18-20020a056808131200b00378277539fdmr1939162oiv.283.1676221228687; Sun, 12
 Feb 2023 09:00:28 -0800 (PST)
MIME-Version: 1.0
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Sun, 12 Feb 2023 09:00:17 -0800
Message-ID: <CANX2M5ayFcJsq7P2-mPAt0rvmfjYB9PaL0E2K7mKUxUC=TCTwA@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in n_tty_open
To:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000e6f15005f483aaa0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e6f15005f483aaa0
Content-Type: text/plain; charset="UTF-8"

Hi,

We would like to report the following bug which has been found by our
modified version of syzkaller.

======================================================
description: BUG: unable to handle kernel paging request in n_tty_open
affected file: drivers/tty/tty_ldisc.c
kernel version: 6.2.0-rc5
kernel commit: 41c66f47061608dc1fd493eebce198f0e74cc2d7
git tree: kmsan
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=a9a22da1efde3af6
crash reproducer: attached
======================================================
Crash log:
======================================================
RBP: 00007f7117670c30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000d
R13: 00007f71165abf6c R14: 00007f71165abf60 R15: 00007f7117670d80
 </TASK>
BUG: unable to handle page fault for address: ffffd10016bfa050
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 11410067 P4D 11410067 PUD 1157d067 PMD 31910067 PTE 0
Oops: 0002 [#1] PREEMPT SMP
CPU: 1 PID: 14496 Comm: syz-executor.4 Not tainted
6.2.0-rc5-00010-g41c66f470616 #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:n_tty_open+0xa5/0x240 drivers/tty/n_tty.c:1883
Code: c8 48 c7 c7 c0 79 c0 8f e8 f8 0e ef fb 4d 8d 67 50 48 8b 18 8b
02 89 45 d0 4d 85 ed 0f 85 12 01 00 00 4c 89 e7 e8 0b 0f ef fb <48> 89
18 48 85 db 0f 85 0b 01 00 00 4d 8d a7 88 22 00 00 48 8b 45
RSP: 0018:ffff8880a72036a0 EFLAGS: 00010286
RAX: ffffd10016bfa050 RBX: 0000000000000000 RCX: ffffd10016bfa050
RDX: ffffd90016bfa050 RSI: 0000000000000001 RDI: ffffc90016bfa050
RBP: ffff8880a72036e0 R08: 0000000000000001 R09: ffff8880a6a03458
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90016bfa050
R13: 0000000000000000 R14: ffff88808b6c1000 R15: ffffc90016bfa000
FS:  00007f7117671700(0000) GS:ffff88813fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffd10016bfa050 CR3: 00000000a7110000 CR4: 0000000000150ee0
Call Trace:
 <TASK>
 tty_ldisc_open drivers/tty/tty_ldisc.c:433 [inline]
 tty_ldisc_setup+0xfc/0x4c0 drivers/tty/tty_ldisc.c:740
 tty_init_dev+0x4b0/0xad0 drivers/tty/tty_io.c:1437
 tty_open_by_driver drivers/tty/tty_io.c:2079 [inline]
 tty_open+0x176f/0x20b0 drivers/tty/tty_io.c:2126
 chrdev_open+0xa45/0xb80 fs/char_dev.c:414
 do_dentry_open+0xf85/0x1970 fs/open.c:882
 vfs_open+0x75/0xa0 fs/open.c:1013
 do_open fs/namei.c:3557 [inline]
 path_openat+0x4c4b/0x5a00 fs/namei.c:3714
 do_filp_open+0x252/0x660 fs/namei.c:3741
 do_sys_openat2+0x200/0x920 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x285/0x310 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f711648d59d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7117670bd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f71165abf60 RCX: 00007f711648d59d
RDX: 00000000000a6503 RSI: 0000000020000000 RDI: ffffffffffffff9c
RBP: 00007f7117670c30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000d
R13: 00007f71165abf6c R14: 00007f71165abf60 R15: 00007f7117670d80
 </TASK>
Modules linked in:
CR2: ffffd10016bfa050
---[ end trace 0000000000000000 ]---
RIP: 0010:n_tty_open+0xa5/0x240 drivers/tty/n_tty.c:1883
Code: c8 48 c7 c7 c0 79 c0 8f e8 f8 0e ef fb 4d 8d 67 50 48 8b 18 8b
02 89 45 d0 4d 85 ed 0f 85 12 01 00 00 4c 89 e7 e8 0b 0f ef fb <48> 89
18 48 85 db 0f 85 0b 01 00 00 4d 8d a7 88 22 00 00 48 8b 45
RSP: 0018:ffff8880a72036a0 EFLAGS: 00010286
RAX: ffffd10016bfa050 RBX: 0000000000000000 RCX: ffffd10016bfa050
RDX: ffffd90016bfa050 RSI: 0000000000000001 RDI: ffffc90016bfa050
RBP: ffff8880a72036e0 R08: 0000000000000001 R09: ffff8880a6a03458
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90016bfa050
R13: 0000000000000000 R14: ffff88808b6c1000 R15: ffffc90016bfa000
FS:  00007f7117671700(0000) GS:ffff88813fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffd10016bfa050 CR3: 00000000a7110000 CR4: 0000000000150ee0
----------------
Code disassembly (best guess):
   0: c8 48 c7 c7          enterq $0xc748,$0xc7
   4: c0 79 c0 8f          sarb   $0x8f,-0x40(%rcx)
   8: e8 f8 0e ef fb        callq  0xfbef0f05
   d: 4d 8d 67 50          lea    0x50(%r15),%r12
  11: 48 8b 18              mov    (%rax),%rbx
  14: 8b 02                mov    (%rdx),%eax
  16: 89 45 d0              mov    %eax,-0x30(%rbp)
  19: 4d 85 ed              test   %r13,%r13
  1c: 0f 85 12 01 00 00    jne    0x134
  22: 4c 89 e7              mov    %r12,%rdi
  25: e8 0b 0f ef fb        callq  0xfbef0f35
* 2a: 48 89 18              mov    %rbx,(%rax) <-- trapping instruction
  2d: 48 85 db              test   %rbx,%rbx
  30: 0f 85 0b 01 00 00    jne    0x141
  36: 4d 8d a7 88 22 00 00 lea    0x2288(%r15),%r12
  3d: 48                    rex.W
  3e: 8b                    .byte 0x8b
  3f: 45                    rex.RB

-- 
Thanks and Regards,

Dipanjan

--000000000000e6f15005f483aaa0
Content-Type: text/x-csrc; charset="US-ASCII"; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_le1mrgen0>
X-Attachment-Id: f_le1mrgen0

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRSAKCiNpbmNsdWRlIDxkaXJlbnQuaD4KI2lu
Y2x1ZGUgPGVuZGlhbi5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNp
bmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0ZGFyZy5oPgojaW5jbHVkZSA8c3RkYm9vbC5o
PgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGli
Lmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5cy9wcmN0bC5oPgojaW5jbHVkZSA8
c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMu
aD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNpbmNsdWRlIDx1bmlz
dGQuaD4KCnN0YXRpYyB2b2lkIHNsZWVwX21zKHVpbnQ2NF90IG1zKQp7Cgl1c2xlZXAobXMgKiAx
MDAwKTsKfQoKc3RhdGljIHVpbnQ2NF90IGN1cnJlbnRfdGltZV9tcyh2b2lkKQp7CglzdHJ1Y3Qg
dGltZXNwZWMgdHM7CglpZiAoY2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUMsICZ0cykpCgll
eGl0KDEpOwoJcmV0dXJuICh1aW50NjRfdCl0cy50dl9zZWMgKiAxMDAwICsgKHVpbnQ2NF90KXRz
LnR2X25zZWMgLyAxMDAwMDAwOwp9CgpzdGF0aWMgYm9vbCB3cml0ZV9maWxlKGNvbnN0IGNoYXIq
IGZpbGUsIGNvbnN0IGNoYXIqIHdoYXQsIC4uLikKewoJY2hhciBidWZbMTAyNF07Cgl2YV9saXN0
IGFyZ3M7Cgl2YV9zdGFydChhcmdzLCB3aGF0KTsKCXZzbnByaW50ZihidWYsIHNpemVvZihidWYp
LCB3aGF0LCBhcmdzKTsKCXZhX2VuZChhcmdzKTsKCWJ1ZltzaXplb2YoYnVmKSAtIDFdID0gMDsK
CWludCBsZW4gPSBzdHJsZW4oYnVmKTsKCWludCBmZCA9IG9wZW4oZmlsZSwgT19XUk9OTFkgfCBP
X0NMT0VYRUMpOwoJaWYgKGZkID09IC0xKQoJCXJldHVybiBmYWxzZTsKCWlmICh3cml0ZShmZCwg
YnVmLCBsZW4pICE9IGxlbikgewoJCWludCBlcnIgPSBlcnJubzsKCQljbG9zZShmZCk7CgkJZXJy
bm8gPSBlcnI7CgkJcmV0dXJuIGZhbHNlOwoJfQoJY2xvc2UoZmQpOwoJcmV0dXJuIHRydWU7Cn0K
CnN0YXRpYyBpbnQgaW5qZWN0X2ZhdWx0KGludCBudGgpCnsKCWludCBmZDsKCWZkID0gb3Blbigi
L3Byb2MvdGhyZWFkLXNlbGYvZmFpbC1udGgiLCBPX1JEV1IpOwoJaWYgKGZkID09IC0xKQoJZXhp
dCgxKTsKCWNoYXIgYnVmWzE2XTsKCXNwcmludGYoYnVmLCAiJWQiLCBudGgpOwoJaWYgKHdyaXRl
KGZkLCBidWYsIHN0cmxlbihidWYpKSAhPSAoc3NpemVfdClzdHJsZW4oYnVmKSkKCWV4aXQoMSk7
CglyZXR1cm4gZmQ7Cn0KCnN0YXRpYyB2b2lkIGtpbGxfYW5kX3dhaXQoaW50IHBpZCwgaW50KiBz
dGF0dXMpCnsKCWtpbGwoLXBpZCwgU0lHS0lMTCk7CglraWxsKHBpZCwgU0lHS0lMTCk7Cglmb3Ig
KGludCBpID0gMDsgaSA8IDEwMDsgaSsrKSB7CgkJaWYgKHdhaXRwaWQoLTEsIHN0YXR1cywgV05P
SEFORyB8IF9fV0FMTCkgPT0gcGlkKQoJCQlyZXR1cm47CgkJdXNsZWVwKDEwMDApOwoJfQoJRElS
KiBkaXIgPSBvcGVuZGlyKCIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMiKTsKCWlmIChkaXIpIHsK
CQlmb3IgKDs7KSB7CgkJCXN0cnVjdCBkaXJlbnQqIGVudCA9IHJlYWRkaXIoZGlyKTsKCQkJaWYg
KCFlbnQpCgkJCQlicmVhazsKCQkJaWYgKHN0cmNtcChlbnQtPmRfbmFtZSwgIi4iKSA9PSAwIHx8
IHN0cmNtcChlbnQtPmRfbmFtZSwgIi4uIikgPT0gMCkKCQkJCWNvbnRpbnVlOwoJCQljaGFyIGFi
b3J0WzMwMF07CgkJCXNucHJpbnRmKGFib3J0LCBzaXplb2YoYWJvcnQpLCAiL3N5cy9mcy9mdXNl
L2Nvbm5lY3Rpb25zLyVzL2Fib3J0IiwgZW50LT5kX25hbWUpOwoJCQlpbnQgZmQgPSBvcGVuKGFi
b3J0LCBPX1dST05MWSk7CgkJCWlmIChmZCA9PSAtMSkgewoJCQkJY29udGludWU7CgkJCX0KCQkJ
aWYgKHdyaXRlKGZkLCBhYm9ydCwgMSkgPCAwKSB7CgkJCX0KCQkJY2xvc2UoZmQpOwoJCX0KCQlj
bG9zZWRpcihkaXIpOwoJfSBlbHNlIHsKCX0KCXdoaWxlICh3YWl0cGlkKC0xLCBzdGF0dXMsIF9f
V0FMTCkgIT0gcGlkKSB7Cgl9Cn0KCnN0YXRpYyB2b2lkIHNldHVwX3Rlc3QoKQp7CglwcmN0bChQ
Ul9TRVRfUERFQVRIU0lHLCBTSUdLSUxMLCAwLCAwLCAwKTsKCXNldHBncnAoKTsKCXdyaXRlX2Zp
bGUoIi9wcm9jL3NlbGYvb29tX3Njb3JlX2FkaiIsICIxMDAwIik7Cn0KCnN0YXRpYyB2b2lkIHNl
dHVwX2ZhdWx0KCkKewoJc3RhdGljIHN0cnVjdCB7CgkJY29uc3QgY2hhciogZmlsZTsKCQljb25z
dCBjaGFyKiB2YWw7CgkJYm9vbCBmYXRhbDsKCX0gZmlsZXNbXSA9IHsKCSAgICB7Ii9zeXMva2Vy
bmVsL2RlYnVnL2ZhaWxzbGFiL2lnbm9yZS1nZnAtd2FpdCIsICJOIiwgdHJ1ZX0sCgkgICAgeyIv
c3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX2Z1dGV4L2lnbm9yZS1wcml2YXRlIiwgIk4iLCBmYWxzZX0s
CgkgICAgeyIvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX3BhZ2VfYWxsb2MvaWdub3JlLWdmcC1oaWdo
bWVtIiwgIk4iLCBmYWxzZX0sCgkgICAgeyIvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX3BhZ2VfYWxs
b2MvaWdub3JlLWdmcC13YWl0IiwgIk4iLCBmYWxzZX0sCgkgICAgeyIvc3lzL2tlcm5lbC9kZWJ1
Zy9mYWlsX3BhZ2VfYWxsb2MvbWluLW9yZGVyIiwgIjAiLCBmYWxzZX0sCgl9OwoJdW5zaWduZWQg
aTsKCWZvciAoaSA9IDA7IGkgPCBzaXplb2YoZmlsZXMpIC8gc2l6ZW9mKGZpbGVzWzBdKTsgaSsr
KSB7CgkJaWYgKCF3cml0ZV9maWxlKGZpbGVzW2ldLmZpbGUsIGZpbGVzW2ldLnZhbCkpIHsKCQkJ
aWYgKGZpbGVzW2ldLmZhdGFsKQoJZXhpdCgxKTsKCQl9Cgl9Cn0KCnN0YXRpYyB2b2lkIGV4ZWN1
dGVfb25lKHZvaWQpOwoKI2RlZmluZSBXQUlUX0ZMQUdTIF9fV0FMTAoKc3RhdGljIHZvaWQgbG9v
cCh2b2lkKQp7CglpbnQgaXRlciA9IDA7Cglmb3IgKDs7IGl0ZXIrKykgewoJCWludCBwaWQgPSBm
b3JrKCk7CgkJaWYgKHBpZCA8IDApCglleGl0KDEpOwoJCWlmIChwaWQgPT0gMCkgewoJCQlzZXR1
cF90ZXN0KCk7CgkJCWV4ZWN1dGVfb25lKCk7CgkJCWV4aXQoMCk7CgkJfQoJCWludCBzdGF0dXMg
PSAwOwoJCXVpbnQ2NF90IHN0YXJ0ID0gY3VycmVudF90aW1lX21zKCk7CgkJZm9yICg7OykgewoJ
CQlpZiAod2FpdHBpZCgtMSwgJnN0YXR1cywgV05PSEFORyB8IFdBSVRfRkxBR1MpID09IHBpZCkK
CQkJCWJyZWFrOwoJCQlzbGVlcF9tcygxKTsKCQkJaWYgKGN1cnJlbnRfdGltZV9tcygpIC0gc3Rh
cnQgPCA1MDAwKQoJCQkJY29udGludWU7CgkJCWtpbGxfYW5kX3dhaXQocGlkLCAmc3RhdHVzKTsK
CQkJYnJlYWs7CgkJfQoJfQp9Cgp2b2lkIGV4ZWN1dGVfb25lKHZvaWQpCnsKbWVtY3B5KCh2b2lk
KikweDIwMDAwMDAwLCAiL2Rldi90dHlTM1wwMDAiLCAxMSk7CglpbmplY3RfZmF1bHQoMTMpOwoJ
c3lzY2FsbChfX05SX29wZW5hdCwgMHhmZmZmZmZmZmZmZmZmZjljdWwsIDB4MjAwMDAwMDB1bCwg
MHhhNjUwM3VsLCAwdWwpOwoKfQppbnQgbWFpbih2b2lkKQp7CgkJc3lzY2FsbChfX05SX21tYXAs
IDB4MWZmZmYwMDB1bCwgMHgxMDAwdWwsIDB1bCwgMHgzMnVsLCAtMSwgMHVsKTsKCXN5c2NhbGwo
X19OUl9tbWFwLCAweDIwMDAwMDAwdWwsIDB4MTAwMDAwMHVsLCA3dWwsIDB4MzJ1bCwgLTEsIDB1
bCk7CglzeXNjYWxsKF9fTlJfbW1hcCwgMHgyMTAwMDAwMHVsLCAweDEwMDB1bCwgMHVsLCAweDMy
dWwsIC0xLCAwdWwpOwoJc2V0dXBfZmF1bHQoKTsKCQkJbG9vcCgpOwoJcmV0dXJuIDA7Cn0K
--000000000000e6f15005f483aaa0
Content-Type: application/octet-stream; name="repro.syz"
Content-Disposition: attachment; filename="repro.syz"
Content-Transfer-Encoding: base64
Content-ID: <f_le1mrgey1>
X-Attachment-Id: f_le1mrgey1

b3BlbmF0JHR0eVMzKDB4ZmZmZmZmZmZmZmZmZmY5YywgJigweDdmMDAwMDAwMDAwMCksIDB4YTY1
MDMsIDB4MCkgKGZhaWxfbnRoOiAxMykK
--000000000000e6f15005f483aaa0--
