Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5157261E5D0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 21:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKFUCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 15:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKFUCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 15:02:47 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BCC11162
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 12:02:47 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id j7-20020a056e02154700b003007885e7beso7463450ilu.20
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 12:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kW1a4fRbEa1SEBmyH4rjxoqQpC2WFDzr69iE3nyWhiU=;
        b=n9HkQW85TUtoT6L2IQS7xe5iymjcHHR7TNsHpnUZMdjIl5thpnNmbHvXuWME6D28t8
         71RQ1kKMLHOnyog/TeTwtZAoaPjjxCfKHwrfP6DA+TNWN+B/tF5zp/ZCoaSP+oN/klyu
         0W6pUPvz6YYs7i136BxjCn3T6zVMkX4fx1osq9cNyn1Zwb5yGYS4rV9AGRSXffaZK/8Q
         vgL3XVbAXxb2V9EPRfAS2AP8qtXfwI0GQE18rNUotETDOLXFuvcVvxZF4uRLEBYZfBvk
         kSNwIe18y+2Dlo6w5SEQBu2B0xuztmYYNfh1Rsky5uSyuz79tORBm3AOWF7VtTQAn9G+
         xCQQ==
X-Gm-Message-State: ACrzQf04RFGLHr8Xg7vjHt75YyvNpIVC33SosNR7l7PIf5nN1/tEGmE1
        MCcjiBI5gYg5x2Ms84CYN2s3JXcG301K5+ZUj/48J7hgPSJG
X-Google-Smtp-Source: AMsMyM4ky7JZui9hRI4tDDDeI3wLOKEV1GDV4vqhkIUxR1RGQiu+ldEcDus+Dwu/dHlag9wbgVkUkiX3e2BUNFwt4pzJg1zXP/pF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1688:b0:2fc:50d7:6966 with SMTP id
 f8-20020a056e02168800b002fc50d76966mr26208240ila.51.1667764966542; Sun, 06
 Nov 2022 12:02:46 -0800 (PST)
Date:   Sun, 06 Nov 2022 12:02:46 -0800
In-Reply-To: <000000000000c7e7be05eaa93401@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006653e305ecd2ca03@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in dbJoin
From:   syzbot <syzbot+667a6d667592227b1452@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    b208b9fbbcba Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=162c2866880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7e100ed8aaa828e
dashboard link: https://syzkaller.appspot.com/bug?extid=667a6d667592227b1452
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f7ffb1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f9a066880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92fde6d92d82/disk-b208b9fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae3dbdb3faf8/vmlinux-b208b9fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bbf4da09683c/bzImage-b208b9fb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/69e8cbb81983/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+667a6d667592227b1452@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2745:24
index 1426063360 is out of range for type 's8 [1365]'
CPU: 0 PID: 122 Comm: jfsCommit Not tainted 6.1.0-rc3-syzkaller-00288-gb208b9fbbcba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 dbJoin+0x2c7/0x2f0 fs/jfs/jfs_dmap.c:2745
 dbFreeBits+0x50d/0xd40 fs/jfs/jfs_dmap.c:2305
 dbFreeDmap fs/jfs/jfs_dmap.c:2054 [inline]
 dbFree+0x35e/0x660 fs/jfs/jfs_dmap.c:379
 txFreeMap+0x97c/0xd70 fs/jfs/jfs_txnmgr.c:2510
 xtTruncate+0xe74/0x32d0 fs/jfs/jfs_xtree.c:2467
 jfs_free_zero_link+0x3f5/0x680 fs/jfs/namei.c:758
 jfs_evict_inode+0x35a/0x440 fs/jfs/inode.c:153
 evict+0x2a4/0x620 fs/inode.c:664
 txUpdateMap+0x8eb/0xaa0 fs/jfs/jfs_txnmgr.c:2362
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x488/0xb80 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
================================================================================

