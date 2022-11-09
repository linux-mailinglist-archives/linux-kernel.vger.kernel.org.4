Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F0162264D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKIJJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiKIJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:09:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B38CED2D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:08:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 79215225AE;
        Wed,  9 Nov 2022 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667984426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tNgqA/29m6rapVBwLFRJijgTafS7LZvhU0/xyktjM78=;
        b=kp73N4GrxXnW44EQ0y0a4TB2FDUUhg9bhrveGCZgIn/A1FhubwJpIh1y+hKCy4wXn6co3c
        20upJxsrxiH0vy1+PpItIS5Jo6KaTzwXo6xPoQ912M/H7ab2GsZFIjcSfjFjLeN+2kEExt
        bf66ED4Q+PFwb70volaUmYYdnVvXgi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667984426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tNgqA/29m6rapVBwLFRJijgTafS7LZvhU0/xyktjM78=;
        b=jMap4o4c/5oJmcGWZKwu3L1piJFejxuiyCAfS3FvdJDGlPwqXn8NI6LbHqPMV0ko/4ZQLu
        DUlwcAZMY/Up0yAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E7801331F;
        Wed,  9 Nov 2022 09:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q/7UAipsa2P0ZAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 09 Nov 2022 09:00:26 +0000
Message-ID: <87187c52-ae48-130b-6479-ae1023915bc1@suse.cz>
Date:   Wed, 9 Nov 2022 10:00:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
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
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Shiyan <shc_work@mail.ru>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-olinux-omap@vger.kernel.orgmap"@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/22 22:44, Pasha Tatashin wrote:
> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> Hi,
>>
>> as we all know, we currently have three slab allocators. As we discussed
>> at LPC [1], it is my hope that one of these allocators has a future, and
>> two of them do not.
>>
>> The unsurprising reasons include code maintenance burden, other features
>> compatible with only a subset of allocators (or more effort spent on the
>> features), blocking API improvements (more on that below), and my
>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>> without resorting to spelling out the letters.
>>
>> I think (but may be proven wrong) that SLOB is the easier target of the
>> two to be removed, so I'd like to focus on it first.
>>
>> I believe SLOB can be removed because:
>>
>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>> by putting all objects together, which has its CPU performance costs
>> (locking, lack of percpu caching, searching for free space...). I'm not
>> aware of any "tiny linux" deployment that opts for this. For example,
>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>> SLOB impact is too much for those who tried. Googling for
>> "CONFIG_SLOB=y" yielded nothing useful.
> 
> I am all for removing SLOB.
> 
> There are some devices with configs where SLOB is enabled by default.
> Perhaps, the owners/maintainers of those devices/configs should be
> included into this thread:
> 
> tatashin@soleen:~/x/linux$ git grep SLOB=y
> arch/arm/configs/clps711x_defconfig:CONFIG_SLOB=y
> arch/arm/configs/collie_defconfig:CONFIG_SLOB=y
> arch/arm/configs/multi_v4t_defconfig:CONFIG_SLOB=y
> arch/arm/configs/omap1_defconfig:CONFIG_SLOB=y
> arch/arm/configs/pxa_defconfig:CONFIG_SLOB=y
> arch/arm/configs/tct_hammer_defconfig:CONFIG_SLOB=y
> arch/arm/configs/xcep_defconfig:CONFIG_SLOB=y
> arch/openrisc/configs/or1ksim_defconfig:CONFIG_SLOB=y
> arch/openrisc/configs/simple_smp_defconfig:CONFIG_SLOB=y
> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
> arch/sh/configs/rsk7201_defconfig:CONFIG_SLOB=y
> arch/sh/configs/rsk7203_defconfig:CONFIG_SLOB=y
> arch/sh/configs/se7206_defconfig:CONFIG_SLOB=y
> arch/sh/configs/shmin_defconfig:CONFIG_SLOB=y
> arch/sh/configs/shx3_defconfig:CONFIG_SLOB=y
> kernel/configs/tiny.config:CONFIG_SLOB=y

Great point, thanks. Ccing. First mail here:
https://lore.kernel.org/all/CA%2BCK2bD-uVGJ0%3D9uc7Lt5zwY%2B2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com/



>>
>> - Last time we discussed it [2], it seemed SLUB memory requirements can
>> be brought very close to SLOB's if needed. Of course it can never have
>> as small footprint as SLOB due to separate kmem_caches, but the
>> difference is not that significant, unless somebody still tries to use
>> Linux on very tiny systems (goes back to the previous point).
>>
>> Besides the smaller maintenance burden, removing SLOB would allow us to
>> do a useful API improvement - the ability to use kfree() for both
>> objects allocated by kmalloc() and kmem_cache_alloc(). Currently the
>> latter has to be freed by kmem_cache_free(), passing a kmem_cache
>> pointer in addition to the object pointer. With SLUB and SLAB, it is
>> however possible to use kfree() instead, as the kmalloc caches and the
>> rest of kmem_caches are the same and kfree() can lookup the kmem_cache
>> from object pointer easily for any of those. XFS has apparently did that
>> for years without anyone noticing it's broken on SLOB [3], and
>> legitimizing and expanding this would help some use cases beside XFS
>> (IIRC Matthew mentioned rcu-based freeing for example).
>>
>> However for SLOB to support kfree() on all allocations, it would need to
>> store object size of allocated objects (which it currently does only for
>> kmalloc() objects, prepending a size header to the object), but for
>> kmem_cache_alloc() allocations as well. This has been attempted in the
>> thread [3] but it bloats the memory usage, especially on architectures
>> with large ARCH_KMALLOC_MINALIGN, where the prepended header basically
>> has to occupy the whole ARCH_KMALLOC_MINALIGN block to be DMA safe.
>> There are ongoing efforts to reduce this minalign, but the memory
>> footprint would still increase, going against the purpose of SLOB, so
>> again it would be easier if we could just remove it.
>>
>> So with this thread I'm interested in hearing arguments/use cases for
>> keeping SLOB. There might be obviously users of SLOB whom this
>> conversation will not reach, so I assume the eventual next step would be
>> to deprecate it in a way that those users are notified when building a
>> new kernel and can raise their voice then. Is there a good proven way
>> how to do that for a config option like this one?
>>
>> Thanks,
>> Vlastimil
>>
>> [1] https://lpc.events/event/16/contributions/1272/ - slides in the
>> slabs.pdf linked there
>> [2]
>> https://lore.kernel.org/all/20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal/#t
>> [3]
>> https://lore.kernel.org/all/20210930044202.GP2361455@dread.disaster.area/
>>
>>
>>

