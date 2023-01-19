Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9091C6738F7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjASMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjASMtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED4D1E1EE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674132533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YAKRFMXRp2ApOVKi5cAZjE7qcay8g+VNvLJ9cfYcxHU=;
        b=dbL2dHJfjXoE87j2A0CVDxCXYGbKr/+uvio9oI6MNKcJyNKqsHiBdWmq1ET/Uw//H/R7Ng
        /sPCvNGzFVwjMjioH+YmKHyObpwAYYq6b0IxU+B/0DwlTsXZPMKdr7rZjy9lntdD2LGAGx
        LaLJPX1F8Xnr8VSZaIL8UMQjIhnvQx8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-P25k8TtnNPWS2eseBHZwiA-1; Thu, 19 Jan 2023 07:48:48 -0500
X-MC-Unique: P25k8TtnNPWS2eseBHZwiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 608A1183B3C0;
        Thu, 19 Jan 2023 12:48:48 +0000 (UTC)
Received: from localhost (ovpn-13-24.pek2.redhat.com [10.72.13.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 853622026D68;
        Thu, 19 Jan 2023 12:48:47 +0000 (UTC)
Date:   Thu, 19 Jan 2023 20:48:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        lstoakes@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y8k8K9Ztfm/Yj5PO@fedora>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-4-bhe@redhat.com>
 <Y8U6Gi5d4F8mO0ib@pc636>
 <Y8kSwyJBe426pj7R@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8kSwyJBe426pj7R@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/23 at 05:52pm, Baoquan He wrote:
> On 01/16/23 at 12:50pm, Uladzislau Rezki wrote:
> > On Fri, Jan 13, 2023 at 11:19:17AM +0800, Baoquan He wrote:
> > > Currently, vread can read out vmalloc areas which is associated with
> > > a vm_struct. While this doesn't work for areas created by vm_map_ram()
> > > interface because it doesn't have an associated vm_struct. Then in vread(),
> > > these areas are all skipped.
> > > 
> > > Here, add a new function vmap_ram_vread() to read out vm_map_ram areas.
> > > The area created with vmap_ram_vread() interface directly can be handled
> > > like the other normal vmap areas with aligned_vread(). While areas
> > > which will be further subdivided and managed with vmap_block need
> > > carefully read out page-aligned small regions and zero fill holes.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  mm/vmalloc.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 73 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index ab4825050b5c..13875bc41e27 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3544,6 +3544,65 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
> > >  	return copied;
> > >  }
> > >  
> > > +static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags)
> > > +{
> > > +	char *start;
> > > +	struct vmap_block *vb;
> > > +	unsigned long offset;
> > > +	unsigned int rs, re, n;
> > > +
> > > +	/*
> > > +	 * If it's area created by vm_map_ram() interface directly, but
> > > +	 * not further subdividing and delegating management to vmap_block,
> > > +	 * handle it here.
> > > +	 */
> > > +	if (!(flags & VMAP_BLOCK)) {
> > > +		aligned_vread(buf, addr, count);
> > > +		return;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Area is split into regions and tracked with vmap_block, read out
> > > +	 * each region and zero fill the hole between regions.
> > > +	 */
> > > +	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> > > +
> > > +	spin_lock(&vb->lock);
> > > +	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
> > >
> > CPU-X invokes free_vmap_block() whereas we take the vb->lock and do
> > some manipulations with vb that might be already freed over RCU-core.
> > 
> > Should we protect it by the rcu_read_lock() also here?
> 
> Just go over the vb and vbq code again, seems we don't need the
> rcu_read_lock() here. The rcu lock is needed when operating on the
> vmap_block_queue->free list. I don't see race between the vb accessing
> here and those list adding or removing on vmap_block_queue->free with
> rcu. If I miss some race windows between them, please help point out.
> 
> However, when I check free_vmap_block(), I do find a risk. As you said,

Forgot to add details about why there's no race between free_vmap_block()
and vmap_ram_vread() because we have taken vmap_area_lock at the beginning
of vread(). So, except of the missing checking on returned value from
xa_load(), free_vmap_block() either is blocked to wait for vmap_area_lock
before calling unlink_va(), or finishes calling unlink_va() to remove
the vmap from vmap_area_root tree. In both cases, no race happened.

> CPU-x invokes free_vmap_block() and executed xa_erase() to remove the vb
> from vmap_blocks tree. Then vread() comes into vmap_ram_vread() and call
> xa_load(), it would be null. I should check the returned vb in
> free_vmap_block().
> 
> 
> static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags)
> {
> ......
> if (!(flags & VMAP_BLOCK)) {
>                 aligned_vread(buf, addr, count);
>                 return;
>         }
> 
>         /*
>          * Area is split into regions and tracked with vmap_block, read out
>          * each region and zero fill the hole between regions.
>          */
>         vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> 	if (!vb)    <-- vb need be checked here to avoid accessing erased vb from vmap_blocks tree
> 		memset(buf, 0, count);
> ......
> }
> 

