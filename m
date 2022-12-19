Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1E565085C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 09:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiLSICG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 03:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiLSIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 03:01:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F6B2710
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 00:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671436868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xt5/uiaQBWC3cRw5vbprkSzWH2IlI+tYcfTCqp0vhwk=;
        b=ElLkYB9pF5FAvrNhlNFZl96e369yebRr6aLB8iNtZ6i65p1+8XSc3cSB+xRQb1SJPjmFpW
        R1mLV4MXd9VIzmlC2k2gnSbyxkCma3P8Gi1mvpKlO1dQ9uCku+jx9u7/GwV1H99dPMR/qc
        N6sBoVlId+UG7r1TqJEg/pB7DYnwAjU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-7NJ4EhN1P5auwNSH5O_5-Q-1; Mon, 19 Dec 2022 03:01:06 -0500
X-MC-Unique: 7NJ4EhN1P5auwNSH5O_5-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C765101A521;
        Mon, 19 Dec 2022 08:01:06 +0000 (UTC)
Received: from localhost (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CD1E40C1074;
        Mon, 19 Dec 2022 08:01:03 +0000 (UTC)
Date:   Mon, 19 Dec 2022 16:01:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y6AaPKT7mdVxdHRl@MiWiFi-R3L-srv>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-3-bhe@redhat.com>
 <Y52rllbXHMwbpJ8K@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y52rllbXHMwbpJ8K@lucifer>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/22 at 11:44am, Lorenzo Stoakes wrote:
> On Sat, Dec 17, 2022 at 09:54:30AM +0800, Baoquan He wrote:
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
> >  				    (va->va_end - va->va_start));
> >  	free_unmap_vmap_area(va);
> 
> Would it be better to perform the BUG_ON() after the lock is released? You
> already check if va exists before unmasking so it's safe.

It's a little unclear to me why we care BUG_ON() is performed before or
after the lock released. We won't have a stable kernel after BUG_ON()(),
right?
> 
> Also, do we want to clear VMAP_BLOCK here?

I do, but I don't find a good place to clear VMAP_BLOCK.

In v1, I tried to clear it in free_vmap_area_noflush() as below,
Uladzislau dislikes it. So I remove it. My thinking is when we unmap and
free the vmap area, the vmap_area is moved from vmap_area_root into
&free_vmap_area_root. When we allocate a new vmap_area via
alloc_vmap_area(), we will allocate a new va by kmem_cache_alloc_node(),
the va->flags must be 0. Seems not initializing it to 0 won't impact
thing.

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5d3fd3e6fe09..d6f376060d83 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1815,6 +1815,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)

        spin_lock(&vmap_area_lock);
        unlink_va(va, &vmap_area_root);
+       va->flags = 0;
        spin_unlock(&vmap_area_lock);

        nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>

> 

