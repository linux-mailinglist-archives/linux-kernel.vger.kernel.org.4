Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8691669779
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbjAMMiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241423AbjAMMcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:47 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD519D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:32:18 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y5-20020a056e021be500b0030bc4f23f0aso15778305ilv.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOPApE4vEssQW/bmP0yQPfKy/Cq/4eJSEiR3dcgbEFQ=;
        b=dSZG/W7/ponoQqqFBLepU7uIUtuFNCoqakat0/2lD6b4ULNXYrlBQqIfbgp4VG6JWS
         gUqEs+NyCv3n33HCbc7RcxnqA/9M56tCGA9JYopT6JBhpoveJgEZgXhxFItpT+LJ0Qv9
         mc/3eT+ELCSs1Tx4rWVYndWmvftWK4ego0sixGo1szak++yJnm48SOhd5je9UjC8JFu4
         pyQbSuqe2Oef75rdQlwN8RhO7c6o0hW5vOXDwKv4X8cDOEhMzFLXLWimpO3KhU1GyKhQ
         NJLWhsbO3hut862dzAdP0gsEUTmJYK90Lp2SAXyYKpHSnAtFzdccOJuaCorSSrkyu+S9
         bPtw==
X-Gm-Message-State: AFqh2krX2Ia4tenTfnVWWnuYbXk1qBk9uheKlEGtdv6Q5d+pYJuh7EN1
        wNvKF10tRmv/VHha8Ch5ygDwEY1OVPq0vNfN0dpEYtR7hw3v
X-Google-Smtp-Source: AMrXdXuLfNV+YY+00A/f8PJuVSA337W3ZTtvuKAfV9HonAl/gDkWQJOixM5MW1vptHMH5ivTEpu+nhqcpgNPcUU+Q3w5N/kfyxoC
MIME-Version: 1.0
X-Received: by 2002:a92:670e:0:b0:30d:c130:6cb3 with SMTP id
 b14-20020a92670e000000b0030dc1306cb3mr1269390ilc.90.1673613138129; Fri, 13
 Jan 2023 04:32:18 -0800 (PST)
Date:   Fri, 13 Jan 2023 04:32:18 -0800
In-Reply-To: <20230113120648.965-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097010305f2246cdc@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_rawmidi_poll
From:   syzbot <syzbot+e3ec01fd2d18c9264c3b@syzkaller.appspotmail.com>
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
WARNING: refcount bug in mm_update_next_owner

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 5598 at lib/refcount.c:25 refcount_warn_saturate+0x17c/0x1f0 lib/refcount.c:25
Modules linked in:
CPU: 0 PID: 5598 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:refcount_warn_saturate+0x17c/0x1f0 lib/refcount.c:25
Code: 0a 31 ff 89 de e8 d4 13 78 fd 84 db 0f 85 2e ff ff ff e8 57 17 78 fd 48 c7 c7 60 87 a6 8a c6 05 60 d0 54 0a 01 e8 98 a7 b2 05 <0f> 0b e9 0f ff ff ff e8 38 17 78 fd 0f b6 1d 4a d0 54 0a 31 ff 89
RSP: 0018:ffffc90005befb68 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88807d2f57c0 RSI: ffffffff8166972c RDI: fffff52000b7df5f
RBP: ffff88807d2f3aa8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880764ee300
R13: ffff88807d2f3fa8 R14: 0000000000000000 R15: ffff88807d2f3aa8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000021000000 CR3: 000000007673f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:199 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 get_task_struct include/linux/sched/task.h:110 [inline]
 mm_update_next_owner+0x585/0x7b0 kernel/exit.c:504
 exit_mm kernel/exit.c:562 [inline]
 do_exit+0x9a4/0x2a90 kernel/exit.c:854
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1012
 get_signal+0x225f/0x24f0 kernel/signal.c:2859
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9d6f48c0c9
Code: Unable to access opcode bytes at 0x7f9d6f48c09f.
RSP: 002b:00007f9d70279218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f9d6f5abf88 RCX: 00007f9d6f48c0c9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f9d6f5abf88
RBP: 00007f9d6f5abf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9d6f5abf8c
R13: 00007ffd0405f78f R14: 00007f9d70279300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=116f295a480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e3ec01fd2d18c9264c3b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104b995a480000

