Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EA86CD134
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjC2EeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2EeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D676E26A5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680064397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rRwu3ztVYvKt4K2vX6rUuVGMO2e8UGV6paC6FMa9y/I=;
        b=EZKIkkMoJ0GaZMw4y/DjaDKx4jTvTpYUTuvwMNG/lzv16uJIA3wRrJZlppl5hQg70zFVaj
        uhMlrp1wUt1J6tpq/RJwifnaeEzaccbihd8rYISOD0aRIJ+Gy6okItp5nKVjxRBnsVPgA6
        N5ZgFY68GkMqAT8eF+AF/1gPJplCkww=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-9eGy4BwpN02NIhmiOtAIWw-1; Wed, 29 Mar 2023 00:33:11 -0400
X-MC-Unique: 9eGy4BwpN02NIhmiOtAIWw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A2AE80C8C2;
        Wed, 29 Mar 2023 04:33:11 +0000 (UTC)
Received: from localhost (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B428C15BA0;
        Wed, 29 Mar 2023 04:33:09 +0000 (UTC)
Date:   Wed, 29 Mar 2023 12:33:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCO/gTgw9PUuU+mG@MiWiFi-R3L-srv>
References: <20230327170126.406044-1-urezki@gmail.com>
 <ZCJd//IM6FGkbVTJ@MiWiFi-R3L-srv>
 <ZCLex4BPPtosouvd@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCLex4BPPtosouvd@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/23 at 02:34pm, Uladzislau Rezki wrote:
......  
> > > @@ -2003,8 +2037,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> > >  	bitmap_set(vb->used_map, 0, (1UL << order));
> > >  	INIT_LIST_HEAD(&vb->free_list);
> > >  
> > > -	vb_idx = addr_to_vb_idx(va->va_start);
> > > -	err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
> > > +	vbq = addr_to_vbq(va->va_start);
> > > +	err = xa_insert(&vbq->vmap_blocks, va->va_start, vb, gfp_mask);
> > 
> > Using va->va_start as index to access xarray may cost extra memory.
> > Imagine we got a virtual address at VMALLOC_START, its region is
> > [VMALLOC_START, VMALLOC_START+4095]. In the xarray, its sequence order
> > is 0. While with va->va_start, it's 0xffffc90000000000UL on x86_64 with
> > level4 paging mode. That means for the first page size vmalloc area,
> > storing it into xarray need about 10 levels of xa_node, just for the one
> > page size. With the old addr_to_vb_idx(), its index is 0. Only one level
> > height is needed. One xa_node is about 72bytes, it could take more time
> > and memory to access va->va_start. Not sure if my understanding is correct.
> > 
> > static unsigned long addr_to_vb_idx(unsigned long addr)
> > {
> >         addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
> >         addr /= VMAP_BLOCK_SIZE;
> >         return addr;
> > }
> > 
> If the size of array depends on index "length", then, indeed it will require
> more memory. From the other hand we can keep the old addr_to_vb_idx() function 
> in order to "cut" a va->va_start index.

Yeah, the extra 10 levels of xa_node is unnecessary if we keep the old
addr_to_vb_idx(). And the prolonged path will cost more time to reach the 
wanted leaf node. E.g on x86_64 with 4 level paging mode, vmalloc area
is 32TB. With the old calculation, its index range is [0, 8M], 4 level
heights of xa_node at most is enough to cover.

