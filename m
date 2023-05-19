Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCD709C62
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjESQY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjESQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7FC9
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DABF65933
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B59DC43443;
        Fri, 19 May 2023 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684513486;
        bh=l7IqxgTGgOUrrRLp/9kEkeElM34tTO5S0maFth2gfks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VF1ZxWOsDhHWaJROcCgln8Hk8HRRpZ6O1WlOpqGsQF66QGWjGTWJ9Nd1/D9UsgRIe
         vKUedzeZUSBtnbtv3lm0tFU5AsUwrTT6+sVq61IuhcRzdGrl0ZsyJLGpScoTfCXJJh
         zA7FNLg7M8o/dj/uZgSB1tGhC6Ibmoo5jD3SOjfazOqofa5udrf3iNq+BLaB8tFuR5
         1fGrvop1FmSUiLwjXbquoL0VTW/G7AoWZVFrJnu3Zq5pgz5PwMeWGe93i1U8iFpgZ9
         h22nqG/+VnalqFvfeQB5Rnm7Cd5gkJFPIDCaoU/OoGnH536xVCiWOLDAlLA36vlOl6
         giYN9E4mPIOoA==
Date:   Fri, 19 May 2023 19:24:32 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "song@kernel.org" <song@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/5] Prototype for direct map awareness in page
 allocator
Message-ID: <20230519162432.GG4967@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <e48a7fb1f8ab8d670b0884fd2a5d1e8c1c20e712.camel@intel.com>
 <ZAn34D3hXR7dp8KC@kernel.org>
 <ZGeYgKCFOkzP2fub@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGeYgKCFOkzP2fub@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 08:40:48AM -0700, Sean Christopherson wrote:
> On Thu, Mar 09, 2023, Mike Rapoport wrote:
> > On Thu, Mar 09, 2023 at 01:59:00AM +0000, Edgecombe, Rick P wrote:
> > > On Wed, 2023-03-08 at 11:41 +0200, Mike Rapoport wrote:
> > > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > > 
> > > > Hi,
> > > > 
> > > > This is a third attempt to make page allocator aware of the direct
> > > > map
> > > > layout and allow grouping of the pages that must be unmapped from
> > > > the direct map.
> > > > 
> > > > This a new implementation of __GFP_UNMAPPED, kinda a follow up for
> > > > this set:
> > > > 
> > > > https://lore.kernel.org/all/20220127085608.306306-1-rppt@kernel.org
> > > > 
> > > > but instead of using a migrate type to cache the unmapped pages, the
> > > > current implementation adds a dedicated cache to serve __GFP_UNMAPPED
> > > > allocations.
> > > 
> > > It seems a downside to having a page allocator outside of _the_ page
> > > allocator is you don't get all of the features that are baked in there.
> > > For example does secretmem care about numa? I guess in this
> > > implementation there is just one big cache for all nodes.
> > > 
> > > Probably most users would want __GFP_ZERO. Would secretmem care about
> > > __GFP_ACCOUNT?
> > 
> > The intention was that the pages in cache are always zeroed, so __GFP_ZERO
> > is always implicitly there, at least should have been.
> 
> Would it be possible to drop that assumption/requirement, i.e. allow allocation of
> __GFP_UNMAPPED without __GFP_ZERO?  At a glance, __GFP_UNMAPPED looks like it would
> be a great fit for backing guest memory, in particular for confidential VMs.  And
> for some flavors of CoCo, i.e. TDX, the trusted intermediary is responsible for
> zeroing/initializing guest memory as the untrusted host (kernel/KVM) doesn't have
> access to the guest's encryption key.  In other words, zeroing in the kernel would
> be unnecessary work.

Making and unmapped allocation without __GFP_ZERO shouldn't be a problem. 

However, using a gfp flag and hooking up into the free path in page
allocator have issues and preferably should be avoided.

Will something like unmapped_alloc() and unmapped_free() work for your
usecase?

-- 
Sincerely yours,
Mike.
