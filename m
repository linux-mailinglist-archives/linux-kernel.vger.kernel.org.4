Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B6A621EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKHVpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKHVpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:45:14 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001A920373
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:45:12 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ft34so5672407ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 13:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mZFYs8/zJjnbjhxTKlu/w82IWm0RAU48MKw/y8nRI+A=;
        b=mhDFXjVqtUOa9ADmdT3AyKxlu9yrLNznmsAqiT/urYmLB5C5JlSB2vwN0krfoC9fyA
         orfVh86H0lh+U9RieTNZKk20UdD6ApuyCbEEJehRxBGPaQj9d44Q+kG6SMwdl2jpjJwb
         kh+g6MbuP1lAqfh4ECVfKGkX3XBXVH+dJd3ZWySFEHT1Uesu2Mi0jxW/6N1x9mjgM9mx
         0Lm/w6shCcvrUGhLoY6y2d9MYpQ3aVExCzItoXq/DRazSkayN6xXjISbYg+u5oGuKLmr
         tvunTpllbeBaCcXFRCliaHmOCMMGO0WfVFfZT5BXf8fsMf3Nlk6sclYgGXff/K7k0+zv
         CExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZFYs8/zJjnbjhxTKlu/w82IWm0RAU48MKw/y8nRI+A=;
        b=w+o/WLbbaoShSB6GJBNHvYCeO/Qh8CXuSvqixQu+mi19SvNi3ukaOIYPIiPENH1Gtq
         Un7iBj/txOk6MpFrspjAWdV7S/MM90I5enkIAXbVu6H1DoMnlEFIF+sq+rmO9yAVIoyw
         iqCZAoSz8kARgiDsukbz/t6xUV1BRWIEisWhWMamq0NEGZY08chkeBYIAvgjt9t+ksWl
         3bdVOv+FzD4dWR5YQC6mxXpARJ7ZaaDtHuYL1WR3TtIFeMb8PPhc/JOfOn8/hFvu6vTf
         ji/6mxwKDQ1tq7ohRgFg0beC6i5KEANjj9/VhFKtAoe7/3tRCCufkrMd88LyQr7a24hx
         ELXg==
X-Gm-Message-State: ACrzQf36A+9w7u07bttxmC9xy6ODvEVSFGjiEcp+1pIgP6ZBg2rAwB/8
        4f3QeJax+6ECZkKjyjje64TsLGPfUvJO5kzPRie8Vg==
X-Google-Smtp-Source: AMsMyM5Prj/Xj102CMb75AxvuB6WgPWaojsX+xM0xgkodxuTmeo7H90R++xOrlixi2Jh2ZqCmo5RKF7YvufuC+HL7k8=
X-Received: by 2002:a17:907:761b:b0:7a3:86dd:d330 with SMTP id
 jx27-20020a170907761b00b007a386ddd330mr54176947ejc.34.1667943911502; Tue, 08
 Nov 2022 13:45:11 -0800 (PST)
MIME-Version: 1.0
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
In-Reply-To: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 8 Nov 2022 16:44:34 -0500
Message-ID: <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
Subject: Re: Deprecating and removing SLOB
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Hi,
>
> as we all know, we currently have three slab allocators. As we discussed
> at LPC [1], it is my hope that one of these allocators has a future, and
> two of them do not.
>
> The unsurprising reasons include code maintenance burden, other features
> compatible with only a subset of allocators (or more effort spent on the
> features), blocking API improvements (more on that below), and my
> inability to pronounce SLAB and SLUB in a properly distinguishable way,
> without resorting to spelling out the letters.
>
> I think (but may be proven wrong) that SLOB is the easier target of the
> two to be removed, so I'd like to focus on it first.
>
> I believe SLOB can be removed because:
>
> - AFAIK nobody really uses it? It strives for minimal memory footprint
> by putting all objects together, which has its CPU performance costs
> (locking, lack of percpu caching, searching for free space...). I'm not
> aware of any "tiny linux" deployment that opts for this. For example,
> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
> SLOB impact is too much for those who tried. Googling for
> "CONFIG_SLOB=y" yielded nothing useful.

I am all for removing SLOB.

There are some devices with configs where SLOB is enabled by default.
Perhaps, the owners/maintainers of those devices/configs should be
included into this thread:

tatashin@soleen:~/x/linux$ git grep SLOB=y
arch/arm/configs/clps711x_defconfig:CONFIG_SLOB=y
arch/arm/configs/collie_defconfig:CONFIG_SLOB=y
arch/arm/configs/multi_v4t_defconfig:CONFIG_SLOB=y
arch/arm/configs/omap1_defconfig:CONFIG_SLOB=y
arch/arm/configs/pxa_defconfig:CONFIG_SLOB=y
arch/arm/configs/tct_hammer_defconfig:CONFIG_SLOB=y
arch/arm/configs/xcep_defconfig:CONFIG_SLOB=y
arch/openrisc/configs/or1ksim_defconfig:CONFIG_SLOB=y
arch/openrisc/configs/simple_smp_defconfig:CONFIG_SLOB=y
arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
arch/sh/configs/rsk7201_defconfig:CONFIG_SLOB=y
arch/sh/configs/rsk7203_defconfig:CONFIG_SLOB=y
arch/sh/configs/se7206_defconfig:CONFIG_SLOB=y
arch/sh/configs/shmin_defconfig:CONFIG_SLOB=y
arch/sh/configs/shx3_defconfig:CONFIG_SLOB=y
kernel/configs/tiny.config:CONFIG_SLOB=y

>
> - Last time we discussed it [2], it seemed SLUB memory requirements can
> be brought very close to SLOB's if needed. Of course it can never have
> as small footprint as SLOB due to separate kmem_caches, but the
> difference is not that significant, unless somebody still tries to use
> Linux on very tiny systems (goes back to the previous point).
>
> Besides the smaller maintenance burden, removing SLOB would allow us to
> do a useful API improvement - the ability to use kfree() for both
> objects allocated by kmalloc() and kmem_cache_alloc(). Currently the
> latter has to be freed by kmem_cache_free(), passing a kmem_cache
> pointer in addition to the object pointer. With SLUB and SLAB, it is
> however possible to use kfree() instead, as the kmalloc caches and the
> rest of kmem_caches are the same and kfree() can lookup the kmem_cache
> from object pointer easily for any of those. XFS has apparently did that
> for years without anyone noticing it's broken on SLOB [3], and
> legitimizing and expanding this would help some use cases beside XFS
> (IIRC Matthew mentioned rcu-based freeing for example).
>
> However for SLOB to support kfree() on all allocations, it would need to
> store object size of allocated objects (which it currently does only for
> kmalloc() objects, prepending a size header to the object), but for
> kmem_cache_alloc() allocations as well. This has been attempted in the
> thread [3] but it bloats the memory usage, especially on architectures
> with large ARCH_KMALLOC_MINALIGN, where the prepended header basically
> has to occupy the whole ARCH_KMALLOC_MINALIGN block to be DMA safe.
> There are ongoing efforts to reduce this minalign, but the memory
> footprint would still increase, going against the purpose of SLOB, so
> again it would be easier if we could just remove it.
>
> So with this thread I'm interested in hearing arguments/use cases for
> keeping SLOB. There might be obviously users of SLOB whom this
> conversation will not reach, so I assume the eventual next step would be
> to deprecate it in a way that those users are notified when building a
> new kernel and can raise their voice then. Is there a good proven way
> how to do that for a config option like this one?
>
> Thanks,
> Vlastimil
>
> [1] https://lpc.events/event/16/contributions/1272/ - slides in the
> slabs.pdf linked there
> [2]
> https://lore.kernel.org/all/20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal/#t
> [3]
> https://lore.kernel.org/all/20210930044202.GP2361455@dread.disaster.area/
>
>
>
