Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B099874ADCA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjGGJ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGGJ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:29:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443D81FED;
        Fri,  7 Jul 2023 02:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C992D618DF;
        Fri,  7 Jul 2023 09:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469D0C433C7;
        Fri,  7 Jul 2023 09:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688722151;
        bh=TiVqgBQxOT3C3TBkmM/c7nKqqaoif0rl2+UYbMz3sqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyuLd0FCJEQhqnrVpquSVLKc/9uI0i7rdMICm0QZElUzRmgl1WAypdZRf644WG5w6
         wVwwOe7uTbd6a5um1d6z2qgLJrXKCpq1rXMHNpxh0jP21HzLgs6LU7p19zMbzFotb4
         nJtjTSe2HVhiChBbqKoLsix3YSP7/IVd7wy0lWd4=
Date:   Fri, 7 Jul 2023 10:29:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        "moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "petr@tesarici.cz" <petr@tesarici.cz>
Subject: Re: [PATCH v3 4/7] swiotlb: if swiotlb is full, fall back to a
 transient memory pool
Message-ID: <2023070706-humbling-starfish-c68f@gregkh>
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
 <34c2a1ba721a7bc496128aac5e20724e4077f1ab.1687859323.git.petr.tesarik.ext@huawei.com>
 <BYAPR21MB1688AAC65852E75764F53099D72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <2023070626-boxcar-bubbly-471d@gregkh>
 <BYAPR21MB168802F691D3041C9B2F9F2DD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168802F691D3041C9B2F9F2DD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 02:22:50PM +0000, Michael Kelley (LINUX) wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org> Sent: Thursday, July 6, 2023 1:07 AM
> > 
> > On Thu, Jul 06, 2023 at 03:50:55AM +0000, Michael Kelley (LINUX) wrote:
> > > From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Tuesday, June 27, 2023
> > 2:54 AM
> > > >
> > > > Try to allocate a transient memory pool if no suitable slots can be found,
> > > > except when allocating from a restricted pool. The transient pool is just
> > > > enough big for this one bounce buffer. It is inserted into a per-device
> > > > list of transient memory pools, and it is freed again when the bounce
> > > > buffer is unmapped.
> > > >
> > > > Transient memory pools are kept in an RCU list. A memory barrier is
> > > > required after adding a new entry, because any address within a transient
> > > > buffer must be immediately recognized as belonging to the SWIOTLB, even if
> > > > it is passed to another CPU.
> > > >
> > > > Deletion does not require any synchronization beyond RCU ordering
> > > > guarantees. After a buffer is unmapped, its physical addresses may no
> > > > longer be passed to the DMA API, so the memory range of the corresponding
> > > > stale entry in the RCU list never matches. If the memory range gets
> > > > allocated again, then it happens only after a RCU quiescent state.
> > > >
> > > > Since bounce buffers can now be allocated from different pools, add a
> > > > parameter to swiotlb_alloc_pool() to let the caller know which memory pool
> > > > is used. Add swiotlb_find_pool() to find the memory pool corresponding to
> > > > an address. This function is now also used by is_swiotlb_buffer(), because
> > > > a simple boundary check is no longer sufficient.
> > > >
> > > > The logic in swiotlb_alloc_tlb() is taken from __dma_direct_alloc_pages(),
> > > > simplified and enhanced to use coherent memory pools if needed.
> > > >
> > > > Note that this is not the most efficient way to provide a bounce buffer,
> > > > but when a DMA buffer can't be mapped, something may (and will) actually
> > > > break. At that point it is better to make an allocation, even if it may be
> > > > an expensive operation.
> > >
> > > I continue to think about swiotlb memory management from the standpoint
> > > of CoCo VMs that may be quite large with high network and storage loads.
> > > These VMs are often running mission-critical workloads that can't tolerate
> > > a bounce buffer allocation failure.  To prevent such failures, the swiotlb
> > > memory size must be overly large, which wastes memory.
> > 
> > If "mission critical workloads" are in a vm that allowes overcommit and
> > no control over other vms in that same system, then you have worse
> > problems, sorry.
> > 
> > Just don't do that.
> > 
> 
> No, the cases I'm concerned about don't involve memory overcommit.
> 
> CoCo VMs must use swiotlb bounce buffers to do DMA I/O.  Current swiotlb
> code in the Linux guest allocates a configurable, but fixed, amount of guest
> memory at boot time for this purpose.  But it's hard to know how much
> swiotlb bounce buffer memory will be needed to handle peak I/O loads.
> This patch set does dynamic allocation of swiotlb bounce buffer memory,
> which can help avoid needing to configure an overly large fixed size at boot.

But, as you point out, memory allocation can fail at runtime, so how can
you "guarantee" that this will work properly anymore if you are going to
make it dynamic?

confused,

greg k-h
