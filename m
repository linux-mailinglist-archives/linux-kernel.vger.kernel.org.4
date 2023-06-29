Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FDB742410
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjF2Khb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjF2Kh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:37:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8210A1719
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 173D161519
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C500CC433C8;
        Thu, 29 Jun 2023 10:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688035045;
        bh=sONaYv6UlgXbLD/aLQtYnVckSjlCsweTqAbtdSSP5zM=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=Uzj6h2JqtcxAN20DXkkU6uIHwrEK0txzz9xT3T72nX8OymgoSrnuMrlntqt8TH//H
         Zkoy12uP5E6S1B4arAgk7C2x55bOsWxaKEztqGcE2YTaIrmtKQTDqkqjoBvKQ11tbx
         KsAFupaqBjgQcUmpcOjDMgqHN25VIQ9G8e5Aq6yIYQQFzqLYpHg+DZlfj38uF0cd3a
         yux9CcAF8cx7sgk7FGJWdwzdxddUahIHuLX2ac4e/Z8aQmD/TZyjim+MqDzyXpsBtb
         DomWQSQp6O11yDkzIkeL5vc63prQYZU9lB4LB4lZMNkQdu/zF/WhRTWttPN05OazHP
         dD5QEklr204/g==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     syzbot <syzbot+522a57d8d5a0f7ac5c6c@syzkaller.appspotmail.com>,
        brauner@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] upstream test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
In-Reply-To: <000000000000dde2fb05ff2d39c6@google.com>
References: <000000000000dde2fb05ff2d39c6@google.com>
Date:   Thu, 29 Jun 2023 12:37:21 +0200
Message-ID: <87352a7dwe.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+522a57d8d5a0f7ac5c6c@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6aeadf7896bf Merge tag 'docs-arm64-move' of git://git.lwn...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12cea2c7280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=652d39e0420afbb8
> dashboard link: https://syzkaller.appspot.com/bug?extid=522a57d8d5a0f7ac5c6c
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3887d048a41c/disk-6aeadf78.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b25a7d5f9034/vmlinux-6aeadf78.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/96457fbed62d/bzImage-6aeadf78.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+522a57d8d5a0f7ac5c6c@syzkaller.appspotmail.com
>
> ================================================================================
> UBSAN: array-index-out-of-bounds in kernel/pid.c:244:3
> index 1 is out of range for type 'struct upid[1]'
> CPU: 1 PID: 4996 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-01761-g6aeadf7896bf #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
>  alloc_pid+0x405/0xc40 kernel/pid.c:244
>  copy_process+0x1f2f/0x4350 kernel/fork.c:2523
>  kernel_clone+0x222/0x800 kernel/fork.c:2915
>  __do_sys_clone kernel/fork.c:3058 [inline]
>  __se_sys_clone kernel/fork.c:3042 [inline]
>  __x64_sys_clone+0x258/0x2a0 kernel/fork.c:3042
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f30e5e89fab
> Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
> RSP: 002b:00007ffe72312890 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 00007ffe72312ee8 RCX: 00007f30e5e89fab
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> RBP: 0000000000000000 R08: 0000000000000000 R09: 000055555643c400
> R10: 000055555643c6d0 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe72312980 R14: 00007f30e5fac9d8 R15: 000000000000000c
>  </TASK>
> ================================================================================

FWIW, I hit this with the clone3 kselftest (on riscv).
