Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6C96CF170
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjC2Ru5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2Ru4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:50:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41713DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:50:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g19so8160152lfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680112253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrJBG4j0MX3RJtzvHtYn32M+HCCSyQiEld3ZxAOtBC0=;
        b=geIMhDJ1Mi5G5pdHbCcdQfvXH2ZwoO8b7FNmTcX+jIk9DpdS0jRRdY051vsCzL8ghw
         8HJBAOO3cOBe8xQ/ifI6pIqGe5v8fxSif9fGKHheok6gz7oJhe9nKglOd/OV54efn08B
         WKI0Viskp/tEPoDtMghrsdf7/GexEGKIQL50tJX07Xtr4TbUHqFoO6kPV0zlEKlfEOpt
         6u/bBzUeYhHUVgRpd07cdGge52f6N2rZgZkMR6BKFlBmuKOSQik/NUriOovzIJNUC03F
         Cs9c7EOxZUGDJazHtAjsG9qXB5PjFq4jpT8uVYMSl9Mdg0AJr1UztZjeiCPStIUB2Y4m
         bvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680112253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrJBG4j0MX3RJtzvHtYn32M+HCCSyQiEld3ZxAOtBC0=;
        b=UXbvrf+ZVngyrr26VemTDPsE7WQiSGnXQZteR9nYSyR5ZkqtOrFtnZMYfQ5j0Gy9US
         PinU2KeQRRU1GB8cXj6h+fsxMnjMAVbmoIJwjZMGVkSu/plePVcN6zBWYi1FZjhiorw8
         5rzRRuWrUPdlYsjvV2E8pKKm+7jO7tKhxPCtMdpOnTBcZTorAaxHatKukkbxcC4zlanp
         M/ItjDD0pvHp6MNwlt0tyG4eA5aYiyrgxXq4ELfmbPWObtHIp4oK1l7wFrHabP6wIVRZ
         SO5e5spLZAx3BDsI4p8x3BWxuzFd/thVr3OvHcooOE52+p3Rd2Z2iIz/rOYLzTLT6gJJ
         c8Iw==
X-Gm-Message-State: AAQBX9fgHlzReyq3VnDJG4z8nxNvOm61RML2GmkG9KLYEVCby4WybCNa
        Nv6uWAzjs0JucCaPkb75q/0=
X-Google-Smtp-Source: AKy350b5bWyYa2pQhB7T397LxSlDTtO5CdfVLDLtkRV8ip3h1rjrRIUGLFB48p5UJ8VkXrWNtNaV1w==
X-Received: by 2002:ac2:59c6:0:b0:4e9:5f90:748 with SMTP id x6-20020ac259c6000000b004e95f900748mr5957347lfn.9.1680112253181;
        Wed, 29 Mar 2023 10:50:53 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id u4-20020ac251c4000000b004db1a7e6decsm5546238lfm.205.2023.03.29.10.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 10:50:52 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 29 Mar 2023 19:50:50 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCR6erByRH0g19wd@pc636>
References: <20230327170126.406044-1-urezki@gmail.com>
 <132e2d5c-0c1f-4fff-850c-b3fb084455bb@lucifer.local>
 <ZCRStzHE06l21T0c@pc636>
 <ZCRl6DG_q7Hn4DGS@murray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCRl6DG_q7Hn4DGS@murray>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 05:23:04PM +0100, Lorenzo Stoakes wrote:
> On Wed, Mar 29, 2023 at 05:01:11PM +0200, Uladzislau Rezki wrote:
> > Hello, Lorenzo!
> >
> > > >  /*
> > > > - * XArray of vmap blocks, indexed by address, to quickly find a vmap block
> > > > - * in the free path. Could get rid of this if we change the API to return a
> > > > - * "cookie" from alloc, to be passed to free. But no big deal yet.
> > > > + * In order to fast access to any "vmap_block" associated with a
> > > > + * specific address, we store them into a per-cpu xarray. A hash
> > > > + * function is addr_to_vbq() whereas a key is a vb->va->va_start
> > > > + * value.
> > > > + *
> > > > + * Please note, a vmap_block_queue, which is a per-cpu, is not
> > > > + * serialized by a raw_smp_processor_id() current CPU, instead
> > > > + * it is chosen based on a CPU-index it belongs to, i.e. it is
> > > > + * a hash-table.
> > > > + *
> > > > + * An example:
> > > > + *
> > > > + *  CPU_1  CPU_2  CPU_0
> > > > + *    |      |      |
> > > > + *    V      V      V
> > > > + * 0     10     20     30     40     50     60
> > > > + * |------|------|------|------|------|------|...<vmap address space>
> > > > + *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> > > > + *
> > > > + * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> > > > + *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> > > > + *
> > > > + * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> > > > + *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> > > > + *
> > > > + * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> > > > + *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> > > >   */
> > >
> > > OK so if I understand this correctly, you're overloading the per-CPU
> > > vmap_block_queue array to use as a simple hash based on the address and
> > > relying on the xa_lock() in xa_insert() to serialise in case of contention?
> > >
> > > I like the general heft of your comment but I feel this could be spelled
> > > out a little more clearly, something like:-
> > >
> > >   In order to have fast access to any vmap_block object associated with a
> > >   specific address, we use a hash.
> > >
> > >   Rather than waste space on defining a new hash table  we take advantage
> > >   of the fact we already have a static per-cpu array vmap_block_queue.
> > >
> > >   This is already used for per-CPU access to the block queue, however we
> > >   overload this to _also_ act as a vmap_block hash. The hash function is
> > >   addr_to_vbq() which hashes on vb->va->va_start.
> > >
> > >   This then uses per_cpu() to lookup the _index_ rather than the
> > >   _cpu_. Each vmap_block_queue contains an xarray of vmap blocks which are
> > >   indexed on the same key as the hash (vb->va->va_start).
> > >
> > >   xarray read acceses are protected by RCU lock and inserts are protected
> > >   by a spin lock so there is no risk of a race here.
> > >
> > /*
> >  * In order to fast access to any "vmap_block" associated with a
> >  * specific address, we use a hash.
> >  *
> >  * A per-cpu vmap_block_queue is used in both ways, to serialize
> >  * an access to free block chains among CPUs(alloc path) and it
> >  * also acts as a vmap_block hash(alloc/free paths). It means we
> >  * overload it, since we already have the per-cpu array which is
> >  * used as a hash table.
> 
> Nit - it may be worth highlighting that when used as a hash it the 'cpu' is
> not in fact a cpu but rather a hash key.
> 
> E.g. just add on the end of this something like:-
> 
> When used as a hash table the 'cpu' passed to per_cpu is not actually a CPU
> but rather the hash key.
> 
> >  *
> >  * A hash function is addr_to_vbq() which hashes any address to
> >  * a specific index(in a hash) it belongs to. This then uses a
> >  * per_cpu() macro to access the array with specific index.
> 
> May need a tweak if you are happy with my review that we can simply have a
> helper that returns the xarray in which case we won't necessary have this
> function :) but depends of course on how the respin looks!
> 
> >  *
> >  * An example:
> >  *
> >  *  CPU_1  CPU_2  CPU_0
> >  *    |      |      |
> >  *    V      V      V
> >  * 0     10     20     30     40     50     60
> >  * |------|------|------|------|------|------|...<vmap address space>
> >  *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> >  *
> >  * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> >  *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> >  *
> >  * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> >  *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> >  *
> >  * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> >  *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> >  *
> >  * This technique allows almost remove a lock-contention in locking
> >  * primitives which protect insert/remove operations.
> 
> This sentence is a little confusing, perhaps rephrase a little:-
> 
> This technique almost always avoids lock contention on insert/remove,
> however the xarray spinlock protects against any contention that remains.
> 
> >  */
> > Are you find with it?
> 
> Other than the small nits above (sorry!) it seems fine! Thanks for
> updating, much appreciated :)
> 
Good. Made the changes. I will upload a new vX patch. Everything
that makes it more clear for readers is worth to do :)

--
Uladzislau Rezki
