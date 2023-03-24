Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0118F6C79F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCXIhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCXIhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:37:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E0C5B81
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:37:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B099533777;
        Fri, 24 Mar 2023 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679647052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6FnsbtwY1B8sPVCZAmhHvqVWvJAbJzIFlXms6iNspUI=;
        b=FWO7t6jnASnlueUDIY+7y4XybdZ8cLn/U4DqkHTvKGbbpzg+VOwfRKt7tDXyssJPPEEyCF
        28WGaEwlGzq97yMRRbwhX8UJmt+UD8g2c403LOBH0dc3sjHEaiYb91zb4BEqU+UvJ9UbY8
        /ePG54a8aEvSe/Ekyd6VIHX+QUSRS+o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91DA0133E5;
        Fri, 24 Mar 2023 08:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T+VUIUxhHWTkAgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 24 Mar 2023 08:37:32 +0000
Date:   Fri, 24 Mar 2023 09:37:31 +0100
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
Message-ID: <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308094106.227365-2-rppt@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-03-23 11:41:02, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> When set_memory or set_direct_map APIs used to change attribute or
> permissions for chunks of several pages, the large PMD that maps these
> pages in the direct map must be split. Fragmenting the direct map in such
> manner causes TLB pressure and, eventually, performance degradation.
> 
> To avoid excessive direct map fragmentation, add ability to allocate
> "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
> allocated pages from the direct map and use a cache of the unmapped pages.
> 
> This cache is replenished with higher order pages with preference for
> PMD_SIZE pages when possible so that there will be fewer splits of large
> pages in the direct map.
> 
> The cache is implemented as a buddy allocator, so it can serve high order
> allocations of unmapped pages.

Why do we need a dedicated gfp flag for all this when a dedicated
allocator is used anyway. What prevents users to call unmapped_pages_{alloc,free}?
-- 
Michal Hocko
SUSE Labs
