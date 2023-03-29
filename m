Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9253E6CEC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjC2PBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjC2PBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:01:18 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5932113
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:01:15 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x20so16437024ljq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680102074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uGkOiPefovVtTgmI0DGR4n+0i+4dhScH7wTyfGZyKZ4=;
        b=SbZx/BNv29iJLafH16pVZEH6NzuXGx0/EkmsHJg5oGgkhNyDdyt09RSBTN4LYcBRuP
         grqHwZEISgRdxBDDokfWKVcUjottoVLqaDkaitFH+NnmGvi/Muekp1G3mb5IygF1TESR
         Ms4CvR2i0s6AYOzrXehFk8kNV5f1JUVDsYc/Ie2dYX5GTaVe4pouDmvdzJpBW01ooHdk
         NEdraHc2ngwDVbamZMNVKKnaCpcubm6wisE+kh5OGW1nvA/jnUif5aIgsd51EQ1wPNPY
         ZcAAU1M+4D8nE0uQOrD7dEcKmAicK0Ly0w0ENcuR0S4mUWuntofVk0pi/VQC8+GljMA/
         6FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680102074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGkOiPefovVtTgmI0DGR4n+0i+4dhScH7wTyfGZyKZ4=;
        b=QbBvsBy8uCr9lJk7CDBEosahc8VpMRpNSXXAPPaKt0hFvIhtg9HaNQnK6BicapH/yK
         LU1JNmNduEkhdPXVEnBJuBeUMAuhMl8dFCtlGKp65EU4Ll5RGlapltOiHLr8nNqGxa9N
         6pEo7xJfO+W7RvXad7jBVdVnOwJCxzEuBzUd2dwIyyTvI5uGYHbsgk2zIm9/qVdlTWi+
         FM20SxwfNht4qKAEdWLUcWrW822LlS20JpFmbLVXrA2TSSMVoP5cbeSP0XkcBtT1lp/Q
         swJoZYBKRaC1wDRZ8OkpIEGcwipMxmm71aR89NaOG7zIDFVpBQAB3YVNNQxkiUbqNzYT
         vabw==
X-Gm-Message-State: AAQBX9drAQvhx7wdQl91tA13RacpRII1FUCnKcBnNOvdFoxNO7uiaTw+
        KxVp15uuJf0kDuaZufzXXKisnJHQJFI=
X-Google-Smtp-Source: AKy350bmNjSibzz5IjH+FPLvx4k80sgIsDRNsbkYElca1mk18T7z7nd5kgY0LY9/n5OZPy8CMNf9FA==
X-Received: by 2002:a2e:80c4:0:b0:295:ba22:360 with SMTP id r4-20020a2e80c4000000b00295ba220360mr7177511ljg.42.1680102073973;
        Wed, 29 Mar 2023 08:01:13 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id h26-20020a2e901a000000b00298a7f8c4bfsm4771546ljg.67.2023.03.29.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:01:13 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 29 Mar 2023 17:01:11 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCRStzHE06l21T0c@pc636>
References: <20230327170126.406044-1-urezki@gmail.com>
 <132e2d5c-0c1f-4fff-850c-b3fb084455bb@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132e2d5c-0c1f-4fff-850c-b3fb084455bb@lucifer.local>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Lorenzo!

> >  /*
> > - * XArray of vmap blocks, indexed by address, to quickly find a vmap block
> > - * in the free path. Could get rid of this if we change the API to return a
> > - * "cookie" from alloc, to be passed to free. But no big deal yet.
> > + * In order to fast access to any "vmap_block" associated with a
> > + * specific address, we store them into a per-cpu xarray. A hash
> > + * function is addr_to_vbq() whereas a key is a vb->va->va_start
> > + * value.
> > + *
> > + * Please note, a vmap_block_queue, which is a per-cpu, is not
> > + * serialized by a raw_smp_processor_id() current CPU, instead
> > + * it is chosen based on a CPU-index it belongs to, i.e. it is
> > + * a hash-table.
> > + *
> > + * An example:
> > + *
> > + *  CPU_1  CPU_2  CPU_0
> > + *    |      |      |
> > + *    V      V      V
> > + * 0     10     20     30     40     50     60
> > + * |------|------|------|------|------|------|...<vmap address space>
> > + *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> > + *
> > + * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> > + *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> > + *
> > + * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> > + *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> > + *
> > + * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> > + *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> >   */
> 
> OK so if I understand this correctly, you're overloading the per-CPU
> vmap_block_queue array to use as a simple hash based on the address and
> relying on the xa_lock() in xa_insert() to serialise in case of contention?
> 
> I like the general heft of your comment but I feel this could be spelled
> out a little more clearly, something like:-
> 
>   In order to have fast access to any vmap_block object associated with a
>   specific address, we use a hash.
> 
>   Rather than waste space on defining a new hash table  we take advantage
>   of the fact we already have a static per-cpu array vmap_block_queue.
> 
>   This is already used for per-CPU access to the block queue, however we
>   overload this to _also_ act as a vmap_block hash. The hash function is
>   addr_to_vbq() which hashes on vb->va->va_start.
> 
>   This then uses per_cpu() to lookup the _index_ rather than the
>   _cpu_. Each vmap_block_queue contains an xarray of vmap blocks which are
>   indexed on the same key as the hash (vb->va->va_start).
> 
>   xarray read acceses are protected by RCU lock and inserts are protected
>   by a spin lock so there is no risk of a race here.
> 
/*
 * In order to fast access to any "vmap_block" associated with a
 * specific address, we use a hash.
 *
 * A per-cpu vmap_block_queue is used in both ways, to serialize
 * an access to free block chains among CPUs(alloc path) and it
 * also acts as a vmap_block hash(alloc/free paths). It means we
 * overload it, since we already have the per-cpu array which is
 * used as a hash table.
 *
 * A hash function is addr_to_vbq() which hashes any address to
 * a specific index(in a hash) it belongs to. This then uses a
 * per_cpu() macro to access the array with specific index.
 *
 * An example:
 *
 *  CPU_1  CPU_2  CPU_0
 *    |      |      |
 *    V      V      V
 * 0     10     20     30     40     50     60
 * |------|------|------|------|------|------|...<vmap address space>
 *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
 *
 * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
 *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
 *
 * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
 *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
 *
 * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
 *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
 *
 * This technique allows almost remove a lock-contention in locking
 * primitives which protect insert/remove operations.
 */
Are you find with it?

--
Uladzislau Rezki

