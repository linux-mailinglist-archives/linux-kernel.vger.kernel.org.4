Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBB363D645
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiK3NGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiK3NGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:06:40 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA03B1F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:06:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f13so26834172lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FzZ3Z8aYPlb4P3DEeMpBt2rK5IaeVa49dnDza8zoCqQ=;
        b=QT7NMTw42OEcTFgp9+reCPWZi5OFpkaW7RsY3wYtRm/8AdXTKnzhH3X8N+MLahV+/d
         O2pBrHAUkHWqjYeof9lezMafaphvVx1ylczmMZq7jl2fbiKDN9nWrgwAfwJMbTLWCYw7
         qEL9c4yFD1dvhisKAYmacnOzDQJl2//B4FcjTrWsUm76P31NaDkXjHwwRkrf+0YMsxZg
         3ZMPRoqPmdCxdCxVFrLoY9OO1f0UzBZGpjXcHM/ugJN3RTcmYKr/T+/gndXTadgHnExP
         TLCd9uXJH+y6vkP2HLOpQUYE7veoKbKlt0qCvymKsBHjrLHFN+LkG6J/9DlST5rdxSaD
         nihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzZ3Z8aYPlb4P3DEeMpBt2rK5IaeVa49dnDza8zoCqQ=;
        b=uGlph5mDH3QAZIUIJlYqZIetMtvxGiE00f7ecZB/pPoYpWA5EgIvXCeA6OVS2VDctD
         oqLXyBVkW8expEXZ8f3WJgE5rgYzQD4/siYdnFhrrwyYdEanKs/EPK4EmiVzZuy93Ujt
         3hjLaUXBTEMADeO6rdDEiE/8RSuKoyM43hrzCsOd6msC10GvIA/z3T58bm8A+GS4aSSF
         MJw93zUl03V+sbM4NgNMBhNQbs+/jlqvcipLdq2k2cHsxeXKXPA9RvElp8foXkY688yu
         5rjFNt+sstw+ML1Ed54s4O0QRjS0VJHsf3LCXmedr5GjWJQr+QbIXcmpYREfEmhaD6aH
         a0Ag==
X-Gm-Message-State: ANoB5pk4Dfk1cKXHHkfRVn6ybhO9T/xjIaQJ9ZtjJdqsXpWNfO2n0xSO
        2E7GuIcUmf9tP4pf3ggZeEQ=
X-Google-Smtp-Source: AA0mqf4HSeJYk1H9+qNndNaSZZbHl/fd13IuvaaRFdMvdLDayLEUbLaFVu6HeqYBZde/T2ldmIYkHQ==
X-Received: by 2002:a05:6512:52d:b0:4a2:7574:b64a with SMTP id o13-20020a056512052d00b004a27574b64amr19951758lfc.336.1669813597235;
        Wed, 30 Nov 2022 05:06:37 -0800 (PST)
Received: from pc636 (host-90-235-25-230.mobileonline.telia.com. [90.235.25.230])
        by smtp.gmail.com with ESMTPSA id v3-20020a05651203a300b004a4754c5db5sm247108lfp.244.2022.11.30.05.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:06:36 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 30 Nov 2022 14:06:34 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, hch@infradead.org
Subject: Re: [PATCH RFC 3/3] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y4dVWsmEUcjPBeYc@pc636>
References: <20221109033535.269229-1-bhe@redhat.com>
 <20221109033535.269229-4-bhe@redhat.com>
 <Y3c77o95A9vKQ745@casper.infradead.org>
 <Y32VznHyZrS6vs4E@MiWiFi-R3L-srv>
 <Y34fIzV7UnquyS1r@casper.infradead.org>
 <Y38+4tspZxRJj73p@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y38+4tspZxRJj73p@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 05:52:34PM +0800, Baoquan He wrote:
> On 11/23/22 at 01:24pm, Matthew Wilcox wrote:
> > On Wed, Nov 23, 2022 at 11:38:54AM +0800, Baoquan He wrote:
> > > On 11/18/22 at 08:01am, Matthew Wilcox wrote:
> > > > On Wed, Nov 09, 2022 at 11:35:34AM +0800, Baoquan He wrote:
> > > > > Currently, vread() can read out vmalloc areas which is associated with
> > > > > a vm_struct. While this doesn't work for areas created by vm_map_ram()
> > > > > interface because it doesn't allocate a vm_struct. Then in vread(),
> > > > > these areas will be skipped.
> > > > > 
> > > > > Here, add a new function vb_vread() to read out areas managed by
> > > > > vmap_block specifically. Then recognize vm_map_ram areas via vmap->flags
> > > > > and handle  them respectively.
> > > > 
> > > > i don't understand how this deals with the original problem identified,
> > > > that the vread() can race with an unmap.
> > > 
> > > Thanks for checking.
> > > 
> > > I wrote a paragraph, then realized I misunderstood your concern. You are
> > > saying the comment from Uladzislau about my original draft patch, right?
> > > Paste the link of Uladzislau's reply here in case other people want to
> > > know the background:
> > > https://lore.kernel.org/all/Y1uKSmgURNEa3nQu@pc636/T/#u
> > > 
> > > When Stephen raised the issue originally, I posted a draft patch as
> > > below trying to fix it:
> > > https://lore.kernel.org/all/Y1pHTj2wuhoWmeV3@MiWiFi-R3L-srv/T/#u
> > > 
> > > In above draft patch, I tried to differentiate normal vmalloc area and
> > > vm_map_ram area with the fact that vmalloc area is associated with a
> > > vm_struct, while vm_map_ram area has ->vm as NULL. And I thought their
> > > only difference is normal vmalloc area has guard page, so its size need
> > > consider the guard page; while vm_map_ram area has no guard page, only
> > > consider its own actual size. Uladzislau's comment reminded me I was
> > > wrong. And the things we need handle are beyond that.
> > > 
> > > Currently there are three kinds of vmalloc areas in kernel:
> > > 
> > > 1) normal vmalloc areas, associated with a vm_struct, this is allocated 
> > > in __get_vm_area_node(). When freeing, it set ->vm to NULL
> > > firstly, then unmap and free vmap_area, see remove_vm_area().
> > > 
> > > 2) areas allocated via vm_map_ram() and size is larger than
> > > VMAP_MAX_ALLOC. The entire area is not associated with vm_struct, and
> > > freed at one time in vm_unmap_ram() with unmapping and freeing vmap_area;
> > > 
> > > 3) areas allocated via vm_map_ram(), then delegate to vb_alloc() when
> > > size <= VMAP_MAX_ALLOC. Its vmap_area is allocated at one time with
> > > VMAP_BLOCK_SIZE big, and split and used later through vb_alloc(), freed
> > > via vb_free(). When the entire area is dirty, it will be unmapped and
> > > freed.
> > > 
> > > Based on above facts, we need add flags to differentiate the normal
> > > vmalloc area from the vm_map_ram area, namely area 1) and 2). And we
> > > also need flags to differentiate the area 2) and 3). Because area 3) are
> > > pieces of a entire vmap_area, vb_free() will unmap the piece of area and
> > > set the part dirty, but the entire vmap_area will kept there. So when we
> > > will read area 3), we need take vb->lock and only read out the still
> > > mapped part, but not dirty or free part of the vmap_area.
> > 
> > I don't think you understand the problem.
> > 
> > Task A:			Task B:		Task C:
> > p = vm_map_ram()
> > 			vread(p);
> > 			... preempted ...
> > vm_unmap_ram(p);
> > 					q = vm_map_ram();
> > 			vread continues
> 
> 
> 
> > 
> > If C has reused the address space allocated by A, task B is now reading
> > the memory mapped by task C instead of task A.  If it hasn't, it's now
> > trying to read from unmapped, and quite possibly freed memory.  Which
> > might have been allocated by task D.
> 
> Hmm, it may not be like that.
> 
> Firstly, I would remind that vread() takes vmap_area_lock during the
> whole reading process. Before this patchset, the vread() and other area
> manipulation will have below status:
> 1) __get_vm_area_node() could only finish insert_vmap_area(), then free
> the vmap_area_lock, then warting;
> 2) __get_vm_area_node() finishs setup_vmalloc_vm()
>   2.1) doing mapping but not finished;
>   2.2) clear_vm_uninitialized_flag() is called after mapping is done;
> 3) remove_vm_area() is called to set -> = NULL, then free vmap_area_lock;
> 
> Task A:			   Task B:		     Task C:
> p = __get_vm_area_node()
> remove_vm_area(p);
> 			   vread(p);
> 
> 			   vread end 
> 					     q = __get_vm_area_node();
> 
> So, as you can see, the checking "if (!va->vm)" in vread() will filter
> out vmap_area:
> a) areas if only insert_vmap_area() is called, but ->vm is still NULL; 
> b) areas if remove_vm_area() is called to clear ->vm to NULL;
> c) areas created through vm_map_ram() since its ->vm is always NULL;
> 
> Means vread() will read out vmap_area:
> d) areas if setup_vmalloc_vm() is called;
>   1) mapping is done on areas, e.g clear_vm_uninitialized_flag() is
>        called;
>   2) mapping is being handled, just after returning from setup_vmalloc_vm();
> 
> 
> ******* after this patchset applied:
> 
> Task A:			Task B:		Task C:
> p = vm_map_ram()
> vm_unmap_ram(p);
> 			vread(p);
>                          vb_vread()
> 			vread end 
> 
> 					q = vm_map_ram();
> 
> With this patchset applied, other than normal areas, for the
> vm_map_ram() areas:
> 1) In vm_map_ram(), set vmap_area->flags = VMAP_RAM when vmap_area_lock
>    is taken; In vm_unmap_ram(), clear it wiht "va->flags &= ~VMAP_RAM"
>    when vmap_area_lock is taken;
> 2) If vmap_block, set va->flags = VMAP_RAM|VMAP_BLOCK; And set
>    vmap_block->used_map to track the used region, filter out the dirty
>    and free region;
> 3) In vb_vread(), we take vb->lock to avoid reading out dirty regions.
> 
> Please help point out what is wrong or I missed.
> 
One thing is we still can read-out un-mapped pages, i.e. a text instead:

<snip>
static void vb_free(unsigned long addr, unsigned long size)
{
	unsigned long offset;
	unsigned int order;
	struct vmap_block *vb;

	BUG_ON(offset_in_page(size));
	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);

	flush_cache_vunmap(addr, addr + size);

	order = get_order(size);
	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));

	vunmap_range_noflush(addr, addr + size);

	if (debug_pagealloc_enabled_static())
		flush_tlb_kernel_range(addr, addr + size);

	spin_lock(&vb->lock);
...
<snip>

or am i missing something? Is it a problem? It might be. Another thing
it would be good if you upload a new patchset so it is easier to review
it.

Thanks!

--
Uladzislau Rezki
