Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F260764F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJULfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJULfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:35:01 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53441277D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:34:57 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id q12-20020a5d834c000000b006bc2cb1994aso2514295ior.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ia/35krEiM4+20rku5K9XHZO0EC9eKdsLPC16lui58=;
        b=vnUxMZU1v7bj+W8Ladz0ukbTYNzr+gRuPV5q+FIVW2gXEoqPtc0epUzUv7TUDHD0Ya
         3pNSoMvhajIOWuHkSBZzGg0jj9YI2bRDMTUZ6HVtVlPG4bdWg9WYYGOyTEx2U5sp6+HB
         Mo6I36C1DUMT+3k2JqDgMQ9JT0nFb4fWqc/pzkcOHGxkApmQCPVetxBYON+9Yw0G1KHn
         XC/isM5/7BePyz1m9h8frWlgdiNuh6GGHAbG+eOeN8PU1T9HcVTLM11urnqyxSyqUgsY
         eHA6ijaSGZtfNcvV0+1Bm+3ig6uWPcklYXH9196ZTzuwQqtQPPiwRQjxPIi+NaGvcGAa
         NP+g==
X-Gm-Message-State: ACrzQf1/EvoEZyGpUz3TLPEkLup0/HiUJIYEbn987scmgolb7NkNURzC
        ZMM2d1s8kzdUfHDvYEBA5M1D89IxcWmWgp3Vt2hxlg8/tmcl
X-Google-Smtp-Source: AMsMyM6HoeU0DIIBTQ7IHchf+dHlOFjfwI4tIaaIrRM8CrfuQfFbx2BXJUtcateLEcYagwzZcOTx78wqt0AS5EMQKfq/KFpbf3Jo
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:15c9:b0:2e1:a5b6:7e25 with SMTP id
 q9-20020a056e0215c900b002e1a5b67e25mr13016488ilu.185.1666352081335; Fri, 21
 Oct 2022 04:34:41 -0700 (PDT)
Date:   Fri, 21 Oct 2022 04:34:41 -0700
In-Reply-To: <000000000000ca93e205eb893680@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0fe3e05eb89d308@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in dbFreeBits
From:   syzbot <syzbot+cf96cd135c5e00252e3b@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, paskripkin@gmail.com, r33s3n6@gmail.com,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4d48f589d294 Add linux-next specific files for 20221021
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=130d1e4a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4b7d600a5739a6
dashboard link: https://syzkaller.appspot.com/bug?extid=cf96cd135c5e00252e3b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dcd48c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a881e2880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c86bd0b39a0/disk-4d48f589.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/074059d37f1f/vmlinux-4d48f589.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6ac10f1c36b9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf96cd135c5e00252e3b@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1681:12
shift exponent -256 is negative
CPU: 1 PID: 3602 Comm: syz-executor318 Not tainted 6.1.0-rc1-next-20221021-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 dbFreeBits.cold-0x5/0x72
 dbAllocAny+0xa4/0x1a0 fs/jfs/jfs_dmap.c:1512
 dbAlloc+0x46d/0xa70 fs/jfs/jfs_dmap.c:869
 extBalloc fs/jfs/jfs_extent.c:321 [inline]
 extAlloc+0x4e7/0xeb0 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x661/0xa90 fs/jfs/inode.c:248
 __block_write_begin_int+0x3b9/0x14b0 fs/buffer.c:1991
 __block_write_begin fs/buffer.c:2041 [inline]
 block_write_begin+0xb5/0x440 fs/buffer.c:2102
 jfs_write_begin+0x2d/0xd0 fs/jfs/inode.c:304
 generic_perform_write+0x252/0x570 mm/filemap.c:3771
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3899
 generic_file_write_iter+0xdf/0x350 mm/filemap.c:3931
 call_write_iter include/linux/fs.h:2191 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_writev+0x1aa/0x630 fs/read_write.c:934
 do_pwritev+0x1b6/0x270 fs/read_write.c:1031
 __do_sys_pwritev2 fs/read_write.c:1090 [inline]
 __se_sys_pwritev2 fs/read_write.c:1081 [inline]
 __x64_sys_pwritev2+0xeb/0x150 fs/read_write.c:1081
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f93dbe84f69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc412c8fb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f93dbe84f69
RDX: 0000000000000002 RSI: 0000000020003380 RDI: 0000000000000003
RBP: 00007f93dbe44730 R08: 0000000002000000 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00083878000000fc R15: 0000000000000000
 </TASK>
================================================================================

