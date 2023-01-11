Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C766604B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbjAKQWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjAKQVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:21:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD343395DC;
        Wed, 11 Jan 2023 08:19:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F6B44DEB;
        Wed, 11 Jan 2023 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673453950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Uo1F/S6/BtgInuYAgaI0yUjIL9CeDbM27HnRNyBOC8=;
        b=oUm4vmx/tY5jshUMzmTMV4ujxm9WBPq7G63760MdNaeUeWGw61qJWUsBiU/ThcpJxf3YbT
        9dnFhOb83o/uIlG01AUWYKBRHbBej41yxRsJGPGrJM6vF20xCc+ljCnJ/Ur+izcnctbDnB
        +W6AaANj1nk+G3E8ZdNbT5nkdMWH1UE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EC6B1358A;
        Wed, 11 Jan 2023 16:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aLOxBX7hvmPZTgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 11 Jan 2023 16:19:10 +0000
Date:   Wed, 11 Jan 2023 17:19:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] docs/mm: Physical Memory: add structure,
 introduction and nodes description
Message-ID: <Y77hfY8+FUun1tKa@dhcp22.suse.cz>
References: <20230110152358.2641910-1-rppt@kernel.org>
 <20230110152358.2641910-3-rppt@kernel.org>
 <Y72YMk21sSJLfUiz@dhcp22.suse.cz>
 <Y76qi7OB0gcigqZA@kernel.org>
 <Y767UIx0TQtylJPG@dhcp22.suse.cz>
 <Y77de+xRh+8NXXKn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y77de+xRh+8NXXKn@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-01-23 18:02:03, Mike Rapoport wrote:
> On Wed, Jan 11, 2023 at 02:36:16PM +0100, Michal Hocko wrote:
> > On Wed 11-01-23 14:24:43, Mike Rapoport wrote:
> > > On Tue, Jan 10, 2023 at 05:54:10PM +0100, Michal Hocko wrote:
> > > > On Tue 10-01-23 17:23:58, Mike Rapoport wrote:
> > > > [...]
> > > > > +* ``ZONE_DMA`` and ``ZONE_DMA32`` represent memory suitable for DMA by
> > > > > +  peripheral devices that cannot access all of the addressable memory.
> > > > 
> > > > I think it would be better to not keep the historical DMA based menaning
> > > > and teach that future developers. You can say something like
> > > > 
> > > > ZONE_DMA and ZONE_DMA32 have historically been used for memory suitable
> > > > for DMA. For many years there are better more robust interfaces to
> > > > get memory with DMA specific requirements (Documentation/core-api/dma-api.rst).
> > > 
> > > But even today ZONE_DMA(32) means that the memory is suitable for DMA. This
> > > is nicely encapsulated with dma APIs and there should be no new GFP_DMA
> > > users, but still memory outside ZONE_DMA is not suitable for DMA.
> > 
> > Well, the thing is that ZONE_DMA means different thing for different
> > architectures. For x86 it is effectivelly about ISA attached HW - which
> > means almost nothing these days. There is plethora of other HW with
> > different address range constrains for DMA transfer so binding the zone
> > with DMA is more likely to cause confusion than it helps.
> 
> Ok, how about
> 
> * ``ZONE_DMA`` and ``ZONE_DMA32`` historically represented memory suitable for
>   DMA by peripheral devices that cannot access all of the addressable
>   memory. For many years there are better more and robust interfaces to get
>   memory with DMA specific requirements (:ref:`DMA API <_dma_api>`), but
>   ``ZONE_DMA`` and ``ZONE_DMA32`` still represent memory ranges that have
>   restrictions on how they can be accessed.
>   Depending on the architecture, either of these zone types or even they both
>   can be disabled at build time using ``CONFIG_ZONE_DMA`` and
>   ``CONFIG_ZONE_DMA32`` configuration options. Some 64-bit platforms may need
>   both zones as they support peripherals with different DMA addressing
>   limitations.

Sounds better to me. Thanks!
At least ZONE_DMA32 is somehow better defined as it represents 32b
address range constrain. DMA can be really different on different
arches. Probably good to have it here. Ideally we would have a reference
how that range is established but architectures are not unified in that
respect.


-- 
Michal Hocko
SUSE Labs
