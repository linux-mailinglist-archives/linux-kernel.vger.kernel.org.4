Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBAA6C1E89
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCTRuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCTRtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:49:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84AE10427;
        Mon, 20 Mar 2023 10:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0B85CCE1268;
        Mon, 20 Mar 2023 17:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88782C433EF;
        Mon, 20 Mar 2023 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679334254;
        bh=6DWJt0rrEq7W4EzAc8pwNUO8xNmHBtl5KZ70f953RzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XC3RVwkxvdJkDzjF8FSRbgTX/PSUM+XlKBbymCh2x+kc97dcQZWohPbBKWgd5cP8d
         0O9+YU98jipjen13c3LbUtk7ozKRRORHvXfQ3zr45yf5uliOOnO15/bd9hSGL7C3wo
         pVi/b5a/yTO6WqOLVDJ/layBzld0e64d4C8gC57eXEkYV9cuf4/dLwDBrlSH4ULJ5c
         kj40KbM5m2dk4osuXVGTIu/4yJ/4yyudUKPf/TuExxSxyM8APjQd+D/LvtRw4IqXeF
         6Xt0J6kq2oHZ2IsV+SmV3PS268168Cru1T55WfD6r51OsVIVTCVmh21/u2ao3HHrWv
         dvYLbYktXlmjA==
Date:   Mon, 20 Mar 2023 19:44:00 +0200
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
Message-ID: <ZBibYDR0h1UeL6L5@kernel.org>
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
 <20230316131711.1284451-3-alexghiti@rivosinc.com>
 <ZBN4Hoo99DNd5wKx@kernel.org>
 <efe1ef6b-b1c2-8d5b-82b7-3cd64053643e@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe1ef6b-b1c2-8d5b-82b7-3cd64053643e@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:54:14AM +0100, Alexandre Ghiti wrote:
> Hi Mike,
> 
> On 3/16/23 21:12, Mike Rapoport wrote:
> > Hi Alexandre,
> > 
> > On Thu, Mar 16, 2023 at 02:17:09PM +0100, Alexandre Ghiti wrote:
> > > This function allows to split a region in memblock.memory and will be
> > > useful when setting up the linear mapping with STRICT_KERNEL_RWX: it
> > > allows to isolate the kernel text/rodata and then avoid to map those
> > > regions with a PUD/P4D/PGD.
> > Sorry I've missed it last time. The changelog is fine in the context of
> 
> 
> No worries :)
> 
> 
> > this series, but if you look at it as a part of memblock changelog it
> > doesn't provide enough background on why memblock_isolate_memory() is
> > useful.
> > 
> > Can you please add more context so it would be self explanatory?
> 
> 
> What about: "memblock.memory contains the list of memory regions and a
> memory region can cover memory that will be mapped with different
> permissions. So to ease the mapping process, allow to isolate those regions
> by introducing a new function called memblock_isolate_memory. This will be
> used in arch specific code to isolate the kernel text/rodata regions when
> STRICT_KERNEL_RWX is enabled so that we avoid mapping them with PUD/P4D/PGD
> mappings."

With this change

... STRICT_KERNEL_RWX is enabled so that they can be mapped with base pages.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> Thanks,
> 
> Alex
> 
> 
> > 
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > Reviewed-by: Anup Patel <anup@brainfault.org>
> > > Tested-by: Anup Patel <anup@brainfault.org>
> > > ---
> > >   include/linux/memblock.h |  1 +
> > >   mm/memblock.c            | 20 ++++++++++++++++++++
> > >   2 files changed, 21 insertions(+)
> > > 
> > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > index 50ad19662a32..2f7ef97c0da7 100644
> > > --- a/include/linux/memblock.h
> > > +++ b/include/linux/memblock.h
> > > @@ -125,6 +125,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
> > >   int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
> > >   int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
> > >   int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
> > > +int memblock_isolate_memory(phys_addr_t base, phys_addr_t size);
> > >   void memblock_free_all(void);
> > >   void memblock_free(void *ptr, size_t size);
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 25fd0626a9e7..e8c651a37012 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -805,6 +805,26 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
> > >   	return 0;
> > >   }
> > > +/**
> > > + * memblock_isolate_memory - isolate given range in memblock.memory
> > > + * @base: base of range to isolate
> > > + * @size: size of range to isolate
> > > + *
> > > + * Isolates the given range in memblock.memory so that it does not share any
> > > + * region with other ranges.
> > > + *
> > > + * Return:
> > > + * 0 on success, -errno on failure.
> > > + */
> > > +
> > > +int __init_memblock memblock_isolate_memory(phys_addr_t base, phys_addr_t size)
> > > +{
> > > +	int start_rgn, end_rgn;
> > > +
> > > +	return memblock_isolate_range(&memblock.memory, base, size,
> > > +				      &start_rgn, &end_rgn);
> > > +}
> > > +
> > >   static int __init_memblock memblock_remove_range(struct memblock_type *type,
> > >   					  phys_addr_t base, phys_addr_t size)
> > >   {
> > > -- 
> > > 2.37.2
> > > 
> 

-- 
Sincerely yours,
Mike.
