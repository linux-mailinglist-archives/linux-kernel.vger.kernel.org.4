Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147D1687A99
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjBBKqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjBBKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:45:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EF8885F1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:45:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C69F6B823EF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0796C433D2;
        Thu,  2 Feb 2023 10:45:18 +0000 (UTC)
Date:   Thu, 2 Feb 2023 10:45:15 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
Message-ID: <Y9uUO9AadE+8ik/0@arm.com>
References: <20230109052816.405335-1-anshuman.khandual@arm.com>
 <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
 <20230126133321.GB29148@willie-the-truck>
 <d454c9a2-5300-b600-a2ae-21d82d338470@arm.com>
 <20230131154950.GB2646@willie-the-truck>
 <Y9pZALdn3pKiJUeQ@arm.com>
 <A8DF7D56-C145-4B49-A034-022917B87C89@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A8DF7D56-C145-4B49-A034-022917B87C89@linux.dev>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 05:51:39PM +0800, Muchun Song wrote:
> > On Feb 1, 2023, at 20:20, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> Bah, sorry! Catalin reckons it may have been him talking about the vmemmap.
> > 
> > Indeed. The discussion with Anshuman started from this thread:
> > 
> > https://lore.kernel.org/all/20221025014215.3466904-1-mawupeng1@huawei.com/
> > 
> > We already trip over the existing checks even without Anshuman's patch,
> > though only by chance. We are not setting the software PTE_DIRTY on the
> > new pte (we don't bother with this bit for kernel mappings).
> > 
> > Given that the vmemmap ptes are still live when such change happens and
> > no-one came with a solution to the break-before-make problem, I propose
> > we revert the arm64 part of commit 47010c040dec ("mm: hugetlb_vmemmap:
> > cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*"). We just need this hunk:
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 27b2592698b0..5263454a5794 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -100,7 +100,6 @@ config ARM64
> > 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> > 	select ARCH_WANT_FRAME_POINTERS
> > 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> > -	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> 
> Maybe it is a little overkill for HVO as it can significantly minimize the
> overhead of vmemmap on ARM64 servers for some workloads (like qemu, DPDK).
> So I don't think disabling it is a good approach. Indeed, HVO broke BBM,
> but the waring does not affect anything since the tail vmemmap pages are
> supposed to be read-only. So, I suggest skipping warnings if it is the
> vmemmap address in set_pte_at(). What do you think of?

IIUC, vmemmap_remap_pte() not only makes the pte read-only but also
changes the output address. Architecturally, this needs a BBM sequence.
We can avoid going through an invalid pte if we first make the pte
read-only, TLBI but keeping the same pfn, followed by a change of the
pfn while keeping the pte readonly. This also assumes that the content
of the page pointed at by the pte is the same at both old and new pfn.

-- 
Catalin
