Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E623F63EFF9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiLALyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLALyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:54:44 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1188B4EC12
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:54:42 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id l21-20020a5d9315000000b006df7697880aso1346850ion.23
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39Mgqh2uz2rVDVflMB9s+soGI9KxsGosN2jFzjtM6hs=;
        b=sjG6+MQkqDCqbBhMPDuXLZkNCoFiOqhFJRSd2Vov2bLGR/BkgAFmKj33zimddl3/rU
         yERg085n7yiivJ27Ix2WGL3zOAv96Ac0A1TIEQ4wZFc07gy014M1O4M9N8795AcCaczw
         KBemoKX4LiD4bNWSPaa265mmbiE7mj+SetY4wXX1kQriKSvdQKnfNY/Qfzi6NhGDTfs2
         SoiSGDZpe7Ptpyz9TxJsz/Pk6c0lS4NThbt80BlBElUa1eULGauAM5b7+wb63f9tz6uU
         wUUzwhxPxHVW00ROxklwrD0lPZVanGE44QjEV2WxcFOGMjO1e2ABi3kH70oRRZQJZCsm
         HhqA==
X-Gm-Message-State: ANoB5pnHAQDcnABh2xKqL8ScgfU0EYVxFQbu8b3cDBiEcj1zs0CXy86V
        H3JgRa9cBn9pkqOwRggDjtVw3z3+50qUh0SnCIf6g536OqIi
X-Google-Smtp-Source: AA0mqf6xmnKB6O/ANW/EUlClxL68VUQebuCb5Bk6IlRaJUaFAwQfGN8M6QKXzW4aCjmlw4Xfk8/CLg8tUMlvxdxU5d0/YXJ2tML6
MIME-Version: 1.0
X-Received: by 2002:a6b:f414:0:b0:6d1:88ee:a64f with SMTP id
 i20-20020a6bf414000000b006d188eea64fmr22004077iog.61.1669895681429; Thu, 01
 Dec 2022 03:54:41 -0800 (PST)
Date:   Thu, 01 Dec 2022 03:54:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7574205eec2e2ad@google.com>
Subject: [syzbot] memory leak in z_erofs_do_read_page
From:   syzbot <syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com>
To:     chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
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

syzbot found the following issue on:

HEAD commit:    ef4d3ea40565 afs: Fix server->active leak in afs_put_server
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1251434b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=979161df0e247659
dashboard link: https://syzkaller.appspot.com/bug?extid=6f8cd9a0155b366d227f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1102d8d5880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1549a85b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3221db92d084/disk-ef4d3ea4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/909a41154e5c/vmlinux-ef4d3ea4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31207496b5e3/bzImage-ef4d3ea4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/53f3c05f9892/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811009c7f8 (size 136):
  comm "syz-executor227", pid 3659, jiffies 4294973830 (age 12.500s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821db19b>] kmem_cache_zalloc include/linux/slab.h:679 [inline]
    [<ffffffff821db19b>] z_erofs_alloc_pcluster fs/erofs/zdata.c:152 [inline]
    [<ffffffff821db19b>] z_erofs_register_pcluster fs/erofs/zdata.c:497 [inline]
    [<ffffffff821db19b>] z_erofs_collector_begin fs/erofs/zdata.c:576 [inline]
    [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740 fs/erofs/zdata.c:728
    [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580 fs/erofs/zdata.c:1670
    [<ffffffff814bc0d6>] read_pages+0x86/0x3d0 mm/readahead.c:161
    [<ffffffff814bc60d>] page_cache_ra_unbounded+0x1ed/0x220 mm/readahead.c:270
    [<ffffffff814bcfe9>] do_page_cache_ra mm/readahead.c:300 [inline]
    [<ffffffff814bcfe9>] page_cache_ra_order+0x399/0x410 mm/readahead.c:560
    [<ffffffff814bd48d>] ondemand_readahead+0x42d/0x640 mm/readahead.c:682
    [<ffffffff814bd7d8>] page_cache_sync_ra+0x138/0x140 mm/readahead.c:709
    [<ffffffff814ac448>] page_cache_sync_readahead include/linux/pagemap.h:1213 [inline]
    [<ffffffff814ac448>] filemap_get_pages+0x158/0xa00 mm/filemap.c:2581
    [<ffffffff814ace2e>] filemap_read+0x13e/0x520 mm/filemap.c:2675
    [<ffffffff814ad3e9>] generic_file_read_iter+0x1d9/0x280 mm/filemap.c:2821
    [<ffffffff815f782f>] __kernel_read+0x13f/0x340 fs/read_write.c:428
    [<ffffffff822729ac>] integrity_kernel_read+0x2c/0x40 security/integrity/iint.c:199
    [<ffffffff82276d4c>] ima_calc_file_hash_tfm+0x11c/0x1d0 security/integrity/ima/ima_crypto.c:485
    [<ffffffff82277131>] ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
    [<ffffffff82277131>] ima_calc_file_hash+0xf1/0xa70 security/integrity/ima/ima_crypto.c:573
    [<ffffffff82278b57>] ima_collect_measurement+0x307/0x380 security/integrity/ima/ima_api.c:292
    [<ffffffff82274dbd>] process_measurement+0x7cd/0xdb0 security/integrity/ima/ima_main.c:337

BUG: memory leak
unreferenced object 0xffff88811009ca18 (size 136):
  comm "syz-executor227", pid 3663, jiffies 4294974353 (age 7.270s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821db19b>] kmem_cache_zalloc include/linux/slab.h:679 [inline]
    [<ffffffff821db19b>] z_erofs_alloc_pcluster fs/erofs/zdata.c:152 [inline]
    [<ffffffff821db19b>] z_erofs_register_pcluster fs/erofs/zdata.c:497 [inline]
    [<ffffffff821db19b>] z_erofs_collector_begin fs/erofs/zdata.c:576 [inline]
    [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740 fs/erofs/zdata.c:728
    [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580 fs/erofs/zdata.c:1670
    [<ffffffff814bc0d6>] read_pages+0x86/0x3d0 mm/readahead.c:161
    [<ffffffff814bc60d>] page_cache_ra_unbounded+0x1ed/0x220 mm/readahead.c:270
    [<ffffffff814bcfe9>] do_page_cache_ra mm/readahead.c:300 [inline]
    [<ffffffff814bcfe9>] page_cache_ra_order+0x399/0x410 mm/readahead.c:560
    [<ffffffff814bd48d>] ondemand_readahead+0x42d/0x640 mm/readahead.c:682
    [<ffffffff814bd7d8>] page_cache_sync_ra+0x138/0x140 mm/readahead.c:709
    [<ffffffff814ac448>] page_cache_sync_readahead include/linux/pagemap.h:1213 [inline]
    [<ffffffff814ac448>] filemap_get_pages+0x158/0xa00 mm/filemap.c:2581
    [<ffffffff814ace2e>] filemap_read+0x13e/0x520 mm/filemap.c:2675
    [<ffffffff814ad3e9>] generic_file_read_iter+0x1d9/0x280 mm/filemap.c:2821
    [<ffffffff815f782f>] __kernel_read+0x13f/0x340 fs/read_write.c:428
    [<ffffffff822729ac>] integrity_kernel_read+0x2c/0x40 security/integrity/iint.c:199
    [<ffffffff82276d4c>] ima_calc_file_hash_tfm+0x11c/0x1d0 security/integrity/ima/ima_crypto.c:485
    [<ffffffff82277131>] ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
    [<ffffffff82277131>] ima_calc_file_hash+0xf1/0xa70 security/integrity/ima/ima_crypto.c:573
    [<ffffffff82278b57>] ima_collect_measurement+0x307/0x380 security/integrity/ima/ima_api.c:292
    [<ffffffff82274dbd>] process_measurement+0x7cd/0xdb0 security/integrity/ima/ima_main.c:337



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
