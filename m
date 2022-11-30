Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8616D63D2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiK3KH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiK3KHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:07:48 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BB0DE8A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:07:46 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id p24-20020a0568301d5800b0066e6dc09be5so271481oth.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlVRdvDiWaoVHZ8Thwgk3ZajGBWkmHbpNIGvhArZOPo=;
        b=aAfYo32bgjBlQ5xnrWc1O0UKCMyjI/dc8WbCWKqZGP1jUZmVimyS7Vf+D0AXor/O+s
         BfwSqLmL+fgX7V+raQpkWAzNZASvtkVvjkOFKZQeUrGLQNtZjGsAMWOI8a6Pu4kn/MwB
         U/gQMvACKzzq3+OG1O98z/tqFrVdIoobVEMwmxcVbSLHx63luXI+Tn+KKIOvLD3HJMvd
         OzoqIXuZhr/kjikPjcDQcxAl4J3HigzGKxcIUYdpJDQOTPAZxEtGef4ZwczEnxhdpPox
         RvB72oXq+gjqGaKe9ujeM9S4ASFILbWwLGjPg+wkxC+yieiLOU+TelQ86Rl3hLU8rFbv
         yG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlVRdvDiWaoVHZ8Thwgk3ZajGBWkmHbpNIGvhArZOPo=;
        b=s6wr4CvVuVqmqVYvjIjY2/WPYTIg8lKHQ5TFphPgBMs2PmlkbrkC+vOoEPGAa9gtl7
         owBY9x7qvPlS4mIet8g3H++iNlxmTwXSmTE9Ect0mpJaR7RdG6AURhz6KMckw/j6AE83
         5SKeORCkwpr1D/bVc9NwAK1NR9L7/SKSx4iuZ66qu0WrTwYUJLkwsw0JPCMLfajV5km3
         S56h5Cy/05yPxRs886YXn5+EwGhRF2fquC6+GicikeH7W47pudq+mr7izSfXokgnqkOP
         JBeBX8EJDdXejeaAxwZ56/NBP84WTqL/NP6/c+w9yqauhPdEMV/RaUk/TQLzQZUwNZoW
         qhvQ==
X-Gm-Message-State: ANoB5plAYqqwy8g6EKqrUBTxf7h12Y9mx39biO+Zrq7AWoHOEMR267uS
        jFxtKUGIZ4YEurskNs+7bJaByrUZRhYxax1rKmJ01g==
X-Google-Smtp-Source: AA0mqf4IGBP/4wLP5cvORwjJUFOdd8YIYkfzj0KNKsm89a74fUFvqocp1sL6rpac1LLftMErY71RT2FuDJ77EimtOYw=
X-Received: by 2002:a05:6830:1b62:b0:66c:7982:2d45 with SMTP id
 d2-20020a0568301b6200b0066c79822d45mr19944892ote.123.1669802865832; Wed, 30
 Nov 2022 02:07:45 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d482ba05ee97d4e3@google.com> <cd4158d0-bfc0-099c-c914-4889eaf95036@huawei.com>
In-Reply-To: <cd4158d0-bfc0-099c-c914-4889eaf95036@huawei.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 30 Nov 2022 11:07:35 +0100
Message-ID: <CACT4Y+Ybj2+5vRw+dGLwZz9i8BV95wRKkumvEGU3nUdWEZTm9w@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in gfs2_gl_hash_clear (3)
To:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc:     syzbot <syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com>,
        brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        madvenka@linux.microsoft.com, scott@os.amperecomputing.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org,
        "liwei (GF)" <liwei391@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 at 11:03, 'Wangshaobo (bobo)' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> Fix missing call gfs2_make_fs_ro() int gfs2_put_super()
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git
>
> b7b275e60bcd
>
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -584,9 +584,7 @@ static void gfs2_put_super(struct super_block *sb)
>          }
>          spin_unlock(&sdp->sd_jindex_spin);
>
> -       if (!sb_rdonly(sb)) {
> -               gfs2_make_fs_ro(sdp);
> -       }
> +       gfs2_make_fs_ro(sdp);
>          WARN_ON(gfs2_withdrawing(sdp));
>
>          /*  At this point, we're through modifying the disk  */
> --

Hi Wangshaobo,

Note the patch is corrupted. You probably posted via the web interface
and it removed some whitespaces. You either need to post via a client
that does not mess with whitespaces, or attach the patch as a file.

> =E5=9C=A8 2022/11/29 16:32, syzbot =E5=86=99=E9=81=93:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kern=
elci
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/lin=
ux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D167aebbb880=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D54b747d981a=
cc7b7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Ded7d0f71a89e2=
8557a77
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2=
da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D164673538=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D168c3d03880=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/d75f5f77b3a3/d=
isk-6d464646.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/9382f86e4d95/vmli=
nux-6d464646.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/cf2b5f0d51dd=
/Image-6d464646.gz.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/04ef2213=
0add/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com
> >
> > INFO: task syz-executor888:3126 blocked for more than 143 seconds.
> >        Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
> > task:syz-executor888 state:D stack:0     pid:3126  ppid:3124   flags:0x=
00000000
> > Call trace:
> >   __switch_to+0x180/0x298 arch/arm64/kernel/process.c:553
> >   context_switch kernel/sched/core.c:5209 [inline]
> >   __schedule+0x408/0x594 kernel/sched/core.c:6521
> >   schedule+0x64/0xa4 kernel/sched/core.c:6597
> >   schedule_timeout+0x108/0x1b4 kernel/time/timer.c:1935
> >   gfs2_gl_hash_clear+0xd4/0x1b0 fs/gfs2/glock.c:2263
> >   gfs2_put_super+0x318/0x390 fs/gfs2/super.c:620
> >   generic_shutdown_super+0x94/0x198 fs/super.c:492
> >   kill_block_super+0x30/0x78 fs/super.c:1428
> >   gfs2_kill_sb+0x68/0x78
> >   deactivate_locked_super+0x70/0xe8 fs/super.c:332
> >   deactivate_super+0xd0/0xd4 fs/super.c:363
> >   cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
> >   __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
> >   task_work_run+0x100/0x148 kernel/task_work.c:179
> >   resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> >   do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
> >   prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inlin=
e]
> >   exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
> >   el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
> >   el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
> >   el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
> >
> > Showing all locks held in the system:
> > 1 lock held by rcu_tasks_kthre/11:
> >   #0: ffff80000d4a4768 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_=
tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
> > 1 lock held by rcu_tasks_trace/12:
> >   #0: ffff80000d4a4db8 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at=
: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
> > 1 lock held by khungtaskd/27:
> >   #0: ffff80000d4a4640 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquir=
e+0x4/0x48 include/linux/rcupdate.h:303
> > 2 locks held by getty/2759:
> >   #0: ffff0000c7d7e098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref=
_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
> >   #1: ffff80000f6be2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tt=
y_read+0x19c/0x89c drivers/tty/n_tty.c:2177
> > 1 lock held by syz-executor888/3126:
> >   #0: ffff0000cae680e0 (&type->s_umount_key#41){+.+.}-{3:3}, at: deacti=
vate_super+0xc8/0xd4 fs/super.c:362
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> >
> > .
> >
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/cd4158d0-bfc0-099c-c914-4889eaf95036%40huawei.com.
