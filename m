Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5814B63E8F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiLAErv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLAErl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:47:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9BB983BD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669870004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5RDZVdIuWvEKzyANxlSq2annUBhbnhdtL1S+4RFGYU8=;
        b=au7xeDm8mLBhFsXeeY3DSqThChNhEL2sQklBbCQ3xsnCfn9I7RrlQg+X4MkPhK/wAngvsY
        92kx9es7bINhDpkGZhvJ40ugKp9Qe7tvj1/CM7g6cVNOIQcGfZJbU+EXyioCox7nGf6awv
        K6k+GLgu57khUarGCnbj8EfOD/aQX38=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-RQtQOBHtPEaowv5OaN26YQ-1; Wed, 30 Nov 2022 23:46:41 -0500
X-MC-Unique: RQtQOBHtPEaowv5OaN26YQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E410F29ABA36;
        Thu,  1 Dec 2022 04:46:40 +0000 (UTC)
Received: from localhost (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FA1F492B04;
        Thu,  1 Dec 2022 04:46:39 +0000 (UTC)
Date:   Thu, 1 Dec 2022 12:46:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, hch@infradead.org
Subject: Re: [PATCH RFC 3/3] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y4gxq8zR/ueJNHUc@MiWiFi-R3L-srv>
References: <20221109033535.269229-1-bhe@redhat.com>
 <20221109033535.269229-4-bhe@redhat.com>
 <Y3c77o95A9vKQ745@casper.infradead.org>
 <Y32VznHyZrS6vs4E@MiWiFi-R3L-srv>
 <Y34fIzV7UnquyS1r@casper.infradead.org>
 <Y38+4tspZxRJj73p@MiWiFi-R3L-srv>
 <Y4dVWsmEUcjPBeYc@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4dVWsmEUcjPBeYc@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 at 02:06pm, Uladzislau Rezki wrote:
> On Thu, Nov 24, 2022 at 05:52:34PM +0800, Baoquan He wrote:
......
> > > I don't think you understand the problem.
> > > 
> > > Task A:			Task B:		Task C:
> > > p = vm_map_ram()
> > > 			vread(p);
> > > 			... preempted ...
> > > vm_unmap_ram(p);
> > > 					q = vm_map_ram();
> > > 			vread continues
> > 
> > 
> > 
> > > 
> > > If C has reused the address space allocated by A, task B is now reading
> > > the memory mapped by task C instead of task A.  If it hasn't, it's now
> > > trying to read from unmapped, and quite possibly freed memory.  Which
> > > might have been allocated by task D.
> > 
> > Hmm, it may not be like that.
> > 
> > Firstly, I would remind that vread() takes vmap_area_lock during the
> > whole reading process. Before this patchset, the vread() and other area
> > manipulation will have below status:
> > 1) __get_vm_area_node() could only finish insert_vmap_area(), then free
> > the vmap_area_lock, then warting;
> > 2) __get_vm_area_node() finishs setup_vmalloc_vm()
> >   2.1) doing mapping but not finished;
> >   2.2) clear_vm_uninitialized_flag() is called after mapping is done;
> > 3) remove_vm_area() is called to set -> = NULL, then free vmap_area_lock;
> > 
> > Task A:			   Task B:		     Task C:
> > p = __get_vm_area_node()
> > remove_vm_area(p);
> > 			   vread(p);
> > 
> > 			   vread end 
> > 					     q = __get_vm_area_node();
> > 
> > So, as you can see, the checking "if (!va->vm)" in vread() will filter
> > out vmap_area:
> > a) areas if only insert_vmap_area() is called, but ->vm is still NULL; 
> > b) areas if remove_vm_area() is called to clear ->vm to NULL;
> > c) areas created through vm_map_ram() since its ->vm is always NULL;
> > 
> > Means vread() will read out vmap_area:
> > d) areas if setup_vmalloc_vm() is called;
> >   1) mapping is done on areas, e.g clear_vm_uninitialized_flag() is
> >        called;
> >   2) mapping is being handled, just after returning from setup_vmalloc_vm();
> > 
> > 
> > ******* after this patchset applied:
> > 
> > Task A:			Task B:		Task C:
> > p = vm_map_ram()
> > vm_unmap_ram(p);
> > 			vread(p);
> >                          vb_vread()
> > 			vread end 
> > 
> > 					q = vm_map_ram();
> > 
> > With this patchset applied, other than normal areas, for the
> > vm_map_ram() areas:
> > 1) In vm_map_ram(), set vmap_area->flags = VMAP_RAM when vmap_area_lock
> >    is taken; In vm_unmap_ram(), clear it wiht "va->flags &= ~VMAP_RAM"
> >    when vmap_area_lock is taken;
> > 2) If vmap_block, set va->flags = VMAP_RAM|VMAP_BLOCK; And set
> >    vmap_block->used_map to track the used region, filter out the dirty
> >    and free region;
> > 3) In vb_vread(), we take vb->lock to avoid reading out dirty regions.
> > 
> > Please help point out what is wrong or I missed.
> > 
> One thing is we still can read-out un-mapped pages, i.e. a text instead:
> 
> <snip>
> static void vb_free(unsigned long addr, unsigned long size)
> {
> 	unsigned long offset;
> 	unsigned int order;
> 	struct vmap_block *vb;
> 
> 	BUG_ON(offset_in_page(size));
> 	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
> 
> 	flush_cache_vunmap(addr, addr + size);
> 
> 	order = get_order(size);
> 	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
> 	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
> 
> 	vunmap_range_noflush(addr, addr + size);
> 
> 	if (debug_pagealloc_enabled_static())
> 		flush_tlb_kernel_range(addr, addr + size);
> 
> 	spin_lock(&vb->lock);
> ...
> <snip>
> 
> or am i missing something? Is it a problem? It might be. Another thing
> it would be good if you upload a new patchset so it is easier to review
> it.

Thanks for checking.

Please check patch 1, vmap_block->used_map is introduced to track the
vb regions allocation and free via vb_alloc/vb_free(). The vb->used_map
only set for pages being used, the dirty and free regions are all
cleared. In the added vb_vread() of patch 3, vb->lock is required and
taken during the whole vb vmap reading, and only page of regions set in
vb->used_map will be read out.

So if vb_free() is called, and vb->used_map is cleared away, it won't
be read out in vb_vread(). If vb_free() is requiring vb->lock and waiting,
the region hasn't been unmapped and can be read out.

@@ -2114,6 +2118,9 @@ static void vb_free(unsigned long addr, unsigned long size)
        order = get_order(size);
        offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
        vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
+       spin_lock(&vb->lock);
+       bitmap_clear(vb->used_map, offset, (1UL << order));
+       spin_unlock(&vb->lock);
 
        vunmap_range_noflush(addr, addr + size);

I will work out a formal patchset for reviewing, will post and CC all
reviewers.

Thanks
Baoquan

