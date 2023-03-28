Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113416CBFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjC1Mws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjC1MwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:52:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330C29ED6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:51:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y20so15712242lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680007903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hs9czBowTVXtBSbTBDGLfq3Wvgq44g4XfvNTDtPs14=;
        b=Pg837fJpYuaudSP2F7GMihu5+qcV7F3jdK+Vuk9JZbN9esDq3lVftaCC39ptLJZkc0
         PNKEx+9ya27yIn5fkLESNmKWaPczNljzBCBw+1PiGbG/7/BRQl/dk+1TJzh6pCo5tx4r
         8v0tBkpxcko3ck+vSv5fI0f5ufViAUR1MIjb+t5dN8N9AZlNyttDgFv5mX2q6blBu0lM
         BKTqIAwLmgrV+rWmRVHThFewf29MRVH+Rkhce1jVLN41vtSqzx1wx6LzlM+NivGnanG9
         Ru2fZUxtBsb8VyQxSMoQJN40JTR4oYiwjlvxl3ZWF0pMeIihLXdWYyhNPigPiqOTPuG5
         oohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680007903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hs9czBowTVXtBSbTBDGLfq3Wvgq44g4XfvNTDtPs14=;
        b=PVykCi8XX+kXXjGRfwx+Yb+3pWEXIwpEq1umJZjVlg5yhKOFcKAilZ0I45q7zFQV7x
         zkDej5/L/kPuhZbLXz1TV7IuwKiQYUpJ9Mpwo81a9E0i6f3jsQB+i8hWEEgAhuJKISkE
         ane8YVWo4tRbVkS/YHLEGpmN4+4E/NgrJhj3QozZVoeFmg+vrJMjcoo2eeQyLB9OJxZQ
         DLsY6TOvHSyvcD54qrz3AQWnYxZQRaAkgkplZ6UzLA127L5pEDxNsfEnjCJSutGJw79H
         hLSClNc6CiMV0JPjWGOhT1JQgMgXtWxGakfrqBI8dzT8QB09BjpmM6otnE7+B93/HOZr
         IO6Q==
X-Gm-Message-State: AAQBX9es8dSFuE+HuHLCWJmlAy5a3IFgR1IKEjeqkEFyfsTWmdcE0lYX
        j5vSJjorjP4XG7CR0Yj2x+Q=
X-Google-Smtp-Source: AKy350Y807+WlWkgf/id++hV3fInsxybPBU0ZDk4OTgzDCIO+HQxykA7YecnTfXz2QOI20PQhRF0GA==
X-Received: by 2002:ac2:51a1:0:b0:4df:830d:4a3a with SMTP id f1-20020ac251a1000000b004df830d4a3amr4811564lfk.23.1680007902779;
        Tue, 28 Mar 2023 05:51:42 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id v15-20020ac2560f000000b004d5a4f63402sm5072165lfd.213.2023.03.28.05.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:51:42 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 28 Mar 2023 14:51:40 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCLi3K839DFzWFW8@pc636>
References: <20230327170126.406044-1-urezki@gmail.com>
 <132e2d5c-0c1f-4fff-850c-b3fb084455bb@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132e2d5c-0c1f-4fff-850c-b3fb084455bb@lucifer.local>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 09:09:32PM +0100, Lorenzo Stoakes wrote:
> On Mon, Mar 27, 2023 at 07:01:25PM +0200, Uladzislau Rezki (Sony) wrote:
> > A global vmap_blocks-xarray array can be contented under
> > heavy usage of the vm_map_ram()/vm_unmap_ram() APIs. The
> > lock_stat shows that a "vmap_blocks.xa_lock" lock is a
> > second in a top-list when it comes to contentions:
> >
> > <snip>
> > ----------------------------------------
> > class name con-bounces contentions ...
> > ----------------------------------------
> > vmap_area_lock:         2554079 2554276 ...
> >   --------------
> >   vmap_area_lock        1297948  [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
> >   vmap_area_lock        1256330  [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
> >   vmap_area_lock              1  [<00000000c95c05a7>] find_vm_area+0x16/0x70
> >   --------------
> >   vmap_area_lock        1738590  [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
> >   vmap_area_lock         815688  [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
> >   vmap_area_lock              1  [<00000000c1d619d7>] __get_vm_area_node+0xd2/0x170
> >
> > vmap_blocks.xa_lock:    862689  862698 ...
> >   -------------------
> >   vmap_blocks.xa_lock   378418    [<00000000625a5626>] vm_map_ram+0x359/0x4a0
> >   vmap_blocks.xa_lock   484280    [<00000000caa2ef03>] xa_erase+0xe/0x30
> >   -------------------
> >   vmap_blocks.xa_lock   576226    [<00000000caa2ef03>] xa_erase+0xe/0x30
> >   vmap_blocks.xa_lock   286472    [<00000000625a5626>] vm_map_ram+0x359/0x4a0
> > ...
> > <snip>
> >
> > that is a result of running vm_map_ram()/vm_unmap_ram() in
> > a loop. The test creates 64(on 64 CPUs system) threads and
> > each one maps/unmaps 1 page.
> >
> > After this change the "xa_lock" can be considered as a noise
> > in the same test condition:
> >
> > <snip>
> > ...
> > &xa->xa_lock#1:         10333 10394 ...
> >   --------------
> >   &xa->xa_lock#1        5349      [<00000000bbbc9751>] xa_erase+0xe/0x30
> >   &xa->xa_lock#1        5045      [<0000000018def45d>] vm_map_ram+0x3a4/0x4f0
> >   --------------
> >   &xa->xa_lock#1        7326      [<0000000018def45d>] vm_map_ram+0x3a4/0x4f0
> >   &xa->xa_lock#1        3068      [<00000000bbbc9751>] xa_erase+0xe/0x30
> > ...
> > <snip>
> >
> > This patch does not fix vmap_area_lock/free_vmap_area_lock and
> > purge_vmap_area_lock bottle-necks, it is rather a separate rework.
> >
> > v1 - v2:
> >    - Add more comments(Andrew Morton req.)
> >    - Switch to WARN_ON_ONCE(Lorenzo Stoakes req.)
> >
> > v2 -> v3:
> >    - Fix a kernel-doc complain(Matthew Wilcox)
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 85 +++++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 64 insertions(+), 21 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 978194dc2bb8..821256ecf81c 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1908,9 +1908,22 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> >  #define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
> >  #define VMAP_FLAGS_MASK		0x3
> >
> > +/*
> > + * We should probably have a fallback mechanism to allocate virtual memory
> > + * out of partially filled vmap blocks. However vmap block sizing should be
> > + * fairly reasonable according to the vmalloc size, so it shouldn't be a
> > + * big problem.
> > + */
> >  struct vmap_block_queue {
> >  	spinlock_t lock;
> >  	struct list_head free;
> > +
> > +	/*
> > +	 * An xarray requires an extra memory dynamically to
> > +	 * be allocated. If it is an issue, we can use rb-tree
> > +	 * instead.
> > +	 */
> > +	struct xarray vmap_blocks;
> >  };
> >
> >  struct vmap_block {
> > @@ -1928,24 +1941,46 @@ struct vmap_block {
> >  static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> >
> >  /*
> > - * XArray of vmap blocks, indexed by address, to quickly find a vmap block
> > - * in the free path. Could get rid of this if we change the API to return a
> > - * "cookie" from alloc, to be passed to free. But no big deal yet.
> > + * In order to fast access to any "vmap_block" associated with a
> > + * specific address, we store them into a per-cpu xarray. A hash
> > + * function is addr_to_vbq() whereas a key is a vb->va->va_start
> > + * value.
> > + *
> > + * Please note, a vmap_block_queue, which is a per-cpu, is not
> > + * serialized by a raw_smp_processor_id() current CPU, instead
> > + * it is chosen based on a CPU-index it belongs to, i.e. it is
> > + * a hash-table.
> > + *
> > + * An example:
> > + *
> > + *  CPU_1  CPU_2  CPU_0
> > + *    |      |      |
> > + *    V      V      V
> > + * 0     10     20     30     40     50     60
> > + * |------|------|------|------|------|------|...<vmap address space>
> > + *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> > + *
> > + * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> > + *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> > + *
> > + * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> > + *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> > + *
> > + * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> > + *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> >   */
> 
> OK so if I understand this correctly, you're overloading the per-CPU
> vmap_block_queue array to use as a simple hash based on the address and
> relying on the xa_lock() in xa_insert() to serialise in case of contention?
> 
> I like the general heft of your comment but I feel this could be spelled
> out a little more clearly, something like:-
> 
>   In order to have fast access to any vmap_block object associated with a
>   specific address, we use a hash.
> 
>   Rather than waste space on defining a new hash table  we take advantage
>   of the fact we already have a static per-cpu array vmap_block_queue.
> 
>   This is already used for per-CPU access to the block queue, however we
>   overload this to _also_ act as a vmap_block hash. The hash function is
>   addr_to_vbq() which hashes on vb->va->va_start.
> 
>   This then uses per_cpu() to lookup the _index_ rather than the
>   _cpu_. Each vmap_block_queue contains an xarray of vmap blocks which are
>   indexed on the same key as the hash (vb->va->va_start).
> 
>   xarray read acceses are protected by RCU lock and inserts are protected
>   by a spin lock so there is no risk of a race here.
> 
>   An example:
> 
>   ...
> 
> Feel free to cut this down as needed :) but I do feel it's important to
> _explicitly_ point out that we're overloading this as it's quite confusing
> at face value.
> 
> > -static DEFINE_XARRAY(vmap_blocks);
> > +static struct vmap_block_queue *
> > +addr_to_vbq(unsigned long addr)
> > +{
> > +	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> >
> > -/*
> > - * We should probably have a fallback mechanism to allocate virtual memory
> > - * out of partially filled vmap blocks. However vmap block sizing should be
> > - * fairly reasonable according to the vmalloc size, so it shouldn't be a
> > - * big problem.
> > - */
> > +	return &per_cpu(vmap_block_queue, index);
> > +}
> >
> > -static unsigned long addr_to_vb_idx(unsigned long addr)
> > +static unsigned long
> > +addr_to_vb_va_start(unsigned long addr)
> >  {
> > -	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
> > -	addr /= VMAP_BLOCK_SIZE;
> > -	return addr;
> > +	return rounddown(addr, VMAP_BLOCK_SIZE);
> >  }
> >
> >  static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
> > @@ -1953,7 +1988,7 @@ static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
> >  	unsigned long addr;
> >
> >  	addr = va_start + (pages_off << PAGE_SHIFT);
> > -	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
> > +	WARN_ON_ONCE(addr_to_vb_va_start(addr) != va_start);
> >  	return (void *)addr;
> >  }
> >
> > @@ -1970,7 +2005,6 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  	struct vmap_block_queue *vbq;
> >  	struct vmap_block *vb;
> >  	struct vmap_area *va;
> > -	unsigned long vb_idx;
> >  	int node, err;
> >  	void *vaddr;
> >
> > @@ -2003,8 +2037,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  	bitmap_set(vb->used_map, 0, (1UL << order));
> >  	INIT_LIST_HEAD(&vb->free_list);
> >
> > -	vb_idx = addr_to_vb_idx(va->va_start);
> > -	err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
> > +	vbq = addr_to_vbq(va->va_start);
> > +	err = xa_insert(&vbq->vmap_blocks, va->va_start, vb, gfp_mask);
> 
> I might be being pedantic here, but shortly after this code you reassign vbq:-
> 
> 	vbq = addr_to_vbq(va->va_start);
> 	err = xa_insert(&vbq->vmap_blocks, va->va_start, vb, gfp_mask);
> 	if (err) {
> 		kfree(vb);
> 		free_vmap_area(va);
> 		return ERR_PTR(err);
> 	}
> 
> 	vbq = raw_cpu_ptr(&vmap_block_queue);
> 
> Which is confusing at a glance, as you're using it once as a hash lookup
> and again for its 'true purpose'.
> 
> I wonder whether it would be better overall, since you always follow a vbq
> lookup explicitly with an operation on vmap_blocks, to just add a helper
> that returned a pointer to the xarray? e.g. (untested code here :):-
> 
> static struct xarray *get_vblock_array(unsigned long addr)
> {
> 	struct vmap_block_queue *vbq;
> 	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> 
> 	vbq = &per_cpu(vmap_block_queue, index);
> 	return &vbq->vblocks;
> }
> 
> And replace addr_to_vbq() with this. That'd also make the mechanism of this
> hash lookup super explicit.
> 
Thank you for the comments. I will go through all of them and fix
accordingly. At lease i see that i have to update the documentation in
more better way!

Thanks!

--
Uladzislau Rezki
