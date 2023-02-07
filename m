Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BAC68D12D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBGICy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBGICu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:02:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36EEF80
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:02:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCA54B81707
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61B2C433D2;
        Tue,  7 Feb 2023 08:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675756965;
        bh=m1mY6LHjMtd4mCY+qvpdh/PwbL2CZe7f6wuaufWjflY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V90u/9Vw4oNZBCLorHPSMddd8M1Af8iHu9LoqoQo96JJ2vlviIJhKOSymCMVOuOBO
         EeIQ03d2BeU6yZcJh9wyrveOBk6RbgEB3SCIxAEfgdGnCMuquWJBTM0371e77YgpoK
         KVOsbVrMgeVtcLietDw7bLqQDuqjDSAEwPibCeVAXbIppOpcNqgNifksdnKzQGaTbc
         p5LfITvA33HWdMh/BMqQpgIgnP+LPzyhKnQt142JzQtx11FigkfByV2xHfc5NPuPKk
         aOyIF/u8iiPB13lQUlHvt2tcTXBQJ0IXJBhe6JwvdXGN6t9ppIX+sDZ+IqUeSUWqYL
         f234q7cSCdeMQ==
Date:   Tue, 7 Feb 2023 10:02:32 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Aaron Thompson <dev@aaront.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix memblock_free_late() deferred init bug, redux
Message-ID: <Y+IFmA1FVNRtpEFZ@kernel.org>
References: <20230206071211.3157-1-dev@aaront.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206071211.3157-1-dev@aaront.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On Mon, Feb 06, 2023 at 07:12:09AM +0000, Aaron Thompson wrote:
> Hi Mike,
> 
> Unfortunately my attempted bugfix 115d9d77bb0f ("mm: Always release pages to the
> buddy allocator in memblock_free_late()") is itself buggy. It's true that all
> reserved pages are initialized by the time memblock_free_late() is called, but
> if the pages being freed are in the deferred init range, __free_one_page() might
> access nearby uninitialized pages when trying to coalesce buddies, in which case
> badness ensues :(
> 
> deferred_init_maxorder() handles this by initializing a max-order-sized block of
> pages before freeing any of them. We could change memblock_free_late() to do
> that, but it seems to me that having memblock_free_late() get involved in
> initializing and freeing free pages would be a bit messy. I think it will be
> simpler to free the reserved pages later, as part of deferred init or after.
> 
> I can see a few ways to accomplish that:
> 
> 1. Have memblock_free_late() remove the range from memblock.reserved. Deferred
>    init will then handle that range as just another free range, so the pages
>    will be initialized and freed by deferred_init_maxorder().
> 
>    This is the simplest fix, but the problem is that the pages will be
>    initialized twice, first by memmap_init_reserved_pages() and again by
>    deferred_init_maxorder(). It looks risky to me to blindly zero out an
>    already-initialized page struct, but if we could say for certain that the
>    page structs for memblock-reserved ranges aren't actually used, at least
>    until after deferred init is done, then this could work. I don't know the
>    usage of page structs well enough to say.
> 
> 2. Take 1 and fix the double-init problem. In addition to removing the range
>    from memblock.reserved, also set a flag on the range in memblock.memory that
>    indicates the pages for that range have already been initialized.
>    deferred_init_maxorder() would skip initializing pages for ranges with the
>    flag set, but it would still free them.
> 
>    This seems like a bit of a conceptual stretch of the memblock region flags
>    since this is not a property of the memory itself but rather of the page
>    structs corresponding to that memory. But it gets the job done.
> 
> 3. Defer the freeing of reserved pages until after deferred init is completely
>    done. Have memblock_free_late() set a flag on the range in memblock.reserved,
>    and have memblock_discard() call __free_pages_core() on those ranges.
> 
>    I think this would be a reasonable use of flags on reserved regions. They are
>    not currently used.

I think 3 is the most straight-forward as a concept. It'll need some care
for ARCH_KEEP_MEMBLOCK architectures, e.g. arm64, though

I also can think about

4. Extend initialization of the memory map around the reserved regions in
memmap_init_reserved_pages()/reserve_bootmem_region(). If these functions
initialize the memory map of the entire pageblock surrounding the reserved
range, __free_one_page() will certainly access initialized struct pages.
 
> The included patch implements option 1 because it is the simplest, but it should
> not be used if the double-init of the page structs is unsafe. In my testing I
> verified that the count, mapcount, and lru list head of all pages are at their
> defaults when memblock_free_late() is called by efi_free_boot_services(), but
> that's obviously not conclusive. I have draft versions of 2 and 3 that I can
> finish up quickly if either of those are preferable.

At this point of the release cycle I prefer to revert 115d9d77bb0f ("mm:
Always release pages to the buddy allocator in memblock_free_late()") and
to work on the proper fix for the next release.
 
> Please let me know what you think, and sorry for introducing this bug.
> 
> Thanks,
> Aaron
> 
> Aaron Thompson (1):
>   mm: Defer freeing reserved pages in memblock_free_late()
> 
>  mm/internal.h                     |  2 ++
>  mm/memblock.c                     | 36 ++++++++++++++++++++-----------
>  mm/page_alloc.c                   | 17 +++++++++++++++
>  tools/testing/memblock/internal.h |  7 +++---
>  4 files changed, 47 insertions(+), 15 deletions(-)
> 
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
