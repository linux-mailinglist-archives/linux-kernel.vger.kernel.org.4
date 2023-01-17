Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F3B66D440
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjAQCZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjAQCZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:25:17 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E8423DB7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:25:16 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id k7-20020a056e02156700b0030f025aeca3so3070896ilu.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akdLHauNdr8pjJDaxuTYeV8CfYSNE8Mipw5+gZJ8v3k=;
        b=Q6hwP/E6Y0RupOioOUmi+RmS3VYA9xt+Ej2m5IDskh/DojMwfGD0eJif0jwNjH1e0s
         s5rkqzTAgff8ZY0TvZT6NHs7TqamohiL7npd4bl0MNVYQ+1BV1Y6hT7DRs97Lf8PjW4+
         3/wzyNYTlns7o3lkDfxXsyG+BjnP2U3/9EIQW0CdLThMhLnytdimAuNcFAFblRIm6QWV
         0HsUTnTq+7/gk/U0Q4JiTWXPtHH1rMlBoLhrmHIhe1nS/SaEAI7OT/EKyF3BYEfsMDvD
         R8z6etIi0LlF/jaQ+DYVasRT9uOneKIXr74gZzJlMO0byIh3zaIYByWgjXHpU1o+PvtS
         5gOA==
X-Gm-Message-State: AFqh2kpWTvHQ4jC67vETX0uvZHg6f5fUfZKmd2xRp8ylpj8zcz6lNcZ8
        OQqi7Cu8aTJlxapLanrm+sU9OPpZIInd3+5zOoK26SOHw5Sg
X-Google-Smtp-Source: AMrXdXsOmMkVSB/fBreXL3EX4W3TgKbt8fDj13/yzTGb4IjFn24kmSqFIPsbqsNWYZuOd5Zr/Gi9rFalH+nYEFz002Z6vNueLbmi
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4199:b0:363:ae32:346f with SMTP id
 az25-20020a056638419900b00363ae32346fmr110217jab.31.1673922316166; Mon, 16
 Jan 2023 18:25:16 -0800 (PST)
Date:   Mon, 16 Jan 2023 18:25:16 -0800
In-Reply-To: <20230117004337.2132-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000096b8305f26c6981@google.com>
Subject: Re: [syzbot] possible deadlock in lapb_disconnect_request
From:   syzbot <syzbot+c9450e09c6b15886782c@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: MAX_LOCKDEP_CHAINS too low!

BUG: MAX_LOCKDEP_CHAINS too low!
turning off the locking correctness validator.
CPU: 0 PID: 5160 Comm: kworker/u4:6 Not tainted 6.2.0-rc3-syzkaller-00017-g358a161a6a9e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: bond594 bond_netdev_notify_work
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 lookup_chain_cache_add kernel/locking/lockdep.c:3778 [inline]
 validate_chain kernel/locking/lockdep.c:3799 [inline]
 __lock_acquire+0xf2c/0x3084 kernel/locking/lockdep.c:5055
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x6c/0xb4 kernel/locking/spinlock.c:162
 debug_object_activate+0x6c/0x30c lib/debugobjects.c:665
 debug_timer_activate kernel/time/timer.c:782 [inline]
 __mod_timer+0x534/0x700 kernel/time/timer.c:1119
 add_timer+0x34/0x50 kernel/time/timer.c:1244
 __queue_delayed_work kernel/workqueue.c:1676 [inline]
 queue_delayed_work_on+0x130/0x240 kernel/workqueue.c:1701
 queue_delayed_work include/linux/workqueue.h:518 [inline]
 bond_netdev_notify_work+0xc8/0xf4 drivers/net/bonding/bond_main.c:1743
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863


Tested on:

commit:         358a161a Merge branch 'for-next/fixes' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17830e7e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2573056c6a11f00d
dashboard link: https://syzkaller.appspot.com/bug?extid=c9450e09c6b15886782c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161144da480000

