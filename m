Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5866865D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjBAMUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBAMUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:20:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6396C4E51E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:20:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0879B8215F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0547CC433EF;
        Wed,  1 Feb 2023 12:20:18 +0000 (UTC)
Date:   Wed, 1 Feb 2023 12:20:16 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
Message-ID: <Y9pZALdn3pKiJUeQ@arm.com>
References: <20230109052816.405335-1-anshuman.khandual@arm.com>
 <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
 <20230126133321.GB29148@willie-the-truck>
 <d454c9a2-5300-b600-a2ae-21d82d338470@arm.com>
 <20230131154950.GB2646@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131154950.GB2646@willie-the-truck>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:49:51PM +0000, Will Deacon wrote:
> On Fri, Jan 27, 2023 at 12:43:17PM +0000, Robin Murphy wrote:
> > On 2023-01-26 13:33, Will Deacon wrote:
> > > On Tue, Jan 24, 2023 at 11:11:49AM +0530, Anshuman Khandual wrote:
> > > > On 1/9/23 10:58, Anshuman Khandual wrote:
> > > > > Changing pfn on a user page table mapped entry, without first going through
> > > > > break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
> > > > > to intercept such changes, via an updated pgattr_change_is_safe(). This new
> > > > > check happens via __check_racy_pte_update(), which has now been renamed as
> > > > > __check_safe_pte_update().
> > > > > 
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > > ---
> > > > > This applies on v6.2-rc3. This patch had some test time on an internal CI
> > > > > system without any issues being reported.
> > > > 
> > > > Gentle ping, any updates on this patch ? Still any concerns ?
> > > 
> > > I don't think we really got to the bottom of Mark's concerns with
> > > unreachable ptes on the stack, did we? I also have vague recollections
> > > of somebody (Robin?) running into issues with the vmap code not honouring
> > > BBM.
> > 
> > Doesn't ring a bell, so either it wasn't me, or it was many years ago and
> > about 5 levels deep into trying to fix something else :/
> 
> Bah, sorry! Catalin reckons it may have been him talking about the vmemmap.

Indeed. The discussion with Anshuman started from this thread:

https://lore.kernel.org/all/20221025014215.3466904-1-mawupeng1@huawei.com/

We already trip over the existing checks even without Anshuman's patch,
though only by chance. We are not setting the software PTE_DIRTY on the
new pte (we don't bother with this bit for kernel mappings).

Given that the vmemmap ptes are still live when such change happens and
no-one came with a solution to the break-before-make problem, I propose
we revert the arm64 part of commit 47010c040dec ("mm: hugetlb_vmemmap:
cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*"). We just need this hunk:

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 27b2592698b0..5263454a5794 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -100,7 +100,6 @@ config ARM64
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
-	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES

-- 
Catalin
