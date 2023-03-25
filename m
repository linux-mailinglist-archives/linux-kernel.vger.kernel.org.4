Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4A6C8B35
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCYGCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCYGCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:02:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CEC19697
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA239B82437
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC746C433D2;
        Sat, 25 Mar 2023 06:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679724145;
        bh=Rm5cs/yD0VtyU6KhTA35Om5SsVQpAHv9hH3/NHRCp/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4GsbOChMjBs+cc6q/siXf+TIpqHSXAP4PhF5b3RctdQLqfhSBXZIjGjaYbR1gqIO
         Fvoyeu28I30ITId8AlXRmsDo+Yad3QrVVGWACLTYYL7Q3Sy5U8IjAhh4vwxhmx3RFz
         DwBqZF/R62NeydzttDCSvUAzM6VZV+gjEKljw5jcBCZR8mhj2ydWSCeiEGCC3AhpOi
         Y9YlMuH528884ZqUlXHk5f9ovfP95Xue443SNJ3dyjubxNOleI/X3tjTjOI3Ef2Gh3
         couRbkuD5vnFweX+PBAl3tLptvNVJDrih9blzTaTOSyKJ9RUDrZgkb9kGKxniAwvsa
         Fvxq+xyPz5mXQ==
Date:   Sat, 25 Mar 2023 09:02:10 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        horms@kernel.org, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, will@kernel.org,
        kexec@lists.infradead.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64: kdump : take off the protection on
 crashkernel memory region
Message-ID: <ZB6OYjP5ODkSwaUx@kernel.org>
References: <20230324131838.409996-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324131838.409996-1-bhe@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:18:35PM +0800, Baoquan He wrote:
> Problem:
> =======
> On arm64, block and section mapping is supported to build page tables.
> However, currently it enforces to take base page mapping for the whole
> linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
> crashkernel kernel parameter is set. This will cause longer time of the
> linear mapping process during bootup and severe performance degradation
> during running time.
> 
> Root cause:
> ==========
> On arm64, crashkernel reservation relies on knowing the upper limit of
> low memory zone because it needs to reserve memory in the zone so that
> devices' DMA addressing in kdump kernel can be satisfied. However, the
> upper limit of low memory on arm64 is variant. And the upper limit can
> only be decided late till bootmem_init() is called [1].
> 
> And we need to map the crashkernel region with base page granularity when
> doing linear mapping, because kdump needs to protect the crashkernel region
> via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
> support well on splitting the built block or section mapping due to some
> cpu reststriction [2]. And unfortunately, the linear mapping is done before
> bootmem_init().
> 
> To resolve the above conflict on arm64, the compromise is enforcing to
> take base page mapping for the entire linear mapping if crashkernel is
> set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
> performance is sacrificed.
> 
> Solution:
> =========
> Comparing with the always encountered base page mapping for the whole
> linear region, it's better to take off the protection on crashkernel memory
> region for now because the protection can only happen in a chance in one
> million, while the base page mapping for the whole linear mapping is
> always mitigating arm64 systems with crashkernel set.
> 
> This can let distros have chance to back port this patchset to fix the
> performance issue caused by the base page mapping in the whole linear
> region.
> 
> Extra words
> ===========
> I personally expect that  we can add these back in the near future
> when arm64_dma_phys_limit is fixed, e.g Raspberry Pi enlarges the device
> addressing limit to 32bit; or Arm64 can support splitting built block or
> section mapping. Like this, the code is the simplest and clearest.
> 
> Or as Catalin suggested, for below 4 cases we currently defer to handle
> in bootme_init(), we can try to handle case 3) in advance so that memory
> above 4G can avoid base page mapping wholly. This will complicate the
> already complex code, let's see how it looks if people interested post patch.
> 
> crashkernel=size
> 1)first attempt:  low memory under arm64_dma_phys_limit
> 2)fallback:       finding memory above 4G
> 
> crashkernel=size,high
> 3)first attempt:  finding memory above 4G
> 4)fallback:       low memory under arm64_dma_phys_limit
> 
> 
> [1]
> https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u
> 
> [2]
> https://lore.kernel.org/linux-arm-kernel/20190911182546.17094-1-nsaenzjulienne@suse.de/T/
> 
> Baoquan He (3):
>   arm64: kdump : take off the protection on crashkernel memory region
>   arm64: kdump: do not map crashkernel region specifically
>   arm64: kdump: defer the crashkernel reservation for platforms with no
>     DMA memory zones
> 
>  arch/arm64/include/asm/kexec.h    |  6 -----
>  arch/arm64/include/asm/memory.h   |  5 ----
>  arch/arm64/kernel/machine_kexec.c | 20 --------------
>  arch/arm64/mm/init.c              |  6 +----
>  arch/arm64/mm/mmu.c               | 43 -------------------------------
>  5 files changed, 1 insertion(+), 79 deletions(-)

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
