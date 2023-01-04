Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2693365CDF8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjADICl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjADICh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:02:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A818DD60
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672819308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dwgpmamNgNwEmXXg6tvLp+vc2Uwn9c8dy3qla9ZtcrQ=;
        b=DX5DbcKng7GT3g91tGIUh+RGy1XRtYReuU76jNZ32bxz/SSyv29DP23ngeD59sT3QyrCNc
        FPfutZ4pg5uSu6UoRuJxOaQKR2529VDUu48mckBCpc3Zvx/JLrq2XjK1R8875oI76708S0
        COeDdUyzUoIcrfw1lUlJSGMjWZz3D8g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-Jwd81b_3NC-qFfWoqIFMEA-1; Wed, 04 Jan 2023 03:01:43 -0500
X-MC-Unique: Jwd81b_3NC-qFfWoqIFMEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34B093C02B9D;
        Wed,  4 Jan 2023 08:01:42 +0000 (UTC)
Received: from localhost (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D77840C1141;
        Wed,  4 Jan 2023 08:01:40 +0000 (UTC)
Date:   Wed, 4 Jan 2023 16:01:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y7UyYDRnc663qzTs@MiWiFi-R3L-srv>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-4-bhe@redhat.com>
 <Y52wsONH+u/h0nuj@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y52wsONH+u/h0nuj@lucifer>
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

On 12/17/22 at 12:06pm, Lorenzo Stoakes wrote:
> On Sat, Dec 17, 2022 at 09:54:31AM +0800, Baoquan He wrote:
> > Currently, vread can read out vmalloc areas which is associated with
> > a vm_struct. While this doesn't work for areas created by vm_map_ram()
> > interface because it doesn't have an associated vm_struct. Then in vread(),
> > these areas will be skipped.
> >
> > Here, add a new function vb_vread() to read out areas managed by
> > vmap_block specifically. Then recognize vm_map_ram areas via vmap->flags
> > and handle them respectively.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/vmalloc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 59 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 190f29bbaaa7..6612914459cf 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3515,6 +3515,51 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
> >  	return copied;
> >  }
> >
> > +static void vb_vread(char *buf, char *addr, int count)
> > +{
> > +	char *start;
> > +	struct vmap_block *vb;
> > +	unsigned long offset;
> > +	unsigned int rs, re, n;
> > +
> > +	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> > +
> > +	spin_lock(&vb->lock);
> > +	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
> > +		spin_unlock(&vb->lock);
> > +		memset(buf, 0, count);
> > +		return;
> > +	}
> > +	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> > +		if (!count)
> > +			break;
> > +		start = vmap_block_vaddr(vb->va->va_start, rs);
> > +		if (addr < start) {
> > +			if (count == 0)
> > +				break;
> > +			*buf = '\0';
> > +			buf++;
> > +			addr++;
> > +			count--;
> > +		}

Very sorry, Lorenzo, I just noticed this mail. It's very weird. Earlier,
Uladzislau's reply to patch 2/7 got to be seen in my mutt mail client 10
days later. I am not sure it's my mail client's problem, or a mail server
delivery issue.

> 
> I may be missing something here, but is this not essentially 'if the address is
> below a used region, write a single null byte into the buffer and continue,
> assuming we are now in a used area?'

Not sure if I got you. for_each_set_bitrange only iterates the used
regions. So in the for loop, what we do is fill zero into the buffer
below the used region, then read out the used region. You said
'continue', I don't understand what it means.

Assume we have 3 used regions in one vmap block, see below diagram. 
     |_______|______________|________|_____________|_____|_____________|______|
     |hole 0 |used region 0 |hole 1  |used region 1|hole2|used region2 |hole 3 |

hole 0,1,2 will be set zero when we iterate to the used region above
them. And the last hole 3 is set at the end of this function. Please
help point it out if I got it wrong.
 
> 
> This doesn't seem right, but I am happy to be corrected (perhaps we only expect
> to be a single byte below a start region?)
> 
> > +		/*it could start reading from the middle of used region*/
> > +		offset = offset_in_page(addr);
> > +		n = (re - rs + 1) << PAGE_SHIFT - offset;
> 
> The kernel bot has already picked up on this paren issue :)

Right, has been handled. Thanks.

> 
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
> > +	/* zero-fill the left dirty or free regions */
> > +	if (count)
> > +		memset(buf, 0, count);
> > +}
> > +
> >  /**
> >   * vread() - read vmalloc area in a safe way.
> >   * @buf:     buffer for reading data
> > @@ -3545,7 +3590,7 @@ long vread(char *buf, char *addr, unsigned long count)
> >  	struct vm_struct *vm;
> >  	char *vaddr, *buf_start = buf;
> >  	unsigned long buflen = count;
> > -	unsigned long n;
> > +	unsigned long n, size, flags;
> >
> >  	addr = kasan_reset_tag(addr);
> >
> > @@ -3566,12 +3611,16 @@ long vread(char *buf, char *addr, unsigned long count)
> >  		if (!count)
> >  			break;
> >
> > -		if (!va->vm)
> > +		vm = va->vm;
> > +		flags = va->flags & VMAP_FLAGS_MASK;
> > +
> > +		if (!vm && !flags)
> >  			continue;
> >
> 
> This seems very delicate now as going forward, vm _could_ be NULL. In fact, a
> later patch in the series then goes on to use vm and assume it is not null (will
> comment).
> 
> I feel we should be very explicit after here asserting that vm != NULL.
> 
> > -		vm = va->vm;
> > -		vaddr = (char *) vm->addr;
> > -		if (addr >= vaddr + get_vm_area_size(vm))
> > +		vaddr = (char *) va->va_start;
> > +		size = flags ? va_size(va) : get_vm_area_size(vm);
> 
> For example here, I feel that this ternary should be reversed and based on
> whether vm is null, unles we expect vm to ever be non-null _and_ flags to be
> set?

Now only vm_map_ram area sets flags, all other types has vm not null.
Since those temporary state, e.g vm==NULL, flags==0 case has been
filtered out. Is below you suggested?

		size = (!vm&&flags)? va_size(va) : get_vm_area_size(vm);
		or
		size = (vm&&!flags)? get_vm_area_size(vm):va_size(va);

> 
> > +
> > +		if (addr >= vaddr + size)
> >  			continue;
> >  		while (addr < vaddr) {
> >  			if (count == 0)
> > @@ -3581,10 +3630,13 @@ long vread(char *buf, char *addr, unsigned long count)
> >  			addr++;
> >  			count--;
> >  		}
> > -		n = vaddr + get_vm_area_size(vm) - addr;
> > +		n = vaddr + size - addr;
> >  		if (n > count)
> >  			n = count;
> > -		if (!(vm->flags & VM_IOREMAP))
> > +
> > +		if ((flags & (VMAP_RAM|VMAP_BLOCK)) == (VMAP_RAM|VMAP_BLOCK))
> > +			vb_vread(buf, addr, n);
> > +		else if ((flags & VMAP_RAM) || !(vm->flags & VM_IOREMAP))
> >  			aligned_vread(buf, addr, n);
> >  		else /* IOREMAP area is treated as memory hole */
> >  			memset(buf, 0, n);
> > --
> > 2.34.1
> >
> 

