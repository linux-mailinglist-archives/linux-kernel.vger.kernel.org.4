Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78A25BDEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiITHzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiITHz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:55:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B062DFA;
        Tue, 20 Sep 2022 00:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H0mXB3qLzd6nyp4U82pUC+0jG9YRP9G0sb9CuKu7rQc=; b=YCkxzsVunikesQe2vmc4oMq2Hn
        Jg33iFWFuD4QHdvq6fDWy8Z3gojgL0RTxp2wHVG11PD9SGiG94LnDwCfM0D5ZbFKC//BwQb83f5kt
        KwsNLeOUgUUU3MHlb6KJoYbFbSJuTfGC5UEoEajTXpzQIwfGeW85tyLb7xxH/Ao7q2EwK2BNuzYWc
        aNL14xoXbcw6ZY0YsF3QsrggrY8mOuwt3JZRUErGulwoWldPYHn9QdDr2suz3ZVXuunT+RoLnvWlg
        xDYTJiVsEp/MPK7zZcEyW9nsCtWowlraCvfA3e1XhM3BAyuqxe7ilU6LfUtfHbB5iLnEj7CYeZdr3
        XHziMGFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaY5v-001WMi-Uv; Tue, 20 Sep 2022 07:55:04 +0000
Date:   Tue, 20 Sep 2022 00:55:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     iommu@lists.linux.dev, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        sstabellini@kernel.org, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, jgross@suse.com,
        boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com,
        m.szyprowski@samsung.com, konrad.wilk@oracle.com,
        robin.murphy@arm.com, hpa@zytor.com, oleksandr_tyshchenko@epam.com,
        joe.jin@oracle.com
Subject: Re: [PATCH RFC v2 1/1] wiotlb: split buffer into 32-bit default and
 64-bit extra zones
Message-ID: <Yylx1xPdEbq3k4v1@infradead.org>
References: <20220820074250.5460-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820074250.5460-1-dongli.zhang@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 12:42:50AM -0700, Dongli Zhang wrote:
> Hello,
> 
> I used to send out RFC v1 to introduce an extra io_tlb_mem (created with
> SWIOTLB_ANY) in addition to the default io_tlb_mem (32-bit).  The
> dev->dma_io_tlb_mem is set to either default or the extra io_tlb_mem,
> depending on dma mask. However, that is not good for setting
> dev->dma_io_tlb_mem at swiotlb layer transparently as suggested by
> Christoph Hellwig.
> 
> https://lore.kernel.org/all/20220609005553.30954-1-dongli.zhang@oracle.com/
> 
> Therefore, this is another RFC v2 implementation following a different
> direction. The core ideas are:
> 
> 1. The swiotlb is splited into two zones, io_tlb_mem->zone[0] (32-bit) and
> io_tlb_mem->zone[1] (64-bit).
> 
> struct io_tlb_mem {
> 	struct io_tlb_zone zone[SWIOTLB_NR];
> 	struct dentry *debugfs;
> 	bool late_alloc;
> 	bool force_bounce;
> 	bool for_alloc;
> 	bool has_extra;
> };
> 
> struct io_tlb_zone {
> 	phys_addr_t start;
> 	phys_addr_t end;
> 	void *vaddr;
> 	unsigned long nslabs;
> 	unsigned long used;
> 	unsigned int nareas;
> 	unsigned int area_nslabs;
> 	struct io_tlb_area *areas;
> 	struct io_tlb_slot *slots;
> };
> 
> 2. By default, only io_tlb_mem->zone[0] is available. The
> io_tlb_mem->zone[1] is allocated conditionally if:
> 
> - the "swiotlb=" is configured to allocate extra buffer, and
> - the SWIOTLB_EXTRA is set in the flag (this is to make sure arch(s) other
>   than x86/sev/xen will not enable it until it is fully tested by each
>   arch, e.g., mips/powerpc). Currently it is enabled for x86 and xen.
> 
> 3. During swiotlb map, whether zone[0] (32-bit) or zone[1] (64-bit
> SWIOTLB_ANY)
> is used depends on min_not_zero(*dev->dma_mask, dev->bus_dma_limit).
> 
> To test the RFC v2, here is the QEMU command line.
> 
> qemu-system-x86_64 -smp 8 -m 32G -enable-kvm -vnc :5 -hda disk.img \
> -kernel path-to-linux/arch/x86_64/boot/bzImage \
> -append "root=/dev/sda1 init=/sbin/init text console=ttyS0 loglevel=7 swiotlb=32768,4194304,force" \
> -net nic -net user,hostfwd=tcp::5025-:22 \
> -device nvme,drive=nvme01,serial=helloworld -drive file=test.qcow2,if=none,id=nvme01 \
> -serial stdio
> 
> There is below in syslog. The extra 8GB buffer is allocated.
> 
> [    0.152251] software IO TLB: area num 8.
> ... ...
> [    3.706088] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    3.707334] software IO TLB: mapped default [mem 0x00000000bbfd7000-0x00000000bffd7000] (64MB)
> [    3.708585] software IO TLB: mapped extra [mem 0x000000061cc00000-0x000000081cc00000] (8192MB)
> 
> After the FIO is triggered over NVMe, the 64-bit buffer is used.
> 
> $ cat /sys/kernel/debug/swiotlb/io_tlb_nslabs_extra
> 4194304
> $ cat /sys/kernel/debug/swiotlb/io_tlb_used_extra
> 327552
> 
> Would you mind helping if this is the right direction to go?
> 
> Thank you very much!
> 
> Cc: Konrad Wilk <konrad.wilk@oracle.com>
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  arch/arm/xen/mm.c                      |   2 +-
>  arch/mips/pci/pci-octeon.c             |   5 +-
>  arch/x86/include/asm/xen/swiotlb-xen.h |   2 +-
>  arch/x86/kernel/pci-dma.c              |   6 +-
>  drivers/xen/swiotlb-xen.c              |  18 +-
>  include/linux/swiotlb.h                |  73 +++--

> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 3d826c0..4edfa42 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -125,7 +125,7 @@ static int __init xen_mm_init(void)
>  		return 0;
>  
>  	/* we can work with the default swiotlb */
> -	if (!io_tlb_default_mem.nslabs) {
> +	if (!io_tlb_default_mem.zone[SWIOTLB_DF].nslabs) {
>  		rc = swiotlb_init_late(swiotlb_size_or_default(),
>  				       xen_swiotlb_gfp(), NULL);
>  		if (rc < 0)

First thing we need before doing anything about multiple default
pools is to get all the knowledge of details hidden inside swiotlb.c.

For swiotlb_init_late that seems easy as we can just move the check
into it.

> diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
> index e457a18..0bf0859 100644
> --- a/arch/mips/pci/pci-octeon.c
> +++ b/arch/mips/pci/pci-octeon.c
> @@ -654,6 +654,9 @@ static int __init octeon_pci_setup(void)
>  		octeon_pci_mem_resource.end =
>  			octeon_pci_mem_resource.start + (1ul << 30);
>  	} else {
> +		struct io_tlb_mem *mem = &io_tlb_default_mem;
> +		struct io_tlb_zone *zone = &mem->zone[SWIOTLB_DF];
> +
>  		/* Remap the Octeon BAR 0 to map 128MB-(128MB+4KB) */
>  		octeon_npi_write32(CVMX_NPI_PCI_CFG04, 128ul << 20);
>  		octeon_npi_write32(CVMX_NPI_PCI_CFG05, 0);
> @@ -664,7 +667,7 @@ static int __init octeon_pci_setup(void)
>  
>  		/* BAR1 movable regions contiguous to cover the swiotlb */
>  		octeon_bar1_pci_phys =
> -			io_tlb_default_mem.start & ~((1ull << 22) - 1);
> +			zone->start & ~((1ull << 22) - 1);

But we'll need to do something about this mess.  I'll need help from
the octeon maintainer on it.

> -	x86_swiotlb_flags |= SWIOTLB_ANY;
> +	x86_swiotlb_flags |= SWIOTLB_ANY | SWIOTLB_EXTRA;

I don't think this is how it is suppoed to be.  SWIOTLB_ANY already
says give me a pool with no addressing constrains.  We don't need
two pools without that.  EXTRA is also not exactly a very helpful
name here.

>  #ifdef CONFIG_X86
> -int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
> +int xen_swiotlb_fixup(void *buf, unsigned long nslabs, unsigned int flags)
>  {
>  	int rc;
>  	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);
>  	unsigned int i, dma_bits = order + PAGE_SHIFT;
>  	dma_addr_t dma_handle;
>  	phys_addr_t p = virt_to_phys(buf);
> +	unsigned int max_dma_bits = 32;

I think live will be a lot simple if the addressing bits are passed to
this function, and not some kind of flags.

> +#define SWIOTLB_DF	0
> +#define SWIOTLB_EX	1
> +#define SWIOTLB_NR	2

These names are not very descriptive.
