Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB39E660C65
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 05:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjAGEI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 23:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjAGEIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 23:08:49 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC4B714B6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 20:08:34 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l13-20020a056e0212ed00b00304c6338d79so2246007iln.21
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 20:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJnD3ig7sUZlgkQL2QrvIKL261gXu5lismF55Zm2ACA=;
        b=cXgdWwvdz1h+Q4d2ekPDgQ4NHsp3IKo5YWC2vd1UazJ/IuIuMPOPfjPDrVML//G7zB
         1J1IN6Qk/uZJdS/duZl+Hl1aXWw2S9RZkzSpDMa6v4oCiZmG89YAahius7UzU3lCJp9+
         JgkkUxpH4P9saKTQbS177KZA2e/aktpOyFttWoxcTyaEzz30h/jLyNnqoj7U3GU/QmOc
         fQ0kXLgLljP47QxiY80CaBHhnksEGe1Rapc6BRNGnpm90Rje2lKuSTVY/2QqXMWrYPVP
         Izdcjw+rT0Pzo9TRM2MUoPgJ36NWozxi4N6vADWcJ6vHfzHdXBUOnzz/011I1wZQJzGw
         mL4Q==
X-Gm-Message-State: AFqh2kqogv1Ocu9Gt+UTL1kwFOtwpjRtYkPyjHse9a/QsrCFJxZXUFrs
        rT59hk/4YSUDA6+lwEM4wmdHIM8UHfuDvTerCU3OkrW3OurO
X-Google-Smtp-Source: AMrXdXuy2euMsQQ9E+WhqIqXIrYNKIm2eQXpddY48B0jZjLjqK9OhbKlswuaMNR4xBrzYX/el6ZDwiNoQoiPSFTLq7kvUgFwCfp9
MIME-Version: 1.0
X-Received: by 2002:a5e:c00c:0:b0:6a2:8015:afef with SMTP id
 u12-20020a5ec00c000000b006a28015afefmr4726761iol.149.1673064513949; Fri, 06
 Jan 2023 20:08:33 -0800 (PST)
Date:   Fri, 06 Jan 2023 20:08:33 -0800
In-Reply-To: <20230107020600.4739-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a5b5805f1a4b0c4@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in p9_client_disconnect
From:   syzbot <syzbot+ea8b28e8dca42fc3bcbe@syzkaller.appspotmail.com>
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
BUG: unable to handle kernel paging request in p9_client_disconnect

Unable to handle kernel paging request at virtual address 0032503900080052
Mem abort info:
  ESR = 0x0000000096000044
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000044
  CM = 0, WnR = 1
[0032503900080052] address between user and kernel address ranges
Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3496 Comm: syz-executor.0 Not tainted 6.1.0-rc2-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : p9_client_disconnect+0x1c/0x30 net/9p/client.c:1067
lr : p9_client_disconnect+0x18/0x30 net/9p/client.c:1065
sp : ffff800010f83ca0
x29: ffff800010f83ca0 x28: ffff0000c684cec0 x27: 0000000000000000
x26: 00000000000000c0 x25: 0000000000000002 x24: ffff80000d37d050
x23: ffff80000d379000 x22: 0000000000000000 x21: 0000000000000000
x20: ffff0000cfaf5f00 x19: 3032503900080002 x18: 00000000000002aa
x17: ffff80000c0cd83c x16: 00000000000003fa x15: 0000000000000150
x14: 0000000001ef2008 x13: 0000000000000120 x12: 0000000000000000
x11: ff8080000be79558 x10: 0000000000000000 x9 : ffff80000be79558
x8 : 0000000000000002 x7 : 0000000000000000 x6 : ffff80000c036518
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0000c684cec0 x1 : 0000000000000000 x0 : 3032503900080002
Call trace:
 p9_client_disconnect+0x1c/0x30
 v9fs_session_cancel+0x2c/0x44 fs/9p/v9fs.c:534
 v9fs_kill_super+0x2c/0x50 fs/9p/vfs_super.c:225
 deactivate_locked_super+0x70/0xe8 fs/super.c:331
 deactivate_super+0xd0/0xd4 fs/super.c:362
 cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0x100/0x148 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: 910003fd aa0003f3 9710b6ef 52800048 (b9005268) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	910003fd 	mov	x29, sp
   4:	aa0003f3 	mov	x19, x0
   8:	9710b6ef 	bl	0xfffffffffc42dbc4
   c:	52800048 	mov	w8, #0x2                   	// #2
* 10:	b9005268 	str	w8, [x19, #80] <-- trapping instruction


Tested on:

commit:         247f34f7 Linux 6.1-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15b8a776480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9bed8d6a8992a0
dashboard link: https://syzkaller.appspot.com/bug?extid=ea8b28e8dca42fc3bcbe
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c64f3a480000

