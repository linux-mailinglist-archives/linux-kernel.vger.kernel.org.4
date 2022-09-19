Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AD55BC40B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiISIKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiISIKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:10:36 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16313E38
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:10:35 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y1-20020a056602200100b006893cd97da9so14267356iod.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=q3nttBvEn2pG4Dwb57sJB9DDnZkjfuTq728A1BAZF78=;
        b=p/oFDl8r6w8MEAul3nmfkKtddnma8JDmhmG8qk+fxElPWI2Ruf6wWVI6jz+8p8d28v
         Un2jgzD85hT+sPUgCK8eU8SEBxt2R8pWckR6Vg2wM3RIfNxsCf3xPy+WF6dslHuPiSGF
         G3715Lcd6e96Z587h8sxLgmrNTAH6yeIfS8vhvdgj55BhcRC3thPhJvnWBuqHi6IGqNr
         tx3ZPGO4cQfMZ3uNKJm3stVDXQYzi3Y+7fUdFxlQTMeSjXwtAxSa45q8EfEkmRL5v+5+
         +azwoJH4j6t+5dCbGbL7GfN/yobyZo70rE9zTaWOT5GoDlDc21umcsve038NlQOzygQD
         ZbcA==
X-Gm-Message-State: ACgBeo1pMupYQ/7HiO20x+/ETlRi6p6Phs0iZcVEH98C5XAmj0rRLHh7
        Q2QyiQJmJt7Iw3gDcSVIkrQRd8++PAfroHT1SNNmkhpgJctn
X-Google-Smtp-Source: AMsMyM6F9/Y1MiESdlE9sTUXyQj2iIT5+uHNCGp7mnUisa/aD7Y7MvTjXswhxOwFtyg4VRIwXspdW+aJwqLU7XzCQDgPAN5OqqLx
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1683:b0:35a:4772:edc2 with SMTP id
 f3-20020a056638168300b0035a4772edc2mr7579890jat.128.1663575035215; Mon, 19
 Sep 2022 01:10:35 -0700 (PDT)
Date:   Mon, 19 Sep 2022 01:10:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008058305e9033f85@google.com>
Subject: [syzbot] KMSAN: uninit-value in tomoyo_path_chown
From:   syzbot <syzbot+541e21dcc32c4046cba9@syzkaller.appspotmail.com>
To:     glider@google.com, jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3a2b6b904ea7 x86: kmsan: enable KMSAN builds for x86
git tree:       https://github.com/google/kmsan.git master
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13719145080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e64bc5364a1307e
dashboard link: https://syzkaller.appspot.com/bug?extid=541e21dcc32c4046cba9
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cac995080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16816c33080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+541e21dcc32c4046cba9@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in tomoyo_path_chown+0x121/0x240 security/tomoyo/tomoyo.c:366
 tomoyo_path_chown+0x121/0x240 security/tomoyo/tomoyo.c:366
 security_path_chown+0x17d/0x260 security/security.c:1224
 chown_common+0x9f2/0xef0 fs/open.c:729
 vfs_fchown fs/open.c:802 [inline]
 ksys_fchown+0x229/0x360 fs/open.c:813
 __do_sys_fchown fs/open.c:821 [inline]
 __se_sys_fchown fs/open.c:819 [inline]
 __x64_sys_fchown+0x8a/0xe0 fs/open.c:819
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Local variable newattrs created at:
 chown_common+0xd1/0xef0 fs/open.c:708
 vfs_fchown fs/open.c:802 [inline]
 ksys_fchown+0x229/0x360 fs/open.c:813

CPU: 0 PID: 3490 Comm: syz-executor426 Not tainted 6.0.0-rc2-syzkaller-47460-g3a2b6b904ea7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
