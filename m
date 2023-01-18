Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A4667118D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjARDKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjARDKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B484FCFB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674011396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTozoTYivpj8I4L2tIqMRp9GkC9vbzgfcsOJBU+tFh0=;
        b=HNfaprpkYkMyJamTNt0GAUJF6GM9yZFhre0ScVTvtqijSwJfBYVhNsw1H59bELCSblYVmo
        Le4po+c95UrM+eFFYgiJIcw+0GGgFhaMc1vk+4/FF95tWQ7LW2q9wS96WKsxxKRII+/gHd
        V8B8xatJWCg9wnS85hKf88gixmzhmgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-7TMUMTMDNjyacfJSUnjcCQ-1; Tue, 17 Jan 2023 22:09:51 -0500
X-MC-Unique: 7TMUMTMDNjyacfJSUnjcCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B39AB18811CE;
        Wed, 18 Jan 2023 03:09:50 +0000 (UTC)
Received: from localhost (ovpn-13-29.pek2.redhat.com [10.72.13.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 725C71121319;
        Wed, 18 Jan 2023 03:09:48 +0000 (UTC)
Date:   Wed, 18 Jan 2023 11:09:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y8di+GSIr4HLxYyy@fedora>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-3-bhe@redhat.com>
 <Y6HpGayyQZH7U7Fd@pc636>
 <Y6UrPGMVYUMttKD3@MiWiFi-R3L-srv>
 <Y8DWG+OHV6E4cR8p@fedora>
 <Y8WPWngsci0QPY0Y@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8WPWngsci0QPY0Y@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16/23 at 06:54pm, Uladzislau Rezki wrote:
> On Fri, Jan 13, 2023 at 11:55:07AM +0800, Baoquan He wrote:
> > Hi Uladzislau Rezki，
> > 
> > On 12/23/22 at 12:14pm, Baoquan He wrote:
> > > On 12/20/22 at 05:55pm, Uladzislau Rezki wrote:
> > ......
> >  > >  	spin_lock(&vmap_area_lock);
> > > > >  	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> > > > > @@ -1887,6 +1889,10 @@ struct vmap_area *find_vmap_area(unsigned long addr)
> > > > >  
> > > > >  #define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
> > > > >  
> > > > > +#define VMAP_RAM		0x1
> > > > > +#define VMAP_BLOCK		0x2
> > > > > +#define VMAP_FLAGS_MASK		0x3
> > > > > 
> > > > Maybe to rename a VMAP_BLOCK to something like VMAP_BLOCK_RESERVED or
> > > > VMAP_PER_CPU_BLOCK?
> > > 
> > > Both VMAP_BLOCK or VMAP_PER_CPU_BLOCK look good to me, please see my
> > > explanation at below.
> > > 
> > > > 
> > > > >  struct vmap_block_queue {
> > > > >  	spinlock_t lock;
> > > > >  	struct list_head free;
> > > > > @@ -1962,7 +1968,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> > > > >  
> > > > >  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
> > > > >  					VMALLOC_START, VMALLOC_END,
> > > > > -					node, gfp_mask);
> > > > > +					node, gfp_mask,
> > > > > +					VMAP_RAM|VMAP_BLOCK);
> > > > >
> > > > A new_vmap_block() is for a per-cpu path. As far as i see the VMAP_BLOCK
> > > > flag is used to mark a VA that corresponds to a reserved per-cpu free area.
> > > > 
> > > > Whereas a VMAP_RAM is for VA that was obtained over per-cpu path but
> > > > over alloc_vmap_area() thus a VA should be read out over "busy" tree
> > > > directly.
> > 
> > Rethinking about the vmap->flags and the bit0->VMAP_RAM,
> > bit1->VMAP_BLOCK correspondence, it looks better to use bit0->VMAP_RAM
> > to indicate the vm_map_ram area, no matter how it's handled inside
> > vm_map_ram() interface; and use bit1->VMAP_BLOCK to mark out the special
> > vm_map_ram area which is further subdivided and managed by struct
> > vmap_block. With these, you can see that we can identify vm_map_ram area
> > and treat it as one type of vmalloc area, e.g in vread(), s_show().
> > 
> > Means when we are talking about vm_map_ram areas, we use
> > (vmap->flags & VMAP_RAM) to recognize them; when we need to
> > differentiate and handle vm_map_ram areas respectively, we use
> > (vmap->flags & VMAP_BLOCK) to pick out the area which is further managed
> > by vmap_block. Please help check if this is OK to you.
> > 
> > > > 
> > > > Why do you need to set here both VMAP_RAM and VMAP_BLOCK?
> > > 
> > > My understanding is that the vm_map_ram area has two types, one is
> > > the vb percpu area via vb_alloc(), the other is allocated via
> > > alloc_vmap_area(). While both of them is got from vm_map_ram()
> > > interface, this is the main point that distinguishes the vm_map_ram area
> > > than the normal vmalloc area, and this makes vm_map_ram area not owning
> > > va->vm pointer. So here, I use flag VMAP_RAM to mark the vm_map_ram
> > > area, including the two types; meanwhile, I add VMAP_BLOCK to mark out
> > > the vb percpu area. 
> > > 
> > > I understand people could have different view about them, e.g as you
> > > said, use VMAP_RAM to mark the type of vm_map_ram area allocated through
> > > alloc_vmap_area(), while use VMAP_PER_CPU_BLOCK to mark vb percpu area
> > > from vb_alloc. In this way, we may need to rename VMAP_RAM to reflect
> > > the area allocated from alloc_vmap_area() only. Both is fine to me.
> > > 
> > > > 
> > > > >  	if (IS_ERR(va)) {
> > > > >  		kfree(vb);
> > > > >  		return ERR_CAST(va);
> > > > > @@ -2229,8 +2236,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
> > > > >  		return;
> > > > >  	}
> > > > >  
> > > > > -	va = find_vmap_area(addr);
> > > > > +	spin_lock(&vmap_area_lock);
> > > > > +	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> > > > >  	BUG_ON(!va);
> > > > > +	if (va)
> > > > > +		va->flags &= ~VMAP_RAM;
> > > > > +	spin_unlock(&vmap_area_lock);
> > > > >  	debug_check_no_locks_freed((void *)va->va_start,
> > > > >
> > > > Agree with Lorenzo. BUG_ON() should be out of spinlock(). Furthermore
> > > > i think it makes sense to go with WARN_ON_ONCE() and do not kill a system.
> > > > Instead emit a warning and bailout.
> > > > 
> > > > What do you think? Maybe separate patch for it?
> > > 
> > > Agree, your patch looks great to me. Thanks.
> > > 
> > > > 
> > > > >  				    (va->va_end - va->va_start));
> > > > >  	free_unmap_vmap_area(va);
> > > > > @@ -2265,7 +2276,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
> > > > >  	} else {
> > > > >  		struct vmap_area *va;
> > > > >  		va = alloc_vmap_area(size, PAGE_SIZE,
> > > > > -				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> > > > > +				VMALLOC_START, VMALLOC_END,
> > > > > +				node, GFP_KERNEL, VMAP_RAM);
> > > > >  		if (IS_ERR(va))
> > > > >  			return NULL;
> > > > >  
> > > > > @@ -2505,7 +2517,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
> > > > >  	if (!(flags & VM_NO_GUARD))
> > > > >  		size += PAGE_SIZE;
> > > > >  
> > > > > -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask);
> > > > > +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
> > > > >  	if (IS_ERR(va)) {
> > > > >  		kfree(area);
> > > > >  		return NULL;
> > > > >
> > > > I know we have already discussed the new parameter. But what if we just
> > > > use atomic_set operation to mark VA as either vmap-ram or vmap-block?
> > 
> > As I replied at above, I take the vm_map_ram as one kind of vmalloc
> > area, and mark out the percpu vmap block handling of vm_map_ram area.
> > Seems the passing in the flags through function parameter is better. Not
> > sure if I got your suggestion correctly, and my code change is
> > appropriate. I have sent v3 according to your and Lorenzo's comments and
> > suggestion, and my rethinking after reading your words. I make some
> > adjustment to try to remove misundersanding or confusion when reading
> > patch and code. Please help check if it's OK.
> > 
> OK, if we decided to go with a parameter it is OK, it is not a big deal
> and complexity. If needed it can be adjusted later on if there is a
> need.

My preference for function parameter passing is we don't need do the
atomic reading when we want to check va->flags. However, in va->flags
setting side, atomic_set() code is simpler than function parameter.

	flags = atomic_read(&va->flags);
        if (flags & VMAP_RAM) {
		
	}

I checked code, and feel it doesn't have much difference, so keep the
current code. If there's other thing I didn't think of, we can still
change. Thanks.

