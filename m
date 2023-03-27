Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7E06CA7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjC0Oby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjC0Obt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:31:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B12210D8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:31:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F3EFA21CC8;
        Mon, 27 Mar 2023 14:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679927506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2w61i4ixMyqYusHwfrvLzXW5aN7Xtkku6WNwaDadPY=;
        b=m4EQn2/jdCZ3O/fv1kxvv0zziOQljSrWfBGaK69LM66+XLU1Z09GuiKAbPhteNAaDSL6ow
        vkvISD0nqygDQ2g0TJdrkQ7QMso4tAp7S5rDBX2K/LndwIyGQfKu8h1S2v7nBVKfkgZNuJ
        gpyaa1uT9Tov5FStjIE+YPCQJD5I6cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679927506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2w61i4ixMyqYusHwfrvLzXW5aN7Xtkku6WNwaDadPY=;
        b=wT9VT+Pw1gsMGJhRIY9yDIfTMGZvt+XEWCFlX2FUykZyimCDOzkEXDppVZYeoUpJltlZsm
        fH9XkbMyzpNDygCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDAC613482;
        Mon, 27 Mar 2023 14:31:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bkqBLdGoIWT2FQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 27 Mar 2023 14:31:45 +0000
Message-ID: <f2702360-d560-95da-a93d-16fae1dbf766@suse.cz>
Date:   Mon, 27 Mar 2023 16:31:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org> <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
 <ZB6W1C88TU6CcjJH@kernel.org> <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/23 15:43, Michal Hocko wrote:
> On Sat 25-03-23 09:38:12, Mike Rapoport wrote:
>> On Fri, Mar 24, 2023 at 09:37:31AM +0100, Michal Hocko wrote:
>> > On Wed 08-03-23 11:41:02, Mike Rapoport wrote:
>> > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>> > > 
>> > > When set_memory or set_direct_map APIs used to change attribute or
>> > > permissions for chunks of several pages, the large PMD that maps these
>> > > pages in the direct map must be split. Fragmenting the direct map in such
>> > > manner causes TLB pressure and, eventually, performance degradation.
>> > > 
>> > > To avoid excessive direct map fragmentation, add ability to allocate
>> > > "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
>> > > allocated pages from the direct map and use a cache of the unmapped pages.
>> > > 
>> > > This cache is replenished with higher order pages with preference for
>> > > PMD_SIZE pages when possible so that there will be fewer splits of large
>> > > pages in the direct map.
>> > > 
>> > > The cache is implemented as a buddy allocator, so it can serve high order
>> > > allocations of unmapped pages.
>> > 
>> > Why do we need a dedicated gfp flag for all this when a dedicated
>> > allocator is used anyway. What prevents users to call unmapped_pages_{alloc,free}?
>> 
>> Using unmapped_pages_{alloc,free} adds complexity to the users which IMO
>> outweighs the cost of a dedicated gfp flag.
> 
> Aren't those users rare and very special anyway?

I think it's mostly about the freeing that can happen from a generic context
not aware of the special allocation, so it's not about how rare it is, but
how complex would be to determine exhaustively those contexts and do
something in them.

>> For modules we'd have to make x86::module_{alloc,free}() take care of
>> mapping and unmapping the allocated pages in the modules virtual address
>> range. This also might become relevant for another architectures in future
>> and than we'll have several complex module_alloc()s. 
> 
> The module_alloc use is lacking any justification. More context would be
> more than useful. Also vmalloc support for the proposed __GFP_UNMAPPED
> likely needs more explanation as well.
> 
>> And for secretmem while using unmapped_pages_alloc() is easy, the free path
>> becomes really complex because actual page freeing for fd-based memory is
>> deeply buried in the page cache code.
> 
> Why is that a problem? You already hook into the page freeing path and
> special case unmapped memory.

But the proposal of unmapped_pages_free() would suggest this would no longer
be the case?

But maybe we could, as a compromise, provide unmapped_pages_alloc() to get
rid of the new __GFP flag, provide unmapped_pages_free() to annotate places
that are known to free unmapped memory explicitly, but the generic page
freeing would also keep the hook?

>> My gut feeling is that for PKS using a gfp flag would save a lot of hassle
>> as well.
> 
> Well, my take on this is that this is not a generic page allocator
> functionality. It is clearly an allocator on top of the page allocator.
> In general gfp flags are scarce and convenience argument usually fires
> back later on in hard to predict ways. So I've learned to be careful
> here. I am not saying this is a no-go but right now I do not see any
> acutal advantage. The vmalloc usecase could be interesting in that
> regards but it is not really clear to me whether this is a good idea in
> the first place.
> 

