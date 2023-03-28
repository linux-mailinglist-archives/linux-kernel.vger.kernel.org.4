Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E966CC631
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjC1P0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjC1P0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:26:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B70113FC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:25:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D0283219DA;
        Tue, 28 Mar 2023 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680017089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jboALtBYOng+vAI1cXsw10gaHCTV6EGfJuMtn5T9qYU=;
        b=d/ox4Hsy51Ysq4Z8utOZ85kAr07ayerlZVJleL9GXKEGNpyGiI+K9D1AQnhyp1oPpiC6eq
        m8ycCh5pFCECGHJaL4ixLL7RrLW4D1oM9byutuS7V1UWrNfxyzxbP8MbtuPPVVqcdIo8MD
        VBG3mbJ61PWiEZNxANCT/hHgzFz01Ek=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B53951390D;
        Tue, 28 Mar 2023 15:24:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5pJ4KcEGI2SjGQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 28 Mar 2023 15:24:49 +0000
Date:   Tue, 28 Mar 2023 17:24:49 +0200
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
Message-ID: <ZCMGwWmF9MGObSlt@dhcp22.suse.cz>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
 <ZB6W1C88TU6CcjJH@kernel.org>
 <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
 <ZCKIX3de5AZfGggK@kernel.org>
 <ZCKZuXxq38obmYpn@dhcp22.suse.cz>
 <ZCMDmHSqOeCj1EIo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCMDmHSqOeCj1EIo@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-03-23 18:11:20, Mike Rapoport wrote:
> On Tue, Mar 28, 2023 at 09:39:37AM +0200, Michal Hocko wrote:
[...]
> > OK, so you want to reduce that direct map fragmentation?
> 
> Yes.
> 
> > Is that a real problem?
> 
> A while ago Intel folks published report [1] that showed better performance
> with large pages in the direct map for majority of benchmarks.
> 
> > My impression is that modules are mostly static thing. BPF
> > might be a different thing though. I have a recollection that BPF guys
> > were dealing with direct map fragmention as well.
> 
> Modules are indeed static, but module_alloc() used by anything that
> allocates code pages, e.g. kprobes, ftrace and BPF. Besides, Thomas
> mentioned that having code in 2M pages reduces iTLB pressure [2], but
> that's not only about avoiding the splits in the direct map but also about
> using large mappings in the modules address space.
> 
> BPF guys suggested an allocator for executable memory [3] mainly because
> they've seen performance improvement of 0.6% - 0.9% in their setups [4].

These are fair arguments and it would have been better to have them in
the RFC. Also it is not really clear to me what is the actual benefit of
the unmapping for those usecases. I do get they want to benefit from
caching on the same permission setup but do they need unmapping as well?

> > > If we were to use unmapped_pages_alloc() in modules_alloc(), we would have
> > > to implement the part of vmalloc() that reserves the virtual addresses and
> > > maps the allocated memory there in module_alloc().
> > 
> > Another option would be to provide an allocator for the backing pages to
> > vmalloc. But I do agree that a gfp flag is a less laborous way to
> > achieve the same. So the primary question really is whether we really
> > need vmalloc support for unmapped memory.
> 
> I'm not sure I follow here. module_alloc() is essentially an alias to
> vmalloc(), so to reduce direct map fragmentation caused by code allocations
> the most sensible way IMO is to support unmapped memory in vmalloc().

What I meant to say is that vmalloc is currently using the page
allocator (resp bulk allocator) for the backing storage. I can imagine
an extension to replace this default allocator by something else (e.g. a
given allocation function). This would be more generic and it would
allow different usecases (e.g. benefit from caching withtout doing the
actual unmapping).
 
> I also think vmalloc with unmmapped pages can provide backing pages for
> execmem_alloc() Song proposed.

Why would you need to have execmem_alloc have its memory virtually
mapped into vmalloc space?

> [1] https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/
> [2] https://lore.kernel.org/all/87mt86rbvy.ffs@tglx/
> [3] https://lore.kernel.org/all/20221107223921.3451913-1-song@kernel.org/
> [4] https://lore.kernel.org/bpf/20220707223546.4124919-1-song@kernel.org/
> 
> -- 
> Sincerely yours,
> Mike.

-- 
Michal Hocko
SUSE Labs
