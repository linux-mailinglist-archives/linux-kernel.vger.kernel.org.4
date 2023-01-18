Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B4671F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjAROY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjAROXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:23:39 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429917573C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:07:21 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso25204509ilj.17
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TjwZxiPkFXM5gUP/E2AOEvtASNvfmz0qBmFB6dfUWMw=;
        b=t6a9mz+khx9qrnjYSCrGb3HWFIadJb2y63FVm3VzVPIytJJGvrTcMi/zLONVy4XyiY
         vA/Yeq9rdwo54GA2rFfh6uo1XCy2dth2Q0U7jJwtW2n749ZZWFcvaieTCf8VPDJsGztU
         krPNCWsDKvp7hH4QItazFkxB3qZiw6J0/yOquUijf7uwo9xwDNqqdOkEjTsytqEg6y3z
         dXcPEcfSdHSYbL4o6eNjK05Qtp0g6zzc1IjHMRKp2iuxFFGKl6w9Kz65/pVeNg5uJ1ML
         JDV+UixRMstjEZw6AMAGmu/JcbXR40eO1qrg+c5M2hU3F1D32jQVbEh76/wIOHfS3rGW
         tMLA==
X-Gm-Message-State: AFqh2krEXfMgypX94nz1F9JvzGZVnKwuUbCF187M2uyF8wSXoqAborQ6
        oCG34VRO495KpQcnul05sNk4Oh/u5JSynXj8bQKtBj34Lo3L
X-Google-Smtp-Source: AMrXdXuwe6a3dIxfwa2QwD3DF9oziqdDjzdzCXIgVPJvcm6oiYPT4E6czKIZQcfRN/AYhhhacNuCOg2bdNvoaLuUx5zsRPgN76gX
MIME-Version: 1.0
X-Received: by 2002:a92:dc91:0:b0:309:1bfd:32b8 with SMTP id
 c17-20020a92dc91000000b003091bfd32b8mr847297iln.70.1674050840627; Wed, 18 Jan
 2023 06:07:20 -0800 (PST)
Date:   Wed, 18 Jan 2023 06:07:20 -0800
In-Reply-To: <20230118094915.2906-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1150f05f28a55fd@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_pcm_post_stop
From:   syzbot <syzbot+e29d28728f38190cecfc@syzkaller.appspotmail.com>
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
WARNING in io_ring_exit_work

------------[ cut here ]------------
WARNING: CPU: 0 PID: 11 at io_uring/io_uring.c:2977 io_ring_exit_work+0x320/0xc80 io_uring/io_uring.c:2977
Modules linked in:
CPU: 0 PID: 11 Comm: kworker/u4:1 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Workqueue: events_unbound io_ring_exit_work
RIP: 0010:io_ring_exit_work+0x320/0xc80 io_uring/io_uring.c:2977
Code: 40 8c e8 57 f4 02 f8 48 8b 05 f0 59 74 02 31 ff 4c 8b 74 24 10 49 29 c6 4c 89 f6 e8 8e 21 b5 f7 4d 85 f6 79 10 e8 b4 24 b5 f7 <0f> 0b 48 c7 44 24 08 70 17 00 00 e8 a4 24 b5 f7 48 8b 74 24 08 48
RSP: 0018:ffffc90000107bd0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807969a838 RCX: 0000000000000000
RDX: ffff88813fe4ba80 RSI: ffffffff89cc982c RDI: 0000000000000007
RBP: ffff88807969a000 R08: 0000000000000007 R09: 0000000000000000
R10: fffffffffffffffe R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88807969a040 R14: fffffffffffffffe R15: ffff88807969a3c8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555568ee708 CR3: 0000000029c9e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=118c8241480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15607d19480000

