Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1B267D4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjAZS52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjAZS5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:57:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BBC2A9A1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=x1s0NexqBs6SB0lDAmiO+zAwVXu4qrWxnIdKYFnSVPI=; b=qUhw8xEhcs5dYFOSIuLnty3Ic4
        UHD/bjp1JAo+c/RHGuQg7pFK+1G4fmO9JZC85hwXRT/k5uu18glutpnen5jdltNIyACHXhokMXA6y
        miheWAn9y1bzE7j28iLG9/ODmQ+K35V4vIncELfGZT+LM+HnQ/xrexPFoCRMihcag72JZfUk4+uqT
        YeMtPgrpA7wXyNO70fossxzB9JQgU9RovuumkgppCaPJr4wIgUSoe4f30QKBwlu2epXVKTziP2TpR
        97yrD6bmbqj2xWXtHK5IsVYhy45hZJFhd2GMhjUQe0/Ia9VtXQjy66TJAbavkgcCUjx+fk3/Zp5Q7
        XjhHGKuw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL7Qw-0070Yz-DD; Thu, 26 Jan 2023 18:57:14 +0000
Date:   Thu, 26 Jan 2023 18:57:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: kernel BUG in page_add_anon_rmap
Message-ID: <Y9LNCouUvsUFCYkT@casper.infradead.org>
References: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 11:59:16PM +0000, Sanan Hasanov wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.
> 
> We enhanced the coverage of the configuration file using our tool, klocalizer.
> 
> Kernel Branch: 6.2.0-rc5-next-20230124
> Kernel config: https://drive.google.com/file/d/1MZSgIF4R9QfikEuF5siUIZVPce-GiJQK/view?usp=sharing
> Reproducer: https://drive.google.com/file/d/1H5KWkT9VVMWTUVVgIaZi6J-fmukRx-BM/view?usp=sharing
> 
> Thank you!
> 
> Best regards,
> Sanan Hasanov
> 
> head: 0000000000020000 0000000000000000 00000004ffffffff ffff8881002b8000
> page dumped because: VM_BUG_ON_PAGE(!first && (flags & (( rmap_t)((((1UL))) << (0)))))
> ------------[ cut here ]------------

I know it says "cut here" and you did that, but including just a few
lines above that would be so much more helpful.  I can infer that this
is a multi-page folio, but more than that is hard to tell.

> kernel BUG at mm/rmap.c:1248!

That tracks with VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);

> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 7 PID: 14932 Comm: syz-executor.1 Not tainted 6.2.0-rc5-next-20230124 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:page_add_anon_rmap+0xddd/0x11c0 mm/rmap.c:1248
> Code: c0 ff 48 8b 34 24 48 89 df e8 1f ff 07 00 49 89 c6 e9 85 f6 ff ff e8 52 73 c0 ff 48 c7 c6 c0 3c d8 89 48 89 ef e8 b3 23 f8 ff <0f> 0b e8 3c 73 c0 ff 48 c7 c6 00 3b d8 89 48 89 ef e8 9d 23 f8 ff
> RSP: 0018:ffffc9000c56f7b0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff88807efc6f30 RCX: 0000000000000000
> RDX: ffff8880464fd7c0 RSI: ffffffff81be733d RDI: fffff520018adedb
> RBP: ffffea0000c68080 R08: 0000000000000056 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000c68000
> R13: 0000000000000001 R14: ffffea0000c68088 R15: 0000000000000000
> FS:  00007f717898a700(0000) GS:ffff888119f80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7178947d78 CR3: 000000004a9e6000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  remove_migration_pte+0xaa6/0x1390 mm/migrate.c:261

                        if (folio_test_anon(folio))
                                page_add_anon_rmap(new, vma, pvmw.address,
                                                   rmap_flags);

Earlier in that function, we had:
                if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
                        rmap_flags |= RMAP_EXCLUSIVE;

so that also makes sense.  We can also infer that RMAP_COMPOUND wasn't
set, so we're trying to do just one page from the folio.

All right, back to rmap.c:

                first = atomic_inc_and_test(&page->_mapcount);

So first is clearly false (ie _mapcount was not -1), implying somebody
else already mapped this page.  Not really sure what's going on at
this point.  Seems unlikely that the folio changes in
remove_migration_pte() are responsible since they're from last January.
Huang has some more changes to migrate.c that I don't feel qualified
to judge.

Nothing's jumping out at me as obviously wrong.  Is it possible to
do a bisect?

>  rmap_walk_anon+0x23a/0x5b0 mm/rmap.c:2433
>  rmap_walk+0x96/0xd0 mm/rmap.c:2509
>  remove_migration_ptes mm/migrate.c:294 [inline]
>  migrate_folio_move mm/migrate.c:1307 [inline]
>  migrate_pages_batch+0x15f8/0x3910 mm/migrate.c:1809
>  migrate_pages+0x1b56/0x22e0 mm/migrate.c:1961
>  do_mbind mm/mempolicy.c:1329 [inline]
>  kernel_mbind+0x4c0/0x790 mm/mempolicy.c:1476
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f717788edcd
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7178989bf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
> RAX: ffffffffffffffda RBX: 00007f71779bc050 RCX: 00007f717788edcd
> RDX: 0000000000000004 RSI: 0000000000001000 RDI: 0000000020002000
> RBP: 00007f71778fc59c R08: 00000000000007ff R09: 0000000000000002
> R10: 00000000200000c0 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd2c012f6f R14: 00007ffd2c013110 R15: 00007f7178989d80
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:page_add_anon_rmap+0xddd/0x11c0 mm/rmap.c:1248
> Code: c0 ff 48 8b 34 24 48 89 df e8 1f ff 07 00 49 89 c6 e9 85 f6 ff ff e8 52 73 c0 ff 48 c7 c6 c0 3c d8 89 48 89 ef e8 b3 23 f8 ff <0f> 0b e8 3c 73 c0 ff 48 c7 c6 00 3b d8 89 48 89 ef e8 9d 23 f8 ff
> RSP: 0018:ffffc9000c56f7b0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff88807efc6f30 RCX: 0000000000000000
> RDX: ffff8880464fd7c0 RSI: ffffffff81be733d RDI: fffff520018adedb
> RBP: ffffea0000c68080 R08: 0000000000000056 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000c68000
> R13: 0000000000000001 R14: ffffea0000c68088 R15: 0000000000000000
> FS:  00007f717898a700(0000) GS:ffff888119f80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7178947d78 CR3: 000000004a9e6000 CR4: 0000000000350ee0
> 
