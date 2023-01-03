Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9160465BE53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbjACKmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbjACKmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:42:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B08FD0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:42:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A702F612DF;
        Tue,  3 Jan 2023 10:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672742531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YB/VfJyqR2Ctk6NUfTxqD1+8uBbSnAj8wJw27eWBLlA=;
        b=LVuNsQOyOc21/OmyYpLiteoEoDLNR5xR3DUXKpmoLOHNfHkw1ORbk+2HJwtSrDRtCCUnzL
        Ev738nBXfX/AEi7f7bwg9kgHBJLPqM+TDb0lRitqxpRqLbJUruRa+hyapdUFyzO/IAoU0a
        y2Q3OZ7MOE1R6lRl1P6sKXF3pOpBvow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672742531;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YB/VfJyqR2Ctk6NUfTxqD1+8uBbSnAj8wJw27eWBLlA=;
        b=FE54agbAjFRkSxSPALaZEWwTg1UCm/BELGcBm2rISnrkgO9eR1tyHl9RqK4bLtwWet0bJt
        r58UxtOVzQSYs3DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FF431392B;
        Tue,  3 Jan 2023 10:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tD18HoMGtGPNSgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 03 Jan 2023 10:42:11 +0000
Message-ID: <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
Date:   Tue, 3 Jan 2023 11:42:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
To:     kernel test robot <oliver.sang@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202212312021.bc1efe86-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/22 16:26, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed kernel_BUG_at_include/linux/mm.h due to commit (built with gcc-11):
> 
> commit: 0af8489b0216fa1dd83e264bef8063f2632633d7 ("mm, slub: remove percpu slabs with CONFIG_SLUB_TINY")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linux-next/master c76083fac3bae1a87ae3d005b5cb1cbc761e31d5]
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: default
> 	torture_type: tasks-tracing
> 
> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Looking at the full dump:

> [   25.780445][  T214] page:e660911a refcount:0 mapcount:0 mapping:00000000 index:0xedaeef00 pfn:0x2daee
> [   25.781618][  T214] page:0946d53a refcount:0 mapcount:0 mapping:00000000 index:0x0 pfn:0x2daec

OK, so we started dumping one page but then immediately went dumping
another. This means page_dump() tripped on itself.

Why did we dump the first page? The callback is

> [   25.812675][  T214]  dump_page+0x2a/0xc0
> [   25.813025][  T214]  ? _raw_spin_lock_irqsave+0x16/0x30
> [   25.813492][  T214]  folio_flags+0x23/0x70
> [   25.813945][  T214]  get_partial_node+0x89/0x290

We walk the partial list, and for a struct slab we check
pfmemalloc_match() thus slab_test_pfmemalloc() thus folio_test_active(),
which will do folio_flags(). That has two VM_BUG... checks but one requires
n > 0 which wouldn't be true here, so it has to be:
VM_BUG_ON_PGFLAGS(PageTail(page), page);

So page with pfn pfn:0x2daee is supposed to be a folio head of order 0 or
order 1 (probably), not larger due to the pfn. But it's a tail page, oops.
We start dumping it, but also create a folio of that, and then trip on
!folio_test_large(folio), because we try to evaluate folio_entire_mapcount()
in __dump_page(), which has that check.
So we start dumping the folio page, and that has pfn:0x2daec. Which means
the page pfn:0x2daee was tail with compound_head pointing to 0x2daec. So
0x2daec was order-2 at some point, with pfn:0x2daee being a 3rd tail page of 4.

> [   25.782360][  T214] flags: 0x0(zone=0)
> [   25.782705][  T214] raw: 00000000 e764d494 e6f205b4 00000000 00000000 00020000 ffffffff 00000000
> [   25.783445][  T214] raw: 00000000 00000000
> [   25.783809][  T214] page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
> [   25.784455][  T214] page_owner tracks the page as freed
> [   25.785164][  T214] page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 208, tgid 208 (systemd-udevd), ts 25780391126, free_ts 25780421356
> [   25.786859][  T214]  post_alloc_hook+0x1fa/0x280
> [   25.787266][  T214]  get_page_from_freelist+0x226/0x310
> [   25.787723][  T214]  __alloc_pages+0xdd/0x360
> [   25.788114][  T214]  alloc_slab_page+0x12d/0x200
> [   25.788517][  T214]  allocate_slab+0x6a/0x350
> [   25.788900][  T214]  new_slab+0x48/0xc0
> [   25.789258][  T214]  __slab_alloc_node+0xfb/0x270
> [   25.789749][  T214]  kmem_cache_alloc+0x8f/0x4e0
> [   25.790154][  T214]  getname_flags+0x33/0x2f0
> [   25.790538][  T214]  getname+0x1a/0x30
> [   25.790881][  T214]  do_sys_openat2+0xa5/0x1f0
> [   25.791278][  T214]  do_sys_open+0x8e/0xe0
> [   25.791636][  T214]  __ia32_sys_openat+0x2b/0x40
> [   25.792040][  T214]  __do_fast_syscall_32+0x72/0xd0
> [   25.792486][  T214]  do_fast_syscall_32+0x32/0x70
> [   25.792899][  T214]  do_SYSENTER_32+0x15/0x20
> [   25.793307][  T214] page last free stack trace:
> [   25.793701][  T214]  free_pcp_prepare+0x34f/0x940
> [   25.794123][  T214]  free_unref_page_prepare+0x29/0x210
> [   25.794577][  T214]  free_unref_page+0x3a/0x3b0
> [   25.794988][  T214]  __free_pages+0x187/0x1f0
> [   25.795378][  T214]  __free_slab+0x1fd/0x350
> [   25.795842][  T214]  free_slab+0x22/0x70
> [   25.796233][  T214]  free_to_partial_list+0x125/0x260
> [   25.796761][  T214]  do_slab_free+0x30/0x70
> [   25.801249][  T214]  kmem_cache_free+0x171/0x1e0
> [   25.801686][  T214]  putname+0x9f/0xf0
> [   25.802023][  T214]  do_sys_openat2+0xe2/0x1f0
> [   25.802411][  T214]  do_sys_open+0x8e/0xe0
> [   25.802781][  T214]  __ia32_sys_openat+0x2b/0x40
> [   25.803192][  T214]  __do_fast_syscall_32+0x72/0xd0
> [   25.803613][  T214]  do_fast_syscall_32+0x32/0x70
> [   25.804027][  T214]  do_SYSENTER_32+0x15/0x20

Yet the page owner info tells us, 0x2daee was most recently used as order-1,
and now it seems to be (based on the raw struct page dump) sitting on a pcplist.

So the events leading up to this could be something like:

- 0x2daee is order-1 slab folio of the inode cache, sitting on the partial list
- despite being on partial list, it's freed ???
- somebody else allocates order-2 page 0x2daec and uses it for whatever,
then frees it
- 0x2daec is reallocated as order-1 slab from names_cache, then freed
- we try to allocate from the slab page 0x2daee and trip on the PageTail

Except, the freeing of order-2 page would have reset the PageTail and
compound_head in 0x2daec, so this is even more complicated or involves some
extra race?

In any case, this is something a debug_pagealloc kernel could have a chance
of catching earlier. Would it be possible to enable CONFIG_DEBUG_PAGEALLOC
and DEBUG_PAGEALLOC_ENABLE_DEFAULT additionally to the rest of the
configuration, and repeat the test?

Separately we should also make the __dump_page() more resilient.

Thanks,
Vlastimil

> [   25.804432][  T214] ------------[ cut here ]------------
> [   25.804917][  T214] kernel BUG at include/linux/mm.h:825!
> [   25.805402][  T214] invalid opcode: 0000 [#1] SMP
> [   25.805820][  T214] CPU: 0 PID: 214 Comm: udevadm Tainted: G S                 6.1.0-rc2-00014-g0af8489b0216 #2 1c4d7707ec0ce574ed62a77e82a8580202758048
> [   25.806944][  T214] EIP: __dump_page.cold+0x282/0x369
> [   25.807376][  T214] Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
> [   25.808960][  T214] EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
> [   25.809578][  T214] ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
> [   25.810168][  T214] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
> [   25.810803][  T214] CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
> [   25.811407][  T214] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   25.811999][  T214] DR6: fffe0ff0 DR7: 00000400
> [   25.812390][  T214] Call Trace:
> [   25.812675][  T214]  dump_page+0x2a/0xc0
> [   25.813025][  T214]  ? _raw_spin_lock_irqsave+0x16/0x30
> [   25.813492][  T214]  folio_flags+0x23/0x70
> [   25.813945][  T214]  get_partial_node+0x89/0x290
> [   25.814357][  T214]  __slab_alloc_node+0xbb/0x270
> [   25.814860][  T214]  kmem_cache_alloc_lru+0x8d/0x4e0
> [   25.815289][  T214]  ? __lock_release+0x3ec/0x410
> [   25.815697][  T214]  ? iget_locked+0x78/0x310
> [   25.816096][  T214]  alloc_inode+0x93/0x150
> [   25.816469][  T214]  iget_locked+0xdd/0x310
> [   25.816829][  T214]  ? lock_is_held_type+0x80/0xf0
> [   25.817264][  T214]  kernfs_get_inode+0x24/0xb0
> [   25.817670][  T214]  kernfs_iop_lookup+0xb5/0x1a0
> [   25.818087][  T214]  __lookup_slow+0xd9/0x2a0
> [   25.818479][  T214]  lookup_slow+0x50/0x90
> [   25.818847][  T214]  walk_component+0x19c/0x2c0
> [   25.819244][  T214]  path_lookupat+0xa3/0x270
> [   25.819627][  T214]  path_openat+0x307/0x3e0
> [   25.820007][  T214]  do_filp_open+0x7c/0x130
> [   25.820409][  T214]  do_sys_openat2+0x113/0x1f0
> [   25.820807][  T214]  do_sys_open+0x8e/0xe0
> [   25.821211][  T214]  __ia32_sys_openat+0x2b/0x40
> [   25.821622][  T214]  __do_fast_syscall_32+0x72/0xd0
> [   25.822057][  T214]  ? trace_hardirqs_on+0xa2/0x110
> [   25.822480][  T214]  ? __fput+0x19f/0x390
> [   25.822842][  T214]  ? lockdep_hardirqs_on_prepare+0x242/0x400
> [   25.823346][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> [   25.823823][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> [   25.824259][  T214]  ? lockdep_hardirqs_on_prepare+0x242/0x400
> [   25.824767][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> [   25.825254][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> [   25.825696][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> [   25.826155][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> [   25.826627][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> [   25.827056][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> [   25.827486][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> [   25.827929][  T214]  ? irqentry_exit_to_user_mode+0x23/0x30
> [   25.828423][  T214]  ? irqentry_exit+0x7f/0xc0
> [   25.828812][  T214]  do_fast_syscall_32+0x32/0x70
> [   25.829223][  T214]  do_SYSENTER_32+0x15/0x20
> [   25.829589][  T214]  entry_SYSENTER_32+0xa2/0xfb
> [   25.830003][  T214] EIP: 0xb7f8c549
> [   25.830330][  T214] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> [   25.831929][  T214] EAX: ffffffda EBX: 00000006 ECX: 006142a1 EDX: 002a8000
> [   25.832522][  T214] ESI: 00000000 EDI: 00000001 EBP: 00614024 ESP: bff3c4a0
> [   25.833123][  T214] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200246
> [   25.833738][  T214] Modules linked in:
> [   25.834062][  T214] ---[ end trace 0000000000000000 ]---
> [   25.834522][  T214] EIP: __dump_page.cold+0x282/0x369
> [   25.834960][  T214] Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
> [   25.836574][  T214] EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
> [   25.837183][  T214] ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
> [   25.837772][  T214] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
> [   25.838414][  T214] CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
> [   25.839011][  T214] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   25.839597][  T214] DR6: fffe0ff0 DR7: 00000400
> [   25.839995][  T214] Kernel panic - not syncing: Fatal exception
> [   25.840554][  T214] Kernel Offset: disabled


