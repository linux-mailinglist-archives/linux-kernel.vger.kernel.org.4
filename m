Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B755FD597
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJMHi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJMHix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:38:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17A122BCB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:38:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c20so1287251ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JeTU9g7DODs0OvPIoiZ5PWNJ3O2Vyb2ZIWCixOTK2bU=;
        b=fPQ9G05JalHFCVNyHNj4ZYEBAWJBPGcXqWiPKAT62Yw27sqEnyb5rH6nhH5+hMJfU3
         9P9e74oVgEnlFmbnkZ8aw00g/zKVg/sRvA3y7YCeaBBbRBK+L8NWobeODTUiZTM6w/Xp
         Ny34lZuZbgX5bltDphH6dPPUKNs97EHfFltXfowPEtr0fsYlkNlms0AbTcBX/5mJNiQf
         dzfwJ/GPdgF3toU6TmZ+X+YhGi01uZipyX/R77Lt3pXexvAQemXf8iLNBQUQyln4qC++
         awDdp9G/rZATcghHWWGOu3PSf/SKpCuZN/dB/KvIvGgxsl4JAnLS+BckXAHKpTb3IFgr
         4hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeTU9g7DODs0OvPIoiZ5PWNJ3O2Vyb2ZIWCixOTK2bU=;
        b=AbXvQ+2BenUBSxCmaG3Oy5LTJy4C892zt1aA/o5ymAAC/9M33qXAF4RY6x+sNl4M8e
         LktCRbF9FSBfhMQC0HG/dZDWhw7KvaZOT68e+En49eVmI+yD+KgJ9HccI4g9apyeQlsm
         T4+M88VbLoUQYq3IIUfudxszV0Yt5qPZrP0rfQqDAM+w91PhMOjZp+tgyBvjFgu/PwYW
         rwkuw6Ipnf5ZErGqRuLITjWLHyH5VtnoaiMxUVrxuLBcPFlvnurK4ISWZ5s8G6X+aeKZ
         hV5bcE/Nk4PWAkWh1ioJkqgSKDFFeLH4jThe2og8lUXjA6DYgZcHZ4so+UrJD8DqhorR
         w2NQ==
X-Gm-Message-State: ACrzQf170RARq2VjoEMQrGtYBRsz2NC5P6toIcLgp+LkIXZxMxPyjH6/
        OZIvvFUFGlQYrsS99ylKaNPmQmM7MeQLitXPsxbV0A==
X-Google-Smtp-Source: AMsMyM4vZL5B+eJo77MkwWxzCAnN7Qkp3w2XEGNKeO6OUhD9QagElyBIqQWvHKQq+mzMwdr7aYRlM8lcIOUcjJzg7mk=
X-Received: by 2002:a2e:978e:0:b0:26e:8ad6:6d5b with SMTP id
 y14-20020a2e978e000000b0026e8ad66d5bmr10536991lji.363.1665646730714; Thu, 13
 Oct 2022 00:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002b89b205ead703ff@google.com> <Y0cEQbWsy7XAkyVZ@slm.duckdns.org>
In-Reply-To: <Y0cEQbWsy7XAkyVZ@slm.duckdns.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Oct 2022 09:38:37 +0200
Message-ID: <CACT4Y+Z9ku-uZVGvAwDD9ajr3Sx_KQHmc5hRUOB0_S2Ctj_=+w@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in kernfs_walk_and_get_ns
To:     Tejun Heo <tj@kernel.org>
Cc:     syzbot <syzbot+9baaae5fc5795e2e6acf@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 12 Oct 2022 at 20:30, Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Oct 12, 2022 at 07:14:35AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    282342f2dc97 Add linux-next specific files for 20220830
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=14b47c63080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c7b70bd555c649f4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9baaae5fc5795e2e6acf
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12acb375080000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1718658b080000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9baaae5fc5795e2e6acf@syzkaller.appspotmail.com
> >
> > BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1498
> > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 3603, name: syz-executor323
> > preempt_count: 1, expected: 0
> > RCU nest depth: 0, expected: 0
> > INFO: lockdep is turned off.
> > irq event stamp: 0
> > hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > hardirqs last disabled at (0): [<ffffffff814710e0>] copy_process+0x20f0/0x7120 kernel/fork.c:2199
> > softirqs last  enabled at (0): [<ffffffff81471128>] copy_process+0x2138/0x7120 kernel/fork.c:2203
> > softirqs last disabled at (0): [<0000000000000000>] 0x0
> > Preemption disabled at:
> > [<0000000000000000>] 0x0
> > CPU: 1 PID: 3603 Comm: syz-executor323 Not tainted 6.0.0-rc3-next-20220830-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9896
> >  down_read+0x71/0x450 kernel/locking/rwsem.c:1498
> >  kernfs_walk_and_get_ns+0xcc/0x3a0 fs/kernfs/dir.c:897
> >  kernfs_walk_and_get include/linux/kernfs.h:600 [inline]
> >  cgroup_get_from_path+0x61/0x610 kernel/cgroup/cgroup.c:6647
>
> The fix for this one is already queued in cgroup/for-6.1-fixes. Will send
> that to linus once rc1 drops.

Hi Tejun,

What is the fix?
syzbot needs it to close the bug and report similarly looking issues in future.
