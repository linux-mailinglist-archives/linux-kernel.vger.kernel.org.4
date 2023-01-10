Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD966635FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbjAJACZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbjAJACX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:02:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123551095
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:02:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A322614A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E93C433D2;
        Tue, 10 Jan 2023 00:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673308940;
        bh=Bo3AnNVXmmwYMuuPk5Lw90/Q5OVY3JGWHngWXn0FfXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ja6X/cVS8o1va3h6gogTHEP1nw8w/e8Zz/ihx+Lldt7GQX3Bs9QbVkne5MqPpNLf0
         58ALME2skhO4dzyaho+f3bQaSvszrZ8hfNr7+vftuPfFTkq+7VKVFAkD4prqDPRC4G
         6o490S/tWV359tDiqPCkjz2BAi9uyOFPoIi6NEv0=
Date:   Mon, 9 Jan 2023 16:02:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+502859d610c661e56545@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [syzbot] WARNING in mbind_range
Message-Id: <20230109160219.1bda9e780e0fdf7b43cd0210@linux-foundation.org>
In-Reply-To: <000000000000de1c8f05f1d566d0@google.com>
References: <00000000000053159f05f1cf4cad@google.com>
        <000000000000de1c8f05f1d566d0@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023 06:15:39 -0800 syzbot <syzbot+502859d610c661e56545@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    543b9b2fe10b Add linux-next specific files for 20230109
> git tree:       linux-next

THanks.  Will you be performing a bisection?

> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12978216480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ceb6f70a080e19c3
> dashboard link: https://syzkaller.appspot.com/bug?extid=502859d610c661e56545
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117fcc02480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1396d7d6480000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/22f2428ec2eb/disk-543b9b2f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6003c7af47cc/vmlinux-543b9b2f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ac9a6ad60347/bzImage-543b9b2f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+502859d610c661e56545@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5072 at mm/mempolicy.c:797 mbind_range+0x5d2/0x760 mm/mempolicy.c:797

static int mbind_range(struct mm_struct *mm, unsigned long start,
		       unsigned long end, struct mempolicy *new_pol)
{
	VMA_ITERATOR(vmi, mm, start);
	struct vm_area_struct *prev;
	struct vm_area_struct *vma;
	int err = 0;
	pgoff_t pgoff;

	prev = vma_prev(&vmi);
	vma = vma_find(&vmi, end);
	if (WARN_ON(!vma))
		return 0;

Liam recently altered this code with "mempolicy: convert to vma iterator"?

> Modules linked in:
> CPU: 0 PID: 5072 Comm: syz-executor326 Not tainted 6.2.0-rc3-next-20230109-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:mbind_range+0x5d2/0x760 mm/mempolicy.c:797
> Code: 96 e8 f2 c7 b4 ff 4d 85 e4 74 8c e8 e8 c7 b4 ff 4c 89 e7 e8 10 7d ff ff e9 7a ff ff ff 45 31 f6 e9 72 ff ff ff e8 ce c7 b4 ff <0f> 0b 45 31 f6 e9 63 ff ff ff e8 bf ae 02 00 e9 6d fc ff ff 4c 89
> RSP: 0018:ffffc90003c9fca8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff88807aa0ec00 RCX: 0000000000000000
> RDX: ffff888022cad7c0 RSI: ffffffff81cce582 RDI: ffffc90003c9fd20
> RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000020c12000
> R13: 0000000000000000 R14: 0000000020012000 R15: 0000000000000000
> FS:  00005555556a1300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fba95ca5fb8 CR3: 0000000026945000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  do_mbind mm/mempolicy.c:1320 [inline]
>  kernel_mbind+0x473/0x7c0 mm/mempolicy.c:1474
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fba95c5eae9
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe65f13508 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fba95c5eae9
> RDX: 0000000000000000 RSI: 0000000000c00000 RDI: 0000000020012000
> RBP: 00007fba95c22c90 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fba95c22d20
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
