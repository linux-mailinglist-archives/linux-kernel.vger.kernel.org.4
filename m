Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ABB738957
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjFUPeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjFUPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C660A99
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5859E6159B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F6CC433C8;
        Wed, 21 Jun 2023 15:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687361625;
        bh=RBBHaTEeXaEDjmpOS3S5lkjDgXoLmDvyKlks+2J3yS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JPZO7S47WqWQdmhICNHVqNbb8pw60Py4BPi10Ph8/Y+dkDgtr9jou5f/VwUy/OAc/
         c58F3fg6w/APhks+WeT3aVSwWKPHvi20KY75m3D+8+N8ch7nycZM9zMKW4pPkl70tl
         /jijq2AOO/cDfBvcVe03wMdkltLpgGRxQPzQAvH+je1mM1ovm2zSA0FIY4z3nVjTyI
         j+GWI+AHIsRY2NYZ8CNTljdJ9mogHyNRHg4oz9m0E1BKRmfPQHFXnIP9JfBKbQ5+ML
         g1q6OyMkFuv6BLpt2YwKfVymS2+0z52r/RDk367uwv6THhStdIO/lS5MeSaJehSMOe
         Xsvv1M2KPjGxg==
Date:   Wed, 21 Jun 2023 18:33:05 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Add error message when memblock_can_resize is
 not ready
Message-ID: <20230621153305.GF52412@kernel.org>
References: <20230614131746.3670303-1-songshuaishuai@tinylab.org>
 <20230614160710.GH52412@kernel.org>
 <6EA2B512AB4F2017+9d56e9b9-a875-9799-147b-1c8adc693507@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6EA2B512AB4F2017+9d56e9b9-a875-9799-147b-1c8adc693507@tinylab.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 03:04:55PM +0800, Song Shuai wrote:
> Sorry for not replying to you in time
> 
> 在 2023/6/15 00:07, Mike Rapoport 写道:
> > Hi,
> > 
> > On Wed, Jun 14, 2023 at 09:17:46PM +0800, Song Shuai wrote:
> > > The memblock APIs are always correct, thus the callers usually don't
> > > handle the return code. But the failure caused by unready memblock_can_resize
> > > is hard to recognize without the return code. Like this piece of log:
> > 
> > Please make it clear that failure is in memblock_double_array(), e.g.
> > 
> 
> Having numerous memblock reservations at early boot where
> memblock_can_resize is unset
> may exhaust the INIT_MEMBLOCK_REGIONS sized memblock.reserved regions and
> try to
> double the region array via memblock_double_array() which fails and returns
> -1 to the caller.
> 
> You can find the numerous memblock reservations reported by this commit
> 24cc61d8cb5a ("arm64: memblock: don't permit memblock resizing until linear
> mapping is up").
> And the similar test sense can be simulated by a constructed dtb with
> numerous discrete
> /memreserve/ or /reserved-memory regions.

Ideally, the callers of memblock_reserve() should check the return value
and panic with a meaningful message if it fails. Still, for now something
like this patch is an improvement.
 
How about we make the changelog to be something like:

Subject: memblock: report failures when memblock_can_resize is not set

The callers of memblock_reserve() do not check the return value presuming
that memblock_reserve() always succeeds, but there are cases where it may
fail.

Having numerous memblock reservations at early boot where
memblock_can_resize is unset may exhaust the INIT_MEMBLOCK_REGIONS sized
memblock.reserved regions array and an attempt to double this array via
memblock_double_array() will fail and will return -1 to the caller.

When this happens the system crashes anyway, but it's hard to identify the
reason for the crash.

Add a panic message to memblock_double_array() to aid debugging of the
cases when too many regions are reserved before memblock can resize
memblock.reserved array.

> > But when memblock_double_array() is called before memblock_can_resize
> > is true, it is hard to understand the actual reason for the failure.
> > 
> > > 
> > > ```
> > > [    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pmd_fixmap+0x14/0x1c
> > > [    0.000000] memblock_reserve: [0x000000017ffff000-0x000000017fffffff] memblock_alloc_range_nid+0xb8/0x128
> > > [    0.000000] Oops - store (or AMO) access fault [#1]
> > > ```
> > > 
> > > So add an error message for this kind of failure:
> > > 
> > > ```
> > > [    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pmd_fixmap+0x14/0x1c
> > > [    0.000000] memblock_reserve: [0x000000017ffff000-0x000000017fffffff] memblock_alloc_range_nid+0xb8/0x128
> > > [    0.000000] memblock: Can't double reserved array for area start 0x000000017ffff000 size 4096
> > > [    0.000000] Oops - store (or AMO) access fault [#1]
> > > ```
> > > 
> > > Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> > > ---
> > >   mm/memblock.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 3feafea06ab2..ab952a164f62 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -418,8 +418,11 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
> > >   	/* We don't allow resizing until we know about the reserved regions
> > >   	 * of memory that aren't suitable for allocation
> > >   	 */
> > > -	if (!memblock_can_resize)
> > > +	if (!memblock_can_resize) {
> > > +		pr_err("memblock: Can't double %s array for area start %pa size %ld\n",
> > > +			type->name, &new_area_start, (unsigned long)new_area_size);

The system will crash anyway if we get, here, so why won't use panic?
Also, dumping new_area_start here does not add any information but rather
confuses. How about

	panic("memblock: cannot resize %s array\n", type->name);

> > 
> > Most of the time memblock uses %llu and cast to u64 to print size, please
> > make this consistent.
> I will fix it in next version if the above description is ok for you.
> > 
> > >   		return -1;
> > > +	}
> > >   	/* Calculate new doubled size */
> > >   	old_size = type->max * sizeof(struct memblock_region);
> 
> -- 
> Thanks
> Song Shuai
> 
> 

-- 
Sincerely yours,
Mike.
