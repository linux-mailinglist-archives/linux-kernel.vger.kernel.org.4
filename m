Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948B76937CA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 15:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBLOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 09:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBLOsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 09:48:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467997A80;
        Sun, 12 Feb 2023 06:48:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 09595CE0EBB;
        Sun, 12 Feb 2023 14:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2BBC433EF;
        Sun, 12 Feb 2023 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676213277;
        bh=p8vea+Viq5T3HBJIG/rvWJdkWif69BStqXp2D3hTyL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXngzYQovn7F4x3f1kNvFy7yRu1FjOfMayfHfTEscWM3IMrcsvzBmh6sPpHROpD3t
         1nL8rP87l6XKbcncHY1GLGXdf+FgtBmNB9stZSrWBsL/X5SXHfmlHaszDqk+Pf7HaG
         T4Z+ccXrAjTTsaOnPj+HyQGVhWwFu0QXrs5opSMdG445COrmyTvA8IROHCBv3BY6Nu
         lNM4FZEXiKLMR1kmOx6whh4Wjr/AVJT2vBxNT4kQeqABbMDGwEXpRb8GXFTVjWayHn
         WOKu2zk4j0SVV44jB+VnPs6nOnj5zfeRjyk8U2kA2MaEcwgVg8kqwC+d/7heZT8RCB
         c61irGKs6joXQ==
Date:   Sun, 12 Feb 2023 16:47:42 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] docs/mm: Physical Memory: add example of interleaving
 nodes
Message-ID: <Y+j8DtL3SE7rLDzJ@kernel.org>
References: <20230212095445.1311627-1-rppt@kernel.org>
 <Y+jScFT/qyXSPESp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+jScFT/qyXSPESp@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 11:50:08AM +0000, Matthew Wilcox wrote:
> On Sun, Feb 12, 2023 at 11:54:45AM +0200, Mike Rapoport wrote:
> > +Note, that memory banks may belong to interleaving nodes. In the example
> > +below an x86 machine has 16Gbytes or RAM in 4 memory banks, even banks
> > +belong to node 0 and odd banks belong to node 1::
> 
> s/or RAM/of RAM/

Thanks
 
> The "Note," is superfluous, you can just write:
> 
> Memory banks may belong to interleaved nodes.

Ok
 
> And I think we prefer the newer form "GiB" for new documentation.

I've used Gbytes in previous examples, so I'd prefer to keep it consistent
We can swipe s/Gbytes/GiB/g later.
 
> > +
> > +  0              4G              8G             12G            16G
> > +  +-------------+ +-------------+ +-------------+ +-------------+
> > +  |    node 0   | |    node 1   | |    node 0   | |    node 1   |
> > +  +-------------+ +-------------+ +-------------+ +-------------+
> > +
> > +  0   16M      4G
> > +  +-----+-------+ +-------------+ +-------------+ +-------------+
> > +  | DMA | DMA32 | |    NORMAL   | |    NORMAL   | |    NORMAL   |
> > +  +-----+-------+ +-------------+ +-------------+ +-------------+
> > +
> > +In such case node 0 will span from 0 to 12 Gbytes and node 1 will span from
> > +4 to 16 Gbytes.
> 
> s/such/this/ (and I'd use GiB again)

-- 
Sincerely yours,
Mike.
