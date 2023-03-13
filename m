Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8081C6B8190
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCMTQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCMTQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:16:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BC97B4A5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:16:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so12785391pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678734962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/5Rie9XNH3O01C6i6sTjO1ub7buneGgIQ/uoN2kKxpA=;
        b=AA5+ghPWKWiW+1KgOlt3EELbSymxoONAvDtzj7hTgYI/hABHvEjfK/tKrf4irLSPlv
         xs4XMwIomczVBXmrGT1Md4+UazJdu8QXaVuUvgp6WxWgRbhjsKVs4BhYmCN/iJCrWoON
         +ZbfmY3YIfJbXQOrqAEk1wJe7YTEaiZw8CuW5tlcIoAwOdVw/DZ4JOgGaFUmDG6YlWyS
         UC6O/vmh8uuQIOPkZ/VLjB0HXI3T9Xpn/UYjTYHwVtbU50zMzLNXRbUeIoVe+r8JW8YJ
         cm06b1vxuDjLDAih3rWlXdEadyTO5NisuN8Se+8dJDrsWChcOgdeA7ib116aXqkekawh
         xPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678734962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5Rie9XNH3O01C6i6sTjO1ub7buneGgIQ/uoN2kKxpA=;
        b=saFotJUPwYWCLf80FHVLselNDczJr6lnzYQui+T07qi285Y2x3CaRk4vVT9KetMIs9
         jF9pL2kXOLd5uM1/hAt2mN50Lk+yVtIUa9QVCFqrbI2DB4EAI/UcSThGVcLc+IX7O8Ai
         iBdhBiDtd/fi8qd31PnAS2xzjuovH2HngZvCOEPZF8WRaI2LPOkbPEqsKzaKIwVkVK+I
         YLIpikRud4bgYyM3auChHy1t5ofdXQy4hWmnlRzFvVVTQHVLWrojHBn73nRn3LBqWKbs
         +SE8v155mcQXRXPbplcRY3lkhDFt6aN+CxKXiLL6/xWW80I6R8M0nyB7BXHKa1hBUWVd
         nI9A==
X-Gm-Message-State: AO0yUKW5aK4RGORVkXFK+Y07lbQf2C1GUzsFeeLKDWArAFEAF993FoZc
        sW1Xa1/sTNaEwtQ+8PBkjqOqW/hra/tpGR8J6uj5KA==
X-Google-Smtp-Source: AK7set/F5+iUuSMqKwLnpl/qSzw4NwDDL0YxjMKY4s1y/RL/YAu8AkGwNHieemzqwlK+eQyqdHPjng==
X-Received: by 2002:a17:903:338c:b0:1a0:42ba:8910 with SMTP id kb12-20020a170903338c00b001a042ba8910mr341280plb.10.1678734961675;
        Mon, 13 Mar 2023 12:16:01 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78259000000b005a8bdc18453sm99917pfn.35.2023.03.13.12.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:16:01 -0700 (PDT)
Date:   Mon, 13 Mar 2023 12:15:57 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] [mm?] kernel BUG in hpage_collapse_scan_file
Message-ID: <20230313191557.6lm53ndvwoxtf5dz@google.com>
References: <000000000000226a6105f6954b47@google.com>
 <CAAa6QmSH-c4voB2vg=ohdeQwmGDJ8X5rUw97-99cFkVaOPD5mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAa6QmSH-c4voB2vg=ohdeQwmGDJ8X5rUw97-99cFkVaOPD5mg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 10 17:02, Zach O'Keefe wrote:
> On Fri, Mar 10, 2023 at 4:52 PM syzbot
> <syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    857f1268a591 Merge tag 'objtool-core-2023-03-02' of git://..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=168e1032c80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9578faa5475acb35fa50
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179e4e12c80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119cce98c80000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/b3b7a7e333f1/disk-857f1268.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/5940be1cf171/vmlinux-857f1268.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/986015398e4a/bzImage-857f1268.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > kernel BUG at mm/khugepaged.c:1823!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 5097 Comm: syz-executor220 Not tainted 6.2.0-syzkaller-13154-g857f1268a591 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
> > RIP: 0010:collapse_file mm/khugepaged.c:1823 [inline]
> > RIP: 0010:hpage_collapse_scan_file+0x67c8/0x7580 mm/khugepaged.c:2233
> > Code: 00 00 89 de e8 c9 66 a3 ff 31 ff 89 de e8 c0 66 a3 ff 45 84 f6 0f 85 28 0d 00 00 e8 22 64 a3 ff e9 dc f7 ff ff e8 18 64 a3 ff <0f> 0b f3 0f 1e fa e8 0d 64 a3 ff e9 93 f6 ff ff f3 0f 1e fa 4c 89
> > RSP: 0018:ffffc90003dff4e0 EFLAGS: 00010093
> > RAX: ffffffff81e95988 RBX: 00000000000001c1 RCX: ffff8880205b3a80
> > RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 00000000000001c1
> > RBP: ffffc90003dff830 R08: ffffffff81e90e67 R09: fffffbfff1a433c3
> > R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
> > R13: ffffc90003dff6c0 R14: 00000000000001c0 R15: 0000000000000000
> > FS:  00007fdbae5ee700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fdbae6901e0 CR3: 000000007b2dd000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  madvise_collapse+0x721/0xf50 mm/khugepaged.c:2693
> >  madvise_vma_behavior mm/madvise.c:1086 [inline]
> >  madvise_walk_vmas mm/madvise.c:1260 [inline]
> >  do_madvise+0x9e5/0x4680 mm/madvise.c:1439
> >  __do_sys_madvise mm/madvise.c:1452 [inline]
> >  __se_sys_madvise mm/madvise.c:1450 [inline]
> >  __x64_sys_madvise+0xa5/0xb0 mm/madvise.c:1450
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7fdbae65dc39
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fdbae5ee2f8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> > RAX: ffffffffffffffda RBX: 00007fdbae6e64b8 RCX: 00007fdbae65dc39
> > RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
> > RBP: 00007fdbae6e64b0 R08: 0000000000000001 R09: 0000000000000033
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdbae5ee300
> > R13: 0000000000000001 R14: 00007fdbae5ee400 R15: 0000000000022000
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:collapse_file mm/khugepaged.c:1823 [inline]
> > RIP: 0010:hpage_collapse_scan_file+0x67c8/0x7580 mm/khugepaged.c:2233
> > Code: 00 00 89 de e8 c9 66 a3 ff 31 ff 89 de e8 c0 66 a3 ff 45 84 f6 0f 85 28 0d 00 00 e8 22 64 a3 ff e9 dc f7 ff ff e8 18 64 a3 ff <0f> 0b f3 0f 1e fa e8 0d 64 a3 ff e9 93 f6 ff ff f3 0f 1e fa 4c 89
> > RSP: 0018:ffffc90003dff4e0 EFLAGS: 00010093
> > RAX: ffffffff81e95988 RBX: 00000000000001c1 RCX: ffff8880205b3a80
> > RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 00000000000001c1
> > RBP: ffffc90003dff830 R08: ffffffff81e90e67 R09: fffffbfff1a433c3
> > R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
> > R13: ffffc90003dff6c0 R14: 00000000000001c0 R15: 0000000000000000
> > FS:  00007fdbae5ee700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fdbae6901e0 CR3: 000000007b2dd000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> 
> I had a look at this, and the issue is stemming from failed (due to
> error injection here) xas_store() in collapse_file() (in this report,
> specifically was picking on shmem after MADV_REMOVE punch). This puts
> the xa_state into an error state (-ENOMEM) and the subsequent
> xas_next() will (a) not increment xas->xa_index (which trips the
> VM_BUG_ON), and (b) returns NULL (which is confusing, since AFAIU,
> that's a "valid" entry for a truncated page cache entry, but also
> being used to indicate error).
> 
> I think the right thing to do is to check xas_invalid() at the top of
> the loop, or checking return value of all those xas_store()'s and
> taking appropriate action. There is also the possibility this never
> occurs in practice due to the "Ensure we have slots for all the pages
> in the range" check at the top of the function, and that we are only
> able to trip this from error injection.

Right, so looking a bit more into this this morning, my last question about
whether the xas_create_range() check at the top of collapse_file() guaranteeing
us the needed slots (and that syzbot was only able to trip this due to error
injection) is plainly false: we are actually attempting to allocate memory here,
so clearly the slots weren't already available - duh.

Now, why isn't that well-intending pre-reservation enough? Well, we are dropping
the xarray lock ~ every iteration of the for-loop, then relocking it to store
the hugpage at the current index. While the lock is dropped, there isn't
anything protecting us from racing with page_cache_delete() -- here, from

	__filemap_remove_folio()
	truncate_inode_folio()
	shmem_undo_range()
	shmem_truncate_range()
	vfs_fallocate()
	madvise_remove()

which can then remove slots out from under us:

	xas_delete_node()
	update_node()
	xas_store()
	page_cache_delete()

So, I think this code needs to be guarded against concurrent slot removal.

I think just giving up is the best (i.e. simplest) route (vs taking some
additional measures to serialize vs concurrent removal). One concern is that if
we've encountered ENOMEM situation where xas_store() is failing, then the
rollback code also won't work correctly. However, rollback xas_store() will
either replace the current hpage entry with the previous entry, or replace it
will a NULL entry (had it been a hole previously) -- neither of which will
involve any additional allocations -- so we're safe.

Patch to fix this should be following in the next day or so.


