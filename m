Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF7265DD93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbjADUVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbjADUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:20:54 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED8F183AF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:20:53 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so25001070wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 12:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9D51sBkHzbum0wkfy6pYLD6DjeGvD3BV7AVetui/1c=;
        b=ncNwW2r7IzCm6QlXyN7XxBG5XWVWkMevZBTomy13qHLdiEaCQ3pEmYio8vo9yJteHY
         Zuso76/7bdzSQrFPjy11mzM/SmC/5H1Kr2rlaXY5x43Q2xsJkiOv6mfMIY9zAnSgGJxD
         jowcsBqatuJns6pvar+xj8ORL2qNQJHKP/PdZtJG/Samn0a5HvpDJeMFCo8xnSF1BLZ1
         g6Y3gG5svqJ2SclfPYrY2zSaVN6F43cnfVJyykI31kXvnCcOOOwd3ZqgPYZEmDMRdMr4
         AGcWuV18PscMnFpO9HiD9yb0d9q1nwsuITcNdCJUQ3q38lpIinn0P8+yKW4tqN2n4LFx
         1OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9D51sBkHzbum0wkfy6pYLD6DjeGvD3BV7AVetui/1c=;
        b=M5r7SxVAf8yAQ6duXzrtnBaV0B4D1fIsB3ORuMYj/fzbXErtm9W2dg2HELqH9ci79l
         pXktGeDVOXTNTaY8Lj7fTEsNV5ld/eJ9ITi977dimibEPqWliEaYwdDqlYhMShtJ5vAN
         3seyh7yxYkaTDq6vsOLW3yM0vig9aTqL8SKtT4qJTlshMpCyoG/BqhpDd+54IhI606Em
         xZUGxjjp9aAOLcDKwFoscdyRNlx5yDr6vPQHgUz6hgUO17wrO5Jg3zGIS8kQwi8ByFOq
         avDqqFU1eB8jBX3BSsMujgjWTAkScJQprLPfKZ3SWoMXzH21VZ/4otOg4MgobDtIs5Uq
         NqQQ==
X-Gm-Message-State: AFqh2kpG3p2+m0H+xyUf16vDM8NeAqs96PMAWM8Oe+PBbdjs8swczCXU
        OtbEG9n+yPjSWsututUdnt0=
X-Google-Smtp-Source: AMrXdXuRHdaqt4oF0yfOeB3UkSYeCEzYx2NUGm5/c7P6LHOWkrBeZmy2cA2HfUVOnwfFMJNKlTvQSQ==
X-Received: by 2002:a05:600c:3acc:b0:3d9:a145:91a with SMTP id d12-20020a05600c3acc00b003d9a145091amr13691746wms.28.1672863651736;
        Wed, 04 Jan 2023 12:20:51 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id t184-20020a1c46c1000000b003b4a699ce8esm51816695wma.6.2023.01.04.12.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:20:50 -0800 (PST)
Date:   Wed, 4 Jan 2023 20:20:49 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y7XfoQgk3HHgK0+f@lucifer>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-4-bhe@redhat.com>
 <Y52wsONH+u/h0nuj@lucifer>
 <Y7UyYDRnc663qzTs@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7UyYDRnc663qzTs@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 04:01:36PM +0800, Baoquan He wrote:
> On 12/17/22 at 12:06pm, Lorenzo Stoakes wrote:
> > On Sat, Dec 17, 2022 at 09:54:31AM +0800, Baoquan He wrote:
> > > Currently, vread can read out vmalloc areas which is associated with
> > > a vm_struct. While this doesn't work for areas created by vm_map_ram()
> > > interface because it doesn't have an associated vm_struct. Then in vread(),
> > > these areas will be skipped.
> > >
> > > Here, add a new function vb_vread() to read out areas managed by
> > > vmap_block specifically. Then recognize vm_map_ram areas via vmap->flags
> > > and handle them respectively.
> > >
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  mm/vmalloc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 59 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 190f29bbaaa7..6612914459cf 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3515,6 +3515,51 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
> > >  	return copied;
> > >  }
> > >
> > > +static void vb_vread(char *buf, char *addr, int count)
> > > +{
> > > +	char *start;
> > > +	struct vmap_block *vb;
> > > +	unsigned long offset;
> > > +	unsigned int rs, re, n;
> > > +
> > > +	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> > > +
> > > +	spin_lock(&vb->lock);
> > > +	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
> > > +		spin_unlock(&vb->lock);
> > > +		memset(buf, 0, count);
> > > +		return;
> > > +	}
> > > +	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> > > +		if (!count)
> > > +			break;
> > > +		start = vmap_block_vaddr(vb->va->va_start, rs);
> > > +		if (addr < start) {
> > > +			if (count == 0)
> > > +				break;
> > > +			*buf = '\0';
> > > +			buf++;
> > > +			addr++;
> > > +			count--;
> > > +		}
>
> Very sorry, Lorenzo, I just noticed this mail. It's very weird. Earlier,
> Uladzislau's reply to patch 2/7 got to be seen in my mutt mail client 10
> days later. I am not sure it's my mail client's problem, or a mail server
> delivery issue.
>

Odd, maybe try lei with mutt I find that works well :)

> >
> > I may be missing something here, but is this not essentially 'if the address is
> > below a used region, write a single null byte into the buffer and continue,
> > assuming we are now in a used area?'
>
> Not sure if I got you. for_each_set_bitrange only iterates the used
> regions. So in the for loop, what we do is fill zero into the buffer
> below the used region, then read out the used region. You said
> 'continue', I don't understand what it means.
>
> Assume we have 3 used regions in one vmap block, see below diagram.
>      |_______|______________|________|_____________|_____|_____________|______|
>      |hole 0 |used region 0 |hole 1  |used region 1|hole2|used region2 |hole 3 |
>
> hole 0,1,2 will be set zero when we iterate to the used region above
> them. And the last hole 3 is set at the end of this function. Please
> help point it out if I got it wrong.

Maybe let me rephrase:-

- We want to read `count` bytes from `addr` into `buf`
- We iterate over _used_ blocks, placing the start/end of each block in `rs`, `re`
  respectively.
- If we hit a block whose start address is above the one in which we are interested then:-
  - Place a zero byte in the buffer
  - Increment `addr` by 1 byte
  - Decrement the `count` by 1 byte
  - Carry on

I am seriously confused as to why we do this? Surely we should be checking
whether the range [addr, addr + count) overlaps this block at all, and only then
copying the relevant region?

It's the fact that blocks are at base page granularity but then this condition
is at byte granularity that is confusing to me (again it's _very_ possible I am
just being dumb here and missing something, just really want to understand this
better :)

> > > -		vm = va->vm;
> > > -		vaddr = (char *) vm->addr;
> > > -		if (addr >= vaddr + get_vm_area_size(vm))
> > > +		vaddr = (char *) va->va_start;
> > > +		size = flags ? va_size(va) : get_vm_area_size(vm);
> >
> > For example here, I feel that this ternary should be reversed and based on
> > whether vm is null, unles we expect vm to ever be non-null _and_ flags to be
> > set?
>
> Now only vm_map_ram area sets flags, all other types has vm not null.
> Since those temporary state, e.g vm==NULL, flags==0 case has been
> filtered out. Is below you suggested?
>
> 		size = (!vm&&flags)? va_size(va) : get_vm_area_size(vm);
> 		or
> 		size = (vm&&!flags)? get_vm_area_size(vm):va_size(va);
>

Sorry I didn't phrase this very well, my point is that the key thing you're
relying on here is whether vm exists in order to use it so I simply meant:-

size = vm ? get_vm_area_size(vm) : va_size(va);

This just makes it really explicit that you need vm to be non-NULL, and you've
already done the flags check before so this should suffice.
