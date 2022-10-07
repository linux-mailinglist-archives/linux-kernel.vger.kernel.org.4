Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22F05F8015
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJGVgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJGVgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:36:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E410C4D0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 14:35:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so5752577pjf.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+wrwccqdr/zF+1tP1F0UnlCET9RTVASvUjJL3hAGzM=;
        b=HGs1RayrgTgUjIt/VJSsGC+WEqkhCp1S82B5zMpTiKUCHGV8MUSkaoFaclYVBBKoJO
         2jbgDbb7hN85Lhe0G7tQwEzExctfTuNhSIH4wbBU+21qEKUE5c29uvHDLL/oDfh6CDYV
         8HQCnmsMkUG5TQmzLbdu/pBfqPBydSpc7dt5N0GGEZ6ajNnJ+X9uCVLvi4yya65vs2xG
         l9jJF5qVrER931/BXzThv7fjNNm0K+Bk+fo3M1/3v6X12gH7dTWU3cZf6MIi9VW6EIDK
         JoQpgGb0qkHWZ12BWEY+al/8t4b4vcZbGSrMRetFhmjWyaszWHkSX2zcFbJ5U8a7Z1Z0
         ylsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+wrwccqdr/zF+1tP1F0UnlCET9RTVASvUjJL3hAGzM=;
        b=eCmTilmBjNeNvRwMiYGKdWIRSUv6f/ADx/46cg02uc//5gHEP7jyDZURTEB+DaRD39
         DDi/sbtlIE5nZTnac3XZOZbDcxzsmVKdZDwJBBLQvlKVWaizWt+RncsttNOHBMdM2sn5
         ejY1A7tJ1lWzvDNFVMBXHS9jqNjEZXcZRDVbDtAwizr/h/1abCe7ZBZpTkRlwqN/YZWZ
         0/ZbxNfHqP4vfvZJJNlyuf3WUoU8HHNWkP8OomYcH+rw2wHEiZPgfzrfKbyj45HYvxcD
         6C7kCcaRRSCV4lK1t1k1LNCbi/tdvTH+zFNnizUWf3ZaRDLZUrfplNa8jcqj/b0ihbxm
         rE0Q==
X-Gm-Message-State: ACrzQf2Zf7eq7DVROPMbl8jd3d+k0UvKi0F4PpyKSP9oVYaIT5ojbMPI
        ldtiFv9DrzTBi85Po3nMqJk=
X-Google-Smtp-Source: AMsMyM5CA/5ugdTIDbGsq24SwxOBXcWIV2TsGkAQGTBU81XGOxyyJDdJPShYMuoW/SC5jv/DYQvrBg==
X-Received: by 2002:a17:90b:3149:b0:202:e9e9:632f with SMTP id ip9-20020a17090b314900b00202e9e9632fmr18805312pjb.96.1665178551253;
        Fri, 07 Oct 2022 14:35:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w19-20020a631613000000b004597e92f99dsm2091586pgl.66.2022.10.07.14.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 14:35:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 7 Oct 2022 11:35:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [syzbot] general protection fault in kernfs_get_inode
Message-ID: <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000028a44005ea40352b@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc'ing Christian and quoting whole body)

Christan, I can't repro it here but think what we need is sth like the
following. The problem is that cgroup_is_dead() check in the fork path isn't
enough as the perm check depends on cgrp->procs_file being available but
that is cleared while DYING before DEAD. So, depending on the timing, we can
end up trying to deref NULL pointer in may_write.

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8ad2c267ff471..603b7167450a1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4934,6 +4934,10 @@ static int cgroup_may_write(const struct cgroup *cgrp, struct super_block *sb)
 
 	lockdep_assert_held(&cgroup_mutex);
 
+	/*if @cgrp is being removed, procs_file may already be gone */
+	if (!cgrp->procs_file.kn)
+		return -ENODEV;
+
 	inode = kernfs_get_inode(sb, cgrp->procs_file.kn);
 	if (!inode)
 		return -ENOMEM;


On Tue, Oct 04, 2022 at 07:19:34PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    0326074ff465 Merge tag 'net-next-6.1' of git://git.kernel...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=149c92cc880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1de7ca9efcc028c
> dashboard link: https://syzkaller.appspot.com/bug?extid=534ee3d24c37c411f37f
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10af2492880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104874f0880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/43729d6ce2fc/disk-0326074f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1f76d6f68eb3/vmlinux-0326074f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
> CPU: 1 PID: 3617 Comm: syz-executor384 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> RIP: 0010:kernfs_ino include/linux/kernfs.h:358 [inline]
> RIP: 0010:kernfs_get_inode+0x2e/0x520 fs/kernfs/inode.c:254
> Code: 41 56 41 55 41 54 49 89 fc 53 48 89 f3 e8 1a 04 7e ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 3a 04 00 00 48 8b b3 90 00 00 00 4c 89 e7 e8 79
> RSP: 0018:ffffc90003c8fa30 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000012 RSI: ffffffff81fd1156 RDI: 0000000000000090
> RBP: ffffc90003c8fa50 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000024 R12: ffff8880224ba000
> R13: ffff888075922000 R14: ffff88801ebf0000 R15: ffff8880211ae000
> FS:  0000555556907300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000200 CR3: 000000001c179000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  cgroup_may_write+0x86/0x120 kernel/cgroup/cgroup.c:4937
>  cgroup_css_set_fork kernel/cgroup/cgroup.c:6237 [inline]
>  cgroup_can_fork+0x961/0xec0 kernel/cgroup/cgroup.c:6331
>  copy_process+0x43ed/0x7090 kernel/fork.c:2358
>  kernel_clone+0xe7/0xab0 kernel/fork.c:2671
>  __do_sys_clone3+0x1cd/0x2e0 kernel/fork.c:2963
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f621d8c3e99
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcaa952ec8 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f621d8c3e99
> RDX: 0000000000000000 RSI: 0000000000000058 RDI: 00007ffcaa952f40
> RBP: 0000000000000000 R08: 00007ffcaa952d60 R09: 00007ffcaa952ef0
> R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffcaa952eec
> R13: 00007ffcaa952f00 R14: 00007ffcaa952f40 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:kernfs_ino include/linux/kernfs.h:358 [inline]
> RIP: 0010:kernfs_get_inode+0x2e/0x520 fs/kernfs/inode.c:254
> Code: 41 56 41 55 41 54 49 89 fc 53 48 89 f3 e8 1a 04 7e ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 3a 04 00 00 48 8b b3 90 00 00 00 4c 89 e7 e8 79
> RSP: 0018:ffffc90003c8fa30 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000012 RSI: ffffffff81fd1156 RDI: 0000000000000090
> RBP: ffffc90003c8fa50 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000024 R12: ffff8880224ba000
> R13: ffff888075922000 R14: ffff88801ebf0000 R15: ffff8880211ae000
> FS:  0000555556907300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffcaa9cb8f0 CR3: 000000001c179000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	41 56                	push   %r14
>    2:	41 55                	push   %r13
>    4:	41 54                	push   %r12
>    6:	49 89 fc             	mov    %rdi,%r12
>    9:	53                   	push   %rbx
>    a:	48 89 f3             	mov    %rsi,%rbx
>    d:	e8 1a 04 7e ff       	callq  0xff7e042c
>   12:	48 8d bb 90 00 00 00 	lea    0x90(%rbx),%rdi
>   19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   20:	fc ff df
>   23:	48 89 fa             	mov    %rdi,%rdx
>   26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>   2e:	0f 85 3a 04 00 00    	jne    0x46e
>   34:	48 8b b3 90 00 00 00 	mov    0x90(%rbx),%rsi
>   3b:	4c 89 e7             	mov    %r12,%rdi
>   3e:	e8                   	.byte 0xe8
>   3f:	79                   	.byte 0x79
> 

-- 
tejun
