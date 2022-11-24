Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B340A637597
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiKXJxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKXJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:53:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3765B22525
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669283566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7L+h3KurfKA2XgF/JWh+o00uAwdQI7k3d5Am6A8/bns=;
        b=XwNaBfzEWOCWEKv5kXN7tHqgLg8Ktu6gWgl9BPHdWwMUQwriVFEe4Mei5a20ksQIK8wyyA
        yfw4Runs+JbVIKiakmzIVPze26imcoSGQqGanm57hNusm7zkzgtvByWCqguw7pP5D4P6CG
        tCXnuHnvL1vNPNX9lUfuAMjqTq4He74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-fbvlmA5dNAGqu3AJn1gNIg-1; Thu, 24 Nov 2022 04:52:42 -0500
X-MC-Unique: fbvlmA5dNAGqu3AJn1gNIg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F2DE101A528;
        Thu, 24 Nov 2022 09:52:42 +0000 (UTC)
Received: from localhost (ovpn-12-208.pek2.redhat.com [10.72.12.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5952492B04;
        Thu, 24 Nov 2022 09:52:40 +0000 (UTC)
Date:   Thu, 24 Nov 2022 17:52:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, stephen.s.brennan@oracle.com,
        urezki@gmail.com, hch@infradead.org
Subject: Re: [PATCH RFC 3/3] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y38+4tspZxRJj73p@MiWiFi-R3L-srv>
References: <20221109033535.269229-1-bhe@redhat.com>
 <20221109033535.269229-4-bhe@redhat.com>
 <Y3c77o95A9vKQ745@casper.infradead.org>
 <Y32VznHyZrS6vs4E@MiWiFi-R3L-srv>
 <Y34fIzV7UnquyS1r@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y34fIzV7UnquyS1r@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 at 01:24pm, Matthew Wilcox wrote:
> On Wed, Nov 23, 2022 at 11:38:54AM +0800, Baoquan He wrote:
> > On 11/18/22 at 08:01am, Matthew Wilcox wrote:
> > > On Wed, Nov 09, 2022 at 11:35:34AM +0800, Baoquan He wrote:
> > > > Currently, vread() can read out vmalloc areas which is associated with
> > > > a vm_struct. While this doesn't work for areas created by vm_map_ram()
> > > > interface because it doesn't allocate a vm_struct. Then in vread(),
> > > > these areas will be skipped.
> > > > 
> > > > Here, add a new function vb_vread() to read out areas managed by
> > > > vmap_block specifically. Then recognize vm_map_ram areas via vmap->flags
> > > > and handle  them respectively.
> > > 
> > > i don't understand how this deals with the original problem identified,
> > > that the vread() can race with an unmap.
> > 
> > Thanks for checking.
> > 
> > I wrote a paragraph, then realized I misunderstood your concern. You are
> > saying the comment from Uladzislau about my original draft patch, right?
> > Paste the link of Uladzislau's reply here in case other people want to
> > know the background:
> > https://lore.kernel.org/all/Y1uKSmgURNEa3nQu@pc636/T/#u
> > 
> > When Stephen raised the issue originally, I posted a draft patch as
> > below trying to fix it:
> > https://lore.kernel.org/all/Y1pHTj2wuhoWmeV3@MiWiFi-R3L-srv/T/#u
> > 
> > In above draft patch, I tried to differentiate normal vmalloc area and
> > vm_map_ram area with the fact that vmalloc area is associated with a
> > vm_struct, while vm_map_ram area has ->vm as NULL. And I thought their
> > only difference is normal vmalloc area has guard page, so its size need
> > consider the guard page; while vm_map_ram area has no guard page, only
> > consider its own actual size. Uladzislau's comment reminded me I was
> > wrong. And the things we need handle are beyond that.
> > 
> > Currently there are three kinds of vmalloc areas in kernel:
> > 
> > 1) normal vmalloc areas, associated with a vm_struct, this is allocated 
> > in __get_vm_area_node(). When freeing, it set ->vm to NULL
> > firstly, then unmap and free vmap_area, see remove_vm_area().
> > 
> > 2) areas allocated via vm_map_ram() and size is larger than
> > VMAP_MAX_ALLOC. The entire area is not associated with vm_struct, and
> > freed at one time in vm_unmap_ram() with unmapping and freeing vmap_area;
> > 
> > 3) areas allocated via vm_map_ram(), then delegate to vb_alloc() when
> > size <= VMAP_MAX_ALLOC. Its vmap_area is allocated at one time with
> > VMAP_BLOCK_SIZE big, and split and used later through vb_alloc(), freed
> > via vb_free(). When the entire area is dirty, it will be unmapped and
> > freed.
> > 
> > Based on above facts, we need add flags to differentiate the normal
> > vmalloc area from the vm_map_ram area, namely area 1) and 2). And we
> > also need flags to differentiate the area 2) and 3). Because area 3) are
> > pieces of a entire vmap_area, vb_free() will unmap the piece of area and
> > set the part dirty, but the entire vmap_area will kept there. So when we
> > will read area 3), we need take vb->lock and only read out the still
> > mapped part, but not dirty or free part of the vmap_area.
> 
> I don't think you understand the problem.
> 
> Task A:			Task B:		Task C:
> p = vm_map_ram()
> 			vread(p);
> 			... preempted ...
> vm_unmap_ram(p);
> 					q = vm_map_ram();
> 			vread continues



> 
> If C has reused the address space allocated by A, task B is now reading
> the memory mapped by task C instead of task A.  If it hasn't, it's now
> trying to read from unmapped, and quite possibly freed memory.  Which
> might have been allocated by task D.

Hmm, it may not be like that.

Firstly, I would remind that vread() takes vmap_area_lock during the
whole reading process. Before this patchset, the vread() and other area
manipulation will have below status:
1) __get_vm_area_node() could only finish insert_vmap_area(), then free
the vmap_area_lock, then warting;
2) __get_vm_area_node() finishs setup_vmalloc_vm()
  2.1) doing mapping but not finished;
  2.2) clear_vm_uninitialized_flag() is called after mapping is done;
3) remove_vm_area() is called to set -> = NULL, then free vmap_area_lock;

Task A:			   Task B:		     Task C:
p = __get_vm_area_node()
remove_vm_area(p);
			   vread(p);

			   vread end 
					     q = __get_vm_area_node();

So, as you can see, the checking "if (!va->vm)" in vread() will filter
out vmap_area:
a) areas if only insert_vmap_area() is called, but ->vm is still NULL; 
b) areas if remove_vm_area() is called to clear ->vm to NULL;
c) areas created through vm_map_ram() since its ->vm is always NULL;

Means vread() will read out vmap_area:
d) areas if setup_vmalloc_vm() is called;
  1) mapping is done on areas, e.g clear_vm_uninitialized_flag() is
       called;
  2) mapping is being handled, just after returning from setup_vmalloc_vm();


******* after this patchset applied:

Task A:			Task B:		Task C:
p = vm_map_ram()
vm_unmap_ram(p);
			vread(p);
                         vb_vread()
			vread end 

					q = vm_map_ram();

With this patchset applied, other than normal areas, for the
vm_map_ram() areas:
1) In vm_map_ram(), set vmap_area->flags = VMAP_RAM when vmap_area_lock
   is taken; In vm_unmap_ram(), clear it wiht "va->flags &= ~VMAP_RAM"
   when vmap_area_lock is taken;
2) If vmap_block, set va->flags = VMAP_RAM|VMAP_BLOCK; And set
   vmap_block->used_map to track the used region, filter out the dirty
   and free region;
3) In vb_vread(), we take vb->lock to avoid reading out dirty regions.

Please help point out what is wrong or I missed.

> 
> Unless there's some kind of reference count so that B knows that both
> the address range and the underlying memory can't be freed while it's
> in the middle of the vread(), this is just unsafe.
> 

