Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA4650B68
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiLSMZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiLSMZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:25:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D36DEC2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671452696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZJjKwl9viRzOtHWuPnaZZpLHGevx7oKmf4B2oFCUswI=;
        b=SdHs9HtQ+GBdbnGKcGJKRYSNkxUxzFgFXUUw79E+P2AUSF5OQNHxCP6vv7kSIbBGw5dpQA
        4X0zylzgdD1yVd35Ul6yYW9fQUX3/94rzVN/3pa/A4Ld5o/N3QO0S3fhWJVFzUIDwIHo5Q
        +eTQp2X9TdzGbiOpSqeq1FT1ZreGx74=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-cGoprQawMYWMl6k7v-feqA-1; Mon, 19 Dec 2022 07:24:53 -0500
X-MC-Unique: cGoprQawMYWMl6k7v-feqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81DA01C07562;
        Mon, 19 Dec 2022 12:24:52 +0000 (UTC)
Received: from localhost (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2413C1410DD7;
        Mon, 19 Dec 2022 12:24:50 +0000 (UTC)
Date:   Mon, 19 Dec 2022 20:24:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y6BYD24wzAogqRyT@MiWiFi-R3L-srv>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-3-bhe@redhat.com>
 <Y52rllbXHMwbpJ8K@lucifer>
 <Y6AaPKT7mdVxdHRl@MiWiFi-R3L-srv>
 <Y6AqRauq6wEYK0n5@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6AqRauq6wEYK0n5@lucifer>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 at 09:09am, Lorenzo Stoakes wrote:
> On Mon, Dec 19, 2022 at 04:01:00PM +0800, Baoquan He wrote:
> > On 12/17/22 at 11:44am, Lorenzo Stoakes wrote:
> > > On Sat, Dec 17, 2022 at 09:54:30AM +0800, Baoquan He wrote:
> > > > @@ -2229,8 +2236,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
> > > >  		return;
> > > >  	}
> > > >
> > > > -	va = find_vmap_area(addr);
> > > > +	spin_lock(&vmap_area_lock);
> > > > +	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> > > >  	BUG_ON(!va);
> > > > +	if (va)
> > > > +		va->flags &= ~VMAP_RAM;
> > > > +	spin_unlock(&vmap_area_lock);
> > > >  	debug_check_no_locks_freed((void *)va->va_start,
> > > >  				    (va->va_end - va->va_start));
> > > >  	free_unmap_vmap_area(va);
> > >
> > > Would it be better to perform the BUG_ON() after the lock is released? You
> > > already check if va exists before unmasking so it's safe.
> >
> > It's a little unclear to me why we care BUG_ON() is performed before or
> > after the lock released. We won't have a stable kernel after BUG_ON()(),
> > right?
> 
> BUG_ON()'s can be recoverable in user context and it would be a very simple
> change that would not fundamentally alter anything to simply place the added
> lines prior to the BUG_ON().
> 
> The code as-is doesn't really make sense anyway, you BUG_ON(!va) then check if
> va is non-null, then immediately the function afterwards passes va around as if
> it were not null, so I think it'd also be an aesthetic and logical improvement
> :)

In fact, I should not do the checking, but do the clearing anyway. If I
change it as below, does it look better to you?


diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5e578563784a..369b848d097a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2253,8 +2253,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 	spin_lock(&vmap_area_lock);
 	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
 	BUG_ON(!va);
-	if (va)
-		va->flags &= ~VMAP_RAM;
+	va->flags &= ~VMAP_RAM;
 	spin_unlock(&vmap_area_lock);
 	debug_check_no_locks_freed((void *)va->va_start,
 				    (va->va_end - va->va_start));

> 
> > >
> > > Also, do we want to clear VMAP_BLOCK here?
> >
> > I do, but I don't find a good place to clear VMAP_BLOCK.
> >
> > In v1, I tried to clear it in free_vmap_area_noflush() as below,
> > Uladzislau dislikes it. So I remove it. My thinking is when we unmap and
> > free the vmap area, the vmap_area is moved from vmap_area_root into
> > &free_vmap_area_root. When we allocate a new vmap_area via
> > alloc_vmap_area(), we will allocate a new va by kmem_cache_alloc_node(),
> > the va->flags must be 0. Seems not initializing it to 0 won't impact
> > thing.
> >
> 
> You are at this point clearing the VMAP_RAM flag though, so if it is unimportant
> what the flags are after this call, why are you clearing this one?

With my understanding, We had better do the clearing. Currently, from
the code, not doing the clearing won't cause issue. If possible, I would
like to clear it as below draft code.

> 
> It is just a little confusing, I wonder whether the VMAP_BLOCK flag is necessary
> at all, is it possible to just treat a non-VMAP_BLOCK VMAP_RAM area as if it
> were simply a fully occupied block? Do we gain much by the distinction?

Yeah, VMAP_BLOCK flag is necessary. vmap_block contains used region,
or dirty/free regions. While the non-vmap_blcok vm_map_ram area is
similar with the non vm_map_ram area. When reading out vm_map_ram
regions, vmap_block regions need be treated differently.

> 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 5d3fd3e6fe09..d6f376060d83 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1815,6 +1815,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)
> >
> >         spin_lock(&vmap_area_lock);
> >         unlink_va(va, &vmap_area_root);
> > +       va->flags = 0;
> >         spin_unlock(&vmap_area_lock);
> >
> >         nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
> >
> > >
> >
> 

