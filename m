Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6866C67F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCWMRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjCWMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:17:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEE32748A;
        Thu, 23 Mar 2023 05:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5252D6265E;
        Thu, 23 Mar 2023 12:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A110FC433D2;
        Thu, 23 Mar 2023 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679573788;
        bh=8YTL8vaeuBpq0vMMQ/pbSHbLP5F5De7OWHvSO64jqWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDgklDt8UIydy52o7p+cvl9EhYSRXBlx8yDr0RpdwchOpAWt6GwNdHG/NBGCmELJV
         Uql/fyfzD0OL9HkOe/Ms1uxy6JSV5qRIFuevWhqnixbnOo43OLrxQ5N95RM1eq3K9j
         5+Ku2OpjWJxdiAkdfmdbx3w1fpTxA5j4wVZXbpkZX1/cXch1PeVuxJJjQQ6dV+76Y0
         zjDfQ7yiArDoR6s/YPeV/52Gbes/HR4ZXY5pO+ID4bBnkvaG+QmC/XzexzI1XSOrqV
         M6TX9FtCCqI/IlT4JR8TeV9DkaQRsifWQ92K/J06fytFjYUkmp/nxzywNO1E6RT9t8
         GjueaLrm8T/GQ==
Date:   Thu, 23 Mar 2023 14:16:12 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 2/4] mm: Introduce memblock_isolate_memory
Message-ID: <ZBxDDPnldPIgKngc@kernel.org>
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
 <20230316131711.1284451-3-alexghiti@rivosinc.com>
 <ZBN4Hoo99DNd5wKx@kernel.org>
 <efe1ef6b-b1c2-8d5b-82b7-3cd64053643e@ghiti.fr>
 <ZBibYDR0h1UeL6L5@kernel.org>
 <67ba29ff-b03d-2d24-a844-7ae25ddca447@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ba29ff-b03d-2d24-a844-7ae25ddca447@ghiti.fr>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:52:36PM +0100, Alexandre Ghiti wrote:
> 
> On 3/20/23 18:44, Mike Rapoport wrote:
> > On Mon, Mar 20, 2023 at 11:54:14AM +0100, Alexandre Ghiti wrote:
> > > Hi Mike,
> > > 
> > > On 3/16/23 21:12, Mike Rapoport wrote:
> > > > Hi Alexandre,
> > > > 
> > > > On Thu, Mar 16, 2023 at 02:17:09PM +0100, Alexandre Ghiti wrote:
> > > > > This function allows to split a region in memblock.memory and will be
> > > > > useful when setting up the linear mapping with STRICT_KERNEL_RWX: it
> > > > > allows to isolate the kernel text/rodata and then avoid to map those
> > > > > regions with a PUD/P4D/PGD.
> > > > Sorry I've missed it last time. The changelog is fine in the context of
> > > 
> > > No worries :)
> > > 
> > > 
> > > > this series, but if you look at it as a part of memblock changelog it
> > > > doesn't provide enough background on why memblock_isolate_memory() is
> > > > useful.
> > > > 
> > > > Can you please add more context so it would be self explanatory?
> > > 
> > > What about: "memblock.memory contains the list of memory regions and a
> > > memory region can cover memory that will be mapped with different
> > > permissions. So to ease the mapping process, allow to isolate those regions
> > > by introducing a new function called memblock_isolate_memory. This will be
> > > used in arch specific code to isolate the kernel text/rodata regions when
> > > STRICT_KERNEL_RWX is enabled so that we avoid mapping them with PUD/P4D/PGD
> > > mappings."
> > With this change
> > 
> > ... STRICT_KERNEL_RWX is enabled so that they can be mapped with base pages.
> 
> 
> Actually they will get mapped with PMD mappings :) I'll just append: "or PMD
> mapping" to your sentence above if that's ok with you.

Didn't read the rest of the patches :)

.. STRICT_KERNEL_RWX is enabled so that they can be mapped with differently
than the rest of the memory.

Does it cover the usescases?

> > 
> > Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> 
> 
> Thanks for your review,
> 
> Alex
> 
> 
> > 
> > > Thanks,
> > > 
> > > Alex
> > > 
> > > 
> > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > Reviewed-by: Anup Patel <anup@brainfault.org>
> > > > > Tested-by: Anup Patel <anup@brainfault.org>
> > > > > ---
> > > > >    include/linux/memblock.h |  1 +
> > > > >    mm/memblock.c            | 20 ++++++++++++++++++++
> > > > >    2 files changed, 21 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > > > index 50ad19662a32..2f7ef97c0da7 100644
> > > > > --- a/include/linux/memblock.h
> > > > > +++ b/include/linux/memblock.h
> > > > > @@ -125,6 +125,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
> > > > >    int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
> > > > >    int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
> > > > >    int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
> > > > > +int memblock_isolate_memory(phys_addr_t base, phys_addr_t size);
> > > > >    void memblock_free_all(void);
> > > > >    void memblock_free(void *ptr, size_t size);
> > > > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > > > index 25fd0626a9e7..e8c651a37012 100644
> > > > > --- a/mm/memblock.c
> > > > > +++ b/mm/memblock.c
> > > > > @@ -805,6 +805,26 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
> > > > >    	return 0;
> > > > >    }
> > > > > +/**
> > > > > + * memblock_isolate_memory - isolate given range in memblock.memory
> > > > > + * @base: base of range to isolate
> > > > > + * @size: size of range to isolate
> > > > > + *
> > > > > + * Isolates the given range in memblock.memory so that it does not share any
> > > > > + * region with other ranges.
> > > > > + *
> > > > > + * Return:
> > > > > + * 0 on success, -errno on failure.
> > > > > + */
> > > > > +
> > > > > +int __init_memblock memblock_isolate_memory(phys_addr_t base, phys_addr_t size)
> > > > > +{
> > > > > +	int start_rgn, end_rgn;
> > > > > +
> > > > > +	return memblock_isolate_range(&memblock.memory, base, size,
> > > > > +				      &start_rgn, &end_rgn);
> > > > > +}
> > > > > +
> > > > >    static int __init_memblock memblock_remove_range(struct memblock_type *type,
> > > > >    					  phys_addr_t base, phys_addr_t size)
> > > > >    {
> > > > > -- 
> > > > > 2.37.2
> > > > > 

-- 
Sincerely yours,
Mike.
