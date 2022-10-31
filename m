Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB26138E7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiJaOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiJaOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:24:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB54334
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:24:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k2so29876176ejr.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWsKN3Ad6ZzGIKX0q2VLbHKg6VVJ+gJtPDB9kbPfB/Y=;
        b=Hedv7/E/sAcu640NeWFMKl5BbgkDJBVWUrNyX9GO7+Hl4hRzBRdowm4vvCZkVklE54
         wrndXM0Mh4rnrODWice/gX268ehNbky2CJc+htnkhyJg6bPiqgxUIYV16o4iPYzyvbPe
         hVasGrQJIT+z8lM07kNeDobKUa+EsOijDuPUiu3jo0maRKbUgYZgbKp8kCaWFuebfcnU
         llgUTn/ayEMrjKWk+U5inGmAZCwYiOHX72mmo5napE8UxU5wLpVjKxlZ0Y3xrH8rD5s4
         uinSbuppC1+ZPml3ge90MOSbrvQXWkMUbiohpmjzalUePDyiwkp31Kgm62fRQrdu5hq7
         Ih8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWsKN3Ad6ZzGIKX0q2VLbHKg6VVJ+gJtPDB9kbPfB/Y=;
        b=YYa/wzGdr3CENECbaEZJMv2X+K9MsWXpmexGx1dhXUYQB4q3VwOC1HNl1Ye4rUKo4F
         fFwitPm9HAHV5xgJVAYBSiLVkAbjpi7bsGRdzHrzxYzbbSK+rnkFGTGpOPus2KgPg8f4
         UJREgE2eT5BZlcX5FOJq+xn5joUL20v8OxDftyYgMRl1HJjfe2QUwJlQ6zuMrXusl81Q
         wnlbVZo/T8jN/qZpHCsOEc2rq26PzPJUgc2VTdSkrhAfUMYOJS6ul1EtSuwzspXQ53e9
         Xp3MCigynWtbJSpWf7ocBg5sBLZX+KnGyVOSd9QijoMJGSfUc3yKfv/xiXCd8BfAjT15
         CDjw==
X-Gm-Message-State: ACrzQf2d/d4LqkY+luBVnvwWgNetG8jxMCXUoahHGY5FRwYy6hoHSVju
        iOBSgCj0t93waWzrhye8L87bvFt1YE+FUXc2TTQVp3bwc8E3Tg==
X-Google-Smtp-Source: AMsMyM5aNZ+EYCT/lEvzr71vVPee0ae+gmJ3Nw2Fh4C4iYqIASPq6OOkvh+EDgw7spUL8CLnI4YLPqMWeVyAvq6GHoU=
X-Received: by 2002:a17:907:2c71:b0:79e:8603:72c6 with SMTP id
 ib17-20020a1709072c7100b0079e860372c6mr13483910ejc.172.1667226252399; Mon, 31
 Oct 2022 07:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAO4mrfeYuKpeskCfNMG=0YuHMTGh7LbyfK0pXH+zc40MKkSh+g@mail.gmail.com>
In-Reply-To: <CAO4mrfeYuKpeskCfNMG=0YuHMTGh7LbyfK0pXH+zc40MKkSh+g@mail.gmail.com>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 31 Oct 2022 22:23:37 +0800
Message-ID: <CAO4mrfeaqNwQffr7-V2BpC2DmYc-o9vKHBDrRr+5i_phaLJHHA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in fscache_free_cookie
To:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux developers,

Here is the link to the reproducers.

C reproducer: https://drive.google.com/file/d/1g1uju2rj7ujfCGc_cWHVBhJb-vMZjWvF/view?usp=share_link
Syz reproducer:
https://drive.google.com/file/d/1g3Jy98NftOZkM_QVh0XCP5dB8kXPPMTF/view?usp=share_link

The bug persists in the latest commit, v5.15.76 (4f5365f77018). I hope
it is helpful to you.

[  127.444408][ T6903] FAULT_INJECTION: forcing a failure.
[  127.444408][ T6903] name fail_page_alloc, interval 1, probability
0, space 0, times 1
[  127.448565][ T6903] CPU: 1 PID: 6903 Comm: a.out Not tainted 5.15.76 #5
[  127.450699][ T6903] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[  127.454780][ T6903] Call Trace:
[  127.455825][ T6903]  <TASK>
[  127.456776][ T6903]  dump_stack_lvl+0x8d/0xcf
[  127.458239][ T6903]  should_fail+0x13c/0x160
[  127.459641][ T6903]  __alloc_pages+0x121/0x420
[  127.461108][ T6903]  alloc_pages+0x85/0x150
[  127.462485][ T6903]  new_slab+0x300/0x4e0
[  127.463823][ T6903]  ___slab_alloc+0xaac/0x1080
[  127.465009][ T6903]  ? p9_fid_create+0x26/0x1b0
[  127.466126][ T6903]  ? p9_fid_create+0x26/0x1b0
[  127.467229][ T6903]  ? __slab_alloc.isra.90+0x4f/0xb0
[  127.468453][ T6903]  __slab_alloc.isra.90+0x4f/0xb0
[  127.469642][ T6903]  ? p9_fid_create+0x26/0x1b0
[  127.470744][ T6903]  kmem_cache_alloc_trace+0x229/0x270
[  127.472194][ T6903]  p9_fid_create+0x26/0x1b0
[  127.473459][ T6903]  p9_client_attach+0x53/0x2d0
[  127.474548][ T6903]  ? v9fs_session_init+0x698/0x930
[  127.475715][ T6903]  ? v9fs_session_init+0x5ed/0x930
[  127.476883][ T6903]  v9fs_session_init+0x5ed/0x930
[  127.478011][ T6903]  ? rcu_read_lock_sched_held+0x4d/0x80
[  127.479269][ T6903]  ? trace_kmalloc+0x8c/0xe0
[  127.480311][ T6903]  ? kmem_cache_alloc_trace+0x192/0x270
[  127.481576][ T6903]  ? v9fs_mount+0x57/0x3e0
[  127.482585][ T6903]  v9fs_mount+0x57/0x3e0
[  127.483554][ T6903]  legacy_get_tree+0x2e/0x80
[  127.484599][ T6903]  vfs_get_tree+0x28/0x100
[  127.485612][ T6903]  path_mount+0x926/0xce0
[  127.486605][ T6903]  ? putname+0x83/0xa0
[  127.487537][ T6903]  do_mount+0x92/0xb0
[  127.488449][ T6903]  __x64_sys_mount+0xb0/0x120
[  127.489517][ T6903]  do_syscall_64+0x34/0xb0
[  127.490524][ T6903]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  127.491862][ T6903] RIP: 0033:0x7ff527e9a469
[  127.492865][ T6903] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8
64 89 01 48
[  127.497297][ T6903] RSP: 002b:00007ff52858ada8 EFLAGS: 00000202
ORIG_RAX: 00000000000000a5
[  127.499198][ T6903] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007ff527e9a469
[  127.501005][ T6903] RDX: 00000000200002c0 RSI: 0000000020000100
RDI: 0000000000000000
[  127.502805][ T6903] RBP: 00007ff52858ae20 R08: 00000000200007c0
R09: 0000000000000000
[  127.504602][ T6903] R10: 0000000000000000 R11: 0000000000000202
R12: 00007ffee097c81e
[  127.506411][ T6903] R13: 00007ffee097c81f R14: 00007ff52856b000
R15: 0000000000000003
[  127.508219][ T6903]  </TASK>
[  127.529498][ T6908] FAULT_INJECTION: forcing a failure.
[  127.529498][ T6908] name failslab, interval 1, probability 0, space
0, times 1
[  127.532621][ T6908] CPU: 1 PID: 6908 Comm: a.out Not tainted 5.15.76 #5
[  127.534188][ T6908] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[  127.536998][ T6908] Call Trace:
[  127.537744][ T6908]  <TASK>
[  127.538412][ T6908]  dump_stack_lvl+0x8d/0xcf
[  127.539445][ T6908]  should_fail+0x13c/0x160
[  127.540454][ T6908]  should_failslab+0x5/0x10
[  127.541484][ T6908]  slab_pre_alloc_hook.constprop.98+0x4e/0xc0
[  127.542863][ T6908]  ? fscache_alloc_cookie+0x2c1/0x330
[  127.544086][ T6908]  __kmalloc+0x64/0x240
[  127.545038][ T6908]  fscache_alloc_cookie+0x2c1/0x330
[  127.546225][ T6908]  __fscache_acquire_cookie+0xcc/0x4a0
[  127.547475][ T6908]  v9fs_cache_session_get_cookie+0x68/0x110
[  127.548824][ T6908]  v9fs_session_init+0x62c/0x930
[  127.550014][ T6908]  ? rcu_read_lock_sched_held+0x4d/0x80
[  127.551281][ T6908]  ? trace_kmalloc+0x8c/0xe0
[  127.552327][ T6908]  ? kmem_cache_alloc_trace+0x192/0x270
[  127.553597][ T6908]  ? v9fs_mount+0x57/0x3e0
[  127.554599][ T6908]  v9fs_mount+0x57/0x3e0
[  127.555570][ T6908]  legacy_get_tree+0x2e/0x80
[  127.556617][ T6908]  vfs_get_tree+0x28/0x100
[  127.557629][ T6908]  path_mount+0x926/0xce0
[  127.558619][ T6908]  ? putname+0x83/0xa0
[  127.559550][ T6908]  do_mount+0x92/0xb0
[  127.560458][ T6908]  __x64_sys_mount+0xb0/0x120
[  127.561533][ T6908]  do_syscall_64+0x34/0xb0
[  127.562540][ T6908]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  127.563881][ T6908] RIP: 0033:0x7ff527e9a469
[  127.564888][ T6908] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8
64 89 01 48
[  127.569353][ T6908] RSP: 002b:00007ff528569da8 EFLAGS: 00000202
ORIG_RAX: 00000000000000a5
[  127.571263][ T6908] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007ff527e9a469
[  127.573078][ T6908] RDX: 00000000200002c0 RSI: 0000000020000100
RDI: 0000000000000000
[  127.574889][ T6908] RBP: 00007ff528569e20 R08: 00000000200007c0
R09: 0000000000000000
[  127.576698][ T6908] R10: 0000000000000000 R11: 0000000000000202
R12: 00007ffee097c81e
[  127.578529][ T6908] R13: 00007ffee097c81f R14: 00007ff52854a000
R15: 0000000000000003
[  127.580347][ T6908]  </TASK>
[  127.582306][ T6908] list_del corruption, ffff888101394720->next is NULL
[  127.584217][ T6908] ------------[ cut here ]------------
[  127.585496][ T6908] kernel BUG at lib/list_debug.c:50!
[  127.586726][ T6908] invalid opcode: 0000 [#1] PREEMPT SMP
[  127.587995][ T6908] CPU: 0 PID: 6908 Comm: a.out Not tainted 5.15.76 #5
[  127.589552][ T6908] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[  127.592388][ T6908] RIP: 0010:__list_del_entry_valid+0x55/0xb0
[  127.593770][ T6908] Code: 39 ca 74 4d 48 8b 32 48 39 fe 75 56 48 8b
50 08 48 39 f2 75 61 b8 01 00 00 00 c3 48 89 fe 48 c7 c7 40 96 3d 85
e8 f1 65 f8 01 <0f> 0b 48 89 fe 48 c7 c7 70 96 3d 85 e8 e0 65 f8 01 0f
0b 48 89 fe
[  127.598566][ T6908] RSP: 0018:ffffc90002613c50 EFLAGS: 00010286
[  127.599956][ T6908] RAX: 0000000000000033 RBX: ffff888101394668
RCX: 0000000000000000
[  127.601766][ T6908] RDX: 0000000000000000 RSI: ffffffff812d935c
RDI: 00000000ffffffff
[  127.603579][ T6908] RBP: 0000000000000079 R08: 0000000000000000
R09: 0000000000000001
[  127.605389][ T6908] R10: 0000000000000000 R11: 0000000000000001
R12: 000000000000001f
[  127.607234][ T6908] R13: 0000000000000000 R14: ffffffff8496d360
R15: 0000000000000000
[  127.609062][ T6908] FS:  00007ff52856a700(0000)
GS:ffff88807dc00000(0000) knlGS:0000000000000000
[  127.611098][ T6908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  127.612604][ T6908] CR2: 000055d718411188 CR3: 0000000011a11000
CR4: 00000000003506f0
[  127.614423][ T6908] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[  127.616403][ T6908] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[  127.618478][ T6908] Call Trace:
[  127.619236][ T6908]  <TASK>
[  127.619945][ T6908]  fscache_free_cookie.part.14+0x21/0xd0
[  127.621282][ T6908]  fscache_alloc_cookie+0x291/0x330
[  127.622777][ T6908]  __fscache_acquire_cookie+0xcc/0x4a0
[  127.624490][ T6908]  v9fs_cache_session_get_cookie+0x68/0x110
[  127.626334][ T6908]  v9fs_session_init+0x62c/0x930
[  127.627869][ T6908]  ? rcu_read_lock_sched_held+0x4d/0x80
[  127.629567][ T6908]  ? trace_kmalloc+0x8c/0xe0
[  127.631022][ T6908]  ? kmem_cache_alloc_trace+0x192/0x270
[  127.632731][ T6908]  ? v9fs_mount+0x57/0x3e0
[  127.634136][ T6908]  v9fs_mount+0x57/0x3e0
[  127.635499][ T6908]  legacy_get_tree+0x2e/0x80
[  127.636928][ T6908]  vfs_get_tree+0x28/0x100
[  127.638330][ T6908]  path_mount+0x926/0xce0
[  127.639722][ T6908]  ? putname+0x83/0xa0
[  127.641030][ T6908]  do_mount+0x92/0xb0
[  127.642279][ T6908]  __x64_sys_mount+0xb0/0x120
[  127.643747][ T6908]  do_syscall_64+0x34/0xb0
[  127.645166][ T6908]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  127.647038][ T6908] RIP: 0033:0x7ff527e9a469
[  127.648440][ T6908] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8
64 89 01 48
[  127.654640][ T6908] RSP: 002b:00007ff528569da8 EFLAGS: 00000202
ORIG_RAX: 00000000000000a5
[  127.657251][ T6908] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007ff527e9a469
[  127.659757][ T6908] RDX: 00000000200002c0 RSI: 0000000020000100
RDI: 0000000000000000
[  127.662296][ T6908] RBP: 00007ff528569e20 R08: 00000000200007c0
R09: 0000000000000000
[  127.664816][ T6908] R10: 0000000000000000 R11: 0000000000000202
R12: 00007ffee097c81e
[  127.667345][ T6908] R13: 00007ffee097c81f R14: 00007ff52854a000
R15: 0000000000000003
[  127.669876][ T6908]  </TASK>
[  127.670834][ T6908] Modules linked in:
[  127.672259][ T6908] ---[ end trace c3a644b48eb3b338 ]---
[  127.673760][ T6908] RIP: 0010:__list_del_entry_valid+0x55/0xb0
[  127.675148][ T6908] Code: 39 ca 74 4d 48 8b 32 48 39 fe 75 56 48 8b
50 08 48 39 f2 75 61 b8 01 00 00 00 c3 48 89 fe 48 c7 c7 40 96 3d 85
e8 f1 65 f8 01 <0f> 0b 48 89 fe 48 c7 c7 70 96 3d 85 e8 e0 65 f8 01 0f
0b 48 89 fe
[  127.679641][ T6908] RSP: 0018:ffffc90002613c50 EFLAGS: 00010286
[  127.681037][ T6908] RAX: 0000000000000033 RBX: ffff888101394668
RCX: 0000000000000000
[  127.682878][ T6908] RDX: 0000000000000000 RSI: ffffffff812d935c
RDI: 00000000ffffffff
[  127.684707][ T6908] RBP: 0000000000000079 R08: 0000000000000000
R09: 0000000000000001
[  127.686541][ T6908] R10: 0000000000000000 R11: 0000000000000001
R12: 000000000000001f
[  127.688366][ T6908] R13: 0000000000000000 R14: ffffffff8496d360
R15: 0000000000000000
[  127.690194][ T6908] FS:  00007ff52856a700(0000)
GS:ffff88807dc00000(0000) knlGS:0000000000000000
[  127.692236][ T6908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  127.693766][ T6908] CR2: 000055d718411188 CR3: 0000000011a11000
CR4: 00000000003506f0
[  127.695610][ T6908] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[  127.697449][ T6908] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[  127.699281][ T6908] Kernel panic - not syncing: Fatal exception
[  127.701367][ T6908] Kernel Offset: disabled
[  127.702367][ T6908] Rebooting in 86400 seconds.

Best,
Wei

On Sun, 30 Oct 2022 at 18:32, Wei Chen <harperchen1110@gmail.com> wrote:
>
> Dear Linux Developer,
>
> Recently when using our tool to fuzz kernel, the following crash was triggered:
>
> HEAD commit: 64570fbc14f8 Linux 5.15-rc5
> git tree: upstream
> compiler: gcc 8.0.1
> console output:
> https://drive.google.com/file/d/1XbBDSFuHIAMsOAmvF0ITxNg8CEr443UB/view?usp=share_link
> kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
>
> RBP: 000000000000004a R08: 00000000200007c0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bfac
> R13: 0000000000000000 R14: 000000000119bfa0 R15: 00007fffa5a71650
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 14091067 P4D 14091067 PUD 14092067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 13456 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__list_del_entry_valid+0x2d/0x50
> Code: 01 00 00 00 00 ad de 48 8b 07 48 8b 57 08 48 39 c8 0f 84 cd cb
> 46 02 48 b9 22 01 00 00 00 00 ad de 48 39 ca 0f 84 f0 cb 46 02 <48> 8b
> 32 48 39 fe 0f 85 d0 cb 46 02 48 8b 50 08 48 39 f2 0f 85 b5
> RSP: 0018:ffffc9000cf63c28 EFLAGS: 00010217
> RAX: 0000000000000000 RBX: ffff88800f2113d8 RCX: dead000000000122
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88800f211490
> RBP: 0000000000000079 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff86485018 R11: 0000000000000000 R12: 000000000000001f
> R13: 0000000000000000 R14: ffffffff8518ba40 R15: 0000000000000000
> FS:  00007f0e4932c700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000014090000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  fscache_free_cookie+0x45/0x120
>  fscache_alloc_cookie+0x331/0x350
>  __fscache_acquire_cookie+0x132/0x620
>  v9fs_cache_session_get_cookie+0x7d/0x140
>  v9fs_session_init+0x798/0xac0
>  v9fs_mount+0x53/0x480
>  legacy_get_tree+0x2e/0x90
>  vfs_get_tree+0x29/0x100
>  path_mount+0x58e/0x10a0
>  do_mount+0x9b/0xb0
>  __x64_sys_mount+0x13a/0x150
>  do_syscall_64+0x34/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4692c9
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0e4932bc38 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f0e4932bc80 RCX: 00000000004692c9
> RDX: 00000000200002c0 RSI: 0000000020000100 RDI: 0000000000000000
> RBP: 000000000000004a R08: 00000000200007c0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bfac
> R13: 0000000000000000 R14: 000000000119bfa0 R15: 00007fffa5a71650
> Modules linked in:
> CR2: 0000000000000000
> ---[ end trace 15cdfd4d79de03b8 ]---
> RIP: 0010:__list_del_entry_valid+0x2d/0x50
> Code: 01 00 00 00 00 ad de 48 8b 07 48 8b 57 08 48 39 c8 0f 84 cd cb
> 46 02 48 b9 22 01 00 00 00 00 ad de 48 39 ca 0f 84 f0 cb 46 02 <48> 8b
> 32 48 39 fe 0f 85 d0 cb 46 02 48 8b 50 08 48 39 f2 0f 85 b5
> RSP: 0018:ffffc9000cf63c28 EFLAGS: 00010217
> RAX: 0000000000000000 RBX: ffff88800f2113d8 RCX: dead000000000122
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88800f211490
> RBP: 0000000000000079 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff86485018 R11: 0000000000000000 R12: 000000000000001f
> R13: 0000000000000000 R14: ffffffff8518ba40 R15: 0000000000000000
> FS:  00007f0e4932c700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000014090000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0: 01 00                add    %eax,(%rax)
>    2: 00 00                add    %al,(%rax)
>    4: 00 ad de 48 8b 07    add    %ch,0x78b48de(%rbp)
>    a: 48 8b 57 08          mov    0x8(%rdi),%rdx
>    e: 48 39 c8              cmp    %rcx,%rax
>   11: 0f 84 cd cb 46 02    je     0x246cbe4
>   17: 48 b9 22 01 00 00 00 movabs $0xdead000000000122,%rcx
>   1e: 00 ad de
>   21: 48 39 ca              cmp    %rcx,%rdx
>   24: 0f 84 f0 cb 46 02    je     0x246cc1a
> * 2a: 48 8b 32              mov    (%rdx),%rsi <-- trapping instruction
>   2d: 48 39 fe              cmp    %rdi,%rsi
>   30: 0f 85 d0 cb 46 02    jne    0x246cc06
>   36: 48 8b 50 08          mov    0x8(%rax),%rdx
>   3a: 48 39 f2              cmp    %rsi,%rdx
>   3d: 0f                    .byte 0xf
>   3e: 85                    .byte 0x85
>   3f: b5                    .byte 0xb5
>
> Best,
> Wei
