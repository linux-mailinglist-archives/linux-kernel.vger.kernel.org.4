Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EA76894CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjBCKKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjBCKKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:10:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AAB3B657
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:10:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE4D61E6E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8797BC4339B;
        Fri,  3 Feb 2023 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675419030;
        bh=MkeyM1pf1E87Sjf13zOYblh7VwWTB+aRBJGK3IdoD3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gndm3jVVo6DNVeMZo4teOouitAnfSFlZmnYL2Im5CK+9ePSIY00o1b8g8NsQDEIsj
         t9xMolt/Ouwk0y+9/P50LbuhoPhXfk2G72w3EVVKqnxSoK8XAlNhLIUNxGP7NVyKyg
         wzRS4T0WeGaF7TibtoxbjrAQMt9sW+OawzCvPvyxzA4mZz9DV7TaXfKwCDUiGJf2mY
         CS4h216toTLaE7ySHED2AiI8PNNpYr1ebJtmNenGJjfb7nBQpxsrBF1VkbxtpYI02L
         thRQ36MFL0H9wZQyyngy4tEB+Ws8M4lMbLbX1ShZ9L09LuOKGwynuY9+c3vh4roLrR
         QgMFd/LKzUSMg==
Date:   Fri, 3 Feb 2023 10:10:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
Message-ID: <20230203101023.GA5597@willie-the-truck>
References: <20230109052816.405335-1-anshuman.khandual@arm.com>
 <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
 <20230126133321.GB29148@willie-the-truck>
 <d454c9a2-5300-b600-a2ae-21d82d338470@arm.com>
 <20230131154950.GB2646@willie-the-truck>
 <Y9pZALdn3pKiJUeQ@arm.com>
 <A8DF7D56-C145-4B49-A034-022917B87C89@linux.dev>
 <Y9uUO9AadE+8ik/0@arm.com>
 <F10F1618-7153-41C7-A475-522D833C41D4@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F10F1618-7153-41C7-A475-522D833C41D4@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 10:40:18AM +0800, Muchun Song wrote:
> 
> 
> > On Feb 2, 2023, at 18:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > On Thu, Feb 02, 2023 at 05:51:39PM +0800, Muchun Song wrote:
> >>> On Feb 1, 2023, at 20:20, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>>> Bah, sorry! Catalin reckons it may have been him talking about the vmemmap.
> >>> 
> >>> Indeed. The discussion with Anshuman started from this thread:
> >>> 
> >>> https://lore.kernel.org/all/20221025014215.3466904-1-mawupeng1@huawei.com/
> >>> 
> >>> We already trip over the existing checks even without Anshuman's patch,
> >>> though only by chance. We are not setting the software PTE_DIRTY on the
> >>> new pte (we don't bother with this bit for kernel mappings).
> >>> 
> >>> Given that the vmemmap ptes are still live when such change happens and
> >>> no-one came with a solution to the break-before-make problem, I propose
> >>> we revert the arm64 part of commit 47010c040dec ("mm: hugetlb_vmemmap:
> >>> cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*"). We just need this hunk:
> >>> 
> >>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >>> index 27b2592698b0..5263454a5794 100644
> >>> --- a/arch/arm64/Kconfig
> >>> +++ b/arch/arm64/Kconfig
> >>> @@ -100,7 +100,6 @@ config ARM64
> >>> select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> >>> select ARCH_WANT_FRAME_POINTERS
> >>> select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> >>> - select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >> 
> >> Maybe it is a little overkill for HVO as it can significantly minimize the
> >> overhead of vmemmap on ARM64 servers for some workloads (like qemu, DPDK).
> >> So I don't think disabling it is a good approach. Indeed, HVO broke BBM,
> >> but the waring does not affect anything since the tail vmemmap pages are
> >> supposed to be read-only. So, I suggest skipping warnings if it is the
> >> vmemmap address in set_pte_at(). What do you think of?
> > 
> > IIUC, vmemmap_remap_pte() not only makes the pte read-only but also
> > changes the output address. Architecturally, this needs a BBM sequence.
> > We can avoid going through an invalid pte if we first make the pte
> > read-only, TLBI but keeping the same pfn, followed by a change of the
> > pfn while keeping the pte readonly. This also assumes that the content
> > of the page pointed at by the pte is the same at both old and new pfn.
> 
> Right. I think using BBM is to avoid possibly creating multiple TLB entries
> for the same address for a extremely short period. But accessing either the
> old page or the new page is fine in this case. Is it acceptable for this
> special case without using BBM?

Sadly, the architecture allows the CPU to conjure up a mapping based on a
combination of the old and the new descriptor (a process known as
"amalgamation") so we _really_ need the BBM sequence.

I'm in favour of disabling the optimisation now and bringing it back once
we've got this fixed.

Will
