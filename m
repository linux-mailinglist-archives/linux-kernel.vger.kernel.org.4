Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2C7241D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbjFFMNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbjFFMNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB87199D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686053475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9UWxNSLczplRrlU8D85PXIfR9MjaZts2kqh1cwWtVQ=;
        b=O/hFqfesUD8iA6RLTT/0Mj6sCJTv7rmZibBCb/IHvXs6BhOVGHQwdH3jY0iPgwdDxRHDGh
        GjpDzTCBjYk5mAIMzPGwoHUltdTSwkuQ2cm6vrdo4bAFLQp8znHpVG2zaBsj4A3X/1EfRY
        Em6yxJNsnhiJsvEeJ9a2iczKVkAEr/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-qeLKYcDPMJqNh4S-gPwWtw-1; Tue, 06 Jun 2023 08:11:10 -0400
X-MC-Unique: qeLKYcDPMJqNh4S-gPwWtw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72CDE858F1C;
        Tue,  6 Jun 2023 12:11:09 +0000 (UTC)
Received: from localhost (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C01E492B00;
        Tue,  6 Jun 2023 12:11:08 +0000 (UTC)
Date:   Tue, 6 Jun 2023 20:11:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 8/9] mm: vmalloc: Offload free_vmap_area_lock global lock
Message-ID: <ZH8iWAgsDSF1I+B6@MiWiFi-R3L-srv>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-9-urezki@gmail.com>
 <ZH0vuwaSddREy9dz@MiWiFi-R3L-srv>
 <ZH7128Q0MiRh6S5f@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH7128Q0MiRh6S5f@pc638.lan>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/23 at 11:01am, Uladzislau Rezki wrote:
> On Mon, Jun 05, 2023 at 08:43:39AM +0800, Baoquan He wrote:
> > On 05/22/23 at 01:08pm, Uladzislau Rezki (Sony) wrote:
> > ......  
> > > +static unsigned long
> > > +this_cpu_zone_alloc_fill(struct cpu_vmap_zone *z,
> > > +	unsigned long size, unsigned long align,
> > > +	gfp_t gfp_mask, int node)
> > > +{
> > > +	unsigned long addr = VMALLOC_END;
> > > +	struct vmap_area *va;
> > > +
> > > +	/*
> > > +	 * It still can race. One task sets a progress to
> > > +	 * 1 a second one gets preempted on entry, the first
> > > +	 * zeroed the progress flag and second proceed with
> > > +	 * an extra prefetch.
> > > +	 */
> > > +	if (atomic_xchg(&z->fill_in_progress, 1))
> > > +		return addr;
> > > +
> > > +	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
> > > +	if (unlikely(!va))
> > > +		goto out;
> > > +
> > > +	spin_lock(&free_vmap_area_lock);
> > > +	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> > > +		cvz_size, 1, VMALLOC_START, VMALLOC_END);
> > > +	spin_unlock(&free_vmap_area_lock);
> > 
> > The 'z' is passed in from this_cpu_zone_alloc(), and it's got with
> > raw_cpu_ptr(&cpu_vmap_zone). Here when we try to get chunk of cvz_size
> > from free_vmap_area_root/free_vmap_area_list, how can we guarantee it
> > must belong to the 'z' zone? With my understanding, __alloc_vmap_area()
> > will get efficient address range sequentially bottom up from
> > free_vmap_area_root. Please correct me if I am wrong.
> > 
> We do not guarantee that and it does not worth it. The most important is:
> 
> If we search a zone that exactly match a CPU-id the usage of a global
> vmap space becomes more wider, i.e. toward a high address space. This is
> not good because we can affect other users which allocate within a specific
> range. On a big system it might be a problem. Therefore a pre-fetch is done 
> sequentially on demand.
> 
> Secondly, i do not see much difference in performance if we follow
> exactly CPU-zone-id.

Ah, I see, the allocated range will be put into appropriate zone's
busy tree by calculating its zone via addr_to_cvz(va->va_start). The
cvz->free tree is only a percpu pre-fetch cache. This is smart, thanks a
lot for explanation. 

> 
> > static unsigned long
> > this_cpu_zone_alloc(unsigned long size, unsigned long align, gfp_t gfp_mask, int node)
> > {
> >         struct cpu_vmap_zone *z = raw_cpu_ptr(&cpu_vmap_zone);
> > 	......
> > 	if (addr == VMALLOC_END && left < 4 * PAGE_SIZE)
> >                 addr = this_cpu_zone_alloc_fill(z, size, align, gfp_mask, node);
> > }
> > 
> > > +
> > > +	if (addr == VMALLOC_END) {
> > > +		kmem_cache_free(vmap_area_cachep, va);
> > > +		goto out;
> > > +	}
> > > +
> > > +	va->va_start = addr;
> > > +	va->va_end = addr + cvz_size;
> > > +
> > > +	fbl_lock(z, FREE);
> > > +	va = merge_or_add_vmap_area_augment(va,
> > > +		&fbl_root(z, FREE), &fbl_head(z, FREE));
> > > +	addr = va_alloc(va, &fbl_root(z, FREE), &fbl_head(z, FREE),
> > > +		size, align, VMALLOC_START, VMALLOC_END);
> > > +	fbl_unlock(z, FREE);
> > > +
> > > +out:
> > > +	atomic_set(&z->fill_in_progress, 0);
> > > +	return addr;
> > > +}
> > > +
> > > +static unsigned long
> > > +this_cpu_zone_alloc(unsigned long size, unsigned long align, gfp_t gfp_mask, int node)
> > > +{
> > > +	struct cpu_vmap_zone *z = raw_cpu_ptr(&cpu_vmap_zone);
> > > +	unsigned long extra = align > PAGE_SIZE ? align : 0;
> > > +	unsigned long addr = VMALLOC_END, left = 0;
> > > +
> > > +	/*
> > > +	 * It is disabled, fallback to a global heap.
> > > +	 */
> > > +	if (cvz_size == ULONG_MAX)
> > > +		return addr;
> > > +
> > > +	/*
> > > +	 * Any allocation bigger/equal than one half of
> >                           ~~~~~~typo~~~~~~  bigger than/equal to
> I will rework it!
> 
> --
> Uladzislau Rezki
> 

