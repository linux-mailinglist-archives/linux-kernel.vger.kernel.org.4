Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CF6723C74
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbjFFJBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbjFFJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:01:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399FBE8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:01:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-97467e06511so678544266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686042078; x=1688634078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnMd6bfiED4zKR1iR5FkmLNtvDbuw3tGERhLuXjCvBQ=;
        b=HIdIZcQCFKSHUksaNp5kqKFQs1fdAVHgMqC66xzYesJR+taDCpexBTpoNgamojfRxY
         DIz5T8XtMO8pcl6BCOeP5v0BbzQKV0kt0co8gw7nxxBswhotqGYKdfFzlToNK3OlOp8H
         A47TYwbuzyUMgySNNCVDzjpyqduYQOGP1wQ4sBphEM3iFFqRXI6ctlMbJhU1jorIbPZG
         4Jan/I3cfGPq0S70UM4oQoRwgnMhDzku7qR0dlZhVgOCP78CqUcsjzBTrp/U/mQ9JHyL
         yuMUQN7seGAuX1AW1qris3EObLx3cqDWuTHR3T9pZbf+/JhMCQ43hTRzZbhocTD1QREC
         NZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042078; x=1688634078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnMd6bfiED4zKR1iR5FkmLNtvDbuw3tGERhLuXjCvBQ=;
        b=J0l6+qiLSiwEcdZGCcXIyMQOjdBqJbViWDoEXndl2giYb+PhzPDo4i+xIi0OvOuVWp
         kVWcyGm+qHSdr3LkCRaGTVoZXDYdyBiiHeR3JNUNV46ZkN8gtjpbM5DJh2RRdD+iPopa
         VyHx4hFuYET9z8fpQbIz8BUkxgEUGkZbBbZygXWWZmigS1hb4AZ0B4OV/R3/xG42tmz7
         vQrfaUzykcv6eL6FeHtCMxDv6wPlTgwDRJQ+uMXwczt63ZsFbrh0D5TeaVih0+h4+9mT
         cEiDQcOlJP+D6DlU0z02/PdNa8GiQ2+/n/L5q1Vfk/zVPLIK6jI7Ipa2RA/x+/OqdVET
         XWFA==
X-Gm-Message-State: AC+VfDw2hs+gXOzg+BD9H2p/fVkwKFZ4sqkU/tGABj+A3lmx2ARtwVG0
        ljeBjCqBGkuqUhikTy0W3D0C5gOfwgc=
X-Google-Smtp-Source: ACHHUZ59rso37royUEW/KsCeYswFmChzfMtAKYDSvPTvRqfq++5UqovHaWXqgye1/8LDFozfOPdU/Q==
X-Received: by 2002:a17:907:6d27:b0:978:66bd:d771 with SMTP id sa39-20020a1709076d2700b0097866bdd771mr1998621ejc.55.1686042077499;
        Tue, 06 Jun 2023 02:01:17 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r4-20020a17090638c400b009584c5bcbc7sm5254907ejd.49.2023.06.06.02.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 02:01:17 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 6 Jun 2023 11:01:15 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 8/9] mm: vmalloc: Offload free_vmap_area_lock global lock
Message-ID: <ZH7128Q0MiRh6S5f@pc638.lan>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-9-urezki@gmail.com>
 <ZH0vuwaSddREy9dz@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH0vuwaSddREy9dz@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 08:43:39AM +0800, Baoquan He wrote:
> On 05/22/23 at 01:08pm, Uladzislau Rezki (Sony) wrote:
> ......  
> > +static unsigned long
> > +this_cpu_zone_alloc_fill(struct cpu_vmap_zone *z,
> > +	unsigned long size, unsigned long align,
> > +	gfp_t gfp_mask, int node)
> > +{
> > +	unsigned long addr = VMALLOC_END;
> > +	struct vmap_area *va;
> > +
> > +	/*
> > +	 * It still can race. One task sets a progress to
> > +	 * 1 a second one gets preempted on entry, the first
> > +	 * zeroed the progress flag and second proceed with
> > +	 * an extra prefetch.
> > +	 */
> > +	if (atomic_xchg(&z->fill_in_progress, 1))
> > +		return addr;
> > +
> > +	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
> > +	if (unlikely(!va))
> > +		goto out;
> > +
> > +	spin_lock(&free_vmap_area_lock);
> > +	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> > +		cvz_size, 1, VMALLOC_START, VMALLOC_END);
> > +	spin_unlock(&free_vmap_area_lock);
> 
> The 'z' is passed in from this_cpu_zone_alloc(), and it's got with
> raw_cpu_ptr(&cpu_vmap_zone). Here when we try to get chunk of cvz_size
> from free_vmap_area_root/free_vmap_area_list, how can we guarantee it
> must belong to the 'z' zone? With my understanding, __alloc_vmap_area()
> will get efficient address range sequentially bottom up from
> free_vmap_area_root. Please correct me if I am wrong.
> 
We do not guarantee that and it does not worth it. The most important is:

If we search a zone that exactly match a CPU-id the usage of a global
vmap space becomes more wider, i.e. toward a high address space. This is
not good because we can affect other users which allocate within a specific
range. On a big system it might be a problem. Therefore a pre-fetch is done 
sequentially on demand.

Secondly, i do not see much difference in performance if we follow
exactly CPU-zone-id.

> static unsigned long
> this_cpu_zone_alloc(unsigned long size, unsigned long align, gfp_t gfp_mask, int node)
> {
>         struct cpu_vmap_zone *z = raw_cpu_ptr(&cpu_vmap_zone);
> 	......
> 	if (addr == VMALLOC_END && left < 4 * PAGE_SIZE)
>                 addr = this_cpu_zone_alloc_fill(z, size, align, gfp_mask, node);
> }
> 
> > +
> > +	if (addr == VMALLOC_END) {
> > +		kmem_cache_free(vmap_area_cachep, va);
> > +		goto out;
> > +	}
> > +
> > +	va->va_start = addr;
> > +	va->va_end = addr + cvz_size;
> > +
> > +	fbl_lock(z, FREE);
> > +	va = merge_or_add_vmap_area_augment(va,
> > +		&fbl_root(z, FREE), &fbl_head(z, FREE));
> > +	addr = va_alloc(va, &fbl_root(z, FREE), &fbl_head(z, FREE),
> > +		size, align, VMALLOC_START, VMALLOC_END);
> > +	fbl_unlock(z, FREE);
> > +
> > +out:
> > +	atomic_set(&z->fill_in_progress, 0);
> > +	return addr;
> > +}
> > +
> > +static unsigned long
> > +this_cpu_zone_alloc(unsigned long size, unsigned long align, gfp_t gfp_mask, int node)
> > +{
> > +	struct cpu_vmap_zone *z = raw_cpu_ptr(&cpu_vmap_zone);
> > +	unsigned long extra = align > PAGE_SIZE ? align : 0;
> > +	unsigned long addr = VMALLOC_END, left = 0;
> > +
> > +	/*
> > +	 * It is disabled, fallback to a global heap.
> > +	 */
> > +	if (cvz_size == ULONG_MAX)
> > +		return addr;
> > +
> > +	/*
> > +	 * Any allocation bigger/equal than one half of
>                           ~~~~~~typo~~~~~~  bigger than/equal to
I will rework it!

--
Uladzislau Rezki
