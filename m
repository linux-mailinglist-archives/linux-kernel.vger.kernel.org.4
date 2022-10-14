Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062035FF553
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJNVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiJNVYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:24:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46271116C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:24:45 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e79c329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e79c:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A1811EC0749;
        Fri, 14 Oct 2022 23:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665782652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sL9Hdwoosr1myxY8uxl7rJYk4EfYMwZN6GGNR0+GVd8=;
        b=O8LpGMcBog7otzVpmp1f1BJNhIqGQsrx0Uf0HQ9NQbFP7MldJFt686rykKhrxHyuJTPaS0
        9lr79G/IwASin4L2E8vntxpXKszoaJKeimfzbPgCQxEyM2ziuqBOAaF/EwfaZZEO0KMB08
        ib55c2CLnABfsmQVjcbY9Z2z+Bwx9Ts=
Date:   Fri, 14 Oct 2022 23:24:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     syzbot <syzbot+d0fd2bf0dd6da72496dd@syzkaller.appspotmail.com>
Cc:     dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] WARNING in c_start
Message-ID: <Y0nTd9HSnnt/KDap@zn.tnic>
References: <0000000000007647ec05eb05249c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000007647ec05eb05249c@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 02:16:42PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://anon..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1030f562880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=557e715ffce7a200
> dashboard link: https://syzkaller.appspot.com/bug?extid=d0fd2bf0dd6da72496dd
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d0fd2bf0dd6da72496dd@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3671 at include/linux/cpumask.h:110 cpu_max_bits_warn include/linux/cpumask.h:110 [inline]
> WARNING: CPU: 1 PID: 3671 at include/linux/cpumask.h:110 cpumask_check include/linux/cpumask.h:117 [inline]
> WARNING: CPU: 1 PID: 3671 at include/linux/cpumask.h:110 cpumask_next include/linux/cpumask.h:178 [inline]
> WARNING: CPU: 1 PID: 3671 at include/linux/cpumask.h:110 c_start+0x152/0x1b0 arch/x86/kernel/cpu/proc.c:156
> Modules linked in:
> CPU: 1 PID: 3671 Comm: syz-fuzzer Not tainted 6.0.0-syzkaller-11990-g9c9155a3509a #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:110 [inline]
> RIP: 0010:cpumask_check include/linux/cpumask.h:117 [inline]
> RIP: 0010:cpumask_next include/linux/cpumask.h:178 [inline]
> RIP: 0010:c_start+0x152/0x1b0 arch/x86/kernel/cpu/proc.c:156
> Code: a0 68 99 8b e8 3f 97 4b 00 5b 5d 4c 89 e0 41 5c 41 5d c3 e8 30 97 4b 00 45 31 e4 5b 4c 89 e0 5d 41 5c 41 5d c3 e8 1e 97 4b 00 <0f> 0b e9 1e ff ff ff 48 c7 c7 40 54 e1 8d e8 fb 19 97 00 e9 6b ff
> RSP: 0018:ffffc90002f27c70 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffffff8de15440 RCX: 0000000000000000
> RDX: ffff88801b3b6100 RSI: ffffffff812ffc02 RDI: 0000000000000004
> RBP: 0000000000000008 R08: 0000000000000004 R09: 0000000000000008
> R10: 0000000000000008 R11: 0000000000000001 R12: ffff88801c29c278
> R13: 0000000000000008 R14: ffff888023b17b3c R15: 0000000000000000
> FS:  000000c00004e890(0000) GS:ffff88802c800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe53b98da00 CR3: 000000001b4cb000 CR4: 0000000000150ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  seq_read_iter+0x2c6/0x1280 fs/seq_file.c:225
>  proc_reg_read_iter+0x111/0x2d0 fs/proc/inode.c:301
>  call_read_iter include/linux/fs.h:2185 [inline]
>  new_sync_read fs/read_write.c:389 [inline]
>  vfs_read+0x67d/0x930 fs/read_write.c:470
>  ksys_read+0x127/0x250 fs/read_write.c:613
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x4ae09b
> Code: e8 ea 57 fb ff eb 88 cc cc cc cc cc cc cc cc e8 fb 9b fb ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> RSP: 002b:000000c0007233b8 EFLAGS: 00000212 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 000000c00003e800 RCX: 00000000004ae09b
> RDX: 0000000000000b49 RSI: 000000c0004fe4b7 RDI: 0000000000000003
> RBP: 000000c000723408 R08: 0000000000000001 R09: 000000c000074480
> R10: 0000000000000b49 R11: 0000000000000212 R12: 000000c000723570
> R13: 0000000000000000 R14: 000000c0000001a0 R15: 00007fe53942c2f3
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Let's see if the bot understands fetching patches from mailing lists:

# syz test: https://lore.kernel.org/r/20221014155845.1986223-3-ajones@ventanamicro.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
