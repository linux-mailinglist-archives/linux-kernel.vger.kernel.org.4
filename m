Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A5F647F3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLII2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLII2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:28:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7876310
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 00:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670574461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5PNq7BuzrIj0WOAorIXdgJHnJPF+VBpzrzEg+7HTfZI=;
        b=I7VFYblyYhohwC/F7LtXvoihDmDB8Rr3IT48r4jceEyrMPiFNE2QvJLbu9MaYCufoM3Bz/
        J9xyMQVlDGm73i8srWRWg/cYKSOHR+THd6jAYS3NKC6prD9oMiYbiX5xNeFUpXH2525+OL
        5jKvzckKqgivRcxgifcbMYBVlukOHdI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-iRY_Cp07O4Gy04162ffIrA-1; Fri, 09 Dec 2022 03:27:39 -0500
X-MC-Unique: iRY_Cp07O4Gy04162ffIrA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74B6529ABA1B;
        Fri,  9 Dec 2022 08:27:39 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 844442166B26;
        Fri,  9 Dec 2022 08:27:38 +0000 (UTC)
Date:   Fri, 9 Dec 2022 16:27:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v1 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y5LxdkM5QlBL3OIC@MiWiFi-R3L-srv>
References: <20221204013046.154960-1-bhe@redhat.com>
 <20221204013046.154960-3-bhe@redhat.com>
 <Y43qfdseyq0zizJO@pc636>
 <Y5BI3Sp8QCyweXwt@MiWiFi-R3L-srv>
 <Y5JAkqeecvNwPcRf@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5JAkqeecvNwPcRf@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/22 at 08:52pm, Uladzislau Rezki wrote:
> On Wed, Dec 07, 2022 at 04:03:41PM +0800, Baoquan He wrote:
......
> > > > @@ -1967,6 +1972,9 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> > > >  		kfree(vb);
> > > >  		return ERR_CAST(va);
> > > >  	}
> > > > +	spin_lock(&vmap_area_lock);
> > > > +	va->flags = VMAP_RAM|VMAP_BLOCK;
> > > > +	spin_unlock(&vmap_area_lock);
> > > >
> > > The per-cpu code was created as a fast per-cpu allocator because of high
> > > vmalloc lock contention. If possible we should avoid of locking of the
> > > vmap_area_lock. Because it has a high contention.
> > 
> > Fair enough. I made below draft patch to address the concern. By
> > adding argument va_flags to alloc_vmap_area(), we can pass the 
> > vm_map_ram flags into alloc_vmap_area and filled into vmap_area->flags.
> > With this, we don't need add extra action to acquire vmap_area_root lock
> > and do the flags setting. Is it OK to you?
> > 
> > From 115f6080b339d0cf9dd20c5f6c0d3121f6b22274 Mon Sep 17 00:00:00 2001
> > From: Baoquan He <bhe@redhat.com>
> > Date: Wed, 7 Dec 2022 11:08:14 +0800
> > Subject: [PATCH] mm/vmalloc: change alloc_vmap_area() to pass in va_flags
> > 
> > With this change, we can pass and set vmap_area->flags for vm_map_ram area
> > in alloc_vmap_area(). Then no extra action need be added to acquire
> > vmap_area_lock when doing the vmap_area->flags setting.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/vmalloc.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index ccaa461998f3..d74eddec352f 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1586,7 +1586,9 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
> >  static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  				unsigned long align,
> >  				unsigned long vstart, unsigned long vend,
> > -				int node, gfp_t gfp_mask)
> > +				int node, gfp_t gfp_mask,
> > +				unsigned long va_flags)
> > +)
> >  {
> >  	struct vmap_area *va;
> >  	unsigned long freed;
> > @@ -1630,6 +1632,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	va->va_start = addr;
> >  	va->va_end = addr + size;
> >  	va->vm = NULL;
> > +	va->flags = va_flags;
> >  
> >  	spin_lock(&vmap_area_lock);
> >  	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> > @@ -1961,7 +1964,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  
> >  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
> >  					VMALLOC_START, VMALLOC_END,
> > -					node, gfp_mask);
> > +					node, gfp_mask,
> > +					VMAP_RAM|VMAP_BLOCK);
> >  	if (IS_ERR(va)) {
> >  		kfree(vb);
> >  		return ERR_CAST(va);
> > @@ -2258,7 +2262,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
> >  	} else {
> >  		struct vmap_area *va;
> >  		va = alloc_vmap_area(size, PAGE_SIZE,
> > -				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> > +				VMALLOC_START, VMALLOC_END,
> > +				node, GFP_KERNEL, VMAP_RAM|VMAP_BLOCK);
> >  		if (IS_ERR(va))
> >  			return NULL;
> >  
> > @@ -2498,7 +2503,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
> >  	if (!(flags & VM_NO_GUARD))
> >  		size += PAGE_SIZE;
> >  
> > -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask);
> > +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
> >  	if (IS_ERR(va)) {
> >  		kfree(area);
> >  		return NULL;
> > -- 
> > 2.34.1
> > 
> Yes, this is better than it was before. Adding an extra parameter makes
> it more valid and logical.

That's great. I will add this in v2.

