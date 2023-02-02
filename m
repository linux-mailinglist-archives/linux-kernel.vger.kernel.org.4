Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19576873BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjBBDVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBBDVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1146575789
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675308015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rK7R8Ymf//RLaf8YqF06g2e/AYVjMdAxmOF83wfnLdo=;
        b=TI7QKUGmsEr87HL1NScuDA52d0H/FsJTKY/BwTAFDvXVhHLlvAYwXywkqg3FgF8Iy0SXEC
        pKNIGCgozi1QG3qwWB79/QQCJaXN8Ri/uO72VvPYwAYPZpnYkQbYpgjihM7cDjtYy36jtz
        uwqE/lJaft4rLGN+Q4nIl7zT35IFVwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-eL-bS1ooPSu4NaxsFXnbeA-1; Wed, 01 Feb 2023 22:20:13 -0500
X-MC-Unique: eL-bS1ooPSu4NaxsFXnbeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 617F7802314;
        Thu,  2 Feb 2023 03:20:12 +0000 (UTC)
Received: from localhost (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BB31404BEC0;
        Thu,  2 Feb 2023 03:20:10 +0000 (UTC)
Date:   Thu, 2 Feb 2023 11:20:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, stephen.s.brennan@oracle.com,
        urezki@gmail.com, willy@infradead.org, hch@infradead.org,
        error27@gmail.com
Subject: Re: [PATCH v4 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y9sr56DqC+JCXt7z@MiWiFi-R3L-srv>
References: <20230201091339.61761-1-bhe@redhat.com>
 <20230201091339.61761-4-bhe@redhat.com>
 <Y9rImPGSF/EQ1Xey@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9rImPGSF/EQ1Xey@lucifer>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/23 at 08:16pm, Lorenzo Stoakes wrote:
> On Wed, Feb 01, 2023 at 05:13:35PM +0800, Baoquan He wrote:
> > Currently, vread can read out vmalloc areas which is associated with
> > a vm_struct. While this doesn't work for areas created by vm_map_ram()
> > interface because it doesn't have an associated vm_struct. Then in vread(),
> > these areas are all skipped.
> >
> > Here, add a new function vmap_ram_vread() to read out vm_map_ram areas.
> > The area created with vmap_ram_vread() interface directly can be handled
> > like the other normal vmap areas with aligned_vread(). While areas
> > which will be further subdivided and managed with vmap_block need
> > carefully read out page-aligned small regions and zero fill holes.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/vmalloc.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 80 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index ab4825050b5c..5a3ea6cb7ec2 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3544,6 +3544,67 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
> >  	return copied;
> >  }
> >
> > +static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags)
> > +{
> > +	char *start;
> > +	struct vmap_block *vb;
> > +	unsigned long offset;
> > +	unsigned int rs, re, n;
> > +
> > +	/*
> > +	 * If it's area created by vm_map_ram() interface directly, but
> > +	 * not further subdividing and delegating management to vmap_block,
> > +	 * handle it here.
> > +	 */
> > +	if (!(flags & VMAP_BLOCK)) {
> > +		aligned_vread(buf, addr, count);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Area is split into regions and tracked with vmap_block, read out
> > +	 * each region and zero fill the hole between regions.
> > +	 */
> > +	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> > +	if (!vb)
> > +		goto finished;
> > +
> > +	spin_lock(&vb->lock);
> > +	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
> > +		spin_unlock(&vb->lock);
> > +		goto finished;
> > +	}
> > +	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> > +		if (!count)
> > +			break;
> > +		start = vmap_block_vaddr(vb->va->va_start, rs);
> > +		while (addr < start) {
> > +			if (count == 0)
> > +				break;
> 
> Bit pedantic, but you're using the `if (!count)` form of checking whether it's
> zero above, but here you explicitly check it, would be good to keep both consistent.

Yeah, sounds good. Will change.

> 
> Given you're checking here, perhaps you could simply drop the previous check?

Well, maybe no. The previous "if (!count)" is checking if count is 0
after the 'count -=n;' line at the end of the for_each loop. While this
"if (count == 0)" is checking if count is 0 after 'count--;' at the end
of while loop. Not sure if I got your point.

> 
> > +			*buf = '\0';
> > +			buf++;
> > +			addr++;
> > +			count--;
> > +		}
> > +		/*it could start reading from the middle of used region*/
> > +		offset = offset_in_page(addr);
> > +		n = ((re - rs + 1) << PAGE_SHIFT) - offset;
> > +		if (n > count)
> > +			n = count;
> > +		aligned_vread(buf, start+offset, n);
> > +
> > +		buf += n;
> > +		addr += n;
> > +		count -= n;
> > +	}
> > +	spin_unlock(&vb->lock);
> > +
> > +finished:
> > +	/* zero-fill the left dirty or free regions */
> > +	if (count)
> > +		memset(buf, 0, count);
> > +}
> > +
> >  /**
> >   * vread() - read vmalloc area in a safe way.
> >   * @buf:     buffer for reading data
> > @@ -3574,7 +3635,7 @@ long vread(char *buf, char *addr, unsigned long count)
> >  	struct vm_struct *vm;
> >  	char *vaddr, *buf_start = buf;
> >  	unsigned long buflen = count;
> > -	unsigned long n;
> > +	unsigned long n, size, flags;
> >
> >  	addr = kasan_reset_tag(addr);
> >
> > @@ -3595,12 +3656,21 @@ long vread(char *buf, char *addr, unsigned long count)
> >  		if (!count)
> >  			break;
> >
> > -		if (!va->vm)
> > +		vm = va->vm;
> > +		flags = va->flags & VMAP_FLAGS_MASK;
> > +		/*
> > +		 * VMAP_BLOCK indicates a sub-type of vm_map_ram area, need
> > +		 * be set together with VMAP_RAM.
> > +		 */
> > +		WARN_ON(flags == VMAP_BLOCK);
> > +
> > +		if (!vm && !flags)
> >  			continue;
> >
> > -		vm = va->vm;
> > -		vaddr = (char *) vm->addr;
> > -		if (addr >= vaddr + get_vm_area_size(vm))
> > +		vaddr = (char *) va->va_start;
> > +		size = vm ? get_vm_area_size(vm) : va_size(va);
> > +
> > +		if (addr >= vaddr + size)
> >  			continue;
> >  		while (addr < vaddr) {
> >  			if (count == 0)
> > @@ -3610,10 +3680,13 @@ long vread(char *buf, char *addr, unsigned long count)
> >  			addr++;
> >  			count--;
> >  		}
> > -		n = vaddr + get_vm_area_size(vm) - addr;
> > +		n = vaddr + size - addr;
> >  		if (n > count)
> >  			n = count;
> > -		if (!(vm->flags & VM_IOREMAP))
> > +
> > +		if (flags & VMAP_RAM)
> > +			vmap_ram_vread(buf, addr, n, flags);
> > +		else if (!(vm->flags & VM_IOREMAP))
> >  			aligned_vread(buf, addr, n);
> >  		else /* IOREMAP area is treated as memory hole */
> >  			memset(buf, 0, n);
> > --
> > 2.34.1
> >
> 
> Other than the nit, feel free to add:-
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> 

