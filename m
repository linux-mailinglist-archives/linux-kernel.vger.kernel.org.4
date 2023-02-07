Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72DE68DBBF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjBGOga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjBGOgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:36:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A314410B1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:32:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DC9AB8198A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891F4C43443;
        Tue,  7 Feb 2023 14:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675780297;
        bh=49yr/FtTuZBsppzLS6kTX9ewOWDHt7Ufj7812zHXhac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UethI1XnoHOFrnTAZjkOJeIMc83MR9S09pTS/YPudqvDnQUOdSdu2uvOfSde5tq2b
         5CLBQiEy7tAnKGF/ZNwBi2iEUR7vYx1bTGMUY4/KzHqWds4rt5m+FnhGnLzrwf7vI9
         0uNuNeWmaaNJ8NcjrmjcAHxp1zy350La4YNYCvNMcmCNdAVeyJaO2AkR0Id1Hw5O9P
         Nc/lPqOrl8uAc32jcD+D46llco/yPq1f/Dbwqsrgz2UneboS9p1W65JPY6JqMZdfRJ
         sQpQ/TssInUYjJ5qo05r/Jty+R5qi5LU1DduOsHhcXJEYgqaSCOTgHFsi9yO08TIEe
         GSQH/m2uQJTtQ==
Date:   Tue, 7 Feb 2023 14:31:31 +0000
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
Message-ID: <20230207143131.GA12475@willie-the-truck>
References: <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
 <20230126133321.GB29148@willie-the-truck>
 <d454c9a2-5300-b600-a2ae-21d82d338470@arm.com>
 <20230131154950.GB2646@willie-the-truck>
 <Y9pZALdn3pKiJUeQ@arm.com>
 <A8DF7D56-C145-4B49-A034-022917B87C89@linux.dev>
 <Y9uUO9AadE+8ik/0@arm.com>
 <F10F1618-7153-41C7-A475-522D833C41D4@linux.dev>
 <20230203101023.GA5597@willie-the-truck>
 <93461768-791A-45BE-BEF2-344CC5228C92@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93461768-791A-45BE-BEF2-344CC5228C92@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 11:28:12AM +0800, Muchun Song wrote:
> 
> 
> > On Feb 3, 2023, at 18:10, Will Deacon <will@kernel.org> wrote:
> > 
> > On Fri, Feb 03, 2023 at 10:40:18AM +0800, Muchun Song wrote:
> >> 
> >> 
> >>> On Feb 2, 2023, at 18:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>> 
> >>> On Thu, Feb 02, 2023 at 05:51:39PM +0800, Muchun Song wrote:
> >>>>> On Feb 1, 2023, at 20:20, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>>>>> Bah, sorry! Catalin reckons it may have been him talking about the vmemmap.
> >>>>> 
> >>>>> Indeed. The discussion with Anshuman started from this thread:
> >>>>> 
> >>>>> https://lore.kernel.org/all/20221025014215.3466904-1-mawupeng1@huawei.com/
> >>>>> 
> >>>>> We already trip over the existing checks even without Anshuman's patch,
> >>>>> though only by chance. We are not setting the software PTE_DIRTY on the
> >>>>> new pte (we don't bother with this bit for kernel mappings).
> >>>>> 
> >>>>> Given that the vmemmap ptes are still live when such change happens and
> >>>>> no-one came with a solution to the break-before-make problem, I propose
> >>>>> we revert the arm64 part of commit 47010c040dec ("mm: hugetlb_vmemmap:
> >>>>> cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*"). We just need this hunk:
> >>>>> 
> >>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >>>>> index 27b2592698b0..5263454a5794 100644
> >>>>> --- a/arch/arm64/Kconfig
> >>>>> +++ b/arch/arm64/Kconfig
> >>>>> @@ -100,7 +100,6 @@ config ARM64
> >>>>> select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> >>>>> select ARCH_WANT_FRAME_POINTERS
> >>>>> select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> >>>>> - select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >>>> 
> >>>> Maybe it is a little overkill for HVO as it can significantly minimize the
> >>>> overhead of vmemmap on ARM64 servers for some workloads (like qemu, DPDK).
> >>>> So I don't think disabling it is a good approach. Indeed, HVO broke BBM,
> >>>> but the waring does not affect anything since the tail vmemmap pages are
> >>>> supposed to be read-only. So, I suggest skipping warnings if it is the
> >>>> vmemmap address in set_pte_at(). What do you think of?
> >>> 
> >>> IIUC, vmemmap_remap_pte() not only makes the pte read-only but also
> >>> changes the output address. Architecturally, this needs a BBM sequence.
> >>> We can avoid going through an invalid pte if we first make the pte
> >>> read-only, TLBI but keeping the same pfn, followed by a change of the
> >>> pfn while keeping the pte readonly. This also assumes that the content
> >>> of the page pointed at by the pte is the same at both old and new pfn.
> >> 
> >> Right. I think using BBM is to avoid possibly creating multiple TLB entries
> >> for the same address for a extremely short period. But accessing either the
> >> old page or the new page is fine in this case. Is it acceptable for this
> >> special case without using BBM?
> > 
> > Sadly, the architecture allows the CPU to conjure up a mapping based on a
> > combination of the old and the new descriptor (a process known as
> > "amalgamation") so we _really_ need the BBM sequence.
> 
> I am not familiar with ARM64, what's the user-visible effect if this
> "amalgamation" occurs?

The user-visible effects would probably be data corruption and instability,
since the amalgamated TLB entry could result in a bogus physical address and
bogus permissions.

Will
