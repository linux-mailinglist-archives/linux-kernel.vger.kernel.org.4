Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E595F869D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 20:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiJHS3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiJHS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 14:29:46 -0400
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FE94D105
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 11:29:41 -0700 (PDT)
Received: by cae.in-ulm.de (Postfix, from userid 1000)
        id 4F4C414026A; Sat,  8 Oct 2022 20:29:40 +0200 (CEST)
Date:   Sat, 8 Oct 2022 20:29:40 +0200
From:   "Christian A. Ehrhardt" <lk@c--e.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Christian Brauner <brauner@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [syzbot] general protection fault in kernfs_get_inode
Message-ID: <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi (from another Christian),

On Fri, Oct 07, 2022 at 11:35:49AM -1000, Tejun Heo wrote:
> (cc'ing Christian and quoting whole body)
> 
> Christan, I can't repro it here but think what we need is sth like the
> following. The problem is that cgroup_is_dead() check in the fork path isn't
> enough as the perm check depends on cgrp->procs_file being available but
> that is cleared while DYING before DEAD. So, depending on the timing, we can
> end up trying to deref NULL pointer in may_write.
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 8ad2c267ff471..603b7167450a1 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -4934,6 +4934,10 @@ static int cgroup_may_write(const struct cgroup *cgrp, struct super_block *sb)
>  
>  	lockdep_assert_held(&cgroup_mutex);
>  
> +	/*if @cgrp is being removed, procs_file may already be gone */
> +	if (!cgrp->procs_file.kn)
> +		return -ENODEV;
> +
>  	inode = kernfs_get_inode(sb, cgrp->procs_file.kn);
>  	if (!inode)
>  		return -ENOMEM;

I had syzbot hit the same crash here and as can be seen from the
reproducer the root cause is that the target cgroup (specified
via CLONE_INTO_CGROUP) is a version 1 cgroup. These cgroups just
don't initialize ->procs_file.kn.

This is a regression from v6.0 caused by 

   f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")   

Unless we want to revert this patch the correct fix might be
something like this:

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f487c54a0087..67474b1ae087 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6249,6 +6249,11 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 		goto err;
 	}
 
+	if (!cgroup_on_dfl(dst_cgrp)) {
+		ret = -EBADF;
+		goto err;
+	}
+
 	if (cgroup_is_dead(dst_cgrp)) {
 		ret = -ENODEV;
 		goto err;


For reference: This is the reproducer produces by syzbot here:
| r0 = fsopen(&(0x7f0000000040)='cpuset\x00', 0x0)
| fsconfig$FSCONFIG_CMD_CREATE(r0, 0x6, 0x0, 0x0, 0x0)
| r1 = fsmount(r0, 0x0, 0x0)
| syz_clone3(&(0x7f00000009c0)={0x244000700, 0x0, 0x0, 0x0, {}, 0x0, 0x0, 0x0, 0x0, 0x0, {r1}}, 0x58)

The crash is 100% reproducible on every single run, i.e. not a
deletion race or similar.

     regards   Christian

> 
> 
> On Tue, Oct 04, 2022 at 07:19:34PM -0700, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    0326074ff465 Merge tag 'net-next-6.1' of git://git.kernel...
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=149c92cc880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e1de7ca9efcc028c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=534ee3d24c37c411f37f
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10af2492880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104874f0880000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/43729d6ce2fc/disk-0326074f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/1f76d6f68eb3/vmlinux-0326074f.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com
> > 
> > general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
> > CPU: 1 PID: 3617 Comm: syz-executor384 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> > RIP: 0010:kernfs_ino include/linux/kernfs.h:358 [inline]
> > RIP: 0010:kernfs_get_inode+0x2e/0x520 fs/kernfs/inode.c:254
> > Code: 41 56 41 55 41 54 49 89 fc 53 48 89 f3 e8 1a 04 7e ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 3a 04 00 00 48 8b b3 90 00 00 00 4c 89 e7 e8 79
> > RSP: 0018:ffffc90003c8fa30 EFLAGS: 00010206
> > RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: 0000000000000012 RSI: ffffffff81fd1156 RDI: 0000000000000090
> > RBP: ffffc90003c8fa50 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000001 R11: 0000000000000024 R12: ffff8880224ba000
> > R13: ffff888075922000 R14: ffff88801ebf0000 R15: ffff8880211ae000
> > FS:  0000555556907300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000200 CR3: 000000001c179000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  cgroup_may_write+0x86/0x120 kernel/cgroup/cgroup.c:4937
> >  cgroup_css_set_fork kernel/cgroup/cgroup.c:6237 [inline]
> >  cgroup_can_fork+0x961/0xec0 kernel/cgroup/cgroup.c:6331
> >  copy_process+0x43ed/0x7090 kernel/fork.c:2358
> >  kernel_clone+0xe7/0xab0 kernel/fork.c:2671
> >  __do_sys_clone3+0x1cd/0x2e0 kernel/fork.c:2963
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f621d8c3e99
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffcaa952ec8 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f621d8c3e99
> > RDX: 0000000000000000 RSI: 0000000000000058 RDI: 00007ffcaa952f40
> > RBP: 0000000000000000 R08: 00007ffcaa952d60 R09: 00007ffcaa952ef0
> > R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffcaa952eec
> > R13: 00007ffcaa952f00 R14: 00007ffcaa952f40 R15: 0000000000000000
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:kernfs_ino include/linux/kernfs.h:358 [inline]
> > RIP: 0010:kernfs_get_inode+0x2e/0x520 fs/kernfs/inode.c:254
> > Code: 41 56 41 55 41 54 49 89 fc 53 48 89 f3 e8 1a 04 7e ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 3a 04 00 00 48 8b b3 90 00 00 00 4c 89 e7 e8 79
> > RSP: 0018:ffffc90003c8fa30 EFLAGS: 00010206
> > RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: 0000000000000012 RSI: ffffffff81fd1156 RDI: 0000000000000090
> > RBP: ffffc90003c8fa50 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000001 R11: 0000000000000024 R12: ffff8880224ba000
> > R13: ffff888075922000 R14: ffff88801ebf0000 R15: ffff8880211ae000
> > FS:  0000555556907300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ffcaa9cb8f0 CR3: 000000001c179000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >    0:	41 56                	push   %r14
> >    2:	41 55                	push   %r13
> >    4:	41 54                	push   %r12
> >    6:	49 89 fc             	mov    %rdi,%r12
> >    9:	53                   	push   %rbx
> >    a:	48 89 f3             	mov    %rsi,%rbx
> >    d:	e8 1a 04 7e ff       	callq  0xff7e042c
> >   12:	48 8d bb 90 00 00 00 	lea    0x90(%rbx),%rdi
> >   19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
> >   20:	fc ff df
> >   23:	48 89 fa             	mov    %rdi,%rdx
> >   26:	48 c1 ea 03          	shr    $0x3,%rdx
> > * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
> >   2e:	0f 85 3a 04 00 00    	jne    0x46e
> >   34:	48 8b b3 90 00 00 00 	mov    0x90(%rbx),%rsi
> >   3b:	4c 89 e7             	mov    %r12,%rdi
> >   3e:	e8                   	.byte 0xe8
> >   3f:	79                   	.byte 0x79
> > 
> 
> -- 
> tejun
