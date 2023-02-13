Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC5F693EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBMHc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBMHc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:32:27 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A94D517
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:32:25 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id q3-20020a5edb03000000b00725625524e5so7800009iop.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quj/8o7gTMSH+S+wTa1zjEbyVtT9EYHOFb83bFu8E1g=;
        b=WLfiOQfn7dkj1/NaPAZBxnC4tsgwnT9V+DoCenFU6DMQ4LSUsJhWDgiUwtVMFs4WaQ
         j1FIQCkf/hDdg4r/thUkMhsktrfpX0RL0Zdo1+c0qOyyiSoJMc2TePRMNyvWxIqxWr0q
         837Zi6ONmaUMCFH1aTuyd2klMDByqnveRSxZL+fTI+Kx2kT4ubFKpQw6m5Ucyc5Wi15i
         T3MrsWAD82L2t6tLOwPJC7026YqyPQTjZjtzEz/ClAVZ6UfYeLYg9Xf2i8sO1ZpXsYTa
         YiblRfIYJcNA5c9n0QNZXBqMKQ9XOGqbCU+iZt0Ff/UBaMCBXbsCmI5ugrEVUfdUhbpT
         oDTQ==
X-Gm-Message-State: AO0yUKXGZ6UliImtpFxBjgR00JfSc9m5Y8hQt2kJRN8x1kWKHGgEf5Kz
        H6hvjS73DOLQXPyI0rFAtLVfyEOn1grA4DYMLXgMX3+8fPVm
X-Google-Smtp-Source: AK7set91ScUm74tbttLJhTTiDPNTwirgV+qr+5SPp4I3IY4zM1LggDLslbYGTnHlWHUzrq20kjjaMjqAeT5d4UxW+pJWmCKjUUDT
MIME-Version: 1.0
X-Received: by 2002:a05:6638:ecb:b0:3ac:ca0a:6fdf with SMTP id
 q11-20020a0566380ecb00b003acca0a6fdfmr13231209jas.56.1676273545103; Sun, 12
 Feb 2023 23:32:25 -0800 (PST)
Date:   Sun, 12 Feb 2023 23:32:25 -0800
In-Reply-To: <20230213071422.2985-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033d42305f48fd97f@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in __timer_delete_sync
From:   syzbot <syzbot+1e164be619b690a43d79@syzkaller.appspotmail.com>
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
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for lo to become free. Usage count = 2
leaked reference.
 __netdev_tracker_alloc include/linux/netdevice.h:4039 [inline]
 netdev_hold include/linux/netdevice.h:4068 [inline]
 ipv6_add_dev+0x43e/0x1320 net/ipv6/addrconf.c:401
 addrconf_notify+0x61e/0x18c0 net/ipv6/addrconf.c:3552
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1945
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 register_netdevice+0xfb4/0x1640 net/core/dev.c:10084
 register_netdev+0x31/0x50 net/core/dev.c:10179
 loopback_net_init+0x7a/0x170 drivers/net/loopback.c:219
 ops_init+0xb9/0x670 net/core/net_namespace.c:135
 setup_net+0x793/0xe60 net/core/net_namespace.c:333
 copy_net_ns+0x31b/0x6b0 net/core/net_namespace.c:483
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc5/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x449/0x920 kernel/fork.c:3202
 __do_sys_unshare kernel/fork.c:3273 [inline]
 __se_sys_unshare kernel/fork.c:3271 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3271
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd


Tested on:

commit:         75da437a Merge branch '40GbE' of git://git.kernel.org/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16527cc7480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e5fc864153bbc8c
dashboard link: https://syzkaller.appspot.com/bug?extid=1e164be619b690a43d79
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10692a4f480000

