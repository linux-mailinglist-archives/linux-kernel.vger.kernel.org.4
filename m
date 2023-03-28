Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674876CB856
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjC1Hjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjC1Hjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:39:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B63196
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:39:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E37D81FD6A;
        Tue, 28 Mar 2023 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679989177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6LsNQFW9qDJbRtDT8d0v52+HSjljoW5023G5IXOpgfw=;
        b=jHH+FS9qODj00E1eRKg6/VYtJn7vkmlf4B0mnpK86VQ+9DisQyhb6dJ6bfYSvAlpJYrjUR
        meLggKv3uhru4lKroWou8mhhpT1a0SMGu0JCgDYpfHVoLiK8krIR5uCKcvCPpOf0+kAh2J
        E8xoamhubbBxrSisYFF0Yg1EcE3rYo4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C555B1390B;
        Tue, 28 Mar 2023 07:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2VNgLLmZImR8CAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 28 Mar 2023 07:39:37 +0000
Date:   Tue, 28 Mar 2023 09:39:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZCKZuXxq38obmYpn@dhcp22.suse.cz>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
 <ZB6W1C88TU6CcjJH@kernel.org>
 <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
 <ZCKIX3de5AZfGggK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCKIX3de5AZfGggK@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-03-23 09:25:35, Mike Rapoport wrote:
> On Mon, Mar 27, 2023 at 03:43:27PM +0200, Michal Hocko wrote:
> > On Sat 25-03-23 09:38:12, Mike Rapoport wrote:
> > > On Fri, Mar 24, 2023 at 09:37:31AM +0100, Michal Hocko wrote:
> > > > On Wed 08-03-23 11:41:02, Mike Rapoport wrote:
> > > > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > > > 
> > > > > When set_memory or set_direct_map APIs used to change attribute or
> > > > > permissions for chunks of several pages, the large PMD that maps these
> > > > > pages in the direct map must be split. Fragmenting the direct map in such
> > > > > manner causes TLB pressure and, eventually, performance degradation.
> > > > > 
> > > > > To avoid excessive direct map fragmentation, add ability to allocate
> > > > > "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
> > > > > allocated pages from the direct map and use a cache of the unmapped pages.
> > > > > 
> > > > > This cache is replenished with higher order pages with preference for
> > > > > PMD_SIZE pages when possible so that there will be fewer splits of large
> > > > > pages in the direct map.
> > > > > 
> > > > > The cache is implemented as a buddy allocator, so it can serve high order
> > > > > allocations of unmapped pages.
> > > > 
> > > > Why do we need a dedicated gfp flag for all this when a dedicated
> > > > allocator is used anyway. What prevents users to call unmapped_pages_{alloc,free}?
> > > 
> > > Using unmapped_pages_{alloc,free} adds complexity to the users which IMO
> > > outweighs the cost of a dedicated gfp flag.
> > 
> > Aren't those users rare and very special anyway?
> > 
> > > For modules we'd have to make x86::module_{alloc,free}() take care of
> > > mapping and unmapping the allocated pages in the modules virtual address
> > > range. This also might become relevant for another architectures in future
> > > and than we'll have several complex module_alloc()s. 
> > 
> > The module_alloc use is lacking any justification. More context would be
> > more than useful. Also vmalloc support for the proposed __GFP_UNMAPPED
> > likely needs more explanation as well.
>  
> Right now module_alloc() boils down to vmalloc() with the virtual range
> limited to the modules area. The allocated chunk contains both code and
> data. When CONFIG_STRICT_MODULE_RWX is set, parts of the memory allocated
> with module_alloc() remapped with different permissions both in vmalloc
> address space and in the direct map. The change of permissions for small
> ranges causes splits of large pages in the direct map.

OK, so you want to reduce that direct map fragmentation? Is that a real
problem? My impression is that modules are mostly static thing. BPF
might be a different thing though. I have a recollection that BPF guys
were dealing with direct map fragmention as well.

> If we were to use unmapped_pages_alloc() in modules_alloc(), we would have
> to implement the part of vmalloc() that reserves the virtual addresses and
> maps the allocated memory there in module_alloc().

Another option would be to provide an allocator for the backing pages to
vmalloc. But I do agree that a gfp flag is a less laborous way to
achieve the same. So the primary question really is whether we really
need vmalloc support for unmapped memory.
-- 
Michal Hocko
SUSE Labs
