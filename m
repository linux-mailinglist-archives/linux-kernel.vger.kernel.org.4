Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB535F23FA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJBQCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJBQCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:02:47 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC3223142;
        Sun,  2 Oct 2022 09:02:46 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id w139so283553vkw.7;
        Sun, 02 Oct 2022 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6FhDfSROWelbkoJYn4OyQgnyoM7fZOIVUxp2qTofRC0=;
        b=YWZBhmVQASMOFsOXDvbtNlfDQ53Z/evG03Zh6H6/qyo6yjZ+iRPykhwDbavGunWKgQ
         Rw62i6p3KmmUCRnegaSUfbgTqQ+opspf46Bk0OVBGLU+yLu2FM51dQvGZSwzKtYC449K
         7q1nOgKt3zAjJKgS6Z6YhQZkUAuvPPH042TVuASxFqC1cFrl/fkgR1ka7pGSRx20s/HD
         51q3leGi84OOGfmJjfzOjlLUdUf3s3OFiGG+PmL+44zL8I7B22z8IWYow5AVCI5IRUUY
         plsVrQODlf+BO8UTkVhxQddqUw5hxr4UMpe5pc3Xy2sy6dG1rfLqTqaA+dqXn8FUFsVe
         lKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6FhDfSROWelbkoJYn4OyQgnyoM7fZOIVUxp2qTofRC0=;
        b=qLREgKhyqOdiXAxVGPDBBhPsq2PPjN4fOcza8ie4ccikz15kkLjEc3bBwvwkBDB4sw
         F0aJDuEU5f2tpCIfTlVi1FjWVOk7Nc/tScUXAA5LIlo3xemuC4fmdoPZW/wZ9UkTc46Z
         1+Ola5KuiTsS7p3makmmaz6g5Rw29fRR35zOjTft7dE5cct0uQ0XcvTAkjfgrfeP6hUZ
         ifhNEqanndbpzfQYQvbhLzCdTlESIUSXYO9oH0pfWSExagKSsAnUyduaYo8YHcb2IThI
         3YlF/yJGMiAQYnhV5Pk0eJelPUGXqloP5iWOPrckkU/yFbU30gv2soi+smHxXdVUCUlk
         uaAA==
X-Gm-Message-State: ACrzQf3eAb7xuWo4afmdvDaHcTovTU3m2Nj1XEOUpC7YS8qVgSYsyl6K
        j/JK9vZaSpWGtt78CdxVE7bcga6ihRlSt+tiQ+4=
X-Google-Smtp-Source: AMsMyM48ATUgV5Gl/4jDCBSDOz7V6DJ5WbdW/gQ9bRVryrjolzPirU70DlinT8d3bXU+0p7UsrGWzACqHJFA0zPGmeo=
X-Received: by 2002:a05:6122:1814:b0:3a9:d454:de85 with SMTP id
 ay20-20020a056122181400b003a9d454de85mr1761744vkb.23.1664726564899; Sun, 02
 Oct 2022 09:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae7bd605e9f95a47@google.com>
In-Reply-To: <000000000000ae7bd605e9f95a47@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 3 Oct 2022 01:02:28 +0900
Message-ID: <CAKFNMom=r+9taXjz-TGWxatPwJz2Y+P5JOA3gaoLqgNfTf8VCQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING: refcount bug in nilfs_put_root
To:     syzbot <syzbot+7b6d672e5810fec9e6eb@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 1, 2022 at 10:47 PM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=13ef3998880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aae2d21e7dd80684
> dashboard link: https://syzkaller.appspot.com/bug?extid=7b6d672e5810fec9e6eb
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145c7a1f080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c843ef080000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/11078f50b80b/disk-bbed346d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/398e5f1e6c84/vmlinux-bbed346d.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7b6d672e5810fec9e6eb@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 2048
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 1 PID: 3038 at lib/refcount.c:87 refcount_dec_and_lock+0x180/0x1ec lib/refcount.c:146
> Modules linked in:
> CPU: 1 PID: 3038 Comm: syz-executor274 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : refcount_dec_and_lock+0x180/0x1ec lib/refcount.c:146
> lr : refcount_dec_not_one lib/refcount.c:87 [inline]
> lr : refcount_dec_and_lock+0x17c/0x1ec lib/refcount.c:146
> sp : ffff800012893a30
> x29: ffff800012893a30 x28: ffff80000cc15042 x27: ffff0000cc376640
> x26: 0000000000000002 x25: 00000000ffffffff x24: 0000000000000000
> x23: 00000000c0000000 x22: 0000000000000000 x21: ffff80000d5eb4a0
> x20: ffff0000cc2b5520 x19: ffff80000d8c8000 x18: 00000000000000c0
> x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c7128000
> x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c7128000
> x11: ff808000081c0d5c x10: 0000000000000000 x9 : 7c5041a976250900
> x8 : 7c5041a976250900 x7 : ffff80000819545c x6 : 0000000000000000
> x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000000
> Call trace:
>  refcount_dec_and_lock+0x180/0x1ec lib/refcount.c:146
>  nilfs_put_root+0x30/0x80 fs/nilfs2/the_nilfs.c:797
>  nilfs_segctor_destroy fs/nilfs2/segment.c:2747 [inline]
>  nilfs_detach_log_writer+0x3b8/0x4d0 fs/nilfs2/segment.c:2810
>  nilfs_put_super+0x28/0x9c fs/nilfs2/super.c:468
>  generic_shutdown_super+0x8c/0x190 fs/super.c:491
>  kill_block_super+0x30/0x78 fs/super.c:1427
>  deactivate_locked_super+0x70/0xe8 fs/super.c:332
>  deactivate_super+0xd0/0xd4 fs/super.c:363
>  cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
>  __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
>  task_work_run+0xc4/0x14c kernel/task_work.c:177
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0x26c/0xbe0 kernel/exit.c:795
>  do_group_exit+0x60/0xe8 kernel/exit.c:925
>  __do_sys_exit_group kernel/exit.c:936 [inline]
>  __se_sys_exit_group kernel/exit.c:934 [inline]
>  __wake_up_parent+0x0/0x40 kernel/exit.c:934
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
>  el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
> irq event stamp: 9228
> hardirqs last  enabled at (9227): [<ffff8000081befc8>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
> hardirqs last disabled at (9228): [<ffff80000bfb5fbc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:404
> softirqs last  enabled at (7974): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (7972): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz dup: KASAN: use-after-free Read in nilfs_segctor_confirm

Based on the analysis so far, this issue is due to the same cause as
the issue above.

Ryusuke Konishi
