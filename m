Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837946CD252
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjC2Gy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjC2Gy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:54:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AD2211D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:54:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y35so12501607ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680072864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z64+4NP0Iaq2THmuvx30e3ulOcM6eG7Y0CK87PMVoP4=;
        b=NdRrpDX6sK0yGYNDimTTRFcPrBRKBbkFmoAP4Wr21vi4mlUg+Hjb4JCxFK3ZraDOcD
         ZLQP1FCcaJe57bk79OMqS0yILOsjUQQJD/8gsx3S/m7e9LQwnbm5FlIGKveYoP7zMPzB
         m+qpc5c40Zzbj+dYjHd+r4QxnIeSBXSuL5fLbdzWOgM29C7POfr0tmT8yLNKiSyfwhfz
         TDvmvZbo0uC/Z9oz2XRVd9fv/1/CoMlt5lD0StzahriaLrqZS9Zw56nHfr+65z73iI1r
         goqu5XdcUaVCK+i9xY/m3WasFx+q034MslmAUwJYDk1LZil6bBbtKE+G/ml1anBwuZ+a
         UfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680072864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z64+4NP0Iaq2THmuvx30e3ulOcM6eG7Y0CK87PMVoP4=;
        b=QFBI3vXXWTTaDITxM265QqwY9S4G7ky1hiaAHu+6qSVOtLZXG7o9TK3nqEGIwh01tF
         aGqzGLOtPgJbFl3F9gynM7S8P1ZbyOgVJTmSIWY8MA06Kl5CtoXsgbyaXOs5YtDpu6ry
         3iHkiL3lcXCGBAB66hVUZcnuFuGsFSUBef+eDanfU1Mg7JwM5VuPuh6RmliBo494vWZp
         Q6IfJSl3kuMtsaWbw1jmzavQ1cxXpOmZOblMALcX0+PQB0uSZfncBUX1L50qupetUpHh
         NUVzBmoxwC5zCBYvEHk0GmS0L2Mp0Jz1U9NydS4rd92oJHWJxthPOS4iLlb5qdtNyi4F
         m4Ow==
X-Gm-Message-State: AAQBX9duzd2Hqlvy0mCki7QE84IljOi3Nb1224eN8b0rrJ+66uIhjlDn
        KiOxrirp2cPX+AToWDyFNtA=
X-Google-Smtp-Source: AKy350ZYvagz4vuBTC3lqDdAYJ+bClEDJbqeIK12P3i/5LCHauUXkBZ85ve9qjn0FCROjTHD6NjMZQ==
X-Received: by 2002:a2e:9d87:0:b0:29e:c648:674 with SMTP id c7-20020a2e9d87000000b0029ec6480674mr6145908ljj.46.1680072864233;
        Tue, 28 Mar 2023 23:54:24 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id o4-20020a2e90c4000000b00299fe6c262csm5375138ljg.77.2023.03.28.23.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 23:54:23 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 29 Mar 2023 08:54:20 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCPgnCP3bXWu7qRr@pc636>
References: <20230327170126.406044-1-urezki@gmail.com>
 <ZCJd//IM6FGkbVTJ@MiWiFi-R3L-srv>
 <ZCLex4BPPtosouvd@pc636>
 <ZCO/gTgw9PUuU+mG@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCO/gTgw9PUuU+mG@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 12:33:05PM +0800, Baoquan He wrote:
> On 03/28/23 at 02:34pm, Uladzislau Rezki wrote:
> ......  
> > > > @@ -2003,8 +2037,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> > > >  	bitmap_set(vb->used_map, 0, (1UL << order));
> > > >  	INIT_LIST_HEAD(&vb->free_list);
> > > >  
> > > > -	vb_idx = addr_to_vb_idx(va->va_start);
> > > > -	err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
> > > > +	vbq = addr_to_vbq(va->va_start);
> > > > +	err = xa_insert(&vbq->vmap_blocks, va->va_start, vb, gfp_mask);
> > > 
> > > Using va->va_start as index to access xarray may cost extra memory.
> > > Imagine we got a virtual address at VMALLOC_START, its region is
> > > [VMALLOC_START, VMALLOC_START+4095]. In the xarray, its sequence order
> > > is 0. While with va->va_start, it's 0xffffc90000000000UL on x86_64 with
> > > level4 paging mode. That means for the first page size vmalloc area,
> > > storing it into xarray need about 10 levels of xa_node, just for the one
> > > page size. With the old addr_to_vb_idx(), its index is 0. Only one level
> > > height is needed. One xa_node is about 72bytes, it could take more time
> > > and memory to access va->va_start. Not sure if my understanding is correct.
> > > 
> > > static unsigned long addr_to_vb_idx(unsigned long addr)
> > > {
> > >         addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
> > >         addr /= VMAP_BLOCK_SIZE;
> > >         return addr;
> > > }
> > > 
> > If the size of array depends on index "length", then, indeed it will require
> > more memory. From the other hand we can keep the old addr_to_vb_idx() function 
> > in order to "cut" a va->va_start index.
> 
> Yeah, the extra 10 levels of xa_node is unnecessary if we keep the old
> addr_to_vb_idx(). And the prolonged path will cost more time to reach the 
> wanted leaf node. E.g on x86_64 with 4 level paging mode, vmalloc area
> is 32TB. With the old calculation, its index range is [0, 8M], 4 level
> heights of xa_node at most is enough to cover.
> 
Good! I have not analyzed how xarray stores its indexes. I will update
the patch to cut indexes so we stay the same as we used to be before.

--
Uladzislau Rezki
