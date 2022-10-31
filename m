Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EFC6137E2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiJaNZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJaNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:25:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96718658D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:25:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t25so29388912ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ILgZB9K9eLvRiXGRH7QRw28GvQlSsGrk7u6vEXzxEm0=;
        b=Gjrb69JKw1e0yFxsBBwqNxXU4PJiElikm9X8TxS4BGx3/qY3HFiMxYxSEerLQbTkPp
         bagYwZu7Jhx4YsQnbBvur9oxffJ7QA7byoob7qR9rEMMDpDFwNlJVXGHPtW6t6GuwprE
         lsGrd52PftbnSuWYAe6TNKmkz8x1bLJS01dFG/6IrSRSwcUUqyh8E6oNX507rkcgLjmH
         e9bipBvBPDp1hu4z25WwRcumKy1EY78rKeEDomKLwHANhvt4aVlk1BJgpvcPhOMu9ufU
         1z9tQYqLwHNXsCpd0cR0Jp7LfFHD+0wxZTD8P5h0moOOK2HqF88hWjuGOWLQWbiuuHuN
         qqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILgZB9K9eLvRiXGRH7QRw28GvQlSsGrk7u6vEXzxEm0=;
        b=Uoj58REMEPIpOtdpu5zQvxDCpXvkDFQ+HHt1kgchb5Qg9vL0xWrY47oAST7GddAmsT
         YSxnZr6EWMuprjRzQhLFcg8UR9fOiS+DoPT7K28xycKMuTlX8hZfyN5w7tAsxGZ3mJpq
         pBaNbilDntut1RIkXstIWDtHsgHKRT2tRLx/9dg/sxOVEOv88RGFyNH2y4ta0J45Kg0Z
         wnJ1MTBqwmLEP8qyDCKi7Gb2e7ccRXSOTfXzs94FwNkcGBLP0F72tfI/YgWDQ9LxYRiw
         oQ+zUlgNcKGwaahbxVAy835XfDG8YHrEmH/jQCWzPA78LrEJw2K5z5Vk2He6vsgfeXax
         VT6w==
X-Gm-Message-State: ACrzQf1biFYNFTSu7W8MJDC2TI0VbEnRAujW/QVjsv80Vi0JBL7TPKns
        AeIPparEjXwnd6E43C/N1BQd0aDZycqbJzcV/rvDEFpi3Us=
X-Google-Smtp-Source: AMsMyM6atkoW/zl8GzN9rFWToYxqo9gxCS2KwUXpWYPFEqsqUZchGmP5ztc+anwJqmSqV2qLiqUiA5JwWF/JDPxdD6M=
X-Received: by 2002:a17:907:2c75:b0:78d:c201:e9aa with SMTP id
 ib21-20020a1709072c7500b0078dc201e9aamr13122800ejc.235.1667222739810; Mon, 31
 Oct 2022 06:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAO4mrfd4=HRXMrcdZQUorNaFss3AFfrRxuXWMFT3uh+Dvfwb9g@mail.gmail.com>
In-Reply-To: <CAO4mrfd4=HRXMrcdZQUorNaFss3AFfrRxuXWMFT3uh+Dvfwb9g@mail.gmail.com>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 31 Oct 2022 21:25:04 +0800
Message-ID: <CAO4mrfdU4oGktM8PPFg66=32N0JSGx=gtG80S89-b66tS3NLVw@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in gfs2_evict_inode
To:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
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

C reproducer: https://drive.google.com/file/d/1P9GsW2pvEN_tvn89RYsrgnv2uDz3_6iq/view?usp=share_link
Syz reproducer:
https://drive.google.com/file/d/1Be-QEZ-hfj_CXhXlSEvzbf3E89HmkVMH/view?usp=share_link

The bug persists in the latest commit, v5.15.76 (4f5365f77018). I hope
it is helpful to you.

[   83.919419][ T6891]   function = gfs2_dirent_scan, file =
fs/gfs2/dir.c, line = 602
[   83.923713][ T6891] gfs2: fsid=syz:syz.0: about to withdraw this file system
[   83.929444][ T6891] gfs2: fsid=syz:syz.0: File system withdrawn
[   83.931468][ T6891] CPU: 1 PID: 6891 Comm: a.out Not tainted 5.15.76 #5
[   83.933492][ T6891] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[   83.936328][ T6891] Call Trace:
[   83.937107][ T6891]  <TASK>
[   83.937780][ T6891]  dump_stack_lvl+0x8d/0xcf
[   83.938843][ T6891]  gfs2_withdraw+0x212/0x730
[   83.939908][ T6891]  ? gfs2_dirent_scan+0x158/0x1a0
[   83.941070][ T6891]  gfs2_dirent_scan+0x158/0x1a0
[   83.942185][ T6891]  ? do_filldir_main.isra.21+0x1e0/0x1e0
[   83.943476][ T6891]  ? do_filldir_main.isra.21+0x1e0/0x1e0
[   83.944765][ T6891]  gfs2_dirent_search+0x156/0x2b0
[   83.945928][ T6891]  gfs2_dir_search+0x4a/0x120
[   83.947005][ T6891]  gfs2_lookupi+0x1ec/0x2c0
[   83.948042][ T6891]  ? gfs2_lookupi+0x12d/0x2c0
[   83.949127][ T6891]  ? gfs2_lookup_simple+0x57/0x90
[   83.950403][ T6891]  gfs2_lookup_simple+0x57/0x90
[   83.951522][ T6891]  init_inodes+0x6c/0xfd0
[   83.952527][ T6891]  ? snprintf+0x66/0x90
[   83.953544][ T6891]  ? gfs2_fill_super+0xa4d/0x1080
[   83.954695][ T6891]  gfs2_fill_super+0xa4d/0x1080
[   83.955809][ T6891]  ? gfs2_glock_nq_num+0x8f/0xe0
[   83.956946][ T6891]  ? snprintf+0x66/0x90
[   83.957905][ T6891]  ? set_blocksize+0x100/0x130
[   83.959011][ T6891]  ? gfs2_reconfigure+0x4c0/0x4c0
[   83.960164][ T6891]  ? get_tree_bdev+0x1c9/0x310
[   83.961270][ T6891]  get_tree_bdev+0x1c9/0x310
[   83.962579][ T6891]  gfs2_get_tree+0x24/0xc0
[   83.963992][ T6891]  vfs_get_tree+0x28/0x100
[   83.965423][ T6891]  path_mount+0x926/0xce0
[   83.966878][ T6891]  ? putname+0x83/0xa0
[   83.968251][ T6891]  do_mount+0x92/0xb0
[   83.969599][ T6891]  __x64_sys_mount+0xb0/0x120
[   83.971115][ T6891]  do_syscall_64+0x34/0xb0
[   83.972527][ T6891]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[   83.974433][ T6891] RIP: 0033:0x7f4669d7f48a
[   83.975836][ T6891] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83
c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d de f9 2a 00 f7 d8
64 89 01 48
[   83.982060][ T6891] RSP: 002b:00007f466a46bd38 EFLAGS: 00000282
ORIG_RAX: 00000000000000a5
[   83.984695][ T6891] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007f4669d7f48a
[   83.986856][ T6891] RDX: 0000000020000000 RSI: 0000000020000100
RDI: 00007f466a46be70
[   83.988696][ T6891] RBP: 00007f466a46bef0 R08: 00007f466a46bd70
R09: 0000000000000000
[   83.990534][ T6891] R10: 0000000000000000 R11: 0000000000000282
R12: 00007ffd64dee9fe
[   83.992369][ T6891] R13: 00007ffd64dee9ff R14: 00007f466a44c000
R15: 0000000000000003
[   83.994218][ T6891]  </TASK>
[   83.997025][ T6891] gfs2: fsid=syz:syz.0: can't lookup journal index: 0
[   83.998884][ T6891] BUG: kernel NULL pointer dereference, address:
000000000000008c
[   84.000696][ T6891] #PF: supervisor read access in kernel mode
[   84.002075][ T6891] #PF: error_code(0x0000) - not-present page
[   84.003452][ T6891] PGD 109056067 P4D 109056067 PUD 109057067 PMD 0
[   84.004955][ T6891] Oops: 0000 [#1] PREEMPT SMP
[   84.006026][ T6891] CPU: 1 PID: 6891 Comm: a.out Not tainted 5.15.76 #5
[   84.007585][ T6891] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[   84.010444][ T6891] RIP: 0010:gfs2_evict_inode+0x39f/0x910
[   84.011742][ T6891] Code: 02 37 ff be 01 00 00 00 48 89 df e8 ab 38
60 ff 48 8b bb b8 04 00 00 31 f6 e8 7d 95 fd ff 49 8b 87 00 09 00 00
31 f6 4c 89 ff <8b> 90 8c 00 00 00 e8 56 43 00 00 85 c0 89 85 60 ff ff
ff 75 25 e8
[   84.016251][ T6891] RSP: 0018:ffffc900025d3b00 EFLAGS: 00010246
[   84.017655][ T6891] RAX: 0000000000000000 RBX: ffff88810cb10650
RCX: 0000000000000000
[   84.019490][ T6891] RDX: ffff88810ab15340 RSI: 0000000000000000
RDI: ffff88810c1bc000
[   84.021329][ T6891] RBP: ffffc900025d3bb0 R08: 0000000000000001
R09: 0000000000000000
[   84.023160][ T6891] R10: ffffc900025d38f8 R11: 0000000000000001
R12: ffff88810cb10b88
[   84.024992][ T6891] R13: ffff88810cb10878 R14: ffff88810c1bc000
R15: ffff88810c1bc000
[   84.026825][ T6891] FS:  00007f466a46c700(0000)
GS:ffff88813dc00000(0000) knlGS:0000000000000000
[   84.028869][ T6891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.030382][ T6891] CR2: 000000000000008c CR3: 000000010c054000
CR4: 00000000003506e0
[   84.032206][ T6891] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   84.034034][ T6891] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   84.035859][ T6891] Call Trace:
[   84.036615][ T6891]  <TASK>
[   84.037294][ T6891]  ? find_held_lock+0x2d/0x90
[   84.038375][ T6891]  ? gfs2_evict_inode+0x2c7/0x910
[   84.039537][ T6891]  ? evict_unlinked_inode+0x380/0x380
[   84.040773][ T6891]  ? evict+0xfd/0x1e0
[   84.041694][ T6891]  evict+0xfd/0x1e0
[   84.042571][ T6891]  ? gfs2_glock_put_eventually+0x40/0x40
[   84.043866][ T6891]  iput.part.20+0x217/0x3a0
[   84.044949][ T6891]  iput+0x29/0x40
[   84.045790][ T6891]  dentry_unlink_inode+0x163/0x170
[   84.046971][ T6891]  __dentry_kill+0x137/0x220
[   84.048032][ T6891]  ? dput+0x32/0x650
[   84.048936][ T6891]  dput+0x42b/0x650
[   84.049814][ T6891]  gfs2_fill_super+0xa94/0x1080
[   84.050932][ T6891]  ? gfs2_glock_nq_num+0x8f/0xe0
[   84.052068][ T6891]  ? snprintf+0x66/0x90
[   84.053036][ T6891]  ? set_blocksize+0x100/0x130
[   84.054137][ T6891]  ? gfs2_reconfigure+0x4c0/0x4c0
[   84.055292][ T6891]  ? get_tree_bdev+0x1c9/0x310
[   84.056391][ T6891]  get_tree_bdev+0x1c9/0x310
[   84.057457][ T6891]  gfs2_get_tree+0x24/0xc0
[   84.058474][ T6891]  vfs_get_tree+0x28/0x100
[   84.059489][ T6891]  path_mount+0x926/0xce0
[   84.060486][ T6891]  ? putname+0x83/0xa0
[   84.061432][ T6891]  do_mount+0x92/0xb0
[   84.062353][ T6891]  __x64_sys_mount+0xb0/0x120
[   84.063437][ T6891]  do_syscall_64+0x34/0xb0
[   84.064455][ T6891]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[   84.065811][ T6891] RIP: 0033:0x7f4669d7f48a
[   84.066822][ T6891] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83
c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d de f9 2a 00 f7 d8
64 89 01 48
[   84.071310][ T6891] RSP: 002b:00007f466a46bd38 EFLAGS: 00000282
ORIG_RAX: 00000000000000a5
[   84.073242][ T6891] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007f4669d7f48a
[   84.075069][ T6891] RDX: 0000000020000000 RSI: 0000000020000100
RDI: 00007f466a46be70
[   84.076892][ T6891] RBP: 00007f466a46bef0 R08: 00007f466a46bd70
R09: 0000000000000000
[   84.078724][ T6891] R10: 0000000000000000 R11: 0000000000000282
R12: 00007ffd64dee9fe
[   84.080598][ T6891] R13: 00007ffd64dee9ff R14: 00007f466a44c000
R15: 0000000000000003
[   84.082437][ T6891]  </TASK>
[   84.083141][ T6891] Modules linked in:
[   84.084084][ T6891] CR2: 000000000000008c
[   84.085089][ T6891] ---[ end trace 7249ef596cc64205 ]---
[   84.086343][ T6891] RIP: 0010:gfs2_evict_inode+0x39f/0x910
[   84.087642][ T6891] Code: 02 37 ff be 01 00 00 00 48 89 df e8 ab 38
60 ff 48 8b bb b8 04 00 00 31 f6 e8 7d 95 fd ff 49 8b 87 00 09 00 00
31 f6 4c 89 ff <8b> 90 8c 00 00 00 e8 56 43 00 00 85 c0 89 85 60 ff ff
ff 75 25 e8
[   84.092183][ T6891] RSP: 0018:ffffc900025d3b00 EFLAGS: 00010246
[   84.093581][ T6891] RAX: 0000000000000000 RBX: ffff88810cb10650
RCX: 0000000000000000
[   84.095407][ T6891] RDX: ffff88810ab15340 RSI: 0000000000000000
RDI: ffff88810c1bc000
[   84.097245][ T6891] RBP: ffffc900025d3bb0 R08: 0000000000000001
R09: 0000000000000000
[   84.099079][ T6891] R10: ffffc900025d38f8 R11: 0000000000000001
R12: ffff88810cb10b88
[   84.100917][ T6891] R13: ffff88810cb10878 R14: ffff88810c1bc000
R15: ffff88810c1bc000
[   84.102756][ T6891] FS:  00007f466a46c700(0000)
GS:ffff88813dc00000(0000) knlGS:0000000000000000
[   84.104808][ T6891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.106320][ T6891] CR2: 000000000000008c CR3: 000000010c054000
CR4: 00000000003506e0
[   84.108160][ T6891] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   84.109992][ T6891] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   84.111822][ T6891] Kernel panic - not syncing: Fatal exception
[   84.113908][ T6891] Kernel Offset: disabled
[   84.114912][ T6891] Rebooting in 86400 seconds..

Best,
Wei
