Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E706A94EE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCCKMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjCCKMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:12:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA55B5D8A9;
        Fri,  3 Mar 2023 02:12:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 763A4617A6;
        Fri,  3 Mar 2023 10:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA015C433EF;
        Fri,  3 Mar 2023 10:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677838348;
        bh=zSP4xjwQDlAEcT4eSELsSnu2Y/RaPLRuo7VgSU9hATs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzpbJmGqcPtZzscYVDHWsmdWQW6SKzVuhMclSOjXhPrrrIAwDMPiAAx/rOFShYwzq
         Kr+JfFrJVM3sl5VseW8UNnoprCOZF4ziydHLqf85WCKsuW5ubdpetFjWNhk1kjceQ3
         bhVtKp5heJU7SSdumpCxpXZ4DxPncpb0+DOwv60UEDWVbMnxVyDe9Ku6WidET+QBMv
         awVxJrXjlg6o/Gj0+dV1JcTkX1jt4ZKdyGGUeLp3eOwRZ9GVblITo3I2c5MCzT1hIF
         JafFcg+3/MgdK+GAwP0v5tgNrFMnO1RvI4rGXpVra83zceVjtaPDlf64HqrQulqkBO
         2y0ta9IrKc9ig==
Date:   Fri, 3 Mar 2023 12:12:14 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        mike.kravetz@oracle.com, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH V2] mm/debug_vm_pgtable: Replace pte_mkhuge() with
 arch_make_huge_pte()
Message-ID: <ZAHH/oj4cfi8TpHO@kernel.org>
References: <20230302114845.421674-1-anshuman.khandual@arm.com>
 <d4895edc-a7de-239b-e452-c64535b68685@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4895edc-a7de-239b-e452-c64535b68685@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 01:42:21PM +0100, David Hildenbrand wrote:
> On 02.03.23 12:48, Anshuman Khandual wrote:
> > Since the following commit arch_make_huge_pte() should be used directly in
> > generic memory subsystem as a platform provided page table helper, instead
> > of pte_mkhuge(). Change hugetlb_basic_tests() to call arch_make_huge_pte()
> > directly, and update its relevant documentation entry as required.
> > 
> > 'commit 16785bd77431 ("mm: merge pte_mkhuge() call into arch_make_huge_pte()")'
> > 
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Link: https://lore.kernel.org/all/1ea45095-0926-a56a-a273-816709e9075e@csgroup.eu/
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > This applies on latest mainline.
> > 
> > Changes in V2:
> > 
> > - Send PMD_SHIFT and VM_ACCESS_FLAGS as arguments for arch_make_huge_pte()
> > Changes in V1:
> > 
> > https://lore.kernel.org/all/20230302031833.360679-1-anshuman.khandual@arm.com/
> > 
> >   Documentation/mm/arch_pgtable_helpers.rst | 2 +-
> >   mm/debug_vm_pgtable.c                     | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
> > index 30d9a09f01f4..af3891f895b0 100644
> > --- a/Documentation/mm/arch_pgtable_helpers.rst
> > +++ b/Documentation/mm/arch_pgtable_helpers.rst
> > @@ -214,7 +214,7 @@ HugeTLB Page Table Helpers
> >   +---------------------------+--------------------------------------------------+
> >   | pte_huge                  | Tests a HugeTLB                                  |
> >   +---------------------------+--------------------------------------------------+
> > -| pte_mkhuge                | Creates a HugeTLB                                |
> > +| arch_make_huge_pte        | Creates a HugeTLB                                |
> >   +---------------------------+--------------------------------------------------+
> >   | huge_pte_dirty            | Tests a dirty HugeTLB                            |
> >   +---------------------------+--------------------------------------------------+
> > diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> > index af59cc7bd307..7887cc2b75bf 100644
> > --- a/mm/debug_vm_pgtable.c
> > +++ b/mm/debug_vm_pgtable.c
> > @@ -934,7 +934,7 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
> >   #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
> >   	pte = pfn_pte(args->fixed_pmd_pfn, args->page_prot);
> > -	WARN_ON(!pte_huge(pte_mkhuge(pte)));
> > +	WARN_ON(!pte_huge(arch_make_huge_pte(pte, PMD_SHIFT, VM_ACCESS_FLAGS)));
> >   #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
> >   }
> >   #else  /* !CONFIG_HUGETLB_PAGE */
> 
> 
> IMHO, it's a bit weird that we are starting to call these things "arch_*".
> PTE operations like these are already mostly arch-specific helpers with
> custom implementations (and some generic ones in asm-generic as a fallback).

Yeah, probably a better name for arch_make_huge_pte() would have been
pte_make_huge()
 
> So this one certainly sticks out now ... anyhow, change itself LGTM ...
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
