Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0636C946D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCZNLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjCZNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC547ECB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679836250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NPuzCb6emXFKjbfHKUqPR1esheXB74vBtkS6IskDoFs=;
        b=hH38jTzOd/aNx9aTrwMwAd/HjqY7tvyk2b3bvlNN2DZMJCBtKtuvyZeskNX4R09FZhslJs
        3tE1ipwRRlPs//dSyua4EYUgPbmHuw2DX0XdVAVE4vmF3NuFQVb0wufnNdhSD4ES4jMDet
        Q0rhs7xFeJX9JOK7vZsyNLyGhIkzjLA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-I9D9QCf1ObSRY4kuQG3jaA-1; Sun, 26 Mar 2023 09:10:47 -0400
X-MC-Unique: I9D9QCf1ObSRY4kuQG3jaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E125C38041C7;
        Sun, 26 Mar 2023 13:10:46 +0000 (UTC)
Received: from localhost (ovpn-12-88.pek2.redhat.com [10.72.12.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D3C640C6E67;
        Sun, 26 Mar 2023 13:10:44 +0000 (UTC)
Date:   Sun, 26 Mar 2023 21:10:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        horms@kernel.org, John.p.donnelly@oracle.com, will@kernel.org,
        kexec@lists.infradead.org, ardb@kernel.org, rppt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: kdump: defer the crashkernel reservation for
 platforms with no DMA memory zones
Message-ID: <ZCBEQ12AYSrujUBn@MiWiFi-R3L-srv>
References: <20230324131838.409996-1-bhe@redhat.com>
 <20230324131838.409996-4-bhe@redhat.com>
 <3653555d-3302-fc40-c917-963b029fc839@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3653555d-3302-fc40-c917-963b029fc839@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/23 at 10:04am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/3/24 21:18, Baoquan He wrote:
> > In commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> > platforms with no DMA memory zones"), reserve_crashkernel() is called
> > much earlier in arm64_memblock_init() to avoid causing base apge
> > mapping on platforms with no DMA meomry zones.
> > 
> > With taking off protection on crashkernel memory region, no need to call
> > reserve_crashkernel() specially in advance. The deferred invocation of
> > reserve_crashkernel() in bootmem_init() can cover all cases.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/arm64/include/asm/memory.h | 5 -----
> >  arch/arm64/mm/init.c            | 6 +-----
> >  2 files changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index 78e5163836a0..efcd68154a3a 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -374,11 +374,6 @@ static inline void *phys_to_virt(phys_addr_t x)
> >  })
> >  
> >  void dump_mem_limit(void);
> > -
> > -static inline bool defer_reserve_crashkernel(void)
> > -{
> > -	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
> > -}
> >  #endif /* !ASSEMBLY */
> >  
> >  /*
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 58a0bb2c17f1..b888de59e0b7 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -408,9 +408,6 @@ void __init arm64_memblock_init(void)
> >  
> >  	early_init_fdt_scan_reserved_mem();
> >  
> > -	if (!defer_reserve_crashkernel())
> > -		reserve_crashkernel();
> > -
> >  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> >  }
> >  
> > @@ -457,8 +454,7 @@ void __init bootmem_init(void)
> >  	 * request_standard_resources() depends on crashkernel's memory being
> >  	 * reserved, so do it here.
> >  	 */
> > -	if (defer_reserve_crashkernel())
> > -		reserve_crashkernel();
> > +	reserve_crashkernel();
> >  
> >  	memblock_dump_all();
> >  }
> 
> Some comments also need to be deleted, above the definition of arm64_dma_phys_limit
> in arch/arm64/mm/init.c

Thanks, have posted v2 of patch 3 to remove the code comment, and move
back the arm64_dma_phys_limit assignmet as 'PHYS_MASK + 1;' into
zone_sizes_init(). These should be part of the reverting commit
031495635b46, I missed that.

