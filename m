Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902D166949E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbjAMKtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAMKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:48:21 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024165A884
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:48:20 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so15632760ilb.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acmV5/kXQimhv5QuO06OJ4XTjoOp72YZOwoh8223q2o=;
        b=fj626THoaLIvN4240zmkCoC99FoyW1zEULwzJHixUtmJuEqYVGpoALOjARVXQUziTP
         BlL3qdZlN4qwEOR/CGoKcQGC35F6xD93WVv2iPusuM1t2QnqCNdm3RCQ87mgsrROsW/X
         swrYmRLlAQLfdwnh4MaRDxS2QyY6FIbRXrhx2GMBXwJQLBmp23zkddwPFPynq8rbyiPr
         GxfppXyQWPk3WzcInM9A52TOtnumXB11GT3h+9NT249EE007bLEffseyEoOh9TGVQSx8
         xGpTTqjdxeBMl4/GLoxvZJKrj9Fsdx1nEvt1/iTIPbzJPT2paKDL7bq3uKNAcO7iaw2g
         mg7Q==
X-Gm-Message-State: AFqh2kqcLpxQhFqatS9Fa4I6kVgKVT1arbLjSv6ifKrougBz7ot1NKcX
        lQBQ+cpqZLF5CyDQyAchhr4drRZedAESaPy0FEUFvnSIlCpX
X-Google-Smtp-Source: AMrXdXtpetnlCnefMJnX0RBqQt+M+5GFaqyHYmOSssLDIjhU15Bb5Rak+ba3hX2Iw3u2bkN6aFdsj1CK0HIrfyJyMssD79gOBa9P
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:114e:b0:30e:d1cf:b378 with SMTP id
 o14-20020a056e02114e00b0030ed1cfb378mr447215ill.222.1673606899394; Fri, 13
 Jan 2023 02:48:19 -0800 (PST)
Date:   Fri, 13 Jan 2023 02:48:19 -0800
In-Reply-To: <20230113102834.768-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb710c05f222f8e6@google.com>
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
WARNING in close_substream

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5602 at kernel/sched/wait.c:248 __wake_up_pollfree+0x44/0x60 kernel/sched/wait.c:249
Modules linked in:
CPU: 0 PID: 5602 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__wake_up_pollfree+0x44/0x60 kernel/sched/wait.c:248
Code: 29 ff ff 48 8d 6b 40 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80 3c 02 00 75 11 48 8b 43 40 48 39 c5 75 03 5b 5d c3 <0f> 0b 5b 5d c3 48 89 ef e8 ef d1 6d 00 eb e5 66 66 2e 0f 1f 84 00
RSP: 0018:ffffc90004fafab0 EFLAGS: 00010297
RAX: ffffc90004fbfcd8 RBX: ffff888075f56a50 RCX: 0000000000000000
RDX: 1ffff1100ebead52 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff888075f56a90 R08: 0000000000000001 R09: ffffffff91353c67
R10: 0000000000000001 R11: 000000000009d400 R12: ffff888075f56a90
R13: 0000000000000001 R14: ffff88814a092100 R15: ffff88801c690050
FS:  00007f49e15dd700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005598bec2d000 CR3: 000000002b119000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 wake_up_pollfree include/linux/wait.h:271 [inline]
 snd_rawmidi_runtime_free sound/core/rawmidi.c:191 [inline]
 close_substream.part.0+0x229/0x8a0 sound/core/rawmidi.c:571
 close_substream sound/core/rawmidi.c:545 [inline]
 rawmidi_release_priv+0x192/0x270 sound/core/rawmidi.c:588
 snd_rawmidi_release+0x87/0x120 sound/core/rawmidi.c:625
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x24f0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f49e228c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f49e15dd218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f49e23ac058 RCX: 00007f49e228c0c9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f49e23ac058
RBP: 00007f49e23ac050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f49e23ac05c
R13: 00007ffe4d1f3a2f R14: 00007f49e15dd300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1498500e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e3ec01fd2d18c9264c3b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a8ed16480000

