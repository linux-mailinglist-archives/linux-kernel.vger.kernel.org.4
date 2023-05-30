Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF471537A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjE3CLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjE3CK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:10:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4A1F1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:10:55 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QVbNS2DTgzqTTd;
        Tue, 30 May 2023 10:06:16 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 10:10:53 +0800
Message-ID: <38ea4ea3-cd7f-abf4-e992-2f748e3b1fcb@huawei.com>
Date:   Tue, 30 May 2023 10:10:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH -next] mm: page_alloc: simplify has_managed_dma()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Mike Rapoport <rppt@kernel.org>
References: <20230529144022.42927-1-wangkefeng.wang@huawei.com>
 <ZHS2AgVvrT3n/hlM@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZHS2AgVvrT3n/hlM@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/29 22:26, Matthew Wilcox wrote:
> On Mon, May 29, 2023 at 10:40:22PM +0800, Kefeng Wang wrote:
>> The ZONE_DMA should only exists on Node 0, only check NODE_DATA(0)
>> is enough, so simplify has_managed_dma() and make it inline.
> 
> That's true on x86, but is it true on all architectures?

There is no document about numa node info for the DMA_ZONE, + Mike

I used 'git grep -w ZONE_DMA arch/'

1) the following archs without NUMA support, so it's true for them,

arch/alpha/mm/init.c:	max_zone_pfn[ZONE_DMA] = dma_pfn;
arch/arm/mm/init.c:	max_zone_pfn[ZONE_DMA] = min(arm_dma_pfn_limit, 
max_low);
arch/m68k/mm/init.c:	max_zone_pfn[ZONE_DMA] = end_mem >> PAGE_SHIFT;
arch/m68k/mm/mcfmmu.c:	max_zone_pfn[ZONE_DMA] = PFN_DOWN(_ramend);
arch/m68k/mm/motorola.c:	max_zone_pfn[ZONE_DMA] = memblock_end_of_DRAM();
arch/m68k/mm/sun3mmu.c:	max_zone_pfn[ZONE_DMA] = ((unsigned 
long)high_memory) >> PAGE_SHIFT;
arch/microblaze/mm/init.c:	zones_size[ZONE_DMA] = max_low_pfn;
arch/microblaze/mm/init.c:	zones_size[ZONE_DMA] = max_pfn;


2) Simple check following archs, it seems that it is yes to them too.

arch/mips/mm/init.c:	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
arch/powerpc/mm/mem.c:	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
arch/s390/mm/init.c:	max_zone_pfns[ZONE_DMA] = PFN_DOWN(MAX_DMA_ADDRESS);
arch/sparc/mm/srmmu.c:		max_zone_pfn[ZONE_DMA] = max_low_pfn;
arch/x86/mm/init.c:	max_zone_pfns[ZONE_DMA]		= min(MAX_DMA_PFN, 
max_low_pfn);
arch/arm64/mm/init.c:	max_zone_pfns[ZONE_DMA] = 
PFN_DOWN(arm64_dma_phys_limit);
arch/loongarch/mm/init.c:	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;

