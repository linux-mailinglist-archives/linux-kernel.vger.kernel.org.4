Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF2631512
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 17:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKTQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 11:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiKTQE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 11:04:27 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE11EA5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 08:04:26 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id i131so11041203ybc.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 08:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=63KL2Saxfoi531hFptfQlVE1NeSUNbrmZNLZbGcmaxY=;
        b=BTEHfCYO4GwUrFkNHsTnE7XzHROm+8LVsAn2nQgWZLOib6kcL5YP6+oE0PfXHnuTUw
         6RkEoOliWVHmtzJg1crFqmrVKkxeYfZWKZvPmndibUDTbX8coRt4iUUiQsBmgr3eMv2z
         h14FmZ4QceXzeBw5wo7eS0Sq++q/lIxcWcO5bS4XHURsU/mTEIFcgu5H0m65kGiFaszQ
         rzVOK7LMNbSNvR52oTwW3Gj/c7bj7opiAOPiUWdEfBCaZCPdh/FO2sysYq8PA5C7YvLX
         otKChIOthp0rvPMSdK6MWG7HIrxQK72L7helMKV/dSx7NJaKQX8NQ3XQ5zm3wYsaksum
         GZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63KL2Saxfoi531hFptfQlVE1NeSUNbrmZNLZbGcmaxY=;
        b=H+kGMAL3dRAR5eb75P0RX6er6DQ//+bGdcHeQzeksjt1DPtzo7L6xONbxCTsmVoSK0
         gHBI5IAbHiHYwuaLDi0kRm2Ma8ObfkN6tcJ09DsOY+xHAFWZ99TU6BuXsttkoss/XrbP
         E1UGpUNQFLfcQRYibQ2KzTBooqp+0icme1NGXLwNJDotelW+or9CDd3uoMfqwxvTlR5s
         eX6j1dbA6mZR5bnKCjYWwOWONyeJJ4pfJsDvQHGQXY4ZMKcc4FdEe//faRnodxMUl35C
         1YmbbvuY/zwDqTDgKA8Y3gVp9HgXYSdVG24yzB7wZUtqcrKRuVDilo4+RadIinyL56IC
         zaRw==
X-Gm-Message-State: ANoB5pkC3Ne0akEEY1+RZtmfIPhk30zQRy0SBY3lX1wAkiiVsNiiEv6u
        FLdsK/xqwnZrOXE8zandtt9lKbUfCx11o1HFG7vsfQ==
X-Google-Smtp-Source: AA0mqf6K3o0mb0hd9Rd6/OPbQTHO4qrPuKzcvOlD6ReLl/K3P0vC3tVJMNh6UpBg4AJoNjI1BgF4H8664zHJsIhI/wI=
X-Received: by 2002:a25:348c:0:b0:6cb:ec87:a425 with SMTP id
 b134-20020a25348c000000b006cbec87a425mr12946602yba.387.1668960265640; Sun, 20
 Nov 2022 08:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20221120090213.922567-1-syoshida@redhat.com> <20221120104907.4795-1-hdanton@sina.com>
In-Reply-To: <20221120104907.4795-1-hdanton@sina.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 20 Nov 2022 08:04:13 -0800
Message-ID: <CANn89iJxiV_-g6n60aeA=mO=DYwGV9VdJswHP4pc-Vwq_UgrRA@mail.gmail.com>
Subject: Re: [PATCH v2] net: tun: Fix use-after-free in tun_detach()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Shigeru Yoshida <syoshida@redhat.com>, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+106f9b687cd64ee70cd1@syzkaller.appspotmail.com
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

On Sun, Nov 20, 2022 at 2:49 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On 20 Nov 2022 18:02:13 +0900 Shigeru Yoshida <syoshida@redhat.com>
> > syzbot reported use-after-free in tun_detach() [1].  This causes call
> > trace like below:
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in notifier_call_chain+0x1ee/0x200 kernel/notifier.c:75
> > Read of size 8 at addr ffff88807324e2a8 by task syz-executor.0/3673
> >
> > CPU: 0 PID: 3673 Comm: syz-executor.0 Not tainted 6.1.0-rc5-syzkaller-00044-gcc675d22e422 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
> >  print_address_description mm/kasan/report.c:284 [inline]
> >  print_report+0x15e/0x461 mm/kasan/report.c:395
> >  kasan_report+0xbf/0x1f0 mm/kasan/report.c:495
> >  notifier_call_chain+0x1ee/0x200 kernel/notifier.c:75
> >  call_netdevice_notifiers_info+0x86/0x130 net/core/dev.c:1942
> >  call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
> >  call_netdevice_notifiers net/core/dev.c:1997 [inline]
> >  netdev_wait_allrefs_any net/core/dev.c:10237 [inline]
> >  netdev_run_todo+0xbc6/0x1100 net/core/dev.c:10351
> >  tun_detach drivers/net/tun.c:704 [inline]
> >  tun_chr_close+0xe4/0x190 drivers/net/tun.c:3467
> >  __fput+0x27c/0xa90 fs/file_table.c:320
> >  task_work_run+0x16f/0x270 kernel/task_work.c:179
> >  exit_task_work include/linux/task_work.h:38 [inline]
> >  do_exit+0xb3d/0x2a30 kernel/exit.c:820
> >  do_group_exit+0xd4/0x2a0 kernel/exit.c:950
> >  get_signal+0x21b1/0x2440 kernel/signal.c:2858
> >  arch_do_signal_or_restart+0x86/0x2300 arch/x86/kernel/signal.c:869
> >  exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
> >  exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
> >  syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
> >  do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > The cause of the issue is that sock_put() from __tun_detach() drops
> > last reference count for struct net, and then notifier_call_chain()
> > from netdev_state_change() accesses that struct net.
>
> Correct. IOW the race between netdev_run_todo() and cleanup_net() is behind
> the uaf report from syzbot.
>
> >
> > This patch fixes the issue by calling sock_put() from tun_detach()
> > after all necessary accesses for the struct net has done.
>
> Thanks for your fix.
>
> But tun is not special wrt netdev_run_todo() and call_netdevice_notifiers(),
> so the correct fix should be making netdev grab another hold on net and
> invoking put_net() in the path of netdev_run_todo().

Well, this is not going to work. Unless I am missing something.

1) A netns is destroyed when its refcount reaches zero.

   if (refcount_dec_and_test(&net->ns.count))
        __put_net(net);

    This transition is final.

    (It is illegal to attempt a refcount_inc() from this state)

2) All its netdevices are unregistered.

   Trying to get a reference on netns in netdevice dismantle path
would immediately trigger a refcount_t warning.
