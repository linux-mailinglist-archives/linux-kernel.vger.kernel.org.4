Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B2E6CEF3F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjC2QXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjC2QXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:23:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCA0619C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:23:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso2362019wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680106987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GlibarqBbZ4Q0mPsWReLWgLf3BnPWtPZlsUlpY0M8PQ=;
        b=RSO+my1D55gcMaKHDx5zQ3TCPd3DaIBAgXOqlGdI8tctkJGeKTNSV8irKwETa6Qr/q
         ygvt0qW05COhtQdgjp79ou02U9SeEA05pUU047PBx83ycFUMVKrQHgKZWDZWeRgeV+3/
         ZFagReelZMGVg+QmwFTVVu+UMiiQ1OQSLo8DV73K0Kl2GPv6aKVD/lGZ3dk2Vdmgt8ww
         rH7lnBjcZuNzajuALBDctf7jOSp84d6TTAYW6pM1Fxyw6CL3Fc1ov3CVNpYtYQ80PBFZ
         RudhmGJxext9IcHG3VmYjZ4Xz+B5XDLLvnBJ2EIUGJaogZjnhRKGcAajlA6iJ0yVYfYr
         9vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680106987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlibarqBbZ4Q0mPsWReLWgLf3BnPWtPZlsUlpY0M8PQ=;
        b=ec0K4J6YNdxk3zQG0YM1JSfo1PYvUtcREYmjo6L2NNWF48RZjRqC0clRwFXDHTFzIR
         Savwcg9at4ONmGJbNp7WuVjavkA/IAD2GF8df1ciG/auS7z3bmvFVEAHQy+Ma/NDoD52
         kVj1WoBvHMq3bFqOk+/caLL2TOW+gNl7GiuD1e0zrFT/xIvHAJFxgb1U5SkMEflZBeJC
         idgs9vDFKgdEFBcSfoDMNDRBUo/+HPIe2Jy3hZg3FBF2zwb72nln2n1ECktLtv4nyFAd
         drGW+hoz/Sks2bDicET30nylPwmzIou/B89MZoxsJ5f+dqpcGgpc/LEH7fpIlvZGdRmF
         zD/g==
X-Gm-Message-State: AO0yUKUIJtBBmj7Vt0ZCsdlCelFejauuO8rqjAYgswh7FaZUY6frN3Mc
        ez0cMPR8p7Hxih4G+q7J+XNKab01Rac=
X-Google-Smtp-Source: AK7set+kPI0uPHX/+oeAOe4CloIOapYtWqi+nps/c/zQdsmvNuNSHHfB15M0OOakmiPQu34zcSwxtw==
X-Received: by 2002:a1c:790b:0:b0:3ee:56f7:75d2 with SMTP id l11-20020a1c790b000000b003ee56f775d2mr15645326wme.20.1680106986790;
        Wed, 29 Mar 2023 09:23:06 -0700 (PDT)
Received: from localhost ([208.34.186.1])
        by smtp.gmail.com with ESMTPSA id x15-20020a05600c21cf00b003ee1b2ab9a0sm2699424wmj.11.2023.03.29.09.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:23:05 -0700 (PDT)
Date:   Wed, 29 Mar 2023 17:23:04 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCRl6DG_q7Hn4DGS@murray>
References: <20230327170126.406044-1-urezki@gmail.com>
 <132e2d5c-0c1f-4fff-850c-b3fb084455bb@lucifer.local>
 <ZCRStzHE06l21T0c@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCRStzHE06l21T0c@pc636>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 05:01:11PM +0200, Uladzislau Rezki wrote:
> Hello, Lorenzo!
>
> > >  /*
> > > - * XArray of vmap blocks, indexed by address, to quickly find a vmap block
> > > - * in the free path. Could get rid of this if we change the API to return a
> > > - * "cookie" from alloc, to be passed to free. But no big deal yet.
> > > + * In order to fast access to any "vmap_block" associated with a
> > > + * specific address, we store them into a per-cpu xarray. A hash
> > > + * function is addr_to_vbq() whereas a key is a vb->va->va_start
> > > + * value.
> > > + *
> > > + * Please note, a vmap_block_queue, which is a per-cpu, is not
> > > + * serialized by a raw_smp_processor_id() current CPU, instead
> > > + * it is chosen based on a CPU-index it belongs to, i.e. it is
> > > + * a hash-table.
> > > + *
> > > + * An example:
> > > + *
> > > + *  CPU_1  CPU_2  CPU_0
> > > + *    |      |      |
> > > + *    V      V      V
> > > + * 0     10     20     30     40     50     60
> > > + * |------|------|------|------|------|------|...<vmap address space>
> > > + *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> > > + *
> > > + * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> > > + *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> > > + *
> > > + * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> > > + *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> > > + *
> > > + * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> > > + *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> > >   */
> >
> > OK so if I understand this correctly, you're overloading the per-CPU
> > vmap_block_queue array to use as a simple hash based on the address and
> > relying on the xa_lock() in xa_insert() to serialise in case of contention?
> >
> > I like the general heft of your comment but I feel this could be spelled
> > out a little more clearly, something like:-
> >
> >   In order to have fast access to any vmap_block object associated with a
> >   specific address, we use a hash.
> >
> >   Rather than waste space on defining a new hash table  we take advantage
> >   of the fact we already have a static per-cpu array vmap_block_queue.
> >
> >   This is already used for per-CPU access to the block queue, however we
> >   overload this to _also_ act as a vmap_block hash. The hash function is
> >   addr_to_vbq() which hashes on vb->va->va_start.
> >
> >   This then uses per_cpu() to lookup the _index_ rather than the
> >   _cpu_. Each vmap_block_queue contains an xarray of vmap blocks which are
> >   indexed on the same key as the hash (vb->va->va_start).
> >
> >   xarray read acceses are protected by RCU lock and inserts are protected
> >   by a spin lock so there is no risk of a race here.
> >
> /*
>  * In order to fast access to any "vmap_block" associated with a
>  * specific address, we use a hash.
>  *
>  * A per-cpu vmap_block_queue is used in both ways, to serialize
>  * an access to free block chains among CPUs(alloc path) and it
>  * also acts as a vmap_block hash(alloc/free paths). It means we
>  * overload it, since we already have the per-cpu array which is
>  * used as a hash table.

Nit - it may be worth highlighting that when used as a hash it the 'cpu' is
not in fact a cpu but rather a hash key.

E.g. just add on the end of this something like:-

When used as a hash table the 'cpu' passed to per_cpu is not actually a CPU
but rather the hash key.

>  *
>  * A hash function is addr_to_vbq() which hashes any address to
>  * a specific index(in a hash) it belongs to. This then uses a
>  * per_cpu() macro to access the array with specific index.

May need a tweak if you are happy with my review that we can simply have a
helper that returns the xarray in which case we won't necessary have this
function :) but depends of course on how the respin looks!

>  *
>  * An example:
>  *
>  *  CPU_1  CPU_2  CPU_0
>  *    |      |      |
>  *    V      V      V
>  * 0     10     20     30     40     50     60
>  * |------|------|------|------|------|------|...<vmap address space>
>  *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
>  *
>  * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
>  *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
>  *
>  * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
>  *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
>  *
>  * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
>  *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
>  *
>  * This technique allows almost remove a lock-contention in locking
>  * primitives which protect insert/remove operations.

This sentence is a little confusing, perhaps rephrase a little:-

This technique almost always avoids lock contention on insert/remove,
however the xarray spinlock protects against any contention that remains.

>  */
> Are you find with it?

Other than the small nits above (sorry!) it seems fine! Thanks for
updating, much appreciated :)

>
> --
> Uladzislau Rezki
>
