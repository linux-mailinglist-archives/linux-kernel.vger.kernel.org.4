Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BCE65EECA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjAEOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjAEOdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:33:21 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EEB5791F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:33:16 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id y11-20020a056e02178b00b0030c048d64a7so17189909ilu.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 06:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EE3LsWNibLxLYoVVm12EwAXtv+NkpUOR3oNx76/MwI=;
        b=H9iXI/4dLQlKLFqjRlyykK9ecnPaijc6OY/pPDizJ2jnEiFKz1O2A26t4PuenfdxsD
         SOdwS8p/bTVZJ2wTnStVs4m90BQwY9fAE4kprMWouEcqdq5eeDq/WHEkmTK9f8ZSSpLg
         SOEFW9XSMU/yT9OR0DBBuAe+Dg6664G+RwpOqYpomBWJabofRUOlDD3oLwIckf2P4AUh
         yV/cQdGVdxm1xmH8abNp6CfwGcfUupA5uyK6cglYbrE0haeHh0kRhSqGsKEiubmdEohM
         UFJGYtOC0xEuapduQSjF0D4Le42xzMsZt2b6VHbvuRjavF/qXF5KBxnsmLKH0AQrPdhK
         DXuA==
X-Gm-Message-State: AFqh2koq7sRV+MXNWu+CFXHfPNXMWGPYFBQbVHGBSXppXoPHNsHWQMgI
        LiyKN0VAubC0BrHeGXisc25QEm9pYnieJI0/9U5qYl0YXvOC
X-Google-Smtp-Source: AMrXdXtMgvmeF/e4yTusMr+YTqoJZNcvkWXaK41QWlBqub5lVVuHkK9IGjX2d8jwcR7tozTR9Txd3pKK9ZAUUcYQSK3E0K4DdGuu
MIME-Version: 1.0
X-Received: by 2002:a02:3907:0:b0:38a:9c57:2468 with SMTP id
 l7-20020a023907000000b0038a9c572468mr3776149jaa.154.1672929196084; Thu, 05
 Jan 2023 06:33:16 -0800 (PST)
Date:   Thu, 05 Jan 2023 06:33:16 -0800
In-Reply-To: <CANp29Y63rCdepVtantxdJEcvbRv0D61gfY_oGV7dgrmEGgPdLw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007796bd05f1852ec2@google.com>
Subject: Re: [syzbot] [erofs?] WARNING: CPU: NUM PID: NUM at
 mm/page_alloc.c:LINE get_page_from_freeli
From:   syzbot <syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, chao@kernel.org,
        hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, nogikh@google.com,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in get_page_from_freelist

------------[ cut here ]------------
WARNING: CPU: 1 PID: 4385 at mm/page_alloc.c:3829 rmqueue mm/page_alloc.c:3829 [inline]
WARNING: CPU: 1 PID: 4385 at mm/page_alloc.c:3829 get_page_from_freelist+0xbf3/0x2ce0 mm/page_alloc.c:4280
Modules linked in:
CPU: 1 PID: 4385 Comm: kworker/u5:1 Not tainted 6.2.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: erofs_unzipd z_erofs_decompressqueue_work
RIP: 0010:rmqueue mm/page_alloc.c:3829 [inline]
RIP: 0010:get_page_from_freelist+0xbf3/0x2ce0 mm/page_alloc.c:4280
Code: 48 c1 e8 03 42 80 3c 28 00 0f 85 18 1f 00 00 48 8b 03 f7 84 24 d8 00 00 00 00 80 00 00 48 89 44 24 68 74 08 41 83 fe 01 76 02 <0f> 0b 41 83 fe 09 0f 94 c2 41 83 fe 03 0f 96 c0 08 c2 88 54 24 50
RSP: 0018:ffffc900055e74d8 EFLAGS: 00010202
RAX: ffff88813fffae00 RBX: ffff88813fffc300 RCX: ffff88813fffabe8
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffc900055e7718
RBP: 0000000000000002 R08: 0000000000002b49 R09: 0000000000078534
R10: 0000000000002b48 R11: 0000000000000000 R12: 0000000000002b48
R13: dffffc0000000000 R14: 0000000000000009 R15: ffff88813fffa700
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff496515829 CR3: 000000000c48e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
 vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
 __vmalloc_area_node mm/vmalloc.c:3057 [inline]
 __vmalloc_node_range+0x978/0x13c0 mm/vmalloc.c:3227
 kvmalloc_node+0x156/0x1a0 mm/util.c:606
 kvmalloc include/linux/slab.h:737 [inline]
 kvmalloc_array include/linux/slab.h:755 [inline]
 kvcalloc include/linux/slab.h:760 [inline]
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1035 [inline]
 z_erofs_decompress_queue+0x6e2/0x3060 fs/erofs/zdata.c:1141
 z_erofs_decompressqueue_work+0x77/0xb0 fs/erofs/zdata.c:1153
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


Tested on:

commit:         88603b6d Linux 6.2-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1193edc6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46221e8203c7aca6
dashboard link: https://syzkaller.appspot.com/bug?extid=c3729cda01706a04fb98
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
