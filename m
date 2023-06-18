Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3F1734535
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 09:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjFRHJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 03:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFRHJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 03:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE0A10E0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 00:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BBA760DCE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 07:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BC4C433C0;
        Sun, 18 Jun 2023 07:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687072170;
        bh=JtfdClECfN8YVYAgrgvYa8BILPJkj4nOja+go6KxzGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZCy4MTgaNYHL74aVzpVXXxSsnRC+Jc60nwps7hpZerQU0Cq/6p1QNRE02uqQ44vv
         SP41j7Zox7ACcdHNTfSysULK6V3d2L160EM2s4yTFKERK9vO5qfWPxNJVkyf7x1k+n
         pQQZ22VH66BKf1AOiIkON22JcHBHntmadMVibOzEp7W2CuXPy+RBWYDgYJ9Xk4V9rU
         A4vkl947/aPk6vk5rCmiHz7W4OwZIWC95rnL7sm5WEMCza/DmiwXdyqWdroykxHBjd
         BKKyT8E+ABUQaNGb76htQU8+GQ2PNvT9GENqQJ34+zRrJ2sUnqSSTCCrIF45XSJfbW
         84+gotcSUkOVA==
Date:   Sun, 18 Jun 2023 10:08:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Liam Ni <zhiguangni01@gmail.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        akpm@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] x86,NUMA:Get the number of ram pages directly in
 numa_meminfo_cover_memory()
Message-ID: <20230618070850.GY52412@kernel.org>
References: <20230615142016.419570-1-zhiguangni01@gmail.com>
 <20230615170011.GK52412@kernel.org>
 <CACZJ9cVxqeDooeAMi8HBFmeo_85E+NuMYbW9PCvp7Rm-wunOGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACZJ9cVxqeDooeAMi8HBFmeo_85E+NuMYbW9PCvp7Rm-wunOGg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 06:47:11PM +0800, Liam Ni wrote:
> On Fri, 16 Jun 2023 at 01:00, Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Fri, Jun 16, 2023 at 12:20:16AM +1000, Liam Ni wrote:
> > > In a previous implementation,The ram page is calculated
> > > by counting the number of holes,
> > > however,the number of ram pages is calculated during hole calculation.
> > > Therefore,we can directly calculate the amount of ram pages.
> > >
> > > Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> > > ---
> > >  arch/x86/mm/numa.c |  4 ++--
> > >  include/linux/mm.h |  4 ++++
> > >  mm/mm_init.c       | 33 +++++++++++++++++++++++++++++++++
> > >  3 files changed, 39 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > index 2aadb2019b4f..8ea0e956e3d7 100644
> > > --- a/arch/x86/mm/numa.c
> > > +++ b/arch/x86/mm/numa.c
> > > @@ -461,12 +461,12 @@ static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> > >               u64 s = mi->blk[i].start >> PAGE_SHIFT;
> > >               u64 e = mi->blk[i].end >> PAGE_SHIFT;
> > >               numaram += e - s;
> > > -             numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> > > +             numaram += __available_pages_in_range(mi->blk[i].nid, s, e);
> >
> > This is wrong. You add number of pages in range core MM sees to the number
> > of pages covered by the numa_meminfo.
> >
> > More generally, rather than traverse all the numa_meminfo's and for each of
> > them traverse all the regions in memblock.memory it's enough to count
> > memory in memblock that doesn't have the node assigned and compare it to
> > memblock_phys_mem_size().
> 
> Logic like below?
> static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> {
>    u64 error_value;
>    error_value = pages_without_nid_in_range(0,max_pfn);
>     if ((error_value ) >= (1 << (20 - PAGE_SHIFT))) {
>         //print error information
>         return false;
>      }
>      return true;
> }
> 
> I can't figure out why compare it with memblock_phys_mem_size().
> The number of pages in memblock that doesn't have the node
> assigned,which also means that these pages are not in numa_info.
> So these pages can represent the number of lose pages.

Yes, there is no need to compare with memblock_phys_mem_size() if you count
pages that don't have nid set in memblock.
 
> Thanks
> Liam Ni

-- 
Sincerely yours,
Mike.
