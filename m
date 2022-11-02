Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8197615CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKBHQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKBHQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:16:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B287F2314C;
        Wed,  2 Nov 2022 00:16:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c24so15735829pls.9;
        Wed, 02 Nov 2022 00:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxnaJtGnHY9c3pR6sfYcqGHFdJa7CTSVoKFDBdpZd/E=;
        b=RfYfUanUzsmrD4NrnTpZIgg1ZpZyGlfKzER+Us1F3hVaaryHC5ViWPZ+qmbEwqPuxd
         J2qSCoI5sTwQVQlLmuZh7I+FE4P94psmy3fwJ3YnEpJvsaWgy/SZawU4IwEy7h55LHwp
         ZfzW9i0Xl9JIXi5JTuuri+byzb++DGZWNaUFJFlQUSPL+oF6sGH9opKSDboMTikMSxsF
         cPXQJNrjUi/HIj9n5/4tMg9TDSnguq45BE4iOzAAMOeGtH7iW/N/HSRRTxufRWzDLb+j
         rCDWTTpFcK7SAN8CGxlGZny+kj6rD3HikkdTKoYhyvt+Td2WR/cwAXagCff2k/tLYjP1
         AiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxnaJtGnHY9c3pR6sfYcqGHFdJa7CTSVoKFDBdpZd/E=;
        b=Lf6mZZImi4NKfs/h2ppiuo1Pv9vnElA6MF0G8ievSyCov7Lh1RM4jTnAoCmTUSWncg
         RxxurLG47rS5CXlS8ATCanWfNLGfZXa8ExN+zVXuni06D1E8U6XcF0Zw6IAMyJMX0yLd
         tyLYW3tVWlv1hNovXFgICELDQ/chZJiOC9+PkXCQWvKg+N01GoJ0R9pVxMkZU6QMVbZ/
         qEGW4ubfBACO6TzmPxj1wrno3JFxlezPqqqOW24r7i1L9zk6Kz390+6xJMyzAN3+FCF/
         hVUbkoShJ177uMdTl7wz2ySieyZs6BSNt6ovp8ziADvheCAW+Zhx5+EmeUxGJ+zUSrpI
         ZQdA==
X-Gm-Message-State: ACrzQf1LMhJdlVq7CSnqf7yqmUGZs8oH3AV+hR0gx5o10QUSpOcJxv89
        8N6f45QKj2N/Jq9Ra9NKBOk=
X-Google-Smtp-Source: AMsMyM7VCjOjm4355yCUSd9y7vSe9NT/AXkF+/ACD4YrTSRx1swmQlVcbiwoopX0A/w7M6LidjjF3g==
X-Received: by 2002:a17:90a:e147:b0:213:bd97:d6b7 with SMTP id ez7-20020a17090ae14700b00213bd97d6b7mr20173753pjb.199.1667373376131;
        Wed, 02 Nov 2022 00:16:16 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a195c00b001f8c532b93dsm747383pjh.15.2022.11.02.00.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:16:14 -0700 (PDT)
Date:   Wed, 2 Nov 2022 16:16:06 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     John Thomson <lists@johnthomson.fastmail.com.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <Y2IZNqpABkdxxPjv@hyeyoo>
References: <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
 <Y2DngwUc7cLB0dG7@hyeyoo>
 <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
 <Y2D4D52h5VVa8QpE@hyeyoo>
 <Y2ElURkvmGD5csMc@feng-clx>
 <70002fbe-34ec-468e-af67-97e4bf97819b@app.fastmail.com>
 <Y2IJSR6NLVyVTsDY@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2IJSR6NLVyVTsDY@feng-clx>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:08:09PM +0800, Feng Tang wrote:
> On Tue, Nov 01, 2022 at 07:39:13PM +0000, John Thomson wrote:
> > 
> > 
> > On Tue, 1 Nov 2022, at 13:55, Feng Tang wrote:
> > > On Tue, Nov 01, 2022 at 06:42:23PM +0800, Hyeonggon Yoo wrote:
> > >> setup_arch() is too early to use slab allocators.
> > >> I think slab received NULL pointer because kmalloc is not initialized.
> > >> 
> > >> It seems arch/mips/ralink/mt7621.c is using slab too early.
> > >
> > > Cool! it is finally root caused :) Thanks!
> > >
> > > The following patch should solve it and give it a warning message, though
> > > I'm not sure if there is other holes.  
> > >
> > > Thanks,
> > > Feng
> > >
> > > ---
> > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > index 33b1886b06eb..429c21b7ecbc 100644
> > > --- a/mm/slab_common.c
> > > +++ b/mm/slab_common.c
> > > @@ -1043,7 +1043,14 @@ size_t __ksize(const void *object)
> > >  #ifdef CONFIG_TRACING
> > >  void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
> > >  {
> > > -	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
> > > +	void *ret;
> > > +
> > > +	if (unlikely(ZERO_OR_NULL_PTR(s))) {
> > > +		WARN_ON_ONCE(1);
> > > +		return s;
> > > +	}
> > > +
> > > +	ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
> > >  					    size, _RET_IP_);
> > > 
> > >  	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 157527d7101b..85d24bb6eda7 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -3410,8 +3410,14 @@ static __always_inline
> > >  void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> > >  			     gfp_t gfpflags)
> > >  {
> > > -	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> > > +	void *ret;
> > > 
> > > +	if (unlikely(ZERO_OR_NULL_PTR(s))) {
> > > +		WARN_ON_ONCE(1);
> > > +		return s;
> > > +	}
> > > +

Thank you for suggestion!

I think the holes are:
	kmalloc_node_trace(), kmem_cache_alloc_node(), __do_kmalloc_node()

And want to suggest:
	What about using VM_WARN_ON_ONCE() instead?

> > > +	ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> > >  	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
> > > 
> > >  	return ret;
> > 
> > Yes, thank you, that patch atop v6.1-rc3 lets me boot, and shows the warning and stack dump.
> > Will you submit that, or how do we want to proceed?
> 
> Thanks for confirming. I wanted to wait for Vlastimil, Hyeonggon and
> other developer's opinion. And yes, I can also post a more formal one.
> 
> > transfer started ......................................... transfer ok, time=2.11s
> > setting up elf image... OK
> > jumping to kernel code
> > zimage at:     80B842A0 810B4BC0
> > 
> > Uncompressing Linux at load address 80001000
> > 
> > Copy device tree to address  80B80EE0
> > 
> > Now, booting the kernel...
> > 
> > [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #73 SMP Wed Nov  2 05:10:01 AEST 2022
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] WARNING: CPU: 0 PID: 0 at mm/slub.c:3416 kmem_cache_alloc+0x5a4/0x5e8
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #73
> > [    0.000000] Stack : 810fff78 80084d98 00000000 00000004 00000000 00000000 80889d04 80c90000
> > [    0.000000]         80920000 807bd328 8089d368 80923bd3 00000000 00000001 80889cb0 00000000
> > [    0.000000]         00000000 00000000 807bd328 8084bcb1 00000002 00000002 00000001 6d6f4320
> > [    0.000000]         00000000 80c97d3d 80c97d68 fffffffc 807bd328 00000000 00000000 00000000
> > [    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000 00000020 80010000 80010000
> > [    0.000000]         ...
> > [    0.000000] Call Trace:
> > [    0.000000] [<80008260>] show_stack+0x28/0xf0
> > [    0.000000] [<8070c958>] dump_stack_lvl+0x60/0x80
> > [    0.000000] [<8002e184>] __warn+0xc4/0xf8
> > [    0.000000] [<8002e210>] warn_slowpath_fmt+0x58/0xa4
> > [    0.000000] [<801c0fac>] kmem_cache_alloc+0x5a4/0x5e8
> > [    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
> > [    0.000000] [<80928060>] prom_init+0x44/0xf0
> > [    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
> > [    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
> > [    0.000000] 
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
> > [    0.000000] printk: bootconsole [early0] enabled
> > 
> > Thank you for working through this with me.
> > I will try to address the root cause in mt7621.c.
> > It looks like other arch/** soc_device_register users use postcore_initcall, device_initcall,
> > or the ARM DT_MACHINE_START .init_machine. A quick hack to use postcore_initcall in mt7621
> > avoided this zero ptr kmem_cache passed to kmem_cache_alloc_lru.
> 
> If IIUC, the prom_soc_init() is only called once in kernel, can the
> 'soc_dev_attr' just be defined as a global data structure instead
> of calling kzalloc(), as its size is small only containing 7 pointers.

But soc_device_registers() too uses kmalloc. I think calling it
after slab initialization will be best solution - if that is correct.

> 
> Thanks,
> Feng
> 

-- 
Thanks,
Hyeonggon
