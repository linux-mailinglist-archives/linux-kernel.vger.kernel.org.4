Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE2D6D1DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCaKL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjCaKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:10:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5250821ABC
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:04:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h25so28188585lfv.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680257057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PjavG9MKLZVv3dV4g4hTqEbK+DVu3JkYcu79G0KPCSs=;
        b=ZfIaVOUZZRPCaRbk9t8JCQ6cmxkuEmo7oDBLzBvZXLDpz3Ld0ELmqnD6N0ol3Qe3zZ
         XV5iFYdYq0MitzmHSFHkoOiu76DoaLAf2Kb6gd984ud62ulivOyg1UzFZfZx69PLnS5t
         BvUl7fsylgv5jmHbQWqUsOrXRD5NizPtd8ENLAG5goGayuHVPm452Y/zN8Nj531bXmP+
         Ym9N9hESm7fQ4x7KEdjPS2JkVUWqkX/BVBL0Z5XJAvlDyMI21BRmn6oiABMVe2y1RVHg
         3ZWHllXbpYNUMxX7IoPpBHWWpNoSK6aOZAzTb1zNczuqyE6b7P/HTaKOEUbeUvY9lCjk
         6WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680257057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjavG9MKLZVv3dV4g4hTqEbK+DVu3JkYcu79G0KPCSs=;
        b=WSqskfZoourghpnPNOkpz/jrJGlsGG7p4yENgMfJhMSDJ0+ew6zC9+0H4Lt11nu9nF
         c3SPnzsZSQYtB1EaCmUqEON5pmZRBAbeUdSvnHUSZUYJGwG7UNlRsYd68b+R0S5LC03X
         vGC3ymm/nh/kQvk7s6u/KcHBW1KpdmikPYycrND5BMJtOZdQktiXrryMUPgORDhYKD6F
         ksTrtMNpzr7qYQfIQ2qeMBPe7K0dCVI8whp8z1o3Q+IsPSR8W3zf+bXm5fjW7swtPHSG
         KjyPYVTULQuSvWgTDJaf/Zr3C6slc2HVXAwgcLcqAgZ3jCGnAFr69ahbv94EPHyrQE8P
         A11A==
X-Gm-Message-State: AAQBX9ffeKmW73KsvmF7xNeKGz6k2YzmVha7Il4J7X8yz73sg+/GLF/o
        FkEcCVseIPA4GRSMTj7XEZY=
X-Google-Smtp-Source: AKy350bozdYquIMupN8R9z3xFxNGqy7WuNnFfeVcPBjRWL7RAsQagwXeLs1UZeNO17Y7Pu2pIb+3tQ==
X-Received: by 2002:ac2:5bc9:0:b0:4d8:86c1:4782 with SMTP id u9-20020ac25bc9000000b004d886c14782mr2672689lfn.23.1680257057262;
        Fri, 31 Mar 2023 03:04:17 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id t8-20020a19ad08000000b004cb23904bd9sm315534lfc.144.2023.03.31.03.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:04:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 31 Mar 2023 12:04:14 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Rename addr_to_vb_xarray() function
Message-ID: <ZCawHhhLygb+qySm@pc636>
References: <20230331073727.6968-1-urezki@gmail.com>
 <65a19f0a-be4d-42c9-a75d-1356996acdda@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a19f0a-be4d-42c9-a75d-1356996acdda@lucifer.local>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 09:38:49AM +0100, Lorenzo Stoakes wrote:
> On Fri, Mar 31, 2023 at 09:37:27AM +0200, Uladzislau Rezki (Sony) wrote:
> > Short the name of the addr_to_vb_xarray() function to the
> > addr_to_vb_xa(). This aligns with other internal function
> > abbreviations.
> >
> > Suggested-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 671d6d5d5b78..b8b646f8a00d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1945,7 +1945,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> >   * used as a hash table. When used as a hash a 'cpu' passed to
> >   * per_cpu() is not actually a CPU but rather a hash index.
> >   *
> > - * A hash function is addr_to_vb_xarray() which hashes any address
> > + * A hash function is addr_to_vb_xa() which hashes any address
> >   * to a specific index(in a hash) it belongs to. This then uses a
> >   * per_cpu() macro to access an array with generated index.
> >   *
> > @@ -1971,7 +1971,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> >   * however xarray spinlocks protect against any contention that remains.
> >   */
> >  static struct xarray *
> > -addr_to_vb_xarray(unsigned long addr)
> > +addr_to_vb_xa(unsigned long addr)
> >  {
> >  	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> >
> > @@ -2048,7 +2048,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  	bitmap_set(vb->used_map, 0, (1UL << order));
> >  	INIT_LIST_HEAD(&vb->free_list);
> >
> > -	xa = addr_to_vb_xarray(va->va_start);
> > +	xa = addr_to_vb_xa(va->va_start);
> >  	vb_idx = addr_to_vb_idx(va->va_start);
> >  	err = xa_insert(xa, vb_idx, vb, gfp_mask);
> >  	if (err) {
> > @@ -2070,7 +2070,7 @@ static void free_vmap_block(struct vmap_block *vb)
> >  	struct vmap_block *tmp;
> >  	struct xarray *xa;
> >
> > -	xa = addr_to_vb_xarray(vb->va->va_start);
> > +	xa = addr_to_vb_xa(vb->va->va_start);
> >  	tmp = xa_erase(xa, addr_to_vb_idx(vb->va->va_start));
> >  	BUG_ON(tmp != vb);
> >
> > @@ -2193,7 +2193,7 @@ static void vb_free(unsigned long addr, unsigned long size)
> >  	order = get_order(size);
> >  	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
> >
> > -	xa = addr_to_vb_xarray(addr);
> > +	xa = addr_to_vb_xa(addr);
> >  	vb = xa_load(xa, addr_to_vb_idx(addr));
> >
> >  	spin_lock(&vb->lock);
> > @@ -3556,7 +3556,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
> >  	 * Area is split into regions and tracked with vmap_block, read out
> >  	 * each region and zero fill the hole between regions.
> >  	 */
> > -	xa = addr_to_vb_xarray((unsigned long) addr);
> > +	xa = addr_to_vb_xa((unsigned long) addr);
> >  	vb = xa_load(xa, addr_to_vb_idx((unsigned long)addr));
> >  	if (!vb)
> >  		goto finished;
> > --
> > 2.30.2
> >
> 
> I have no problem with this patch but it's a bit of a pain to apply, as
> doesn't apply to mm-unstable or -next as it doesn't take into account my
> vread_iter changes, however Andrew can probably figure it out :)
> 
> I checked it manually and it's fine, so:-
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
Thanks! I based it on next-20230317. If Andrew has some issues with it
i will resend it on a latest tip!

--
Uladzislau Rezki
