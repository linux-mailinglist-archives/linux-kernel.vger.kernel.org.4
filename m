Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680B470A91F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjETQ3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 12:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 12:29:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C929124;
        Sat, 20 May 2023 09:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 302F360F78;
        Sat, 20 May 2023 16:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FB6C433AA;
        Sat, 20 May 2023 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684600166;
        bh=fTnQ3UUQGfx5X0prFzXPtTRMKF/u+s4ExF23SjpumIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1/lwdsQrUsOzmAxQPXk6OZR3fcv4Y6H1DgMU6+bALEJ5Ksl6aoJOox9GpBrAjN9Q
         xESjjU6gHJdRsTJogcOk8ud56izKpWovyso07qMC5bFSrdOcS0d6eQCQeMdaVFo3bw
         AtQt/L0HU5EHi3yc9fZXYtTUdKqnilRWUKVLqfbQ=
Date:   Sat, 20 May 2023 17:29:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jann Horn <jannh@google.com>, stable@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binder: fix UAF of alloc->vma in race with munmap()
Message-ID: <2023052002-nervy-juggling-c7a1@gregkh>
References: <20230519195950.1775656-1-cmllamas@google.com>
 <2023052032-lemon-backed-ccf2@gregkh>
 <ZGjCWI6kpaNuNiya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGjCWI6kpaNuNiya@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 12:51:36PM +0000, Carlos Llamas wrote:
> On Sat, May 20, 2023 at 10:55:02AM +0100, Greg Kroah-Hartman wrote:
> > On Fri, May 19, 2023 at 07:59:49PM +0000, Carlos Llamas wrote:
> > > [ cmllamas: clean forward port from commit 015ac18be7de ("binder: fix
> > >   UAF of alloc->vma in race with munmap()") in 5.10 stable. It is needed
> > >   in mainline after the revert of commit a43cfc87caaf ("android: binder:
> > >   stop saving a pointer to the VMA") as pointed out by Liam. The commit
> > >   log and tags have been tweaked to reflect this. ]
> > > 
> > > In commit 720c24192404 ("ANDROID: binder: change down_write to
> > > down_read") binder assumed the mmap read lock is sufficient to protect
> > > alloc->vma inside binder_update_page_range(). This used to be accurate
> > > until commit dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in
> > > munmap"), which now downgrades the mmap_lock after detaching the vma
> > > from the rbtree in munmap(). Then it proceeds to teardown and free the
> > > vma with only the read lock held.
> > > 
> > > This means that accesses to alloc->vma in binder_update_page_range() now
> > > will race with vm_area_free() in munmap() and can cause a UAF as shown
> > > in the following KASAN trace:
> > > 
> > >   ==================================================================
> > >   BUG: KASAN: use-after-free in vm_insert_page+0x7c/0x1f0
> > >   Read of size 8 at addr ffff16204ad00600 by task server/558
> > > 
> > >   CPU: 3 PID: 558 Comm: server Not tainted 5.10.150-00001-gdc8dcf942daa #1
> > >   Hardware name: linux,dummy-virt (DT)
> > >   Call trace:
> > >    dump_backtrace+0x0/0x2a0
> > >    show_stack+0x18/0x2c
> > >    dump_stack+0xf8/0x164
> > >    print_address_description.constprop.0+0x9c/0x538
> > >    kasan_report+0x120/0x200
> > >    __asan_load8+0xa0/0xc4
> > >    vm_insert_page+0x7c/0x1f0
> > >    binder_update_page_range+0x278/0x50c
> > >    binder_alloc_new_buf+0x3f0/0xba0
> > >    binder_transaction+0x64c/0x3040
> > >    binder_thread_write+0x924/0x2020
> > >    binder_ioctl+0x1610/0x2e5c
> > >    __arm64_sys_ioctl+0xd4/0x120
> > >    el0_svc_common.constprop.0+0xac/0x270
> > >    do_el0_svc+0x38/0xa0
> > >    el0_svc+0x1c/0x2c
> > >    el0_sync_handler+0xe8/0x114
> > >    el0_sync+0x180/0x1c0
> > > 
> > >   Allocated by task 559:
> > >    kasan_save_stack+0x38/0x6c
> > >    __kasan_kmalloc.constprop.0+0xe4/0xf0
> > >    kasan_slab_alloc+0x18/0x2c
> > >    kmem_cache_alloc+0x1b0/0x2d0
> > >    vm_area_alloc+0x28/0x94
> > >    mmap_region+0x378/0x920
> > >    do_mmap+0x3f0/0x600
> > >    vm_mmap_pgoff+0x150/0x17c
> > >    ksys_mmap_pgoff+0x284/0x2dc
> > >    __arm64_sys_mmap+0x84/0xa4
> > >    el0_svc_common.constprop.0+0xac/0x270
> > >    do_el0_svc+0x38/0xa0
> > >    el0_svc+0x1c/0x2c
> > >    el0_sync_handler+0xe8/0x114
> > >    el0_sync+0x180/0x1c0
> > > 
> > >   Freed by task 560:
> > >    kasan_save_stack+0x38/0x6c
> > >    kasan_set_track+0x28/0x40
> > >    kasan_set_free_info+0x24/0x4c
> > >    __kasan_slab_free+0x100/0x164
> > >    kasan_slab_free+0x14/0x20
> > >    kmem_cache_free+0xc4/0x34c
> > >    vm_area_free+0x1c/0x2c
> > >    remove_vma+0x7c/0x94
> > >    __do_munmap+0x358/0x710
> > >    __vm_munmap+0xbc/0x130
> > >    __arm64_sys_munmap+0x4c/0x64
> > >    el0_svc_common.constprop.0+0xac/0x270
> > >    do_el0_svc+0x38/0xa0
> > >    el0_svc+0x1c/0x2c
> > >    el0_sync_handler+0xe8/0x114
> > >    el0_sync+0x180/0x1c0
> > > 
> > >   [...]
> > >   ==================================================================
> > > 
> > > To prevent the race above, revert back to taking the mmap write lock
> > > inside binder_update_page_range(). One might expect an increase of mmap
> > > lock contention. However, binder already serializes these calls via top
> > > level alloc->mutex. Also, there was no performance impact shown when
> > > running the binder benchmark tests.
> > > 
> > > Fixes: c0fd2101781e ("Revert "android: binder: stop saving a pointer to the VMA"")
> > 
> > I can't find this commit in any tree, are you sure it's correct?
> 
> The commit comes from your char-misc-linus branch, it hasn't really
> landed in mainline yet. I added this tag to make sure this fix is
> bounded to the revert otherwise it exposes the UAF. I know I'm relying
> on a merge, so let me know if I should drop the tag instead.

Ah, no, that works, thanks, I'll queue it up.

greg k-h
