Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928676B287E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjCIPQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCIPPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:15:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE2B30DF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:14:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86042B81F6E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03659C433D2;
        Thu,  9 Mar 2023 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678374895;
        bh=C4w5vmfcLPBn4U6yuKEqRWXaXPOuMzm9bLGZsROhwbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeIltWNziJV+7bwnl4rl5/rCSOBMCwEOvbEY/fJTksRb6IALA/kD8+j1i7mJyG3To
         6g19+r0gBeRGPa0AiBhYrzV0eOPxlw58pCTc4xSP4UUUNVnEJNa/iNJMmJZ89p3cZk
         2oYky2tsBVSbWajCn0Btcs+H3kon1KIZMDCw+VoyvstEqLLeqgT2nJFIv4diYTf2cc
         yA3ScUZsCXDISpPdsirXBZNO6xdBUSXwM7BpRlBGCKMgOCokUxTIHD8ZTa78/qixNQ
         DJEkNyY8zoxiQLcYTRd/q5KXhNSvnu9mWZpL7OWtHu7VfNIJiFCvQoOTuafjSbb47B
         DESiBNQMs5eVA==
Date:   Thu, 9 Mar 2023 17:14:40 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Message-ID: <ZAn34D3hXR7dp8KC@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <e48a7fb1f8ab8d670b0884fd2a5d1e8c1c20e712.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e48a7fb1f8ab8d670b0884fd2a5d1e8c1c20e712.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 01:59:00AM +0000, Edgecombe, Rick P wrote:
> On Wed, 2023-03-08 at 11:41 +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > Hi,
> > 
> > This is a third attempt to make page allocator aware of the direct
> > map
> > layout and allow grouping of the pages that must be unmapped from
> > the direct map.
> > 
> > This a new implementation of __GFP_UNMAPPED, kinda a follow up for
> > this set:
> > 
> > https://lore.kernel.org/all/20220127085608.306306-1-rppt@kernel.org
> > 
> > but instead of using a migrate type to cache the unmapped pages, the
> > current implementation adds a dedicated cache to serve __GFP_UNMAPPED
> > allocations.
> 
> It seems a downside to having a page allocator outside of _the_ page
> allocator is you don't get all of the features that are baked in there.
> For example does secretmem care about numa? I guess in this
> implementation there is just one big cache for all nodes.
> 
> Probably most users would want __GFP_ZERO. Would secretmem care about
> __GFP_ACCOUNT?

The intention was that the pages in cache are always zeroed, so __GFP_ZERO
is always implicitly there, at least should have been.
__GFP_ACCOUNT is respected in this implementation. If you look at the
changes to __alloc_pages(), after getting pages from unmapped cache there
is 'goto out' to the point where the accounting is handled.

> I'm sure there is more, but I guess the question is, is
> the idea that these features all get built into unmapped-alloc at some
> point? The alternate approach is to have little caches for each usage
> like the grouped pages, which is probably less efficient when you have
> a bunch of them. Or solve it just for modules like the bpf allocator.
> Those are the tradeoffs for the approaches that have been explored,
> right?

I think that no matter what cache we'll use it won't be able to support all
features _the_ page allocator has. Indeed if we'd have per case cache
implementation we can tune that implementation to support features of
interest for that use case, but then we'll be less efficient in reducing
splits of the large pages. Not to mention increase in complexity as there
will be several caches doing similar but yet different things.

This POC mostly targets secretmem and modules, so this was pretty much
about GFP_KERNEL without considerations for NUMA, but I think extending
this unmapped alloc for NUMA should be simple enough but it will increase
memory overhead even more.
 
-- 
Sincerely yours,
Mike.
