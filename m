Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A93563DA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiK3P7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiK3P7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:59:38 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6B581D85
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:59:37 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id x5-20020a6bda05000000b006db3112c1deso11423565iob.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31oMlGVxdTNvE3N0DrgczjpMQQxH9AHS0L7H6mJK5k8=;
        b=NJZvsnEUziyUebtd3XWbZiRFhX/NaJGF8XlP4+keTcAqOjuiwH184W2hgp/kUIaY8T
         SntYx8Kfa1K+81Tm1acz+YkFDGVpiJSYX8DocMMxFdetfDU2bXNabNRnUCaNoFM2MEgq
         7ufZ+zqRQD8jXGZQS6SUE98nRQYcolvvnFgI20PwHVyPDwxproUTAsvOZZANzp3MNf0a
         /hX+CBTIQ7pPBQ8A0fTysT2cy0l8FloU1c+xfQIBL354wERacw+fNAu/xpTbV3mG6MPF
         yXzemGzl6rhiKYJMyWa4QAaY0xDKjvt+JXxAoGeJj/lS3tSNGMA/dHHM4bDtc97T6sT8
         H7Pw==
X-Gm-Message-State: ANoB5pnEPj3ZI67rj63esytFJcC4f8zmPSilWS8N5I04iI6OV1uxARo0
        la73BbZNxHf1PEgRUXx4Nq++FiRc4JHnqDCRpRUnoXQG+b+N
X-Google-Smtp-Source: AA0mqf5BjNiEaWx5JmVfaBMvIGNaWf35nkooGqwNsv0860gyBP48maw+yT9Ajj01swyjvd44SXcKgpmYmZ3Z+sQ2tsDabcfoG6ld
MIME-Version: 1.0
X-Received: by 2002:a5d:860b:0:b0:6da:46b4:85f6 with SMTP id
 f11-20020a5d860b000000b006da46b485f6mr19898813iol.147.1669823976659; Wed, 30
 Nov 2022 07:59:36 -0800 (PST)
Date:   Wed, 30 Nov 2022 07:59:36 -0800
In-Reply-To: <00000000000034d16305e50acc8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7610f05eeb23004@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in do_journal_end (2)
From:   syzbot <syzbot+845cd8e5c47f2a125683@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com, jack@suse.cz, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, neilb@suse.de,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org, yi.zhang@huawei.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    01f856ae6d0c Merge tag 'net-6.1-rc8-2' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1461a85b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=845cd8e5c47f2a125683
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109da15b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11639425880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5428d604f56a/disk-01f856ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e953d290d254/vmlinux-01f856ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f71610a4904/bzImage-01f856ae.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2ea230629718/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+845cd8e5c47f2a125683@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in set_buffer_uptodate include/linux/buffer_head.h:148 [inline]
BUG: KASAN: null-ptr-deref in do_journal_end+0x155f/0x4a30 fs/reiserfs/journal.c:4081
Read of size 8 at addr 0000000000000000 by task syz-executor603/3632

CPU: 0 PID: 3632 Comm: syz-executor603 Not tainted 6.1.0-rc7-syzkaller-00101-g01f856ae6d0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_report+0xed/0x1f0 mm/kasan/report.c:398
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 set_buffer_uptodate include/linux/buffer_head.h:148 [inline]
 do_journal_end+0x155f/0x4a30 fs/reiserfs/journal.c:4081
 reiserfs_sync_fs+0xbb/0x130 fs/reiserfs/super.c:78
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x310 fs/super.c:474
 kill_block_super+0x79/0xd0 fs/super.c:1428
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1186
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x664/0x2070 kernel/exit.c:820
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f745e18eac9
Code: Unable to access opcode bytes at 0x7f745e18ea9f.
RSP: 002b:00007ffd72d53218 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f745e205350 RCX: 00007f745e18eac9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00007f745e1ffe40
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 00007f745e205350
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
==================================================================

