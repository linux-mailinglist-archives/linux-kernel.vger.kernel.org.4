Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58B75E9E27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiIZJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiIZJpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:45:22 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5ED641D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:44:45 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id g3-20020a056e021a2300b002f875de24a2so1297641ile.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5AcHl37dizQLDlu5f/ODMQgpAKb6ZWaYOq0BVW5S03c=;
        b=aSC0JdyaH4JMaFk+duwmw87XspWDZletXf4xfvt9o0e+QYyT55I8tdojgiMUAPnSAj
         w0iRw6kPAubAlyjnPT0VEAtUAjtyMNhprGjCSN6tbSz7hnh0+Bgh4spgla53CqRMBGOh
         aDrv8K7YCX/EC6MKwv9OXGzicUIP2+KwN5gp0DR7hxdNLvDV7NMcvekDplG0czSalwVJ
         IhIQcpZUQpUfH9aTdGbhofK5zGx0emfRApTUP6Tg+ikg1/oJ92vB1GILpgGCuiYyizBv
         Edwj+aJFaC87q+ljbEht/e1l65Fv27Aruco2vLU7vsJsxMLx5gaM68jXdCTIGE7PLDS6
         w0hQ==
X-Gm-Message-State: ACrzQf1inITjJlaVqZaLcDQD/tS0PoOa0Bc2f0++mmKJ/ENBYIosTcmM
        h0xCL14nwr2KjcCzif8ySnuzYWmX6NovSdV/DAn2a2tSv/Ha
X-Google-Smtp-Source: AMsMyM7fDLT+epWJ8eBUjUpMp0JPd2pZmkyCrgymHnRY7WkWFjeYwXfCd9afbXgS4Jats1mksYzD4quvLbcSNYhASb6Wg4jID+Qs
MIME-Version: 1.0
X-Received: by 2002:a92:280f:0:b0:2f7:e5ad:63ad with SMTP id
 l15-20020a92280f000000b002f7e5ad63admr6573696ilf.59.1664185484852; Mon, 26
 Sep 2022 02:44:44 -0700 (PDT)
Date:   Mon, 26 Sep 2022 02:44:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa458a05e991602c@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in dbAdjTree
From:   syzbot <syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    1a61b828566f Merge tag 'char-misc-6.0-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=141e2650880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=39ba34a099ac2e9bd3cb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dde8a8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12018470880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/367e34e7ff83/disk-1a61b828.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/91a2819fe451/vmlinux-1a61b828.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2841:19
index 262145 is out of range for type 's8 [1365]'
CPU: 1 PID: 119 Comm: jfsCommit Not tainted 6.0.0-rc6-syzkaller-00309-g1a61b828566f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:283
 dbAdjTree+0x34c/0x360 fs/jfs/jfs_dmap.c:2841
 dbJoin+0x1f0/0x240 fs/jfs/jfs_dmap.c:2808
 dbFreeBits+0x15d/0x8c0 fs/jfs/jfs_dmap.c:2305
 dbFreeDmap+0x61/0x1a0 fs/jfs/jfs_dmap.c:2054
 dbFree+0x250/0x540 fs/jfs/jfs_dmap.c:379
 txFreeMap+0x8f1/0xd70 fs/jfs/jfs_txnmgr.c:2529
 txUpdateMap+0x3cd/0xc50 fs/jfs/jfs_txnmgr.c:2325
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x610/0xb70 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
================================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 119 Comm: jfsCommit Not tainted 6.0.0-rc6-syzkaller-00309-g1a61b828566f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 panic+0x2c8/0x627 kernel/panic.c:274
 ubsan_epilogue+0x4a/0x50 lib/ubsan.c:158
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:283
 dbAdjTree+0x34c/0x360 fs/jfs/jfs_dmap.c:2841
 dbJoin+0x1f0/0x240 fs/jfs/jfs_dmap.c:2808
 dbFreeBits+0x15d/0x8c0 fs/jfs/jfs_dmap.c:2305
 dbFreeDmap+0x61/0x1a0 fs/jfs/jfs_dmap.c:2054
 dbFree+0x250/0x540 fs/jfs/jfs_dmap.c:379
 txFreeMap+0x8f1/0xd70 fs/jfs/jfs_txnmgr.c:2529
 txUpdateMap+0x3cd/0xc50 fs/jfs/jfs_txnmgr.c:2325
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x610/0xb70 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
