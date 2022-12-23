Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB11E654BED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiLWEP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLWEPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C2B23172
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 20:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671768904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XfqgZkfFnhSLMM96QdZwz7snPxiyFPL2NQRVeVMAqNk=;
        b=FFnSyCjF7g4cTXvuTcmImaByaul0s0YFgM915Fm+JYiBC8/pYWA5A4yo7FK+jiurxjiZgg
        iNRxJSAYOxaV4D+lRx5polXtt/NPd4Pfc5x94WfaJuQOq9pzHadvN7KqhDO9iS3fpsLY4P
        DxTDMVvCP7Z8nagcTSSXcXPclEdNXYQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-kmLALo5cMBuWzJtU6LV1PA-1; Thu, 22 Dec 2022 23:14:58 -0500
X-MC-Unique: kmLALo5cMBuWzJtU6LV1PA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10B51811E9C;
        Fri, 23 Dec 2022 04:14:57 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9FC751EF;
        Fri, 23 Dec 2022 04:14:55 +0000 (UTC)
Date:   Fri, 23 Dec 2022 12:14:52 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y6UrPGMVYUMttKD3@MiWiFi-R3L-srv>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-3-bhe@redhat.com>
 <Y6HpGayyQZH7U7Fd@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6HpGayyQZH7U7Fd@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/22 at 05:55pm, Uladzislau Rezki wrote:
> > Through vmalloc API, a virtual kernel area is reserved for physical
> > address mapping. And vmap_area is used to track them, while vm_struct
> > is allocated to associate with the vmap_area to store more information
> > and passed out.
> > 
> > However, area reserved via vm_map_ram() is an exception. It doesn't have
> > vm_struct to associate with vmap_area. And we can't recognize the
> > vmap_area with '->vm == NULL' as a vm_map_ram() area because the normal
> > freeing path will set va->vm = NULL before unmapping, please see
> > function remove_vm_area().
> > 
> A normal "free" path sets it to NULL in order to prevent a double-free
> of same VA. We can avoid of touching the va->vm if needed and do an unlink
> on entry in the remove_vm_area() when a lock is taken to find an area.
> 
> Will it help you?

Sorry, this mail sneaked out of my sight until I notice it now. My mutt
client makes it look like in the thread I talked with Lorenzo.

Yes, as I replied to your v2 patch, that is very helpful, thanks.

> 
> > Meanwhile, there are two types of vm_map_ram area. One is the whole
> > vmap_area being reserved and mapped at one time; the other is the
> > whole vmap_area with VMAP_BLOCK_SIZE size being reserved, while mapped
> > into split regions with smaller size several times via vb_alloc().
> > 
> > To mark the area reserved through vm_map_ram(), add flags field into
> > struct vmap_area. Bit 0 indicates whether it's a vm_map_ram area,
> > while bit 1 indicates whether it's a vmap_block type of vm_map_ram
> > area.
> > 
> > This is a preparatoin for later use.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/vmalloc.h |  1 +
> >  mm/vmalloc.c            | 22 +++++++++++++++++-----
> >  2 files changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 096d48aa3437..69250efa03d1 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -76,6 +76,7 @@ struct vmap_area {
> >  		unsigned long subtree_max_size; /* in "free" tree */
> >  		struct vm_struct *vm;           /* in "busy" tree */
> >  	};
> > +	unsigned long flags; /* mark type of vm_map_ram area */
> >  };
> >  
> >  /* archs that select HAVE_ARCH_HUGE_VMAP should override one or more of these */
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 5d3fd3e6fe09..190f29bbaaa7 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1586,7 +1586,8 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
> >  static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  				unsigned long align,
> >  				unsigned long vstart, unsigned long vend,
> > -				int node, gfp_t gfp_mask)
> > +				int node, gfp_t gfp_mask,
> > +				unsigned long va_flags)
> >  {
> >  	struct vmap_area *va;
> >  	unsigned long freed;
> > @@ -1630,6 +1631,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	va->va_start = addr;
> >  	va->va_end = addr + size;
> >  	va->vm = NULL;
> > +	va->flags = va_flags;
> >  
> >  	spin_lock(&vmap_area_lock);
> >  	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> > @@ -1887,6 +1889,10 @@ struct vmap_area *find_vmap_area(unsigned long addr)
> >  
> >  #define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
> >  
> > +#define VMAP_RAM		0x1
> > +#define VMAP_BLOCK		0x2
> > +#define VMAP_FLAGS_MASK		0x3
> > 
> Maybe to rename a VMAP_BLOCK to something like VMAP_BLOCK_RESERVED or
> VMAP_PER_CPU_BLOCK?

Both VMAP_BLOCK or VMAP_PER_CPU_BLOCK look good to me, please see my
explanation at below.

> 
> >  struct vmap_block_queue {
> >  	spinlock_t lock;
> >  	struct list_head free;
> > @@ -1962,7 +1968,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  
> >  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
> >  					VMALLOC_START, VMALLOC_END,
> > -					node, gfp_mask);
> > +					node, gfp_mask,
> > +					VMAP_RAM|VMAP_BLOCK);
> >
> A new_vmap_block() is for a per-cpu path. As far as i see the VMAP_BLOCK
> flag is used to mark a VA that corresponds to a reserved per-cpu free area.
> 
> Whereas a VMAP_RAM is for VA that was obtained over per-cpu path but
> over alloc_vmap_area() thus a VA should be read out over "busy" tree
> directly.
> 
> Why do you need to set here both VMAP_RAM and VMAP_BLOCK?

My understanding is that the vm_map_ram area has two types, one is
the vb percpu area via vb_alloc(), the other is allocated via
alloc_vmap_area(). While both of them is got from vm_map_ram()
interface, this is the main point that distinguishes the vm_map_ram area
than the normal vmalloc area, and this makes vm_map_ram area not owning
va->vm pointer. So here, I use flag VMAP_RAM to mark the vm_map_ram
area, including the two types; meanwhile, I add VMAP_BLOCK to mark out
the vb percpu area. 

I understand people could have different view about them, e.g as you
said, use VMAP_RAM to mark the type of vm_map_ram area allocated through
alloc_vmap_area(), while use VMAP_PER_CPU_BLOCK to mark vb percpu area
from vb_alloc. In this way, we may need to rename VMAP_RAM to reflect
the area allocated from alloc_vmap_area() only. Both is fine to me.

> 
> >  	if (IS_ERR(va)) {
> >  		kfree(vb);
> >  		return ERR_CAST(va);
> > @@ -2229,8 +2236,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
> >  		return;
> >  	}
> >  
> > -	va = find_vmap_area(addr);
> > +	spin_lock(&vmap_area_lock);
> > +	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> >  	BUG_ON(!va);
> > +	if (va)
> > +		va->flags &= ~VMAP_RAM;
> > +	spin_unlock(&vmap_area_lock);
> >  	debug_check_no_locks_freed((void *)va->va_start,
> >
> Agree with Lorenzo. BUG_ON() should be out of spinlock(). Furthermore
> i think it makes sense to go with WARN_ON_ONCE() and do not kill a system.
> Instead emit a warning and bailout.
> 
> What do you think? Maybe separate patch for it?

Agree, your patch looks great to me. Thanks.

> 
> >  				    (va->va_end - va->va_start));
> >  	free_unmap_vmap_area(va);
> > @@ -2265,7 +2276,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
> >  	} else {
> >  		struct vmap_area *va;
> >  		va = alloc_vmap_area(size, PAGE_SIZE,
> > -				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> > +				VMALLOC_START, VMALLOC_END,
> > +				node, GFP_KERNEL, VMAP_RAM);
> >  		if (IS_ERR(va))
> >  			return NULL;
> >  
> > @@ -2505,7 +2517,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
> >  	if (!(flags & VM_NO_GUARD))
> >  		size += PAGE_SIZE;
> >  
> > -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask);
> > +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
> >  	if (IS_ERR(va)) {
> >  		kfree(area);
> >  		return NULL;
> >
> I know we have already discussed the new parameter. But what if we just
> use atomic_set operation to mark VA as either vmap-ram or vmap-block?
> 
> As for alloc_vmap_area() we set it just as zero.

Sorry, I may not get your point clearly, could you be more specific? 

