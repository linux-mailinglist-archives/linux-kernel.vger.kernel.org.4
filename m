Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493217254F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbjFGG6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbjFGG6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:58:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A6E1730
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:58:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1bdfe51f8so3333151fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686121125; x=1688713125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=82Mu8QU4HigZydZK6DfsxJpMaVzvXeGB338dtPOY7lc=;
        b=ci3FU/8Ywn3sJORB9+b8BmfaGsKCl5pt/0UliRmgmvFvOY8lecCDd6qiEFFrJkog39
         e4Ti+y49/WlBtP7CARqhfDuVITEYKcv35NBmt7nkKU63tU2dSrGr+ir5G3q6b7sEoPfy
         76wwyY+cOcCFZA+klvxrfQTHlk2kAWNxoondLl331cRz2g07xiYqrzcXuCj0rgf8hesA
         aZhDE4CIHNqdkITdqdIe/KEqEoWtx5YgyT1/au1fh5SJBH5O67jIIoiTLrmCsipIgH9z
         l8As81tUBAlzKfkwFxJ7vmgJjR9dqQv8H54QywLscqH+Yd7IOf97Hkce2XzhJQejWcyf
         3VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686121125; x=1688713125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82Mu8QU4HigZydZK6DfsxJpMaVzvXeGB338dtPOY7lc=;
        b=iJ+PWRo4qy84UrszudCJcJgpHkZQPD/2DDOd37VPy9SMnCIPSdfi2KNnXj3RXAibhF
         cZ592B+qPjarLDUUdsYKtBAbpxX0qxL7iF5xmPPUQU/Sq9jVriLvN7l3DXzcgaowxoyR
         5fIpa5O3PaIKrgBStjW7hgVXmldzCR/baYJrqD8s/TNX59rr5iu+K+nmHONyCIPNInGB
         O7QRhrqcQo7i0INetyfUxzOiddXyAS8pI0G6C3CllBCpW9GjIikF30QDJlN2lSZwZUAI
         jyzYrzUYQKzy9jC99zEC35mB41FyjiTzFFTOBUAsp1mRh/ouPGQRizCeRhGin8hXVKe3
         qbuA==
X-Gm-Message-State: AC+VfDydBWKQa3qtLPrUKuO4v2yfkPxiBJWuZQ2b7exzirZFeatIkGsY
        P7Ewxc3vkO3fT/FztEF+UHw=
X-Google-Smtp-Source: ACHHUZ5B2RdpfLHe8NDMciXzpd9hXBiT9WzxU7nqW7jVGDhWqel12HsOpeMGr/WkkkljEJcjMoA5oQ==
X-Received: by 2002:a2e:2d02:0:b0:2ac:6f6d:aee4 with SMTP id t2-20020a2e2d02000000b002ac6f6daee4mr1635329ljt.6.1686121125258;
        Tue, 06 Jun 2023 23:58:45 -0700 (PDT)
Received: from pc636 (host-90-233-211-151.mobileonline.telia.com. [90.233.211.151])
        by smtp.gmail.com with ESMTPSA id t17-20020a2e9c51000000b002ac7a25c001sm2109931ljj.24.2023.06.06.23.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 23:58:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 7 Jun 2023 08:58:42 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <ZIAqojPKjChJTssg@pc636>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-9-urezki@gmail.com>
 <ZH0vuwaSddREy9dz@MiWiFi-R3L-srv>
 <ZH7128Q0MiRh6S5f@pc638.lan>
 <ZH8iWAgsDSF1I+B6@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH8iWAgsDSF1I+B6@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:11:04PM +0800, Baoquan He wrote:
> On 06/06/23 at 11:01am, Uladzislau Rezki wrote:
> > On Mon, Jun 05, 2023 at 08:43:39AM +0800, Baoquan He wrote:
> > > On 05/22/23 at 01:08pm, Uladzislau Rezki (Sony) wrote:
> > > ......  
> > > > +static unsigned long
> > > > +this_cpu_zone_alloc_fill(struct cpu_vmap_zone *z,
> > > > +	unsigned long size, unsigned long align,
> > > > +	gfp_t gfp_mask, int node)
> > > > +{
> > > > +	unsigned long addr = VMALLOC_END;
> > > > +	struct vmap_area *va;
> > > > +
> > > > +	/*
> > > > +	 * It still can race. One task sets a progress to
> > > > +	 * 1 a second one gets preempted on entry, the first
> > > > +	 * zeroed the progress flag and second proceed with
> > > > +	 * an extra prefetch.
> > > > +	 */
> > > > +	if (atomic_xchg(&z->fill_in_progress, 1))
> > > > +		return addr;
> > > > +
> > > > +	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
> > > > +	if (unlikely(!va))
> > > > +		goto out;
> > > > +
> > > > +	spin_lock(&free_vmap_area_lock);
> > > > +	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> > > > +		cvz_size, 1, VMALLOC_START, VMALLOC_END);
> > > > +	spin_unlock(&free_vmap_area_lock);
> > > 
> > > The 'z' is passed in from this_cpu_zone_alloc(), and it's got with
> > > raw_cpu_ptr(&cpu_vmap_zone). Here when we try to get chunk of cvz_size
> > > from free_vmap_area_root/free_vmap_area_list, how can we guarantee it
> > > must belong to the 'z' zone? With my understanding, __alloc_vmap_area()
> > > will get efficient address range sequentially bottom up from
> > > free_vmap_area_root. Please correct me if I am wrong.
> > > 
> > We do not guarantee that and it does not worth it. The most important is:
> > 
> > If we search a zone that exactly match a CPU-id the usage of a global
> > vmap space becomes more wider, i.e. toward a high address space. This is
> > not good because we can affect other users which allocate within a specific
> > range. On a big system it might be a problem. Therefore a pre-fetch is done 
> > sequentially on demand.
> > 
> > Secondly, i do not see much difference in performance if we follow
> > exactly CPU-zone-id.
> 
> Ah, I see, the allocated range will be put into appropriate zone's
> busy tree by calculating its zone via addr_to_cvz(va->va_start). The
> cvz->free tree is only a percpu pre-fetch cache. This is smart, thanks a
> lot for explanation. 
> 
Yes. The busy/lazy are placed per-cpu zone(using addr_to_cvz(addr)) whereas
the allocated chunk on a current CPU.

Thanks!

--
Uladzislau Rezki
