Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73850715475
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 06:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjE3ETp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 00:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjE3ETj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 00:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F07E3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 21:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685420333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vd84+23L+DqUfG/jxYQI70piLAPE+2K6XH2FBhdTlw8=;
        b=h8EpxyxhZsBv+WFqxq+Sfq2OLDkKy9uo9USCMbpa+FHB91jmQTwdAOx+wYMkaeDMM28twu
        zNRj73UP05zgRgaG3aHsQezl193XieQKljWm4kUsMY9bkw98ZrR/uEYp0NUQxQp3yvNNzs
        UPBl5Fuy7O1fcoeY5QJTie2i3rUK4uU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-rxs9tmbgPDaDSRJNcMrZWg-1; Tue, 30 May 2023 00:18:49 -0400
X-MC-Unique: rxs9tmbgPDaDSRJNcMrZWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 047F0101A52C;
        Tue, 30 May 2023 04:18:49 +0000 (UTC)
Received: from localhost (ovpn-12-192.pek2.redhat.com [10.72.12.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4319340CFD45;
        Tue, 30 May 2023 04:18:47 +0000 (UTC)
Date:   Tue, 30 May 2023 12:18:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH -next] mm: page_alloc: simplify has_managed_dma()
Message-ID: <ZHV5JCINq6fc/SG9@MiWiFi-R3L-srv>
References: <20230529144022.42927-1-wangkefeng.wang@huawei.com>
 <ZHS2AgVvrT3n/hlM@casper.infradead.org>
 <38ea4ea3-cd7f-abf4-e992-2f748e3b1fcb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ea4ea3-cd7f-abf4-e992-2f748e3b1fcb@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/23 at 10:10am, Kefeng Wang wrote:
> 
> 
> On 2023/5/29 22:26, Matthew Wilcox wrote:
> > On Mon, May 29, 2023 at 10:40:22PM +0800, Kefeng Wang wrote:
> > > The ZONE_DMA should only exists on Node 0, only check NODE_DATA(0)
> > > is enough, so simplify has_managed_dma() and make it inline.
> > 
> > That's true on x86, but is it true on all architectures?
> 
> There is no document about numa node info for the DMA_ZONE, + Mike
> 
> I used 'git grep -w ZONE_DMA arch/'

willy is right. max_zone_pfn can only limit the range of zone, but
can't decide which zone is put on which node. The memory layout is
decided by firmware. I searched commit log to get below commit which
can give a good example.

commit c1d0da83358a2316d9be7f229f26126dbaa07468
Author: Laurent Dufour <ldufour@linux.ibm.com>
Date:   Fri Sep 25 21:19:28 2020 -0700

    mm: replace memmap_context by meminit_context
    
    Patch series "mm: fix memory to node bad links in sysfs", v3.
    
    Sometimes, firmware may expose interleaved memory layout like this:
    
     Early memory node ranges
       node   1: [mem 0x0000000000000000-0x000000011fffffff]
       node   2: [mem 0x0000000120000000-0x000000014fffffff]
       node   1: [mem 0x0000000150000000-0x00000001ffffffff]
       node   0: [mem 0x0000000200000000-0x000000048fffffff]
       node   2: [mem 0x0000000490000000-0x00000007ffffffff]

> 
> 1) the following archs without NUMA support, so it's true for them,
> 
> arch/alpha/mm/init.c:	max_zone_pfn[ZONE_DMA] = dma_pfn;
> arch/arm/mm/init.c:	max_zone_pfn[ZONE_DMA] = min(arm_dma_pfn_limit,
> max_low);
> arch/m68k/mm/init.c:	max_zone_pfn[ZONE_DMA] = end_mem >> PAGE_SHIFT;
> arch/m68k/mm/mcfmmu.c:	max_zone_pfn[ZONE_DMA] = PFN_DOWN(_ramend);
> arch/m68k/mm/motorola.c:	max_zone_pfn[ZONE_DMA] = memblock_end_of_DRAM();
> arch/m68k/mm/sun3mmu.c:	max_zone_pfn[ZONE_DMA] = ((unsigned
> long)high_memory) >> PAGE_SHIFT;
> arch/microblaze/mm/init.c:	zones_size[ZONE_DMA] = max_low_pfn;
> arch/microblaze/mm/init.c:	zones_size[ZONE_DMA] = max_pfn;
> 
> 
> 2) Simple check following archs, it seems that it is yes to them too.
> 
> arch/mips/mm/init.c:	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
> arch/powerpc/mm/mem.c:	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
> arch/s390/mm/init.c:	max_zone_pfns[ZONE_DMA] = PFN_DOWN(MAX_DMA_ADDRESS);
> arch/sparc/mm/srmmu.c:		max_zone_pfn[ZONE_DMA] = max_low_pfn;
> arch/x86/mm/init.c:	max_zone_pfns[ZONE_DMA]		= min(MAX_DMA_PFN,
> max_low_pfn);
> arch/arm64/mm/init.c:	max_zone_pfns[ZONE_DMA] =
> PFN_DOWN(arm64_dma_phys_limit);
> arch/loongarch/mm/init.c:	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
> 

