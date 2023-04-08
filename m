Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3B6DB822
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 04:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDHCSX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Apr 2023 22:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDHCSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 22:18:22 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D56CC1F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 19:18:19 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id u6-20020a926006000000b003232594207dso286525ilb.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 19:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680920299; x=1683512299;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SIGsaPEVbwjdBXWew8mB+KLOEyXGltP5ug92i+dvdE=;
        b=WpxdqCtqXybyV/la3ri5xjnUwXzmzaMj6IEvmDXT+Pd6djg9fabRrxWoCn2zxSPWl9
         HIv2p5n8o/ZiqXo8bbJlJxEqUjwaLvWFqxKlXp8cfHn39rExgumhoq1VehqmXt0QOSKh
         zoLt+qpBxb0jUm5sk29gHKD5c/D3g279poaPggkPyqBfC8tURUdm9yhzBhWJt52Eeg67
         48+ECd4ptc0eNUv5Bpkxiy2afzpJuUsOrichSjeOchRR1KnujAfNY1woqoaU678jodRo
         gVJnlcM7N8+YHgMCW5xEgaevxEw4h1KlcTbL5WY73mDqUBRakAsH4Iqf1e0htzbpSIJI
         92gA==
X-Gm-Message-State: AAQBX9dBD0KHUqpYE9v9w5Ql/6dtTTlNC2zNPtzVu+DHr9fg+s7NRByS
        J0T8fvzgFUopKq30QTlRt+3Mj4hbQn71wEttu/BMuO0FtU7G
X-Google-Smtp-Source: AKy350ZZi32JQitt9Kv7+J4DNcyP+kAVMh3UUiPitnRI76AreZL6RDGiMqp8rcQkHj5fxwtIJd9w4B3sYvt/r9NvWS2UzuEsCU6H
MIME-Version: 1.0
X-Received: by 2002:a05:6602:314d:b0:753:34e:2ee7 with SMTP id
 m13-20020a056602314d00b00753034e2ee7mr221371ioy.0.1680920299256; Fri, 07 Apr
 2023 19:18:19 -0700 (PDT)
Date:   Fri, 07 Apr 2023 19:18:19 -0700
In-Reply-To: <20230408020425.1227-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055425605f8c9c142@google.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (2)
From:   syzbot <syzbot+7e1e1bdb852961150198@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=2.3 required=5.0 tests=FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

_sys_unshare+0x31/0x40
[   60.089065][ T5080]  do_syscall_64+0x39/0xb0
[   60.093476][ T5080]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.099416][ T5080] leaked reference.
[   60.103225][ T5080]  sk_alloc+0x717/0x7f0
[   60.107391][ T5080]  __netlink_create+0x63/0x380
[   60.112349][ T5080]  __netlink_kernel_create+0x114/0x860
[   60.117843][ T5080]  crypto_netlink_init+0x9c/0x120
[   60.122881][ T5080]  ops_init+0xb9/0x6b0
[   60.126951][ T5080]  setup_net+0x5d1/0xc50
[   60.131198][ T5080]  copy_net_ns+0x4ef/0x990
[   60.135615][ T5080]  create_new_namespaces+0x3f6/0xb20
[   60.140898][ T5080]  unshare_nsproxy_namespaces+0xc1/0x1f0
[   60.146532][ T5080]  ksys_unshare+0x449/0x920
[   60.151164][ T5080]  __x64_sys_unshare+0x31/0x40
[   60.155969][ T5080]  do_syscall_64+0x39/0xb0
[   60.160406][ T5080]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.166329][ T5080] leaked reference.
[   60.170228][ T5080]  sk_alloc+0x717/0x7f0
[   60.174564][ T5080]  inet_create+0x399/0xfa0
[   60.179077][ T5080]  __sock_create+0x380/0x850
[   60.183859][ T5080]  inet_ctl_sock_create+0x8d/0x220
[   60.189007][ T5080]  igmp_net_init+0xd0/0x1b0
[   60.193561][ T5080]  ops_init+0xb9/0x6b0
[   60.197658][ T5080]  setup_net+0x5d1/0xc50
[   60.201917][ T5080]  copy_net_ns+0x4ef/0x990
[   60.206779][ T5080]  create_new_namespaces+0x3f6/0xb20
[   60.212172][ T5080]  unshare_nsproxy_namespaces+0xc1/0x1f0
[   60.217901][ T5080]  ksys_unshare+0x449/0x920
[   60.222502][ T5080]  __x64_sys_unshare+0x31/0x40
[   60.227420][ T5080]  do_syscall_64+0x39/0xb0
[   60.232021][ T5080]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.238038][ T5080] leaked reference.
[   60.241836][ T5080]  sk_alloc+0x717/0x7f0
[   60.246001][ T5080]  __netlink_create+0x63/0x380
[   60.250780][ T5080]  __netlink_kernel_create+0x114/0x860
[   60.256275][ T5080]  fib_net_init+0x21b/0x3c0
[   60.260822][ T5080]  ops_init+0xb9/0x6b0
[   60.264991][ T5080]  setup_net+0x5d1/0xc50
[   60.269240][ T5080]  copy_net_ns+0x4ef/0x990
[   60.273676][ T5080]  create_new_namespaces+0x3f6/0xb20
[   60.278962][ T5080]  unshare_nsproxy_namespaces+0xc1/0x1f0
[   60.284599][ T5080]  ksys_unshare+0x449/0x920
[   60.289103][ T5080]  __x64_sys_unshare+0x31/0x40
[   60.294136][ T5080]  do_syscall_64+0x39/0xb0
[   60.298561][ T5080]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.304582][ T5080] leaked reference.
[   60.308472][ T5080]  sk_alloc+0x717/0x7f0
[   60.312637][ T5080]  __netlink_create+0x63/0x380
[   60.317502][ T5080]  __netlink_kernel_create+0x114/0x860
[   60.323005][ T5080]  uevent_net_init+0xfb/0x360
[   60.327693][ T5080]  ops_init+0xb9/0x6b0
[   60.331776][ T5080]  setup_net+0x5d1/0xc50
[   60.336670][ T5080]  copy_net_ns+0x4ef/0x990
[   60.341169][ T5080]  create_new_namespaces+0x3f6/0xb20
[   60.346653][ T5080]  unshare_nsproxy_namespaces+0xc1/0x1f0
[   60.352347][ T5080]  ksys_unshare+0x449/0x920
[   60.356956][ T5080]  __x64_sys_unshare+0x31/0x40
[   60.361933][ T5080]  do_syscall_64+0x39/0xb0
[   60.366386][ T5080]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.372606][ T5080] leaked reference.
[   60.376436][ T5080]  sk_alloc+0x717/0x7f0
[   60.380606][ T5080]  __netlink_create+0x63/0x380
[   60.385389][ T5080]  __netlink_kernel_create+0x114/0x860
[   60.390890][ T5080]  audit_net_init+0x1b8/0x450
[   60.395770][ T5080]  ops_init+0xb9/0x6b0
[   60.399934][ T5080]  setup_net+0x5d1/0xc50
[   60.404274][ T5080]  copy_net_ns+0x4ef/0x990
[   60.408698][ T5080]  create_new_namespaces+0x3f6/0xb20
[   60.413992][ T5080]  unshare_nsproxy_namespaces+0xc1/0x1f0
[   60.419761][ T5080]  ksys_unshare+0x449/0x920
[   60.424277][ T5080]  __x64_sys_unshare+0x31/0x40
[   60.429041][ T5080]  do_syscall_64+0x39/0xb0
[   60.433541][ T5080]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.439452][ T5080] leaked reference.
[   60.443257][ T5080]  sk_alloc+0x717/0x7f0
[   60.447508][ T5080]  __netlink_create+0x63/0x380
[   60.452281][ T5080]  __netlink_kernel_create+0x114/0x860
[   60.457852][ T5080]  genl_pernet_init+0xad/0x160
[   60.462721][ T5080]  ops_init+0xb9/0x6b0
[   60.466802][ T5080]  setup_net+0x5d1/0xc50
[   60.471096][ T5080]  copy_net_ns+0x4ef/0x990
[   60.475515][ T5080]  create_new_namespaces+0x3f6/0xb20
[   60.480816][ T5080]  unshare_nsproxy_namespaces+0xc1/0x1f0
[   60.486749][ T5080]  ksys_unshare+0x449/0x920
[   60.491259][ T5080]  __x64_sys_unshare+0x31/0x40
[   60.496026][ T5080]  do_syscall_64+0x39/0xb0
[   60.500447][ T5080]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.506359][ T5080] leaked reference.
[   60.510169][ T5080]  sk_alloc+0x717/0x7f0
[   60.514334][ T5080]  __netlink_create+0x63/0x380
[   60.519108][ T5080]  __netlink_kernel_create+0x114/0x860
[   60.524631][ T5080]  rtnetlink_net_init+0xbc/0x140
[   60.529576][ T5080]  ops_init+0xb9/0x6b0
[   60.533669][ T5080]  setup_net+0x5d1/0xc50
[   60.537917][ T5080]  copy_net_ns+0x4ef/0x990
[   60.542337][ T5080]  create_new_namespaces+0x3f6/0xb20
[   60.547624][ T5080]  unshare_nsproxy_namespaces+0xc1/0x1f0
[   60.553256][ T5080]  ksys_unshare+0x449/0x920
executing program
[   60.557763][ T5080]  __x64_sys_unshare+0x31/0x40
[   60.562564][ T5080]  do_syscall_64+0x39/0xb0
[   60.567064][ T5080]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.602770][ T5080] ------------[ cut here ]------------
[   60.608665][ T5080] WARNING: CPU: 0 PID: 5080 at lib/ref_tracker.c:39 ref_tracker_dir_exit+0x3a2/0x600
[   60.618219][ T5080] Modules linked in:
[   60.622147][ T5080] CPU: 0 PID: 5080 Comm: syz-executor.0 Not tainted 6.3.0-rc3-syzkaller-00148-gf33642224e38-dirty #0
[   60.633255][ T5080] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
[   60.643391][ T5080] RIP: 0010:ref_tracker_dir_exit+0x3a2/0x600
[   60.649568][ T5080] Code: 0f 84 c3 fe ff ff e8 2d 3d 44 fd 44 89 ff e8 c5 f9 ff ff e9 b1 fe ff ff e8 1b 3d 44 fd 48 8b 74 24 10 4c 89 ef e8 de 99 c6 05 <0f> 0b e8 07 3d 44 fd 49 8d 6d 44 be 04 00 00 00 48 89 ef e8 e6 4e
[   60.669510][ T5080] RSP: 0018:ffffc90003faf9c8 EFLAGS: 00010246
[   60.675617][ T5080] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
[   60.683768][ T5080] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000001
[   60.691917][ T5080] RBP: ffff888023b48210 R08: 0000000000000001 R09: 0000000000000001
[   60.699984][ T5080] R10: fffffbfff1cef7a2 R11: 0000000000094001 R12: ffff888023b48210
[   60.708199][ T5080] R13: ffff888023b481c0 R14: ffff888023b48210 R15: ffff88802a589e48
[   60.716273][ T5080] FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
[   60.725599][ T5080] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   60.732293][ T5080] CR2: 0000555559c04160 CR3: 0000000029c85000 CR4: 00000000003506f0
[   60.740532][ T5080] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   60.748686][ T5080] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   60.756820][ T5080] Call Trace:
[   60.760129][ T5080]  <TASK>
[   60.763123][ T5080]  __put_net+0x25/0x80
[   60.767379][ T5080]  __sk_destruct+0x60e/0x770
[   60.772271][ T5080]  __sk_free+0x175/0x460
[   60.776616][ T5080]  sk_free+0x7c/0xa0
[   60.780546][ T5080]  tun_chr_close+0x1df/0x240
[   60.785553][ T5080]  __fput+0x27c/0xa90
[   60.790245][ T5080]  ? __tun_detach+0x1400/0x1400
[   60.795309][ T5080]  task_work_run+0x16f/0x270
[   60.800935][ T5080]  ? task_work_cancel+0x30/0x30
[   60.806925][ T5080]  do_exit+0xad3/0x2960
[   60.811399][ T5080]  ? find_held_lock+0x2d/0x110
[   60.816301][ T5080]  ? get_signal+0x89d/0x25b0
[   60.821047][ T5080]  ? mm_update_next_owner+0x7b0/0x7b0
[   60.826545][ T5080]  ? do_raw_spin_lock+0x124/0x2b0
[   60.831705][ T5080]  ? spin_bug+0x1c0/0x1c0
[   60.836578][ T5080]  do_group_exit+0xd4/0x2a0
[   60.841144][ T5080]  get_signal+0x2315/0x25b0
[   60.845750][ T5080]  ? lockdep_hardirqs_on+0x7d/0x100
[   60.851290][ T5080]  ? exit_signals+0x910/0x910
[   60.856012][ T5080]  ? slab_free_freelist_hook+0x8b/0x1c0
[   60.862100][ T5080]  ? putname+0x102/0x140
[   60.866524][ T5080]  arch_do_signal_or_restart+0x79/0x5c0
[   60.872130][ T5080]  ? get_sigframe_size+0x10/0x10
[   60.877309][ T5080]  ? putname+0x102/0x140
[   60.881790][ T5080]  ? __x64_sys_umount+0x118/0x190
[   60.887118][ T5080]  exit_to_user_mode_prepare+0x15f/0x250
[   60.892903][ T5080]  syscall_exit_to_user_mode+0x1d/0x50
[   60.898430][ T5080]  do_syscall_64+0x46/0xb0
[   60.902969][ T5080]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.909014][ T5080] RIP: 0033:0x7f669c08d567
[   60.913716][ T5080] Code: Unable to access opcode bytes at 0x7f669c08d53d.
[   60.920796][ T5080] RSP: 002b:00007fffe9735458 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[   60.929995][ T5080] RAX: fffffffffffffffe RBX: 0000000000000003 RCX: 00007f669c08d567
[   60.938218][ T5080] RDX: 00007fffe973552c RSI: 000000000000000a RDI: 00007fffe9735520
[   60.947047][ T5080] RBP: 00007fffe9735520 R08: 00000000ffffffff R09: 00007fffe97352f0
[   60.955920][ T5080] R10: 0000555555e11853 R11: 0000000000000246 R12: 00007f669c0e6b74
[   60.963947][ T5080] R13: 00007fffe97365e0 R14: 0000555555e11810 R15: 00007fffe9736620
[   60.972140][ T5080]  </TASK>
[   60.975349][ T5080] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   60.982626][ T5080] CPU: 0 PID: 5080 Comm: syz-executor.0 Not tainted 6.3.0-rc3-syzkaller-00148-gf33642224e38-dirty #0
[   60.993470][ T5080] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
[   61.003796][ T5080] Call Trace:
[   61.007088][ T5080]  <TASK>
[   61.010074][ T5080]  dump_stack_lvl+0xd9/0x150
[   61.014684][ T5080]  panic+0x688/0x730
[   61.018593][ T5080]  ? panic_smp_self_stop+0x90/0x90
[   61.024596][ T5080]  ? show_trace_log_lvl+0x285/0x390
[   61.030052][ T5080]  ? ref_tracker_dir_exit+0x3a2/0x600
[   61.035663][ T5080]  check_panic_on_warn+0xb1/0xc0
[   61.040823][ T5080]  __warn+0xf2/0x390
[   61.044735][ T5080]  ? ref_tracker_dir_exit+0x3a2/0x600
[   61.050157][ T5080]  report_bug+0x2da/0x500
[   61.054588][ T5080]  handle_bug+0x3c/0x70
[   61.058761][ T5080]  exc_invalid_op+0x18/0x50
[   61.063728][ T5080]  asm_exc_invalid_op+0x1a/0x20
[   61.068869][ T5080] RIP: 0010:ref_tracker_dir_exit+0x3a2/0x600
[   61.074898][ T5080] Code: 0f 84 c3 fe ff ff e8 2d 3d 44 fd 44 89 ff e8 c5 f9 ff ff e9 b1 fe ff ff e8 1b 3d 44 fd 48 8b 74 24 10 4c 89 ef e8 de 99 c6 05 <0f> 0b e8 07 3d 44 fd 49 8d 6d 44 be 04 00 00 00 48 89 ef e8 e6 4e
[   61.095761][ T5080] RSP: 0018:ffffc90003faf9c8 EFLAGS: 00010246
[   61.102393][ T5080] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
[   61.110743][ T5080] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000001
[   61.118811][ T5080] RBP: ffff888023b48210 R08: 0000000000000001 R09: 0000000000000001
[   61.126880][ T5080] R10: fffffbfff1cef7a2 R11: 0000000000094001 R12: ffff888023b48210
[   61.134870][ T5080] R13: ffff888023b481c0 R14: ffff888023b48210 R15: ffff88802a589e48
[   61.142890][ T5080]  ? ref_tracker_dir_exit+0x3a2/0x600
[   61.148312][ T5080]  __put_net+0x25/0x80
[   61.154592][ T5080]  __sk_destruct+0x60e/0x770
[   61.160017][ T5080]  __sk_free+0x175/0x460
[   61.164288][ T5080]  sk_free+0x7c/0xa0
[   61.168205][ T5080]  tun_chr_close+0x1df/0x240
[   61.172919][ T5080]  __fput+0x27c/0xa90
[   61.176933][ T5080]  ? __tun_detach+0x1400/0x1400
[   61.181840][ T5080]  task_work_run+0x16f/0x270
[   61.186646][ T5080]  ? task_work_cancel+0x30/0x30
[   61.192320][ T5080]  do_exit+0xad3/0x2960
[   61.196604][ T5080]  ? find_held_lock+0x2d/0x110
[   61.201576][ T5080]  ? get_signal+0x89d/0x25b0
[   61.206271][ T5080]  ? mm_update_next_owner+0x7b0/0x7b0
[   61.211670][ T5080]  ? do_raw_spin_lock+0x124/0x2b0
[   61.216712][ T5080]  ? spin_bug+0x1c0/0x1c0
[   61.221063][ T5080]  do_group_exit+0xd4/0x2a0
[   61.225601][ T5080]  get_signal+0x2315/0x25b0
[   61.230139][ T5080]  ? lockdep_hardirqs_on+0x7d/0x100
[   61.235376][ T5080]  ? exit_signals+0x910/0x910
[   61.240106][ T5080]  ? slab_free_freelist_hook+0x8b/0x1c0
[   61.245774][ T5080]  ? putname+0x102/0x140
[   61.250057][ T5080]  arch_do_signal_or_restart+0x79/0x5c0
[   61.255632][ T5080]  ? get_sigframe_size+0x10/0x10
[   61.260677][ T5080]  ? putname+0x102/0x140
[   61.264951][ T5080]  ? __x64_sys_umount+0x118/0x190
[   61.271995][ T5080]  exit_to_user_mode_prepare+0x15f/0x250
[   61.277824][ T5080]  syscall_exit_to_user_mode+0x1d/0x50
[   61.283329][ T5080]  do_syscall_64+0x46/0xb0
[   61.287765][ T5080]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   61.293679][ T5080] RIP: 0033:0x7f669c08d567
[   61.298195][ T5080] Code: Unable to access opcode bytes at 0x7f669c08d53d.
[   61.305479][ T5080] RSP: 002b:00007fffe9735458 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[   61.313908][ T5080] RAX: fffffffffffffffe RBX: 0000000000000003 RCX: 00007f669c08d567
[   61.321887][ T5080] RDX: 00007fffe973552c RSI: 000000000000000a RDI: 00007fffe9735520
[   61.329889][ T5080] RBP: 00007fffe9735520 R08: 00000000ffffffff R09: 00007fffe97352f0
[   61.337891][ T5080] R10: 0000555555e11853 R11: 0000000000000246 R12: 00007f669c0e6b74
[   61.345873][ T5080] R13: 00007fffe97365e0 R14: 0000555555e11810 R15: 00007fffe9736620
[   61.353876][ T5080]  </TASK>
[   61.357151][ T5080] Kernel Offset: disabled
[   61.361660][ T5080] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build737377994=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at fbf0499ac
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=fbf0499acc828df26995835e51d83c3a0117e716 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230324-165937'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=fbf0499acc828df26995835e51d83c3a0117e716 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230324-165937'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=fbf0499acc828df26995835e51d83c3a0117e716 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230324-165937'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"fbf0499acc828df26995835e51d83c3a0117e716\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=13254763c80000


Tested on:

commit:         f3364222 ptp_qoriq: fix memory leak in probe()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=7e1e1bdb852961150198
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14055c11c80000

