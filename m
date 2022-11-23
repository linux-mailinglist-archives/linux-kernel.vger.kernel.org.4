Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CD6636011
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiKWNhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbiKWNgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:36:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0203E657DD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a6cCVVEt16pUp7IjlR7FRGcFelPEQyVp+VfuhVmOVlg=; b=bkJDnu9YsW/TxUA5ZAKnDeGihE
        LR6xDjQEfhfVS/zC3bZ+14rUJ/3wksjcPhAdVyYLEGjRco2ZJDBkZQ8ZgOgx6qd4RTAfskW8hciVi
        QOJZUFhtW+A08gnqMmPA9Nlv8/SDHlrg2MVbeAwUde0/rVI10Mzx536D5Xb64n62WLQrOyjGXfZ/v
        GIF7rJUERrMXhYc3QjKgoNFV77LcrDCfnZZjFodyCjk0euk5vwTGgcEXXaZsVERP9Plrv6vhYI0jy
        16pyOupGb7wMTaH7p4Mgwm25dD56tC5DefFfK7qjIEZTt24FIFg6ufMr8CmYHyxTblRLgTleaNfIz
        V9M0L+kA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxpkB-007d5i-JS; Wed, 23 Nov 2022 13:24:51 +0000
Date:   Wed, 23 Nov 2022 13:24:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, stephen.s.brennan@oracle.com,
        urezki@gmail.com, hch@infradead.org
Subject: Re: [PATCH RFC 3/3] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y34fIzV7UnquyS1r@casper.infradead.org>
References: <20221109033535.269229-1-bhe@redhat.com>
 <20221109033535.269229-4-bhe@redhat.com>
 <Y3c77o95A9vKQ745@casper.infradead.org>
 <Y32VznHyZrS6vs4E@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y32VznHyZrS6vs4E@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:38:54AM +0800, Baoquan He wrote:
> On 11/18/22 at 08:01am, Matthew Wilcox wrote:
> > On Wed, Nov 09, 2022 at 11:35:34AM +0800, Baoquan He wrote:
> > > Currently, vread() can read out vmalloc areas which is associated with
> > > a vm_struct. While this doesn't work for areas created by vm_map_ram()
> > > interface because it doesn't allocate a vm_struct. Then in vread(),
> > > these areas will be skipped.
> > > 
> > > Here, add a new function vb_vread() to read out areas managed by
> > > vmap_block specifically. Then recognize vm_map_ram areas via vmap->flags
> > > and handle  them respectively.
> > 
> > i don't understand how this deals with the original problem identified,
> > that the vread() can race with an unmap.
> 
> Thanks for checking.
> 
> I wrote a paragraph, then realized I misunderstood your concern. You are
> saying the comment from Uladzislau about my original draft patch, right?
> Paste the link of Uladzislau's reply here in case other people want to
> know the background:
> https://lore.kernel.org/all/Y1uKSmgURNEa3nQu@pc636/T/#u
> 
> When Stephen raised the issue originally, I posted a draft patch as
> below trying to fix it:
> https://lore.kernel.org/all/Y1pHTj2wuhoWmeV3@MiWiFi-R3L-srv/T/#u
> 
> In above draft patch, I tried to differentiate normal vmalloc area and
> vm_map_ram area with the fact that vmalloc area is associated with a
> vm_struct, while vm_map_ram area has ->vm as NULL. And I thought their
> only difference is normal vmalloc area has guard page, so its size need
> consider the guard page; while vm_map_ram area has no guard page, only
> consider its own actual size. Uladzislau's comment reminded me I was
> wrong. And the things we need handle are beyond that.
> 
> Currently there are three kinds of vmalloc areas in kernel:
> 
> 1) normal vmalloc areas, associated with a vm_struct, this is allocated 
> in __get_vm_area_node(). When freeing, it set ->vm to NULL
> firstly, then unmap and free vmap_area, see remove_vm_area().
> 
> 2) areas allocated via vm_map_ram() and size is larger than
> VMAP_MAX_ALLOC. The entire area is not associated with vm_struct, and
> freed at one time in vm_unmap_ram() with unmapping and freeing vmap_area;
> 
> 3) areas allocated via vm_map_ram(), then delegate to vb_alloc() when
> size <= VMAP_MAX_ALLOC. Its vmap_area is allocated at one time with
> VMAP_BLOCK_SIZE big, and split and used later through vb_alloc(), freed
> via vb_free(). When the entire area is dirty, it will be unmapped and
> freed.
> 
> Based on above facts, we need add flags to differentiate the normal
> vmalloc area from the vm_map_ram area, namely area 1) and 2). And we
> also need flags to differentiate the area 2) and 3). Because area 3) are
> pieces of a entire vmap_area, vb_free() will unmap the piece of area and
> set the part dirty, but the entire vmap_area will kept there. So when we
> will read area 3), we need take vb->lock and only read out the still
> mapped part, but not dirty or free part of the vmap_area.

I don't think you understand the problem.

Task A:			Task B:		Task C:
p = vm_map_ram()
			vread(p);
			... preempted ...
vm_unmap_ram(p);
					q = vm_map_ram();
			vread continues

If C has reused the address space allocated by A, task B is now reading
the memory mapped by task C instead of task A.  If it hasn't, it's now
trying to read from unmapped, and quite possibly freed memory.  Which
might have been allocated by task D.

Unless there's some kind of reference count so that B knows that both
the address range and the underlying memory can't be freed while it's
in the middle of the vread(), this is just unsafe.
