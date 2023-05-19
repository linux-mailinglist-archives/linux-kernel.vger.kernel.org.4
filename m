Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0E7091B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjESIaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjESIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFBEE6B
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36A01654C4
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F16C433EF;
        Fri, 19 May 2023 08:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684484999;
        bh=8+80y47QSWOvbKO/38h2ooL7X2lhtxzCV052gx173Cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9f+e7XR94xtnbODov82DRWMQQaabqcIaW+nbvJthodigBYPKD5BSr1SLDRkJtKN4
         NdbAbDH3YhM30vh+sWk+EgRlEpTqcrzdkdx8CJ6hoP/3JBguYbpfbYq61zA6TCZaST
         WLqSYTtfPrKcU9epkKPLt4M5AWJO36cufP5G5IuNnhYi1gw4u4XbXlpEa2P8z0wsER
         J0dvzF9e8UrMUcvJD9QonNIBE6HyDn6IcQQxKPLPbm+dFh231QDWi1AMccO9+p0HYS
         6O6rPIoyXatSX+PU0aIDA9Dc5sM8qcfDewvKufzj3x5E0BltpU43RlZkGfW056AVxS
         QUjc3U5Uyt2zA==
Date:   Fri, 19 May 2023 11:29:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Song Liu <song@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <20230519082945.GE4967@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan>
 <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan>
 <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGZfLHA8vuRJwa0f@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kent,

On Thu, May 18, 2023 at 01:23:56PM -0400, Kent Overstreet wrote:
> On Thu, May 18, 2023 at 10:00:39AM -0700, Song Liu wrote:
> > On Thu, May 18, 2023 at 9:48 AM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Thu, May 18, 2023 at 09:33:20AM -0700, Song Liu wrote:
> > > > I am working on patches based on the discussion in [1]. I am planning to
> > > > send v1 for review in a week or so.
> > >
> > > Hey Song, I was reviewing that thread too,
> > >
> > > Are you taking a different approach based on Thomas's feedback? I think
> > > he had some fair points in that thread.
> > 
> > Yes, the API is based on Thomas's suggestion, like 90% from the discussions.
> > 
> > >
> > > My own feeling is that the buddy allocator is our tool for allocating
> > > larger variable sized physically contiguous allocations, so I'd like to
> > > see something based on that - I think we could do a hybrid buddy/slab
> > > allocator approach, like we have for regular memory allocations.
> > 
> > I am planning to implement the allocator based on this (reuse
> > vmap_area logic):
> 
> Ah, you're still doing vmap_area approach.
> 
> Mike's approach looks like it'll be _much_ lighter weight and higher
> performance, to me. vmalloc is known to be slow compared to the buddy
> allocator, and with Mike's approach we're only modifying mappings once
> per 2 MB chunk.
> 
> I don't see anything in your code for sub-page sized allocations too, so
> perhaps I should keep going with my slab allocator.

Your allocator implicitly relies on vmalloc because of module_alloc ;-)

What I was thinking is that we can replace module_alloc() calls in your
allocator with something based on my unmapped_alloc(). If we make the part
that refills the cache also take care of creating the mapping in the
module address space, that should cover everything.
 
> Could you share your thoughts on your approach vs. Mike's? I'm newer to
> this area of the code than you two so maybe there's an angle I've missed
> :)
> 

-- 
Sincerely yours,
Mike.
